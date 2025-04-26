Return-Path: <linux-kernel+bounces-621294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C2BA9D75C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Apr 2025 05:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6E759A72E2
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Apr 2025 03:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F86204F83;
	Sat, 26 Apr 2025 03:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="luCRFcXb"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88D418DB0E
	for <linux-kernel@vger.kernel.org>; Sat, 26 Apr 2025 03:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745636985; cv=none; b=SBVPmQJCWLuv6zPU26UewdSLiszToJqF7JN1tWHHwhSujHnp+Nra1bdEESLQoHrSUD8aW1nGXnvoktRsHZUZvk54oGVINnzodyW+Ggs7f8qcFB8VXBv8GqiVHQO563L3+7j6gdPl9L1WcYV78wQNHNwvrG4m9j3XJQyMxhM97Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745636985; c=relaxed/simple;
	bh=441V5ESwkAxGr81gZEhh08rmYdBnNkpNFEQUap5lXmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ToUHOUoVJjuAzNwHdF5fINkp1V9FBMnfOZYinvQMJUSaHn8nJRz0sHy6mSo3vgjToG+OxwZy4EHpE6hbxt9ORZT/4LM/MLAtiweexaAmy2Il02TQwJWHofAGMvAyDHOUUMcUGnBJlENRzgNHibywlKiSyv8/LXD4hrI1vdPoNHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=luCRFcXb; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 25 Apr 2025 23:09:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745636981;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FdhrJFKY8wVSb1r5E4UtBdzhzCn51MOc3SmLaIlgc+s=;
	b=luCRFcXbUS92iZSWsmcP3ERBvSJF6ldURjsrhJDD2Wgso+SXeOilH/XyBR4sbLPQHyY7gd
	PS5FcFpu/A4fK8aevi3FlkYrWpRVEFT47JliBUuvOiEc4Gys6FsOhMhoImwLmhD5ownYwj
	nuGMAwe2WA5UinFxmb59hB1bA7D+p1c=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.15-rc4
Message-ID: <lmp73ynmvpl55lnfym3ry76ftegc6bu35akltfdwtwtjyyy46z@d3oygrswoiki>
References: <l7pfaexlj6hs56znw754bwl2spconvhnmbnqxkju5vqxienp4w@h2eocgvgdlip>
 <CAHk-=wjajMJyoTv2KZdpVRoPn0LFZ94Loci37WLVXmMxDbLOjg@mail.gmail.com>
 <ivvkek4ykbdgktx5dimhfr5eniew4esmaz2wjowcggvc7ods4a@mlvoxz5bevqp>
 <CAHk-=wg546GhBGFLWiuUCB7M1b3TuKqMEARCXhCkxXjZ56FMrg@mail.gmail.com>
 <q3thzkbsq6bwur7baoxvxijnlvnobyt6cx4sckonhgdkviwz76@45b6xlzvrtkr>
 <CAHk-=wh09TvgFu3WKaeLu8jAxCmwZa24N7spAXi=jrVGW7X9ZA@mail.gmail.com>
 <mlsjl7qigswkjvvqg2bheyagebpm2eo66nyysztnrbpjau2czt@pdxzjedm5nqw>
 <CAHk-=wiSXnaqfv0+YkOkJOotWKW6w5oHFB5xU=0yJKUf8ZFb-Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiSXnaqfv0+YkOkJOotWKW6w5oHFB5xU=0yJKUf8ZFb-Q@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Apr 25, 2025 at 08:04:08PM -0700, Linus Torvalds wrote:
> On Fri, 25 Apr 2025 at 20:00, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> >
> > No, what I wrote is exactly how CI lookups work with the dcache. Go have
> > a look.
> 
> Kent, I literally wrote most of that code,

The subject is CI lookups, and I'll eat my shoe if you wrote that.

> and you are claiming that the CI case is trying to be the fast case.

Are you being obtuse on purpose?

I'm saying the CI case is a combination of overoptimized and poorly
designed. I'm not saying the CI case is trying to be the fast path
relative to case-sensitive lookups, that would be insane.

