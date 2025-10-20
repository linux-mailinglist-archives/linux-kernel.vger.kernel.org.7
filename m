Return-Path: <linux-kernel+bounces-860148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 281BBBEF6B1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 08:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 09A634E5EBD
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 06:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F06D2D4817;
	Mon, 20 Oct 2025 06:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YiCweczO"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6462D24AC
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 06:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760940586; cv=none; b=hzxU3OSpA7kmsOb5/k+Hx59szn5q+M8Kdn0m4X3mGjMMBwXsqYrTK3vDZ5xlhBs19gNmj4cFoAI6/xW5Wpu7MbipJ0yxkXBM3D84dOfNXbS3e+ENdzXfMIYZI2eS9n8/NWIhMxun9tNb7j5jvD3mPkf1NgauJPli/uCcMyHAyJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760940586; c=relaxed/simple;
	bh=TSkXx9p+cdcuN4RyjU/7+bxJX0eR43d5i9gSdUnyWqA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RlZKl4zFWVIPXiWq4x3DB9QaT5kUOqSyu4tX00NsoReo1AJT2qz7iDc8t7ZP0KWBFFRh0Cj4tlRUR8Uom7hBGd4MFFiaCejLC84GOQ7o17lxlTGeZDF/X92mOFPRsWZqdq2vUcPFYddnV0vRwkVHnHndMWxmOOF/rDrKCxe3Uzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YiCweczO; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-781251eec51so3117306b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 23:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760940585; x=1761545385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7dfL7kTT70td9Gucubeing58DEa3GtXtMFuhoAEWKt4=;
        b=YiCweczO7qL0bLIbEhBFkfC41vj6JjZ5fu2QrSxURZo9Fj6/stOUNOl19sJiKfVeAJ
         7NcZ6pFWeCNqpo+T4BZHAoc89jp/JzQ9cdAE1u6KxF7Y55rqGe2Gzy4bApllbbh+i9SF
         1XXHwjaWoUHSRVHwDh8B094H/cbYmNapKWlGvhkvJQ+oTHWAl94NpTckDOdWUleFa9J+
         8R1joWKwnjdGABGF1Z7sWVYpoQsHqsn69U3EEyEOt6O3kTSUqFUZi/IW3wewx77p4QxA
         hbXOAxpCFixDoqNpr1bxfYYY1mf90af3x6zonVWjgv+rqO1wnqjw0jEaLPPNWcLxH6v4
         DF/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760940585; x=1761545385;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7dfL7kTT70td9Gucubeing58DEa3GtXtMFuhoAEWKt4=;
        b=qe5MZLoYkGUibgMsjNqjzMEno2ZwtlZliXto9dbqm7cmKIqjKeabq0pOLIBIJNRjjk
         MHd8zlcWj4RS2EtxXYSU173ozdb8T6k7I9ismv81R63y46a/mX9tBlEYNxNUBiDphvtC
         vDerEwArWKyxxEW0rn8yhWQUkK/fPkV241tDZQ3RYDbKaBXK/Knqnezb9TEkuPJI1jHR
         2NEMxs9bDG51aeplFZ7XTlRX5gzfvPWineUVhFjJQgbk+HKV4FuKA2Y0lpiarYYc3w1U
         CA3vsiXzhlvPsEQaOGU423t91VVbiiEBnbVvuX067JR0HLEU7lRXx1q2FUUHEP42/NoF
         05iA==
X-Forwarded-Encrypted: i=1; AJvYcCUfYS+yE2p+xVamtzlppP3+vL5gYd1GvHJ8PWJO6EFrkEodkd/fcxQZAnGlwLqGpXbMpkOIWOo5EFzwO4M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcvqC5cWyVjBsn9NtpI4zZThinhP4EmzyHZ7eb7V/rAFp0ezyQ
	UXjArAaWBt65WW46bTzOuAz/kG+AnMWtYzT+E4rY6CEkxvf/Xg+Y0u3F
X-Gm-Gg: ASbGncs6SJrKb+fe4sC3AEFs7L+INU/rll5hp6LeBmR8rcqTMv1Yfb7YJjNO/uJ/5oJ
	Jn9W0jqmQaWMjEy8HbJfflWDomNdRrKkRm0X1xj1swFzSLJGnaRyRtTAypYnRAF7u7VBg4v9jzF
	2yhOFEq2OruCBt2Hu62B4FwoiiBjByhL8LMuQi6CB4nlW4Rz+SIEutTZ+iI6C2q4naaDHr44Bvk
	urIB04G4B+4G0ZUEvw57Zw6oVBxINGhZOHyRV1K0V7MGJEBky8a7XSddt5ZctLZt0Ps2NdehiAV
	zV/Rs1cvXbcs5FahhM2gLW53jpxMYkTBLsmgHKXmrKMV2SNWfFMPSqY/q9vp4/LNE4SuubmnqZl
	ZDLppSwXYC2vLHQnT5fHQ7TOcLISl+Si+v2hbeQ3of1F5dkYguWhZVDOjwOnrVSfWiv7E5WK8SC
	RxQkSXcxAQDF5ZYSvVlBvH7O2KZw1WeKl2pA==
X-Google-Smtp-Source: AGHT+IHP0ZsMUNHsK2KdZWrtS/RspPbYrWPfyaSqgIWpmkMx5f88SNl3aodjR9lUNwOI0e0SwDclHg==
X-Received: by 2002:a05:6a00:1493:b0:77f:3149:3723 with SMTP id d2e1a72fcca58-7a220d3464dmr13900320b3a.29.1760940584630;
        Sun, 19 Oct 2025 23:09:44 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:af1f:624:50a9:430c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a2301211besm7169019b3a.68.2025.10.19.23.09.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Oct 2025 23:09:43 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+f3185be57d7e8dda32b8@syzkaller.appspotmail.com,
	stable@kernel.org
Subject: [PATCH v2] ext4: refresh inline data size before write operations
Date: Mon, 20 Oct 2025 11:39:36 +0530
Message-ID: <20251020060936.474314-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


The cached ei->i_inline_size can become stale between the initial size
check and when ext4_update_inline_data()/ext4_create_inline_data() use
it. Although ext4_get_max_inline_size() reads the correct value at the
time of the check, concurrent xattr operations can modify i_inline_size
before ext4_write_lock_xattr() is acquired.

This causes ext4_update_inline_data() and ext4_create_inline_data() to
work with stale capacity values, leading to a BUG_ON() crash in
ext4_write_inline_data():

  kernel BUG at fs/ext4/inline.c:1331!
  BUG_ON(pos + len > EXT4_I(inode)->i_inline_size);

The race window:
1. ext4_get_max_inline_size() reads i_inline_size = 60 (correct)
2. Size check passes for 50-byte write
3. [Another thread adds xattr, i_inline_size changes to 40]
4. ext4_write_lock_xattr() acquires lock
5. ext4_update_inline_data() uses stale i_inline_size = 60
6. Attempts to write 50 bytes but only 40 bytes actually available
7. BUG_ON() triggers

Fix this by recalculating i_inline_size via ext4_find_inline_data_nolock()
immediately after acquiring xattr_sem. This ensures ext4_update_inline_data()
and ext4_create_inline_data() work with current values that are protected
from concurrent modifications.

This is similar to commit a54c4613dac1 ("ext4: fix race writing to an
inline_data file while its xattrs are changing") which fixed i_inline_off
staleness. This patch addresses the related i_inline_size staleness issue.

Reported-by: syzbot+f3185be57d7e8dda32b8@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=f3185be57d7e8dda32b8
Cc: stable@kernel.org
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
Changes in v2:
- Simplified to single-line fix (refresh i_inline_size after taking lock)
- The refresh protects ext4_update_inline_data()/ext4_create_inline_data()
  from using stale i_inline_size that may have changed between the initial
  size check and lock acquisition
- Follows same pattern as commit a54c4613dac1 for consistency
---
 fs/ext4/inline.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 1b094a4f3866..b48c7dbe76a2 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -418,7 +418,12 @@ static int ext4_prepare_inline_data(handle_t *handle, struct inode *inode,
 		return -ENOSPC;
 
 	ext4_write_lock_xattr(inode, &no_expand);
-
+	/*
+	 * ei->i_inline_size may have changed since the initial check
+	 * if other xattrs were added. Recalculate to ensure
+	 * ext4_update_inline_data() validates against current capacity.
+	 */
+	(void) ext4_find_inline_data_nolock(inode);
 	if (ei->i_inline_off)
 		ret = ext4_update_inline_data(handle, inode, len);
 	else
-- 
2.43.0


