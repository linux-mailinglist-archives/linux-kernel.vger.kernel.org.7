Return-Path: <linux-kernel+bounces-841317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BB2BB7045
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 15:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DBB3F4E232E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 13:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2E917C21B;
	Fri,  3 Oct 2025 13:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKbMNVBc"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC461C01
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 13:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759498267; cv=none; b=WcngTmaQ9YMKqp1gmvYXQdCrIBgqoVtKpzAyWu6We2DIoS6IuSeQC+wrmr0HXa60iohPg66SIVvSMF0Q5V4Y22/b0sF6N9k/R9C0dnVlJs30/Xw2ccLjvt1pX7lwBA+2A0EpKjZySpnIij07PDVDzyc0FmY/VS02M/0wmzLHpGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759498267; c=relaxed/simple;
	bh=M/PYD8FqgY/wvD6rOzHZxSYgVw00CojRui7/mt/ISlM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ASHq7HFLUAwns0u/qHY/vfixL+Pm5GK2X5cNrWw+FvhlYsTcH6MBkwki9cZX9+8zESXwyhfXDem0s/GX2z3SscsIuEU/weL0Yqp92FisVzkHtuV3fTsx5TnOVBzliNGg0YKzHFvuM+jQbo0JDDYwoAEKhL3OvUYI66U8jM6ZVQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKbMNVBc; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-78127433a32so1748366b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 06:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759498264; x=1760103064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SGZud21unrH50dFl0sIlMV///6phEw6y8UIVkHJrd1M=;
        b=LKbMNVBc6GR5/eTcNRHNJ9Byv/TAJn8R5kVaofc7GN4DU0C3VE0aVbbCEjXIuL/y4V
         stww0Ee0oaT7J4UK9JMA4k02By8rfA5gD1K0hcZHRtYqsufgMLQ/x3l/CLTWQ7VcVZeG
         3zp0EI6IJ1TQGKiwRx31zc6pak/ZyvYKk3bVExB6Yjz/ngtExwpsETZSX+g/Pthv936w
         qtBD7SVFgqZKoZJ+cydW0cBv+3g7oT0236/oIIXyrCbBGHGUvcXCGF4ziIG5lJG5INd/
         LrbEVOV0c+GKUP2av07zy63GyuOifdeZeIRaxEP0R5ThHWdmbuYZQxlHxBVGJiptPVB+
         SG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759498264; x=1760103064;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SGZud21unrH50dFl0sIlMV///6phEw6y8UIVkHJrd1M=;
        b=kJzTfstL9gzZKCLrEiI3uIyMaeg3jhjEq2ATpnOY0ZzHq1NTA8VW+TZGj7Z8e/BxIk
         FhqaK0Ec1BpDkJBPFO0J0V+2mpmi/FSbCmhnmwpokEFQRa125qVDDYnDz+0S2QtsTHdl
         HCJ24tF9MSKm0lCEYfDys5pjjbbPUEkUvUqU+pETHrJgVX7y404mjTKWGhGWUYV1PbMq
         HlVFKJ1+qvz5W7jLWlFqZDS56nuQZkTGvQjUFJCqCw4a/apVNScOOeKlD4IlwJ5EtfQu
         KwJOViG6XvJu8To1a6AYplVMKf6Ug0wWtGlVLS2OLv+ebzJhkmsbbbWmFdT5O9WEfwhU
         4IxQ==
X-Forwarded-Encrypted: i=1; AJvYcCVt+ew8CA7GdgBoAhjBHgzBq28ybN4rjRQBwdOqH/pi3fQ3SZiWvQrS3BPJmWaD/qlbrUMSjXFbEwVtLcc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcX6QiMLQjkJCzeaJRCkROSMFvlvDuufJOewrv6J7p2wzfZjfy
	oI0NUFujknszX/CIzR9RscjEzfMk3DN+UCZqJpaDh/H7hSImdfNipK48
X-Gm-Gg: ASbGncsnejg4159mFqb0HBb84q9KyCLV/YZ0iSL6jAZCpVVUBSKbCDKz2PXU3xkWSzj
	AXDAmcPGdB72HSZWOnDdHI2ZUNCdAqrlAm+ky2BieSV2cLYuMSkfuBmwv2PlnDjMN1Qa7on7UR9
	MoiBQbOOOvLU8w7VKzTK0a4E/GAn+Pl9hE2BCTGX/Ja7Ppa24PTw2pXVyclULkbQiwfLKfWbqgJ
	u0aPzAPs6CNzvs259W4dR+/YqMkyuLW0BUXgI1zlhaqB8K852QrzJ311x8M5m5Tkx+nGzP0P143
	zE2GWPpaAykBaBlo/OXjcPbAAizIN0272fPnYuMPISP6QqLxRAFPeQA6FkAfkE4kwGRQnR2Dh+M
	Og8NS+2GtcNQ0V2MnhPGTggRMyMXWA1oDgOj2bKIz2Hu5dFeIO0gCbptS40RvDMyj7IEiMv0dwh
	E=
X-Google-Smtp-Source: AGHT+IHUNFg2+6wlpsRB1KLXor895ZHBGEuyK2qlm9lTRa0xoty9J21fzUwTVsMeDCocct+adtHtjw==
X-Received: by 2002:a05:6a20:a11b:b0:2ea:12b9:2dfa with SMTP id adf61e73a8af0-32b620d927amr4632018637.40.1759498264283;
        Fri, 03 Oct 2025 06:31:04 -0700 (PDT)
Received: from fedora ([45.116.149.225])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099f72c54sm4627884a12.45.2025.10.03.06.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 06:31:03 -0700 (PDT)
From: rtapadia730@gmail.com
To: dsterba@suse.com,
	clm@fb.com,
	fdmanana@kernel.org
Cc: linux-btrfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	khalid@kernel.org,
	david.hunter.linux@gmail.com,
	Rajeev Tapadia <rtapadia730@gmail.com>
Subject: [PATCH v2] btrfs: fix comment in alloc_bitmap() and drop stale TODO
Date: Fri,  3 Oct 2025 19:00:02 +0530
Message-ID: <20251003133001.45052-2-rtapadia730@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rajeev Tapadia <rtapadia730@gmail.com>

All callers of alloc_bitmap() hold a transaction handle, so GFP_NOFS is
needed to avoid deadlocks on recursion. Update the comment and drop the
stale TODO.

Signed-off-by: Rajeev Tapadia <rtapadia730@gmail.com>
---
Change log:
As per previous review the change is not required. So just removing the
stale TODO.

 fs/btrfs/free-space-tree.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/free-space-tree.c b/fs/btrfs/free-space-tree.c
index dad0b492a663..bb8ca7b679be 100644
--- a/fs/btrfs/free-space-tree.c
+++ b/fs/btrfs/free-space-tree.c
@@ -165,11 +165,9 @@ static unsigned long *alloc_bitmap(u32 bitmap_size)
 
 	/*
 	 * GFP_NOFS doesn't work with kvmalloc(), but we really can't recurse
-	 * into the filesystem as the free space bitmap can be modified in the
-	 * critical section of a transaction commit.
-	 *
-	 * TODO: push the memalloc_nofs_{save,restore}() to the caller where we
-	 * know that recursion is unsafe.
+	 * into the filesystem here. All callers hold a transaction handle
+	 * open, so if a GFP_KERNEL allocation recurses into the filesystem
+	 * and triggers a transaction commit, we would deadlock.
 	 */
 	nofs_flag = memalloc_nofs_save();
 	ret = kvzalloc(bitmap_rounded_size, GFP_KERNEL);
-- 
2.51.0


