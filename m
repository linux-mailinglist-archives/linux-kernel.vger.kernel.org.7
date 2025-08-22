Return-Path: <linux-kernel+bounces-782716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1EEB32408
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 23:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84F58B0632D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 21:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679053218AE;
	Fri, 22 Aug 2025 21:16:37 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCDF283C9D
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 21:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755897397; cv=none; b=IvEnamtqRqO7iVgpzyn2LBxzVkEuLHfQs+BvR0EdK5WV6JkwZQQgq5M3C/MBKzy5brC/Tmc2gyhL1NxVi2B1KzsqQUdeWa96MHubHpl30G0wVimH5Lae88BZmR3GfXqZY0wl/x4F+IRBZNqTeQUQzO/wIsdnvr8joJc4xoSfnI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755897397; c=relaxed/simple;
	bh=S3WdWKxD+OrHvdwVR5qi1NaCJN9OU12JkKzxkr/eBQU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WmDbrphfWFqOevtztG/cD1McxcdQYQWpu64tSyhjSUo8THdZl2SPg0JKKc5QE1dv/FkuumDavV+sUV78P4XDw+zsCfdMrd5R+NVUMeiZwCu48Ery9UjtoSMyaM2pzitkeYotdDZZU9eURK1azh7bpvukCeigMmnHY6dPQi3nYM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id EFE22138819;
	Fri, 22 Aug 2025 21:16:32 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf03.hostedemail.com (Postfix) with ESMTPA id 7A3B36000C;
	Fri, 22 Aug 2025 21:16:30 +0000 (UTC)
Date: Fri, 22 Aug 2025 17:16:37 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML
 <linux-kernel@vger.kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mark Rutland
 <mark.rutland@arm.com>, Andrew Morton <akpm@linux-foundation.org>, Liao
 Yuanhong <liaoyuanhong@vivo.com>, Pu Lehui <pulehui@huawei.com>, Tao Chen
 <chen.dylane@linux.dev>, Tengda Wu <wutengda@huaweicloud.com>, Ye Weihua
 <yeweihua4@huawei.com>
Subject: Re: [GIT PULL] tracing: Fixes for v6.17
Message-ID: <20250822171637.7ee1cf7e@gandalf.local.home>
In-Reply-To: <20250822170808.5ce49cc3@gandalf.local.home>
References: <20250822124933.74965607@gandalf.local.home>
	<20250822192437.GA458494@ax162>
	<20250822170808.5ce49cc3@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 7A3B36000C
X-Stat-Signature: bjntq5z7yo4madp6uhdrzgp9jsuwpj8f
X-Rspamd-Server: rspamout02
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/m0l6OLZFMVM2FQkMXW8Qr1vpQ5EeQv1E=
X-HE-Tag: 1755897390-7031
X-HE-Meta: U2FsdGVkX1/qeSxceh1NNPOnHYDKLfS9ik63obbfsIKjqVhFsSw6BciglIfIiIkA35nV5nmvmluA4fdgSthirzm1uSjiZ431FBSbZgix6tnpHIsOnF17PY8fqh0N5EgS+R9uYbGexTYQHau8cLE5Zh6V/HG/6OOzZAKV4DSIyycF/oGIFhNu9h27as2fBHbM/SwlRJESHj2YToX5G7u1sguW+AWNrGXkW0gQ9+rmazu92Aq7Ny1hptzUqElSiUlKzORb5laUG7QgL1Sc65Ie6Wg07LWqWCuEUgvq2EnqyzGzC8AJai3vM9E6Nkwd4rL5OQbiArfxjRTcto5xW0xZS7O/somouyCygR6FcojZCgY/Vsw2Gicb9s3+DrcoEHOF

On Fri, 22 Aug 2025 17:08:08 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > 
> > If there is any other information I can provide or patches I can test, I
> > am happy to do so.  
> 
> Can you send me your .config file?

Actually, can you see if this fixes the bug you are seeing?

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index f992a5eb878e..2b570e057ba3 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -4662,7 +4662,8 @@ ftrace_regex_open(struct ftrace_ops *ops, int flag,
 			iter->hash = alloc_and_copy_ftrace_hash(size_bits, hash);
 		}
 	} else {
-		iter->hash = alloc_and_copy_ftrace_hash(hash->size_bits, hash);
+		if (hash)
+			iter->hash = alloc_and_copy_ftrace_hash(hash->size_bits, hash);
 	}
 
 	if (!iter->hash) {


-- Steve

