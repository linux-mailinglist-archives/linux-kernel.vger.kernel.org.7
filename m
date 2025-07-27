Return-Path: <linux-kernel+bounces-747259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17EF0B1319E
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 21:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F1231762B6
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 19:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1880233723;
	Sun, 27 Jul 2025 19:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJBTo/Sr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3715422FDE6;
	Sun, 27 Jul 2025 19:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753646301; cv=none; b=mL0O9bFfA96qvYAXRiaXdR+DPqVvLbcHyhhGQax03K+4VjTMpx1+WW1dULRgXSHjT7KTOgVxRF85KhVcg8UlHip2AHfhCYsayNJtsMwkOygU94ax35ag/YLWRpA/4/wwDEYT0f5D1Zh3IPyVZt2EOjNlKKlqSiVLDRa6R9eL/j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753646301; c=relaxed/simple;
	bh=oLCDK1T1x0R7EmTwhwpVbjC3s4vp39BNykyI9TtQHUU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GIZlxCJ3nD99GwEazUkjSKjLQ5BghJjBHYzSTVo01DNKRF9Wd2wMFjqHSDBbrxNeBv47Gi8z6VqrYn59BSoSzWhL9/Gw8Tj0N6Qs/cBk9pjdjtzfypVDCi270Te5KEyBkYCMa4DC1Girqogc+pRYo3L9PUCh8qsFTCWgACCgwWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJBTo/Sr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F3CC4CEEB;
	Sun, 27 Jul 2025 19:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753646301;
	bh=oLCDK1T1x0R7EmTwhwpVbjC3s4vp39BNykyI9TtQHUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UJBTo/SrqGmt3TMkX0Ics22MrLsCSPfsPcG0RWttkZ+jIEhTmTqvqioGO+LZc+PnD
	 GLrGX45GosuqPmHSb/KGDJLC/pGRNv9Do0QdqpRchSL5s4PwxdI4j2FUwkpnHsNC4n
	 EsndJn+C7EHGsazEPIZgclPyG8vvCaQuYDVIT4wN5yPT5vN1kz/hzLkVrIyHswdgCj
	 vGpPoI15dgbNQRg4JgKogxdUseThcLY+jjg3yiQ7vAds7C56zqoV54M5BaWSK1g/2l
	 XKhQg68PaV/jiDMleWtfzK4f4mcBQKPImrWLTsoSxZoPMMYgvudfK0LUx15AUXS9rm
	 eCjff8rJwEd3w==
From: Sasha Levin <sashal@kernel.org>
To: corbet@lwn.net,
	linux-doc@vger.kernel.org,
	workflows@vger.kernel.org
Cc: sashal@kernel.org,
	josh@joshtriplett.org,
	kees@kernel.org,
	konstantin@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	rostedt@goodmis.org
Subject: [PATCH 2/4] agents: add core development references
Date: Sun, 27 Jul 2025 15:58:00 -0400
Message-Id: <20250727195802.2222764-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250727195802.2222764-1-sashal@kernel.org>
References: <20250727195802.2222764-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/agents/core.rst  | 28 ++++++++++++++++++++++++++++
 Documentation/agents/index.rst |  3 ++-
 Documentation/agents/main.rst  |  5 +++++
 3 files changed, 35 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/agents/core.rst

diff --git a/Documentation/agents/core.rst b/Documentation/agents/core.rst
new file mode 100644
index 000000000000..da171dde1f9d
--- /dev/null
+++ b/Documentation/agents/core.rst
@@ -0,0 +1,28 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+========================================
+Core Linux Kernel Development References
+========================================
+
+Essential documentation for Linux kernel development:
+
+How to do Linux kernel development
+----------------------------------
+
+The comprehensive guide for becoming a Linux kernel developer and learning to work with the kernel development community.
+
+See :ref:`Documentation/process/howto.rst <process_howto>`
+
+Submitting patches
+------------------
+
+The essential guide to getting your code into the kernel, covering everything from patch formatting to the submission process.
+
+See :ref:`Documentation/process/submitting-patches.rst <submittingpatches>`
+
+Submission checklist
+--------------------
+
+A checklist of items to review before submitting code to ensure patches are accepted more quickly.
+
+See :ref:`Documentation/process/submit-checklist.rst <submitchecklist>`
diff --git a/Documentation/agents/index.rst b/Documentation/agents/index.rst
index 109266ca91ec..2737ab62efa0 100644
--- a/Documentation/agents/index.rst
+++ b/Documentation/agents/index.rst
@@ -7,4 +7,5 @@ Agents
 .. toctree::
    :maxdepth: 1
 
-   main
\ No newline at end of file
+   main
+   core
\ No newline at end of file
diff --git a/Documentation/agents/main.rst b/Documentation/agents/main.rst
index 98aa8250be9d..34f13d0b975a 100644
--- a/Documentation/agents/main.rst
+++ b/Documentation/agents/main.rst
@@ -5,3 +5,8 @@ Linux Kernel Development Agent Instructions
 =====================================
 
 This is the Linux kernel repository. When working with this codebase, you must follow the Linux kernel development processes and coding standards.
+
+Core Development Process
+------------------------
+
+For essential kernel development documentation, see :doc:`core`
-- 
2.39.5


