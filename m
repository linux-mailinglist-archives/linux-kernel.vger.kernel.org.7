Return-Path: <linux-kernel+bounces-802461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39173B45294
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:09:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EACC5A6E2D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E9B30E82C;
	Fri,  5 Sep 2025 09:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="XmdmO0PZ"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2852FF172
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063186; cv=none; b=K/3XZHG9cTPPggGz0p5HX4PhynxR51lvY3CvKJy1gzDP7VfTxKMtFNVS/8WDRiqY/ivAdXBVi6GnGM43ZtKgw2/kljvyECuCslMY10kGSO3UQnvOwK4emHS2NH2RV4jWrsg5Pb6i4jf2RJ8SC8Wca4H3oexgWwmVtfvxS0sjBKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063186; c=relaxed/simple;
	bh=TEHGZc4EvUV1xMIHiLNRLZQG/6cnDJNCMcleBirpd+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lym1gdCgcbJAvTl6SnX5vpqbvTm5gXyYD81/Bxc1MX2K7EhkQxu9TeqZy1SPxsd1uZ5+eZTK1LVYRPlLJDI0QO2GxYOXntojs4YXyGjO+/9Mnz0pHOz8yIbhjPhfvR6Fsc18zqsBFZq19pt8CC7bpXdOJfrLuNT1GAr/MqY7WBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=XmdmO0PZ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45b8b2712d8so17438645e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 02:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757063183; x=1757667983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XhvxllmRkk7qbtcIy4x6tRpvouKSR7M6p3iibpYHVJ0=;
        b=XmdmO0PZZFYpvRkY+VfY708wdWgU3SJHLP1wqE7F3hXhLH+dxH/DUbolM8X3kUJhD2
         jxG+ZXgVVikn9gQemEprUozVO6mWxgsaGkHsyOoqYZllc4QUZSkhw1kGqupLLTdtOB7H
         J/YZTzERZ5gorC09Pax8Y1aVq3dVmQd1cPJpj10715WVa8cI+OAbxkWiHEomQS4f1CJ6
         ncwIRzxDpuJNa0P3ui6yVNMiu9tLGdIRygijh09rszUpdZq4WJaQrJW4nQgSUPSEvCHd
         J45hKWYOSz7WYpMHf5dz9gERDm+CNIUolojrvkKDpe1gCxcsgAYfUmpu/bM+FpDKAfjF
         M/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757063183; x=1757667983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XhvxllmRkk7qbtcIy4x6tRpvouKSR7M6p3iibpYHVJ0=;
        b=s64bPmxO+OyLJq8oP3Xre8xmqTkkLWVxNlWyTxHWiV7+UMCBFydP3qvGXsde6AbSnO
         CAQ8aRiVQ/nVdm7tTg8nGeoGSlWuBKGCt60kWlHDITaEKW4gNXd+cvX7uvybsdTfDeTC
         z1BESTHfJW/Osx2a/f6IIrvIqklQRjsCAaF/GmfJcjLWkQF1PjuofqTJrAhbuVi0wtmF
         2AKPnBa7mq3/5veU1AsQKjtDheU0sBOE4WAB3sdaImvPqtC6jjk4y7FtlEDYSUKq7/cy
         OzsE94Ou6UpwskVp001eN4R9txnKnSdzz8ztJkqmeuvLZSPdZOT1knS0akPZawfLxZDG
         GKGQ==
X-Gm-Message-State: AOJu0YyrrqRW4dclDAw/JUagYI91o6itHBOtY+kgAXYk7Oriv8fKFXK+
	dQtqjkwn/inW1M1BCa05gft3/LKq8nB9vwSQ/N7RyYFpGzAxCi6if2WA1s3M+UXj9SydNhvSZkN
	QZDYH
X-Gm-Gg: ASbGncvYbAYtGLjIidk+NyQIcFlehyvtRnLl0eCQQLZYEWo0UXVYgKmQ5lkYgL4EJUL
	StE7qm5Tm8Eqov15xafDow7wn0kouC2YWAuvJw7jWRQnFV3YPlgI6LoOTeSxsjfgmYfKa8OqNIA
	PJRQ71xfEa/qbCnGoNNIJyJvKBnK+vcYKhh1BoQbdfDgvd5ZVhhQE+cKBJxCLxT6GLIvOPrJAP3
	OO1eRvmRGdBzb7N0t/XG/wdrklv+zIOuI8NcKlMut7NKYgdujE/b95MUcLi38m/hdrBLIHskRMA
	MTB+OqI6sv4Vv7l5LwdIMtxFMskDoHdVR6yniQh8CcQO0h22Avua2qYkvd2nH45TLYzwMaA0wjK
	eDJg6k/i8a/l4GF4c/ndzZOOtmOspfUqOz4Q2TrjUbOuEU+k9jr7GNkES7kI+yjf4U49h
X-Google-Smtp-Source: AGHT+IFQIFlzOCxxmQ7C2Do80yKgfSPsGCHu1QihwCx2ZpKBASWum+WQU9o0sStuA2s084NA0nh7Zw==
X-Received: by 2002:a05:600c:3153:b0:458:bda4:43df with SMTP id 5b1f17b1804b1-45b85570996mr229305965e9.17.1757063182704;
        Fri, 05 Sep 2025 02:06:22 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dcfd000dasm35392835e9.5.2025.09.05.02.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:06:22 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Len Brown <len.brown@intel.com>
Subject: [PATCH 1/1] PM: WQ_PERCPU added to alloc_workqueue users
Date: Fri,  5 Sep 2025 11:06:02 +0200
Message-ID: <20250905090602.105725-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905090602.105725-1-marco.crivellari@suse.com>
References: <20250905090602.105725-1-marco.crivellari@suse.com>
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
 kernel/power/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/main.c b/kernel/power/main.c
index 6254814d4817..eb55ef540032 100644
--- a/kernel/power/main.c
+++ b/kernel/power/main.c
@@ -1012,7 +1012,7 @@ EXPORT_SYMBOL_GPL(pm_wq);
 
 static int __init pm_start_workqueue(void)
 {
-	pm_wq = alloc_workqueue("pm", WQ_FREEZABLE, 0);
+	pm_wq = alloc_workqueue("pm", WQ_FREEZABLE | WQ_PERCPU, 0);
 
 	return pm_wq ? 0 : -ENOMEM;
 }
-- 
2.51.0


