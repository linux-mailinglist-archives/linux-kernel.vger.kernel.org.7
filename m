Return-Path: <linux-kernel+bounces-794643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D5EB3E4A8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 15:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 471F61A811C2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 13:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E6F322770;
	Mon,  1 Sep 2025 13:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OxwNXuXe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30BE1DD9AD;
	Mon,  1 Sep 2025 13:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756732887; cv=none; b=n/Lq+ET6MzH2hb10jdwDufdcp3rtg7t5ylepFzYlLxu8LYSUurApVx2YvObO9p0DQnokVFSdi7swbe0uRXUV4YtMd+o+7XOfiIWvZuMaLjWixt0AKHr6UKrFTzxMrV4tXDcm5zqK2kQC9DgZ2dxOOzImiuN6tQqMQC+IkaMfG8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756732887; c=relaxed/simple;
	bh=u2CDTQhsURCCSqa3JpAMaK/gwDrT9364bVhhTnoXS28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DxRVGVWfQq9JGGiHmk3fgZWEnS0BQ8ucu4LzNTE+55rFasKJMjCrUTHdCBSXMgwZd7USb9EzNn4C/sV4FN3PvNk7i5klYdBUfwf3Irotkwi2fNTpDRVtHP7//YXcrtXtzkUlm36tBq2PNNbUrsYThGIwSJBDoDx5orahfxbQRMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OxwNXuXe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CC2CC4AF09;
	Mon,  1 Sep 2025 13:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756732887;
	bh=u2CDTQhsURCCSqa3JpAMaK/gwDrT9364bVhhTnoXS28=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OxwNXuXedznJSi2jMRuobh4RjVk3OOQFMSaYcrC0WD+BnuCQBoPJQi/tMn6pLL8Qw
	 GHgP7OjcXR+zSPJO70P/HBs717bnvnSD6B10AYyMysp+LGLI2l3UvBkoBRElWiR3hI
	 mETwpZjkKUIyFeFInWIUUV9s06dKUhLbxNOwSgl5mE3gOEvXse1iF2oYolchJVjUSe
	 YQZf4OSDu8XPCynyrnhHE9rFLYXd32G1Av3gDf02EVOQmCoryYB11eVIF9WrhovoSI
	 ymxEVzUmNTqWjJ7SNe/oXOmfq876Lo2sVLDQ9yZexg+oDyJZcc42u4HVbPQ7JKYTcE
	 QTRiXmgiuM3Pw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ut4TN-00000003Dcf-2NzC;
	Mon, 01 Sep 2025 15:21:25 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Kees Cook <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] docs: kernel_include.py: drop some old behavior
Date: Mon,  1 Sep 2025 15:21:22 +0200
Message-ID: <00cdf3cbe2481aac875c543ded14b5eacfe071ec.1756732363.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1756732363.git.mchehab+huawei@kernel.org>
References: <cover.1756732363.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

The old behavior is not using anymore, so let's drop it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/sphinx/kernel_include.py | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/Documentation/sphinx/kernel_include.py b/Documentation/sphinx/kernel_include.py
index 661ed978bed8..2c4bb8215b4c 100755
--- a/Documentation/sphinx/kernel_include.py
+++ b/Documentation/sphinx/kernel_include.py
@@ -316,11 +316,9 @@ class KernelInclude(Directive):
         env = self.state.document.settings.env
 
         #
-        # The include logic accepts only patches relative to:
-        #   - Kernel source tree
-        #   - Documentation output directory
-        #
-        # The logic does check it to prevent directory traverse
+        # The include logic accepts only patches relative to the
+        # Kernel source tree.  The logic does check it to prevent
+        # directory traverse issues.
         #
 
         srctree = os.path.abspath(os.environ["srctree"])
@@ -331,10 +329,6 @@ class KernelInclude(Directive):
         if os.path.isfile(src_path):
             base = srctree
             path = src_path
-        elif os.path.exists(arg):
-            # Allow patches from output dir
-            base = os.getcwd()
-            path = os.path.abspath(path)
         else:
             raise self.warning(f'File "%s" doesn\'t exist', path)
 
@@ -359,11 +353,6 @@ class KernelInclude(Directive):
 
         env.note_dependency(os.path.abspath(path))
 
-        # HINT: I had to copy&paste the whole Include.run method. I'am not happy
-        # with this, but due to security reasons, the Include.run method does
-        # not allow absolute or relative pathnames pointing to locations *above*
-        # the filesystem tree where the reST document is placed.
-
         if not self.state.document.settings.file_insertion_enabled:
             raise self.warning('"%s" directive disabled.' % self.name)
         source = self.state_machine.input_lines.source(self.lineno -
-- 
2.51.0


