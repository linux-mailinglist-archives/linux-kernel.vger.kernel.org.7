Return-Path: <linux-kernel+bounces-853570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A428BDC00B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 03:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 25FA44EFB05
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 01:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766672FABF5;
	Wed, 15 Oct 2025 01:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="cF9Xc70q"
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297B11A2547
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 01:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760492222; cv=none; b=g1PMBOjZEXW37gLuzjafkvB/Wf/MiAZleAHNdZKFIcXqp0iWW2WyvFlkMdwBC+/cIRswpGVmNPVx7ed1bH+a1utVnpZRb+vAa2NnrpDIZvj+RfzSzhDcOYcOFhXUxHZniJHFximihEFWuw1+4zuzD5dbdfmrQ74SYzvqfMDh040=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760492222; c=relaxed/simple;
	bh=VNzuOIZtM7x0bC3NAKAfo3smiDRZDGgL03z+yyBpsFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RBu2SFnKjjDm1Z4YZIS0llBH3z10SdJx9PSf3BdIutp3MA2FsUAkcdZGtM1wvzdeTFq0jpR0m3OUf8Dgay3gJbpJGMW7loyseVLAlL2l1X1sUBrZpzuYpE7KSrLs5NXNMhNPCO7WYJd0stxdWQm91mWjWjU7Y/aur3XG+D6wnso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=cF9Xc70q; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-113-184.bstnma.fios.verizon.net [173.48.113.184])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 59F1ahs3025516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Oct 2025 21:36:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1760492204; bh=sRdFakBFwAe0WPdBT51ixaIfm1NY5cLZtUEuc3GPpmY=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=cF9Xc70qfRzwqBRFMm5DJU4TggVAvETofzQffQutEz0won3Xi4bV4t0x6qLotRZVs
	 b7aBjfIopbCnApA8hX2gPg4TD+rzduFjXz2HBkCTtztTaGllAZ8tY5YD0rHDrpSZnb
	 ofYDKJbYuWEdvIJQAIU/4BJhhPw1+qO90ocEfXoCV/YoLBmtWKTQgxN2pwgmDTbfnr
	 4rz7SlysxHeaqO7fTOmSM+EUMCsHK/1OlLSDqR9WD0k9LIZDrjeiqWIrpe8PfM41C1
	 uKTNIEHo/9OXBJulJqpf4vw6G6/3JGhJCSNln3NicPWz/9xCAiuaSef9yIf+t8VJwB
	 6f7a4lWz6YIjg==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 2A50A2E00D9; Tue, 14 Oct 2025 21:36:43 -0400 (EDT)
Date: Tue, 14 Oct 2025 21:36:43 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Developers List <linux-kernel@vger.kernel.org>,
        linux@roeck-us.net
Subject: Re: [PATCH] Use CONFIG_EXT4_FS instead of CONFIG_EXT3_FS in all of
 the defconfigs
Message-ID: <20251015013643.GC721110@mit.edu>
References: <20251014020604.684591-1-tytso@mit.edu>
 <CAHk-=wi52OZ642dxY=zdW+-nAY_KWtjsFs0mkAzzq74f65Da7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi52OZ642dxY=zdW+-nAY_KWtjsFs0mkAzzq74f65Da7w@mail.gmail.com>

On Tue, Oct 14, 2025 at 02:37:36PM -0700, Linus Torvalds wrote:
> On Mon, 13 Oct 2025 at 19:06, Theodore Ts'o <tytso@mit.edu> wrote:
> >
> > Commit d6ace46c82fd ("ext4: remove obsolete EXT3 config options")
> > removed the obsolete EXT3_CONFIG options, since it had been over a
> > decade since fs/ext3 had been removed.
> 
> Just checking: did you expect me to apply this directly, or was this
> more of a "FYI" and it's in your tree and I should be expecting it as
> a pull request?

It's an FYI, and so Guenter could unbreak his defconfig testing.  I
was waiting for my regression tests to complete before sending you a
pull request.  Those have come back green, so I'll be sending you a
pull request shortly.

					- Ted

