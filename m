Return-Path: <linux-kernel+bounces-766619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0C7B2491E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 14:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3E4C726BED
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 12:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61AF2FE57D;
	Wed, 13 Aug 2025 12:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iXo0KP3M"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E0F2FE561
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 12:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755086623; cv=none; b=bWY1ecHj4+Fk7Ko6Liph1RSvKwFZ8tbVN0s9K/WzMFbEGVkSC60XXYPiP5GgtIvyQXBxWxBwhUprMIHBS3gWCU7Va03/NopvIlzsrz1IpkYMblJisRvVYR1pRI71gO4xGLqel6a2jdvPAVIf9DZCCeDb2hCBUvwm7FhSX70iKOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755086623; c=relaxed/simple;
	bh=WELsSM3AtKEclzA9q3wHWqr7DDhmuuJHaSOln9m13CY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xrw271K9ZD/jlW+rVyXdNWSNYviQhEWmoXX/d8X7kSsT0MwsL49hEv/B4gsi7QlZRrYvtIYRtE0+suBe0XEsojmXbQJzshKjb5ZOIkHZU5ILE2lrdJYE28WTmuY7p8R4lAow+NeZ/tj3GooxoEUxZga8i1Vg5EvWGqQ8tMPVDic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iXo0KP3M; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b7920354f9so5326820f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 05:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755086620; x=1755691420; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3XvjMpS+8oWnYVArmJHtXmTPeaMaVACHoQ9sHAWIeo4=;
        b=iXo0KP3M2X7GwMNY7Cd6j3qEAdDH/7dz0AwDSIAS17W7DKnymLx8aegSA/NsLgDXjE
         izufUd7hr5rW5t8pZKgXXpPhxGyfKHF9WnY/Cwi/gsxxwZBYPRTbw4zwGBxn+429EVyF
         1LheqrVg1OtRnh+dt/KfFPq53HGeh8aDOOVoKuW5NgssqhBqbzo1hBHxnNx+TdGl2DUr
         YWi2OomUh3mQjrkW+PphSKRFNBl/M3PhCouxmJUJCZHdoLXqk9BC8A79yGthPSM8HGbl
         mHqywqh2Uj8mfYdj9mGS9N49rAKYTBXmCkvoX4ZNiQqsOuQVRq40/56cHpAU+ibY3g9u
         tVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755086620; x=1755691420;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3XvjMpS+8oWnYVArmJHtXmTPeaMaVACHoQ9sHAWIeo4=;
        b=r9a5kiqhAB/X8hUrSPVNtS1MhGngADC922ILeSjHdCmHAmcnB27pwjh5ontA6WsoW8
         Ltk7fHkCJ/qk78VR1appevP2TMRdFeZ33QgiQlm5sqFBoB9JR1SWh3JSgeKjbPDJJpDG
         moaI9XUxn6ZuMFSBqXZAFAjKdxcQ6KnlbzW5aBpsjzPkfac4T15qzFv7Cdnas7qWlvoT
         tGTqIrOahDvH2SeeZIxSUADlym36ABDWbLFgeGlemuy+rAiXL11j7o5LkrwQCOeExgRu
         9PqHD7cIITtUqXjs37qM1wpHQndVQCwATzr4yU6wNnmDf+FQJaxgNj1NNm9R/7J0kV7S
         N3VA==
X-Gm-Message-State: AOJu0YzKhI+9V8guRtdFixH4T5gUdufbSCPQuqL5OkxktfiWNGKBkZx0
	4LZVxrF8ihFpsqkgnkkjdgP0fGQLcgA+sRf/Jkf9rQWmMy26NEYzgyFS+0iOpT/r3yM=
X-Gm-Gg: ASbGncuRmRQpcgjEd7J3ma78Aiq1zP8KQ6uORKu3avHqnyexVKkSxu2OIQJLe7mPZLd
	MyqzBjrQbd57qbkp5pT8MRuHbNfvJQ1rAOa2gkKml+/3/R4oNVYE43eziUAWNKaDMjUVsaN1ekV
	wUQFg9iZaQVILN2lWbHX3gsB8PF8uybFtP0c0v2ci4jp0Uw4ubZXXSbu0PJijF0kEShmbsJP2Mn
	+8si5F6PVPtUiM7uw6Yq5pD1OrUZzWu1RPkXgWdt8xr/dlPxVlYOnTphWN1Lr1YNrks5/sc/8Gf
	bIo/enadi6odNluWc2u2kmpvgkjCSAckjeKnBRwXKSjfuAI8UebdjFOV3zs4Uc6zTrKdcjCanbS
	a+AxD+Cjf/4jvdiGTNDZ/3xlrvc6DGcbU1jorV7qcGpgfBfTyYUdaRNuoiZ4/tw==
X-Google-Smtp-Source: AGHT+IHxp+VeWjHiqQ8aBd+gz91GtrFP/7x1AqDysrQKifIk/EESEugnh5wrM4RvHZhNCnsTelpLKQ==
X-Received: by 2002:a05:6000:290c:b0:3a6:f2a7:d0bb with SMTP id ffacd0b85a97d-3b917d29dacmr2224481f8f.12.1755086619388;
        Wed, 13 Aug 2025 05:03:39 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b90fdc85a4sm8298461f8f.60.2025.08.13.05.03.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Aug 2025 05:03:38 -0700 (PDT)
Message-ID: <f7f01234-ce5f-41d2-8a73-17f6b86dcd1f@linaro.org>
Date: Wed, 13 Aug 2025 14:03:38 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] clocksource: Add standalone MMIO ARM arch timer
 driver
To: Marc Zyngier <maz@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
 <guohanjun@huawei.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Mark Rutland <mark.rutland@arm.com>
References: <20250807160243.1970533-1-maz@kernel.org>
 <20250813-macho-snobbish-alpaca-ff07fa@sudeepholla> <aJx4g8z3l438Qgnv@raptor>
 <86ikir8mqw.wl-maz@kernel.org>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <86ikir8mqw.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 13/08/2025 13:49, Marc Zyngier wrote:
> On Wed, 13 Aug 2025 12:35:31 +0100,
> Alexandru Elisei <alexandru.elisei@arm.com> wrote:

[ ... ]

>> ls: cannot access '/dev/kvm': No such file or directory
>>
>> With this series, if firmware doesn't configure access to the memory-mapped
>> timer:
>>
>> [    0.549399] kvm [1]: Hyp nVHE mode initialized successfully
>> ..
>> [    2.018050] arch-timer-mmio 2a810000.timer: Unable to find a suitable frame in timer @ 0x000000002a810000
>> [    2.018123] arch-timer-mmio 2a810000.timer: probe with driver arch-timer-mmio failed with error -22
> 
> Ah, you have managed to test the error path. Thanks for that!

Applied (including patch 1/4)

Thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

