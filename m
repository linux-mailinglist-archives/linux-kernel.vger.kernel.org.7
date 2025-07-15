Return-Path: <linux-kernel+bounces-731532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A2083B055C7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:05:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7C49189C4A3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE0A2D541B;
	Tue, 15 Jul 2025 09:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wd6djG0R"
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186A82D4B5E
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 09:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752570297; cv=none; b=Mlm/qJzqDEToWMi+/1yiUcusa3PKRaif3RJLMsLr1Ohr2D3Tgm4B919ZqSvI4oi8cZKghK6XCiyrTZU7jLAfTU8plcxWK7NbzAj8J+xOEC2SyQbbfiym3Hqtp6a5s6DlgAS5NulmPAJULFL/f0MvRg7puQ2yZyNItCsSN10m57E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752570297; c=relaxed/simple;
	bh=bCcO5BWOMg4zWppoYQdyYeZG6014gqukH8Wo1eDYPK0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nJzLTTFFGLgLICs8AfZLSpSD1dpbfPY0lLu5UATDlr/yLZJIePbtaCgdbg74/pVIQFnMrVVYb9AlSJWUpojV7i9oLGn0tIhXtZOpLepWgwENogiPKZZi2Jy9m+b0qSYrnf7sEKGY0qF5Xag33VdkuMLf2BIJIKRmCjQYiMCWujI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Wd6djG0R; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-3a6e2d85705so2963004f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 02:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752570294; x=1753175094; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RC35Uaddkl3Qjbyo7ZQPMdSP8Ho5N5PGV7tzcTZPgxA=;
        b=Wd6djG0RpOPMw1MY0CzUIAkwYGpBz+xAZWaPE2DZRmWr2HA/PISoKFZnanMhLsQyMp
         DTYVeQle1J8/kVc2644P2J6mF/vWX/xyZR7ziU+XOJdBK1aILQTwwzuYp4Fbq/LW9etF
         ci/be9Y0RPhBHaLUiU+JgnrUs3CyVyycSW6Bi1Z+RZJD/6j39Uj2opwJaPhBmo44UQmx
         lJVJj5635NXXT+8+qDNE/pF5gIfEvMkFzW+UZL98huge3FxflgwrJpGfxCnrszlfRhho
         3cCEahsB8y7qz2sWmEAEtARN8FurW/jx5nPmtr52KEs/4ZTDV3XIm97jPH689yKaQ/jn
         /uwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752570294; x=1753175094;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RC35Uaddkl3Qjbyo7ZQPMdSP8Ho5N5PGV7tzcTZPgxA=;
        b=EXrDtjO9rcDURTJHGB1HJDmGgeO/k1r1sxu46Jvooads7VDb0nNy5j7QlLESGLjjfa
         asJ0SVTMPmMrTRm/VY0qBYh+B5xuJku+gQLVfSHeS193vaU1WuDwzPaGXtx2AK8wsiv7
         5UVfW9NHHk9qDto0W+UH2JAz3h4oUaL8KoIUZvQ1Z3/Xmq2q5xakVBx24jRrjfjrCP7/
         xc6hrkpmusdY0N5LdkFTxDoIDf5WKzas/J8QuOsUQDDC7VzNyJihYN9zOKPQ/7L5Ypsb
         PAT3IY5Xo/AoqxMNJxADHl6jolCa9yshjXL4ZM4kPeIBhUdEB2LD6CellrZQtmCGMqJM
         QGyg==
X-Forwarded-Encrypted: i=1; AJvYcCXgWVSfnqZfCaXkoHIBYh4b0Y0YWhipZvZM36Lz02u6UiUEpWMs3JwSYY9fKlAhvaWrS0Exh1o1ywhLtWw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8TtYVhEdtrPOLt9TS6a9M+niRckc33+hpyoRVsJAHZxJL8a7L
	cGYGLoUoSDp5qNymKxFQKzWpox5gFhv158KPgArUUC8Klf5eB49+hYj/i2mt0f6ERkE=
X-Gm-Gg: ASbGnctE7qs/kuHTRUkF/Rx7zp/wWOS7Hr+3iiA+zVHTKNzEuqABZw9541xCv80J4sR
	2B7xMEXMDzTSomf4o1d6UmyRem+XmwBvIk/gANLq6nzwJMgNhQD8PHcPQo11MZRormcfbFaGZdn
	pb+SR3FYtRzd4gdOnJ140PgbEOYpP1XwnHR+a2WRl7o+4RKcPdDSC3bvamNV90GExPUh4DLKB0G
	7TRCz05bnsOWQAaRK9Lm68b3OTxWcwsKKsf5m7HfMpDErfHeHdm1sLcthQieoE4byh8K07UWmWp
	KFMNbQFgAVNDpILyZVEsiZw/UyGWlEnvnM1nWGD0AlqJ+UDVGY4fXwKG2BK9HkMMpLsKkWweawt
	4pZs/Jn7keIQIVdWpPQZMbBYV7gwyujDXqa8erQmHNJGcX8OwIIxVvH1kjdu8XOk=
X-Google-Smtp-Source: AGHT+IH7ZwYaoq1ijwhyR8CQGw2jNG3G9MrFh5JCTUkvpu9ErJbmnjvF+ugRsyGoX44jMF3p8DMzxw==
X-Received: by 2002:a05:6000:4818:b0:3a8:310a:b1dc with SMTP id ffacd0b85a97d-3b5f359b173mr11825598f8f.56.1752570294340;
        Tue, 15 Jul 2025 02:04:54 -0700 (PDT)
Received: from [192.168.0.35] (188-141-3-146.dynamic.upc.ie. [188.141.3.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45627898725sm9928635e9.1.2025.07.15.02.04.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Jul 2025 02:04:53 -0700 (PDT)
Message-ID: <944ee7e4-e937-4fa6-b527-f1ffdd397fec@linaro.org>
Date: Tue, 15 Jul 2025 10:04:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: iris: MAINTAINERS: Document actual maintainership
 by Bryan O'Donoghue
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Hans Verkuil <hverkuil@xs4all.nl>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Dikshita Agarwal <quic_dikshita@quicinc.com>
References: <20250714151609.354267-2-krzysztof.kozlowski@linaro.org>
 <f1283a01-db49-417d-b4f5-2488aad2d237@linaro.org>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-US
In-Reply-To: <f1283a01-db49-417d-b4f5-2488aad2d237@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 15/07/2025 08:18, Krzysztof Kozlowski wrote:
>> +M:	Bryan O'Donoghue<bryan.odonoghue@linaro.org>
>>   M:	Vikash Garodia<quic_vgarodia@quicinc.com>
>>   M:	Dikshita Agarwal<quic_dikshita@quicinc.com>
>>   R:	Abhinav Kumar<abhinav.kumar@linux.dev>
>> -R:	Bryan O'Donoghue<bryan.odonoghue@linaro.org>
> 
> I think it would be good to add here also T:. Bryan, do you use your
> kernel.org repo or the freedesktop repo from last pull request?
> 
> Best regards,
> Krzysztof

Freedesktop - the media-ci lets us test a whole bunch of stuff so its 
convenient / less work to issue a PR from there.

---
bod

