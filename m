Return-Path: <linux-kernel+bounces-756009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0549B1AEAD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 08:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37AFC17C07B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 06:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EA9D1C861A;
	Tue,  5 Aug 2025 06:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZWIrT2/q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF14521C16E
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 06:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754376414; cv=none; b=oULXDYxZDHdIyLqOslPKa5Zm2cGYad6OcG5vj/Jsu3+387+S/181AIUwl05nrs/bav9NwKTaRtJdKIlPl7GSgkLxV21nBKApcMXbp/h8rkh5Jwg2ewc56QUmOwVhbY2qZw9NQW2fQsIxLCjZ2tL3Ltry6xWHwY/Z8YweQ1PMkCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754376414; c=relaxed/simple;
	bh=EDiniWOnC5JT2ZDLVI432IWzxmkyUZa/X/za3lSG+Hw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=f7bk69hsT8BKff4wVQjexmgzXNF6NLh+GeQLBwhfHvPcI8l5+Oif4bX2NNzTs3hJTCESLAZnj/87Yk7vFSUoVocIsvK27qNPndMF/tohS3dXEx4s35QfhsSPbb+17mcglEFmAzRDLK/IJxnJMkAj9EiRxiEU26Xhqu34Ph/pW6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZWIrT2/q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 319E0C4CEF9
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 06:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754376413;
	bh=EDiniWOnC5JT2ZDLVI432IWzxmkyUZa/X/za3lSG+Hw=;
	h=From:Date:Subject:To:Cc:From;
	b=ZWIrT2/qHBzQsxafqWBMJU2PWctKWvwlUIrUua0/ecVlcHXjBTHub61A2XQ97fLxL
	 z6VSV053FJFTxgqaiqPFnWxaNKT1q1luzcL2w8EBUVYLSPFgApwkCmrtDIhTPGwD4o
	 6hhZS8VNPHnXiVPzkx7YeG3lt45+Uwpr+m4j4lPGuZRnSBM+U9d0qBQRFbsbw8r1p4
	 STZvWur+SwovVPmtinGch6foTDszf0EzO9F5mPhcWZtt9b1ZTknZJEDo6vjZ6xMiCe
	 TT8eCo8r4jo/blcQFXTcs45FgOLRnN6IhAFith2T0vhCHS+b85xK0+YmUGjasbhryU
	 r5V21TCuu/LtA==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-60bfcada295so6587001a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 23:46:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXyMaGahYYy1XyGliGMYwvEBcPFnmG5f1Jc/tY6AfzMc6BeUrSrNM7bdK1mZb7R4u5rquGwS3N7jcgVD8Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKcZY39SxO4tqK/+Eh4W8U89Fk4PYc7lc4uV3nu3m1TnMqtInr
	9U7eMd9Fp6qhfL9L4PJGaEtFaKmYVMiegW0oegjcFtGY6SwwwRTdXwzruzYJMntNBGSXr5gKnwS
	sXTcz2Tvl2Ubgd4vdhu5O/YJl4qmxu+s=
X-Google-Smtp-Source: AGHT+IGXTNxuJb2cpp2FQC6CrLAzwzJThe4mq5hDLwjI3XnIaE6kGwEZi+FbuYmxjSpz2ibniYLdzzgxSprlexJs/QQ=
X-Received: by 2002:a17:907:7f2a:b0:ae0:cde3:4bbd with SMTP id
 a640c23a62f3a-af94023020amr1307876866b.44.1754376411711; Mon, 04 Aug 2025
 23:46:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 5 Aug 2025 15:46:40 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9Lv6B+f1pzMW_yfQfANXNs1HYuD0h-5zixf3xVNUy6pA@mail.gmail.com>
X-Gm-Features: Ac12FXxzmXzsFpZow3kQrD5pKm6Gy4jRW_OXPTQQA76u3JS-sFO6A7VzTKlhMlM
Message-ID: <CAKYAXd9Lv6B+f1pzMW_yfQfANXNs1HYuD0h-5zixf3xVNUy6pA@mail.gmail.com>
Subject: [GIT PULL] exfat update for 6.17-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Sungjong Seo <sj1557.seo@samsung.com>, "Yuezhang.Mo" <Yuezhang.Mo@sony.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

This is exfat update pull request for v6.17-rc1. I add a description of
this pull request below. Please pull exfat with following ones.

Thanks!

The following changes since commit cbbf0a759ff96c80dfc32192a2cc427b79447f74:

  Merge tag 'mtd/for-6.17' of
git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux (2025-07-31
13:43:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git
tags/exfat-for-6.17-rc1

for you to fetch changes up to 99f9a97dce39ad413c39b92c90393bbd6778f3fd:

  exfat: add cluster chain loop check for dir (2025-08-01 08:34:23 +0900)

----------------------------------------------------------------
Description for this pull request:
 - Use generic_write_sync instead of vfs_fsync_range in exfat_file_write_iter.
   It will fix an issue where fdatasync would be set incorrectly.
 - Fix potential infinite loop by the self-linked chain.

----------------------------------------------------------------
Yuezhang Mo (1):
      exfat: add cluster chain loop check for dir

Zhengxu Zhang (1):
      exfat: fdatasync flag should be same like generic_write_sync()

 fs/exfat/dir.c    | 12 ++++++++++++
 fs/exfat/fatent.c | 10 ++++++++++
 fs/exfat/file.c   |  5 ++---
 fs/exfat/namei.c  |  5 +++++
 fs/exfat/super.c  | 32 +++++++++++++++++++++-----------
 5 files changed, 50 insertions(+), 14 deletions(-)

