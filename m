Return-Path: <linux-kernel+bounces-897971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D86C540B6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 20:01:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CA24D347890
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 19:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F8734BA5B;
	Wed, 12 Nov 2025 18:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFO18ydV"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBF334B1B6
	for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 18:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762973954; cv=none; b=hoIwvRNxcx9RmagqQkD/5h81MJEx8AbLWh/feX22d2C088PmRlnHQpZoUw6zJfl1zaeCrdYjIGu6yO04g4j+FxPXdxV8qHafjHQR1nZuj5nrj1TcMXynuFEZ122w6Hz0X+Y4xvgTQRXDjQQTRvca6XEJ3KnWRjCMZy2hVV88X8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762973954; c=relaxed/simple;
	bh=e+vkzTXZpebv4x57j1CGKLaD1D6tZMW1EsZ1XwAHvFo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IUH7masXhPruuKADTskOj2haNEUCYFdu3O/8EEz2HYKNZxEXlJ80z0g71F5UHtTbKA6PBVng/18Jp6Ko+9dJKw7BRqbGxGfSvBuFZkHgpShHLScL8ZGSmMsYIUmYsiB1+WYStjH1pO3TOFhU9yPs2OLM5/55gEz8fAkj8WM50ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BFO18ydV; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8b1e54aefc5so1098885a.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 10:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762973951; x=1763578751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fkHIbEfS/RNvXEomxAVQK3p1e0eKqwElvBQxcuWip4A=;
        b=BFO18ydVZMP8NS6mCuuGL5zF3P7FOFdS1CjaFAPJEoOXX4p7O54xp7PzVxJ74xk5YN
         l/1zmVA1spvURY30JdxqrZCjTh+uB7eVnwefbKA3bRE9qU1/ifln4G9gJqGhcDynvFqZ
         mKFgVQo30BWBgKjZXKbJ2fFebjii6RdxrEYoIPTB9GKsrVaZnwlkZLrPQegHlEOBt609
         G2qenLm+BQyj1BvbVI/EmYC3vRmEDyXj3RMJKkYR3dOrI+cAV2TywqDqfqrBscUJGp6g
         WEKJEr8cSvg3kjbfa/e8n2aohaRgxwWz4wztbh+XSDoU3F0EOVcBb6R2pyqQhEM8Ro+Q
         eU4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762973951; x=1763578751;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fkHIbEfS/RNvXEomxAVQK3p1e0eKqwElvBQxcuWip4A=;
        b=tNO3dgJmysby2GERJMqnWkXKvikHJ2Yeo+aE2v7UI0yrpkaw735EWwmNNPckFQrzUL
         RBuZ3TP8alRxo6nS/5oEphQ8TYAxdTTNFlyAG7KxwGED+Q44jq/2qrirrTppGZMIY0Vp
         gDIjSjcsTkzwK73GI+Tz6eU4LuBxmwTIrdThaVVaMl5uznNVfIK6PSzO2GwRGhzrjb4n
         b8wEn3hAujaJfgJLSk1LgFbfOCLgsGxRJQM/UtmifGYBow1z1/sokSm84bsQ0KWigQre
         fJuaqDKJr9qSc8Gy6PjXM9ylWPZ3boAitdurwvfCsZ9r3F//zLmF7f0jicbGQ0z0QrtT
         uzbw==
X-Forwarded-Encrypted: i=1; AJvYcCWlC07lXRt4TwZev5/yuArQjeVKCh//x1MmzRsOyHVrWLPTwwndH7JdS+jESD6TOQ32o8CY17qTwn1bye0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNJ5DI2+9MYPudvI/DZgeEfRfV56K7RjQLctqi715N3ueOYEf0
	u6ipd3t5tbrMLh0iaRn8YZia3R1m0C/D3er93joS4CySvxsWTWiHhHgo
X-Gm-Gg: ASbGncvDZhyRy9+dcDLUxOjI0s7CiPg5GLPZIXKbVdXzGLhA/WHlZorPuEt56vlG+7p
	XfZs3uC8+GE+DMKDbiizPqRfhKPo7JbtC9U9FPjNd63sJ0WFPyIFlWyp00xnP9fyHXO9d9M6CK3
	Om7cQ2qYS0HxHYvqq3i8bNQqqfadnn0AWJLDDzKiTwFjmMNcBL62AjuhKbS6UYllLq40G182j6H
	5Y/OIMFSotx5hCFYWHbycJ7QRmaLb2TllX9EV7RoZhaD/B2201X3qHUZFzXEE0iSBfuupmMwTsa
	kd0mYoW1/GuOVMTjIvqb7aBbUpCII0BoCzqBfZXOlKoE34LvlJKvz3cn72WoUiYa7u1CBaQggKM
	ruh4r8gu+e05OyzOwoaMUV8N6uvn4egpi4hnilJ7EutCNA51cFoZa/ivGBDg3UhEdciC/dhHOhe
	LDPVuLjsOdfuoQAznBEzDx
X-Google-Smtp-Source: AGHT+IEZ/eFmBvYWxQT6tHvgfcJ/HtfGiXneBQsdqEwDBB0RGnuIeLuNXC6xaD38X4tP/8xo1OT0pw==
X-Received: by 2002:a05:620a:414f:b0:86e:21a4:4742 with SMTP id af79cd13be357-8b29b987041mr480654085a.77.1762973951464;
        Wed, 12 Nov 2025 10:59:11 -0800 (PST)
Received: from rpthibeault-XPS-13-9305.. ([23.233.177.113])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29a85d2efsm244726685a.14.2025.11.12.10.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 10:59:11 -0800 (PST)
From: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: cascardo@igalia.com,
	jack@suse.cz,
	yebin10@huawei.com,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com,
	Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
Subject: [PATCH v2] ext4: validate xattrs to avoid OOB in ext4_find_inline_entry
Date: Wed, 12 Nov 2025 13:57:13 -0500
Message-ID: <20251112185712.2031993-2-rpthibeault@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aRHSrpFone-SSkZa@quatroqueijos.cascardo.eti.br>
References: <aRHSrpFone-SSkZa@quatroqueijos.cascardo.eti.br>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When looking for an entry in an inlined directory, if e_value_offs is
changed underneath the filesystem by some change in the block device, it
will lead to an out-of-bounds access that KASAN detects as a
use-after-free.

This is a similar problem as fixed by
commit c6b72f5d82b1 ("ext4: avoid OOB when system.data xattr changes underneath the filesystem")
whose fix was to call ext4_xattr_ibody_find() right after reading the
inode with ext4_get_inode_loc() to check the validity of the xattrs.

However, ext4_xattr_ibody_find() only checks xattr names, via
xattr_find_entry(), not e_value_offs.

Fix by calling xattr_check_inode() which performs a full check on the
xattrs in inode.

Reported-by: syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=3ee481e21fd75e14c397
Tested-by: syzbot+3ee481e21fd75e14c397@syzkaller.appspotmail.com
Fixes: 5701875f9609 ("ext4: fix out-of-bound read in ext4_xattr_inode_dec_ref_all()")
Signed-off-by: Raphael Pinsonneault-Thibeault <rpthibeault@gmail.com>
---
changelog
v1 -> v2: change Fixes tag to reflect that ext4_xattr_ibody_find() used to call 
xattr_check_inode() until 5701875f9609.

 fs/ext4/inline.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 1b094a4f3866..7d46e1e16b52 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -1593,6 +1593,13 @@ struct buffer_head *ext4_find_inline_entry(struct inode *dir,
 
 	down_read(&EXT4_I(dir)->xattr_sem);
 
+	if (EXT4_INODE_HAS_XATTR_SPACE(dir)) {
+		ret = xattr_check_inode(dir, IHDR(dir, ext4_raw_inode(&is.iloc)),
+					ITAIL(dir, ext4_raw_inode(&is.iloc)));
+		if (ret)
+			goto out;
+	}
+
 	ret = ext4_xattr_ibody_find(dir, &i, &is);
 	if (ret)
 		goto out;
-- 
2.43.0


