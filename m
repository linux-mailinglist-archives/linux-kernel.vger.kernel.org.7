Return-Path: <linux-kernel+bounces-735180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B8DB08BD6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 13:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33D8E3B635C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 11:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739BC29ACCC;
	Thu, 17 Jul 2025 11:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jTFjLUu6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2771F9F73;
	Thu, 17 Jul 2025 11:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752752245; cv=none; b=RgiWbt6jg71gwp19AdNejujDy+4965WV4Id5IniEc40FgBFUF/XFRXFFD9U7Yn79HlS5+cIAsJD7XXSNf3NcaWxj8ZOPPg7pLtRcB42piLxobNUay35HVQINGESQIplw41oRSxtCGz9yztE34ndVZdUMKoUv+aj4LwiOu7ty0ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752752245; c=relaxed/simple;
	bh=LZclc8zmVbRhnO1CRhpy4u/m5fe34HId0hi9iXYV0pQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O5/3SzUd76tD/L5LkSsS7er3Oct6CYwNYS27rGmsYFzoQ1mKsTcZ+jjyCedmtAllKTjjyjM8Z19nZMMCVjwzvY1XqfRZ9RCnUoBBSrMLlwhXXCsMAiGdoT0DHTTp2rtLxIFs5zKDto5EFYh1X8f9XwjhoEaFNU04uXV6HGn/Vck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jTFjLUu6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EA5CC4CEE3;
	Thu, 17 Jul 2025 11:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752752245;
	bh=LZclc8zmVbRhnO1CRhpy4u/m5fe34HId0hi9iXYV0pQ=;
	h=From:To:Cc:Subject:Date:From;
	b=jTFjLUu6mEsSa7RGtlRL2ZCF+uqYMKHrqc+hK5NTJl8AhjXIxc+OR3HqmpXj6a8Cl
	 FY0+LZTUiFBMS3Vr4Qpxz3R+DTyTutylcasZm+M/FRUDRaBzMBubeSu62Zqy2bHSig
	 STf0wBJmqPbEfN+785prPyI4QZNXAYrBBoQDQJ6zEC1IF9B5VdMuqBxOaQzLAef38F
	 LIoSBGb6XeIK07nw8W/rSypa7GazVVU3261p1dQrGgt1q7cdmDoTWZOnfwdryjhFod
	 GU+Zm/KwS+wIjmKg8L4ZTik3q06W9+rVWkQHF6ZVDxxZtqsuUwQ7SnjeyBNNO6Q6fX
	 pIApCGT3htI/Q==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ucMvT-0000000BQtO-1Mlf;
	Thu, 17 Jul 2025 13:37:23 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	Kees Cook <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org,
	Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH v2] sphinx: kernel_abi: fix performance regression with O=<dir>
Date: Thu, 17 Jul 2025 13:37:19 +0200
Message-ID: <e25673d87357457bc54ee863e97ff8f75956580d.1752752211.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

The logic there which adds a dependency note to Sphinx cache
is not taking into account that the build dir may not be
the source dir. This causes a performance regression:

$ time make O=/tmp/foo SPHINXDIRS=admin-guide htmldocs

	[OUTDATED]
	Added: set()
	Changed: {'abi-obsolete', 'abi-removed', 'abi-stable-files', 'abi-obsolete-files', 'abi-stable', 'abi', 'abi-removed-files', 'abi-testing-files', 'abi-testing', 'gpio/index', 'gpio/obsolete'}
	Removed: set()
	All docs count: 385
	Found docs count: 385

	real    0m11,324s
	user    0m15,783s
	sys     0m1,164s

To get the root cause of the problem (ABI files reported as changed),
I used this changeset:

	diff --git a/Documentation/conf.py b/Documentation/conf.py
	index e8766e689c1b..ab486623bd8b 100644
	--- a/Documentation/conf.py
	+++ b/Documentation/conf.py
	@@ -571,3 +571,16 @@ def setup(app):
	     """Patterns need to be updated at init time on older Sphinx versions"""

	     app.connect('config-inited', update_patterns)
	+    app.connect('env-get-outdated', on_outdated)
	+
	+def on_outdated(app, env, added, changed, removed):
	+    """Track cache outdated due to added/changed/removed files"""
	+    print("\n[OUTDATED]")
	+    print(f"Added: {added}")
	+    print(f"Changed: {changed}")
	+    print(f"Removed: {removed}")
	+    print(f"All docs count: {len(env.all_docs)}")
	+    print(f"Found docs count: {len(env.found_docs)}")
	+
	+    # Just return what we have
	+    return added | changed | removed

Reported-by: Akira Yokosawa <akiyks@gmail.com>
Closes: https://lore.kernel.org/linux-doc/c174f7c5-ec21-4eae-b1c3-f643cca90d9d@gmail.com/
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
v2: updated description. No changes at the diff itself

 Documentation/sphinx/kernel_abi.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/sphinx/kernel_abi.py b/Documentation/sphinx/kernel_abi.py
index db6f0380de94..4c4375201b9e 100644
--- a/Documentation/sphinx/kernel_abi.py
+++ b/Documentation/sphinx/kernel_abi.py
@@ -146,8 +146,10 @@ class KernelCmd(Directive):
                 n += 1
 
             if f != old_f:
-                # Add the file to Sphinx build dependencies
-                env.note_dependency(os.path.abspath(f))
+                # Add the file to Sphinx build dependencies if the file exists
+                fname = os.path.join(srctree, f)
+                if os.path.isfile(fname):
+                    env.note_dependency(fname)
 
                 old_f = f
 
-- 
2.50.1



