Return-Path: <linux-kernel+bounces-870353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A97C0A832
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 13:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C515E3B276C
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 12:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57BD32E8B7D;
	Sun, 26 Oct 2025 12:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="AehCcECH"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231252DCF50;
	Sun, 26 Oct 2025 12:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761482559; cv=none; b=LsYCS4FtXFWPpHwIJj55sgPrb24vx6TfqDRpR175c+UVLLU5cilZ9y1rOCVcsilJsYLvtLrY4+VSorBs/8xHLZtLIDbG1j3A5j18kP66uDZRC5Akw40OH62jMe9VrDTArn7yExggy6XKwZEaUWeDCW//Rr2++Em2cdcMwXryAEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761482559; c=relaxed/simple;
	bh=YPmz9plxeC1YEcFAWI17S4yEgIf+VNJKzQ5SC6730bM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hIRzn0ar26uKSoN+2uaWzhubYfF2t4toJJO3cqKvyL0Ds3UoRiC43rSMsxQm+G0eOPFrByabsb8SL7tGuCMPQMGEX/9LRwm/1LXl68BXmfQTZYNFuYzM2F7v+WT67iZN6b39yJ2jWIue3hVCHRw5MO5IPXDgxbEBqhjqvruOkcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=AehCcECH; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=Xl7EbKxVssEXZJh8Rfnajk+ePVuHpmu9Mxi6gIB7sbs=; t=1761482554;
	x=1761914554; b=AehCcECHHGj7CGEj59Ae1dQLU2Ijx4/jffdmjsx/fPw+ERI4S5ZNiN8GhIVST
	pc6igRHKLLyD7czlsoeUucTe0AVXumx928Zb5prlvHi4APx+jDAhwQ8d+egcZbPFSOWSiU44sy0Yo
	me4LsdTq+uDBuPQHRpI1ks3iJ3hSkaQeF1Z4gL5P8N+gKRZTgUHC5t8jWppxDM1mI3PQSfpiPv1zP
	BGGwmVMSbGZCJovVRuz3/36JBB0vBOeuv2RjwtyovzjtfGqDALItZNV6DJYiktI5REWAbnoWGLY0m
	kwA02lDXOSwXMwHXJe0le7uIufLl5yvRRGEPyFSVIRZsVMG6hw==;
Received: from [2a02:8108:8984:1d00:a8ad:ebd4:6fc6:160] (helo=luggage.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	id 1vD04u-001mZC-06;
	Sun, 26 Oct 2025 13:42:32 +0100
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Jonathan Corbet <corbet@lwn.net>
Cc: workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 25/30] docs: reporting-issues: improve text on non-regressions in stable
Date: Sun, 26 Oct 2025 13:42:16 +0100
Message-ID: <0a3548a6b5d8ca87c9d81838d84afeb619a6985e.1761481839.git.linux@leemhuis.info>
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
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1761482554;2f8dc1da;
X-HE-SMSGID: 1vD04u-001mZC-06

Fine-tune the instructions about handling non-regressions only occurring
in stable or longterm kernels. This removes the accompanying text in the
reference section to shorten things somewhat: this case is rare and the
instructions in the step-by-step guide cover all the important bits now.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 .../admin-guide/reporting-issues.rst          | 129 ++----------------
 1 file changed, 9 insertions(+), 120 deletions(-)

diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
index 9611514d10414e..a78060098c59f0 100644
--- a/Documentation/admin-guide/reporting-issues.rst
+++ b/Documentation/admin-guide/reporting-issues.rst
@@ -299,29 +299,29 @@ supported stable or longterm series that (b) you were unable to reproduce in
 the current mainline and (c) is not a regression. If all of that holds true,
 follow these steps:
 
-* Be aware: it is possible the issue will not be resolved, as the fix might be
+* Be aware: It is possible the issue will not be resolved, as the fix might be
   too big or risky to backport.
 
-* Search Linux' mainline Git repository or `lore
+* Search Linux's mainline Git repository or `lore
   <https://lore.kernel.org/all/>`_ for the change resolving the issue. In case
-  you have trouble locating it, consider using a bisection; alternatively ask
+  you have trouble locating it, consider using a bisection; alternatively, ask
   on the list of the affected subsystem for advice while CCing the relevant
   maintainers and developers.
 
 * Check if the change is already scheduled to be backported by searching the
-  patch description for a 'stable tag' (a line like 'Cc:
-  <stable@vger.kernel.org>' and the patch's title in lore.kernel.org:
+  patch description for a 'stable tag' (e.g., a line like 'Cc:
+  <stable@vger.kernel.org>') and the patch's title in lore.kernel.org:
 
-  * If the change is already scheduled for backporting, it usually will be
-    picked up within one or two weeks after being mainlined. Note though, plans
+  * If the change is already scheduled for backporting, it will usually be
+    picked up within one or two weeks after being mainlined. Note, though, plans
     sometimes change; a comment next to the stable tag might also limit how far
     the fix is backported and thus exclude the series you care about. If there
     are good reasons for this, you are out of luck. If you can't spot any:
 
     Send a reply asking the involved developers if backporting to the series is
-    an option. Note though, the developers might greenlight backporting, but
+    an option. Note, though, the developers might greenlight backporting, but
     unwilling to handle the work themselves -- in which case you or somebody
-    else must test and submit the fix and everything it depends on as explained
+    else must test and submit the fix and everything it depends on, as explained
     in Documentation/process/stable-kernel-rules.rst.
 
   * If the change is not scheduled for backporting, search `lore
@@ -1457,117 +1457,6 @@ easier. And with a bit of luck there might be someone in the team that knows a
 bit about programming and might be able to write a fix.
 
 
-Reference for "Reporting issues only occurring in older kernel version lines"
------------------------------------------------------------------------------
-
-This section provides details for the steps you need to take if you could not
-reproduce your issue with a mainline kernel, but want to see it fixed in older
-version lines (aka stable and longterm kernels).
-
-Some fixes are too complex
-~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-    *Prepare yourself for the possibility that going through the next few steps
-    might not get the issue solved in older releases: the fix might be too big
-    or risky to get backported there.*
-
-Even small and seemingly obvious code-changes sometimes introduce new and
-totally unexpected problems. The maintainers of the stable and longterm kernels
-are very aware of that and thus only apply changes to these kernels that are
-within rules outlined in Documentation/process/stable-kernel-rules.rst.
-
-Complex or risky changes for example do not qualify and thus only get applied
-to mainline. Other fixes are easy to get backported to the newest stable and
-longterm kernels, but too risky to integrate into older ones. So be aware the
-fix you are hoping for might be one of those that won't be backported to the
-version line your care about. In that case you'll have no other choice then to
-live with the issue or switch to a newer Linux version, unless you want to
-patch the fix into your kernels yourself.
-
-Common preparations
-~~~~~~~~~~~~~~~~~~~
-
-    *Perform the first three steps in the section "Reporting issues only
-    occurring in older kernel version lines" above.*
-
-You need to carry out a few steps already described in another section of this
-guide. Those steps will let you:
-
- * Check if the kernel developers still maintain the Linux kernel version line
-   you care about.
-
- * Search the Linux stable mailing list for exiting reports.
-
- * Check with the latest release.
-
-
-Check code history and search for existing discussions
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-
-    *Search the Linux kernel version control system for the change that fixed
-    the issue in mainline, as its commit message might tell you if the fix is
-    scheduled for backporting already. If you don't find anything that way,
-    search the appropriate mailing lists for posts that discuss such an issue
-    or peer-review possible fixes; then check the discussions if the fix was
-    deemed unsuitable for backporting. If backporting was not considered at
-    all, join the newest discussion, asking if it's in the cards.*
-
-In a lot of cases the issue you deal with will have happened with mainline, but
-got fixed there. The commit that fixed it would need to get backported as well
-to get the issue solved. That's why you want to search for it or any
-discussions abound it.
-
- * First try to find the fix in the Git repository that holds the Linux kernel
-   sources. You can do this with the web interfaces `on kernel.org
-   <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/>`_
-   or its mirror `on GitHub <https://github.com/torvalds/linux>`_; if you have
-   a local clone you alternatively can search on the command line with ``git
-   log --grep=<pattern>``.
-
-   If you find the fix, look if the commit message near the end contains a
-   'stable tag' that looks like this:
-
-          Cc: <stable@vger.kernel.org> # 5.4+
-
-   If that's case the developer marked the fix safe for backporting to version
-   line 5.4 and later. Most of the time it's getting applied there within two
-   weeks, but sometimes it takes a bit longer.
-
- * If the commit doesn't tell you anything or if you can't find the fix, look
-   again for discussions about the issue. Search the net with your favorite
-   internet search engine as well as the archives for the `Linux kernel
-   developers mailing list <https://lore.kernel.org/lkml/>`_. Also read the
-   section `Locate kernel area that causes the issue` above and follow the
-   instructions to find the subsystem in question: its bug tracker or mailing
-   list archive might have the answer you are looking for.
-
- * If you see a proposed fix, search for it in the version control system as
-   outlined above, as the commit might tell you if a backport can be expected.
-
-   * Check the discussions for any indicators the fix might be too risky to get
-     backported to the version line you care about. If that's the case you have
-     to live with the issue or switch to the kernel version line where the fix
-     got applied.
-
-   * If the fix doesn't contain a stable tag and backporting was not discussed,
-     join the discussion: mention the version where you face the issue and that
-     you would like to see it fixed, if suitable.
-
-
-Ask for advice
-~~~~~~~~~~~~~~
-
-    *One of the former steps should lead to a solution. If that doesn't work
-    out, ask the maintainers for the subsystem that seems to be causing the
-    issue for advice; CC the mailing list for the particular subsystem as well
-    as the stable mailing list.*
-
-If the previous three steps didn't get you closer to a solution there is only
-one option left: ask for advice. Do that in a mail you sent to the maintainers
-for the subsystem where the issue seems to have its roots; CC the mailing list
-for the subsystem as well as the stable mailing list (stable@vger.kernel.org).
-
-
 Appendix: additional background information
 ===========================================
 
-- 
2.51.0


