Return-Path: <linux-kernel+bounces-831261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA71FB9C383
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:00:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA29D3A3AA6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 21:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EF3E285C91;
	Wed, 24 Sep 2025 21:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="qANOd8KC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D456D281509
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 21:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758747612; cv=none; b=gI9DHDQXZzcPB/IadYMtbXOmWsf7gZaHZRqimX5wfglrl569iU0g722BQWXRaO9Jw3gT4ol8miyOoOARrEl3FL7PTSNKp/Z7wo+7BBsB7xl0X8WV1cmrE+ZDCUVzj3/k71ND23xRR2ZP8djKTtrtXsG9K+BdZ2gc5CtAgiBMH1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758747612; c=relaxed/simple;
	bh=dDJN8b77rN9ysunvOFha1XEVk2yflq4396QA+xCKryA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=X1PseXp0wj2MFjdoI5cxlCIbRz9dGt7nGFQO9Oh6GGa9Lk5aiuQMVhnzvcssWWJyPfr9JNRh+pWEdEKqeuTpXoVyg18SwtSlAoOr2Uw+2dBGAKt0RwtdL9N2+AZmyqnEL1mJ0OGl4bGN2QmG7hkbrdytwgCqAx+dssztXQwjEjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=qANOd8KC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19600C4CEE7;
	Wed, 24 Sep 2025 21:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1758747611;
	bh=dDJN8b77rN9ysunvOFha1XEVk2yflq4396QA+xCKryA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qANOd8KCLjLmqepp6rdBNv6MmCrjJQdAU6quKdt1acGS2IMaHi6blrwkvKzfR/A2g
	 pLanFR4po7eEdJLjiTLqiKCNSElQhay+3N7EYlL820XKuZIP0G1rqUhse3aEbpG/jt
	 YQ4zbJV7UVgLhM7jEUz3SZDs4Wg2MoCAuIB9KoM8=
Date: Wed, 24 Sep 2025 14:00:10 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Mike Rapoport <rppt@kernel.org>,
 Alexander Graf <graf@amazon.com>, Baoquan He <bhe@redhat.com>, Changyuan
 Lyu <changyuanl@google.com>, Chris Li <chrisl@kernel.org>, Pasha Tatashin
 <pasha.tatashin@soleen.com>, kexec@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/4] kho: add support for preserving vmalloc
 allocations
Message-Id: <20250924140010.81305926b42d0223dcf3b818@linux-foundation.org>
In-Reply-To: <mafs0ikh7dg54.fsf@kernel.org>
References: <20250921054458.4043761-1-rppt@kernel.org>
	<20250921054458.4043761-4-rppt@kernel.org>
	<20250922131948.GX1391379@nvidia.com>
	<20250922143407.93e171f8b7c09eb21159a33e@linux-foundation.org>
	<mafs0ikh7dg54.fsf@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Sep 2025 17:28:07 +0200 Pratyush Yadav <pratyush@kernel.org> wrote:

> >
> > Not sure why this code works - I'll suspend the series from linux-next
> > for now.
> 
> It only gets called in the error path and that didn't get hit during
> testing I suppose. Until v3 the chunk was being allocated using
> kzalloc() so I guess this got missed in the move to get_zeroed_page().
> 
> I think Mike is out of office this week. Do you think this series is
> stable enough to land in the upcoming merge window? If so, I can send a
> v6 with the fix today.

A one-liner fiup would be preferred, if no other changes are required,
thanks.

