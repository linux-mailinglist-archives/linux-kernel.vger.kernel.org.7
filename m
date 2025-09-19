Return-Path: <linux-kernel+bounces-824588-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9291B899FA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17B817A3323
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 13:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00E5D23C8C5;
	Fri, 19 Sep 2025 13:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="PKFnfDqZ"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380D52AD16
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 13:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758287694; cv=none; b=t4K1jNT3Nw/MajZhxBzbwIZ1HJJTM8FvpmfpQZ0kOy7r6uLfK0cFfHXkXKQnafgw2OScscHEG+yZybGeTSjLCi5kbNecJor7FrVwRblss1wdiJxB6oswVc8jM+OhJrsPr5tbjgZ40mo88jqr7yH14bxkqzLTgWIcG5h5UpeHgA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758287694; c=relaxed/simple;
	bh=9uNRaKLm/UkEWXz6L6vPG9AM0/2z8XI4VFYyvvZye5g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iuuYbw7slNQeBF90zFOPSkPz8RYZ1k8DDLGDt+XV2NR2c51rCtZfchJM0a/8D4d0IjRjeTY+p3ZRlucv11z2vmEqkIRJX85ngdo5SVSGSrLvenufZurswvwXcdFOavh4obo4Ivv86mGqOYDN03pknmOhOFswVyFQ+9lQVd0IxUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b=PKFnfDqZ; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b548745253so34004741cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 06:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google; t=1758287691; x=1758892491; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4TO8ldCpCwaQtoLKPhvsFlsBIhB9gZdGySwv7zH4ykU=;
        b=PKFnfDqZ2XWhcDzyes2A/wyUHVilZHsLqlmlIGtFavXL5r+pHj+TuLLbnVqdq+cgNJ
         a4SvkmK8xKrr+5unP34aF31+YtwVQiUya2JU2lEmJup5PXJ7RXggQDTo3MBlMaldC6VW
         DKOmYGKgECPKA0kWuSQy8rye7tEU+I2PtEXj+K+/P/9amgoBSWyBklKg24rP3sON33NM
         fgCl84fGTMUS3/QfeSyf2uJA7AwmtamtxNJHRv4IGS7cc9UHxCjleIzNiaSeuQQ/kiwu
         sQjF+l3bkfc7dCVolUf3et+7ZYPc0p3YgiGcsQPoskwqCieTtBwS7c2VoZ9k/aIspZv+
         F8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758287691; x=1758892491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4TO8ldCpCwaQtoLKPhvsFlsBIhB9gZdGySwv7zH4ykU=;
        b=XQuVf0oUQT0JPzc5K2SMTP1BMO30nS60D494xgxFP81UDzUTA6rg87AM/toZFpR8sN
         MiNWG27PaJq6bLD0nBqLlzoz5TUHDNFVDOAgDz8RAYx5okMj+qcBBcB+iL8Lgs+qkt9X
         MHErGGBfyrr+fuuPVcNl+1SMtUmtOln+IgPy9Yy9Q4tcwrCuu9vb4bKia4/cxbWHzPXP
         EEJoZvlCj5JGWRyp8YpZhzru7ZnmikVBNTu4UDsNhJvunyRdA9H3RLE8mSLsy+kwjL2W
         saXBe13hkOuKHjFB8yxFN2TvCV0kNFn74VQcwlfTrZNLjW/pgD595aKXvj4BS7owXOOt
         22Bw==
X-Gm-Message-State: AOJu0Yz3HG1M8RygloD5Jn5W7MzWrTlxFN56/jR1NIidmeyzmdiQbUm5
	9dDqZg/4o3L1Vl9Xk6QgGM3D8PrPEWSLhTn3Qa8JioMCi3Fn7Rx91zwaSsy4X0mVOTpPBeXRCoR
	XVWXSuZKbg2X+IjSNvr0uzbhAzTFPjlY4TswHyBI3YA==
X-Gm-Gg: ASbGncuX/agdVzuMVWviyHdeKLQeLDoJMea8GvMsUuH8yAP17EqrLonYF0U0vhjiRIT
	dszgla3JqwoicuoUQLwshWuSH7lad/K6wOAdxppN9ILMFEAs3VufcfwDNqno4DomsbMGm7Hj+KN
	2+XkyIJ9qtbD/jY2QVDIrf8AC54PNj4NpqlOFfhRwWUUatEZ++4HhgIKs1AqUKDHS/kAj2dD8Kj
	/Q5
X-Google-Smtp-Source: AGHT+IFP5OPPTxwZ8V54f9/k+r549Cc9+2zxQm2wZ1tAr4n+kgl+fwpljr133j453kMoly6d472Qfg2qfJWHUKMsWzY=
X-Received: by 2002:a05:622a:1a02:b0:4b5:da5f:d9b7 with SMTP id
 d75a77b69052e-4c073ab0dd8mr34737991cf.78.1758287690916; Fri, 19 Sep 2025
 06:14:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
In-Reply-To: <20250918222607.186488-1-xiyou.wangcong@gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Fri, 19 Sep 2025 09:14:12 -0400
X-Gm-Features: AS18NWCzyLEt0N2rB1CWsx_n5vr6VC5G7l3ExS6vuWkIq3v8_7YkqfncY9X_FkM
Message-ID: <CA+CK2bD3D_XFu1E60qBYwdDzK0c7_bN0BkGBE7h6h_sxmmfvAQ@mail.gmail.com>
Subject: Re: [RFC Patch 0/7] kernel: Introduce multikernel architecture support
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: linux-kernel@vger.kernel.org, Cong Wang <cwang@multikernel.io>, 
	Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>, 
	Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, Changyuan Lyu <changyuanl@google.com>, 
	kexec@lists.infradead.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 18, 2025 at 6:26=E2=80=AFPM Cong Wang <xiyou.wangcong@gmail.com=
> wrote:
>
> This patch series introduces multikernel architecture support, enabling
> multiple independent kernel instances to coexist and communicate on a
> single physical machine. Each kernel instance can run on dedicated CPU
> cores while sharing the underlying hardware resources.
>
> The multikernel architecture provides several key benefits:
> - Improved fault isolation between different workloads
> - Enhanced security through kernel-level separation
> - Better resource utilization than traditional VM (KVM, Xen etc.)
> - Potential zero-down kernel update with KHO (Kernel Hand Over)

Hi Cong,

Thank you for submitting this; it is an exciting series.

I experimented with this approach about five years ago for a Live
Update scenario. It required surprisingly little work to get two OSes
to boot simultaneously on the same x86 hardware. The procedure I
followed looked like this:

1. Create an immutable kernel image bundle: kernel + initramfs.
2. The first kernel is booted with memmap parameters, setting aside
the first 1G for its own operation, the second 1G for the next kernel
(reserved), and the rest as PMEM for the VMs.
3. In the first kernel, we offline one CPU and kexec the second kernel
with parameters that specify to use only the offlined CPU as the boot
CPU and to keep the other CPUs offline (i.e., smp_init does not start
other CPUs). The memmap specify the first 1G reserved, and the 2nd 1G
for its own operations, and the rest  is PMEM.
4. Passing the VMs worked by suspending them in the old kernel.
5. The other CPUs are onlined in the new kernel (thus killing the old kerne=
l).
6. The VMs are resumed in the new kernel.

While this approach was easy to get to the experimental PoC, it has
some fundamental problems that I am not sure can be solved in the long
run, such as handling global machine states like interrupts. I think
the Orphaned VM approach (i.e., keeping VCPUs running through the Live
Update procedure) is more reliable and likely to succeed for
zero-downtime kernel updates.

Pasha

>
> Architecture Overview:
> The implementation leverages kexec infrastructure to load and manage
> multiple kernel images, with each kernel instance assigned to specific
> CPU cores. Inter-kernel communication is facilitated through a dedicated
> IPI framework that allows kernels to coordinate and share information
> when necessary.
>
> Key Components:
> 1. Enhanced kexec subsystem with dynamic kimage tracking
> 2. Generic IPI communication framework for inter-kernel messaging
> 3. Architecture-specific CPU bootstrap mechanisms (only x86 so far)
> 4. Proc interface for monitoring loaded kernel instances
>
> Patch Summary:
>
> Patch 1/7: Introduces basic multikernel support via kexec, allowing
>            multiple kernel images to be loaded simultaneously.
>
> Patch 2/7: Adds x86-specific SMP INIT trampoline for bootstrapping
>            CPUs with different kernel instances.
>
> Patch 3/7: Introduces dedicated MULTIKERNEL_VECTOR for x86 inter-kernel
>            communication.
>
> Patch 4/7: Implements generic multikernel IPI communication framework
>            for cross-kernel messaging and coordination.
>
> Patch 5/7: Adds arch_cpu_physical_id() function to obtain physical CPU
>            identifiers for proper CPU management.
>
> Patch 6/7: Replaces static kimage globals with dynamic linked list
>            infrastructure to support multiple kernel images.
>
> Patch 7/7: Adds /proc/multikernel interface for monitoring and debugging
>            loaded kernel instances.
>
> The implementation maintains full backward compatibility with existing
> kexec functionality while adding the new multikernel capabilities.
>
> IMPORTANT NOTES:
>
> 1) This is a Request for Comments (RFC) submission. While the core
>    architecture is functional, there are numerous implementation details
>    that need improvement. The primary goal is to gather feedback on the
>    high-level design and overall approach rather than focus on specific
>    coding details at this stage.
>
> 2) This patch series represents only the foundational framework for
>    multikernel support. It establishes the basic infrastructure and
>    communication mechanisms. We welcome the community to build upon
>    this foundation and develop their own solutions based on this
>    framework.
>
> 3) Testing has been limited to the author's development machine using
>    hard-coded boot parameters and specific hardware configurations.
>    Community testing across different hardware platforms, configurations,
>    and use cases would be greatly appreciated to identify potential
>    issues and improve robustness. Obviously, don't use this code beyond
>    testing.
>
> This work enables new use cases such as running real-time kernels
> alongside general-purpose kernels, isolating security-critical
> applications, and providing dedicated kernel instances for specific
> workloads etc..
>
> Signed-off-by: Cong Wang <cwang@multikernel.io>
>
> ---
>
> Cong Wang (7):
>   kexec: Introduce multikernel support via kexec
>   x86: Introduce SMP INIT trampoline for multikernel CPU bootstrap
>   x86: Introduce MULTIKERNEL_VECTOR for inter-kernel communication
>   kernel: Introduce generic multikernel IPI communication framework
>   x86: Introduce arch_cpu_physical_id() to obtain physical CPU ID
>   kexec: Implement dynamic kimage tracking
>   kexec: Add /proc/multikernel interface for kimage tracking
>
>  arch/powerpc/kexec/crash.c          |   8 +-
>  arch/x86/include/asm/idtentry.h     |   1 +
>  arch/x86/include/asm/irq_vectors.h  |   1 +
>  arch/x86/include/asm/smp.h          |   7 +
>  arch/x86/kernel/Makefile            |   1 +
>  arch/x86/kernel/crash.c             |   4 +-
>  arch/x86/kernel/head64.c            |   5 +
>  arch/x86/kernel/idt.c               |   1 +
>  arch/x86/kernel/setup.c             |   3 +
>  arch/x86/kernel/smp.c               |  15 ++
>  arch/x86/kernel/smpboot.c           | 161 +++++++++++++
>  arch/x86/kernel/trampoline_64_bsp.S | 288 ++++++++++++++++++++++
>  arch/x86/kernel/vmlinux.lds.S       |   6 +
>  include/linux/kexec.h               |  22 +-
>  include/linux/multikernel.h         |  81 +++++++
>  include/uapi/linux/kexec.h          |   1 +
>  include/uapi/linux/reboot.h         |   2 +-
>  init/main.c                         |   2 +
>  kernel/Makefile                     |   2 +-
>  kernel/kexec.c                      | 103 +++++++-
>  kernel/kexec_core.c                 | 359 ++++++++++++++++++++++++++++
>  kernel/kexec_file.c                 |  33 ++-
>  kernel/multikernel.c                | 314 ++++++++++++++++++++++++
>  kernel/reboot.c                     |  10 +
>  24 files changed, 1411 insertions(+), 19 deletions(-)
>  create mode 100644 arch/x86/kernel/trampoline_64_bsp.S
>  create mode 100644 include/linux/multikernel.h
>  create mode 100644 kernel/multikernel.c
>
> --
> 2.34.1
>

