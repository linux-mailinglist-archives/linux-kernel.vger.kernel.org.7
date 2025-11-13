Return-Path: <linux-kernel+bounces-898540-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE818C55812
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 04:05:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C42D43B0691
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 03:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B64526E6FE;
	Thu, 13 Nov 2025 03:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REJHIpeQ"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD08267386
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 03:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763003107; cv=none; b=geU4xZd4DTOB7PeECLzm49ixzrchh0atcHSh85DRkDHqoOgWNwtQuEIU8zhuPS9x0OIX0mzP6tdRQxyAws4SooM8Jxm544fPOb5uJBbIjXz3tb/LbyPw+PUyhAYF0ZafW4mX8UqPuAcLShyvLTU1nj1BAd2FnUXTBenAjY52ffQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763003107; c=relaxed/simple;
	bh=O9zV8bAoUVd2ZzjVizrq0aVJWNKCtlsakqD1EEwfl7I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=r0V0Euhi00kxkjixNSxmUQuG7ftMpJJ/XLDTlMAALksVNfn802eTNsSNiJihpIH1FMtODkx4CvFzxYiCBsH9aUhhi/HmC/Ap08IUW3NhBvbXwtClUeOe5Z9CcGsx9/jRu0GhFwdwTdlKxydjPKYbovBSF6hWl1pnAW42XmM/G3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=REJHIpeQ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-297cf964774so464395ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Nov 2025 19:05:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763003105; x=1763607905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=79ZFMgyqh7NLEU0bjPwPQ0uTiSQzLvP0WrsYbbAHZdM=;
        b=REJHIpeQMqCyfBtuqBxxYToslfUaJjbaFtZz5LA1BkKaq31+IeB3Jvot6lc7oTh8dp
         N5v4UFmTRDFJx7ISkKvslA/ySRIhVewBJ8qPZk76bAgxgkQj5ATGEgEzwWVb3S3TWISb
         evA8YWqeqgy5RO+c8aw3FK8GLXvj/xcxXQtIqpiUgKY+C2ZYDVSh8sVWfFIjPLi9UYo2
         rAJKukHDY0JQVbtyBbmACUbHzS1KtmwLOQc6TZOEDZ77IOCUeQjSq0EVwKxXBmrRK5vJ
         Bk1xdp9iGrjBqvP0BG6iPTRAy2LeOO5NHyELTzxS3M4OAVBWlF+PoljBx+D6BjJENoPx
         +1iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763003105; x=1763607905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=79ZFMgyqh7NLEU0bjPwPQ0uTiSQzLvP0WrsYbbAHZdM=;
        b=FdqWV++RMRka3S1ocg0/2iqbKlIkw/tu6jRMShwsYU3eXAN2yk3kyknjiGmBeoC+4g
         9l+QCuHEATiGxxKFjJitbw71XWdMgIwzYxwKaNkyLf8hHze+WKUaA1N/VsMBQrQXlI36
         hViNQQrR/RRfJBRfFfLEcYp2jJeXjcDogzdcZ4jmSy8ZoGaHUnEtcq3GviPs1A4lLDQt
         tXTX9c1EPFIG7h82YCoglBMkJyNIDztPY9F5+mybAf2bg4u+x9TxeMSt+9j0ZZ0zOBwG
         0aC6eTNpNfywTZZOHbL8elNX2bJcWkWbYGXT3EZEfdaJbIo5TLA1aff2U4D+vg5qEuzO
         7DUw==
X-Forwarded-Encrypted: i=1; AJvYcCV44wkQNwXc79JxmIxQO6TFP9BCZhwWeIaYAf02qXBp0ePV7J4eJ4vwZoLKkF2jP/kkrwp+3+XyWjk8kwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnbskDCmg+S3AE6UsVSrpb1PMr+13C1RaFxQO/yCcqEE8KM4fi
	Zqps/MNheXTDu6mExwganTj1tiXgxBaTQ6LQT1x1cXQxmJlhRjdGxzxz
X-Gm-Gg: ASbGncs/iGZlAF/vnbXfzwuSCXsF5zW+LxBv9GdlH8mqJXY1Q33x193YyqNnYEzMpIR
	SqQfyWb+47nq5TapHcbH/l5PYSx71qTANp+AgpnNnXDneb9jS7riFLoojgOziqLzcuguqNnI9C5
	j5Y8rkQA5gtyJpA7UdnHtHMOquY3OHuxmdVsGubDiu55kJH7M6bTyi4fM+2v/kBm2lDXu2RKcSc
	96hu/PyXGV2x7PZf5XfK3+9/cDRaXaTyTSZk9hsHUIsmE+wCsB66a5M3Zxuisluor0S31O9W0Ve
	nGytU5WA9OGSOn6KadrGTUA4sMpPZUadbA8VWGFWHuZ4EpwiE73+AtXWSRh/TTewt+VqrM00Xum
	vA1aFJXj0r5AzDnzuHY5cJNbidCNMrG6iMU66cpROe2Uj1SVgvJ0bbweqxIzBJXVtGx4a6EJaGm
	A95ilAoqD6Zanwvq8GbWPIi37pf0lErc5hILi1T+HcZoQVjicNkLF6f4YeiyX6/g==
X-Google-Smtp-Source: AGHT+IEw90g2Hzt/8ufbJVQWlDjtChK6HX/U5OEBYjDIouhOWonfZhzrah1NQrxITRslczO8iIzXZQ==
X-Received: by 2002:a17:902:db04:b0:295:247c:fb7e with SMTP id d9443c01a7336-2984edfb282mr36630385ad.11.1763003105365;
        Wed, 12 Nov 2025 19:05:05 -0800 (PST)
Received: from poi.localdomain (KD118158218050.ppp-bb.dion.ne.jp. [118.158.218.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2346dasm6739945ad.7.2025.11.12.19.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 19:05:04 -0800 (PST)
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
Subject: [PATCH] ksmbd: vfs_cache: avoid integer overflow in inode_hash()
Date: Thu, 13 Nov 2025 12:04:53 +0900
Message-Id: <20251113030453.526393-1-pioooooooooip@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <2025111234-synthesis-wimp-7485@gregkh>
References: <2025111234-synthesis-wimp-7485@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

inode_hash() currently mixes a name-derived hash with the super_block
pointer using an unbounded multiplication:

    tmp = (hashval * (unsigned long)sb) ^
          (GOLDEN_RATIO_PRIME + hashval) / L1_CACHE_BYTES;

On 64-bit kernels this multiplication can overflow for many inputs.
With attacker-chosen filenames (authenticated client), overflowed
products collapse into a small set of buckets, saturating a few chains
and degrading lookups from O(1) to O(n). This produces second-scale
latency spikes and high CPU usage in ksmbd workers (algorithmic DoS).

Replace the pointer*hash multiply with hash_long() over a mixed value
(hashval ^ (unsigned long)sb) and keep the existing shift/mask. This
removes the overflow source and improves bucket distribution under
adversarial inputs without changing external behavior.

This is an algorithmic-complexity issue (CWE-190/CWE-407), not a
memory-safety bug.

Reported-by: Qianchang Zhao <pioooooooooip@gmail.com>
Reported-by: Zhitong Liu <liuzhitong1993@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Qianchang Zhao <pioooooooooip@gmail.com>
---
 fs/smb/server/vfs_cache.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/smb/server/vfs_cache.c b/fs/smb/server/vfs_cache.c
index dfed6fce8..ac18edf56 100644
--- a/fs/smb/server/vfs_cache.c
+++ b/fs/smb/server/vfs_cache.c
@@ -10,6 +10,7 @@
 #include <linux/vmalloc.h>
 #include <linux/kthread.h>
 #include <linux/freezer.h>
+#include <linux/hash.h>
 
 #include "glob.h"
 #include "vfs_cache.h"
@@ -65,12 +66,8 @@ static void fd_limit_close(void)
 
 static unsigned long inode_hash(struct super_block *sb, unsigned long hashval)
 {
-	unsigned long tmp;
-
-	tmp = (hashval * (unsigned long)sb) ^ (GOLDEN_RATIO_PRIME + hashval) /
-		L1_CACHE_BYTES;
-	tmp = tmp ^ ((tmp ^ GOLDEN_RATIO_PRIME) >> inode_hash_shift);
-	return tmp & inode_hash_mask;
+	return hash_long(hashval ^ (unsigned long)sb, inode_hash_shift) &
+		inode_hash_mask;
 }
 
 static struct ksmbd_inode *__ksmbd_inode_lookup(struct dentry *de)
-- 
2.34.1


