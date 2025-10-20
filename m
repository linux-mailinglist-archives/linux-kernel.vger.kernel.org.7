Return-Path: <linux-kernel+bounces-859962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F110BEF0CD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 04:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF4921899426
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 02:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6582E3FC2;
	Mon, 20 Oct 2025 02:08:33 +0000 (UTC)
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026D942056
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 02:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760926112; cv=none; b=Zr6NT6mpYP8+Q2mefjuQ4ejpqAyC/O8wZJ2zwJxi1HROCjz6Wy8WgfVD5PPJHMr8gSUNzk0rQWeQe9fqnTsNjs47uk6DyzGNR16B4zAR2QOQouN+ytDrOgMRjWH+OS5NdY7pi2bFjaxHQgW7yXzqlEA9AahFJAYsJXcjfWLPLYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760926112; c=relaxed/simple;
	bh=uPq9gUW6Ggn4YtNDag+Ah1GDDuiaoQ3Qen6CuVpWlMc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=s5zsjLeom2EjiXlfQ+OWsp6WnSbvV0wypmfmkob3jAJvdNxzR9mYquFJ1Mpsfer4lbnNW4WTshfKEvxab+dQrg647kNMlfQm46enctiGJ1mm3kOgxZXEn1rGgP67Idia296ONtCyYWuFFqKat9YHnZmHbgkLGydxImTOFVVEu5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-79ef9d1805fso3566316b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 19:08:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760926110; x=1761530910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dW+8qEBUDAhc3jUXkOs7jc3BtK1QhB3DJ9LAVMHfzYQ=;
        b=IJPqhsh9RU1DJep9ITr+hx6Chpn2M9Q2qaZ1DRnyziSYbIVJRjlTzincWns/C0OOe9
         PlecbGqAGln8SWKtRKMWtuc+6sWOxjK3Spu+FNMlYFEgIjRCiqAyTc7/tTJewlFrV6r6
         u9kkZfPZ/921L+O1QeopNzr9iZvYog/AbW2s1KDD1fL+4e9tU/ZLP3tipRptIgPSpyzH
         nt9CzUCoedMM8z6ywuuvXWarRc0t3pPWFq7ll2/uDQiZ2DZNXyzMroXhBudK2xrCoupA
         fgXdlbaKYVDL05JOAFi2NX6rWa23JgXjuv1AufHLLKV97tmtNNBbG5e8opoD4qgDoRTZ
         N4kQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsmxC5hdL2B/yD/LlaWv2es/r2c17U3TC21GcRpd9f47ffNRr32ntTFAt9WLSKVgNKk2lYDXzkjkVIgJI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywyall1cNPAXd62tGOneurJsrzvCIC6WYqti5Cg2iQUWdWu78KN
	qYhLO/ruv40RUBMllmoXIVBYajCGZdJRWeeLxQW2Hrb7Bj2Jw/i7RcYM
X-Gm-Gg: ASbGncsGrmvXRoZv52ZSGm43sMlGZyRBkuZeHX9UPULEDVk01i4yJQN7fhM2LcnhiKa
	03p77qKLCFh+iYJg8WXIehmRUTEzqs4vn3W+BD8GC6Z/DtkZXgfCycAZo0i362dNXf/S1veO4Jl
	cWz1D9A9bU0taKQfPlSzl6FTE86xWA1c1TW/shDdWPqoIMGMMvUW5VlqKeEE8DXGubsyXY8Z5yG
	GXpaIgMgd57Nbqyif9StADAFGHvndqxwDaLdb42FR3JKSbuEYeaNC5ke1vIhDiX7lnyy+/E3pVH
	xBmqMu9dmMIy2LrxGSWUUGg1+0redx52o4J2Un6niqCRPBB26tNZGdokGQIWP6orXfWzHT/BG5w
	o0vlmsa3Zl6dtCL3jNM79tLhmeGM+UeBFFvHujLKGTfs++GIzC/4cF2yQ4+JBvRRcyXfuCRIEBY
	3YGC4CCH5v1MPQY4A=
X-Google-Smtp-Source: AGHT+IEwC40Eao9RjtGdS/TCHWmg7SuHz1awY4cyfkIalLbM0+n12u0rqVgEoyO4dZL3ccNUFXboJw==
X-Received: by 2002:a05:6a00:b4b:b0:77f:4b9b:8c34 with SMTP id d2e1a72fcca58-7a220d34eccmr13257838b3a.31.1760926110178;
        Sun, 19 Oct 2025 19:08:30 -0700 (PDT)
Received: from localhost.localdomain ([1.227.206.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a23010df83sm6722300b3a.59.2025.10.19.19.08.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 19:08:29 -0700 (PDT)
From: Namjae Jeon <linkinjeon@kernel.org>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	hch@infradead.org,
	hch@lst.de,
	tytso@mit.edu,
	willy@infradead.org,
	jack@suse.cz,
	djwong@kernel.org,
	josef@toxicpanda.com,
	sandeen@sandeen.net,
	rgoldwyn@suse.com,
	xiang@kernel.org,
	dsterba@suse.com,
	pali@kernel.org,
	ebiggers@kernel.org,
	neil@brown.name,
	amir73il@gmail.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	iamjoonsoo.kim@lge.com,
	cheol.lee@lge.com,
	jay.sim@lge.com,
	gunho.lee@lge.com,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH 00/11] ntfsplus: ntfs filesystem remake
Date: Mon, 20 Oct 2025 11:07:38 +0900
Message-Id: <20251020020749.5522-1-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Introduction
============

The NTFS filesystem[1] still remains the default filesystem for Windows
and The well-maintained NTFS driver in the Linux kernel enhances
interoperability with Windows devices, making it easier for Linux users
to work with NTFS-formatted drives. Currently, ntfs support in Linux was
the long-neglected NTFS Classic (read-only), which has been removed from
the Linux kernel, leaving the poorly maintained ntfs3. ntfs3 still has
many problems and is poorly maintained, so users and distributions are
still using the old legacy ntfs-3g.


What is ntfsplus?
=================

The remade ntfs called ntfsplus is an implementation that supports write
and the essential requirements(iomap, no buffer-head, utilities, xfstests
test result) based on read-only classic NTFS.
The old read-only ntfs code is much cleaner, with extensive comments,
offers readability that makes understanding NTFS easier. This is why
ntfsplus was developed on old read-only NTFS base.
The target is to provide current trends(iomap, no buffer head, folio),
enhanced performance, stable maintenance, utility support including fsck.


Key Features
============

- Write support:
   Implement write support on classic read-only NTFS. Additionally,
   integrate delayed allocation to enhance write performance through
   multi-cluster allocation and minimized fragmentation of cluster bitmap.

- Switch to using iomap:
   Use iomap for buffered IO writes, reads, direct IO, file extent mapping,
   readpages, writepages operations.

- Stop using the buffer head:
   The use of buffer head in old ntfs and switched to use folio instead.
   As a result, CONFIG_BUFFER_HEAD option enable is removed in Kconfig also.

- Public utilities include fsck[2]:
   While ntfs-3g includes ntfsprogs as a component, it notably lacks
   the fsck implementation. So we have launched a new ntfs utilitiies
   project called ntfsprogs-plus by forking from ntfs-3g after removing
   unnecessary ntfs fuse implementation. fsck.ntfs can be used for ntfs
   testing with xfstests as well as for recovering corrupted NTFS device.

- Performance Enhancements:

   - ntfsplus vs. ntfs3:

     * Performance was benchmarked using iozone with various chunk size.
        - In single-thread(1T) write tests, ntfsplus show approximately
          3~5% better performance.
        - In multi-thread(4T) write tests, ntfsplus show approximately
          35~110% better performance.
        - Read throughput is identical for both ntfs implementations.

     1GB file      size:4096           size:16384           size:65536
     MB/sec   ntfsplus | ntfs3    ntfsplus | ntfs3    ntfsplus | ntfs3
     ─────────────────────────────────────────────────────────────────
     read          399 | 399           426 | 424           429 | 430
     ─────────────────────────────────────────────────────────────────
     write(1T)     291 | 276           325 | 305           333 | 317
     write(4T)     105 | 50            113 | 78            114 | 99.6


     * File list browsing performance. (about 12~14% faster)

                  files:100000        files:200000        files:400000
     Sec      ntfsplus | ntfs3    ntfsplus | ntfs3    ntfsplus | ntfs3
     ─────────────────────────────────────────────────────────────────
     ls -lR       7.07 | 8.10        14.03 | 16.35       28.27 | 32.86


     * mount time.

             parti_size:1TB      parti_size:2TB      parti_size:4TB
     Sec      ntfsplus | ntfs3    ntfsplus | ntfs3    ntfsplus | ntfs3
     ─────────────────────────────────────────────────────────────────
     mount        0.38 | 2.03         0.39 | 2.25         0.70 | 4.51

   The following are the reasons why ntfsplus performance is higher
    compared to ntfs3:
     - Use iomap aops.
     - Delayed allocation support.
     - Optimize zero out for newly allocated clusters.
     - Optimize runlist merge overhead with small chunck size.
     - pre-load mft(inode) blocks and index(dentry) blocks to improve
       readdir + stat performance.
     - Load lcn bitmap on background.

- Stability improvement:
   a. Pass more xfstests tests:
      ntfsplus passed 287 tests, significantly higher than ntfs3's 218.
      ntfsplus implement fallocate, idmapped mount and permission, etc,
      resulting in a significantly high number of xfstests passing compared
      to ntfs3.
   b. Bonnie++ issue[3]:
      The Bonnie++ benchmark fails on ntfs3 with a "Directory not empty"
      error during file deletion. ntfs3 currently iterates directory
      entries by reading index blocks one by one. When entries are deleted
      concurrently, index block merging or entry relocation can cause
      readdir() to skip some entries, leaving files undeleted in
      workloads(bonnie++) that mix unlink and directory scans.
      ntfsplus implement leaf chain traversal in readdir to avoid entry skip
      on deletion.

- Journaling support:
   ntfs3 does not provide full journaling support. It only implement journal
   replay[4], which in our testing did not function correctly. My next task
   after upstreaming will be to add full journal support to ntfsplus.


The feature comparison summary
==============================

Feature                               ntfsplus   ntfs3
===================================   ========   ===========
Write support                         Yes        Yes
iomap support                         Yes        No
No buffer head                        Yes        No
Public utilities(mkfs, fsck, etc.)    Yes        No
xfstests passed                       287        218
Idmapped mount                        Yes        No
Delayed allocation                    Yes        No
Bonnie++                              Pass       Fail
Journaling                            Planned    Inoperative
===================================   ========   ===========

References
==========
[1] https://en.wikipedia.org/wiki/NTFS
[2] https://github.com/ntfsprogs-plus/ntfsprogs-plus
[3] https://lore.kernel.org/ntfs3/CAOZgwEd7NDkGEpdF6UQTcbYuupDavaHBoj4WwTy3Qe4Bqm6V0g@mail.gmail.com/
[4] https://marc.info/?l=linux-fsdevel&m=161738417018673&q=mbox


Namjae Jeon (11):
  ntfsplus: in-memory, on-disk structures and headers
  ntfsplus: add super block operations
  ntfsplus: add inode operations
  ntfsplus: add directory operations
  ntfsplus: add file operations
  ntfsplus: add iomap and address space operations
  ntfsplus: add attrib operatrions
  ntfsplus: add runlist handling and cluster allocator
  ntfsplus: add reparse and ea operations
  ntfsplus: add misc operations
  ntfsplus: add Kconfig and Makefile

 fs/Kconfig                |    1 +
 fs/Makefile               |    1 +
 fs/ntfsplus/Kconfig       |   45 +
 fs/ntfsplus/Makefile      |   18 +
 fs/ntfsplus/aops.c        |  631 +++++
 fs/ntfsplus/aops.h        |   92 +
 fs/ntfsplus/attrib.c      | 5373 +++++++++++++++++++++++++++++++++++++
 fs/ntfsplus/attrib.h      |  159 ++
 fs/ntfsplus/attrlist.c    |  276 ++
 fs/ntfsplus/attrlist.h    |   21 +
 fs/ntfsplus/bitmap.c      |  193 ++
 fs/ntfsplus/bitmap.h      |   90 +
 fs/ntfsplus/collate.c     |  173 ++
 fs/ntfsplus/collate.h     |   37 +
 fs/ntfsplus/compress.c    | 1565 +++++++++++
 fs/ntfsplus/dir.c         | 1226 +++++++++
 fs/ntfsplus/dir.h         |   33 +
 fs/ntfsplus/ea.c          |  712 +++++
 fs/ntfsplus/ea.h          |   25 +
 fs/ntfsplus/file.c        | 1056 ++++++++
 fs/ntfsplus/index.c       | 2114 +++++++++++++++
 fs/ntfsplus/index.h       |  127 +
 fs/ntfsplus/inode.c       | 3705 +++++++++++++++++++++++++
 fs/ntfsplus/inode.h       |  354 +++
 fs/ntfsplus/layout.h      | 2288 ++++++++++++++++
 fs/ntfsplus/lcnalloc.c    |  993 +++++++
 fs/ntfsplus/lcnalloc.h    |  127 +
 fs/ntfsplus/logfile.c     |  773 ++++++
 fs/ntfsplus/logfile.h     |  316 +++
 fs/ntfsplus/mft.c         | 2630 ++++++++++++++++++
 fs/ntfsplus/mft.h         |   93 +
 fs/ntfsplus/misc.c        |  221 ++
 fs/ntfsplus/misc.h        |  218 ++
 fs/ntfsplus/mst.c         |  195 ++
 fs/ntfsplus/namei.c       | 1606 +++++++++++
 fs/ntfsplus/ntfs.h        |  172 ++
 fs/ntfsplus/ntfs_iomap.c  |  704 +++++
 fs/ntfsplus/ntfs_iomap.h  |   22 +
 fs/ntfsplus/reparse.c     |  550 ++++
 fs/ntfsplus/reparse.h     |   15 +
 fs/ntfsplus/runlist.c     | 1995 ++++++++++++++
 fs/ntfsplus/runlist.h     |   91 +
 fs/ntfsplus/super.c       | 2716 +++++++++++++++++++
 fs/ntfsplus/unistr.c      |  471 ++++
 fs/ntfsplus/upcase.c      |   73 +
 fs/ntfsplus/volume.h      |  241 ++
 include/uapi/linux/ntfs.h |   23 +
 47 files changed, 34560 insertions(+)
 create mode 100644 fs/ntfsplus/Kconfig
 create mode 100644 fs/ntfsplus/Makefile
 create mode 100644 fs/ntfsplus/aops.c
 create mode 100644 fs/ntfsplus/aops.h
 create mode 100644 fs/ntfsplus/attrib.c
 create mode 100644 fs/ntfsplus/attrib.h
 create mode 100644 fs/ntfsplus/attrlist.c
 create mode 100644 fs/ntfsplus/attrlist.h
 create mode 100644 fs/ntfsplus/bitmap.c
 create mode 100644 fs/ntfsplus/bitmap.h
 create mode 100644 fs/ntfsplus/collate.c
 create mode 100644 fs/ntfsplus/collate.h
 create mode 100644 fs/ntfsplus/compress.c
 create mode 100644 fs/ntfsplus/dir.c
 create mode 100644 fs/ntfsplus/dir.h
 create mode 100644 fs/ntfsplus/ea.c
 create mode 100644 fs/ntfsplus/ea.h
 create mode 100644 fs/ntfsplus/file.c
 create mode 100644 fs/ntfsplus/index.c
 create mode 100644 fs/ntfsplus/index.h
 create mode 100644 fs/ntfsplus/inode.c
 create mode 100644 fs/ntfsplus/inode.h
 create mode 100644 fs/ntfsplus/layout.h
 create mode 100644 fs/ntfsplus/lcnalloc.c
 create mode 100644 fs/ntfsplus/lcnalloc.h
 create mode 100644 fs/ntfsplus/logfile.c
 create mode 100644 fs/ntfsplus/logfile.h
 create mode 100644 fs/ntfsplus/mft.c
 create mode 100644 fs/ntfsplus/mft.h
 create mode 100644 fs/ntfsplus/misc.c
 create mode 100644 fs/ntfsplus/misc.h
 create mode 100644 fs/ntfsplus/mst.c
 create mode 100644 fs/ntfsplus/namei.c
 create mode 100644 fs/ntfsplus/ntfs.h
 create mode 100644 fs/ntfsplus/ntfs_iomap.c
 create mode 100644 fs/ntfsplus/ntfs_iomap.h
 create mode 100644 fs/ntfsplus/reparse.c
 create mode 100644 fs/ntfsplus/reparse.h
 create mode 100644 fs/ntfsplus/runlist.c
 create mode 100644 fs/ntfsplus/runlist.h
 create mode 100644 fs/ntfsplus/super.c
 create mode 100644 fs/ntfsplus/unistr.c
 create mode 100644 fs/ntfsplus/upcase.c
 create mode 100644 fs/ntfsplus/volume.h
 create mode 100644 include/uapi/linux/ntfs.h

-- 
2.34.1


