Return-Path: <linux-kernel+bounces-758466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64850B1CF83
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 01:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A9B26266ED
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 23:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FA223BCF8;
	Wed,  6 Aug 2025 23:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vVgwlcQB"
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC56BA59
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 23:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754524099; cv=none; b=hKbnqwrT9UC+IcFXnGlqBrQawOeoztsK73hGuq/dnziDwuId8+0wgQ7WWGx+eX2KzxJE+LXOLcm7amnKCZoBSfFNQjRGm2vdOJ9in74+zq3FOVttbdwhWmTrnMihPhglVa1fElANuwZqgTEyf22IAQezFiLWJTixIh02yzHBnwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754524099; c=relaxed/simple;
	bh=87urm10gXqnaea1qRi++53vbIz0UUowSS164xMzA07E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s0QDnZlYQs7l0+01V2KJ/9teTqS63q3G0DozcVNGzJHdqRyLW/IjS0PevKlzRUkRjUV3itl4AQiBBYWCn8XaDw6xBeVjNAvj+IbjF9N+9MWmav7oxBpaFTuDkyLysJn6k3q4tHNY/SftxPmtMmbSNYA3bRO5LKTRwnan2LV45Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vVgwlcQB; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 6 Aug 2025 16:48:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754524094;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LrggOZQVWbsWMeGrQROI1WKi3B0AmMr1G31LZIrH2yg=;
	b=vVgwlcQBxuJauzPDtrnkF9B4Kv7hNR31S1SVfnBtlMTyLL55uWI7HT/XmOlpWjQHtzlDRj
	X7OzTpytW0xYlZzm9gyBAvpURhUZHVpBCOqZ0cG8azZLlkX5VKMXu+mvU3D7mh5MQHQqUL
	7+iJJaJtkwTrRYhrfADnodnRgViOzUI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: David Hildenbrand <david@redhat.com>
Cc: Nhat Pham <nphamcs@gmail.com>, SeongJae Park <sj@kernel.org>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Jonathan Corbet <corbet@lwn.net>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, kernel-team@meta.com, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, Takero Funaki <flintglass@gmail.com>
Subject: Re: [RFC PATCH v2] mm/zswap: store <PAGE_SIZE compression failed
 page as-is
Message-ID: <jn2fzoodgcxmyld5c7k6jifigkmbhmq2gftvxx7k4ei2kz6r72@vlrndnijfgrf>
References: <20250805002954.1496-1-sj@kernel.org>
 <761a2899-6fd9-4bfe-aeaf-23bce0baa0f1@redhat.com>
 <CAKEwX=MVBJ+Okfsob4Z30_5Y4P8c2DWoS1dYN4dF5dgp4+CexA@mail.gmail.com>
 <055a8a69-731d-43b8-887e-54d8718877cb@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <055a8a69-731d-43b8-887e-54d8718877cb@redhat.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Aug 06, 2025 at 10:14:39PM +0200, David Hildenbrand wrote:
> 
> But yeah, whether these "as is" pages are movable or not is a good question
> as well -- in particular when zsmalloc supports page migration and the "as
> is" pages would not.

By "as is" page, do you mean the page which the reclaim code is trying
to reclaim or the page within zsmalloc on which the content of original
pages are copied as is? Most probably you meant the page which the reclaim
code is trying to reclaim. This page is on its way to get freed after
[z]swapout is completed and this patch is not changing any behavior for
that path.


