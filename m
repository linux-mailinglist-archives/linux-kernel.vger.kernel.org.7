Return-Path: <linux-kernel+bounces-890675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E18DC40A4D
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 16:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0743422B2D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 15:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C3032E15B;
	Fri,  7 Nov 2025 15:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="I0ZDTvDd"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A5232D0DA
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 15:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762530169; cv=none; b=oHwP3WZh7nn1jX7AvNuKuWNF6KfqI0KkpoJ2O7BqkC4j9clIevVd7LiAmFPylbk9aGlO0foOtaoBOnbP/eym1M17d/csbqRTPKHmU43BMyYUD21xl1O77V8MbasAg8Da6UytLhrnmfU6A4h3CP9Zzj4LBM8zRpMCfdGCwTQ+qGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762530169; c=relaxed/simple;
	bh=FllVlbWS4MtLkyQNg1oOoXS8Gv/IymNyRvTVHqi2Ks4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LBhXYSaHrT4dqBv/C5scUMh8S3ZPu64825XGLkQMX1pIIYup3mMhwo/SraCqrvbhr6tMzSz7YcMfEkzZmbYb1OEe9wXq2vlyiA7OnUIoqNyqT0crOuRn1WuKXwjIdswcEFQfp4XiBOs66a0AR3PeQcjhmT7BdVemISxu7URghTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=I0ZDTvDd; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-421851bca51so698262f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 07:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762530166; x=1763134966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EEllDksTQmdd3u8PyFwFKXQ1ssazmQ/lfWRUKOA18nI=;
        b=I0ZDTvDdZasUnpUiGcBtTCkw79yxoN3lP8jisbYQfWrYhOBDmOe/+DqiwXEnCjT/Fr
         Ywj9Goc3m1tMGbX4CVGUqlPGakpxl/HCS/j48ZgWsMLSwmytZadPTVXS5sVlUpIpF1oU
         hSLaPwvoea5DKYZ8sAo6rhB7DqsVkekaLWkDYR2wmanaG0RcsnADWO6IpBGnFpAr6kLJ
         1x1+/4Cj1OxmgOCxkPA5vJX7OlGY2xrHDWHzcKfX2RLk9yjr03eFVqF0m0ZHm+nwa3Si
         L7ovxpYUW5Lc5BnUrxWNxLr4STTrrk7YkDtVCShjcFG/XzS6aCWpyd80dvr/SeYpB9Gc
         HqSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762530166; x=1763134966;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EEllDksTQmdd3u8PyFwFKXQ1ssazmQ/lfWRUKOA18nI=;
        b=bUQVUnhvWlMDez9aBkFuVo6H/ZyXuL/8k/N2JjWUTScW9TTqI40WD25MTux8qLm7q2
         UcKPscRNtXEUm/8CN3Ohvt5t5Zp42uRiSstlP8fiw57mxrmYcrR24jNwOJBp4JcwYLW0
         6VgR/V8/bb4Zj+uJBKptWmCEtXFppXKsI/UaOPhTdXo0Tn3HfnR0akHKeNwUEDFXMSp4
         iXjnFT4K1kh0/FZ/GBQ++8+lq7spVGqp7rWC4lyt8xSEtrqo6n74j9HQXDciwnB2fMay
         C6kBfwwAIZjIB7shJt5cfd5w92q8FOWz1d0+RZfFc3dLWkMO97Lc+lBFW7a+F3pHyHsN
         2+AA==
X-Gm-Message-State: AOJu0Yxc7S8ftFF6WIrWXttjQfJZfmLB4yunMyQ5OTtrJ/Z5sKRY1vT9
	J2vwjK27NnOBTGBYlhdMHANZGVR+FpUZAVb2t8iPXonW3aMTa8+uMIBYbM6plZq2wSparZ+1kuB
	mR8r1
X-Gm-Gg: ASbGncubUmvYo1ZQDgvWBeqIT9b6glC+QAUfMU6MPbTbdLFTShK6kLx7bHSm0KlUD6O
	MEn1GceZmO8vOCHxumLJM1v4lKiRGo2opznMI0p5n7q86A7mFNIAJbZkneWHRQCajmjrkpb44Z3
	x/EoxC973DSN+DfPolgWBkTe1olwJFRwq1jOksMIFnVOHBzrKVIJiKrAcq9eRVp3xOGCYPNOD6s
	JDtvES7Csu0WKWEKYDpPfTvNzmhApKAXEJzobIWSvnVzQwEMHyHA0lStzkRtR2jJrMN9U7A4bfe
	LrjP1r5fpSfsHZ82BhIbO8R2UCtEhJf3TnztC04TffugiwCti0wVY/EcCyTBTcfHeay0/3LBXLL
	igT6vqYdkPHhIYu7oaHWi+iCszI7Fj7TIGki2RhakOpXQk6Dq/bKdJL3yKWHBFWZx90PBpM5ihI
	j1FSPpYd/VnNmc7h83uYIvl+OqrCY4PPpp5Zc=
X-Google-Smtp-Source: AGHT+IFBda1EcsHmddpDO9LOEIIrlJYCTDL5Rlz+CdU/5vjVJjQIDVH1r/dzDG/W3yb8c7vMr4OskA==
X-Received: by 2002:a05:6000:1867:b0:429:d19f:d922 with SMTP id ffacd0b85a97d-42adc6895b6mr3593700f8f.11.1762530165930;
        Fri, 07 Nov 2025 07:42:45 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac67921c3sm6213783f8f.40.2025.11.07.07.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 07:42:45 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Oliver Neukum <oneukum@suse.com>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH] usb: uas: add WQ_PERCPU to alloc_workqueue users
Date: Fri,  7 Nov 2025 16:42:36 +0100
Message-ID: <20251107154236.306620-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently if a user enqueues a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.
This lack of consistency cannot be addressed without refactoring the API.

alloc_workqueue() treats all queues as per-CPU by default, while unbound
workqueues must opt-in via WQ_UNBOUND.

This default is suboptimal: most workloads benefit from unbound queues,
allowing the scheduler to place worker threads where they’re needed and
reducing noise when CPUs are isolated.

This continues the effort to refactor workqueue APIs, which began with
the introduction of new workqueues and a new alloc_workqueue flag in:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

This change adds a new WQ_PERCPU flag to explicitly request
alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/usb/storage/uas.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/storage/uas.c b/drivers/usb/storage/uas.c
index 4ed0dc19afe0..0657f5f7a51f 100644
--- a/drivers/usb/storage/uas.c
+++ b/drivers/usb/storage/uas.c
@@ -1265,7 +1265,7 @@ static int __init uas_init(void)
 {
 	int rv;
 
-	workqueue = alloc_workqueue("uas", WQ_MEM_RECLAIM, 0);
+	workqueue = alloc_workqueue("uas", WQ_MEM_RECLAIM | WQ_PERCPU, 0);
 	if (!workqueue)
 		return -ENOMEM;
 
-- 
2.51.1


