Return-Path: <linux-kernel+bounces-779936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8ACB2FB48
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C844B1CC0C57
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7358E34166C;
	Thu, 21 Aug 2025 13:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQvdyDt9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF7A341666
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 13:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755783758; cv=none; b=Oh+AdShGrqeiF+Zx9g1qPQSoelfSXnMvZQ52aSPZdtFx1/yI5gqSPTLzL+sr9JxDbS2WAuun0X2O2K2HNSb7ffDNsVhUxVA4B6wgwqGseYIGgk7ovhFoy42kTiPjcTrzwRlZfNsrSC4QEZlbDtBpDaN6ZFPB/294ue7+Txy6IeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755783758; c=relaxed/simple;
	bh=pilO4jUangUTqQdAkiK4cWGSMK4Xy1+X18LLgCwRYNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxsnE1Dm4wpfCL+/Z9jY2qn7q7+G3xSovYC4jywYIHM/bFf2GLgEsZrF5L4WZq7y5LqqzCPdkVmt6/Abbkv/DmJEyWh4weIvyyKTv67EjRw1pMlWoV7ikCjcmxZrAPe5zmJqrSaI+7ilXMUpqpOLl8GC0znAL2QjPgB/c40umH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQvdyDt9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0809C4CEEB;
	Thu, 21 Aug 2025 13:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755783758;
	bh=pilO4jUangUTqQdAkiK4cWGSMK4Xy1+X18LLgCwRYNA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lQvdyDt9lzQK+pQNTFgZuzvHiKKUWyubxQxAbJoDgR8mAI1atF+0gJN1VTzanJFfm
	 TOFwv7bNK2omxdx3Y3YtLVxw4gCjhdJLWm1jil4yda2sTrclDuDelyFbN48tEfdPAK
	 Z213AkAq7WcJDhpXA0Ma4xObdw3cG2kcNkxlqa3wQr0PEOq2yVXuZ+hJnDvcQ5y3Hr
	 eUGxSr4XExvJJmNdOOVZXiuPZFesguUu9G05zYUr10flws6SdqMmmjw3Kw/DmWatxc
	 7JeWjRS/JWfRH8wLRlaPmhtRgH/r+oILWgB9s/H2Jip4k4jtub374ODzjOHQeTfwQv
	 5Rw+8Ima2t3UA==
Date: Thu, 21 Aug 2025 07:42:36 -0600
From: Keith Busch <kbusch@kernel.org>
To: Nilay Shroff <nilay@linux.ibm.com>
Cc: John Garry <john.g.garry@oracle.com>, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, tytso@mit.edu,
	martin.petersen@oracle.com, djwong@kernel.org, mcgrof@infradead.org
Subject: Re: [RFC PATCH] nvme: add an opt-in to use AWUPF
Message-ID: <aKciTPKiL8wRWmHA@kbusch-mbp>
References: <20250820150220.1923826-1-john.g.garry@oracle.com>
 <aKZDRrfUTxJoFA1m@kbusch-mbp>
 <b8156bb1-b7fe-4036-9dbb-98fdcec3ff65@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8156bb1-b7fe-4036-9dbb-98fdcec3ff65@linux.ibm.com>

On Thu, Aug 21, 2025 at 10:55:31AM +0530, Nilay Shroff wrote:
> On 8/21/25 3:21 AM, Keith Busch wrote:
> > I tried to list out conditions for when I think the value could be counted on here:
> > 
> >   https://lore.kernel.org/linux-nvme/aGvuRS8VmC0JXAR3@kbusch-mbp/
> > 
> Regarding the checks you listed, they seem too restrictive. They only support
> AWUPF for single-controller devices and for disks that either have only one
> namespace or support formatting all namespaces together (i.e., do not support
> formatting individual namespaces).

Being restrictive was the point. It constrains to 1.0 type behavior
where things were much simpler. I am just shocked vendors went through
the trouble to implement the complicated features but couldn't be
bothered to do the trivial one that makes it useful.

