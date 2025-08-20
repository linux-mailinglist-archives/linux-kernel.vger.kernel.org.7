Return-Path: <linux-kernel+bounces-776926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1583EB2D30E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 06:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2E2D5A5474
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 04:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B8B277CA0;
	Wed, 20 Aug 2025 04:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="imgp4A6L"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8818626D4E6;
	Wed, 20 Aug 2025 04:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755664484; cv=none; b=jru1bPRaf7LdHJsooU8jFXGcaSY2q8tNrdxj8ZGAdi5mgyLcnbIUr9YpgOeDvcBpc+7aKtnzHU9Ro89dz3bSPp9UQRB+4N19KYZt9hmuxwPWrVwxFu61SiGB0a+/tVgwRcRxb7vViuC45QwCXTIvgAvlXiGUgZ9hgSg97Osm3ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755664484; c=relaxed/simple;
	bh=IE+YVmONe8+OmcHFwhNiUC5Y6aV43BEeC0O3nKJgnVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pnxAOUdEpM02EAGpJ0m7IrUkZ1eI3EnBBTJ0tDMnHduYguJ4QzLJl03Rhz3EurHtYZ3gfARmlaxeT7G/ffOsX7OLPlALW2qf+9HFu1gZioklzy889ZU4D5K4DOj4HUZ+HEVHHnfyELssEpCh50ei69+zBXOuQwW+Avx6OfwtfTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=imgp4A6L; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-32326bd4f4dso513027a91.1;
        Tue, 19 Aug 2025 21:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755664482; x=1756269282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hdzCk77MP3wx+nUo2C99H0YrbUbbbgXAPHawwUGevU=;
        b=imgp4A6LteiUDO7dmmKrxgN/u5AsJFLlyUqBYiCm9/J7Nk7si98j8LLkXIKs1PM/Dr
         C956kTc40KgJ5oP2gmWj1nnydrFBPu2G+P0eryfEaOZpkkHQ6olHEWT4IeSL/nG2Y0ap
         eX/L+7xiKdqVtV5KhaJLrGRWzRozkYKi4L2eO6HcpFu/zQy2pxOhAGkN2lPRLRATLP2x
         DSMDYRjykiSTRDYlkIvPLDdJgBX4tMCEB7bsAh7ogJlxemxZoiK1VIkJaNU5FokI+I0C
         0pnhzKSIXldB1j0qMyR0ElVlx1IA7rw9dxiuyDVL0Wj2H6OgjS0LC36DyIHQJva73QbA
         7rXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755664482; x=1756269282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1hdzCk77MP3wx+nUo2C99H0YrbUbbbgXAPHawwUGevU=;
        b=gkl/f+O/r4uCVIwhDIc2TH/8JuueE4iRmCg2n44O30M4JvS9WaPUbgkAVoCdukRDaD
         1nzRpr3SZ2/M3qZz2JU3Adw4+tjkrGOpPmYZLxwvBPBb0mqhp/RXPLReUQfKgFA+BIgM
         jT91KvoZSEGWsc9SV6XBBx9dPCFUxNLOQ4F8yfeloA7MFB2PSrK5ZRKyxGDV7zpFuPD/
         9zBT3w6FH+TrL13Mh21XRcGm69Lq47zaGTpsH4g3X5c/tbSVnj8noZ3gxDm5p/Tf0HQt
         6STrT5N6ScQWCQJKhDIgJ9hvwid02tnuF++eSxcx2GKA/yobTQGicjIW5UxhA9p8U3yG
         wCxg==
X-Forwarded-Encrypted: i=1; AJvYcCVB8m5rSLGY5VYEdxuBfKzbzW59/wafUhDpeJd0VrVVkUSDZJqOqWWSphh4Z7/BadhKBqbv4QWedVM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3yB2+jDWWwX+FKQIoSOfKoiTVfTHN36ZEjen6DhhIUW7SJJ8T
	pWA1ZrfEXCxtXpJjcscTGff4+425G+lOiawXK04/7URTz9H8froBigwh
X-Gm-Gg: ASbGnctFRId5CDtc578OvVXpXBwFVpOSueJ7c8rdsElgZaGQjM9ymvkaozpNZHlMcnz
	MTbMvOnrqswRUw60TaxtCb1gWCheNKadiMWJJO48iP1ERq8keYdvSodW6r+y/hFGXvgHImJIBO5
	PZvOJFa86UJ8r8VfinxlM5OkwbAcpaPD7MPAa4owyTrEIOv3mTYDfK5pYZs4QS1HaQDvnW722Lh
	aWYqsNWcZRHoTbqGQk+BuWFI3IC0BMWXdijV1EklU8Jh6tH6ig0rIqmDga705DdThzOeCLtlzOc
	PJGFzmaXjCb5Tp7aDwPJ7HLxufypXkV+g0oI3pCkRw26+7X+8femWuT7Og+TP4zONlMq+q59zfK
	Emkr9aZDCjyddxPjMSHFtZQ==
X-Google-Smtp-Source: AGHT+IFTBnYvJdFNjUjbHaO8K9ArV262MbVxRpC7WHVNKKM82f8tJt+j5pADxmY6u0U0ZYYHiq2leg==
X-Received: by 2002:a17:90b:5247:b0:321:c9cf:deaa with SMTP id 98e67ed59e1d1-324d356c5f9mr5988168a91.17.1755664481545;
        Tue, 19 Aug 2025 21:34:41 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-324e254c74fsm861928a91.13.2025.08.19.21.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 21:34:38 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id B56EA436C401; Wed, 20 Aug 2025 11:34:35 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux F2FS <linux-f2fs-devel@lists.sourceforge.net>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Daeho Jeong <daehojeong@google.com>,
	Yuanye Ma <yuanye.ma20@gmail.com>,
	Yangtao Li <frank.li@vivo.com>
Subject: [PATCH 4/6] Documentation: f2fs: Wrap snippets in literal code blocks
Date: Wed, 20 Aug 2025 11:34:30 +0700
Message-ID: <20250820043432.22509-5-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820043432.22509-1-bagasdotme@gmail.com>
References: <20250820043432.22509-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3599; i=bagasdotme@gmail.com; h=from:subject; bh=IE+YVmONe8+OmcHFwhNiUC5Y6aV43BEeC0O3nKJgnVQ=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBlL/bddebbG9/ziyqP3fGvffJbs/bXswLpFM7df/b7v8 PeEVZ7BIR2lLAxiXAyyYooskxL5mk7vMhK50L7WEWYOKxPIEAYuTgGYyNFHDL/ZkiSCqtefvZDm pOvybic3c5Hzuo2Lj+zZxHrGLa3+6nlThv9Rh5r/zYzY+uZzWtOXYyWhO95vWRWcbF0kfW3Tl/p 1S5ZyAAA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Compression mode code and device aliasing shell snippets are shown
in htmldocs output as long-running paragraph instead. Wrap them.

Fixes: 602a16d58e9a ("f2fs: add compress_mode mount option")
Fixes: 128d333f0dff ("f2fs: introduce device aliasing file")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/filesystems/f2fs.rst | 58 +++++++++++++++---------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index 85e015b712c2e1..0f9472ae62f2cb 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -931,15 +931,15 @@ target file and the timing. The user can do manual compression/decompression on
 compression enabled files using F2FS_IOC_DECOMPRESS_FILE and F2FS_IOC_COMPRESS_FILE
 ioctls like the below.
 
-To decompress a file,
+To decompress a file::
 
-fd = open(filename, O_WRONLY, 0);
-ret = ioctl(fd, F2FS_IOC_DECOMPRESS_FILE);
+  fd = open(filename, O_WRONLY, 0);
+  ret = ioctl(fd, F2FS_IOC_DECOMPRESS_FILE);
 
-To compress a file,
+To compress a file::
 
-fd = open(filename, O_WRONLY, 0);
-ret = ioctl(fd, F2FS_IOC_COMPRESS_FILE);
+  fd = open(filename, O_WRONLY, 0);
+  ret = ioctl(fd, F2FS_IOC_COMPRESS_FILE);
 
 NVMe Zoned Namespace devices
 ----------------------------
@@ -969,32 +969,32 @@ reserved and used by another filesystem or for different purposes. Once that
 external usage is complete, the device aliasing file can be deleted, releasing
 the reserved space back to F2FS for its own use.
 
-<use-case>
+.. code-block::
 
-# ls /dev/vd*
-/dev/vdb (32GB) /dev/vdc (32GB)
-# mkfs.ext4 /dev/vdc
-# mkfs.f2fs -c /dev/vdc@vdc.file /dev/vdb
-# mount /dev/vdb /mnt/f2fs
-# ls -l /mnt/f2fs
-vdc.file
-# df -h
-/dev/vdb                            64G   33G   32G  52% /mnt/f2fs
+   # ls /dev/vd*
+   /dev/vdb (32GB) /dev/vdc (32GB)
+   # mkfs.ext4 /dev/vdc
+   # mkfs.f2fs -c /dev/vdc@vdc.file /dev/vdb
+   # mount /dev/vdb /mnt/f2fs
+   # ls -l /mnt/f2fs
+   vdc.file
+   # df -h
+   /dev/vdb                            64G   33G   32G  52% /mnt/f2fs
 
-# mount -o loop /dev/vdc /mnt/ext4
-# df -h
-/dev/vdb                            64G   33G   32G  52% /mnt/f2fs
-/dev/loop7                          32G   24K   30G   1% /mnt/ext4
-# umount /mnt/ext4
+   # mount -o loop /dev/vdc /mnt/ext4
+   # df -h
+   /dev/vdb                            64G   33G   32G  52% /mnt/f2fs
+   /dev/loop7                          32G   24K   30G   1% /mnt/ext4
+   # umount /mnt/ext4
 
-# f2fs_io getflags /mnt/f2fs/vdc.file
-get a flag on /mnt/f2fs/vdc.file ret=0, flags=nocow(pinned),immutable
-# f2fs_io setflags noimmutable /mnt/f2fs/vdc.file
-get a flag on noimmutable ret=0, flags=800010
-set a flag on /mnt/f2fs/vdc.file ret=0, flags=noimmutable
-# rm /mnt/f2fs/vdc.file
-# df -h
-/dev/vdb                            64G  753M   64G   2% /mnt/f2fs
+   # f2fs_io getflags /mnt/f2fs/vdc.file
+   get a flag on /mnt/f2fs/vdc.file ret=0, flags=nocow(pinned),immutable
+   # f2fs_io setflags noimmutable /mnt/f2fs/vdc.file
+   get a flag on noimmutable ret=0, flags=800010
+   set a flag on /mnt/f2fs/vdc.file ret=0, flags=noimmutable
+   # rm /mnt/f2fs/vdc.file
+   # df -h
+   /dev/vdb                            64G  753M   64G   2% /mnt/f2fs
 
 So, the key idea is, user can do any file operations on /dev/vdc, and
 reclaim the space after the use, while the space is counted as /data.
-- 
An old man doll... just what I always wanted! - Clara


