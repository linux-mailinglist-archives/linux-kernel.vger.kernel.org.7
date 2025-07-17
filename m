Return-Path: <linux-kernel+bounces-735909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7B7B0951E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 21:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48DB317ADD8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 19:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB962FCFFC;
	Thu, 17 Jul 2025 19:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Kswv4wdi"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D7DCA4B;
	Thu, 17 Jul 2025 19:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752781303; cv=none; b=cc24PRMs8tAFecty/GTOXwqbxGXamSdllLWwLq+MYHWvAKI0kyc7zEhX84E3mp43qT4q/4o/uTg4ndQBXfqsGaR/+t2/mXlKzHLiKlHN1Up5nguhMALgF0M8KVQmA/lFOXHFFLJtXjSbqCGczi02mQpb8+C5pJhFAJUOxm3a2K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752781303; c=relaxed/simple;
	bh=KQPRLbjIIFFOLW6bfUb07pFVo+R2I5cI4/b2Zw2nJpQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JtB7F/XsQTpb1Oy0/j5HtOXyEULfKp6PClZDl8HeFKGQGLCLc/XjGuIp3+i/E+PbHKVZLAsmuSgOSnwapw6LBvFsOEN+HJE5jQBkvsQ9kjpC5MIN76dYsxzXdD2LP/Z3ZVbevbK6Llga8nFKB+4Wk09cRbzIBjOki/Vz3S3YuJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Kswv4wdi; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 15AF6403E1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1752781301; bh=rmvWRnG6YIOBViJ2519P+js6uMde+DaULhJoWx6eh/Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Kswv4wdistut/nhc8EsaxC7nydVG+Wqs6cass9aVKrs7lQnUyQxCIAThC9flJtbbN
	 s1uSV4qmIHIf9HTwjWp8mLOncS5byP9ozLfbfhVpT4xvGODjv85crF11Ua72xIKjMZ
	 d1ozQeORbSzl7ZyKcBs1p32iMBB8mwaO3UwoS8gkunjPnp8bIr2qZfL/cfCDzD4voU
	 LUdj9BAlEMPq7ag+e9BYOSrcEKZORz+XIivEwjvDR9UudqloNdl3GnziuF5/8Zmabx
	 xYs6R0bwbiXMO5cXO36rHwDwimmRsjNfFGGxDDAEdFkp19rVlG5kZwyDPVS2lJ56rk
	 uGOvNZkmRZkdQ==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 15AF6403E1;
	Thu, 17 Jul 2025 19:41:41 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Ignacio =?utf-8?Q?Pe=C3=B1a?= <ignacio.pena87@gmail.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: Add patch-validator to dev-tools
In-Reply-To: <20250717162948.23078-1-ignacio.pena87@gmail.com>
References: <87wmjy92r6.fsf@trenco.lwn.net>
 <20250717162948.23078-1-ignacio.pena87@gmail.com>
Date: Thu, 17 Jul 2025 13:41:40 -0600
Message-ID: <875xfqbo5n.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ignacio Pe=C3=B1a <ignacio.pena87@gmail.com> writes:

> On Thu, Jul 17, 2025 at 09:38:00AM -0600, Jonathan Corbet wrote:
>> Interesting ... overall, we don't generally have detailed documentation
>> for out-of-tree utilities, though there isn't necessarily any reason why
>> we couldn't.  But I'm curious as to why you haven't submitted the tool
>> itself?
>
> That's a great question! I kept it external for a few reasons:
>
> First, I'm still pretty new to kernel development and wanted the freedom
> to iterate quickly as I learn what checks are actually useful. Being=20
> external means I can push updates immediately when someone points out
> a new common mistake (like Greg just did with the date check!).

I would guess, though, that you would get more people pointing things
out if you were to post the tool to the list and eventually get it in.
The kernel cycle isn't *that* slow in the end...

> Second, I wrote everything in bash for simplicity, which probably isn't
> the best fit for the kernel's scripts/ directory. Plus, as Greg mentioned
> in his reply, many of these checks really belong in checkpatch.pl rather
> than a separate tool.

It wouldn't be the only bash script, certainly.

> So my plan now is to work on patches for checkpatch.pl to add the most
> useful checks there (where they belong), while keeping the workflow=20
> helpers as an external toolkit.

It's your tool, you should develop it as you see fit, but keeping it
separate will make it harder to attract people to try it out.

Sending improvements to checkpatch is, of course, a good thing to do.

> Given this direction, would you prefer I withdraw this documentation=20
> patch? I'm happy either way - just thought it might help other newcomers
> in the meantime, but I totally understand if you'd rather wait until
> the checks are properly integrated into checkpatch.pl.

For now, it's probably best to keep the documentation with the tool
itself; at least, that's how it seems to me.

Thanks,

jon

