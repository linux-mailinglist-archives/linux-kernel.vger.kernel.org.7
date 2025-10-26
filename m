Return-Path: <linux-kernel+bounces-870333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 414F0C0A7CF
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 13:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BDA104E8410
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 12:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC7D2E06EF;
	Sun, 26 Oct 2025 12:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="DcEcOzku"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7567E2C17A8;
	Sun, 26 Oct 2025 12:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761482553; cv=none; b=SWmHU1VIH5WwvuamHQoBMJgQIh7HfBYm0uCryepGQz2O7EHqp0ONGTyEvXsnjqVefffGnyXQjt/j8smmLr10NsZVWdZDnKUZCnSzAKz1jB7jBkJhsnu0JlfnKxGTzGoWEC5gV6HjA4JJF4logHPxSlTAm/JuMkXsj2W1e6ga/vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761482553; c=relaxed/simple;
	bh=vghudGEOY3L1ytcEYABOWe472CPzB9vVvZz/X1Px26A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AkNH1QkYFM0MLLUKpzPVcZA5VJs21Tne2faliEtjfIy0A1zEt8GtHhhIKv1PhENRIUMg9BbZogaojv57B9t8IeBwUBVeraCTQscQGoeeoMO1r/sPI90vlFWjHPIReSTXZGqJuvQr8so7hIYKEMYdQ4nm22NabdhcP37r2DBc/SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=DcEcOzku; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:From:Sender:
	Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=A9M9qnXAKMMmJCdLmCAyHsjy98RtFl6ZF9DFi+xuUB8=; t=1761482551;
	x=1761914551; b=DcEcOzkuAxLLQ9iCDWvClnYTOvNO++ZqYAJygDLgZPxd5NdejNLZQbhQzRDd7
	p0ucvKsmxYeLuZdM+yuIMoQtBP6uitMi7TwyOUWmrxf/UsSVTzoCNcW2KYu9dS7mnomM1uO7N3v/m
	yaUUBtsd2046oKrWA1Ir+rRJGNrK6YrUViKu1xk9eYuIUMWiWnQfU8i5Ik4lR3aN2YUxxWHzjvbuE
	AaaqDWuB5970iXOJfMcPMxp0jo5ulBzI8yHH0wPcwcpBSKGFXbOvDqdT40UJt4JgqQ5rzdBhCUxjS
	KABWrOwpze7pg1O3rJXmfd+/CmVgBM0f9XtOfzh52hQv2XB1CQ==;
Received: from [2a02:8108:8984:1d00:a8ad:ebd4:6fc6:160] (helo=luggage.fritz.box); authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	id 1vD04m-001mXP-12;
	Sun, 26 Oct 2025 13:42:24 +0100
From: Thorsten Leemhuis <linux@leemhuis.info>
To: Jonathan Corbet <corbet@lwn.net>
Cc: workflows@vger.kernel.org,
	linux-doc@vger.kernel.org,
	regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 05/30] docs: reporting-issues: outline why reporting is complicated
Date: Sun, 26 Oct 2025 13:41:56 +0100
Message-ID: <a6704ef5b3a8dcbaf645ddb5407e8f13553502b0.1761481839.git.linux@leemhuis.info>
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
X-HE-SMSGID: 1vD04m-001mXP-12

Replace the closing words with a section that describes why reporting
Linux kernel bugs is more complicated than in other FLOSS projects.

Signed-off-by: Thorsten Leemhuis <linux@leemhuis.info>
---
 .../admin-guide/reporting-issues.rst          | 67 ++++++++++++++++---
 1 file changed, 59 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/reporting-issues.rst b/Documentation/admin-guide/reporting-issues.rst
index 745e698cb6be8b..2629fde3aa4b8f 100644
--- a/Documentation/admin-guide/reporting-issues.rst
+++ b/Documentation/admin-guide/reporting-issues.rst
@@ -1756,14 +1756,65 @@ But do not worry too much about all of this, a lot of drivers have active
 maintainers who are quite interested in fixing as many issues as possible.
 
 
-Closing words
-=============
-
-Compared with other Free/Libre & Open Source Software it's hard to report
-issues to the Linux kernel developers: the length and complexity of this
-document and the implications between the lines illustrate that. But that's how
-it is for now. The main author of this text hopes documenting the state of the
-art will lay some groundwork to improve the situation over time.
+Why reporting Linux kernel bugs is somewhat complicated
+-------------------------------------------------------
+
+The Linux kernel's development model differs from typical Open Source projects
+in a few important aspects. Four of those complicate bug reporting:
+
+1. Developers are free to solely focus on the latest mainline codebase.
+
+2. The 'stable team' maintains the stable and longterm kernel series, but is not
+   allowed to fix many bugs just there if they happen in mainline, too.
+
+3. There is no central bug tracker.
+
+4. Most kernels used in Linux distributions are totally unsuitable for reporting
+   bugs upstream.
+
+Due to the first aspect, some of the developers ignore or react coldly to
+reports about bugs in, say, Linux 6.1 when 6.2-rc1 is already out.
+
+The combination of the first and the second aspect is why some of the
+developers are unwilling to look into reports with stable or longterm kernels:
+the problem might never have happened in the code they work on, for example
+because the stable team did something wrong between 6.1.1 and 6.1.2.
+
+The stable team due to those two aspects is often in a similar but opposite
+situation when it comes to bugs reported using a kernel like 6.1.2: If that
+issue already happened in 6.1 and still happens in the latest mainline kernel,
+then it must be fixed there first. That is among the reasons why reporters in
+the end always have to check if mainline is affected, as the stable team often
+is the wrong point of contact, unless it is a series specific regression.
+
+There are various reasons why no central bug tracker exists. They, among others,
+were not a thing yet when Linux started, which is why reporting my email was
+the norm initially -- and still is, as quite a few developers prefer to handle
+all aspects of kernel development via email. Some, on the other hand, saw
+benefits in trackers and set up bugzilla.kernel.org, which due to the
+aforementioned aspect never became mandatory and has some problematic aspects;
+this is why it frequently does not even forward newly filed reports to the
+appropriate developers. Yet other developers prefer the comfort of Git forges
+for development and issue tracking; but subsystems use various forges, so those
+trackers are spread over the web.
+
+The fourth aspect is explained in the second point of the reference section
+already: Old codebases, modified sources, and add-ons lead to bugs that were
+fixed a long time ago already or never happened upstream in the first place.
+These are problems for many other software packaged by Linux distributions as
+well. But there it is usually a smaller problem, as the modifications and
+extensions distributors apply to the kernel are often much bigger and more
+dangerous; the kernel also changes way more quickly, is a lot more
+complex, and naturally more fragile. Due to these aspects, many developers
+expect reports to be based on fresh and vanilla kernels. Furthermore, most of
+them receive way more bug reports than they are able to handle, which is
+why they prioritize the ones that look more promising.
+
+Reporting a bug due to these and other unmentioned aspects is harder than in
+other Free/Libre & Open Source Software projects -- the complexity of this
+document proves that. But that is the state of affairs for now. The primary
+author of this text hopes documenting it will lay some groundwork to improve
+the situation over time.
 
 
 ..
-- 
2.51.0


