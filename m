Return-Path: <linux-kernel+bounces-621267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 909AAA9D70C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Apr 2025 03:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3F141BC72B5
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Apr 2025 01:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836161EB5DA;
	Sat, 26 Apr 2025 01:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s2+fqNlk"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FE51898FB;
	Sat, 26 Apr 2025 01:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745631493; cv=none; b=dP0nUsZrZY+uklTqg/jRXJ9JGrQCgrpsBkspWnZiU6VpTNnl0lPV09gjmxwugUE7vs5fxGIz9vRw2nr/pJC4P9uB4xCvsStjzPF0NQYw58qkejX4bPHC4Gwe9JvkLNTG0pnmhiykrytNMtQ4dqKzIfofMjOIgJHIocShIzVjAUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745631493; c=relaxed/simple;
	bh=ogcQIujD79K4IHDyOfmSYQEQC9XIlGMIxKjhrhahnKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WDtHpsHIAv8QJsgMAX43vd/mqdvc+hd2TwT1d6XlU7csCr0z6KpLKtPCfIW5N3x7zzyqEKXjl9n2vKPAGO2NCHdykSigk7Qv0ySjj3SHwGLoKa/ZiNIrD6XBqUIqAcoeszGZee6m+6K/1nu8vx+cPO/o5XHvtWHltHk+pZHVWn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s2+fqNlk; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 25 Apr 2025 21:38:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745631487;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UlQDI5leMOTzecRb0HcGY/zda5YRvxMOa39eLdxx4kw=;
	b=s2+fqNlkqe8x/x8xYgOlBo7yrtcd78bTQ0F0bEdu9edVE4ilRpVdbUZuhNCdGIBmjv8XxJ
	4H6/Gg+ylUi9ywCE921e16l6puX+zIovYpaI7fvsM+xrVPBv/eRhWrTh7k0MCT8pmAJV7c
	Tjv24IFZVyYutG5ZduoKWNoT+1ONWP4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] bcachefs fixes for 6.15-rc4
Message-ID: <q3thzkbsq6bwur7baoxvxijnlvnobyt6cx4sckonhgdkviwz76@45b6xlzvrtkr>
References: <l7pfaexlj6hs56znw754bwl2spconvhnmbnqxkju5vqxienp4w@h2eocgvgdlip>
 <CAHk-=wjajMJyoTv2KZdpVRoPn0LFZ94Loci37WLVXmMxDbLOjg@mail.gmail.com>
 <ivvkek4ykbdgktx5dimhfr5eniew4esmaz2wjowcggvc7ods4a@mlvoxz5bevqp>
 <CAHk-=wg546GhBGFLWiuUCB7M1b3TuKqMEARCXhCkxXjZ56FMrg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg546GhBGFLWiuUCB7M1b3TuKqMEARCXhCkxXjZ56FMrg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Apr 25, 2025 at 09:35:27AM -0700, Linus Torvalds wrote:
> On Thu, 24 Apr 2025 at 21:52, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> >
> > And the attitude of "I hate this, so I'm going to partition this off as
> > much as I can and spend as little time as I can on this" has all made
> > this even worse - the dcache stuff is all half baked.
> 
> No. The dcache side is *correct*.
> 
> The thing is, you absolutely cannot make the case-insensitive lookup
> be the fast case.

That's precisely what the dcache code does, and is the source of the
preblems.

Case insensitivy in the dcache caches the case sensitive name the lookup
was done with, not the case insensitive name we do the comparison
against.

That means we end up with extra aliases - and potentially an _unbounded_
number of aliases if someone is screwing around. Given the problems
we've had with negative dentries, that sounds like a DOS attack waiting
to happen.

It also introduces tricky corner cases into the filesystem code; last
bug I was chasing last night was one where without calling
d_prune_aliases(), those aliases would stick around and end up pointing
to an old version of the vfs inode when the file was deleted and
recreated, which was only caught by bcachefs assertions in our
write_inode method. Eesh.

And that's to say nothing of the complications w.r.t. negative dentries.

I would've rather had the dcache itself do normalization in pathwalk,
and only cache the _normalized_ dirent name.

That would've made lookups a tiny bit slower - but like you said, who
cares; we don't need case insensitive lookups to be the fastpath. RCU
pathwalks would've still worked, it wouldn't have been huge.

Maybe the samba people cared, I haven't looked up the original
discussions. But it seems more likely the determining factor was keeping
case insensitivity out of the dcache code.

> Now, if filesystem people were to see the light, and have a proper and
> well-designed case insensitivity, that might change. But I've never
> seen even a *whiff* of that. I have only seen bad code that
> understands neither how UTF-8 works, nor how unicode works (or rather:
> how unicode does *not* work - code that uses the unicode comparison
> functions without a deeper understanding of what the implications
> are).

Since you're not saying anything about how you think filesystems get
this wrong, this is just trash talking. I haven't seen anything that
looks broken about how case insensitivy is handled.

And honestly I don't think the security "concerns" are real concerns
anymore, since we're actively getting away from directories shared by
different users - /tmp - because that's caused _so_ many problems all on
its own.

(But unicode does create problems with e.g. all the different space
characters, because if you do have a shared directory you can now do
sneaky things like drop in a file that appears to have the same name as
another file, and try to get a unsuspecting user to click on the wrong
one. I don't think that's something the filesystem needs to be getting
involved in - that's a "don't use shared directories, idiot" problem,
i.e. your permissions model is broken if you're affected by that.)

> It's in filesystem people who didn't understand - and still don't,
> after decades - that you MUST NOT just blindly follow some external
> case folding table that you don't understand and that can change over
> time.
> 
> The "change overr time" part is particularly vexing to me, because it
> breaks one of the fundamental rules that unicode was *supposed* to
> fix: no locale garbage.

First off, since the unicode folding rules are referenced by the on disk
formats, they are _not_ changing without review by filesystem folks.

Actually - not in the case of bcachefs, since we store both the
normalized and unnormalized d_name.

Like Ted said, updates that simply add folding rules for new unicode
charecters are totally fine. Aside from that, everyone agrees with you
that we don't want locale garbage, literally no one is asking for that.

So I don't know where yuo're getting that from.

In filesystem land, we version things because you'd be BLOODY STUPID not
to - not because we plan on making changes willy-nilly.

