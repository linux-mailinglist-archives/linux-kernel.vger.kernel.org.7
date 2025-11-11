Return-Path: <linux-kernel+bounces-895809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0937C4EFDD
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 17:18:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE3213A5BAA
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 16:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2804836C5AC;
	Tue, 11 Nov 2025 16:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnh8bApP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8405136C591;
	Tue, 11 Nov 2025 16:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762877871; cv=none; b=OcSZZqlKnfLZVitrMB7NHusP9/cjUOFPyVgZao/+hlmejg/nWE1/6eAoo4n5JOCP2JChxsSSBBNRwkfZDLZllxn+Us7JwjSNtjHcQ0yjqNz5b2DfT3bMi0dNjdrcRifJtr9iaeSa5PqD961Ebyils9I0VK0+ktJrr9cva7maHtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762877871; c=relaxed/simple;
	bh=Z+LQRGKLYxNjvH6fP5yhpl7Kv0w5jjTBPTJp/J6C2Yo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WJeX8oCnix/UAFQQjw3BYg78TVMeHdgmIiw99a6g9btNQ3AEjOb9GUd4trX46IeBgPx5H4e+M5+SHeGg8Vt3hhz17zEN5dvjskRpxgXS7nfK1XKhh8NFxWuG2DD1LPZ1yffMBTrC2S6Jtn8Skx98Af38kM+tfTZ4x27phAJRY6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnh8bApP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40973C4CEF7;
	Tue, 11 Nov 2025 16:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762877871;
	bh=Z+LQRGKLYxNjvH6fP5yhpl7Kv0w5jjTBPTJp/J6C2Yo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dnh8bApPe7cpDYrgzM4zk2TTVQaSRvFc1CmEnnV6almuou+bFLzmIzI9EaJmm8Cya
	 Npmp11P1DHwTp0GODLpvsytTj0WZnkWmjXopIbLTDCLqlT5I6n2W3AawJKye29bV45
	 kmZHmu0U6wgrVeDRV4OT7s7/N3zE7IfW3mVnm8V1wlMEnB0aDuFn1Ie/n05Wt838Ov
	 ya/Fr7AXF13goqBHxQhQ/d1B5yz1jz8K8lI6cD9e443VZx3RND+W0GcNLgvw0XAlzr
	 dMr8PmE7Ck2kL0xO4EcqjEBc842YB8ROCFHfNCn9cH/Rj0YaANj2M7hsMGoAcFHMop
	 83alFF8gSTfWQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vIr40-00000007s4h-1chb;
	Tue, 11 Nov 2025 17:17:48 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	"Jonathan Corbet" <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] Documentation/sphinx/kernel_feat.py: use class directly
Date: Tue, 11 Nov 2025 17:17:43 +0100
Message-ID: <bc3b2cb9310428c571f7850e61d7c3915794f778.1762877066.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1762877066.git.mchehab+huawei@kernel.org>
References: <cover.1762877066.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Now that get_feat is in Python, we don't need to use subprocess
to fork an executable file: we can use the feature classes
directly.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/sphinx/kernel_feat.py | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/Documentation/sphinx/kernel_feat.py b/Documentation/sphinx/kernel_feat.py
index 1dcbfe335a65..59b3ca573021 100644
--- a/Documentation/sphinx/kernel_feat.py
+++ b/Documentation/sphinx/kernel_feat.py
@@ -34,7 +34,6 @@
 import codecs
 import os
 import re
-import subprocess
 import sys
 
 from docutils import nodes, statemachine
@@ -89,18 +88,16 @@ class KernelFeat(Directive):
 
         srctree = os.path.abspath(os.environ["srctree"])
 
-        args = [
-            os.path.join(srctree, 'tools/docs/get_feat.pl'),
-            'rest',
-            '--enable-fname',
-            '--dir',
-            os.path.join(srctree, 'Documentation', self.arguments[0]),
-        ]
+        feature_dir = os.path.join(srctree, 'Documentation', self.arguments[0])
+
+        feat = ParseFeature(feature_dir, False, True)
+        feat.parse()
 
         if len(self.arguments) > 1:
-            args.extend(['--arch', self.arguments[1]])
-
-        lines = subprocess.check_output(args, cwd=os.path.dirname(doc.current_source)).decode('utf-8')
+            arch = self.arguments[1]
+            lines = feat.output_arch_table(arch)
+        else:
+            lines = feat.output_matrix()
 
         line_regex = re.compile(r"^\.\. FILE (\S+)$")
 
-- 
2.51.1


