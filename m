Return-Path: <linux-kernel+bounces-875664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0847C19892
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 10:59:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C9C319C7494
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8718328618;
	Wed, 29 Oct 2025 09:59:14 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B67C322547
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761731954; cv=none; b=i1K5wWXRmc+AVGCJAKuRJwmasiitM4MbMZR0dj+TNtiW2D/E7N6+SJ8jS74SfFC6Eu7TaWhatVMzi4SpuB6MT/ckAiNq8FcOBDWMmC0L03czJ0Mm1vVgNExSvY9L+UKOlCSCe6FuCtSf9e1Is3ApzvoDiOc3HmOGu2Szb/0OCHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761731954; c=relaxed/simple;
	bh=BIkvibrBgE43TBEg27Xd7i+8HTB+89R/1BVU+bnaJ7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rUJUtqEIg+0/Otttr4RnsYLTw+AgMDDfLHRqNw+GWT7L2afoVa8bGXzDvUqWBcTmP02fogtrZXI/8/6PK6wW22uocPcB/xF6ut3l7oo7kudNRZhkZCkFGM45z4LfDweMJtKDCamwuHpGaZNm0NzOi3uJAL5gNE6acuC3lzxe6MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CC5EB227A88; Wed, 29 Oct 2025 10:59:07 +0100 (CET)
Date: Wed, 29 Oct 2025 10:59:07 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <dwagner@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Daniel Wagner <wagi@kernel.org>,
	Keith Busch <kbusch@kernel.org>,
	John Meneghini <jmeneghi@redhat.com>,
	Bryan Gurney <bgurney@redhat.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: drop bogus nid quirk for multipath devices which
 passed id test
Message-ID: <20251029095907.GA1652@lst.de>
References: <20251028-bogus-id-check-v1-1-c087a98b5466@kernel.org> <20251029074403.GA30412@lst.de> <bd91a6c1-cefc-43e2-8dd8-48b7ea241ded@flourine.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd91a6c1-cefc-43e2-8dd8-48b7ea241ded@flourine.local>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Oct 29, 2025 at 10:45:57AM +0100, Daniel Wagner wrote:
> On Wed, Oct 29, 2025 at 08:44:03AM +0100, Christoph Hellwig wrote:
> > But more imporantly dropping the quirk for multipath devices is
> > fundamentally the wrong thing to do, as we really need proper IDs for
> > multipathing. So just add another entry for the Dell device using
> > the dell subvendor/subdevice id that does not have the quirk.
> 
> The problem it is not possible to distinguish between the two devices
> based on subvendor/subdevice ids. I've tried to find some way to keep
> those two devices apart, serial numbers but I don't think there is
> something usable. Thus the idea to rely our own sanity checks and
> enable the feature if these pass. 

The problem is that there is no such thing as a sanity check.  Otherwise
life would be easy.  But I really can't believe that Dell is incompetent
enough to not leave a mark of their OEM Firmware version anywhere.

