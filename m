Return-Path: <linux-kernel+bounces-801428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEF7B444E3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 19:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DBC4A41B80
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 17:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4742232144D;
	Thu,  4 Sep 2025 17:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisle.com header.i=@aisle.com header.b="iXhx1Rkl"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44B731DD9A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 17:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757008554; cv=none; b=rUty/gPpj8e2nNOtzr8WajvGs/EmIiVagmsosadJ73wIR/LRpHJJ6DRPnzGXc1O7gh726WM9xsXNYbIx3DBRt/VKKYUmK4kfhPavBhBBqPIBBUDYfQsL8okq+MJp3E9/Tfnv312uEFNe7JcJvqH0pjsOrUoO+zP5JSj+0ywWmUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757008554; c=relaxed/simple;
	bh=mW2jw4Gqq8kIhfnnpqfGdlZeipHpcksc78sKRIZawQk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BxMmWlU8d6dcyTxNok4GuFKbtocp7+jXA+wvRIu8/Io6c/A3qt/ugiAqz8bMFO22UM9FBOIYEwJpRhJBDodb4m+DF2GiMduA8+UmQEpeEbkJGLlGQsoyOf1bupD+RJgCGFFNETr2RiHwZ1FX4DsvFMJ4jJm54N2fydK/njQDvTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisle.com; spf=pass smtp.mailfrom=aisle.com; dkim=pass (2048-bit key) header.d=aisle.com header.i=@aisle.com header.b=iXhx1Rkl; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aisle.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b02c719a117so246246166b.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 10:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aisle.com; s=google; t=1757008551; x=1757613351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zMtbznq3tl66msCReaOp/sA5Z6pLqOTnltPjz7M8pLk=;
        b=iXhx1RklD4sOfSnUQushvij+utyZZICkNDWzwvmiHXWOhjwIJ7fv+Rq/L+1UtgrJfL
         B56JoxB67+mi0MvTYXaHKiJOdc9bSEAL/GuMzmpFTmWmijHtiZ1xafkcQBMQgKjS66Ei
         c9k119OLSD2P463f+MAP3Tff0bL47FQ0FMwPHSraSRAWRWHD7UxULEZfh+agi4Qva1VS
         XFI2a4jyfpuCNKmnJaFGK6nKJyC18iaKrN3p/cb3ZdKl2zyD385viuBSOhjzj58TWnov
         0EH+Q6WbghCA0WvhhbnFjz1UCpXaUCbJWfXwoTnbg4a6Z474NRKU9neFUDe0OBFmYl3E
         W7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757008551; x=1757613351;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zMtbznq3tl66msCReaOp/sA5Z6pLqOTnltPjz7M8pLk=;
        b=DB8GBR7HNz/OC8QuVCdXW/U/jdSu4qJ5CIK23lwUWviCUjEf8Nz++UHg0xW8MCJa6k
         OayBVn6y5a/M0ZfPL97It99kQ6h5LF61h8LDHCU99FY9eRaJxSpE2qtroAhYErijd+C8
         pkIZkgrBPqx0KMG4RBZQ492hPbCIMDxUWt5sCWXtEW1ZigeMzuyR7VqeBhpOBJL4zyVn
         dklCN3SgjLHDqFhZ2ugO9c0I7o6Jyfj0FPHSJujPpnZH0iiNdOZoKh0qSwgwAIDpJjTk
         JmcSGbMMuylFmDOwola7ibUh23ctSVm/nI3dY8A6Wz7tpmcaJ6+lewKUeGZ/17LQd8Nd
         QfYg==
X-Forwarded-Encrypted: i=1; AJvYcCVwlFkd0IGV7W4jcntCLPgIwgGsQRjrpHUrT+F0un1Kh/xZjOlv+z2P5KTQkmrkTMU1PU1ygglGvxFfI6w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqs1wxV4YFysDfv33PK0mcFhZAJNz8hXGNESKZ+mf4RiCKfbzJ
	YTg8OX97a6wHG8on1DLghIMwBKhk9nBcBzs+cJiMZp21DzgTXc90+gzIMmLWhDogQXE=
X-Gm-Gg: ASbGncvUzMuV859k5naOqiPJfZA0Ae+UF1e20uGBzxYe0geJW1WG0M7U4z0g77nnsTg
	/172SvBGfpBrMfqXxEm4fBwsJDgAUqmaEg7DL2SYwVZrxrl8DPKYLfj0Q6Idge4Bh+kmXhGVdkY
	RMhSEr64VXOboImgR1/YA+R8Lx2wkQb33GMUyXxfdj1heUp/0rB5VyXIF01TQEK1e45uCt15nfy
	9QjFvH6Kx3CGwp0VSdIpekYQ1qDhl+q0YYZEAsA8EglKGtkzxRxxPneSlIhph5ZSOrKMzkqXuk3
	3xp9cqU6iJicmHh1MjEoTeMGBCsiRiE7NLrZy0WhdBrc5fB/VR5fZej+9sNufUyW5Su0JByJO9y
	EW6TGM489Wg7mjbYqPiWHqWUhk0o85CWpIj2FxC1DhqDYw4+t7idxKiGoaA==
X-Google-Smtp-Source: AGHT+IHHwye8S38M+daTlQY3u4C4GqM9qagbcu55Qj4nHECI21MQC05GMM41j4Ip7X73DFZQRvUF2A==
X-Received: by 2002:a17:906:d54a:b0:b04:2049:4c5 with SMTP id a640c23a62f3a-b0420490836mr1656559866b.6.1757008551138;
        Thu, 04 Sep 2025 10:55:51 -0700 (PDT)
Received: from localhost ([149.102.246.23])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b043d6c2f6asm883392266b.62.2025.09.04.10.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 10:55:50 -0700 (PDT)
From: Stanislav Fort <stanislav.fort@aisle.com>
X-Google-Original-From: Stanislav Fort <disclosure@aisle.com>
To: SeongJae Park <sj@kernel.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Stanislav Fort <disclosure@aisle.com>
Subject: [PATCH] mm/damon/sysfs: fix use-after-free in state_show()
Date: Thu,  4 Sep 2025 20:55:49 +0300
Message-Id: <20250904175549.88928-1-disclosure@aisle.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

state_show() currently reads kdamond->damon_ctx without holding
damon_sysfs_lock. This creates a use-after-free race condition:

CPU 0                           CPU 1
-----                           -----
state_show()                    damon_sysfs_turn_damon_on()
  ctx = kdamond->damon_ctx;
                                mutex_lock(&damon_sysfs_lock);
                                damon_destroy_ctx(kdamond->damon_ctx);
                                kdamond->damon_ctx = NULL;
                                mutex_unlock(&damon_sysfs_lock);
  damon_is_running(ctx);        /* ctx is freed */
    mutex_lock(&ctx->kdamond_lock);  /* UAF */

The race can occur with other functions that free or replace the context
while holding damon_sysfs_lock, such as damon_sysfs_kdamonds_rm_dirs()
and damon_sysfs_kdamond_release().

Fix this by acquiring damon_sysfs_lock before accessing the context,
mirroring the locking pattern used in pid_show().

This vulnerability was present when state_show() was first introduced to
access kdamond->damon_ctx.

Fixes: a61ea561c871 ("mm/damon/sysfs: link DAMON for virtual address spaces monitoring")
Reported-by: Stanislav Fort <disclosure@aisle.com>
Signed-off-by: Stanislav Fort <disclosure@aisle.com>
---
 mm/damon/sysfs.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 1234567..abcdef0 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1258,17 +1258,24 @@ static ssize_t state_show(struct kobject *kobj, struct kobj_attribute *attr,
 		char *buf)
 {
 	struct damon_sysfs_kdamond *kdamond = container_of(kobj,
 			struct damon_sysfs_kdamond, kobj);
-	struct damon_ctx *ctx = kdamond->damon_ctx;
-	bool running;
+	struct damon_ctx *ctx;
+	bool running = false;
+
+	if (!mutex_trylock(&damon_sysfs_lock))
+		return -EBUSY;
+
+	ctx = kdamond->damon_ctx;
+	if (ctx)
+		running = damon_is_running(ctx);
 
-	if (!ctx)
-		running = false;
-	else
-		running = damon_is_running(ctx);
+	mutex_unlock(&damon_sysfs_lock);
 
 	return sysfs_emit(buf, "%s\n", running ?
 			damon_sysfs_cmd_strs[DAMON_SYSFS_CMD_ON] :
 			damon_sysfs_cmd_strs[DAMON_SYSFS_CMD_OFF]);
 }
 
 static int damon_sysfs_set_attrs(struct damon_ctx *ctx,
-- 
2.34.1

