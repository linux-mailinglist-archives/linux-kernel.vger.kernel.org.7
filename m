Return-Path: <linux-kernel+bounces-886923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD5BC36B09
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 17:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 86F4234DB64
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 16:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1ED32ED57;
	Wed,  5 Nov 2025 16:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j/F0JTWb"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F1825E469
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 16:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762360114; cv=none; b=P/FGGh2p9pVcDEQaELTCBcX8bREpiSikeNkuA4kJN0rFd5YH1iBmH5ZVmyTGQ41L/8ZuaaK76SjmSkPR4Y2uIoPIlhTBNBhb48ePTisJvU5DNCRBLeq5bisnCGsyFy63dlRIk9c/laQvygsUoOhw3qit1bh4IAi8uaHM9W4Vpbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762360114; c=relaxed/simple;
	bh=aJ1f5V0uew9Za4nsW1MyDwJoEjJKM36x0hfHj12g8Ak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PMHaXLj+IW6ZIocYNnnOSNlz/TrBEq+KY2EFVa52oL81AVy/tk8zpOOF8O3qFdJliJD9eWJbHZGi14mljst/Q5PaCdNmutcnQJddUqwDIpIKSeHgk8joavFoZq1F2V2hTlfK7qxyx7kap9WUX+6ELMsFpezrzjlMBFNeL2/T5b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=j/F0JTWb; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b7260fc0f1aso327832166b.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 08:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762360111; x=1762964911; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tI1w+zRHNjqYgYKUw8eqjf6yQpSJ+H6WAlDRjf6NeDY=;
        b=j/F0JTWbqrHuHz6LJTbjXx7b4dVSDCaBdofPJBsUHdKCgfT63rha7QKOLh+jpWkdJa
         N7Zbo49aYpUr0H2KI7uYzUZCaP7l+go2kuSHdkduVVxgIKA/O754tDG8oskNFBZ4qvsu
         m11gAH7KmOEbIONpjaSdVcjvH5uu8b2Vum23ITuDGlCkhTPAJjnvpL2Yr0UKpubygod9
         36Fr2zxaxTB93GqkfRHh1vqRvD8Sd3TrSMdmUbHGQ69Cy11DkJ2ArkYZ0hjdAisxFRnW
         bR041+MeAu7AYzscYFwWvN1wbqKJCaj+euKWe2/N9UlL3PDUqet3zHKdkLZ7OJTFunP/
         5xqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762360111; x=1762964911;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tI1w+zRHNjqYgYKUw8eqjf6yQpSJ+H6WAlDRjf6NeDY=;
        b=SWMB7i+mYkU04HCCeCZep1ZBDmQ0z5rPOoCxb7eVEKnsEoYeHy3N0HR/3T1m7EMAHC
         o5XL79oabrQZVQdwTBkeAHsKFXWIhToT03ADR6VtLtv+Tf7rK6bQYRKz9dtc19n/5Fk/
         cMcfmVh2jsjKEItYoa9OTzsIs6XwIkg+XOvQG66/o+Qitc7VDi5eRogevrZsNGzBeFPg
         nPO+PWo84sVhundVsEbMixuBbpW/yEY2T61tMqheIdR1upYP6eSLqphrbQDKGfHcfZc7
         L5O8UjPu6LdM7pulWysrq0otkniArwH5Q9siYu8Zz0pWoY0nW0s2yE0c+KQZEVDAprk1
         Ki8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWQE4LzHY7x5zOxIl5ulEWZc+UnjIG3urwPnBKY+w4uf2AKV3nKbNNyJD6bALZ+e4RP982BjkRCI+3AIOc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx90OU0EJFdFmZtkHgS5JUCB0bpo8634YrES2C3Blk8FGmSrzC7
	ETjjkMJAtvvjijNFZV6nhld4jPhvwCLoH/F0x+e7kNajpkU2X/+uXbJQ+3iGsKRLGuU=
X-Gm-Gg: ASbGncvAJ/ndkD+WNrvC5egG/rLpGQIY/xkxdF5Yn25Ibj9DnCnvyQMJzOQhebOSgYx
	86A4ifFerMDg4EUcfw4SWT/NJB//FW+3/0XkBX+joupzOSTcSxSQHtp85mclzTFSC2If84dqca5
	BS4bge4YZhtYpGXqWmL/5gMp3rA4LYcMKNKguw7vCsLnSlC1MP3BtiCo/MVV4igIdJvVjOTZtU+
	xIxJw3zSmQPeQ1FShWX4kpmbRDozNQjT0oVx3KLC+RZ24IQK7Ezgvcdmw8kvbwLY35sau/uW2Ea
	DEIIYmijQI1LcVFeefyuN3YYJrcZCow8MNlupGh22AnZ35ywpg8+akUgBd5hwDQEK9Hd4M69bfY
	GzxMSmHnL+95noP44O+uheYhSH8Diij32GQ2dZHi3Wn4jRMEMAJ+CGMo0YuurmNvSjHxkrZYjbL
	TMglSblXUybB+U6ZrjA1vWfk0=
X-Google-Smtp-Source: AGHT+IHUIt7T9pXuVmpVYaL9XQ6GnLTYW2Usq+9EdzSRSWz7ihtMq4nQ0SqhbWd8MSLFCOpnH9FH5w==
X-Received: by 2002:a17:906:40d:b0:b72:6728:5bb1 with SMTP id a640c23a62f3a-b7267287f28mr269900866b.56.1762360111222;
        Wed, 05 Nov 2025 08:28:31 -0800 (PST)
Received: from [172.20.148.132] ([87.213.113.147])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723db0f1besm522399366b.31.2025.11.05.08.28.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 08:28:30 -0800 (PST)
Message-ID: <5680a2a8-aeb3-4274-a264-4ff658cc9246@linaro.org>
Date: Wed, 5 Nov 2025 17:28:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/28] mtd: spinand: Make use of the operation templates
 through SPINAND_OP()
To: Miquel Raynal <miquel.raynal@bootlin.com>, Mark Brown
 <broonie@kernel.org>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Steam Lin <STLin2@winbond.com>, Santhosh Kumar K <s-k6@ti.com>,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org
References: <20251031-winbond-v6-17-rc1-oddr-v1-0-be42de23ebf1@bootlin.com>
 <20251031-winbond-v6-17-rc1-oddr-v1-10-be42de23ebf1@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20251031-winbond-v6-17-rc1-oddr-v1-10-be42de23ebf1@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/31/25 6:26 PM, Miquel Raynal wrote:
> index 4afebaf5f0195b9bc617ea1f125f637f76fff9f8..a8fd04a67cfa9925bd68c57539d86e0816b76274 100644
> --- a/include/linux/mtd/spinand.h
> +++ b/include/linux/mtd/spinand.h
> @@ -701,6 +701,93 @@ struct spinand_device {
>  			     unsigned int retry_mode);
>  };
>  
> +static inline struct spi_mem_op

Do we still do inlines?

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

