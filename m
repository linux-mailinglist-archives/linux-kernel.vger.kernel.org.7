Return-Path: <linux-kernel+bounces-754176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 73523B18F5F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 18:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 67F6D4E04AD
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 16:26:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A5824A057;
	Sat,  2 Aug 2025 16:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="svcydBnD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E8DA48;
	Sat,  2 Aug 2025 16:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754151985; cv=none; b=sDwlYVEx5qG/2Y7OGsm5JfDKLtuE7y22jVwPFUybP4dPEjv6bzm8oMFhDUWSBl5+J2KOsQFC8Y1WaXod8mTydRcwVb/z+iHgA+S4ZuMWPScUlghq/kXWV5Zy6K5Vh8KvEHBT1Blr+2cUegBgnBi5k4RzP/Doyp04/0/dHkbxoH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754151985; c=relaxed/simple;
	bh=W0ZacJKxa8AZBkVMM8nSyCWTVkVdazHmu557pWLPoto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jxJaj/PpDiqaM6fZ8VroH/cwNiMdfjIDrM2NAwNLSx4swSv6DUXYcywpflBkxekCVRwjKJjVuahUxCBE9TGNk2ffmwIPLVCscpmUa091kn9UHkeGCrgmnmAHcWLmNPxQLMtcxC0IrWFIpmQ3Czy9hsefZdwUAjHCSnN3D0IgQxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=svcydBnD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C48C4CEF4;
	Sat,  2 Aug 2025 16:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1754151984;
	bh=W0ZacJKxa8AZBkVMM8nSyCWTVkVdazHmu557pWLPoto=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=svcydBnDUxJF+sO6JuBzszDOfXYqJMWJKqWyq7wHYX+1JbaVZSfsalyxiHJcYJ/Ls
	 c7FM0J+tb/n+iHJyDz4h1QAVgAjg5hzhqgTJGTO9EtNWy11KWSsEQwoE8jVYlb5uII
	 SBkFIO5AZfqk9o4jl57pWzsBcBNq1sHFLGevEylY=
Date: Sat, 2 Aug 2025 12:26:22 -0400
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jani Nikula <jani.nikula@intel.com>, 
	Krzysztof Kozlowski <krzk@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Hendrik Hamerlinck <hendrik.hamerlinck@hammernet.be>, dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com, 
	joe@perches.com, corbet@lwn.net, apw@canonical.com, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev, workflows@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] checkpatch: validate commit tag ordering
Message-ID: <20250802-hog-of-eternal-realization-a9ab6f@lemur>
References: <20250724072032.118554-1-hendrik.hamerlinck@hammernet.be>
 <53eb0068-008b-48e6-9b92-d92de2ed4fc9@kernel.org>
 <CAMuHMdU2e+5Hf3v=C=sE=+25f_A=2=Zzw5rxvcT=hb75VC=iFQ@mail.gmail.com>
 <45f0995f-17ac-45a3-8bc0-3b276ee91a9d@kernel.org>
 <3e9106d35d41a044adeadffeea32fa096c9e1370@intel.com>
 <20250802121200.665ea309@foz.lan>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250802121200.665ea309@foz.lan>

On Sat, Aug 02, 2025 at 12:12:00PM +0200, Mauro Carvalho Chehab wrote:
> > Let's just decide whatever order b4 uses *is* the proper order, and save
> > ourselves endless hours of debating! :p
> 
> I don't think it makes sense to have a "proper order" verified on
> checkpatch, as some tags may appear on different places.
> 
> For instance, the custody chain was designed to have SoBs appearing
> in different places:
> 
> - author(s) SoB together co-developed-by are usually the first ones;
> - then patches may have been reviewed, tested, acked or passed on some
>   other trees, gaining tags like tested-by, R-B, A-B, SoB, Cc;
> - the subsystem maintainer will add his SoB in the end.
> 
> non-custody chain tags, like fixes, closes, reported-by...
> usually comes first, but I don't think we need to enforce an specific
> order.

I wholeheartedly agree -- it really doesn't matter the order the trailers are
in, as long as it's clear who is the person who pulled the trailer in, which
is why I stick to the chain of custody. I'm pretty sure nobody has ever looked
at a commit and went "I can't believe they put the Link trailer above the
Suggested-by trailer," so enforcing it in checkpatch seems like wasted effort
to me.

-K

