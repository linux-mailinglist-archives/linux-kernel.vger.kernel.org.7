Return-Path: <linux-kernel+bounces-736040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B4AB0970C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 00:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DECA4E56B6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 22:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F382F24167B;
	Thu, 17 Jul 2025 22:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JCMJhbXa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6E5241103
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 22:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752792767; cv=none; b=SnB4wkmayGe846GBH8yYzHrwWkV0nVuc/rGQymK/kXNKwOAFpf3iIoSmfV6chf9FweHuoYX+yvcNLTWBTjUlfO2pZYdjJkdrtuTFHodlbpMztSZYpxsu1QtStCFuU1ZBYaT9OzRp3qV5SWQHlNUqlzJboLJ3giin5YzLf2vOF7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752792767; c=relaxed/simple;
	bh=CSmc0JHp5Ls90DfiJWQpBqfObYBdpwcTd8QjfaVqd/I=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=sd7X8YUz6Z9tKqDw81TdNtFuhzpPXtGl31b5GKIUdtnWgpbxGP3mALTu1VogPUZB5Ly8+KXl8GjZdZ4iSiR/DyyXzYxSbHb+kfAUKwgNfYuW1cNVAy325uJV3TJo/PN0ZO5Bd7eVoFBa+LfrTyfpFvBVHM7yBdAIJglTznksWsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JCMJhbXa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 816E9C4CEE3;
	Thu, 17 Jul 2025 22:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1752792766;
	bh=CSmc0JHp5Ls90DfiJWQpBqfObYBdpwcTd8QjfaVqd/I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JCMJhbXa7A202WishAfZaEuYxgBXTQ4WKne9zG5wtdJAkxYzfJcYxUh+rvT7QUKY6
	 0zs+IVKaWvl3b/NGvROX2pHwIP5eKqOs3NrGr6Z63VPtpGyX0L4H/UO0euEFu75cjN
	 7JbVT5FndhbLxQVPr/kYjYtallxbkOXPwE0i/ewk=
Date: Thu, 17 Jul 2025 15:52:46 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Davidlohr Bueso <dave@stgolabs.net>, mhocko@kernel.org,
 hannes@cmpxchg.org, roman.gushchin@linux.dev, yosryahmed@google.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] mm/memcg: make memory.reclaim interface generic
Message-Id: <20250717155246.1f2a90c76d71b401255f11b9@linux-foundation.org>
In-Reply-To: <ggavn7jgnti6uhdwlbgmuz4miplyh5zzixgmlye53qmaoh7tkp@3srwgtxrhtld>
References: <20250623185851.830632-1-dave@stgolabs.net>
	<20250623185851.830632-3-dave@stgolabs.net>
	<ggavn7jgnti6uhdwlbgmuz4miplyh5zzixgmlye53qmaoh7tkp@3srwgtxrhtld>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Jul 2025 15:17:09 -0700 Shakeel Butt <shakeel.butt@linux.dev> wrote:

> On Mon, Jun 23, 2025 at 11:58:49AM -0700, Davidlohr Bueso wrote:
> > +
> > +int user_proactive_reclaim(char *buf, struct mem_cgroup *memcg, pg_data_t *pgdat)
> > +{
> > +	unsigned int nr_retries = MAX_RECLAIM_RETRIES;
> > +	unsigned long nr_to_reclaim, nr_reclaimed = 0;
> > +	int swappiness = -1;
> > +	char *old_buf, *start;
> > +	substring_t args[MAX_OPT_ARGS];
> > +
> > +	if (!buf || (!memcg && !pgdat))
> 
> I don't think this series is adding a use-case where both memcg and
> pgdat are non-NULL, so let's error out on that as well.

As a followup, please.  This has been in -next for four weeks and I'd
prefer not to have to route around it (again).


