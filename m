Return-Path: <linux-kernel+bounces-730728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 975CAB048B1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 22:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F327C171531
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 20:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E07239573;
	Mon, 14 Jul 2025 20:37:52 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2EB367
	for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 20:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752525471; cv=none; b=ZrOMJrZCGswocQyW9WeXAX5uxGL4YEHStQL2BGmVNs6ffHYhf7/aFpQhHDPwzSmGPYOLpG8ZWJXNIlojuLYS+iK4cSFFDIYiGDc5bpHJvVNsA7DivD7pL/ppDP6hatlqd14HeQD0lmSk5s5g+ji1qr20VrtgNVfd/IhlHN03+7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752525471; c=relaxed/simple;
	bh=PWiDxnGMbbrlX9MWJ+QpQAM1esHHISIQTj05WlBCLHs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X44DVy5Ll8NZ0DXGaQkeafL2Meeo2kZxlX7dWdTQ4q3ibIWCWrqRTCyPvRMuHubHfWkHLBiW81OAl+MbpavVjTAQANAIUc86GkCrqayw9juZ/d6v7cEnFRwdJOw7Aoyh0e+O9g1TUIZx8EMuLSvoa+ni/Zs03FIOzk209wlSWME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id DAE78140279;
	Mon, 14 Jul 2025 20:37:42 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id A62A933;
	Mon, 14 Jul 2025 20:37:40 +0000 (UTC)
Date: Mon, 14 Jul 2025 16:37:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Steven Rostedt
 <rostedt@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Christoph Hellwig <hch@infradead.org>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar
 <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel
 <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] LTTng upstreaming next steps
Message-ID: <20250714163755.1de132e9@gandalf.local.home>
In-Reply-To: <20250714162750.45b12314@gandalf.local.home>
References: <b554bfa3-d710-4671-945b-5d6ec49e52cd@efficios.com>
	<CAHk-=wiT9Cz+EbbuKozqiu7DnZQ7ftAWSmGf-xy_CdhJPCsNSg@mail.gmail.com>
	<20250714162750.45b12314@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A62A933
X-Stat-Signature: xk4z1gqoiscr8r66dmmnfixomtbu7j9e
X-Rspamd-Server: rspamout02
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/xNE8wkg/pr3dXwH1mkG4h+/M5dZNDt+k=
X-HE-Tag: 1752525460-972131
X-HE-Meta: U2FsdGVkX18PPt56LssvLYIU5+Hte+1W+3U6N3bEHCcQqCEeyWWcr6rgFOuKfUg+mfgWtDmvijQalhJ8XcC8scGbAtYTv3RaQtvK8LmxP/jopn4sqvHS9E1+vYtDKzCqop8Gc9GroY9vG3tZrHm0hoCZbhTGQ5fN6PVb+Xk5XAQKJBhAEFDF87LqDWQYGoEHKqa6PIk9/P67cqvzHlwQ7EcCl99ZHLKvq2ryxb+RdYfn+w++rT7ElQerj+a5TQcwaSSwL+xn7U2MjCKQ11mz663cqwZMAj6+sol80BpYxvLVF8ljdZTtQBhCOed8Sh6TS5OKSbwwB9nMPiruaxi4UxllAQapaO5XZlMgqF8P09XkCwUvl2sAGKPUQR4AWqeBGJKzwLer5EbwgJUw7JLQ8Q==

On Mon, 14 Jul 2025 16:27:50 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > And very clearly - based on history - that unification will never happen.  
> 
> Unfortunately, I think you're right. :-(

Actually, let me take that back. I think you are right as long as one is
out of tree. Because there's no incentive to merge them.

If LTTng were to be in tree, it would be much easier to work on a strategy
to merge the infrastructure as the maintainers of both would have better
access to each other's code.

The Linux kernel has had a long history of two or more ways of doing
something that eventually was merged into a single shared infrastructure.

But as long as one is out of tree, it will never happen. That's because it
is much harder to merge infrastructure together when they are separated
like that.

-- Steve

