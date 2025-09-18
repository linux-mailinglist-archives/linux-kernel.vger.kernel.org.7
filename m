Return-Path: <linux-kernel+bounces-823507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA625B86AE1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 21:32:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63C697BFCA3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 19:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A688523BCF0;
	Thu, 18 Sep 2025 19:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nI6DaFh5"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17416249F9
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 19:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758223943; cv=none; b=V/N6DW490WicuGVDRrSrN7bGm2rNt3e0/ohRkBFqn9lPyhCDHbRLBB8bbmZJUeRO0tWt5t0+YCYpDToBOQ4V+/BhMQ1zRVam0AyOOCC2XfNcNq+ijq6qCOogx0jZY3dPy3Zpyr9IucxFJMRovdUnM56xJ82LVPCH/1L3FzIJwg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758223943; c=relaxed/simple;
	bh=XxrczHv0nak0abQXvH89vCaKytZFxHLIKyeNeQ+cLuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TKwoawuqzGZy9VX0woVkj4dKarj/sbp9pJfgK2npkRdqJdVJ9nEnjwdG1TyaVkIPUtQW+dqGHr9z8lyTADlQxdJeLv4W9Nls9kBoh4XOPxVi7nVunrd585wPSJni4j9Yd/a83t5souuHm65L2pkRF+CgN4oDkKo5Ua1f1v+FzJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nI6DaFh5; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 18 Sep 2025 12:32:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758223938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CXdQmrJQp8IC2n0baB8wqlkTmG/JwI0rNF4jhtPL+io=;
	b=nI6DaFh5nW0bhVzHmtlARyeIe5GrSY2iZ6oj/ufmKxoHD7Mq2JVzDQpggmDP/YWp4Xs9Bm
	KGBl3clV9PR674K9yNZSqbw9zySwUrwTaL3ir+sTz1jaAOBS5UOITVc2q1JQbC7GNnufqK
	PWKGHrK560kzS9YKDo6/ImEnasMNx24=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: kirill@shutemov.name
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>, 
	Harry Yoo <harry.yoo@oracle.com>, Johannes Weiner <hannes@cmpxchg.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Kiryl Shutsemau <kas@kernel.org>
Subject: Re: [PATCH 2/2] mm/rmap: Improve mlock tracking for large folios
Message-ID: <thknnu35aqusupqt5rin4vmach3vb3ukyyaowdegtww2mvmrom@zck5s5bzj4vx>
References: <20250918112157.410172-1-kirill@shutemov.name>
 <20250918112157.410172-3-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918112157.410172-3-kirill@shutemov.name>
X-Migadu-Flow: FLOW_OUT

On Thu, Sep 18, 2025 at 12:21:57PM +0100, kirill@shutemov.name wrote:
> From: Kiryl Shutsemau <kas@kernel.org>
> 
> The kernel currently does not mlock large folios when adding them to
> rmap, stating that it is difficult to confirm that the folio is fully
> mapped and safe to mlock it. However, nowadays the caller passes a
> number of pages of the folio that are getting mapped, making it easy to
> check if the entire folio is mapped to the VMA.
> 
> mlock the folio on rmap if it is fully mapped to the VMA.
> 
> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>

It would be interesting to state how this specific issue was causing
problems in our production particularly for workloads that were doing
load shedding based on mlock stats.

