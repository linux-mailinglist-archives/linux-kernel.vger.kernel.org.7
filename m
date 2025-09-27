Return-Path: <linux-kernel+bounces-834778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D74BA5812
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 03:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FEA7171DD4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 01:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AC0207A09;
	Sat, 27 Sep 2025 01:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZvgQAkMe"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8429134BA59
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 01:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758937978; cv=none; b=d9M/WEesEjgC+sdKPjmu77v5ODe6q8FyjxWAYh1qGoiiE7nXrrcjQc5Ihq0n4aH/NkE7OYbNi/3dvaCpcYEODS7+rxpcxkApALyuhH2n5Yu6JuPNuyVwbeKootpbxzD9ctMQIK0UbIqNHtBNs6MjzRTsPesb9fBBavpr6ILNUq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758937978; c=relaxed/simple;
	bh=ZYXy+qZoq15hPEdWMOX95bXvFqMYr53/l5pbz9JGvLg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JZVCbXiCwcpKF49f+g0qehvkqqIwONC3gDKJgRKtFQEnL5iJ8yBYwQ7GZlRJdJf3DX1/IZDFtXLBucx8cNVfXYymQYGIZspY6PYoA6YZvwgO/FEsB0EI90Wzw9cqvp98ZvGAKKboAXMcsHPEdRE9WdYDjdPfJWMolYiqTVOO9Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZvgQAkMe; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-77f5d497692so3938241b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 18:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758937977; x=1759542777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dNZKuIkpO9xzN0SiRMeuDaqHWkcO0grUi3IMiky7S6U=;
        b=ZvgQAkMeVbAjiqMST/80Z5ZKzU8B3VH8nb7yeHky9iqYNZgd7+4ElqHDr6crbdy3Mb
         +7mQVd4myeKMhq1gtLe8kJblWengKS3RukNYfUyL/AweMYYm/s3zu+eQevSOwsdFV8EI
         k8c1T3fB4QYje79nQ7SNKmoVvpGL9GCNdj1hTsGwhrOoSFhbeyFJZf4eTXLeShumat1U
         887K7V9eqy+zl2nwI3QWSDuz5JZe7BAtWhQ4VjK/dh6v8XiDh82g90cTA530whyxp8RS
         5y2UAGpY/CyHyxX9fzI/TJ4L+4V8cG+ayHmOmDEOPDZytZ9E2gmFl/1VcizZ1NydRF60
         2KcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758937977; x=1759542777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dNZKuIkpO9xzN0SiRMeuDaqHWkcO0grUi3IMiky7S6U=;
        b=JHCEyXOPR76B6TzvVoGtnh/0SpJ51oC4oYFgyl38v+D7d6zC/M4HCzV5XrkSJJNUuY
         W7RjjuifhbqnAVAiOhwpKtVIZpXxdj1+Ksg0pBF003+t2zFnnJnDPcDMOvVAcwojJFyU
         hqYWXDu73pO/17UMgeVnUxptEimVOWHOjozt1Zq1Kksm0BM0kR3WNwCp8N558qa9Lxvw
         /rMwiUGSE47m+RgpjcIXCxLBo834WSblPru1DzUd4PJI9n2vgutHn9uDwx/369jrdb1f
         J0xludhpt3R0jHHFQflZCLw8BJaFGLUSUOjMXofWEGsRylRuKLezVYv630PMBW/g8m1I
         F7ww==
X-Gm-Message-State: AOJu0YzdjYMD6+z5Kf5D8NE9+QnxLKcw3qWztn3I5IUd9dHQpvzEbGHK
	E8/w9RyX3WZ438+IS3maxN4W2QdpO/9nAPQ6gy+cyWurKmwZgW9tHH1W
X-Gm-Gg: ASbGncvjXj0E4XgAXHB4Fn2UNhTSZAolN247/YrPiBWgpGO/5lAFiwi/EpHmz+06wfa
	xW3Z8iy03MhdOJOI359hWHA2jKIjdNj5JhJxb9BDsbz2Sz6ows7ysQQIUU7DDTFDWhI0+QKKDyl
	CSXTEFzUB4BIO3SRvai/xFCVxWoiw41pPp50duPSaQ16QvvWZw32Soh9jKx7XD3xM+7rFsw8pHn
	j4JL9mLvLWUyU5rl2u2YMLgTZ635EL9E/yHoLUzluXaT2PX5s9zxur0PMdjg9+13HwRnz0PJ6l+
	2ARqZsXZoT4d+NDVri72kTwuRwnVNxB2yW7azIy2+e70lGp761wJD8x0dJPg+7gpCoWHzH0vg0n
	dtiYfeHleJD1E3nAc
X-Google-Smtp-Source: AGHT+IHi08UcJp+4yu1Szh8nOEE8/dJqhKWmQapEqXNHok7hka+Vj48+0jZH2f+VFz+uiV1OCaQU3A==
X-Received: by 2002:a17:90b:380f:b0:32e:32e4:9789 with SMTP id 98e67ed59e1d1-3342a257486mr10689082a91.3.1758937976479;
        Fri, 26 Sep 2025 18:52:56 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341be2073dsm10251836a91.19.2025.09.26.18.52.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 18:52:56 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: phillip@squashfs.org.uk
Cc: linux-kernel@vger.kernel.org,
	Sang-Heon Jeon <ekffu200098@gmail.com>,
	syzbot+f754e01116421e9754b9@syzkaller.appspotmail.com,
	Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH] squashfs: add sanity check for invalid inode size
Date: Sat, 27 Sep 2025 10:52:47 +0900
Message-ID: <20250927015247.957452-1-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Corrupted squashfs images can have negative inode sizes. Add sanity
check to prevent negative inode size.

Reported-by: syzbot+f754e01116421e9754b9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f754e01116421e9754b9
Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
Tested-by: syzbot+f754e01116421e9754b9@syzkaller.appspotmail.com
Cc: Amir Goldstein <amir73il@gmail.com>
---
Special thanks to Amir's kindness analysis [1]. I couldn't find proper
tag for credit, so i just cc-ing. But feel free to add proper credit.

Also, I referred method of erofs. but i might be wrong, please let me
know about that. Thanks for consideration.

[1] https://lore.kernel.org/all/CAOQ4uxgkpi4v3NTSTq5GGJEceHHi97iY4rtsAJuo5c-yxu-Bzg@mail.gmail.com/
---
 fs/squashfs/inode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/squashfs/inode.c b/fs/squashfs/inode.c
index ddc65d006063..148cd75f5bd7 100644
--- a/fs/squashfs/inode.c
+++ b/fs/squashfs/inode.c
@@ -426,6 +426,12 @@ int squashfs_read_inode(struct inode *inode, long long ino)
 		return -EINVAL;
 	}
 
+	if (unlikely(inode->i_size < 0)) {
+		ERROR("Negative i_size %lld inode 0x%llx\n",
+			inode->i_size, ino);
+		return -EINVAL;
+	}
+
 	if (xattr_id != SQUASHFS_INVALID_XATTR && msblk->xattr_id_table) {
 		err = squashfs_xattr_lookup(sb, xattr_id,
 					&squashfs_i(inode)->xattr_count,
-- 
2.43.0


