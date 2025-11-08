Return-Path: <linux-kernel+bounces-891505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C155C42CEF
	for <lists+linux-kernel@lfdr.de>; Sat, 08 Nov 2025 13:36:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4F41734A87C
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Nov 2025 12:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969E4257AD1;
	Sat,  8 Nov 2025 12:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SbZfQk2p"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F4B25A630
	for <linux-kernel@vger.kernel.org>; Sat,  8 Nov 2025 12:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762605381; cv=none; b=FWFk/qBh0Yg5U9jZ0KPyTIJtsDfjDXuvnoZjLiMR+V1hSFfUe6+K7z7D6yRQ3c6/jveMkrtHzlu9Xpkb0lnr0+7cxKdRKvmH8vJmbdspRdJt3VzQU29wJDOCvh0qzh8WbKqxD0+jtFPXlL8AubV2COX842blLjs0bEWCtPga54s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762605381; c=relaxed/simple;
	bh=uRVHkf74PN+NsgRpPhLx88tlLbm6OItPRVdDekAJNfg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WbFLVXCwBaFG2B6AN/CmgrfEhaG6TskJW2uVq0b95uzfpD5wGD2Wvd5hhCZcWBolJbol+C18hStzsUP0EqEai07Ej9aw1qZ3RtIqePix5G3l9TPyW3vjrP1cIltwUw0sL7Z8vYD7WDTwJ6dGwOA2T6+QcZ2m1xUfCDs54F/NVdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SbZfQk2p; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-297cf964774so1748805ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Nov 2025 04:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762605378; x=1763210178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kb8819sRG4CMNnKbcxDJ79PlxuoIzXm9ZoWrsp3orTM=;
        b=SbZfQk2pS/PzjUrbA9LceOfFNNiwGZDO1+ZftxUBKKIigRfxtITCbQjrXobUAO78vj
         XPGhYREsChQoWpuSCejJa3n+PhWkXF1kpIDbn5mB25xct4cBcl9dAfeWxCC2eKpbL2Ue
         xyt3gGbaCLYA+6okZ8tQw+KQD+Anm9ts+Osvq5DmoSOTz/xiPr8tnsS9cpGcW4HAA8HM
         sPK4lBckeVNoB5Ghp/9vV8sZaa2N96HRxpapjCAnIWe4KiLWsp8q/6RlGtllrafXwyRf
         fApRQquKHVRb36aVyydfMxRxUzhVi5fEfyTtGDR+sqvIZe/mDHaQfypZzBY/V+P9Qxwa
         9Raw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762605378; x=1763210178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kb8819sRG4CMNnKbcxDJ79PlxuoIzXm9ZoWrsp3orTM=;
        b=pHbvH6DB3iVBo73vbTSeYgHuez7kdlnQiU7pej0biAW4ob403cgvRmXy6HbKjayUN/
         NrzXqWx+IGlurL3JcWn4+I7Bof6s7SnZ6Q92+ReQ3RtrbV401Z1YpyIZEGfUcFMuxg/Q
         X/g9a4lfLbeXbBi2a0R0Y7jib/IGotYALMciBprPEKqAj/tApAaCHKvk9Js/zw8JJHvh
         TiHKdIXGX4Zgzh50sB4pcGUoGAzh9DbCa024Rg9CH7eNxsf5YI3VafiVDzavbXYoji9D
         vBY57nAeMlN6D9SOeXJ0j4cY1xbyk8vu0bGUi+YS0QyPeG5/s4GdVgnMyiQ+x46WYDzX
         7FpQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8juYPEEPefiR1nxTXCWw254IbCJ873q5GSYsQVv+Ix1oHnz3lamnaCytw22KBJw3dM2Gu+nEzw3jiXps=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/EIQOtJPNrSyGzEzY5tbnBYwbmeWwU43TGfuKaDObWih6Ojtn
	+kWrCPBN7YmEgdLQtEzNu8FV8PSej29IwCXehs2si/lIw9pR99m0X6GaiDHgT0a+a1g=
X-Gm-Gg: ASbGncs3LjCIxPGW9rDGI84bmYj65jwZBnM6Vj5zs7vx54Mwp0dBYqSvrJPtSTXA2kw
	AazkV8D8EgmAfaoMUVYxd9CDoPjwzXrnDLgLVphfLr5icQz4AHIA4mnFfEw4jRDEbhPoVlm7ajo
	2bSZV6NGCuhLWjfBbZz2QRHj/+lHdLwxm9E/V9aH1iBhDumUpuRzLB9aQsx1GMBJTDDJfjwAG1M
	Pbkvgk16dH464tzLc9ifpmtrWL+UST1U4tkaI/oyNH7NCWEWD7yYJYbj7hvfpAv3lXq4lCL2Ayg
	H8+b0dV7rsSkx0Pb137RsXa6XaUHddg+y435zIFKD6gTMBUoonY5qA5mtu/1BUsjrUbXfOEyyP+
	+SHQqxrlpOY3rndcjeKAWEaLuU53Wc5yHmkrrSjqICcDtkUVdVMNSwUvJ4/LNaOAQmEVecSHdwk
	qGMj7QBQdEUgmxxtaF7xsJz4NoLfRwY9S/RcwYVB4EQ4EL+3d9khkkkQRg3s7f0CM8y8BKUJs3q
	QieP/OGyHk=
X-Google-Smtp-Source: AGHT+IHbxRfdUT4HVX6GH+hFiYMSSiTWIZoTQpxma32JqxsfSwUnqkfo6IFizDS0NzlaG/f8uasiNg==
X-Received: by 2002:a17:902:e847:b0:296:549c:a1e with SMTP id d9443c01a7336-297e5649f22mr15677755ad.3.1762605378467;
        Sat, 08 Nov 2025 04:36:18 -0800 (PST)
Received: from poi.localdomain (KD118158218050.ppp-bb.dion.ne.jp. [118.158.218.50])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba901959a47sm7648305a12.28.2025.11.08.04.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 04:36:18 -0800 (PST)
From: Qianchang Zhao <pioooooooooip@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>
Cc: gregkh@linuxfoundation.org,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	security@kernel.org,
	Zhitong Liu <liuzhitong1993@gmail.com>,
	Qianchang Zhao <pioooooooooip@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ksmbd: vfs: fix truncate lock-range check for shrink/grow and avoid size==0 underflow
Date: Sat,  8 Nov 2025 21:36:09 +0900
Message-Id: <20251108123609.382365-1-pioooooooooip@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2025110803-retrace-unnatural-127f@gregkh>
References: <2025110803-retrace-unnatural-127f@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ksmbd_vfs_truncate() uses check_lock_range() with arguments that are
incorrect for shrink, and can underflow when size==0:

- For shrink, the code passed [inode->i_size, size-1], which is reversed.
- When size==0, "size-1" underflows to -1, so the range becomes
  [old_size, -1], effectively skipping the intended [0, old_size-1].

Fix by:
- Rejecting negative size with -EINVAL.
- For shrink (size < old): check [size, old-1].
- For grow   (size > old): check [old, size-1].
- Skip lock check when size == old.
- Keep the return value on conflict as -EAGAIN (no noisy pr_err()).

This avoids the size==0 underflow and uses the correct range order,
preserving byte-range lock semantics.

Reported-by: Qianchang Zhao <pioooooooooip@gmail.com>
Reported-by: Zhitong Liu <liuzhitong1993@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Qianchang Zhao <pioooooooooip@gmail.com>
---
 fs/smb/server/vfs.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 891ed2dc2..e7843ec9b 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -825,17 +825,27 @@ int ksmbd_vfs_truncate(struct ksmbd_work *work,
 	if (!work->tcon->posix_extensions) {
 		struct inode *inode = file_inode(filp);
 
-		if (size < inode->i_size) {
-			err = check_lock_range(filp, size,
-					       inode->i_size - 1, WRITE);
-		} else {
-			err = check_lock_range(filp, inode->i_size,
-					       size - 1, WRITE);
+		loff_t old = i_size_read(inode);
+		loff_t start = 0, end = -1;
+		bool need_check = false;
+
+		if (size < 0)
+			return -EINVAL;
+
+		if (size < old) {
+			start = size;
+			end   = old - 1;
+			need_check = true;
+		} else if (size > old) {
+			start = old;
+			end   = size - 1;
+			need_check = true;
 		}
 
-		if (err) {
-			pr_err("failed due to lock\n");
-			return -EAGAIN;
+		if (need_check) {
+			err = check_lock_range(filp, start, end, WRITE);
+			if (err)
+				return -EAGAIN;
 		}
 	}
-- 
2.34.1


