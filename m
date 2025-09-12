Return-Path: <linux-kernel+bounces-813839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 118B5B54B6E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 603121BC3B4D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 11:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F27C30103E;
	Fri, 12 Sep 2025 11:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uR9vkkSB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B617F2FDC2C;
	Fri, 12 Sep 2025 11:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757677594; cv=none; b=K+G80qquKWBaHm3hVcyaWDc5A4MY2mpiDV0ccRkmrO5GHIxPv5LOLEJ+eDGhFuGkzPPBrc8pHQIxf7hoBqDxlEIQws6vma4vFh/u3Q2UXfiodeAoG5Fvluu1Tr/xk4HF1Fz7hI9JRHn12tjsjr4IE5nInt8MSgvhh0TYD8hJkto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757677594; c=relaxed/simple;
	bh=jlol1TuhVNcZDXlNqsLBvYWROc27W0iXgTQpgdIUTbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=M+WiODtax09yHuKbbLNIJXPaur7HDjwTs4K8Mb5DhZV0DrzsZADDOcX7jk0fbOp9YX5t93EVFNbKaa0VJzVpZrZCVOYQHF3FK9OTRbCI3artyvd7jA2k9wd4lB0iwqfPQnr29pSkBj0s8MZvD1t8O7xR+vdcXaP8pBTuvDfM0UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uR9vkkSB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6362FC4CEFB;
	Fri, 12 Sep 2025 11:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757677594;
	bh=jlol1TuhVNcZDXlNqsLBvYWROc27W0iXgTQpgdIUTbU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uR9vkkSBW0yv+66nBxYMC/oEvmbvs19AP6iw3YMHN4kWwrMCZlQarYCAbKnQHoSCG
	 A7c+a/P9NalKD/Qu9TxrHgc+AYCVAbOvikeTez+36MjYCQcWbCjglulUg+ThNIHWLl
	 ULzNJRIfbQ95r7CPOq+CV2A/zqrMUyUmV9qjLnLL0Wtfs7Bhaa3UGpFfBmntWq450p
	 KDWsQ7+amhdNfQSxNWvhbdvGJ8cBsRWSoikVb8Gqq/cpCFXlA82VLZ62K3BgafPXz/
	 MeHn6d3Uduwlorz6ioWjHpR05Rvg838Mq/mY333htYhXFPWg31LCHsmhsuOyXvubSa
	 r5wJcK+poDC6w==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ux2Ea-00000008Rs5-2Jfq;
	Fri, 12 Sep 2025 13:46:32 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 03/18] scripts/jobserver-exec: add a help message
Date: Fri, 12 Sep 2025 13:46:10 +0200
Message-ID: <ce2b08ce249411d03a653961360f65767cd68374.1757677427.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1757677427.git.mchehab+huawei@kernel.org>
References: <cover.1757677427.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Currently, calling it without an argument shows an ugly error
message. Instead, print a message using pythondoc as description.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/jobserver-exec | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/scripts/jobserver-exec b/scripts/jobserver-exec
index 40a0f0058733..ae23afd344ec 100755
--- a/scripts/jobserver-exec
+++ b/scripts/jobserver-exec
@@ -1,6 +1,15 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0+
 
+"""
+Determines how many parallel tasks "make" is expecting, as it is
+not exposed via any special variables, reserves them all, runs a subprocess
+with PARALLELISM environment variable set, and releases the jobs back again.
+
+See:
+    https://www.gnu.org/software/make/manual/html_node/POSIX-Jobserver.html#POSIX-Jobserver
+"""
+
 import os
 import sys
 
@@ -12,17 +21,12 @@ sys.path.insert(0, os.path.join(SRC_DIR, LIB_DIR))
 from jobserver import JobserverExec                  # pylint: disable=C0415
 
 
-"""
-Determines how many parallel tasks "make" is expecting, as it is
-not exposed via an special variables, reserves them all, runs a subprocess
-with PARALLELISM environment variable set, and releases the jobs back again.
-
-See:
-    https://www.gnu.org/software/make/manual/html_node/POSIX-Jobserver.html#POSIX-Jobserver
-"""
-
 def main():
     """Main program"""
+    if len(sys.argv) < 2:
+        name = os.path.basename(__file__)
+        sys.exit("usage: " + name +" command [args ...]\n" + __doc__)
+
     with JobserverExec() as jobserver:
         jobserver.run(sys.argv[1:])
 
-- 
2.51.0


