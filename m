Return-Path: <linux-kernel+bounces-734020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22277B07C1A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 19:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11D18506F63
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 17:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA322F547F;
	Wed, 16 Jul 2025 17:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="VDqwmsfJ"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7A9274B30
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 17:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752687205; cv=none; b=FVp66/29jiScOvqDkJ2Cz25ttSuWnU85tEAune3Ei5pDV08RxStHhz43D5R+RIYZA3lA7Bb26rehSbH0dJQo4Tr+/Ixt/cL/RMzh0OSOGsAHsGACf8KvOJma+tQF3ef0gPqB+Zx+F05/HA3ZVUr3j9xWf94c8CX1KhwKP+N5DyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752687205; c=relaxed/simple;
	bh=iUZ+V9+bG7doEuOqxuvM+Ki8iugArgszeFctBH2UwOs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R914GpAAWE+0a6sPOgiDR9S54B9pBl8mt/W+MoX5D7jSRDpc8G74iezdajCvQ6gFiaFBVCoXdFBumgkSAzze3MDkQWx52nMd74t3mQh69h6/JekMeQGlJEjO6bhbZmR7a5pTXt11KPaXfl5hwPCImYMG9fQw1oNdgF2D8dM5NJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=VDqwmsfJ; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1752687200; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=zDJCiGHS3GPm13IZWsw1313r2MueLUxvlBMMubXIbYw=;
	b=VDqwmsfJGuNKv2veeRb7yPfgcdVCCD+sLLyq3u6Y6MKcqndXYDYOe8WCoR40DPk6RZIln8Ia21W3kaW6spN5PsEW9NR6x+rAr3Smlr0AITq4+uAlgLSR/6R5ZnjyH15hQ4m66/EpPl4bzZ4kC2trSm4JlqTBZVSWzXTp8nYZbEI=
Received: from x31i01179.sqa.na131.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wj5Vb3w_1752687195 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 17 Jul 2025 01:33:19 +0800
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: linux-erofs@lists.ozlabs.org
Cc: LKML <linux-kernel@vger.kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH v3 0/2] erofs: support metadata compression
Date: Thu, 17 Jul 2025 01:33:12 +0800
Message-ID: <20250716173314.308744-1-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
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
 |         |_______ Vanilla _______|___  378634240 ( 362MiB) ___|
 |  AOSP   |_______ `-m4096` ______|___  377856000 ( 361MiB) ___|
 |_________|_ `-m4096` (lz4hc,12) _|___  377942016 ( 361MiB) ___|

Thanks,
Gao Xiang

v2: https://lore.kernel.org/r/20250711094004.2488-1-liubo03@inspur.com
Changes since v2:
 - refine the ondisk format and implementation.

Bo Liu (1):
  erofs: implement metadata compression

Gao Xiang (1):
  erofs: add on-disk definition for metadata compression

 fs/erofs/data.c         | 59 +++++++++++++++++++++++++----------------
 fs/erofs/decompressor.c |  2 +-
 fs/erofs/erofs_fs.h     | 15 ++++++++---
 fs/erofs/fileio.c       |  2 +-
 fs/erofs/inode.c        |  5 ++--
 fs/erofs/internal.h     | 19 ++++++++++---
 fs/erofs/super.c        | 22 +++++++++++++--
 fs/erofs/xattr.c        | 20 +++++++++-----
 fs/erofs/zdata.c        |  5 +++-
 fs/erofs/zmap.c         | 16 ++++++-----
 10 files changed, 115 insertions(+), 50 deletions(-)

-- 
2.43.5


