Return-Path: <linux-kernel+bounces-895867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D89C4F248
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 17:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 394274F47C4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B03393DD5;
	Tue, 11 Nov 2025 16:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iJB2KNJD";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="I7CzNzI/"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C547377EBE
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 16:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762880010; cv=none; b=tX7ftqNYBabZ02QT7CI6OuFhwky6m9hwfxY54BeNXUbN174sgDfkBk6HTde/qkuU41UDtLR5YYwCKm2iodjsGZt/7qiXTKMBtUsZuDo4h/hLmL3EOLo7pfNEpvZEPMCORjZFRhi9lIGUr5xg2svd6r2SLc6+1honk9jkFK5eD98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762880010; c=relaxed/simple;
	bh=SS0LZ3kWuX/E6hwB65fRvUu+pViB6WaWPy05xJu0hgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qg0r8mtSCZibmfdJNqL7nG9LrpSuIZ09ufFIVkqq14FpEjfPcBc7B2FpGoJuZpP4T7Ce6zB9DJMXOVbyuZVI6PQM/WWVyJzaFx9DeTKQvk2Ub2E2nmdCgC/kPQu4yoDo+WIvAtoctjp8pK4V5r87I5iKP7YfgAnjmE/i4wVec7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iJB2KNJD; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=I7CzNzI/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762880008;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Jv9tA8d7GDzG4uMgQEzEG6S975RuueXPPh6IjnESOqs=;
	b=iJB2KNJDjZKas9tWGhHoTtvF1pEfBQ4Y+1yAblzr0B9mw+ihWA+ms6m0I7M26n2Gaox0ZL
	LxNtvR0lS9hsNYaT+EscVentlIddbLH3PxcEAhush4KA+DcCXE+oZbCbhswHRDxvNec+MJ
	xAIB6mDc/a0G4pNUT2Kzd9Frh8vt5JI=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-bnEwcyi-NLmhSkmombiI8A-1; Tue, 11 Nov 2025 11:53:27 -0500
X-MC-Unique: bnEwcyi-NLmhSkmombiI8A-1
X-Mimecast-MFC-AGG-ID: bnEwcyi-NLmhSkmombiI8A_1762880006
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-b72de28c849so348140366b.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 08:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762880006; x=1763484806; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Jv9tA8d7GDzG4uMgQEzEG6S975RuueXPPh6IjnESOqs=;
        b=I7CzNzI/LVx8TR6964pA0QufkAXXCFWHq7dYm8HSPOWbWX1Cbx2uHhsrrbXYkkZ9i2
         schN4KYeeBNKsuI/7esSv9JGaMC7of1FN0eF4fpH33myPDE2CjgVDTVZqRG3zWsQVNr7
         FR8Tn33MVuJod+XQ835LHDLZa8FLNWpRepxg62GlwsutgAVTdAC0+claddXci4PgUJo3
         70xMKS622p2t1PlYahcJZXMCrGsChYMcqknbdTiWOS/mw5AjdSeYpJNgXnoY66HVkmzi
         76ojuo/FH0gA+jebFS3RvWeWms0XfmN1xA8z9qNjasQa+MZxoh/3P23eRHpvGPg0OEZU
         ra0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762880006; x=1763484806;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jv9tA8d7GDzG4uMgQEzEG6S975RuueXPPh6IjnESOqs=;
        b=EEqiWgKEIl2DQndFch7xf8SjeRdqKHz4cUqMoQF/YlcwQVaDA3BTJ8knG0SQRNET5/
         0bzNNOR8i8xoOXOVcK05XUtIe5MtaG56ilssHz/182PaHux3LTeCk3dRLp2vIJ8NGg0y
         1PBTNI8Z+Mjuzr0onn+MIuu5Gbx68PpypBsR5PIEgZoLM2ex/J9NoD94Sk3lv+syN2Ig
         VhnZEw2IDRMkeei3Xg3Z76recRZes5SSb2z51fnu9qMD3cPeeVowwfoTygTlkwHEm+tZ
         ZgWiIR9PCme2Ubaed4IStad5LLn7F7jye9Iy3t4++0pz+nTQb9lsxi9yCy1wqtMjJv7h
         jx9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUXvmFpjEeYcZP23oMbgvzI3J8gVMyaIgaP+7hN7ma8DsaEy8JQCRh+kK6BRdpg6sCe5J24aTtq6eXdS50=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdMdzVju59xF+v48fj/RxUODgfLNeaJklqI/CfaEK7CI3S9t7r
	ngc6P8n19+lpgJmZQkbEDIWepkvlM29RbKIhYIshdG2abQOgFlHikAp76yfpmqLq2eao5WzJfzv
	QppPn7Z42efaQxKVagbqDQIn7WE5e7ZkhHCMgRFvRocfxfbrHGPCz36cb6rDbys7vHg==
X-Gm-Gg: ASbGncv9T53t2R3/CjDlechts4YImKd7vsgR00JE9cy1Y5V8bdq5dwhT2imJMNYQaV0
	hHMz2Uhd/im9aLxaN1vmJg+zJ7bbIpggfe6lgI1hgozE4Wnu2uY8l6jJ/Zfo6mVWOqa4lpv04xJ
	fqiDRxdndazPUxqYkeAO+03bm9rV5G7f4UswjheQTKFW5A/8jAAWzuvskygBaqpUkXW7I+4gIy/
	UzNHIfoeALJ+SkQ0ZkRcNLJmg7+xx/LMsExqyxVMpuBkyT9BI9kVyaC/iHe/Gz61deErLdDnsDh
	vrRqME5SCDp4qy/5NYS6MTmdLb4N80x2kKWN0voyF5bDZR/JXmAJD0nkOBv3dl9cwbmU3rW7vhL
	pfn+47ylF2t+9TcUXSEaez8v6NhI70kpzNefnjNhe+IfENs6cjGX2jior2zSwrz4M8r86zCtFty
	/HVsJ0pg==
X-Received: by 2002:a17:907:2d8f:b0:b70:b13c:3622 with SMTP id a640c23a62f3a-b72e02d20acmr1307170766b.4.1762880005761;
        Tue, 11 Nov 2025 08:53:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHi5yK53r4gzdwr4cN+XIhmGedNSM+6slG564RO1Q+SEbGpJKZilfw72VaC5vPjhYR0V+gqJA==
X-Received: by 2002:a17:907:2d8f:b0:b70:b13c:3622 with SMTP id a640c23a62f3a-b72e02d20acmr1307167266b.4.1762880005311;
        Tue, 11 Nov 2025 08:53:25 -0800 (PST)
Received: from [192.168.10.81] ([176.206.111.214])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-b72bf97d430sm1451420666b.37.2025.11.11.08.53.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 08:53:23 -0800 (PST)
Message-ID: <1ebf3a23-5671-41c1-8daa-c83f2f105936@redhat.com>
Date: Tue, 11 Nov 2025 17:53:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v1 12/20] KVM: x86: Support REX2-extended register
 index in the decoder
To: "Chang S. Bae" <chang.seok.bae@intel.com>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: seanjc@google.com, chao.gao@intel.com, zhao1.liu@intel.com
References: <20251110180131.28264-1-chang.seok.bae@intel.com>
 <20251110180131.28264-13-chang.seok.bae@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20251110180131.28264-13-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/10/25 19:01, Chang S. Bae wrote:
> Update register index decoding to account for the additional bit fields
> introduced by the REX2 prefix.
> 
> Both ModR/M and opcode register decoding paths now consider the extended
> index bits (R4, X4, B4) in addition to the legacy REX bits (R3, X3, B3).
> 
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>

Replying here for both patches 10 and 12, because I think you can merge 
them in one, I'd prefer to avoid bitfields.

You only need a single enum:

enum {
	REX_B = 1,
	REX_X = 2,
	REX_R = 4,
	REX_W = 8,
	REX_M = 0x80,
};

for REX_W/REX_M you access them directly, while for RXB you go through a 
function:

static inline rex_get_rxb(u8 rex, u8 fld)
{
	BUILD_BUG_ON(!__builtin_constant_p(fld));
	BUILD_BUG_ON(fld != REX_B && fld != REX_X && fld != REX_R);

	rex >>= ffs(fld) - 1;	// bits 0+4
	return (rex & 1) + (rex & 0x10 ? 8 : 0);
}

>   	} else {
>   		reg = (ctxt->b & 7) |
> -		      (ctxt->rex.bits.b3 * BIT(3));
> +		      (ctxt->rex.bits.b3 * BIT(3)) |
> +		      (ctxt->rex.bits.b4 * BIT(4));

+		      rex_get_rxb(ctxt->rex, REX_B);

and likewise everywhere else.

>   	}
>   
>   	if (ctxt->d & Sse) {
> @@ -1124,9 +1125,12 @@ static int decode_modrm(struct x86_emulate_ctxt *ctxt,
>   	int rc = X86EMUL_CONTINUE;
>   	ulong modrm_ea = 0;
>   
> -	ctxt->modrm_reg = ctxt->rex.bits.r3 * BIT(3);
> -	index_reg       = ctxt->rex.bits.x3 * BIT(3);
> -	base_reg        = ctxt->rex.bits.b3 * BIT(3);
> +	ctxt->modrm_reg	= (ctxt->rex.bits.r3 * BIT(3)) |
> +			  (ctxt->rex.bits.r4 * BIT(4));
> +	index_reg	= (ctxt->rex.bits.x3 * BIT(3)) |
> +			  (ctxt->rex.bits.x4 * BIT(4));
> +	base_reg	= (ctxt->rex.bits.b3 * BIT(3)) |
> +			  (ctxt->rex.bits.b4 * BIT(4));
>   
>   	ctxt->modrm_mod = (ctxt->modrm & 0xc0) >> 6;
>   	ctxt->modrm_reg |= (ctxt->modrm & 0x38) >> 3;


