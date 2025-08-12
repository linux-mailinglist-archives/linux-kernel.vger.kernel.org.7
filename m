Return-Path: <linux-kernel+bounces-764458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE3BB22326
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 11:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D54D17A7097
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 09:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA48415853B;
	Tue, 12 Aug 2025 09:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y2sI2CJW"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADAB35961
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 09:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754991049; cv=none; b=jx9j8EZdMHKqC2NKxy+3DsLQm4tN+6AhNjqIlsFMbS+cp2irMUkXnifhCR6PJ+2dKhe6zIicso7c0KajtNAb2fHo0pb9Zv+daQgaBaYbGPrh9yMppcIhnF0c7R3z0NIn34upCxGwpaNtGS9qvhXi1y21DpdHBOq5VMG7KM0DOd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754991049; c=relaxed/simple;
	bh=1ctdnqPGqAyOWzxP/bcgrgyfAXOuONJDhAVdM5kTbbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CtN55Fobv72k7pthyJ/3zoZuxk5MMCXX5bqHY6QbKvfB7IULKw4rKANmErNEOLC/3JK1V4MtODy6p8Rfq5emyaB+g3qbOiKyyr1Wbtfsa5kJHX7ZH38R1n4xNq+s6pN9eBclDl4SeAyyCqH4hXk6aC4aluGcvJM96aGFi/f+fzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y2sI2CJW; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-459d4d7c745so47955925e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 02:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754991045; x=1755595845; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ApHNj7yZvO4jJFb6PrP/BJ1XkJPLeNWnc1hR3D0Tv4c=;
        b=y2sI2CJWKSj9U4U/UrVDz3PxH965DyDcXocWypCh9YDx6b2QsvBF5iA7oKBAj595dI
         38yYC/1D16G+OWfgybkVwShDBLEiwAZqqVD6pIZeMvMhF10IgrByuHc0vv/U0Ry5uWu8
         2rWrlYi1FCuzxKGYvlFmNvA+FccU+RgYrj9DDohe45SVum4iyMVGg3yP0B4aUWEp0OUI
         BrOdaG+bzmqzAGj+RlkwR1xEZSQbPCI7WRJGDJ9T0Tyxox+908CZHxWkCzgG8T1OTr/K
         moSSdS4smtyQ5MHb3RQQpWVvz5D4n6yrmzJsg3kFPQWodjUNGVxLyTs84kB6vX5N+Rfd
         Sm+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754991045; x=1755595845;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ApHNj7yZvO4jJFb6PrP/BJ1XkJPLeNWnc1hR3D0Tv4c=;
        b=pQB9dGPseGHDlpxWkuoi1SoECtoHtf2+e49mr2Wirhj6anTeJAJK/9QZcNPyIyz1bZ
         qgTRKmf8gAHfV6WcIiDPntqelwhVeUoeAgy7hB5iuDPGNErBmdJw2ZA56Qc8cXHFYZnj
         /f1ivIxbwqDrJ1caqc18FSEFA01iUFnnhL1A8gHF0XfX/niHClc5qbMKyfw8imw0nNj7
         U5J9xDyfAZ0z8uon3zBJ9MXbAiXun/vNurP2Q7WtnHclMJe+KJP28iBHeJ1uxWcTgNJa
         3rAGNml1ftlYfteB/48hog/+yxkiYMiyyDiGiOkiNm8g7m7VOmKXqEB/biVNr3l+n0Oj
         h/og==
X-Forwarded-Encrypted: i=1; AJvYcCUblrSdF+6bEnO1m2CWL66m/WyAqOwi2LPIhgkoJdJRI+zxJUYC5VchQICIDYRGdKxIMa2rQtRmGOaAvcA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+53YAiccT4nDW+89+a/rz+jPCEt1Iv7EDI/r52+3KnyMyTh5K
	m21dKajN+vSLdsjhleFQFrdPpMxspg4V8VTEP4DmGFhBAcE77Meq4AhG0XDE+45448tkZAztLxB
	KKHFTkQA=
X-Gm-Gg: ASbGncudrIX9pYujkqwkJ5eBtJY85KWiF9Qyn73sAt7MLaUd8hKfiZh9XeMmvsoP7Sq
	jYswcU+me8O3sSy6oeN3HX6SCP1HBvZxy7t/9RIOubPVbJBatI+MLzKXi0Ueyh9wGbUCW9eFrmZ
	aYIhUOIHCIkVleHKTmaE8QOtKvUZogYnID6TOh1qzmmLe9xLn+qap7ZmBkzKAmoE2kTQ+NwsG+F
	GnZgiFJILc7ZAVNJ0Tt02UFnKuxCfwtxm3m4iHm2ZxffC1YUR6+sPfj0ksP+XSm9EU/1dYUXlV0
	xNLzpuG2+W/WC1E5SJUsB/q5f4ZAP+VzgxupX3rZKseS/2udCWbgQF/RuZPS6/lNvwq1sQrg6YM
	BZxde+CRFhjI9Ek1AKfMhaWLXlaM=
X-Google-Smtp-Source: AGHT+IG43aUKBGp6GEVejGh0g6YqJDKDpg04fc0cvecZpxEcGicPXu5t5quNi7mcLCsCrydFcL/cxA==
X-Received: by 2002:a05:6000:3104:b0:3b7:9dc1:74a5 with SMTP id ffacd0b85a97d-3b900b80561mr10991013f8f.52.1754991045510;
        Tue, 12 Aug 2025 02:30:45 -0700 (PDT)
Received: from [192.168.1.3] ([185.48.76.109])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c47c516sm43931526f8f.62.2025.08.12.02.30.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Aug 2025 02:30:45 -0700 (PDT)
Message-ID: <c527e86c-916e-45bc-b469-8d5c94e980d2@linaro.org>
Date: Tue, 12 Aug 2025 10:30:44 +0100
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

Reviewed-by: James Clark <james.clark@linaro.org>



