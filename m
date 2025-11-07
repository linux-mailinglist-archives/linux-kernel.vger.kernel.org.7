Return-Path: <linux-kernel+bounces-890671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE0BC40A11
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 16:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 22EAA4ECCC4
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 15:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB00F32ED3C;
	Fri,  7 Nov 2025 15:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ezEn+KTn"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1199E32C326
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 15:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762529871; cv=none; b=RAnveP3ld3KfwgqeGWTvt2O8AL6x5lJyobzcoExS2+Ou7FEi1afjw9s2ID82u4DrMD8RJxMm+kbCHUAsOnb7HRYyzuJyWQIyjVGx9ntkQ/ukyGV0TQpzqNMiWx0wGJAy4YShzqcXqLqfy6yLjX49w6zhd8TxD/kRf1QkbmFA78Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762529871; c=relaxed/simple;
	bh=mPQ47w/zAfUpHgqm7tWAUuazXErGJ2t+HqxJi7cN+Fg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dh+y8kKtsMx3S0HRe64riKDRdjhrN25D46lxmkVCpUxHN3u2MJcP3TffG/BzmAd4DrW8d+lzROscNfWRUPuMUhPEYk06aC4MLA36ULyNEyMDNb2LXNr8F3g9voG9IsP0rS1e+XS5iLln0pRNkBLQWxaFsmRNrblIajufxNefFQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ezEn+KTn; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3ece1102998so531229f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 07:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762529867; x=1763134667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PYlVzA960q272CsXQuy54o8lCSBlxUjmuT/lBHNgOu0=;
        b=ezEn+KTnrLfYk6W8nBbaH8irxEiQ4o7zODZvHGZA+tAz4t/t9MdtHGXrkHZTK33J3S
         +UHv4DrpkZJMNS1wQtKyC+RVS2aA1i3WhQNrpSuo0sc0t2vNVowO/+4CT9IaEjJkZD8p
         yvBxOYYPAuC5lh1dCjW5WP9JIC27eMJr1cUbOigH8riPjmRBM2gyX+2MCRPs+E4nKKsc
         xqnckn9dQIo3d7lCU6PqrkUX616tEAZ642cvDUPhufCIGXFQ7i4QFKaQJt32ZsBuNmDz
         CCC+1M7T+Wk1qqC0h8wNAgEjAUBkMCrBHTmAyxFaGuDgJnLLWhC1eDV8vP8awBJq+TU5
         /yvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762529867; x=1763134667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PYlVzA960q272CsXQuy54o8lCSBlxUjmuT/lBHNgOu0=;
        b=R1qUjl76j6Qd6oaIORBDAFNxhXfeKzYkZwXKOy65QP+RxATIvZKKJ6/DN8G06rk7A0
         ePlcGjAp7O4esNqN0lqWd7OPjK0Zli/8oN5vtxB8gq9PlzvsMC2R2N9ryw4mQbA5ALDo
         1aDnw39Bw1RxgkGkD8NbmFp84UZTTSyLvWYjnrqIJIw7cLeh5Eh6+RpYAUOAcPyy8aAV
         xJPpcw0eSPF/OS4ugFiGPPw11rthrkrY+mdaVW1psDk+9L2mx/fKqxgrrESz66r/c8rA
         1UgL9VRxixyuuTWZO5tPZRoKnK1AkKvBxQQ2c5AFCloNLYLlKjJsADxo9IaG2sKp1yLl
         j1Iw==
X-Gm-Message-State: AOJu0Yw2Xd0VfBjSaBhfbvlpUnIJanOKpPaGHJcsngMvaC6kDR/uT5tr
	l0NpdzWNHx3oOgRJt3Pqa1p6rJ3ww7HWPDCENp9vqY27/yMUM1ZmFreni+lS90TkO+v4C7fuFlz
	0E6Ia
X-Gm-Gg: ASbGncs/zgqCIJajsbURZncE7WKemXfPPPPrUl0AEh8TTx59pVHWGeHBil4arsdwb18
	XaIiY2aaDKb8zXnxs9nVe77dH+lNEPN5AmVI923B2JF8EURuWgJt8OfBxLEwt3/nMXIB3wPYY5j
	8rIhjHMmSYf62Jr7DiF24V/G+iyAkEilIB6LFzDWuOTzUWoOpdAD6HdEn0Q3YT5KDIZ+b/SeoOI
	HjxfAkCaegZCcBuKcVKROf+5CpLooVRZ2XLCe4MWZVIsHflC93uYSfrXoa7+OvKpV+s+xJGo8K3
	kWGsQN5jIy5dckL9QzvVxvYMCCoEvsoy96QmPKBsAumvK4FhH1kNj7jDZoJCcWjNvDGaAqGNjpC
	RzNtSbRD6QuIQm3ub6ELT8cOq7SN2qwfZsD+nFLleTK6EjZTC8S3m8n6e/ICzFmD9jgm/RWN9sk
	DnB1NpdIxMw/lzrZEaXqAhPHPQ
X-Google-Smtp-Source: AGHT+IGYhcS+M6tSBMjY0Hp3kRBjPTX80aXF3ObfGQ195hEhJg3fYy/Wcot1z8cXfnMCDUR5aSHR2A==
X-Received: by 2002:a05:6000:612:b0:427:167:c2ce with SMTP id ffacd0b85a97d-42ae5adcbabmr3068885f8f.42.1762529867007;
        Fri, 07 Nov 2025 07:37:47 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42ac67845ccsm5763460f8f.36.2025.11.07.07.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 07:37:46 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 2/2] usb: typec: anx7411: add WQ_PERCPU to alloc_workqueue users
Date: Fri,  7 Nov 2025 16:37:31 +0100
Message-ID: <20251107153737.301413-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251107153737.301413-1-marco.crivellari@suse.com>
References: <20251107153737.301413-1-marco.crivellari@suse.com>
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

Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/usb/typec/anx7411.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/typec/anx7411.c b/drivers/usb/typec/anx7411.c
index 0ae0a5ee3fae..2e8ae1d2faf9 100644
--- a/drivers/usb/typec/anx7411.c
+++ b/drivers/usb/typec/anx7411.c
@@ -1516,8 +1516,7 @@ static int anx7411_i2c_probe(struct i2c_client *client)
 
 	INIT_WORK(&plat->work, anx7411_work_func);
 	plat->workqueue = alloc_workqueue("anx7411_work",
-					  WQ_FREEZABLE |
-					  WQ_MEM_RECLAIM,
+					  WQ_FREEZABLE | WQ_MEM_RECLAIM | WQ_PERCPU,
 					  1);
 	if (!plat->workqueue) {
 		dev_err(dev, "fail to create work queue\n");
-- 
2.51.1


