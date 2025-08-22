Return-Path: <linux-kernel+bounces-782145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D25DAB31BAE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 16:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E99CE621D22
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626C8343203;
	Fri, 22 Aug 2025 14:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnZoaR8m"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11694312806;
	Fri, 22 Aug 2025 14:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755872389; cv=none; b=N7Nq4vZ0e23o3QDPeB5fn18MmhXjfWjKGlARjkPrAALj2BaF/m/Ja+N7CjmVLNVkKi2rv/DYnHPA9iGAh8u94eq0jINM2Ogl0lmrbFa/QdN7nwCE4dAJYxie7DnvQcHA0k+wEfH4n6XTR6GMIWAcE9AIb/QrJv9MNLUFjuHyqhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755872389; c=relaxed/simple;
	bh=TiBwJFe/nRO7mW633U4ruwZsiS7f5kmzwOmkA8jDJ8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EzgrHagGB8MnaLjKZgHejJ945dr157sBl4vJZdQ8ws/KGLbvlrFtoHncd2EScQvK2lTNZwUHtQrP1Ab96PepeJ5lu5kjS2QIKpCYxprx922QBa1tkyNAC/mEaQqx6F4ImD6uNSe3Hpa5PcrOkTLvfg0FE6RHcz8xwAOrOSAE01o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cnZoaR8m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CF74C4AF0B;
	Fri, 22 Aug 2025 14:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755872388;
	bh=TiBwJFe/nRO7mW633U4ruwZsiS7f5kmzwOmkA8jDJ8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cnZoaR8mkqWdkhXogG36OiOzzru0Q6F7fY9vMqdWMxvZ31bkmVwl52w7x7dWtmhaY
	 JkbG2COElI/BIJMRBEwcjkL0vWWFJkuHvVpOhhtYS66oVh9Q730sNv1q3C6NAroF8N
	 4HuhUUIwa8/5Gpj1kdzENRtehmRX2VV9AxlepiaNx14v7uBuUBTWoNZBR9iCqOTuYM
	 IcM7nOvztBIdGuxbbJ4uaPSv5BjUoV2mfML0QrF+atwB0sssFFHpy7VFzG/ub2O2nk
	 TGxXySWuxgMNWLeM4guToi46M8saTRq0gSkN+OCyhEYLibHvIVa6UyeIVXJrbcPDdo
	 ByYC5yMsFBJ8w==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.2)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1upScM-0000000CCsB-2ebD;
	Fri, 22 Aug 2025 16:19:46 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Mauro Carvalho Chehab" <mchehab+huawei@kernel.org>,
	Kees Cook <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 20/24] docs: kernel_include.py: remove line numbers from parsed-literal
Date: Fri, 22 Aug 2025 16:19:32 +0200
Message-ID: <b484fe5fcbf6e5217f112f205fbf54f0bbc3dcca.1755872208.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755872208.git.mchehab+huawei@kernel.org>
References: <cover.1755872208.git.mchehab+huawei@kernel.org>
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


