Return-Path: <linux-kernel+bounces-882249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 397EFC29FD3
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 04:46:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E33F63B1619
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 03:46:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB4D27FB12;
	Mon,  3 Nov 2025 03:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b="NmvW7J/0"
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BC01A294
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 03:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762141596; cv=none; b=qdG5VfAnIdeq8OOaPR0yAVV/P6BXGjhq89LnMbVhQBZaKGV9YCi91+PJ7JuCYnXfWftiVJWkSQx6wOCYWOW1F03y0P+PwfvED8hdIRVrqpmIUcw3mOZ+e0zBse23HcBHm0ypcKn/eM3RR35qSDl/bSFfsOJfAniPUtjVrJrtpbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762141596; c=relaxed/simple;
	bh=yUx/o+iM8bZDA46a4ngR/r4JqpMprbDWFyaV1v974xM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=J9mrWZNv0eNIdw4soX/QW4rAbS1yp3PLjNt67RsrkvTm3CFGhB/EQbRaegzgwMOMkpu47G7VlxDAw8Be/XbkqK0aWp0Jeu0BgXpJlJa67yMNyDMTFGXSjyIdJngQWOrj5M4aiOn7bPm9qsmQTBFwsJuPxiqgowyOXq7str4SUQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool; spf=pass smtp.mailfrom=packett.cool; dkim=pass (2048-bit key) header.d=packett.cool header.i=@packett.cool header.b=NmvW7J/0; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=packett.cool
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=packett.cool
Message-ID: <8f003bfb-8279-4c65-a271-c1e4a029043d@packett.cool>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=packett.cool;
	s=key1; t=1762141591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dr0ikCBUo2Fu54QL3NUrxLxEo1BIiZlIC6veZgMQ1n4=;
	b=NmvW7J/0D68DT9PC8Wgy4wcDNbi3KsOvcGChZbs5V5yuDJaPzp+cBQIOOI8ctcIIIWCKSF
	VUh8PvSyltBt/EQ/GE2zz3N7nIp+LVCvWqI7f72RuOZzs6Mw0YEySufoVEXvj1KArUtHa+
	/Mhm0aJ8XQ03Rpdm8plVdLqMx00QKTfp8m9grhXmc5f6v6tYqrtHTDk8GzmSZxGRf6FBw3
	2IpZ+zXgA2MfKZScWG50uB3xk2KbsGH3sQrjmuZ+7jzYhX1A93RT2xTtWHdEjDujRHKdXN
	C00FGIRc0/TOt3D2FXTSnhlHBtDCjLIqDIjrjv2gjgayn/ObA4YHMt7HP0Wiaw==
Date: Mon, 3 Nov 2025 00:46:13 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/2] power: supply: qcom_battmgr: improve charge control
 threshold handling
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sebastian Reichel <sre@kernel.org>, Fenglin Wu
 <fenglin.wu@oss.qualcomm.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251012233333.19144-2-val@packett.cool>
 <176213091335.301408.9120443011267055817.b4-ty@collabora.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Val Packett <val@packett.cool>
In-Reply-To: <176213091335.301408.9120443011267055817.b4-ty@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/2/25 9:48 PM, Sebastian Reichel wrote:

> On Sun, 12 Oct 2025 20:32:17 -0300, Val Packett wrote:
>> Currently, upowerd is unable to turn off the battery preservation mode[1]
>> on Qualcomm laptops, because it does that by setting the start threshold to
>> zero and the driver returns an error:
>>
>> pmic_glink.power-supply.0: charge control start threshold exceed range: [50 - 95]
>>
>> Kernel documentation says the end threshold must be clamped[2] but does
>> not say anything about the start threshold.
>>
>> [...]
> Applied, thanks!
>
> [1/2] power: supply: qcom_battmgr: clamp charge control thresholds
>        commit: 8809980fdc8a86070667032fa4005ee83f1c62f3
> [2/2] power: supply: qcom_battmgr: support disabling charge control
>        commit: 446fcf494691da4e685923e5fad02b163955fc0e


Woahh.. please revert the second one.

I'm sorry, I thought this was discussed here but apparently it was only 
on IRC and I must've assumed that the patches weren't going anywhere 
because of the lack of R-b..

The disable bit was acting rather strange after all, we'd need more work 
to figure out if that's even possible. Let's leave it at the clamp only.

~val


