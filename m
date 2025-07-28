Return-Path: <linux-kernel+bounces-748594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBCBB14378
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 22:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D5054E0F02
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 20:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CFC215798;
	Mon, 28 Jul 2025 20:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XHlpLnWe"
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C741C5D53
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 20:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753735741; cv=none; b=kq4F3dhz7KBUNrHWWMRxzSbnt9RF5riECRMka6MWSdIWoGDoA25U05lRtaIjB5UImYywB8fOtoBxJ+Ryvi+15u3Rrd6KzzBS91nMja9EqYiz3XNY+sHwQh7YRWjiu3Zq55aGd8JLKm/imuNQJ5qQDXcw51mH7aVv0PiCa68QeqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753735741; c=relaxed/simple;
	bh=5vwNtBAiZrAV+LEFtAVdpBBw7PWwXIOyH0M/XgHDsdU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nQ5MiAJ4h7apOS15I9RSW2dLK4A3weYh34hFid+iyb5uqh9mblhLwPrWznk0SGkqZUD74lAxbG5oLiZ0e2BtQCtEYpSUIMjP2kWAtJArD8EBtC5qdo65/SPs4ajkZBxH+Pj8xCUxg4scvOPpsJamuJ7RisjE1rWX4J0KRkxR0w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XHlpLnWe; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <23db6029-5e1d-4e52-8fd5-80eab09551af@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753735726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J3NoJR90pH6xEaxazCzJ2C43aRHAtpWnwhAUBAVQ704=;
	b=XHlpLnWeJDhUA2ULXvC1IfxhatZ+nIFwlY3QP+G5wCzx+DsGwSdLtylLKgC+IlVaCDz/Df
	4iHcrVKhziHYh870FR3IwyGvjj5HKO8zbL5KR1pRm127GT1qyQvuhd8SSLPg9VICf2SuIU
	syxmk1PqEeVNE1Azj3Mb8bbFrIeHQeY=
Date: Mon, 28 Jul 2025 16:48:39 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [ANN] netdev call - Jul 29th
To: Daniel Golle <daniel@makrotopia.org>, Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Russell King <linux@armlinux.org.uk>,
 Vineeth Karumanchi <vineeth.karumanchi@amd.com>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Christian Marangi <ansuelsmth@gmail.com>, Lei Wei <quic_leiwei@quicinc.com>,
 Michal Simek <michal.simek@amd.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
 Robert Hancock <robert.hancock@calian.com>, John Crispin <john@phrozen.org>,
 Felix Fietkau <nbd@nbd.name>, Robert Marko <robimarko@gmail.com>,
 Frank Wunderlich <frank-w@public-files.de>, linux-kernel@vger.kernel.org,
 netdev-driver-reviewers@vger.kernel.org
References: <20250728085356.3f88e8e4@kernel.org>
 <aIfhVdMj1K6Bd2-F@pidgin.makrotopia.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <aIfhVdMj1K6Bd2-F@pidgin.makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Daniel,

On 7/28/25 16:45, Daniel Golle wrote:
> Hi!
> 
> On Mon, Jul 28, 2025 at 08:53:56AM -0700, Jakub Kicinski wrote:
>> Hi!
>> 
>> The bi-weekly call is scheduled for tomorrow at 8:30 am (PT) / 
>> 5:30 pm (~EU), at https://bbb.lwn.net/rooms/ldm-chf-zxx-we7/join
>> 
>> We have one agenda topic - Arkadiusz Kubalewski says:
>> 
>>   Wanted to meet and discuss the need for clock id on microchip driver
>>   provided by Ivan, I hope we could have a meeting to brainstorm some
>>   ideas and decide next steps on how to deal with such cases.
>> 
>> I can also provide a quick update on the netdev foundation activities.
> 
> Christian Marangi and me would like to join you this week in order to
> discuss how to proceed with the groundworks for standalone PCS drivers.
> 
> See also:
> https://lore.kernel.org/all/20250709135216.GA721198@horms.kernel.org/
> 
> I know this is kinda short notice, but it would be great to add this to
> the agenda and decide in which direction we should go.

I have a conflict at that time, although I could join at 12.

--Sean

