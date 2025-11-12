Return-Path: <linux-kernel+bounces-897643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C60C53449
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 17:06:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A73633517A9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 15:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B1E342144;
	Wed, 12 Nov 2025 15:50:20 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE0D338904
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 15:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762962619; cv=none; b=AL+NCe8dfOtkUjcesfY2maJXMWT0p+ZAd8zyZ+W0jm6q7DfFj/0TOkALqRs2kmXf1qL0zdMjHUorQK2g6k8QGQ0WRPu71ZFb8UwzMlmLdcCV4rYSsm9ZGDWjzMlAX+UuqT+IhOPiQRzYlVRfszJ9eApvV4T870FNWePx0EigvmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762962619; c=relaxed/simple;
	bh=gutkwe9SVbG0zgvDPYIq02i5W1JaLEos29QB40n4b58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ia+BsDFZunHJgaErAYJeyyzmXEVLjKLoCkW5F9Uc0YpZx/nasj543oULA5lnOLN6R/bSZLmXVrpblSPuZQklNiQACkNBZji8dh+G3UT6x5uFsErczFR0mEQc1j+nbnlOy9FMTTNMMy32PGRKgklnmN1S7G/p5xKQ/NuH+qfSHzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6DA2C68AA6; Wed, 12 Nov 2025 16:50:12 +0100 (CET)
Date: Wed, 12 Nov 2025 16:50:11 +0100
From: Christoph Hellwig <hch@lst.de>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>,
	Eric Biggers <ebiggers@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: mempool_alloc_bulk and various mempool improvements
Message-ID: <20251112155011.GC7209@lst.de>
References: <20251111135300.752962-1-hch@lst.de> <48e45106-f76a-421d-8f9c-645469076ad4@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48e45106-f76a-421d-8f9c-645469076ad4@suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Nov 12, 2025 at 01:22:01PM +0100, Vlastimil Babka wrote:
> On 11/11/25 14:52, Christoph Hellwig wrote:
> > Hi all,
> > 
> > this series adds a bulk version of mempool_alloc that makes allocating
> > multiple objects deadlock safe.
> > 
> > The initial users is the blk-crypto-fallback code:
> > 
> >   https://lore.kernel.org/linux-block/20251031093517.1603379-1-hch@lst.de/
> > 
> > with which v1 was posted, but I also have a few other users in mind.
> 
> How do we handle this then once it's settled?

Good question.  I think there is enough mm material now for a merge
through an mm tree.  If we get it sorted out for this merge window just
merging it through mm even when there is no user yet would be easiest as
the blk-crypto work is probably not going to make this merge window with
additional review from Eric and I'll most like have another user for the
next merge window as well (block bounce buffering for !STABLE_WRITES
dio).  Otherwise we'll have to operate with shared branches.


