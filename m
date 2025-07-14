Return-Path: <linux-kernel+bounces-730100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0BEB0401A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A63D7AA124
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C16F24EA85;
	Mon, 14 Jul 2025 13:35:42 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B7C1FBE8A
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 13:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752500142; cv=none; b=Ec3Z/nKaDAg6hmc3LEJrOBQHMoBUUnoVaydlciZstU1S0izKibL5hssV92H4JbM2OQuv1quyOBAl17cxIRj5uaZfA6t5Ir+YSQrQ45PlcAI5Sok/qzacuMy4I/sU+u8gOeFLT9oxNZ1Zr3ou/fhamhmdwOPfKNbK40acjXOzRKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752500142; c=relaxed/simple;
	bh=v5QT3NxwwHROlBCgiiem/s5w0QQak9inubGX1Bl17Ok=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d1zuRzPklAXcVWmdzogODxjV6I3FMTXars8gNFGc7eVnVukTwY39pWsoCqccSTAQuSiC7Ox3EqZzEpLHOacs4IRDag1rxZHEp6uGyYejgdrGdpwXWdRON9wrapbr1GZUkE8z0caEQ4p2Yn63xzfEpLaMVgtXd73sbBzfUrkIlg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id D19DF10C743;
	Mon, 14 Jul 2025 13:35:36 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id 306E320025;
	Mon, 14 Jul 2025 13:35:33 +0000 (UTC)
Date: Mon, 14 Jul 2025 09:35:47 -0400
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
Message-ID: <20250714093547.62159c19@gandalf.local.home>
In-Reply-To: <2025071419-negligent-balcony-84c5@gregkh>
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
	<2025071419-negligent-balcony-84c5@gregkh>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: jf8ig6owygbdjrx7geztyqbqrtmfinqm
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 306E320025
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18yoB4Cvfb5Z8eMiQMRUBQHSjRT2gpCTUA=
X-HE-Tag: 1752500133-851657
X-HE-Meta: U2FsdGVkX1+ooYyMQxuWhze99OzmddTXUAQH99g3d3DwQqRFp7qEAvcddFcWkx/FEFvCXpe+LFbehcNYglmmAH0MhLjXO4qDNbiOnZFKlZU5GMc5gIyDVhaUoAcyAhyLqNoHRtFUrpCx0l5IXKBERhL6YrR7i5vofG/ijjWOucv4TnJ8KyImB06KkbRPvZW9lGb8Y0SgylnZWyfQXoQvL+RDA/2ExI9UI/wbUiYCV3WPO5wXdC1y7sRos+C5vWUVwT8kc5zhSgqz1G2KQF2hCaTXJunK0rbRzcPUaYp2OhTbYKZb9D57+lcpTEFkmc4A4j8lmxP7D4Hg+UxsY2RkpZ+Pi4ZIZtSvuD33AwFMYhE95Xco2nxtEbReLBhzOBE48hArGVgZ2h5wB+hvwGci3g==

On Mon, 14 Jul 2025 15:26:47 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> As it seems that we do have other tracing/perf developers already, start
> with them and go forward to see what they say.

We tried that. I don't have the time and I'm sure the perf folks don't
care. I advocate for LTTng because of the support that Mathieu has given
us.

The only other option is to allow LTTng to have access to a couple of
functions that Mathieu helped develop. Otherwise it's forcing me to say
"Thank you Mathieu for all your work, now go F*** off!".

Which appears to be the only option :-(

-- Steve

