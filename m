Return-Path: <linux-kernel+bounces-748514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F1C8B14224
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 20:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9103E17EC8C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 18:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A91275B09;
	Mon, 28 Jul 2025 18:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="yYK/bpch"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F8C21D3D2
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 18:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753728220; cv=none; b=P3TtTvFrS2RyuqtB3ueiIRkTv9ecBuZSWh66gRb0ucaGrDldD0ul4Y+RMx9INdZxTiMlpPQGmylWqekO3yBoiDWlfnYT9ukxRSL0x+UB1J/6kMlXmzVqy3mSCF3eHajAtaOkLEcEl+3Gt9egrJ+xk0PwUpMM34KKFKK5HNIYEU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753728220; c=relaxed/simple;
	bh=BeYX5ULWpMzCYt5aj7au6TZM5PYy08OpxDrGvmRS3CQ=;
	h=Message-ID:Subject:From:To:Cc:Date:Content-Type:MIME-Version; b=cV55vsKf4l0sRT7PzvLU00zAQ0rrNhT9PkMedvFNHiJP8fs5RmelkYR5HGyVhm2npYKxAXqtH3WWDSHNwV/Hppg0JNg5nVccjbV3+iYQMcBsdnxFHfe4zeE9GnptY7Y92VjjR3VN8mOt3cecIdZxgxnhbWg1+5UNmea4On2kelM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=yYK/bpch; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e8bbb605530so189046276.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 11:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1753728216; x=1754333016; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt:date:cc
         :to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0MzMyhZAEbqpTatWL0r+pi0WsoTOaw49EBjF+jSRUkY=;
        b=yYK/bpch88mnu3+5RUM3AxLYSIHD3gwFVcwFS/OpDUYT6f2o9DkO/bKtoXb/+YDW/k
         q8iZIc2gFwByuZwRvJlPNupeP94FoKvSZItkphBFbfXvLeV8sHXSUUpb4aDx4nLUiNNG
         VIDqAnf3QsgON+2cnf3ncD0IwvK6FFnvnCab6RtD5DtfxEXmxVrn35IpttifYdp5Tifj
         teZe2GvwQ1XEXD4H6gUkhzIZXFIeVdEPDq2bPYTC7dz6rMemIwbzHMsKRa0aUM4ReGTU
         3yevXwOoeTUB3o+bAGTPKsEiUTc0Bkl/9I74zfLs0bW89maSR9Hj506CXFWa92TYxCuY
         MjSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753728216; x=1754333016;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt:date:cc
         :to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0MzMyhZAEbqpTatWL0r+pi0WsoTOaw49EBjF+jSRUkY=;
        b=s7vVPWNCn2jOE5FHukTfSWVLmP5ZdTZPwN0BoyB1vxIGzVKtZIvQsXsoWmbTqDPcjT
         uX93GKD2cKyKL5wL4hyRB6Whl5GbHTGKDPCEIbBFSGa2OwPbTRzoaCkMnwXzTrYr+2DV
         euU3ckoB9jZ7k18OBiA7Ij5XwkKYLIalxnu6Fvz2HUNbMqEguQkuAgI0EAlXjAYCwtnS
         9UdT+LgCUoGC4I82nCEhuy2BpnYUqEn6HoAwHneXdGOT7Mazy8Xi95sKdbbKTDgUnjLs
         RgyzrVbFTNQvwQQNQA75qC/j3EVHx7892VGGRn1gIywiSNy3HN1WPBtPPcYQmhogbRLS
         yGbA==
X-Forwarded-Encrypted: i=1; AJvYcCXnPAo3tpLEx5/jeUWVHXk292CRNZxb78dqTMcP1xQak7S5RnTWCzY8kck1QAwrwD0QqfMi7XNbvA1XMrU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSQZJW/qGa3OV8nviJphd9bQZNKz8HZsIpqY/qrwRHEF8fQEnM
	r2I57r0tHgS/JvNlYbBm9bHeCtr73mwKPBnabuI9k87K90tU3V/55p6mvBmoXyeawHs=
X-Gm-Gg: ASbGnct531hBqbMn/kS8QOw65/O0Z0pblBtoWBuGx9YZArktbAP9Wc1RAdkjV7/B/0Z
	gblvaaVIWHFGz7ujy71qd6+TZpJW3A9eikz69P/LH4mdWPM3ofNwuoq2dVfYtNq4FOxtxmuT2v7
	HF5dJjTYxDtXIP+KrByGDz0/fncqswqh109zS2fam0AN4bCiC1WI57LzcofUcPWjxlbn5nvm5h5
	EKvcqb71ssDTazXHu4JsPAYU66/Et8/5rji7+wVuCgvNEp6sH+fcCwHf0rAzi/ClKoUrNRcXRkg
	BJqC6DpVehhsJH//p0ZaVLhcHpS9amYfc1wLKMbmf8fO+Q103tTBD/zH4QO0t3zaTgNm11+hNdU
	wCRfBP+kbVAx76s0gGjh7/NvVAI2pbf+/N4j+EuskpGGXGmQrAv+JZnxdXmTxZFcfmRY=
X-Google-Smtp-Source: AGHT+IGzdVl0rhdAl5YCruWrFT4kLton1HptFfWWRFansQ8il3+azupxWoWc45pTa3K31ApMwi2rEw==
X-Received: by 2002:a05:6902:e0f:b0:e8e:2088:394c with SMTP id 3f1490d57ef6-e8e25129ea2mr815304276.16.1753728215525;
        Mon, 28 Jul 2025 11:43:35 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:38e:fb39:4709:1385? ([2600:1700:6476:1430:38e:fb39:4709:1385])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e8df85da9d6sm2149248276.19.2025.07.28.11.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 11:43:34 -0700 (PDT)
Message-ID: <a557f6d129ea4cb7ab1d1ed2232bfa811810abe2.camel@dubeyko.com>
Subject: [GIT PULL] hfs/hfsplus changes for 6.17-rc1
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: torvalds@linux-foundation.org
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	glaubitz@physik.fu-berlin.de, frank.li@vivo.com,
 johannes.thumshirn@wdc.com, 	penguin-kernel@I-love.SAKURA.ne.jp
Date: Mon, 28 Jul 2025 11:43:32 -0700
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hello Linus,

Currently, we have around 221 opened issues in HFS/HFS+ file system
drivers. Mostly, xfstests reveal majority of the issues and multiple
tests leave HFS/HFS+ volume in corrupted state.

Johannes Thumshirn has made nice cleanup in hfsplus_submit_bio().
Tetsuo Handa has fixed the syzbot reported issue in
hfsplus_create_attributes_file() for the case of corruption
the Attributes File's metadata. Yangtao Li has fixed the syzbot
reported issue by removing the uneccessary WARN_ON() in
hfsplus_free_extents().

The rest patches contains fixes:
(1) restoring generic/001 successful execution by erasing
deleted b-tree nodes;
(2) eliminating slab-out-of-bounds issue in hfs_bnode_read()
and hfsplus_bnode_read() by checking correctness of offset and
length by operation of accessing b-tree node's content;
(3) eliminating slab-out-of-bounds read in hfsplus_uni2asc()
for the case if b-tree node's record has corrupted length of
a name that could be bigger than HFSPLUS_MAX_STRLEN;
(4) eliminating general protection fault in hfs_find_init()
for the case of initial b-tree object creation.

The following changes since commit
19272b37aa4f83ca52bdf9c16d5d81bdd1354494:

  Linux 6.16-rc1 (2025-06-08 13:44:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/vdubeyko/hfs.git
tags/hfs-v6.17-tag1

for you to fetch changes up to
736a0516a16268995f4898eded49bfef077af709:

  hfs: fix general protection fault in hfs_find_init() (2025-07-25
15:40:16 -0700)

----------------------------------------------------------------
hfs/hfsplus updates for v6.17

- hfs: fix general protection fault in hfs_find_init()
- hfs: fix slab-out-of-bounds in hfs_bnode_read()
- hfsplus: fix slab-out-of-bounds in hfsplus_bnode_read()
- hfsplus: fix slab-out-of-bounds read in hfsplus_uni2asc()
- hfsplus: don't use BUG_ON() in hfsplus_create_attributes_file()
- hfsplus: don't set REQ_SYNC for hfsplus_submit_bio()
- hfsplus: remove mutex_lock check in hfsplus_free_extents
- hfs: make splice write available again
- hfsplus: make splice write available again
- hfs: fix not erasing deleted b-tree node issue

----------------------------------------------------------------
Johannes Thumshirn (1):
      hfsplus: don't set REQ_SYNC for hfsplus_submit_bio()

Tetsuo Handa (1):
      hfsplus: don't use BUG_ON() in hfsplus_create_attributes_file()

Viacheslav Dubeyko (5):
      hfs: fix not erasing deleted b-tree node issue
      hfsplus: fix slab-out-of-bounds read in hfsplus_uni2asc()
      hfsplus: fix slab-out-of-bounds in hfsplus_bnode_read()
      hfs: fix slab-out-of-bounds in hfs_bnode_read()
      hfs: fix general protection fault in hfs_find_init()

Yangtao Li (3):
      hfsplus: make splice write available again
      hfs: make splice write available again
      hfsplus: remove mutex_lock check in hfsplus_free_extents

 fs/hfs/bfind.c       |  3 ++
 fs/hfs/bnode.c       | 93
++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/hfs/btree.c       | 57 +++++++++++++++++++++++++-------
 fs/hfs/extent.c      |  2 +-
 fs/hfs/hfs_fs.h      |  1 +
 fs/hfs/inode.c       |  1 +
 fs/hfsplus/bnode.c   | 92
+++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/hfsplus/extents.c |  3 --
 fs/hfsplus/inode.c   |  1 +
 fs/hfsplus/super.c   |  6 ++--
 fs/hfsplus/unicode.c |  7 ++++
 fs/hfsplus/xattr.c   |  6 +++-
 12 files changed, 252 insertions(+), 20 deletions(-)

