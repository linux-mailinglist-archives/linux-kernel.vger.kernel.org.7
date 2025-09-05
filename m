Return-Path: <linux-kernel+bounces-802408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D2DB45220
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:53:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C9B4A46C10
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 08:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAD728031D;
	Fri,  5 Sep 2025 08:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Xe9sc5ko"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5FA281356
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 08:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757062405; cv=none; b=F4e2JyaHAKYOVj92rCvRTJi2vqjgnwN7pJTCV61d8UFQG3c6wIsVpI4qGgLduo/K5nxOAwTZfps//Rk2RC1yQOa2q91mlKPR+J96mHiEN586/wNGZNEUUONsvgxe3Uj2te/0D1RsHzr4dErXKR/HhpAZbYZG+qH4mdR8S0Pxj0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757062405; c=relaxed/simple;
	bh=GEf62t/g6oiTVPVC1cJMYKypf+y03W8litzuitIwb3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HA579zPu9DM9+u++EKrT75VSd7JqNToZ3iPgfgJerg9wHr8a3e2NxCSoLIkgaYNh3EdXtFb9C1jcQPKqWb2guGzNKMd7qmHAjxpY3I5mSjBo/L4cAvd4R00lekNMn7CAiZD2lxdEolQQXIxcndMCRFWt2vEHKdqxWrECH76ldXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Xe9sc5ko; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45b8b25296fso12055005e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 01:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757062402; x=1757667202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4B2o7LJolSwLsUyedkxBTIDf82LUraxF+ncxBU9k/G8=;
        b=Xe9sc5kobS8rKgJpzVV3E+grt28SWN2X5TGc7W0t62nvbZgNvG9wwbzshJLnSgSotO
         G5fhUquHkbRrlM0iqDtYQvKlxf5jip1r9WWF31xIN8JvJR9MXvLnCeclsU29uhPt17Wb
         k+CY5pDHftVQk7E8/7tDVJB59PDzkcmB5eCv9K0lpk9vpsNKpMUK/556Ts6TgqL6SY8D
         RTXV4RgbnIbF3b63h/zPYIdOBBJosuFiH743skE2AJgDNvg5k8M4/v+IPZAddSL6NVNB
         kZ37OXnx+5xbpJI0ueuAHzFNQzZxWQGyiE2scXiPg7txRJ42IboHDy3Mbcd1Tzdx0QNw
         RNGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757062402; x=1757667202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4B2o7LJolSwLsUyedkxBTIDf82LUraxF+ncxBU9k/G8=;
        b=xUdKGUvzVGp6KpM/6vRb4dskXoP4NoCiFfyKBLvTG1QvvLHJzuaOje2xyIyrJQLP8S
         nI+Prxcd/XeOq7FBP8+PyrxVayErtCVhc2E5RVYPwb25WMJyIzsN2VlNFszRFBwMS83X
         +5ETWZeVsDBuhLcu/MC7+qLeeXgArIVyYUcAbJt3ZHqDND9++XTz5yvA1xgEZxs7IBA+
         6U77z8mnPZC0oqSEZejHGvH04HlDolSI58bWkIbtVGOBgbhtb51PSVziwYeZgcYaSyz6
         Wg89A8GXfQkAAJyhXhmqONBsRHUIIu117BO88cuqquYA4mxZmJHCN4HTQc60+kahBcoS
         g5/A==
X-Gm-Message-State: AOJu0YxsAnB9UZuC0lMIM8DdgdtgtvLjmSMWOWFHt3OQE96iVKZG+2Rg
	svOVEKvp2FfdJvcTKWnkkw1RbO42LkxsbTDg2D+6uKyB0h3hH2aa76/RtPoAmUUVoHwiuJ51ykU
	6Ls1x
X-Gm-Gg: ASbGncuOjaUoKJA+CCoQGraJzCoemYkm1nLwX3K+6VzDJlvQTrtlmJ44bI/FKUVFATQ
	1WCd4eGxhP/Q3wCRez1SjqnY1q5WIUWmgEggqqGw23p2Xmc+wKR8c/9RpaHYqUus+z1+TTd9Wjw
	dMZPmHrJzTxqIkW3YW3nF/NVm+cfXfrYp4G3J+Hg6Fq1V8PAZ/OS7gzPXliAtJB78j9TQwNaWVG
	jhPNmLxcfECp8pxVL26/JT2e0wsBPkD9J1pwyC9lNap1w1FvWePzzl9vOE3xyD+gHpfdcimGtWa
	Bkqp9FrXEQqUUyhRqCqQ/bzHLSEpxWQ6tQHcBAkY07XNf1cdTBvq1EhVA9zt/uaeO2p5sUFiBZY
	wAuHewkY67IMAVwa/Rnw956hrwwxu08skCIbgc3Xb/vwgYjY=
X-Google-Smtp-Source: AGHT+IGBjO7xQV7cWnxGjNyx+7vN27kfCPPMb+7tirAXxLTouuf1kijLEtLKWTroGzkDJeGipPC59w==
X-Received: by 2002:a05:600c:1c26:b0:45d:d68c:dfa5 with SMTP id 5b1f17b1804b1-45dd68ce344mr12325985e9.19.1757062401693;
        Fri, 05 Sep 2025 01:53:21 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3d729a96912sm18487293f8f.8.2025.09.05.01.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 01:53:21 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH 2/3] bpf: replace use of system_unbound_wq with system_dfl_wq
Date: Fri,  5 Sep 2025 10:53:08 +0200
Message-ID: <20250905085309.94596-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905085309.94596-1-marco.crivellari@suse.com>
References: <20250905085309.94596-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistentcy cannot be addressed without refactoring the API.

system_unbound_wq should be the default workqueue so as not to enforce
locality constraints for random work whenever it's not required.

Adding system_dfl_wq to encourage its use when unbound work should be used.

queue_work() / queue_delayed_work() / mod_delayed_work() will now use the
new unbound wq: whether the user still use the old wq a warn will be
printed along with a wq redirect to the new one.

The old system_unbound_wq will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 kernel/bpf/helpers.c  | 4 ++--
 kernel/bpf/memalloc.c | 2 +-
 kernel/bpf/syscall.c  | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index e3a2662f4e33..b969ca4d7af0 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1593,7 +1593,7 @@ void bpf_timer_cancel_and_free(void *val)
 	 * timer callback.
 	 */
 	if (this_cpu_read(hrtimer_running)) {
-		queue_work(system_unbound_wq, &t->cb.delete_work);
+		queue_work(system_dfl_wq, &t->cb.delete_work);
 		return;
 	}
 
@@ -1606,7 +1606,7 @@ void bpf_timer_cancel_and_free(void *val)
 		if (hrtimer_try_to_cancel(&t->timer) >= 0)
 			kfree_rcu(t, cb.rcu);
 		else
-			queue_work(system_unbound_wq, &t->cb.delete_work);
+			queue_work(system_dfl_wq, &t->cb.delete_work);
 	} else {
 		bpf_timer_delete_work(&t->cb.delete_work);
 	}
diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 889374722d0a..bd45dda9dc35 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -736,7 +736,7 @@ static void destroy_mem_alloc(struct bpf_mem_alloc *ma, int rcu_in_progress)
 	/* Defer barriers into worker to let the rest of map memory to be freed */
 	memset(ma, 0, sizeof(*ma));
 	INIT_WORK(&copy->work, free_mem_alloc_deferred);
-	queue_work(system_unbound_wq, &copy->work);
+	queue_work(system_dfl_wq, &copy->work);
 }
 
 void bpf_mem_alloc_destroy(struct bpf_mem_alloc *ma)
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 9794446bc8c6..bb6f85fda240 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -901,7 +901,7 @@ static void bpf_map_free_in_work(struct bpf_map *map)
 	/* Avoid spawning kworkers, since they all might contend
 	 * for the same mutex like slab_mutex.
 	 */
-	queue_work(system_unbound_wq, &map->work);
+	queue_work(system_dfl_wq, &map->work);
 }
 
 static void bpf_map_free_rcu_gp(struct rcu_head *rcu)
-- 
2.51.0


