Return-Path: <linux-kernel+bounces-769516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DCBB26FB1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 21:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F02271CC4E7D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 19:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0129F2441AA;
	Thu, 14 Aug 2025 19:30:52 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9009923D7F4;
	Thu, 14 Aug 2025 19:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755199851; cv=none; b=ZMj1LZNLpXorbiuTYx7FAjp6LsdOF3pBdQt6R6SAgBub74WoSs9seERVLTV6MjYN7BaxoFed6DnO+iaIUrMe6h6bhoPnJMdoGMTE3/aMRwWCzpBx1W9WBZ0/J1R6/Pw4+nwNM9oFudPbQJYRJAtmitBr5Hl8oIVjvEz8ysvD0p0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755199851; c=relaxed/simple;
	bh=B8D84kncEdf8+YC+9tk/28lZGcp6tSs3s4JbHwObiJ8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=eD/MTA3+ByUQwwYIZNrTvLAP5pV7ndEv8DNsfUy+4VIjc67tA2ObT51CIQeFUKgzMjUrIq/45p/MMi46nu4Rdddfun9ph1tfSORiDvEh7PS1VmUt9fxkwM2EBGCKUWNlc8sa1G93QGT3IHA3O82Bq+BsPnA+5USdQt1oPm/yDkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 57EJRmgr019295;
	Thu, 14 Aug 2025 21:27:48 +0200
From: Willy Tarreau <w@1wt.eu>
To: Jonathan Corbet <corbet@lwn.net>
Cc: security@kernel.org, workflows@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 2/2] Documentation: smooth the text flow in the security bug reporting process
Date: Thu, 14 Aug 2025 21:27:30 +0200
Message-Id: <20250814192730.19252-2-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20250814192730.19252-1-w@1wt.eu>
References: <20250814192730.19252-1-w@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The text was presenting the team, the the e-mail address, then some of
the expectations, then what form of e-mail is expected. By switching
the e-mail paragraph two paragraphs later and dropping the "Contact"
sub-section, we can have a more natural flow that presents the team,
then its expectation, then how to best contribute, then where to send.

And more importantly, it increases the chances that reporters have read
the prerequisites before finding the e-mail address.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 Documentation/process/security-bugs.rst | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/Documentation/process/security-bugs.rst b/Documentation/process/security-bugs.rst
index 7dcc034d3df8e..84657e7d2e5b4 100644
--- a/Documentation/process/security-bugs.rst
+++ b/Documentation/process/security-bugs.rst
@@ -8,17 +8,6 @@ like to know when a security bug is found so that it can be fixed and
 disclosed as quickly as possible.  Please report security bugs to the
 Linux kernel security team.
 
-Contact
--------
-
-The Linux kernel security team can be contacted by email at
-<security@kernel.org>.  This is a private list of security officers
-who will help verify the bug report and develop and release a fix.
-If you already have a fix, please include it with your report, as
-that can speed up the process considerably.  It is possible that the
-security team will bring in extra help from area maintainers to
-understand and fix the security vulnerability.
-
 The security team and maintainers almost always require additional
 information beyond what was initially provided in a report and rely on
 active and efficient collaboration with the reporter to perform further
@@ -36,6 +25,14 @@ information is helpful.  Any exploit code is very helpful and will not
 be released without consent from the reporter unless it has already been
 made public.
 
+The Linux kernel security team can be contacted by email at
+<security@kernel.org>.  This is a private list of security officers
+who will help verify the bug report and develop and release a fix.
+If you already have a fix, please include it with your report, as
+that can speed up the process considerably.  It is possible that the
+security team will bring in extra help from area maintainers to
+understand and fix the security vulnerability.
+
 Please send plain text emails without attachments where possible.
 It is much harder to have a context-quoted discussion about a complex
 issue if all the details are hidden away in attachments.  Think of it like a
-- 
2.17.5


