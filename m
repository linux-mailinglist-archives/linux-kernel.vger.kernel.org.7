Return-Path: <linux-kernel+bounces-882809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 762B1C2B8F3
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 13:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AF833A8058
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 11:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5803074A0;
	Mon,  3 Nov 2025 11:58:48 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568D02D7BF
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 11:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762171127; cv=none; b=FeMd85G8aFHOb6tzrDxjQgy0ZYOVargX6p+mf4CoyeTekvcMCOsq7HS9Ui4nxzeMJSiL0ffPlBEC4mF31Z7IRIlb57qoSCtA9nN++N9gp7lMfikVJKi551wAt+JMq8SIm2JKRqPMdckp69jaaoc82aT51ZJVJP0Kl885A50bsTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762171127; c=relaxed/simple;
	bh=dZjMsZ3OwIXpABrAz/dmsNqcZIe3nCsA3z3P7pZAY+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kt5CXqzKoGvU1TYvMHlhKn9TPCcLEdLx4W+ZY3UWV71fQ9B9o5nboKwfDYfX9XP3bcHcSnPW+8oMdU16sEWy3udohtXUfb4spgRetSrozgdyGUloHr48Yo3QJ8K2VlBHUQ7pFrOQstI+6mBZR16QUYFwqIYfitZlEhG+wOU7f10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 51433227A87; Mon,  3 Nov 2025 12:58:41 +0100 (CET)
Date: Mon, 3 Nov 2025 12:58:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: Alistair Francis <alistair23@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, axboe@kernel.dk,
	sagi@grimberg.me, hare@suse.de, kch@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH 3/3] nvme: Allow reauth from sysfs
Message-ID: <20251103115841.GA16274@lst.de>
References: <20251030035114.16840-1-alistair.francis@wdc.com> <20251030035114.16840-4-alistair.francis@wdc.com> <20251031140541.GB17006@lst.de> <CAKmqyKNr8N4r=9RvgErr-zj929gd8oRfdKGgrhVajK_UxR828g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKmqyKNr8N4r=9RvgErr-zj929gd8oRfdKGgrhVajK_UxR828g@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Nov 03, 2025 at 11:47:23AM +1000, Alistair Francis wrote:
> On Sat, Nov 1, 2025 at 12:05 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > On Thu, Oct 30, 2025 at 01:51:14PM +1000, alistair23@gmail.com wrote:
> > > From: Alistair Francis <alistair.francis@wdc.com>
> > >
> > > Allow userspace to trigger a reauth (REPLACETLSPSK) from sysfs.
> > > This can be done by writing the queue ID to te sysfs file.
> > >
> > > echo 0 > /sys/devices/virtual/nvme-fabrics/ctl/nvme0/replace_psk
> > >
> > > Note that only QID 0 (admin queue) is supported.
> >
> > Why pass the queue ID then instead of a boolean value?
> 
> I liked the explicitness of passing a queue ID instead of a bool and
> it allows supporting more queues in the future if that changes in the
> spec.
> 
> I can change it to a bool instead if that's preferred?

I find an "echo 0" for a simple one-shot sysfs file rather confusing.
Given that we're not likely to grow anything else I'd vote against
doing it, but this is no hard NAK if there is consensus to do it
this way by others.

