Return-Path: <linux-kernel+bounces-815284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDACB56221
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 17:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 471BB7A216F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 15:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CEA12F3605;
	Sat, 13 Sep 2025 15:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhcpdItY"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF0D2ED15D
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 15:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757779130; cv=none; b=soaCFipvWPhOUKwOD33CO1Rx4wF9lwyUmRTvujdlqec6gPZnM+cZ5tdU4Dr2adQgtiZUB5fy4yQQkLuylFEI6qOhuYT1FqirFp7lH7v+Iiam3bIPVpG2mqYgQmTVrs5ZYOUfu9TRj2wlidyIXDWcje8sfYZ/6CIo8G9bH1Gx33s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757779130; c=relaxed/simple;
	bh=ysEO5UfPlgDYvjZpTZ5QQdgQAIUSS7tS69IXC4Lp6ZU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P97fPDtOMVc9mTdcYESGcuueroVgz7UWk+TioCkX7g6OJCuAzP7Ic5rKzBcKgzgaduq25TB0oIlm3xmiJ23qmSVvs63TFaKUeZ0torf0THksqpBcvbZlH89E0PzBFRKV1NUf7IU5WZ+qPXl5tKgZTX9IwLsC+J7z/78jJag0w0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhcpdItY; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-45f2a69d876so16085e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 08:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757779126; x=1758383926; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4fTzk4osdS7kL0jIAxv8b2eMmWAJ1UpX17/BW+y0ay0=;
        b=RhcpdItYxgncORRtdWuCCiMOBjjIFwyAwEkK7e/p7hMKnwaK/px/jN0inDnXMCMxbt
         AusHNYNVt25z4Ow1i/KhtXhveNCA3yxxLYAIN61yYpd4KDvqO+/HB6IKt5bEJL5H6jIo
         TEePTfx/8P71+JjIBm5k+8LAurTTrxQQG4pd0pjAopIlwz/BdztzSXhbppVMxB7qsehj
         StRNdQa350bSMcmhpST9psqH6LZhv0XtRzlpXqpbDSowQAAAC92sKjbDqS+NeMRSaezc
         NZiB3rHd4YKvzMzc8CVNLITkkjxe03Wv2oyvdsbYNzcc/pGI2U2SlkBBKAvCOQgfO3q2
         GE+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757779126; x=1758383926;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4fTzk4osdS7kL0jIAxv8b2eMmWAJ1UpX17/BW+y0ay0=;
        b=wfXkhKW09A3uuTmOFAjt/zP0mYZ4hARSeXfNycZssDmjenb279WOI+U9ouneOcinv+
         ykubszS1Mbfmbg2qrjQC3wOHLoCerWWU5snutUm+O0zJi5UhE3nBqVSecbkzXqrTond5
         J+4Hth1Fwek4XuYzEm+FjSXRp97eDNO6f1iZwFCap5QXk8YZuA2kI5u75FoiUk28gcyM
         +h8YJFTMIPd14lJFvtQXIt+nN7jCQ07wwL0kyUkFzoxAQz1/nUlZvzen6oNNd28oIlAh
         Fi5Av/cLpV3MTg77gRwhEWiJjyWLhRFmCizhwByLWNaLBLj+ElgKOps61POIpvOrai+U
         4nvQ==
X-Forwarded-Encrypted: i=1; AJvYcCV00VMeKR9wvO8y0aZvlY/eh8/uMmr5GoJTwAxF6fFKQl+DpVjiwz3OZZ5/NdQRZtFWPlH1VAPJK4lzVzQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb4suWCyP8KfPQz2RXagaCL2vTd13M5m2RseZcf0zwGLcL8kQe
	4BrWMunGzbq0TT1Kd/ZL8d2HqiJLVdSDeWrpjqwuOJV/U8b18kTk9rwiZMEB4A==
X-Gm-Gg: ASbGncsf2F4e2N4xoqMiMK2nRdhnapGJz3kDMfjZDX7RTQRLW7WxwrEfr9xQrxeZ3TL
	2b/vxaYJ/I6OHvHBzqNB1cGyNNSbXpxJoYsXUtDa996KgXR8ZKQQdCcUVVg7F+3ZO7Xl5FAcxiI
	bu+6rKC57H0+UWXgcmd4xOEf32Ll+Gh8C+hQgJAMZJTZ8XEFLYMOzjSl8GYW3w7SjNUWLT87jF+
	Ov8NhNdRcJbB3IFT1WyxNoyuOTogYyYivfibxR1bwSbcn7bJGbPn3C9bUqd6Cgknx/U5/tmB9ig
	zNJNqnFpqO2Yp3pCMIKiafsPGTcNy8dWGf0B9tzknCi4sagZXnnvupxsbnMMAppNdkKsau+8VJk
	Uml1aCRhTbU6jqWM5LajZ9tw1fyG0j+2m1VfDO2kVwBdih8UJgqJME5SWJqu6Wpvw/Q==
X-Google-Smtp-Source: AGHT+IEZjKHYvnIe99kbdNvb3qo3o/kahoQ23h4rmRfRqeXhpX+qGek9qlWilTTZAewjhFFXhHpxrQ==
X-Received: by 2002:a05:600c:2113:b0:45d:d5c6:97b4 with SMTP id 5b1f17b1804b1-45f211d4efamr49863105e9.9.1757779125528;
        Sat, 13 Sep 2025 08:58:45 -0700 (PDT)
Received: from localhost.localdomain (ip-94-112-167-15.bb.vodafone.cz. [94.112.167.15])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f290d1512sm17659805e9.16.2025.09.13.08.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 08:58:44 -0700 (PDT)
From: Ilya Dryomov <idryomov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Ceph fixes for 6.17-rc6
Date: Sat, 13 Sep 2025 17:58:29 +0200
Message-ID: <20250913155830.96394-1-idryomov@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit 76eeb9b8de9880ca38696b2fb56ac45ac0a25c6c:

  Linux 6.17-rc5 (2025-09-07 14:22:57 -0700)

are available in the Git repository at:

  https://github.com/ceph/ceph-client.git tags/ceph-for-6.17-rc6

for you to fetch changes up to cdbc9836c7afadad68f374791738f118263c5371:

  libceph: fix invalid accesses to ceph_connection_v1_info (2025-09-10 21:22:56 +0200)

----------------------------------------------------------------
A fix for a race condition around r_parent tracking that took a long
time to track down from Alex and some fixes for potential crashes on
accessing invalid memory from Max and myself.  All marked for stable.

----------------------------------------------------------------
Alex Markuze (2):
      ceph: fix race condition validating r_parent before applying state
      ceph: fix race condition where r_parent becomes stale before sending message

Ilya Dryomov (1):
      libceph: fix invalid accesses to ceph_connection_v1_info

Max Kellermann (2):
      ceph: always call ceph_shift_unused_folios_left()
      ceph: fix crash after fscrypt_encrypt_pagecache_blocks() error

 fs/ceph/addr.c       |   9 +--
 fs/ceph/debugfs.c    |  14 ++---
 fs/ceph/dir.c        |  17 +++--
 fs/ceph/file.c       |  24 +++----
 fs/ceph/inode.c      |  88 +++++++++++++++++++++-----
 fs/ceph/mds_client.c | 172 +++++++++++++++++++++++++++++++--------------------
 fs/ceph/mds_client.h |  18 ++++--
 net/ceph/messenger.c |   7 ++-
 8 files changed, 223 insertions(+), 126 deletions(-)

