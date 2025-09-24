Return-Path: <linux-kernel+bounces-831358-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A580B9C724
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B20ED1884165
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CE628488A;
	Wed, 24 Sep 2025 23:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="WLrJDxT8"
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D515E243371
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758755390; cv=none; b=uZmZFDmfx6MyBiLefY5Reyx2k5bhfnmdeVOCaOVCqnA/lK840GjRNjDF46qZS4qD2gU+IfiL4B4/JLYH5v6rtkkkuJ/AonThwnA3sdO/8aAw16HuKo90oYqPCN4QMGTa0ytPkmY1XDURn6ub9xJjdT4zwe4+CqO+w1Ma/hclTQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758755390; c=relaxed/simple;
	bh=KDm7q+MIJNTRpl7BCOFoPDj04yz/4t+34tin/l+vess=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=upYh861jsmhBQ2ZiXEGUAZj+oMugp7YfKTNcILhGdAxRnamNClZL4f2BGddVJYWW3iqkbGXAJnUhg5cci9NIZPl5TyP1w7ymNOihfQruBaEjT2wWOhoZqaI2NVwOCFZKovyd1tUfvBCWyK2HaeWaeeXlo2TE2b0XE4k/qHPAdAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=WLrJDxT8; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1758755387;
	bh=KDm7q+MIJNTRpl7BCOFoPDj04yz/4t+34tin/l+vess=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=WLrJDxT8W9UBbmk/+FKsjVXtd0LFDGdTEyb9WOSSMPMhYaMfNN0HyHARKw9zaTiQe
	 qQfTIwcYtqT+Q/x2bKM2QE828TSZG18Qc3kv3y7k4Wtv5V67C2aEgPvYZ9yU89Hg/5
	 tRv0Tm/h+V3KqyMEXOt+LhR56U3/S+mlwA1a2uP4=
Received: by gentwo.org (Postfix, from userid 1003)
	id 0ABC540293; Wed, 24 Sep 2025 16:09:47 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 0805F4028E;
	Wed, 24 Sep 2025 16:09:47 -0700 (PDT)
Date: Wed, 24 Sep 2025 16:09:47 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
cc: Andrew Morton <akpm@linux-foundation.org>, 
    Johannes Weiner <hannes@cmpxchg.org>, Chris Mason <clm@fb.com>, 
    Kiryl Shutsemau <kirill@shutemov.name>, 
    Brendan Jackman <jackmanb@google.com>, Michal Hocko <mhocko@suse.com>, 
    Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, 
    Zi Yan <ziy@nvidia.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
    kernel-team@meta.com
Subject: Re: [PATCH v2 2/4] mm/page_alloc: Perform appropriate batching in
 drain_pages_zone
In-Reply-To: <20250924204409.1706524-3-joshua.hahnjy@gmail.com>
Message-ID: <a84ede7d-60ad-3df9-77ae-cd0dbc545b85@gentwo.org>
References: <20250924204409.1706524-1-joshua.hahnjy@gmail.com> <20250924204409.1706524-3-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 24 Sep 2025, Joshua Hahn wrote:

> drain_pages_zone completely drains a zone of its pcp free pages by
> repeatedly calling free_pcppages_bulk until pcp->count reaches 0.
> In this loop, it already performs batched calls to ensure that
> free_pcppages_bulk isn't called to free too many pages at once, and
> relinquishes & reacquires the lock between each call to prevent
> lock starvation from other processes.


drain_pages_zone() operates on a lock in a percpu area. The lock is
specific to a cpu and should not be contended in normal operatons unless
there is significant remote access to the per cpu queues.

This seems to be then from __drain_all_pages() running on multiple cpus
frequently. There is no point in concurrently draining the per cpu pages
of all processors from multiple remote processors and we have a
pcpu_drain_mutex to prevent that from happening.

So we need an explanation as to why there is such high contention on the
lock first before changing the logic here.

The current logic seems to be designed to prevent the lock contention you
are seeing.


