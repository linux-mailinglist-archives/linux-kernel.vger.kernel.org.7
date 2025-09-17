Return-Path: <linux-kernel+bounces-820631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D01B7D157
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62C174827FE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 12:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD50393DE0;
	Wed, 17 Sep 2025 12:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eO1nP3vg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BE031BCBC;
	Wed, 17 Sep 2025 12:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758111356; cv=none; b=DfEvyGdfQwW17NgK94bDvAhhUvz/SWytEm0ABBYe2tfvI6ew0anCFfwD1IeEa5pt6ujlO3hkaYE2llK2mEEZvfNWCWJeTxUNCjHPjsK/tK9oxypfUXc+95vsoHotcYAkEuE9s6fRpswkpaW/y5oGrDEId6r7c6L4VEQYKY81GIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758111356; c=relaxed/simple;
	bh=jlol1TuhVNcZDXlNqsLBvYWROc27W0iXgTQpgdIUTbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AGuqbGtGe6PQBpFK2SwFW3+aGmDCBfbWUOHjRWBHfUZ50aJPzkEWqBYMZRdCsoivnk0yfLFV3vE5JozHzh7l06IEp6f3UmfdlqCjPVOOOXfVF21R0YsfDYQS2Kg7jNXxrZakQXciBZwVkkYmd5rcpPugUr5yaNTlQnSw+nFKZfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eO1nP3vg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E87BC4CEFA;
	Wed, 17 Sep 2025 12:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758111355;
	bh=jlol1TuhVNcZDXlNqsLBvYWROc27W0iXgTQpgdIUTbU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eO1nP3vgZcBN0PFJ1WsBVBVikAoR58lAtSZf05IqGO+LxsUA/yV8CxVE5f2VM38wF
	 t88aW82Q7xc+55m++oeYNi7oy4FLYP7W/kaaH0b8ijREQSNgCKq2hTIA7ru5Me+4fc
	 P3FQumb2iuem4VLcx1srENMrE4fyzQKbwGOUNoADtJaR5bjQs55PvRC0lonAOod2LY
	 fAo16jXql7ndhmr9zSEmDW7PQXLbPrm+R8GXZ1VPnR69QQa9T/2bze283miY29uoUs
	 6DlH60ItBAN4vvGVb/dMez1OFmUt7IAbBPPgmsxb1TUJluQp8PurTR37QXndZ72wkP
	 m7Hyp7nYrWmpA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uyr4h-0000000CGdM-0Tq4;
	Wed, 17 Sep 2025 14:15:51 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Akira Yokosawa" <akiyks@gmail.com>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 03/24] scripts/jobserver-exec: add a help message
Date: Wed, 17 Sep 2025 14:14:57 +0200
Message-ID: <ce2b08ce249411d03a653961360f65767cd68374.1758111077.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758111077.git.mchehab+huawei@kernel.org>
References: <cover.1758111077.git.mchehab+huawei@kernel.org>
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


