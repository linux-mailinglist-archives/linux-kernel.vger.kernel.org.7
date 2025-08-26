Return-Path: <linux-kernel+bounces-785852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AA93B351CE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 04:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CD242455E7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 02:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8612701C4;
	Tue, 26 Aug 2025 02:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOvCBkoK"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEC621FF25;
	Tue, 26 Aug 2025 02:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756175970; cv=none; b=M8/elO0KDbis4SF81Vf9OwQOP6ohTaILpFBVyBtS806IEKEQ06sxQUaTSpTIDFJ3WmCRLOQ66T5FNcGbiTzigrs/ncblK5qqCTPIm+Dw9f8nPfr2KznrpEQH1KoiZGrDgugbregIxcHD4SX3C6VnbajY0w7ZnXpGrD8iKkHk4pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756175970; c=relaxed/simple;
	bh=xHs+l2pfnza2uc+5614jN3sm82wrUYBarOeH9qm4DmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d/+BHHhd5KmnxMiM1RCW4CyfuLbvJr9eZVGekVrUY4/2hvc2iMzsGNrFaQmJRiI4ZWGboDtJdGFFpnVvoduu+aLuHBxpS01HrJkyDFq4E7iqwXhNny9GMgpmw4wdYGuwgYCiO5XKLbgZ656+0WS+5b8GwksvyeKmRKLEa8IV7go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lOvCBkoK; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-246fc803b90so10926475ad.3;
        Mon, 25 Aug 2025 19:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756175968; x=1756780768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GQynW9QiNkC8m7UhwgLmWwZBf8g2MjsE/2KafsbAG70=;
        b=lOvCBkoK3eQzbCvZO0S2MVgyqaMcfAj9MuBXg22O60NXHQTmUtEASXRzeRcDapOVuU
         1Ep8deAxBGBWnfcFT8v3/fuH5xKAHhPk98m4S1d0061mhctxdnOytaD1AUjb4x5lYY0y
         LJTHbpFgpfc7Nowccnp/BZz+5QnqnMw/nmXmn/Ot7HiaXlOraoP+sK+Fu3XUDb88NXS7
         xDpf17DRpYy5mWNAVr5S4K9yOjQ7lpj0DUWqObCmLw/zvHlXCSgC+NqsI5J5fXlWJOs+
         oU8fyNO4WGltEFcLt0OKxk+5gWm1rAtg5w2XqvMn8S6nWsTIThMEciKou88gzle3jfPo
         Zf7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756175968; x=1756780768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GQynW9QiNkC8m7UhwgLmWwZBf8g2MjsE/2KafsbAG70=;
        b=ihN4LVwCUIkbpVW2LkQePTwiemICnHfQTGMJdF3gm9Lg+7cBRje2rUT/Gi5YeEhfcF
         sWUfFrjnxl6Xd9Wv+qR1Dov1+9PvG5FEd5PcM/dIH3PAtV2X8wfqyiavjxHJgtRpC/7/
         Qar+a4fgbh/WgtlAHufA9K/RrpFHZSI+RrXvjbBVkG0nNId3vMhP44bgDlq0HZC2YiaL
         LhpHZHnmhBP9kPXRrMvlQLKM6CAJyAWxUGwuXGw1h1nL6nXsOFoI4VteZBpuVGpWEEYP
         /dTbckt+aJv8gf6P6pStSiyG1lXvgu04UMVTmUJEI8qoPNJf7P5B4Gs16fuHbxCVYG8m
         ZN4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXIyY28I79F6L+qoa3rZQosa40WlfPxfR2JsAlyx+qqWZY+oDsVfBbFAWt4iJV8KN05ybTOxKuiCfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlevH08Jhn2zrlsY7FQH58dhOvyaBpvzzwuWWxw98uLBenAzOt
	2pXNte0i/YRS3ylQ0prVTvoYm5AJ5VMtbRr0ZNgsrGap2yHqQxFKbGLF
X-Gm-Gg: ASbGncv5ENm06i5ODSYaEuFM0bNV36ygBTQFkJJ+I9flYIGxQyKIW4sNtqWphlnb45Q
	532m0Q0EKzv32d1u7ASBwPu+4M/wO7rffM5xdSN4kBi4e6x5bvme5/SM1KnEccfvOHkDoMQvrep
	bLdF/W1BhmpV1EPI3vMupHNB1EZmfpkLHrLjb/abjH5rcHmfhIHJNjiVXWRZh/+Bg2L3i+JHKz3
	GVFnqNHBt5eqrMmPcXndTlXPrHKs/bmvHs1Fx8Qad81FIU6yifwtnEpBmmmBfHJwqdWpshPqoV3
	ir4g9YC1m+5vMbLX+CEEzg/cqfPC9w5hI2Ric3sw5VoKHv/MhzXHL7r4J3az9RPQJSusROCalt6
	LTV5z0kEoWJ4OPhXCHiuWEBfZfVPEkYj1
X-Google-Smtp-Source: AGHT+IHmEMMHHRcOtgYg4LZPSqkm+z1dB2t0mOOt5Ny373ENmShez272ct4ZPtzZLFkpespJvpgnXw==
X-Received: by 2002:a17:903:40c5:b0:246:cc19:17eb with SMTP id d9443c01a7336-246cc19229dmr84410505ad.19.1756175967819;
        Mon, 25 Aug 2025 19:39:27 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246688645e1sm81074495ad.79.2025.08.25.19.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 19:39:27 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id F1D89424E25B; Tue, 26 Aug 2025 09:39:24 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux GFS2 <gfs2@lists.linux.dev>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Chen Linxuan <chenlinxuan@uniontech.com>,
	James Morse <james.morse@arm.com>
Subject: [PATCH] Documentation: gfs2: Consolidate GFS2 docs into its own subdirectory
Date: Tue, 26 Aug 2025 09:39:13 +0700
Message-ID: <20250826023913.14888-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3546; i=bagasdotme@gmail.com; h=from:subject; bh=xHs+l2pfnza2uc+5614jN3sm82wrUYBarOeH9qm4DmQ=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBlrpc+b6eVttHk4QULvlVNuZ8DC2+fO26vuzpz3WOHPu 3nM6mZ6HaUsDGJcDLJiiiyTEvmaTu8yErnQvtYRZg4rE8gQBi5OAZjIE26G/8GMYY3fpk2Ikrjl 8Fm9ni3414OjBUtvaHLs1Dq/+setVXcZGV6pcTkd2HVnS7nYYlbDKZdWaVaHvn8UuU/wP/PptsZ b01kB
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Documentation for GFS2 is scattered in three docs that are in
Documentation/filesystems/ directory. As these docs are standing out as
a group, move them into separate gfs2/ subdirectory.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/filesystems/{ => gfs2}/gfs2-glocks.rst |  0
 .../filesystems/{ => gfs2}/gfs2-uevents.rst          |  0
 Documentation/filesystems/{ => gfs2}/gfs2.rst        |  6 +++---
 Documentation/filesystems/gfs2/index.rst             | 12 ++++++++++++
 Documentation/filesystems/index.rst                  |  4 +---
 MAINTAINERS                                          |  2 +-
 6 files changed, 17 insertions(+), 7 deletions(-)
 rename Documentation/filesystems/{ => gfs2}/gfs2-glocks.rst (100%)
 rename Documentation/filesystems/{ => gfs2}/gfs2-uevents.rst (100%)
 rename Documentation/filesystems/{ => gfs2}/gfs2.rst (96%)
 create mode 100644 Documentation/filesystems/gfs2/index.rst

diff --git a/Documentation/filesystems/gfs2-glocks.rst b/Documentation/filesystems/gfs2/gfs2-glocks.rst
similarity index 100%
rename from Documentation/filesystems/gfs2-glocks.rst
rename to Documentation/filesystems/gfs2/gfs2-glocks.rst
diff --git a/Documentation/filesystems/gfs2-uevents.rst b/Documentation/filesystems/gfs2/gfs2-uevents.rst
similarity index 100%
rename from Documentation/filesystems/gfs2-uevents.rst
rename to Documentation/filesystems/gfs2/gfs2-uevents.rst
diff --git a/Documentation/filesystems/gfs2.rst b/Documentation/filesystems/gfs2/gfs2.rst
similarity index 96%
rename from Documentation/filesystems/gfs2.rst
rename to Documentation/filesystems/gfs2/gfs2.rst
index 1bc48a13430c1c..f971353d23611c 100644
--- a/Documentation/filesystems/gfs2.rst
+++ b/Documentation/filesystems/gfs2/gfs2.rst
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
diff --git a/Documentation/filesystems/gfs2/index.rst b/Documentation/filesystems/gfs2/index.rst
new file mode 100644
index 00000000000000..3875b9e1bb5cd7
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
+   gfs2
+   gfs2-glocks
+   gfs2-uevents
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


