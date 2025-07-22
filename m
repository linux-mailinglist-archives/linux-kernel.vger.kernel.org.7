Return-Path: <linux-kernel+bounces-741396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89721B0E396
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 20:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53ACD1C21383
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 18:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D778D2820B9;
	Tue, 22 Jul 2025 18:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IwgsSgkl"
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8DC23B60F
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 18:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753209552; cv=none; b=HMj3BIMGfxwtNKTOzQ7LLu54b1Y5v6moi87841MspUucl2seIqL/wcOpKB44o45CRSsLbyIlEfpOVXFL8HReHrtNmRszwcHDeWu+dUPEiBuZz6eKFXIHeF2qUGacql365QJDf5scHhA7Yg+EMTIPiKfS1IcT+y92gW5dQPcAqCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753209552; c=relaxed/simple;
	bh=vyfqUxLMwZ1GxMNyoJ7DUhaQTFyRoZUZaVogpeYGc9o=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PKkkRzDHwl9C95WggtOxCA6RBb8x0UoTgz/F0udF5Rj7ZhpdcIPgJ3COqBdNrcxfHMYTkKsYP7x10YqpCytts8mSHnTM4coXWRKA+OntTj7XNsI9Omd/FXJDIrjwPA+Ufu8E8XtY9kRPKXcaJq/7Z8mx07oCmQ1OTOx61/DbGxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IwgsSgkl; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-612e67cee87so3184667a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 11:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753209548; x=1753814348; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8JcyrT1yxlGaoNHF9VUuNd45CIqGbNSpnox4Y+ol6RE=;
        b=IwgsSgklh98NI429NOssBWVyCPCFbUzr3239OAkcWgKBVujbKbC9Im2Ut90C8p+1zO
         KUj3iZxaUlokGXj9PWrpSb7EVSGkOrwT6LxPd+8qb3fC5ySpLQ33fQno3mP5lnu09Y4w
         eS1fpBL4zoEXEH+6fGrr0ECQH7WE4YUST1JwvtSMz4xOwOBzMMgtd9hoH8RwwdrVsxgq
         agvEQKO/Y+CSO6DWFzHt3+N6wazB6KUcmJyffv39CTvxiT9QilrLO+uH95lMLQ0cx5Cb
         xlNLwOLLknuCuwS5HB1/ihwgXQ725tuLRcOFwJzaKTir2w372r1jZDeR1gP16hsYU05O
         j2AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753209548; x=1753814348;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8JcyrT1yxlGaoNHF9VUuNd45CIqGbNSpnox4Y+ol6RE=;
        b=XInrMgKTtXKTUMm7RQZXfZ6rNHBHuLe95G6CCpI47uJ9iZzFSJK8l5Nksf6/fsy8JN
         GWeS7VzdEsSsjkVRIHpS5cByPBh2KPDwZB3shYEQdGSC+vOQFx/YgGxJSLcU0kYTKUmU
         Ex4Gis6jy9kNF5YGgB1sbqKK+GPTJgMYX3Mu5Y4ACjSX6TS7KsW5OMgcGjTKURtnzEU/
         z4Vx5Dq54k5twGfLuGACLdraITns+JFl8IDJCahTuDSHxx6e2C/OsrZ/b2KIGCBnH39C
         tr0QYlJ9PqXM3CiE4N/olLBKa9t+dzvwtKFzGgcShQyq12u++NGCe7MnSzrYlS3ctGp7
         yqYA==
X-Forwarded-Encrypted: i=1; AJvYcCWcAK9YpEB8O7kYxZyf6jBvOylJiANs3yOXqH6OouxyqQwEAPhtbFxgpvygEJLiEmStfBeha1NAMRSv6C4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZnjXj4GUrU5nvo+SnbRw+rWDYx9MttUwKu9msr6ISGNDWzIHG
	IFPDPPDaet5JZH4/y70MZ+q0O71A3BtZQnpPNFsWlvAHmEz2ojp+yJ2Xj+XVMpNxhLhiy4X/Mlm
	fbQ==
X-Google-Smtp-Source: AGHT+IFr4YwjZRNLAhzMR8dvXJNxw6seS1J1CKUX52zD6Pb3AiCbF2jrKfYAnc1dm3jnBrVGzAC9QjuEyw==
X-Received: from edex4.prod.google.com ([2002:a50:ba84:0:b0:608:3a2d:685c])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:90c:b0:601:6c34:5ed2
 with SMTP id 4fb4d7f45d1cf-6149b410255mr50137a12.4.1753209547885; Tue, 22 Jul
 2025 11:39:07 -0700 (PDT)
Date: Tue, 22 Jul 2025 20:38:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250722183839.151809-1-elver@google.com>
Subject: [PATCH] kcsan: test: Initialize dummy variable
From: Marco Elver <elver@google.com>
To: elver@google.com
Cc: Dmitry Vyukov <dvyukov@google.com>, Alexander Potapenko <glider@google.com>, 
	Boqun Feng <boqun.feng@gmail.com>, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, 
	Linux Kernel Functional Testing <lkft@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Newer compiler versions rightfully point out:

 kernel/kcsan/kcsan_test.c:591:41: error: variable 'dummy' is
 uninitialized when passed as a const pointer argument here
 [-Werror,-Wuninitialized-const-pointer]
   591 |         KCSAN_EXPECT_READ_BARRIER(atomic_read(&dummy), false);
       |                                                ^~~~~
 1 error generated.

Although this particular test does not care about the value stored in
the dummy atomic variable, let's silence the warning.

Link: https://lkml.kernel.org/r/CA+G9fYu8JY=k-r0hnBRSkQQrFJ1Bz+ShdXNwC1TNeMt0eXaxeA@mail.gmail.com
Fixes: 8bc32b348178 ("kcsan: test: Add test cases for memory barrier instrumentation")
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/kcsan/kcsan_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kcsan/kcsan_test.c b/kernel/kcsan/kcsan_test.c
index c2871180edcc..49ab81faaed9 100644
--- a/kernel/kcsan/kcsan_test.c
+++ b/kernel/kcsan/kcsan_test.c
@@ -533,7 +533,7 @@ static void test_barrier_nothreads(struct kunit *test)
 	struct kcsan_scoped_access *reorder_access = NULL;
 #endif
 	arch_spinlock_t arch_spinlock = __ARCH_SPIN_LOCK_UNLOCKED;
-	atomic_t dummy;
+	atomic_t dummy = ATOMIC_INIT(0);
 
 	KCSAN_TEST_REQUIRES(test, reorder_access != NULL);
 	KCSAN_TEST_REQUIRES(test, IS_ENABLED(CONFIG_SMP));
-- 
2.50.0.727.gbf7dc18ff4-goog


