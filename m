Return-Path: <linux-kernel+bounces-779268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A078B2F0DF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 10:21:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0E5644E55A6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 08:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3E12ECD15;
	Thu, 21 Aug 2025 08:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W75ChgpJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F3E2EB850;
	Thu, 21 Aug 2025 08:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755764224; cv=none; b=ud5eXs6kFpHszOsZycbDxqP9algNRgtw2p1pe4UsZVjTjZGVelSAykkqM/RlALuUt1hICf2+IOtGkuF63nm9XPdYKy1O8V6Tdd0908QaAFjHpy7RwjJFqeWXf5C9Bcmi+LLhr5Y8Yl9MZ+vzY0t8zeuZG2n1P7+L+aJ2Cn2z+HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755764224; c=relaxed/simple;
	bh=zMOHwhAKrRV4C5jWXOxsmB8Ttf0MQwEXFsiqcts/lkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YCibjF7lFcBG8v/HrKcG5BV3yn4zBSkbasfe0HAMky44XNa0TaF5DI5xZVrJJRvC+YIU3agYf2nNGdMGBmAAdYTP+EgahT5M+UjLBW8nxBI2kg8om/Kj2H9J2XLCFsKJh2K845jmObwU7w2qrQk0NnlWy6SXnryaO3uLBFa1lxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W75ChgpJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE92C116B1;
	Thu, 21 Aug 2025 08:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755764224;
	bh=zMOHwhAKrRV4C5jWXOxsmB8Ttf0MQwEXFsiqcts/lkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W75ChgpJj0xZM7futsdm6rUJEnYZHpoxcAXMEytGpMxm5iza7FndC182xp7zrfA4W
	 XP/2UKxPvkKrB3RfRAzyazD9XzOR5XK/72afgRRVG018n+MQnFFWNFUi2/jZO5+nFQ
	 OXFUpp5T1tmzyT5pj7oJLEpEblVxbLMMl7MoyfRRNW0Nqu6YSyCL3SCtkpuCmasP9a
	 dOEXMxPZ+hmufSaZd5+WN3mSiYC9TqiPyrFBUcsSRYcaLtWpAYGthICIXVHlAL5snx
	 RwJZWJzSQ+2E5oLKgw2JuN/HwTMXgLtLjBzMb8Tx0H4EPNQ145LPNGcYTBXtIH57ML
	 xfWo1c8dbtEbA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1up0Tm-0000000BLgD-2dJF;
	Thu, 21 Aug 2025 10:17:02 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/14] docs: conf.py: fix doc name with SPHINXDIRS
Date: Thu, 21 Aug 2025 10:16:39 +0200
Message-ID: <183f630643eacf414cfa8d892f03dd1b1055c21e.1755763127.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755763127.git.mchehab+huawei@kernel.org>
References: <cover.1755763127.git.mchehab+huawei@kernel.org>
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


