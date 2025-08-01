Return-Path: <linux-kernel+bounces-753398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF3CB18263
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 15:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F94F3AEBF5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 13:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406BF41C72;
	Fri,  1 Aug 2025 13:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYyxumxF"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FF933D8
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 13:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754054433; cv=none; b=GTA2qY2zsN/68hCEE5lOpk0QxGdKXJuxdUAbKeUuQOuswCN9DqICSQBqcy7LLjJ8lT5XDjxJaH4EZZ7FXP6h8G//S1v3ssxcXUalHyo6Kagr3zjyf+WcxHPhIL/RP4t90/Q3GzxOnfm8YgPrNVio/57nox/daL/MCfmvSil9Z/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754054433; c=relaxed/simple;
	bh=XjuSyWfKixzEQ24rvBLTAh6nrg/7yMjllEowVFEFXFA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=GsSlSioo4NqIud4NAdDRuQTNpin3ArXLkAImDrxgviStm1SjM8U/gxPmsWsP8kpmG5YedDyuN8qDTJTkpc8QyEOPuxt9TWqMKI77jnHysLYOfBMkJmUfTzzepiuVvUWPTPwmOCk9mGvPiGJ7qhVc6+sehMPbrdFaXfQ2P+awNVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gYyxumxF; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-455f7cc9362so2366325e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 06:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754054430; x=1754659230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uztxM7H2O0V+TFZUWGHabEFzemzhN1qUbtIy+mSjrDA=;
        b=gYyxumxF63krBraCnnleGKS6IDDIHjAIAVpFJLmDwRZ3Af864GidyailnbDJQfKSWp
         b/lJH1UbfdyGFqzEt4linC/6s+7m0oFO/lInIEPOndsqffbyUgiVdGcRdgR6R3JwBAZt
         E3Mh967ntNrOxmXtzRD5oStL+V8pgq5QeZdv3m/A1AHqxmzLBv220isOHcvxxs7DsQL0
         ilTra3uze5OGJ8RbayGZdaV2MnXom93+YvhMLxSCvOB4jrBRzvgXwqIa1tWkZanaDGCz
         eQrRdV/MhVgKoHkki2L0neSmTdrM2GbWe9H7Q1xj9P5OGFcwMuQvB5cfpIaJv5yMehgO
         EwZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754054430; x=1754659230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uztxM7H2O0V+TFZUWGHabEFzemzhN1qUbtIy+mSjrDA=;
        b=guYuUfcRjlBIVS/j/lEioVLaM7y0uvTpaUre6HY56ZsQFdWOuxglCZm40QSQw/yDuU
         dWmupefCnx7xt7R37uzBcV3PN8PLXVTiZ2CczVEBFtsyB4HtTOdKZAcZIjgH0xp8My+S
         MnUF1gT+R0M6bd2Pzfyk/zMTC0TzRWoCKRrPa3TCccsd8QWLohmWuu+/odrUI2LEf4RC
         WK5UBvfo6tBqa5eL1fwxMvb9V46i+4JEilfogv63M7P0uotRatkw0scZv5xRTU649RIG
         /2yewSo9LSUeD7KV+b1ZMfIAuos8fxNmontPhpjYvsXqIOxe/caLJrYpdLS6XQMMvv8Q
         0qZQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6RQx7ahmepmBJSW7QW5IUEWVg54doIRwCBdy9jge5B8nlv7a7HhwSJzHn/80RmKsuIcp7UFahsCV5+tg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5jDq52Yk/q9c8PF8nEEZ/kmlZ+6mbhaQ/1T9zNt7R2VZIybHK
	EcxS50HN690Ch3ZAAGnPQC4Hk7GcUMI90YFLtBIsFp1xFBBS9chOjWCp
X-Gm-Gg: ASbGncv0dENrNTTCSdYe/Mc2lYGXJR9UkzWzoV5z6sPfwfzSlGoFl7o2cbUd4P9Z3PQ
	iTSV+gw0k/o98jzPXERJve1vN+ofX4Mg9bZn7+6FNczyVHNKWTqbyf/kbKSXOIf1Jr3Oxy20JXB
	glw81MVVC0BSirrlxAtS10RM00+8iyDwqd4ReiyJqWNXl2VaFAPadZRfrGmrqO3Yxfi2JfkBBPt
	CAWsUKqJxKoBneNtrxaShyqqWVm5bCiavQTMadi8KvEYkBGFCVWCWz2f8WShF9IrL7MEKl6JyW/
	PEpK6RnK62Cl6II18I4o7phVm1iAes9E+lBSRvifKBx8swU31QawcBbRTHrZrVX1ZAMyPOoL+Dq
	6BFljMQGlN75kLwha90oS8dMSoA5zttfBVcPRBXamm6AMJutK4reohnAh2d9PG2sL4VkmSQDN+O
	gRIFUJpIkb
X-Google-Smtp-Source: AGHT+IHmHYArwt4OX8f+1dStz3v/Z2bvtN4EGoCRvRxKigzWESbMcBWPBLztCRwoDvRuYJqFAL9iPQ==
X-Received: by 2002:a05:600c:3e15:b0:442:fff5:5185 with SMTP id 5b1f17b1804b1-4589e8745e9mr28842175e9.6.1754054429861;
        Fri, 01 Aug 2025 06:20:29 -0700 (PDT)
Received: from pop-os.localdomain (208.77.11.37.dynamic.jazztel.es. [37.11.77.208])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4530a8sm5906250f8f.38.2025.08.01.06.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 06:20:28 -0700 (PDT)
From: =?UTF-8?q?Miguel=20Garc=C3=ADa?= <miguelgarciaroman8@gmail.com>
To: dm-devel@lists.linux.dev
Cc: agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Miguel=20Garc=C3=ADa?= <miguelgarciaroman8@gmail.com>
Subject: [PATCH] dm: sysfs: use sysfs_emit() in dm_attr_*_show()
Date: Fri,  1 Aug 2025 15:19:07 +0200
Message-Id: <20250801131907.371700-1-miguelgarciaroman8@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch replaces the existing sprintf/strcat/strlen patterns in the
four dm-sysfs show() callbacks with the sysfs_emit() API, as recommended by
Documentation/filesystems/sysfs.rst. The change has no functional impact.
The output format remains exactly the same—but it:

  - Eliminates manual buffer-length calculations and strcat calls  
  - Protects against potential PAGE_SIZE overruns  
  - Makes intent clearer and aligns with current kernel best practices  

Signed-off-by: Miguel García <miguelgarciaroman8@gmail.com>
---

Tested-on:
  • Built-in dm_mod and loop drivers in a custom vmlinuz via virtme-ng
  • BusyBox-based initramfs in QEMU (x86_64, 2 GB RAM, 2 vCPU)
  
Test procedure:
  1. In the guest shell:
       # mount -t tmpfs tmpfs /tmp
       # dd if=/dev/zero of=/tmp/backing.img bs=1M count=8
       # losetup /dev/loop0 /tmp/backing.img
       # sectors=$((8*1024*1024/512))
       # echo "0 $sectors linear /dev/loop0 0" | dmsetup create testdm --uuid test-uuid-123
  2. Verify each sysfs attribute still matches the original output:
       # cat /sys/block/dm-*/dm/name        →  testdm
       # cat /sys/block/dm-*/dm/uuid        →  test-uuid-123
       # cat /sys/block/dm-*/dm/suspended   →  0
       # cat /sys/block/dm-*/dm/use_blk_mq  →  1
  3. Remove and clean up:
       # dmsetup remove testdm
       # losetup -d /dev/loop0

Both before and after the patch the attribute contents and formatting are
identical, confirming no functional change.


 drivers/md/dm-sysfs.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/md/dm-sysfs.c b/drivers/md/dm-sysfs.c
index bfaef27ca79f..fed9751970a0 100644
--- a/drivers/md/dm-sysfs.c
+++ b/drivers/md/dm-sysfs.c
@@ -68,35 +68,33 @@ static ssize_t dm_attr_store(struct kobject *kobj, struct attribute *attr,
 
 static ssize_t dm_attr_name_show(struct mapped_device *md, char *buf)
 {
-	if (dm_copy_name_and_uuid(md, buf, NULL))
+	char name[DM_NAME_LEN];
+
+	if (dm_copy_name_and_uuid(md, name, NULL))
 		return -EIO;
 
-	strcat(buf, "\n");
-	return strlen(buf);
+	return sysfs_emit(buf, "%s\n", name);
 }
 
 static ssize_t dm_attr_uuid_show(struct mapped_device *md, char *buf)
 {
-	if (dm_copy_name_and_uuid(md, NULL, buf))
+	char uuid[DM_UUID_LEN];
+
+	if (dm_copy_name_and_uuid(md, NULL, uuid))
 		return -EIO;
 
-	strcat(buf, "\n");
-	return strlen(buf);
+	return sysfs_emit(buf, "%s\n", uuid);
 }
 
 static ssize_t dm_attr_suspended_show(struct mapped_device *md, char *buf)
 {
-	sprintf(buf, "%d\n", dm_suspended_md(md));
-
-	return strlen(buf);
+	return sysfs_emit(buf, "%d\n", dm_suspended_md(md));
 }
 
 static ssize_t dm_attr_use_blk_mq_show(struct mapped_device *md, char *buf)
 {
 	/* Purely for userspace compatibility */
-	sprintf(buf, "%d\n", true);
-
-	return strlen(buf);
+	return sysfs_emit(buf, "%d\n", true);
 }
 
 static DM_ATTR_RO(name);
-- 
2.34.1


