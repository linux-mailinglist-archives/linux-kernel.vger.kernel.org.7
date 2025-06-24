Return-Path: <linux-kernel+bounces-700330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C3EAE66F1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 15:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47F39189F9D9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jun 2025 13:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8982BEC24;
	Tue, 24 Jun 2025 13:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="Xq1039Am"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D045F28F528
	for <linux-kernel@vger.kernel.org>; Tue, 24 Jun 2025 13:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750772850; cv=none; b=cr5IALavI8maPEdWMC8rLGAQ5oLlURsTwdYT8xK84j3txFFcJaAJXiRYMd+9gavWdULHucF8SWXdR8CH6jZVDbHQefALxDmj6HzrIIWzMI/MQGpzTPQdoBE4rVAOBcaI3FuaEDaDc7kimQB1MLj5L0GK2J1GHVMZR6C6L1+0HXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750772850; c=relaxed/simple;
	bh=FPqOE17+APKrELMb456PcHqUROKib4uvVIedL0A/K7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CI/c0SkIuqTvZA2XbsG3408PlhL1mUK8Y4C2kBPYV3U4KeyrzHHPwiIz/Tb+EP9eaxt9Tt2/MDeqINUf9I7Jx90Ruaz2CcCdGPnANbVVcRPyarysL2+i5SXqckA3iPPNOHle/rdadDMFD6AgKnjgF7Ly5n24K4cO9a65QuTrveg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=Xq1039Am; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a6e8b1fa37so730440f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jun 2025 06:47:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1750772847; x=1751377647; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ycq0kX3Vn1ZpP7yxI/jdDggIlJCstgVkDpgaYIcdwgY=;
        b=Xq1039AmgKM/kRcKJpfQ+M+EFxzjmDkRzQMPsUNm7yPox9qqQPD3Im3dKZM04UGQDg
         C1zj9a4aRodqr5W7zjqczr7f5arr2EI/V0oWfhezuoW2mH6NF9K9TWCEUSMOPaxQ5Jz1
         3kKgq7t7mpn8TcCBzXwS0KniE01VAj7OuAl7MBhw6Ug00DlPWsIUwF3BENyif5X4Csrt
         fFiN8muVCFpktfDzicjbZnFOzmEgnf+47ZOMjY91OeplRnpLrr9WksTl7j6lrfNGTXhX
         fTjpCuDt6ioLbCy/vba/iFFPpsFhZnljIPtPtoTozTqj4X2Qfg0PADUmkGxyThxSGlR+
         ajxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750772847; x=1751377647;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ycq0kX3Vn1ZpP7yxI/jdDggIlJCstgVkDpgaYIcdwgY=;
        b=JJRhwC+gI6Hn08lpscoKAys3WOIDt++rkA0l0WyfnHO5Dz0DGHKIkvaw4bW6jvvG3K
         iRfaEJ1K0NTXQG7Qf8908BBgdfFE4D1FkTi93NtP6jWluF+97iiVI6Ogc9Zz3pzgfmDe
         HjOMzZj4jM+BgNR+O6JJH+hAOq0LdIyEi1m25F/9qdme34EP6II83flSuMiY8Z3pBHnG
         ENH+OJzX1NisxmEcNaCh+Na7dRilwCDozrpItMpuqy6nbTx+mRu3HeClr8yIvjCuYNpo
         OzcNiDwdI0d1LbMxixsSb1PNxRX6pmmJez0RzbIxeJ3xnvrJedX5bbbmrC2gaeQAVXcW
         Zxmg==
X-Forwarded-Encrypted: i=1; AJvYcCUFMSlsEVql93EI6JJUlGWIOIdH2CtRjd9Z7V9Lef+Qandv1zm4kM8pPRbOeoES71+n19b98g2VB4rKWus=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0lEuf5c4uPosH2Z7ltqTXJmdEA78Z08ZNbrBmztwkV3o+mKcr
	r1CXsbdumHcqSzahjJnpFpKPAYD+cQsw69mOFtwoCxxshvikyHy+jSVQYAQrZhaKBOU=
X-Gm-Gg: ASbGncvNrs/kbUIosodIicJOY84Sf1AvavnYDc9cyuINQcmQsY/asoFDU0b+a3mCPpX
	2oefH6QFxvlb3xqjf/uaMMpBwyXcZOCXAiRo2uiWfPUb1fmWGqluXWk8iwJvDGs0TL12lwx2jJb
	B3aOa2FSBHt9gm2IeCvxYjRaRexjHO4SWTfjxDhdnm7s+hcu+k3HPG0vdbQCrw4Ke+y7vyAo8on
	h4hYO6sLRBjjBYe8PVHGkHjJfBBy604wyOf2KZawOJkVPm1SAO2fYjjzLrXayFZe5cp5XlMBnz+
	0H3APTkSA82cUQ0utQHO5oFe0Hh+MvwgyrT2/Jtb1lKnlfIiGg==
X-Google-Smtp-Source: AGHT+IHb76B6ik9Yt3pkD/SAdLPqXg65db3i1R0WxXLtr/BPlZTDKztKX7BSnwY0vPSiL+IcBDUqLw==
X-Received: by 2002:a05:6000:2211:b0:3a4:ed62:c7e1 with SMTP id ffacd0b85a97d-3a6d12c455cmr12967179f8f.12.1750772847157;
        Tue, 24 Jun 2025 06:47:27 -0700 (PDT)
Received: from localhost ([2a02:8308:a00c:e200::5485])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a6e80f259dsm2035419f8f.50.2025.06.24.06.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 06:47:26 -0700 (PDT)
Date: Tue, 24 Jun 2025 15:47:26 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: zhouquan@iscas.ac.cn
Cc: anup@brainfault.org, atishp@atishpatra.org, paul.walmsley@sifive.com, 
	palmer@dabbelt.com, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	kvm@vger.kernel.org, kvm-riscv@lists.infradead.org
Subject: Re: [PATCH 5/5] KVM: riscv: selftests: Add bfloat16 extension to
 get-reg-list test
Message-ID: <20250624-044127e80c3700d93f114280@orel>
References: <cover.1750164414.git.zhouquan@iscas.ac.cn>
 <65752029ed1ae331a9ac867a6fef2e63a797569e.1750164414.git.zhouquan@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65752029ed1ae331a9ac867a6fef2e63a797569e.1750164414.git.zhouquan@iscas.ac.cn>

On Tue, Jun 17, 2025 at 09:10:50PM +0800, zhouquan@iscas.ac.cn wrote:
> From: Quan Zhou <zhouquan@iscas.ac.cn>
> 
> The KVM RISC-V allows Zfbfmin/Zvfbfmin/Zvfbfwma extensions for Guest/VM
> so add them to get-reg-list test.
> 
> Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
> ---
>  tools/testing/selftests/kvm/riscv/get-reg-list.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/tools/testing/selftests/kvm/riscv/get-reg-list.c b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> index ebdc34b58bad..e5a07e000b66 100644
> --- a/tools/testing/selftests/kvm/riscv/get-reg-list.c
> +++ b/tools/testing/selftests/kvm/riscv/get-reg-list.c
> @@ -80,6 +80,7 @@ bool filter_reg(__u64 reg)
>  	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZCF:
>  	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZCMOP:
>  	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZFA:
> +	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZFBFMIN:
>  	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZFH:
>  	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZFHMIN:
>  	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZICBOM:
> @@ -104,6 +105,8 @@ bool filter_reg(__u64 reg)
>  	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZTSO:
>  	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZVBB:
>  	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZVBC:
> +	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZVFBFMIN:
> +	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZVFBFWMA:
>  	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZVFH:
>  	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZVFHMIN:
>  	case KVM_REG_RISCV_ISA_EXT | KVM_REG_RISCV_ISA_SINGLE | KVM_RISCV_ISA_EXT_ZVKB:
> @@ -535,6 +538,7 @@ static const char *isa_ext_single_id_to_str(__u64 reg_off)
>  		KVM_ISA_EXT_ARR(ZCF),
>  		KVM_ISA_EXT_ARR(ZCMOP),
>  		KVM_ISA_EXT_ARR(ZFA),
> +		KVM_ISA_EXT_ARR(ZFBFMIN),
>  		KVM_ISA_EXT_ARR(ZFH),
>  		KVM_ISA_EXT_ARR(ZFHMIN),
>  		KVM_ISA_EXT_ARR(ZICBOM),
> @@ -559,6 +563,8 @@ static const char *isa_ext_single_id_to_str(__u64 reg_off)
>  		KVM_ISA_EXT_ARR(ZTSO),
>  		KVM_ISA_EXT_ARR(ZVBB),
>  		KVM_ISA_EXT_ARR(ZVBC),
> +		KVM_ISA_EXT_ARR(ZVFBFMIN),
> +		KVM_ISA_EXT_ARR(ZVFBFWMA),
>  		KVM_ISA_EXT_ARR(ZVFH),
>  		KVM_ISA_EXT_ARR(ZVFHMIN),
>  		KVM_ISA_EXT_ARR(ZVKB),
> @@ -1138,6 +1144,7 @@ KVM_ISA_EXT_SIMPLE_CONFIG(zcd, ZCD);
>  KVM_ISA_EXT_SIMPLE_CONFIG(zcf, ZCF);
>  KVM_ISA_EXT_SIMPLE_CONFIG(zcmop, ZCMOP);
>  KVM_ISA_EXT_SIMPLE_CONFIG(zfa, ZFA);
> +KVM_ISA_EXT_SIMPLE_CONFIG(zfbfmin, ZFBFMIN);
>  KVM_ISA_EXT_SIMPLE_CONFIG(zfh, ZFH);
>  KVM_ISA_EXT_SIMPLE_CONFIG(zfhmin, ZFHMIN);
>  KVM_ISA_EXT_SUBLIST_CONFIG(zicbom, ZICBOM);
> @@ -1162,6 +1169,8 @@ KVM_ISA_EXT_SIMPLE_CONFIG(zkt, ZKT);
>  KVM_ISA_EXT_SIMPLE_CONFIG(ztso, ZTSO);
>  KVM_ISA_EXT_SIMPLE_CONFIG(zvbb, ZVBB);
>  KVM_ISA_EXT_SIMPLE_CONFIG(zvbc, ZVBC);
> +KVM_ISA_EXT_SIMPLE_CONFIG(zvfbfmin, ZVFBFMIN);
> +KVM_ISA_EXT_SIMPLE_CONFIG(zvfbfwma, ZVFBFWMA);
>  KVM_ISA_EXT_SIMPLE_CONFIG(zvfh, ZVFH);
>  KVM_ISA_EXT_SIMPLE_CONFIG(zvfhmin, ZVFHMIN);
>  KVM_ISA_EXT_SIMPLE_CONFIG(zvkb, ZVKB);
> @@ -1213,6 +1222,7 @@ struct vcpu_reg_list *vcpu_configs[] = {
>  	&config_zcf,
>  	&config_zcmop,
>  	&config_zfa,
> +	&config_zfbfmin,
>  	&config_zfh,
>  	&config_zfhmin,
>  	&config_zicbom,
> @@ -1237,6 +1247,8 @@ struct vcpu_reg_list *vcpu_configs[] = {
>  	&config_ztso,
>  	&config_zvbb,
>  	&config_zvbc,
> +	&config_zvfbfmin,
> +	&config_zvfbfwma,
>  	&config_zvfh,
>  	&config_zvfhmin,
>  	&config_zvkb,
> -- 
> 2.34.1
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

