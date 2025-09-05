Return-Path: <linux-kernel+bounces-802477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A2D9B452B6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F1BF58678D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5882BDC35;
	Fri,  5 Sep 2025 09:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="So9XhtQ4"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1928288527
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063351; cv=none; b=EPxBQo0DkjmDZXsXsooaDaa0pclAdQce7cJms50DvyS4Dy5jNp3gHQjRttS29LLu+6ZRcwiiMbhPBDXseRfvr5uZw702ps5g1Fj0qZylMwxB+hksQVsCewA4llnRis+wEPGNI2QVD8wXpkWIBpYQUAPOPIETUnZF0SjrYjyiYKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063351; c=relaxed/simple;
	bh=b/+MOpMmP/GIfKr7wTa1E1BNlwW6DNYUo8mVwHKUgBc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cou2DtUwSrvz85yCedK9PePXM4SCxRMNsJ9quTBzJT54jqX0cdKj987LtpExH8LeWt9uvo7BeUTrfvvYeKMcUCEhO1Zi1WhAGY9wfxppLpXUjHm6t2mm3XPOHxRaQHpzm8Fk8QUnFgu23ZdwMbn893IAKQLvjVXm97duz8xeuFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=So9XhtQ4; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3c68ac7e18aso1261059f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 02:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757063348; x=1757668148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9M5qxE3ItNC3Mnz+ynWNndW7FEsZCwWL/Y4p9WAoVvE=;
        b=So9XhtQ4HbtUkWbI6JgJcbA07cMolu8XLIO8hxW/aNfarSoJr/nZE9H2zR1ZrL4/h5
         31IBtwyDwV1+jisPxLDUCjixjV4pmCBsoq74yM0sJ7TDT32Kp/YGer69BXKuHvatUAhY
         GB49Dieu5GQzFVQ/iurwwwQwRvJxRMjUitZBxJtoBd/cXDynGkJilwCaLK9oj6gjmG/O
         kb57yDLt5hE5vVt3XnPyYH7sOul7LkQHD21LTpz4Bl6H1qWIvm5/SB4K8d18aGkUjsdk
         xULIN5+2sVbG3morvIQGwGIF4Diu1S7tOYlYJslUsATv5Ltjz/itSfs3GR1o+lSSgQZ6
         t4OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757063348; x=1757668148;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9M5qxE3ItNC3Mnz+ynWNndW7FEsZCwWL/Y4p9WAoVvE=;
        b=Kob0dUS+TgFUhJSVBDnsLs8zXwBBSV2usPmca1El5iLvy0/r+JZGi8WYwKt65k+UVX
         NSbSLCxm+yH13o6vj6oAboOp4NNdeVBpNb2XlM4z91vxqOUOVKA52himPAqISF7yvl9f
         2STpaNUY5UZRcJnfI8W7VwYqDYaNI0d2DJvKAtPvtemmlbEYQiCdmTgxf/Q9zAxj+YPK
         1cMIPrAlpIVryBc1T4iB+cro8A5k3xSI+QCpw7yCAuINP87JvW3q84cAtQ0fK1MIgxgw
         p4dl011w27qVEztf9fNd0BAOb8X+x5Pjmtz8ZR0VXqMSwgtWrMEIXURrgkCMNGFvYs6c
         0Sdw==
X-Gm-Message-State: AOJu0Yx78MhxMBAYVj0hUWZ5FcZAMwJ/utqscER/7Mtz71sJSWvbejJM
	jlhLCMF+S0KztcqwAqtWEjEOWXYowwsB/P9zhRVtf8BidBNrs52aDx1UmEJFnphKCGV5TeBqfOC
	+GUHobGY=
X-Gm-Gg: ASbGncsGoIqBqdzCjAgTivcPknvcIzBcAYxFtRsNSmDClEB5jh+4QqLpubh7DzaxKBy
	ZmyHyFytkncGa8NGkf6KYF8sPle5M4jm8DGOqoPpiYXzC1kbw7gnJXp7V1IHp1lVkB9tSwoe6mj
	wpkQv1PIXO8f4/KZzs6zt9/KR8MP8r5VU8YmENNv/5ykmCoreYDNKJRAvKKMn6vh3esve8zVuPp
	df5uAV8L9eWEGx2cjr+sfTSz4C0g1lqErgdYzcLy9/4kEZtQXttbcGPjfDPnaGkDEkVZrv0newv
	NjJgjEpFLTludqxl9on3Y34P6K07tqdCZXIq3MU6OMmUA5z53pZS0MPeW2DnKiNynxEsmyaNTb+
	hi4wC1ZTH5Xag+rbgs6jfBSvKnZtbvlAIlYoLzOwT/3/3E6iPNut71/KFFA==
X-Google-Smtp-Source: AGHT+IHgs81iOxB8/hn8VA8Mb3DxvlmefAcfwUJkrY/1A7uC4lmN4hVFGgcv1OogLAr+V7yPhyPC6w==
X-Received: by 2002:a05:6000:2308:b0:3d7:abf7:24af with SMTP id ffacd0b85a97d-3d7abf72cecmr12599967f8f.23.1757063347795;
        Fri, 05 Sep 2025 02:09:07 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dda6da5casm12931995e9.7.2025.09.05.02.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:09:07 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>
Subject: [PATCH 2/2] s390: replace use of system_wq with system_percpu_wq
Date: Fri,  5 Sep 2025 11:08:57 +0200
Message-ID: <20250905090857.108240-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905090857.108240-1-marco.crivellari@suse.com>
References: <20250905090857.108240-1-marco.crivellari@suse.com>
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
 arch/s390/kernel/diag/diag324.c  | 4 ++--
 arch/s390/kernel/hiperdispatch.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kernel/diag/diag324.c b/arch/s390/kernel/diag/diag324.c
index 7fa4c0b7eb6c..f0a8b4841fb9 100644
--- a/arch/s390/kernel/diag/diag324.c
+++ b/arch/s390/kernel/diag/diag324.c
@@ -116,7 +116,7 @@ static void pibwork_handler(struct work_struct *work)
 	mutex_lock(&pibmutex);
 	timedout = ktime_add_ns(data->expire, PIBWORK_DELAY);
 	if (ktime_before(ktime_get(), timedout)) {
-		mod_delayed_work(system_wq, &pibwork, nsecs_to_jiffies(PIBWORK_DELAY));
+		mod_delayed_work(system_percpu_wq, &pibwork, nsecs_to_jiffies(PIBWORK_DELAY));
 		goto out;
 	}
 	vfree(data->pib);
@@ -174,7 +174,7 @@ long diag324_pibbuf(unsigned long arg)
 		pib_update(data);
 		data->sequence++;
 		data->expire = ktime_add_ns(ktime_get(), tod_to_ns(data->pib->intv));
-		mod_delayed_work(system_wq, &pibwork, nsecs_to_jiffies(PIBWORK_DELAY));
+		mod_delayed_work(system_percpu_wq, &pibwork, nsecs_to_jiffies(PIBWORK_DELAY));
 		first = false;
 	}
 	rc = data->rc;
diff --git a/arch/s390/kernel/hiperdispatch.c b/arch/s390/kernel/hiperdispatch.c
index e7b66d046e8d..85b5508ab62c 100644
--- a/arch/s390/kernel/hiperdispatch.c
+++ b/arch/s390/kernel/hiperdispatch.c
@@ -191,7 +191,7 @@ int hd_enable_hiperdispatch(void)
 		return 0;
 	if (hd_online_cores <= hd_entitled_cores)
 		return 0;
-	mod_delayed_work(system_wq, &hd_capacity_work, HD_DELAY_INTERVAL * hd_delay_factor);
+	mod_delayed_work(system_percpu_wq, &hd_capacity_work, HD_DELAY_INTERVAL * hd_delay_factor);
 	hd_update_capacities();
 	return 1;
 }
-- 
2.51.0


