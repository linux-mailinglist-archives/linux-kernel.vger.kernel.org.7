Return-Path: <linux-kernel+bounces-729981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2839B03E8F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3034C17DF23
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 12:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8BB2472AE;
	Mon, 14 Jul 2025 12:26:01 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FA0247290
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 12:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752495961; cv=none; b=Dv8SENLhI4Mhv24xGH2W7Lxrr0NhYFTUcvHHW+9/CzjnuvzJ8JYEWaXrx/28D5EhZkmNpEm5HT3u9ElJXbbLVisuXankO3CTWfCUUghrxK3jvgU4DSZBowGege7FxBZXL5vxTLqhQR9mG/Twoc7R4Cl1tYJoVrgSt6DUP1pDF9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752495961; c=relaxed/simple;
	bh=lU7UGE+aoSBLcyw8bD/4bp1qDRVbDORNOLT4iYw0yCo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XfPDLymrg0qa+xkkO+Qt0+6+QH/APB0kH5MPD+RIzlu3yCInqHjYMAZ3DUiX+pdKOkRAbamS7ikRAiuxlNRdpWCTRQolAALN6lK1MoPTj/YlAmaHzG7tQbbHMmnxOGLh4wwYGPfjP6GjGPI2EhK9hcT/XCggK+FIuOYxHjGNvic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 3C68312A0CB;
	Mon, 14 Jul 2025 12:25:56 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 674E360012;
	Mon, 14 Jul 2025 12:25:52 +0000 (UTC)
Date: Mon, 14 Jul 2025 08:26:06 -0400
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
Message-ID: <20250714082606.06e7d4a1@gandalf.local.home>
In-Reply-To: <20250714082033.702160ad@gandalf.local.home>
References: <20250709212556.32777-1-mathieu.desnoyers@efficios.com>
	<20250709212556.32777-3-mathieu.desnoyers@efficios.com>
	<aHC-_HWR2L5kTYU5@infradead.org>
	<20250711065742.00d6668b@gandalf.local.home>
	<aHSmIa3uffj5vW-m@infradead.org>
	<20250714062724.6febd9fb@gandalf.local.home>
	<aHTsOcIUs0ObXCo1@infradead.org>
	<20250714075426.36bdda0b@gandalf.local.home>
	<2025071443-lazily-blabber-3fbd@gregkh>
	<20250714082033.702160ad@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 4tbjo9n1z3zkfeatqzprzecbx85tmq5k
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 674E360012
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+sw5YLWW1HrCk9yRJJXITtYfV8nA23g/o=
X-HE-Tag: 1752495952-13260
X-HE-Meta: U2FsdGVkX18PVT7lSMbKh7DTBbs42shpPmbI6P0LxNFSHbVJu3VD8pp7q86o0jMJvX3RaytWmMY0IFgxmKJshAietyx71Maz9vJ8TaVY6R6zpDiOVpin87mdpmq26bcdyO41+90UnMRZ86GL3xiUesh6g8mG6mSs69q82FzcFWvgAWc0vm40CCBPYYr8icBrGZZHJ/4LWOzShRhptwxgZwiK3c951FZnYqxPEhzLO35R7NCT47XkjFlgL2OSjz3iWzM3MIx9iWZ0GcLVYoWAeTm8I90qg2MNO4AX75qBhssNWAvM46y6Ekj+9O03R/SITwwd/VSdklKBXigGEso+pO+DHLzvSJwHM5GHVGm3HO67cqiUdC/6BldqcT1VuOCE

On Mon, 14 Jul 2025 08:20:33 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Just like perf and ftrace. They are stand alone subsystems where other

I should clarify, I'm using "ftrace" to reference the "tracing" subsystem,
as "ftrace" technically is the function hook mechanism that is tightly
coupled with every architecture that uses it.

So here, when I say "ftrace" I mean kernel/trace/*, and I really should say
"the tracing subsystem"

-- Steve


