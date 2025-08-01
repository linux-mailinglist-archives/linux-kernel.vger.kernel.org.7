Return-Path: <linux-kernel+bounces-752756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4804EB17A86
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 02:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C0661C82223
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 00:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A650B1367;
	Fri,  1 Aug 2025 00:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="BlIlbcrt"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2DE179A3;
	Fri,  1 Aug 2025 00:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754007226; cv=none; b=Yq/pWrJu7odXTSzXVzhT6J83v9kVQhbDl7EqjrBXsyPDymsVEUq1jFrbCEHJmpCbCGL8FskKLqbmBZ7tQFoEWY+bycturPY0J4zbcBdMYauEgnXoJxmhOIKCAdrbbgxGaFZ+bkdslbbS53V6rZlsN6L5DLgcVyE1sBJMvjLTtPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754007226; c=relaxed/simple;
	bh=UikgWuPl67D/fNXakHTxUd2A5vqqMgc5WiNC02gmeGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kbLgqhFikDBpg382TSzdXov6aHT+yMogsS0YaXlnKc+q+9k6DryMINhvNCUlZJzHXmPxN6nGyZGlGAnCoL8TvEOcGV4iT57cCaAHZMvxWXFwJswDtqvWEFGUkTv4qqehhbCEvb5VlFqbbeGOgSvpy2QkqavNxQfMD9Dw5W46dMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=BlIlbcrt; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D958D40AF0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1754007220; bh=XNEzhTSVAQRzQDjIcMHPoA90wuZD9B/p03R0VwgAYLI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BlIlbcrtL3BfQu0xw9JhefSpRJtlD0HAVmNyf+YLe4iWiSrd/wGngYxBsy5tW1vq5
	 BKTO/sOdIm+22avgUcg5xiXh7OQNbE/3cyVTAnq1R8xuAoFc7+m9r6nPFdLGLvaj3s
	 cymdd8uZWnzzO04pajw62DVxUzv8MQodP/bhX37hI/YISJR3RSWZfW3pQuwM/Q4RF3
	 K6VOM3d6V6Csn7xAzglB7cc5KE5BPuUQpBRcyLxbtWDQTH/tZWu0NzrnDkZx9mfdC4
	 wY/sHUqwXjzx7ij+1yL5w7O4q5O2kn2MSRtU8V+Co63QijxYaBZAeNtJVSzw4hLl1v
	 u2edIC/K/owuw==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id D958D40AF0;
	Fri,  1 Aug 2025 00:13:39 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 09/12] docs: kdoc: Some rewrite_struct_members() commenting
Date: Thu, 31 Jul 2025 18:13:23 -0600
Message-ID: <20250801001326.924276-10-corbet@lwn.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250801001326.924276-1-corbet@lwn.net>
References: <20250801001326.924276-1-corbet@lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add comments to rewrite_struct_members() describing what it is actually
doing, and reformat/comment the main struct_members regex so that it is
(more) comprehensible to humans.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/lib/kdoc/kdoc_parser.py | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index b751fa8edde7..20e0a2abe13b 100644
--- a/scripts/lib/kdoc/kdoc_parser.py
+++ b/scripts/lib/kdoc/kdoc_parser.py
@@ -647,22 +647,28 @@ class KernelDoc:
                 return (r.group(1), r.group(3), r.group(2))
         return None
 
+    #
+    # Rewrite the members of a structure or union for easier formatting later on.
+    # Among other things, this function will turn a member like:
+    #
+    #  struct { inner_members; } foo;
+    #
+    # into:
+    #
+    #  struct foo; inner_members;
+    #
     def rewrite_struct_members(self, members):
-        # Split nested struct/union elements
-        #
-        # This loop was simpler at the original kernel-doc perl version, as
-        #   while ($members =~ m/$struct_members/) { ... }
-        # reads 'members' string on each interaction.
         #
-        # Python behavior is different: it parses 'members' only once,
-        # creating a list of tuples from the first interaction.
+        # Process struct/union members from the most deeply nested outward.  The
+        # trick is in the ^{ below - it prevents a match of an outer struct/union
+        # until the inner one has been munged (removing the "{" in the process).
         #
-        # On other words, this won't get nested structs.
-        #
-        # So, we need to have an extra loop on Python to override such
-        # re limitation.
-
-        struct_members = KernRe(r'(struct|union)([^{};]+)(\{)([^{}]*)(\})([^{};]*)(;)')
+        struct_members = KernRe(r'(struct|union)' # 0: declaration type
+                                r'([^{};]+)' 	  # 1: possible name
+                                r'(\{)'
+                                r'([^{}]*)'       # 3: Contents of declaration
+                                r'(\})'
+                                r'([^{};]*)(;)')  # 5: Remaining stuff after declaration
         tuples = struct_members.findall(members)
         while tuples:
             for t in tuples:
-- 
2.50.1


