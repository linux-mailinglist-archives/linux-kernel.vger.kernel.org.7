Return-Path: <linux-kernel+bounces-754184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CC2B18F68
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 18:32:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3B77189C36A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Aug 2025 16:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64AC23B630;
	Sat,  2 Aug 2025 16:32:02 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCBC19EEC2
	for <linux-kernel@vger.kernel.org>; Sat,  2 Aug 2025 16:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754152322; cv=none; b=b4EG3xrFco6nSp02BQtp7xKtyotdvxrZ8yk0X8F9REEsWHAFr7/6JJaABLdTP1B4zN7ndAVgsdZeM4IaWKpk4mhRccZ7t6rIY+DcHYIEbNW8ifiY5kWNYOhc00L7jK1kX0HeSG61fZlf4vn/ZhHNWDZSVSmtUcirUKV8H/xtFzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754152322; c=relaxed/simple;
	bh=8Bi8QsvqFrHGmJXJkgQ3aonW0L2f110/7/Hn8TYXtk0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OJQPLGNEL2iQufncsFRqDefYp4knyTuHOdnvZ0+bu9AybHjfZIMDLb7HP3r73vn2Kdb66TtQ16cVOQW1bc7zqFcPTvBE7KgJvPmOY/QfJoO3Gf+n3QdIKBZE8ixtgViKj/2Nua/i1+sKJbibO2eO+E52b9/hnYEXitgVN4ZnL/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id B43F91404E1;
	Sat,  2 Aug 2025 16:31:52 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id D7A432F;
	Sat,  2 Aug 2025 16:31:50 +0000 (UTC)
Date: Sat, 2 Aug 2025 12:32:13 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Steven Rostedt <rostedt@kernel.org>
Cc: linux-kernel@vger.kernel.org, Tomas Glozar <tglozar@redhat.com>, John
 Kacur <jkacur@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [for-next][PATCH 0/6] tracing: Final clean ups for v6.17
Message-ID: <20250802123213.692c76f2@gandalf.local.home>
In-Reply-To: <20250802162734.529626660@kernel.org>
References: <20250802162734.529626660@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D7A432F
X-Stat-Signature: 5xoaybcor9c1a9xcniejz91tj4erfryp
X-Rspamd-Server: rspamout02
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+BIS6KNsWYfQfsYA5xJRZC51TCPAaIE+E=
X-HE-Tag: 1754152310-152285
X-HE-Meta: U2FsdGVkX18S8nXKpVMjNZ1O6mBkX31PN1UtVbylJ3lPyNb+KA9LWBnb4MK0ZUNVw3HO77badITAcPsXwYdshxAn8ohMbzC5MU+yGfOYqfGiAsIHgbuT8m99uhsWX0TzCSXQlWZAJDO5sful5EBnZpGebo/SEi+mBG2Ie81SXsQYb523u+VHimD8I2pEAut2GWVRRcMvs1HXzi7rVPY4q09qtvgxTc9tyKnlbFEzoxpHpWATn0a+EE5gSk9Sgf0a7n5hP1IIxFqAY6W8WFylEuI2ezz/0k0GXVHjF5G62W9Mtlj92wDQoKr03autTIvISuAbLz9DZ6XLmp00CX5t29CP0Dn/TYze

[ Adding Masami and Mathieu ]

Oops, I accidentally used the RTLA script to send these.

Sorry Tomas and John ;-)

-- Steve


On Sat, 02 Aug 2025 12:27:34 -0400
Steven Rostedt <rostedt@kernel.org> wrote:

> Last minute changes for v6.17
> 
> - Remove unneeded goto out statements
> 
>   Over time, the logic was restructured but left a "goto out" where the
>   out label simply did a "return ret;". Instead of jumping to this out
>   label, simply return immediately and remove the out label.
> 
> - Clean up the tracing code with guard() and __free() logic
> 
>   There were several locations that were prime candidates for using guard()
>   and __free() helpers. Switch them over to use them.
> 
> - Fix output of function argument traces for unsigned int values
> 
>   The function tracer with "func-args" option set will record up to 6 argument
>   registers and then use BTF to format them for human consumption when the
>   trace file is read. There's several arguments that are "unsigned long" and
>   even "unsigned int" that are either and address or a mask. It is easier to
>   understand if they were printed using hexadecimal instead of decimal.
>   The old method just printed all non-pointer values as signed integers,
>   which made it even worse for unsigned integers.
> 
>   For instance, instead of:
> 
>     __local_bh_disable_ip(ip=-2127311112, cnt=256) <-handle_softirqs
> 
>   Show:
> 
>    __local_bh_disable_ip(ip=0xffffffff8133cef8, cnt=0x100) <-handle_softirqs
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
> trace/for-next
> 
> Head SHA1: 3ca824369b71d4b441e1fdcdee8e66bcb05510a9
> 
> 
> Steven Rostedt (6):
>       tracing: Remove unneeded goto out logic
>       tracing: Add guard(ring_buffer_nest)
>       tracing: Add guard() around locks and mutexes in trace.c
>       tracing: Use __free(kfree) in trace.c to remove gotos
>       ring-buffer: Convert ring_buffer_write() to use guard(preempt_notrace)
>       tracing: Have unsigned int function args displayed as hexadecimal
> 
> ----
>  include/linux/ring_buffer.h       |   3 +
>  kernel/trace/ring_buffer.c        |  16 +--
>  kernel/trace/trace.c              | 287 ++++++++++++++------------------------
>  kernel/trace/trace_events_synth.c |   6 +-
>  kernel/trace/trace_output.c       |   8 +-
>  5 files changed, 120 insertions(+), 200 deletions(-)


