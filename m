Return-Path: <linux-kernel+bounces-722513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EDEAFDB80
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 01:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8128A1AA1452
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 23:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961F022DFA6;
	Tue,  8 Jul 2025 23:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ingK5OZ1"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEEB227B95
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 23:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752015922; cv=none; b=imr4x6JgXlBNWW6s9vQyimQHVVcPpCk5Ep9Qpij8pv2JC5E/c1EZnW2qjtDRV2cYo85SIrjbutdc3fIEMsQB6/lOXpCIu2Q3AJ0m12S0+MoI8g2tlLhmSh8dhCbXGtVAF7jIepJveUYYQYKh/+s+xwbtNbBvKbPAxoZlK6ApBcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752015922; c=relaxed/simple;
	bh=WovQaQ9PikrY5uLmVbsHl3tpSSKbTT19zMVimO8nhF8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sw5gcSS9+66dBAPHGOqC5wVIh5dksRW/M0rAm+LG34WNiqEjskVsYm06PRXMVaBn38XmB14Q+QMnkjnuM0KEyhqdQC6I5T2sMmldnUZqf4Qe0n4SwFvHMSWtAGC+oZdHs6ZSqy43Y+uGdpg5MyG5FWgdScuzBaap1xAHiTf3Q54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ingK5OZ1; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-234b440afa7so48541635ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 16:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752015920; x=1752620720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3nTeLrKufhqWMbv8ZxgNZNY3CTIL94aICMXLX0urdhU=;
        b=ingK5OZ15H8n1DKqWNN4yVu6rO8pZ1M7KqxlMvJNtlek6n68bYH0stV+Trjt23K6LS
         YVjJziYNgh7WZNc+gWgu+iQEFRFuHABxqWxozcY/z97Cv3SY7zeyRKx9COmSelGt15um
         Kr8pRWA25lYKFOzAGtStqwHwac3QnIIYEnPioKIBb5TOlUQt8PubNCCwxf2X+tgEG3UQ
         HlHeizPBz/BMsHuLGOrBUKIP6w5EX64bZJAkoVzCW8nf3aRqMwGhmBExglAW/29XtFUW
         qx4atcksQgcnSW/zpAIc+bOcBQmaPCvfT4rVRx5SrQ72lIhsV1xMp6ym0tWLzMgnYpW9
         PAAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752015920; x=1752620720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3nTeLrKufhqWMbv8ZxgNZNY3CTIL94aICMXLX0urdhU=;
        b=UnhPLbDlXmk3/ro8/mcnFFUAfmXJOLcGo0K3awAazblSz6cIlLe4IyiWrkkW0avyIH
         jzNU7uLFbo7UTmb91VSYFpBDXEStbwgWjCo4Z2ztIDzjIW2E1AnqtV/G0KPVpCVHi7eN
         TpEbwB1dAm1Nz4SkEdav5LM8XOlu4xpJIH8hiuXMQCOFGOdH5n/Of0NqjyAGj3nmBpyI
         jXszT7JEJO2KHkE/9tgf3efiXME9tg5oVWFDayBWq4BkaN64Moss+37QXpaGwYDnOJY5
         K0bG6SR8vGuBlQjBysL+z8AX4b5Wab5HVls6g/J909iYAJXFJ7CXLqB57nceKevNJ6rf
         JfXw==
X-Forwarded-Encrypted: i=1; AJvYcCU9yEmPGoPagSls9watqc+ZRAy6J0TB3FW2i+eAwq8ItO15gMqt7P3ch9sfKgAsAR7CsMl98WzeKl73DBA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFE+jSwvANcNi8XhQn7RJvNTMRkJMpOQgTob9pS1mXjAXwdAw7
	SGNNYWOzE0lYQ/bVf8CbWCnYm4MukGzS8Ctk/iz5LV7GWD9Q3MCY96Hf
X-Gm-Gg: ASbGnctOyzy9x/7bgv+tcvQyW+B+VmahhEi2xtJWYOgIZTuwiKNc2hBKzEeiICVb+1k
	s85VBpqyLebewzx986PzxgKCFzq7/sf98cmaCXIZ0b/9m11S05qFGzrCA1517aZjBS5/R8s/FVA
	agS4YZfghsWwHUZ0RXZxDTanzR8mXLx4b30zuyHKneFF2dYx3h1Wmh/12H21Jv98oAs9JL61u8p
	2+H/EkvaavwHujU5QUQe/6zndC+kdmg1tjCundOBoUh9ewTlUUZN6JN+lCIaALHdNp/tf5xbHau
	9duEk3mXQbLsdIoeE1RpUX6dyNnPZLFNvYXUlkaXWxkvCqQoSWN31pjLN5itCyT3
X-Google-Smtp-Source: AGHT+IEKFLgqtEP19+48DpnOvxj3AeRJtQt+1/a9IT4AzzhP5p8Oq+cBQQrGaVgjDHWgXi4OBaDXaA==
X-Received: by 2002:a17:903:2888:b0:236:363e:55d with SMTP id d9443c01a7336-23ddb2f2e2emr3240005ad.28.1752015919744;
        Tue, 08 Jul 2025 16:05:19 -0700 (PDT)
Received: from p920.. ([2001:569:799a:1600:edd4:8189:b111:bc2a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8434ee13sm118879925ad.70.2025.07.08.16.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 16:05:19 -0700 (PDT)
From: Moon Hee Lee <moonhee.lee.ca@gmail.com>
To: almaz.alexandrovich@paragon-software.com
Cc: ntfs3@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	syzbot+b0373017f711c06ada64@syzkaller.appspotmail.com,
	Moon Hee Lee <moonhee.lee.ca@gmail.com>
Subject: [PATCH] fs/ntfs3: reject index allocation if $BITMAP is empty but blocks exist
Date: Tue,  8 Jul 2025 16:04:55 -0700
Message-ID: <20250708230454.156971-2-moonhee.lee.ca@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Index allocation requires at least one bit in the $BITMAP attribute to
track usage of index entries. If the bitmap is empty while index blocks
are already present, this reflects on-disk corruption.

syzbot triggered this condition using a malformed NTFS image. During a
rename() operation involving a long filename (which spans multiple
index entries), the empty bitmap allowed the name to be added without
valid tracking. Subsequent deletion of the original entry failed with
-ENOENT, due to unexpected index state.

Reject such cases by verifying that the bitmap is not empty when index
blocks exist.

Reported-by: syzbot+b0373017f711c06ada64@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b0373017f711c06ada64
Fixes: d99208b91933 ("fs/ntfs3: cancle set bad inode after removing name fails")
Tested-by: syzbot+b0373017f711c06ada64@syzkaller.appspotmail.com
Signed-off-by: Moon Hee Lee <moonhee.lee.ca@gmail.com>
---
 fs/ntfs3/index.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 1bf2a6593dec..6d1bf890929d 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1508,6 +1508,16 @@ static int indx_add_allocate(struct ntfs_index *indx, struct ntfs_inode *ni,
 			bmp_size = bmp_size_v = le32_to_cpu(bmp->res.data_size);
 		}
 
+		/*
+		 * Index blocks exist, but $BITMAP has zero valid bits.
+		 * This implies an on-disk corruption and must be rejected.
+		 */
+		if (in->name == I30_NAME &&
+		    unlikely(bmp_size_v == 0 && indx->alloc_run.count)) {
+			err = -EINVAL;
+			goto out1;
+		}
+
 		bit = bmp_size << 3;
 	}
 
-- 
2.43.0


