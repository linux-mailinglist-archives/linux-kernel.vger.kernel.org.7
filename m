Return-Path: <linux-kernel+bounces-821194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C125B80B10
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A6611C27195
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E4133FC68;
	Wed, 17 Sep 2025 15:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DP25JFl0"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E31F33DC6F
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 15:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758123550; cv=none; b=KpT0CIFOFqjHV78cZUc0YDAovCHnApYFYUhyOWNncJyDX+av3hIRa2zc1s7Y8CxeD1xNKzlICRa/694bTDdy+/62+DzdegOD+ffmAFOsfDEQxwaT0xQyyHyVxUr272TNXejtMlZlYL6YWkDfTvT5fdq992BZClDWogf/F5SJwec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758123550; c=relaxed/simple;
	bh=14dVJh5LLNSsQMouLJW1+odXPDO7vGIGVZX71yzalWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=meOe8Wy1s0z+tlQ+Tw32QY6iNIHYzF3W/q7P9/Mtn6F8xIy4NRc7DfR8cm2gwJBEbv7hOLvVuYti61LY1V62HLLM0ohw5srToDusJcvVfZ/prSdT3fU0yhxbWUK26H3eHMvV0l14Lfpwms5ftdtc8y7/aW3kjkpAwehIQ+QBI6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DP25JFl0; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3e9ca387425so3018693f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 08:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758123546; x=1758728346; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQMKJhlNsyXsN8hraKIynod7eK47kKIO6zJUMqoMyYI=;
        b=DP25JFl0GhaujR0ef+QtDtj+AJw8+Lk+PtA4NmIkvMxRsb8Yue60XPCpZIndaWxa9U
         mBF3mCXcS+rJJ43BIZtPGBxC+Of/RwL/oaZhcVvL0xXxNMk+81sI59vbgpdklRF4EOof
         P2Bs5M/7mQyb+J/U4jSgqNx+yWuL5mqKgmgZc++ksKsV5GOSpw+jIzgtzlhORlYSXS6b
         eHFZMFCFeFSjJfoliz0f4qoZFxRyo2bMcsziV60RcXWjmH2Z8L72IBCLVOVWiaE1bV9L
         Oa2+VitzT7cpGustpDCKVRtW46CsugVxW/MWn8BDm8EPI/dXFUMzHaFgOAbN+RYxS0N2
         xizQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758123546; x=1758728346;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UQMKJhlNsyXsN8hraKIynod7eK47kKIO6zJUMqoMyYI=;
        b=IgtHjP0zP2GfdcInSAIDZs4f/UIVu69PCxtS/s8jgXgWWCzROTabe2rxieH4/xa075
         GQiFephTxV9n7nhJASSQGQhm94SST/m1YJh3s6BF/DYQHakW6eKm48lqt+hpvAWz8WyF
         f11eF3fMzEY+A5JrrlQg1kFXfzQ8Te6dBeJatofupfqciktD/TUDqSOTe1xBzy88AIwc
         7Y5fwBFrZot/ofRlb9jGSgINYE+y1su0LD+k+c8AaaYJD66Fc3aTMihl/9ygnlrsPBEV
         P7j8i1xQ60P2CST/lRsK56HG4yRybW1PQVnklRHYLi+6ZBhZUDiqRj6gffFC9zVm2v9T
         x2pQ==
X-Gm-Message-State: AOJu0YwkRmfoJW98D2ePgaI08qemC9kzEv/fI9YenBEiDmgeGMvNA+fE
	1/uGbIsw8ny7fxvT20zUVI1iNHm3JQ7Atrod1dl850ogbfWQNFhIy7J2SFuf4WZCSaQTeZIfVAF
	yuPO2eg0=
X-Gm-Gg: ASbGncsyx/4uhNe2DqJ6qhiRj/gAHjsqgm8M9yKUScHjnXXNp4CS2MoWUOgywyk/bqZ
	xfZRxll7XRcLVR0whUvC+0bGO1APRacf6666AbQCRdYQ/QIFpEoZzW3dFrKJjDx8NljFS7jvoI+
	UL6EusAZ9F8JkAK+pzdyWNiCZ7m8Bm9wbDlk+olOxsvZDBqWyc16XazwDVzxNLUGpTAxkvMqZhr
	H0MSKTZsRVP0GhI04OWoJShwMElgkkjwrZYPBpFwVkUj08l9Wa0PDjLr970SDvnrRBON0ai280F
	Q41ssgoklxeGwADsh5lOP19+XNRc9q/8EMAzYYPVSW+zluhyPIoc7P1nZEnc8WgAbEHCuatTalb
	AbdJ49rx1utIwMdmJ9ufuXeBVigXLCUpVvoSdWeljwE7Yzvg=
X-Google-Smtp-Source: AGHT+IExlJvr1s8wpdqGiMxNMltp++fzMVipn3Ukanng0vmVWhtAsTfmNFFfXT3S2vlwQa79qdLk8w==
X-Received: by 2002:a05:6000:400c:b0:3e3:4863:5dfa with SMTP id ffacd0b85a97d-3ecdf9aeeddmr2127444f8f.1.1758123546212;
        Wed, 17 Sep 2025 08:39:06 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e774a3fb5bsm23208319f8f.58.2025.09.17.08.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 08:39:05 -0700 (PDT)
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
Subject: [PATCH v2 1/3] drivers/s390: WQ_PERCPU added to alloc_workqueue users
Date: Wed, 17 Sep 2025 17:38:57 +0200
Message-ID: <20250917153859.363593-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250917153859.363593-1-marco.crivellari@suse.com>
References: <20250917153859.363593-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.
This lack of consistentcy cannot be addressed without refactoring the API.

alloc_workqueue() treats all queues as per-CPU by default, while unbound
workqueues must opt-in via WQ_UNBOUND.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This patch adds a new WQ_PERCPU flag to explicitly request the use of
the per-CPU behavior. Both flags coexist for one release cycle to allow
callers to transition their calls.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

All existing users have been updated accordingly.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>
---
 drivers/s390/char/tape_3590.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/char/tape_3590.c b/drivers/s390/char/tape_3590.c
index a1bafaf73f87..2a2931d303cb 100644
--- a/drivers/s390/char/tape_3590.c
+++ b/drivers/s390/char/tape_3590.c
@@ -1671,7 +1671,7 @@ tape_3590_init(void)
 
 	DBF_EVENT(3, "3590 init\n");
 
-	tape_3590_wq = alloc_workqueue("tape_3590", 0, 0);
+	tape_3590_wq = alloc_workqueue("tape_3590", WQ_PERCPU, 0);
 	if (!tape_3590_wq)
 		return -ENOMEM;
 
-- 
2.51.0


