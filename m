Return-Path: <linux-kernel+bounces-879681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86BFCC23C1A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 09:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D131562D9E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 08:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDC822F6594;
	Fri, 31 Oct 2025 08:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lc+9FDXr"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD39311C16
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 08:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761898182; cv=none; b=EXjIuO9wS0hp91RzyCfNGbNnySG7n8MCQvTx8zEeqwN7SXcGMIpwMwRQgy99RAW+/q73ceairxPQx09j7inrLGorkxxNeU1IV8dD4tAbycCpHVUWcvv8lXENNds3GkAXbuLksx3ObbN0AMDFiuCc61b7n20tMBSCZCWquZhpkUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761898182; c=relaxed/simple;
	bh=kf8HyOsYwdOePIqwVTCWV7fE1+Z/HvbEoskwb19+yBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NFgXVHxItAR0SLYMhFvxeOd6kiSArTlxFgEAkh0XYVENccEof/Od4uDEbOE28oM1v/LxRQ2GGwcU7Kk8H6dPKjoviOiWFpdTHmQtmd+2f9WLwIZkXR+v4Pjo8xxL6AW7Q9XMxahrA1C01DU6xGv9BtN90URNmB6NBtbaTCv4ZIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lc+9FDXr; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4770d4df4deso32795e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 01:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761898179; x=1762502979; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VvPD2QlzwFWzsFKSo3tRWtjQG+OHFkXfXTJssyHMdKI=;
        b=lc+9FDXrXiwwWzDDfFnplss3ObNmbbrWWaihGwjrLxv1r0ZdJw0MVyxlmMApFUZEgz
         st/QJm3RFNqy5yRjukpwVIP6qSCXU3/FZOGtQmwts2TRqcidB+GwENkb/+ILY6om6L7v
         bYTiI6KB/U/SI8usArVmDLX6VZtd+GbJveN3n68ql7C7Fj36m4E5uq1d/KRRwF28uGqU
         +XFU8KK/+7NXLzstpc1Hr+c0vv1rR9qZdtsVzFtX2FWUr+NGJ720BkHZjlA12OejbOzb
         bhh7JNNlqr47dj+Q9VOmPOrwj67kqa+yNXvU1u0ilSqmTMLNBxG3r2ey7pPgisUc6bMC
         0HtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761898179; x=1762502979;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VvPD2QlzwFWzsFKSo3tRWtjQG+OHFkXfXTJssyHMdKI=;
        b=b1I6rDjAogO7DTEwDQ6DYwnyd3cJysBQ4egl5I0vmUlpEJikTrNlSgiqy2SY1g+xYb
         gPVM+yVScy4lt9+ctWZSUy9Kqziv74xQ8RIxCseL2atOmbA3QPrThzAeq2/Iw3Qz+OAz
         1MZVZDdCnHQTUrrY0zo+IgQjSy+jj/a8zsgRC+V5DxAeplmlwS8jO7jAxZE4QLJ4fc21
         QEq1MgY/Ljz/XSJ5loK5Opb9M3wyftoaX9ypOODOh5LbYe0DMdVND/x7qK47DXx1VVPW
         5jyQbEn3kcrUMb0wsN/J1wDTw6uRQg9Hqb9qxoqbW2MhxPM17kllIpvaxyfgH2FEtXs+
         JnFA==
X-Forwarded-Encrypted: i=1; AJvYcCUcj812bh8OFEh5iRtKULwnNwpgUEljgq37r+wdkZxes/1XmTr8Vc2VVLnDkM5XUyeAHx8taMRCV3Dms2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxN/wa7gYlBhVP7m2qKt5heFbn5xU/mxmetqnUXosnTMm3x8uc
	V1yz4eQVt3FEZNsz+76FUImzHpmMKBrSlmC9uZOzCGYmlIrSk//XB+gxmHq4EnwR4A==
X-Gm-Gg: ASbGncstap5JWNsqvFttNNuANY3A5COwIiBTsabp0MKJbJ9nf3BRHQ440p3kbjlZjm+
	zmFGGEXghy8rYKOnAEodrEL8c+KSh6ioPQYQZn3eZH2sv3vtnYFsZPngWZksLyLhC5zUFA2eIR8
	rfCbB+eImCT9tbi/t0LI233b2Tj7DshfQZkVCkrPFqu2xMWbRzluGt6NE9BwsxwPv3723INUCFK
	cOMX0p+k+XdaQ8HwW3sFT3attyzw7eycCbjrjZ2okdgxmCClaGq7K49TOnzYWbo14Kxbispbq/p
	70zgqMGo+Hz0CtwTFkKVQHQ/D0QBSLjoE9H7e3W5ZY/f50qA8ip7RpVfpGeZ8a6KeNZRhcd07cj
	3HVJcM86Fr0tL6IMMgjZU4wlD5UYN7sCsO+0Z75GpTDEkW9oReZSGWzwVAlFrEMDjfuAGgIzrJ/
	g4My1FXOtGuqIDSVFZvTkV1p9Vr/MkHCggew3df4Iu8MFf+m1hdoGrEMAUKw==
X-Google-Smtp-Source: AGHT+IEowXI+Xa7Cev+Atw93C9B+sivtK/myXmK5E4UjFwYC2UVYflMXTzX7icRn1YESBGhfSybnGw==
X-Received: by 2002:a05:600c:3ba8:b0:477:1afe:b962 with SMTP id 5b1f17b1804b1-477324afbe5mr1342845e9.1.1761898178470;
        Fri, 31 Oct 2025 01:09:38 -0700 (PDT)
Received: from google.com (177.112.205.35.bc.googleusercontent.com. [35.205.112.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47733023256sm19735575e9.17.2025.10.31.01.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 01:09:37 -0700 (PDT)
Date: Fri, 31 Oct 2025 08:09:34 +0000
From: Sebastian Ene <sebastianene@google.com>
To: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com,
	catalin.marinas@arm.com, will@kernel.org, perlarsen@google.com,
	ayrton@google.com, linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] KVM: arm64: fix FF-A call failure when ff-a driver
 is built-in
Message-ID: <aQRuvu8V3woqnqCV@google.com>
References: <20251027191729.1704744-1-yeoreum.yun@arm.com>
 <20251027191729.1704744-2-yeoreum.yun@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251027191729.1704744-2-yeoreum.yun@arm.com>

On Mon, Oct 27, 2025 at 07:17:28PM +0000, Yeoreum Yun wrote:

Hi Yeoreum,

> Until has_version_negotiated is set to true,
> all FF-A function calls fail except FFA_VERSION.
> The has_version_negotiated flag is set to true when
> the first FFA_VERSION call is made after init_hyp_mode().
> 
> This works fine when the FF-A driver is built as a module,
> since ffa_init() is invoked after kvm_arm_init(), allowing do_ffa_version()
> to set has_version_negotiated to true.
> 
> However, when the FF-A driver is built-in (CONFIG_ARM_FFA_TRANSPORT=y),
> all FF-A calls fail. This happens because ffa_init() runs before
> kvm_arm_init() — the init level of ffa_init() is rootfs_initcall.
> As a result, the hypervisor cannot set has_version_negotiated,
> since the FFA_VERSION call made in ffa_init() does not trap to the hypervisor
> (HCR_EL2.TSC is cleared before kvm_arm_init()).
> 

I understand the reason behind the patch but this is problematic to have
the builtin driver load before pKVM because the hypervisor would be
un-aware of the host mapped buffers. (eg. the call from ffa_rxtx_map is
not trapped because it is too early). Essentially, you will end up
bypassing the hyp FF-A proxy which I think you will want to avoid.

> Consequently, this causes failures when using EFI variable services
> with secure partitions that rely on FFA_SEND_DIRECT_MSG.
> 
> To fix this, call hyp_ffa_post_init() and set has_version_negotiated
> during hyp_ffa_init() when the FF-A driver is built-in (CONFIG_ARM_FFA_TRANSPORT=y).
> 
> Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> ---
>  arch/arm64/kvm/hyp/nvhe/ffa.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/kvm/hyp/nvhe/ffa.c b/arch/arm64/kvm/hyp/nvhe/ffa.c
> index 4e16f9b96f63..0ae87ff61758 100644
> --- a/arch/arm64/kvm/hyp/nvhe/ffa.c
> +++ b/arch/arm64/kvm/hyp/nvhe/ffa.c
> @@ -984,5 +984,17 @@ int hyp_ffa_init(void *pages)
>  	};
>  
>  	version_lock = __HYP_SPIN_LOCK_UNLOCKED;
> +
> +	if (IS_BUILTIN(CONFIG_ARM_FFA_TRANSPORT)) {
> +		hyp_spin_lock(&version_lock);
> +		if (hyp_ffa_post_init()) {
> +			hyp_spin_unlock(&version_lock);
> +			return -EOPNOTSUPP;
> +		}
> +
> +		smp_store_release(&has_version_negotiated, true);
> +		hyp_spin_unlock(&version_lock);
> +	}
> +
>  	return 0;
>  }

Thanks,
Sebastian

> -- 
> LEVI:{C3F47F37-75D8-414A-A8BA-3980EC8A46D7}
> 

