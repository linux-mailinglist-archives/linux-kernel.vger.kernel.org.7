Return-Path: <linux-kernel+bounces-721906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C6BAFCF50
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 17:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E885C7ABBBD
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 15:32:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B5A1C4A0A;
	Tue,  8 Jul 2025 15:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ifMKTzzZ"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F36221C9E4
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 15:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751988848; cv=none; b=tMy+KgN1lvibTnGpRSgD39lKlLog8AJR3rV9Aoqe/TAS+l5HRgVr7o1LPT0/GafGfVCfSM+Ubecci6JEIgqmvJwGeZ+JCIHgatBvy0uFGQ/y5asDpFxsHV/XS+zlXHEBm7LlWNDGYe+4BtSyfH/odKPC5ifDCIfXYfgu4QzgoeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751988848; c=relaxed/simple;
	bh=ZhQARY+dMy04cmVCG3gKjNrTT6k7l5XUjHxmQQ3Odws=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=niYTkJijLAZxPg36+74ljr7V6lec1T1nyJDV41sMxF1RhItpHCR2mR8juq3CzFvUZ9Ka5m7QVzM7uiNOO9ePVxqRe8RQ8PM904YYM5hkMdB582e/ESofqWCEHONIq3RbAhX9x75iu5CSz7ZZqhNaohMHKaTl6heWN4+Vg1Ex3Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ifMKTzzZ; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <06710fb3-fc55-479e-b029-134f41fb93eb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1751988841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UikPezaKOR74LDrxg8ACKqHsuH0yXZu32wrnQNh+phc=;
	b=ifMKTzzZSNehwnTaGTAuaeH7r7ho9nFO+uR7Cs37lBKqjZPjj77jNkxFpkPFxX6gRmTI0p
	GKXquz0dWmM+t4G/M4xfAwNee465VUQrrPcm7XPOsi3UDS26Sqk2c/OHj4fEU/e/weWkSB
	IDum6qt7B0ZFVjFI6ycbReQeQ8GDsj8=
Date: Tue, 8 Jul 2025 11:33:46 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] net: phy: Don't register LEDs for genphy
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Florian Fainelli <f.fainelli@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Christian Marangi <ansuelsmth@gmail.com>
References: <20250707195803.666097-1-sean.anderson@linux.dev>
 <aGzduaQp3hWA5V-i@shell.armlinux.org.uk>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <aGzduaQp3hWA5V-i@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 7/8/25 04:58, Russell King (Oracle) wrote:
> On Mon, Jul 07, 2025 at 03:58:03PM -0400, Sean Anderson wrote:
>> If a PHY has no driver, the genphy driver is probed/removed directly in
>> phy_attach/detach. If the PHY's ofnode has an "leds" subnode, then the
>> LEDs will be (un)registered when probing/removing the genphy driver.
> 
> Maybe checking whether the PHY driver supports LEDs would be more
> sensible than checking whether it's one of the genphy drivers?

The genphy driver is special, since it is probed synchronously from
phy_attach. All other drivers are probed asynchronously and don't have
this problem.

>> This could occur if the leds are for a non-generic driver that isn't
>> loaded for whatever reason. Synchronously removing the PHY device in
>> phy_detach leads to the following deadlock:
>> 
>> rtnl_lock()
>> ndo_close()
>>     ...
>>     phy_detach()
>>         phy_remove()
>>             phy_leds_unregister()
>>                 led_classdev_unregister()
>>                     led_trigger_set()
>>                         netdev_trigger_deactivate()
>>                             unregister_netdevice_notifier()
>>                                 rtnl_lock()
>> 
>> There is a corresponding deadlock on the open/register side of things
>> (and that one is reported by lockdep), but it requires a race while this
>> one is deterministic.
> 
> Doesn't this deadlock exist irrespective of whether the genphy driver(s)
> are being used, and whether or not the PHY driver supports LEDs?

Nope.

--Sean

