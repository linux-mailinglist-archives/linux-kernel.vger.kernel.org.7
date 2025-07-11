Return-Path: <linux-kernel+bounces-727716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53EB3B01E8C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 16:02:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C50F458229F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 14:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B80EC2E03EB;
	Fri, 11 Jul 2025 14:02:42 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90DA2DFF28
	for <linux-kernel@vger.kernel.org>; Fri, 11 Jul 2025 14:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752242562; cv=none; b=nU8lVNggT4AeOJTvEOXsueDFi+ctjqgrSUQoacKnN39MN2f11aSF6oTYLtmacd5PoS11FlYcBwW3fLBBRRHlLQIGPQ56FLMgccthFelAli3yB5962uPjN5BdQP32kCvCRPeiZhiTK7r10jbGTFya/zH58M7agdlEoIkzuwdck4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752242562; c=relaxed/simple;
	bh=ww5ul5av5YlGsietWAju+zqeRKQTdBLir1IQJqrOpNY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LqznIV/5OOc5CjDhDgaW1zvHErByMCJEzAwZ5/LC1SDZdd6kHr2cTHR9beSqK0GepCvs34XKM6P75L7H2p5xUS3NA13+Zxnzf6VV6zHy0I31AFNWE6gYEmAc5HPUr8+BXqVRIHKaKOqwOOeNJRHbwYl4nze45Xn0HVpMMTZ6OyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id E7756BF029;
	Fri, 11 Jul 2025 14:02:35 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 018A12000E;
	Fri, 11 Jul 2025 14:02:31 +0000 (UTC)
Date: Fri, 11 Jul 2025 10:02:39 -0400
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
Message-ID: <20250711100239.55434108@gandalf.local.home>
In-Reply-To: <2025071124-cola-slouching-9dd2@gregkh>
References: <20250709212556.32777-1-mathieu.desnoyers@efficios.com>
	<20250709212556.32777-3-mathieu.desnoyers@efficios.com>
	<aHC-_HWR2L5kTYU5@infradead.org>
	<20250711065742.00d6668b@gandalf.local.home>
	<2025071124-cola-slouching-9dd2@gregkh>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: kk9rk6ptfpc7b3z9yxb773amknhcbn3p
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 018A12000E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18gQsBbfQZUT2DYdzzVmvufjHNhNWU68kg=
X-HE-Tag: 1752242551-805074
X-HE-Meta: U2FsdGVkX1/8UEaLsptMMC26ROGydsfpnRclQTQ4WJrdGWwfIbsKE4jgn9Nl/1/2ZpU0WZ6jNvOBqCM4Ky7WWTgEx8Md64oXz1mCxukonDIM6GBGAUsrDkSwl2eiC3bxjH9Z428WFvQ73nTW8bem2yIh+sOD6b3lkWcMXK8KTMPrGjCBX8bTTeXTWUBM8Ng93YGBhRW0Ye9SRFWzNLKZapIglQ7LDZC5ZSwTxwkzW1ITQzpG21kqlVh3/NiZNfV5jSYP2eS4HDP8XdVJTYdoLX/ZTpIUVKNSGhuUvgUc3XqBMlIcNZuREbGtNJbaq9DyBrXN7W69Sy9Afb7Bxy8oAJBRdyzNu/+9PSa4DSNcr9k5kyU/9pDy6F0qx/yUpRsw

On Fri, 11 Jul 2025 13:38:07 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> Yes, lttng is a "good citizen" of the kernel community, and yes, it's
> not merged into the tree, but that's not our issue, and living outside
> of the tree has it's penalities, both economic and technical.  This is
> one of those penalities, sorry.

BTW, when it comes to tracers, being out of tree is actually a huge
advantage. Tracers, unlike drivers, are only monitoring the kernel. Which
means it doesn't really rely on the workings of the kernel, so it really
doesn't get much help from changes made by other kernel developers. Like
the BPF folks have said keeping BPF programs up to date, isn't that much of
a burden.

The huge advantage that LTTng has over perf and ftrace for being out of
tree is that it controls the ABI between the LTTng kernel side and the user
space side. LTTng can experiment with new interfaces, and if something
breaks, it can simply change it and deliver a new tool that includes the
new module with the update.

One thing that perf and ftrace struggle with is getting the API correct the
first time. That's because they have no control over what other tools may use
their interface. If I expose something that another tool starts to use
(like powertop) and then I change it to enhance tracing and it breaks that
tool, that change gets reverted. To make any new update, I have to guess at
what are all the ways a tool could abuse this interface and also make sure
it works well into the future when new things come up. There's a lot of
interfaces I would love to change but can't, simply because they are now
ABI.

LTTng doesn't have the burden of worrying about "what other tool may use
this kernel interface?", and can even change it much later if Mathieu finds
a better way to do it.

-- Steve

