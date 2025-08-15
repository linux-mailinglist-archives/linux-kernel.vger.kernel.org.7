Return-Path: <linux-kernel+bounces-770819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F41FB27F51
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 13:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 792767B5113
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03BE93009E3;
	Fri, 15 Aug 2025 11:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HnWaEtuT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D1B15A87C;
	Fri, 15 Aug 2025 11:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755257846; cv=none; b=ZnmS63OIdag6e8qcjBIUVXgRQFAaSBwXcXleK5x9xyhaeTwFLevKBgyegTbqfdISvsD1ITqZCPorVj1Wt8sg/kD9m4nDAopOJnMYGXLNRgsTHILqNEGxA+VraX29H8ovrmVQL6WJY4a8rGQqNk+f6jSql7zeeRXRmY06q2l9EBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755257846; c=relaxed/simple;
	bh=zMOHwhAKrRV4C5jWXOxsmB8Ttf0MQwEXFsiqcts/lkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mFqxzjg7V7F4+9s+J0RQAr1Ncu+CeqnNNZc2XLeQcolgiZoIjDM3Ggg7GkqWNoQkB8V8kDZL5qURDrXQ59Q+9s+LvkrbNJE+RJ88P+jZBRhkTkE9oOiU7pw+9AWT32H+emZoBDPbkPiaHqu9A54winUuHborGDo/DQUDmOyTP3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HnWaEtuT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD536C4CEF0;
	Fri, 15 Aug 2025 11:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755257845;
	bh=zMOHwhAKrRV4C5jWXOxsmB8Ttf0MQwEXFsiqcts/lkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HnWaEtuTsnRFP9auXiYPtn8ty957O3uKjiWJt9xUq6Y1NRspqWzhdRC2T7Pjhb/ga
	 Ruxf6zuONywsxVkGjMMBTYzLylIKS4Ub+GxXixELQBTQUJFe+vvPGynzrLd9D58pYB
	 77zkd3/FFDloFzYWqF6H/uqv7CmRFZjp7BMM67mdb/XplRr9mQoxvZAbN6KtNTWaI6
	 e/9xMw1C1g4jTgbVsKooQA3TnqHzg12jLLuE6mP8tBrByd/oOgPaqTMwFrzZY/LZbH
	 U0QPE2uhzM5iOgsi7Fs+Gn+XXnOSqq5uBj4Td2JGDtG4DsCqgwjY8TKp9YMwNl1Y3Z
	 hzf91QH586l8g==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1umskO-000000042T5-05gc;
	Fri, 15 Aug 2025 13:37:24 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 03/11] docs: conf.py: fix doc name with SPHINXDIRS
Date: Fri, 15 Aug 2025 13:36:19 +0200
Message-ID: <51360d73e925ddedb39bad2f9a4c184e16261fdf.1755256868.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755256868.git.mchehab+huawei@kernel.org>
References: <cover.1755256868.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

When SPHINXDIRS is used, the current logic produces a wrong
list of files, as it will not pick the SPHINXDIRS directory,
picking instead their children.

Add a rule to detect it and create the PDF doc with the right
name.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/conf.py | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/conf.py b/Documentation/conf.py
index 2c1be59fd54b..c8401ed75402 100644
--- a/Documentation/conf.py
+++ b/Documentation/conf.py
@@ -91,6 +91,19 @@ def config_init(app, config):
     # LaTeX and PDF output require a list of documents with are dependent
     # of the app.srcdir. Add them here
 
+    # When SPHINXDIRS is used, we just need to get index.rst, if it exists
+    if not os.path.samefile(doctree, app.srcdir):
+        doc = "index"
+        doc_name = os.path.basename(app.srcdir)
+        if os.path.exists(os.path.join(app.srcdir, doc + ".rst")):
+            latex_documents.append((doc, doc_name + ".tex",
+                                    "Linux %s Documentation" % doc_name.capitalize(),
+                                    "The kernel development community",
+                                    "manual"))
+            return
+
+    # When building all docs, or when a main index.rst doesn't exist, seek
+    # for it on subdirectories
     for fn in os.listdir(app.srcdir):
         doc = os.path.join(fn, "index")
         if not os.path.exists(os.path.join(app.srcdir, doc + ".rst")):
-- 
2.50.1


