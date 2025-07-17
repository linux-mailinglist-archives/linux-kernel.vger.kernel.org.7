Return-Path: <linux-kernel+bounces-736021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5788EB096DF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 00:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E6664A2413
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 22:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862921A2541;
	Thu, 17 Jul 2025 22:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i172STiy"
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F84A94F
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 22:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752790639; cv=none; b=ha+NfJxcrsmbiPahu+pE9AswgLKX/hDuH04WKBtm1esG73/swmmldEhTdjwQMJR6wgaFsKrrOacXJIl3goYTgtDKHibIgIdps3ztbDUj2km2n7cAqeD2mZodrF59TOVpeL+TTCECW7mj5XLMtgQeTv53Bdi26NetQ+7W2Kt98Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752790639; c=relaxed/simple;
	bh=fOv5RxM6gI9E8TJPoZP0GHyKll73VLdqn61Iu9KqbrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G9WLgxlwwTuFmgUcxK27hOg6xPiWHSV2QEPXYmUl6R808raIVJ+TT6QOsrO51f9myMLj+STrrukjxJgZfURggvX8Lo8rGFYSNLHtR1C9O9NQgUbFnf9WJ5LyWVeB8fhdio6hheICM3o9GCJIxkvQXbOqXMwoBfeZaPVrXKCSOiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i172STiy; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 17 Jul 2025 15:17:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752790634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ByQdKtZyzhaIQ24Myi/U0d7Rpd2vwY+O9UsiHyxh+bo=;
	b=i172STiygyv8IcHD0OtVefvqlgsMSu/5vnXyNdWKCRFm73a8u27QWiMOKI+VMNZsiEbF4T
	RcJdDsEUxuQtAEgpV/Tnb40xNr8BeDBsXch7q2FxUun2q0FCbLj3QlSBWRUQJOIqaPyPce
	ffxXcYJW8hou6q5aSCwQRBxlbIyxjw0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: akpm@linux-foundation.org, mhocko@kernel.org, hannes@cmpxchg.org, 
	roman.gushchin@linux.dev, yosryahmed@google.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] mm/memcg: make memory.reclaim interface generic
Message-ID: <ggavn7jgnti6uhdwlbgmuz4miplyh5zzixgmlye53qmaoh7tkp@3srwgtxrhtld>
References: <20250623185851.830632-1-dave@stgolabs.net>
 <20250623185851.830632-3-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623185851.830632-3-dave@stgolabs.net>
X-Migadu-Flow: FLOW_OUT

On Mon, Jun 23, 2025 at 11:58:49AM -0700, Davidlohr Bueso wrote:
> +
> +int user_proactive_reclaim(char *buf, struct mem_cgroup *memcg, pg_data_t *pgdat)
> +{
> +	unsigned int nr_retries = MAX_RECLAIM_RETRIES;
> +	unsigned long nr_to_reclaim, nr_reclaimed = 0;
> +	int swappiness = -1;
> +	char *old_buf, *start;
> +	substring_t args[MAX_OPT_ARGS];
> +
> +	if (!buf || (!memcg && !pgdat))

I don't think this series is adding a use-case where both memcg and
pgdat are non-NULL, so let's error out on that as well.

