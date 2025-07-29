Return-Path: <linux-kernel+bounces-749031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72302B1491B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 09:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF88B163AB4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 07:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46097263F59;
	Tue, 29 Jul 2025 07:28:25 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8FF263F40
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 07:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753774104; cv=none; b=moitbXWzljWA/oCxiZjHox0oR3Jj8u+obBhxUp+/RR+y2cn9xh4gy/wH8CuoMPs9qfity+ukQ++NFsOZ/B7OiYlqtWqZfeEq+Q5BpiFDxQ8js36cEJvs91FDnCllHDtTLOd8BuXKkUOlZ+BZT5H5qk8QcUUXflXvWrff5yPHejs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753774104; c=relaxed/simple;
	bh=YXTXRZSqeVN5r8aC8osaO20V+asJOktil2K1doQXx18=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=BNQ32aOiLaESNKkC017uNYSyRDzzDBcxbNQowAK9Itbf3AfGgUWk3icV90vKLahEs7dKAfhIBIK8y8wVhCVYfvJ6OOMS8o6b24wcY97NcM8U4f1CRQa2nwBE54BrZ9jhdYalwJkC7F+ejnkxni4PWEhmQereWQOhOy39PObUjNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4brn4s2xnwz8Xs6y;
	Tue, 29 Jul 2025 15:28:13 +0800 (CST)
Received: from xaxapp01.zte.com.cn ([10.88.99.176])
	by mse-fl2.zte.com.cn with SMTP id 56T7RwRS004639;
	Tue, 29 Jul 2025 15:27:58 +0800 (+08)
	(envelope-from fan.yu9@zte.com.cn)
Received: from mapi (xaxapp01[null])
	by mapi (Zmail) with MAPI id mid32;
	Tue, 29 Jul 2025 15:27:59 +0800 (CST)
Date: Tue, 29 Jul 2025 15:27:59 +0800 (CST)
X-Zmail-TransId: 2af9688877ff44c-9e5bb
X-Mailer: Zmail v1.0
Message-ID: <20250729152759994n3YKgjxLglCCPkOtYtU2U@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <fan.yu9@zte.com.cn>
To: <tglx@linutronix.de>, <frederic@kernel.org>, <peterz@infradead.org>,
        <oleg@redhat.com>, <brauner@kernel.org>, <iro@zeniv.linux.org.uk>,
        <joel.granados@kernel.org>, <lorenzo.stoakes@oracle.com>,
        <akpm@linux-foundation.org>
Cc: <linux-kernel@vger.kernel.org>, <xu.xin16@zte.com.cn>,
        <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHQgdjJdIHNpZ25hbDogY2xhcmlmeSBfX3NlbmRfc2lnbmFsX2xvY2tlZCBjb21tZW50IGluIGRvX25vdGlmeV9wYXJlbnQ=?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl2.zte.com.cn 56T7RwRS004639
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: fan.yu9@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.133 unknown Tue, 29 Jul 2025 15:28:13 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6888780D.002/4brn4s2xnwz8Xs6y

From: Fan Yu <fan.yu9@zte.com.cn>

The original comment (introduced in commit 61e713bdca36 ("signal: Avoid
corrupting si_pid and si_uid in do_notify_parent")) stated that
__send_signal should be used because si_pid/si_uid are in the parent's
namespace, but it did not explain why send_signal_locked() is unsafe here.

This became more ambiguous after
  commit 157cc18122b4 ("signal: Rename send_signal send_signal_locked")
without updating the comment.

Explicitly clarify that:
1. send_signal_locked() may incorrectly modify si_pid/si_uid when crossing
   PID/user namespaces (e.g., reset si_pid to 0 or translate si_uid).
2. __send_signal_locked() preserves the original siginfo values, which is
   critical since they are already in the parent's namespace.

Signed-off-by: Fan Yu <fan.yu9@zte.com.cn>
---
Changes in V2:
- Some fixes according to
https://lore.kernel.org/all/878qk8pdkd.ffs@tglx/
https://lore.kernel.org/all/20250728155815.GB25567@redhat.com/
- Clarify why __send_signal_locked must be used

 kernel/signal.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index e2c928de7d2c..047b22837a36 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2252,8 +2252,10 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
 			sig = 0;
 	}
 	/*
-	 * Send with __send_signal as si_pid and si_uid are in the
-	 * parent's namespaces.
+	 * Use __send_signal_locked() instead of send_signal_locked()
+	 * because si_pid and si_uid are already in the parent's
+	 * namespace. send_signal_locked() would incorrectly modify
+	 * them when crossing PID/user namespaces.
 	 */
 	if (valid_signal(sig) && sig)
 		__send_signal_locked(sig, &info, tsk->parent, PIDTYPE_TGID, false);
-- 
2.25.1

