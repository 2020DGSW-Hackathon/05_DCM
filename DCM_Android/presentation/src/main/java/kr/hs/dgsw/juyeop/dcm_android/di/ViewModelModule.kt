package kr.hs.dgsw.juyeop.dcm_android.di

import kr.hs.dgsw.juyeop.dcm_android.viewmodel.SignInViewModel
import kr.hs.dgsw.juyeop.dcm_android.viewmodel.SplashViewModel
import org.koin.androidx.viewmodel.dsl.viewModel
import org.koin.dsl.module

val viewModelModule = module {
    viewModel { SplashViewModel(get()) }
    viewModel { SignInViewModel(get()) }
}