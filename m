Return-Path: <linux-kernel+bounces-895848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id ED39DC4F1D6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 17:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 751264F50DD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8783B3730DD;
	Tue, 11 Nov 2025 16:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F9eTogNq"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214893730DA
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 16:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762879560; cv=none; b=oin1inF96x9Du4/eAFK6II8qfYr5ISznC0cG3itWzWFA5rXQl4KUXjlbrZsC8/1nWbv9DThAhoW9Ag+4SQ6m3yQl4Wdq9l+FAAZiXK1jGPihXlzwKRYeAmLfSmyEbA61gUIk90H1UB0I+R+eT0lfIV5V9lShHqNDmmJMCx45bVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762879560; c=relaxed/simple;
	bh=6asq6D0YWk1clzZ0WCtlMvMA5lEjdT6pWxHqsmk527s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KuFYyZywLvjjYESlE2WqNAo0sB6z6xKUrx1OwUI75/yoSyL5mKKQz9nYc/GRqBupZrEUcwar3BEYA1uL/toxOmCfOrfda/7mQZJvGbxiB9bEYViejpZKdAR2zikT0HNXTHDvwfBeS8UmugF+1TNK50v5+Y8oH9ZqjhiDvyHlxVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F9eTogNq; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 11 Nov 2025 08:45:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762879554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QwOueIDR7iQLq0yktgbr0XMz1VzOnqj2R/QpQ9bY1ZU=;
	b=F9eTogNqMIrPlvSuExmQ7EbcOmA1oJ69tHiAS8UUnOhVS46t4pAhkZk06/DWTS/NIUIpNb
	+/DQ/LxknjCDPtzBy6dEgLfsIALH8ubWqhQMCDNWkTDOMj881YgTFWO1j7vJ0gKl+Up/1a
	D1/ypSEWvsjRVuIdcvJ94kIBOg8oezU=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Harry Yoo <harry.yoo@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/4] memcg: cleanup the memcg stats interfaces
Message-ID: <xjwmyqdjynpeuqtgxiz3igynjl4ywopdc33lteidgmp5yez2ed@pbdfsekytezn>
References: <20251110232008.1352063-1-shakeel.butt@linux.dev>
 <0618ea79-fed3-4d4d-9573-2be49de728cf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0618ea79-fed3-4d4d-9573-2be49de728cf@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Tue, Nov 11, 2025 at 04:36:14PM +0800, Qi Zheng wrote:
> Hi Shakeel,
> 
> On 11/11/25 7:20 AM, Shakeel Butt wrote:
> > The memcg stats are safe against irq (and nmi) context and thus does not
> > require disabling irqs. However for some stats which are also maintained
> > at node level, it is using irq unsafe interface and thus requiring the
> > users to still disables irqs or use interfaces which explicitly disables
> > irqs. Let's move memcg code to use irq safe node level stats function
> > which is already optimized for architectures with HAVE_CMPXCHG_LOCAL
> > (all major ones), so there will not be any performance penalty for its
> > usage.
> 
> Generally, places that call __mod_lruvec_state() also call
> __mod_zone_page_state(), and it also has the corresponding optimized
> version (mod_zone_page_state()). It seems necessary to clean that up
> as well, so that those disabling-IRQs that are only used for updating
> vmstat can be removed.

I agree, please take a stab at that.

