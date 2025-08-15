Return-Path: <linux-kernel+bounces-770657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF606B27D84
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 11:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C50FFAE3642
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 09:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14162FC889;
	Fri, 15 Aug 2025 09:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VUCpQuuc"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6001F24C077
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 09:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755251333; cv=none; b=DGM2yE1FjC7/TAF15079HC5UM5a/Mg+epxpOLAxDDrscBu1f7HnioL0NXp+aOysrlBV6NKME/sp75psDZ8GD/apOnbzS5dW/ZXA0fBK5VAgxeJoaoc9asxVJK6kZ6KCui80fa/CiMJbIy28FRMXS3WxDGZhhgjnjAKff8rOMe1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755251333; c=relaxed/simple;
	bh=ApXFijJ9ifitsmoPMtx4eROfJLE/kj9jV/ZIIu7MUGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SGGN2RNop+eqYv9nxBIjTiJDzTfiGX9qPb26IRJyGN7+G49cDMuL+fyrt2qRpGHRQbialFT+53NMxJRhWmQAZOMgme820FnrumxPC32dw6PaaYz8qvhIHsV9WqRGxQRI2KkbSLA6nuamnDw8YtssLlUT+8IjIt56D/sP9ruqDCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VUCpQuuc; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b9df0bffc3so1052663f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 02:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755251329; x=1755856129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qTDwqJU1nmGKtl+X+8GsqFW5lzvu8oH1GJ2AavRkMc=;
        b=VUCpQuucv+tAzcTDKfjlXObqmJkjMuKwACW5SOOtqFhuxHW5dNV40AawiccX4Se+9c
         pQU6s3ErhIX/oMJ1htlw5nEmapBZPalbQeo4I7zXyDX2w2/uo2ad0oYgb2CtJSPo5XLC
         cGawniHl+GiwLtAsYZN0kKDrJHxUlzx7pQerSX8kfLbo+E5NfrYA9vPHbHh/WkW4fLB4
         Ij1g8Mlnn4CCi0tewhYt7uCB0ht93Dm6GXqEj/Lervurf0Xz6Hc1gCYyJ21h/6fKgpVB
         R1qql3m62Iqdxzl/dT8wh+fNAOKLN9zxMGQGO/2OXadEZaPLLmm9wXQ10UBjtSXTe4b2
         hSbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755251329; x=1755856129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8qTDwqJU1nmGKtl+X+8GsqFW5lzvu8oH1GJ2AavRkMc=;
        b=CwagWwKNNnVaxisTB5St0EKI4+fizLqu5G/CHxo0ZzgIxMwJS2Mc1UveAvFtzl/iuc
         3GJkBbjq3g0zoyXoewCQbcrwa5xk5iU55jeo9MPvIyzuTXYM2lP7IzgGAmEvVX/rHh1b
         orLqROD2o0FhwTnyDgFGZT45Fwx0zSelGDgtXIJINvffkIUAiPduEWoJy+vLOu7qAX9Z
         KdnubLBfoEgcNio2nLc5UwQDpihf+nzIY8iHlvComgpWDk8rk4jiorBB5lg+rUNJXxQp
         wBbEXXG+KoMF5hmDZQzI5zzuZz6ieTuEtNXEshWT6YOIcZPonQvoH62YkWeadGwMABa3
         KiPA==
X-Gm-Message-State: AOJu0YwPNjXJItDMJArUZkY1DyRZGsDg6KSC1371IKXMLffFyPVmjVA8
	0y2z1nmINHojQmDRnyXhXQ1ks7Q5zL01B4GYgDwK4poGk/x9HwYyiy0iO0wYk7kDL6PL+kNppW9
	ra1yd
X-Gm-Gg: ASbGncuJubLo7ORxmsFpb4T27Qi0zhIWpr+V/Qvjpxh7ocwAyVV+VwwRaAtPASsMoVl
	H1jJfYK+54v8eqG+0A+rEwZ0cTAI1pHo7yNkZuZ3RLSCENn2Of3waNGo8/tk9IN6/nKySmVTq1X
	Gx7Ni5G8IOzl2rIwys6EqFOU0tW3keKMVwUQ2xNAR+a11MqYx+LGLy/YxscSnayLXt253cfTIBY
	hy/unR0nP89kOqa5mk7wPZ/u+oa51Pa8FmRWvIWfaxmxPJYnjQ4s26xOvMObLfz82Nc25S5o0op
	BjNplVXP94V1zy4R537jaGC1Q7sMtwK8Zyq7pZMfkZDmGeRmU5f77X2eNEOZfe31pNEpln/6BzG
	FN/ng0MvMOZ3lrAFwv1MVHGoyPqBR5A8ne2ANpYUAtxSNZQ==
X-Google-Smtp-Source: AGHT+IHGexusHTIUA8LXz2AQhtbDX50PiccTmNsoRb+YSF+2WHeoBBr1PwoviEWMoQI3pnrSN7hHPA==
X-Received: by 2002:a05:6000:430c:b0:3b7:8984:5134 with SMTP id ffacd0b85a97d-3bb66a3b2ddmr1065862f8f.16.1755251329463;
        Fri, 15 Aug 2025 02:48:49 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb64758441sm1313811f8f.13.2025.08.15.02.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 02:48:49 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 1/2] Workqueue: mm: replace use of system_wq with system_percpu_wq
Date: Fri, 15 Aug 2025 11:48:42 +0200
Message-ID: <20250815094843.55377-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815094843.55377-1-marco.crivellari@suse.com>
References: <20250815094843.55377-1-marco.crivellari@suse.com>
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
CPU affinity constraint, which is very often not required by users.
Make it clear by adding a system_percpu_wq to all the mm subsystem.

The old wq will be kept for a few release cylces.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 mm/backing-dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 783904d8c5ef..784605103202 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -966,7 +966,7 @@ static int __init cgwb_init(void)
 {
 	/*
 	 * There can be many concurrent release work items overwhelming
-	 * system_wq.  Put them in a separate wq and limit concurrency.
+	 * system_percpu_wq.  Put them in a separate wq and limit concurrency.
 	 * There's no point in executing many of these in parallel.
 	 */
 	cgwb_release_wq = alloc_workqueue("cgwb_release", 0, 1);
-- 
2.50.1


