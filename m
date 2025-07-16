Return-Path: <linux-kernel+bounces-733622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCEAB07713
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 15:33:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D1FE1C259BE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 13:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE7C1B6CFE;
	Wed, 16 Jul 2025 13:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="iJlGtK+7"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 081FA19D092
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 13:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752672814; cv=none; b=O83gzMmg0lragEBC200HEXXWcagMZe0nNNVNtGQWArTg3IcDC8b2INqr4SK3mRaOcgUqnoIyDCxytpquHDE2GsOMiCzrKKpYUVSX0zaEmVqSW7RBqKd6VZEebhXV2Ok7m0WLT4h4SFUlaNre+j6KXVg7lIE7SW1TdbRHxtSFBmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752672814; c=relaxed/simple;
	bh=SBYMWwsVuR79YKqblcUA6idmRhBEnxiah0HOlvk5tjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lZvgR7D5LBX6d+J5HGoNaYUAqqnBJg8+cfP8ke1GeVN+6ig/otbB+Qgh4bjcliMnJM7gfv01S8A7elqSY5XncFJa9MaWYlaXy/Bc2v8lG7k3IJvfc0mC8ufF8h3Wmlgg3S6CO3v6mUTOrjezWedPfx9odU2xLRBqRtRc4nh8PLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=iJlGtK+7; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=xeNcHKC6/mz7f8ocQCh2lyC66kXRR40uhkAC7FLKM+c=; b=iJlGtK+71r/QFXX1
	IvC7lq9VNrD+JL14oKMTij2Sf3nu3VGNURepl91Gja9xQzoylTCWmhxYgM6uS5GXAQegDgPRn3hd7
	0Sg17Jb6+U7Q/ktJdm+l8CwiqrydVVBQ9kIsr7YkzsDpswNTRyhKN1NczmljcmDQRNc3fP0bipTn7
	0QX5Qf7rd7i5lNtkclujfnM8suq2HFVRI7D6I+oyDLOGE4nDJjyALAOKJOsLy0UwzKOUcRCL9NF55
	WXBh3bKSaUu1TmY9AyqdWwMZJ8ZBtPcvYy2orv9Nkd9B3MgNtR5kT3nZxRjZH5gDW1YkT0Is1MJMK
	LywdNVFPTx1727amyQ==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1uc2GG-00GQYz-0b;
	Wed, 16 Jul 2025 13:33:28 +0000
Date: Wed, 16 Jul 2025 13:33:28 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: akpm@linux-foundation.org, terrelln@fb.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/xxhash: Comment out unused functions
Message-ID: <aHeqKPaUqd43X-QS@gallifrey>
References: <20250714000927.294767-1-linux@treblig.org>
 <aHXwfyKRvXi5AZZT@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <aHXwfyKRvXi5AZZT@infradead.org>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-34-amd64 (x86_64)
X-Uptime: 13:33:00 up 79 days, 21:46,  1 user,  load average: 0.16, 0.10, 0.03
User-Agent: Mutt/2.2.12 (2023-09-09)

* Christoph Hellwig (hch@infradead.org) wrote:
> On Mon, Jul 14, 2025 at 01:09:27AM +0100, linux@treblig.org wrote:
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > 
> > xxh32_digest() and xxh32_update() were added in 2017 in the original
> > xxhash commit, but have remained unused.
> > 
> > While I've mostly been deleting unused functions, this is a general
> > library and I see erofs is using other bits of xxh32, so it didn't
> > seem right just to delete them.
> > 
> > Comment them out with #if 0.
> > (Which checkpatch rightly warns about)
> 
> Please just remove it like all other dead code.  The same argument
> that folks can easily look at the git history to resurrect it applies
> here as everywhere else.

Hmm OK, as requested, v2 posted:

Subject: [PATCH v2] lib/xxhash: Remove unused functions
Date: Wed, 16 Jul 2025 14:32:45 +0100
Message-ID: <20250716133245.243363-1-linux@treblig.org>

Dave
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

