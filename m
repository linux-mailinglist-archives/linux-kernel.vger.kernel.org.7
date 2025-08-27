Return-Path: <linux-kernel+bounces-787544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F85B377A8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 04:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22F2E1B6537C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Aug 2025 02:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A899272E7E;
	Wed, 27 Aug 2025 02:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9YR6ApT"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B3E1C700D;
	Wed, 27 Aug 2025 02:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756261290; cv=none; b=LQbzTBlIi1RHvhV6FENv8ltorl+tHUrmkLNW6VQDI1eA7duxBzRC8UxcgoXRJYau76McsvEgYR6h4lTIch8NIwG341GxUJo1p6SyDIIxI69LhPw8gxz1TsK2YJ8Wtm2/gnYVAyakm0yWHb7Zq/V+A2oQYl9Fv7i3s82EjLrS47Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756261290; c=relaxed/simple;
	bh=+ZVR9Ppk28E2J4qnPmkr6EkpyP7ccUanbegMHUGq/KI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QX4rAeOeHYyn431eJU3Cld1X4VEfFqTZn6aAIXrBvBHxFCwgscsNWSoStfn5YmJPo+QTTTspFB2yjkn+ZebkpDC0ysFm325FLBqg185IP9U5i/hmKChoXZlXxwIzc2qHXX0uBnzkgdshwQ4M5wyKCnq8B0gFRLivLDLmdffZl5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9YR6ApT; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-771ed4a8124so2470175b3a.2;
        Tue, 26 Aug 2025 19:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756261288; x=1756866088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qibv7r9QH5jVvZNBeRJTT/rC//28RtGqi+oX6/1f72I=;
        b=V9YR6ApTJ/O1sL29GsoLqJ16hxfFQuddujIEdBCwIaxnSBK8qJGO52ItUYMzk1xpAR
         cM83A+t9yPauBblKBNffzOrTeClkQfFupvqJBFIHvNdsxU0asyJT2xTNaLeEhiUR+Tzn
         WqZ1rx3ljfVXhsSl6swUBOOtgjhosySuCKFnWF+cbzckeLeY7DWB1zO42h33hRUptgtQ
         0KFPxtbj9pgroOIE2cvxKWorYbRoHwIhLP+gIlCdt2ABs41WPjkfJ0rABi5DP2WiApOT
         5rOiCh/uavgtUA7AvwYiEnLYY+/dgOqQEagVI3WINUkFyviKnWPFHxKAoak7jZnakaJ9
         j05w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756261288; x=1756866088;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qibv7r9QH5jVvZNBeRJTT/rC//28RtGqi+oX6/1f72I=;
        b=jxpRXdxS1XngpB5YJp6HISeT/pCUAw5K6eCc6tmuJaBVFgBiShpF9nIWC29aJdh4jn
         nhEBwJgUVTrUDN8ZyRLPc6piKv90hitMRP/1UNzms22dza7U/IVr7fXYWqcycwQz6IC+
         XN4Eug3O6XoiudxVZsLLXNAETO8ytno1vPh6CfT3qyE1t+DJ2i1/8tcYVzL5rPSdnHv8
         lC3CKMxq3bfWd7doX5rzi2Ex8Nlrk7rujjwKB85cQYXUAKjiREGSWKZ/mNgzJjeSXsWt
         u5gnHWvH1Yo/kFKYu2jRkA1+vrbGPluLfn104FlxXzRvOefT5KoJBJHFjCE4dTnxDCEI
         smDg==
X-Forwarded-Encrypted: i=1; AJvYcCWSeCHcwDwBvKhEimvJ5InlIvtTawLYU32N+1nf7BkoRLlerjvtxc3NiLv7kMivhJhAXRdJVS8o7/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsR5H2egrCMJ43VjJQCRiVm5wHVYi9mpfHyuUMA0uksibM/iBg
	f757UE4TRClWOrdhp4VRs8R3LtHHjLa1r4v/Zt5scraL+2SGo44bhyxttZcTJtME
X-Gm-Gg: ASbGncsqpfRpRWY4hBA6RyZ8DHZDwvs6RkenxMOHYbTXl3712WsCL6VJWhinZhuvukk
	WR08ID68Hw2zM8jM3AZlf3GmpDk3uyPdHO0NFo7TePivEI0RPJJRZT5osyiAvYPWjXURctcPB1K
	fWqaUmx/RpC+okaaLxNZ5jfC/AN2BIA7J/kPSBNuIC6LyM4e8pv6xS6zJ7hk/dcXLbVkoQaH6+a
	gIC8b4xLYyNe1GvkQMQaXw1qlP3uzJa2sdhqfhgD0dRtnzhh/zh4L6g7zgahPqycXssGyt1bFOv
	EYDMwszGjcbDOTZoXJhoUks0PSn5iV9VbWa1kYm0RIBtcmzTySHlnj3lyhwDRcSVFU64QdD1C7Z
	NbUicMD606iNrjepBNnrITA==
X-Google-Smtp-Source: AGHT+IFjTD8x2VGb975Gtlblzp8JBLZaUMkNK+9zmVIvPYqOW88mYas5zqSDQMegGiWkV9iU9pcz5w==
X-Received: by 2002:a05:6a00:1793:b0:771:f852:4529 with SMTP id d2e1a72fcca58-771f8524884mr7535006b3a.13.1756261287905;
        Tue, 26 Aug 2025 19:21:27 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77040215c40sm11656556b3a.96.2025.08.26.19.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 19:21:27 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 2CF59424BFD0; Wed, 27 Aug 2025 09:21:25 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux GFS2 <gfs2@lists.linux.dev>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Chen Linxuan <chenlinxuan@uniontech.com>,
	James Morse <james.morse@arm.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v2] Documentation: gfs2: Consolidate GFS2 docs into its own subdirectory
Date: Wed, 27 Aug 2025 09:21:22 +0700
Message-ID: <20250827022122.12132-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3716; i=bagasdotme@gmail.com; h=from:subject; bh=+ZVR9Ppk28E2J4qnPmkr6EkpyP7ccUanbegMHUGq/KI=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBnrsgWX3s1xPTdBZvu9zRvNBYXmvaxWfp1et+qIY1fdp L0RD39bdpSyMIhxMciKKbJMSuRrOr3LSORC+1pHmDmsTCBDGLg4BWAiLbsZ/tc8WXouaFFW3dSG rXVmrwXPN/ntCPiy8dUag6kBd9+8XF7EyHBzAmdobrHGqSvNodLXHm7+PnPrxyfrtxyZrfF/58P pH5dyAQA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Documentation for GFS2 is scattered in three docs that are in
Documentation/filesystems/ directory. As these docs are standing out as
a group, move them into separate gfs2/ subdirectory.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Changes since v1 [1]:

   * Strip gfs2- prefix (Matthew)

 [1]: https://lore.kernel.org/linux-doc/20250826023913.14888-1-bagasdotme@gmail.com/

 .../filesystems/{gfs2-glocks.rst => gfs2/glocks.rst} |  0
 Documentation/filesystems/gfs2/index.rst             | 12 ++++++++++++
 .../filesystems/{gfs2.rst => gfs2/overview.rst}      |  6 +++---
 .../{gfs2-uevents.rst => gfs2/uevents.rst}           |  0
 Documentation/filesystems/index.rst                  |  4 +---
 MAINTAINERS                                          |  2 +-
 6 files changed, 17 insertions(+), 7 deletions(-)
 rename Documentation/filesystems/{gfs2-glocks.rst => gfs2/glocks.rst} (100%)
 create mode 100644 Documentation/filesystems/gfs2/index.rst
 rename Documentation/filesystems/{gfs2.rst => gfs2/overview.rst} (96%)
 rename Documentation/filesystems/{gfs2-uevents.rst => gfs2/uevents.rst} (100%)

diff --git a/Documentation/filesystems/gfs2-glocks.rst b/Documentation/filesystems/gfs2/glocks.rst
similarity index 100%
rename from Documentation/filesystems/gfs2-glocks.rst
rename to Documentation/filesystems/gfs2/glocks.rst
diff --git a/Documentation/filesystems/gfs2/index.rst b/Documentation/filesystems/gfs2/index.rst
new file mode 100644
index 00000000000000..9d9ca84d45a7ae
--- /dev/null
+++ b/Documentation/filesystems/gfs2/index.rst
@@ -0,0 +1,12 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+====================
+Global File System 2
+====================
+
+.. toctree::
+   :maxdepth: 1
+
+   overview
+   glocks
+   uevents
diff --git a/Documentation/filesystems/gfs2.rst b/Documentation/filesystems/gfs2/overview.rst
similarity index 96%
rename from Documentation/filesystems/gfs2.rst
rename to Documentation/filesystems/gfs2/overview.rst
index 1bc48a13430c1c..f971353d23611c 100644
--- a/Documentation/filesystems/gfs2.rst
+++ b/Documentation/filesystems/gfs2/overview.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-====================
-Global File System 2
-====================
+=============
+GFS2 Overview
+=============
 
 GFS2 is a cluster file system. It allows a cluster of computers to
 simultaneously use a block device that is shared between them (with FC,
diff --git a/Documentation/filesystems/gfs2-uevents.rst b/Documentation/filesystems/gfs2/uevents.rst
similarity index 100%
rename from Documentation/filesystems/gfs2-uevents.rst
rename to Documentation/filesystems/gfs2/uevents.rst
diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 11a599387266a4..897eabaa30d65d 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -90,9 +90,7 @@ Documentation for filesystem implementations.
    ext3
    ext4/index
    f2fs
-   gfs2
-   gfs2-uevents
-   gfs2-glocks
+   gfs2/index
    hfs
    hfsplus
    hpfs
diff --git a/MAINTAINERS b/MAINTAINERS
index dafc1171254406..c685140f78c4e9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10335,7 +10335,7 @@ L:	gfs2@lists.linux.dev
 S:	Supported
 B:	https://bugzilla.kernel.org/enter_bug.cgi?product=File%20System&component=gfs2
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git
-F:	Documentation/filesystems/gfs2*
+F:	Documentation/filesystems/gfs2/*
 F:	fs/gfs2/
 F:	include/uapi/linux/gfs2_ondisk.h
 

base-commit: ee9a6691935490dc39605882b41b9452844d5e4e
-- 
An old man doll... just what I always wanted! - Clara


