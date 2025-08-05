Return-Path: <linux-kernel+bounces-757010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F0DB1BC53
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 00:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C13AF18A54CF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 22:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBBB253932;
	Tue,  5 Aug 2025 22:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kr7O7WRw"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0591D5AB7
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 22:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754431381; cv=none; b=D29aEJp0WwviWa+Y30O3npSpUzku0Y3P/iyaUo4Lo5GtZlC+i/RfGvHISDb2tQpEXD6TYvr/5aTe608aWFur8z92Z4RMUB/ToJC+/5oFJiSpVNb5+dHnNfU9/Y+fYeYyd5m/o9VGnUdRaN5sksMVRNBBVwAWMfG5kChJCSYOWUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754431381; c=relaxed/simple;
	bh=d5TkrEbLHEN+FxVF9A7Yh7YQ6z+4BIBtcBTz0GYsdmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uK6vIZXUSGLFktNZhmVCoJDzEfiID8xhnPmROolDjXh5fIQaBhyCPKm+3XC0dQPvgnqmRmUmLX9iG4CdeS1pY1fOTsPH0ENB9u7VnM0gZbb0LQHl62G4yrqrmSx0Mz7C6GV1q9Kts1M2rRRFBvyYd/8TrkNg7xRpV364DFj83p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kr7O7WRw; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3c426447-e2b9-4c81-8fc2-7cf7e36660d2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754431377;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ez2C2OAgBeMciXBR/9ziwB88bSx7rB1jiAVUqpft0y0=;
	b=kr7O7WRwZkhdIDqHHSrr6Y8PAQhUdIndp5EkK8M0u59gQIN6aSpVFLbEvW3qqcaTSxaLb3
	82q31ru/fk3dAm7044JYssSMWy/ZmaIh5Bu1pmjmaTrU8CuPuWyBfvgBBtRto8zHOylQEw
	/1YgidHpvsbDWAj1OVOqPv6LngUqQIw=
Date: Tue, 5 Aug 2025 18:02:45 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 7/7] net: axienet: Split into MAC and MDIO
 drivers
To: Andrew Lunn <andrew@lunn.ch>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Michal Simek <michal.simek@amd.com>,
 Leon Romanovsky <leon@kernel.org>
References: <20250805153456.1313661-1-sean.anderson@linux.dev>
 <20250805153456.1313661-8-sean.anderson@linux.dev>
 <c320da3b-6e55-474a-93d6-666092b70774@lunn.ch>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <c320da3b-6e55-474a-93d6-666092b70774@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 8/5/25 17:40, Andrew Lunn wrote:
>> Fixes: 1a02556086fc ("net: axienet: Properly handle PCS/PMA PHY for 1000BaseX mode")
> 
> If this is for net-next, please don't have a Fixes: tag.

This is a fix. But as explained in the cover letter this is quite an
involved fix for an uncommon bug. I can target net if you like.

>>  struct axienet_common {
>>  	struct platform_device *pdev;
>> +	struct auxiliary_device mac;
>>  
>>  	struct clk *axi_clk;
>>  
>>  	struct mutex reset_lock;
>> -	struct mii_bus *mii_bus;
>> +	struct auxiliary_device mii_bus;
> 
> Keeping the name mii_bus for something which is not an struct mii_bus
> is going to cause confusion. Please give it a different name.

Like mdio?

> This is another patch which needs splitting up.

I don't think it can be split up in any major way. The whole conversion
of the MAC/MDIO portions of the driver has to be done at the same time
as the parent driver is converted to use them.

--Sean

