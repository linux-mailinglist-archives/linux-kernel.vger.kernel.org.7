Return-Path: <linux-kernel+bounces-878578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 483F1C2109C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 152104F0464
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 15:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27806366FD2;
	Thu, 30 Oct 2025 15:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="OYqcXIB0"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C223655C4
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 15:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761839280; cv=none; b=B2/iSnRDL4GZWXD9P1U/3iiQDhWGMehXWY8M+ux8czAwN105klYuhTyAqF1OmbGSmbsDkaKDn8gehRCkQmM3j0qn6H08iC7FUuru+QPudJxE9cHW1oAT/5TZoOmqleWIg3M7f1cRBwLvmQPYBEXe8atK5PPHNUNchv/lzaDrh+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761839280; c=relaxed/simple;
	bh=dj4JgxYSsx9iEnxdLQ5jxXbS7kC+kfcSZq1bbTHwdIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AKm4NlfZ+J0OxBkb4EauOMPsEdCAP4PNNICoG/tPnPGjK7KHV7o+80yT6jm3glR4BFeEMJjllaJyp6OMQpeTgkEI8vB8NDubtX8gW+K/YVuSeJVq/0RDX5TQptosMgzHz8b7ShJrhnkvuKO2tvJd8MjPA2GIL9J8AxxnmaYvQ8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=OYqcXIB0; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-429bb95a238so360039f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 08:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761839276; x=1762444076; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1JA5tH0/jN6QofZu1XRi2irHFU4Wf8X4Ks8QpkT31AM=;
        b=OYqcXIB0cWM8c1GgJbJM6dF98vt3GzLky6N+84TJvZIjbQeisHBEzlogtoXd6hx6XW
         uzRGHeMGlvW2aqzXCd09LdS+tB6vlG12tMhTrv80RpLOUx/5KLgaDcBhdnkcumjNDCwD
         vDtYo2EYOzgd235VgPtwuJe4Yv3KnNTI0YZ44ihjapCwTtrAnmbTKUs5fC3ZgvE/MBun
         tiHqK1Fskzu6W5t+NcydRiHmaFitLofjibGWu6+Zz99UQguBmVGbBNtcNk5TK4eoTtHy
         0T9CQl4bKuifJ6b8hNllups+f2gSJzPCWpE3tLtsuH/hidVgW05lhscZ3JiDDEv37yKR
         dTVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761839276; x=1762444076;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1JA5tH0/jN6QofZu1XRi2irHFU4Wf8X4Ks8QpkT31AM=;
        b=AF3SaQ6SNRdJpAWXB5r6/CdmV7rifcEsO5Jdtf5BZ834snuhKPD9zS7KVowRindVMW
         RMWfLMw/uhN9gfnbluZFBBiuqO7K1Xz8SXyG3mfnb9HbM9Y3CFQst/5r1H3TxF8VW4WG
         QV89Fa4fTpX7o8aW4NTTB2NNoBlT6H1YCrPUBXMyAghz8uctRWVnB2Np16EDJZsOPT77
         czafcxIuvbBJrccwnmNaJozgKGkrCq/3gPjegeRq/JSti6+4AjLK858U1xlXXGhtcP/t
         u+dStZ0i/s/ttpmCWBTxK7kMvsZHt+QDXYBDxyFRufWPjZUBQop5Aj5A51HAZ7QyKeCR
         3Pug==
X-Gm-Message-State: AOJu0YyTMdaw5vKcibCn7t+6C5fnxAeZZ8eU3W/JhSzwFgg/JceDx0Us
	LLT5uRhAZAMkyIqyK8e7pEq7vxrmN2fbx+3HMwkza8uXYnpbcqxFU2mj/FlpVUlVErQHbZloRuj
	tGBoq
X-Gm-Gg: ASbGncuGVFVjc14OXrP+PoT8dwFwqr79Lcx8gkR6Ik/55mqGeMlze/9/QGaUTC4p+Fn
	LkUeUjx1ddZ8XBvVnQoiVzELcInR0Arf6STdKZ+r6xep3O6T9j4M2Z+ft81prj9BQ2kNunfO2T5
	HYKi0u0VgM35wHiwnklhwc/rmuGBFm87q/mC51Nr4/9GDGRNnyhkmomLPxKm7uP/jZJSEzY/F6Q
	fJt8+XVBsYV+lizyGvtr3UmCkfklT4J+Pnlz3NizSgy/NjlC/gSzwmTaMheT3bFV4MmMRPby4iC
	SPf5OYP++DDhixQT/MAKrODG+WH8QYwfPz7h0bxaUWOi9hGvxH0vb9XF4bzunwv1Xhsa3QSzZMS
	qLjLwQ1yirFP/lgFQeo+mYWnnotA/nhF82VN02HWs9ImY15u5j4WLVBMCb/7MZy/lDuv9KeIMyd
	ITqIZa4yT004QiJN4=
X-Google-Smtp-Source: AGHT+IEEYnjir9tDFz2xcJ3AeLq+Hq9UTEgdA54xaGRh8uYrQgEV3tVv37Pq49sexRk8dbqzfWFkSg==
X-Received: by 2002:a05:6000:2203:b0:428:3ea7:4473 with SMTP id ffacd0b85a97d-429bd6a48f4mr35234f8f.39.1761839276467;
        Thu, 30 Oct 2025 08:47:56 -0700 (PDT)
Received: from linux.fritz.box ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952d4494sm33230465f8f.21.2025.10.30.08.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 08:47:56 -0700 (PDT)
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
	Len Brown <lenb@kernel.org>
Subject: [PATCH 4/5] ACPI: OSL: WQ_PERCPU added to alloc_workqueue users
Date: Thu, 30 Oct 2025 16:47:38 +0100
Message-ID: <20251030154739.262582-5-marco.crivellari@suse.com>
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
---
 drivers/acpi/osl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index a79a5d47bdb8..05393a7315fe 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1694,8 +1694,8 @@ acpi_status __init acpi_os_initialize(void)
 
 acpi_status __init acpi_os_initialize1(void)
 {
-	kacpid_wq = alloc_workqueue("kacpid", 0, 1);
-	kacpi_notify_wq = alloc_workqueue("kacpi_notify", 0, 0);
+	kacpid_wq = alloc_workqueue("kacpid", WQ_PERCPU, 1);
+	kacpi_notify_wq = alloc_workqueue("kacpi_notify", WQ_PERCPU, 0);
 	kacpi_hotplug_wq = alloc_ordered_workqueue("kacpi_hotplug", 0);
 	BUG_ON(!kacpid_wq);
 	BUG_ON(!kacpi_notify_wq);
-- 
2.51.0


