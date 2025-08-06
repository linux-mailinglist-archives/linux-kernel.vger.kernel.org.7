Return-Path: <linux-kernel+bounces-757589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 144F0B1C3F5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 11:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BB7718732E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 09:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F1628A718;
	Wed,  6 Aug 2025 09:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="JodVtdKs"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1582882CB
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 09:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754474354; cv=none; b=qC/C166ZxoRBIbYcQ/QJDaVfiTK4dMM57lWHMM629UepfbolXkUSnk0dPwqTmJ925W1JUd9UE54aSnajZYQLraHsENw+HezFxxswxaS3TTCAykiWKnTrUusrLxMhAcTodP/j1W3kBZ7aKXQ/u6lHEY+XNV7+InG54qDYHUk9njY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754474354; c=relaxed/simple;
	bh=IKb5uL5a/Yv1fqtDIHgQ8CxYzBv3w+4eE2yq1mQQMCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TIb/1yarJlotyu4bbAQQdmXuDI+fDmjrAw8bFDu5ByTWh8lVXD7h9BVnCmRXJmTJJ7Ad6t25I/x+CQv/G8JGi/krS0rqV7CBCm79gjS8DaVP5415GfIuaWzCY+dxz3EMe72qNU2t+vJSlSJb4uE0d3dxFWEJUGFMv1LFpT3Uc7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=JodVtdKs; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b3226307787so4114412a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 02:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1754474351; x=1755079151; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nVGDM3I4SAq4IdauxFBCdAq636kZPPhTHlfXhatdxwg=;
        b=JodVtdKsakt68yizrYENPkHCaH3/eKoTv0iLPGBcmALd3xSznwfqITVwSooAL5tYTk
         w7Wgssl02hmfqArrUqCZUqAoGvQ0Ijdd9HPn0VQjBdFEcL117a6gSr2aH+l0KtpVmKuF
         0Yu3x1xPmp5v8jpqY+nWy6XLZxaEiGJsYtgh5kQQLSnryYTZXbZGB5+o6Zo6KcYonx3B
         vGagya54iV1VXzwtGf4z1CQ8aBXOqpLuHHYGRxqjlhC3Y7jVxPyf6iAV3QoHlccBCEEm
         3ZTQnoQl+s8dVJECoS5vmqVFxfPKDf8kJRDrIb8VWukXjFT5tBJzitnHC3AeF/dDNl2r
         q75g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754474351; x=1755079151;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nVGDM3I4SAq4IdauxFBCdAq636kZPPhTHlfXhatdxwg=;
        b=syw/+WiMF3ROKrfHhFSfIz2dFADfg81nvFKl9rZi/eZNpVyG9yk2c/7N3XIH4urPN5
         xyMKsltmGKISPc6WT9b4BkjOiqsWyh2BFzHYtzB1rNuxMcplY2dCSz2MtUjSkLttwQg7
         KnXKdZRHSV1YfzNsOgzTKBh1upiuuBw2/lET4C61MICrzxEDD574Tp6RRx/Ad7h8tv6s
         GNBO+1UBzqrxMRJ5kldWbbN2fhJgXHHK4IeEFS+Y/OIdydTslstK4LEUMJXQii3/Mg78
         VxKE78m/WX9Kh4BljZD9jZG5tlJsrl4peIxFs0Qjrg1HoWqYDfm/NV5n6s5j9l7lPVoi
         hWXw==
X-Forwarded-Encrypted: i=1; AJvYcCXzaQ8/gavkQDoa+WQGUIZxtUWOcAKuVaXHe0CJaxbAkLFArUb3Syc7+ge27NxvJzfUvjSrXzNvegoGhAs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZsgbP4fNskCPGeROvDmgnb5+92upivqtKgvbuDC8+QOIzIZnw
	BGlUszIGua7qesfvxdFdvOornDsIt/WY1f0cCS8DHtClp+Ilc7UpGo7XiE27UN/+4Oc=
X-Gm-Gg: ASbGncsbjuSY7vFzRBFz+aqANKUBDMDB7jh20S1Xhwuig+TOd0axKySoaa/zwFP/BjZ
	uab0LhIg+VdVRN7FAjkXx++08L/ajuP7AQLQz/fOngDitGm3qAYwrXPW0ymZnv++y9qdI3WAlSH
	1hfxt4hQkzVUhPDzWDlNbKyQpREydHtA3vsEdOlpFaxmORn4xEf4HyPUi+Zte4nVtkDypUVhmWW
	QaqrFuamgFiQxz+82Y6LmAquhOQ1LWH175TfnZfcFfSInsOZpOMRilkdVShuRzfe8BuDjRNCeiq
	xXUh9kmOjmCq4eXnaGsHR34LwB6tWvRzXVM5oSC+EGfW23n83BaVrnmAqx3Q1IEyQQ2L7EaCAF6
	xKJ9LJ9Ycke63S+AYCkaTScVknWAzh9p9mX4=
X-Google-Smtp-Source: AGHT+IFDQkiy8dEal9JGcheFb4DCeMC/D2uxTEcourcA4xojZOo5yHWKjW3OBM8sYPB5X5rv1iZYAg==
X-Received: by 2002:a17:903:2302:b0:240:25f3:211b with SMTP id d9443c01a7336-242a0beacd1mr26147005ad.51.1754474351119;
        Wed, 06 Aug 2025 02:59:11 -0700 (PDT)
Received: from [192.168.68.110] ([177.170.244.6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8975c03sm154551605ad.97.2025.08.06.02.59.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 02:59:10 -0700 (PDT)
Message-ID: <953d2f4c-d82f-4e8f-a905-b7dfbf690ef7@ventanamicro.com>
Date: Wed, 6 Aug 2025 06:59:06 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RISC-V: KVM: fix stack overrun when loading vlenb
To: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>,
 kvm-riscv@lists.infradead.org
Cc: kvm@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, Anup Patel <anup@brainfault.org>,
 Atish Patra <atishp@atishpatra.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 stable@vger.kernel.org
References: <20250805104418.196023-4-rkrcmar@ventanamicro.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Content-Language: en-US
In-Reply-To: <20250805104418.196023-4-rkrcmar@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/5/25 7:44 AM, Radim Krčmář wrote:
> The userspace load can put up to 2048 bits into an xlen bit stack
> buffer.  We want only xlen bits, so check the size beforehand.
> 
> Fixes: 2fa290372dfe ("RISC-V: KVM: add 'vlenb' Vector CSR")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Radim Krčmář <rkrcmar@ventanamicro.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   arch/riscv/kvm/vcpu_vector.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/riscv/kvm/vcpu_vector.c b/arch/riscv/kvm/vcpu_vector.c
> index a5f88cb717f3..05f3cc2d8e31 100644
> --- a/arch/riscv/kvm/vcpu_vector.c
> +++ b/arch/riscv/kvm/vcpu_vector.c
> @@ -182,6 +182,8 @@ int kvm_riscv_vcpu_set_reg_vector(struct kvm_vcpu *vcpu,
>   		struct kvm_cpu_context *cntx = &vcpu->arch.guest_context;
>   		unsigned long reg_val;
>   
> +		if (reg_size != sizeof(reg_val))
> +			return -EINVAL;
>   		if (copy_from_user(&reg_val, uaddr, reg_size))
>   			return -EFAULT;
>   		if (reg_val != cntx->vector.vlenb)


