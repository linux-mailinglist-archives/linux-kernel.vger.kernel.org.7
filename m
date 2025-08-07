Return-Path: <linux-kernel+bounces-759537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EAE6B1DEC6
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 23:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FFB77B1EA0
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Aug 2025 21:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6907274FFB;
	Thu,  7 Aug 2025 21:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="O9TvI0v4"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8144326CE1C;
	Thu,  7 Aug 2025 21:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754601420; cv=none; b=Dx0zYLErBKhoJmfgtOceorpwq3bRX4SxQSBC7fmsSIHMeyEmEGuOJjeOBfbMAj38WCzNxU6Vavp2qTGGDMBrjE7ZQVhCJXTP4UAOBjmf9PGLFIB+GhrEEZizSLAZpgUvGxcGdQewNhNDFHSx5rbKCg1b2tS3b79bMu73A2q321k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754601420; c=relaxed/simple;
	bh=UataK2dH+WS9Ga0PirdCnTHcjTjTrYaaKiJkDBGN1II=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uLrBsTfUcMlw0F+mc2KVjvu8Yl1BlUOAqwkaaUqUQv50fV8pI2ogBzlbmgm/qdzsbh0dpWoMKvV5aLUQRAQcqz4/uni4EtwIAVeOqJBC7loX9gXABZ9ZUZ2vN55s2gVvFGNWeCd1DzbnqFMTqjLQqll6DLJNaXU7tw7/2GQv46A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=O9TvI0v4; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0D1D840AF1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1754601414; bh=cRTibWquOyDOZaMN4U55xfQZDUSokjnEvoTYB0ZSrfc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O9TvI0v4RgTtAVquWuSerC+VLTJeMz2pRy6fO0iW68YFYIWF5bQOdi3eRxAVgo+xk
	 pinsovL793hKqMtT/6375X+6qrPwB0+147eCq38AmqlJkcGGOi7ANyZV0jz9pl5F7B
	 so+OX6/CojucfQXuwJ1KUI23itHTFpEcyoH0NfrKmeVS6mzL14rj/hGVgndoPTFWFt
	 F58iu2CeLCd64IOyTXZ6L2u6hlyJKFBeP6XlL9Yx9nKgCj2SvuX9za6d3j65olcioN
	 j7idBTr/TGLJaKTemW0dzHnPVeL1SydrJdyD8rgVgHgNTP4zKxNhY5fnegEh7YFTSc
	 3CiTZPb3hIMFQ==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:4600:2da9::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 0D1D840AF1;
	Thu,  7 Aug 2025 21:16:54 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Akira Yokosawa <akiyks@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 09/12] docs: kdoc: Some rewrite_struct_members() commenting
Date: Thu,  7 Aug 2025 15:16:36 -0600
Message-ID: <20250807211639.47286-10-corbet@lwn.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250807211639.47286-1-corbet@lwn.net>
References: <20250807211639.47286-1-corbet@lwn.net>
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

Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 scripts/lib/kdoc/kdoc_parser.py | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/scripts/lib/kdoc/kdoc_parser.py b/scripts/lib/kdoc/kdoc_parser.py
index 0c279aa802a0..e3d0270b1a19 100644
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
-        struct_members = KernRe(r'(struct|union)([^\{\};]+)(\{)([^\{\}]*)(\})([^\{\};]*)(;)')
+        struct_members = KernRe(r'(struct|union)'   # 0: declaration type
+                                r'([^\{\};]+)' 	    # 1: possible name
+                                r'(\{)'
+                                r'([^\{\}]*)'       # 3: Contents of declaration
+                                r'(\})'
+                                r'([^\{\};]*)(;)')  # 5: Remaining stuff after declaration
         tuples = struct_members.findall(members)
         while tuples:
             for t in tuples:
-- 
2.50.1


