Return-Path: <linux-kernel+bounces-870329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B7AC0A793
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 13:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3DEC64E7933
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 12:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7392DC788;
	Sun, 26 Oct 2025 12:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="HsVf0ULQ"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D682D0635;
	Sun, 26 Oct 2025 12:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761482552; cv=none; b=DHGhvAoLarVwnTBiCdnq8DVPGGCzctUYECbDPcvmsQ1t2Q1ZJKBcJN+xvtXcRJlpP2sb6RGJJUeeAOoKU/N9WSGl8cUwfVFNjB1kx8kaHWQimyPiPWZvQtAGdzV5Uh517LO5bnxDiEzTqHEc24JFrId5GZuLGMNhCpYnvqHMQcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761482552; c=relaxed/simple;
	bh=yyf519215u2MDdtHhsuvS1aHgIQQ/WJ2C5bOX/X38zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qm++xG5mog+SIGyw+Kb2yGbxStQMCrTNbssYaplriCIA9m8jeqt5wx+o4UEbkWoggptthwuAmjIFQyHBQ7UXBbswviVow9PDLCa3OzPgz6n5X7DoucB7qFWeC24sdhd0Exj0p3ovgSslOa3Oq99F4Yxul1IdMxv2Fxu1OG+aVIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=HsVf0ULQ; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=+90988As5O3leaoO212A9P2dJ7//kwlH5PvTRnoE+AY=; t=1761482550;
	x=1761914550; b=HsVf0ULQv3aIaBYOLHIa4TAun6Z2ffZSFGsRWQaiuF1a9yJZczZoEof8EEJDO
	9hNuqeB1KsNdOE1msHA8UDpbK0wNzs+Te40uI2+QYDul6hVeP0F/XMsgMyAxqyalySSoIyXSMIjMG
	R692WIDamDf9RYkiHLPBLtCm7gSPCCxf+FtRHKAJA5puX1nSH1dkVCyI0TVRJFhtCadWtWnKvm5lr
	ONlUEA7Gj7BeqrJYr96+S2YZh3VXIwdZ2AkxvrMVo+P6ouukfzdv6fYcUYcM0Qf3UWZ4y1iTCRFN2
	JVREu9lOdmP4vpOSIn2CQ9CD8AtqI6zy+vpEg+njhLetujVYXQ==;
Received: from [2a02:8108:8984:1d00:a8ad:ebd4:6fc6:160] (helo=luggage.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	id 1vD04k-001mX6-31;
	Sun, 26 Oct 2025 13:42:23 +0100
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Jonathan Corbet <corbet@lwn.net>
Cc: workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 02/30] docs: reporting-issues: tweak the reference section intro
Date: Sun, 26 Oct 2025 13:41:53 +0100
Message-ID: <d94aa32d4a1ed5ef9d0f768d05e64987f4a1ae69.1761481839.git.linux@leemhuis.info>
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
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1761482550;db804c08;
X-HE-SMSGID: 1vD04k-001mX6-31

Small improvements to the intro of the reference section.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 .../admin-guide/reporting-issues.rst          | 67 +++++++++----------
 1 file changed, 31 insertions(+), 36 deletions(-)

diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
index 3bc47afaf85ea0..90b50c27c0d2b6 100644
--- a/Documentation/admin-guide/reporting-issues.rst
+++ b/Documentation/admin-guide/reporting-issues.rst
@@ -244,42 +244,37 @@ The reference section below explains each of these steps in more detail.
 Reference section: Reporting issues to the kernel maintainers
 =============================================================
 
-The detailed guides above outline all the major steps in brief fashion, which
-should be enough for most people. But sometimes there are situations where even
-experienced users might wonder how to actually do one of those steps. That's
-what this section is for, as it will provide a lot more details on each of the
-above steps. Consider this as reference documentation: it's possible to read it
-from top to bottom. But it's mainly meant to skim over and a place to look up
-details how to actually perform those steps.
-
-A few words of general advice before digging into the details:
-
- * The Linux kernel developers are well aware this process is complicated and
-   demands more than other FLOSS projects. We'd love to make it simpler. But
-   that would require work in various places as well as some infrastructure,
-   which would need constant maintenance; nobody has stepped up to do that
-   work, so that's just how things are for now.
-
- * A warranty or support contract with some vendor doesn't entitle you to
-   request fixes from developers in the upstream Linux kernel community: such
-   contracts are completely outside the scope of the Linux kernel, its
-   development community, and this document. That's why you can't demand
-   anything such a contract guarantees in this context, not even if the
-   developer handling the issue works for the vendor in question. If you want
-   to claim your rights, use the vendor's support channel instead. When doing
-   so, you might want to mention you'd like to see the issue fixed in the
-   upstream Linux kernel; motivate them by saying it's the only way to ensure
-   the fix in the end will get incorporated in all Linux distributions.
-
- * If you never reported an issue to a FLOSS project before you should consider
-   reading `How to Report Bugs Effectively
-   <https://www.chiark.greenend.org.uk/~sgtatham/bugs.html>`_, `How To Ask
-   Questions The Smart Way
-   <http://www.catb.org/esr/faqs/smart-questions.html>`_, and `How to ask good
-   questions <https://jvns.ca/blog/good-questions/>`_.
-
-With that off the table, find below the details on how to properly report
-issues to the Linux kernel developers.
+The step-by-step guide above outlines all the major steps in brief fashion,
+which usually covers everything required. But even experienced users will
+sometimes wonder how to actually realize some of those steps or why they are
+needed; there are also corner cases the guide ignores for readability. That is
+what the entries in this reference section are for, which provide additional
+information for each of the steps in the detailed guide.
+
+A few words of general advice:
+
+* The Linux kernel developers are well aware that reporting bugs to them is
+  more complicated and demanding than in other FLOSS projects. Quite a few
+  would love to make it simpler. But that would require convincing a lot of
+  developers to change their habits; it, furthermore, would require improvements
+  on several technical fronts and people that constantly take care of various
+  things. Nobody has stepped up to do or fund that work.
+
+* A warranty or support contract with some vendor doesn't entitle you to
+  request fixes from the upstream Linux developers: Such contracts are
+  completely outside the scope of the upstream Linux kernel, its development
+  community, and this document -- even if those handling the issue work for the
+  vendor who issued the contract. If you want to claim your rights, use the
+  vendor's support channel.
+
+* If you never reported an issue to a FLOSS project before, consider skimming
+  guides like `How to ask good questions
+  <https://jvns.ca/blog/good-questions/>`_, `How To Ask Questions The Smart Way
+  <http://www.catb.org/esr/faqs/smart-questions.html>`_, and `How to Report
+  Bugs Effectively <https://www.chiark.greenend.org.uk/~sgtatham/bugs.html>`_,.
+
+With that off the table, find below details for the steps from the detailed
+guide on reporting issues to the Linux kernel developers.
 
 
 Make sure you're using the upstream Linux kernel
-- 
2.51.0


