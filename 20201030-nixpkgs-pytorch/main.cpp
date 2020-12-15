#include <torch/torch.h>
#include <iostream>

int main() {

    torch::DeviceType device_type;
    if (torch::cuda::is_available()) {
        std::cout << "CUDA available! Training on GPU." << std::endl;
        device_type = torch::kCUDA;
    } else {
        std::cout << "Training on CPU." << std::endl;
        device_type = torch::kCPU;
    }
    torch::Device device(device_type);

    torch::Tensor tensor = torch::eye(3, device);
    std::cout << tensor << std::endl;

    return 0;
}

