Return-Path: <linux-kernel+bounces-742851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F06F4B0F75A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 17:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 800EA567174
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jul 2025 15:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCAF130E58;
	Wed, 23 Jul 2025 15:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=nixdorf.dev header.i=@nixdorf.dev header.b="ZUJYBkuF"
Received: from shadowice.org (shadowice.org [95.216.8.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E241A5BAE
	for <linux-kernel@vger.kernel.org>; Wed, 23 Jul 2025 15:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.216.8.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753285517; cv=none; b=Q01lNwKE2+xpw2AgCAGM83wSHIDD5VPF4lJs70TA0N9QDpG/NEIcrc4VYfvIogPAfMNB4PT9nzFeQpa60AeQ9Y9pGtZ3fU4PdnB9GuoIKzcQOS+9FppXYuNJ6oWPHkRM/wiNZE5piDR6fsgohmwYgLqMgpgmVGnDcqidTBbHTsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753285517; c=relaxed/simple;
	bh=rTvu3BJdQlechtwiUw7+Po0Fpa7OQn19KBJSFAcO6n8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=E0oAPg6SebssdDWhCadWRARpVTivKCTJ69aIr4NV7CxGfjaQoa5ZONmXBH0OD4+U1qOnvIyGRPnowG1AEF++Fz81nYd2+171E2EpH7R1YLLp8eeezwKTNkdLWzd+bC7YlIbsjXWXvNumbHtq/fFyDN0fNc5hNzRdwgMf9KyEeLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nixdorf.dev; spf=none smtp.mailfrom=nixdorf.dev; dkim=fail (0-bit key) header.d=nixdorf.dev header.i=@nixdorf.dev header.b=ZUJYBkuF reason="key not found in DNS"; arc=none smtp.client-ip=95.216.8.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nixdorf.dev
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nixdorf.dev
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=default; bh=rTvu3BJdQlec
	htwiUw7+Po0Fpa7OQn19KBJSFAcO6n8=; h=cc:to:subject:date:from;
	d=nixdorf.dev; b=ZUJYBkuFjsA2Q9vbOiaXmTci19ACs3EWH8KHBY5je/Ltk5rTLMYHY
	wCaTpSLlI+dg2WdhxlAabKLVpXdA+ecAKCKtSE4QuCHNx6LBwzvKDpJrS2n7k1YCbSgbPA
	vJn03NvaKB3Wyr9dwm/niFTs+Uk3EKxU6Ple6yFXFLc1w3hw=
Received: from [127.0.0.1] (p4fe9d2f1.dip0.t-ipconnect.de [79.233.210.241])
	by shadowice.org (OpenSMTPD) with ESMTPSA id 0b804b51 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 23 Jul 2025 17:38:32 +0200 (CEST)
From: Johannes Nixdorf <johannes@nixdorf.dev>
Date: Wed, 23 Jul 2025 17:38:20 +0200
Subject: [PATCH] seccomp: Fix a race with WAIT_KILLABLE_RECV if the tracer
 replies too fast
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-seccomp-races-v1-1-bef5667ce30a@nixdorf.dev>
X-B4-Tracking: v=1; b=H4sIAOsBgWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDcyND3eLU5OT83ALdosTk1GLdVEtzC0vzFLMUS5MkJaCegqLUtMwKsHn
 RsbW1AClNuQZfAAAA
X-Change-ID: 20250721-seccomp-races-e97897d6d94b
To: Kees Cook <kees@kernel.org>, Andy Lutomirski <luto@amacapital.net>, 
 Will Drewry <wad@chromium.org>, Sargun Dhillon <sargun@sargun.me>
Cc: linux-kernel@vger.kernel.org, Ali Polatel <alip@chesswob.org>, 
 Johannes Nixdorf <johannes@nixdorf.dev>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753285111; l=3055;
 i=johannes@nixdorf.dev; s=20250722; h=from:subject:message-id;
 bh=rTvu3BJdQlechtwiUw7+Po0Fpa7OQn19KBJSFAcO6n8=;
 b=x//spWWrzD0eyi7yYTuHF/k1StjO1VXmjJZ1SX3Cb3RZozfwhtmI2Q8aTJ5uYIQbMkX9Ipx4v
 Dto3xP8jCMwDuN1nAwHho26PKmdIw8RVvm3iakGUBlasR14qDczteMd
X-Developer-Key: i=johannes@nixdorf.dev; a=ed25519;
 pk=6Mv9a34ZxWm/f3K6MdzLRKgty83xawuXPS5bMkbLzWs=

Normally the tracee starts in SECCOMP_NOTIFY_INIT, sends an
event to the tracer, and starts to wait interruptibly. With
SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV, if the tracer receives the
message (SECCOMP_NOTIFY_SENT is reached) while the tracee was waiting
and is subsequently interrupted, the tracee begins to wait again
uninterruptibly (but killable).

This fails if SECCOMP_NOTIFY_REPLIED is reached before the tracee
is interrupted, as the check only considered SECCOMP_NOTIFY_SENT as a
condition to begin waiting again. In this case the tracee is interrupted
even though the tracer already acted on its behalf. This breaks the
assumption SECCOMP_FILTER_FLAG_WAIT_KILLABLE_RECV wanted to ensure,
namely that the tracer can be sure the syscall is not interrupted or
restarted on the tracee after it is received on the tracer. Fix this
by also considering SECCOMP_NOTIFY_REPLIED when evaluating whether to
switch to uninterruptible waiting.

With the condition changed the loop in seccomp_do_user_notification()
would exit immediately after deciding that noninterruptible waiting
is required if the operation already reached SECCOMP_NOTIFY_REPLIED,
skipping the code that processes pending addfd commands first. Prevent
this by executing the remaining loop body one last time in this case.

Fixes: c2aa2dfef243 ("seccomp: Add wait_killable semantic to seccomp user notifier")
Reported-by: Ali Polatel <alip@chesswob.org>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220291
Signed-off-by: Johannes Nixdorf <johannes@nixdorf.dev>
---
 kernel/seccomp.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 41aa761c7738cefe01ca755f78f12844d7186e2a..fa44bcb6aa47df88bdc5951217d99779bd56ab70 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1139,7 +1139,7 @@ static void seccomp_handle_addfd(struct seccomp_kaddfd *addfd, struct seccomp_kn
 static bool should_sleep_killable(struct seccomp_filter *match,
 				  struct seccomp_knotif *n)
 {
-	return match->wait_killable_recv && n->state == SECCOMP_NOTIFY_SENT;
+	return match->wait_killable_recv && n->state >= SECCOMP_NOTIFY_SENT;
 }
 
 static int seccomp_do_user_notification(int this_syscall,
@@ -1186,13 +1186,12 @@ static int seccomp_do_user_notification(int this_syscall,
 
 		if (err != 0) {
 			/*
-			 * Check to see if the notifcation got picked up and
-			 * whether we should switch to wait killable.
+			 * Check to see whether we should switch to wait
+			 * killable. Only return the interrupted error if not.
 			 */
-			if (!wait_killable && should_sleep_killable(match, &n))
-				continue;
-
-			goto interrupted;
+			if (!(!wait_killable && should_sleep_killable(match,
+								      &n)))
+				goto interrupted;
 		}
 
 		addfd = list_first_entry_or_null(&n.addfd,

---
base-commit: 89be9a83ccf1f88522317ce02f854f30d6115c41
change-id: 20250721-seccomp-races-e97897d6d94b

Best regards,
-- 
Johannes Nixdorf <johannes@nixdorf.dev>


