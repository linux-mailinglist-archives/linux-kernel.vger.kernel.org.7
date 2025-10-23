Return-Path: <linux-kernel+bounces-867782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E550C037BB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 23:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24D3A3A695A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 21:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C818227057D;
	Thu, 23 Oct 2025 21:04:59 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F1235B138
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 21:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761253499; cv=none; b=clda4gc6scvyFwG2tOKCtqRiO3Oa4dVqHXorkD5CTdp2gD2VbPVE+6DDorQcM7PsrIMkdC9QAnzyR94L8q6O1FyDAfeIai1i/XBO/OnALZlctoMDO2jrYAZCmuUnm5fiLtpi5ZWocR9ISwTBbXvktRkg0dqSH9KMQpgTHlNolBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761253499; c=relaxed/simple;
	bh=RMEi3n8PARTMY4qA/ODdBOqZMt4BtGgB0HzAgOu1Yvc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=P71YCvmOCYHABXGwU0sA1EKD2GRQvjjQ6ivCW5JRyPHDHy+dySd45IT5DYRnTujUCEoxmxNHjzaF7pdFRAVfBYFujOVV/N+tG5TY//9tfbqfM7uqQ4Qi+Kz+eaNKenrBDcYFoH7NznlxD20//QgtygwtOX3YRpkUBwMEDLJ+mFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 74B7A1DCCF9;
	Thu, 23 Oct 2025 21:04:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id CFEAE20028;
	Thu, 23 Oct 2025 21:04:52 +0000 (UTC)
Date: Thu, 23 Oct 2025 17:05:19 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Gabriele Monaco
 <gmonaco@redhat.com>, Nam Cao <namcao@linutronix.de>
Subject: [ GIT PULL ] rv: A couple of fixes for v6.18
Message-ID: <20251023170519.52a6261a@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: hhkz4fwib5ykyogbc3q9pc3ur9esp3jm
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: CFEAE20028
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19JtznBFKtT2CJumPAw78lqj9v3dixl5i8=
X-HE-Tag: 1761253492-794983
X-HE-Meta: U2FsdGVkX18WKZCcYlh8AZfNbQNUsWTxPXmwdOkVWYA2JkPbWKM8Hw093R6kJD1F171i0LAab5VSiIs+uHMDwd2TFPO4wNixDfoUFPj/y3RR+nsfqFsNCoVU6xQk6W2vPmarZpoRIVbaMt8ejTt7BR3CxovT5BbaolrzdWheURHfqswPXjxv01d/06JfymbU5JhUssPKPIBInrz4TMRsC7qOGxEU/7bHVIXMH2i1LiKmY8MB3bic5kcUP30V6HbA8UF6x7NNkhfLY6bmYFsGnHhyqMm7N3xn6pmPUQGcjnz7Prx4hWVh6hAQx3ceLAKBiu8zGkXAifw6CDp+Es60JWu+UtekpV2V


Linus,

A couple of fixes for Runtime Verification

- A bug caused a kernel panic when reading enabled_monitors was reported.
  Change callbacks functions to always use list_head iterators and by
  doing so, fix the wrong pointer that was leading to the panic.

- The rtapp/pagefault monitor relies on the MMU to be present
  (pagefaults exist) but that was not enforced via kconfig, leading to
  potential build errors on systems without an MMU. Add that kconfig
  dependency.


Please pull the latest trace-rv-v6.18-rc2 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace-rv-v6.18-rc2

Tag SHA1: 710476ae493b02551d9987bdbd52f4c3cf3bffef
Head SHA1: 3d62f95bd8450cebb4a4741bf83949cd54edd4a3


Nam Cao (2):
      rv: Fully convert enabled_monitors to use list_head as iterator
      rv: Make rtapp/pagefault monitor depends on CONFIG_MMU

----
 kernel/trace/rv/monitors/pagefault/Kconfig |  1 +
 kernel/trace/rv/rv.c                       | 12 ++++++------
 2 files changed, 7 insertions(+), 6 deletions(-)
---------------------------
diff --git a/kernel/trace/rv/monitors/pagefault/Kconfig b/kernel/trace/rv/monitors/pagefault/Kconfig
index 5e16625f1653..0e013f00c33b 100644
--- a/kernel/trace/rv/monitors/pagefault/Kconfig
+++ b/kernel/trace/rv/monitors/pagefault/Kconfig
@@ -5,6 +5,7 @@ config RV_MON_PAGEFAULT
 	select RV_LTL_MONITOR
 	depends on RV_MON_RTAPP
 	depends on X86 || RISCV
+	depends on MMU
 	default y
 	select LTL_MON_EVENTS_ID
 	bool "pagefault monitor"
diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index 48338520376f..43e9ea473cda 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -501,7 +501,7 @@ static void *enabled_monitors_next(struct seq_file *m, void *p, loff_t *pos)
 
 	list_for_each_entry_continue(mon, &rv_monitors_list, list) {
 		if (mon->enabled)
-			return mon;
+			return &mon->list;
 	}
 
 	return NULL;
@@ -509,7 +509,7 @@ static void *enabled_monitors_next(struct seq_file *m, void *p, loff_t *pos)
 
 static void *enabled_monitors_start(struct seq_file *m, loff_t *pos)
 {
-	struct rv_monitor *mon;
+	struct list_head *head;
 	loff_t l;
 
 	mutex_lock(&rv_interface_lock);
@@ -517,15 +517,15 @@ static void *enabled_monitors_start(struct seq_file *m, loff_t *pos)
 	if (list_empty(&rv_monitors_list))
 		return NULL;
 
-	mon = list_entry(&rv_monitors_list, struct rv_monitor, list);
+	head = &rv_monitors_list;
 
 	for (l = 0; l <= *pos; ) {
-		mon = enabled_monitors_next(m, mon, &l);
-		if (!mon)
+		head = enabled_monitors_next(m, head, &l);
+		if (!head)
 			break;
 	}
 
-	return mon;
+	return head;
 }
 
 /*

