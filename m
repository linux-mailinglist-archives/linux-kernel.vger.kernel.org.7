Return-Path: <linux-kernel+bounces-791575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F7EB3B8BC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 12:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61119566EAB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Aug 2025 10:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72973081D4;
	Fri, 29 Aug 2025 10:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Fv8R9wE3"
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9E826FA67
	for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 10:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756463461; cv=none; b=MIHPOMhwz+/vj14lanuZjXpPJddfdEq614QLC8v3Z22DOAqKfYBaWPP5Fte3NyMlEb0L8jk62bJMMYLSOyWFZes8w1/983Q9NuQsKTDKTR/+kdMA9R+6BBIXVa7HZDMbpr2bm2JXYUMXo34eLk+ObPY+r4sMPVbbs2MKQofx2ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756463461; c=relaxed/simple;
	bh=q1/NxwapFXz4YKEZLs6l/uoiYCRxAqO1nGr93HAORmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sXq6ECPnvvpyigR6cdln8T9XmAJQgRGmzZp/jv2ydr6zkrqvVbpdrKg/B2798f4X/jO52XSZq59uFp+E8wf/bCuxNfSrLRax3rgJX2UdScTjXAyNbvut3BInWgg9tf82OWspbzW1EBP8G2QOpxwW7I5rFIeW6lZqSJtlxI11On4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Fv8R9wE3; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=xxHiL5pC7W4H7jqFvU/eKmDKFAZbn6zpj2ouP4FN9XA=; b=Fv8R9wE3zxlyCryKWFyrovJl2R
	23qwlIO0d5RbKIgVPe0MUZsibOZCFfwqdYp/+nJzwYwS5Ri6/uVXScFiNT2+p9VMStzQR93oRR4KV
	uZgwvkMcFKpghCBsgoMgkMOQQAmmqIzkpRpgvliRe9hO3aWOJSN/kvlRh3JhW2A2KUi5HAfwCnqx4
	WvBPoqvgLmtj9JknRYclW3ABYE41K9LpmkGOVPZKWRc3dD8/SbPMNmieZPJSQdto/jeE18En/9HXy
	kR2M/kH9xNabdM53wpPAKY44NFmQLgNszOENAo+czQlurtepr8WCBBQXkzOdab8AK3r7oNXqOrXe8
	hsF61yug==;
Received: from [191.38.27.188] (helo=quatroqueijos.cascardo.eti.br)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1urwNa-003mlJ-7h; Fri, 29 Aug 2025 12:30:46 +0200
Date: Fri, 29 Aug 2025 07:30:36 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Mel Gorman <mgorman@techsingularity.net>, kernel-dev@igalia.com,
	Helen Koike <koike@igalia.com>,
	Matthew Wilcox <willy@infradead.org>,
	Thierry Reding <thierry.reding@gmail.com>, neil@brown.name
Subject: Re: [PATCH] mm/page_alloc: only set ALLOC_HIGHATOMIC for __GPF_HIGH
 allocations
Message-ID: <aLGBTPAphSP84jZ8@quatroqueijos.cascardo.eti.br>
References: <20250814172245.1259625-1-cascardo@igalia.com>
 <10cdada2-f28f-4868-b821-4a13ed627e76@suse.cz>
 <77058118-b481-4c45-8f86-d9a67ea6a187@suse.cz>
 <filznxw2rq5ylpawl3auho7luiyaqxkmitf76bbpxyihkbkw43@pos7qfwb3i56>
 <5e3bd766-0845-4d7a-acf3-1493eb925451@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e3bd766-0845-4d7a-acf3-1493eb925451@suse.cz>

On Fri, Aug 29, 2025 at 11:30:17AM +0200, Vlastimil Babka wrote:
> On 8/29/25 10:56, Sergey Senozhatsky wrote:
> > On (25/08/29 10:38), Vlastimil Babka wrote:
> >> On 8/29/25 10:36, Vlastimil Babka wrote:
> >> > On 8/14/25 19:22, Thadeu Lima de Souza Cascardo wrote:
> > [..]
> >> > Agreed with others that this change matches the original intention and it
> >> > must have been an oversight. Also found nothing to the contrary in the
> >> > original threads.
> >> 
> >> Oops, forgot to add
> >> 
> >> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> > 
> > Thank you!
> > 
> > FWIW
> > Tested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> > 
> > This needs Cc: stable@vger.kernel.org  all the way down to 5.15,
> > as far as I can tell.
> 
> If that problem bothers users of LTS kernels in that range, we can do that.
> I wonder a bit how it was only found out now as a regression in the
> browser/desktop environment test if it's that old? Is there another factor
> i.e. some new frequesnt source of allocations that trigger it?

That is not. It is just that there was an upgrade all the way back from 5.4
and, then, I caught this while doing some code inspection and reviewing the
patchset I referred to.

Well, I also tested that it really happens and caught a unix socket skb
allocation triggering that as it masks off __GFP_DIRECT_RECLAIM.

Cascardo.

