Return-Path: <linux-kernel+bounces-730170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B96F7B040F3
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 16:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F654163DA0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DB824DD0B;
	Mon, 14 Jul 2025 14:06:29 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29E324DCEF
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 14:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752501989; cv=none; b=F5/C9uxDXBCjMdIGxr5jBWdZEG9yQSDpKfT1TYIkXXmEj5d9xLIv+njq5W8ifzDUyMhJsD3gFgUH0T7KhasjVdP7hekIbZsZZtw0hfJ/wXwHKLToOhhJvDyDPYFw6HQtbbCk/Fty4rlerWq5bKxBiPjP9V392gYY7CjnC9/pRjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752501989; c=relaxed/simple;
	bh=Xwr1vcyUrckVHV5kH7obupTr6TzvD31DOMhK/UPVmJo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HmwLFAeIvxgxpdou8cCTnYTrekVLrQUw1sg0vXt9SOXX5fHQX1IwE7QUnhAVpEVP1oaJ5uRnpzKwHf45xWdAIbmnO5w+YZbyedBr7y7Srvs7mXscX7ZNE6yJBewRvTb4ctCRIdIwRJHBMn2YFgJCPCJHad0wCB1K8LDNbc0vOo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 725DC1401A7;
	Mon, 14 Jul 2025 14:06:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 4E8B420;
	Mon, 14 Jul 2025 14:06:14 +0000 (UTC)
Date: Mon, 14 Jul 2025 10:05:53 -0400
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
Message-ID: <20250714100553.4e30a669@batman.local.home>
In-Reply-To: <2025071435-disorder-obliged-b74e@gregkh>
References: <aHC-_HWR2L5kTYU5@infradead.org>
	<20250711065742.00d6668b@gandalf.local.home>
	<aHSmIa3uffj5vW-m@infradead.org>
	<20250714062724.6febd9fb@gandalf.local.home>
	<aHTsOcIUs0ObXCo1@infradead.org>
	<20250714075426.36bdda0b@gandalf.local.home>
	<2025071443-lazily-blabber-3fbd@gregkh>
	<20250714082033.702160ad@gandalf.local.home>
	<2025071419-negligent-balcony-84c5@gregkh>
	<20250714093547.62159c19@gandalf.local.home>
	<2025071435-disorder-obliged-b74e@gregkh>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: uk14f84iiya4zs1gm7jy868hjjsqqpfj
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 4E8B420
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+PP/+9tdRnbTHtccOPaywoOJty52BLQkU=
X-HE-Tag: 1752501974-194159
X-HE-Meta: U2FsdGVkX1+/giixfV2RlkeRZA8zduW88pyYsFrCy6jtetZwp17Emm04BU9ruvrAQX8bKLnbaJHquYqRUF8vMkB3S7qJHgNvQbginLS4SvEiTspV2M48Sdasm92naa5I4uqPDI+mFcDMJ33yh2NZjGY52dNQNrgxXIUjNASXhADfJ4qXwz9sx/lV4BK5ZjGLUDOlmrB16a2iEdfi/bMAcoeqcN1UcPeo0QM1wLFR+Vi1nS/Q5+rxtr3QMMmBl8Vk9xyivBDvxgcUK6y7icTraYcdvUUt5G1tLc7FcmKTIkotbU65PXBgwxxjbvhZB/vv++FyL47WUexKOJFoTVClFGIVJWwrtUXDmvl0T6pmGG6N2Q3MjkwmDXKbKTO7b8qA

On Mon, 14 Jul 2025 15:56:14 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> lttng not getting merged because you don't have time to review it should
> not make the above rule somehow invalid.

Well, it's because LTTng is a separate entity that handles different
users than I worry about.

I'm having enough trouble keeping up with what is already in the
kernel. If we can find someone else to help out, I'm all for it.
Currently the tracing subsystem has two maintainers (Masami and
myself), and there's still not enough time to review the current code.
Mathieu is listed as a reviewer on the tracing subsystem. Could he
review his own code?

-- Steve

