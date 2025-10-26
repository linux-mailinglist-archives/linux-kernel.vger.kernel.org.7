Return-Path: <linux-kernel+bounces-870336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD36DC0A7E1
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 13:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98B8A18A0D23
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 12:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433BA2E172E;
	Sun, 26 Oct 2025 12:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="wJIDYZY+"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44ECB2D4814;
	Sun, 26 Oct 2025 12:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761482554; cv=none; b=tqKKfmuvzeshZ5oCTI8nGbFyQekgOV+53HPCCVnWTiT7OFHJl8CUSBpZnEBBfzp7cQaVffDN86lfcZki/HrmLG9zhNon4I1g7j9wVhP/B64saGe0GwzcU0eyaW1PrfRSHeJ2M8r1O4Qj3n+1vaQ2aHTDgN/o05lVa0KIQQYoRMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761482554; c=relaxed/simple;
	bh=xAI5YfEuTiDep83Xgs+jcdtCYrUUTepDFLMFVQqhTlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cPRrJQpJmQXF4+02npv2b/JbawDd8brNFh2TnW7hVXzdhOCYsFnLemOS+yHLgYO4REGRlsaDmNS5e8EoxpGqImnGR5dBE+CYymLQ9IjYoexsP6LyMgkcotbfiXzbT+/GgSbRksZ6It/hfileQdPrrv06Apie28L0aAbdJPXoCH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=wJIDYZY+; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=634MWhFAXgdF+Ly2EAEMkXBMHvbyAhbHlX3frr8jsXI=; t=1761482550;
	x=1761914550; b=wJIDYZY+KjnmVBLrvThs0s9Qr5UUJfgaVUuDyqbv2BjZ/gD4i/bvCKKOWb894
	09HTdZTrJzhow+UOLyY0+nUyI2d61skoNxHCjQyIhqCG2cUfdVcumEzkWRVliKANDEZKYYf7OwuoH
	ee4XO24aN+EVtcOeXxLH1AIanGZ404DUtBFpU/fefUaszztjedtfvlShAA7KiZtwuYYzUEk2ZaQt6
	oXhZKFpZwwgfL9tZGLaK/iCIByehS7KDV5L79f6DJoArfF8CPsrM7rkUh3G6Vmqxruiz1RyPs/oGh
	UCKIQXcFtqtQoRbsuxx1JMv9wk47dQjNBNGseoefNb9mZL3F4Q==;
Received: from [2a02:8108:8984:1d00:a8ad:ebd4:6fc6:160] (helo=luggage.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	id 1vD04k-001mX6-1V;
	Sun, 26 Oct 2025 13:42:22 +0100
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Jonathan Corbet <corbet@lwn.net>
Cc: workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 01/30] docs: reporting-issues: mention text is best viewed rendered
Date: Sun, 26 Oct 2025 13:41:52 +0100
Message-ID: <4f7e2de2a2336c52e55cc49dcda627a4e86b8793.1761481839.git.linux@leemhuis.info>
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
X-HE-SMSGID: 1vD04k-001mX6-1V

Add a comment before the step-by-step guide explaining that the document
is best viewed in the rendered form, as there the internal links will
work that later patches will add.

While at it change the double quotes in the license hint at the end of
the document into single quotes, which is the preferred style.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 Documentation/admin-guide/reporting-issues.rst | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
index a68e6d90927471..3bc47afaf85ea0 100644
--- a/Documentation/admin-guide/reporting-issues.rst
+++ b/Documentation/admin-guide/reporting-issues.rst
@@ -48,6 +48,16 @@ Once the report is out, answer any questions that come up and help where you
 can. That includes keeping the ball rolling by occasionally retesting with newer
 releases and sending a status update afterwards.
 
+..
+   Note: If you see this note, you are reading the text's source file. You
+   might want to switch to a rendered version: It makes it a lot easier to
+   read and navigate this document -- especially when you want to look something
+   up in the reference section, then jump back to where you left off.
+..
+   Find the latest rendered version of this text here:
+   https://docs.kernel.org/admin-guide/reporting-issues.html
+
+
 Step-by-step guide how to report issues to the kernel maintainers
 =================================================================
 
@@ -1748,13 +1758,13 @@ art will lay some groundwork to improve the situation over time.
    you spot a typo or small mistake, feel free to let him know directly and
    he'll fix it. You are free to do the same in a mostly informal way if you
    want to contribute changes to the text, but for copyright reasons please CC
-   linux-doc@vger.kernel.org and "sign-off" your contribution as
-   Documentation/process/submitting-patches.rst outlines in the section "Sign
-   your work - the Developer's Certificate of Origin".
+   linux-doc@vger.kernel.org and 'sign-off' your contribution as
+   Documentation/process/submitting-patches.rst outlines in the section 'Sign
+   your work - the Developer's Certificate of Origin'.
 ..
    This text is available under GPL-2.0+ or CC-BY-4.0, as stated at the top
    of the file. If you want to distribute this text under CC-BY-4.0 only,
-   please use "The Linux kernel developers" for author attribution and link
+   please use 'The Linux kernel developers' for author attribution and link
    this as source:
    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/plain/Documentation/admin-guide/reporting-issues.rst
 ..
-- 
2.51.0


