Return-Path: <linux-kernel+bounces-870331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6676C0A79D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 13:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7714D18A01E1
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 12:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1742DCF52;
	Sun, 26 Oct 2025 12:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="1q8fE0lt"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0979D2D7DF1;
	Sun, 26 Oct 2025 12:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761482553; cv=none; b=b390zb8++lncefXHZ0IrpP04jiUg9EJwn4XI0DOR94lFslUqMZRN34tzCtzv0DeeKzxNp1BRbox8FoeGzfhcH42c7wjtbdprU0dixIuvbTYY8DgCFzaComLaXJ80BFzb7t4oT8hLAKcKsNZGF7teLsM7Znvt8JFqRcVUbh83lu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761482553; c=relaxed/simple;
	bh=zdHVVuWMdLD/IA0oLUCz2dfrOnOXQo2D2OWsrWMT4AI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FNByPIqNKBIBHEa6x3guZRE2LvSTmgBZYwWVgjkYPP4GKNTuopWXaWbqq0P53jU5sR8ojP4Br1lBsloALE5Ld0JMZy3ibwlYu+iX9GVGAek8BcUS2ul1TXqXGL9VTwib/PiC4AlPGQr4A/Zf4UwzoScUxXUH7sX4F6LVPdT2Ttc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=1q8fE0lt; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=fHLnuG6RM3Qg3mrCT9HfBteDN/mL5635GCoRcQ8os+0=; t=1761482551;
	x=1761914551; b=1q8fE0ltuE1TrfIzW9wIfGzR3W6ADY1DQUrFTyNNy34vcBbfNZMEIOOoCwW2A
	qxZVtHXmnFOpPmj9V0FysKwu1sEYgyDD1Smy+v9UNis89z0Hy/bHy7tTPcK4FtHKN0MHy+6pyh4jD
	SN8Sz3m7HJDP+KojWsxdxDtxFBFqQd/S0IvXTsoYCVcgc4SKExVLXIITx0ziWQlAxHw1fQ0sWcTbj
	t8lXLyFUchQ8OlNMsdP7jG4Roj/ixrFg+uOF9izFDqwVQGgq2orPxBf+wJ5rMCvREWnXJ9HcDYUkM
	xG9TyNkSLoKm0HYTQTU9Ts+B5UNisZETsEdWBq4eW+WLNgINaQ==;
Received: from [2a02:8108:8984:1d00:a8ad:ebd4:6fc6:160] (helo=luggage.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	id 1vD04r-001mYF-0z;
	Sun, 26 Oct 2025 13:42:29 +0100
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Jonathan Corbet <corbet@lwn.net>
Cc: workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 19/30] docs: reporting-issues: move text on 'check other places' upwards
Date: Sun, 26 Oct 2025 13:42:10 +0100
Message-ID: <ca584bfed5e0e1eb724d432a0d70c070ea608420.1761481839.git.linux@leemhuis.info>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1761481839.git.linux@leemhuis.info>
References: <cover.1761481839.git.linux@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1761482551;009d26c6;
X-HE-SMSGID: 1vD04r-001mYF-0z

Move text around to improve diffability of a follow-up patch.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 .../admin-guide/reporting-issues.rst          | 82 +++++++++----------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
index 56e004ba038403..baee1da327d116 100644
--- a/Documentation/admin-guide/reporting-issues.rst
+++ b/Documentation/admin-guide/reporting-issues.rst
@@ -157,6 +157,10 @@ following the others is usually in your own interest.
 
  [:ref:`details <maintainers_repiref>`]
 
+ * Search the archives of the bug tracker or mailing list in question
+   thoroughly for reports that might match your issue. If you find anything,
+   join the discussion instead of sending a new report.
+
  * Create a fresh backup and put system repair and restore tools at hand.
 
  * Ensure your system does not enhance its kernels by building additional
@@ -169,10 +173,6 @@ following the others is usually in your own interest.
    (say something broke when updating from 5.10.4 to 5.10.5), scroll down to
    'Dealing with regressions within a stable and longterm kernel line'.
 
- * Search the archives of the bug tracker or mailing list in question
-   thoroughly for reports that might match your issue. If you find anything,
-   join the discussion instead of sending a new report.
-
 After these preparations you'll now enter the main part:
 
  * Unless you are already running the latest 'mainline' Linux kernel, better
@@ -851,6 +851,43 @@ about the particular driver at all.
 [:ref:`back to step-by-step guide <maintainers_repisbs>`]
 
 
+Search for existing reports, second run
+---------------------------------------
+
+    *Search the archives of the bug tracker or mailing list in question
+    thoroughly for reports that might match your issue. If you find anything,
+    join the discussion instead of sending a new report.*
+
+As mentioned earlier already: reporting an issue that someone else already
+brought forward is often a waste of time for everyone involved, especially you
+as the reporter. That's why you should search for existing report again, now
+that you know where they need to be reported to. If it's mailing list, you will
+often find its archives on `lore.kernel.org <https://lore.kernel.org/>`_.
+
+But some list are hosted in different places. That for example is the case for
+the ath10k WiFi driver used as example in the previous step. But you'll often
+find the archives for these lists easily on the net. Searching for 'archive
+ath10k@lists.infradead.org' for example will lead you to the `Info page for the
+ath10k mailing list <https://lists.infradead.org/mailman/listinfo/ath10k>`_,
+which at the top links to its
+`list archives <https://lists.infradead.org/pipermail/ath10k/>`_. Sadly this and
+quite a few other lists miss a way to search the archives. In those cases use a
+regular internet search engine and add something like
+'site:lists.infradead.org/pipermail/ath10k/' to your search terms, which limits
+the results to the archives at that URL.
+
+It's also wise to check the internet, LKML and maybe bugzilla.kernel.org again
+at this point. If your report needs to be filed in a bug tracker, you may want
+to check the mailing list archives for the subsystem as well, as someone might
+have reported it only there.
+
+For details how to search and what to do if you find matching reports see
+"Search for existing reports, first run" above.
+
+Do not hurry with this step of the reporting process: spending 30 to 60 minutes
+or even more time can save you and others quite a lot of time and trouble.
+
+
 Prepare for emergencies
 -----------------------
 
@@ -918,43 +955,6 @@ regressions with newer kernel version line (say something broke when switching
 from 5.9.15 to 5.10.5) do not qualify.
 
 
-Search for existing reports, second run
----------------------------------------
-
-    *Search the archives of the bug tracker or mailing list in question
-    thoroughly for reports that might match your issue. If you find anything,
-    join the discussion instead of sending a new report.*
-
-As mentioned earlier already: reporting an issue that someone else already
-brought forward is often a waste of time for everyone involved, especially you
-as the reporter. That's why you should search for existing report again, now
-that you know where they need to be reported to. If it's mailing list, you will
-often find its archives on `lore.kernel.org <https://lore.kernel.org/>`_.
-
-But some list are hosted in different places. That for example is the case for
-the ath10k WiFi driver used as example in the previous step. But you'll often
-find the archives for these lists easily on the net. Searching for 'archive
-ath10k@lists.infradead.org' for example will lead you to the `Info page for the
-ath10k mailing list <https://lists.infradead.org/mailman/listinfo/ath10k>`_,
-which at the top links to its
-`list archives <https://lists.infradead.org/pipermail/ath10k/>`_. Sadly this and
-quite a few other lists miss a way to search the archives. In those cases use a
-regular internet search engine and add something like
-'site:lists.infradead.org/pipermail/ath10k/' to your search terms, which limits
-the results to the archives at that URL.
-
-It's also wise to check the internet, LKML and maybe bugzilla.kernel.org again
-at this point. If your report needs to be filed in a bug tracker, you may want
-to check the mailing list archives for the subsystem as well, as someone might
-have reported it only there.
-
-For details how to search and what to do if you find matching reports see
-"Search for existing reports, first run" above.
-
-Do not hurry with this step of the reporting process: spending 30 to 60 minutes
-or even more time can save you and others quite a lot of time and trouble.
-
-
 Install a fresh kernel for testing
 ----------------------------------
 
-- 
2.51.0


