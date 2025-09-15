Return-Path: <linux-kernel+bounces-817331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6579DB580DA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 17:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18874168172
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 15:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1FC434A32A;
	Mon, 15 Sep 2025 15:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="G1cETgS8"
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D2F313524
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 15:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757950012; cv=none; b=p99Fri4EfpZXcqKetHSZHoyOJ3yC8Adj/kMmo2VDr6XmORWXbzLP7p3eeJfJWPJI01PDwB5kSaxYaQtTn08wjwlubrljRtqjwvpOzKvshsrSgo+Ay8Cf+Kfr+3tJs6YlN5XJ20+RiiI9CKu1qI4ZtSToHsbaczlDwzZNitohVQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757950012; c=relaxed/simple;
	bh=eiHdDciDni3gYAAZEuLtsnxsboW5Wnfisp7dlGLHlh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j49vW4r6QWyqDwDlrcbeF75B2E8ttNApBhM2DVwyl1mRDyHjBfyaLhSa9uDcKJNR2zqMdjIsmQTI+ahPU42Yex+q/Vb8W/1X5OjZacTswk7LuyJd0+tLuWmiITEu6nSYQe01R+kFAbC20VCLCZyfTNxxn+mbw7i0h+OsY+hH6DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=G1cETgS8; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-423fc1532bdso25703515ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 08:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1757950009; x=1758554809; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lgIK+urtilm1qOsjSmDUUjKbzrkdpZTbpLIEbKtk/E8=;
        b=G1cETgS8z9jQzC23unMI3KhMgTujIeXJ93VnzAlAK0FhB7FlIWVfT5hufeMJDbBmkW
         dA/NxQNJ0syOFiqk9u8q0IAern/xVbpORLBYIIgmEBtt3SbgW6sYGZo03gYC4uDXaDx7
         dzaXfLrJS2fQuawZuAzVdT+k6iskf4KFlSVBEiaV+LVWS1Y9r4NkKXqv8FwInWq8I8WZ
         ShlFHMVzML26/KiMN0vroETq/yuVoAGsOG4GKO6rVGonHmiv7zMWeZlxPVxtFEUDdPeK
         ZE5SpJpBp041qfIxXYGWNSCYN+l9186qSGFnbTkkbdHYYrM3Bu5pakc8aBK5odlIs5rx
         WeGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757950009; x=1758554809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lgIK+urtilm1qOsjSmDUUjKbzrkdpZTbpLIEbKtk/E8=;
        b=dO+iP5tC0DcOp3+tegBok2M+hXyBbSUuSLZPWUNPO7X0fVFB2jDWVoXDX7rNG8jvzy
         HB6KIVgSqEWmP9xmw+ZnI1t4BKUVIVZe7PuMN6ySuP6TWl6FP+FZ8L/Tvxy2GVgqQcvg
         a6ZppP3WNiFqbgM2HerBAoE2nzPnl0nwP/flB0Zy9Fy0o3+51qGH7lLG7Hxl9EhIC8vv
         GPxXfw54jIecyFE2fSkFD/3Al6HJ4PSTuo89HYrtv+UnvA4Oq0N7RTAxluIN5t1UYdHS
         655lxJ1L9K45owwe8So087ZzXsAqrYY6Inw7w8AsBrzFLlW+pD5txxynrejpCpWYqvH1
         Bx+A==
X-Forwarded-Encrypted: i=1; AJvYcCXcJ+dCf9lgM0xN1G/J104vqM4DWOuyymJTPzR+FPg3Qo/WvTNNo4Gkq9Wxv5IICgsH5vn8X9/XmPG3gbk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7+IFxX4aqrbpmzUOQGZmlZXTnHHmzJh9BUD2wEHDeKAztDApA
	05zq7tCSGPPGvWFRXxHdiA4G8OokkidWxOJBMKYlkkCplUkCI+ZgVaiZ+CB19krHoAs=
X-Gm-Gg: ASbGncvVwDn7qwOJ1yyHWWynWCpWIQ0jnWHEpGmdqgiXByU6tQ0NiZk387DFiqNpV00
	jvlU6blByW7zomwmMhB9c91hRExFfudWHRDqlRQY8WLQhfDaxDNXeqiW/nO8NZaw4n22A+wyt4E
	47FCM0kgIg0mCxExz54Kk1aI+fJnck0zxdQ0NcEejgsoiuQv2EGk9YHWJQefi4V2WIEUITd1xbs
	PGjHSA2EAVwG0QeNmB7PlvABrPGDVVo/lVrb5DZgIUidu7xtn2cnMFffMyBYJhzu5FqeV4LG4B/
	RCk9jTjoqL3nfJzQsrGkSLA+QgaMkCnlS5PrA+aNHoRABYOJj7bt4Ny5AW0p+TL2LAT+Q0JEXJR
	EYkVIjewS+AtKOnOcFTPzvSFw1e2oDD9USVg=
X-Google-Smtp-Source: AGHT+IGp645TMnXX5YrOG2zVq4VnjBtkYnO7RTUiSqJt6Cj1uUCLMRmiK6QUARht6yH+1otNnwE4xA==
X-Received: by 2002:a05:6e02:1805:b0:415:fe45:3dfe with SMTP id e9e14a558f8ab-4209d7e0f1bmr156060435ab.3.1757950008836;
        Mon, 15 Sep 2025 08:26:48 -0700 (PDT)
Received: from localhost ([140.82.166.162])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-511f3067b89sm4770679173.38.2025.09.15.08.26.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 08:26:48 -0700 (PDT)
Date: Mon, 15 Sep 2025 10:26:47 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: Anup Patel <anup@brainfault.org>, Atish Patra <atish.patra@linux.dev>, 
	kvm-riscv@lists.infradead.org, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH] RISC-V: KVM: Fix SBI_FWFT_POINTER_MASKING_PMLEN algorithm
Message-ID: <20250915-ed7932a34b8d58c2f9bdc4ab@orel>
References: <20250915053431.1910941-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915053431.1910941-1-samuel.holland@sifive.com>

On Sun, Sep 14, 2025 at 10:34:20PM -0700, Samuel Holland wrote:
> The implementation of SBI_FWFT_POINTER_MASKING_PMLEN from commit
> aa04d131b88b ("RISC-V: KVM: Add support for SBI_FWFT_POINTER_MASKING_PMLEN")
> was based on a draft of the SBI 3.0 specification, and is not compliant
> with the ratified version.
> 
> Update the algorithm to be compliant. Specifically, do not fall back to
> a pointer masking mode with a larger PMLEN if the mode with the
> requested PMLEN is unsupported by the hardware.
> 
> Fixes: aa04d131b88b ("RISC-V: KVM: Add support for SBI_FWFT_POINTER_MASKING_PMLEN")
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
> I saw that the RFC version of this patch already made it into
> riscv_kvm_queue, but it needs an update for ratified SBI 3.0. Feel free
> to squash this into the original commit, or I can send a replacement v2
> patch if you prefer.
> 
>  arch/riscv/kvm/vcpu_sbi_fwft.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/riscv/kvm/vcpu_sbi_fwft.c b/arch/riscv/kvm/vcpu_sbi_fwft.c
> index cacb3d4410a54..62cc9c3d57599 100644
> --- a/arch/riscv/kvm/vcpu_sbi_fwft.c
> +++ b/arch/riscv/kvm/vcpu_sbi_fwft.c
> @@ -160,14 +160,23 @@ static long kvm_sbi_fwft_set_pointer_masking_pmlen(struct kvm_vcpu *vcpu,
>  	struct kvm_sbi_fwft *fwft = vcpu_to_fwft(vcpu);
>  	unsigned long pmm;
>  
> -	if (value == 0)
> +	switch (value) {
> +	case 0:
>  		pmm = ENVCFG_PMM_PMLEN_0;
> -	else if (value <= 7 && fwft->have_vs_pmlen_7)
> +		break;
> +	case 7:
> +		if (!fwft->have_vs_pmlen_7)
> +			return SBI_ERR_INVALID_PARAM;
>  		pmm = ENVCFG_PMM_PMLEN_7;
> -	else if (value <= 16 && fwft->have_vs_pmlen_16)
> +		break;
> +	case 16:
> +		if (!fwft->have_vs_pmlen_16)
> +			return SBI_ERR_INVALID_PARAM;
>  		pmm = ENVCFG_PMM_PMLEN_16;
> -	else
> +		break;
> +	default:
>  		return SBI_ERR_INVALID_PARAM;
> +	}
>  
>  	vcpu->arch.cfg.henvcfg &= ~ENVCFG_PMM;
>  	vcpu->arch.cfg.henvcfg |= pmm;
> -- 
> 2.47.2
> 
> base-commit: 7835b892d1d9f52fb61537757aa446fb44984215
> branch: up/kvm-fwft-pmlen
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

