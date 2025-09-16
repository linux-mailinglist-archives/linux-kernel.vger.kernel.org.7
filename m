Return-Path: <linux-kernel+bounces-818568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F4CB59373
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:24:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7E1C7A875C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 10:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B38C304BCE;
	Tue, 16 Sep 2025 10:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TApN4LFX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70221303A3D;
	Tue, 16 Sep 2025 10:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758018215; cv=none; b=BTBnBwLbS2on8JJXql/sob3Ny7roKqVD4aUAT39knGJkDgh68BF/cqPsAHePk/T6Ut9/CdYeAMlViWc9EUWlG3MYxM/0StedoKcTupTzrcNtH3SC1lYNBezkk8Lh/TClASHKLhc8uC9TcnF6FMpd3QktlL8WYVzuMjG7JNvVAic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758018215; c=relaxed/simple;
	bh=jlol1TuhVNcZDXlNqsLBvYWROc27W0iXgTQpgdIUTbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ozuY0MYSvAWVsd4orP42E9wdWRPzh7UzpgtMIAQrHdxNqnCfkneqo27BetZfcp4vv/TLt7GwLN1SIHyAgrxGPKFL3uyR/sIa1p/q5xol/FXRdKWfccCj6C8J419Qt5MijB7ap1auce5VOKeS/7PYRdYCXi7cUPdtGFNf3CcJpx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TApN4LFX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B773C4CEEB;
	Tue, 16 Sep 2025 10:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758018215;
	bh=jlol1TuhVNcZDXlNqsLBvYWROc27W0iXgTQpgdIUTbU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TApN4LFXLiKXzH79GIRAoA7VKkeuGCkK/3p2UTPY07xh1zFLKlKnX/vacbwbKggWu
	 KCJOa2Uy2akNBD0gfS2bnAJBIT6lBhCXpgqoy+wznoEaWRmhqPmG+8P0JQZ1dkVYL/
	 rqQDGt6EdyvHOKFR8e5pQ8hC+YapHTyiB9yd/Yp12P1HVWK32pG8/cltHof8rjy8sg
	 x9kBEnIt7BBR6pXY/JF+j+HdjBBqUZRkaLM6dRRmE8OeCJ9BTx+hn8zy+0ONdxDZQH
	 E0t2fWWEjJGnfUYeeM9NI7b3CQP1gHRReafwXLRGDT2UAMwNNCLn4b8eaVFFNC5oc7
	 eh+64gb8B9FPA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uySqS-0000000BBOh-2q4i;
	Tue, 16 Sep 2025 12:23:32 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 03/21] scripts/jobserver-exec: add a help message
Date: Tue, 16 Sep 2025 12:22:39 +0200
Message-ID: <ce2b08ce249411d03a653961360f65767cd68374.1758018030.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758018030.git.mchehab+huawei@kernel.org>
References: <cover.1758018030.git.mchehab+huawei@kernel.org>
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


