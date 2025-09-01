Return-Path: <linux-kernel+bounces-794305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6977CB3DFCF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 12:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20A5D160D86
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 10:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A716B2FF64A;
	Mon,  1 Sep 2025 10:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="L0GpEZAd"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE4B2367A0
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 10:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756721437; cv=none; b=FmBrooQmKOFH+cVdDjtQPmfvahK/+CK1JIer4CQ+Y5By6UFDQImwJk4r2q4H38/uA8TB9jm3C4iGFsz6siICTZmB2OeD878mLDZqJmR9RXESYaCAgkcsAg0VR/GbLjdJWpNb53GREFXXWWu6+1hsRre0DFIXi6Q1M4hg0Q/KHIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756721437; c=relaxed/simple;
	bh=mr+/rrqD0RsXkLD93tqMCKXdAHEjECiKDKizSsZYWWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oobzvylN900yj+zTx14y1z9t7TENhm9kINVbkZnxUNewZpnDJc7l1Yuv8eW96Pp0cbOS5RFV3W+eRuLnNJx0s5HquoUIEhmtXmlO5bNgNyRIQtlinf3RvyBiuzw5pF4p6qIpyLbM84v5iQCYfOVULXydgXcct0dm5k6qtJom/0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=fail (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=L0GpEZAd reason="signature verification failed"; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6E82340E019E;
	Mon,  1 Sep 2025 10:10:30 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id BfKmIhEDODP7; Mon,  1 Sep 2025 10:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1756721426; bh=CuDkbBHaOkz3S6dxH5sofEzQV09UxorXmN0sQT3iX1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L0GpEZAdUljQTEMv7mxmRwOoYWcAUqok6js/WWsircC3BXT47ypAXYme4KN5uNCgF
	 SCSDPWvgHMYmsGN0xKnHqLNKfCNKESGObmD2B+CwuOqTnrtxGU7Qb2D+Amvscr75pM
	 sFcd4z7lpbM6p6a5D+WNqgnkAHxeOv+kVj2QZsuVvW1ZCJd0mi1kjoGOW6q0lw7I4U
	 C8A3RLFd12tBytBL+LcUJs66qjN1ph2YTA5tnB6VfqnqSEPEP9eYIzVXBFR3VjrvIn
	 hF+09kr/5x9kQQ4TpvFkuMkvS9A28jnSvDPEDfX6gkF4t+EFGH+h61AMMLe5QszwPI
	 0zOx7beM379x1l57qw/6aQEjRFLrx80Brn/+TS6/ezwfyyBj7i5pGB34lKAJGS/tp7
	 +5QCK4CES8WCZF+ZP3ua+NELQQ2fvFRMbwT8YmtPn2GPzKCi70wa0fqCBmwv8pFNzu
	 XkzWlJgUZa0TEGkPBtKIRPUWE9LULcxs7m20x6XZLqK0JPdfm7inaDwY+TbQeMDDFV
	 +7tjqndQ+uVW6v9bd63A+XNHv5VgMzU+kgKbRbR8anj+90dpBqjFVQ9rozFyv2mMwu
	 HN82cmBWgBBuypmAGU/2tZjo9j1YRYdYd2NIeD3Gp/1FvLPbcd1NqYX2STEn5Bjiyv
	 LmQSHCllJg7I2k/z3VOx6xNs=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id DA82840E01A2;
	Mon,  1 Sep 2025 10:10:18 +0000 (UTC)
Date: Mon, 1 Sep 2025 12:10:11 +0200
From: Borislav Petkov <bp@alien8.de>
To: Michel =?utf-8?Q?D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Cc: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: evergreen_packet3_check:... radeon 0000:1d:00.0: vbo resource
 seems too big for the bo
Message-ID: <20250901101011.GAaLVxA_Ax0R-Wy2IX@fat_crate.local>
References: <20250829171655.GBaLHgh3VOvuM1UfJg@fat_crate.local>
 <CADnq5_Oqonrth+5T-83dnFBZ67GvykkPt-9aUepJd+fUMwnupw@mail.gmail.com>
 <20250829194044.GCaLICPKJcGJRYdSfO@fat_crate.local>
 <20250829204840.GEaLISKGTwuScnDF8Y@fat_crate.local>
 <CADnq5_MbpYmC2PSyOr0gQk7F8mVz0-LG3dZtUZS2HhV8LTgDww@mail.gmail.com>
 <20250830174810.GAaLM5WkiFc2BtQ6kW@fat_crate.local>
 <51ae551b-6708-4fcd-84f9-fc1400f02427@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <51ae551b-6708-4fcd-84f9-fc1400f02427@mailbox.org>
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 01, 2025 at 11:27:01AM +0200, Michel D=C3=A4nzer wrote:
> use some kind of debug output API which doesn't hit dmesg by default

You still want to be enabled by default so that normal users can see it a=
nd
actually report it.

> (can be a non-once variant instead, that's more useful for user-space
> developers).

I don't see how a non-once variant can tell you anything new - it is repe=
ating
one cryptic message to most users so what's the point of parroting it mor=
e
than once?

IMO, that message should be beefed up to have more information, dump it o=
nce
and encourage users to report it.

Then, whoever gets to debug it, will ask for a reproducer and then do the=
ir
own kernel patching to add more info and make the message more useful to =
them
when debugging the thing.

At least this is how I would do it...

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

