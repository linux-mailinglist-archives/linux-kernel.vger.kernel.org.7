Return-Path: <linux-kernel+bounces-789832-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD03B39B4C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 13:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EB041C27041
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 11:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA84E30DED1;
	Thu, 28 Aug 2025 11:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="UzYBM3Yp"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F1B619ADBA
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 11:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756379767; cv=none; b=Xt2E2FZScAuREH/owXZN3OzCiSA31Lfz8Pnq43YmuQzXQGA923XUB8sLTJNYJGyJ7zvNx7IBqUxqBN/xuGWX9/UDcX25J5PmByaqsTn4HFZT2zfyOH8UmvJGGFg51TFstInj4jPt7BA11FOdzq40ZHGxVR124a8v9HBVcI79LXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756379767; c=relaxed/simple;
	bh=x2CwY0f27ONX+8fmDC68h7bPHgxl9g7WINlENPZM7FQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rw/5T44PTMNMz80k1UXpHK888NrweqErup4VfeICWXPh0RnjGMT5k+/mIUpUcRpLvBC5MVsEItUKC1c+zHOa6Ly8Lw3RHNE55a+bvPIEN0KIgrvperrY6m566+avyV1z35GQEsfMpkiY8mZZAPpsClan0s1lqaH6HXRvB0uorFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=UzYBM3Yp; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45b55ed86b9so4209485e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 04:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1756379763; x=1756984563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/QHBOrXAja8iWLDpJiD9eodym9F/g93zNuwCDVC3UT0=;
        b=UzYBM3YpxrIrUDUDvNEAWw2vlcnHMx9856CwgCzIbpqufWz5OIC7H3YnE9AEr+5ViS
         CX0GWtKb0n7Rke7qJPva1KgsXh7vscFoPb9p955qR5TqOlqnGH99lfR9htG0G+yoZfVP
         wWaXDhQCVi+E/lshbryHpuCGuFUB6qUIu23Xi7K4Up92Tws8mHzDJm4Wip5NA0axCmt7
         WcTcEbMjBpxuJBxhdaXo6XEUx67BWrIP3HYEs6FjNoO62dUJuncyzJLJbYhLvVOFVMaS
         YFdGN6iYOJ9culihj1bkvcuzxY1IDmnAYuAdwrMhrTxIkUBtUgYREytBFt8MQO6UhAUq
         gj3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756379763; x=1756984563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/QHBOrXAja8iWLDpJiD9eodym9F/g93zNuwCDVC3UT0=;
        b=XdOSdlIZaEsPPrhgDIP1B+P359NE56rFwqwmf4OAu+ZBiHuNqXrufAmWLcDlPW1+lW
         3OtaYpJBh1qKq4ErfkyX0QISrryA9UJul7I2t8k9je0jCAPmzVKxn4SuXXDAW2WVan8n
         Exr7UCaufoZO4FFH+4f0Y1uroyrFKyIKsBITQfIxu/fBmk6bBTqJgetxp/5zqHH+QLEW
         qq4LU+MZD2LC3DovTvRCVHxs9mx7KJHrfHIbvQQT1yUczkwolm6hhEGCqkIgt6WGnf7J
         ymMvKKIQBaN5plE/Vd0Q961qODpmHBAqKR009Gn6e8itmviC+/KdSIXPPFV2qeRInYAc
         a/7A==
X-Forwarded-Encrypted: i=1; AJvYcCW2B+kw6wpLIrP8kkHTXxBkQwwoIuurfD2fh8d1gTeeMR0RmJkGuKAYko7ErnGXf3sGKRAtUgeGDolb7Bo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye+D8PuGFcHggSQ9Crl2kbLKnBO5HNEX6NYRmpj4uA5XyuhOMq
	UKCxismRdhPxuBEYFNI0GF64JhR33rQika4HFvLhpvzAFXx4z01YFCGYLj+enRhCKt4=
X-Gm-Gg: ASbGncvTQMLeSf2pdh8tUIwYyt12FpdVt8YDrbiPr62o7ttABrKxZweEneMuZ4Bi3yt
	EKF7p8DKFXUuhGr74ONvW/hYIuepxSULArd97OLCGphV32x7b29e1boxC22HwJbFqHJqTwON3d1
	JVa/my1gcfBvJhZHBAdoBhKdKMx1brJJz+b9W53GiNU8kM2zyNYAaYpPW3a2A4+4rgjy2BrzOc7
	+eHs8q0WEw+za6KCq1rS2Wz2WUQxOcWBHyIPyC+9LVIrU6ThnInT0KitY4yEbYk5KIBOU5eDGcb
	lRbZ1oF7cDEePc8W6ECOes5lBL1/RJMZo4Du+Hhfc78QzCXv2Doz+tl0MZ6PC16npHNe0CFxRFp
	GE84MxPh3vM9lVSsaPo4ksIWotEqD7O6GSiMueC8eWxAtA4P0ud7SRyU6ByDCs/e12VrToqDQYB
	wU1dJYECLha95mk/IEgfC6VC6uyNQczwJ+
X-Google-Smtp-Source: AGHT+IErHCmWbg2YMUeSrTBCHGmKcPBhN8tMdoOfMQOVPGyHr5ox98O0LhP5cUl5kKNQOFlN8MsLNw==
X-Received: by 2002:a05:600c:35c9:b0:458:b7d1:99f9 with SMTP id 5b1f17b1804b1-45b517a0655mr207154405e9.11.1756379762476;
        Thu, 28 Aug 2025 04:16:02 -0700 (PDT)
Received: from raven.intern.cm-ag (p200300dc6f1d0f00023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f1d:f00:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f306c93sm69608945e9.14.2025.08.28.04.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 04:16:01 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: Slava.Dubeyko@ibm.com,
	xiubli@redhat.com,
	idryomov@gmail.com,
	amarkuze@redhat.com,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	brauner@kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>,
	stable@vger.kernel.org
Subject: [PATCH] fs/ceph/addr: fix crash after fscrypt_encrypt_pagecache_blocks() error
Date: Thu, 28 Aug 2025 13:15:52 +0200
Message-ID: <20250828111552.686973-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function move_dirty_folio_in_page_array() was created by commit
ce80b76dd327 ("ceph: introduce ceph_process_folio_batch() method") by
moving code from ceph_writepages_start() to this function.

This new function is supposed to return an error code which is checked
by the caller (now ceph_process_folio_batch()), and on error, the
caller invokes redirty_page_for_writepage() and then breaks from the
loop.

However, the refactoring commit has gone wrong, and it by accident, it
always returns 0 (= success) because it first NULLs the pointer and
then returns PTR_ERR(NULL) which is always 0.  This means errors are
silently ignored, leaving NULL entries in the page array, which may
later crash the kernel.

The simple solution is to call PTR_ERR() before clearing the pointer.

Fixes: ce80b76dd327 ("ceph: introduce ceph_process_folio_batch() method")
Link: https://lore.kernel.org/ceph-devel/aK4v548CId5GIKG1@swift.blarg.de/
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ceph/addr.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 8b202d789e93..e3e0d477f3f7 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1264,7 +1264,9 @@ static inline int move_dirty_folio_in_page_array(struct address_space *mapping,
 								0,
 								gfp_flags);
 		if (IS_ERR(pages[index])) {
-			if (PTR_ERR(pages[index]) == -EINVAL) {
+			int err = PTR_ERR(pages[index]);
+
+			if (err == -EINVAL) {
 				pr_err_client(cl, "inode->i_blkbits=%hhu\n",
 						inode->i_blkbits);
 			}
@@ -1273,7 +1275,7 @@ static inline int move_dirty_folio_in_page_array(struct address_space *mapping,
 			BUG_ON(ceph_wbc->locked_pages == 0);
 
 			pages[index] = NULL;
-			return PTR_ERR(pages[index]);
+			return err;
 		}
 	} else {
 		pages[index] = &folio->page;
-- 
2.47.2


