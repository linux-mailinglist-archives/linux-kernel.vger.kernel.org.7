Return-Path: <linux-kernel+bounces-893490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACCBC47917
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 16:35:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B7253BA853
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 15:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB902405E7;
	Mon, 10 Nov 2025 15:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="W2UsTThZ"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D730238C15
	for <linux-kernel@vger.kernel.org>; Mon, 10 Nov 2025 15:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762788306; cv=none; b=W/rIerU0PKz70DhjJ5/NJamIUiCW9Ozw7i2DD+9/b30CHDRAAaRwV0rs+KJOa37JDh0WpzxqlN0nNp9yiVruvCxiM2TYW/s4Y09C7oD9lhln00Ja0vUe7+pxrsqmuOa+HXfej1fDTYgC1Qy+Frv50agJDaXbNtDzmDcF+7oW94w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762788306; c=relaxed/simple;
	bh=Hf70xnTUzHT0AbtUYSYilJ3of2QDSmVqTAwGyxAZSMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+T+S2Df9wcoPVQ0AxC6HXRA4kMhx5IKhii/DKPg//JEsdRd02NtGq/t3aXwghBMIWAsquETItrbRYN3hNyyaSaMgNqFq9+vkOZvr2SQeRS2kosR9wyMrWr2gLmHjSdwcA+8/Q0BsyQseG++W70cpNwV6oHw32UhGxB0KgsEu6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=W2UsTThZ; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-122-154.bstnma.fios.verizon.net [173.48.122.154])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 5AAFNb2W023077
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Nov 2025 10:23:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1762788220; bh=LWsOtKf98HJ2h4K/ocg2B4qyQO2r0tUF3y7tZbw+0o8=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=W2UsTThZmVADUsN7gV4UmUcms2ZqQ2i4nHb4X8F/LPNuVxXsqL9R0711RQL/dMXcv
	 iQmLiX389vap5x6c4WWDQQtcsEO449v+0mPqYbB4ly6sPpQ2ID6U5t0mcdGtepwnzX
	 TicOy2AMVPWAl1BIB8yCyQeAydknyQH1ezopxMa2/i8GZHg7Sq/6wV8tH/zXMMbVUH
	 kyRNykUcEr3LT0idsob0Jsh5y4ikEq/I/SzmRz6UtcT0Vcu7pJCSHhgp7kVNEE7PRi
	 fm2myIyBHQyT8ccYxn4L2BnTi2DP6eDJrf2KP0nAtPIYXuOhd/nzwnBnY2/IwUcczn
	 IRalfEGgFo0Tg==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 1D24C2E00D9; Mon, 10 Nov 2025 10:23:37 -0500 (EST)
Date: Mon, 10 Nov 2025 10:23:37 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Pankaj Raghav <kernel@pankajraghav.com>
Cc: libaokun@huaweicloud.com, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca, jack@suse.cz, linux-kernel@vger.kernel.org,
        mcgrof@kernel.org, ebiggers@kernel.org, willy@infradead.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, chengzhihao1@huawei.com,
        libaokun1@huawei.com
Subject: Re: [PATCH v2 24/24] ext4: enable block size larger than page size
Message-ID: <20251110152337.GF2988753@mit.edu>
References: <20251107144249.435029-1-libaokun@huaweicloud.com>
 <20251107144249.435029-25-libaokun@huaweicloud.com>
 <52401c3a-26aa-473f-b7e2-1c658550dd37@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52401c3a-26aa-473f-b7e2-1c658550dd37@pankajraghav.com>

On Mon, Nov 10, 2025 at 01:51:28PM +0100, Pankaj Raghav wrote:
> 
> Are you adding the experimental flag because allocation failures can occur with
> LBS configuration or because it is a new feature (or both)?

I'm going to guess that it was added to mirror what XFS did.

I'll note that this is generally not the pattern for ext4, where we
tend to put these warnings in mke2fs/mkfs.ext4, and by not enabling
them by default.  We haven't historically put them as a warning printk
because I don't believe most users read dmesg output.  :-)

When we've wanted to put some kind of warning or disclaimer in the
kernel, my bias has been to add some kind of Kconfig feature flag,
say, "CONFIG_FS_LARGE_BLOCKSIZE" or "CONFIG_EXT4_LARGE_BLOCKSIZE"
which can either have a warning of its experimental nature in the
config descrption, or if it's *reallY* on the edge (not in this case,
in my opinion) by putting an explicit dependency on
CONFIG_EXPERIMENTAL.

I will admit that most users don't read the Kconfig help text, since
most uesrs aren't even compiling their own kernels :-), but it does
allow for more description of why it might be considered
"experimental" for distribution engineers, and it's less disruptive
when we inevitably forget to remove the experimental warning.  :-)

That being said, this is a personal preference sort of thing, and
people of good will can disagree about what's the best way to approach
this sort of warning.

Cheers,

						- Ted

P.S.  I'm happy not having any kind of experimental warning for bs >
ps, since users would have to affirmatively request a 64k blocksize in
mkfs, and most users don't override the default when creating file
systems, so I assume that people who do so Know What They Are Doing.

