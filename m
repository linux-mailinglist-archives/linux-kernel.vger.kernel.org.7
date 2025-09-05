Return-Path: <linux-kernel+bounces-802467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B55CB4529F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA2A0540D64
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122FE307481;
	Fri,  5 Sep 2025 09:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UVVO3r8q"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7896C283145
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063235; cv=none; b=cCBjIZ3klpL68QxsOYWTfUpuZKPEDU9rKWzbGef2tgfghzZcQAGIrVmkAwREzY7N8aujy4p0PzbujC7kuPA4cVcvNiGMSvFZMSSg55n2LgSDeYZ0j8mn+Z1+SfFX3JkUw+W0iUBXr/0IiTPkDeLw5lm3cMi/u0Mn3jddbdG/xSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063235; c=relaxed/simple;
	bh=MxmeDlDN5KAsmLl6RmrOmIHNNJKRzlp34HwIOHi+2Nk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O7UWpjLpStMn7VlYSk+CfXFRunHSGKKgxOBt2MWLLEwZn5YIll3rybTgizUnp9GUk88N0Wjih1LLOtVJTTW+WUDDj4ZOdt7OoWtcGKw0JoAJfNqBxwwQ+yKcr9+pYeVnCW7G4YbczNO60KkiEs26QMHGRe28DHMLZU6X3OjUAaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UVVO3r8q; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45b9a856dc2so12610365e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 02:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757063231; x=1757668031; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yWlMhxr6/JAIt8xHhW6LUxkzXPJaGBgQ29vWEbfPbfw=;
        b=UVVO3r8qLEr+BI6+9Li/6sNjkH0ShAqfTpk9Y1oEFpvX59oIpd56sR7rLOAK9nTiYe
         zsJpRVZlH1nRrtHHFjXMilTVSUHx1qLPjQtL8+KYUkJskekCRlXndtEo2TKtDBHB/5fL
         NSP5QDWCUUPM3p+ufHdJ2JxR2qGWlojLDbWwcLPazSCpjhGXTu94EMXZEqdtQiktDXhU
         RIuKIabUExueLDOo7nNMuWWWfgBtM4LsT7phxpK9lN5xEcqGbeaWXeP94w4l9wfvGckc
         9h5eBoRgEwZev0yMKOPllQ47fYVLl5QW4k4UdcGbtisVNS4ciKcr5Ha7pvVSL4L2mDee
         W4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757063231; x=1757668031;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yWlMhxr6/JAIt8xHhW6LUxkzXPJaGBgQ29vWEbfPbfw=;
        b=befN82dZ5b7m9HM/q3unpWyk8ldqQ2swV0zj4C7k1EK3j36OIwAQ2ExjKWD+q6ydef
         GTYesfHyHdYd/pLjMxdqoLUIlaokzyGYsJMd2WVx9kfdTASrhBKCZh92DJKeulJrclWC
         DN5jvEozsfAhgoAqNK9NkmGRacoxxxQKXUaLVanBGyP9mwgl9Mi/YVauax4LTQJx0D52
         AvVC49NWe0Wj52Y5TWNoSJPkACwPAuq2+GOXqg6DSdioqbevf4EgFfQg+E/A/wE2Dath
         Z1Mk959f97+gHKDJ3Ru0mGmcIy3+rwe8yLA6p4oRgvKzpADIenlLrfqpOpCoplUKWVBz
         nYtQ==
X-Gm-Message-State: AOJu0YxbDFEhWVjV9bbpzobvof/7Dmhc/1gjuGTI8Sss9KTFr9H8dbqb
	B9VkYUzZCB71ugXHJOro5+mtj526BL6cbRK2zqyHkMAu5HAg5y7fi9E8UJUa7nQrcUwtgbF/HTw
	T6R+T
X-Gm-Gg: ASbGncuccPz+xwG3a313TxYX4y4+MdbfT5Rn/uFeC1PwfbcwKdCc3G9TO8kzVNNVTeP
	BoB3BAEmCpXiy/T8sFOcaB/bwedTAegKZA9HDbCj5LJyVEC4hJcClumEMTy4GE3rOBu4Lajxkkv
	83isfQKH0IfDob42XrvWe+s6Eu5ySHP44SVpZsT3y7dr++RNfXrHw9PGWSgnKBZrVQIBFeIMjVF
	RtXQ54oRDHWD1y1mKOx0x0CrJNJzwHgIYuZe+2M5xn+DWot2wm0enYFe9Yt+djhMM+lUHTcOKv7
	rMdPF7ahB1QWHu4wrpPr0hg6pWHRu3tJeP09Viaozgj3v/pVsi7tgB49Xj0GvirVVhMlfEXJUaJ
	1VZ5VZBqlABxNj5YuCOvseM2FIQ9jhcF9+BAjW1aSK1CP7/g=
X-Google-Smtp-Source: AGHT+IED/A3KRrjTPIg3Rfxm4o8Ll0/rnXVSCw4XqZdm4RnIIk+8IMDwa9jZJ8xmaRzlAn5M4IpdMg==
X-Received: by 2002:a05:600c:4f07:b0:45d:d6fc:2509 with SMTP id 5b1f17b1804b1-45ddc189486mr562625e9.6.1757063231266;
        Fri, 05 Sep 2025 02:07:11 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dcfcf3de7sm35952735e9.4.2025.09.05.02.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:07:10 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Sebastian Reichel <sre@kernel.org>
Subject: [PATCH 2/2] power: supply: WQ_PERCPU added to alloc_workqueue users
Date: Fri,  5 Sep 2025 11:06:41 +0200
Message-ID: <20250905090641.106297-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905090641.106297-1-marco.crivellari@suse.com>
References: <20250905090641.106297-1-marco.crivellari@suse.com>
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
---
 drivers/power/supply/ab8500_btemp.c       | 3 ++-
 drivers/power/supply/ipaq_micro_battery.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/ab8500_btemp.c b/drivers/power/supply/ab8500_btemp.c
index b00c84fbc33c..e5202a7b6209 100644
--- a/drivers/power/supply/ab8500_btemp.c
+++ b/drivers/power/supply/ab8500_btemp.c
@@ -667,7 +667,8 @@ static int ab8500_btemp_bind(struct device *dev, struct device *master,
 
 	/* Create a work queue for the btemp */
 	di->btemp_wq =
-		alloc_workqueue("ab8500_btemp_wq", WQ_MEM_RECLAIM, 0);
+		alloc_workqueue("ab8500_btemp_wq", WQ_MEM_RECLAIM | WQ_PERCPU,
+				0);
 	if (di->btemp_wq == NULL) {
 		dev_err(dev, "failed to create work queue\n");
 		return -ENOMEM;
diff --git a/drivers/power/supply/ipaq_micro_battery.c b/drivers/power/supply/ipaq_micro_battery.c
index 7e0568a5353f..ff8573a5ca6d 100644
--- a/drivers/power/supply/ipaq_micro_battery.c
+++ b/drivers/power/supply/ipaq_micro_battery.c
@@ -232,7 +232,8 @@ static int micro_batt_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	mb->micro = dev_get_drvdata(pdev->dev.parent);
-	mb->wq = alloc_workqueue("ipaq-battery-wq", WQ_MEM_RECLAIM, 0);
+	mb->wq = alloc_workqueue("ipaq-battery-wq",
+				 WQ_MEM_RECLAIM | WQ_PERCPU, 0);
 	if (!mb->wq)
 		return -ENOMEM;
 
-- 
2.51.0


