Return-Path: <linux-kernel+bounces-640455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B9AAB04E5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 22:49:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD7B27B3DD6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 May 2025 20:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509A82040A8;
	Thu,  8 May 2025 20:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XNjoyHxy"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4C71D63F5
	for <linux-kernel@vger.kernel.org>; Thu,  8 May 2025 20:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746737349; cv=none; b=P9HOmb/K4btQusCPA6ANpQW7yFX+E/dYiOfhXCltDBuyv7BpZPwWn7xgJb+FEgtOoWHEyqAT9w6AraDeH0eLw1y0p4HcB7omhUUKSD+WfPEGzHya80YGiI5eWsBv1BljYgP/WZTsm0TRB1fJKcR7X37C52Tg2+Hk0WyuVVuqQuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746737349; c=relaxed/simple;
	bh=2O+95E7zO9i3cGRl3SSpYMaA6Ah/SQh5GryTuc2IF10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qlBxYMorGIINUy9SHQWsoqVy9qZCU6+RspA5V4e1WzOv5YL8l1tCtGrvo4lP9te+auKsnDgKVcsSG2scxwe+yY1yw2ZHt7ZAEgAf00p9RJBANIKdxetgBBo2T4nsJHtHJnCOzuywWArodPGjdjlQBwXyiCoun7YtJleAphO9n78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XNjoyHxy; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <1aab25ca-aed5-4041-a42a-59922b909c02@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1746737334;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5EEjFOogoiiYPhLwD0L/W9+kfxiWffHlG4VpQTz/XW4=;
	b=XNjoyHxyH8VD4DhVXOrDqGN6m2BB1Apf1zrQ05VyAgxPP+e/FVbjipXV20iBOG9zLYUM5E
	FUh/gBqmw54T0/MQZfRqzfVVe8AOlJ9WgCojkmjArwzC2gRJhlCuUKKszH1rXc8cdZ0+YM
	5qEFaK3OrpgXR3zhDCSvUZY0EvmcR8g=
Date: Thu, 8 May 2025 21:48:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] net: dsa: convert to ndo_hwtstamp_get() and
 ndo_hwtstamp_set()
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, =?UTF-8?Q?K=C3=83=C2=B6ry_Maincent?=
 <kory.maincent@bootlin.com>, Kurt Kanzenbach <kurt@linutronix.de>,
 Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Woojung Huh <woojung.huh@microchip.com>,
 UNGLinuxDriver@microchip.com, Claudiu Manoil <claudiu.manoil@nxp.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Simon Horman <horms@kernel.org>, Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
References: <20250508095236.887789-1-vladimir.oltean@nxp.com>
 <21e9e805-1582-4960-8250-61fe47b2d0aa@linux.dev>
 <20250508204059.msdda5kll4s7coti@skbuf>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250508204059.msdda5kll4s7coti@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 08/05/2025 21:40, Vladimir Oltean wrote:
> On Thu, May 08, 2025 at 09:25:14PM +0100, Vadim Fedorenko wrote:
>> The new interface also supports providing error explanation via extack,
>> it would be great to add some error messages in case when setter fails.
>> For example, HIRSCHMANN HellCreek switch doesn't support disabling
>> of timestamps, it's not obvious from general -ERANGE error code, but can
>> be explained by the text in extack message.
> 
> I wanted to keep the patches spartan and not lose track of the conversion
> subtleties in embelishments like extack messages which can be added later
> and do not require nearly as much attention to the flow before and after.
> I'm afraid if I say "yes" here to the request to add extack to hellcreek
> I'm opening the door to further requests to do that for other DSA drivers,
> and sadly I do not have infinite time to fulfill them. Plus, I would
> like to finalize the conversion tree-wide by the end of this development
> cycle.
> 
> Even if I were to follow through with your request, I would do so in a
> separate patch. I've self-reviewed this patch prior to posting it, and I
> was already of the impression that it is pretty busy as it is.

I agree that the patch is pretty busy, and the extack additions should
go into separate patch. The only thing which bothers me is that it may 
never happen if it's not done with this patch.

Anyway, the conversion code looks good, so

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

