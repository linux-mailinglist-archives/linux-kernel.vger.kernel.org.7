Return-Path: <linux-kernel+bounces-883909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5695C2EBC4
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 02:23:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98B3B3B9A54
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 01:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A97212548;
	Tue,  4 Nov 2025 01:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EdgYUvAY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 176A81A5BB4
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 01:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762219402; cv=none; b=g3faFNDDEBYuReRVwGfgWsQf4JmkCVBuYlnkhFPvbodDJSP6tNi1burF69Sp9qWE2y3XFVhjE6449r+qDqMcysFskBlrHtJYFeeH7ZO9M4dtw79w/0ZZKJNbXW/O6Mf6W9CyiziRPcpjSJNurb2ULEoKm80KIlC6w49MPiEUMf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762219402; c=relaxed/simple;
	bh=O+EbnOruKhiIrqCFK8PK7/fd3bCIQqLDIo8Gmu5gXD8=;
	h=Date:From:To:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=g7inQO5bf88c4axoj+iBauUZcdpK3Jodz1HC6xwKFts/Zz/Z5HGb3rLKCN4ROG95rDs0ih9aFKVHt4IPvLBTddG8yOWErEDtUW419kDfAdCM1D0RS8k+O2Jq+OjPTrHynqPhmokzTb22S59spJ1RGpI4BWIkcnZQ+Cc3k7CXxnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EdgYUvAY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 926DEC4CEE7;
	Tue,  4 Nov 2025 01:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1762219401;
	bh=O+EbnOruKhiIrqCFK8PK7/fd3bCIQqLDIo8Gmu5gXD8=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=EdgYUvAYaqJ4iE8rYLjZnK2QIlkPprTnCr88K3m1l6ewi6mUMHyNC3jl/5qjpCZmJ
	 rSlcoRH1V4Ijowsw6+XnYbz7c/pJXq2Yz/Xu0h3elPEQtBgNAfiYr7X3LN5LDSum1g
	 wpRnmKi1RJbzz7C859LT39PqK9okofTjRhUCsP3w=
Date: Mon, 3 Nov 2025 17:23:21 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Pratyush Yadav <pratyush@kernel.org>, Baoquan He <bhe@redhat.com>,
 Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>, Pasha
 Tatashin <pasha.tatashin@soleen.com>, kexec@lists.infradead.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] kho: misc fixes
Message-Id: <20251103172321.689294e48c2fae795e114ce6@linux-foundation.org>
In-Reply-To: <20251103162020.ac696dbc695f9341e7a267f7@linux-foundation.org>
References: <20251103180235.71409-1-pratyush@kernel.org>
	<20251103162020.ac696dbc695f9341e7a267f7@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 3 Nov 2025 16:20:20 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:

> On Mon,  3 Nov 2025 19:02:30 +0100 Pratyush Yadav <pratyush@kernel.org> wrote:
> 
> > This series has a couple of misc fixes for KHO I discovered during code
> > review and testing.
> > 
> > The series is based on top of [0] which has another fix for the function
> > touched by patch 1. I spotted these two after sending the patch. If that
> > one needs a reroll, I can combine the three into a series.
> >
> 
> Things appear to be misordered here.
> 
> [1/2] "kho: fix unpreservation of higher-order vmalloc preservations"
> 	fixes a667300bd53f2, so it's wanted in 6.18-rcX
> 
> [2/2] "kho: warn and exit when unpreserved page wasn't preserved"
> 	fixes fc33e4b44b271, so it's wanted in 6.16+
> 
> So can we please have [2/2] as a standalone fix against latest -linus,
> with a cc:stable?
> 
> And then [1/2] as a standalone fix against latest -linus without a
> cc:stable.
> 

OK, I think I figured it out.

In mm-hotfixes-unstable I have

kho-fix-out-of-bounds-access-of-vmalloc-chunk.patch
kho-fix-unpreservation-of-higher-order-vmalloc-preservations.patch
kho-warn-and-exit-when-unpreserved-page-wasnt-preserved.patch

The first two are applicable to 6.18-rcX and the third is applicable to
6.18-rcX, with a cc:stable for backporting.


