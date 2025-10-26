Return-Path: <linux-kernel+bounces-870334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B9FC0A7D2
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 13:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A20B518A0F0E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 12:44:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7A22E0924;
	Sun, 26 Oct 2025 12:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="kg8udvqb"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820392D7DFF;
	Sun, 26 Oct 2025 12:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761482553; cv=none; b=UpY2YN11yVaBilMjdCMiZtPtxvynybXVmgm77AAmGjGq6KNaDsEkkGPjN2NJz//OQeTW7xVbge3dyMoXDK39zIDf9QhvbELwGSO7qN3ZCfUw7qHeoYCWrJJHYFM6ccncJz7x5ajMeoP4HvSE+sYiyLhfOkQPPQmu7PpArDTTiag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761482553; c=relaxed/simple;
	bh=Jhphcb2eOJvYE4YvsIZauiMAEtvFpkvShA2BIkzuVJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UAs9nIWVLc5Khsi0UNxNpyIgSBc+tvjhSdv2OPxhX1f4XRdnCYrI0/a62JPwq+qya8SLAM6aO65OChtmQV51X8J++7I3Dw2nqWtTVfll64/ORZmXAs4duqQMMFkkvWWrLGlrKSLHy8eOJfiHS27o4LJFvRB5agqEDLj9RSooYJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=kg8udvqb; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=lPjt0MqJvH6hs507jG7OGwNx1ZlrR2+68vhiSR2b17I=; t=1761482551;
	x=1761914551; b=kg8udvqb6gkbHUAi0XOrwvWSuBokh3Ml3IDuq0j5XXWfr0XoaKgEBImZAPjfY
	NgtSndcxjbS4zLOAyybriYX2qnG9zwSThnubIwgsOBF2Im0tx3CUdCgWL9wON1fdfZyCi9HSl/HPt
	N3MDouQCIUo5utVRZt30lR+LBRRQI8L8FYQPY0Lnxa3JCR7kpRabUMJjdTXKLsY6nrwER2/+Ek4Pv
	T//9jNaofNA01o5oYcRMhuNZ6xbi35j2l+leJ7Oglyol3IqOBis3YF0kBfMVdzbCoXkN9nfM0DUbI
	fhakJaeG5SqLJZHYIkjveeEWF/2BdGY4nNus7hmMWrA+mj9+Sg==;
Received: from [2a02:8108:8984:1d00:a8ad:ebd4:6fc6:160] (helo=luggage.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	id 1vD04r-001mYe-2u;
	Sun, 26 Oct 2025 13:42:29 +0100
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Jonathan Corbet <corbet@lwn.net>
Cc: workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 20/30] docs: reporting-issues: improve text on check other places
Date: Sun, 26 Oct 2025 13:42:11 +0100
Message-ID: <1a654e35cf72a349b5882b010ac9ad5f34830f9a.1761481839.git.linux@leemhuis.info>
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
X-HE-SMSGID: 1vD04r-001mYe-2u

Fine-tune the instructions about checking other places for existing
reports.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 .../admin-guide/reporting-issues.rst          | 72 +++++++++++--------
 1 file changed, 44 insertions(+), 28 deletions(-)

diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
index baee1da327d116..c34a95d5af4ac6 100644
--- a/Documentation/admin-guide/reporting-issues.rst
+++ b/Documentation/admin-guide/reporting-issues.rst
@@ -157,9 +157,24 @@ following the others is usually in your own interest.
 
  [:ref:`details <maintainers_repiref>`]
 
- * Search the archives of the bug tracker or mailing list in question
-   thoroughly for reports that might match your issue. If you find anything,
-   join the discussion instead of sending a new report.
+.. _otherplaces_repisbs:
+
+* If the developers of the affected driver or subsystem use a dedicated mailing
+  list not `archived on lore <https://lore.kernel.org/>`_, search its archives
+  for earlier reports and potential fixes; if the subsystem is among the few
+  using one of various bug trackers, search it as well.
+
+  Checking `bugzilla.kernel.org <https://bugzilla.kernel.org/>`_ might be worth
+  a shot, too. But keep in mind that for most of the kernel it is the wrong
+  place to submit bug reports: Many Linux developers do not care about the bug
+  tracker and are not even notified about bugs in their code submitted there.
+
+  If you find matching reports or fixes in either place, follow the instructions
+  provided earlier. In the case of Bugzilla, check if the appropriate developers
+  noticed the ticket -- and if not, consider sending an email to the responsible
+  people and lists pointing them to it.
+
+ [:ref:`details <otherplaces_repiref>`]
 
  * Create a fresh backup and put system repair and restore tools at hand.
 
@@ -851,41 +866,42 @@ about the particular driver at all.
 [:ref:`back to step-by-step guide <maintainers_repisbs>`]
 
 
-Search for existing reports, second run
----------------------------------------
+.. _otherplaces_repiref:
 
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
+Search for existing reports in other places
+-------------------------------------------
+
+  *If the developers of the affected driver or subsystem use a dedicated
+  mailing list not archived on lore, search its archives for earlier reports
+  and potential fixes; if the subsystem is* [:ref:`... <otherplaces_repisbs>`]
+
+Now that you know where they need to be reported to, search the target for
+existing reports again. If it is a mailing list, you will often find its
+archives on `lore <https://lore.kernel.org/all/>`_.
+
+But some lists are hosted in different places. That, for example, is the case
+for the ath10k WiFi driver used as an example in the previous step. But you'll
+often find the archives for these lists easily on the net. Searching for
+'archive ath10k@lists.infradead.org', for example, will lead you to the `Info
+page for the ath10k mailing list <https://lists.infradead.org/mailman/listinfo/ath10k>`_,
+which at the top links to its `list archives <https://lists.infradead.org/pipermail/ath10k/>`_.
+Sadly, this and quite a few other lists miss a way to search the archives. In
+those cases, use a regular internet search engine and add something like
 'site:lists.infradead.org/pipermail/ath10k/' to your search terms, which limits
 the results to the archives at that URL.
 
-It's also wise to check the internet, LKML and maybe bugzilla.kernel.org again
+It is also wise to check the internet, LKML and maybe bugzilla.kernel.org again
 at this point. If your report needs to be filed in a bug tracker, you may want
 to check the mailing list archives for the subsystem as well, as someone might
 have reported it only there.
 
-For details how to search and what to do if you find matching reports see
-"Search for existing reports, first run" above.
+For details on how to search and what to do if you find matching reports, see
+':ref:`Search for existing reports and fixes <checkloreone_repiref>`' above.
 
 Do not hurry with this step of the reporting process: spending 30 to 60 minutes
-or even more time can save you and others quite a lot of time and trouble.
+or even more time can save everyone, including you, quite some trouble.
+
+[:ref:`back to step-by-step guide <otherplaces_repisbs>`]
 
 
 Prepare for emergencies
-- 
2.51.0


