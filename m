Return-Path: <linux-kernel+bounces-735163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9B1B08BAB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 13:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 897FE1AA2B14
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 11:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC5529A9FE;
	Thu, 17 Jul 2025 11:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DItPwpO7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BED145B27;
	Thu, 17 Jul 2025 11:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752751432; cv=none; b=n0HbUpzjGRnFNVWowYe715o9QpOpAPc4urhY+0pz/Nk0BoAbClovfQ40q1FmrWZNwWXWp/53e/h+VwMi9OR9tdCiCqUIsFHiZCfxac5UIK9NvzGQLuVXRIhckZzs1kvyl8oEBgFcCi/4GOL/BBKNCy9tIzuKZxAbWZ17mlvH8uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752751432; c=relaxed/simple;
	bh=sMRASinYsOiNvWFXLXcubyFSBK1Ekxj1Q+zyVQYPMJM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mQAKcacg6ey6UoaqAmF4FDp0qiQOKk0dOoRJjUx12P8rcWFZZom88PrZlXI/5BBOqc6+b1tgyy/Qs+Z+KM3COONpJ0jevJHDeYfHHw6/q62v996E0GXKzMDtn9Iia9wemvYYSf/0OKwWBJ5t2l+4r8qU6wsO6muZSLdtOYpKjog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DItPwpO7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC55C4CEE3;
	Thu, 17 Jul 2025 11:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752751431;
	bh=sMRASinYsOiNvWFXLXcubyFSBK1Ekxj1Q+zyVQYPMJM=;
	h=From:To:Cc:Subject:Date:From;
	b=DItPwpO7Ed32EaErdvLXJckDZE5bfmgBrU+5kBE2u5ZBRFV7LjEt8kgNzBRTA5SEA
	 gF7TXOOgR7RwoZ2ED3tKOu2mbH0nA2kjZoAe1KWXWAmNMfNNiO3GKbseWkoqik2G8B
	 1M9bW8KGiJSV2Fz9ztgWQVmPs4jcmghYRnDib/tDi88PROdhVY5Fq/u0PPhftR1PXv
	 i5BEHMYXm/b1iI/fB3UAenkSTgVInI1Qrgn5pvA7vlVIZUwNAMmqAr6nQxdvvIpKUO
	 Zqq0+LgYyAITsoxVMbbZ61cTOXSDWmMhXYOQkBO2Q9YKWwrK1AXmNC4xAAJ3R2/LcU
	 A038cK3ZX7s3g==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1ucMiL-0000000AyjN-1MNf;
	Thu, 17 Jul 2025 13:23:49 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org,
	Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH] sphinx: kernel_abi: fix performance regression with O=<dir>
Date: Thu, 17 Jul 2025 13:23:24 +0200
Message-ID: <20250717112345.2616617-1-mchehab+huawei@kernel.org>
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
	@@ -571,3 +571,17 @@ def setup(app):
	     """Patterns need to be updated at init time on older Sphinx versions"""

	     app.connect('config-inited', update_patterns)
	+    app.connect('env-get-outdated', on_outdated)
	+
	+def on_outdated(app, env, added, changed, removed):
	+    """Proper outdated handler with type conversion"""
	+    print("\n[OUTDATED]")
	+    print(f"Added: {added}")
	+    print(f"Changed: {changed}")
	+    print(f"Removed: {removed}")
	+    print(f"All docs count: {len(env.all_docs)}")
	+    print(f"Found docs count: {len(env.found_docs)}")
	+
	+    # Just return what we have
	+    return added | changed | removed
	+

Reported-by: Akira Yokosawa <akiyks@gmail.com>
Closes: https://lore.kernel.org/linux-doc/c174f7c5-ec21-4eae-b1c3-f643cca90d9d@gmail.com/
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
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


