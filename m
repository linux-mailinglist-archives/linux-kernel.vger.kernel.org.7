Return-Path: <linux-kernel+bounces-886265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CE0C351D8
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 11:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58E393B67C0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 10:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BCD3054C7;
	Wed,  5 Nov 2025 10:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KI2Cqd/w"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91965303CA8
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 10:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762338937; cv=none; b=iyojtPPM1RfwRlcSkbkVgSVzmdKNbMlt2IQL2+iQswHpenbivAj08haVjsqqs3XF8RvzzkO453szqL4/DNE6oqNBytcn/Wc3Y1UeqQhv/HvOWvsWzsf860Fl+n4Ji9mJBae9aQfkM2UJnQPw9EI2FAybSq5Xcgg1RFKglzrk6Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762338937; c=relaxed/simple;
	bh=yqbu7b7MWh+o9G4RkgUwppR85QBaqUy6TOfNzXk7g4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ijXDR3tG9SFQCNcLolEgcoHhK6VJEQgQgLgmMw2RFAZUK+e0+g9vDoLOphjleOKVd1u/Mf5iJUqmjgs1TGwzZmbxeFnGXDpDRMchVvYuueNQG7TfqMGOjuLLAtK8onauXiyq/zSYLFsLekBVwG7J5GDcKOwCzUVGMIS8iskmAkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KI2Cqd/w; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-470ffbf2150so3249085e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 02:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762338933; x=1762943733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j924HG2Q+xtogTUybUu3y/yj+19EIdBYoNF5wDoWcHc=;
        b=KI2Cqd/w9eLdSC7Vq6fKTyqZnuue2jzTiLr71lm45805vn+q+Ua4XPvLZYAkypRQ4v
         K92twBFNiNf2gBI/b59Ku6q7/ddTiptHL3wUTFoGIZkGUcEEapEgPcsxBOyVS7RAnLjZ
         M46/EhmeafMVpYigoC7hEKhiSi0M4H47WkduKrugWDO3uCszIZBX/xIHDHZ+G6dxqeYy
         ZEOTJtWuN1Am+Ac7xvhb6/CYV76If1VxruFKwPUzcSHWaaPz6dA8WugUDj7LXCH1j32x
         chY54WoLnJI8cQ2pwQRDSEg8Kkrf7FE5h/HaK9TSogC4R19atRuWEUa2HprKltJySja3
         mbIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762338933; x=1762943733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j924HG2Q+xtogTUybUu3y/yj+19EIdBYoNF5wDoWcHc=;
        b=ae33bOsifdxymAKsauLarOJadLmfAqNIgj+sVvnlXcUk6LaWxZId7rPZlRx63ZAJTZ
         /nDBwcXrLjFY4/6g1jU1DBdgvqp6PvG35oX1G6ZDPwExbnQVvRSc3Xk0cCr35yUTjnSk
         hMBHwKboknzKYLxnHYx1fMWnBbx3lmtvhXYqAWJjH/50/stLvtZdvCR8A/v7KJjOObN/
         ACUULAi3vSt7bdzR/nopy/wdpARfH3ZTkwdvq2YsMsEN5ssOQpSKPssg3juVDBXI/sC5
         xyXw+gU7R/V/dncBfmZGHGn/cXW2U/PEHCQbItLx48JFMmIJ8lhSjWIsE8lySm4iTQwG
         ZGwQ==
X-Gm-Message-State: AOJu0YxoB924XKZ+fwF8uDXWACEwlNKOSGGGG3qQWFFkowGcLNAzZ+d4
	GxpVPD1jtGP1ylFOVt3Bo6480pImRcKvVdWolYVu2e8jDZUEuXgW+eQ7tnYb6+idcTSIkYFNo3Q
	r5m+6
X-Gm-Gg: ASbGncvK89lWEW2s/5c8KoOH5+Unnbk3K7sMJAizxZ3588I1b0mVp7hvIgT2Xohzdy3
	ZKwmcsJUHuKbV5o3CPru4+0X5s5Y2Dd1VUZv2mFrNrMvlJnnRYTqI0whizy/8Mf5TPZFp8qmbfb
	uHxVk2OVBHgoe0M9XpepsEHIuH95jZsG9HQCr2Nca2RWKwUMLbPd/OdCPd5+/LAO3hvB5EgBrWV
	+85Wsam9xtjcaCeRqKxIJmdJhoS4oNQK8eQOkDOubRfkGEqOOgUF1lu1jEyCMQyJrRRzcKdtZ8T
	WtzQv//IpLa46D876415w+DBto6RoZNIoifyJaemdzsrnfxLULk4aI/Ta3XycIwiGEQiV8qIepI
	wf4ZgXDS/1Xcw0CR3RpwOLRsE0ADGrLcTZK2l+xlw+CVVFsD1AYJQkpqkzzerNP4YBY0B4Dk7wt
	A8yi3BUUfmwtzNp+IxBAPng4Fo
X-Google-Smtp-Source: AGHT+IHko+T7iXzjNaTHv4D0TV8/bTpGNVLuCGfq/p6VzjGqrwnfKfb9WAEoEQ74rgmR+vZ1wqGEyw==
X-Received: by 2002:a05:6000:2508:b0:429:cc39:99c0 with SMTP id ffacd0b85a97d-429e2d888abmr2436379f8f.1.1762338933560;
        Wed, 05 Nov 2025 02:35:33 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc1f9cdbsm9924053f8f.34.2025.11.05.02.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 02:35:33 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 4/4] Input: psmouse-smbus - add WQ_PERCPU to alloc_workqueue users
Date: Wed,  5 Nov 2025 11:35:23 +0100
Message-ID: <20251105103523.103622-5-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251105103523.103622-1-marco.crivellari@suse.com>
References: <20251105103523.103622-1-marco.crivellari@suse.com>
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

This patch continues the effort to refactor worqueue APIs, which has begun
with the change introducing new workqueues and a new alloc_workqueue flag:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

This change adds a new WQ_PERCPU flag to explicitly request alloc_workqueue()
to be per-cpu when WQ_UNBOUND has not been specified.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/input/mouse/psmouse-smbus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/psmouse-smbus.c b/drivers/input/mouse/psmouse-smbus.c
index 93420f07b7d0..5d6a4909ccbf 100644
--- a/drivers/input/mouse/psmouse-smbus.c
+++ b/drivers/input/mouse/psmouse-smbus.c
@@ -299,7 +299,7 @@ int __init psmouse_smbus_module_init(void)
 {
 	int error;
 
-	psmouse_smbus_wq = alloc_workqueue("psmouse-smbus", 0, 0);
+	psmouse_smbus_wq = alloc_workqueue("psmouse-smbus", WQ_PERCPU, 0);
 	if (!psmouse_smbus_wq)
 		return -ENOMEM;
 
-- 
2.51.1


