Return-Path: <linux-kernel+bounces-806121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4091FB49224
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 16:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 675153AE4FD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 14:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BFF30C616;
	Mon,  8 Sep 2025 14:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Lcr3YCfH"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A72430ACF6
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 14:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757343323; cv=none; b=OUegRqXZ06zwk5VEpgS0kYNkprET9EGqvpZymsDG/IsNuOTGZsiKTOxAsXViNFJOsIlVJP/1wQgmplv4HSVbf4uFH26zGJt4oh2SBNJlvo9XMxj4aVMtVtQJZizFBA7czsGmqSIZXJhKL7dkeePta2TGPR3lK5B1nUQlq4ek81A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757343323; c=relaxed/simple;
	bh=Ee3FEGF3xAzaNWyedS6bEV11L5ZuNpo5FfZvcXJOKIQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FUofdX/984Lmti4ojDoxqojcCtuYh+ngQIyV8Zk6T7fk1UiT83oJPh74JOT9fhIm8mtHokvxaxWZ6LmwC8OvdjEF1lnEhZ+aKkrWYt2XUDhsA4SNCcxb9JszGQpEPgSZEJBwqGBWuKNKDW0Vct9oD/SSVQk5sBcQtxEmaWydDIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Lcr3YCfH; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-32c54c31ed9so2160154a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 07:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1757343321; x=1757948121; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VWM7u6gzgr9T/MqWNSjboANbXNdcmY+DYtZN3CoqJLg=;
        b=Lcr3YCfHMl5EkZS+rruz6v+hUVMCMyPaVB/queYrRL9XaQCy9BvDWGte0DVzqcaFoA
         ErLoSzYqDbyVsjZ9G1oFqtBDK2SEgnSa4CwRX+nxLbPqtZ+K5pr15sYILlg7HtqLaJfp
         dRrWktvPXROgir7GZ+PMnBhDke4GYUysWzzLZiSEf4lPw63r4SHJ8t8S88iD7UHu3vpx
         MRlK0miUHufy/WuJxNjakhSLVKjPjj97Kh473fWQF2iENv8bjEvLmfwc8+Ztv2v5pY/0
         CFaQ+tw3LMg03uaeGL0ZBbLE+d7ivTc+MtZCMyFrp4K0lVNwOIHjwCdSmkinvbx54Gxo
         tCJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757343321; x=1757948121;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VWM7u6gzgr9T/MqWNSjboANbXNdcmY+DYtZN3CoqJLg=;
        b=CESsSj1FZ69mBSq/Bh72d/T7+9iTBA51UFTi90dS1nhunyGNd0fYJzFvfc15bkKGB2
         QKreAgVDUE1pAJ4D4IUDpOQMQCk7L0oX+gc3PHt+ZJlvAZlDxC7KOfxzgIo0AW1LlB49
         iwL+PuOnq4dN6Pp1NRsvHw4RIV60ONEBIJbLCpDjEQMY65WHI1prvrr+sWvho2IC6vW8
         kGSq12xj0IkXXY0Y301hKbFnwmgPjk2/mLyo4X/swI7w+dOwb54w7zCWTfyZzv4m8nXC
         eDN0eezGN3TgwLqtKmqxC8wbmHvimCJxHk8io7OaBzPpqFJCcAfGZLCgXIq8oaC2xq+7
         fOtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwK6AdrNL5xownhAUoDpbQDCc7paHgS+D4f7RlBWBD1PNbVTOoScANbVICMr3ciOb4BXzt1MPat95EHlM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuG8i2MR3c9R7sB+ISx+1T315+1Yh2Gji4WChdqr8i/q0cp8+o
	VraIQ37Lf1tFNPmuIz89m7IvMV6lVtDxyJgLw2hWB8Ox+tBDfu3B937S6nxk+ShiP7E=
X-Gm-Gg: ASbGnct86XOfMysNja2FLpQsa8ObanFXMKVwcs5diw877R/rCnDgvlO1dajDxMHg5RC
	TIav2L7SPuDDEwIM8Lg7ps8vW1zCO9M8CEIWwUNtMfdJEqs46ji8ODEnma5+k1d/7k3iNAIz8Uj
	3GcA7K3CT/szigx1oFAxTo1PgcwgWB87IPj/BeoJojsl7xxFY1B7cPqgVmxZPz7mNUs22o8e4/1
	BD+nCUzbA/kVVS/Ui3twVhBMMFGalsUp6ti3w2ukwZfD8Q+JlqZrZxHPRNue1GLI7DTKwI/JVfk
	FNTPXIERiZ0ASAa05INZDU4E0Z8vTxQXlovjMQ1XP4Fy0mAtSNP8mPykZfvcxudn29O6MuC/F1c
	1L2EsSgZVGb4T2uo1qyKfO+3dWfFPTcQ2kYsPWm1t2su6eiZ0T9/2HKCdFejty5M=
X-Google-Smtp-Source: AGHT+IHQQxVqMdGburuSqybk1K9hiDqhGVVKjqoe0QgNVws6jTvHrNuDup3Nz5V5FroJtX3PJ2Ck5A==
X-Received: by 2002:a17:90b:530b:b0:31f:ca:63cd with SMTP id 98e67ed59e1d1-32d43ef0790mr9924165a91.2.1757343320170;
        Mon, 08 Sep 2025 07:55:20 -0700 (PDT)
Received: from [10.4.109.2] ([139.177.225.231])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32d7d4074b4sm3854864a91.4.2025.09.08.07.55.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 07:55:19 -0700 (PDT)
Message-ID: <c2979c40-0cf9-4238-9fb5-5cef6dd9f411@bytedance.com>
Date: Mon, 8 Sep 2025 22:55:07 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [External] Re: [PATCH] KVM: x86: Latch INITs only in specific CPU
 states in KVM_SET_VCPU_EVENTS
From: Fei Li <lifei.shirley@bytedance.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Sean Christopherson <seanjc@google.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, liran.alon@oracle.com, hpa@zytor.com,
 wanpeng.li@hotmail.com, kvm@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20250827152754.12481-1-lifei.shirley@bytedance.com>
 <aK8r11trXDjBnRON@google.com>
 <CABgObfYqVTK3uB00pAyZAdX=Vx1Xx_M0MOwUzm+D1C04mrVfig@mail.gmail.com>
 <f904b674-98ba-4e13-a64c-fd30b6ac4a2e@bytedance.com>
 <CABgObfb4ocYcaZixoPD_VZL5Z_SieTGJW3GBCFB-_LuOH5Ut2g@mail.gmail.com>
 <d686f056-180c-4a22-a359-81eadb062629@bytedance.com>
Content-Language: en-US
In-Reply-To: <d686f056-180c-4a22-a359-81eadb062629@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/5/25 10:59 PM, Fei Li wrote:
>
> On 8/29/25 12:44 AM, Paolo Bonzini wrote:
>> On Thu, Aug 28, 2025 at 5:13 PM Fei Li <lifei.shirley@bytedance.com> 
>> wrote:
>>> Actually this is a bug triggered by one monitor tool in our production
>>> environment. This monitor executes 'info registers -a' hmp at a fixed
>>> frequency, even during VM startup process, which makes some AP stay in
>>> KVM_MP_STATE_UNINITIALIZED forever. But this race only occurs with
>>> extremely low probability, about 1~2 VM hangs per week.
>>>
>>> Considering other emulators, like cloud-hypervisor and firecracker 
>>> maybe
>>> also have similar potential race issues, I think KVM had better do some
>>> handling. But anyway, I will check Qemu code to avoid such race. Thanks
>>> for both of your comments. 🙂
>> If you can check whether other emulators invoke KVM_SET_VCPU_EVENTS in
>> similar cases, that of course would help understanding the situation
>> better.
>>
>> In QEMU, it is possible to delay KVM_GET_VCPU_EVENTS until after all
>> vCPUs have halted.
>>
>> Paolo
>>
> Hi Paolo and Sean,
>
>
> Sorry for the late response, I have been a little busy with other 
> things recently. The complete calling processes for the bad case are 
> as follows:
>
> `info registers -a` hmp per 2ms[1]      AP(vcpu1) thread[2]           
> BSP(vcpu0) send INIT/SIPI[3]
>
>                                  [2]
>                                  KVM: KVM_RUN and then
>                           schedule() in kvm_vcpu_block() loop
>
> [1]
> for each cpu: cpu_synchronize_state
> if !qemu_thread_is_self()
> 1. insert to cpu->work_list, and handle asynchronously
> 2. then kick the AP(vcpu1) by sending SIG_IPI/SIGUSR1 signal
>
>                       [2]
>                       KVM: checks signal_pending, breaks loop and 
> returns -EINTR
> Qemu: break kvm_cpu_exec loop, run
>   1. qemu_wait_io_event()
>   => process_queued_cpu_work => cpu->work_list.func()
>        e.i. do_kvm_cpu_synchronize_state() callback
>        => kvm_arch_get_registers
>             => kvm_get_mp_state /* KVM: get_mpstate also calls
>            kvm_apic_accept_events() to handle INIT and SIPI */
>        => cpu->vcpu_dirty = true;
>   // end of qemu_wait_io_event
>
>                                   [3]
>                                   SeaBIOS: BSP enters non-root mode 
> and runs reset_vector() in SeaBIOS.
>                                            send INIT and then SIPI by 
> writing APIC_ICR during smp_scan
>                                   KVM: BSP(vcpu0) exits, then => 
> handle_apic_write
>                                        => kvm_lapic_reg_write => 
> kvm_apic_send_ipi to all APs
>                                        => for each AP: 
> __apic_accept_irq, e.g. for AP(vcpu1)
>                                             => case APIC_DM_INIT: 
> apic->pending_events = (1UL << KVM_APIC_INIT)
>                                                  (not kick the AP yet)
>                                             => case APIC_DM_STARTUP: 
> set_bit(KVM_APIC_SIPI, &apic->pending_events)
>                                                  (not kick the AP yet)
>
>   [2]
>   2. kvm_cpu_exec()
>   => if (cpu->vcpu_dirty):
>      => kvm_arch_put_registers
>         => kvm_put_vcpu_events
>                       KVM: kvm_vcpu_ioctl_x86_set_vcpu_events
>  => clear_bit(KVM_APIC_INIT, &vcpu->arch.apic->pending_events);
>       e.i. pending_events changes from 11b to 10b
>  // end of kvm_vcpu_ioctl_x86_set_vcpu_events
> Qemu: => after put_registers, cpu->vcpu_dirty = false;
>         => kvm_vcpu_ioctl(cpu, KVM_RUN, 0)
>                       KVM: KVM_RUN
>  => schedule() in kvm_vcpu_block() until Qemu's next SIG_IPI/SIGUSR1 
> signal
>  /* But AP(vcpu1)'s mp_state will never change from 
> KVM_MP_STATE_UNINITIALIZED
>    to KVM_MP_STATE_INIT_RECEIVED, even then to KVM_MP_STATE_RUNNABLE
> without handling INIT inside kvm_apic_accept_events(), considering BSP 
> will never
>    send INIT/SIPI again during smp_scan. Then AP(vcpu1) will never enter
>    non-root mode */
>
>                                   [3]
>                                   SeaBIOS: waits CountCPUs == 
> expected_cpus_count and loops forever
>                                   e.i. the AP(vcpu1) stays: 
> EIP=0000fff0 && CS =f000 ffff0000
>                                         and BSP(vcpu0) appears 100% 
> utilized as it is in a while loop.
>
> As for other emulators (like cloud-hypervisor and firecracker), there 
> is no interactive command like 'info registers -a'.
> But sorry again that I haven't had time to check code to confirm 
> whether they invoke KVM_SET_VCPU_EVENTS in similar cases, maybe later. :)
>
>
> Have a nice day, thanks
> Fei
>

By the way, this doesn't seem to be a Qemu bug, since calling "info 
registers -a" is allowed regardless of the vcpu state (including when 
the VM is in the bootloader). Thus the INIT should not be latched in 
this case. To fix this, I think we need add the 
kvm_apic_init_sipi_allowed() condition: only latch INITs in specific CPU 
states. Or change mp_state to KVM_MP_STATE_INIT_RECEIVED and then clear 
INIT here. Should I send a v2 patch with a clearer commit message?
Have a nice day, thanks
Fei

