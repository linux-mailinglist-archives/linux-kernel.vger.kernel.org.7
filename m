Return-Path: <linux-kernel+bounces-890530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA09C40448
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 15:13:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F09B74ED030
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 14:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B366632863B;
	Fri,  7 Nov 2025 14:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HnAockRi"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A42D32860C
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 14:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762524796; cv=none; b=XcvCSc2QBB9O5ejIN5AApxxN3q/XdMsDzQZH9Fa4fn7Z/nXncgTLiuE9Ys0vDDlvWNLdCN6oUvrysowraguPiITF3NsnnFlXLjQF7ZGnAVx3bBM4jEbko4sSqfcTHWXxQJwV01u4Cro6YkGkUDOD1mHTeyjKW3ZYlahKKO19upU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762524796; c=relaxed/simple;
	bh=MREIJFcZ2rp1rmZfWwvS3zaB6eT7Dhlq5P2feIRtluo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gg6iWsJT2KSL8dPZBbzF+qTiL45GYwfyr79LqKywr755v1LPQeVQ2fZ6cIJxNxHH12sG23oHW6dAzP+g/lmMY86B9ZnJqdQjokVvrgMW/z0ArLYbLBTRG+i9uFc8lMaK7BkcsrlkMYAwhN+9pakJsVAf0W2hCkY/Pt470QFuJUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HnAockRi; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-471b80b994bso8532915e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Nov 2025 06:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762524790; x=1763129590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Zya9CDjAWwz/YQhtW3O1MV9PxrsdkYyA1iOu9tElgJc=;
        b=HnAockRiA75xWEDQyNFcwrmKxWLGRhYFd3mtTuIAGYtZeRCctXd15tg+Z8kYkl+n53
         g9kKC52aT22ODg3iwr4J4oUswOMh1hQgj5KaalkJjyJVp0s2kUzbws20pG+DHcoGXAUo
         hyJCaqytVHLiI0/5yLcWT+JbLMfmvM3TsThgq29Mxowp38lCabLVDBcoVjiX/D1YOvil
         TT8YGIPPl4pGsiFN0hI2LN63cDk97MccmEJY56A+tXLh3V54IYp9Qoa6NBzynTp5AAHL
         f8LO6D0tq/3NTQKQO8Jb0d0UPNGEj16dUYdkD+qucyvdjTl/i4mDeKA4w5ZDOAs+O5We
         W0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762524790; x=1763129590;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zya9CDjAWwz/YQhtW3O1MV9PxrsdkYyA1iOu9tElgJc=;
        b=stenSLXrz/fqySVIRVeNlR8/qMSd242K0bwCcvhiEUyPLj0NRcJxsYGoz97FCeYNGV
         5SNtYF0A928Y2LTUzvkDgnn8rNdnUn7ho7OnAOppzIpqNBL0YyqHJYsEU0IFPh09GTU9
         XpNMiojigm9MGEmZc/xFRgtpSNZ5eOhHlSUDAY3q0d8pawpr2MXsiVn0nEta5ZHthloW
         v0lJOIMzV7mQyvWUy3YftjHlXQhPmgrzfZ+Q6NwRlOsC990i2zaG0lxSfSvSBy+sRarC
         SYp4JJA3aM5O1iNl7+vd06RE+m59o+L3cmmIMJYdFzOnJ1J3RsAXvtnCiXjtZ0VvWZat
         uwTA==
X-Gm-Message-State: AOJu0Yyyc4482WVsM6YpOj7cf2FM/2trMF1fQ6ERkErWwjLFmMZHIMeU
	2le83TRvJ/Ytg5M33JsR+ZAn6duS3wn+8Hvs6NEKSBts9Br2R7zVJThkcs1dETnPJwOiZ2eDtcq
	PBOoW
X-Gm-Gg: ASbGncub8dBXUT4TzJhISvEBgJvkY/7hvV/9Afg/ZqtSFQKdfM2NS5F8vdO61BcK9xH
	ARLeEEd9nhN7zidYapvyOD7vBiwo0R4S4a6Z/HLY6fByZYudYmcKFURSWKvk8Jfc+syhrYYyrXb
	6D/OlYUtrX2u1M/LdFrps3lwtwYLtatTRp7Y1Rtf38KRKXG/PXNQ/j08lF6pxEyR5/rPxQMOWbt
	bv/39x4BrIZB6JRFhG2A6YoA1b132vWN3TbaM2FM9EGJ/XDTxtGkAv86TNkwhfIRf/4CuaJTI/e
	jDJaAYr4I/TtUuj/RVk+fMvVgzxqD/BTqYs+846jneFQzYoHIoBqOXgQm8waNWgPSIBYD4ofDXb
	pxpbJgzCDjkI2JUAliaJsY1YHK4G3w9vX/plOaKAc4oQoU2T7lupotTaH3v+TD5aALdOVTDDMKO
	cM7DmN/jRo6G/gX1OetyUMAwbqT5rm3WyWMmU=
X-Google-Smtp-Source: AGHT+IGp7Uv+Rz0H0a9Tbxc8WVcxFYh+xPnB3f9zZgNkWgNSCruoFQ5+kEx67gRvEzujnx6ZhHmG0g==
X-Received: by 2002:a05:600c:1f10:b0:475:dbb5:23a2 with SMTP id 5b1f17b1804b1-4776bc904efmr24244345e9.16.1762524790118;
        Fri, 07 Nov 2025 06:13:10 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477641b622asm42998605e9.4.2025.11.07.06.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 06:13:09 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: [PATCH] media: platform: mtk-mdp3: add WQ_PERCPU to alloc_workqueue users
Date: Fri,  7 Nov 2025 15:13:03 +0100
Message-ID: <20251107141303.223254-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
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
 drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
index 6559d72d5d42..9083367ae2e4 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-core.c
@@ -255,14 +255,16 @@ static int mdp_probe(struct platform_device *pdev)
 		goto err_free_mutex;
 	}
 
-	mdp->job_wq = alloc_workqueue(MDP_MODULE_NAME, WQ_FREEZABLE, 0);
+	mdp->job_wq = alloc_workqueue(MDP_MODULE_NAME,
+				      WQ_FREEZABLE | WQ_PERCPU, 0);
 	if (!mdp->job_wq) {
 		dev_err(dev, "Unable to create job workqueue\n");
 		ret = -ENOMEM;
 		goto err_deinit_comp;
 	}
 
-	mdp->clock_wq = alloc_workqueue(MDP_MODULE_NAME "-clock", WQ_FREEZABLE,
+	mdp->clock_wq = alloc_workqueue(MDP_MODULE_NAME "-clock",
+					WQ_FREEZABLE | WQ_PERCPU,
 					0);
 	if (!mdp->clock_wq) {
 		dev_err(dev, "Unable to create clock workqueue\n");
-- 
2.51.1


