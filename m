Return-Path: <linux-kernel+bounces-779321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6057EB2F28F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:43:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EDB4176815
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F382C11C5;
	Thu, 21 Aug 2025 08:38:32 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8736829BD9E
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 08:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755765512; cv=none; b=S95rKVob1yUUwhxeDGQkFt+mjW7kPAZQRGAPYmkqQpz+CQKHwrEzD4kd2RfIs011NRMfpzpfFiX3y8HilYDUfVFCIHnFP8Iu92l5zJ6bdyM1EhxQ0sFqsXAVWtwVkGRfgzcI/RWsZf0lp8X1Gb1vu+0GuP128+US0vUPwychsh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755765512; c=relaxed/simple;
	bh=gWtMCcRLC4msLB5548UipuvrC35J+04tMtUqvLkVMdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cLSjj77w5S1Z5SwLAyxh+66W9mMzucz28T+xo7X0ADscHq3FBRpKRBSXy36/ZUB72wnigSKmbXNQpMRADheY1Pw+9mSFvK9IkYdTvi6J1E8RjAQFQfRciDGFzVTDRKLUakkDpWDoMdO+8JQ0NDKpvzbuORwwPAuMX2bK0N3h1fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6AC6F227A88; Thu, 21 Aug 2025 10:38:24 +0200 (CEST)
Date: Thu, 21 Aug 2025 10:38:24 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu, nilay@linux.ibm.com,
	martin.petersen@oracle.com, djwong@kernel.org, mcgrof@infradead.org
Subject: Re: [RFC PATCH] nvme: add an opt-in to use AWUPF
Message-ID: <20250821083824.GC29224@lst.de>
References: <20250820150220.1923826-1-john.g.garry@oracle.com> <aKZDRrfUTxJoFA1m@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aKZDRrfUTxJoFA1m@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Aug 20, 2025 at 03:51:02PM -0600, Keith Busch wrote:
> On Wed, Aug 20, 2025 at 03:02:20PM +0000, John Garry wrote:
> > It would be preferred to stop honouring AWUPF altogether, but this may
> > needlessly disable atomic write support for many "good" devices which
> > only specify AWUPF. Currently all validation of controller-related
> > atomics limits is dropped.
> 
> These "good" devices that only report AWUPF, is there some set of
> characteristics that generally applies to all of them? I tried to list
> out conditions for when I think the value could be counted on here:
> 
>   https://lore.kernel.org/linux-nvme/aGvuRS8VmC0JXAR3@kbusch-mbp/
> 
> I just don't know if you know of any devices where that criteria doesn't
> git. If not, maybe we can work with that without introducing more user
> knobs.

Given how broken the field is I'd rather not make any general exception.
If you want to use a device claiming that you use the override and you
are responsible.  NAWUPF has been added in Linux 1.2, and the brokenness
of AWUPF should have been obvious to firmware engineers ever since they
had to deal with multiple LBA formats.  There's really no excuse for not
supporting the sane version that is a trivial firmware addition.

