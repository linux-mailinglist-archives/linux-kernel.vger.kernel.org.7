Return-Path: <linux-kernel+bounces-805428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B81B4886C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:29:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A95AC3B6F3E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 09:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2142F0689;
	Mon,  8 Sep 2025 09:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3PtvkYP"
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1BF2F1FFB
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 09:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757323713; cv=none; b=c5s5p9F7jwfGlNZiCy4W8I+W0Gjz/rHc49+2MMQKmtGnz9x6XvtTfN03Slm58j7u/31+iWtf7m4SpVJ4uZTMQUwucqKWah7nn7Eii2E4hCsluCgMdcy2DLDstmJy4mVmjPSk4B7xkOVQh6RIx056Fc1uAi3rNxxTHuP3WJhAAHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757323713; c=relaxed/simple;
	bh=8UwGtijbNmep8IlKNziHhoVscnj9O1J7bOmzYtqxc+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NnQlvnFERlMDc/jwcW3LVLgNNK2DgnQ2UVT5Pl90+PFRrF6Zc4+9K7EhvEtapW5QySOJ0ptdSWsR876YV8jpieaFeWpy0x3DQ68KuwyygCNCv27z5a7ZBCsBs5UUcBd5bHEvCObHldcPOmj+3Wy/xamFUQNFhSlwpSJw71Wccp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L3PtvkYP; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b49b56a3f27so2505702a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 02:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757323712; x=1757928512; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1aIO/Jc9gNb+dffbLCO11wsfc76FxYTcfSF7E2zqgos=;
        b=L3PtvkYP3js5eBHf6pETweGts9rj0Ak+Pu+5omOAOalyx1eUVIJuXpV7NxaXNl/YTi
         6c7lHVXwTWUryfNn4TpoLp6UgloVI7WD1U5rA4LlsZlLt0qCasX4FoByr7bOeQN7TODQ
         vmlxxr/Fs0GV292t9Jm8Qyl8bjMM2J+Wto3AI4SRSTPgumbXEiP4a9IlOsgMJX/3som5
         avlpMBT4KHR8sjZw/mbmC0DIjYF1vZzWyvVGlZ5REJdPx7utrpN9rRCnE5EP0rDh3FOb
         Sjl8uR3PQaBBLe+3WEn7Yrf6Yj64lOi7JsOgSpi48yH2K4MckYc9DUgZrKA+EWWsIWql
         yoAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757323712; x=1757928512;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1aIO/Jc9gNb+dffbLCO11wsfc76FxYTcfSF7E2zqgos=;
        b=e45OsaiwV2bqNoMD2WDc9TeQep7Bvjw8Fvqb/V9rLOkuiGopX/nx22cly7wYE0Sxot
         N5JYWzJyo7VgTV3LMl7/J911w4dbXzsv4BkvnRq3za0kz0XOl0byuBQVinNb6V46emGd
         gTyzlDCHogsYHQIGhua6/5n/a6WdJMQ5u42plkTSTO41w9QFTNCRhFV2Lrj9wxo8p4AW
         VKkuS5tUx5UtbOPakWQVcGJZOpyg1MLpGq1h3FhEsw9yjCvjVwdiI459wAi7ZepORCD9
         qqa/CxIFC8KO1aYxyzV4W1OgivN+pHRax8ZHZWfiGKGWF2YBlqEpeYYUvcWaoU07yhfa
         0yVw==
X-Forwarded-Encrypted: i=1; AJvYcCUFANtDMPeH1mWQOjVLjbsvJHHD8o+O4JlcZPJdFPY5FMjb+eNXe4cjOO7wLPOpT40JaIWXlWtAZpI32xk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBgTRD0Cfo66UcOKkaUnlo7Je5gUKC7vDOnKOA28Vs1y2Ss21s
	KROG4cDJXXNTNeLY46j9HCULIMJl4LJuyQ2s+mqlkMnBEzn75hzaEry/cMJ2Mw==
X-Gm-Gg: ASbGncsK50FtC82e4Jpl1L0tbRaWnGarF+Y6p4uEJBzXbVhs3rhpAMqPg5kMhDpNTNQ
	kD/C82wN46zKzlfSFRe+9L+suLJQkuK6hgLgszu+hi1z4u4LhEQDCAMo6Lsi5aVVn3DVTrBSwyc
	nabtBiZN9VpkyVnLBcvDr3rAdMQ3jdN4KfSbF5tX/UEkww/FcYHKxHHRn1WFzCBVzuER2tnrnBY
	BaBJOFCrzcer+kiQ0995sHfBCoC0vUvlZijMdw8HltzE3wXoAUq42nbjoUrAjPdultV7eMPFAjh
	jqYD/yYqa8mKKayuwUv26Eg8K019joO9QqAF+HaujPEQS2Fmxgdu4Gqsmb4MafQeDkIXtq+TkU3
	6j4nAnJAciBmlrdMT+y2CsiOB8rGwpK1PzFH8iRC3xBIbWf4hZcsqXb6EjVmdzUUdeIDHG823
X-Google-Smtp-Source: AGHT+IEXLmGTm7mVbd9WymfKCr5IMKeWD2CbkcCLjMtCRO58i9jj5tdNIyt6wYAt2uN9AQbVTvai8Q==
X-Received: by 2002:a05:6a21:339b:b0:250:429b:9e6c with SMTP id adf61e73a8af0-25344dc4b0cmr11777361637.40.1757323711541;
        Mon, 08 Sep 2025 02:28:31 -0700 (PDT)
Received: from [192.168.0.5] (KD106168128197.ppp-bb.dion.ne.jp. [106.168.128.197])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b5207352e9csm8326243a12.48.2025.09.08.02.28.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Sep 2025 02:28:31 -0700 (PDT)
Message-ID: <73bd7d59-0029-480c-b1a8-ec5ad5b16553@gmail.com>
Date: Mon, 8 Sep 2025 18:28:26 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mtd: spi-nor: spansion: Modify addr_mode_nbytes for DTR
 mode
To: Santhosh Kumar K <s-k6@ti.com>, miquel.raynal@bootlin.com,
 richard@nod.at, vigneshr@ti.com, tudor.ambarus@linaro.org,
 pratyush@kernel.org, mwalle@kernel.org
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
 praneeth@ti.com, p-mantena@ti.com, a-dutta@ti.com, u-kumar1@ti.com
References: <20250904131309.3095165-1-s-k6@ti.com>
Content-Language: en-US
From: Takahiro Kuwano <tkuw584924@gmail.com>
In-Reply-To: <20250904131309.3095165-1-s-k6@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/4/2025 10:13 PM, Santhosh Kumar K wrote:
> The nor->params->addr_mode_nbytes parameter defines the address byte
> count for the current addressing mode. When transitioning between SDR
> and DDR modes, this parameter must be properly updated to maintain the
> correct addressing behavior. So, implement the necessary updates to
> nor->params->addr_mode_nbytes during both DDR mode enablement and
> disablement operations to ensure address byte counts remain consistent
> with the active transfer mode.
> 
The address byte count for the current addressing mode is defined as
params->addr_nbytes. The params->addr_mode_nbytes tracks flash's internal
addressing mode and is not used in octal DDR mode.

> Signed-off-by: Santhosh Kumar K <s-k6@ti.com>
> ---
> 
> Tested on TI's AM62x SK
> Logs: https://gist.github.com/santhosh21/8d69756bd54605d79086b00850e1083a
> 
> ---
>  drivers/mtd/spi-nor/spansion.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/mtd/spi-nor/spansion.c b/drivers/mtd/spi-nor/spansion.c
> index a0296c871634..678f7f4052c9 100644
> --- a/drivers/mtd/spi-nor/spansion.c
> +++ b/drivers/mtd/spi-nor/spansion.c
> @@ -230,6 +230,8 @@ static int cypress_nor_octal_dtr_en(struct spi_nor *nor)
>  			return ret;
>  	}
>  
> +	nor->params->addr_mode_nbytes = 4;
> +
Are there any problems if we don't do this?

>  	/* Read flash ID to make sure the switch was successful. */
>  	ret = spi_nor_read_id(nor, nor->addr_nbytes, 3, buf,
>  			      SNOR_PROTO_8_8_8_DTR);
> @@ -275,6 +277,8 @@ static int cypress_nor_octal_dtr_dis(struct spi_nor *nor)
>  			return ret;
>  	}
>  
> +	nor->params->addr_mode_nbytes = 3;
> +
This doesn't work in case flash's internal address mode is 4.

>  	/* Read flash ID to make sure the switch was successful. */
>  	ret = spi_nor_read_id(nor, 0, 0, buf, SNOR_PROTO_1_1_1);
>  	if (ret) {

Thanks,
Takahiro


