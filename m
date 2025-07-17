Return-Path: <linux-kernel+bounces-736023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5561B096E4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 00:26:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E06B1C46842
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 22:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8CC23504B;
	Thu, 17 Jul 2025 22:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tx441+kg"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449ABA94F
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 22:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752791157; cv=none; b=l3j6BiIDRBSxxw4xE4hXbAYezlTSpAzhJhLxoZB6Lb4b+SyHMhVVBteDgx4F4VVHo9VtUzupTYJactVXsvyCeT0nuDsHvvpDXBDM8aiO1FheNeTQBqAYT7D+8VMi/gBk1ecelGuhWOZ1M94Mus27/1iNzh38zRuspaLEjYNYS+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752791157; c=relaxed/simple;
	bh=ff+PuEfLq0f+mSoCdnqwCELeQOcBC9/NO39To61gZj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B7ZozGr89RyPUD/0txwX1Dxg52iYYI1RK7pLYDYcjLUMc8iBJg1RKcdDBztTeMHTJSSBjwi6AiTxo30mlnWkvPs/sC6Muu2NBM+ZBIx3AX7dfFN+HNZo+EGNqdhFVG9JW6OOBCzR8hlW6sD5o3EuiPecT22jE29zza9pPy2KrXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tx441+kg; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 17 Jul 2025 15:25:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752791152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uz7nhPK8jyYRdmklZUgWgxVPE7irLBNH5W65gVbFxfA=;
	b=tx441+kg2VcagCsoBT6Bexvh3MQNgfZlZXtWbb74Cb+ky0RlCrErq49BV9cq3SNejlO2/p
	9ZY95cs+VZ0bqpFLOd6vwZBom1PVbiPOc/8LGqpUziNCbeKxRWtw1w4tnLpoCMCTVVK5NM
	e3T2dRyOHyT8wv/GZYclVFIP4Dd/qCQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: akpm@linux-foundation.org, mhocko@kernel.org, hannes@cmpxchg.org, 
	roman.gushchin@linux.dev, yosryahmed@google.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] mm/vmscan: make __node_reclaim() more generic
Message-ID: <o5jfl4awn5wzf62slfz52d2p6ic2vd5hr2puygcizc4jovlaeb@jgnp4l7iiye4>
References: <20250623185851.830632-1-dave@stgolabs.net>
 <20250623185851.830632-4-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623185851.830632-4-dave@stgolabs.net>
X-Migadu-Flow: FLOW_OUT

On Mon, Jun 23, 2025 at 11:58:50AM -0700, Davidlohr Bueso wrote:
> As this will be called from non page allocator paths for
> proactive reclaim, allow users to pass the sc and nr of
> pages, and adjust the return value as well. No change in
> semantics.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

