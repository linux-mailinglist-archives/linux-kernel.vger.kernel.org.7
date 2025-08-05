Return-Path: <linux-kernel+bounces-756726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBE1B1B85E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 18:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41D6C18A6EC2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 16:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6065296163;
	Tue,  5 Aug 2025 16:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5GsBm6f"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1DF2957CD;
	Tue,  5 Aug 2025 16:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754410866; cv=none; b=OeuXymbmheTdSpyqUS8FWMLhrIkeSqeVBqHZJhO9JXBReVfystHBVc+UPcjWMvcpE4ZYELVMIOIqkvyQwzFS8sZbhsONMa7Cm02LtPyXEO4KUDNXGyutEzcpGy13B+3pjVnBiVNP8SlGxORG5Z7ZBY81VKiWucNkx6I4Z88IsoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754410866; c=relaxed/simple;
	bh=sRiz1J40qM7F1f5zbR2yuHtbqdCjGQCfPAToa5nzbY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RrlqNgCKx3x3uO2ty46p1KAhmdZ8vt9PfthXEeYrdU8uK+CWTNcjxVWgPXylyLJTu9RnZaH4BIEw0rQdP6sr+YzmIZZCD6MD9c++5vvphPv30VfR2XfMTbCMqQEfuso7ut5DILGUjjQjZWdooPZd3QBUiPq/fiH7WJBVZKDfWDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5GsBm6f; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-71b4b36d0bdso45327517b3.1;
        Tue, 05 Aug 2025 09:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754410863; x=1755015663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BjNpkvSXW+v2m5Yu69UUOTo/LokqTIxoGaybS6E7Cys=;
        b=D5GsBm6f7ATK53xLGHBaYX9dK+sbEo35h0g2iHEW2jDJv7P3X3vVQZnqLio8Ez8OgJ
         pQfL2ohrH4qwJA0HDjz9JrZbV0EN0IllC8idWF7XsImudefbQZxJqDv0n87+w0H+xvN4
         MJVKq+x8C0Z9OnBgvY9rMoyC/Lb0FkTOwsVJyXjbHeTLpnZ9CCMwCAtvVGbTDJwxGsYk
         RxZtk7/ZRMz2A0tzTjE1fDEK5t5VxX/9D18uQxXGUARXQgK/8ehJNEAKC9f0zBgmpFUd
         KVPSTRLq7Vl4QPlcUx6gc7Kv8oMMpIQtQGZP4trvGMVeG24r1W0wCyvqWtsPGajiHJgj
         xtpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754410863; x=1755015663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BjNpkvSXW+v2m5Yu69UUOTo/LokqTIxoGaybS6E7Cys=;
        b=tv4rySS+sanxozxlQ1oJWPYV3cIbvn/b4BIAY1l/RsdLhO3ITrWi49pi1EsgD7k43h
         YnW+6VdyLwf95g+WV4uam5/q1GYKUQrQleruNT0bfZCgqP5ZWkjNCjeJcyYe32SwGrgw
         l1Rm3mYKE3bDnM8XqE81fXbArW9O+AdnosrZxG9IPxasCUedSOprhgIcSCG4v8Pxjqmy
         +4K5NUklYcXNnhHI6Dw+jlf/YYuUR7GBZqGDqaENFe5bOCzhp9StKRt0+ZznKwrIl8iA
         84ZG9HcjFqFVZeMDtKdqZ2QcO1C8glTuYGGLqkdUFR1WYyXZsFy+12t+BO9IL3LVZEbu
         EtTg==
X-Forwarded-Encrypted: i=1; AJvYcCU/Wrc40yrrPQIwuu0VuXBK5DAyCSLQBWV0YfWydWiVSZGY0E0oXqDnbmKFp2ATjNmpNiJB2iaVYeQ=@vger.kernel.org, AJvYcCVCuHWf4C5AK/3aBaJG2I5RXXPCyLRkduK2BEbNbceEK3o3F6ieZe+uZmgmsrPTUvI6Cd7eH/xUtVp6ZcTS@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9uoLR0apCzK+9RHHsX7hidBxYs+dh4tEFEG9xqhLG9Skwy163
	LpjZZnxuxeXV8J1Osq48lxC0evH2Iu8G3zE5dBNP1UX7HCkiOPUYitvc
X-Gm-Gg: ASbGncs0CZH0Nokqzi9LgyWE/bYJ80W9eQ10fk/25xvTUkvVr/8njAQOu/cR9M5+StK
	hVd5yubRJwbK+sqCml2RaUeR6AfI6NN95/g28Tq6gdfocAWRM+epO8lhHMaxTnd9YM7PNYOQeSz
	2pgf5VyxGQs7J8Z5PlUSGWtCOwjdzls+ylqzPSNZcL0HAuW+MoUQq56zcpoAFDWocd4gVPNzU1M
	HLVdV3lRe9lVDvGRft5oujezCUUp5TRL4Gbma/dyuiJVdqdbtArZbt0NJou566tNHqiLvTwfB5d
	k4kw7Ymifv+kQsrAUpCGkLIPnrA89CQc/BuTHupECiL7l49kYtYmvHLGydbKgmAw/1i8ZNkCCcK
	aOMNI57ohfRBHaGnHiPJfjjFngbtJMjYkWQt4J6uyndY=
X-Google-Smtp-Source: AGHT+IEQM0QlTGhxyMPibEvEMDpbAzpmE9uEnXqB1fB3pRbIadxeRKgx9pmHX+QFoHCpre2n2PEesg==
X-Received: by 2002:a05:690c:8694:10b0:71a:34c6:706 with SMTP id 00721157ae682-71b7ed8b056mr123189357b3.17.1754410863480;
        Tue, 05 Aug 2025 09:21:03 -0700 (PDT)
Received: from bijan-laptop.attlocal.net ([2600:1700:680e:c000:2c65:e45a:e7d5:5f0e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71b5a5cdfc5sm33098757b3.77.2025.08.05.09.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 09:21:02 -0700 (PDT)
From: Bijan Tabatabai <bijan311@gmail.com>
To: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: sj@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	corbet@lwn.net,
	Bijan Tabatabai <bijantabatab@micron.com>
Subject: [PATCH 4/5] Docs/ABI/damon: Document new DAMON commands
Date: Tue,  5 Aug 2025 11:20:21 -0500
Message-ID: <20250805162022.4920-5-bijan311@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250805162022.4920-1-bijan311@gmail.com>
References: <20250805162022.4920-1-bijan311@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bijan Tabatabai <bijantabatab@micron.com>

Document the new commit_schemes_dests and wait_for_schemes_apply DAMON
commands.

Signed-off-by: Bijan Tabatabai <bijantabatab@micron.com>
---
 .../ABI/testing/sysfs-kernel-mm-damon         | 21 +++++++++++--------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index e98974dfac7a..429947de9aba 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -27,16 +27,19 @@ Description:	Writing 'on' or 'off' to this file makes the kdamond starts or
 		makes the kdamond reads the user inputs in the sysfs files
 		except 'state' again.  Writing 'commit_schemes_quota_goals' to
 		this file makes the kdamond reads the quota goal files again.
-		Writing 'update_schemes_stats' to the file updates contents of
-		schemes stats files of the kdamond.  Writing
-		'update_schemes_tried_regions' to the file updates contents of
-		'tried_regions' directory of every scheme directory of this
-		kdamond.  Writing 'update_schemes_tried_bytes' to the file
-		updates only '.../tried_regions/total_bytes' files of this
-		kdamond.  Writing 'clear_schemes_tried_regions' to the file
-		removes contents of the 'tried_regions' directory.  Writing
+		Writing 'commit_schemes_dests' to this file makes the kdamond
+		read the dests files again. Writing 'update_schemes_stats' to
+		the file updates contents of schemes stats files of the
+		kdamond.  Writing 'update_schemes_tried_regions' to the file
+		updates contents of 'tried_regions' directory of every scheme
+		directory of this kdamond.  Writing 'update_schemes_tried_bytes'
+		to the file updates only '.../tried_regions/total_bytes' files
+		of this kdamond.  Writing 'clear_schemes_tried_regions' to the
+		file removes contents of the 'tried_regions' directory.  Writing
 		'update_schemes_effective_quotas' to the file updates
-		'.../quotas/effective_bytes' files of this kdamond.
+		'.../quotas/effective_bytes' files of this kdamond. Writing
+		'wait_for_schemes_apply' to the file does nothing but wait until
+		the next time every scheme is applied.
 
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/pid
 Date:		Mar 2022
-- 
2.43.5


