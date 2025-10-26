Return-Path: <linux-kernel+bounces-870344-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 622DCC0A805
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 13:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4314E34998E
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 12:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FAC2E6CDA;
	Sun, 26 Oct 2025 12:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="MKfz35Jr"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22F212DCF4E;
	Sun, 26 Oct 2025 12:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761482556; cv=none; b=l0HlwR9AIEdJGLabnjbagR1sTvo5yao9CV4QblNfF7YFA1vWUSzNIy76/QFJWhkkySPzv3mq42gTj4EVFZkS4NJ+pKMbeYs31tBRnpSifPDN+p6Uv4k34sjjVHLnVwe112ThuH62ctC9teHons7IczJi94gbRy2jQ4Ukueefy+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761482556; c=relaxed/simple;
	bh=ftrjxyR5SRqa7HLu+jbXUUvmYzdPS+hzpbZq2tjBS6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fJqVgF4oKOkwIu/oLad/e+njSH220qKDlnHeQRFvtvh6RgVrlNobnzrcP/Uk0DU49j1ZCgmRIETEnt3uaaTh7zSo6HcrJjje+JLBPuVAsHugvsazVk3x+Qdj1llRWpMWuZbQoD05lUPYMP+M0NEz8hWkNukYz1wmCg6DD2ttDBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=MKfz35Jr; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=qAm9hVLNKsdEv5v/8w3e/Zz2emv2ug/0HzuP0mkDOgU=; t=1761482554;
	x=1761914554; b=MKfz35Jr5C3OPvJRA7/z/rg2go32cBGeXv08ZjWCXSmLvoYgLBOBttuNr/Oc8
	GQQOoM+qSprEp1VZhqfw4wfo45B1zOdhSwaYAc4O3dbaOmEL1V/TkkHc0cU5qhORAaOxCy6m9U7Yx
	gEPFQj/xHs/RsEJdpwNSynAcrImw+//JcBoTO7gmw0b5QzQ/xYu56mJxzazZfP8KpNdBe8vEEv1Tt
	gM+/sdTL4tJ13nAVmQtpH6Ez0M6gS8CPDvEmyZU7hdk+numn2BQjxzrmoBn9xj73cTv3xzcK4/aLP
	QekhJ73K5T7qRr4/XCZRNGbiaWpLW0yj2bkpsW3GRa36icInTQ==;
Received: from [2a02:8108:8984:1d00:a8ad:ebd4:6fc6:160] (helo=luggage.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	id 1vD04u-001mZC-1A;
	Sun, 26 Oct 2025 13:42:32 +0100
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Jonathan Corbet <corbet@lwn.net>
Cc: workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 26/30] docs: reporting-issues: improve text on second search
Date: Sun, 26 Oct 2025 13:42:17 +0100
Message-ID: <91a969bd0db253f59f579ec3a080404029756d3b.1761481839.git.linux@leemhuis.info>
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
X-HE-SMSGID: 1vD04u-001mZC-1A

Fine-tune the instructions about searching lore again while dropping the
text on optimizing the write-up how to reproduce the issue: this is left
to a later step now.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 .../admin-guide/reporting-issues.rst          | 38 ++++++++++---------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
index a78060098c59f0..aad98ccb49add8 100644
--- a/Documentation/admin-guide/reporting-issues.rst
+++ b/Documentation/admin-guide/reporting-issues.rst
@@ -257,11 +257,17 @@ following the others is usually in your own interest.
 
  [:ref:`details <verify_repiref>`]
 
- * Optimize your notes: try to find and write the most straightforward way to
-   reproduce your issue. Make sure the end result has all the important
-   details, and at the same time is easy to read and understand for others
-   that hear about it for the first time. And if you learned something in this
-   process, consider searching again for existing reports about the issue.
+.. _checkloretwo_repisbs:
+
+* If you performed a bisection or learned anything new about the bug while
+  following this guide so far, search once more for earlier reports
+  and fixes. In the bisection case, you want to search
+  `lore <https://lore.kernel.org/all/>`_   for the culprit's mainline commit-id
+  abbreviated to seven characters immediately followed by an asterisk (e.g.,
+  '`1f2e3d4 <https://lore.kernel.org/all/?q=1f2e3d4*>`_'); if that does not
+  produce any valuable insights, search for the commit's title, too.
+
+ [:ref:`details <checkloretwo_repiref>`]
 
  * If your failure involves a 'panic', 'Oops', 'warning', or 'BUG', consider
    decoding the kernel log to find the line of code that triggered the error.
@@ -988,23 +994,19 @@ more detailed instructions, follow Documentation/admin-guide/verify-bugs-and-bis
 [:ref:`back to step-by-step guide <verify_repisbs>`]
 
 
-Optimize description to reproduce issue
----------------------------------------
+.. _checkloretwo_repiref:
 
-    *Optimize your notes: try to find and write the most straightforward way to
-    reproduce your issue. Make sure the end result has all the important
-    details, and at the same time is easy to read and understand for others
-    that hear about it for the first time. And if you learned something in this
-    process, consider searching again for existing reports about the issue.*
+Search again
+------------
 
-An unnecessarily complex report will make it hard for others to understand your
-report. Thus try to find a reproducer that's straight forward to describe and
-thus easy to understand in written form. Include all important details, but at
-the same time try to keep it as short as possible.
+  *If you performed a bisection or learned anything new about the bug
+  while following this guide so far, search once more* [:ref:`... <checkloretwo_repisbs>`]
 
-In this in the previous steps you likely have learned a thing or two about the
+During the previous step you likely have learned a thing or two about the
 issue you face. Use this knowledge and search again for existing reports
-instead you can join.
+and potential fixes.
+
+[:ref:`back to step-by-step guide <checkloretwo_repisbs>`]
 
 
 Decode failure messages
-- 
2.51.0


