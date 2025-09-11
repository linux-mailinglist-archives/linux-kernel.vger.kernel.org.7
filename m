Return-Path: <linux-kernel+bounces-811163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA11B52518
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 02:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90E727B636B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 00:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC78D1B21BF;
	Thu, 11 Sep 2025 00:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzPXxdqC"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC56E1A9F94;
	Thu, 11 Sep 2025 00:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757551489; cv=none; b=e3F5VW3i/Dpjxp8wlRgD+tkwvWAm8ErXX59Te+Y/t/YjEfIvea4lAGeNl0pSXBbH+ICcXvi5AiZoiNAJMXmvGCzpfv2vvjiAWmaD1aSazPcmvpKoYgU8S66GYpT2rJ4HyIRIAcaByAUhsLiR3O9+u+Tc1ey22wuNd3veMZ9A1Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757551489; c=relaxed/simple;
	bh=HCW13knBhT7RFy7HDKQQcC+dfTeWFpruSeLFZ+02xhI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fo4mZ7iGCzLjAWe+nLP4Eyz6K1ANh9be9lSJ483HSn7fU9oG1sKp3jV2ig8GGaPJbylhqcliJJR9tjO9389HYWmtP+O34jrdVwmRHyhu1LMGCE6XFSIHVU6TEn6wwmVyBsM/MhcJq6Iix3bEbKiTIP5xR5wLxzqX3Me7W+WqKgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lzPXxdqC; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-32b60a9aa4cso85895a91.0;
        Wed, 10 Sep 2025 17:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757551487; x=1758156287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BpySo3NLnF3NQPlDF6BjVjWyIhuBi9Js7xK/Y+fCdkg=;
        b=lzPXxdqCZAXNSU4jCa68ygtMN9UYqrQ9MfbP2nJGAcjMeKh5smw9gd38m5lSwF0jL3
         03s0cRiCueioC9iJ9UJPuE/+3Cj8/RSEIi3qr4FeFOLW8qQJ8I2ANcjTFQFnea45WNme
         WodBskekjAJHLdShKhWZrlRZWDXZ8YrKspd9qbuYFNJKO3TyYT9EXl809hkQWl9ZdERV
         8Bql5AdGGnwbv1vvWrlMbdQ4hBNXunby7u4kHAZvqa7QqTFprdB7ZAcNaHMIIKb+NHA+
         EaUqN3jzR6RxCz1y5wQrfJIbmWlO6L1PK6VQg9an2Xzc8QikFVk9LseOJtuyNY2K42lz
         vDnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757551487; x=1758156287;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BpySo3NLnF3NQPlDF6BjVjWyIhuBi9Js7xK/Y+fCdkg=;
        b=nbYXeYxwyiMDrv9ais5btP5vAmbD5Q8BD6eShGkq671Khb+SqOAIYZthFp8sRSXGfM
         s1wTUvOX3sFyXHjyoqXD/0fBNVaQGjwqvf22NBh30LZ93mMmFon0JdSmOF5TI3PIJhak
         aQbqT4O0+LNNczzT/zQJ3gXai68CTjZe3SxQAi45ksNPx+aCfMp/zJWCD72KfpQc0exx
         zhq762NA/aTsZVwBf4UNDMCWYrbyyKae8P/3Vuw/IoStTHiStMqfcsJqVKr8Pgj9e3R6
         2tL5MTDeQ+6wqmldrm77kMmtXlQp/VkctxehcAcxw6gLgfYUr8s2oX2RdeWXd/DiB53Q
         eulg==
X-Forwarded-Encrypted: i=1; AJvYcCWjfuwQ8Z8OpEDJWQjXzw7dxCQXqvv8mHlsBArxb/vfVGgKzmdp6+waUtOOWT0oSOciJP6xeoyHAQw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4VNBDE1wyxz6MX7zzhSjwqEiyUKOaDeXC0Q8BB4uuVRwB9xFa
	3PYcFEIIq5+XrVk8TufmE7rzmv/jadJSxIeJ14zOclxdu/I0RW6u1bQw
X-Gm-Gg: ASbGncsLUPEhrzqClu+jMBNKFAiGn0U/TO9DUkuM/AcBYTkhilnFZWC3xW2CKDHrf2H
	p6zGf9IB3sw5Wms9xdD0pAsD2vUFg3X6MNmuNJgtWuoO1rvjCfwE41QPt3rqg8KIbi2JFauyys7
	PFpjSF1jKcwVEKsgZ11QQMmRi+rtBWnNNeEGIoRkIoNgA+l9DfvpaWRMU+QzYFKDwaCj1hYi3QY
	lpE+5S0Cgm5OP9WsJg4Af5Om9w0xwc7aCALkt6PWRQmdI6suVtB/xTEID8k9mWtemE+WYLzkv4m
	jWXenMikB28ycJL18atTDCPBILhenCsSKQuDK2o42qokX6Eh0s9VTQV6YoL8KA8QGMs+GDxRT+4
	3wotDtol4mC4lKrntifqdswj8+HQd+bTcVj5P
X-Google-Smtp-Source: AGHT+IHjmPZWDl9vb0uIHl2eRmaTWkqg9sSefNMn2g+fVPHeFXt0Fk772YcKBqrgPaf3/cb0zvSmbQ==
X-Received: by 2002:a17:90b:1f8c:b0:32b:9bec:158f with SMTP id 98e67ed59e1d1-32d43fc44abmr20864742a91.29.1757551486936;
        Wed, 10 Sep 2025 17:44:46 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd54e6e0csm293105a91.0.2025.09.10.17.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 17:44:46 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 62C4B420A6BE; Thu, 11 Sep 2025 07:44:43 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux GFS2 <gfs2@lists.linux.dev>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	James Morse <james.morse@arm.com>,
	Bernd Schubert <bschubert@ddn.com>,
	Chen Linxuan <chenlinxuan@uniontech.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v4] Documentation: gfs2: Consolidate GFS2 docs into its own subdirectory
Date: Thu, 11 Sep 2025 07:44:17 +0700
Message-ID: <20250911004416.8663-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3561; i=bagasdotme@gmail.com; h=from:subject; bh=HCW13knBhT7RFy7HDKQQcC+dfTeWFpruSeLFZ+02xhI=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBmHpM7/Ed5mkx2surRfe7aD0Ioqxcnzb5/Zyl/q/P/4k usswg3MHaUsDGJcDLJiiiyTEvmaTu8yErnQvtYRZg4rE8gQBi5OAZjI1NWMDFMfeuy2nlZv5LZS XGmKxtV7fKyG5l9eJyekqLlwirLnFTIy/GLZd+3tzgDx2f6XF5TlNE93WcPp7bND8vP8nMP5ZfL ujAA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Documentation for GFS2 is scattered in three docs that are in
Documentation/filesystems/ directory. As these docs are standing out as
a group, move them into separate gfs2/ subdirectory.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
Changes since v3 [1]:

  * Merge original gfs2.rst contents into index page (Jon)

[1]: https://lore.kernel.org/linux-doc/20250909014606.15043-1-bagasdotme@gmail.com/

 .../filesystems/{gfs2-glocks.rst => gfs2/glocks.rst} |  0
 .../filesystems/{gfs2.rst => gfs2/index.rst}         | 12 ++++++++++++
 .../{gfs2-uevents.rst => gfs2/uevents.rst}           |  0
 Documentation/filesystems/index.rst                  |  4 +---
 MAINTAINERS                                          |  2 +-
 5 files changed, 14 insertions(+), 4 deletions(-)
 rename Documentation/filesystems/{gfs2-glocks.rst => gfs2/glocks.rst} (100%)
 rename Documentation/filesystems/{gfs2.rst => gfs2/index.rst} (94%)
 rename Documentation/filesystems/{gfs2-uevents.rst => gfs2/uevents.rst} (100%)

diff --git a/Documentation/filesystems/gfs2-glocks.rst b/Documentation/filesystems/gfs2/glocks.rst
similarity index 100%
rename from Documentation/filesystems/gfs2-glocks.rst
rename to Documentation/filesystems/gfs2/glocks.rst
diff --git a/Documentation/filesystems/gfs2.rst b/Documentation/filesystems/gfs2/index.rst
similarity index 94%
rename from Documentation/filesystems/gfs2.rst
rename to Documentation/filesystems/gfs2/index.rst
index 1bc48a13430c1c..e5e19540356138 100644
--- a/Documentation/filesystems/gfs2.rst
+++ b/Documentation/filesystems/gfs2/index.rst
@@ -4,6 +4,9 @@
 Global File System 2
 ====================
 
+Overview
+========
+
 GFS2 is a cluster file system. It allows a cluster of computers to
 simultaneously use a block device that is shared between them (with FC,
 iSCSI, NBD, etc).  GFS2 reads and writes to the block device like a local
@@ -50,3 +53,12 @@ The following man pages are available from gfs2-utils:
   gfs2_convert		to convert a gfs filesystem to GFS2 in-place
   mkfs.gfs2		to make a filesystem
   ============		=============================================
+
+Implementation Notes
+====================
+
+.. toctree::
+   :maxdepth: 1
+
+   glocks
+   uevents
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
index ef87548b8f88c6..1b19137f50a6b7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10336,7 +10336,7 @@ L:	gfs2@lists.linux.dev
 S:	Supported
 B:	https://bugzilla.kernel.org/enter_bug.cgi?product=File%20System&component=gfs2
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git
-F:	Documentation/filesystems/gfs2*
+F:	Documentation/filesystems/gfs2/
 F:	fs/gfs2/
 F:	include/uapi/linux/gfs2_ondisk.h
 

base-commit: f44a29784f685804d9970cfb0d3439c9e30981d7
-- 
An old man doll... just what I always wanted! - Clara


