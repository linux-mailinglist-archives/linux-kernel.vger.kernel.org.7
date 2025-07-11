Return-Path: <linux-kernel+bounces-727437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2213AB01A34
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 12:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67446188E89C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 10:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDC7288C10;
	Fri, 11 Jul 2025 10:57:44 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85815146585
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 10:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752231463; cv=none; b=fSpeRkpi7fAJGG7Eu9nR4+VFOA/akkxO4rUzAG9gMPjosyecB164ULIBBKkLtLb0PIWFsajBBMao5xxoRtOuLWeulDwxIeJLdj4WkmW7fRsrt0xPoSoEbHpSXQgKc+PUD9O/znOrk//FVAiM+6nRqMKCNNo2BsaWXiLWLKbRPAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752231463; c=relaxed/simple;
	bh=n2v+V7Dt5M2kG11EP0+UJi01N1/LUvq1qS6h71wI9/M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HNkRttZFZ7o/EQQmaVS7srWge64OSkmFvtFmOI9qdQzfpV5R01By6CcYoKhk9SBXICxTw7SMC630Pv7eBVOXsCDorouyMbocLZO2V067GMU1jxj5iS1nntvUxfugP605OsPmrsMNg1pm9yjhU/mlETCpQYN424fZhmm0g9BtU78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 0BA9610E1EB;
	Fri, 11 Jul 2025 10:57:39 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 5740880014;
	Fri, 11 Jul 2025 10:57:35 +0000 (UTC)
Date: Fri, 11 Jul 2025 06:57:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Namhyung Kim
 <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Andrii
 Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, "Jose
 E. Marchesi" <jemarch@gnu.org>, Beau Belgrave <beaub@linux.microsoft.com>,
 Jens Remus <jremus@linux.ibm.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>,
 tech-board-discuss@lists.linuxfoundation.org
Subject: Re: [RFC PATCH 2/5] unwind: Export unwind_user symbol to GPL
 modules
Message-ID: <20250711065742.00d6668b@gandalf.local.home>
In-Reply-To: <aHC-_HWR2L5kTYU5@infradead.org>
References: <20250709212556.32777-1-mathieu.desnoyers@efficios.com>
	<20250709212556.32777-3-mathieu.desnoyers@efficios.com>
	<aHC-_HWR2L5kTYU5@infradead.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 9xeuxq7er38yowmu6nukaz3jz8o4s8rp
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: 5740880014
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18pS6T2o/rogsMPwNJqEbkqQQgCokmTmn8=
X-HE-Tag: 1752231455-45601
X-HE-Meta: U2FsdGVkX1+O0EXwju0hS6rR7KizxI864GA0/mDCEcd8H7demm1Caf3R/wYOP8but1VUfszLgsIMa9VrTTkiyfPA01t8GsLnl4UI74afdVn2hGjQln7QyrpQyupopvFTKtV7xxOdpmZRAdts6BPF6V0W4p/LKC1aHdkxPiBc9BxKkvWTwlulNAaR5e/HHX/PL2OwygnKHFHNTyBFdt5QnlU6zq0VQDRvN4utaTSWIT33fd3a8w8Cr97xK+7XirneATcciSHhXKNowi+LLoAHTIaCb1yOlqUETccpkBwoojBMCYF5dqXKvBv8KZG+4Z+Hd006R7Qx9gMdoL5Bx3i45Vqo3IQdEL0tJ8WB79AhE7d2k88pPuH0paZUtIeXDuHDLG37olZ8Q0gh/I3RtI+wwma1DUPfkQSE


[ Adding the TAB to this as well ]

On Fri, 11 Jul 2025 00:36:28 -0700
Christoph Hellwig <hch@infradead.org> wrote:

> On Wed, Jul 09, 2025 at 05:25:49PM -0400, Mathieu Desnoyers wrote:
> > Allow the unwind_user symbol to be used by GPL modules, for instance
> > LTTng.  
> 
> I don't see a LTTng submission or any other user in this series.
> So the usual prohibition against adding unused exports applies here
> as usual.

I want to bring up this discussion. I understand there's a policy not to
add EXPORT_SYMBOL_GPL() unless there's a current user of it in the kernel
proper. My question is, does this policy have to be draconian?

The LTTng project and specifically its maintainer Mathieu has a long
history of working along side of the Linux kernel and actively adding
enhancements to the code. This is not an Nvidia or VMware situation where
the modules add special secret sauce that they do not want to share. This
is a long standing kernel contributor and maintainer that has proved
himself time and time again to be an asset to the Linux kernel community.

It's not even that LTTng wants to be out of tree. There's been several
attempts to get LTTng merged. But they all failed due to disagreements in
approaches and other aspects of the design. With perf and ftrace already in
the kernel which focus toward helping kernel developers debug their issue,
several maintainers do not see the point of LTTng. But LTTng focuses more
on non kernel developers. Mathieu and I have come to a conclusion that
LTTng and ftrace have two different audiences. And we actively work with
each other to improve both ftrace and LTTng.

LTTng was redesigned to work as a very non-intrusive external kernel module
that could be ported to newer kernels without much pain. This approach has
worked for both Mathieu and the kernel maintainers for several years.

It is not because Mathieu doesn't want LTTng in the kernel that is keeping
it out of the tree. He would very much like it in-tree! LTTng is not in the
kernel because the kernel maintainers themselves have been blocking it. I
do not feel that we should be also add the extra burden to prevent any call
it could use from being EXPORT_SYMBOL_GPL().

Mathieu has been very helpful in the work to develop this deferred unwind
code that will help ftrace, perf and BPF. I would also like it to help
LTTng. The only way to do so is to have an EXPORT_SYMBOL_GPL() for it.

Now you can argue that we need to get LTTng into mainline before it can use
this new work that the maintainer of LTTng has been very involved in to
develop. But that would probably take a long time and from past
experiences, may fail completely. So for now, I am saying that we give
LTTng an exception to the rule that functions can not be
EXPORT_SYMBOL_GPL() unless there's a in-tree kernel module that requires it.

-- Steve

