Return-Path: <linux-kernel+bounces-772759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A3DB2972D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 04:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3F55179CA9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 02:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CC025A2A7;
	Mon, 18 Aug 2025 02:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ABn4IF1X"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 209941B4247
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 02:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755485987; cv=none; b=k0YsLUqLOYk4A9khIQVRkkGzmJCZiktOTP6lKyxMM5jFKPT6SpbRn4uz72w/iPQZ5yMMLSqism0ugOzhKFeEUqdMju/1lLOAM5D+ap6Wld01xN8kKRNSoMjXP1GCZTsEnOL90TGpICzn4ERurMtjfWGlfnbFafztoNE/DlS9Z1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755485987; c=relaxed/simple;
	bh=l0oGxhr69i2XgfLSJ6MBoDCtiIgjNb43saiOXd3ydlM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=qjMfD4D+Z57FvK0IOfyJVQ29I5EA/BkWT9yOyssNJvMk26TjvXZZIpcas+bOqW2Ja2ZnJret6DNCFawQI0zSJc+H1qzOH62zRJfY+/3lGvjjeFkr1vt0SsIeCKYA8VeGGEq+YsBISDM3e+m0BvFS/skPEMO5G7/QJwnkyiQm7ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ABn4IF1X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A9CCC4CEEB;
	Mon, 18 Aug 2025 02:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1755485986;
	bh=l0oGxhr69i2XgfLSJ6MBoDCtiIgjNb43saiOXd3ydlM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ABn4IF1Xfv/Bl3lM5awifjZEWeaotFjkCQOtrQ9nSX/EcHBkka5rpkEVUwg38r8lv
	 ApR+y/Y9WX772rsaTYotCGMTZAzTftMF66j2/GnTlhD4KBbFC8yJ8WcCavRVhLaOpd
	 EaChv3LieC1YJB8Ufznte7IOpzjPeS6ta9Eq9Xrw=
Date: Sun, 17 Aug 2025 19:59:45 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: jane.chu@oracle.com
Cc: lirongqing <lirongqing@baidu.com>, muchun.song@linux.dev,
 osalvador@suse.de, david@redhat.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH][v2] mm/hugetlb: early exit from
 hugetlb_pages_alloc_boot() when max_huge_pages=0
Message-Id: <20250817195945.a845d2f5c045e4f60b07469f@linux-foundation.org>
In-Reply-To: <08cc4405-948a-446e-b198-5745c32f9ee1@oracle.com>
References: <20250814102333.4428-1-lirongqing@baidu.com>
	<08cc4405-948a-446e-b198-5745c32f9ee1@oracle.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 Aug 2025 19:21:54 -0700 jane.chu@oracle.com wrote:

> 
> On 8/14/2025 3:23 AM, lirongqing wrote:
> > From: Li RongQing <lirongqing@baidu.com>
> > 
> > Optimize hugetlb_pages_alloc_boot() to return immediately when
> > max_huge_pages is 0, avoiding unnecessary CPU cycles and the below
> > log message when hugepages aren't configured in the kernel command
> > line.
> > [    3.702280] HugeTLB: allocation took 0ms with hugepage_allocation_threads=32
> > 
> > Signed-off-by: Li RongQing <lirongqing@baidu.com>
> > ---
> > diff with v1: adding the reduced log messages in commit header
> > 
> >   mm/hugetlb.c | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 753f99b..514fab5 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -3654,6 +3654,9 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
> >   		return;
> >   	}
> >   
> > +	if (!h->max_huge_pages)
> > +		return;
> > +
> >   	/* do node specific alloc */
> >   	if (hugetlb_hstate_alloc_pages_specific_nodes(h))
> >   		return;
> 
> Looks good.  Could you add stable: ?

Sure, I did that.

A Fixes: would be nice, to tell the -stable maintainers how far back in
time we need this, but the target sommit isn't obvious.


