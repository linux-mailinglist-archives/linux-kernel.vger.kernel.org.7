Return-Path: <linux-kernel+bounces-782264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F26B31D98
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 17:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DED661886328
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288D419D09C;
	Fri, 22 Aug 2025 15:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nZHOyjjo"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F081E7C08
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 15:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755875026; cv=none; b=fMgNdkLWqu7IIXFVG2LOW3PBAL0uVnopFgEUHrWa3ZMjNo7df+Y6hd5uwJ7ZZkIs+bwl4gtofKr6LnWooGUUYayH0lYqwb3X9mltL+KuYi0kSYPvdhtnQq1Heds7RKwbGrvqn5RxB1/agAkeTzZv5H4XnRVEv3B5hrK32bhngvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755875026; c=relaxed/simple;
	bh=cevULq5F47U5pn1UQxro5Ou3EUsPb0j9aD0QUfQ/gUE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o/0e0Xqi4aGZPokjGHxExEAol93R60a2JN1iaPq1j5fUoVtKk1kpWxPqQUpcDFCLgJ2E/SGYcxx9cqTIqHANLpCIsedOm3+dtlPD449SRrYvDwWRObOJHK+HJtt+uwpyogqVpv5Ty9s0nC+MECMCNsHqNPKQ7H+cG5nORJvwZIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nZHOyjjo; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afca3e71009so501223066b.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 08:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755875023; x=1756479823; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wWh8PyGxlWxe5MHSxxwSqq6RuwtxVFP35Vd46MU/svw=;
        b=nZHOyjjo2836ZM/zCSCZmCOnl2oGlnhFz000cUAeipCnpp4SovKuqPAtiAANZEJPok
         NTEBSMhDb4Z2mFQFW6XN3E1MflS0cWcom5wfeUIYsDOyMGHoA6kZt6k7bCG+IoXAr0wV
         6wZ0othq0dYvNYG500kCi7B3gC7njq+2lPaE90oSmnMH2sePsqkg5Ud9lNnA4l10pV0l
         57LRG6g+6n0a1XpKcsXThb7IK/jHciwQwTyk1MKdO1RWPaq0hCkbABJpBZURgUQ6VGGV
         7R47MQKKu6/yKU/adebHOkKyRRGDDKJOspVT0hBsAOAgNyTpYkv9b9ZfGIPS9iH+D1k5
         4efg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755875023; x=1756479823;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wWh8PyGxlWxe5MHSxxwSqq6RuwtxVFP35Vd46MU/svw=;
        b=mZEASJKDzfTNyWdJqbJtrjxNZAmJrfPM6UrQhqRQq6le4fcc4QjKLg7SBN4q4yGRFW
         JeeHYu8TRdL9uPFuLnSwhZCMow5PX375exGfXecwBfluFbObf8wEkDBS2xqFuKZ7JMfC
         dczFo8S7niiFJtLgFtBGRHPWTAeLu7oiHzGsk8xIv0V2XHbmi/esFhd1gO2jvQ9qRHFC
         TZd1RuEvV1Hfa1msffVDD/D9yCLVRNPCCd722v7xpedZEcpMYa9g80kdAlkBigrrVCGy
         tAf0I9mQHyjF+7J7IHgbqLw7vUmCYlJxufDxJdFsRiVXsWtN/xRvaQqADCaM0xy8sVHP
         Xb1g==
X-Forwarded-Encrypted: i=1; AJvYcCV4Qpd+MWN/EkAVwwqhXNpB5d4TfDuFWlFV4AH1vBdop/FFO2b2Abu0JCbdXVWWBG2EZcJ2OZwbVdmtAoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVvlZVF2x6OtuXQdhCTUBSnPBHoSPwsHu6AEL6Aw25iVmgVYjn
	WhCOvGLiXPWs+TJ2XQ5ly5NfTto8Q2az00bXHTreOrxiRM+SMiT1EwhBquT5pDtqH2s=
X-Gm-Gg: ASbGncu4DehkgJ9EsqoaybxNFQ0TmoUrmuAET+FGG8+3PYBQpG6J5k+KJSivTEmvrnw
	yrqih+uz91Ij30FOtJpp0QazXMcqrh9DH6wLhFluTljCsYq20+k2PlpcRmyFvxBsmEU+wSHIs7o
	FODUhNV+/VZtkeBhRWnbWCDNUM275BHPHUGHn4Zar3c4XGUqqrrwQzz4OkU+9NzF5Wu9Ib+KG0S
	p0p668vkgfnC6EYqhu4N+D8Z1zgpFHQvPwFLvzsMq/mgLm0KxnbINXa8+MOx2lFwcocWt/3Rirj
	c71OmmLPz8uK5URLNELwaRL5Ry+Ev5fvwLg3NrbTbikXnMy1G4//SwHSyAwPT0kPhcIDhGzWR6d
	exKGqZcxyYgLbwOKzlzbY8mBBvT4W8Fvo
X-Google-Smtp-Source: AGHT+IHFLMYgpEsUwExR4khNq/wCqpieQpwMLNU5LCmqz1CCYVCENyfpLn38R54b4utgze14geVJgw==
X-Received: by 2002:a17:906:7305:b0:af9:8739:10ca with SMTP id a640c23a62f3a-afe0b497404mr587666966b.28.1755875023083;
        Fri, 22 Aug 2025 08:03:43 -0700 (PDT)
Received: from [172.20.10.10] ([213.233.104.29])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded539d2esm621862866b.113.2025.08.22.08.03.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 08:03:42 -0700 (PDT)
Message-ID: <ebea336e-c43f-4519-b2c6-4f8812e29448@linaro.org>
Date: Fri, 22 Aug 2025 16:03:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: firmware: google,gs101-acpm-ipc: add
 clocks node
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Peter Griffin
 <peter.griffin@linaro.org>, =?UTF-8?Q?Andr=C3=A9_Draszik?=
 <andre.draszik@linaro.org>, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 willmcvicker@google.com, kernel-team@android.com
References: <20250819-acpm-clk-v1-0-6bbd97474671@linaro.org>
 <20250819-acpm-clk-v1-1-6bbd97474671@linaro.org>
 <20250822135521.GA3487754-robh@kernel.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20250822135521.GA3487754-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Rob,

On 8/22/25 2:55 PM, Rob Herring wrote:
> On Tue, Aug 19, 2025 at 11:45:36AM +0000, Tudor Ambarus wrote:
>> The firmware exposes clocks that can be controlled via the ACPM
>> interface. Describe the clocks exposed by the APM firmware.
> 
> ACPM? APM is Advanced Power Management aka the predecessor to ACPI?

ACPM (Alive Clock and Power Manager) is a firmware that operates on the                                 
APM (Active Power Management) module that handles overall power management                              
activities. APM is built around a GREBE processor.

In linux we have an ACPM protocol driver that communicates with the firmware
via mailbox channels. It's similar to arm,scmi if you want.

Cheers,
ta

