Return-Path: <linux-kernel+bounces-878579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AFDC210E4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:54:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 450C21AA2A86
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAB5E3678AD;
	Thu, 30 Oct 2025 15:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="WAz4PaLg"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B90B3655E5
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 15:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761839281; cv=none; b=A28jWN3m6c2Qb7RLFIxkC9BY9SbklpIxY5qR+R8k9MwXrnlBmy6fTJmMznbZatwo6KRJedE4oAoun5TRLUI+fWARAX/5YUYqtJDFgqNGH53wdlBvzZqPMQwwvEdRcsHesGiTLhJ59GW++pZMj/IAmY+X9e404Hzy/1NfCtWDeOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761839281; c=relaxed/simple;
	bh=XJrAeM0bm8IOI+PtKrJkM5ofQWWoG6sG4rQq8LIKX0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AO1z5BfrHa9k9aKTzd3OJ5I/vtxfez7NDjvbHUL6fT6oeg8RaJw4adrQFWv8kOxEBv4hXPveXVR5NTL5mfHq3gL51hdyzGJN6eZAlx04RJPmApihVAAngvzh10Kt2S1Py82yuTzQaSnipygvLOgh1uz+eKjH1dprtNCzNwNIrxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=WAz4PaLg; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-421851bcb25so724997f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761839277; x=1762444077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1EvAdEwVOXpN/RTJbLmUZiFBI5Zw4W1nq/Q+XC07Oog=;
        b=WAz4PaLg1bZJgv+lXGj4SosOAfcLlPRh3xCK/sL/InmnYo0JXGJ8n/0QGyb7e1Vg0d
         kiQLhoBLrPPCaP2Ju94e0sWlbRF0l380mClSMQicbAdDSrgHUjO2GUHyEAYskCrVBEum
         sUUr5wzUwIpNzVMHOi8bYJiTmfzGgxgclLisesItdDai9GrgkwSDCbD5ebKsbUKoY4Pd
         oZIsKQRAe3ZF/1hJEcF7P8zi0E/q8uoYRLzQHwqNbU2rmBfjnZ46E0K5scAGLjJE9ZKG
         5zPnbexlcaLH0DgOW0aMdFhKMbadh8wgwq8NJ5TIAdJDc4EE6OskfT1rGGWg9YB8/kHD
         SkiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761839277; x=1762444077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1EvAdEwVOXpN/RTJbLmUZiFBI5Zw4W1nq/Q+XC07Oog=;
        b=Vlm0Nag8ZPBJBaqo5QhjQCHdwBviijbfVEoK4QfmnE8hAbhzFf1cocPu8k/KJ5V5ib
         jr1QNYCU0BEL1pWUpTBX3TwmWru9F0ZeSUFbeq2bEQt0etkiBbDHHstITtxK5rf9KAP5
         hkS1FJ03zv35a7m4MgVp6fzZGgSKNdN8g9ez/IqJ7a0Ob/GDvS5e3W2hJpTrPkshaPyK
         uzZ+M08HxkKpgtD3/TVg3FL7ZgBK/170rm+oXrXUPVHGSqaytRWeJDA8/9MK4/Ntqy/T
         v+5CqnJKm4as0H9B/M306A55i9Om+BobAOwTsGgEp/CRogImo776bxR1DMh/xJEleyAo
         7YWw==
X-Gm-Message-State: AOJu0Yz1mKPw7egNInysa8p3ZapLsPjQay9xzBGea4LHBbYA6ZC65/sU
	+zcfSylByPH2o11vt3pUP+PV+50ojcBfudp7VbtNdM/oc3h0G/+W8omy+rNSCh27/km6Vq2oIYe
	ZqkZz
X-Gm-Gg: ASbGncsAQmSuzJOjHGDdkau57qHW+tO8rPbYyLrW28D/fH02QkaU27gRa4X1CHshcns
	dIvM8UXwAHI5NWuq3Y+E7jF07y3ybFoqLIV+4JBnExOsP6aeRt2P6BTxa4oTv7DAl/HdvwjCFcN
	+YKkzDBsE5XOif+z/hodYHLAY2cU4UvsKQl3Bbc/4e4Q1q1wojHKsjFBdR/lP+XJQ8wfDxG/k+7
	i3AoZCmEKp7ttQQvikHfZWuHJTb6tmpmv5prwc1zcShuGfRvRFeE7xB2p/hoBhp2LJno7Gvm6Cf
	EWCyd74F8SSYCnLStKfsMDfSRfKCbMCTdiQNnGp5Eju3K4SSI7Rs9coU1En88JqVDXL6OWlL0s/
	FOMCotyaegzxf3VXsNuEbX3awQlH4Ae+ZTlZpiPFJJ5U/XASCMhA5e2aaF7hVgOUTmfi8yTzsgA
	SVmLbdE3uJ6HaqgQE=
X-Google-Smtp-Source: AGHT+IHv0b72t6uTN5xevmEXlNNhXb865PxInovOLuEzLPLCBQj4iAvE7Apv1laDFcFKTRnG6CgXAg==
X-Received: by 2002:a05:6000:2309:b0:426:ed9d:4072 with SMTP id ffacd0b85a97d-429bd680cd2mr43975f8f.21.1761839277284;
        Thu, 30 Oct 2025 08:47:57 -0700 (PDT)
Received: from linux.fritz.box ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d4494sm33230465f8f.21.2025.10.30.08.47.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 08:47:57 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 5/5] ACPI: thermal: WQ_PERCPU added to alloc_workqueue users
Date: Thu, 30 Oct 2025 16:47:39 +0100
Message-ID: <20251030154739.262582-6-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251030154739.262582-1-marco.crivellari@suse.com>
References: <20251030154739.262582-1-marco.crivellari@suse.com>
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

This change adds a new WQ_PERCPU flag to explicitly request
alloc_workqueue() to be per-cpu when WQ_UNBOUND has not been specified.

With the introduction of the WQ_PERCPU flag (equivalent to !WQ_UNBOUND),
any alloc_workqueue() caller that doesn’t explicitly specify WQ_UNBOUND
must now use WQ_PERCPU.

Once migration is complete, WQ_UNBOUND can be removed and unbound will
become the implicit default.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
CC: Zhang Rui <rui.zhang@intel.com>
---
 drivers/acpi/thermal.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
index 8537395b417b..a511f9ea0267 100644
--- a/drivers/acpi/thermal.c
+++ b/drivers/acpi/thermal.c
@@ -1060,7 +1060,8 @@ static int __init acpi_thermal_init(void)
 	}
 
 	acpi_thermal_pm_queue = alloc_workqueue("acpi_thermal_pm",
-						WQ_HIGHPRI | WQ_MEM_RECLAIM, 0);
+						WQ_HIGHPRI | WQ_MEM_RECLAIM | WQ_PERCPU,
+						0);
 	if (!acpi_thermal_pm_queue)
 		return -ENODEV;
 
-- 
2.51.0


