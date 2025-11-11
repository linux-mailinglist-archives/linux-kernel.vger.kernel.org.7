Return-Path: <linux-kernel+bounces-894897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC59C4C672
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 09:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 541EC3A7083
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 08:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE0F23F42D;
	Tue, 11 Nov 2025 08:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="getPdOYm"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BBA26B760
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 08:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762849427; cv=none; b=gTSxxFevuvIxRCvgGj5AkQLCyRub9FyiQ6Yj2OsJ+D8iZnJTv83UJUlXUiQxNhOmIwiJWavCxUaTn+UkJu8I8AfSTJCK70e98wbLj6OO0WZGenWQ/CZlo7TqqPrYoADLXHYjx28zC5rWUwM6LBTlqE/andTGwdmOoLqcVmjJ6BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762849427; c=relaxed/simple;
	bh=luVHMTPb9Vpm1xLPxaeA+Qg3H0BOyiGfUY8Gp1p/Ydo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kZ4it5eOKCiTqpQtNOgHIb1kM/7EN3NwGN72hQa5F9TfSyeFYNrwxCICpllpun+5UNr9DWjZcZOBaNGLMfRIXJmwnTRXu65+VU7hMpid9gw6GNhTlTFwxTEDupTDIqMURaCS/ylE/INuHUPW37BVjI3kkSV+4pg6TSF5lwOSLJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=getPdOYm; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42b3720e58eso1947927f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 00:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762849424; x=1763454224; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1A/s7LNYfJ23Wps55qnqVv15lrsujszwGxWt6oo6eiM=;
        b=getPdOYm9vJ+nW1HYB5LjDobtdfuzhVHNcK0sdXSFMABTB/OnoSuzo9jyr1fLYT+rH
         +eo/qx9oVEOxII7GsZliyWlRWJ1QrVrMzQMh3u/cyb+/kZ/uaeumGXW7hMyhCHGrUVNU
         ArQtXRZD5IygSdeNlKlgi1Ih6RR0+jWsuztkBcqhehhMGCKj9kFhEB46aWJLrulxajkv
         r08OElMXeNixSqIqRaRl/PuStqNqMMeOZh+9jd9sSiAdc9WSgnaqMXY7HksbVLSZATrs
         rtPy1QUAHeL49pI5W2kLQA7AhRnHrUL/7ivzfJLtuKwrD9Yrdu5FE93bCrJuGRwPqITt
         zrPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762849424; x=1763454224;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1A/s7LNYfJ23Wps55qnqVv15lrsujszwGxWt6oo6eiM=;
        b=bQZ7bzApyyZjP1nrVzzHeBM5I9HTtTlV/wdUAq10eunIWF08EyOu8bRUFNgzJUyeRM
         G6+YgInRcJbRljq5fv3Y/9XZ8CSI+MqtTbGQoYBp4ewIsXCkcgxTO97sxHCW3De+IAO2
         BnppEa44ei5xWuqc5V6FW9X8mxqao8lTz+SCMQIE7ccRowxfA9jnVw20Z6G3oyWFVeSk
         20CvKLfLOVsPvK6Vbx67EaqczpxBWqfL4ZbV7ZM7DOrsoe9WwxLMTxJ1rf/iSX33v64y
         JJFxbomuW8ZBMo2A41UozCRrp/3DeYiRnQVvaOLupb2YA5ecyFRicCqGa/Uo2Qh6h2+x
         rW5A==
X-Forwarded-Encrypted: i=1; AJvYcCUGzw6ULO31PEww0jBzo7jD4dyNb8YcBsaXaWuMAO6Re1wptncmPsOIokcE6jlWknDzO4KF94GUYnjVT70=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx96QzSKTAdu3YH2XdeACshqVZ1VUA/KE3tHJ4swPtqbQeX8Vr4
	52F3KHmvK0VEMBh1kJ3ZjFr0RWs9urLyoAQAFAeHdbebR7rmD/qSWMkJLbR8B40zFRU=
X-Gm-Gg: ASbGncvs05Dx7gImzPjioWSeXcWMEAtFEScUBaZ7d0EqovR90fvoD2U2+W42vwowkk2
	2cl0dKfsnUXxq3jYJkCiN1FSvgbM6oRkYd+jCd/VQ+aD62/MjqLLT+cqtpI1PgqOvk9yjkwbtsN
	gcFmV7u3FzVD6uDTztV0XTu10fbxuPrqBv3qAEykl2QeNh6/lXEz0n14CelZzElA/mYyI91DdMi
	ACtC4+OjCksF02EtdTwHj2GOyTUr2Fg8M8TToDDgQLIlAxOVsx3TEzmedM3Mz7ibwFJ92MSr2zw
	UqnuxqTpnT+Ke/V5UyQBcyBA8Lu/i6i7sO2/Pe+58j+hxs/7OkjOIwpfZUin3h9Iv2niKNnHSiU
	Yj4Nw46q2GRPuS1kccv18+tZK6JJXG4/NN6nv4G+MbC+C0e3MjJisyL9Mk6qytW32BkqR+1H4Wm
	GXm36Nqg==
X-Google-Smtp-Source: AGHT+IGcFfxooTzh9xp8g3qMI+6yiTxMXMVuORbnPO/aK2mPEX+2okAsm7MZP8Iv/tFdfF65sQ80Tw==
X-Received: by 2002:a05:6000:4107:b0:42b:2a41:f3d with SMTP id ffacd0b85a97d-42b2dc2d0cbmr8067270f8f.19.1762849423687;
        Tue, 11 Nov 2025 00:23:43 -0800 (PST)
Received: from [10.11.12.107] ([5.12.85.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b314dae4bsm17131179f8f.34.2025.11.11.00.23.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Nov 2025 00:23:43 -0800 (PST)
Message-ID: <afe767f4-6534-40d7-b4c2-f4bf16cb74e3@linaro.org>
Date: Tue, 11 Nov 2025 10:23:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] mtd: spi-nor: micron-st: add mt35xu01gbba support
To: Bough Chen <haibo.chen@nxp.com>, Pratyush Yadav <pratyush@kernel.org>,
 Michael Walle <mwalle@kernel.org>, Miquel Raynal
 <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>
References: <20251110-nor-v1-0-cde50c81db05@nxp.com>
 <20251110-nor-v1-3-cde50c81db05@nxp.com>
 <b046d19f-6e55-47db-b7a8-6c8766da2e7f@linaro.org>
 <DU0PR04MB949675657F9A4C52A0C5E19B90CFA@DU0PR04MB9496.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <DU0PR04MB949675657F9A4C52A0C5E19B90CFA@DU0PR04MB9496.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

did you use html format when replying? Use plaintext, please.

On 11/11/25 9:54 AM, Bough Chen wrote:
>>> +		.size = SZ_128M,
> I did consider to remove the size and other flags since SFDP can handle that, but if remove the .size here.
> Micron spi-nor do not have a chance to execute
> 
> params->set_octal_dtr = micron_st_nor_set_octal_dtr;
> 
> because in micron-st, params->set_octal_dtr is defined in flash_info->fixups-> default_init.
> And flash_info->fixups-> default_init can only be called in spi_nor_init_params_deprecated-> spi_nor_manufacturer_init_params
> If no .size define in flash_info, spi_nor_needs_sfdp() will return true, no chance to call spi_nor_init_params_deprecated.
> 
> If need to remove the .size here, seems to move the params->set_octal_dtr to spi_nor_manufacturer-> fixups-> late_init or flash_info->fixups->late_init.
> 
> I notice macronix already did like that, I will add this change in the next version.

Yes, move that to late_int(). We'd like to remove default_init()
if possible.

Cheers,
ta

