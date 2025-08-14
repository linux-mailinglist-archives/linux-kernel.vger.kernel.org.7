Return-Path: <linux-kernel+bounces-768495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E8AB2619B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 11:56:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A43916F451
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E8C2F0C79;
	Thu, 14 Aug 2025 09:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r+tAfsZ7"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCC92F4A02
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 09:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755165070; cv=none; b=ahiqoucSAgJyUGBsnQT39xVOxJzDpZtD9uQS4h+vl0+DgRZnAjJ6J9juoOnxqfp+hqa1B24gBszmoI+EdU1UzIRLhCT+zKgyLn4bYTq9uPm/v0/STwbliU4Wu3fZalKgj+FaBXn7CbTsCk6S8Sf/wUjca/BOm78skNGDerDbfiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755165070; c=relaxed/simple;
	bh=hNkVqFUfumrBJ9kT7MtYHQKiLOezR4ltTNqHG5lHVyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TqN2AHK+2WI3jo1NGoMXaGwyN4RqKh3em20Hul8OYxMFPZUoCnar/NPi//ZM6rFE5KcRZNfRkcjY6fIPLB3gZYdRTLby+cVNDnHp6VaHFDdfIq5o1dSfzAHSoRbTq5EgkFMLXb3g+837C+bMWWX8eIyJWR5gzQVBtWqFWHTc8TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r+tAfsZ7; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45a1b0d231eso3900725e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 02:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755165067; x=1755769867; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yOQAy3COCQ4GmFM3WN3dte3+9U0UZAfDopK7YmF5fNQ=;
        b=r+tAfsZ7cB8UD/fjFkW9krW1vOqNYkKikMZ3/hCZhFw0vXC6knoVFx+LV589CrA/eF
         sSefibxQqdiVkem1zXceKbee5P87TmUvhRQXn/XTDwjG5Ej8Z8Szs7tvOHimIBE6AnM8
         saDeQ1FBcG3vOO724RPLv8ZJfij1Ht2cQ0cY+LYvcmTMaOm5XAKm6PrBrOifVO1aySwr
         mowZjxmZBOikgXyBTN82WvFD8HlMFmti9L2reErE8dVfVGtXr4LUjLLChoT7187dwp1T
         68du1JavubVo8Jhg+qwy5aeeMrtbeW+xmnMvogGr+wXz3/pp5opZBTwq7DweIBDkK8UA
         g3Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755165067; x=1755769867;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yOQAy3COCQ4GmFM3WN3dte3+9U0UZAfDopK7YmF5fNQ=;
        b=Hr02+7IjwEaPv8fqW5xUxRz28YycAgKBKuM4YpGRmqlJLxoQrJIW5aVcnt3rmfp8JD
         BtZGK7Fcl5jMC7dqJlYeP5+5WjDIJdAlAND50x0oAKsEYFc6lLzN6Avrle3EXbyRuN9i
         ASMUVy2uTZDUF7GceYVeNPnhC+bA6E/SeBVwo7PqZzEwf43aepcDW5wxDBdbGnVfBgf5
         H1+h96jjmhtZa9vb2Er/kq64xrNeVE6Oy8UTOsEW1WaHNjIJDajQe3VirnC43U3WsFS9
         AyJFx4Qe7nn1LoxmXvxP6AfRbBujc6sIfLuEISuvWgId9q5FswTtfahkv3u/o6A/Jig0
         3dig==
X-Forwarded-Encrypted: i=1; AJvYcCXhozRf7V/tiKI+BpUQuRRQZsy2+pOxVBi5rvI3g+dM+mE/HYa4In8dmULGm9l3J8j3TYnau/8P9nuSYkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyADvnoPpQ+wmXMmaJLQuUR1Ki3+aETKz2uT5kaGuXnNzqNr3Yc
	gKCyHxtnJJNAEDN76W8ajAR1+ihdVXsEIsc1ZF4h04lBOG5Ggx2Z6+h691mYAwDzF5Q=
X-Gm-Gg: ASbGncuskCi9s9euRzUTZBz5VYl0rXhGP2O81Ivq10eppaai9gzg4vS5PhcVAZK32Cx
	y/lBIcqo7I4osqyJXOS5/cIAnFW5Wu05buqFhuLFVxjZ7WVo1M1gE5QKyH1vwQW4gi7ALcgExdZ
	RqFpzGVHMRZsQNSmLVJ4kTksQ8U4GnnokcJ3JtwNYVwfNW/mv3aUDNLeKvhl8CdyisnZr3iVfud
	INb8V6x9LVAl8qXWXjE3wKjyJemzM1URCZU+y96I7OLpWVqiKmmgH0FyajdJa85CED5YTNXZqcQ
	ClNkuJJIqGY9OAIGn6cl3MmszHBkJVO+v2YYPXY/Dqz+VstDX3Ut1CwS5C13epRVXRifQI9zpq2
	tdxDWRH9gcM82iRN/BQaYFWYCy98UGX5h+wpmWQ==
X-Google-Smtp-Source: AGHT+IGdC4ogFMsxEXexf91ljpg6EYRn8qPLswcfjSbsTOXL/+XMzWhv4EVsfwYPweF3sDqMIP0pQg==
X-Received: by 2002:a05:600c:5489:b0:456:13b6:4b18 with SMTP id 5b1f17b1804b1-45a1b687593mr20783975e9.31.1755165066996;
        Thu, 14 Aug 2025 02:51:06 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8f8b1bc81sm28340566f8f.69.2025.08.14.02.51.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Aug 2025 02:51:06 -0700 (PDT)
Message-ID: <272077d5-12b1-4922-b924-a96c34b3b1c9@linaro.org>
Date: Thu, 14 Aug 2025 10:51:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] coresight-etm4x: Conditionally access register
 TRCEXTINSELR
To: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
Cc: kernel@oss.qualcomm.com, coresight@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Mike Leach
 <mike.leach@linaro.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>
References: <20250812-trcextinselr_issue-v2-1-e6eb121dfcf4@oss.qualcomm.com>
Content-Language: en-US
From: James Clark <james.clark@linaro.org>
In-Reply-To: <20250812-trcextinselr_issue-v2-1-e6eb121dfcf4@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/08/2025 9:24 am, Yuanfang Zhang wrote:
> The TRCEXTINSELR is only implemented if TRCIDR5.NUMEXTINSEL > 0.
> To avoid invalid accesses, introduce a check on numextinsel
> (derived from TRCIDR5[11:9]) before reading or writing to this register.
> 
> Fixes: f5bd523690d2 ("coresight: etm4x: Convert all register accesses")

This tag isn't right. Although this is where the register accesses were 
last touched, the root issue was present from the introduction of the 
driver.

> Signed-off-by: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
> ---
> Changes in v2:
> - Add fixes tag.
> - Replace "if (drvdata->nrseqstate)" with "if (drvdata->numextinsel)"
> - Link to v1: https://lore.kernel.org/r/20250811-trcextinselr_issue-v1-1-ed78f3215502@oss.qualcomm.com
> ---
>   drivers/hwtracing/coresight/coresight-etm4x-core.c | 11 ++++++++---
>   drivers/hwtracing/coresight/coresight-etm4x.h      |  2 ++
>   2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> index 42e5d37403addc6ec81f2e3184522d67d1677c04..4e411427303981104d11720d3c73af91030f8df3 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> @@ -528,7 +528,8 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
>   		etm4x_relaxed_write32(csa, config->seq_rst, TRCSEQRSTEVR);
>   		etm4x_relaxed_write32(csa, config->seq_state, TRCSEQSTR);
>   	}
> -	etm4x_relaxed_write32(csa, config->ext_inp, TRCEXTINSELR);
> +	if (drvdata->numextinsel)
> +		etm4x_relaxed_write32(csa, config->ext_inp, TRCEXTINSELR);
>   	for (i = 0; i < drvdata->nr_cntr; i++) {
>   		etm4x_relaxed_write32(csa, config->cntrldvr[i], TRCCNTRLDVRn(i));
>   		etm4x_relaxed_write32(csa, config->cntr_ctrl[i], TRCCNTCTLRn(i));
> @@ -1423,6 +1424,7 @@ static void etm4_init_arch_data(void *info)
>   	etmidr5 = etm4x_relaxed_read32(csa, TRCIDR5);
>   	/* NUMEXTIN, bits[8:0] number of external inputs implemented */
>   	drvdata->nr_ext_inp = FIELD_GET(TRCIDR5_NUMEXTIN_MASK, etmidr5);
> +	drvdata->numextinsel = FIELD_GET(TRCIDR5_NUMEXTINSEL_MASK, etmidr5);
>   	/* TRACEIDSIZE, bits[21:16] indicates the trace ID width */
>   	drvdata->trcid_size = FIELD_GET(TRCIDR5_TRACEIDSIZE_MASK, etmidr5);
>   	/* ATBTRIG, bit[22] implementation can support ATB triggers? */
> @@ -1852,7 +1854,9 @@ static int __etm4_cpu_save(struct etmv4_drvdata *drvdata)
>   		state->trcseqrstevr = etm4x_read32(csa, TRCSEQRSTEVR);
>   		state->trcseqstr = etm4x_read32(csa, TRCSEQSTR);
>   	}
> -	state->trcextinselr = etm4x_read32(csa, TRCEXTINSELR);
> +
> +	if (drvdata->numextinsel)
> +		state->trcextinselr = etm4x_read32(csa, TRCEXTINSELR);
>   
>   	for (i = 0; i < drvdata->nr_cntr; i++) {
>   		state->trccntrldvr[i] = etm4x_read32(csa, TRCCNTRLDVRn(i));
> @@ -1984,7 +1988,8 @@ static void __etm4_cpu_restore(struct etmv4_drvdata *drvdata)
>   		etm4x_relaxed_write32(csa, state->trcseqrstevr, TRCSEQRSTEVR);
>   		etm4x_relaxed_write32(csa, state->trcseqstr, TRCSEQSTR);
>   	}
> -	etm4x_relaxed_write32(csa, state->trcextinselr, TRCEXTINSELR);
> +	if (drvdata->numextinsel)
> +		etm4x_relaxed_write32(csa, state->trcextinselr, TRCEXTINSELR);
>   
>   	for (i = 0; i < drvdata->nr_cntr; i++) {
>   		etm4x_relaxed_write32(csa, state->trccntrldvr[i], TRCCNTRLDVRn(i));
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
> index ac649515054d905fa365203bd35f1d839b03292f..823914fefa90a36a328b652b0dc3828b9bddd990 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.h
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.h
> @@ -162,6 +162,7 @@
>   #define TRCIDR4_NUMVMIDC_MASK			GENMASK(31, 28)
>   
>   #define TRCIDR5_NUMEXTIN_MASK			GENMASK(8, 0)
> +#define TRCIDR5_NUMEXTINSEL_MASK               GENMASK(11, 9)
>   #define TRCIDR5_TRACEIDSIZE_MASK		GENMASK(21, 16)
>   #define TRCIDR5_ATBTRIG				BIT(22)
>   #define TRCIDR5_LPOVERRIDE			BIT(23)
> @@ -999,6 +1000,7 @@ struct etmv4_drvdata {
>   	u8				nr_cntr;
>   	u8				nr_ext_inp;
>   	u8				numcidc;
> +	u8				numextinsel;
>   	u8				numvmidc;
>   	u8				nrseqstate;
>   	u8				nr_event;
> 
> ---
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> change-id: 20250811-trcextinselr_issue-f267afa0e5ed
> 
> Best regards,


