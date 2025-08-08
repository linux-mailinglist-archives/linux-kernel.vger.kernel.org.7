Return-Path: <linux-kernel+bounces-760176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5652FB1E769
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 13:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15D3562693F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 11:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1C6257AC7;
	Fri,  8 Aug 2025 11:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="OFxzTIrw"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D4A23C51D
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 11:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754652916; cv=none; b=nUD/eKXrDWjZTWzJQOqvH/TCVcFeeOQ3gYTo41jRJfSuZ0LAAhnEWr7TC6Iiy/I4eWE5TkvAkh0lhLgb0hD9z7cz7JAL5JeZsRzmEq7uxHhh3gPX8nziQR4ByGHyQ2V+YEYQeRlbHVzg/Cm5T0VxWATbfQw4g3azr8AJKji4HV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754652916; c=relaxed/simple;
	bh=CquLhGMQq6SPS9k+2Xd7aktEnvY7w48dkJqJFu3/V9s=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=NjH7UCRvEKc9KnPPHTMtY/muAzOlPxnLtYckgy5xP6b1FN8IVHQ3DdB/we//7oxfR+3E438us7KeTzY5vUaGbMZ4DfwgxguU7X+o9fUrsXbhW3BP9Qte+fZ9A3CDFrRKlT1N/k/6ah5dhBMge3DdeyfTACxvKD3DLj2hJjCAlbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=OFxzTIrw; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-459ddb41887so2719775e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 04:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1754652913; x=1755257713; darn=vger.kernel.org;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bVe0BYxb2hdDOzuqM0QPgQUk4JUNXE4YiObhQZZKcW0=;
        b=OFxzTIrw6kuYFdSWe4ft9TVNCyIxngOudEVFd/LPwFu42NeYks1vYNilZe51CeoarH
         dXGPQelNLhoXCvJc/MyX67U1uI1mXKxN2jPy/KUao64J4+uHOYtRT9N99Lm+GCwiwm+6
         kYm/i3iiPNUa4UZ/C0aCuE/R3/RuWCa5ofwpg22/JSI+RR1YANimK2dSQePGsuGtW9Tl
         n7+s83m2VVd9U1ul7z2L3DLKR6NdB4uMtfvueMwLb3cQ0yfgcX9uHjlqVyKruYxO2ShM
         x29d2scxa+2yZIKjAs2xVMVIk35H9JEvW9BaaQU9JJnIUe1MaiuB3zj/6xvNgwvCZjgT
         bneA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754652913; x=1755257713;
        h=in-reply-to:references:from:to:cc:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bVe0BYxb2hdDOzuqM0QPgQUk4JUNXE4YiObhQZZKcW0=;
        b=lJ+lgdun4DSR23aEeblTKzGWHpMZZBxIQKcu+Kq8Y7Bwccjr+QPUOATKbsyJ7+o1Ap
         Jrw92t7npa/lPw9vYaGLTs+nEgpDLnafPN5xONbVWR3HuZynnm2PbqA734Zu97SQF9Fu
         rue7yfLmgc53VbQAhaXd8iG1gZD9wue+bebRcUCECxTdUa2FHPpyTvli7PLdQTGrbKMm
         fK6z3bGm5DDCrhXEbbprNOIKdcATPkucLY833NBLlJpzLhvXx7x14+oeFGUsy45+NwNo
         1l8FYvT3XCXt5kyPUxBkkJWeYVvdrVq3+M+stVGYcF4xcNnimwFNESH5qMomX4Zsjzmv
         u+Pw==
X-Forwarded-Encrypted: i=1; AJvYcCWjINjg1nqAxaI12tuW9d1Px4xHdjD6K9vOcL/S4fJYnrhlmfvahTscTETAta3bxKwqVF1rym3mdgwtTOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjwqH1H1h0omwYBzjJ5GtNG1V5H/JyFCnm2LRRNYK2rW86cz8r
	+D0QEdaaWi0fJxD+0t+hLcEtauN4VwafvaDLOobcBgCAAmP08jKqgvwTjNZkpdGAgWk=
X-Gm-Gg: ASbGncuFMnNghjvU/1JvrNchEvefCq3ILo4Go4/JaSUO18iA1IoPL4ToawH8bQdHCOE
	X7izP9eTMVqiKOS6KuE48An/6lPw41UH8bP+v6Id0rUab4Q+Bv0cdSzP0Mk91+WhmJrYu+7eIx3
	KjmbnRNI7bWzCAUHWI5GyYqoDxR730EiU1kotIUboPix13Kto51KpAoSepWXm1hVNeTKHcHlGUe
	zt1rU9F2/VBi5Hgb0pOFlfRg8fq/N80X+Om6sNYQFaeUzOQOgYNZegCmrOB5R9s6O8hzLzpAuIR
	gPGFePGrt1qFYQdBDCdwiPTf04WVCKosaGavHCyvG9n3XfvJKI5GBuUkjILKVw9/xT0Q9q/TqDD
	2Tzl/vmZoWbcBoNOn+HHa8oFZgzIP
X-Google-Smtp-Source: AGHT+IFliH1IeRlmtSKl6taCyhr9lWYZytazufI3Vxt3GCyH4GgGDnZo7KA2cPTXc0F1MYhLNN1WMA==
X-Received: by 2002:a5d:5d88:0:b0:3a5:8abe:a265 with SMTP id ffacd0b85a97d-3b900b4ca0bmr1072782f8f.10.1754652912918;
        Fri, 08 Aug 2025 04:35:12 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200:764c:bb32:dd82:c77])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b79c338c7dsm30164171f8f.0.2025.08.08.04.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 04:35:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 08 Aug 2025 13:35:11 +0200
Message-Id: <DBX0JNR61UNM.Z42YERAKRFR8@ventanamicro.com>
Subject: Re: [PATCH] RISC-V: KVM: Using user-mode pte within
 kvm_riscv_gstage_ioremap
Cc: <guoren@linux.alibaba.com>, <kvm@vger.kernel.org>,
 <kvm-riscv@lists.infradead.org>, <linux-riscv@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, "linux-riscv"
 <linux-riscv-bounces@lists.infradead.org>
To: <fangyu.yu@linux.alibaba.com>, <anup@brainfault.org>,
 <atish.patra@linux.dev>, <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
 <aou@eecs.berkeley.edu>, <alex@ghiti.fr>
From: =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>
References: <20250807070729.89701-1-fangyu.yu@linux.alibaba.com>
In-Reply-To: <20250807070729.89701-1-fangyu.yu@linux.alibaba.com>

2025-08-07T15:07:29+08:00, <fangyu.yu@linux.alibaba.com>:
> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
>
> Currently we use kvm_riscv_gstage_ioremap to map IMSIC gpa to the spa of
                                                                    ^^^
                                                                    hpa?

> guest interrupt file within IMSIC.
>
> The PAGE_KERNEL_IO property does not include user mode settings, so when
> accessing the IMSIC address in the virtual machine,  a  guest page fault
> will occur, this is not expected.

PAGE_KERNEL_IO also set the reserved G bit, so you're fixing two issues
with a single change. :)

> According to the RISC-V Privileged Architecture Spec, for G-stage address
> translation, all memory accesses are considered to be user-level accesses
> as though executed in Umode.

What implementation are you using?  I would have assume that the
original code was tested on QEMU, so we might have a bug there.

> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> ---
> diff --git a/arch/riscv/kvm/mmu.c b/arch/riscv/kvm/mmu.c
> @@ -359,8 +360,11 @@ int kvm_riscv_gstage_ioremap(struct kvm *kvm, gpa_t =
gpa,
>  	end =3D (gpa + size + PAGE_SIZE - 1) & PAGE_MASK;
>  	pfn =3D __phys_to_pfn(hpa);
> =20
> +	prot =3D pgprot_noncached(PAGE_WRITE);
> +
>  	for (addr =3D gpa; addr < end; addr +=3D PAGE_SIZE) {
> -		pte =3D pfn_pte(pfn, PAGE_KERNEL_IO);
> +		pte =3D pfn_pte(pfn, prot);
> +		pte =3D pte_mkdirty(pte);

Is it necessary to dirty the pte?

It was dirtied before, so it definitely doesn't hurt,

Reviewed-by: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@ventanamicro.com>

Thanks.

