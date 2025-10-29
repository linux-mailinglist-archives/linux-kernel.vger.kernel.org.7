Return-Path: <linux-kernel+bounces-876783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1C9C1C518
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 18:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B20B4500214
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A3EC3451A6;
	Wed, 29 Oct 2025 16:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TEByD79T"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F5432F772
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 16:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761757019; cv=none; b=YLdIk+Pc0rGBNHQP9sXEVX4wU3w+LZ8/Zw4NuruJXBFEINZvlU3YCiNKu2xYU2uyDyDSZt+ibjrdwJnj/JQme3Cg9yF5eDMaOJUFN27NeXK5BGa+24KFOcKH+GRzlwUQ0Ncruxc2nnVhLRUctYo1rlpvAZPUgHvNgbfzMmE3p5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761757019; c=relaxed/simple;
	bh=Ay8+dCuN1DeWK30AJz39lzGmtE/RxHCisYXLmrzazPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gk8AAQsHBwlvokW+xL29BV4x1+1pecZga6WNE6wjU/XvbW6wwg6WrQeP9JembeaQGs8TwkyuQ9iXJjZwTEQXGOdj/BUBDciapexeBZDVsigKtseoldRyYebcLI2y44Bu1ZrKxUKvmy0lbTX3Bzb1+Nm8XWXBQYQY0x9dQCF+XEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TEByD79T; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-475dbc3c9efso367745e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 09:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761757016; x=1762361816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=neCo6rMsbUGdDP4ruNQ7u/VFFSh1B/BavlHefo52vBY=;
        b=TEByD79T6sH+8rWiVfJfbXsSZ4uEEiPwgf8RQF/zmGXEh1bdTg9TnVhwGwanI0Y0xb
         3QiayTbyzdgxcHcPio+5xORXqLde7+4QN9MJjYzaZJcatwRt/cOXkc6tQ7LKB1WyNAc7
         CfhAnIVp/tC+Rb7Ybffni/3wuYYnC6fAZZSFdfYybIdOaebTB9YabHZqXhePqOmCIbbz
         dmdJFJKIqnZsHhXB84tEHHV9toIXeR6t1tynwuPVyowwxpcyz2jV6ULjSXEFrJGp5dWz
         5br4yrnX26XHzjjjbq4J6pHB6kqJurdXQlpVhJmpaFXY/k+PheCVKgTtF5ZVatF0nMOB
         bZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761757016; x=1762361816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=neCo6rMsbUGdDP4ruNQ7u/VFFSh1B/BavlHefo52vBY=;
        b=sUOQDh1MtUzoZa1sIWsSfki/hQpTpUtZN1rtlG4uKCiNgdy+W1SlR+Wy/QBA3AQbQi
         qFYJKTzNSDni7T6Z54bAfoq9ZHPYMQ7/Grw3uKekblWNtOH6EF2STRsfnW3iQxXcsCY+
         eBtQ5i04GtdhcOdMKGRuxm/tmGCnKML6VgV8UfLdAjK0SlAc45RI526Ij6qHko+TX0wx
         EiHxGpspnIMLg6LXCbxCiaWpNzH+4GfQwjO/emD6k65cjRZz0W0t5a0xHP5sTxhCXnUd
         7SWUU9rEhid3/W+H2X+ErUOJHMI2VHweIni/NkA3IZtyzf1IQlGSiHhL6ZKABssTpW3A
         OSlA==
X-Gm-Message-State: AOJu0Yy+dPk4slR3vQ1di3x3rIsEES5s3As9ODwnoVerUO3oqzAFtTzo
	b/eWlhlxSqV6n1YX/dj2O4ITQNRIZ9HdILgLz9pVkLRSGwKPK20B5qmfP+sd98u9Qdby/CsZ1D2
	NDd3c
X-Gm-Gg: ASbGncvd9vpuFUpbWYsDKKPIRZQF1FXVUQDBcDTL5bMYhlp6Fld/4Qh2KEIqDxCXJZ/
	Lv00G20yIf2MLy3yioLn1PZschSTJhh6siaVVbYVB4+Z8JIKFFYCmmBw+qp83o+2vR+pTdZh2M3
	LlBmsmRrcZTNDCZQmoIijoaSS9XliC3Py84M/ZMg1iRUvyxaQC/2hW0ufFeJlWlLwSGmgLZXJrW
	Y/zpSdeU1cm1drOVekDa/U77CCXRBURTGnNP0OwesQrVvRRoqwyWPfnJfqQgd7EG9FJbRbFP7E3
	1UQrgoMqincI5A8mbT7i3ecGL8N0HI37xGP41+onH2r2RQgX8sv7sTApohwyBOlclfwQWWF72nm
	6ye666vOikJL88cIpagDGM1VcrO7EAPPsJXJoT7IVP740uJKLqIUg9XkJdEzaHgaUnxOrGqAg8G
	qzhvW06BmtZZ8Etw0=
X-Google-Smtp-Source: AGHT+IF2r7j5C2WwoHsesRE+SkzybACCWjnWaK3VR5ks8BG4MDELDNt49EH7s+dQi8bNKqiuYyGAwA==
X-Received: by 2002:a05:600c:1d23:b0:471:734:53c3 with SMTP id 5b1f17b1804b1-4772686f18cmr50925e9.24.1761757015818;
        Wed, 29 Oct 2025 09:56:55 -0700 (PDT)
Received: from linux.fritz.box ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47718fc0335sm48393845e9.2.2025.10.29.09.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 09:56:55 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Maciej Falkowski <maciej.falkowski@linux.intel.com>,
	Karol Wachowski <karol.wachowski@linux.intel.com>,
	Oded Gabbay <ogabbay@kernel.org>
Subject: [PATCH v2 1/2] accel/ivpu: replace use of system_unbound_wq with system_dfl_wq
Date: Wed, 29 Oct 2025 17:56:41 +0100
Message-ID: <20251029165642.364488-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251029165642.364488-1-marco.crivellari@suse.com>
References: <20251029165642.364488-1-marco.crivellari@suse.com>
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

This lack of consistency cannot be addressed without refactoring the API.

system_unbound_wq should be the default workqueue so as not to enforce
locality constraints for random work whenever it's not required.

Adding system_dfl_wq to encourage its use when unbound work should be used.

The old system_unbound_wq will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/accel/ivpu/ivpu_pm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/accel/ivpu/ivpu_pm.c b/drivers/accel/ivpu/ivpu_pm.c
index 475ddc94f1cf..ffa2ba7cafe2 100644
--- a/drivers/accel/ivpu/ivpu_pm.c
+++ b/drivers/accel/ivpu/ivpu_pm.c
@@ -186,7 +186,7 @@ void ivpu_pm_trigger_recovery(struct ivpu_device *vdev, const char *reason)
 	if (atomic_cmpxchg(&vdev->pm->reset_pending, 0, 1) == 0) {
 		ivpu_hw_diagnose_failure(vdev);
 		ivpu_hw_irq_disable(vdev); /* Disable IRQ early to protect from IRQ storm */
-		queue_work(system_unbound_wq, &vdev->pm->recovery_work);
+		queue_work(system_dfl_wq, &vdev->pm->recovery_work);
 	}
 }
 
-- 
2.51.0


