Return-Path: <linux-kernel+bounces-886754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D31A1C3677A
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 16:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 732911A40A90
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 15:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7F2262FD3;
	Wed,  5 Nov 2025 15:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Az15c20r"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872B9257827
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 15:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762356916; cv=none; b=WLUe5t89by7KATbmADalyLK0IkBo+7aykxAYBRzSJQCKqykxtxGCTS2SUnqcBCVWXXqGmPEcu6rWzDwU1XX8bng/tM670TDhQLyt//w8vl/bnmLcLgLJxX5K6RT5LUQoYHbhdpZTfLct1L1CnEfEL48kJRbQYdEBZkvWZwYpT0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762356916; c=relaxed/simple;
	bh=gczMRuZ2fsGRpoCXUBhl7NeVLE82+ehtyW2OQrB7AVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fe3hD+5akHq1yB2UqHjpWnA6Gk2U+H0/K3bSO5rgwOW4ZKET+HwAs/v9K1vcezng8KsJc7ALlpjx3bcHKjpwZL1IkeIRfV4Xg/uyuKAjdsZgx5VSP/hqVNhMu5B7DoqK1imvxynnwgy28lrwEBDJNbM//ffhaXAu8um6tKYSrsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Az15c20r; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b4f323cf89bso479842566b.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 07:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762356912; x=1762961712; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gczMRuZ2fsGRpoCXUBhl7NeVLE82+ehtyW2OQrB7AVI=;
        b=Az15c20rSkoYvwPxvUVQJIrbQfSVMngmjoA/m25zigW1HKN79DAG4lMJSTpaq0dgMY
         OSRboyigHLIEhKdN9YpeAvM01bojHSnCRWp3MTzKXw29F/GUwd7kW7Gczp6PsgvsjWkh
         AN6FBuJrQhyEoHJNpNizQEWzBJQ9z3O5Vd1F44BUoZhAD92vEUMHGRg3GMx9b9mZPD+q
         8mb7nV1YF1nLX99iun0aPtT9xAXs8CIUcpNT5lxa7QNOBhuaAt0Cfu0vcZpcN6iJerLG
         b3JwJ7lgFVUwgsiOJluTjexeuA3WfSz7hS5yTnLQEUaYqDug0LQymyQ6qGRXyQGvT4ll
         AKsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762356912; x=1762961712;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gczMRuZ2fsGRpoCXUBhl7NeVLE82+ehtyW2OQrB7AVI=;
        b=cb0LwNbd5lAyP4TyY7ZHlT1jkRx53UeRoBUGDSLjHVgB9L2mKsWbcGhByrf5ONMrer
         Lk7T2y59pSHtwUlFkTLJxeIAVUVObmWWETYYkfqsdbiefcRxHUXNFBrBE9g9QgkB8ICQ
         Z4maaiVLa+2BXp2zAalcuU9LfglBgZkTw8yk+h7YraCk4OedK5dHfBH2VRDZ/yA8Fvc9
         kMa+iRkpz3/9MMIC7ox6R5gD2LNUY6yKA4eSdrGLuSu52jO4KurDszcn1i4e8I2aFonH
         M9OniA/NPneH0NMmg2j9eeP+9tw/G8uAy6LKkk1Kme4DzdpWhvuCuP9XgBGTksuj4O6s
         MZ2A==
X-Forwarded-Encrypted: i=1; AJvYcCW8/M++cLYqL7lDqjuE+Ud2gMD1jDkzks8B4wXsnz+sk3kNs9fCNg/e0uXPnQveeVU8LyotIQFAd8m10Rw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIhQZhSUoh3DLciGlNY2rfhlopjnmLtctJG88AZx3/hJF/3Mjd
	CvGY2dH3/wZFeFOOHUPB+VsCF6HX9vk2xcn7xH+4dxLtimsZrKoCl5JYnFoySjdzY/Q=
X-Gm-Gg: ASbGncs6eehhZLYyzySdrSAfhEBRNtGiScDWWl562CbRkbG1vNAJh3G6nhwZlITpr+v
	h7eNLvUVn5hUGQThJWa5SulOI7x3bAPXZFhCMCmK7fOAv4ryBWt8Ma48e2oudVM2Hz7E0Xvtwej
	0K5y3fD+Lc+rE9SWhxwwm3nPrZQV+9UNCxUIC63aTDw0k40s3KvVYf2qiAxodri6wpdc5N4/zFD
	obKQC2NjcUaBgrvmpytRvecwJ8Z7BATEuWviI1s0NEUNeBne8WHPJIZsiqef2yLvOYcSPYBTDVR
	ADT4ZqJzgvZQy/783mJng6RDmNXS/vDLVcw7O3jmtFEGgF6odOY6T1b8tkCW1g0GyLXdx5cmUcC
	DtgHqYxNRH/kGBSeHITHYcr9nhLAptGKCSIvJMFmUd+wyR+HAE53iQJ3n0vp7IKUjJd34p9ZIBm
	NPN3TxSGjK5eaK0R+3WpFKnLQ=
X-Google-Smtp-Source: AGHT+IFck5XRDPyHoaLZAuLhkGx4XDGyeWcDyTrgg5x4OYR9WrckK2spEl21YFRwG98d8k3Tyo7H5g==
X-Received: by 2002:a17:907:2daa:b0:b6d:5840:4b43 with SMTP id a640c23a62f3a-b7265400cacmr325257066b.22.1762356911886;
        Wed, 05 Nov 2025 07:35:11 -0800 (PST)
Received: from [172.20.148.132] ([87.213.113.147])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b726ae98aecsm178597866b.11.2025.11.05.07.35.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 07:35:11 -0800 (PST)
Message-ID: <513be88b-a205-4cea-b9ac-fea4da968f91@linaro.org>
Date: Wed, 5 Nov 2025 16:35:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/28] spi: spi-mem: Make the DTR command operation macro
 more suitable
To: Miquel Raynal <miquel.raynal@bootlin.com>, Mark Brown
 <broonie@kernel.org>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Steam Lin <STLin2@winbond.com>, Santhosh Kumar K <s-k6@ti.com>,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org
References: <20251031-winbond-v6-17-rc1-oddr-v1-0-be42de23ebf1@bootlin.com>
 <20251031-winbond-v6-17-rc1-oddr-v1-1-be42de23ebf1@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20251031-winbond-v6-17-rc1-oddr-v1-1-be42de23ebf1@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>


