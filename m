Return-Path: <linux-kernel+bounces-734670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E51AB084A1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 08:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C53774A192D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 06:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0FC20468E;
	Thu, 17 Jul 2025 06:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="BVz9XR6G"
Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3659D1FCD1F
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 06:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752732672; cv=none; b=awJBKn6t8+aPrsWXP1SbKk+FVTxcPPmZYW31DJttXU6fdRDa7j8tJQsOX5qnI61+HsPUPQJSJyHDg26GxEGVHEy0eQksPT5zmZWyt9z51QGLL9ncT9c8JnQBSsfWy790xBCDm18ZIHSZPNk81WcFDMxCUxmpi3jbF9++U4puQI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752732672; c=relaxed/simple;
	bh=r/ELqY9p9UrCGq6No1E+wq/GOusuftqIaLK1wJc+CGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RtT6fTSZlWq58XFKwS95eykxK/UN6WvL+p+7iaKbQlGpJBKvP0BtsbypheXk1e6erJLBca96MmrrOdVgblWXlE/kAPVxn2Jn3S26YcJsaEs2h0Ww5Y3CeUK3wTbnA7zBufJ16s0YbYbHiMXEsAgqRnKKBoY892uYsfzjahQjh0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=BVz9XR6G; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-8731c3473c3so19049139f.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 23:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1752732670; x=1753337470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZFXDSElKOOqp2lhmXXGsXGr9VDCoQ/FfrBr7vY0pwQs=;
        b=BVz9XR6GVUjZQhiGSk3iw/1L80E3WcyEf91W+lPBVE3gpMIUP9OzNMAxdPNCTFhYIt
         hKIO2mwmyP97lQLWuqCbHy1jeXLn+zXEUVmhXJ7ZkBPnhgLUYK5ksiKgTDe2PjzXFrPq
         5N99sAn663QkZtJumhdyqrMOZjeQPdwK86oyJ/QGKMMJKvpdlkclMXyJ3M6p5X8buSrS
         zPgOCfUm3Kotcqoz2ojdH23D/ja67b/gFIJrNN6S8eJpGb6dYIS28GdbRWKxHVS1NkR8
         8fcM/EfczS9MQ65WWtaVVDiUa4blR8bLApSWVCUwgeP7+zb8HrFVwVjzIS1XhLDYD3yP
         XdRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752732670; x=1753337470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZFXDSElKOOqp2lhmXXGsXGr9VDCoQ/FfrBr7vY0pwQs=;
        b=T7HSMdmTpFPb7byluZpVi9KKPLfkni8B3qS7liUz5EQvISq+VyuiFY3YUMUb7Z0PMY
         GjXDvI3LRjXl5r3R9VYucjn11J8NhDKaNgC+iGdZalK3MaE1vIzyq2iRDbsZrWlclzXz
         RuC7QSNPqj006x3C6sEpBWKM8yE1N25LN0zbGAxyQZ7ScuTpqy2aJ4oRQbAUUlTyE/x3
         qCbcns9gQI2FPA99HbbISFqI5tfrUSPqfgjWA/iT9c+DO5nffUn2dVmwWsuAlRh6x+gZ
         tFrPlE9SeOGjiDRXkS3+8K2nqJbwJf5LvCUuxwZutxXg3hFJvUeyjnDo6nfW+wWziCXI
         9HFw==
X-Forwarded-Encrypted: i=1; AJvYcCWzVK254UQpJ/qnXF4d+44edzr6XjbV/wTAFYZFs/wKBsBOabW95gSrydIQaO+S1Q57KC8E7jPeFn77y7k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yykd2KmQC7UnZAxf5OmQU6poIC8YrHQlc5XB2XV2ECuPk8DYZpn
	Jz4GBuojMM4lKSBAEhnOZXiYDU4CTqAPtMe7wR46hgdkZMYcAdaiEcvi1amHAPxbd1dMFuTfuRd
	al5nqT/vUtTHGbHmukfJqZz77sR3M9fx05+TelMuSuM6XvHr58UTD
X-Gm-Gg: ASbGncuVhUSomljKzuTyaVr0vRlZPZCR5NCV1N/yxl5beGLZWvyhtBYsllTsz7E/xtW
	CGX/FZC5+CL3JzBVCf/FaE3SHvuNRtxeEwGCKr/wC+Vw0OuqKU84qoba/v6F6H0O85y5Bccarzv
	6do6+D1PGdUgaBytBLrmKYfWgPMfD4ekatK48ymEYRLankooZ96CRs2vylUVyKqP9gPQOVW0tYn
	8fPpQ==
X-Google-Smtp-Source: AGHT+IF01QfJyQMefqtK6K31hKuroqHVJNbfRoBUWtdmJCmhcOeVgxFHACALHAoTtmmMAVZj3g7jLJEfDcjT3Imbm5Y=
X-Received: by 2002:a05:6602:164a:b0:879:c4a1:1020 with SMTP id
 ca18e2360f4ac-879c4a1138amr581946839f.9.1752732670109; Wed, 16 Jul 2025
 23:11:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1749810735.git.zhouquan@iscas.ac.cn> <20e116efb1f7aff211dd8e3cf8990c5521ed5f34.1749810735.git.zhouquan@iscas.ac.cn>
In-Reply-To: <20e116efb1f7aff211dd8e3cf8990c5521ed5f34.1749810735.git.zhouquan@iscas.ac.cn>
From: Anup Patel <anup@brainfault.org>
Date: Thu, 17 Jul 2025 11:40:58 +0530
X-Gm-Features: Ac12FXzV5Y-LW3CLzhO1n-a_ZnyRISIIMhwEfUeHXAPilMPIemTKisuILYRl6qQ
Message-ID: <CAAhSdy3yjCXHucCzQzXg2BUJM7aYrb2Fd0taJQw=AEnvfnsNAA@mail.gmail.com>
Subject: Re: [PATCH 1/2] RISC-V: KVM: Enable ring-based dirty memory tracking
To: zhouquan@iscas.ac.cn
Cc: ajones@ventanamicro.com, atishp@atishpatra.org, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, kvm@vger.kernel.org, 
	kvm-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 13, 2025 at 5:08=E2=80=AFPM <zhouquan@iscas.ac.cn> wrote:
>
> From: Quan Zhou <zhouquan@iscas.ac.cn>
>
> Enable ring-based dirty memory tracking on riscv:
>
> - Enable CONFIG_HAVE_KVM_DIRTY_RING_ACQ_REL as riscv is weakly
>   ordered.
> - Set KVM_DIRTY_LOG_PAGE_OFFSET for the ring buffer's physical page
>   offset.
> - Add a check to kvm_vcpu_kvm_riscv_check_vcpu_requests for checking
>   whether the dirty ring is soft full.
>
> To handle vCPU requests that cause exits to userspace, modified the
> `kvm_riscv_check_vcpu_requests` to return a value (currently only
> returns 0 or 1).
>
> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>

LGTM.

Reviewed-by: Anup Patel <anup@brainfault.org>

Queued this patch for Linux-6.17

Thanks,
Anup

> ---
>  Documentation/virt/kvm/api.rst    |  2 +-
>  arch/riscv/include/uapi/asm/kvm.h |  1 +
>  arch/riscv/kvm/Kconfig            |  1 +
>  arch/riscv/kvm/vcpu.c             | 18 ++++++++++++++++--
>  4 files changed, 19 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.=
rst
> index 1bd2d42e6424..5de0fbfe2fc0 100644
> --- a/Documentation/virt/kvm/api.rst
> +++ b/Documentation/virt/kvm/api.rst
> @@ -8316,7 +8316,7 @@ core crystal clock frequency, if a non-zero CPUID 0=
x15 is exposed to the guest.
>  7.36 KVM_CAP_DIRTY_LOG_RING/KVM_CAP_DIRTY_LOG_RING_ACQ_REL
>  ----------------------------------------------------------
>
> -:Architectures: x86, arm64
> +:Architectures: x86, arm64, riscv
>  :Type: vm
>  :Parameters: args[0] - size of the dirty log ring
>
> diff --git a/arch/riscv/include/uapi/asm/kvm.h b/arch/riscv/include/uapi/=
asm/kvm.h
> index 5f59fd226cc5..ef27d4289da1 100644
> --- a/arch/riscv/include/uapi/asm/kvm.h
> +++ b/arch/riscv/include/uapi/asm/kvm.h
> @@ -18,6 +18,7 @@
>  #define __KVM_HAVE_IRQ_LINE
>
>  #define KVM_COALESCED_MMIO_PAGE_OFFSET 1
> +#define KVM_DIRTY_LOG_PAGE_OFFSET 64
>
>  #define KVM_INTERRUPT_SET      -1U
>  #define KVM_INTERRUPT_UNSET    -2U
> diff --git a/arch/riscv/kvm/Kconfig b/arch/riscv/kvm/Kconfig
> index 704c2899197e..5a62091b0809 100644
> --- a/arch/riscv/kvm/Kconfig
> +++ b/arch/riscv/kvm/Kconfig
> @@ -25,6 +25,7 @@ config KVM
>         select HAVE_KVM_MSI
>         select HAVE_KVM_VCPU_ASYNC_IOCTL
>         select HAVE_KVM_READONLY_MEM
> +       select HAVE_KVM_DIRTY_RING_ACQ_REL
>         select KVM_COMMON
>         select KVM_GENERIC_DIRTYLOG_READ_PROTECT
>         select KVM_GENERIC_HARDWARE_ENABLING
> diff --git a/arch/riscv/kvm/vcpu.c b/arch/riscv/kvm/vcpu.c
> index e0a01af426ff..0502125efb30 100644
> --- a/arch/riscv/kvm/vcpu.c
> +++ b/arch/riscv/kvm/vcpu.c
> @@ -690,7 +690,14 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
>         }
>  }
>
> -static void kvm_riscv_check_vcpu_requests(struct kvm_vcpu *vcpu)
> +/**
> + * check_vcpu_requests - check and handle pending vCPU requests
> + * @vcpu:      the VCPU pointer
> + *
> + * Return: 1 if we should enter the guest
> + *         0 if we should exit to userspace
> + */
> +static int kvm_riscv_check_vcpu_requests(struct kvm_vcpu *vcpu)
>  {
>         struct rcuwait *wait =3D kvm_arch_vcpu_get_wait(vcpu);
>
> @@ -735,7 +742,12 @@ static void kvm_riscv_check_vcpu_requests(struct kvm=
_vcpu *vcpu)
>
>                 if (kvm_check_request(KVM_REQ_STEAL_UPDATE, vcpu))
>                         kvm_riscv_vcpu_record_steal_time(vcpu);
> +
> +               if (kvm_dirty_ring_check_request(vcpu))
> +                       return 0;
>         }
> +
> +       return 1;
>  }
>
>  static void kvm_riscv_update_hvip(struct kvm_vcpu *vcpu)
> @@ -917,7 +929,9 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>
>                 kvm_riscv_gstage_vmid_update(vcpu);
>
> -               kvm_riscv_check_vcpu_requests(vcpu);
> +               ret =3D kvm_riscv_check_vcpu_requests(vcpu);
> +               if (ret <=3D 0)
> +                       continue;
>
>                 preempt_disable();
>
> --
> 2.34.1
>

