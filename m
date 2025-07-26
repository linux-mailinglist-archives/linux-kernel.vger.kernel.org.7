Return-Path: <linux-kernel+bounces-746769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F874B12AE8
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 16:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E8CD3A90C4
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Jul 2025 14:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9DF28641F;
	Sat, 26 Jul 2025 14:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZHszfh9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCEF2F2E
	for <linux-kernel@vger.kernel.org>; Sat, 26 Jul 2025 14:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753539402; cv=none; b=JA/qOhY18ysmXskVAtnYBthssafX3gN7Uhv4OVx3393Wegvmr+KwSu3QC7xDyM2yB/6BoEe4tweM+TcbmxYhh5Vq1IvlhrBG5jnOC2GHyrGT6HAcsRU9I/6cqg2+UUF8aaga7MiKJfb6vpsT4S+WpHouzyPFXT+ydItT7eGsmvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753539402; c=relaxed/simple;
	bh=4ESg8qJleMclZGoO5VM2hwzCD+vsMTlFWhEKrP5nHlE=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=C47ykZuHXfrIZcfut4yJa/o1dRjpcEXfqqJDU3qwn8v9QXTt6Evh02nVJUeh4mw4dGEgrTWzWyzJ8nzEPMSfKizpI1K5GC2/P7jvBV59TWb7I0iwCfsn2YLnLWonFsfzB5dFefmG0pY5mLht+E3jvrjvZctaGuYfTCok+gB9EO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZHszfh9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00EAAC4CEF1;
	Sat, 26 Jul 2025 14:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753539402;
	bh=4ESg8qJleMclZGoO5VM2hwzCD+vsMTlFWhEKrP5nHlE=;
	h=Date:From:To:Cc:Subject:References:From;
	b=mZHszfh9ei1nKkL5gpfMQWnf+WX9K+a9B4SE5pRML6xk7rIRYDilTOuM2JEj0TMxs
	 Kq0dvm4Uhf4GtBic/QhfMBX8SVYOIKzmw/qlaZFVnhsg1B5dMkZ8MIFpEzB3+8odYm
	 vHZEHRUQq6DAO7Jg3fYJjoeRSA9Xp7XGQ86h5NNv/BTn9Ubo/ndnnzYpOcarvI/W4Z
	 2cf6xGHX+XVVaPnnoGpZXmygr1YZfp913ktUZjOBZJZSsOqRJptzWALD1vNpMakgm6
	 LEMejIyyip2moyGbPSf6jEuKbmgdcrhrnuSMkMFsg7XUCmyF7TDnNxjD29uT6z30Ir
	 q0kIuaxu0PxEQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uffhh-00000001st5-3DIX;
	Sat, 26 Jul 2025 10:16:49 -0400
Message-ID: <20250726141649.618389869@kernel.org>
User-Agent: quilt/0.68
Date: Sat, 26 Jul 2025 10:16:05 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 David Hildenbrand <david@redhat.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>
Subject: [for-next][PATCH 1/2] powerpc/thp: tracing: Hide hugepage events under CONFIG_PPC_BOOK3S_64
References: <20250726141604.934070855@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

The events hugepage_set_pmd, hugepage_set_pud, hugepage_update_pmd and
hugepage_update_pud are only called when CONFIG_PPC_BOOK3S_64 is defined.
As each event can take up to 5K regardless if they are used or not, it's
best not to define them when they are not used. Add #ifdef around these
events when they are not used.

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Link: https://lore.kernel.org/20250612101259.0ad43e48@batman.local.home
Acked-by: David Hildenbrand <david@redhat.com>
Acked-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/trace/events/thp.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/trace/events/thp.h b/include/trace/events/thp.h
index f50048af5fcc..c8fe879d5828 100644
--- a/include/trace/events/thp.h
+++ b/include/trace/events/thp.h
@@ -8,6 +8,7 @@
 #include <linux/types.h>
 #include <linux/tracepoint.h>
 
+#ifdef CONFIG_PPC_BOOK3S_64
 DECLARE_EVENT_CLASS(hugepage_set,
 
 	    TP_PROTO(unsigned long addr, unsigned long pte),
@@ -66,6 +67,7 @@ DEFINE_EVENT(hugepage_update, hugepage_update_pud,
 	    TP_PROTO(unsigned long addr, unsigned long pud, unsigned long clr, unsigned long set),
 	    TP_ARGS(addr, pud, clr, set)
 );
+#endif /* CONFIG_PPC_BOOK3S_64 */
 
 DECLARE_EVENT_CLASS(migration_pmd,
 
-- 
2.47.2



