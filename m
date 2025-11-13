Return-Path: <linux-kernel+bounces-899792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DE0C59188
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 18:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 96A344EC352
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Nov 2025 16:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 393003624B1;
	Thu, 13 Nov 2025 16:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="O0D4aLIf"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D881320A01
	for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 16:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763050845; cv=none; b=OQLjjA6fIK7XGWC2MjM3x1L9rVpkwNIaySHVXA89aE8U+pGpF4d2q7N9qMV6QL996p6zhExC1oLqItWEPyvmLB7QqHHBngtdaA8/NaBG5fwLrOxqYKkSNmhjXHFaRNn4Z8GD8BXBHrN7xq92z40+bS5XxXHW0wVjPjdhrxQsQ0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763050845; c=relaxed/simple;
	bh=i6/Tdijqg6TUvObXhkp4KVAh++KkLe0kXSMy/xdGERI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ldBte/+FWggQrp9xAdGbeazaoHijlzWY/qxfwjGjWhOxwUEX4ZiiuuSdcFKu9U5WVnxVzcq3eTpqYZfjti9oRUTq1RisWV2eCcf9zV0omiEtDF65Hg324vdRchx9z0P40AVEo71GjUH9hLfyTsNVW/OZT2oNbIFnGY5IG6L0QLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=O0D4aLIf; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-42b3d4d9ca6so924357f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Nov 2025 08:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1763050841; x=1763655641; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3hl8tY1RLv+K2+Ox9WrDl4hIf6rzuWKqmNX1UuS7YY=;
        b=O0D4aLIf/UaQdPm2VCJAXRIL3cu/2OQn1lBmnglCQiivVKn623jASzoRhAxXBGGMGt
         7uwOtFnZi3oqqyp8TZBXA7Qb2v1DmhUZfM2JZgitJpg+CTnJjx/T2jXJWq1wRaBlOJls
         SkNAjfIB7eJADfmw5PfJCuOv3C4wQg+fX28zdnKj+IbPebSq//hH0txTuVzfsupV2JT5
         z6cDFPsLuUBNwB8PoIzZrdTe+c6eL2/Jfc24gqXJaCG4dziObjnePAXf7PWeV6VrxI4C
         lrsSTJv/ZJz9E2mPXJSPZ/D273+bUGv+7HpKXfR4xEJ40tQ5zd80TcpJbV56/9iJ0uyd
         vzRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763050841; x=1763655641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m3hl8tY1RLv+K2+Ox9WrDl4hIf6rzuWKqmNX1UuS7YY=;
        b=sqzC6XdYqwYdSvMd7iuVu7Li4iQRSzt0sj9BLvS6OYhpQCCutFfaWXeFBQKL7S3OQu
         f9gjUOzP9hoOkgJxk+cLE562S5V7kn8aeksL+T554MQZ66YAE8Sq5i/gtO4KobNU76Vi
         0RZCzHDXf5VshcxH8ipw6Xyy+Lsge2UX6+razffxpb7CLDKndgOxsUDucXOqial2Yt68
         hYE7NRpVy6R/PmipdUb9A0rujvNlPtkXnRbMgR/z1oY0RRkwh0jyIBLEmR4d71lbcM+v
         eUtYhSwUXKVaO4DBS6Um3Xq0ZIz80xNNEdKKBsYr53DW7w7I8G0TNWmHLYzP6E5h6eyG
         B/vA==
X-Gm-Message-State: AOJu0Yzz+ZgW1x0A+lMLb150Anc/iJxUSBTWQ69gTBtS4Fh6yZTAdgsU
	sSwPkj6nbSDINOoNoPWtr7jRSveMS3Qw89vpINociPT83ydvh2oMVEYkgqbvZ/PwgMWa85cuFEy
	IdBcJ
X-Gm-Gg: ASbGncs9ZMtH9yRfsIN8XtaBnuZrnw+PPYQxl40GXIO+SSyIRxfeK0pVkLQlKOgmSwd
	uJqQNj1oy6lp2yRUe91i0dz6LcGakhY3kmbHffBgPrQsq8a4AUdhAgACVlDu+C+DlzLBWHwFKJj
	Awu2APU1MGEa33ns9+aTy4Mjdk+ZczFSvdwXlyPjUmQzvWAi0f5NBH7wR2xFpHnvX2bNUNas6yd
	jRohBNeRAGM3E8R0KNInSpsgmkmdYEs1J10V7U8Q3qNP3ftAubS8JZ8WsC41bK5pFnskQT9TAkK
	0tJKMKb+BpnwNlAoq1Or7WH519XB1NdeK+iZNpCppXwNsKJwQczHO/prNB4HWDrlZ5PTLJZeRXY
	f716c0a1vp6yDBqXot2/VUphdJxRDHYRBai/ftKW+k2GI/qkBnvw/Ue52qbplvG8Uhf7BKUTAR1
	NNrQV+M3z+OxGTKOMDHAQp0/Fn
X-Google-Smtp-Source: AGHT+IEH+HU7u61di1BKdqfvk0CUEv39L7QRlysFz6Oai91cpdnHTr8tvifetLi7Z4ylnUEyUxZNew==
X-Received: by 2002:a05:6000:2489:b0:429:c851:69b8 with SMTP id ffacd0b85a97d-42b4bda848amr6728334f8f.31.1763050841497;
        Thu, 13 Nov 2025 08:20:41 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f203afsm4680578f8f.39.2025.11.13.08.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:20:41 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 2/3] cw1200: add WQ_PERCPU to alloc_workqueue users
Date: Thu, 13 Nov 2025 17:20:31 +0100
Message-ID: <20251113162032.394804-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251113162032.394804-1-marco.crivellari@suse.com>
References: <20251113162032.394804-1-marco.crivellari@suse.com>
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
For more details see the Link tag below.

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
Link: https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
---
 drivers/net/wireless/st/cw1200/bh.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/st/cw1200/bh.c b/drivers/net/wireless/st/cw1200/bh.c
index 3b4ded2ac801..bdf7132c5849 100644
--- a/drivers/net/wireless/st/cw1200/bh.c
+++ b/drivers/net/wireless/st/cw1200/bh.c
@@ -54,8 +54,9 @@ int cw1200_register_bh(struct cw1200_common *priv)
 	int err = 0;
 	/* Realtime workqueue */
 	priv->bh_workqueue = alloc_workqueue("cw1200_bh",
-				WQ_MEM_RECLAIM | WQ_HIGHPRI
-				| WQ_CPU_INTENSIVE, 1);
+				WQ_MEM_RECLAIM | WQ_HIGHPRI |
+				WQ_CPU_INTENSIVE | WQ_PERCPU,
+				1);
 
 	if (!priv->bh_workqueue)
 		return -ENOMEM;
-- 
2.51.1


