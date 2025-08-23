Return-Path: <linux-kernel+bounces-782907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C52AB326B2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 05:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3971C1B66A12
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 03:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F971EE032;
	Sat, 23 Aug 2025 03:36:45 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE08A393DE5
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 03:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755920205; cv=none; b=N23Qdyddl6ZnmYGaNhzotl87gxfNMvCmuFUh0c5bba/US3PgCMzJg2B5jhKxqNto/vgeRjhix/Evca6e6oz5vSW29qBOTdp/EjjA8wqhE6jwosux8wjkryoWQbvP/bBBDbTiyBSlDNbXOszYJIbkrEfcrD0spABBP1zefToN3Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755920205; c=relaxed/simple;
	bh=E4jqlEuCiPxnBCo97TCOXAqOcCy4jzk/ai2BChH7sPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=IiNyDEkt1mI3spxjH3NINgqgfUQCpD9yAsdLMCnxRmN22EJ55+gV7xfnrji/hUq6yTVd6Z4p1zj1AZWKAxPFn+DPu3g14+ejYTanrbXlclqIsTCi9nC+xuGeR0Ce/58ZsbdWGF1yYWx91M8nI7QYxCd4ixYDb7NGASaPoFFQcvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf04.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 71DB31DD656;
	Sat, 23 Aug 2025 03:36:36 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf04.hostedemail.com (Postfix) with ESMTPA id CC1F820024;
	Sat, 23 Aug 2025 03:36:34 +0000 (UTC)
Date: Fri, 22 Aug 2025 23:36:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Tengda Wu <wutengda@huaweicloud.com>,
 Nathan Chancellor <nathan@kernel.org>
Subject: [for-linus][PATCH] ftrace: Also allocate and copy hash for reading
 of filter files
Message-ID: <20250822233642.69d25aa9@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: zo4a3ooq8z7myw8bu8fquya1ssw3agj8
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: CC1F820024
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/XlXArSvis0vVuWOqmNqtpW3koGZNhTo4=
X-HE-Tag: 1755920194-495430
X-HE-Meta: U2FsdGVkX18IEwsUTfmDNbSvpKpaM+7KM/gyZuQaZAmZV+ZPE0G30LWrTeIL1gi7aPLoPtW8NRwVfdYL6yxSsp5+NUNE5CgZl0Q6l5OfcONd6CqOWvwkXAElMM1i2D8vmuTs8jw16579T5wXqsU38gJZ1KerBlf5kPEbjeHbMtJEygq4CezXJtjlArF/ra9w2EYkFaRohNsMcpY5jg/KjTDP0Fmy3iwZrt7Yq69Yb/IoCoNdjlxBhe2nvhUeqEn09eJoB5NkWqD74IAvyBImqN6GeWHhH4JMacMcBwYKzGnnwMbsGlEbZpGSncmBWox1mANgjNn2wmRg0lpehSwTF0atuxrUdtB6mzO0Da+7zPxhTVKYHugRnlnRwYlb8N23R+EIEWfwPB8TrqmG/IGf/8sAmrjxThP9pkeSP7E2W/3ii12IlfA/ICGD4M0h8ZvH1rhz6+x6TiqRM+DyjT9ttBi3iBdtiZPmD25JHGJLEuMBe9y+wnv7wmzd1lhgNHuZ0DpBBsRTqzuuuPlV9wpbe5iSQTqbWIMmR2I9rNPGrgA=


  git://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git
trace/fixes

Head SHA1: bfb336cf97df7b37b2b2edec0f69773e06d11955


Steven Rostedt (1):
      ftrace: Also allocate and copy hash for reading of filter files

----
 kernel/trace/ftrace.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)
---------------------------
commit bfb336cf97df7b37b2b2edec0f69773e06d11955
Author: Steven Rostedt <rostedt@goodmis.org>
Date:   Fri Aug 22 18:36:06 2025 -0400

    ftrace: Also allocate and copy hash for reading of filter files
    
    Currently the reader of set_ftrace_filter and set_ftrace_notrace just adds
    the pointer to the global tracer hash to its iterator. Unlike the writer
    that allocates a copy of the hash, the reader keeps the pointer to the
    filter hashes. This is problematic because this pointer is static across
    function calls that release the locks that can update the global tracer
    hashes. This can cause UAF and similar bugs.
    
    Allocate and copy the hash for reading the filter files like it is done
    for the writers. This not only fixes UAF bugs, but also makes the code a
    bit simpler as it doesn't have to differentiate when to free the
    iterator's hash between writers and readers.
    
    Cc: stable@vger.kernel.org
    Cc: Masami Hiramatsu <mhiramat@kernel.org>
    Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
    Cc: Nathan Chancellor <nathan@kernel.org>
    Cc: Linus Torvalds <torvalds@linux-foundation.org>
    Link: https://lore.kernel.org/20250822183606.12962cc3@batman.local.home
    Fixes: c20489dad156 ("ftrace: Assign iter->hash to filter or notrace hashes on seq read")
    Closes: https://lore.kernel.org/all/20250813023044.2121943-1-wutengda@huaweicloud.com/
    Closes: https://lore.kernel.org/all/20250822192437.GA458494@ax162/
    Reported-by: Tengda Wu <wutengda@huaweicloud.com>
    Tested-by: Tengda Wu <wutengda@huaweicloud.com>
    Tested-by: Nathan Chancellor <nathan@kernel.org>
    Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 00b76d450a89..a69067367c29 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -4661,13 +4661,17 @@ ftrace_regex_open(struct ftrace_ops *ops, int flag,
 	        } else {
 			iter->hash = alloc_and_copy_ftrace_hash(size_bits, hash);
 		}
+	} else {
+		if (hash)
+			iter->hash = alloc_and_copy_ftrace_hash(hash->size_bits, hash);
+		else
+			iter->hash = EMPTY_HASH;
+	}
 
-		if (!iter->hash) {
-			trace_parser_put(&iter->parser);
-			goto out_unlock;
-		}
-	} else
-		iter->hash = hash;
+	if (!iter->hash) {
+		trace_parser_put(&iter->parser);
+		goto out_unlock;
+	}
 
 	ret = 0;
 
@@ -6543,9 +6547,6 @@ int ftrace_regex_release(struct inode *inode, struct file *file)
 		ftrace_hash_move_and_update_ops(iter->ops, orig_hash,
 						      iter->hash, filter_hash);
 		mutex_unlock(&ftrace_lock);
-	} else {
-		/* For read only, the hash is the ops hash */
-		iter->hash = NULL;
 	}
 
 	mutex_unlock(&iter->ops->func_hash->regex_lock);

