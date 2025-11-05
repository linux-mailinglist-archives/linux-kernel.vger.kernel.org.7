Return-Path: <linux-kernel+bounces-886859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F4FC36A58
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 17:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5CFF664842
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 16:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73F5A335558;
	Wed,  5 Nov 2025 16:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fEwgo+LU"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA76C335547
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 16:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762358913; cv=none; b=HXseOa+06cCv4dmzcP+d8RHn00LiDDZ4E8ifT1m8O5b337BFNO1WQIEUBrJBjcsgUhA8OEiTbv6nFlWW//wzjo05Wnv8PqhD4rYgJWhyBprUWZafYn91a9zLDQsXaczRWG38LdjjfmH2oAlbhxsmZgjdEpUwAokwy8eKOPS56zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762358913; c=relaxed/simple;
	bh=qhthCQOxbmIIKyNheM8Rnhvvbyw9VuqTjkGB1Gw9Shs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cSj544NYnLh6EYzUIvql2IOfGNMV20B5n/aMwoiiqs8HU0N+OxdWRMj52JrXAma2r9P4lqHgIEFcpT4JzdE66uh6YsiNNThCUNpoOsAXYiV/rOc3S3ZlARHn6Sd2yJCeppcVnOAl5eRUt08Unl0iiEThxMTptGgh6BcUmnKJ14I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fEwgo+LU; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-477563bcaacso15404405e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 08:08:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762358909; x=1762963709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f1yBP/HblraJDKUqDJbJpnQ6bTQTPKGimKm7/HBY3uI=;
        b=fEwgo+LUn1JIcmd4fOYUTwR/jPimwMGMx0wEX7Hc/CiCGID2bxFmLcRF2vAQ4ixGRD
         v3W1vhr9T+VMgKDSjrCOBPRBdMs6oEnvAu2TCnPt2wHuReJC6P2H5f4kQ1cCQFTFmuxR
         55Ri/CMrj548FjVwNuP7XLbojQoAVmpE8o4j8++vWLBbPz6yMpvQHX0pYQTYL4c+7n5H
         3c4HFURCYdWYEvexECi5lh4/xTFl0ZWasKshkkVFH0PjKBQ8MWwTBqJvMZzFcQe56fJw
         m2y4P9oKPtz4n+dT2IsktVgBKz6X/9zn/cq+edt0c7U8+0o68UmmgHaRJ04J4tewnpwp
         NHGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762358909; x=1762963709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f1yBP/HblraJDKUqDJbJpnQ6bTQTPKGimKm7/HBY3uI=;
        b=sAMNZ2zJIlHtv+VZChhbR3ZDgMK/Dv/UboAtYvHvrASe4fzWs1r2i27Dkn4IkvqkNl
         RDuTHe2hnk9hb72qaR6Yyh6p+mvttQ9uIsZKyz6W83wyViyyUdNd9AFks5OS+OGQTQo/
         +qUKorJKtFA5w2mLYuqHJA2OnNn5PnLMaxWM6xo6gwhkW7XBThcHe1tBmsfBFOSzhWG1
         DbJH1A46m87bJmQzACQ+tP7IvNEHgixm3Tl15KFeQ7A4D+xwttNTedxOCeIDUFVS0wEl
         RcMvuUQPtRzvvtLIA3nppkU81qAoypU5Wy1H8xB/0NBe4aJI4hn/FvB/eFCVATcUuuBB
         p4HQ==
X-Gm-Message-State: AOJu0YxmmR34Iti60R/P5NvjG4n692FQ6+YqtORDLr9Krn035SdwM8bK
	Jx1AAITPzeL5T07L0Wkze+unnlymfWtGrJ0mzFuoLuJEEyfcAVwj54oT+wx196VSM1Ksa5Nr8pG
	OlG6U
X-Gm-Gg: ASbGncvwxRXTZmMpU6ZST9WqZac7tIgnsDc8KQwzCYl6FwU1szksr4gUHS6PA3a2Oy6
	Z99hSlx6jX6n4yyUxp2A8UwJ3C2dfenTvl01pZ7Oj8+I9mYCZtNNutuTiCc94XHZ0yRysGr20uy
	/7AD86z94ru90tKXlkYInyqMuasr7D38ptl37bI+o6QBbwRo7VRFlucy3GzyV94egx8du0q7OFg
	oiFg0fPmyUpM2R7O4ihv7eIDF+orFm5YuTMM8OILgYIyzGKGd7aEvui9rzGmHuyaT9FbtTtfzca
	xihnxowUshToF6+pH3nxUuqO8NTEb/7Ra2SX7ZcS88A008erjheBF6bhncPAxbVj+4/yhOruri4
	RsFqRaF/Of8W9BKfUfNeS0cjXN8yeJveqJX6KJFG1k8qG6hZWLjbx+/RU6T0B5v0FbWR8ZL65D/
	kx0O4S96zDWmiXQzguAr9q/0o=
X-Google-Smtp-Source: AGHT+IEXc55RGqBKbQMEgoEC9e3feBi0MKsyQiqEKNba7Kuda4jmUF2LBb9/lCW7e1CfbTQzDss9Iw==
X-Received: by 2002:a05:600c:621b:b0:477:fad:acd9 with SMTP id 5b1f17b1804b1-4775ce7dfcfmr49120665e9.34.1762358908612;
        Wed, 05 Nov 2025 08:08:28 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4775cdcc552sm58255715e9.6.2025.11.05.08.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 08:08:28 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>
Subject: [PATCH] RAS/CEC: replace use of system_wq with system_percpu_wq
Date: Wed,  5 Nov 2025 17:08:19 +0100
Message-ID: <20251105160819.302988-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueues a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistency cannot be addressed without refactoring the API.

This patch continues the effort to refactor worqueue APIs, which has begun
with the change introducing new workqueues and a new alloc_workqueue flag:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

Replace system_wq with system_percpu_wq, keeping the old behavior.
The old wq (system_wq) will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/ras/cec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ras/cec.c b/drivers/ras/cec.c
index e440b15fbabc..15f7f043c8ef 100644
--- a/drivers/ras/cec.c
+++ b/drivers/ras/cec.c
@@ -166,7 +166,7 @@ static void cec_mod_work(unsigned long interval)
 	unsigned long iv;
 
 	iv = interval * HZ;
-	mod_delayed_work(system_wq, &cec_work, round_jiffies(iv));
+	mod_delayed_work(system_percpu_wq, &cec_work, round_jiffies(iv));
 }
 
 static void cec_work_fn(struct work_struct *work)
-- 
2.51.1


