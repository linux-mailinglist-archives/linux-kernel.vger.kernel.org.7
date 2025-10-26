Return-Path: <linux-kernel+bounces-870347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F75C0A808
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 13:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C25A6349F9E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 12:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE4B2E7198;
	Sun, 26 Oct 2025 12:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="i8IV4Asz"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFD22DCF58;
	Sun, 26 Oct 2025 12:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761482557; cv=none; b=EqcIKWbS2MXmWOp3gkXBCCifggo8xaR+4gCSObFb38zJY3o49HHo6cclgMRVnYx969N6dYDsuaQM/9+Xrvylimv0CjkDOCWap2t9FiqQB5uCcn9cG7PMfo0t8Ite+jwhy4XoMa1qGt3I65i0prs/AuW+zm0fT9ARZtBZeIgcra0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761482557; c=relaxed/simple;
	bh=SxzqtgXnuHp5B/u8BpLyuGH5vp4zglEON7VaEusma0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VIbgjW7aFLgVa9iEq5t38+9ayAQxtPGySmRfNFJPi35b+MwFq40SiplnnDXAYRVuoS0z6izKPp2vLKrYPT/YrMxRgp6kVvyjM7kA0JXWQ/wT8Onx4iS5I0EjzTXX7tizWfA2lRDV8Rm+4BJ2y4wfC9IsioYVukxwc/51KILSHq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=i8IV4Asz; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=lwoLbJCG/g9rLvqE3zF9jDJz3ge0rUGh/WP0v0I6lRk=; t=1761482554;
	x=1761914554; b=i8IV4AszYNhghC9pEQvV1O/p4hAhEiBbQmLxdBB3/tNyfRodw5AgLMdmQQ55D
	98nk8EGIqPRiZQDaWhY/Z7K05ff0DtHOojgU1B+l7h+XgDzfo/S5mDr8Taxf9c/K5xEmjDtS33Hyo
	0oHUZaADMHsk/a0qEX8Un51ywdhlSRDZSKPDf5uFYYOG72vfiQ2K1DXYlcLm4GX7m3exnWy1Ti61f
	rMaRBTYvZRkNmNsdrlVsoM2Ku+pwXLXKvdKUvLFb7bFs+vgQ56r/i1jtHbaF0LlmCkO3dxUIrVVn6
	HoRiD760wRTS7xWjD0I/GQkQklXsoCiL+Uh4Y1nvBbRk9ylTJg==;
Received: from [2a02:8108:8984:1d00:a8ad:ebd4:6fc6:160] (helo=luggage.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	id 1vD04p-001mXn-1Q;
	Sun, 26 Oct 2025 13:42:27 +0100
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Jonathan Corbet <corbet@lwn.net>
Cc: workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 14/30] docs: reporting-issues: improve text about checking for existing issues
Date: Sun, 26 Oct 2025 13:42:05 +0100
Message-ID: <3f0a8499e8ee3ae168b9328a0cc5890913cd0635.1761481839.git.linux@leemhuis.info>
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
X-HE-SMSGID: 1vD04p-001mXn-1Q

Fine-tune the instructions with regards to checking for existing issues
-- and tell readers straight in the step-by-step guide what to do in
slightly more detail.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 .../admin-guide/reporting-issues.rst          | 166 ++++++++++++------
 1 file changed, 115 insertions(+), 51 deletions(-)

diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
index 439ec52f270167..623feb55caae97 100644
--- a/Documentation/admin-guide/reporting-issues.rst
+++ b/Documentation/admin-guide/reporting-issues.rst
@@ -103,11 +103,31 @@ following the others is usually in your own interest.
 
  [:ref:`details <checkenv_repiref>`]
 
+.. _checkloreone_repisbs:
+
+* Search `lore <https://lore.kernel.org/all/>`_ for similar reports and
+  potential fixes; afterwards the wider internet, too.
+
+  If you find a matching report, check it carefully:
+
+  * If it is less than a month old and without a single doubt about the same
+    issue, consider replying to tell involved people that you are affected as
+    well.
+
+  * If it just looks quite a lot like the same issue, send a reply briefly
+    describing your problem and ask if it might be the same issue; if you do
+    receive a negative reply or none at all, report the problem anew separately.
+
+  * In all other cases, prepare a separate report by following this guide
+    further and linking to any possibly related reports in yours.
+
+ When you find fixes, consider trying them. If they work and are not yet
+ committed, write a short reply to let the developers know. If they don't work
+ while fixing the issue for other people, you most likely face a different
+ problem you have to report independently while linking to the earlier report.
+
+ [:ref:`details <checkloreone_repiref>`]
 
- * Perform a rough search for existing reports with your favorite internet
-   search engine; additionally, check the archives of the `Linux Kernel Mailing
-   List (LKML) <https://lore.kernel.org/lkml/>`_. If you find matching reports,
-   join the discussion instead of sending a new one.
 
  * See if the issue you are dealing with qualifies as regression, security
    issue, or a really severe problem: those are 'issues of high priority' that
@@ -534,53 +554,97 @@ out a few common causes before wasting time on a meaningless bug report:
 [:ref:`back to step-by-step guide <checkenv_repisbs>`]
 
 
-Search for existing reports, first run
---------------------------------------
-
-   *Perform a rough search for existing reports with your favorite internet
-   search engine; additionally, check the archives of the Linux Kernel Mailing
-   List (LKML). If you find matching reports, join the discussion instead of
-   sending a new one.*
-
-Reporting an issue that someone else already brought forward is often a waste of
-time for everyone involved, especially you as the reporter. So it's in your own
-interest to thoroughly check if somebody reported the issue already. At this
-step of the process it's okay to just perform a rough search: a later step will
-tell you to perform a more detailed search once you know where your issue needs
-to be reported to. Nevertheless, do not hurry with this step of the reporting
-process, it can save you time and trouble.
-
-Simply search the internet with your favorite search engine first. Afterwards,
-search the `Linux Kernel Mailing List (LKML) archives
-<https://lore.kernel.org/lkml/>`_.
-
-If you get flooded with results consider telling your search engine to limit
-search timeframe to the past month or year. And wherever you search, make sure
-to use good search terms; vary them a few times, too. While doing so try to
-look at the issue from the perspective of someone else: that will help you to
-come up with other words to use as search terms. Also make sure not to use too
-many search terms at once. Remember to search with and without information like
-the name of the kernel driver or the name of the affected hardware component.
-But its exact brand name (say 'ASUS Red Devil Radeon RX 5700 XT Gaming OC')
-often is not much helpful, as it is too specific. Instead try search terms like
-the model line (Radeon 5700 or Radeon 5000) and the code name of the main chip
-('Navi' or 'Navi10') with and without its manufacturer ('AMD').
-
-In case you find an existing report about your issue, join the discussion, as
-you might be able to provide valuable additional information. That can be
-important even when a fix is prepared or in its final stages already, as
-developers might look for people that can provide additional information or
-test a proposed fix. Jump to the section 'Duties after the report went out' for
-details on how to get properly involved.
-
-Note, searching `bugzilla.kernel.org <https://bugzilla.kernel.org/>`_ might also
-be a good idea, as that might provide valuable insights or turn up matching
-reports. If you find the latter, just keep in mind: most subsystems expect
-reports in different places, as described below in the section "Check where you
-need to report your issue". The developers that should take care of the issue
-thus might not even be aware of the bugzilla ticket. Hence, check the ticket if
-the issue already got reported as outlined in this document and if not consider
-doing so.
+.. _checkloreone_repiref:
+
+Search for existing reports and fixes
+-------------------------------------
+
+  *Search lore.kernel.org for similar reports and potential fixes; afterwards
+  the wider internet, too.*  [:ref:`... <checkloreone_repisbs>`]
+
+You don't want to waste your time reporting an issue anew someone already
+brought forward or resolved already. So it is in your own interest to check for
+existing reports and fixes.
+
+Searching for fixes and existing reports
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+If your search on `lore <https://lore.kernel.org/all/>`_ and the web results in
+a flood of results, consider limiting the search timeframe. In lore you can do
+so by adding something like 'rt:3.months.ago..' or 'rt:1.years.ago..' to your
+query.
+
+Wherever you search, make sure to use good terms; vary them a few times, too.
+
+Start with something specific and become broader if there are no or too few
+results. Also try to look at the issue from the perspective of someone else:
+that might help you to come up with other terms to use in your search.
+
+Remember to search with and without information like the name of the kernel
+driver or the name of the affected hardware component. But its exact brand name
+(say, 'ASUS Red Devil Radeon RX 5700 XT Gaming OC') often is way too specific;
+instead, try search terms like the model line ('Radeon 5700' or 'Radeon 5000')
+and the code name of the main chip ('Navi' or 'Navi10') with and without the
+manufacturer of the main chip's name ('AMD') or the product's series
+('Radeon').
+
+Try fixes and evaluate matching reports closely
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+If you find a potential fix, give it a try; if it is still under discussion and
+helps, let the developers know through a short reply.
+
+You found matching reports or a fix that does not help? Then evaluate them
+closely, as they might be about a different issue with similar symptoms. Your
+next steps depend on the outcome:
+
+* Is the report or fix still discussed and without any doubt about an issue like
+  yours? Then join the exchange, as you might be able to provide valuable
+  additional information or test results.
+
+* If the report or fix seems to be about a different issue, ignore it and
+  proceed with this guide, but briefly mention and link the earlier report or
+  fix in your report later. After reporting, it might also be wise to send a
+  short reply to the earlier report with a text along the lines of 'To whom it
+  may concern, I ran into a similar, but from my understanding slightly
+  different problem', coupled with a link to the report.
+
+* When unsure if it is the same or a different problem, send a short reply to
+  the earlier report or fix; in it, very briefly outline the problem while
+  asking if that seems to be the same problem or a different one better
+  reported separately.
+
+While doing so, keep in mind:
+
+* Chaos and confusion easily ensue when an issue is reported in a bug tracker
+  ticket or mailing list thread that looks related, but, in fact, is about a
+  different issue. Try hard to avoid such an outcome, as then it can quickly
+  happen that none of the problems will be addressed in the end. The best
+  strategy to avoid that: Whenever there is a slight chance that your issue
+  might be different, report it in a new ticket or thread, but mention the
+  earlier reports you found; afterwards send a short reply to the earlier
+  ticket/thread with a text along the lines of 'I have a similar problem which
+  might or might not be related' coupled with a link to your report.
+
+* Never report an issue in a bug tracker ticket or a mailing list thread that
+  looks related, but is considered resolved. Always report in a new thread
+  instead; afterwards send a short reply to the earlier ticket/thread with a
+  text along the lines of 'I have a similar problem which might or might not be
+  related' coupled with a link to your report.
+
+* When spotting matching reports on `bugzilla.kernel.org
+  <https://bugzilla.kernel.org/>`_, keep in mind that the appropriate
+  developers to handle the issue might not even be aware of the report. That is
+  because Bugzilla might not have forwarded the report to them: It lacks the
+  necessary information to do so for many of the kernel's subsystems, as their
+  developers expect reports in different places -- ':ref:`Check how to report
+  your issue <maintainers_repiref>`' describes this in more detail. If in
+  doubt, add a comment to the Bugzilla report; if no reassuring answer is
+  forthcoming, report the issue briefly through the proper channel while
+  mentioning the Bugzilla report; afterwards add a comment to the latter
+  pointing to your report.
+
+[:ref:`back to step-by-step guide <checkloreone_repisbs>`]
 
 
 Issue of high priority?
-- 
2.51.0


