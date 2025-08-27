Return-Path: <linux-kernel+bounces-788102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 899E5B37FAD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 12:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B05EA1B65BBD
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 10:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CD3337683;
	Wed, 27 Aug 2025 10:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C7fSUn0Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01595319855
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 10:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756289872; cv=none; b=rFfbR5ShyOOflLUcblDeNE0nsZKoF3BlXxNenlpIP3cfNrf7+9L1AD6U2YMgKckfgqCmSDMzfI8ZS7FRPwh/l0MPq0IuM55W8bvdt+CKoE9bBfcC5GHDfPKYRXE7rVSIiZp5iNZT7F6ePS9gpjnaSbAuDctuG1JCr8jCYBIyxJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756289872; c=relaxed/simple;
	bh=lOiDzk3UlWjzR0d5BtVvVQ34OrJvTQo9wG1rv9COwv0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mCBs8jSwf09Qd2VWmoX/PPIja9LXc6aio65JjJea0AF29s2z3byrcxzPQ3J3nyiFF66j5PpdtpJcXWqtoMn+Aa4P2ywcgzfTrtuLPhM89MEibRnOKuJE+7dG5Qj8xCodXe4LEXYtsXU9GWU7/bKVq8M9qqvNcB0DkoIGdma/h88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C7fSUn0Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC26FC4CEEB
	for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 10:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756289871;
	bh=lOiDzk3UlWjzR0d5BtVvVQ34OrJvTQo9wG1rv9COwv0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=C7fSUn0QS1V3ETfjHLeo/Uu0aaQQ7I4aa1rZfuTgOpxV4wu3sgnbaYLLl4lrjGEop
	 bXaqysRz1T459K9hHXX6Efg7qL1rfWIIC8iCxc79nf/0DrOyokuKwpr1/zNy+Z5A2D
	 MMo+iJ2H5sYk596YY4o2RA3YsiF9hjp+DwYVopFiPE2UyVKfphxdH/ZDpm75TxYBkk
	 FCGDvkCCwZMxqUSN8UgaP1pS3cqTd2LeEuJJtKUlE5NFfjHQgXe8ClAJHqiGItFCin
	 YOlOY/6ihKCfIz4kjZeVAgMoEG+QLj14CrkYSiTNoUJdB/lPj1UJSfcPUNjle3fOIv
	 1KFoSupfvU96A==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-619487c8865so1546282a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Aug 2025 03:17:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWWZdfafpwafHf920/JsluC/UiwpP18u8pMXHEnG5AEXUReBUSdZFP65dAEiVudG+HEcRNP7d0PPp4FYAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSGyz8p9UAGkcpd8njc5I3qRW+5ii1zeQUS96+DsUCqrnzHPE2
	+pTfzMmwh9kGfn1Nj2U3L/kVSOch4FCa3b0ow3ALXpkqesewdt9GQntSWU1GbGn93c4/MpgUrxH
	PhnLztOp4Rn0O2Ev4DyzJVgTqOQ3cYtM=
X-Google-Smtp-Source: AGHT+IFuech9sAlCSWYd7t9EcWjbklbmV5kXdVa4QmRBKMxaX258l/LboXqUcTT4erExFnyO4586YAytHpLYl57cYzA=
X-Received: by 2002:a05:6402:5186:b0:615:3667:f4eb with SMTP id
 4fb4d7f45d1cf-61c983b7f50mr4247202a12.6.1756289870308; Wed, 27 Aug 2025
 03:17:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250826063908.6615-1-yangtiezhu@loongson.cn>
In-Reply-To: <20250826063908.6615-1-yangtiezhu@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 27 Aug 2025 18:17:38 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4G4_Xvuy35Ff_deY3FrRAaYGRTYpPR5Ru1=BUMqSb1fA@mail.gmail.com>
X-Gm-Features: Ac12FXwg7x9U4Onn7m4aSR2UaTnf41bPqLgQoz98sosS70AuFhO6umncV1nZH5A
Message-ID: <CAAhV-H4G4_Xvuy35Ff_deY3FrRAaYGRTYpPR5Ru1=BUMqSb1fA@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Update help info of config ARCH_STRICT_ALIGN
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied, thanks.

Huacai

On Tue, Aug 26, 2025 at 2:39=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> Loongson 3A6000 and 3C6000 CPUs also support unaligned memory access, so
> the current description is out of date to some extent.
>
> Actually, all of Loongson-3 series processors based on LoongArch support
> unaligned memory access, this hardware capability is indicated by the bit
> 20 of CPUCFG1 register, update the help info to reflect the reality.
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  arch/loongarch/Kconfig | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index f0abc38c40ac..fcf6575b02f8 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -563,7 +563,8 @@ config ARCH_STRICT_ALIGN
>           -mstrict-align build parameter to prevent unaligned accesses.
>
>           CPUs with h/w unaligned access support:
> -         Loongson-2K2000/2K3000/3A5000/3C5000/3D5000.
> +         Loongson-2K2000/2K3000 and all of Loongson-3 series processors
> +         based on LoongArch.
>
>           CPUs without h/w unaligned access support:
>           Loongson-2K500/2K1000.
> @@ -573,6 +574,9 @@ config ARCH_STRICT_ALIGN
>           to run kernel only on systems with h/w unaligned access support=
 in
>           order to optimise for performance.
>
> +         If you want to make sure whether to support unaligned memory ac=
cess
> +         on your hardware, please read the bit 20 of CPUCFG1 register.
> +
>  config CPU_HAS_FPU
>         bool
>         default y
> --
> 2.42.0
>
>

