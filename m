Return-Path: <linux-kernel+bounces-734773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E59BAB08638
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 09:11:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5750CA41B45
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 07:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38CDA21A444;
	Thu, 17 Jul 2025 07:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Vz6ZxWBJ"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D444A21ADA3
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 07:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752736104; cv=none; b=bo5nGHPGudGTlbMpa3BuCDI2iO/Z+NcFJvEl3T5LDaM2fJ1a4pqKDimHZfPf2Ta8sLiTPAcnkFVbJDLGNMmoWJCY2Fh1alHMnkifM/lN8ZLXaUAY/5g1VTpBVtqNjd4UMRRv2/MJ8MhMfzKxjApi6GmhOalp611LYSEv4BILkVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752736104; c=relaxed/simple;
	bh=Q4bKyYmYFsoXiW7DzU/B1gfSL+2062wR+TWoXhLTR/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GdqsjOnOcYgMYYm1m61HXJTnc8tA5ISB7utDgwmlFjnWX7IAJnGFACFmoPi84VxrjrMoECzhNOb5zYSyu0F4acC/UQ5GaM89e8gKBP1jTg3nKVGo1HWV+58F7QPBtTIXZqkBrYVa6AxAJ48U2pAzEi7cU0ZJQM4H2JJs3t25XDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Vz6ZxWBJ; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752736094; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=tFm3HVr9LftpPFBNavNi/pytruj+9SyiAteNScDIPgs=;
	b=Vz6ZxWBJcN1BVifpXoXWoCv6gzRmG1fl/E2pInuQt7pF2nmCGBkk1uXpeSBNM7veKwLCKkS4KOemx/hhI+lhxgwSo+IP8rNbAC+kKlX5id73Fj3EDV3MKRNGzrVvh5xW0S9Q+yiEpOULMug3iJjPv4wPKPEUDJDxR2lbX9VKB0E=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wj791iq_1752736085 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Jul 2025 15:08:14 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v5 0/3] erofs: support metadata compression
Date: Thu, 17 Jul 2025 15:08:02 +0800
Message-ID: <20250717070804.1446345-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250716173314.308744-1-hsiangkao@linux.alibaba.com>
References: <20250716173314.308744-1-hsiangkao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This patchset implements metadata compression since many users are
interested in smaller image sizes (even at the cost of some I/O
latency).

In short, it uses a special "metabox" inode to gather all inode
metadata and then compresses it.  Since EROFS supports multiple
algorithms, you can select a faster algorithm (e.g., LZ4) from
the one used for data compression (e.g., LZMA).

Also see the detailed commit messages for more details.

Here are some preliminary numbers:

Command line: -zlzma,6 -Efragments,ztailpacking -C1048576

  ______________________________________________________________
 |         |_______ Vanilla _______|___ 2554769408 (2437MiB) ___|
 | Fedora  |_______ `-m4096` ______|___ 2524504064 (2408MiB) ___|
 |_________|_ `-m4096` (lz4hc,12) _|___ 2527326208 (2411MiB) ___|
 |         |_______ Vanilla _______|____ 378634240 ( 362MiB) ___|
 |  AOSP   |_______ `-m4096` ______|____ 377856000 ( 361MiB) ___|
 |_________|_ `-m4096` (lz4hc,12) _|____ 377942016 ( 361MiB) ___|
 |         |_______ Vanilla _______|______ 4837376 (4724KiB) ___|
 | OpenWRT |_______ `-m4096` ______|______ 4734976 (4624KiB) ___|
 |_________|_ `-m4096` (lz4hc,12) _|______ 4747264 (4636KiB) ___|

[ Note: directory data is still left uncompressed by `mkfs.erofs` so
        the final image sizes can be further smaller.  Directory data
        is just like regular data, which only needs some userspace work
        so let's address it later. ]

Thanks,
Gao Xiang

v3/4: https://lore.kernel.org/r/20250716173314.308744-1-hsiangkao@linux.alibaba.com 
Changes since v4:
 - address build failure (https://lore.kernel.org/r/202507170548.rvm67YSU-lkp@intel.com);
 - address build failure (https://lore.kernel.org/r/202507170506.Wzz1lR5I-lkp@intel.com).

Bo Liu (1):
  erofs: implement metadata compression

Gao Xiang (1):
  erofs: add on-disk definition for metadata compression

 Documentation/ABI/testing/sysfs-fs-erofs |  2 +-
 fs/erofs/data.c                          | 59 +++++++++++++++---------
 fs/erofs/decompressor.c                  |  2 +-
 fs/erofs/erofs_fs.h                      | 15 ++++--
 fs/erofs/fileio.c                        |  2 +-
 fs/erofs/fscache.c                       |  3 +-
 fs/erofs/inode.c                         |  5 +-
 fs/erofs/internal.h                      | 19 ++++++--
 fs/erofs/super.c                         | 22 ++++++++-
 fs/erofs/sysfs.c                         |  2 +
 fs/erofs/xattr.c                         | 26 +++++++----
 fs/erofs/zdata.c                         |  5 +-
 fs/erofs/zmap.c                          | 16 ++++---
 13 files changed, 123 insertions(+), 55 deletions(-)

-- 
2.43.5


