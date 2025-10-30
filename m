Return-Path: <linux-kernel+bounces-878635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 547AEC21223
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:21:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1FD1B4E2750
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC313678CC;
	Thu, 30 Oct 2025 16:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="T2B6bMa6"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1607366FCD
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 16:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761841258; cv=none; b=s8O2ndPylJ06DY7Sv4ZrW7SpEpWfCdq+RllFM9vIBrnaJ0p9HkA2ggAcdYXi+neDmBvW14oJFAjhyY5cEh1URhz3/82Np0J9TMFtTGq+fxmbiO60exTIrw7FM3wTwvrRvXTKHgm6qpK8IrFykfdM4ifpqoKC9tY3JVidnh/o7WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761841258; c=relaxed/simple;
	bh=bWd3Z/9UcAMJcjoLjTHhyz76mc50vWaKla7wmfVv4pE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E7g1TlNcQKZZ9ePgBuBHqST3lEj5kjkPSORcS5zc7tDAQ5Cb7yX/HoacSp9yitNIVaPmUFxbJfmH4RP0C8t+8+wc7OQuGDTXuF6qA0TvO/d68MrXdKI1ByIlAZgqKDqYYmplAb56BX4BvDlOCsNObhlunX4DkvOuFAzI7aMkb5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=T2B6bMa6; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3ecde0be34eso1561754f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761841255; x=1762446055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6NY69lTN7Ud7Wl3FDNsKkunmZ3YSYqX1JZIpAlME2vc=;
        b=T2B6bMa6WN9GGXnEEALNnxasCjReukR37ErGyiCbRR7yzxIMgYT46vk3CuPA1yscGC
         bja8B7EqrA6B7pcPeNPt47B/T+IGTKBjw1As6UJ3Bb+/rBjMHMxDlAKRUNDfO5slLWCU
         +Nv6MYFTm8DkT0OtaJ9Y/LH8clb958axOukzklBDcFE6GNciGJxWu7TXlHw2q2GSqxjr
         x2iGUtJSEsJYGj4dnHGX786j42ytD/QI5OhVXSwUrDO4bJf0L6vqIdkrHmQkX8jVf0dt
         JyvLvXTqGZF6J+qpkDa/WVyd4mRC+I0Ko6CwQ8sfDHsrm+Tl0q6LC6gCQqmsbzqF650p
         ls+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761841255; x=1762446055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6NY69lTN7Ud7Wl3FDNsKkunmZ3YSYqX1JZIpAlME2vc=;
        b=QsoNFQ5wn610YhrdFMGBYuJ+qorYjbk8E73nh8HSEhttHm1jO+NEYjsAcCPZaegDFa
         WIK5g7HyemivvR4WTc9Unkfon5qQHE4U8KLvPFVL46tFMHqddloSbAl2T4U+aO6R0/ph
         iVAws9bvbjRwp7/XePmDNAs59oCNpfie5Oo2R4WjaFyCDTLQnuIH5PuvBVeNuJU5GohL
         VhNb36+YlpcKUs7MFL9CweB/rmHcnnqdGq66uxxLNJ+hcFiwgQiQs0sreDiiarI8sXKT
         iEC9ve8uYN6SSoc0/ExpmR0CokVAGB2/bBgttQQ+yvOHEqY56fOmNnpZ3zNlCffXIIzG
         77ZA==
X-Gm-Message-State: AOJu0YxTI3na7vEf9sJ6sDoFQyde+0i5OVbRqDxZ6xgJ7+UDLDzNdudK
	KbLlFhoghkmhGmGnQYF69tcgRcYnLogQcyJtaNBXJSALYVXOPXTERN4LFwupLHcXnqNYazePACv
	ajFyE
X-Gm-Gg: ASbGnct3heFJtzwscGUhWtmkDwNieakWkudiSfGiF2BHZi0fE0aNzTKfuyXjLCTg19n
	L/eUTGw/xoIGevIFq+RaMxa0KirvrzdT1heiqxrkLBTmupbHXZnghdC21sh5QsY3wxxlHTbRO01
	rgrKCY5ohgL9c74BGx8YKdqI9+qSljV4rHys3pWmDJVQDehp7SXOn3F/5+nuozQJFJBYeXqfbm0
	IXbWpkl548EkXfyzWSHm7pARcGv7EBHTVaO1vZurVwTFjRsN/zAWv+XJOeovrE7kyzzP9zxmIJ6
	IdpavN7lCAdaDkm+UDn2UvMBDfLVTUYPbhqeQ3+Twb/JpgbprzlU5jQjpW+sicnAqeq8eIzBiLD
	Q46LdqkqHWXM8sM5FXUcaIWu0+XeqM5HG2QsxkNUk03XvYkXVe1frhy2gGoFSjcMeiwLTX7zkiK
	vsTKxKkl4r8L0XjhY=
X-Google-Smtp-Source: AGHT+IFXfPh9yW0jtVttu/qwKjincPyDWS6IM7gy5X4TYXb5a6D/RDGVc/OgitNN+ao8ksUaeqYamg==
X-Received: by 2002:a05:6000:178d:b0:3e7:428f:d33 with SMTP id ffacd0b85a97d-429bcd51231mr502674f8f.16.1761841254774;
        Thu, 30 Oct 2025 09:20:54 -0700 (PDT)
Received: from linux.fritz.box ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952df473sm32758678f8f.42.2025.10.30.09.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 09:20:54 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH 3/3] drm/self_refresh: replace use of system_wq with system_percpu_wq
Date: Thu, 30 Oct 2025 17:20:43 +0100
Message-ID: <20251030162043.292468-4-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251030162043.292468-1-marco.crivellari@suse.com>
References: <20251030162043.292468-1-marco.crivellari@suse.com>
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

system_wq should be the per-cpu workqueue, yet in this name nothing makes
that clear, so replace system_wq with system_percpu_wq.

The old wq (system_wq) will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/gpu/drm/drm_self_refresh_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_self_refresh_helper.c b/drivers/gpu/drm/drm_self_refresh_helper.c
index c0948586b7fd..36f4237efd4d 100644
--- a/drivers/gpu/drm/drm_self_refresh_helper.c
+++ b/drivers/gpu/drm/drm_self_refresh_helper.c
@@ -218,7 +218,7 @@ void drm_self_refresh_helper_alter_state(struct drm_atomic_state *state)
 			 ewma_psr_time_read(&sr_data->exit_avg_ms)) * 2;
 		mutex_unlock(&sr_data->avg_mutex);
 
-		mod_delayed_work(system_wq, &sr_data->entry_work,
+		mod_delayed_work(system_percpu_wq, &sr_data->entry_work,
 				 msecs_to_jiffies(delay));
 	}
 }
-- 
2.51.0


