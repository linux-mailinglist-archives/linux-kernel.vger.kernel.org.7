Return-Path: <linux-kernel+bounces-771591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AB0B28923
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 02:14:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1452B7AEEB1
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 00:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DCD23AD;
	Sat, 16 Aug 2025 00:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPovdOdI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257FE10E9
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 00:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755303259; cv=none; b=GoBdZvukTUGmiJq1Acwz63ZAwDrMuTEuSvAjMWqd1ojbRJzx+xPD/4UoLnwqKmHPlRO9DRL9OY7aKZ5xCtW+ABC2Q6+2YOAG+MF3c6qkMaP/YXDcZruAup2wZ66+pdUm5A9v7kKHls2OWC8Z2R7tWFKodqTplpBhe/9a6piO0p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755303259; c=relaxed/simple;
	bh=9E2a9HWM2TF4Tj0nfz+ge7orBtJMia0qs6lVy6H72Uk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FOhiYEUTxUpGHXvPxxmO7uy1WsgTEuvVv8Q6aPUHOVd97nmjgYvffTuehxZtfiIEfKqMIOKDcyoh3bC1G7alj9njaMRAAeLgsKH30/XIZV9Kgto97p2zQGNHtPt23TgDPDgVzSAG30CKkfNnbc2QLT3/7GRAiGtuH/xE5TXhJ+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPovdOdI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6042C4CEEB;
	Sat, 16 Aug 2025 00:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755303259;
	bh=9E2a9HWM2TF4Tj0nfz+ge7orBtJMia0qs6lVy6H72Uk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bPovdOdIU5s2hlab5l0iRg9GNOXSYe+UJajnz7CYXVCGaiKTBsmn4ltLuC5FVzWku
	 g/++t835BnUWvSCh2conBRqalW1wxqp+fs2XFwzk7raKTuh+4TEnWnXXnmVnCAbHbF
	 Ki2SeSPxdyYFyZEtT4b+5Wnzo66tzwoRg1Mo7NmPPVcx6FIzHu1ihDvzul0dfbjxzx
	 cJkzum5cQeNpvmyE1YjuSHA+FmhInXbybAjGZG/gWRxerBrHOz+DjCYChEc3TzusPO
	 GeMnS4R72PFkMsxh6VhAOhJwXRFZJhtTuvITLqkpdgC2rZQvg5v44eC1r0bUUJ1tw6
	 rWsgfxYrtJqmQ==
From: SeongJae Park <sj@kernel.org>
To: Nhat Pham <nphamcs@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	Chris Li <chrisl@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	David Hildenbrand <david@redhat.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Takero Funaki <flintglass@gmail.com>,
	Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v2] mm/zswap: store <PAGE_SIZE compression failed page as-is
Date: Fri, 15 Aug 2025 17:14:15 -0700
Message-Id: <20250816001415.90915-1-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <CAKEwX=Mtu3KyNUv_oWFo9vNiWKkmbzMXmG3t=XgpVtG9C_v2mA@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 15 Aug 2025 16:08:50 -0700 Nhat Pham <nphamcs@gmail.com> wrote:

> On Fri, Aug 15, 2025 at 3:29 PM Chris Li <chrisl@kernel.org> wrote:
> >
> > On Wed, Aug 13, 2025 at 11:20 AM SeongJae Park <sj@kernel.org> wrote:
[...]
> > I slept over it a bit. Now I think we should make this a counter of
> > how many uncompressed pages count stored in zswap. Preperbelly as per
> > memcg counter.
> 
> Actually, yeah I asked about this counter in a review in an earlier
> version as well, then I completely forgot about it :)
> 
> 
> > I saw that you implement it as a counter in your V1. Does the zsmalloc
> > already track this information in the zspool class? Having this per
> 
> Kinda sorta. If we build the kernel with CONFIG_ZSMALLOC_STAT, we can
> get the number of objects in each size_class.
> 
> Each time we read, I believe we have to read every size class though.
> So it's kinda annoying. Whereas here, we can just read an atomic
> counter? :)

Sounds good.  So in the next version (v4), I will drop compress_fail.  Instead,
I will add two new counters, namely compress_engine_fail and the new atomic
counter, say, stored_uncompressed_pages.  Please suggest better names or
correct me if I'm missing some of your points.


Thanks,
SJ

[...]

