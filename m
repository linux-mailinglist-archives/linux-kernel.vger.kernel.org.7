Return-Path: <linux-kernel+bounces-896639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CB4C50D8D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 08:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C54A0189CC5D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 07:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C7527E049;
	Wed, 12 Nov 2025 07:03:08 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094142777FE
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 07:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762930988; cv=none; b=a/4BsKFYTOPhucDSQkdloR10psMsTZIMtILsCNzQZEwsRDajk1AN5kDksRYAJYuwRUGoJhPazbql9sfyBtOdte7nyb0s8bxiuVJPOmPy3Z3Z9r65LKn+UnYYcmR1r3OJFY6VD/7cpBHqBOPzDK90YqKr2CVwcHsUplkUtmwV1Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762930988; c=relaxed/simple;
	bh=JEoD0k1PllzQMk+fVCGcJj2DDHAu79XO7FfzP17R/PU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQEgjOi5f7ItztRPsd4G0tjvcetLpzexqNZ6plT2oYAvK0ZPSfuyPMKdiz4eIQxeb5qbezdpjiLtbvI/1+4je1gY4BfYaFB6R30pb+zOfgKHXkwitDGGfVUBSKa9VK03blbZEvrSeFyGJbW5MvotOyedraCmqVhpt7koh12AhaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5E2F5227A88; Wed, 12 Nov 2025 08:02:58 +0100 (CET)
Date: Wed, 12 Nov 2025 08:02:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: Alistair Francis <alistair23@gmail.com>
Cc: Hannes Reinecke <hare@suse.de>, kbusch@kernel.org, axboe@kernel.dk,
	hch@lst.de, sagi@grimberg.me, kch@nvidia.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH 3/3] nvme: Allow reauth from sysfs
Message-ID: <20251112070256.GA5276@lst.de>
References: <20251030035114.16840-1-alistair.francis@wdc.com> <20251030035114.16840-4-alistair.francis@wdc.com> <8a236ca6-3675-461a-9166-4d4df3b5de08@suse.de> <CAKmqyKO=W2+5ZBudWhN_L1choupte9vzJBEoxVeZ-vNHykeR0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKmqyKO=W2+5ZBudWhN_L1choupte9vzJBEoxVeZ-vNHykeR0Q@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Nov 12, 2025 at 09:32:00AM +1000, Alistair Francis wrote:
> > I would suggest just allow writes to the 'tls_key' attribute; any
> > writes to that would trigger a replacepsk operation.
> 
> I think the `tls_configured_key` is actually the better attribute to
> write to as that is the one that updates after a REPLACETLSPSK
> operation, see v2 patches which I'm sending now.

Just saw Hannes reply here and saw why you did the current version
the way I did.  Hannes, please don't recommend weird ABIs that
make error checking and future extensibility impossible.


