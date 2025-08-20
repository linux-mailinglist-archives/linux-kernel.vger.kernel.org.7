Return-Path: <linux-kernel+bounces-777308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFE5B2D805
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 11:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18B755A5F04
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 09:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88EE2E0409;
	Wed, 20 Aug 2025 09:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLHDJgkL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F423F2E040E;
	Wed, 20 Aug 2025 09:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755681014; cv=none; b=HM85wnLuAd7gEzhhEfkRTewIgSstNpWsWvHQ31xlfkMtmuPNLHnW+AyXT3xZOWcZ4YyKSGqSuyyR861fAfr1DQthTJ8lqSUCIVA7nu8qE8CPMMhri/jYTrSLIhFlRX40M8C8seslWhPQABdh0G2MDXXVW4htbm9iqPrcBRhGR+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755681014; c=relaxed/simple;
	bh=9wvul6/w8xzCWUv6hCt3n+RtNBa+Uwb8WNag5YjgMnw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kh86t8N4e1yuvsz1luoBdnoroSDuplkPEO5MWcToFFlWMsjI+ZO6W61l/vynOykYrWeJiVPBrRLAB9U52xzIecgde+DYbUOG2nbqRgGYI1XVYhRvkWd3hT9Va9eZGYyv0hhotpHg1Ra61ulvm9/EDybzpAVM9WxRE1czOyEbaEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLHDJgkL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F4EEC4CEEB;
	Wed, 20 Aug 2025 09:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755681013;
	bh=9wvul6/w8xzCWUv6hCt3n+RtNBa+Uwb8WNag5YjgMnw=;
	h=From:To:Cc:Subject:Date:From;
	b=DLHDJgkLx3/ZPCRJzCXeO9w1mpOJkYa7IES6qMtAdz+/XKsrTcrNO5Ppt9Qzk75dK
	 ufqJaN9RjEcuk3HV9c8bKD46xOKAFJgZZ09OCJlAoASjWQaHmLA30nQufQ3M+JH8RT
	 62S6jcWFArcLN+hYfhYkfVHI4vojPS8hrC12eYkwA7vlXtlK2ls2zc5+F+gP8aTEaU
	 3na0DibnW+4iz8bGmQt9FEBsn014wU+Uq4MadLrpprLdK62Umf0ig9D/02ZMNx3DbY
	 3wvnkFUg7nwbGHpkTKVK7rbUBVFOcvls5gSTNQNC9obaWJgK2A9UH9I3q9Vf9Hdn/s
	 4ytZgCSiLIFKg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1uoepf-0000000ASew-1IU5;
	Wed, 20 Aug 2025 11:10:11 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	Kees Cook <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs: kfigure.py: don't crash during read/write
Date: Wed, 20 Aug 2025 11:09:59 +0200
Message-ID: <df1602df0da3a6254d58a782654e7f2e60512dc8.1755680997.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

By default, Python does a very bad job when reading/writing
from files, as it tries to enforce that the character is < 128.
Nothing prevents a SVG file to contain, for instance, a comment
with an utf-8 accented copyright notice - or even an utf-8
invalid char.

While testing PDF and html builds, I recently faced one build
that got an error at kfigure.py saying that a char was > 128,
crashing PDF output.

To avoid such issues, let's use PEP 383 subrogate escape encoding
to prevent read/write errors on such cases.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/sphinx/kfigure.py | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/sphinx/kfigure.py b/Documentation/sphinx/kfigure.py
index ad495c0da270..8ba07344a1c8 100644
--- a/Documentation/sphinx/kfigure.py
+++ b/Documentation/sphinx/kfigure.py
@@ -88,7 +88,7 @@ def mkdir(folder, mode=0o775):
         os.makedirs(folder, mode)
 
 def file2literal(fname):
-    with open(fname, "r") as src:
+    with open(fname, "r", encoding='utf8', errors='surrogateescape') as src:
         data = src.read()
         node = nodes.literal_block(data, data)
     return node
@@ -355,7 +355,7 @@ def dot2format(app, dot_fname, out_fname):
     cmd = [dot_cmd, '-T%s' % out_format, dot_fname]
     exit_code = 42
 
-    with open(out_fname, "w") as out:
+    with open(out_fname, "w", encoding='utf8', errors='surrogateescape') as out:
         exit_code = subprocess.call(cmd, stdout = out)
         if exit_code != 0:
             logger.warning(
@@ -533,7 +533,7 @@ def visit_kernel_render(self, node):
     literal_block = node[0]
 
     code      = literal_block.astext()
-    hashobj   = code.encode('utf-8') #  str(node.attributes)
+    hashobj   = code.encode('utf-8', errors='surrogateescape')) #  str(node.attributes)
     fname     = path.join('%s-%s' % (srclang, sha1(hashobj).hexdigest()))
 
     tmp_fname = path.join(
@@ -541,7 +541,7 @@ def visit_kernel_render(self, node):
 
     if not path.isfile(tmp_fname):
         mkdir(path.dirname(tmp_fname))
-        with open(tmp_fname, "w") as out:
+        with open(tmp_fname, "w", encoding='utf8', errors='surrogateescape') as out:
             out.write(code)
 
     img_node = nodes.image(node.rawsource, **node.attributes)
-- 
2.50.1


