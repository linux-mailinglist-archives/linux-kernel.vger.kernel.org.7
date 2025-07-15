Return-Path: <linux-kernel+bounces-731565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B30CB05649
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 11:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AC6F562593
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 09:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B636D2D5C62;
	Tue, 15 Jul 2025 09:26:33 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515EB22D78A
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 09:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752571593; cv=none; b=ClG3OttRJedzsl2glvmTUJDPEhdFTKsvRpsQSbJYYFtEm3MSG3OICG0HZTjGYK1OgfKE1uF/wMor8+/v6ffSXhc1FqHCKI89LYT7jqsbgKHG2/n+zvexvBSjgi7BdyIlrpY4bCgRWJ1uoEM7Im54Ct9T6Cv+UVsDiOIsgX9SfGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752571593; c=relaxed/simple;
	bh=slpGwSdYfjT4mQWLMWsK+wKd8ciwm+usWuZFAMlQu0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tcAkIdOS285QnAeXXxuDDQRgeV8xQEbzNypX0ePkgVPRLBqYHyDVlvoK+ETkS0O36By2Y4cLTsNDR+2DLT/b8HWjuDWJnsSvroHmBfM9U2/gjMEmoWH3wUB8Deqo8SGNyDnZ+hZNsXDgUM9hUuqiL0a6Mv2zzZ4u1h6JGPgm7UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id EBC5B1D9F7E;
	Tue, 15 Jul 2025 09:26:28 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 532B430;
	Tue, 15 Jul 2025 09:26:25 +0000 (UTC)
Date: Tue, 15 Jul 2025 05:26:41 -0400
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
Message-ID: <20250715052641.1ceb958c@gandalf.local.home>
In-Reply-To: <aHYA9IPs5QiX-QLs@infradead.org>
References: <20250709212556.32777-1-mathieu.desnoyers@efficios.com>
	<20250709212556.32777-3-mathieu.desnoyers@efficios.com>
	<aHC-_HWR2L5kTYU5@infradead.org>
	<20250711065742.00d6668b@gandalf.local.home>
	<aHSmIa3uffj5vW-m@infradead.org>
	<20250714062724.6febd9fb@gandalf.local.home>
	<aHTsOcIUs0ObXCo1@infradead.org>
	<20250714075426.36bdda0b@gandalf.local.home>
	<aHYA9IPs5QiX-QLs@infradead.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 36tdjip6t34a9pg4wwtwp8pixmhgmn61
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 532B430
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1//T8zPQLXZBwI/an/qjdBgfQ9JkxnPbrA=
X-HE-Tag: 1752571585-357310
X-HE-Meta: U2FsdGVkX1+abi9f0XP4/m50ESB6j0w37LP6NDYmqgWObwRz5210WIa1ZuDswwTddpSXqaa25NIWNeTSIQQPDnsmt5rQTN+Qud4GVFJ6jqTF/HshasrH84pItG5atOgHo6vb5caRqaKP3M7HSczBxXY6dOO3lpjrWx4AQgHrs7tZSlibLN0GDlXuoNK/CalNM3SEuvxNUItoEkPQrYgM1pARMDcmh7NARe7hU1vMt0njTlfa0JBy/lTzMFaCbNgXdxIcoJliW7ni4kyA44/Yl5MZcJN8wXDS3FxAEA9FKwJG1Y4opsGrTlI6LZNUay7Q5qFt/6RQRKHKVMGCZ7SfC3WeLodkFmvWM2QcnV8SKG9Dbvs4Ikvf08+a+yiCiHdnLjbP69ySgJUUxZu4TnwlTQ==

On Tue, 15 Jul 2025 00:19:16 -0700
Christoph Hellwig <hch@infradead.org> wrote:

> I honestly don't care.  Not my business.  And you're probably also
> asking the wrong question, as those giant old out of tree projects
> tend to be a mess because of that.  The right question is really what
> functionality does LTTng have that we want in the kernel and work on
> that.

See my reply to Linus in the other thread you were Cc'd on.

https://lore.kernel.org/all/20250715052459.0000e119@gandalf.local.home/

-- Steve

