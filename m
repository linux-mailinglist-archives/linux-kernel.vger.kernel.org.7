Return-Path: <linux-kernel+bounces-815318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7E0B5629A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 20:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7828E1B27DED
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 18:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14BA231A24;
	Sat, 13 Sep 2025 18:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bLn3vU3e"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B0E222593
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 18:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757789364; cv=none; b=JYgookPQGS0wqFeHnpS40KAaTN8rIECekIf3etK9MwSqlHmgLas2ZtDC7oSbHq9KlHYk7750tlV2Ch2hGAZ08AJvRceLEEE3jks18UD76m0+R4ZmuWcOlESU2lZWvJljjXEhEfK2ISb/waN25u49he5Q6t57TqE4wbxLaM2UVtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757789364; c=relaxed/simple;
	bh=If4Dx8GnGsI9EAn+Csky6KF5QogT6E3JWcOUF8Exyug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T9nAsHFe3xR5gBNQnstQMrlNIBy6oxAj9QeqepnJ8+HUz5HhFSoPGPxBiqkZ2Ck8XqpH1c9gOazySV20XPhT+7s2c9j/l3s/Yr3ggrQ0qQU0t5NpHCn+mPUqMuVesnWmhzUw3ZNd3IUisKioGtv20v5/DvRPx+jA4o/xxKeAuHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bLn3vU3e; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-772301f8ae2so2864007b3a.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 11:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757789362; x=1758394162; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rF3GBCGcRqV69CZBLaKsXGjUvkwSYhGDg0qUaj1ycYE=;
        b=bLn3vU3e8T50AEZHqvp91RBvtEh7tO2VWyN4zSS1BsInQyQho0KLVaPw4gtwgkT5O5
         IpNJ1A6lkpgBOgTP5JYiGZzjnIJNPWhzE5IzW+WtiRmR20AqB5IH83CuoX1KKRvTCCGc
         FLrMqSArEmXsge8MoS2c3VcGiop0OoCpEDuHlyKfgCgK+E87YH1o+L3isZzVDqWyB3x/
         uXcrXZaHhFacnJs1DbdzFI2FZoEMcbzHp7MksLrjbOj0Y0CjjJckObUAkRr+2hq2BaZg
         fIGzShRt+rUUc9//cn8goyALhqAXbwQoLh5sQ3pqd1Dt59nlKj7AivgjS2XMgqTsCLQg
         sLhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757789362; x=1758394162;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rF3GBCGcRqV69CZBLaKsXGjUvkwSYhGDg0qUaj1ycYE=;
        b=HyudzLW5Ap0oofScbQMke82po5NtoqlrHJR/mB9oavcC/s7AR4x4KVz/GB4SQVGabO
         B64Dw+It1j4f6AUPqC5+aqIf9mHLMqO1jGgfOrs07C8QF9lbfquUOXh92y1qYRaCYJrz
         gKEMJ6jDGfzOQ8DcsZpO/XC0+hUEwd+OYJSs5vHRbxtxZlOVEfQ0vx5IzTj1J+t53aUt
         BVt9UA675kJzv0SdoJd5SpAV1969zx8vHgMPVc1BWgYqulCo5JOreZIiJ1Va1vk4UW2c
         R486b6tKHIIUyTYVU335zLnue3XD24922Prw8tV24rB/GAQWNehF6SLpTCIF4turZEGT
         ua4g==
X-Forwarded-Encrypted: i=1; AJvYcCX4jqkcRyMLoKrf6tvP+AoUY820kWqj0jeGqolYWh8zdUUwoUdb7VMUb8bH5yIjjl9RHiVTy6vYf4tJwHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxahhotA0GZRjgLES7nov9ogYudgkgDVVLkEpuiAp5hpHY+AtNE
	2+f0A/f9ToaJ+0ug9YrhgASTpQGQ/m9g8KfDP0fHLoqFCsEBpg4FSf/B
X-Gm-Gg: ASbGncvj7ZEOiHZqlRPFUdNQem8HNOaVWMnm1jNxeR4G6UKXjnJKCu1FbL+NT5MOOiE
	7x4+08hxfdcYRBtugKGr7AgLEfhqJdgWiYfKabdEPU0XfaQ2FylffjNy0kT0i0ErDol+mN+AnMM
	0JMstOLjkNIsqrmILdpUKXcMTrXVE3XgQgphUB4nNPF+Xa+3tKBeHksi15aR3AVoUAcls5eI0fT
	BVNB6m9+3kkPz87D3+iNcEJEiuCxpLvFN/9jPhhDUvpATZFtH4yBqQeHaxoF2NZ0o9jYWgXmXbJ
	QI04rGg2A1n/6f0hERidQPlhkEKt230sSpM9RvvI0AfBcK3uk0St93YwS4UJvqNOFGLaWYXUK7p
	X/gNpO1+xJSLcXUEAjecDwgdR0ZQEChJVK9QFVrrhYuChNqIMfHCouu9rVQ==
X-Google-Smtp-Source: AGHT+IER3H6K6+0dTJYxwoJBwqd4juH0cQSJgRMY2gXd9jT2iPi/p7I16dBYJ0ZSS5sqJlCrdMRqag==
X-Received: by 2002:a05:6a20:2449:b0:252:f0b6:be9 with SMTP id adf61e73a8af0-26027c23f4fmr9459029637.0.1757789362176;
        Sat, 13 Sep 2025 11:49:22 -0700 (PDT)
Received: from [192.168.1.6] ([223.181.119.30])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54b03cf65csm4920585a12.16.2025.09.13.11.49.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 11:49:21 -0700 (PDT)
Message-ID: <501a4e0a-2d6e-4a57-9006-91413bd2ebb4@gmail.com>
Date: Sun, 14 Sep 2025 00:19:15 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] arm: dts: ti: omap: Drop unnecessary or unused
 properties
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Paul Barker <paul.barker@sancloud.com>,
 Marc Murphy <marc.murphy@sancloud.com>, Tony Lindgren <tony@atomide.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>, linux-mmc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org
References: <20250908-ti-sdhci-omap-v2-0-72927890482f@gmail.com>
 <20250908-ti-sdhci-omap-v2-1-72927890482f@gmail.com>
 <20250909-uptight-fluorescent-markhor-4639db@kuoka>
Content-Language: en-US
From: Charan Pedumuru <charan.pedumuru@gmail.com>
In-Reply-To: <20250909-uptight-fluorescent-markhor-4639db@kuoka>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 09-09-2025 12:50, Krzysztof Kozlowski wrote:
> On Mon, Sep 08, 2025 at 04:17:12PM +0000, Charan Pedumuru wrote:
>> Remove unnecessary properties like ti,needs-special-reset,
>> ti,needs-special-hs-handling and cap-mmc-dual-data-rate from the DTS
>> files as there is no user of them.
> 
> No user? That's not true:
> 
> git grep ti,needs-special-reset

Should I remove ti,needs-special-reset property for the compatibles "ti,am335-sdhci" and "ti,am437-sdhci" instead of removing for all mmc nodes? ti,needs-special-hs-handling and cap-mmc-dual-data-rate were defined for board specific, so these two properties should be defined in the YAML file to resolve dtb_check errors or can I remove those properties for those boards too?

> 
> Best regards,
> Krzysztof
> 

-- 
Best Regards,
Charan.


