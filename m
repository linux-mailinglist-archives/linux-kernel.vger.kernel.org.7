Return-Path: <linux-kernel+bounces-790572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D85B3AA68
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 20:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7983C206032
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 18:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837D730ACF7;
	Thu, 28 Aug 2025 18:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="QOZcbAzl"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E88C2C11F0
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 18:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756407224; cv=none; b=aohL9dqnTeIRbknQRcVjnpVl1ftcWjzjIVlGbF2QmLqe/p1ycGgXm6H9FFvrgjbeXddDnsaIEbHC35Gv1dRxdBW6gS9HVUVR0ZUw6PGpNwsfrsv5+R5wAnbPNvd+q9eK9sYR5WG6pKdqEWUMoJg5F6QTDCp1KNwOXHk1nKuCXjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756407224; c=relaxed/simple;
	bh=FQ1rdKGi9R94HCP+YGbh7p78J9PEq/G/b/AdDFMY+jY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lcw06ibV+WtWNNNYEyQVJH29X8RxXck7gKaFw89g/dHv05HtrA94wrHLFhA9SRp10qhR5l36gv9O83pwjo3H/z65LfE7nRHRJRoWKUBG2HaaEP+6LnU3p66XC6yZ4AI5wYGZvdL7GcTEe1SjWTaUol3nnj4BTS7/1CInUtIyPMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=QOZcbAzl; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-45b7c01a708so3747275e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 11:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1756407221; x=1757012021; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KQxssGI+raI+XkRI8ea9mGLdtxL/7Ytn0lgOA6dMPAE=;
        b=QOZcbAzlqtiDVq0p0SK2wIYjMIrVjLkDoxQG9YQq0g3CVrOpaPI2SAOa8YMr/u5uSx
         qoXS7ucnnv4z7nBLgs05zJ2+o8cggQXg0mWMCV3bV/UbqPIuiz8/+sEHQUMFdNZhxCPu
         NTfriGwrOQ7TmTthVIA2jz0BEKyCWT7QF+wIwziliqiDFhHKQlE2/kYSaK7TEL5nfSZV
         6GEArmB32Q4qiuOk5I5keQqcEjcmeCemI+XbvM54DtUDzRvcvqAUS417eQkX4frwmCM7
         JP+ZZBqVLq2JyEH4MS242ODQQ+1QPjEtYMpX5TygGzdcbs80AkNkx9dtIhdDkwBFDNC4
         5T5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756407221; x=1757012021;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KQxssGI+raI+XkRI8ea9mGLdtxL/7Ytn0lgOA6dMPAE=;
        b=SS8Wpar+XecIOWyovGM1U/7t6xAyG1VP0sca07jqmowgajRzVKwUArhDbRff4dwe6/
         t4/RgilotC68Y83kOwT/jK8GaxmZ4nH0Ae9kcS8h69/mfDWVkviSzMbvhPxXMBeIq7CB
         h185Tq4PJrI/pz9Ta/4iufk8HeGgtLtRaTgAH7EX2qlpMj+MY43S1i+b7t0sS2DYv7Mg
         pGdsJ4VCzZIcyzQhqYcrzzYQuhQoHBNbPniN81aEyZ188tokL+JNfq+EaatriKHnia57
         1AKkQPfi6bOXsKu2ccWLuQSLRPk5H3cLH0XkmVGawXBwszn20skDuuMwgis/+L/IxRpp
         2cpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfc9rV72ljxjSJpg+6eQA9v19EcWDKUgYYJqzutJeG0sWPSTGhi210aS0M2c9gulWCnbwXNinWj0+gNWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ7eJnkEx1pAPnDWCi4tb6KWZNrNAAP+zdEGPqEJmX6Onow3Qx
	h8MeIgCxoVbie4SbujSl0oV9PaPsC5EVZxkiyFL43elqkCmeGYAMZca05sUHPDL7Rb8=
X-Gm-Gg: ASbGncs2+PKbUsrRHEsbhZMrIZ4xCOc1gDJowivg3xTRn8QAW9nBdXTNgbVRljXOmjD
	Mu2FcHgYkAgkXsTPO1PuTxabzHlb/MZjcuT3jo4+qFGIJFQ+x2KHguU6Siw3vz2AiXINz9Q4ur1
	hEBB0qy7qpZf38iRkOxGORXhU0Qs6RYTMedXjRtmrKV3TJH4ozllGEBcnCRyxqKPTaQhNyWVclN
	+19ws1SA0t6KMS/tXjx2yJOFjEUrZ7Kvq5/bY6R5Q6lsd5AXSR/q55aN/Y5mkTgPjto2xS5a55e
	LQ8E+8CTWzmyLMUbP6h6l5Z3K47TN9fAv5jrKcqTCRBln089/xDrgDOzQsXwe/BUla/RORMS3fs
	cpWKiA10rvRc9BdV1jJunjivpmgzQoRI93GSrwZgUkO0nf8c5QO64KRi5n+DC6VDrVg9A1Xauj5
	hGsQ==
X-Google-Smtp-Source: AGHT+IEsQ4LuJqJJ8bLH2sEiTn/a4xu8JBjHjhH5JH9gsrlNMbO4Yfh55Kjm7XpwgoiSOdsGhAur2g==
X-Received: by 2002:a05:600c:46ca:b0:45b:7c54:7518 with SMTP id 5b1f17b1804b1-45b7c5475a5mr21923185e9.13.1756407221350;
        Thu, 28 Aug 2025 11:53:41 -0700 (PDT)
Received: from ?IPV6:2a02:2f04:6103:4200:a4c6:4e84:e72c:19fd? ([2a02:2f04:6103:4200:a4c6:4e84:e72c:19fd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f306c93sm85978075e9.14.2025.08.28.11.53.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Aug 2025 11:53:40 -0700 (PDT)
Message-ID: <a27c5e51-14ab-4f6c-8da7-3733c1c89abb@tuxon.dev>
Date: Thu, 28 Aug 2025 21:53:39 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] thermal: renesas: Add support for RZ/G3S
To: Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: rafael@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com,
 lukasz.luba@arm.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, geert+renesas@glider.be, magnus.damm@gmail.com,
 p.zabel@pengutronix.de, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 niklas.soderlund@ragnatech.se,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20250810122125.792966-1-claudiu.beznea.uj@bp.renesas.com>
 <aLAWLZBenSWWqqkK@shikoro>
Content-Language: en-US
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <aLAWLZBenSWWqqkK@shikoro>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi, Wolfram,

On 8/28/25 11:41, Wolfram Sang wrote:
> On Sun, Aug 10, 2025 at 03:21:21PM +0300, Claudiu wrote:
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Hi,
>>
>> This series adds thermal support for the Renesas RZ/G3S SoC.
>>
>> Series is organized as follows:
>> - patches 1-2/4:	add thermal support for RZ/G3S
>> - patches 3-4/5:	add device tree support
>>
>> Merge strategy, if any:
>> - patches 1-2/4 can go through the thermal tree
>> - patches 3-4/4 can go through the Renesas tree
> 
> Series applies fine; I can read the temp (36°) which increases
> reasonably over time (40°).
> 
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thank you for checking it,
Claudiu

