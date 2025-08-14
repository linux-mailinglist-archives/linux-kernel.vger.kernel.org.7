Return-Path: <linux-kernel+bounces-769515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C26A3B26FAF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 21:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EB717B0A84
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 19:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A90238C3B;
	Thu, 14 Aug 2025 19:30:49 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94CA31986F;
	Thu, 14 Aug 2025 19:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755199849; cv=none; b=cWrOOnZhHOdIta7RfsonXXHZFlHEiyfOub3KtoeKib89drBZZkiBT6zxeCeSbtOuMWf5g90g6SKSPF9VYwpT1OPtQ/pdqAkm0FV/T1mcx3b/2sLTKOmzQ9OOAzzN/T0GmuEw4sDufOGZcT/eHcWCg2q1HiJW/zRsLEE8pfksDoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755199849; c=relaxed/simple;
	bh=DhhM8Zn5/pQg6diUjBBdUDnZEhmpufToEhf+iKMdsYk=;
	h=From:To:Cc:Subject:Date:Message-Id; b=LDLvoV+F+aZUf+dEh0VQN2ZeFuZTHjBLnPUKVGd6Y1Oyb5JdmsjMyOYj08DEKQjABpYMed7KOpIWmzO/FR6ETAhxTEDJlsQvWh6or95PXkbEQNA/u9Fl4uzxyCZvhIF0hR2fxw2tOfqk9bz3yjeOvrmm16P0M03NxNMHdGxBWjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 57EJRmDH019294;
	Thu, 14 Aug 2025 21:27:48 +0200
From: Willy Tarreau <w@1wt.eu>
To: Jonathan Corbet <corbet@lwn.net>
Cc: security@kernel.org, workflows@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 1/2] Documentation: clarify the expected collaboration with security bugs reporters
Date: Thu, 14 Aug 2025 21:27:29 +0200
Message-Id: <20250814192730.19252-1-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Some bug reports sent to the security team sometimes lack any explanation,
are only AI-generated without verification, or sometimes it can simply be
difficult to have a conversation with an invisible reporter belonging to
an opaque team. This fortunately remains rare but the trend has been
steadily increasing over the last years and it seems important to clarify
what developers expect from reporters to avoid frustration on any side and
keep the process efficient.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 Documentation/process/security-bugs.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/process/security-bugs.rst b/Documentation/process/security-bugs.rst
index 56c560a00b37a..7dcc034d3df8e 100644
--- a/Documentation/process/security-bugs.rst
+++ b/Documentation/process/security-bugs.rst
@@ -19,6 +19,16 @@ that can speed up the process considerably.  It is possible that the
 security team will bring in extra help from area maintainers to
 understand and fix the security vulnerability.
 
+The security team and maintainers almost always require additional
+information beyond what was initially provided in a report and rely on
+active and efficient collaboration with the reporter to perform further
+testing (e.g., verifying versions, configuration options, mitigations, or
+patches). Before contacting the security team, the reporter must ensure
+they are available to explain their findings, engage in discussions, and
+run additional tests.  Reports where the reporter does not respond promptly
+or cannot effectively discuss their findings may be abandoned if the
+communication does not quickly improve.
+
 As it is with any bug, the more information provided the easier it
 will be to diagnose and fix.  Please review the procedure outlined in
 'Documentation/admin-guide/reporting-issues.rst' if you are unclear about what
-- 
2.17.5


