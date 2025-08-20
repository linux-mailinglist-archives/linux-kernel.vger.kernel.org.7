Return-Path: <linux-kernel+bounces-778589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73962B2E7AD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 23:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25AD1189502A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 21:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D9632C323;
	Wed, 20 Aug 2025 21:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pqokFFkP"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 303AF222584
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 21:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755726400; cv=none; b=UGxhHCX0F/UogbOgCcoS6aqEM7/Ll0RMJ3dnERcWlKhedLGQocuGQZS6nJDxmvMJm9SO4E4yNMb3lHhvq55O5rCj7sgV8g6XppeBXxVRk41R+YzlSPcOZ1qAXHNw1W4GOO4S+MrbowUGGtjZ8F5U/gUxSbnRXjzyIyG12Bfztz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755726400; c=relaxed/simple;
	bh=nAmsrVmXRubjdWSnMjMOIY/7nVoWipB3Niubb5P1yrY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ooZ3QoDCi+AkevI2AxgAlpF5lVYwRaxfxu1gNlrquIppOF0FD3mXJcuBc/j+1hKY0Cn9FViTsxcGNG1CGBXRynh2/66F1wqYirzmDrSkfWTsWV3b2Fhl34TTHgvJlYXQwyHjOclWJL/UQjScyx293EZpXtYbnBOe3mWQH83HShg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pqokFFkP; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755726395;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Fdn7x+MRstp/cyQ50OC/Ms9s4EcFQezvc/PIsjppwmo=;
	b=pqokFFkPuxTaBNGObiPKAPtaNiarSwdliFY4dVy5EGweTjGrG34vv6aFpcxnsQtJpyXaib
	dOhUrGodRq9f9CyNLZuPLk5Lj5aPMntXUV4EQzkJLdNZc4kqTubpVGdYWyMK1/51jEwl25
	vRCdNUMTZHKCTOQctxxlXJ8pJe9UudM=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] misc: ad525x_dpot: Use str_enabled_disabled() in
 sysfs_show_reg()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <2025082052-crawfish-revisable-7965@gregkh>
Date: Wed, 20 Aug 2025 23:46:20 +0200
Cc: Michael Hennerich <michael.hennerich@analog.com>,
 Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <AAE18711-427E-4A40-9798-AFEBD24743C3@linux.dev>
References: <20250820102734.760844-2-thorsten.blum@linux.dev>
 <2025082052-crawfish-revisable-7965@gregkh>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
X-Migadu-Flow: FLOW_OUT

On 20. Aug 2025, at 13:15, Greg Kroah-Hartman wrote:
> On Wed, Aug 20, 2025 at 12:27:34PM +0200, Thorsten Blum wrote:
>> Remove hard-coded strings by using the str_enabled_disabled() helper
>> function and silence the following Coccinelle/coccicheck warning
>> reported by string_choices.cocci:
>> 
>>  opportunity for str_enabled_disabled(..)
>> 
>> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
>> ---
> 
> If you are going to change this, might as well call sysfs_emit() as
> well, right?

I guess, but probably in another patch because it's two separate things?

> that way you get two coccicheck warnings at once :)

I didn't look into it, but device_attr_show.cocci doesn't produce any
warnings for drivers/misc/* (at least not for me).

Thanks,
Thorsten


