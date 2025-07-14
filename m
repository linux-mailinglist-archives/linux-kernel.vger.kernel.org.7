Return-Path: <linux-kernel+bounces-729953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B29DB03E38
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 14:07:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 296763A641E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 12:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B012472A0;
	Mon, 14 Jul 2025 12:02:08 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B43246BB8
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 12:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752494528; cv=none; b=GLjBN83TE1s5IxGcFOcQis4IxiECokS3k1Bnn70tVkMxDhi0LROpUCt3ydLsOlhGtcb9+4Foi0L7nV3flONSlMKFAcOZZydfHA8kLdZcH1HDM1dPYB6nIM9irusJANL1Dj/AuzbMYn6ByT/Im39RfsEdN94Hk8GgtCEvNLLiDH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752494528; c=relaxed/simple;
	bh=5FkxaG9fyUix1iu9V1z6Ep7xRMrpFAK6dwevtMyY0VA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OV9G/ey4FR+97xsKpyr6T3+K3K13nRyqR4GdybPKTVkYrIAxoG+qUWIIaKE3YMINkfmSdZ7glrVZSIO6fO7FhzxVzDMmd8zdLNCQlFAm+Ti1OGOKNfqX0NzldMEIMtvgHJzNBBMGBpwHM16hmXUje2H1ZMbFUg7TsN09EJ8q118=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id DB3BB8014E;
	Mon, 14 Jul 2025 12:01:57 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id 53E6920027;
	Mon, 14 Jul 2025 12:01:54 +0000 (UTC)
Date: Mon, 14 Jul 2025 08:02:08 -0400
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
Message-ID: <20250714080208.44c16d3d@gandalf.local.home>
In-Reply-To: <20250714075426.36bdda0b@gandalf.local.home>
References: <20250709212556.32777-1-mathieu.desnoyers@efficios.com>
	<20250709212556.32777-3-mathieu.desnoyers@efficios.com>
	<aHC-_HWR2L5kTYU5@infradead.org>
	<20250711065742.00d6668b@gandalf.local.home>
	<aHSmIa3uffj5vW-m@infradead.org>
	<20250714062724.6febd9fb@gandalf.local.home>
	<aHTsOcIUs0ObXCo1@infradead.org>
	<20250714075426.36bdda0b@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: yodin7qi4he66ntc6mwq7migh7bfwdk5
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 53E6920027
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18VHjKVNadqh6meC2+HBWoZ6rqxIHhzHY0=
X-HE-Tag: 1752494514-350587
X-HE-Meta: U2FsdGVkX1+Rw5qasvUBVFFs2LKJQRHAieQgb6b6B01EkiUdVrJYkR92ouDNnK0xueq6RXCpHN3mX1wY0bR4Ec+Wk58cwrREtK2akICLHk2pgMyxZJHBwMdp+VFwFoVjWJYJnvB1h5/5tzSejxwFOUCjiH23GDbCOQ1DohuZo721kWXmtDSRInFfNbvWnil5BEQreeBaOXamkptLGhyu3szwBboK3yKDBfgnOWNMav9gpqF+TeqFsPRmpMqxXnq90DfDShlGdKZfNUmRtCbm3QkN7598gW73+CvdCaWxCcU2eWe6NrBRrdObGJzaSaZH5ZdNCFjZaFHYXKNYDYVkHiX7EII8XYe96DGvgcNCWnBG5rq33eR/01FqTy+moPr1

On Mon, 14 Jul 2025 07:54:26 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> And yes, I still consider it draconian.

It's not that Mathieu doesn't want to work with upstream. It's more like
upstream doesn't want to work with Mathieu.

And I'll admit that I haven't helped in this regard. In the past I've
considered LTTng as more of an annoyance. But over the years of working
with Mathieu, we have found that ftrace and LTTng have two different
audiences with a little overlap. And because Mathieu has helped out where
he could, I started helping him where I could. That's called, collaboration.

-- Steve

