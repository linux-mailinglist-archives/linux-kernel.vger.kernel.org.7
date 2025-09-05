Return-Path: <linux-kernel+bounces-802580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1637AB45422
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 12:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D28B21BC6C72
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFFA2C08A8;
	Fri,  5 Sep 2025 10:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aisle.com header.i=@aisle.com header.b="ialhU408"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEF229CB56
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 10:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757067051; cv=none; b=HdVSf/7rQwMk4vKHVUTmEKWRgyLkSErQkgr9d2JLJZnqq9IcDV2+yYEqsT9m2VjxCicFG7epPV/trWWkx6MLZDHB7DgXzTIdG7WcyILJ3dr86bXu/LX2pR2juuUIV6QLjuQVNNwJjPubVB2T51aDZQjUcUYeG7Tz/VwWftfTNrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757067051; c=relaxed/simple;
	bh=jkTCp3P+yr42VXTfabfgzJWvbpYCF5TmBIOuVAlfHhA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VAYV110eWHeOB6iLSbvxpzUWP1u+vH+pNoiXO+Ejq8/o8YQDzfuorW/9sy9dmNqYObMbmeKfua9wftb2Lx7nTSqEv7nB/rJwUJFUyuHBbaEWfF50hNoQRIIBmft93vc4Ps7pm5MN5drs+nD4MX5EjZWnGIOS8sIPa0N75R5UPuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisle.com; spf=pass smtp.mailfrom=aisle.com; dkim=pass (2048-bit key) header.d=aisle.com header.i=@aisle.com header.b=ialhU408; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aisle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aisle.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-61d3d622a2bso4011619a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 03:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aisle.com; s=google; t=1757067048; x=1757671848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DAnIhBQbDm9gjZjqjenS6A8LuOGC08UU7yZ4phQFyfQ=;
        b=ialhU408DIw5ysdBqvErPllGXmUWgKO4N0yr0ZJQ3z+x+aLM/XM6TUKJNjRFwU5QpN
         HUIAzkBZZb8VR1zvSAIWElqEHNsAOgpB8AJ/52FcyC9Bgtv1QRMd4yTqXYUi+bJ60TlV
         zldC02jrWSFqPGObqAx/Vwx3BZAHMqzi+qLVOTRJEVpuVifhWFWNYv85DdNZSRBvqyc2
         rUrTWqZm9DkZVXtftmQB6NuziCArBVH+agbn36y8+ypvvykXiDqV69mgyJxSjnwAbGQF
         GBA/mlV6ltJroVaZH+8dxZ2opQYZaZwFnAbf7laNzp3k5WNtz0Ive54pIGk5+CgE+8R0
         ZcOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757067048; x=1757671848;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DAnIhBQbDm9gjZjqjenS6A8LuOGC08UU7yZ4phQFyfQ=;
        b=RkeGqER5Bd5gMWqkK7+0pYKkhXCQLU1V7VbEnGQBgdhLvFaI0l3Ndk9JxKlR+ksCSi
         wp1ZvN2NpTNL1Nd1T8CIsKsC1i80gQOD7cWBp8S//DS5Iag2zTOjBNhRvxWJM4IsKvQ0
         6aQhuMEe19yhEVR5VXBr/4CVN1gKNipO3lLXlul6R1EKh2xoXN+IWO5P75Mv3jo/UkQO
         2KhDWaub6gYle+T4XG2bBjlvZwpQJXYcIiZd9m3TxcrtZ8r/dmWN5xHUEUmQYRlTGu30
         Xl7GX1GyEf8sdpJH9JSrwH3bfZr6bGDNmljd5b92+g0h5IBSA1mAb8TQbT+9LAwY9xF3
         tiqA==
X-Forwarded-Encrypted: i=1; AJvYcCXSrnTAepaPcvMZwZmLcOIIpz5/lQhV+SKCtRmuyz1/W+wu9o8ECWLa2SFoKMnGnl7KpMwo2TkNM68meWY=@vger.kernel.org
X-Gm-Message-State: AOJu0YznUtW1ivpwZaBqhxTI3JR+aCh9Y/ymvkZkN3SeKgez+WQOe9u3
	kijKN9M8fjdu2h23qIiyKkiJZjwYtARYU3j6KIZKq3wopS3/K7i07To0cI8423yhLWagbTXcyzj
	VLMkn0MlHN6D3
X-Gm-Gg: ASbGncucpCxX9yEHghxZmDFL/C6hRa5aRaEY/mJrMPaPdpF+JMLSHJzzHUELvL+bglA
	BDKTyngRDo9xp835KXvjUtXhL+bsQARa+N+kuHntbAtHwBprzwwnOgOlM4VfjQlBy3L2EMNU0wZ
	IFHwwc8PlH8fyvOeJptDd/hf5jYxMYPamDYoEiEUIiDcm+Xax0rVfryan0wmAzy72d27TLilZxD
	Yj84Mq5QJpZAeFdpUDCjdCeXdp02/oA23GVpkTnWdUh/1nPLTe3Z1WECfPoVdkOCgkuq4sIsIcl
	Eoy5h3fpFz2sDqlbr1I4HHpqpwUay+2GCisajDhxVTI7moCSvYzDs5LaN/GE9/5NHTGmPaDFF/D
	56lT8XVTGHyc/PZAh6Jz1ihNUaC0wnTtWl4vdWWGq2bq5jA4AJo9UF5nSWA==
X-Google-Smtp-Source: AGHT+IGp1pr9JZHYShV64sfeXi9j9BsKxp4VYxKhIH6aW6aeCKq4sV+NmvY4luz6jw3F75rB7Ogdww==
X-Received: by 2002:a17:906:e57:b0:aff:1586:14c2 with SMTP id a640c23a62f3a-b0493086abbmr283824166b.4.1757067048302;
        Fri, 05 Sep 2025 03:10:48 -0700 (PDT)
Received: from localhost ([149.102.246.23])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b02152cc1b8sm1530574566b.36.2025.09.05.03.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 03:10:48 -0700 (PDT)
From: Stanislav Fort <stanislav.fort@aisle.com>
X-Google-Original-From: Stanislav Fort <disclosure@aisle.com>
To: sj@kernel.org,
	damon@lists.linux.dev
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Stanislav Fort <disclosure@aisle.com>
Subject: [PATCH v2] mm/damon/sysfs: fix use-after-free in state_show()
Date: Fri,  5 Sep 2025 13:10:46 +0300
Message-Id: <20250905101046.2288-1-disclosure@aisle.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

state_show() reads kdamond->damon_ctx without holding damon_sysfs_lock.
This allows a use-after-free race:

CPU 0                         CPU 1
-----                         -----
state_show()                  damon_sysfs_turn_damon_on()
ctx = kdamond->damon_ctx;     mutex_lock(&damon_sysfs_lock);
                              damon_destroy_ctx(kdamond->damon_ctx);
                              kdamond->damon_ctx = NULL;
                              mutex_unlock(&damon_sysfs_lock);
damon_is_running(ctx);        /* ctx is freed */
mutex_lock(&ctx->kdamond_lock); /* UAF */

(The race can also occur with damon_sysfs_kdamonds_rm_dirs() and
damon_sysfs_kdamond_release(), which free or replace the context under
damon_sysfs_lock.)

Fix by taking damon_sysfs_lock before dereferencing the context,
mirroring the locking used in pid_show().

The bug has existed since state_show() first accessed kdamond->damon_ctx.

Fixes: a61ea561c871 ("mm/damon/sysfs: link DAMON for virtual address spaces monitoring")
Reported-by: Stanislav Fort <disclosure@aisle.com>
Closes: N/A # non-publicly reported
Signed-off-by: Stanislav Fort <disclosure@aisle.com>
---
 mm/damon/sysfs.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 6d2b0dab50cb..7b9254cadd5f 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1260,14 +1260,18 @@ static ssize_t state_show(struct kobject *kobj, struct kobj_attribute *attr,
 {
 	struct damon_sysfs_kdamond *kdamond = container_of(kobj,
 			struct damon_sysfs_kdamond, kobj);
-	struct damon_ctx *ctx = kdamond->damon_ctx;
-	bool running;
+	struct damon_ctx *ctx;
+	bool running = false;
 
-	if (!ctx)
-		running = false;
-	else
+	if (!mutex_trylock(&damon_sysfs_lock))
+		return -EBUSY;
+
+	ctx = kdamond->damon_ctx;
+	if (ctx)
 		running = damon_is_running(ctx);
 
+	mutex_unlock(&damon_sysfs_lock);
+
 	return sysfs_emit(buf, "%s\n", running ?
 			damon_sysfs_cmd_strs[DAMON_SYSFS_CMD_ON] :
 			damon_sysfs_cmd_strs[DAMON_SYSFS_CMD_OFF]);
-- 
2.39.3 (Apple Git-146)


