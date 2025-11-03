Return-Path: <linux-kernel+bounces-883290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD17EC2D1E0
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 17:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F8A346067F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 15:58:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6EA315769;
	Mon,  3 Nov 2025 15:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="c4ZvuE69"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B459314B63
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 15:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762185488; cv=none; b=HxdkDx+khyooKJ/DcjSOmtxU0qhWM9h4Y6abSs9usluHG/wJDS4FddAoQ2RVNSNRwsj0aL/efD+qqWul6FNfvhWGik3P1KrWCtkcy2H+Z/N9v9gz+XwPvyx1nRpLEUjZfreNfkAex1Uqr9EAeTImgF8A8I2REkFLK2liKEnyJ8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762185488; c=relaxed/simple;
	bh=8YVUywM21dbkborn+DsilvP0uwi+I7SyeQftBZ/y/9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cCb/F1/9xwc5UmEnCnEQAPXiMzKtB4Eb1Q1vrazRVV/yFnh+X9hBrGvaH5FoybDnIIyhXbiFWY2pv3DQkPj6BMuW63cka6IDauIjms5QtOsw0EhKSm0o6dK/EeG5/kNys9s0oH2fbvtF+CU27ohboF7d+Y3w/sIHroS3x0/tDAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=c4ZvuE69; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-475d9de970eso30884375e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 07:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762185482; x=1762790282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ks3pir6UgwzDtWvI5xfb6btd0LOWX1yOz6qXljAdndA=;
        b=c4ZvuE69SKuyACWhHfjvinaiiJtKGHr9Cy2E1ejx2VqBa8XFyj6u2Koy/l6Bxma3mA
         pQYrVoPZ/UPk81IVoSIQjWML3ZuPbbcjd6a1DUuiHiY3M//yxyAcTDmejW+b8mCMxkUv
         ZGNjbtlTAD6ml1+q6RCnY3TagRhzN2iZrCfkb5hwD/8WwicRVbcHJQWLA2KOzKzKdM+6
         fDx0vWtQ8C3T8hprnB8rL1hbEhlGE8zZLl1K/u4nUu8YyJM/aHRl9RsKUwCanCDyDbVD
         GYbs4KmxiXNysOTqx0GMZpqNFqSmlopu/kS9n/YyXP+V2NVIMWfMwKjKuwhjrOa4zmMR
         FtqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762185482; x=1762790282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ks3pir6UgwzDtWvI5xfb6btd0LOWX1yOz6qXljAdndA=;
        b=JdkHZzwrKmFXe2/ogv9O0Bz/h0s2LaNvb83aR8PK9oeezEByPtcZr7intm5iFFN6dJ
         HUki0PBJujeoYKBFPMTf+zXXH2TRGOSxH72GKujt5uPw8IFic0VSjgj39vvroHJQ5nyK
         G02ZCZIdb9tPbi8nxETzvl6JwVm6qCJ+/dMvIFncu0cybSQvGeHqLGGk4vfSfrUDssnQ
         RFfyFuVjz9xOA9cGsxjFOF52l5I7XyeJlN8Q3LrfQfc3CV1bA64GDVaTIy/V9OE/RJHD
         1E+0HGK854n6ZK0BY6u22+AJRVTE/g70wTL59iJwMWBYHbdwiyWTIzHG8kOv0VKIToPA
         o7IQ==
X-Gm-Message-State: AOJu0YxHY4V3aY5JTVQCKfW6srZ7UDAUdX8ZLh5W+W7H3ZwhZQAvVzbC
	fmPexn4rtKW2zg8pOa7wXM8zG8cFL9hPuH1oWeILJXx3tWOkol3zEc6/20I95lrwigYp3MlWOWs
	dBIlo
X-Gm-Gg: ASbGncssYKjDospt3+FNBR5k225tMwOohO51MsINm9vr/hICZvmtVyXJb7EIYgiYUxy
	iFy9M/kDoMYFI4IwCCmhtkLMWaFFTa1Eba+oIxJTUJp4OOBcUSQYDu2pqXs5mD6RMXKbggL/smo
	EdzgSEkcjQtYqrf0M61zXLpk+k9pi+YVlRDvNNEfWmbwPHjkphMo90rnLsYvrL8rq6gwDNBlTgA
	P+Yqciv3PCdWTRVDyXCKxF/J0kQ1jPmClepN0JymZRDqX4kvgvJoI9gCu/RgDVDVHmkgC5fKsUi
	xp5Vu7YiKTKGFUpvzbOOmvmDrok1BifK+uKyz1pm3Q1e2AopRSgRsrqQz2Bjnns6rOolLZxJR2J
	68TduXuNDg/InyVuTM4RhqWZKcmKjUFB1Wx2KJUH+Dat6Yoq+qsykqrFU+8U35vrbNHTs/S/Qee
	pwPtO0AOubB0oZoYf+4fX5yi5ljutW1TJZJHA=
X-Google-Smtp-Source: AGHT+IH2AwkZW9XycQosIy4+zjrxvNZTD/pU4xDf9vZ24FbI7K8D4vqtE4qlKSR3Kfp8+HSpcK7r0w==
X-Received: by 2002:a05:600c:3548:b0:471:16b1:b824 with SMTP id 5b1f17b1804b1-4773088be8bmr151144365e9.28.1762185482402;
        Mon, 03 Nov 2025 07:58:02 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47754adcd08sm48245e9.5.2025.11.03.07.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 07:58:02 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian Konig <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Philip Yang <yangp@amd.com>
Subject: [PATCH v2 3/4] amd/amdkfd: add WQ_UNBOUND to alloc_workqueue users
Date: Mon,  3 Nov 2025 16:57:39 +0100
Message-ID: <20251103155740.250398-4-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251103155740.250398-1-marco.crivellari@suse.com>
References: <20251103155740.250398-1-marco.crivellari@suse.com>
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

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

Because of that, add WQ_UNBOUND to alloc_workqueue users to make sure
they are unbound.

The above change introduced in the Workqueue API has been introduced by:

commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index ddfe30c13e9d..a41ebf257756 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -690,7 +690,8 @@ void kfd_procfs_del_queue(struct queue *q)
 int kfd_process_create_wq(void)
 {
 	if (!kfd_process_wq)
-		kfd_process_wq = alloc_workqueue("kfd_process_wq", 0, 0);
+		kfd_process_wq = alloc_workqueue("kfd_process_wq", WQ_UNBOUND,
+						 0);
 	if (!kfd_restore_wq)
 		kfd_restore_wq = alloc_ordered_workqueue("kfd_restore_wq",
 							 WQ_FREEZABLE);
-- 
2.51.1


