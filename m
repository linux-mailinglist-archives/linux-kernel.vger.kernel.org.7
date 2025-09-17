Return-Path: <linux-kernel+bounces-820022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA9CB7CA0B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:06:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49ACB326EAC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 06:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0DC62877D8;
	Wed, 17 Sep 2025 06:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPWIwQud"
Received: from mail-pj1-f66.google.com (mail-pj1-f66.google.com [209.85.216.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8A72BE056
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 06:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758089391; cv=none; b=jjk2dWLzkXFBJBgPJKoZeU361fjB/xTQ9piU4buXHLLQiZ27DK6FPJQafbrqiPpfodNkcmwHRkpvKDZ2YuLm72N5p0mZMFvSCalj/nJ+TAuiNfBebSZjZ4WM+pOK0CuIo2LLFOeuVwbHMBFECyyuq+4bOWEKr/jcHNydsIa1kio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758089391; c=relaxed/simple;
	bh=QNQvynZlOOH8IMgTmEdWcYET2p/CChKWnmzoWhxeMd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kgHplMu2X7xlK82wCVTxLoES6ILzhPXFoHu0S52Qbr2M/DuyI+ICP8H0Uv7ogoeV7G2aDEiePU+mf6XbydvZCNPOXvfA8TxKn7TWj+AEN7Vm/o0Z+mziak78EURTUfgnVV3b9NjxnAotJkt0VwCIxcOVHdlN+xYrtjhhMSjeP/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CPWIwQud; arc=none smtp.client-ip=209.85.216.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f66.google.com with SMTP id 98e67ed59e1d1-32e74ae0306so472364a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 23:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758089390; x=1758694190; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e59v+VK1meCsMZeLVvoLFn49I9lv/VnXIPMZZBibqP4=;
        b=CPWIwQud8Bs8py0FrRBK6LappKq75Yk4/ipLQlLFYG1oM0N47GERCObe6F2UU/AHjs
         RmltKuwsKiHnbxnZKhxOnXJG/2kEmoJEPWhRIcC+tvthGD7SMMXhMT67gjodtK+K4KEv
         S4HNN3+Fr6H3GBdvsRkUuC8CVH8tKDt9c9C+/94WbWGx6eoTBFIPjeiUAlYuN3S2XmPV
         S1Slm07liTw/whjcY5AlGk+BjdVFKMQu/sX1c6F81yl7TsWllWewjs/vDokOFryLcfn6
         gtEbKws8bKiolW5PiJgZKUt7e1JcDfcqU2PS7QRzkqGDbfzpCIsd2jhLvzkZm0pvoHfz
         iZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758089390; x=1758694190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e59v+VK1meCsMZeLVvoLFn49I9lv/VnXIPMZZBibqP4=;
        b=ZI8yVf91fMzO2FHCw1BA9B8E1XSKVdreqAF1d53LpbJQebhs6aui1ZgpmwTbOMTMwe
         /YPIuvI/AMe3fuoa+CWfeoeYXXHoHp2clZwLhzWDsCSB0EqCNYpxUapVxsWCDn1uoILT
         nqmAB+8UfNKlHx6k4qGIYjcL9+uS2mgyPgY5ZHg0D8PQAirfcPaKa1vNkozLlLFkUuH0
         ZbpRnVyTBAU4bdyg0hq25zeoFEn4O2H5lrvNr55wC2w8DRLll1Z6tuRHgDhZliXy1FQO
         +2o6UFOkBMElaRw26cFZO8WT6+zaFDffScdnj2nXEW63V3EfzQyahDmhgmD0F1jZFLV8
         gmVQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2LJT1V1uP9bbPR2czvFoYrciP5AQRc8ZCapNTBao+PcRZZkjHVLkOWaKb63pMFhQnovVdhQaR1b4j8G8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDxLGykNrArgy6MAKJpk7npH3Um2JjhS+gKEBXOKt1yUDh3zz/
	WtkoJKTuLCGltnok9bZ2RAVCv+y9CaSWNehwQvBZKe8PqZMiYHeEa0gU
X-Gm-Gg: ASbGncukPEJeplimkwJfAHCmSJ+YMF/t7U7xYU03wYFQH9A+DvdW1bCYWA38l4qMgS1
	hJySICHnjqQQnrB5YwyOxPxCUqxk/myXmr3/xgnyZ1eKFWYlZsABPxomVyGjP+jp1zCCtDI574G
	NM7okmqLCiQrrZLymkbgcEy9LcdLeDHB6ATFCyEn1jUP+AklObnQ97urgo/8vLp9KOFxwU7foFm
	anNkoK4YDdONFmA8RlRYznJ6eB/cz15HxJrk6Egp7TCmYZ+bZb4tXzah4X3rLqSvWUBjjoFZLhK
	YajMN9zteMnBxZfuJkmZqc8lDzYqRcXSdArySTS8FqCQhyJ87k19eKwvZjV31ZEUS2Mo95zK527
	ahw2ZgvqRp7Bga8d9HhYLD13nfrKh/w==
X-Google-Smtp-Source: AGHT+IGcee+8x5fSj+d0gM6u/9pAt3eJTzUrOSgGWUp1U3NPTVVjd4Tga8HcNTRH0N5/UGUufGONaw==
X-Received: by 2002:a17:90b:33cd:b0:32b:d8a9:8725 with SMTP id 98e67ed59e1d1-32ea631cd58mr5457289a91.18.1758089389508;
        Tue, 16 Sep 2025 23:09:49 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a3aa1c54sm15845427a12.50.2025.09.16.23.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 23:09:48 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: peterz@infradead.org,
	ast@kernel.org
Cc: mingo@redhat.com,
	paulmck@kernel.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	tzimmermann@suse.de,
	simona.vetter@ffwll.ch,
	jani.nikula@intel.com,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v5 4/4] sched: fix some typos in include/linux/preempt.h
Date: Wed, 17 Sep 2025 14:09:16 +0800
Message-ID: <20250917060916.462278-5-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917060916.462278-1-dongml2@chinatelecom.cn>
References: <20250917060916.462278-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are some typos in the comments of migrate in
include/linux/preempt.h:

  elegible -> eligible
  it's -> its
  migirate_disable -> migrate_disable
  abritrary -> arbitrary

Just fix them.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/linux/preempt.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 92237c319035..102202185d7a 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -372,7 +372,7 @@ static inline void preempt_notifier_init(struct preempt_notifier *notifier,
 /*
  * Migrate-Disable and why it is undesired.
  *
- * When a preempted task becomes elegible to run under the ideal model (IOW it
+ * When a preempted task becomes eligible to run under the ideal model (IOW it
  * becomes one of the M highest priority tasks), it might still have to wait
  * for the preemptee's migrate_disable() section to complete. Thereby suffering
  * a reduction in bandwidth in the exact duration of the migrate_disable()
@@ -387,7 +387,7 @@ static inline void preempt_notifier_init(struct preempt_notifier *notifier,
  * - a lower priority tasks; which under preempt_disable() could've instantly
  *   migrated away when another CPU becomes available, is now constrained
  *   by the ability to push the higher priority task away, which might itself be
- *   in a migrate_disable() section, reducing it's available bandwidth.
+ *   in a migrate_disable() section, reducing its available bandwidth.
  *
  * IOW it trades latency / moves the interference term, but it stays in the
  * system, and as long as it remains unbounded, the system is not fully
@@ -399,7 +399,7 @@ static inline void preempt_notifier_init(struct preempt_notifier *notifier,
  * PREEMPT_RT breaks a number of assumptions traditionally held. By forcing a
  * number of primitives into becoming preemptible, they would also allow
  * migration. This turns out to break a bunch of per-cpu usage. To this end,
- * all these primitives employ migirate_disable() to restore this implicit
+ * all these primitives employ migrate_disable() to restore this implicit
  * assumption.
  *
  * This is a 'temporary' work-around at best. The correct solution is getting
@@ -407,7 +407,7 @@ static inline void preempt_notifier_init(struct preempt_notifier *notifier,
  * per-cpu locking or short preempt-disable regions.
  *
  * The end goal must be to get rid of migrate_disable(), alternatively we need
- * a schedulability theory that does not depend on abritrary migration.
+ * a schedulability theory that does not depend on arbitrary migration.
  *
  *
  * Notes on the implementation.
-- 
2.51.0


