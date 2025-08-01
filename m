Return-Path: <linux-kernel+bounces-753825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C6AB1888F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 23:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07BCC3A1FBB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 21:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB9628D8DF;
	Fri,  1 Aug 2025 21:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="f9X+OE6T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4E62036FE
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 21:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754082663; cv=none; b=B53XNAM7RA2jJHO1Jx4xS6WKsNPfB97YQTEq/zvhq3zsdoKghoH5oVpFGrqocXQOBOzLUPcd2x+OAEjqzEc2j42RyopEvXjW49+8sZa6y3FPHoE4iOAc9kTBaQ9VGc7OTSbxYe8kFtyCd8UD29WbKT6LNC67jCJ1xAa0iBQA8vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754082663; c=relaxed/simple;
	bh=ww7t1UI4eak/tTR1kr/oRbXmt8cJpLrpmmFrejZkmk8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=tiKCt657vfZt6fQRd+lOZy1POGkzQ9F5rEdu7bwDsiMzhfgG95Mc6tNrM7iL4pwY1reQ0nUKJ3YGtixuIHCahnQ2NaEhY6Udi0TvnHz7ranSlV9nagWfS77LsiM7jx3WqOEi9t/fYn8UiufJTqckgK5ily19Ig2Sx2R6B+RWca0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=f9X+OE6T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55AEEC4CEE7;
	Fri,  1 Aug 2025 21:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1754082662;
	bh=ww7t1UI4eak/tTR1kr/oRbXmt8cJpLrpmmFrejZkmk8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=f9X+OE6T2ufAtHATllC8W5aKWaZ12A5bdEZvrMetKyo7MIpzCOJKgiBQi1bvRSZvJ
	 ZRy/aKgf6gcmVyJDMpIgJ5zgTtgQ7Vo4mk3M9ynRhfptQvDRrDWCQPMSrakeUQ6azD
	 jU/4m1DF7WMHLXmSWPs4vrDjdq1j6PitZ1vd3uBQ=
Date: Fri, 1 Aug 2025 14:11:01 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Sasha Levin <sashal@kernel.org>
Cc: david@redhat.com, surenb@google.com, aarcange@redhat.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/userfaultfd: fix kmap_local LIFO ordering for
 CONFIG_HIGHPTE
Message-Id: <20250801141101.9f3555a172609cb64fde7f71@linux-foundation.org>
In-Reply-To: <20250731144431.773923-1-sashal@kernel.org>
References: <20250731144431.773923-1-sashal@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Jul 2025 10:44:31 -0400 Sasha Levin <sashal@kernel.org> wrote:

> With CONFIG_HIGHPTE on 32-bit ARM, move_pages_pte() maps PTE pages using
> kmap_local_page(), which requires unmapping in Last-In-First-Out order.
> 
> The current code maps dst_pte first, then src_pte, but unmaps them in
> the same order (dst_pte, src_pte), violating the LIFO requirement.
> This causes the warning in kunmap_local_indexed():
> 
>   WARNING: CPU: 0 PID: 604 at mm/highmem.c:622 kunmap_local_indexed+0x178/0x17c
>   addr \!= __fix_to_virt(FIX_KMAP_BEGIN + idx)
> 
> Fix this by reversing the unmap order to respect LIFO ordering.
> 
> This issue follows the same pattern as similar fixes:
> - commit eca6828403b8 ("crypto: skcipher - fix mismatch between mapping and unmapping order")
> - commit 8cf57c6df818 ("nilfs2: eliminate staggered calls to kunmap in nilfs_rename")
> 
> Both of which addressed the same fundamental requirement that kmap_local
> operations must follow LIFO ordering.
> 
> Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
> Co-developed-by: Claude claude-opus-4-20250514

Well this is innovative.  I doubt if Co-developed-by: is appropriate
for this (where's Claude's Signed-off-by:?)

I'd support creating a new changelog tag for this case.

And really, if AI was recruited in developing a kernel patch, it would
be helpful if the changelog were to have a paragraph describing just
how the AI assist was used.  At least, until everyone knows all about
this?  You probably already have a presentation or a web page, so
adding a link to that would suffice, thanks.


