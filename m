Return-Path: <linux-kernel+bounces-825460-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F068AB8BD92
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 04:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3B15566D19
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 02:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395F21FC104;
	Sat, 20 Sep 2025 02:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDs4+W4W"
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169CA1D7E5C
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 02:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758336193; cv=none; b=i+hHmuz/zuIQBRxG2xsdXmo5LyKP8wuiW7C71kRaAoZER8x03xzVeXm4TpC8s1xiTEleZynyVFdFw/tQntCX5G+9u7wEhpA4ZkxwCe+boSEczHhQLypOT5V6l4bfnLJwHsISEKQjcBnij3WVk7DcYLdhkCrpJHL3C321aaEoI4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758336193; c=relaxed/simple;
	bh=DDKJTv2gUhx9NT8eq3N7/s/2EXymv1Z6SzQngx6JskI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c+4okiRgZBpNQCQdrWd0AT7enUwp5rcjzwWszA4a1WXrOXl+003m87+ze3aJp98tTw19Bt7S8YrvaX0GrPytepdtlNtPDscAlbuscJlGbeD/o/3np+nKcYGwe4pBnPyTSitR4uBa9COfOomTh/iusm2S4IRJbsK6ZUhUC+ruIko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SDs4+W4W; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b4755f37c3eso2399091a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 19:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758336191; x=1758940991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=poa66ZgSmeh+4H17NCB38PC7vFoDWQ1JOuDGdup6VRM=;
        b=SDs4+W4WYWju8f9SjeM/aTUyTb14+mx8gG1jMeBNjZZKI7OgzMxwZ4VOxbslwWWXHp
         jTrolsIJjiUrTIRsysMwb5b/s5+OSe8T4W06ZHawdzK1zgA6Z9FNHyYeXqY8T7aQiiNx
         K74jjIqR+DU8r2s1owa4SkmtEGCq+Yt8IuLedOgzJ4BWkz3IIdI9UuXfDY482fu18C8x
         hvsYvGWGNSVMey7Q/TKsOq7/FwWovnqUb2cm0rj0Bi1YQVRJHhwj4XyKRWL+0NGU9ZpO
         NTWdEFP7mCVe0evjyfM95pcWA9uHshMYdwIZzam6zlU4x8qThICdSkL61j38H5SNPjZl
         x9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758336191; x=1758940991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=poa66ZgSmeh+4H17NCB38PC7vFoDWQ1JOuDGdup6VRM=;
        b=MeTmXg1ZxCIM+YxJdAsy69wGvKJAayJ+4K7zVLh1OIluxqFtvLG386TAzP743rZH7b
         qQw4kq3PKoOmyjcWWwIAUaUulNL4gMh9y3AfBeFJZB18fWLwYpJFhrGd8UcYptHLzmF/
         IDG6eHsKWZGVGrPRAMv+rl/1fm3qbbwe57Bls/avJ7vJonK8ag+JCWpuDpSaZ/Kr9Fme
         mE0n0KJyDz6Tz4tcbgTQ83aL/X3oOvXymr89aq+Iozhcl0/NwXltreOUvxA11F3vnjXS
         YhdCjEyb7s9v0ngxtl4GUqMzotfCOk7gWICUg1iqUmD8w3bO8M1sGXE6wr9fFwS58Oyq
         nxwg==
X-Gm-Message-State: AOJu0Yw9ZIF72IBtZgZt42sjrzAG94w8iY1+RgD1iQy0oB86wh8vsVgq
	PbHk+/c9O4cQHL8b0K+a5astaTxLY1rrT01zNbs1Hcq1/y2+sfUJ2f32
X-Gm-Gg: ASbGnct4lK1q0K8rqrX4fLAJoL/QO4wAMg+24iHE6JY89Dlu2qmv5CfQTWpZ4pduJe4
	FWHnMCGpT0RMpo5oacxaoaW1yB4p8T1r5SOdP87+fnmL5mKiwlTfLNPJibPNimcyitqppupGJIP
	v8KiXiGiPX+iNV81ARrS8NBSwOCixIwJgkMrrccnJcwm8DNxdJ340o85Z+JedF/EaXlmRF9QGKO
	kCejlB/bT9JUnvjFe19lRNAs+Wp0dj0Cf5IECtZMeuX2ldUO1im9V4bsDhCR/8g3zNba/1T55bU
	2efkM3j+ZA7H/IF6HyOSX9eqe2hTaOmodeUinPRJCVeQMrSSLvJbK/u7gmk46LBe9lxofnr9XW2
	WvugqPBmRh79/fyVfTm4MbDhVpcDwylbJ
X-Google-Smtp-Source: AGHT+IF/BI612rR/YcMFm6BDriwszkiWQ3lawEOyMeF1XwV/NPEU1DpX9s0SVrJuvUX8PVyswbJ/Bg==
X-Received: by 2002:a17:903:2f08:b0:25c:982e:2b1d with SMTP id d9443c01a7336-269ba567414mr68110295ad.59.1758336191220;
        Fri, 19 Sep 2025 19:43:11 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3306085e6dcsm6813162a91.29.2025.09.19.19.43.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 19:43:10 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 4F7DE4227237; Sat, 20 Sep 2025 09:43:08 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Will Deacon <will@kernel.org>,
	Markus Heiser <markus.heiser@darmarit.de>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Silvio Fricke <silvio.fricke@gmail.com>
Subject: [PATCH 2/2] Documentation: assoc_array: Format internal tree layout tables
Date: Sat, 20 Sep 2025 09:42:28 +0700
Message-ID: <20250920024227.19474-4-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250920024227.19474-2-bagasdotme@gmail.com>
References: <20250920024227.19474-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3500; i=bagasdotme@gmail.com; h=from:subject; bh=DDKJTv2gUhx9NT8eq3N7/s/2EXymv1Z6SzQngx6JskI=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBnnhDMlljVIJDDknZ++KvkKW0jw5wk1r6pWNqbKq78za liW9y+3o5SFQYyLQVZMkWVSIl/T6V1GIhfa1zrCzGFlAhnCwMUpABOpamFkuPV1jtOuBbu331Hp zz11JVxT9/acACnuzPCcD9fWtjxdXsTIsK6dO/lXcXjF/pclnlfV57hWCzxcrbji9poJT66kic4 34AQA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Format tables in "Basic internal tree layout" as reST tables.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/core-api/assoc_array.rst | 33 ++++++++++++++++----------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/Documentation/core-api/assoc_array.rst b/Documentation/core-api/assoc_array.rst
index 61c7ba1e7b877f..19d89f92bf8da8 100644
--- a/Documentation/core-api/assoc_array.rst
+++ b/Documentation/core-api/assoc_array.rst
@@ -317,8 +317,7 @@ There are two functions for accessing an associative array:
    modified, provided the RCU read lock is held.
 
    The function will return the object if found (and set ``*_type`` to the
-   object
-   type) or will return ``NULL`` if the object was not found.
+   object type) or will return ``NULL`` if the object was not found.
 
 
 Index Key Form
@@ -400,10 +399,11 @@ fixed levels.  For example::
 
 In the above example, there are 7 nodes (A-G), each with 16 slots (0-f).
 Assuming no other meta data nodes in the tree, the key space is divided
-thusly::
+thusly:
 
+    ===========     ====
     KEY PREFIX      NODE
-    ==========      ====
+    ===========     ====
     137*            D
     138*            E
     13[0-69-f]*     C
@@ -411,10 +411,12 @@ thusly::
     e6*             G
     e[0-57-f]*      F
     [02-df]*        A
+    ===========     ====
 
 So, for instance, keys with the following example index keys will be found in
-the appropriate nodes::
+the appropriate nodes:
 
+    =============== ======= ====
     INDEX KEY       PREFIX  NODE
     =============== ======= ====
     13694892892489  13      C
@@ -423,12 +425,13 @@ the appropriate nodes::
     138bbb89003093  138     E
     1394879524789   12      C
     1458952489      1       B
-    9431809de993ba  -       A
-    b4542910809cd   -       A
+    9431809de993ba  \-      A
+    b4542910809cd   \-      A
     e5284310def98   e       F
     e68428974237    e6      G
     e7fffcbd443     e       F
-    f3842239082     -       A
+    f3842239082     \-      A
+    =============== ======= ====
 
 To save memory, if a node can hold all the leaves in its portion of keyspace,
 then the node will have all those leaves in it and will not have any metadata
@@ -442,8 +445,9 @@ metadata pointer.  If the metadata pointer is there, any leaf whose key matches
 the metadata key prefix must be in the subtree that the metadata pointer points
 to.
 
-In the above example list of index keys, node A will contain::
+In the above example list of index keys, node A will contain:
 
+    ====    =============== ==================
     SLOT    CONTENT         INDEX KEY (PREFIX)
     ====    =============== ==================
     1       PTR TO NODE B   1*
@@ -451,11 +455,16 @@ In the above example list of index keys, node A will contain::
     any     LEAF            b4542910809cd
     e       PTR TO NODE F   e*
     any     LEAF            f3842239082
+    ====    =============== ==================
 
-and node B::
+and node B:
 
-    3	PTR TO NODE C	13*
-    any	LEAF		1458952489
+    ====    =============== ==================
+    SLOT    CONTENT         INDEX KEY (PREFIX)
+    ====    =============== ==================
+    3       PTR TO NODE C   13*
+    any     LEAF            1458952489
+    ====    =============== ==================
 
 
 Shortcuts
-- 
An old man doll... just what I always wanted! - Clara


