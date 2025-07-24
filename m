Return-Path: <linux-kernel+bounces-743682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B862B101BB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A46E63A44CA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 07:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 396E3253932;
	Thu, 24 Jul 2025 07:29:14 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF68B2512EE;
	Thu, 24 Jul 2025 07:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753342153; cv=none; b=FJeeLa2N6koT3fOxp/d2n/mRrtf7ZnmyCPQOvUf9sVvNbt0aW9d6dhp+CFUepakumsxVgY2Y3jxdcyyR78IuEyqTeMjQdZKogSTV1j4HA/wAQVHXFQep6N9OJleBvojaLPWBcARU2HqymoCfOjzZz6YBEgwGImXDc/SIxZ1coZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753342153; c=relaxed/simple;
	bh=QHYRVoVA/kw1FfZUki5tl+VYsbcTosH+ZTfCVnrvyPU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/1xDlkZoMsE1q+DGoQHM4Y+SxPfgSajd4uREwmJNMC6uDptaK9UcyVC9GDDwfRyIc2eihUiWgYWSK/AB6Cp9Y+PO/LKM1r/UVgmGFjormgxZdWpIi9OI0MJXwGotkQxS/XGxD8ualZzQAjnQdXChjUHR4gHhWYUCNiwN6JNAtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E1F9C68BEB; Thu, 24 Jul 2025 09:28:59 +0200 (CEST)
Date: Thu, 24 Jul 2025 09:28:59 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christian Brauner <brauner@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Zizhi Wo <wozizhi@huaweicloud.com>,
	kernel test robot <lkp@intel.com>, viro@zeniv.linux.org.uk,
	jack@suse.com, axboe@kernel.dk, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: Re: [PATCH] fs: Add additional checks for block devices during
 mount
Message-ID: <20250724072859.GA29432@lst.de>
References: <20250719024403.3452285-1-wozizhi@huawei.com> <202507192025.N75TF4Gp-lkp@intel.com> <b60e4ef2-0128-4e56-a15f-ea85194a3af0@huaweicloud.com> <20250721064712.GA28899@lst.de> <20250723-heizperiode-fotoreporter-2ada7fe78028@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723-heizperiode-fotoreporter-2ada7fe78028@brauner>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jul 23, 2025 at 02:51:27PM +0200, Christian Brauner wrote:
> > You can just add a if (IS_ENABLED(CONFIG_BLOCK)) check around it.
> > 
> > 
> > But the layering here feels wrong.  sget_dev and it's helper operate
> > purely on the dev_t.  Anything actually dealing with a block device /
> > gendisk should be in the helpers that otherwise use it.
> 
> Either we add a lookup_bdev_alive() variant that checks whether the
> inode is still hashed when looking up the dev_t and we accept that this
> deals with the obvious cases and accept that this is racy...

I don't think racyness matters here.  The block device can die any
time, and the addition here is just to catch the cases where it might
have already been dead for a nicer interface.

> Or we add lookup_bdev_no_open() that returns the block device with the
> reference bumped, paired with lookup_bdev_put_no_open(). Afaiu, that
> would prevent deletion. We could even put this behind a
> guard(bdev_no_open)(fc->source). The reference count bump shouldn't
> matter there. Christoph?

Nothing prevents deletion, it will only get delayed until after the
open_mutex critical section.  I still think GD_DEAD is the best check
here, as it potentially gets set earlier than unshashing the inode,
but in the end both of the racy checks should be perfectly fine.

