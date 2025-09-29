Return-Path: <linux-kernel+bounces-836508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A19FBA9E28
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 17:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3647189FF9E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 15:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA2D30C0E9;
	Mon, 29 Sep 2025 15:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKc62zVt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87ECB34BA5A
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 15:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759161317; cv=none; b=gibEk1I3VCdkaYEmzc6R4dj7nRIUjFAyWn1cXtnXXDNNTtP0/LmGPdXtC4NpKDXGk9xiORPyhbGMqtOubtiYMGQVpjaiUFrKsL4kS2FShfSltRFw98TzswH738eb7j6AGgekTDeUJk2NaFxJNGFaYzdF1t1sS1IjZH0mUPO/kTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759161317; c=relaxed/simple;
	bh=5ZiYViMmHyYTGbotSTQoJNHs5BRuX6SdoxN8p8nXJh0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kq8xf65a+XSvFIa8JNGCIkmYmY8BDNsPK55sJMPi5e7cP1T7+eTI9f6s+M2XgRLMzeZK8rsOCNMpr0C9qU7UQANVZVOpF1x2u+N9lnlGlP05F5vf+HG78F2WyG7+d8ZE/qmQsYCkXB2TxB2FSM5BRhJmfmyh4BexmbTdwyk7TuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKc62zVt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 250CBC4CEF4;
	Mon, 29 Sep 2025 15:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759161314;
	bh=5ZiYViMmHyYTGbotSTQoJNHs5BRuX6SdoxN8p8nXJh0=;
	h=From:Date:Subject:To:Cc:From;
	b=SKc62zVtn00Uk5vk3CA+EXf9fSGP6vPqQA32v4D/dWzgk2RFFeNtX0bU24zWlhcug
	 tpDVDDdQ9jpw1MfHqiFTJajPbdM1iHKCTkq5bYO2D3fXyvBOp8D3iGEdfNY7uaLECr
	 6zvuxpTfR4JewwSet9kfEFiCjCeNJ9qr60inA4HIqu5SMbjxcsXnaFX2gQ+wwRRdfT
	 yXS6XCmnL8d+aGe5tG2Nr+rO7GD8GkSvC84Pt8pMP4D83VNp+ZurwfFTwDnZcn1oBk
	 wO0WatAMmhex5sul7LemGM3f2so47JZZ/7EIw/X9o0fDvVkaCgXUpp17KBaV/GL7zD
	 sN+LcvKRSz9/Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CECACAC5B0;
	Mon, 29 Sep 2025 15:55:14 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Mon, 29 Sep 2025 17:55:07 +0200
Subject: [PATCH] watchdog: move nmi_watchdog sysctl into .rodata
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250929-jag-nmiwd_const-v1-1-92200d503b1f@kernel.org>
X-B4-Tracking: v=1; b=H4sIANqr2mgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDSyNL3azEdN283MzylPjk/LziEt0UcxMj48QkI1MTSzMloK6CotS0zAq
 widGxtbUAqzFcmmEAAAA=
X-Change-ID: 20250929-jag-nmiwd_const-d7423ab25496
To: Petr Mladek <pmladek@suse.com>, Daniel Xu <dlxu@meta.com>
Cc: linux-kernel@vger.kernel.org, Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2198;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=5ZiYViMmHyYTGbotSTQoJNHs5BRuX6SdoxN8p8nXJh0=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGjaq+COM2Svc8jNNFjm5q85lI9TkhtAfjlfy
 8z8sh5u2LRDLokBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJo2qvgAAoJELqXzVK3
 lkFPzlAL/3fhRZbC1qSPUyUYd6UjCH1DU3lx6hp+FzCodX/p2mgTY/luqaOVtuTMqewvQVAJ4dV
 RbrlwckF82kME1qIKhRyrdZrlIGxNwoe6wMf7Ji58iV0YKQXLySYW/Q44x5byReySl6ONNJ1fvR
 3KFPTGU3FQKR8tYayZjjVQyUa/U0B2NyvoPfPJJoqnTo0fXcZTbWdldXDrloJ/HBaip9agWMrgk
 slAItrraZlt3emPeLB0BslyyaClokokTiB4hwq9iaJhLBTtPF/r0E/UQ3nu21DSIRe9z9+HCuuP
 3gPD5+XdsN6Xk0ZKJYivG+5NlHFSa4utglLilzdyiUGvRy9NQAprx/I/8X+Po0cZgfUxEvGaHmA
 0oW/14sZzvzR0WBb6qAIacHvUF2cKkhXohfFxYPrsiK4zH7oc10HM5pctdsLOogMS47+raE+NqC
 ktzJ4mcOjjaTZtKO+Q3mjb3eRdqXoAXabOVJIRQlugNiUI8PpGIWrfZTKqxiV7yLcXYqqu+MIt7
 eU=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239

Move nmi_watchdog into the watchdog_sysctls array to prevent it from
unnecessary modification. This move effectively moves it inside the
.rodata section.

Initially moved out into its own non-const array in commit 9ec272c586b0
("watchdog/hardlockup: keep kernel.nmi_watchdog sysctl as 0444 if probe
fails"), which made it writable only when watchdog_hardlockup_available
was true. Moving it back to watchdog_sysctl keeps this behavior as
writing to nmi_watchdog still fails when watchdog_hardlockup_available
is false.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
This patch is a followup on the discussion/question I had in [1]. I
would prefer this to be const as it locks things in .rodata and prevents
inadvertent modifications [2].

[1] https://lore.kernel.org/all/588ec9ab-b38a-40b3-8db5-575a09e9a126@meta.com/
[2] https://lore.kernel.org/all/20250109-jag-ctl_table_const-v1-1-622aea7230cf@kernel.org/
---
 kernel/watchdog.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 80b56c002c7f123c49f65465fe7af9c74de4f46a..1e4e3eccb065a5ce95486f24fa07387e8218cd62 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -1213,14 +1213,11 @@ static const struct ctl_table watchdog_sysctls[] = {
 	},
 #endif /* CONFIG_SMP */
 #endif
-};
-
-static struct ctl_table watchdog_hardlockup_sysctl[] = {
 	{
 		.procname       = "nmi_watchdog",
 		.data		= &watchdog_hardlockup_user_enabled,
 		.maxlen		= sizeof(int),
-		.mode		= 0444,
+		.mode		= 0644,
 		.proc_handler   = proc_nmi_watchdog,
 		.extra1		= SYSCTL_ZERO,
 		.extra2		= SYSCTL_ONE,
@@ -1230,10 +1227,6 @@ static struct ctl_table watchdog_hardlockup_sysctl[] = {
 static void __init watchdog_sysctl_init(void)
 {
 	register_sysctl_init("kernel", watchdog_sysctls);
-
-	if (watchdog_hardlockup_available)
-		watchdog_hardlockup_sysctl[0].mode = 0644;
-	register_sysctl_init("kernel", watchdog_hardlockup_sysctl);
 }
 
 #else

---
base-commit: e5f0a698b34ed76002dc5cff3804a61c80233a7a
change-id: 20250929-jag-nmiwd_const-d7423ab25496

Best regards,
-- 
Joel Granados <joel.granados@kernel.org>



