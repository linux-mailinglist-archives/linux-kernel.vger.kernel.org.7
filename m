Return-Path: <linux-kernel+bounces-802432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FF1B4525D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C09A87B8C45
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32EFF283C9D;
	Fri,  5 Sep 2025 09:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Qr+/XM3Y"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBA5238D22
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757062901; cv=none; b=MAOZRqBmPZObt6P2wMlizzbB65KHW8gCrAcrWpdNjkM06myKDoJmHrGTXqJ+uUdbAFDMPkNFalfezxIbVYol04F3F1Z8uiaO4jZlimnC/tdX8J4nOxdkDNmRaV9VGpbeQqfRf1atCK7eydI6Axa3WFzUi/BoCqJbJB/G97f2in8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757062901; c=relaxed/simple;
	bh=qvqSjoO/mRLjIPV/1wtDFk60TiCvaNH/heT36hH/Qq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HdbV38s2GPZqIlnI/GwLtY95DhRnkRwhYHXFLTmBsXm3aXgrCgFdZ0BPv4LxAXkQHCn2q+PPB3cn7K6ZRW4eQLGuM43JKRjDVDuYtf2ZZs0beOCjm3mLVMyxROnCJY29d/s5NxUOAQt3ncqsAbcauo4cljAUQ5uquAbBK2YWZAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Qr+/XM3Y; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3ceb9c3d98cso1152268f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 02:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757062898; x=1757667698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5KHWEqaXSiQRHQD3PSK3TviVXz938qrA11SI1DLfq0=;
        b=Qr+/XM3YIRot+XEKx6VXfPVY1M9qTnHPED3PapGgMMjexiJkYzp1xMptTZPAL00Bsy
         1XkybDnqWauSnnnA0RMBM7rhsaJ/mqNHO47RfF4YUdYcOr/h+vyw4AMN8SUeW+Cws/hu
         YsHorwa/ZOQwpewcc8Jk8Lqg4YAW3O1Av1MWNb9jolDRTGqNUo5ZKDGHv9DnTvqYEDam
         AOKs0EWI0LZW6wNp2qrTFqGgCh2SFWQonkbxnQNIKd/JotNgFPQ11y31h1+69BquahRL
         +nHQB3kCHGC4xUBTpuEWlF4Qk67yYOW0Eu5vCjfQ73oywrdwEe3Y4YbikFzve66Gg1wv
         TmrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757062898; x=1757667698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q5KHWEqaXSiQRHQD3PSK3TviVXz938qrA11SI1DLfq0=;
        b=N44gNkorHhz9SU/AfA9mmc+1Qfod5g6Hz6xkEiQb4WZ68lANHLUPIcvFFNeDtEoTbk
         nyh5emwHGHtzLEXTfCy6eBOAy4jJpAukT0KvuaK0QnrLQCBa03xHy6FZcQVJKEsKtKKf
         lNwnLUgI/e1bl0HNpNeW6ulRcj8H14g5b6hBf/ed5wEHkypZXCn9ddtRsA0IHse7WeCX
         CC05crZprrn4K2UJAToeWDAVLs0/m7WTld9EQ7N4I6qpuW0fXNsSEu4/+Vw1+k27gCES
         FRVsGYeNC7J3kfpnC+X1xXOLaSw/3X6LW6+XKn4cC+gB7Cw+5gbW/rGTfiBpU1T733IC
         YeYQ==
X-Gm-Message-State: AOJu0YydiTRpniWYwpqYcKSu4RcmnM5TjezbJo2qKBwzc3IGV5dhqIck
	XZJJs3wp24ATI+fc0yO0Fvc5GEwxo+OU0vrX4dLWZ8D9QSWf4s4hl6Hk6yRGrjNLaC+v+mEzJwP
	GSbL6
X-Gm-Gg: ASbGncs5vmELaQtVNHULA8Aa03wycl9tBJP9U6ieqYfDHu530jDzCGrGGgpEBPf7bUG
	uOzHPUPjN7l+fBy3z5x9kerID8B3nVX6k0o6DK3ZXMHznkCApcNec/a96YUbVnyW63C4EKytx2F
	HOz3flBwGifBS0v34k5NyqQ3irUSuzFUSq6xyYzCKLKMGaKluB6z3roic6KPIs71PJ0qFJS73oi
	5cE4lDT2y/dr4gDvs2G/Om/JdYn1swwR0DbUKZCyUaft///JAXC/gC7hALKc45r1eXyJtbkHKyR
	39vwwB9W664bgrISgkgWb1dJ/DeCKIa3Yb8emxizjBQCo/NYYceBw6mUtbDKEVzI6ddrqhe9Fmg
	aCq23iUVt+UQVWPRwns/tEWIWEl/gAIdkmNfGMVh7w7gfjBwBDEOFy1FgBA==
X-Google-Smtp-Source: AGHT+IEauwqdmqEn4hr445iqcOmm/sJaiG6o1U1wFAlO1tWFtAfZ1VjOWTJlAJ6GuL9SVs/bjIcxfA==
X-Received: by 2002:a05:6000:22c8:b0:3e2:bbd1:e914 with SMTP id ffacd0b85a97d-3e2bbd1eb93mr2650150f8f.51.1757062897600;
        Fri, 05 Sep 2025 02:01:37 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e411219ddfsm1317713f8f.57.2025.09.05.02.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:01:37 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH 1/1] module: replace use of system_wq with system_percpu_wq
Date: Fri,  5 Sep 2025 11:01:30 +0200
Message-ID: <20250905090130.101724-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905090130.101724-1-marco.crivellari@suse.com>
References: <20250905090130.101724-1-marco.crivellari@suse.com>
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

system_wq is a per-CPU worqueue, yet nothing in its name tells about that
CPU affinity constraint, which is very often not required by users. Make
it clear by adding a system_percpu_wq.

queue_work() / queue_delayed_work() mod_delayed_work() will now use the
new per-cpu wq: whether the user still stick on the old name a warn will
be printed along a wq redirect to the new one.

This patch add the new system_percpu_wq except for mm, fs and net
subsystem, whom are handled in separated patches.

The old wq will be kept for a few release cylces.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 kernel/module/dups.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/module/dups.c b/kernel/module/dups.c
index bd2149fbe117..e72fa393a2ec 100644
--- a/kernel/module/dups.c
+++ b/kernel/module/dups.c
@@ -113,7 +113,7 @@ static void kmod_dup_request_complete(struct work_struct *work)
 	 * let this linger forever as this is just a boot optimization for
 	 * possible abuses of vmalloc() incurred by finit_module() thrashing.
 	 */
-	queue_delayed_work(system_wq, &kmod_req->delete_work, 60 * HZ);
+	queue_delayed_work(system_percpu_wq, &kmod_req->delete_work, 60 * HZ);
 }
 
 bool kmod_dup_request_exists_wait(char *module_name, bool wait, int *dup_ret)
@@ -240,7 +240,7 @@ void kmod_dup_request_announce(char *module_name, int ret)
 	 * There is no rush. But we also don't want to hold the
 	 * caller up forever or introduce any boot delays.
 	 */
-	queue_work(system_wq, &kmod_req->complete_work);
+	queue_work(system_percpu_wq, &kmod_req->complete_work);
 
 out:
 	mutex_unlock(&kmod_dup_mutex);
-- 
2.51.0


