Return-Path: <linux-kernel+bounces-849565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E452BD066D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 17:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD1393B9FB7
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 15:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471A6279918;
	Sun, 12 Oct 2025 15:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="NCIioUrl"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDDA7082F
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 15:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760284289; cv=none; b=sjxQRNb4pAyJ83dtvtd1c59QZ3maci/qg5hin2O57I/pbAnrYIf7fUvGPQlucMbxnEItitjhtH4dfyZNii6ZmMOn9YoRgrXtF/HHksSEPIfwrRoYJ3UKjJO5TcQrPjQUFuiQrQOdJQoaBm9LhqLp1gEAUMNLvlcpHdZjp/eox88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760284289; c=relaxed/simple;
	bh=rLwGsYgiNA1M08GQ3X8/MU2r0zyAVlJmac9bNTYnasU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a/hzU3d2QBUoJELQpzjLWD+VW/flYbP0rjkdqNEK6SNQ9cPJujDTp9riGyieUzbyYJ0W6KpHiWrwxt2on36Y462fRWrBddOLwTvYQsgqy4gxixHeKRPDEv+1FyBGScgT4y2BD9TtfeyJQ7UyTp3BOAsVAymo1U/EQw+zXMQUyf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=NCIioUrl; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-57d5ccd73dfso3493374e87.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 08:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1760284284; x=1760889084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/t12InzFvAri1mWk/q7HQ1pr3AqTtuxv6ASYMC0LIYA=;
        b=NCIioUrl5nGlvxNvI85hJ5TomQbWeF6UOZIHb3wib/LTNlBpAgQY8qnxU/XciOTr6k
         0gfjkAFm1vdRNVIaQtP4+Qv84ptNvnmE6T9SflthpygJLxAZh976cGaWlbEEfXHldcmI
         Ekab94H01ncVEVKXVlxaJH9QLYC3vkS80Jwib0jr/6c4E/UdCE4J6AdikOFRz1x83r78
         O43so9HlltGKSRZCcvAxdiKwfG48E7EgjTKQP3OPEAQ+D4ZII+hYJ/PEVh7Wh2dyKZYC
         R2FPmPxU5+Ozr9P9Yi0ddf22FUTH7pR28nVKddmhebEvMNMsbr+LDhLW0ejmeJO6uypZ
         geIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760284284; x=1760889084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/t12InzFvAri1mWk/q7HQ1pr3AqTtuxv6ASYMC0LIYA=;
        b=sb0Z6nmMVFmJPkWSubQVEfHAZwJppRCy8LMBJSyaj/YYmLABewvcIF25QSfSM0cwZr
         0TjYM4il3gchbcjJTvvOEBGot9c7an2ktC0Qc6QdEPB7QeHvqzXllrv7gQNtpYuGsY2Y
         jY9UU7YpF3Y0a+pp7jWs3buL0pNOyjzyTQK+nYy3Fku9056uOavuMeWbN6yC2m8kMJcu
         gqNts8xe+Z0aCR+QBVDIXYBz5jzcLSqQ3FFwbZFseDN1iUiX2ebxiNx8q1WXjN51It5t
         IdDkZb3QQZyg6sjGWuVClKHkBBApoRt20qFsqTV/5OaTL1M5rM5/wKXNLs69Td+2czOo
         yfLw==
X-Forwarded-Encrypted: i=1; AJvYcCUFia0v+SmOKDMaII5yulXX0BAVdUmko4Myv7K8309Ulb7xOGixqItyVHZHCnbwjk0WKyg0TvBwuPPI1Zo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOq76f73vCqeWXHwjJqO5574p9qjjBa411aOQZt4FcIi1LotOv
	3T9JDlP895BUqFNSYowiPU4qQd+/FKTtv5Rn4FR4Ep+44eoAkUXoouHzlFDR2qs2WQV2SwTfe1d
	I1JdlHfWrrif9ePczl1EMx6xTaEY6vx4lbXZl0jsBTQ==
X-Gm-Gg: ASbGnct8cFvcIwiEHUAXik8LEk7kJAFudJmm/+a/fwfTwJdEMna/A0/4fjPMLesGlSo
	WdCLYdlTKFF3H+KaWfHnGBJK7zsVL/BAtOlCfr4wnCOYHhIjIzsjsDe35IMtyy9gomdGur9vaND
	tMuxLyl+tG/Nub9rkRGKmSLezDJ8HVSGTI/0hytpdg4CcroEgM2YA6QTpC8+/MAusnOCLoH2CkJ
	SVKiMVJLCBIJRBOGkmCbw62w8G9ZZwdKNrK5w==
X-Google-Smtp-Source: AGHT+IHibYYuMSAztSRYVgUsb7X+Eeohn+xQDvNzScwzoKe55a/3OjktCD8Y4WeUbjtoNTbPEq8EMqctoNpd55hvnds=
X-Received: by 2002:a05:6512:1110:b0:590:656c:d114 with SMTP id
 2adb3069b0e04-5906dae5d1bmr5127553e87.46.1760284284098; Sun, 12 Oct 2025
 08:51:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251011155746.1558731-1-guoren@kernel.org>
In-Reply-To: <20251011155746.1558731-1-guoren@kernel.org>
From: Anup Patel <apatel@ventanamicro.com>
Date: Sun, 12 Oct 2025 21:21:11 +0530
X-Gm-Features: AS18NWAU0Fdjt2JtdTXJfp-1L5hMarIkG0mDEynGAB1I_qGvGN2Q6vemT_nxpO4
Message-ID: <CAK9=C2UrYg+sHsDqkmz7f7KnaREU7hXF4rbON002cnAti_pDXg@mail.gmail.com>
Subject: Re: [PATCH] riscv: Add pgprot_dmacoherent definition
To: guoren@kernel.org
Cc: samuel.holland@sifive.com, david@redhat.com, yongxuan.wang@sifive.com, 
	cuiyunhui@bytedance.com, luxu.kernel@bytedance.com, paul.walmsley@sifive.com, 
	aou@eecs.berkeley.edu, alex@ghiti.fr, palmer@dabbelt.com, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 11, 2025 at 9:28=E2=80=AFPM <guoren@kernel.org> wrote:
>
> From: "Guo Ren (Alibaba DAMO Academy)" <guoren@kernel.org>
>
> RISC-V Svpbmt Standard Extension for Page-Based Memory Types
> defines three modes:
>
>  Mode | Value | Requested Memory Attributes
>  PMA  |   0   | None
>  NC   |   1   | Non-cacheable, idempotent, weakly-ordered (RVWMO),
>       |       | main memory
>  IO   |   2   | Non-cacheable, non-idempotent, strongly-ordered
>       |       | (I/O ordering), I/O
>
> The pgprot_dmacoherent default uses the IO memory attribute if there
> is no asm definition, but IO is not for main memory according to
> Svpbmt rules.
>
> This commit corrects pgprot_dmacoherent with the NC memory attribute,
> which satisfies performance improvement and prevents using the IO
> attribute to access main memory.
>
> Signed-off-by: Guo Ren (Alibaba DAMO Academy) <guoren@kernel.org>

I had sent the same patch on Aug 20 and you had provided
Tested-by to that patch.

If you had concerns with my patch then you could have provided
comments but you choose to hijack it and change authorship.

Regards,
Anup

> ---
>  arch/riscv/include/asm/pgtable.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pg=
table.h
> index 29e994a9afb6..2a84479de81b 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -654,6 +654,15 @@ static inline pgprot_t pgprot_writecombine(pgprot_t =
_prot)
>         return __pgprot(prot);
>  }
>
> +/*
> + * DMA allocations for non-coherent devices use what the RISC-V architec=
ture
> + * call "Non-Cacheable" memory attribute, which permits idempotent, weak=
ly-ordered
> + * (RVWMO), main memory. This is different from "I/O" memory attribute w=
hich is
> + * intended for MMIO access with Non-cacheable, non-idempotent, strongly=
-ordered
> + * (I/O ordering), I/O attributes.
> + */
> +#define pgprot_dmacoherent pgprot_writecombine
> +
>  /*
>   * Both Svade and Svadu control the hardware behavior when the PTE A/D b=
its need to be set. By
>   * default the M-mode firmware enables the hardware updating scheme when=
 only Svadu is present in
> --
> 2.40.1
>
>

