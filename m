Return-Path: <linux-kernel+bounces-724541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 082B2AFF40F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 23:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F34A5641719
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 21:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E01246788;
	Wed,  9 Jul 2025 21:41:44 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB1A241664
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 21:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752097304; cv=none; b=crg5wS8f1/apSGSIQlbLNV+QOMQphXY2naSBV+hEJQxf7BkHiwRfWkbOSzIkUiFLepo8pa5OgGlH3gZEAq9iElSqojeQiqucwocN80+bBZ8C8xC4m96YOHt4Fat1W0rLggMlxK9FYv04HSudEMFrKRpVNR7kO9NQL51EmhtjOyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752097304; c=relaxed/simple;
	bh=DyfeM4+9WBce4dHsATfyf373BQwUaqE7Qi1tOvZDR74=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nb4NeQ4ptP1bVWJS/mpAgesRcIXQeefuCHHZB2Y4pJF3ChTU0L5TQqHtO2c7UOxpJEoUfTpB7Ab6bybsrydt26DfZ713XClBcDj0BItDuqV2CF0SDyb9OccJ0bELicb1U0E0i7dXD8SoFXwB9CuUcyTjeCPlGhUzW89WFea9PEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id B92C4129482;
	Wed,  9 Jul 2025 21:41:39 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 5B06820032;
	Wed,  9 Jul 2025 21:41:36 +0000 (UTC)
Date: Wed, 9 Jul 2025 17:41:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org, Josh Poimboeuf <jpoimboe@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat
 <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, Beau
 Belgrave <beaub@linux.microsoft.com>, Jens Remus <jremus@linux.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [RFC PATCH 4/5] unwind: Rename unwind_stacktrace to
 unwind_user_stacktrace
Message-ID: <20250709174139.4aa32d2c@gandalf.local.home>
In-Reply-To: <20250709212556.32777-5-mathieu.desnoyers@efficios.com>
References: <20250709212556.32777-1-mathieu.desnoyers@efficios.com>
	<20250709212556.32777-5-mathieu.desnoyers@efficios.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5B06820032
X-Stat-Signature: dsopzakcsyzymndzxery9j3k9zgff3sn
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/9zj77ct+tFbkRWrruJBAgo1cwcsspHFg=
X-HE-Tag: 1752097296-871417
X-HE-Meta: U2FsdGVkX18jtq5YbciVtz5qhDvP6yZzd0Z/ATOIZhbdQnFMuvbdqjzWKBC/wlZgPR4g+sdZ8pv9xN13vjKGS15ngx3uutUuiwyqoCVP+MJuVZK7TUblrDzDXYq7h4v4MYiZ4hEycqoQ7WC0a2zKNrPK+K/UH2rMTN/kxbd5z/Sb2KEZDSrUlnegiFNA3Y/np4O4FY4hIf7FctpUCj+ARWkYgAPIcY9WBqXFgjn7Faxfzr4uldyPcfxmyfTfoC4V4Zv63Dc7EL0hVFldFrvuiA5EMggyRfC6Ee3pCQzawmIaZCnaGd9YKPFIhfEzs0gT1ACNMgbB2ZaTcOfefcT2L8UihZ1euKxvjfgW8Bvun0Jzf4OHYLA3PJmlSVk3GIcZ

On Wed,  9 Jul 2025 17:25:51 -0400
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> Rename the unwind_stacktrace structure to unwind_user_stacktrace to make
> it consistent with the rest of the API.

We originally had that name, but decided it was too long. As only the
deferred unwind uses "unwind_" and it is currently only for user space, do
we really need to have a 22 character structure name? 17 is already big
enough.

And say we make an unwind_kernel_stacktrace()? I doubt we ever would, but
if we did, it would still use the same structure. There's nothing
inherently user space here (with maybe the exception of the compat type,
but still).

And how is this unique to user space? The kernel can have sframes too.

Actually, I think we should rename "enum unwind_user_type" to
"enum unwind_type".

struct unwind_entry {
	enum unwind_type	type;
	unsigned long		ip;
};

As it is only being used for user space now, but it doesn't mean it can't
be used for the kernel.

Heck, there's already work to use sframes in kernel code to replace ORC so
that architectures like ARM64 can have live kernel patching.

-- Steve

