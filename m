Return-Path: <linux-kernel+bounces-863183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC98BF732A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 16:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 147B01887140
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 14:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0838434027D;
	Tue, 21 Oct 2025 14:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hRQM+nfy"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3944B166F1A
	for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 14:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761058572; cv=none; b=TEuSsW1Q1ylPtGd3el/4xx9sI33CcAPs9YbRHkN08PGxgzb3qQzmgUtlWovOPs3Y6oNAj6ciyETDaEYgEyhNJcMS3o8Bd1rgjIT9XdLMXpixR2NEGwqJPGZTEfHGoZiDpy+DcjYFxVkqkgqFYWhBcpNuTFd8HGYiVK/qD048lk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761058572; c=relaxed/simple;
	bh=yDUKZOmUdpEspEjk38NCEBEi7RBBSKGRQVxFp4ovgCY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=h3T6E+/6z5bFAfmm4BTxSHJuUT/MYMsV+siHGIkEcjR6KNQbby/fsk8TaxS+SYGsQtJxM5mw8i/ByHHzXRC2irxTZCej8xaFGntIvkwn0jgqjH1AJv9Lnjk82OwIGBTbWLPdA2ZvZVzlOJ+lrQNrfI/yYeA4/Uww9v4Snfwj7DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hRQM+nfy; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761058568;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yDUKZOmUdpEspEjk38NCEBEi7RBBSKGRQVxFp4ovgCY=;
	b=hRQM+nfyh7A02n5iI1IGpmRje6J6ewsfaTrZsA+WprPNBIa4qZTZM1++K0BmPWbC6Kwfun
	ea0C9zH9GBjZkWuwO20xZv26CXvWFGlH7XgQSQIfxQ2KzQCBEgMCJuO/rtHsuBiPqYFrEa
	F3wpC1hH1PzYQSO1Fb614Ew/RZEqarM=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: William Kucharski <william.kucharski@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,  Andrew Morton
 <akpm@linux-foundation.org>,  Christoph Lameter <cl@gentwo.org>,  David
 Rientjes <rientjes@google.com>,  Harry Yoo <harry.yoo@oracle.com>,  Paul
 Mundt <lethal@linux-sh.org>,  linux-mm@kvack.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Remove reference to destructor in comment in
 calculate_sizes()
In-Reply-To: <20251021110004.2209008-1-william.kucharski@oracle.com> (William
	Kucharski's message of "Tue, 21 Oct 2025 05:00:04 -0600")
References: <20251021110004.2209008-1-william.kucharski@oracle.com>
Date: Tue, 21 Oct 2025 07:55:57 -0700
Message-ID: <87sefc5mo2.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

William Kucharski <william.kucharski@oracle.com> writes:

> The commit that removed support for destructors from kmem_cache_alloc()
> never removed the comment regarding destructors in the explanation
> of the possible relocation of the free pointer in calculate_sizes().
>
> Fixes: 20c2df83d25c ("mm: Remove slab destructors from kmem_cache_create().")
> Signed-off-by: William Kucharski <william.kucharski@oracle.com>

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thanks!

