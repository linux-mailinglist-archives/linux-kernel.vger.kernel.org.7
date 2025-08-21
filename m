Return-Path: <linux-kernel+bounces-780042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BE466B2FC5F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 16:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 130587B8F6A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 14:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD692EDD45;
	Thu, 21 Aug 2025 14:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULo+QUmB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30FF285C89;
	Thu, 21 Aug 2025 14:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755786100; cv=none; b=Xp9ObjSle798aUpTvRdijWGfzLqyW9v6rTPjHnhNyyvBjiE1WmeIs/Fm/iWOM01vJ30dsSQLd8xjFpYzxre9oUgFXmaPyw/5Tck2/CaCw+x3nsdbIS9E7yyrO3MMryDzFuMHtIzAMfIcbRiBjMJoKfzITjM5KzIuuovZXThidKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755786100; c=relaxed/simple;
	bh=TiBwJFe/nRO7mW633U4ruwZsiS7f5kmzwOmkA8jDJ8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WwjJfkTSJR0fDhFYAxd5AT/v9ZsYgYwx2T0vn0gGCVSpQD26jAtZj2WoGn7+WhWC783uIgFhEG8ITJNILDcG5HQ3f2zf+Rpim8S+oD7ywscG043NBeYWOENUqx9XWDK60xLCk/PdmCQYKVYv8Uds8/ZLV174XI7iaRsvH2d7dPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULo+QUmB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C141C2BCC9;
	Thu, 21 Aug 2025 14:21:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755786099;
	bh=TiBwJFe/nRO7mW633U4ruwZsiS7f5kmzwOmkA8jDJ8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ULo+QUmB54xEzR0C4mSfwuNIvkI0BqwOrRW9zwTCpXX2KoiCZyBzA8LWulT1N/TRE
	 injM4rnqbmpUMHAnQhm43jBXklaQO0JIqq/X/ZfCUGnkVnCdn9gs2jCgWRlzuB4es7
	 AaEIO+oZ49T2gZxFWBllVu9cg0ABIyEaK1aJr5s1L4NVgL9IXxMNH5mqFHIBnn7JJy
	 eV20V956KN9i0ODMDmOR7zx9i4O1GQhSLVMBNRuayqyg0QY2ltyVJra9IvjFvYGXx9
	 ripHaUqePJ84z0uyUlbvn/RhgcEFkdfLWysnG20D2DM7+KJP6sdOpHbTVmRzbQeGMt
	 n7Zcc96zrVysA==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1up6Ab-0000000BT9I-26Yc;
	Thu, 21 Aug 2025 16:21:37 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Kees Cook <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 20/24] docs: kernel_include.py: remove line numbers from parsed-literal
Date: Thu, 21 Aug 2025 16:21:26 +0200
Message-ID: <c09b0aa739574739686da9dc08ebe944fabd3442.1755784930.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755784929.git.mchehab+huawei@kernel.org>
References: <cover.1755784929.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

When parsed-literal directive is added to rawtext, while cross
references will be properly displayed, Sphinx will ignore
line numbers. So, it is not worth adding them.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/sphinx/kernel_include.py | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/Documentation/sphinx/kernel_include.py b/Documentation/sphinx/kernel_include.py
index fd4887f80577..3a1753486319 100755
--- a/Documentation/sphinx/kernel_include.py
+++ b/Documentation/sphinx/kernel_include.py
@@ -171,13 +171,24 @@ class KernelInclude(Include):
         if 'warn-broken' in self.options:
             env._xref_files.add(path)
 
-        if "toc" in self.options:
-            rawtext = parser.gen_toc()
-        else:
+        if "toc" not in self.options:
+
             rawtext = ".. parsed-literal::\n\n" + parser.gen_output()
             self.apply_range(rawtext)
 
-        title = os.path.basename(path)
+            include_lines = statemachine.string2lines(rawtext, tab_width,
+                                                      convert_whitespace=True)
+
+            # Sphinx always blame the ".. <directive>", so placing
+            # line numbers here won't make any difference
+
+            self.state_machine.insert_input(include_lines, path)
+            return []
+
+        # TOC output is a ReST file, not a literal. So, we can add line
+        # numbers
+
+        rawtext = parser.gen_toc()
 
         include_lines = statemachine.string2lines(rawtext, tab_width,
                                                   convert_whitespace=True)
-- 
2.50.1


