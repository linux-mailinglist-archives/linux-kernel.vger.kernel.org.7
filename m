Return-Path: <linux-kernel+bounces-736024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3CBB096E5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 00:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4D124E27A2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 22:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B7923504B;
	Thu, 17 Jul 2025 22:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sh3QseuT"
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E1AA94F
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 22:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752791306; cv=none; b=aOSagDuG3IVrEtqM6xfSRbQpIcpoxrf5FQ60eCjE9H7rMECyLzpCfrxNRRLObh05QLVo6N2SEbapUvIsITUOfLWueVWSYwBL5vo1+PKXGGOCQfgJSuttqqWRfPBGFpqjFDggFqP8mO1rycW4apRSezve1excNiCZ0TFe7FnFPm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752791306; c=relaxed/simple;
	bh=9pnwemDfsJJ9Utt9KeUW7y3GiPholRm/1li7y0SQuCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVOuK1sewUWue76GzDsxTWNL/OibVp0HI5ueuOKrQ7kTI0IhU2FSD18EXpixWTGmH947BP8OmkVHTuX87naqoPj+Gg/f6CQko1sSyG+IQulIbCZrgkxWvw8j/F5Dp3gPoxUVpg2U9YnzZRXPFU7NpdGIJp1zVJYYW2HeLGUKfgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sh3QseuT; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 17 Jul 2025 15:28:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752791301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zh/7SvM91qR9TIyz9SW2o/sNWa9jLbdEppcVWn32jKo=;
	b=sh3QseuTc8ReToJ3keoCgDR0PR/3rgRLKUOVpi5CEdMIp9i9ELULiCypr8sMVSd3PSW4Ze
	Bpd9xZsRn3/onTH99B/PapI6OfekxlNykKI30hmN7VFtdr2as0/mRsrDUPq072FcaAj8Sx
	dUqeOi8cksTmaWshphj0OV83TI+qC+s=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: akpm@linux-foundation.org, mhocko@kernel.org, hannes@cmpxchg.org, 
	roman.gushchin@linux.dev, yosryahmed@google.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] mm: introduce per-node proactive reclaim interface
Message-ID: <6utnw5xyyjqo7o3bsn3s2vp5hfl7ujt4hiyluodhdw4mmzgr22@4vxkkw2kb57y>
References: <20250623185851.830632-1-dave@stgolabs.net>
 <20250623185851.830632-5-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623185851.830632-5-dave@stgolabs.net>
X-Migadu-Flow: FLOW_OUT

On Mon, Jun 23, 2025 at 11:58:51AM -0700, Davidlohr Bueso wrote:
> This adds support for allowing proactive reclaim in general on a
> NUMA system. A per-node interface extends support for beyond a
> memcg-specific interface, respecting the current semantics of
> memory.reclaim: respecting aging LRU and not supporting
> artificially triggering eviction on nodes belonging to non-bottom
> tiers.
> 
> This patch allows userspace to do:
> 
>      echo "512M swappiness=10" > /sys/devices/system/node/nodeX/reclaim
> 
> One of the premises for this is to semantically align as best as
> possible with memory.reclaim. During a brief time memcg did
> support nodemask until 55ab834a86a9 (Revert "mm: add nodes=
> arg to memory.reclaim"), for which semantics around reclaim
> (eviction) vs demotion were not clear, rendering charging
> expectations to be broken.
> 
> With this approach:
> 
> 1. Users who do not use memcg can benefit from proactive reclaim.
> The memcg interface is not NUMA aware and there are usecases that
> are focusing on NUMA balancing rather than workload memory footprint.
> 
> 2. Proactive reclaim on top tiers will trigger demotion, for which
> memory is still byte-addressable. Reclaiming on the bottom nodes
> will trigger evicting to swap (the traditional sense of reclaim).
> This follows the semantics of what is today part of the aging process
> on tiered memory, mirroring what every other form of reclaim does
> (reactive and memcg proactive reclaim). Furthermore per-node proactive
> reclaim is not as susceptible to the memcg charging problem mentioned
> above.
> 
> 3. Unlike the nodes= arg, this interface avoids confusing semantics,
> such as what exactly the user wants when mixing top-tier and low-tier
> nodes in the nodemask. Further per-node interface is less exposed to
> "free up memory in my container" usecases, where eviction is intended.
> 
> 4. Users that *really* want to free up memory can use proactive reclaim
> on nodes knowingly to be on the bottom tiers to force eviction in a
> natural way - higher access latencies are still better than swap.
> If compelled, while no guarantees and perhaps not worth the effort,
> users could also also potentially follow a ladder-like approach to
> eventually free up the memory. Alternatively, perhaps an 'evict' option
> could be added to the parameters for both memory.reclaim and per-node
> interfaces to force this action unconditionally.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

After Roman's suggestion, you can add:

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

