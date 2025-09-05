Return-Path: <linux-kernel+bounces-802502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 537F5B452E0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AFBC17BCB4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18933128CF;
	Fri,  5 Sep 2025 09:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Y/+L8ppb"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E81B30FC25
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063617; cv=none; b=AO0y5UrlQn9B5L+RwWzDjT1gB9pSq7zogEPQCgcGxxXiWQNU0AiiqBVIGKZJLhKvj5awNVBnUVYzcUSNBuWnMCLl7CycVfSj0ooxTO963X5D2Ai71bGCyzttWunQPdbUmGR9riWbaf4p0i/s3AVPZocM2eg8LWbVivZpH6YcCpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063617; c=relaxed/simple;
	bh=J3wwsw1G96j/nFfeExdI2sMpIUubrqdNrNeAL9nfLMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MLY1THIlNxzAwNj4KzBc6/WwFcd30w4kdTuYtrMW/yYjoF/StDE0UbkRrN76VsEuffAmUcsEtWvXcc8R7AqYkoiQ5KBrl/OhVowogyg1ZbMpUI0q8mKCQ+/D1OO9IR8ggZLH6By50mqlwy6b+20JT3w6CGtqAjumWYYYApiQeKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Y/+L8ppb; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3df15fdf0caso1532877f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 02:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757063613; x=1757668413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eyvQ6R3XCDNf8BXEIqulKiYHytEcOGEOeWktLjCu/+I=;
        b=Y/+L8ppbmIOmXKw9p/6ydGDjSD2s+2fMLyoCbBq67nDC+0zETDr4qTgdsmtRkZ3w0R
         x1UQHUqD7NuOV3tGhu7PEBRm6WX82Gki92PoYlC5GOjKgE4mqT1D7/ssRq7CnNHVsWsj
         DPtbzHUEdGimKpeXmpDuevbi18f/olAeuleVF9KLmSfcoM0v+p9iGgXN3ehjntsJvxHr
         uZrq+UqmmdW8KWnoat9oyIUf7gdRsKg/awVeg7TxBMEmX9WsJOpZ7PoBnAeg/+5+/e+d
         H0rNoCuYq2//ysM3KdsTFgxRp7sXS6vQYS9jtIlN3EV/sbQRDZojiru5wREqNQ1K0EpI
         9/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757063613; x=1757668413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eyvQ6R3XCDNf8BXEIqulKiYHytEcOGEOeWktLjCu/+I=;
        b=CPlcusDkcUXM/FD6Sx4sXm/GVsk3gcdKgUb0xAojvxJFCQTDU5D77HL6IYXEKk6niK
         ZUVaSTiG2+/pZTUn6tLYVf9f+NZ5T2ifcciKV6xYtbG4aO6fnfYjAcyjiCGtKb8TLjWZ
         bew6DeBP8r6yOkxr33dbt4mNBAN4nBS8XFr8U5bgIkddrJ0Rn0Gj77J4+rLfjiXrtZYh
         OTj0N/KBr+IOCbEpBwZ6Z5LhIuEKf8VkbM7lZyXMPshyIQMd7nRovAG4NvDNXeAu8mdo
         ol53ZflcDstFEy7lyiUVKt3TXZlJj6nGSqtUfj0Vqp186gzaCL2jLxGCzIK6AcPxLzG4
         CpXA==
X-Gm-Message-State: AOJu0YxCofVtCZSMOrYZ1pQcHGdWEwbPyQV7PEA9N/iQ6yN/DIezJ8DY
	9cFcXyDZwOm5xuoUacuGJKLV+JRLthbvSePspnS6GjCF8miRz2VCV/QUsSgwDLh+Z9IVmKgKkhj
	iVrGUViE=
X-Gm-Gg: ASbGncuppKWyHyuODaskESpCJiq+wjpJlQkCJ1e+/QVdXPpwETYej9TaZFvwMg6nGMC
	SkXtIK8YozDEbfjjA1RfVGCZVJlK/N7t9O4omXgeXdmvyczkBIlJZtVAgmH5AoaKcVfLiveoJhA
	cO4h6cHWYJ7XdusKPhbsz0hqcrgeRvdudfYFGKrxvJXtJRlq/KG9Ib3u9Fem+zP6P+LTmsCtOn8
	wzWn0QiW64i26sfEpri388svEtIT5xQ1CLhrQKIuUUMwH5hygXKJj3pF8CuBtxGfxXzogd6fuoD
	IPL2brO4TpVHRo2Y72pLLkVaGjmn7O/aVZcgCQXY09Q87ywr77QIjfzJVxJBPw7ioMm+u45LhiA
	56BF3aXqEJvKIag7TS7cdiMQMKahAhk1ZsqxKiiLHtfNiBstBAp5aKCEgcg==
X-Google-Smtp-Source: AGHT+IE88+5Y2AKOXc8JHubbgaGZ6Smb2LWsmd0BVmStEEthfRNWZwWMQXbUQ20cKjiwD76bBKDFQA==
X-Received: by 2002:a05:6000:2509:b0:3e2:e079:86cf with SMTP id ffacd0b85a97d-3e2e0799704mr2577219f8f.36.1757063613387;
        Fri, 05 Sep 2025 02:13:33 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e4e2c3fe44sm167477f8f.0.2025.09.05.02.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:13:32 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>
Subject: [PATCH 1/3] workqueue: replace use of system_unbound_wq with system_dfl_wq
Date: Fri,  5 Sep 2025 11:13:23 +0200
Message-ID: <20250905091325.112168-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905091325.112168-1-marco.crivellari@suse.com>
References: <20250905091325.112168-1-marco.crivellari@suse.com>
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

system_unbound_wq should be the default workqueue so as not to enforce
locality constraints for random work whenever it's not required.

Adding system_dfl_wq to encourage its use when unbound work should be used.

queue_work() / queue_delayed_work() / mod_delayed_work() will now use the
new unbound wq: whether the user still use the old wq a warn will be
printed along with a wq redirect to the new one.

The old system_unbound_wq will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 include/linux/workqueue.h | 4 ++--
 kernel/workqueue.c        | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index f19072605faa..0e14d78fb970 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -779,8 +779,8 @@ extern void __warn_flushing_systemwide_wq(void)
 	     _wq == system_highpri_wq) ||				\
 	    (__builtin_constant_p(_wq == system_long_wq) &&		\
 	     _wq == system_long_wq) ||					\
-	    (__builtin_constant_p(_wq == system_unbound_wq) &&		\
-	     _wq == system_unbound_wq) ||				\
+	    (__builtin_constant_p(_wq == system_dfl_wq) &&		\
+	     _wq == system_dfl_wq) ||				\
 	    (__builtin_constant_p(_wq == system_freezable_wq) &&	\
 	     _wq == system_freezable_wq) ||				\
 	    (__builtin_constant_p(_wq == system_power_efficient_wq) &&	\
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 62f020050de1..687285701655 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2936,7 +2936,7 @@ static void idle_worker_timeout(struct timer_list *t)
 	raw_spin_unlock_irq(&pool->lock);
 
 	if (do_cull)
-		queue_work(system_unbound_wq, &pool->idle_cull_work);
+		queue_work(system_dfl_wq, &pool->idle_cull_work);
 }
 
 /**
-- 
2.51.0


