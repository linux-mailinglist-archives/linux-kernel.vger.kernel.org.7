Return-Path: <linux-kernel+bounces-751260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BA3B16702
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 21:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 892E61AA5F90
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB0A20297C;
	Wed, 30 Jul 2025 19:40:29 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8467C1A0BF3;
	Wed, 30 Jul 2025 19:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753904428; cv=none; b=Bbk22jhz9yrhx6HfODsUgeOT2TakNdpW3XqMPkKCIXS6i+h10fyki9Wo6Il7XLjBOGxIx8g2zjprHly/JadKHAHVAHJGbPgKpx3C/GAEMkngZUt8jUvaZo+OjywYkJe9C5m+aODheFEtZCUCyeRKKd2at1tKoPqYBPSChwzyYgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753904428; c=relaxed/simple;
	bh=KWgBuSkncc6y7As6BoY5MuN8lrmk72EBboRte+fMyHs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mzB1wpzyE7VverewtJDx4CVnfiWi+EsQHgtEi25yD6jo4x8oOLHfkgI1Hvr5D+Cx4cXj3SxbuF9Ix0lyK+6uuP5McuFeGfnsjgoCIKzcLkmgyw8tZ2VmCvOXPc88oSDZLfEiKlAC3KiZlQbLgjTIRSFJ6vZ+ymNSDRLaca+hZ5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf15.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 4E628807D6;
	Wed, 30 Jul 2025 19:40:24 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 5A74B1A;
	Wed, 30 Jul 2025 19:40:21 +0000 (UTC)
Date: Wed, 30 Jul 2025 15:40:38 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Sasha Levin <sashal@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Greg KH <greg@kroah.com>,
 corbet@lwn.net, linux-doc@vger.kernel.org, workflows@vger.kernel.org,
 josh@joshtriplett.org, kees@kernel.org, konstantin@linuxfoundation.org,
 linux-kernel@vger.kernel.org, Linus Torvalds
 <torvalds@linux-foundation.org>, "Dr. David Alan Gilbert"
 <linux@treblig.org>
Subject: Re: [PATCH 0/4] Add agent coding assistant configuration to Linux
 kernel
Message-ID: <20250730154038.50e2a027@gandalf.local.home>
In-Reply-To: <20250730191033.GA441972@mit.edu>
References: <7e7f485e-93ad-4bc4-9323-f154ce477c39@lucifer.local>
	<2025072854-earthen-velcro-8b32@gregkh>
	<df188552-c2dd-4cb7-9f6a-74e05e677dfc@lucifer.local>
	<20250730112753.17f5af13@gandalf.local.home>
	<158707d7-6729-4bb6-bc72-7556d11bfaef@lucifer.local>
	<20250730121829.0c89228d@gandalf.local.home>
	<aIpKCXrc-k2Dx43x@lappy>
	<20250730130531.4855a38b@gandalf.local.home>
	<aIpah6DTRd99mMqb@lappy>
	<20250730175909.GO222315@ZenIV>
	<20250730191033.GA441972@mit.edu>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: mwy4o3zh648iwaqee63g8kotmtsqmy7o
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 5A74B1A
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19vcu5E+lSpt658nnaRs+iJcHDr1bZcksM=
X-HE-Tag: 1753904421-431025
X-HE-Meta: U2FsdGVkX18sDcuDZX/UduOsNpT/bKi8xeNk7JQVWLxiLfm8KQktXygPUgoFZTzTq3G2VN0XTLoYyhVhdSLs+xW044gJ6wACRsxItoKjYxE1l6zKqIxCGxYAGLO2GcvZriMLgb2o4LJfoytjLd72K1wGSH1aXfxz3PVxwCKz/rJn+4YvV39+fPdMUSArBY8PhGIdDJLpfv6NHlLsP3p3z3+GjZt8gkLVgPz8NIV7VJrtrBm/Z+XtV9I8izhTJI30UW+XG1jCzv/0UXdCaGKeISulTwQ2+T5DR+8iys/zOULUODqHSeAYEb66kJHJfOJR

On Wed, 30 Jul 2025 15:10:33 -0400
"Theodore Ts'o" <tytso@mit.edu> wrote:

> Any tool can be a force multipler, either for good or for ill.
> 
> For example, I suspect we have a much greater set of problems from
> $TOOL's other than Large Language Models.  For example people who use
> "git grep strcpy" and send patches (because strcpy is eeeevil), some
> of which don't even compile, and some of which are just plain wrong.
> Ditto people who take a syzbot reproducer, make some change which
> makes the problem go away, and then submit a patch, and only for
> maintainers to point ut that the patch introduced bugs and/or really
> didn't fix the problem.
> 
> I don't think that we should therefore forbid any use of patches
> generated using the assistance of "git grep" or syzbot.  That's
> because I view this as a problem of the people using the tool, not the
> tool itself.  It's just that AI / LLM have been become a Boogeyman
> that inspires a lot of fear and loathing.

I think some of the fear is that when a new tool becomes available, that a
bunch of patch monkeys start sending "fixes" to the maintainers because
said tool said so. There's been times I had to ask for the cocci scripts to
be changed because too many people were flagging so called issues in my code
that were more of guidelines and caused no real bugs.

LLMs are now a huge new feature that many companies (including ours) is
highly encouraging their engineers to start using. I can see when someone
gets comfortable with the LLM code that is produced, they then start
pointing their attention on us. Kernel code has a lot more subtleties than
other code (like stack constraints, interrupts, etc) that an AI may not be
aware of.

This might just be paranoia, but we want to be prepared if it does happen.

-- Steve

