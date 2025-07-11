Return-Path: <linux-kernel+bounces-728097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD0DB0239F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E906818884A7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D682F2C4A;
	Fri, 11 Jul 2025 18:28:50 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7452F2C5C
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 18:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752258530; cv=none; b=HhyT8btJ1NWYUpEAB4BnQgbac06WxqbALUgaUm/6jNrgouSf0HFheN1wjk2vv47YZbggOgXO9totyDWK/dgFTG3+YaI+3HiZFdKifGWRPZPu2rhkI/NBc8WzSdh7nnM6gQ8UJ4iWMc5FtPzxNl+mZyzxpQzI5lvOdUayvy/rHQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752258530; c=relaxed/simple;
	bh=outJhnfIPj3CtWBSGlrgZTEfaH9N0Vkd8cGgr9/YQTk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OJPPGBs0lnQ1rCjiAzKHEkezL0fmMOk9v3QcPsPpRJ1v5deRnjarssHjMNif8LiRKvi5Ynutg94Edn9z/OSTwVHpIisi5WItelAtoqOX0Zft7JaXTyqs36Hko61otJxH+zgddxB3gz9O6YZkBaX6i33aeKD/SGBZKg2KUZ8AZZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 02A1D16037E;
	Fri, 11 Jul 2025 18:28:39 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id ED04280013;
	Fri, 11 Jul 2025 18:28:35 +0000 (UTC)
Date: Fri, 11 Jul 2025 14:28:34 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Christoph Hellwig <hch@infradead.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org, Josh
 Poimboeuf <jpoimboe@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, Indu
 Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, Beau
 Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton
 <akpm@linux-foundation.org>, tech-board-discuss@lists.linuxfoundation.org
Subject: Re: [RFC PATCH 2/5] unwind: Export unwind_user symbol to GPL
 modules
Message-ID: <20250711142834.73b2864c@batman.local.home>
In-Reply-To: <2025071104-amnesty-flashback-b883@gregkh>
References: <20250709212556.32777-1-mathieu.desnoyers@efficios.com>
	<20250709212556.32777-3-mathieu.desnoyers@efficios.com>
	<aHC-_HWR2L5kTYU5@infradead.org>
	<20250711065742.00d6668b@gandalf.local.home>
	<2025071124-cola-slouching-9dd2@gregkh>
	<20250711091734.5632dcf7@gandalf.local.home>
	<2025071127-reunion-residence-c0f2@gregkh>
	<20250711133240.0d5b6de8@batman.local.home>
	<2025071104-amnesty-flashback-b883@gregkh>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: ED04280013
X-Stat-Signature: i3z4faxtrmkozuk5qxyz18e7fzsyk5r8
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19pg25gEp69pG4NS/hQ9JTRR813gkb9KVA=
X-HE-Tag: 1752258515-552660
X-HE-Meta: U2FsdGVkX1/7CrFkhCQXB5of5GMFPGqL6fg8KBhpdO53QEOz+7ZrVoyC1gU8cld4BJu4xCBhEXBiNfRj7IN67Z4M3w/zUD07BhfvkERxYFJfeDlExeCMbhIqok2NQTf2ezuwzCEQLj46yhQSJlDijRZl+cT9EeVHucBuIibkbMn6FGMPrlhuVREug1yUcc7iFZ9OPIs2cEO5+/F56V8N4W4V4vvzJYOdC/qkfv11TAYjp1ABGyO0a7Sgs4MgM/krUQGK1tsVkuAHHQgfqx9th3dxZQAFz4gzGZp6/Ij2OUhgYSVPUFLQXEIspEIZWSNg/d5nzal3y15tKwyHudKUEmI+K8JjJaYD730nkHnmxBH0rviLvDgTbvVSYAPb5M2N

On Fri, 11 Jul 2025 20:24:37 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Fri, Jul 11, 2025 at 01:32:40PM -0400, Steven Rostedt wrote:
> > > So get the lttng code merged into the tree please, it seems that you are
> > > the one objecting to the merge, not me :)  
> > 
> > It was actually others, and it was years ago. Perhaps we could just
> > accept the LTTng kernel module as is, as a module, and leave it at that?  
> 
> That's up to the maintainers of the subsystem where it would be, not me.

It would likely be its own subsystem (under kernel/lttng?), so I guess
it would be Linus's decision.

-- Steve

