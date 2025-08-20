Return-Path: <linux-kernel+bounces-778098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AA5B2E143
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 17:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D7207ACF4B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 15:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB05219A81;
	Wed, 20 Aug 2025 15:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FQW1/BmR"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D0D1F7569
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 15:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755704160; cv=none; b=GCBKOVkUjdFBmTlcm8GtaqGCcgMzDjnQtye30mqQ7fddm8ZAJ/XmWn/dIpPfO9+zl/35IlXdw3ee65nwI8gWXjTwM8AkMtcCBMqW1uZYdkAsGhVS6B0u78udYgX7MNPC3Ue6X+gqCf15fvTFZbKulBSE3oDMJNDPBfSbTLNA1Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755704160; c=relaxed/simple;
	bh=qZ0Liw116b9dqT6od+97JFalrbcdJYbs5ia5YF/b9cc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BnV7+1DoT87AQLNOxR1va48/Jv6SIby1AqYjMH5ArJOMeS5HBQzwytbUp66d3Jr9IH+Ej88ydkWIBYMVkx7oGrXljhuJ1j3HyGtQPX5BmZfgKu90ax+16JB4fJG9c4OISk5nr0FO7qkzyPY9NZukvQxS/vyiFNC+ItxIRFzKWRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FQW1/BmR; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b9e413a219so33360f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 08:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755704156; x=1756308956; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=OTa/QPkNlRX3mzpJj84n72L7T+hYHVorhJwqGFrj64Y=;
        b=FQW1/BmRXwop5OwC0QohuUnnfBKbfWFXAHzgu+SxvM126tsl1KNDZtgcVHBN6xiWAy
         na0Rt38RzFsIXn/9OPopV3O5YkwXoXc1EfGnfntxFpaYkRhUKNqf8/c1RQmXYmpb3vEF
         hH9WnCTw/5+30dyx6dagum5AtNzOdD2p8wWJVmXsg6rl7lyKiYq02/zJOkMVX3LFBtF2
         YouTIxyrzCrsUT05FTb1x41YBMB6Aqx75C2165Ow5qUeUSetHk0RhjQb/2P0hID0/ieB
         Se3MGrlA+D8z7vWn8vT+/n7NsCcQu9we1hAqprVtXyRmXxVkouv7uXggVAIZ7wfpLK78
         Eylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755704156; x=1756308956;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OTa/QPkNlRX3mzpJj84n72L7T+hYHVorhJwqGFrj64Y=;
        b=C+cfLvNaXQvqLj51sWIPLe8rGrMsYHcZxBvbWo+ajMc3cA45AeFj+LNHhLBoWzneGi
         yLmQHpj9gc/qCwAHRv7g+OUb+hN2Xu2as7D+XsKZLfgNOZa1G7u9W0BVOP+YV/JA1KBi
         KzmNzouqyWb57/ZQ6i2bU+bIgujSdyv49d09LcP2Eb9vS1/XxS+QA3VRB+2eIvi1B/GL
         hLgBR+HKq/dQArGBpP6EmmW/3OeDJ4MAHAwcbVywzKGxdeWxyIRqjpBKPtyO5EFXd07m
         CMuBe4sofZBlVPWZSp4xMFkzQ699BoF2e/FS1Can/mAXDsXOCzwWm5BJGtog+ovXi60k
         LM5A==
X-Forwarded-Encrypted: i=1; AJvYcCU4oxU7OlqOtTzdf0nyOgo9H/Z27e5vaIrhDjcapQcMM2nh+bMzXedxEG60PZ9tGCSsS7P4cvATDaGE/dA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+V0g96ek6FJYQ8siWoYnrdmjYizurMGa8B2Z8WAHA7dF0rTyT
	HthgDt6R+tKtRzcf3pRQ5LE7gP3su7yOBTcwWWNKobslr/hV2qsDRjPr8Za1MXM9I/Q=
X-Gm-Gg: ASbGncuL1eWgRtvA8kaqRZewPOT8sLEbwMv88RJN/sC3YtlJFcZc13fYFN45rhj8+FW
	xvXwuwK2grxMqqWVsUdwMDKPDKyzy5qMEBmqHLBQ0+fxpLVUaI0Af3rdftbKb0GN0QGUo293LZg
	hXVVSuEgGVmDh6oBhMFL4k2VepCDcqKxp8uetBM20BcM2MZ1GfsAQQa5iMVNAwhHkb/V2oNRGCy
	89cVONjWRD1OT+/fdqFJ+EHEhxRT/GPwrwcT8375/av3AXc6aBkWmkK8Svf4G9OU4BFmouGl+Gt
	NKjdVhXqrNNxqBrp9oQhmUfl6+1qLgFbHbmDPfZwMxQ6RWGIWKm8a7NJsAOe9J/TgCx/suOFXcC
	H2vChfaUaTCBJu5oMDmCnWUhH6wKncs48hZ/SqDuCofRiTA==
X-Google-Smtp-Source: AGHT+IExRdAG83Kv3rFioG6BTDRf7b1tbjn7zmhnCP/Jssfrr5kDls3sY5zK7tsqiTwgHqLUr5m41w==
X-Received: by 2002:a05:6000:24c9:b0:3b8:d69b:93b with SMTP id ffacd0b85a97d-3c32ecce485mr2198511f8f.52.1755704156103;
        Wed, 20 Aug 2025 08:35:56 -0700 (PDT)
Received: from [10.20.0.214] (ivokam.ddns.nbis.net. [109.121.139.111])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c0771c166bsm8233775f8f.33.2025.08.20.08.35.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 08:35:55 -0700 (PDT)
Message-ID: <6e5503b9-bc5b-4147-836f-8f86f2ac8124@suse.com>
Date: Wed, 20 Aug 2025 18:35:51 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -v1 2/2] x86/microcode: Add microcode loader debugging
 functionality
To: Borislav Petkov <bp@kernel.org>, X86 ML <x86@kernel.org>
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>,
 Sohil Mehta <sohil.mehta@intel.com>, LKML <linux-kernel@vger.kernel.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>
References: <20250820135043.19048-1-bp@kernel.org>
 <20250820135043.19048-3-bp@kernel.org>
From: Nikolay Borisov <nik.borisov@suse.com>
Content-Language: en-US
Autocrypt: addr=nik.borisov@suse.com; keydata=
 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
In-Reply-To: <20250820135043.19048-3-bp@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 20.08.25 г. 16:50 ч., Borislav Petkov wrote:
> From: "Borislav Petkov (AMD)" <bp@alien8.de>
> 
> Instead of adding ad-hoc debugging glue to the microcode loader each
> time I need it, add debugging functionality which is not built by
> default and when built-in, off by default so that it can only be enabled
> explicitly on the command line.
> 
> Simulate all patch handling the loader does except the actual loading of
> the microcode patch into the hw.
> 
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> ---
>   .../admin-guide/kernel-parameters.txt         |  6 ++
>   arch/x86/Kconfig                              | 12 +++
>   arch/x86/kernel/cpu/microcode/amd.c           | 88 ++++++++++++++-----
>   arch/x86/kernel/cpu/microcode/core.c          | 25 +++++-
>   arch/x86/kernel/cpu/microcode/internal.h      | 10 +++
>   5 files changed, 118 insertions(+), 23 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 9e3bbce6583f..e7badf2aba63 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3770,6 +3770,12 @@
>   	microcode=      [X86] Control the behavior of the microcode loader.
>   	                Available options, comma separated:
>   
> +			base_rev=X - with <X> with format: <u32>
> +			Set the base microcode revision of each thread when in
> +			debug mode.
> +
> +			dbg: enable debugging mode when run in a guest

nit: s/in a guest// since nothing in the debug code is really dependent 
on whether it's run as a guest or not.
> +
>   			dis_ucode_ldr: disable the microcode loader
>   
>   			force_minrev:
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index aa250d90f927..77f72f075d89 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1360,6 +1360,18 @@ config MICROCODE_LATE_FORCE_MINREV
>   
>   	  If unsure say Y.
>   
> +config MICROCODE_DBG
> +	bool "Enable microcode loader debugging"
> +	default n
> +	depends on MICROCODE
> +	help
> +	  Enable code which allows for debugging the microcode loader in
> +	  a guest. Meaning the patch loading is simulated but everything else

dito, AFAICS it's perfectly fine to have the debug output if not run in 
a guest, no ?
> +	  related to patch parsing and handling is done as on baremetal with
> +	  the purpose of debugging solely the software side of things.
> +
> +	  You almost certainly want to say n here.
> +
>   config X86_MSR
>   	tristate "/dev/cpu/*/msr - Model-specific register support"
>   	help


<snip>


