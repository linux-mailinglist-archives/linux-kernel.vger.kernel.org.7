Return-Path: <linux-kernel+bounces-876244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B44BC1B782
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 15:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7905A64072A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 13:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06CBA34F492;
	Wed, 29 Oct 2025 13:38:44 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E4E34F46F
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 13:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761745123; cv=none; b=lNPQ5S5yVG0PxYi3HuKpoEk0Q4aKp40Vb0EpNlygorTdEt41TSGFuvEYaW/Hv29MOA4C8S75suO1II5QJJErcF1ruE4i8grPWZXcu5dttSuaMmOR5Swno/4tIIalXnSDQSmJjUBok4Oh7EkbrnPLsna+zyAt4yEF+E09fIuQXLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761745123; c=relaxed/simple;
	bh=nXrQrLOZQlSlfYKWTFEOIitrE9LrhACr5dPWPL9oHJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gLQWRbEdb8IHW/b7mUbNhCmuwispPL5eYHgPCC76DXTQ25aQFm2/GCE1F5cr5n6WRU0/nqQNup6B5Bu6JxCZWZheVKlUfp+kfUYwOPzArepkjeVXVJpKpkHnum6PZBF4OhOb0Ql46CkgxzGAO6e6r3cqIcTBFbSA/do4PE+QuEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 64D4B227A8E; Wed, 29 Oct 2025 14:38:35 +0100 (CET)
Date: Wed, 29 Oct 2025 14:38:34 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Daniel Wagner <wagi@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	John Meneghini <jmeneghi@redhat.com>,
	Bryan Gurney <bgurney@redhat.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: drop bogus nid quirk for multipath devices which
 passed id test
Message-ID: <20251029133834.GB14596@lst.de>
References: <20251028-bogus-id-check-v1-1-c087a98b5466@kernel.org> <20251029074403.GA30412@lst.de> <bd91a6c1-cefc-43e2-8dd8-48b7ea241ded@flourine.local> <20251029095907.GA1652@lst.de> <831d8af6-5bb0-4869-b9a5-6a4442ec8d67@flourine.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <831d8af6-5bb0-4869-b9a5-6a4442ec8d67@flourine.local>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Oct 29, 2025 at 11:14:27AM +0100, Daniel Wagner wrote:
> On Wed, Oct 29, 2025 at 10:59:07AM +0100, Christoph Hellwig wrote:
> > The problem is that there is no such thing as a sanity check.  Otherwise
> > life would be easy.  But I really can't believe that Dell is incompetent
> > enough to not leave a mark of their OEM Firmware version anywhere.
> 
> Got it. Sure, there are version strings though not really 'stable' as
> Hannes told me. Maybe there is a way to filter these out. But isn't this
> what the command line idea overwrite feature is?

Version isn't optimal, but model numbers often encode model numbers,
and some devices have identifiers in the vendor specific regions of
identify commands.

> John, did you have some progress with this?
> 
> The sad thing is that the Intel device needs the quirk. If the Dell
> device just would use it's own IDs...

I'm pretty sure they are one and the same device, just with slightly
different firmware versions.  It might be that Dell actually reported
the bogus IDs to Intel as part of compliance testing and Intel only
fixed it for them and not the generic firmware build :(

