Return-Path: <linux-kernel+bounces-743812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C37B1038D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90CB81C2573F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 08:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E55227584E;
	Thu, 24 Jul 2025 08:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b="OnBmYrt9"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 841AF274B59
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 08:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753345818; cv=none; b=fS4uVPOy3ZthZ4SiZVRQiHKk2dx9FrM+JhJs8Dksf0Z8Plui+IDUdQkd9opgxJIa/H94yqR6khDuPOiqZECBWDMYyxdbhg5qNCWQBdYWbQFPcnZyWSm5hCqAFJjvdkHPw/K8H5nGNSjwA4Sv1d0pdb/1ZeFt2xC//MmMvYRABk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753345818; c=relaxed/simple;
	bh=jqF7mCGV2czF+BaeGDlzl91lppM9KaeWobxCcAu4HUA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iXUBRDmMSeNevoySgjdLtK21LccyoJRSxKQ2pF+OnpLCZwQnhRhNL9upFWXkkWZ0HO+6khT36hcyWdZJsXF7Gb54uwthT9imc2DE8g6NJ+OSvzrRFQ3ScOBHMmVzlhb9xpTUGDqCV+9oq+xt3Omd4qeuwBPb5wmLKpWgAJtWY04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com; spf=pass smtp.mailfrom=shopee.com; dkim=pass (2048-bit key) header.d=shopee.com header.i=@shopee.com header.b=OnBmYrt9; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=shopee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shopee.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2363616a1a6so5434375ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 01:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1753345817; x=1753950617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=47jmZPI3/V8O8CJJRttybJ/xuaRQjlAB+Z8KeKvbumI=;
        b=OnBmYrt9lRAVcL/3Ck5+wl5uAYjp3O8NR3hnHCArtm/i8qnutJqmFDwoeVH9LBEn1C
         tAZueb71PBMY8XWFMILyeb5F0x8hFEvMVc3Z17sfoah5r4arBtOo7LO3f3EFnjcnnbh/
         WvC00egJ7WFd9vs/NYb5ppG6nT2YeFdneGGuScHFhFZbjNm/qg170+UsyFPxaYTNZjDu
         dqrl0o87Po+8y/DugKEFwenjM8clMn/OPwbvwNASx3l4DyJv6RHlgjyYseLOVTmze4h8
         T87b1xa+G4zsuf4U8y5UmRHTCEEAGvWPXdu0CRTd3Cet+Kba9wkv7Zyjl7uEjv4JEO10
         RLZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753345817; x=1753950617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=47jmZPI3/V8O8CJJRttybJ/xuaRQjlAB+Z8KeKvbumI=;
        b=EsbJnZ5clS5521GL6ZP5qTsglIWu3SgEVy4ftpdDzTiWB2xps2XupPWEmzi0sIqeps
         AtjA/hfCNQGZ6Sr3pMm324X+8ifi86csrrm7vLLRYoA5iFrr7nZcY1cXMbQdnr3vlS8k
         qzSwjuSWV7Of57bk8eDBYKEIlClH6fElvSLp2UOiDaEvDPgRyo0ZKgGdMHjjNjQi7uOu
         XN2JvOMPwGCXpwPJ68lpMMyEvldMMY5DiAbELvrGwIM/sY2nbj26qLB6DT7zVVSbOKxc
         wQ2svipzYqnl32ov7Vjl5XP9Be2NtldC6S3KtDMThXkx1RR4qQRHoz11cdI9tg3h4iUn
         9SHA==
X-Forwarded-Encrypted: i=1; AJvYcCWA9BST/NJRVlQ6U+SgKKxuqsNxRguqgiBQOk6mpML+LJ4q2iziGYUwItANSTh5+VeUyvExXuyzym1294U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRalOK0+SCHmlSGhqTx/Amyh2tw2wau/aYFSgPK7OVoZuYd+8g
	GBRNv1svsJFp3eaGttmy4EIigqgTlA8PH15VIrc+nMVjVSH8OSTI6FsaAMAIF/KW8nY=
X-Gm-Gg: ASbGnctlWtL/CVUxiFsbP9efizrlIZrhAXLOPj8dvJYpvzfPlWuFuRIM7oSE/nQVfZj
	EuL9wU+es6j43LLLEdGLLrZAVYRLz9xLV3GTn6Jxf53j531IMcMUzZ1Xrk74e1kFd7s0PghysTW
	8MkqHdSsVsYw1gN5egjJNtRc1OBUZYaoV+zYtUEU+BXN5YX5eHLB2kDUzyVSa5AO5uGttuTUvzE
	Dq06EGi8Nh2iRq/RUjwoYFRyt/6SMRtghOzxUJzQrjVR0CrLqGzgz0K7zKW5Cu+9aNmEj4Ucg9r
	xyl5/2ZyxssPtalo2FYFbFCQ1HmyG3fS86m/yngqQLFlx7IKCnjXEk+f9LDepkWPhL3eHVb7P1r
	3z1UJxd4=
X-Google-Smtp-Source: AGHT+IHtywVt/v6ABhIAsOPJj1ZdyBALtRbXuQPSUy7BpFp0bvl4EoD/Ksf9GHu1qJpVP+Ax91cj0Q==
X-Received: by 2002:a17:903:1b28:b0:235:f70:fd37 with SMTP id d9443c01a7336-23f9814b043mr85462555ad.19.1753345816938;
        Thu, 24 Jul 2025 01:30:16 -0700 (PDT)
Received: from localhost.localdomain ([143.92.64.18])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa490683fsm10037115ad.195.2025.07.24.01.30.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 01:30:15 -0700 (PDT)
From: Tang Yizhou <yizhou.tang@shopee.com>
X-Google-Original-From: Tang Yizhou
To: axboe@kernel.dk,
	hch@lst.de,
	jack@suse.cz
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tangyeechou@gmail.com,
	Tang Yizhou <yizhou.tang@shopee.com>
Subject: [PATCH 3/3] blk-wbt: doc: Update the doc of the wbt_lat_usec interface
Date: Thu, 24 Jul 2025 16:30:01 +0800
Message-Id: <20250724083001.362882-4-yizhou.tang@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250724083001.362882-1-yizhou.tang@shopee.com>
References: <20250724083001.362882-1-yizhou.tang@shopee.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tang Yizhou <yizhou.tang@shopee.com>

The symbol wb_window_usec cannot be found. Update the doc to reflect the
latest implementation, in other words, the cur_win_nsec member of struct
rq_wb.

Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
---
 Documentation/ABI/stable/sysfs-block | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-block b/Documentation/ABI/stable/sysfs-block
index 4ba771b56b3b..7bb4dce73eca 100644
--- a/Documentation/ABI/stable/sysfs-block
+++ b/Documentation/ABI/stable/sysfs-block
@@ -731,11 +731,11 @@ Contact:	linux-block@vger.kernel.org
 Description:
 		[RW] If the device is registered for writeback throttling, then
 		this file shows the target minimum read latency. If this latency
-		is exceeded in a given window of time (see wb_window_usec), then
-		the writeback throttling will start scaling back writes. Writing
-		a value of '0' to this file disables the feature. Writing a
-		value of '-1' to this file resets the value to the default
-		setting.
+		is exceeded in a given window of time (see the cur_win_nsec
+		member of struct rq_wb), then the writeback throttling will
+		start scaling back writes. Writing a value of '0' to this file
+		disables the feature. Writing a value of '-1' to this file
+		resets the value to the default setting.
 
 
 What:		/sys/block/<disk>/queue/write_cache
-- 
2.25.1


