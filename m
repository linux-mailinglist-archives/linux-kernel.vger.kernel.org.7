Return-Path: <linux-kernel+bounces-811494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AE6B529F2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 09:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8336858136E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 07:29:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5905B26D4D4;
	Thu, 11 Sep 2025 07:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b="zgp44XFw"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521FC26C38D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 07:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757575781; cv=none; b=T2DZ8ixbHeFkz0gPpAE4awMckCmyxDhyETTEAfPZ0uw5jFj+ImAgmimLPuO2lPt/Zl4Whx+9ywCoELnKuD+dYwyrR3teJ+0B5FqJhMOzSYsygT3QeeOIaHZdZde+ne1NJZLJkNLgBpPPEqImTno1mNp8PY9FtQ0ljYXAtpadikY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757575781; c=relaxed/simple;
	bh=dzyPDAyBY3iE453hKGZWh2GhozhS+rLJS+JK8T73SRs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L/D1fnzEO+rmuGvcLvU0u5Dtnbskl5LUVi9OpBkDfEPWvFnDf9pl4ft7O8w/VReomI4IUvpVXakRaDYVq+Ct5X7j5DAEynDA2vcXSk5vvmB8+T8OqtI717sfdGYe3Zr/SbxK5MzncdbhBgsNtxVXS5jVi7svcKHooGwma8/MAfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw; spf=pass smtp.mailfrom=gms.tku.edu.tw; dkim=pass (2048-bit key) header.d=gms-tku-edu-tw.20230601.gappssmtp.com header.i=@gms-tku-edu-tw.20230601.gappssmtp.com header.b=zgp44XFw; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gms.tku.edu.tw
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gms.tku.edu.tw
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-251ace3e7caso5134625ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 00:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gms-tku-edu-tw.20230601.gappssmtp.com; s=20230601; t=1757575777; x=1758180577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D81Vt79I/BTOBBePW6+0X1oh6zDyKaYVMRC1TVaQyRM=;
        b=zgp44XFwPbkb7o2cKpnE2r7Xs7lyjr3cY0QI3HrjgdAMbh33t/+5pXXQkW2WYVI5k4
         gh9OK4ITqPQEKt272Qe5ZGfLR1PhrTkWsnMwPRx9vexHj3RpxsXU6/oWTg3QH12gPJd6
         dq9lK3cBKwbcf2ypExkbHjSOxcRvzRuTcFPWLJZ21iUtqgYS22oPWVB9vl8UXiyVQInD
         MlcHyJKYUXz7hr9V4wKVU3sRkvF6h8HgWlfPLLWFJb1OCPkYruVQNudDBIzLwkwNBAi6
         9Oh57zk/RWXKrzNKhXLii6F4JOjfsMqdG9ETPmPx71gVAwGkHkmKGHAQHgzh2XUo+25j
         ZJqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757575777; x=1758180577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D81Vt79I/BTOBBePW6+0X1oh6zDyKaYVMRC1TVaQyRM=;
        b=BnRrOZ0apQueMII9HB8ly8bSgTzTbZzTxXi1uWNxBtCD/BkBjbktioaSD8BIpQ5PfQ
         hrl+TkeBGBLexv9xvgxOz4Tg82fc2mR3y3pKu2yXsalwanEwmHRNAF7cmj8/d7j6roYW
         Qb1Q1Gn8BnrKbz+UL19AakrsOLXuHl4+ou5TN1+R+cbfveIXVROPenBYs7Et1Bu6tyI+
         EridWpkbpxRUwTDoIpCQQ3oEcVMjnaJpn2nqsq6f2lJ4QJN0r4gQvA705QKcxM88NoEw
         qQYlJozGE9NXBvBfLx8m6alsNiu8SCMtw6EnvL5CJnlvaiMPIom1GHfGIogT9qSu1mrc
         NgXA==
X-Forwarded-Encrypted: i=1; AJvYcCUNrAs75C2zsjdB+eG3Wgm5G9bMakpQOeIo5Z0WG/paQBryMv8aIqkNmvJQVdGPken7GIGy10wJY+NSG7k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMjGLYJkAuPu0C8Hh0uJQqS/adRYLVFwjRzSO3V7CL8F6Y/q10
	Yhrs2ksgKb2EG/P1vMonpd1MZ/NY/Ex5OVV2p/UZsxL2VGUXzaO/mXyptroZ0RS6DwE=
X-Gm-Gg: ASbGncvu3xx/FA5eGmgYhLy0T+Qv5RIoU8UFIwMmlISV8Jx0KsCgGfJZwwKcGLwCO9H
	U3UVxdw8MKr6JpEs7S5BhE6Yr9+P9yjFAanAk5Tz+AAmn44PfUS8/hZ1ZXUG0qtNQcde6txFpN2
	7W9C9wJpD5cDvnQEzXKSh2TVdx5AHQ03t6QQvwnAXCyMNExzxvND05zh4YRb/HFu9rfEJorqRa2
	e1gbS9RyNafdav7TLAGFlBbPOk3C4cFI4MpPW//QSrRD8A61DRoJG0mshx68JxT/HWIRU4qCJF7
	vP4Wbvv1F1VMVqn/5f3ALGT+Uf91Ott0L3FYp6WOGQHX2cjHTTQEdVXZEATonQdkRGhsyiincUs
	48s8H5BtLUNslYxKWxzrbt6k8a9og4r8Uu45vYP0Ki5BfZgslT2hkAKScAQ==
X-Google-Smtp-Source: AGHT+IHO7xlf6/5dPDqWynFAANB+M0UuBkmme6pcsf85zd3+cmkflA/c+A0enwc+u10nZW1Fv/oP5w==
X-Received: by 2002:a17:903:1111:b0:251:3d1c:81f4 with SMTP id d9443c01a7336-25173bbbab1mr288649825ad.54.1757575777526;
        Thu, 11 Sep 2025 00:29:37 -0700 (PDT)
Received: from wu-Pro-E500-G6-WS720T.. ([2001:288:7001:2703:7811:c085:c184:85be])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c37293ef1sm9838395ad.41.2025.09.11.00.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 00:29:36 -0700 (PDT)
From: Guan-Chun Wu <409411716@gms.tku.edu.tw>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	xiubli@redhat.com,
	idryomov@gmail.com,
	ebiggers@kernel.org,
	tytso@mit.edu,
	jaegeuk@kernel.org,
	akpm@linux-foundation.org
Cc: visitorckw@gmail.com,
	home7438072@gmail.com,
	409411716@gms.tku.edu.tw,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	ceph-devel@vger.kernel.org,
	linux-fscrypt@vger.kernel.org
Subject: [PATCH v2 0/5] lib/base64: add generic encoder/decoder, migrate users
Date: Thu, 11 Sep 2025 15:29:25 +0800
Message-Id: <20250911072925.547163-1-409411716@gms.tku.edu.tw>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduces a generic, customizable Base64 encoder/decoder to
the kernel library, eliminating duplicated implementations and delivering
significant performance improvements.

The new helpers support a caller-supplied 64-character table and optional
'=' padding, covering existing variants such as base64url (fscrypt) and
Ceph's custom alphabet. As part of this series, both fscrypt and Ceph are
migrated to the generic helpers, removing their local routines while
preserving their specific formats.

On the encoder side, the implementation operates on 3-byte input blocks
mapped directly to 4 output symbols, avoiding bit-by-bit streaming. This
reduces shifts, masks, and loop overhead, achieving up to ~2.7x speedup
over previous implementations while remaining fully RFC 4648-compatible.

On the decoder side, optimizations replace strchr()-based lookups with a
direct mapping table. Together with stricter RFC 4648 validation, this
yields a ~12-15x improvement in decode throughput.

Overall, the series improves maintainability, correctness, and
performance of Base64 handling across the kernel.

Note:
  - The included KUnit patch provides correctness and performance
    comparison tests to help reviewers validate the improvements. All
    tests pass locally on x86_64 (KTAP: pass:3 fail:0 skip:0). Benchmark
    numbers are informational only and do not gate the tests.
  - Updates nvme-auth call sites to the new API.

Thanks,
Guan-Chun Wu

---

v1 -> v2:
  - Add a KUnit test suite for lib/base64:
      * correctness tests (multiple alphabets, with/without padding)
      * simple microbenchmark for informational performance comparison
  - Rework encoder/decoder:
      * encoder: generalize to a caller-provided 64-character table and
        optional '=' padding
      * decoder: optimize and extend to generic tables
  - fscrypt: migrate from local base64url helpers to generic lib/base64
  - ceph: migrate from local base64 helpers to generic lib/base64

---

Guan-Chun Wu (4):
  lib/base64: rework encoder/decoder with customizable support and
    update nvme-auth
  lib: add KUnit tests for base64 encoding/decoding
  fscrypt: replace local base64url helpers with generic lib/base64
    helpers
  ceph: replace local base64 encode/decode with generic lib/base64
    helpers

Kuan-Wei Chiu (1):
  lib/base64: Replace strchr() for better performance

 drivers/nvme/common/auth.c |   7 +-
 fs/ceph/crypto.c           |  53 +-------
 fs/ceph/crypto.h           |   6 +-
 fs/ceph/dir.c              |   5 +-
 fs/ceph/inode.c            |   2 +-
 fs/crypto/fname.c          |  86 +------------
 include/linux/base64.h     |   4 +-
 lib/Kconfig.debug          |  19 ++-
 lib/base64.c               | 239 ++++++++++++++++++++++++++++++-------
 lib/tests/Makefile         |   1 +
 lib/tests/base64_kunit.c   | 230 +++++++++++++++++++++++++++++++++++
 11 files changed, 466 insertions(+), 186 deletions(-)
 create mode 100644 lib/tests/base64_kunit.c

-- 
2.34.1


