Return-Path: <linux-kernel+bounces-850286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5F5BD2661
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 11:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AF38189AD48
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 09:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 047602E5430;
	Mon, 13 Oct 2025 09:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="boWZckxU"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33EA26D4EE
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 09:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760349409; cv=none; b=SEF4unPFpuIBYDAYlzY22gNhNK9ZYeLY0Pf+IIQl1OvOC/NAO4odOwLQNro1Qcqs00QLpyw//Z1gaPtCA/DdXyJ6KA4qFtZd3Fh3E5Jv65etwJ/I7Drtjt6jKt173jKt0Wj1tBVp6bRVjFh9l5xXfBX8cSWz9ypmbJTIekNjyok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760349409; c=relaxed/simple;
	bh=osO1ANWf/MtQ51cpeQHzFc47cYEE93PJRkuORtoQPk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rqvbteCMK25lw8MOIZPseMjhd7FdCMG58/jhTfksFPalRn6Ire+YuPfC6oTnZr+7edUM+fnQVMrL0H+/Og9JiBru6gbSujWmlaMHgaujKOo1GkZc6bdFjjnZfFoe6mC/kgmTWVDQggq9OjVtD3cFIEPvq0+iVpRDHyj1wK86Xug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=boWZckxU; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-796f9a8a088so3789349b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 02:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760349407; x=1760954207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+yrBFZp5vtdgalR3uw+8+Z4TKx4WciRTYMlOYaljes=;
        b=boWZckxUH2gljY9tzOV+4GrH2LnfwzJdL3n89Jvv5NzspiZL6FD3Icr0ZaO2mw8Rf4
         0rDbyTYmF02mmGSJapwzZxeTvnInSFeGEFyvk82cY7ECggvZ0pt+x8fHN+bJOAJ91sXx
         Shr76lOmWvDEpOw5p96kAx+Nm8vSntVCse606O4EPjmV9f1yHD/794zlBbafdqBNHmcJ
         KDagsUctOVcZXP6iN0BsXveOX4phgNQDsqU4gFXL0bIEjztz6tHBv9dATRadJV4dIS5V
         nN3tnkehNWPRfygDL/ucg7ZWBTYcG15C8YESMRRBCt9+csfGIrex52d1y7B1wi0Q+esq
         IBOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760349407; x=1760954207;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f+yrBFZp5vtdgalR3uw+8+Z4TKx4WciRTYMlOYaljes=;
        b=kIZ13aGKU3jJs7VaSb9t/wJ7bvNewzXbYEJFaqE9SMaTgErh2dUtxrUXdHDiTGaQLx
         +sxxgDyhyhkd3K79eODqPOpl0s4c3xDJvMn2B6lI+cGUeFjmImH9V0Rwym5NTfkjYZeX
         R22HBQhlE/zjD0YilLU1rOgqRaqkADtaEoTzRRJirFx2CyEaFlzN0fAiAMGzDz8cl6kG
         EHv+AQBObYuCtiiiDZpnW255lv8VIFEJz5t2FljBJhIluWoxdrEvdKsie92ONzAhuzMr
         Er2zfVgR74Q9qI5l+aWTBhr3p/Sc7TAegxm2RRQ9+zB48biRgQ545V9AMERo+qNLt28T
         v5Rw==
X-Gm-Message-State: AOJu0Ywe7PB5BWLhC8sUaglq3MGxdVReaUH1z+RLY1ej3CTnQvLIJINZ
	q53h8dXuxiCkZpMtMD7DNcolc8yFwQP9px6d1igmHxn74bIBNCM8G1sh
X-Gm-Gg: ASbGncty8T5TflzdOSfcvo72bTXVcMRPPeWGXb06POBxNAX8MjcRH1K2dRKmO1HeP8m
	obRNdbivcMNrNUT3d/4Tb5VcqfSnw2XqlhX1DBS5pD4cnyZQk94qcVSHyP7I5PD4GGBb3Jko7z4
	H1eVDGDnUEXNnQgpVulFqFY9HW470vloRB7X2MXnyIdJye8z3rrQAAMDbM/Y2ABSSjNjMkxaPEN
	pTHu/5KiG0M1o5op4yAEPclsTVt8ipNMIIW3Om7Y+5v5HVWb25TNvxgyraRRYW357yhZocoDmuD
	D4AI7rdN9YfyCAoKugd/i/GEXZ7NoAJhzAvEqjhsZGDDJh1BxmWhWjYmAKsPwH9zP/peGlzPn1R
	LTRJ5On/jNYONk3xtWscFTxyFECxl3xV4BGGv2RDE5z3ptdOHF3MNt8Y=
X-Google-Smtp-Source: AGHT+IG4d0UlItFBg2gSZoAXDMDXxcApwjTaXpPj1vdprQgwuvA01VXZjBH1veLt+SCHWSZCYBY1UA==
X-Received: by 2002:a05:6a20:a111:b0:2c9:ff13:bc86 with SMTP id adf61e73a8af0-32da8139429mr27108687637.21.1760349406967;
        Mon, 13 Oct 2025 02:56:46 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992b0607e3sm11349871b3a.11.2025.10.13.02.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 02:56:45 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 83F8F45289A7; Mon, 13 Oct 2025 16:56:43 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Will Deacon <will@kernel.org>,
	Markus Heiser <markus.heiser@darmarit.de>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Silvio Fricke <silvio.fricke@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 2/2] Documentation: assoc_array: Format internal tree layout tables
Date: Mon, 13 Oct 2025 16:56:31 +0700
Message-ID: <20251013095630.34235-4-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013095630.34235-2-bagasdotme@gmail.com>
References: <20251013095630.34235-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3600; i=bagasdotme@gmail.com; h=from:subject; bh=osO1ANWf/MtQ51cpeQHzFc47cYEE93PJRkuORtoQPk8=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBlvzlSsWrrxLT/D/Dbmh9K59dPnqPrJVLHW++cet1wee L7UZYthRykLgxgXg6yYIsukRL6m07uMRC60r3WEmcPKBDKEgYtTACby2JbhD9/Kieun8z08xl3x LnTed0Wpa7PY8mavmHYyLLT57SIu5zJGhhmbprfrJyRxdB5Zztqaovi+slNcjLNhdvNavh9vM3/ 5cQIA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Format tables in "Basic internal tree layout" as reST tables.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
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


