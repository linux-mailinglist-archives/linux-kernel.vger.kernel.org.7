Return-Path: <linux-kernel+bounces-733752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AF3B07898
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 16:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B37823A76AC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 14:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AB62F5C48;
	Wed, 16 Jul 2025 14:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epxZYKNd"
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABB22F5332;
	Wed, 16 Jul 2025 14:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752677325; cv=none; b=AGh3ZLFhzJxhZxpz8fJE2f/ndTtJcSFWaUHqa1tH8uHDESVo5Ann1I0ChWWWGkpCdQhjfLxbScdrBrjCMR0NsoK9gmKV9QXsLop0gG8age4xwS0s9ZGzzhSYdhJb1FBVnndimEgANNuGSmDa4ROXEeDeXquU83SNftkK6RfgB+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752677325; c=relaxed/simple;
	bh=BFaee+PMTlX5hdKVFHcg5Yrv+GniSx9t8vdFXR90kUs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eaT5PPitAd8WUegQR4ZxQF7asQvnFneVCYMNUcZAf/f5x898OVs8k+8Fl91cQ3Q0dQxKO7PuVvPI5ShCTSFVRlGvgNuyOmRiiUI3xXa0eNIRDy80S59LLs/phxvQ+M0Gq1TAyyZ0/qW5r8RUziGvqZmIWXo8HvJCTwhDyfy251M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=epxZYKNd; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6fd0a3cd326so66466d6.1;
        Wed, 16 Jul 2025 07:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752677322; x=1753282122; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ddinZAnEwYMRMDRQ6y+KZDh22DDG22BXx2nEWjhYOm4=;
        b=epxZYKNd2UnvR9nsqhUIyAErwmuoghVPgPDvwTWh18YeWqgvrUsKoydz3LxxBr+FfT
         wyQSyozeCvnKYKu9S9e+sg+GNf6A3Z8d1z9cm6SeCmb0AVg1juZwjI0L/jibmolbnRld
         tsO+HUO5dfYzyl32j3OdVQY5KhrpRvFxD6D4nFev2CfWA2KGZ53keyrBw5UO/8OV2nnf
         KlQE0YWhNqJ2E0PKj7pzc2UJbguhAFMix3S9VMy8E3cTM3mz2cn3nOEy4vkN4CZwTMVt
         qxqdyWu2/jT4/iSOjLqrbJMvim7RVDPsZPt3+JDwSiCLRPhbvap4FWGAZiOTknxqBJZ6
         Wgzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752677322; x=1753282122;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:feedback-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ddinZAnEwYMRMDRQ6y+KZDh22DDG22BXx2nEWjhYOm4=;
        b=JWLYBbWgIT9n54B8WsnUqCmiPStZtZW2dp9M5FP7D9w+wQCw9Mo8xKArzbAINDrUDi
         ua+XevLjy8xTmFtF3wJVA0nSHXZB3MoP1/NMqzxD7oqEGbHKOFy4OgdLyckrY7RnGT8H
         CG288un+gIYVQp8/XdehsdMwIaqmbCVeoMBvLFqHZljjUm1BRhzKC/1b3QtO/QDR1lql
         GkSHwrsF5HMoX4zJ6bzf6EBkoXntSVfAvGpzbwnE2DjqliUNRxqpqAZSIS9aXorvZr/u
         TD+CoK3pKxklFzrNnefP70QMWo3cMawGy1Rv2CAEAaCdlVH6NnM8ZhzIxi4HLrJSIRKJ
         Ya+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVBBaJfBB9ptpxVHWTPl8mYIYYFj3EJS61bjKpGC7d+eIY1LQMzs4Cs5X71G5XkUbQhJIG8rvMd/HjvYfk=@vger.kernel.org, AJvYcCWq0f6QVffnfAwUsAqpXYqYbjA3g/mTQtAWDkqAwUzzZdX0zrsfLovRPYouxUoEu/VDOX0DFeWiUOhjVxEGPQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwV+IfTXQT4nHvN76Ih0WhCQWQ96dgQggNTuViB5G5SJtziAMi
	z1LTYTlR4P09fAzqAmLJazvTRXTdp4eljma6kUkPxJ7TeAaRl7KfvRqu
X-Gm-Gg: ASbGncs6cvBOuQKgYVz/gmpcDfMEV996xrUJDBVu0tPq0xZd2gIStNICrNx45e2ccRE
	ehFjihUH8ZoojXLF7Zr+cl+NoCH0s87k43yO+Es97BLrloGHHhlDKVEjvhdMCv0RKjSWn6P57Ta
	wV7NOeN79/PrcKaMnt+jHYStOTV8FPHQZ4Nicam+JSHZ/l4S9hK8sWooQSKzi0HnRvb0ehjQfZN
	lGfCyaxNNQRzeEL9CQvpu4l+eJg8MWyoerp1Cjnw+Jy9hhzMTIJjZtwFc5/t2B9RK77DYGCnofC
	0Ee4P6ABZAbKXsBSjgZSI9fTplwZgQ15ps0hylC/joIjxviLOtMJuzQKz/hHzrisCZaAOq8hNDw
	+sUIJBI6sfuixn5akH8v9/tSlPteLU702abeTV3vUzjZFvSDmLG7UZ7whQ9JewawfPmrN2erlOb
	Jmy4BONXriXonk
X-Google-Smtp-Source: AGHT+IHEAs/dk2LzTmTPg4aUMbCu/Ymg9bI7m/olOGbK5WgQLk446WxRuWFiIMR97mla7YTsGjuVQA==
X-Received: by 2002:a05:6214:4a83:b0:704:85bd:d239 with SMTP id 6a1803df08f44-704f6afbca4mr49374686d6.16.1752677321966;
        Wed, 16 Jul 2025 07:48:41 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70497d71b51sm71360686d6.89.2025.07.16.07.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 07:48:41 -0700 (PDT)
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 49A0DF40068;
	Wed, 16 Jul 2025 10:48:41 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 16 Jul 2025 10:48:41 -0400
X-ME-Sender: <xms:ybt3aNOpQyIhE8zGDQCc4JFoATR32fxZJ8dYkwuTIq-Qxbj8AaWaew>
    <xme:ybt3aFd3cTD8Flf8JqMRbziRoV4SuI4FafrZw-9ZQ1CWc-KltQwhZReOyXm4Mn_az
    hFg9Oos5UNdrEgpVA>
X-ME-Received: <xmr:ybt3aLXLujKQOLaUtDGRSBVBoYPDRgeuivhCPCM1HLEpeJQUNmJqaE_b6w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehjeellecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepgffhffevhffhvdfgjefgkedvlefgkeegveeuheelhfeivdegffejgfetuefgheei
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedune
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvg
    hngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohep
    uddvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmihhnghhosehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgt
    phhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhonhhgmhgrnh
    esrhgvughhrghtrdgtohhmpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheprghlihgtvghrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    eplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    oheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtoheplhgvihhtrghoseguvggsihgrnhdrohhrgh
X-ME-Proxy: <xmx:ybt3aOBnAvfK7CqFLbdxhl2WmefJgAkPBu9_kzMcAYpGyH_Cu4UJgw>
    <xmx:ybt3aO74Q6qSxExytiAHfw-i50KDsyEWM4Eo_oX-099-FF0_UINzVg>
    <xmx:ybt3aN3y7uwABtskki83AbKOx41_pbExrpOOAJFNwOE4OWwcc08TYg>
    <xmx:ybt3aKmVGX9o9HXlIcP7qMHcHeQZ7sYpJdxjJ143wshhr2CPab8TCw>
    <xmx:ybt3aL6ZEDlTc8D0Bm_jxV4FieiOo6QALzYY4PhyWGzdG4dzS_APE27b>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Jul 2025 10:48:39 -0400 (EDT)
From: Boqun Feng <boqun.feng@gmail.com>
To: Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: "Will Deacon" <will@kernel.org>,
	"Waiman Long" <longman@redhat.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Breno Leitao <leitao@debian.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH 6/9] locking/lockdep: Avoid struct return in lock_stats()
Date: Wed, 16 Jul 2025 07:48:15 -0700
Message-Id: <20250716144818.47650-7-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250716144818.47650-1-boqun.feng@gmail.com>
References: <20250716144818.47650-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Returning a large structure from the lock_stats() function causes clang
to have multiple copies of it on the stack and copy between them, which
can end up exceeding the frame size warning limit:

kernel/locking/lockdep.c:300:25: error: stack frame size (1464) exceeds limit (1280) in 'lock_stats' [-Werror,-Wframe-larger-than]
  300 | struct lock_class_stats lock_stats(struct lock_class *class)

Change the calling conventions to directly operate on the caller's copy,
which apparently is what gcc does already.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20250610092941.2642847-1-arnd@kernel.org
---
 include/linux/lockdep_types.h |  2 +-
 kernel/locking/lockdep.c      | 27 ++++++++++++---------------
 kernel/locking/lockdep_proc.c |  2 +-
 3 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/include/linux/lockdep_types.h b/include/linux/lockdep_types.h
index 9f361d3ab9d9..eae115a26488 100644
--- a/include/linux/lockdep_types.h
+++ b/include/linux/lockdep_types.h
@@ -175,7 +175,7 @@ struct lock_class_stats {
 	unsigned long			bounces[nr_bounce_types];
 };
 
-struct lock_class_stats lock_stats(struct lock_class *class);
+void lock_stats(struct lock_class *class, struct lock_class_stats *stats);
 void clear_lock_stats(struct lock_class *class);
 #endif
 
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index dd2bbf73718b..0c941418a215 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -297,33 +297,30 @@ static inline void lock_time_add(struct lock_time *src, struct lock_time *dst)
 	dst->nr += src->nr;
 }
 
-struct lock_class_stats lock_stats(struct lock_class *class)
+void lock_stats(struct lock_class *class, struct lock_class_stats *stats)
 {
-	struct lock_class_stats stats;
 	int cpu, i;
 
-	memset(&stats, 0, sizeof(struct lock_class_stats));
+	memset(stats, 0, sizeof(struct lock_class_stats));
 	for_each_possible_cpu(cpu) {
 		struct lock_class_stats *pcs =
 			&per_cpu(cpu_lock_stats, cpu)[class - lock_classes];
 
-		for (i = 0; i < ARRAY_SIZE(stats.contention_point); i++)
-			stats.contention_point[i] += pcs->contention_point[i];
+		for (i = 0; i < ARRAY_SIZE(stats->contention_point); i++)
+			stats->contention_point[i] += pcs->contention_point[i];
 
-		for (i = 0; i < ARRAY_SIZE(stats.contending_point); i++)
-			stats.contending_point[i] += pcs->contending_point[i];
+		for (i = 0; i < ARRAY_SIZE(stats->contending_point); i++)
+			stats->contending_point[i] += pcs->contending_point[i];
 
-		lock_time_add(&pcs->read_waittime, &stats.read_waittime);
-		lock_time_add(&pcs->write_waittime, &stats.write_waittime);
+		lock_time_add(&pcs->read_waittime, &stats->read_waittime);
+		lock_time_add(&pcs->write_waittime, &stats->write_waittime);
 
-		lock_time_add(&pcs->read_holdtime, &stats.read_holdtime);
-		lock_time_add(&pcs->write_holdtime, &stats.write_holdtime);
+		lock_time_add(&pcs->read_holdtime, &stats->read_holdtime);
+		lock_time_add(&pcs->write_holdtime, &stats->write_holdtime);
 
-		for (i = 0; i < ARRAY_SIZE(stats.bounces); i++)
-			stats.bounces[i] += pcs->bounces[i];
+		for (i = 0; i < ARRAY_SIZE(stats->bounces); i++)
+			stats->bounces[i] += pcs->bounces[i];
 	}
-
-	return stats;
 }
 
 void clear_lock_stats(struct lock_class *class)
diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index b52c07c4707c..1916db9aa46b 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -657,7 +657,7 @@ static int lock_stat_open(struct inode *inode, struct file *file)
 			if (!test_bit(idx, lock_classes_in_use))
 				continue;
 			iter->class = class;
-			iter->stats = lock_stats(class);
+			lock_stats(class, &iter->stats);
 			iter++;
 		}
 
-- 
2.39.5 (Apple Git-154)


