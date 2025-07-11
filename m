Return-Path: <linux-kernel+bounces-728081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD67B02381
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 20:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EF801CC27FA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 18:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43102F2729;
	Fri, 11 Jul 2025 18:21:42 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E03028DF27
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 18:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752258102; cv=none; b=NDUNXAnzqJCPV+bX9nwP9JK5ZGASz/sKVSgypEpTl5SFBU7fGfrXgSclvf/T3h5S0LAcx892DkZC6kNX4ufEX5owZv3qLa63q9U6Jr2RLH9/1IAbe6jLl9c9H6npGAZpFCkYzQGCt+PiFNFpgLJIYb/9TXf4BRQ99eAyCdHT4E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752258102; c=relaxed/simple;
	bh=t9SoAgDI5u54iJABSuhm2MVmg5yAc0se6PKcN3/4Juw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eKkTTSezunoz829RQuUClK+WJh9cFgHmJix2cHbgRpodbsRHVCkHtJS5IWecsJ2QJvNKetfbFnE9FuMpfzU38GCVfNLGiKxk1ppOvJm8rVtmKCZN9mUoHXPsMk5rDNcKC0g999vqV8891imuTlXl71SpR7xMnUFzD2lN0LpB+WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id A4ED71402F2;
	Fri, 11 Jul 2025 18:21:36 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 82D612000D;
	Fri, 11 Jul 2025 18:21:31 +0000 (UTC)
Date: Fri, 11 Jul 2025 14:21:30 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: <dan.j.williams@intel.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, Christoph Hellwig
 <hch@infradead.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 <linux-kernel@vger.kernel.org>, "Josh Poimboeuf" <jpoimboe@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, "Jiri Olsa"
 <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat
 <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, Beau
 Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>,
 "Linus Torvalds" <torvalds@linux-foundation.org>, Andrew Morton
 <akpm@linux-foundation.org>, <tech-board-discuss@lists.linuxfoundation.org>
Subject: Re: [RFC PATCH 2/5] unwind: Export unwind_user symbol to GPL
 modules
Message-ID: <20250711142130.041b951e@batman.local.home>
In-Reply-To: <6871537ec0461_1d3d100c6@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250709212556.32777-1-mathieu.desnoyers@efficios.com>
	<20250709212556.32777-3-mathieu.desnoyers@efficios.com>
	<aHC-_HWR2L5kTYU5@infradead.org>
	<20250711065742.00d6668b@gandalf.local.home>
	<2025071124-cola-slouching-9dd2@gregkh>
	<20250711100239.55434108@gandalf.local.home>
	<6871537ec0461_1d3d100c6@dwillia2-xfh.jf.intel.com.notmuch>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 9qz86moh9af15n34yomyo9saa79fqzwj
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 82D612000D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18KPS5KLZyFfzxSHukJ/10MKcDEj7GxyhA=
X-HE-Tag: 1752258091-787051
X-HE-Meta: U2FsdGVkX1/8kQ9FHe4BZcTQUtkHqVVcKUGaM45btgSZsD2QJi5i1ZyYD6Kui9eKXxK+F32fQ3OIi2RU34qiNlBtFRkAxabMdTAEZ1+wzJs0mB36tkUHe1wDDKW8RgNgfgChc9TGx5MpNl0CbjM84jXB3O5/pPSEqMzWvsm0/AKDXmmIjZC+dmVFILEstDaFbADD2P+YiSsISGruk7qx7AwntGd/EXqufbgtwyRjHJAu6J4aUVeDY2BBdZrxuCdsNiA3XeeBZWD4Pic5V4qtSYlr3ClX0ExMnDnz2cGRn/UIF0rx5rkU8F16k5KV0Mq9ri+j5mBjfZlpi/ldW7doquXATfsOlkSn

On Fri, 11 Jul 2025 11:10:06 -0700
<dan.j.williams@intel.com> wrote:

> > The huge advantage that LTTng has over perf and ftrace for being out of
> > tree is that it controls the ABI between the LTTng kernel side and the user
> > space side. LTTng can experiment with new interfaces, and if something
> > breaks, it can simply change it and deliver a new tool that includes the
> > new module with the update.  
> 
> It is odd to read this claimed benefit when viewing it from the wider
> Linux kernel project. Upstream maintenance of ABI contracts is the
> fundamental struggle of subsystems. The request, "can we get the kernel
> out of the way and maintain our own ABI to our users?" is a consistent
> refrain, and it consistently receives a qualified "no" for regression,
> security, and other interface evolution concerns.

Well I think the history matters a bit here. Mathieu tried to get LTTng
upstream several times. There was never a "Can I keep it out of tree so
I have this flexibility". Only after he gave up trying to get it
upstream, did this advantage play a role. There's been a few times
LTTng was able to take advantage of this "feature".

Note, as Mathieu has stated, LTTng now has a "stable ABI" similar to
what Linux has to make it easier for distributions to maintain LTTng.
But he also said that he can deprecate older interfaces much easier
than he would if it was upstream in Linux.

My comment wasn't to advocate such a approach, it was to counter Greg's
comment of "and living outside of the tree has it's penalities, both
economic and technical.

The main penalty that LTTng has being out of tree is the lack of access
to these functions. But it's been doing very well outside of that.

-- Steve

