Return-Path: <linux-kernel+bounces-818143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB2EB58D81
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 06:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DFFC526A3F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 04:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84292EAB70;
	Tue, 16 Sep 2025 04:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KoJa0Qc3"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AA8271440
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 04:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757998157; cv=none; b=lY4ha0CPRj7glP9xX+ApgZslriV5OUTNwAB8UJ3Z8IXNa5yt7Sh755TXmr5QsNDtuLgXEJA6uoao8WLfYURiPPFN2wGL08ddhDlFoXIDFoUK0+gkX9tAaP0mjNYXA+rcoYyikn0/wPOx9piQHwlDiM8xcqfaS0hj8Z119Oa1WSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757998157; c=relaxed/simple;
	bh=7sG+E8vq4OG/BfLJfXnS6N7EfrLQmjqnuIf5XUjAWWw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Q732q8IZ4BBafVdxhuMrPaKtOKTwL7sW5uCNrjZ8s7ASsLbHM0XF/A4mC3JPmmM07kCO3GfxZVtc5MNV1xBr8Zo9L1obRsrVzlGN/O8CwER9yTxOTqN+233dsBG4UhNDfx7l1xh//L2FAA7UZmWIY/ONW2m42H8BO6zd6VWrKY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KoJa0Qc3; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b52196e8464so3103407a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 21:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757998154; x=1758602954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNMpbtPTFBPk6JIOba7CD2qKlqPbw337arz8FniHJF8=;
        b=KoJa0Qc3lt8G1CQ5AbwOj3qvb9bu5qliDuEc4sfIPbr1BRCVYR3Bx/XN92R2rWqFFv
         nHGpulI2lx/uODqzl/0u0h/6Rd9sByZfpl3GezXb8FqkGEAdnsFhVtRYZkSK5GIUv0/U
         88Lv5WhrrzMFy50Fxe3cVARMTRYHZ/bppdUMJGJiCZEz6603dKLXzj7HX0yNRqQMWyyo
         JfK/UKwhrbZ4VNufXLGhr1uiC09OVkI4kemP0MSwbP+Qk2WkAhoNM2BA+QwLdUISw40+
         6iGnCmDltYbiDd7B2YnOenE3yDZDTJGhVOPaXTN2KCrPIOiSFy+O9HlA808tUeXmw29z
         3WIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757998154; x=1758602954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zNMpbtPTFBPk6JIOba7CD2qKlqPbw337arz8FniHJF8=;
        b=BfMbNIRRluhe2ZU8iIJaYI3AYi286ZMCHCWjDdFIw86Ncxs4em8yXl3xzWKadKLPkm
         kj/xVOtHd/cMk/IfyLac+Sfr6hcsN9LzqV2nn/XFMjzpnzQPD4nllRLg2k5jxTvLIGtW
         5vShx87x476IeOUcOXCdMv0xDiVhVB3gr1H9e7r2VZOky6sCTCuy1ACa7NHrBgqgdJCp
         uYVmvUA4tkAnv8WRZJFUrQIND+/cGu0D5QUv5+mW6mnmW60mFv+dd/KmTqJ/fXs4PQXb
         oaJjFqkN7tHyikH5DCjyGM4vy54yoL1gGBSoYSUz2nw1Tu0tQi4js4mo2rKnbh5gXvtP
         c15w==
X-Forwarded-Encrypted: i=1; AJvYcCXwjR8uyJh9t3WksWj/I/Q54XQniZUdYnP/MO9nZnR4YV66aD/WHgo7MZE5SwM2hteFMC03py7e7Q8HT6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YyukxN7u8tg4CVwP5UTinirF3iazqbhrydV2FzAciU3VBmTbLkp
	xaiXuDWFyqoNUBVXZZobhnQUkGvA7AB9t3DXXiF+ttP1Aer/uFUGXaaxRqn0rweMsjw=
X-Gm-Gg: ASbGnctEkbxdi/sT6VHMIIguxJA6KlVvJdeALWBR7vS7/+wykVlD1GgHaL1vtn2HW91
	mMpMVKdhEkuliRnKgBjmrSEMFGT8F/hUobOAzndB9v8wogEv1J80SmDOzhtCb7q1zTBk9nkw/DX
	D+tdXkXOXRKcnVqkVmfiTxL8CxTbJavmHSUy11RdQ7Nh9YarCd2oeRiRuRlGIX1HhB4SQwjF58l
	sgkV3Q3H1M/VVblPoEN1EEhhxeM8GFl48CdZ0tSTyKzbRaUzMJzPrDsjbESaRcTsZuoa8va+czl
	ShQf4qyU8ReYCnylWTSlE/96p8T+YDJ/qNgHbzL8BqmTV5Cn521/oFwvxvM00w6GGYbZW4ssaI0
	xUncF/xDxNm/iyndLYz+yPT/ux54lrfLPjIjtxUY=
X-Google-Smtp-Source: AGHT+IESqtMzjXYDIyoiu7v1JuOroH/dzFervHo7F64ECeuOEjCMVsn8AAVx3YpgubRO047K2xnTHQ==
X-Received: by 2002:a17:903:3c2c:b0:24b:2b07:5fa5 with SMTP id d9443c01a7336-25d26663dcamr182035635ad.29.1757998153712;
        Mon, 15 Sep 2025 21:49:13 -0700 (PDT)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25ef09c77f8sm104600605ad.15.2025.09.15.21.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 21:49:13 -0700 (PDT)
From: pengdonglin <dolinux.peng@gmail.com>
To: tj@kernel.org,
	tony.luck@intel.com,
	jani.nikula@linux.intel.com,
	ap420073@gmail.com,
	jv@jvosburgh.net,
	freude@linux.ibm.com,
	bcrl@kvack.org,
	trondmy@kernel.org,
	longman@redhat.com,
	kees@kernel.org
Cc: bigeasy@linutronix.de,
	hdanton@sina.com,
	paulmck@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-nfs@vger.kernel.org,
	linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	netdev@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	linux-wireless@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-s390@vger.kernel.org,
	cgroups@vger.kernel.org,
	pengdonglin <dolinux.peng@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	pengdonglin <pengdonglin@xiaomi.com>
Subject: [PATCH v3 09/14] cgroup/cpuset: Remove redundant rcu_read_lock/unlock() in spin_lock
Date: Tue, 16 Sep 2025 12:47:30 +0800
Message-Id: <20250916044735.2316171-10-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916044735.2316171-1-dolinux.peng@gmail.com>
References: <20250916044735.2316171-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: pengdonglin <pengdonglin@xiaomi.com>

Since commit a8bb74acd8efe ("rcu: Consolidate RCU-sched update-side function definitions")
there is no difference between rcu_read_lock(), rcu_read_lock_bh() and
rcu_read_lock_sched() in terms of RCU read section and the relevant grace
period. That means that spin_lock(), which implies rcu_read_lock_sched(),
also implies rcu_read_lock().

There is no need no explicitly start a RCU read section if one has already
been started implicitly by spin_lock().

Simplify the code and remove the inner rcu_read_lock() invocation.

Cc: Waiman Long <longman@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Waiman Long <longman@redhat.com>
Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
Signed-off-by: pengdonglin <dolinux.peng@gmail.com>
---
 kernel/cgroup/cpuset.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index 27adb04df675..9b7e8e8e9411 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -4073,7 +4073,6 @@ void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
 	struct cpuset *cs;
 
 	spin_lock_irqsave(&callback_lock, flags);
-	rcu_read_lock();
 
 	cs = task_cs(tsk);
 	if (cs != &top_cpuset)
@@ -4095,7 +4094,6 @@ void cpuset_cpus_allowed(struct task_struct *tsk, struct cpumask *pmask)
 			cpumask_copy(pmask, possible_mask);
 	}
 
-	rcu_read_unlock();
 	spin_unlock_irqrestore(&callback_lock, flags);
 }
 
@@ -4168,9 +4166,7 @@ nodemask_t cpuset_mems_allowed(struct task_struct *tsk)
 	unsigned long flags;
 
 	spin_lock_irqsave(&callback_lock, flags);
-	rcu_read_lock();
 	guarantee_online_mems(task_cs(tsk), &mask);
-	rcu_read_unlock();
 	spin_unlock_irqrestore(&callback_lock, flags);
 
 	return mask;
@@ -4265,10 +4261,8 @@ bool cpuset_current_node_allowed(int node, gfp_t gfp_mask)
 	/* Not hardwall and node outside mems_allowed: scan up cpusets */
 	spin_lock_irqsave(&callback_lock, flags);
 
-	rcu_read_lock();
 	cs = nearest_hardwall_ancestor(task_cs(current));
 	allowed = node_isset(node, cs->mems_allowed);
-	rcu_read_unlock();
 
 	spin_unlock_irqrestore(&callback_lock, flags);
 	return allowed;
-- 
2.34.1


