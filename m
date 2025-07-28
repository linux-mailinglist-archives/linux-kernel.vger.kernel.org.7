Return-Path: <linux-kernel+bounces-747670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F26B136AA
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 10:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D10017AADC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 08:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7456239E91;
	Mon, 28 Jul 2025 08:25:26 +0000 (UTC)
Received: from mxhk.zte.com.cn (mxhk.zte.com.cn [160.30.148.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C2C5238C20
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 08:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.30.148.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753691126; cv=none; b=BXRoAreHTgil3KNSixW82FmnwmGjzFyiAtFy4GZgfVIcci0gp+9bTzJsZrHtzuOinrJkoNPsfZrk7a/5i2mcUcOKddC8JHjMqlQKU5yslHeLWWZjWjGOjli7IrpW8DCrNQJ0/bYutwvgskLwV8fH+k511nmULeLzfA1e08Vz4E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753691126; c=relaxed/simple;
	bh=anfs0OD7dSebyQsSGsSGtPUMRB2Y201nr9Y4rdxdpTQ=;
	h=Date:Message-ID:Mime-Version:From:To:Cc:Subject:Content-Type; b=Hay1E6Nc7LBaDpE0BUXUv0SFrT9z6sbRyeQg7wN4KhALl2pEMqJyelQuTBM4mjJYlMLz3Woi63VPyeEh6bG4QYrulZzw6e12HgQUncFtypc003DjSsBGOfcP+CGgYxEDVNDDaYpj0IaJjvpQCB1hJ1L2eHUubau+BpgoPdyU/dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn; spf=pass smtp.mailfrom=zte.com.cn; arc=none smtp.client-ip=160.30.148.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zte.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zte.com.cn
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mxhk.zte.com.cn (FangMail) with ESMTPS id 4brBP83nnhz8Xs78;
	Mon, 28 Jul 2025 16:25:16 +0800 (CST)
Received: from xaxapp05.zte.com.cn ([10.99.98.109])
	by mse-fl1.zte.com.cn with SMTP id 56S8OpbK057580;
	Mon, 28 Jul 2025 16:24:52 +0800 (+08)
	(envelope-from fan.yu9@zte.com.cn)
Received: from mapi (xaxapp04[null])
	by mapi (Zmail) with MAPI id mid32;
	Mon, 28 Jul 2025 16:24:54 +0800 (CST)
Date: Mon, 28 Jul 2025 16:24:54 +0800 (CST)
X-Zmail-TransId: 2afb688733d6ffffffff909-b1060
X-Mailer: Zmail v1.0
Message-ID: <202507281624542763Kn377WvUMXlKHVJUdNjA@zte.com.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
From: <fan.yu9@zte.com.cn>
To: <tglx@linutronix.de>, <frederic@kernel.org>, <peterz@infradead.org>,
        <oleg@redhat.com>, <brauner@kernel.org>, <iro@zeniv.linux.org.uk>,
        <joel.granados@kernel.org>, <lorenzo.stoakes@oracle.com>
Cc: <linux-kernel@vger.kernel.org>, <xu.xin16@zte.com.cn>,
        <yang.yang29@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIHNpZ25hbDogUmVtb3ZlIG91dGRhdGVkIF9fc2VuZF9zaWduYWwgcmVmZXJlbmNlcyBpbgogZG9fbm90aWZ5X3BhcmVudA==?=
Content-Type: text/plain;
	charset="UTF-8"
X-MAIL:mse-fl1.zte.com.cn 56S8OpbK057580
X-TLS: YES
X-SPF-DOMAIN: zte.com.cn
X-ENVELOPE-SENDER: fan.yu9@zte.com.cn
X-SPF: None
X-SOURCE-IP: 10.5.228.132 unknown Mon, 28 Jul 2025 16:25:16 +0800
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 688733EC.000/4brBP83nnhz8Xs78

From: Fan Yu <fan.yu9@zte.com.cn>

The function __send_signal was renamed to __send_signal_locked in
commit 157cc18122b4 ("signal: Rename send_signal send_signal_locked"),
making the existing comments in do_notify_parent obsolete.

This patch removes these outdated references to maintain code clarity
and prevent confusion about the current implementation.

Signed-off-by: Fan Yu <fan.yu9@zte.com.cn>
---
 kernel/signal.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index e2c928de7d2c..30a52d884f87 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2251,10 +2251,7 @@ bool do_notify_parent(struct task_struct *tsk, int sig)
 		if (psig->action[SIGCHLD-1].sa.sa_handler == SIG_IGN)
 			sig = 0;
 	}
-	/*
-	 * Send with __send_signal as si_pid and si_uid are in the
-	 * parent's namespaces.
-	 */
+
 	if (valid_signal(sig) && sig)
 		__send_signal_locked(sig, &info, tsk->parent, PIDTYPE_TGID, false);
 	__wake_up_parent(tsk, tsk->parent);
-- 
2.25.1

