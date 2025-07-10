Return-Path: <linux-kernel+bounces-724690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E72AFF5F7
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 02:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FB181BC8B52
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 00:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1813A1991C9;
	Thu, 10 Jul 2025 00:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="idi5Cmt2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5017B72627
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 00:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752107552; cv=none; b=ZWm/2KwHbZbuPwGWrCS1oFrNeM0wAx8sZLKcmoWWeXyjHiEMgIi6l+htluTXbPV7Nt7JVw3jyFXwRhT3MWCEApeUG0Xu6gSy7398R/Da+4mBdEheyx2MYwEBxB5p4ZHNnUW8sj9zkvhqO48WwOYGwsdkeY/CETAhf22C2yosldA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752107552; c=relaxed/simple;
	bh=4AFKpDuvOukgEWENljhISxKYZnsv23Wnboy6Gb3VHt8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=iONq6QVbBnA4eiZgGWqQtYh4J/FR++6y4+8oapfK+ERm3z+s1QkuMXRPgknpBmpljOJ1u5QzKprgWLVcdjO9LwHdlkEwG4ruklD34WENx8v5eXnE8Cxpn7H13EjMH5ZzGUtVmqKzn5d3a2uuVOhNn6hY28qXqCpOON0xHt6xARs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=idi5Cmt2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBF6CC4CEEF;
	Thu, 10 Jul 2025 00:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752107551;
	bh=4AFKpDuvOukgEWENljhISxKYZnsv23Wnboy6Gb3VHt8=;
	h=Date:From:To:Cc:Subject:References:From;
	b=idi5Cmt2BU6E9S7tc8m5IAuxbUhUCS8/RZei0wbd8F+i4BJRD4LBjuGO+HcAHBDtt
	 byw/75BMaFMxopAut1Pi5aNVrWeNfH5ydvD/irfCwt8umQPAVl+4wdqmAX5uJz+Uk2
	 5s2xegiSKUZ/7mqfR/qWuhaE0LuxwTwtppdMGZYOkomWu7+520NgNSluDHhRZMoKP1
	 QlrzRZPYRd6AyE5NuxWtPvTbDFQdHymhfgVKg3vVxlvdDlwaqk8KD5Xnej16Tls88u
	 FQ9Hg9GZcFv4eG3LLSsEjvKjYtc7WvzCC9xjK5OVKkMVjc6AAw811OQH7yISyRlgv2
	 9etl16qi0ZZWQ==
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@kernel.org>)
	id 1uZfDI-00000001WPk-1Uem;
	Wed, 09 Jul 2025 20:32:36 -0400
Message-ID: <20250710003236.205594702@kernel.org>
User-Agent: quilt/0.68
Date: Wed, 09 Jul 2025 20:32:01 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 John Ogness <john.ogness@linutronix.de>,
 Gabriele Monaco <gmonaco@redhat.com>,
 Nam Cao <namcao@linutronix.de>
Subject: [for-next][PATCH 05/12] rv: rename CONFIG_DA_MON_EVENTS to CONFIG_RV_MON_EVENTS
References: <20250710003156.209859354@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Nam Cao <namcao@linutronix.de>

CONFIG_DA_MON_EVENTS is not specific to deterministic automaton. It could
be used for other monitor types. Therefore rename it to
CONFIG_RV_MON_EVENTS.

This prepares for the introduction of linear temporal logic monitor.

Cc: John Ogness <john.ogness@linutronix.de>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/507210517123d887c1d208aa2fd45ec69765d3f0.1752088709.git.namcao@linutronix.de
Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/rv/Kconfig | 6 +++---
 kernel/trace/rv/rv.c    | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index b39f36013ef2..6cdffc04b73c 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -1,14 +1,14 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
-config DA_MON_EVENTS
+config RV_MON_EVENTS
 	bool
 
 config DA_MON_EVENTS_IMPLICIT
-	select DA_MON_EVENTS
+	select RV_MON_EVENTS
 	bool
 
 config DA_MON_EVENTS_ID
-	select DA_MON_EVENTS
+	select RV_MON_EVENTS
 	bool
 
 menuconfig RV
diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index e4077500a91d..e25d65fe432a 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -143,7 +143,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 
-#ifdef CONFIG_DA_MON_EVENTS
+#ifdef CONFIG_RV_MON_EVENTS
 #define CREATE_TRACE_POINTS
 #include <rv_trace.h>
 #endif
-- 
2.47.2



