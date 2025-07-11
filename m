Return-Path: <linux-kernel+bounces-727742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72764B01EFC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81EE41897628
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 14:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A582E54D5;
	Fri, 11 Jul 2025 14:21:31 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F3A2E499A
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 14:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752243691; cv=none; b=SxalghWT7qSIdeJl30C5BKxq+0Gvl8fVYzIxNobG3dyiy/AHL5slGrd8I7pDCMHZbzUhwOKaQAILXmzI0plUwI8dyzP4cSkWmlfxH2D2S1qWBnRnScMq96n509cbRaXZvhP3mbYE82QTSOSSDWh6XM7kZmEBHLUCaJ4s3dEEIdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752243691; c=relaxed/simple;
	bh=jAxICgxAKU72VhtadAurLR5kQDgH+znKn/i5qyNAZzI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LjBsC10bHN9vPBZiSAwq4ZNQ4Gy1Fd+AwBSTLDCp/rmX8XxiLYpy/Dw4v3E23rqCIzJDEwGq9DhL/ydp6KrDuPAFqxHDMEnOejeW+hRHkI66rIsu9e3nzRllh3iN0zi2AwO7CeqM3sKG+BAR1jteja4dh4Bj2Shlz+Z9MroUUEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bdv273Qt7z6L55H;
	Fri, 11 Jul 2025 22:18:07 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id BABF81402EF;
	Fri, 11 Jul 2025 22:21:25 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 11 Jul
 2025 16:21:25 +0200
Date: Fri, 11 Jul 2025 15:21:23 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Ben Horgan <ben.horgan@arm.com>
CC: James Morse <james.morse@arm.com>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>,
	<sudeep.holla@arm.com>, Rob Herring <robh@kernel.org>, Catalin Marinas
	<catalin.marinas@arm.com>, <WillDeaconwill@kernel.org>
Subject: Re: [PATCH v2 1/3] cacheinfo: Set cache 'id' based on DT data
Message-ID: <20250711152123.00002153@huawei.com>
In-Reply-To: <9a1ae272-3128-425b-828d-50b2289a6cb8@arm.com>
References: <20250704173826.13025-1-james.morse@arm.com>
	<20250704173826.13025-2-james.morse@arm.com>
	<9495df36-053e-49a3-8046-1e6aed63b4af@arm.com>
	<20250707133207.00001b88@huawei.com>
	<89c6f2a2-e084-4899-a6d6-819917eb6324@arm.com>
	<9a1ae272-3128-425b-828d-50b2289a6cb8@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 10 Jul 2025 12:24:01 +0100
Ben Horgan <ben.horgan@arm.com> wrote:

> Hi James and Jonathan,
> 
> On 7/10/25 12:15, James Morse wrote:
> > Hi Ben, Jonathan,
> > 
> > On 07/07/2025 13:32, Jonathan Cameron wrote:  
> >> On Mon, 7 Jul 2025 11:27:06 +0100
> >> Ben Horgan <ben.horgan@arm.com> wrote:  
> >>> On 7/4/25 18:38, James Morse wrote:  
> >>>> From: Rob Herring <robh@kernel.org>
> >>>> Use the minimum CPU h/w id of the CPUs associated with the cache for the
> >>>> cache 'id'. This will provide a stable id value for a given system. As
> >>>> we need to check all possible CPUs, we can't use the shared_cpu_map
> >>>> which is just online CPUs. As there's not a cache to CPUs mapping in DT,
> >>>> we have to walk all CPU nodes and then walk cache levels.
> >>>>
> >>>> The cache_id exposed to user-space has historically been 32 bits, and
> >>>> is too late to change. This value is parsed into a u32 by user-space
> >>>> libraries such as libvirt:
> >>>> https://github.com/libvirt/libvirt/blob/master/src/util/virresctrl.c#L1588
> >>>>
> >>>> Give up on assigning cache-id's if a CPU h/w id greater than 32 bits
> >>>> is found.  
> >   
> >>>> diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
> >>>> index cf0d455209d7..df593da0d5f7 100644
> >>>> --- a/drivers/base/cacheinfo.c
> >>>> +++ b/drivers/base/cacheinfo.c
> >>>> @@ -183,6 +184,42 @@ static bool cache_node_is_unified(struct cacheinfo *this_leaf,
> >>>>    	return of_property_read_bool(np, "cache-unified");
> >>>>    }
> >>>>    
> >>>> +static bool match_cache_node(struct device_node *cpu,
> >>>> +			     const struct device_node *cache_node)
> >>>> +{
> >>>> +	for (struct device_node *cache __free(device_node) = of_find_next_cache_node(cpu);  
> >>> Looks like the creation of this helper function has upset the
> >>> device_node reference counting. This first __free(device_node) will only
> >>> cause of_node_put() to be called in the case of the early return from
> >>> the loop. You've dropped the second __free(device_node) which accounts
> >>> for 'cache' changing on each iteration.  
> > 
> > Heh, I just took this hunk verbatim. Fixing this up with the __free() magic is tricky as
> > the existing patterns all drop the reference to cpu, which we don't want to do here. I
> > think at this point the __free() magic is just making this harder to understand. How about
> > the old fashioned way:
> > 
> > | static bool match_cache_node(struct device_node *cpu,
> > |                              const struct device_node *cache_node)
> > | {
> > |         struct device_node *prev, *cache = of_find_next_cache_node(cpu);
> > |
> > |         while (cache) {
> > |                 if (cache == cache_node) {
> > |                         of_node_put(cache);
> > |                         return true;
> > |                 }
> > |
> > |                 prev = cache;
> > |                 cache = of_find_next_cache_node(cache);
> > |                 of_node_put(prev);
> > |         }
> > |
> > |         return false;
> > | }  
> Ok with me.
Agreed. 

> > 
> >   
> >> Good catch - this behaves differently from many of the of_get_next* type
> >> helpers in that it doesn't drop the reference to the previous iteration
> >> within the call.
> >>
> >> Maybe it should?
> >>
> >> I checked a few of the call sites and some would be simplified if it did
> >> others would need some more complex restructuring but might benefit as
> >> well.  
> > 
> > If it did, we'd end up dropping the reference to cpu on the way in, which
> > of_get_next_cpu_node() in for_each_of_cpu_node() was expecting to do.  
> 
> Yes, I think the blurring of the lines between a cpu node and cache node 
> is at least partially to blame for the confusion here.
Yes.  That is more than a little ugly!

> > 
> > 
> > Thanks,
> > 
> > James  
> 
> Thanks,
> 
> Ben
> 
> 


