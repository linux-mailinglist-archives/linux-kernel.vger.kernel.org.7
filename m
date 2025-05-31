Return-Path: <linux-kernel+bounces-668951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BC6AC9982
	for <lists+linux-kernel@lfdr.de>; Sat, 31 May 2025 08:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2AD0189F841
	for <lists+linux-kernel@lfdr.de>; Sat, 31 May 2025 06:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074D31A2643;
	Sat, 31 May 2025 06:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iTEndOEw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88562E628
	for <linux-kernel@vger.kernel.org>; Sat, 31 May 2025 06:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748671688; cv=none; b=ZR5NPeQ4tOWLGHWdogR81f1txkmLaYewm256btZAZrSL9jLWQ5ps+Y1OY8OU1RdrHBA/cd/9tA6SpZ/H4qQCfCsjUgyYbfXkUicGR4G0zgyCuAGfQe7NG8JZeVZ2fjW5tGrAl6xV9HK7LY1kBb3pZ/h+/igljr6o224b85eUYHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748671688; c=relaxed/simple;
	bh=SFlrWWfG74B6exhPjuCqn0hBLGYXiSjGf/EbvYaaAVs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PVEyVQsEVRtl5F40oDnpWoWPLZMVcyDMFKz5sKcjkNP1ETVa9fXBm6z+dkyDnj9utOGx0PWCcTg60fZSQ9cn8XlFKXajV+23MueJHGcmDCR5GgeXY66lyUbJTasMy73mXGN6GSOr9BTh2+Ghwarh+Nf5IJpRDb+C9Gkk0lMiJcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iTEndOEw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748671684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Mi36qKJqcFRPx400y/HtJCcteAnaWg5UTYhGBt/SiY8=;
	b=iTEndOEwVNkWnbwSt2hn3DAfjkjCtLk03rprbk6d5r0psxJzFATdoa2hrtJX4wcOtbeAe8
	UL0i8DEzsu/yFoqnZ/Y/UO145oOjjas3xHsmwffq+AI5zfHQ3GIS6OSObs5Vegry/QYZBP
	AexwLor/sJOUx3smv0lPjjcah1PSeGo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-531-OxWsT9zqM4SBTVYQ970Fcg-1; Sat,
 31 May 2025 02:07:59 -0400
X-MC-Unique: OxWsT9zqM4SBTVYQ970Fcg-1
X-Mimecast-MFC-AGG-ID: OxWsT9zqM4SBTVYQ970Fcg_1748671679
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7F9F0180045C;
	Sat, 31 May 2025 06:07:58 +0000 (UTC)
Received: from virtlab1023.lab.eng.rdu2.redhat.com (virtlab1023.lab.eng.rdu2.redhat.com [10.8.1.187])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EE6C21954191;
	Sat, 31 May 2025 06:07:56 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org
Cc: mlevitsk@redhat.com,
	Randy Dunlap <rdunlap@infradead.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2] rtmutex_api: provide correct extern functions
Date: Sat, 31 May 2025 02:07:56 -0400
Message-ID: <20250531060756.130554-1-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Commit fb49f07ba1d9 ("locking/mutex: implement mutex_lock_killable_nest_lock")
changed the set of functions that mutex.c defines when CONFIG_DEBUG_LOCK_ALLOC
is set.

- it removed the "extern" declaration of mutex_lock_killable_nested from
  include/linux/mutex.h, and replaced it with a macro since it could be
  treated as a special case of _mutex_lock_killable.  It also removed a
  definition of the function in kernel/locking/mutex.c.

- likewise, it replaced mutex_trylock() with the more generic
  mutex_trylock_nest_lock() and replaced mutex_trylock() with a macro.

However, it left the old definitions in place in kernel/locking/rtmutex_api.c,
which causes failures when building with CONFIG_RT_MUTEXES=y.  Bring over
the changes.

Fixes: fb49f07ba1d9 ("locking/mutex: implement mutex_lock_killable_nest_lock")
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
	This time, with brain connected.

 kernel/locking/rtmutex_api.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/kernel/locking/rtmutex_api.c b/kernel/locking/rtmutex_api.c
index 191e4720e546..f21e59a0525e 100644
--- a/kernel/locking/rtmutex_api.c
+++ b/kernel/locking/rtmutex_api.c
@@ -544,12 +544,12 @@ int __sched mutex_lock_interruptible_nested(struct mutex *lock,
 }
 EXPORT_SYMBOL_GPL(mutex_lock_interruptible_nested);
 
-int __sched mutex_lock_killable_nested(struct mutex *lock,
-					    unsigned int subclass)
+int __sched _mutex_lock_killable(struct mutex *lock, unsigned int subclass,
+				 struct lockdep_map *nest_lock)
 {
-	return __mutex_lock_common(lock, TASK_KILLABLE, subclass, NULL, _RET_IP_);
+	return __mutex_lock_common(lock, TASK_KILLABLE, subclass, nest_lock, _RET_IP_);
 }
-EXPORT_SYMBOL_GPL(mutex_lock_killable_nested);
+EXPORT_SYMBOL_GPL(_mutex_lock_killable);
 
 void __sched mutex_lock_io_nested(struct mutex *lock, unsigned int subclass)
 {
@@ -563,6 +563,21 @@ void __sched mutex_lock_io_nested(struct mutex *lock, unsigned int subclass)
 }
 EXPORT_SYMBOL_GPL(mutex_lock_io_nested);
 
+int __sched _mutex_trylock_nest_lock(struct mutex *lock,
+				     struct lockdep_map *nest_lock)
+{
+	int ret;
+
+	if (IS_ENABLED(CONFIG_DEBUG_RT_MUTEXES) && WARN_ON_ONCE(!in_task()))
+		return 0;
+
+	ret = __rt_mutex_trylock(&lock->rtmutex);
+	if (ret)
+		mutex_acquire_nest(&lock->dep_map, 0, 1, nest_lock, _RET_IP_);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(_mutex_trylock_nest_lock);
 #else /* CONFIG_DEBUG_LOCK_ALLOC */
 
 void __sched mutex_lock(struct mutex *lock)
@@ -591,22 +606,16 @@ void __sched mutex_lock_io(struct mutex *lock)
 	io_schedule_finish(token);
 }
 EXPORT_SYMBOL(mutex_lock_io);
-#endif /* !CONFIG_DEBUG_LOCK_ALLOC */
 
 int __sched mutex_trylock(struct mutex *lock)
 {
-	int ret;
-
 	if (IS_ENABLED(CONFIG_DEBUG_RT_MUTEXES) && WARN_ON_ONCE(!in_task()))
 		return 0;
 
-	ret = __rt_mutex_trylock(&lock->rtmutex);
-	if (ret)
-		mutex_acquire(&lock->dep_map, 0, 1, _RET_IP_);
-
-	return ret;
+	return __rt_mutex_trylock(&lock->rtmutex);
 }
 EXPORT_SYMBOL(mutex_trylock);
+#endif /* !CONFIG_DEBUG_LOCK_ALLOC */
 
 void __sched mutex_unlock(struct mutex *lock)
 {
-- 
2.43.5


