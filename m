Return-Path: <linux-kernel+bounces-894050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E125BC49259
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 20:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2628188644F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 19:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0811832E738;
	Mon, 10 Nov 2025 19:54:11 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E0832E124;
	Mon, 10 Nov 2025 19:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762804450; cv=none; b=kGE77XOh+g7u88/7mJ0ZkrR7/vUvYkVl+tiaUc4AAqx0zFxS/onFFt+HL6+z5eXJPuFaRH00K6TdwMLmgrctlT7eofCvnxs0ppFxmgO3j8Uwd6ArpKQ7wyE7mztIysEUZR1oGKvDU+t6wAiBe0NrZjEpXYO+M0XEvS4Pj3GoQ54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762804450; c=relaxed/simple;
	bh=xb+DXZYDEOovalo/bMCSL2f9qW8b2PYk7b5e+tKOcA8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tVpfC8JwU7yf9P2cVqd8OJS83rMh9DL3ESk5pz4gyvHM42ojuP9xrZpKZrGGRbqE4PA09Ns+lSlr0K8zQZs4R37bkmSxn1VmxQrpboY3D0Ykw4nK6W/BzZqmY8jqzFPwj6c+R+x3/8HsTtU0+6U0FL5SQ2yg1rFwVVWVBmnilKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 2578357F37;
	Mon, 10 Nov 2025 19:54:00 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 6BBAA2002C;
	Mon, 10 Nov 2025 19:53:56 +0000 (UTC)
Date: Mon, 10 Nov 2025 14:54:05 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Mike Rapoport <rppt@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Christian Brauner
 <brauner@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Vlastimil
 Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
 "workflows@vger.kernel.org" <workflows@vger.kernel.org>,
 "ksummit@lists.linux.dev" <ksummit@lists.linux.dev>, Dan Williams
 <dan.j.williams@intel.com>, "Theodore Ts'o" <tytso@mit.edu>, Sasha Levin
 <sashal@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Kees Cook
 <kees@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Miguel
 Ojeda <ojeda@kernel.org>, Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH] [v2] Documentation: Provide guidelines for
 tool-generated content
Message-ID: <20251110145405.5bc87cc5@gandalf.local.home>
In-Reply-To: <CAHk-=whczwG=+-sAzoWoTY_VOwdFH3b5AkvQbgh+z98=p1iaXA@mail.gmail.com>
References: <20251105231514.3167738-1-dave.hansen@linux.intel.com>
	<653b4187-ec4f-4f5d-ae76-d37f46070cb4@suse.cz>
	<20251110-weiht-etablieren-39e7b63ef76d@brauner>
	<20251110172507.GA21641@pendragon.ideasonboard.com>
	<CAHk-=wgEPve=BO=SOmgEOd4kv76bSbm0jWFzRzcs4Y7EedpgfA@mail.gmail.com>
	<aRIxYkjX7EzalSoI@kernel.org>
	<CAHk-=wir-u3so=9NiFgG+bWfZHakc47iNy9vZXmSNWSZ+=Ue8g@mail.gmail.com>
	<A274AB1C-8B6B-4004-A2BC-D540260A5771@zytor.com>
	<CAHk-=whczwG=+-sAzoWoTY_VOwdFH3b5AkvQbgh+z98=p1iaXA@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 1zpbhrdnkczb8p84ob86epm6cgmfaeer
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 6BBAA2002C
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX188rcYaq/VcpOMpuxiN+mCOVwn8TkW8hVI=
X-HE-Tag: 1762804436-786591
X-HE-Meta: U2FsdGVkX1+Y4d9D5TU/Zt0fkohlktXpFR1HWk/qRVIvkqMHdUh8tz0tNvRUzmamdqgPUW60sBbX+4zK3vJL6fg6VF2bmBlU7UmeYcZfzeAdDRQe22HGUNNdbDGGxMt9y+U9bJU3LansQC2b3agidz+P8tsNIlMzN1wdYlNv9j4QLPFvWy20LvXrmZxNajerzJf0KNd5yhiHzRQ5G5kfMKzUPBHsmZDpRyxkEVI5+R5uNwfz/cSTWF4mUtg+9/WsH2RXkLEv4k/QCO2MfG2rer/c6AxsL0jYyBEJYsqKq9OMecWZOfA45MmZhfqSfuyMmiM3QwC3Re2zhbzZLGulFqCz3LtDPPQ9yexoj508jDODekv/UpdEMELUH4AILS9o

On Mon, 10 Nov 2025 11:36:00 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> What's the copyright difference between artificial intelligence and
> good oldfashioned wetware that isn't documented by "I used this tool
> and these sources".

Probably no difference. I would guess the real liability is for those that
use AI to submit patches. With the usual disclaimers of IANAL, I'm assuming
that when you place your "Signed-off-by", you are stating that you have the
right to submit this code. If it comes down that you did not have the right
to submit the code, the original submitter is liable.

I guess the question also is, is the maintainer that took that patch and
added their SoB also liable?

If it is discovered that the AI tool was using source code that it wasn't
supposed to be using, and then injected code that was pretty much verbatim
to the original source, where it would be a copyright infringement, would
the submitter of the patch be responsible? Would the maintainer?

I guess this would be no different if the submitter saw some code from a
proprietary project and cut and pasted it without understanding they were
not allowed to, and submitted that.

If the lawyers come back and say the onus is on the submitter and not the
maintainer that the code being submitted is legal to be submitted under
copyright law, then I'm perfectly fine in accepting any AI code (as long as
the submitter can prove they understand that code and the code is clean).

But until the lawyers state that explicitly, I can see why maintainers can
be nervous about accepting AI generated code. Perhaps this transparency can
make matters worse. As it can be argued that the maintainer knew it was a
questionable AI that generated the code? (Like it would be if a maintainer
knew the code being submitted was copied from a proprietary project)

This is out of scope of the current patch, as the patch is about
transparency and not AI acceptance.

-- Steve

