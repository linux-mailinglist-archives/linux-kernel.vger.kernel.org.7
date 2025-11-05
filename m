Return-Path: <linux-kernel+bounces-886944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DA6C36BFC
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 17:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 777BD34F3A3
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 16:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D235C322537;
	Wed,  5 Nov 2025 16:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="W34+0bjg"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946C1334366
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 16:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762360853; cv=none; b=Nj8Wag1Pcvrw8ogB9ffbVnRjCjzDV93qVVeOVSN836CB3hSg+5he/wZaFRn3p7/OepgEd/OEPSkRvsqs3PddncVxOjNFncB0QbavRsXt/QToMEkktSCLH/2OyWgv9Niow+7fpSZ2nQLGH/AmUSQ6xq+6zMrRYJVxmKFdS2paMpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762360853; c=relaxed/simple;
	bh=J5y3cvvKo5+9lQfpJmQgggsGD6TUmDXFlvyHA/c6DMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oLj3Qcd7TsvVBU/BV43emlUskZ0+EIVBczQ4duMemvAb9V52QK9QqDpQNMj83rUCFAvYSZq8/nPBp1+sfN7ifBgoinKnbLfONeAqLzYfsHnJv1FcZ049zovKkqVAg+BI9METJNg17zTdtLXLtSrybbyCmkcGbIDZBWSiMxb2MjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=W34+0bjg; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-640c6577120so5823862a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 08:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762360850; x=1762965650; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J5y3cvvKo5+9lQfpJmQgggsGD6TUmDXFlvyHA/c6DMg=;
        b=W34+0bjgbI78Rx+fR0lg04ark2YnP8VK9JxyOkqWiouRBWde9OcDfYOq2ISUsjVkLm
         DuL5H0sgzpBeou5g7N0EUaxi1fmVAqvWC5z7n9BJsaGq9Hfs3vMlKcSEQDf6jYeVnvU2
         s/ADY+N9e6C0OoZWm4z56RogzYKWIa3/7q7ZL0uyUP2lAwNNwxDg/bsEhj6GNREZQ5nm
         Fkodonb6O2+AsKaS2mvnjLaQWHHUdVRrhxbh8l/FV62Z/NQ9SdBqJ6v7TByUYwlc8aH1
         69Zy4UC7Hg3y8CFxR9WDqI6qgVXJBVW3DEBwpX6olpk3ohMjLBrSCBucEr92fUeLfig+
         jpOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762360850; x=1762965650;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J5y3cvvKo5+9lQfpJmQgggsGD6TUmDXFlvyHA/c6DMg=;
        b=ZXYSThaysf0fCzBrclsjgghXtyQgUOPYNtKP4zqexRGA2JzkW7lZ8bWW8jy+0FTphf
         hP/VuOdkmjJM9KPCtMWKsZWfKmamlirQj1vYeCXY6T9Vahq7N0dYeGsIGroOSf5Lc1s5
         x0tHsj1HiNbDt5lkH9wHbLNCHsV0vmmnrd/TfXdFITxu6yvz7OKaGYZiyUKb3B6phQ2+
         v+vzPLRorRCINPrR5SdzCnlFosc4936dhOOy7piMtbJ5msP7YxFiIIjjUCbtHOfHQt6y
         Y1steKLmEFSMByJIOnpJtU4AVrx2GyVpZclVhLRW+sAqhCuTAd9ffooNZtQtCLVXVJsT
         SxEg==
X-Forwarded-Encrypted: i=1; AJvYcCWdR1o6tASym5io9GUFc+LrPYqWLDf5XhmKUozkk2yQHZ5jQ88dT+1EsYh3jP9esKAatDSYK15mEqrm4T8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1T88owLCoFiI499UXVOs6oyFjKIqzlooap+KUnTJi5xcVBZQb
	BvTRRgmLQKRVykQS5uvTmJkfvdpzHROSqiOIg8D3kxIsyyCWmhpPqytytJVDL/z2mLY=
X-Gm-Gg: ASbGnctkprzCV+5MwT91qzcegeGco0+ODhzNStRdl2AcwXupkq0Y8Wik6zkT+HZF90G
	rwN8182+HDNtwip3/+FLEaWTBSADXcOmpl88BBMKXaqkt4rr4KcyJBVluewTI2t0Og43JSgKY4E
	g0DaOwQBBUVHLnGfY3lXyhgpysGGbYUyEOM9qTv6OLp6M+IQKPyq/OqtJZy/C9KODLHDkVkHesr
	OaYRNeKaQv+r7FyfBI6z8aAiBPhU4p+rUKUT6wRvH+bHQkEoP5NyKfT232nNgjJ71+xQGaqJdx0
	TZnVIMaJLB5gfjVMnrOsWJHWU1Ilj/oKXxiU2NPl1qnf53NdwdVB4yo91d4xAZdG13c+hPxBX7q
	tSxU2oNFLyF2tw6+KQg78AArSSnTpekOVruhK7mk76HsQiDEUr0UQgJkme3MA625IQWHXQB4of8
	ngREEft0s8xLWRrIq8MGgiLDc=
X-Google-Smtp-Source: AGHT+IHHiXKeERAxAGoA9dz0LSZUAmCzTEFW6Xdym3PQ8+7oh8lHWXBcPCZ2UhPmAtNDnOKZfma9sQ==
X-Received: by 2002:a05:6402:280f:b0:640:b573:a30a with SMTP id 4fb4d7f45d1cf-64105a44b13mr3577815a12.22.1762360849881;
        Wed, 05 Nov 2025 08:40:49 -0800 (PST)
Received: from [172.20.148.132] ([87.213.113.147])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-640e6a5c881sm5086735a12.22.2025.11.05.08.40.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 08:40:49 -0800 (PST)
Message-ID: <e469cab3-c0d8-4d68-8eb9-4570ded1884b@linaro.org>
Date: Wed, 5 Nov 2025 17:40:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/28] mtd: spinand: winbond: Convert W25N specific
 operation to SPINAND_OP()
To: Miquel Raynal <miquel.raynal@bootlin.com>, Mark Brown
 <broonie@kernel.org>, Richard Weinberger <richard@nod.at>,
 Vignesh Raghavendra <vigneshr@ti.com>
Cc: Pratyush Yadav <pratyush@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Steam Lin <STLin2@winbond.com>, Santhosh Kumar K <s-k6@ti.com>,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org
References: <20251031-winbond-v6-17-rc1-oddr-v1-0-be42de23ebf1@bootlin.com>
 <20251031-winbond-v6-17-rc1-oddr-v1-13-be42de23ebf1@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20251031-winbond-v6-17-rc1-oddr-v1-13-be42de23ebf1@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

no inline, good :)

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

