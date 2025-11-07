Return-Path: <linux-kernel+bounces-890686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A82EC40AB9
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 16:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E116F4F1C7A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 15:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A164132ED2C;
	Fri,  7 Nov 2025 15:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OibzYL3B"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E16F32ABCE
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 15:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762530571; cv=none; b=dYtmgIQF1jRXNGM9urVNpjbhLuH+638aU67hu3iH1O0f3HZ3dJs+8YIbp6xOmbRVzUKu/9Zke3dvy1PKkqBfHeBrpj51dI3tsdbFrXMXBytSiwPdC3jJilEk0iT4JPFhqezbtrJYh8okm9tklzYDl2TnlfIVVgiGZKlqHvAyLvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762530571; c=relaxed/simple;
	bh=8Qe5l67vygPXJazkcPWfkfCqsb/KeWBfBeAs0hHVwfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Llzd4RybT+iXEBWOD34Wh8G1ApZTq8L4pMfJQcruaBqOvcCimhiTM7RDh+TooPC27ZP7ao2UxXf6YkItGNIaLgX02vDpcPl322DzpRiuEh1kO3V8/WOcIB5Msf2vQtVa/IZ4ZhXE0VtuZdYmYhFRs9yO/IUPmNHjP2zb9sPu6ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OibzYL3B; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-477619f8ae5so7715005e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 07:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762530567; x=1763135367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X3/wHkVzF7HOlD53dUl3XTlhc18km5IWf6+9u8QQV6U=;
        b=OibzYL3B8L7Eh0snlgBvTLwJMeNwIB8eMX1NQ7Lczfzln/qWc2/OFEu7Qz/YFlJG11
         temleb/JbJILAR4zYUG0OD/lruvyHg9PryN//46Eg5GnzDVg0bquRm15bPfHc0c5YgOF
         WzAbcpZyPmeKZEnC4WWXzYInRgdJi5sERQ1OOzRFuobmDk6mYWupdrbcg4pwBKIui2+d
         nUcSQjFq/aIXfVPMduZE9kZtsmq4npE+IWDMfEUjZtYKOcnxB2qy5hXvSg2LQIfn+eg8
         Gl/qxgg5mrN8vDfr/MSIgNpuXyV3FXQLbWqxfftS0CHfhql5sHe39B3TdzDslvFoO+xv
         WlcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762530567; x=1763135367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X3/wHkVzF7HOlD53dUl3XTlhc18km5IWf6+9u8QQV6U=;
        b=q99c97onKxBaxPeoj+zyhxAbdY4IXjM2MfTbDSuNSX4JEmpcSYIxs1xzUk1Yth5iAU
         r01xKiqv5Ls04x26awEtoSppMsK7pkd89eXH0QN8XhzLa0OXEkBrNj5xUuZ6fuz5REKS
         mFG1r11pRanmersAVAiBU0tWpZHV/GKYYhT76M2rMunh7kLWxUQcPBbGP+2gSjJJEKok
         who2AFT0HMnelJln/dtnt+Yf3sD7L1BmyZPaVJ2+gImfg0T4wzvmmaXSFbGaaqa1RCrP
         f0pf7G+jcSId8gKVrQw/Wxgx0Sna9+oEAxTAepwBuXhybMMQ3/znOHQZOTmEQMRKgC52
         DUTQ==
X-Gm-Message-State: AOJu0Yy66f6GNBeW141wZRsdCRsIZKf5irLzD5d5/y9Eck5CJvEesMWo
	HfIT4p+gcKeWTIYDns6sKVvUErMzlXG3xKwCronHFjFdhkLiCU21BysTEZQ90ZvDDH+5kBTn4JN
	oKYil
X-Gm-Gg: ASbGncsfQM42ZymgUrE/cqjGrlghYfu6XFUw0+7B14XLSe3gSKxqwmcIURwP1qssBnz
	Rrw1flcZgBzytvzulPibIK7PFU4QMfAhBRtDB1RR+0BS/0u5FP3kP1PtfDGuxIcwCcwlB7aT2r3
	0y4bMgMeLB7Utc5jEE+r/jip7E0PP3M9mJ48bndWb+0O0FTgthh/6y6jhQd/Tn8yHsjntKDnjDt
	3aIh5/6cZdNXW/XXCReZGBWk0AGN5eFjy1d1CYEwQlrzR3w+HCfbXMyDV/d/hWtK0Z6zuKi/LDO
	QwyJrhNWsAa8nzq2GGfGK4QdnB7PnCAsqxbxAtMejSbCSuSTdZUoysWBmGNxoP2TEQnrDa0bftB
	6G/gsZNrDEqVHjQSWeMZzHDbAjsiW8Bk33Ioc9uem+XwlEEj6o0Pn1JXhLygm7mtkjFgU7PUXso
	rD2KDP15hiqB9lkOfMVeF4hvTP
X-Google-Smtp-Source: AGHT+IH+t3ILybAlPyFaXUrRQDx8y58mbbGb3fzyHsPfpJT0b7oXiH55FZlJkshBo5S1iuffxBxqQg==
X-Received: by 2002:a05:600c:3515:b0:477:5ccb:e19a with SMTP id 5b1f17b1804b1-4776bcae631mr33761005e9.11.1762530567005;
        Fri, 07 Nov 2025 07:49:27 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42abe62bf40sm5875338f8f.9.2025.11.07.07.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 07:49:26 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	David Hildenbrand <david@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio Perez <eperezma@redhat.com>
Subject: [PATCH 2/2] vduse: add WQ_PERCPU to alloc_workqueue users
Date: Fri,  7 Nov 2025 16:49:17 +0100
Message-ID: <20251107154917.313090-3-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251107154917.313090-1-marco.crivellari@suse.com>
References: <20251107154917.313090-1-marco.crivellari@suse.com>
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
 drivers/vdpa/vdpa_user/vduse_dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
index e7bced0b5542..ae357d014564 100644
--- a/drivers/vdpa/vdpa_user/vduse_dev.c
+++ b/drivers/vdpa/vdpa_user/vduse_dev.c
@@ -2173,7 +2173,8 @@ static int vduse_init(void)
 	if (!vduse_irq_wq)
 		goto err_wq;
 
-	vduse_irq_bound_wq = alloc_workqueue("vduse-irq-bound", WQ_HIGHPRI, 0);
+	vduse_irq_bound_wq = alloc_workqueue("vduse-irq-bound",
+					     WQ_HIGHPRI | WQ_PERCPU, 0);
 	if (!vduse_irq_bound_wq)
 		goto err_bound_wq;
 
-- 
2.51.1


