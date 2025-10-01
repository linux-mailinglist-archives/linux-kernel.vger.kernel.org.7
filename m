Return-Path: <linux-kernel+bounces-838926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF577BB0707
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 15:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4292B177A92
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 13:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0446D2EC561;
	Wed,  1 Oct 2025 13:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KjdunqSq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548722882AF;
	Wed,  1 Oct 2025 13:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759324454; cv=none; b=V4y3ar4oPMVegDSkl7i3ULZ/tW639k1fRPIIm07YuZRCf3akL69Ab28nx8muDhMymJEaLubp6Ua28nc7/MxMCf8whC4HpZ9QdPNLjUtJai2bpjpSsZGVoxPrGSMPdNv814FsgA4PTeNc6SP+ePWfHBfIFxYM/SdrjHKf4dm5Ehc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759324454; c=relaxed/simple;
	bh=1fuegTCDJ3VX2Db+yt081Y4g9P//4SsbtF3kWv61KFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MiKpHF3l/6XiUom+HCGWfxX/4O6Vn6+dOyzjX/a9h6SlEC+YKxYbTwXOKGWQE5mBGOecv7zS1Dk6nOqR5nRpQRe3L1QPBcp2A+gN4Y7/Ae5Z55RiQ62JGI3hvirbgtCcKsolmgHOmTsNRDC5iXRwzXj+Qnvr+CGIwDMBY/oI+BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KjdunqSq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE248C4CEF4;
	Wed,  1 Oct 2025 13:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759324453;
	bh=1fuegTCDJ3VX2Db+yt081Y4g9P//4SsbtF3kWv61KFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KjdunqSq8ZhW8/6hBddU6bN6OEcOtqDMIwt8wcDn5thuNtDXVABEL3zMGHHoOVflm
	 +4UsoOOKpdHCWWy0Uc4E8BIVsPYOVjHiv1tRP1v82mQLVWlzjZ9x/GoPzKDMdr9GQc
	 XFL3flVQT9k50P/KsQFX0jrRztiWyCOF4DBRQQGOzeI5Mh+HTSJ4zmarGObp69OfTO
	 FhmmgjvD6//nVWs7nBKjM4FjJLQBKrFxagqrhfzZfQq5O5iCBilWZWJImFUZLr/46F
	 XCERDn1A3Cuw3tcnA8WTJLDFTThKY+vnq2d/w+WNx+FrLIN8Dzc+ehESC+0MvCaSfT
	 gEfmqZIFmdbzA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1v3wep-0000000BGYX-2d02;
	Wed, 01 Oct 2025 15:14:11 +0200
Date: Wed, 1 Oct 2025 15:14:11 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, 
	Linux Doc Mailing List <linux-doc@vger.kernel.org>, linux-kernel@vger.kernel.org, 
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH 0/2] some fixes for docs Makefile
Message-ID: <ybghatxyt7hzci5gmgxz7i6ae65h5ieizjxtmazaaanhwtjwvm@75lyu2zya3ds>
References: <cover.1758881658.git.mchehab+huawei@kernel.org>
 <875xcyvkvy.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875xcyvkvy.fsf@trenco.lwn.net>
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

On Wed, Oct 01, 2025 at 06:58:41AM -0600, Jonathan Corbet wrote:
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> > Hi Jon,
> >
> > Another small series against build-script branch with fixes.
> >
> > The first one removes bogus warnings when latex is not installed.
> > The second one has a small fix to avoid writing *.pyc cache at the
> > source dir.
> >
> > Mauro Carvalho Chehab (2):
> >   tools/docs/sphinx-build-wrapper: allow skipping sphinx-build step
> >   docs: Makefile: avoid a warning when using without texlive
> >
> >  Documentation/Makefile          | 13 ++++---------
> >  tools/docs/sphinx-build-wrapper | 18 ++++++++++++------
> >  2 files changed, 16 insertions(+), 15 deletions(-)
> 
> I've kind of lost the plot with all of these patches but, in any case,
> this one doesn't apply here.  If it's still needed, can I request a
> resend?

Sure. I'll rebase what I have, retest and send you on a single
patch series.

> 
> Thanks,
> 
> jon

-- 
Thanks,
Mauro

