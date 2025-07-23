Return-Path: <linux-kernel+bounces-742416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6EBB0F168
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 13:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60413580DCD
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 11:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4952E11B0;
	Wed, 23 Jul 2025 11:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aW3f+BSi"
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7449128A706;
	Wed, 23 Jul 2025 11:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753270733; cv=none; b=jmbTHFPNIJycecclGuz7FlkqdAlwNiIqMRCAvKrCTSHo3aKCDGIXlwxzydLOt8quI6JUw9LgTC8R5aTj6fp9t58Lrn3elpRWrAVsRuhJGWQAZD5pkvkIA8hSUrmCuMhdFLLwMQvirB86rCe9RdbycZCDMS8jQrG3nZT7ug+BNHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753270733; c=relaxed/simple;
	bh=zSboYXKx0N+K51GLU5TT/9hPklFmlORrWjoKaBQgZzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=crvp0u+Rijrbx4bN1ew0caKWX9bZ4LobpUErhtDUxkvENYfPY2lN2yJgmtZ+smNE3yflxQwBkVtKgS/OQxnXrWVATlsTEjjFaogVme+vprHZ8b1eSYMxcgBSQ5L95UBCi4YwF3A/WxVp8R29eaIv9ZrUX/qG3Of12fCNUh5MSVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aW3f+BSi; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 23 Jul 2025 07:38:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753270729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pTVDq7tqt4jNdxmpuXh4QXyl10dLJquaJYZ+1Q9DQZQ=;
	b=aW3f+BSiEqV6nwQRpRu5sDRX6g8o8us3mskDaHE/zN2IYxn0eNYZiiLEMOQ6b9vDC1ift4
	kIwb0sLOxyeqViTn1vkf6nqt9IZNeRdrzvBM8y+0KFCnHF64AoPX5rgSq6xOY1fsoy154j
	m6/5Xp+O+rcYdvrBpLoriv9icFznMtE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Zhenhua Huang <quic_zhenhuah@quicinc.com>, rientjes@google.com, 
	vbabka@suse.cz, cl@gentwo.org, roman.gushchin@linux.dev, surenb@google.com, 
	pasha.tatashin@soleen.com, akpm@linux-foundation.org, corbet@lwn.net, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, quic_tingweiz@quicinc.com
Subject: Re: [PATCH 1/1] mm: slub: Introduce one knob to control the track of
 slub object
Message-ID: <aqscos5ivap537qljhqa2pntrxfimfkfuflji62rl2picpvaiv@sams7xovbtn6>
References: <20250723080328.4012263-1-quic_zhenhuah@quicinc.com>
 <aICpMWKNvhveAzth@hyeyoo>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aICpMWKNvhveAzth@hyeyoo>
X-Migadu-Flow: FLOW_OUT

On Wed, Jul 23, 2025 at 06:19:45PM +0900, Harry Yoo wrote:
> The subject is a bit misleading. I think it should be something like
> "alloc_tag: add an option to disable slab object accounting".
> 
> On Wed, Jul 23, 2025 at 04:03:28PM +0800, Zhenhua Huang wrote:
> > Mem profiling feature tracks both "alloc_slab_page"(page level) and slub
> > object level allocations. To track object level allocations,
> > slabobj_ext consumes 16 bytes per object for profiling slub object if
> > CONFIG_MEMCG is set.
> > Based on the data I've collected, this overhead accounts for approximately
> > 5.7% of slub memory usage — a considerable cost.
> > w/ noslub  slub_debug=-
> > Slab:              87520 kB
> > w/o noslub slub_debug=-
> > Slab:              92812 kB
> 
> Yes, the cost is not small and I hate that we have to pay 16 bytes of
> memory overhead for each slab object when both memcg and memory profiling
> are enabled.

I believe we did something about this for page_obj_ext; the exact
pointer compression scheme we went with escapes me at the moment.

We did it for page and not slab because page_obj_ext is a large fixed
size overhead and the page allocator is slower anyways, but it's
conceivable we could do the same for slub if the memory overhead vs. cpu
overhead tradeoff is worth it.

And - pointer compression is a valuable technique in general; coming up
with some fast general purpose code (perhaps involving virtual mappings,
we're not so limited on virtual address space as we used to be) might be
worth someone's time exploring.

