Return-Path: <linux-kernel+bounces-823600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCD0B86F39
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 22:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DAD61CC0C08
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 20:49:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB2B264A72;
	Thu, 18 Sep 2025 20:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcJZT5ig"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8DB2F0698
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 20:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758228536; cv=none; b=m8kQ+ctAC3iJSWNvh5OruB0SBNl7eliM69QNcO9RAB4JT2+YA2b5v6t3SvxwcRHewKzhVRnaMj+kJvbqBbAq0mcz6lh9lZEFjU5pOQzlPd8ZVEULb3G1nqPPZ/iluVh/qo6cP+GrMFjzqrbnkUiRwjeEhA+2bfacJEFqGQoliEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758228536; c=relaxed/simple;
	bh=R8VdHAizxiIZiX4FLFq7J/L0lVxWiWwNMZ7Ks/nE3G0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uXu44zoiZAgsjQOKL6s5e5Ipa7q4uERliHnyC98/0G5pl4pTRq6x4Lhia4vRjZTJXzumSRzdCiNUuhjNmaC7HOmKk2vjuDDW5XsLVHsTHdL6zj/510qtI/o9f1sf+mYRdnJzYJeH4tptPCC0HEaexamt9MQY46KTji7GLbrjTn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FcJZT5ig; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2445826fd9dso16967955ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 13:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758228534; x=1758833334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RWvpfkXVsTXpCF10bCqC7yVTYFDAtVdXNdJBDL/F03g=;
        b=FcJZT5ig5HodYEg6hZZNIh/LEu1+Y1Vi26wz+PqpAoFVzoLWv+fQfY9LXjNCt5zfJX
         CB7e8l0e0kFgL2Lffp78GEGYlwEm8FLA4oNtc7uGeYSHgo+liMHQe9zEYCY/9q7LDRIe
         XzQSwUQIc/AVdF/CDugLwUfsEMcjxqIZRD8dwiyVCV00mg74RiE1YVfcJGNmDl5IYiD8
         7njtgvwzf5YITiBvCff14NCA8kXfCyNxSsZXwKwJEPX338LJMZFZjOQ5KuWiPPN8cKLM
         xy5kwIqzXADLaecBkwsed7/RbAgB9+hN9cn5R49qiUurUKJa193GrKqa2QE72NPIelBW
         TbpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758228534; x=1758833334;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RWvpfkXVsTXpCF10bCqC7yVTYFDAtVdXNdJBDL/F03g=;
        b=XUcP6hFH8+JqNZCIdmO/EBCeJdXSFj8wa4qGIZMwJLr11u1ZThSSWlo6GIUh516qAR
         pJXmNCqfWJ98dgv6SkLuIiXKr8FWl44bClDiAi7qSConhpWshrmwRDkhh2ylQzON/P6I
         yjkyJwgZLS+uMQV60He67SY1Wy79evcO48bIRQ9/yJ2IlGekCibeUxSdN3YFBzEWEpsf
         LXwxo5iXoEAFu/WwtpnAbTFt7eTCzhjGvQw8ifagMIGwxlYwQOiyi+5IajBTY9rAp/sX
         XiuMOu5ssB0xf2F0tQXyU5lOAzGRQQ5KBwTDxE2Fpwel0T+TJOEyMHlKjzj/enQx54ux
         t8vw==
X-Forwarded-Encrypted: i=1; AJvYcCXroh031M6ltXSsXZguLgZ2ZrOqGoi+ur5if0nBF2HsSNRS73+3345HYkYa2xh8Blt3bQcKuFvIjZYLcno=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAFplwfdZKnCymcJNJI2Fl7v0CpaSqTHb6CQCHZc9Nhc9R9QIG
	3PM75MNjSxDrb82bBox7NsFfg8rH9QZJ+2/28ofpLxUX4k0vVdnxmEWh
X-Gm-Gg: ASbGncsEdiEN/Dk4Uc5e4ZxE3944MGdLBb35v0uuhvdjk14AQvVo1+x+hNXuCGM+8D2
	41GMuKSDRhhTl5TsUgNiyy9gP9ndpo2AaI+qRv2Znn08vg9Rh5S89s3Ah4w4ND9pP/atxNCU89X
	vnByzS6jeepLWMj+s8AjrdNh6BD4tMKQFyz+jD34yUSJRONBsjzizz5a6uXhfHg+62JkdVp8Q3+
	LfAKrcrt1r2PXlpIFWL6kD5vjSeyY6w148yX6/auJ7q6QuS6GxKB5/zDuPgB91koDiGhwZ/SV7R
	eYcUYQgKaHYvaO3R52WGCY6CxRpLIJ80nGiH4LsztGtYjMrdvo1FHOarQTQlDrkqdtJAKllNQ7E
	mklUFI9kKyVSXqDocby60mjoO4NHV3TEzTug9tHJEzMZyX+1xTzqQXotneOx1e2hFbjL+GXmAGD
	IOzlVRsMME3aSEecfOyCQNnxiLx5249ZqrUntntMIJBbc7
X-Google-Smtp-Source: AGHT+IGvApn9NcuvVzGprdBHvz9fgjbBfoh2S7GiEqj/2hx5hOyGCmpC/rOdk8KdIWmY96AzPPcNKQ==
X-Received: by 2002:a17:903:2ecf:b0:267:776b:a31a with SMTP id d9443c01a7336-269ba517048mr11002435ad.29.1758228534309;
        Thu, 18 Sep 2025 13:48:54 -0700 (PDT)
Received: from crl-3.node2.local ([125.63.65.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-26980368ef4sm34486625ad.149.2025.09.18.13.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 13:48:53 -0700 (PDT)
From: Kriish Sharma <kriish.sharma2006@gmail.com>
To: agruenba@redhat.com
Cc: gfs2@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linux.dev,
	Kriish Sharma <kriish.sharma2006@gmail.com>,
	syzbot+7567dc5c8aa8f68bde74@syzkaller.appspotmail.com
Subject: [PATCH] gfs2: add bounds check for rd_length in compute_bitstructs()
Date: Thu, 18 Sep 2025 20:48:30 +0000
Message-Id: <20250918204830.229918-1-kriish.sharma2006@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

compute_bitstructs() allocates an array of gfs2_bitmap structures
using kcalloc(). The function only checked for length == 0 but did not
guard against excessively large length values.

If rd_length is too large, the multiplication inside
kcalloc(length, sizeof(struct gfs2_bitmap), GFP_NOFS) can exceed
KMALLOC_MAX_SIZE. This leads to the allocator calculating an order
greater than MAX_ORDER when calling get_order(), which is invalid.
As a result, __alloc_pages() warns about the bad request.

This patch adds an explicit check that rd_length is not only non-zero
but also within the maximum safe limit for kmalloc_array():
    length <= KMALLOC_MAX_SIZE / sizeof(struct gfs2_bitmap)

This ensures that get_order() is only ever called with a valid size,
resulting in an allocation order within MAX_ORDER

Fixes: b9158815de52 ("Merge tag 'char-misc-6.9-rc7' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc")
Reported-by: syzbot+7567dc5c8aa8f68bde74@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7567dc5c8aa8f68bde74

Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>
---
 fs/gfs2/rgrp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/gfs2/rgrp.c b/fs/gfs2/rgrp.c
index 26d6c1eea559..a879e8030568 100644
--- a/fs/gfs2/rgrp.c
+++ b/fs/gfs2/rgrp.c
@@ -760,7 +760,7 @@ static int compute_bitstructs(struct gfs2_rgrpd *rgd)
 	u32 bytes_left, bytes;
 	int x;
 
-	if (!length)
+	if (!length || length > KMALLOC_MAX_SIZE / sizeof(struct gfs2_bitmap))
 		return -EINVAL;
 
 	rgd->rd_bits = kcalloc(length, sizeof(struct gfs2_bitmap), GFP_NOFS);
-- 
2.34.1


