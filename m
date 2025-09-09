Return-Path: <linux-kernel+bounces-807008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EC6B49ED6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 03:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 237284448F2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 01:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA99189;
	Tue,  9 Sep 2025 01:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/C0SwbJ"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F43C1A9F96;
	Tue,  9 Sep 2025 01:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757382379; cv=none; b=sAx0EIyNYOs9hsAcMDOGGAI+AmGZAiuafYvm7sepKquh7ntSU06OfP7/XsvUJ+PFYwTfpM4RJ3i4MmlNO81I9ERcfyS+EcP+vCmg7Q73MkSuauk+LWPV0Viz6xUGQibypjKzKAmdu1yKZHDH+3Jnrve2uGQ9vbH3l+6eCka4bFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757382379; c=relaxed/simple;
	bh=Mgm/f/dyyNj+1Olh/CY02O9anr2CSratmtmw7/rayiA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=seBhWzWoEHVkTozYIHoAtA5hr4CYAnSms7DwU3cFtDooM82U9Q9GUqoacPmhaSNNo+yfWJzxZsV4Hj4++ebqtqtNNtOyk2WnT6uBruZRdpOyevt1aILfkFf99h/mYD8LTz3/VfeKZbGQzwUQ172p4wKxid1pJ8ldOaZJr68C+jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/C0SwbJ; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2518a38e7e4so28741265ad.1;
        Mon, 08 Sep 2025 18:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757382377; x=1757987177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KuiOo15AG4OXtbWW33TbGP3QjJoF6Rgu6PmjoTlWNs0=;
        b=P/C0SwbJBggBxTxFjsPLs9/FIO2SQEytk9YuSibhX1jHEabo+P7WZHVWRsVIrz2OpG
         fTauSxl1UwySuxrAFSqn5qKoJtUMwfk2ruOiHblyAXP2Idu4yE+YpKVDhhMOpvFOhxBV
         YHtv/tAPsxBW60LDKVf48GsGwAO7Lu20GHpDGpSVez4hQ4SwaXInwZhgt7d5W8Nx/+rg
         P8ofDA3Db1QL9WdMaYgTd4O9SfsuR6E82Urg/MQ2S0Chy0G01q/5Ui/yD7UC7BhyPp2y
         0jUlrKP35s3oT8/Spm0yG0+6/4Q/mZHBMdTX4uRsKI8/AflCTmZBFQFCcQoKGvsN5YFJ
         JPow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757382377; x=1757987177;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KuiOo15AG4OXtbWW33TbGP3QjJoF6Rgu6PmjoTlWNs0=;
        b=bVmK1/MdRBIQfibPbGV9i0KY0rIcVblwjkimd1USrDXV5F10bua2ODCR4jtQNsY/X3
         cT4uvHzUPMWN1JoMq05xlfPkVo+PQWYPpNht5AIXHYUSClsw+ye+JP8ZJ8lmHVeu+F1l
         bJNn2dKQSDn3RAeGRsnH2e6p0nSBAuQYPWQRtjjbkufY5w1ja4Ukz6NvEhmFeuKQtCGq
         aGVykwlwZTbls+oclhXgG8pQ5aRY6hdZUEupYhBoECByWCCv526sV5zLJZDCIhiESyKB
         x/jkF04+Bpaeu9iBCIqN6jmppNr4nztOUDiZB7Ve7bDyqMIuMaikwPOsQ9glXRWy96kV
         3+Lg==
X-Forwarded-Encrypted: i=1; AJvYcCUHFZXChr9/lzQbutsxUltW9s3rJY8pJXqxb1pBVoVJbEILqH3TiMLNnQt3wewHvwntaXnaTWaN4+I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw75imS+BeoXi2PG5RGTBuQLvSbIKg7kWCgQOv3h+Un/uwQwGen
	HFHHBC73MEVcWfXhxgrnsbyOIfxbJxLoojrbjBIGQfCIIFuLzfl+xvzn
X-Gm-Gg: ASbGnct9nwrlGeLx4uXYeTW7jNekPNf6+3DVQp+FVSEWiYgsr6VF70iMirJiu4WoYAi
	iNujO8KLgwS7IqQ86PQmqWg9LjacVzOL/cttMEgjFkxGZcRe8Qo/25Ix9ZPvb/h05pzHFTOK0FA
	zCPA/OgsBgCp64RU3jH6AY0m1f6TbLFtdO49xNpJcMdmPuHJAf3UsTwsLkLeDducxnpdvMptv7x
	v6Db+ZDxrEWggqGP3fQoPtVs9mqEOFgRfEZ8wLaxsN7oob4PhSFOWRFKd4nauX9XA2KagPUZktx
	0p14v88ff0FCAuItuV2bFRgy2fdrARP+aHN72UwOhO8SJIhvKxgUP1ZhLT1XTVpoarXNaIptl/r
	RQMHt4+9s0FVMAUyXNZeElniSrA==
X-Google-Smtp-Source: AGHT+IGXoxvJ02bO5wRwlNWwxniZMYMlgSaFXoJXpCTp4h8dPraKosEMNBMembTfFIeOUDc1sptulw==
X-Received: by 2002:a17:903:2f92:b0:249:37b2:8629 with SMTP id d9443c01a7336-251759a97e4mr123230625ad.9.1757382377180;
        Mon, 08 Sep 2025 18:46:17 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24b11448a5asm189941315ad.54.2025.09.08.18.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 18:46:16 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 54E17420A80B; Tue, 09 Sep 2025 08:46:14 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux GFS2 <gfs2@lists.linux.dev>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Andreas Gruenbacher <agruenba@redhat.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Bernd Schubert <bschubert@ddn.com>,
	Jeff Layton <jlayton@kernel.org>,
	James Morse <james.morse@arm.com>,
	Chen Linxuan <chenlinxuan@uniontech.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v3] Documentation: gfs2: Consolidate GFS2 docs into its own subdirectory
Date: Tue,  9 Sep 2025 08:46:06 +0700
Message-ID: <20250909014606.15043-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3807; i=bagasdotme@gmail.com; h=from:subject; bh=Mgm/f/dyyNj+1Olh/CY02O9anr2CSratmtmw7/rayiA=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBn72wI3PP566pbttS3uO5jZTBQ+Tv034/xDNfcOiWzZK MdnScESHaUsDGJcDLJiiiyTEvmaTu8yErnQvtYRZg4rE8gQBi5OAZjI4xaG/77Cn2t6OVh1V+lu /a0jvWYBX2PxlwcLpt65wj3txWemGWsY/tkmGz3coi12z2FhY/IEjXtc+x7dEfbK3Grup5jSfar 2HBsA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Documentation for GFS2 is scattered in three docs that are in
Documentation/filesystems/ directory. As these docs are standing out as
a group, move them into separate gfs2/ subdirectory.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
Changes since v2 [1]:

  * Do not use wildcard on MAINTAINERS file entry and add review tag (Randy)

[1]: https://lore.kernel.org/linux-doc/20250827022122.12132-1-bagasdotme@gmail.com/

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
 

base-commit: 7e5a0fe4e8ae2eb341f8ebbee2b24231a58fc28b
-- 
An old man doll... just what I always wanted! - Clara


