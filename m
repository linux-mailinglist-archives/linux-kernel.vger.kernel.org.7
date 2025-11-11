Return-Path: <linux-kernel+bounces-894540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8299FC4B448
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 04:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 76E324EAAB2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 03:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4831123D28B;
	Tue, 11 Nov 2025 03:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="noQmNNpG"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2318533E7
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 03:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762830034; cv=none; b=ajg+81xk1oQ/Ny0iT9iAbPJB+gu/YRVT8vdbvQsDVJRTeWiaN4BOZsTerRFMPc4BTQ3q4nPWQx8fzi+O9v0jfqHExfCK5IusS3lvDZBVf6KV8DGmkAIHmEFpHjLSosUV8cH4sgmbzsXOtom9kdiXZM+6TBCxJtYKXsA11zEnWgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762830034; c=relaxed/simple;
	bh=WaZ1quIzwngQ3WO6HkRzjGQCMLWlWIqFdIjof6f0ajI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K1xPsEQvpWA0H9Tp2pUQFndVL2+VUbF6CqHio7yK7SgXw9Xdk594NETgOwcqdaaQsfAjpGbd1qLihJnSjWCwY/8AZtUNcPByy8diB+7A/N3uLmg5ZhDE9Qn3HsWqOs1+gj9vHA7PVomFaHw6t4FVjsrXYGWtic26IJcamSsMVjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=noQmNNpG; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 10 Nov 2025 19:00:25 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762830030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5ul2ZY2G57orZgmpduBInIrETuK3NAIisOONEv3fwlE=;
	b=noQmNNpGXqeh55EPq5nX35rk2qS9h7N8CFJCxC2xW5/EEMWN4cxmYtu8eeQTlF2OVaBq4J
	aEiHGJ0In+usILEcVeIIEtQdJSVH5joV422aeigrCaAVnKZco27cq/idJjdw5XR9IOoC6+
	piVfwn4nRzlTsjOEEtTJ92jiQJQcTUM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: Harry Yoo <harry.yoo@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org, 
	cgroups@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH 0/4] memcg: cleanup the memcg stats interfaces
Message-ID: <hgf4uciz7rp2mpxalcuingafs5ktmsgvom2pefjv3yogel5dh3@7kkwtrnqotnc>
References: <20251110232008.1352063-1-shakeel.butt@linux.dev>
 <aRKKfdN3B68wxFvN@hyeyoo>
 <24969292-7543-456f-8b80-09c4521507e2@linux.dev>
 <gsew67sciieqxbcczp5mzx4lj6pvvclfrxn6or3pzjqmj7eeic@7bxuwqgnqaum>
 <99429fb8-dcec-43e7-a23b-bee54b8ed6e6@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <99429fb8-dcec-43e7-a23b-bee54b8ed6e6@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Tue, Nov 11, 2025 at 10:48:18AM +0800, Qi Zheng wrote:
> Hi Shakeel,
> 
> On 11/11/25 10:39 AM, Shakeel Butt wrote:
> > On Tue, Nov 11, 2025 at 10:23:15AM +0800, Qi Zheng wrote:
> > > Hi,
> > > 
> > [...]
> > > > 
> > > > Are you or Qi planning a follow-up that converts spin_lock_irq() to
> > > > spin_lock() in places where they disabled IRQs was just to update vmstat?
> > > 
> > > Perhaps this change could be implemented together in [PATCH 1/4]?
> > > 
> > > Of course, it's also reasonable to make it a separate patch. If we
> > > choose this method, I’m fine with either me or Shakeel doing it.
> > > 
> > 
> > Let's do it separately as I wanted to keep the memcg related changes
> > self-contained.
> 
> OK.
> 
> > 
> > Qi, can you please take a stab at that?
> 
> Sure, I will do it.
> 
> > 
> > > > 
> > > > Qi's zombie memcg series will depends on that work I guess..
> > > 
> > > Yes, and there are other places that also need to be converted, such as
> > > __folio_migrate_mapping().
> > 
> > I see __mod_zone_page_state() usage in __folio_migrate_mapping() and
> > using the same reasoning we can convert it to use mod_zone_page_state().
> > Where else do you need to do these conversions (other than
> > __folio_migrate_mapping)?
> 
> I mean converting these places to use spin_lock() instead of
> spin_lock_irq().

For only stats, right?

