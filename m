Return-Path: <linux-kernel+bounces-758389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CE2B1CE5F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 23:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 046537AB2FF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 21:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DF522618F;
	Wed,  6 Aug 2025 21:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XaDw80MR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB3919A;
	Wed,  6 Aug 2025 21:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754515626; cv=none; b=BTcLoN7h/YXLvcgwV6VoJowUxg5B99xoW3TwibYrcdHNVG4GSLcPkXm8QkSuJyBxDdzYtXSzNZCUQCP3XTfvEhwrBhalqMp16Gk1sYPmfGq2w49FyixhfzlBK2Jongby4VFCncQBvcqqnDkI2pahsxVS4Xs1oE4i7xNBWiw5QgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754515626; c=relaxed/simple;
	bh=fd/y8s58skXcwfOKZg2Po6E8sPjD5keSHwvzdWhHovo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hyd049Eo1liF+rWoiMsSCszRjcWuZ0Pgo+qKClFxFqiy+nDDO8PnmpGWKqnEcT77TDHZRiQGEM0iXc55A/uFotuf2HZoqz1YN7ZMJ11PrStFNGp7BDcmvO2veYErW1oRPE2fqcdsqkVN0ePE/beAi2pWFCZQOKpkR5m4fd+bAcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XaDw80MR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C7AC4CEE7;
	Wed,  6 Aug 2025 21:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754515625;
	bh=fd/y8s58skXcwfOKZg2Po6E8sPjD5keSHwvzdWhHovo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XaDw80MRNAQJIgiRSKQYiO+D02uaRQuln7L9Sz1bVZJ1vi1JQR9KkXtR+W1Q1qWP0
	 GFcLghCHx7DXn+vkZf8KzxOjGvOn0s1R1H18bwMPbNTAnco0TL4OndZLfvHqegvdZ+
	 KDMP8mpN9vM2L6fXxthIFE3lzWC4qm1pVY+5DQWWX8n6mnqQE0FCOTit69ZIlR/D29
	 y7b7GOcG1tUrMhaM5RpoY4+sK1J4T7p0RxLHcS8jMKf2KglnVyiYNybCBrP7OudLMK
	 PJNhiGY/lrEUvrpjDpvGnoNT7gv7RvpO3mpyYsbx4QYb7/6mMsr4T9N+pgo8Wq6V8S
	 D+GPlJasv3tHg==
Date: Wed, 6 Aug 2025 23:27:01 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>
Subject: Re: [PATCH 10/12] docs: kdoc: further rewrite_struct_members()
 cleanup
Message-ID: <20250806232701.67b707ee@foz.lan>
In-Reply-To: <87ikj0k3ks.fsf@trenco.lwn.net>
References: <20250801001326.924276-1-corbet@lwn.net>
	<20250801001326.924276-11-corbet@lwn.net>
	<20250801080744.14f83626@foz.lan>
	<87v7n6pscu.fsf@trenco.lwn.net>
	<20250804151511.73ffb949@foz.lan>
	<87ms8djsjx.fsf@trenco.lwn.net>
	<20250806110538.35bcc127@foz.lan>
	<87ikj0k3ks.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Wed, 06 Aug 2025 07:00:19 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> >> > Btw, on this specific case, better to use non-capture group matches
> >> > to avoid those "empty" spaces, e.g. (if I got it right):    
> >> 
> >> The problem is this line here:
> >> 
> >>                 oldmember = "".join(t) # Reconstruct the original formatting
> >> 
> >> The regex *has* to capture the entire match string so that it can be
> >> reconstructed back to its original form, which we need to edit the full
> >> list of members later on.
> >> 
> >> This code could use a deep rethink, but it works for now :)  
> >
> > well, we can still do:
> >
> > 	for t in tuples:
> > 	    maintype, -, -, content, -, s_ids = t
> > 	    oldmember = "".join(t)
> >
> > this way, we'll be naming the relevant parameters and reconstructing
> > the the original form.  
> 
> I've already made a change much like that (the "-" syntax doesn't work,
> of course);

Gah! sorry for the typo. I meant to say:

	maintype, _, _, content, _, s_ids = t

> I hope to post the updates series today, but it's going to
> be busy.
> 
> > Btw, while re.findall() has an API that doesn't return match
> > objects which is incoherent with the normal re API, while looking
> > at the specs today(*), there is an alternative: re.finditer(). 
> > We could add it to KernRE cass and use it on a way that it will use
> > a Match instance. Something like:
> >
> > 	# Original regex expression
> > 	res = Re.finditer(...)
> > [...]  
> 
> A definite possible improvement for later... :)

Ok.

> 
> Thanks,
> 
> jon



Thanks,
Mauro

