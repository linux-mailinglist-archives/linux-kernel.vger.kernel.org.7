Return-Path: <linux-kernel+bounces-886942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8026CC370F3
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 18:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 055686453D2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 16:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0210335554;
	Wed,  5 Nov 2025 16:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Zi3XNqgQ"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CCC318146
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 16:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762360812; cv=none; b=o7vBIGErtfZmlFzUzCXbar9uVAfb3LdbzyK5NLzl++zyIpgI3P71r5o10N6gxV1tYVXZoDOuMt7IGlrVMV33GCgMY8m6kY4eQ85FvdwLKW1AARheMRUdABOF1GAdgFjELiBnwLx7kVyKZHMXU4okHU0StutEJMS95905dQzTzOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762360812; c=relaxed/simple;
	bh=gczMRuZ2fsGRpoCXUBhl7NeVLE82+ehtyW2OQrB7AVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WEAHsPgCIBJgTu4uP7bmfTuwZuMjvE8x8KJRVuXj6hocGPR+Q4kI6A2+1oFrxBh8gsYmlJ/S8iKua2T4MDGL8pYfUX+5o1PqQ0vTJbkOy1Zi2iae9LICNkZE51tK+NC+NiW9OgwHmGBeVjTAB37kF5exN4PKCBmUE2iYlrbmcL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Zi3XNqgQ; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-63c489f1e6cso52391a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 08:40:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762360809; x=1762965609; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gczMRuZ2fsGRpoCXUBhl7NeVLE82+ehtyW2OQrB7AVI=;
        b=Zi3XNqgQzrgwkf2OKfht20nI+Tb4tSvjgtK/ZG8cw+muxWsyhikkaxIEBivtdsyYDb
         oNvfShzgEHSDcH+DuPZvMZIPt6s5nqwYU7Tc6RVlFpUYSLyBpIBgh2ELWJXpVEA3rzxk
         VvDLl9fIhDEjI7BlhHHH3yBjnHR5RjAPNi+J4I4Gnb7g1h+zq0uKg6TPiIu5TgYGWfZQ
         xWHW6kq2yYHYKqyS5yZp8VliOrXzIORHlYzw6u1htOEbJu55JcDIJG05+EAt0qVWNHmL
         XAxJquiRB8jKRuFTtdnFRw8CTn1AvlCFuKPpzq8GvDML3ZvGd6KaQmv9up9NsE5CwLp1
         xTWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762360809; x=1762965609;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gczMRuZ2fsGRpoCXUBhl7NeVLE82+ehtyW2OQrB7AVI=;
        b=idiaHzGk3F/+OYPFILtj33Iz/D04PzIVnaVlUgqIF7P2JggX/POPzNpcSZobyVNvc4
         vtqhBKZRTaJWxkp5K+/Pdu1MKj8eyepO5S1W3dqlF0Yef1XIG7R6Z0JisFqhBR6ZT27Y
         wfaby6wR7DK7NAYZBA5Fp8fsDcv/PewyirugCMi4NfewGxJM231rn2O8q9KRQUw4W/+K
         KG+0Uy9Vq7zJCkXuHMtHPK9mh+xK2GiyFU9RGd/YmIl8a0GPc87o7dOqBp3f7FkYQnJ4
         8A1Ztm2nyu9y/S4MTf1AeAKqwxw5n4ODBV4p8R+i9y9E2g/WDz5jX2Timb1jmKO2iGur
         gB0w==
X-Forwarded-Encrypted: i=1; AJvYcCUtwWmPyrD/073jQiJP5+HEXirdXWXCRvQgXJvzGzPKQulTgmS2uG0z567u2vJghzSwvziP07xVg821Pqs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmTb5ERljaBCBF7oF/jrv/Tz3ymHpTGSh9O5b98pLoyalYh50z
	jSWb5781dynD7xrdlo1/lXtqiRUCX9YJw5eqJrZSJRaukyFMBexW+yCWJwC8jCEmfjo=
X-Gm-Gg: ASbGncvdRl84yHBVJpBPtENUidCLcYGTR1UQWuKiyT8HtKzBtjzv8yQjg4wE+rhzDf7
	gRxeYjSYgdwm4uaYXGLD6sJOJrEvg89DbC3E1efgoidQFBnilEB/1Gl57/NwAKIxUNDpdkHSiGv
	vn+wWVXGxlIenzoUMqfbpleqLF60SttmuEMog5NqDgrl2fk9JCwtUwcQ2pdEN0/mjJfamcpsXo3
	mcSpEH4sur4CP/1nzcQvGX4kfxAt74FAmRPdWnO2nDVv+cDGtmIS5WuwM/r7s/YlD3PEoCnsLBl
	3U2tnV5WdGf0EJuLzHqTqqfF6Enqp6QGrlY8pNnWHM/1Ps5orEDE4v9Unl8Xv9siv+5AiiA+kFs
	IgfMo8ChnLDZCD1rKkFCKOfw595uQUOu07xpGOy+zogf5QPLYryRQzgYfvrFy+9hL0JHfniyhTE
	nZYH87Jw3GWZxBJKOzWRgoj1opyu4a16yy+A==
X-Google-Smtp-Source: AGHT+IE7wXx3urTFDNDSqobwKamWQF4BItgkmBjCAwdlchVnppz88UvExNlhgtNOLk7PtlOnGNVWQA==
X-Received: by 2002:a05:6402:40c7:b0:640:9997:a229 with SMTP id 4fb4d7f45d1cf-6411d16412emr55871a12.3.1762360808780;
        Wed, 05 Nov 2025 08:40:08 -0800 (PST)
Received: from [172.20.148.132] ([87.213.113.147])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-640e6a721f1sm5105380a12.32.2025.11.05.08.40.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Nov 2025 08:40:07 -0800 (PST)
Message-ID: <4ad47442-1c51-45b7-b709-3cca029e4fc7@linaro.org>
Date: Wed, 5 Nov 2025 17:40:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/28] mtd: spinand: macronix: Convert vendor specific
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
 <20251031-winbond-v6-17-rc1-oddr-v1-12-be42de23ebf1@bootlin.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20251031-winbond-v6-17-rc1-oddr-v1-12-be42de23ebf1@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

