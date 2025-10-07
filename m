Return-Path: <linux-kernel+bounces-844880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77875BC2FC5
	for <lists+linux-kernel@lfdr.de>; Wed, 08 Oct 2025 01:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D6FF19A35D2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 23:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67351255E26;
	Tue,  7 Oct 2025 23:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EZ8c0jXd"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE7119005E
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 23:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759880716; cv=none; b=AyxaiQqBf66XDTbndzwHbrsLIJoIk3heEg+lX9s6x7C10MQMuslDnyQs2apLTdhUcY3CcfavLyxscCg2gjnhXy1IMdkG0BaWA08e3rTci6aTp6x+/sdIXEHs2GAsIGioIeoOuu91k6+NzG9IQYJAygoZWQloKWIDU3TWO7pP40A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759880716; c=relaxed/simple;
	bh=t4jCJVkxoZJxN5/EmPGG5tBlDrNWCM4Ia/uSSq0TPUg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fCfzySr/Nro+i3/JTPuXWOy87QzW8oRz8uTBEwOzLbedbt+SU6Uwc23erxdaeUU2LkmIu1udGhR39UJBtXBal0ElioGcCzsnFefyjCF2REmZi6kpXHbJNIntUapP24sBJfAPHXoGQ5xf2pg9E74iteAaZriOACmVV8pgtaCcWMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EZ8c0jXd; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4060b4b1200so5846420f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 16:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759880712; x=1760485512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aDfdN6rIqKoqG6qeZ1NEX3pLR4+cLj1rml/VExyclBs=;
        b=EZ8c0jXddk/1wDxnojFYF0rVadjGeFjZN/iH3AH0kfqlV/sM+tpYFxxqKGDkOCrz/H
         g3RCLhfGdP6ERGS4LmDRF2I//ESpCYXSzwWqhb5BsrbOedlmFLKrv82eOLRNKIuIkkGs
         yaJ16bwXZgI/jhpGn+zd6F+D5zpYPuAWsNk1AqUK6lTjKcim3J97v+GyreRYK2qxl3g5
         RJDlMqk9kNStpBnloXAFfiuDVKNTtgcPhNr0ymiRYBBJxqGOq0pg6uaCA8D9wXM2F3Vm
         BQB+Jm55eVyv4clwy1Axe84re1+93yxyv7diLZsQ9WTp+FbqnGCVxCwfLcq6eqvjBqFA
         LAiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759880712; x=1760485512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aDfdN6rIqKoqG6qeZ1NEX3pLR4+cLj1rml/VExyclBs=;
        b=h7h48m58X05nyGsV+P46HIa0uI5O1UbXQDvX8Bb47lW6oHaDlRZ4aHCghZGiZipLSU
         BUcZ0GOvxBQ4LGoB9K2dyk9Cjw3SwCKgpMnmErlKD2ogG8YBqjUgZg5305xspjIRUCd6
         3QllhO0jxF7pScNJMyVKp4Tc3I6o71UPkREWmXuWS6w+geMyZdqg/zu18CVFSGlr3JEk
         Xf4XoiS64zhCygTNFOA1HdKaNvj9hHFrQyXMLNYBMv25WEgPKL4et83sQjsxYrtYEpwb
         Tm7K0FAIxbPf2QmmiI4UJX5Q8ByQ/BfNEUP3YCHt0AZcSVuX+r5pvd1JysN8HKDqOXKP
         3R4A==
X-Forwarded-Encrypted: i=1; AJvYcCV2CZc5Wln0cUowXUM5zW+TwqPhzvjq9d08d1/Y1Jc09M8nolnxg/zXQZt2mgCWe76xhOyN1O72s2tFgFU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2Tv0iGrmv2QY24Ol9a8XEQcik14F56CDjuRqfOEZFBOTj/SwU
	9OkYuR2Vi8mAw+3MIuMUK/v6Ir12kd9GH08rQh8qzdOkLcQ4ZNFG5tUH
X-Gm-Gg: ASbGncvwesck7tmRK1C27BoDb9wd1PgaombJ7eD8XZ9Ubb1fqdZSN3mgZ9Po2qUtJBR
	3QGUlD4zQyqb1+5FyEAMqT8JZLDbWRNPnSuzehtzsmWm2uxKZl+C2j3jSum6h5Y0w1hRHZKFnjb
	zHHNavvWm49OH/baeT02rTXfDJOGIFTRlRClTlAFKKRU7yBOswfpkfr3QyOJ/iuJa/ZmA8W+Zfj
	E1F7yMhZkEynrKs8IFVgTtBv9FirQWCXmbdnZ7YQr4TCk2HpFMFkw+Sifw4vbwv/xA+0MwgFdG+
	KDv6NBM7Y4GU5q0LckPIIcCOXOcV3yj1nx70N6nnwLTR+W9GystNNOHeYKh03r3NXtjI9I0uMb4
	GD5RI/V4TgszYo+6Zr9mE6R9/5x455P5r3dCCIOBQktPKcqd6
X-Google-Smtp-Source: AGHT+IEt32j5aTlsj5mt5Vj8nJDWXlTmSLYYgW3aLAsDb+6G6ToKNZ2kXLfLfkP0BbJLDMQBydQ4Tg==
X-Received: by 2002:a5d:5f82:0:b0:424:2280:5079 with SMTP id ffacd0b85a97d-4266e7d6d67mr603421f8f.25.1759880712163;
        Tue, 07 Oct 2025 16:45:12 -0700 (PDT)
Received: from eray-kasa.. ([2a02:4e0:2d14:1539:70f9:c50a:91c9:9e0d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8ab909sm26693197f8f.19.2025.10.07.16.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 16:45:11 -0700 (PDT)
From: Ahmet Eray Karadag <eraykrdg1@gmail.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	david.hunter.linux@gmail.com,
	skhan@linuxfoundation.org,
	Ahmet Eray Karadag <eraykrdg1@gmail.com>,
	syzbot+f3185be57d7e8dda32b8@syzkaller.appspotmail.com,
	Albin Babu Varghese <albinbabuvarghese20@gmail.com>
Subject: [PATCH] Fix: ext4: add sanity check for inode inline write range
Date: Wed,  8 Oct 2025 02:42:22 +0300
Message-ID: <20251007234221.28643-2-eraykrdg1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a simple check in ext4_try_to_write_inline_data() to prevent
writes that extend past the inode's inline data area. The function
now returns -EINVAL if pos + len exceeds i_inline_size.

This avoids invalid inline write attempts and keeps the write path
consistent with the inode limits.

Reported-by: syzbot+f3185be57d7e8dda32b8@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=f3185be57d7e8dda32b8
Co-developed-by: Albin Babu Varghese <albinbabuvarghese20@gmail.com> 
Signed-off-by: Albin Babu Varghese <albinbabuvarghese20@gmail.com>
Signed-off-by: Ahmet Eray Karadag <eraykrdg1@gmail.com>
---
 fs/ext4/inline.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 1b094a4f3866..13ba56e8e334 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -782,6 +782,16 @@ int ext4_write_inline_data_end(struct inode *inode, loff_t pos, unsigned len,
 	struct ext4_iloc iloc;
 	int ret = 0, ret2;
 
+	if ((pos + len) > EXT4_I(inode)->i_inline_size) {
+			ext4_warning_inode(inode,
+				"inline write beyond capacity (pos=%lld, len=%u, inline_size=%d)",
+				pos, len, EXT4_I(inode)->i_inline_size);
+		folio_unlock(folio);
+		folio_put(folio);
+		ret = -EINVAL;
+		goto out;
+	}
+
 	if (unlikely(copied < len) && !folio_test_uptodate(folio))
 		copied = 0;
 
@@ -838,8 +848,8 @@ int ext4_write_inline_data_end(struct inode *inode, loff_t pos, unsigned len,
 	 */
 	if (pos + len > inode->i_size && ext4_can_truncate(inode))
 		ext4_orphan_add(handle, inode);
-
-	ret2 = ext4_journal_stop(handle);
+	if (handle)
+		ret2 = ext4_journal_stop(handle);
 	if (!ret)
 		ret = ret2;
 	if (pos + len > inode->i_size) {
-- 
2.43.0


