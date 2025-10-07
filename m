Return-Path: <linux-kernel+bounces-844179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3427DBC13BB
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 13:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8CE0188C732
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 11:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5AC2D9EE7;
	Tue,  7 Oct 2025 11:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wo2smy7v"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AD62D46BB
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 11:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759837094; cv=none; b=IUzJrJyRAEgWC5CnJ87XADq1bZJlTSlzoNOqH7EA+/R5tEyuSXrpPgds9t8ypQ7YdoZGRHzx7KpXpcl4BbnmceI+vWn3MRyf5KociEaVbpsXEZEC4VjRLYpEWQWXNL66xS+UKlaYK+8NNn+C8s48rLgjwjOg8abEZ55sqE6cmz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759837094; c=relaxed/simple;
	bh=AR4v9eUGDhYNQtY1HeNc04PQ//e5S/yDedZGfJKBHh8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iayFvJ2dY4hoSOqqW6cDQxtZIllZHG6EYo1aG8yMTEOYqBRzg1FnLbIFbmEDMJVBTE6ByYXEuIftSHVxxmUjz3lj6VXyR9RIfF7C3vdkbeUFTev77kzzMDGa9ty35soctPGAWuTiiSUXmuxt+UO6t3vcdsGAyku4zYwVJgCpV5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wo2smy7v; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6318855a83fso12637485a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 04:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759837091; x=1760441891; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ml4LEpVTJVXyrvhWASdbj9I+fhI5yZyg6wx5UdWe8k8=;
        b=wo2smy7vYZrTD9Q0Cx5Z5mqKasYKeeG7J1IOXsE2sMUfSwXiUG0nWjZZlnx+bObFma
         zlaXZFdGKz1nvMMHzK3mksdabpzXNYx8V9Yy/hMtFpODdkE2/9n6wkOQDpxjOHeshYTB
         +iWFPXXsfUOgqErrgY8yftdbIQHi6RGjifvNhly7N8pLmY4WWz4YsxRBSr6/46HFXUdP
         9/BbPlqqxRxw4tTV8Zn+L21B8SBhxvQJGSz26cmr+2wsYo96DCRajLOUnvyQMYmhzjJR
         yD10lzALjZYAb1Ww/bcRenMCzWhmZTFj2gW2fJXTOVuGkh1wY8JbVddYljVxhzoDFwqt
         XBdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759837091; x=1760441891;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ml4LEpVTJVXyrvhWASdbj9I+fhI5yZyg6wx5UdWe8k8=;
        b=m7lxxxaPSvS3t28DaiUL5vTeMTBo62eC9LYa9wFfjpk5InlqlnyFAYPgmTxDz4Bvau
         EyIvPeYRzmKajABDeDXR9lzK6HbLFEiTIlrkuN5JKu2nCJ+FosAkdE1NOqsvpIsBPOu5
         x55Byzqbw2Q+wJz2eDeXWombtgk9nQaBN2Ed0uwDGqpz1M5HPOWEnjIPeK/TGHboCtkc
         69LGrZRY9Q4lxg6skf8kIyj6dJyF90MbsY4kxR1kGRMTcN78KgPm8CckpkG4MjNPuh55
         y+ohS0hf27Mt4d8UUxtGaZHzFZeZi7KB7TCFfa+4nktIOY34A0bkVXDfDj9k3NocDeKM
         gmYA==
X-Forwarded-Encrypted: i=1; AJvYcCWRNqS2R3ipb5swSlN1qMCliZpu/9QmmolCSeoB+FEpZ1UBNSaer4BEQUxYBuVvdjoi6SVrGOjJWwJWGFw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuOUGAofqY7TNsMjWuvrA7aJZNXzL0hJyyxzCa9j7yTNAC47az
	YgyVWdgJhw6HTnruMTxR3/7dUJuZoC41RDb73bL46wPTUYwMLhhbMcl1wdQWWMXvXTk=
X-Gm-Gg: ASbGncsbmPMsCMngDOAejg5Qv2jciumviDJd4+OUkhig3p6N7Cbba0nUY16NbLNYcWz
	xHoFs3+tGfj6IsCFJ1dV8M9N8JfsZANz/w9eIH6CckBUz/iilXVvYuD/15TlqVjzKVqS3u2dGVO
	vg1U2oXDLI87v9Wa9WB3Hqeg/K/KVtWosuaBsSQtVU+407hfHjJ2MN9gYnPzoyx/kSsKEKpOejg
	qmQsHjH64GhTzngygKQ+tlXVnD9zrzvWTPMGvidQrzRpumx4jpFRybJEdQMYJZgVIbXJgyWCjOb
	tzNsBTuny+TU4wcZaLLeqe1vBoE2KXnJ4hOm8MwMsb4aZNnrh227f7EWWEjZH6KEWK5f13BLjZF
	4cnzrgakwOECz9WtCgPYKXh3TtvLuRRl86qeNRHnOQUhm9Y+enWWXuq/uq39Mdcy1DojFqKlQKu
	AJv3mL4E0clFKG0ssj
X-Google-Smtp-Source: AGHT+IGRGfFEPmDIsh6CnYypDkCoLqPl3lzoN0Kez0PhVDQ7AyOqIyogj/xm1iA3ddUkIdKbeJyTsg==
X-Received: by 2002:a05:6402:27d4:b0:636:21b3:25a4 with SMTP id 4fb4d7f45d1cf-639348ddf20mr18989792a12.10.1759837091307;
        Tue, 07 Oct 2025 04:38:11 -0700 (PDT)
Received: from [192.168.0.19] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6376b3abcd7sm12224132a12.2.2025.10.07.04.38.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Oct 2025 04:38:10 -0700 (PDT)
Message-ID: <41899b79-7b12-4f94-a55a-7d365336a147@linaro.org>
Date: Tue, 7 Oct 2025 12:38:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] media: venus: prevent potential integer overflow in
 decide_core()
To: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>,
 Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
References: <gpZbbJubwhdMWqv7EprxhkTnwMAvvFs-qxjUEDxb-sji4H2XnPw8M02B6QLs7mrG_EXAgAjmhLVaMZfaVRoAKQ==@protonmail.internalid>
 <20251007103043.1969715-1-Pavel.Zhigulin@kaspersky.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <20251007103043.1969715-1-Pavel.Zhigulin@kaspersky.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07/10/2025 11:30, Pavel Zhigulin wrote:
> The function 'decide_core()' contains the following code:
> 
> 	cur_inst_load = load_per_instance(inst);
> 	cur_inst_load *= inst->clk_data.vpp_freq;
> 	...
> 	cur_inst_lp_load = load_per_instance(inst);
> 	cur_inst_lp_load *= inst->clk_data.low_power_freq;
> 
> This can lead to an integer overflow because the variables
> 'cur_inst_load' and 'cur_inst_lp_load' are of type u32.
> 
> The overflow can occur in the following scenario:
> 
>    1. The current FPS is 240 (VENUS_MAX_FPS constant).
>       The processed image frame has a resolution of 4096x4096 pixels.
>    2. According to 'codec_freq_data':
>         - 'inst->clk_data.low_power_freq' can be up to 320
>         - 'inst->clk_data.vpp_freq' can be up to 675
>       (see drivers/media/platform/qcom/venus/hfi_platform_v4.c
>        and drivers/media/platform/qcom/venus/hfi_platform_v6.c)
>    3. 'load_per_instance()' returns 15728640 under these conditions.
>    4. As a result:
>         cur_inst_load *= inst->clk_data.vpp_freq → 10616832000
>         cur_inst_lp_load *= inst->clk_data.low_power_freq → 5033164800
> 
> The proposed fix changes the type of these variables from u32 to u64
> to prevent overflow.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 3cfe5815ce0e ("media: venus: Enable low power setting for encoder")
> Signed-off-by: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>
> ---
> v2: Revert min_coreid and min_lp_coreid to u32 as
>      Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com> suggested
> 	during review
> v1: https://lore.kernel.org/all/20251006154041.1804800-1-Pavel.Zhigulin@kaspersky.com/
>   drivers/media/platform/qcom/venus/pm_helpers.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
> index f0269524ac70..eec49590e806 100644
> --- a/drivers/media/platform/qcom/venus/pm_helpers.c
> +++ b/drivers/media/platform/qcom/venus/pm_helpers.c
> @@ -582,9 +582,9 @@ static int move_core_to_power_save_mode(struct venus_core *core,
>   }
> 
>   static void
> -min_loaded_core(struct venus_inst *inst, u32 *min_coreid, u32 *min_load, bool low_power)
> +min_loaded_core(struct venus_inst *inst, u32 *min_coreid, u64 *min_load, bool low_power)
>   {
> -	u32 mbs_per_sec, load, core1_load = 0, core2_load = 0;
> +	u64 mbs_per_sec, load, core1_load = 0, core2_load = 0;
>   	u32 cores_max = core_num_max(inst);
>   	struct venus_core *core = inst->core;
>   	struct venus_inst *inst_pos;
> @@ -639,8 +639,9 @@ static int decide_core(struct venus_inst *inst)
>   {
>   	const u32 ptype = HFI_PROPERTY_CONFIG_VIDEOCORES_USAGE;
>   	struct venus_core *core = inst->core;
> -	u32 min_coreid, min_load, cur_inst_load;
> -	u32 min_lp_coreid, min_lp_load, cur_inst_lp_load;
> +	u32 min_coreid, min_lp_coreid;
> +	u64 min_load, cur_inst_load;
> +	u64 min_lp_load, cur_inst_lp_load;
>   	struct hfi_videocores_usage_type cu;
>   	unsigned long max_freq = ULONG_MAX;
>   	struct device *dev = core->dev;
> --
> 2.43.0
> 

Contingent on passing tests.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

