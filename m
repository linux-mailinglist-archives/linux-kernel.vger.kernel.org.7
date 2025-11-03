Return-Path: <linux-kernel+bounces-883292-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE751C2CFA6
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 17:07:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC2AD1892B79
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 15:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A07D3148D2;
	Mon,  3 Nov 2025 15:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NBClukD8"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16643305E0D
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 15:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762185515; cv=none; b=aLL4t8iEYd87gsdwBmxvDO8PYLNXklMnj1IPrnhzrsK534rnLtcxZUSABx1rlP7QvyVtFvl0AUUFNPxXyuv6PqM/ZYbGiUDZbrR/2YhGBbLLZGOUmHG9jUjFXp3828VuK1R8tc4le98ES2JiiJu8mvZ4Rp7XyPWfP0pDtdePZAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762185515; c=relaxed/simple;
	bh=TLH9Wb/W5wsa/x9Zxdb1kFd6dg1J4R7XlzSLC5ag0vU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SfkCOn+pN9kJ2Qzs3tpNrOm5BpGYTSYD+CuAy9pcg8WxqovaMjDbSAsa3GH0Y4KjAqfSs3uqUrlLyMj3dGv/JKuKLm4SXO+WlMHUok7Q+iqYBY6DNgBIr2B8phqlLdWTjvd32DjHh3QtgNm6sz6l4rocbpfr0pahV+0FArKa0kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NBClukD8; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4ed0c8e4dbcso685161cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 07:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1762185512; x=1762790312; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GWdzlPD3UwA71O3gfXQEbZQnV3zfJBjftMr9CfhW/fg=;
        b=NBClukD8MjPXTBQKspRX3E5TrzCm0cApPcNIf5LA/yeHbsWsyBmOLCBJRJhxXgA3uh
         CV+GqC2pOb4Gvc87RApheKoIzpW4WF6aw3D62WbeVuIfFMseRQ1VXDq5xP2ftRigeCKX
         UJcYWAysmDipeH27p0L4TdsfBhLMENVpBWoFsClAwUXJ6vBfyA5ujMfNyncoMZFTb0st
         QSCl0df+9L2H8iYWt4EVeQt1pD7z+X355R/Komh7he70IahIptVV/m3l0WdeDRQZgmfN
         Hx3CQKGtirPya8nE/jio4SSDVb5MKaf/kvmXwjs9zxMsr6JB5f5+MCc/BsQsrALFLufD
         clUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762185512; x=1762790312;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GWdzlPD3UwA71O3gfXQEbZQnV3zfJBjftMr9CfhW/fg=;
        b=fjjshGJTrpuKpi0qAoxRvOpOnS9n5ddXTgqpwdEadMH/ak6yu5sjODHWyv23ZRqEBJ
         cBNqTm+dy0XwAbEMNjoBsdLG5uaSGyeAv+oElZHMrho6krN7R2QTUkcv0nAVRvcQiH+n
         oJM7d6fOwfScK2UPU42Id2fpb7RIH0M2Gxdb4cQ3BE6mjpSVDve7zJGVxaMDW3WyqMDx
         6g3RW6+3lKT/4rUQ5hsYR+QS8lnSRBzFxb/BmFCETb5SBRBCkXyGl4S3Vzapxt7KjJGU
         duVcQDJUMD/23JW6tXm+6ls5nROWV16I7Suvy3VzpW+mfbMZ+hoNW9NP8S40o1LaA8Tm
         R0dw==
X-Gm-Message-State: AOJu0YyHP3nbesfHsaR7kFl4xpNdx7zWbP6flzu05o2omPCK4xm3rsFl
	PO8P9BcDZr+PATGwHojPN3q0iE3RclkOjjXBhq3fqfQCJBIRpTJDr/MVMKEjGSaZFlhLfazH8QJ
	iWeT8vVAqBsddwL2J89QyJ2siFGSjoD85tQllM0RR
X-Gm-Gg: ASbGnctjdcjWh/YA4Rq2BERDuVJdFS/hFMKcTaU7ckozD5BfSN7PpFhfcMdGps83lDz
	Rm/MhR9DCKET4jAVlljIyP0RErQRgLPU12zFPzT4gLnT2Ij9skMyTTRXmR9rJo7eV5+dd1fVmJi
	bD0VuEl9+TbMpBBTCv50Ix/viupc9J+6gAgIz1HGuRekwA4VFiyYSh2MWCuFgoXtS+EriBdvdDF
	JKSYN0I3Mn9RwPNNV09+2PCjRfKzWikxGRWGm3ZFf+2w1jB+X9R3sOCUaThzAt0/XiHofgg
X-Google-Smtp-Source: AGHT+IGe2T2wKlR6rpVRDnkoMGDTb3vI0cZTlvpBJ4r3K1c5Czj0MEShg0Pl77dSoyon9NCq8B2b01vuCWIOxJC3wTA=
X-Received: by 2002:ac8:5d4e:0:b0:4e4:6a1b:1148 with SMTP id
 d75a77b69052e-4ed5fd71353mr150521cf.6.1762185511623; Mon, 03 Nov 2025
 07:58:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aQi-8IuAQ8CIPZuL@x1>
In-Reply-To: <aQi-8IuAQ8CIPZuL@x1>
From: Fuad Tabba <tabba@google.com>
Date: Mon, 3 Nov 2025 15:57:55 +0000
X-Gm-Features: AWmQ_bm94wop0WnkChwn-LbykkGUPLt-S6EzZf2EJA1VPSoIdIEPKrZoy5rLpSk
Message-ID: <CA+EHjTwXWHUoH=-0z00gfWtSGKDymcBGgLdUyM0r0v65VR+86g@mail.gmail.com>
Subject: Re: [PATCH 1/1] tools headers UAPI: Sync linux/kvm.h with the kernel sources
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, Sean Christopherson <seanjc@google.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Ian Rogers <irogers@google.com>, James Clark <james.clark@linaro.org>, 
	Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

On Mon, 3 Nov 2025 at 14:40, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> tldr; Just FYI, I'm carrying this on the perf tools tree.
>
> Full explanation:
>
> There used to be no copies, with tools/ code using kernel headers
> directly. From time to time tools/perf/ broke due to legitimate kernel
> hacking. At some point Linus complained about such direct usage. Then we
> adopted the current model.
>
> See further details at:
>
>  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/include/uapi/README
>
> To pick the changes in:
>
>   fe2bf6234e947bf5 ("KVM: guest_memfd: Add INIT_SHARED flag, reject user page faults if not set")
>   d2042d8f96ddefde ("KVM: Rework KVM_CAP_GUEST_MEMFD_MMAP into KVM_CAP_GUEST_MEMFD_FLAGS")
>   3d3a04fad25a6621 ("KVM: Allow and advertise support for host mmap() on guest_memfd files")
>
> That just rebuilds perf, as these patches don't add any new KVM ioctl to
> be harvested for the the 'perf trace' ioctl syscall argument
> beautifiers.

nit: "the" is repeated. I've noticed this in earlier commits of yours
to this file as well :)

> This addresses this perf build warning:
>
>   Warning: Kernel ABI header differences:
>     diff -u tools/include/uapi/linux/kvm.h include/uapi/linux/kvm.h
>
>   Please see tools/include/uapi/README for further details.
>
> Cc: Sean Christopherson <seanjc@google.com>
> Cc: Fuad Tabba <tabba@google.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> ---

Reviewed-by: Fuad Tabba <tabba@google.com>

Cheers,
/fuad

>  tools/include/uapi/linux/kvm.h | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
> index f0f0d49d25443552..52f6000ab020840e 100644
> --- a/tools/include/uapi/linux/kvm.h
> +++ b/tools/include/uapi/linux/kvm.h
> @@ -962,6 +962,7 @@ struct kvm_enable_cap {
>  #define KVM_CAP_ARM_EL2_E2H0 241
>  #define KVM_CAP_RISCV_MP_STATE_RESET 242
>  #define KVM_CAP_ARM_CACHEABLE_PFNMAP_SUPPORTED 243
> +#define KVM_CAP_GUEST_MEMFD_FLAGS 244
>
>  struct kvm_irq_routing_irqchip {
>         __u32 irqchip;
> @@ -1598,6 +1599,8 @@ struct kvm_memory_attributes {
>  #define KVM_MEMORY_ATTRIBUTE_PRIVATE           (1ULL << 3)
>
>  #define KVM_CREATE_GUEST_MEMFD _IOWR(KVMIO,  0xd4, struct kvm_create_guest_memfd)
> +#define GUEST_MEMFD_FLAG_MMAP          (1ULL << 0)
> +#define GUEST_MEMFD_FLAG_INIT_SHARED   (1ULL << 1)
>
>  struct kvm_create_guest_memfd {
>         __u64 size;
> --
> 2.51.1
>

