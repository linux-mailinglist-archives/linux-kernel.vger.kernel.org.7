Return-Path: <linux-kernel+bounces-878620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 129DEC211AA
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A30774E2E97
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B72E366FA5;
	Thu, 30 Oct 2025 16:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VI/EtZmQ"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069ED365D21
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 16:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761840628; cv=none; b=RcXe3sNH7INxfQdyfQZATVKflpSeXoMdD7oq1OhkWvaSUqVtlbSmEkRU4XemKub5TK8UP8ZJH7JL+SRm1GYUKqhFZBB4j+R/Le9diXJWlj7UvYqRhEZfthzEiUedgcS5qH/OhsL85D2BfwTLOE7maGJs3Z65KyLI79dR/+avuRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761840628; c=relaxed/simple;
	bh=pitwEdfA3nrBdh1BiRCp4D3Z4tLTcR3JkelahY7Hs9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oAij+AbE7qjT1W5VaFfOyOmDQRfXsTHm8jS47fTfvtv/CHnx+t310s/gorTnSK+tIqX6OBN1RcV1OB+6z8XkOdm+JVzQWYMswDiVEfJxv0MGwdyIBHv1L8rycJLuGncgbUm0yELXnnF33za08I1l9P16u6H3S4mnAfl1puwi24g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VI/EtZmQ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-475d9de970eso8922265e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761840624; x=1762445424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1mzPZhnW69Ma46xdkUZL4rvYZEGa/gCP35bg1gX0aRM=;
        b=VI/EtZmQNv4WDwD8Lg1bJSRScPipTIbBHpNrFa9j6ndey5bnhmxQSC75pREDZ+NjhG
         35qUD/F64FFb1QYV7oqMuFFH5otLWObPxBTitNFne2lkYCBwaomgzsJqNSBe6K7872Ye
         INKuy7asXRPuBTpfJMrJzWMHN2O3F9An/L3NN8RmYQWv+MnBXv/eQMAPalCUZpeR6tA/
         w64/t9TXwjB9kb/ZgtP5KXOG6JTG2WLrfeaVK6gQJ2kLFYVaTvn7uKcTbt4xvtxSJVrI
         WDrsY7vcgHe6ZeOS5sqR7eV0zs93brw02oWyPuz1n1HkWQr6Vb9M5GlXLstg8aTA7SCa
         VjaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761840624; x=1762445424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1mzPZhnW69Ma46xdkUZL4rvYZEGa/gCP35bg1gX0aRM=;
        b=LmopvlW7CyfLpRCcteTIYhL1NK3gZbHJis5HU2kMs1oGNeuYDhTp3/yYSnrAhty5qP
         XxK3s4Kl0iO8875gFQU2yp9u7Ai7U8Xsib3bGuXd/agUxSdgvuNU5bSWtrwgDaXTPcTH
         63B9ASyHCCdxnTaE7v/PH7Mv1Z4ossSZxQC0V/g2FXiIWVj1fmOpRy9v1nAMwbVTkfHD
         SYQXgunV6EgqV65BnOybaHm/c5X/8oyVtFSY124f7gjbveM6qsggUR+A/BEIByTnkUuR
         Odh2dpOm5Oi2Q5KBUwiXsGS8FH02hBztpHyiqMmV3Eh6i5nKPa9/1lBjL+Xytt/xnae1
         8T0g==
X-Gm-Message-State: AOJu0YxBgEzkqk/sItQG8z4YmMQFpIx36tEDPZ64Stj8Q0r+xJdDvdyU
	ZtuYg4HJh7oirvcpTHmx4EDPLjZ4CnQXm5lQqZAM4+bAqtZ+ZDyL+Jsy0nzvaV7ZHggiQCGqcrh
	2+1S4
X-Gm-Gg: ASbGncv8lGqXJVFQ4WpCxf9GBfp6vudFX+ZADDuG+7fy3UL80K9lMogjEkeFe7kJaOw
	oWXIVZEFIkgIXvrPzO4J0MtrGPyXOQoh34gSJTfUL0JvQdkn8XakvFC5HmXHb+kJDlaQHplBOof
	kXy3x+4NrQBKJ1B3ieg37rvZ15o90Xc63fr3rlUnWGiJrWLKEuO/tOSU8GWshWNIIAzmyfEPTXs
	/GvmJRE/bDP96nssfCLaiOwt27kw1f0EqRfI6/X2zpE2WnmBP4zIe0zY/E9U7DRGAXEzSz07jDI
	HYioxtlj2IFkqMhjV06zyV03JJPvSe3y5x2rRBLxwhMUFX/1kJZb6/FEZO6aZMasA+hloEK7SWR
	zCRKLcOgov55jlVlD105I99w7k867EX0Bl7IZlEMr0ySa4n+hPczEgEtGGJvT6snjyll+LZppA7
	yyNwz7vt/51E0UrfA=
X-Google-Smtp-Source: AGHT+IFroBmfAiCGL5XJxbZgL6hgq0wEFDb+ooauLfTFeIekjVl2CAAel/J5c/moOLtcfk84yd6I0g==
X-Received: by 2002:a05:600c:4e43:b0:477:e66:406e with SMTP id 5b1f17b1804b1-4773088be60mr3082305e9.29.1761840624032;
        Thu, 30 Oct 2025 09:10:24 -0700 (PDT)
Received: from linux.fritz.box ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952b7a7csm33124857f8f.8.2025.10.30.09.10.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 09:10:23 -0700 (PDT)
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
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH 3/4] amd/amdkfd: WQ_PERCPU added to alloc_workqueue users
Date: Thu, 30 Oct 2025 17:10:10 +0100
Message-ID: <20251030161011.282924-4-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251030161011.282924-1-marco.crivellari@suse.com>
References: <20251030161011.282924-1-marco.crivellari@suse.com>
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
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index ddfe30c13e9d..ebc9925f4e66 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -690,7 +690,8 @@ void kfd_procfs_del_queue(struct queue *q)
 int kfd_process_create_wq(void)
 {
 	if (!kfd_process_wq)
-		kfd_process_wq = alloc_workqueue("kfd_process_wq", 0, 0);
+		kfd_process_wq = alloc_workqueue("kfd_process_wq", WQ_PERCPU,
+						 0);
 	if (!kfd_restore_wq)
 		kfd_restore_wq = alloc_ordered_workqueue("kfd_restore_wq",
 							 WQ_FREEZABLE);
-- 
2.51.0


