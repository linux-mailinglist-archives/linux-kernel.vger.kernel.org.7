Return-Path: <linux-kernel+bounces-879929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D851C246A0
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:21:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7F6DC4F2FEE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF4E33F8AE;
	Fri, 31 Oct 2025 10:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="c+fbS3z0"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF83633DEE9
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761906032; cv=none; b=hf2oY964Cy/PSpDMkwC/obBu90bKWFgQpKqnwhSkEI+raVnTZdDZB1lP0GDlZd1Mw77emyTDQwMpvl8880Pg2RnT5SWwUJS78Zhcv2F1ftlC/dWEcAPDMWhVe3hsgFsgyfOJN1FcvWWD7QpqBYTjC8MzNulRgCEwjI9O+69xCe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761906032; c=relaxed/simple;
	bh=7b+xoAj1KtcHbH1Dax10KChOEGn8QhBRglGjJ1JTwqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PQbBkWIeGmcy2W85xDplaxav/UV7e9H9pGsSj855qSZPWx4fT2nPUL8rHU+a6FMIRfGA1f89loyHiUqOQKis3Abprcn2Bqo2tmx2HI0UoIsL5ooADPfQG2ON0IkwG43HqVq3khlpPrhu+cKhNGi3+vyT5fRy3SVJk3Cxj4rlpts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=c+fbS3z0; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3f0ae439b56so1253880f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:20:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761906029; x=1762510829; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lG/JWTB4mQFHfKHxkHY65ceoWtJs048pwnbqojq+RhA=;
        b=c+fbS3z0ylljDtxnsbJEnnWYizJ8N2W2o6/p9louke0jrMbb+MIpRPoap/FccV2z0G
         cIcFTBIWUVBNXE8b7Jlm7AUl3mQjJhoBkeGCNni/WOj3e46wwIgRNPCPdaGBYXBWFk0X
         sNcE2LqOE6ib0P8EDlR/PdSgjANDJFgyZ271HFS3kDqy6O2U8kAF3dEw9WulBxki2luB
         Xbqn0jlVYki7d4YWZ31TqGXxGS3TKxEhbN9Fipmt+cT6dH8ddiwbkeE12RAPhrXkC2Vp
         1ePDF9Ko997stANb8isvqnfXF4V6ttL3ED2LKjuM5ax80RNMmAUOndhy8D0sfVvXc2D0
         rs7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761906029; x=1762510829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lG/JWTB4mQFHfKHxkHY65ceoWtJs048pwnbqojq+RhA=;
        b=Wp9Dc1xdXUpDqICzQaaV9EXINwFmTSOShJ7PSaxfA+6UcT67DjpCdZerhIVo4nnvOi
         o2fm0RpxRlxsUfzGfThVw8xIKamTpOxWyvOkZAbnbjO2bz5n9ca3eLQvXt9FQpNoah+C
         4LXzJFJ2WoMrIr5oOjClMvvSiAkqHAoosoog8ZEbFEUaReE/Op/5pNbyqBdGaIAtGf+O
         J1JUafDT8OLIyk5pVlKYrDyvQ+f3EgM2r0e2+hCA7I2M2QHLkUtYC2GUGF32vWVMF7MP
         b6syWQ2timza+9F8F32t63be4wFZtobt5wvuPQ3HltNZ+7fyzJc07qMHf9r/UKr/26ek
         A5XA==
X-Gm-Message-State: AOJu0YwDekaX9JKLJVouMDHBmqJpY8Zb8A3Yl3g2C+OBLKWgDP9khR8g
	/+Ucl9gX12vAFnO3egSx+ST2C7gVZvLgRHHr32NrqFXZDK4oxcJtP4M01tQlXIM5qeHiFsedLEZ
	XvACp
X-Gm-Gg: ASbGncvv/thFvFlBuyknhFJ/OO2kTVik90difuwUJ45OJck4nixtO4gXWBFRmFS8yJp
	INwH0o7kk61dEMa+rIdANDSLsCUp6ZPg6MpiTGZkg37Fml5cwS6IAtIwIGQcJyjSVvOLi/9Fla9
	2TH67VGl/TCqQJbWpL8cvoNkDF9GNG+hIRETgYzzUXmcK6QDeU8GPLFZ01pDFRWZ7xtUWX22WSp
	sRGo2JABL+QY1k1vTs16Muc1JmSMv8XP/N3cCYbfPBHyiYyPgNUDq5zmBnz2aa/cXtV3QlvP5FP
	fFAQgrgjiuAUxfbm4CBO+vHxNdmJRgwSRlyoVY4z/9zbFBJ8tkVjdYJ2Oy2LRBTmIHknrItgFEC
	Dv8WjzX/myWUoyA1HbhRug/k7FWXX8vlgQikRzr+tRgHIKVKZgOZQoudje+8gOAqAheEAkuh2Q+
	mHLMIZU9AkEjYQiB6UIAIDjREun3T1fP0ACPs=
X-Google-Smtp-Source: AGHT+IFxPuEPZ18LFLMwyhb4w1UgiiQJF5IBQ0ySKwVqt0uLPj62F1MUEQhY67w2SzSkdspzyNNBCw==
X-Received: by 2002:a05:6000:2511:b0:429:b7bb:89bc with SMTP id ffacd0b85a97d-429bd672238mr2018518f8f.1.1761906028685;
        Fri, 31 Oct 2025 03:20:28 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c110037asm3090410f8f.3.2025.10.31.03.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 03:20:28 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH 1/2] drm/nouveau: replace use of system_unbound_wq with system_dfl_wq
Date: Fri, 31 Oct 2025 11:20:19 +0100
Message-ID: <20251031102020.95349-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031102020.95349-1-marco.crivellari@suse.com>
References: <20251031102020.95349-1-marco.crivellari@suse.com>
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
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index e97e39abf3a2..50b7aade5f0a 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -2474,7 +2474,7 @@ nv50_disp_atomic_commit(struct drm_device *dev,
 	pm_runtime_get_noresume(dev->dev);
 
 	if (nonblock)
-		queue_work(system_unbound_wq, &state->commit_work);
+		queue_work(system_dfl_wq, &state->commit_work);
 	else
 		nv50_disp_atomic_commit_tail(state);
 
-- 
2.51.0


