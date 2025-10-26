Return-Path: <linux-kernel+bounces-870327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC6A4C0A78A
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 13:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89FBA3ACFCE
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 12:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA5B2DC763;
	Sun, 26 Oct 2025 12:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="JQdIhOp5"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F4B2D7392;
	Sun, 26 Oct 2025 12:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761482552; cv=none; b=meSKktRm3j6N09AG6f9dUMnvZv89SGggNHX5RpSqxSluCLoMaVlsr9pJMcBC2ailM9dA3PfCKHHN6D0A/zqtraku9G9lbJ9cQP0jrB25ODM2BFzJxB8d7lttepLc4mF7my/PjXOD4dn5/MS8dRfN7xd8FNlbj3FjiPrt3NBHWvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761482552; c=relaxed/simple;
	bh=44O02KX0DN7+jAJrnarViS3KTXfGoY/g/3iIWB//p/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UNtOBUACLLcqqB0UXMAoV3soMlfW33vNt0tyOQveaZil0AavU19jQAAvR0PNSOh/ExfZNf5+ozJAnAgrqOzQzCQIEvSUoBxTq3jfYzPobbQ/lmUaSeNzSoSaWLFS/5maqpLt8hH1c//CLIBO+jBhkZVs4cnYmLmEC9XC9qjnZUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=JQdIhOp5; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=PKnQQRxCkYFmTCA5kI5Xv69vsVtqU4WtvO3WAuNhaEo=; t=1761482550;
	x=1761914550; b=JQdIhOp5f3KcUw1d7pfJCAmlnh9050+scBFqU/h3M1qK874xdN8/Mg+GBjppg
	HKu7gze51LwqHSAALVYAhXbKi65NykQg68vLmDCXaDsTmwUJC+CHqq7tEX3suGDtuVPXQE9QqwH5T
	3DMRkjz7PkzrM0I7Vn51kHpkj+okFYRR+NM12/JRo6fHkeh5iCYq1ZrbGpxKEcu6yNtBeG7w/OnL1
	5K7ofd1bJgTZUDoFiYb4dVz22yKrAKi2os2tTbld0Cc3+yiy21Z2czhEYJxviUziMtozVWYF4AjdI
	rWpiI0iCnmyL9aOEYHSZEFVvUeblNLO7VOxpGtbaSnUF5FuV/g==;
Received: from [2a02:8108:8984:1d00:a8ad:ebd4:6fc6:160] (helo=luggage.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	id 1vD04l-001mX6-1E;
	Sun, 26 Oct 2025 13:42:23 +0100
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Jonathan Corbet <corbet@lwn.net>
Cc: workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 03/30] docs: reporting-issues: add conclusion to the step-by-step guide
Date: Sun, 26 Oct 2025 13:41:54 +0100
Message-ID: <9a8d7b58f482cf0669bc5028dd0e01301f7f526e.1761481839.git.linux@leemhuis.info>
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
X-HE-SMSGID: 1vD04l-001mX6-1E

Idea and text comes from
Documentation/admin-guide/verify-bugs-and-bisect-regressions.rst

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 Documentation/admin-guide/reporting-issues.rst | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
index 90b50c27c0d2b6..9676ba85e1b73c 100644
--- a/Documentation/admin-guide/reporting-issues.rst
+++ b/Documentation/admin-guide/reporting-issues.rst
@@ -241,6 +241,20 @@ kernels regularly rebased on those. If that is the case, follow these steps:
 The reference section below explains each of these steps in more detail.
 
 
+Conclusion of the step-by-step guide
+------------------------------------
+
+Did you run into trouble following the step-by-step guide not cleared up by the
+reference section below? Did you spot errors? Or do you have ideas on how to
+improve the guide?
+
+If any of that applies, please take a moment and let the primary author of this
+text, Thorsten Leemhuis <linux@leemhuis.info>, know by email while ideally CCing
+the public Linux docs mailing list <linux-doc@vger.kernel.org>. Such feedback is
+vital to improve this text further, which is in everybody's interest, as it will
+enable more people to master the task described here.
+
+
 Reference section: Reporting issues to the kernel maintainers
 =============================================================
 
-- 
2.51.0


