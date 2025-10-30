Return-Path: <linux-kernel+bounces-878621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 868E9C211B6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 17:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30870424870
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 16:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A984366FC5;
	Thu, 30 Oct 2025 16:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="O1yScdwW"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E1C365D34
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 16:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761840629; cv=none; b=ZsGv0ZlC2VPBa4pYni2DDRb9uWWYcDZg/8lPfqvIArqGYJ19VSuaD3FCsHFG65n4Zrxc7AmcQxYiL9Y2KzoHOJvT6Idv0is/WbGcMWzDY4hopjLMgzXjRz3gVcIJ5lDHf9KOdGXaQPK1TegVbFMI2Mv1PoalkucfQNURnEs+MSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761840629; c=relaxed/simple;
	bh=lKjDJt4O/H35TLYg6iUN24lXu3yise5Gp9iVcTWfvgM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hhKd8UnNjD8JxPBD1HIgEvwxsl/v9RExa6e/6swAjiqYG87qbVQQmkrsk1ICBciQ2XGhu2jBl0MOXtBal/qCUj7fDjnU0QB47mwt9uZhr8AcQ0BcXA0tAPoNsuqAg+ZQ20+RocMzK6r55iDCjeLgAwdRphDdgXcgFPiBWmyosj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=O1yScdwW; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-475dd559b0bso16485585e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761840625; x=1762445425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUyLe55hA4hNh5avFZjcyEPUTCpSS8nAfdCLlggpt5s=;
        b=O1yScdwWRkFyK01BvoWW2eHOq7RKpb46MK0bs8HQ/53EgwcRG+VxJRicmJaSfbtsUg
         uoL0ifO3Wmf6J/70Os997kJ1g3QDxyEVaTnPzc8mpIjANBfRODraM+yuNaAD/pzIhTeR
         EnepzWUuu2HGk/FDdbNDSsja0N56qc0pXCDYicOXS51vu0JwhqR4HO3sUu5Suq8e6DEq
         o2grTxPMftopfFTslZoUbwihpZTrbe1GpT6+z4QhedzmXWL8N+RBMVRN/Od/JfUKvrO+
         /ofGGdeuJWf0yWng5iNWbHWCqE6DAMhRujeczX7wzz9TxmMmwxBPgaM75h0JJJIeKiFJ
         YBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761840625; x=1762445425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qUyLe55hA4hNh5avFZjcyEPUTCpSS8nAfdCLlggpt5s=;
        b=tWqJmBBFvjoAbcRc/mGlcFUt4zifYI/nus2AHP+LuhT/X7mIaZwBWCX1wpPO/QGQVy
         RL3Mk78YXZbnP+CWJ0xzb2fnMAEXSDOWrJuznutAgWfZjzPEFjeNUfEgGgXXKm5EGyxF
         MhMQ6PctNjxTS8yNgkgM9BPHomAbdp0xnoscKsxeuwotpOB/6WAHc9t7b4xgEWzcrAri
         3yCQBOYchO0MV4CevwVBgHg3FSCkOelkpZbiuX1yrOGsUWsnueWUyhXCqQx9zxwMjlRT
         cVqLdFAwbYrHrWlzPQRpxQgK3aaz4nGK1X22pmsC40K9+x8zPiuM0aE50jxmoS//9MyF
         g5ag==
X-Gm-Message-State: AOJu0YxqWejnZUQH9T3+Zdt/lGqOo5OotAOqMaHcYtd7kFDeDQbCNUps
	TiJ0dgE+dfXLD6QKPADPT7u7tYpcJaB83W9ggTVQuBNICkbeH71BDc8lnr4ekACxjlxrpk1OhZY
	vyoDr
X-Gm-Gg: ASbGncu1UgbLmI3Vot+fk91tcOJ7DkbfoEFZmPE0j98UnpXtzOU04SZngA7vGVMdisx
	/8s2iMmNSpZfA3bTbugOmGzgfO/1xMrfggNEh5PphOzwhwL9w5KtBnfArEhu9MelTXFiZL2XIgv
	4uHcegySnnSVoVd4w6vpb6KnAlDt+cmVyz9Jb6pO+NhPUbNKbRkQxpEP7kalH349ie0W9wuMmND
	0gN6qzLYXvThkaF2IXBnUnVyrONrmEP4Sq1/wKuZyXHbpNDO+kc2J3TenFQF8jMXy6XL4lBNE5+
	+HI7YlEv/BgTCNqZChuGWjNdB6HEbwZsI8ApGSEh9JkPWgWrWTnDd6EQB5682Ht9iU12lEoDXls
	41OpGnAnVcquBZUJz6xVPFZLcnj4oL9V8GraT3caNzaHleAfg/cEcNCkk/4STKLrCyx+NdmXDuC
	Nu1ODM9tbwjO0Zu9A=
X-Google-Smtp-Source: AGHT+IFyE5J11xUKBnyXYND4mxJaazGINsyI2NsqELziu7PEPOdM/yL8Wk6KNj6+t9t3bygj4S8Ayw==
X-Received: by 2002:a05:600c:6986:b0:46e:7247:cbc0 with SMTP id 5b1f17b1804b1-47730859cefmr2359355e9.18.1761840625061;
        Thu, 30 Oct 2025 09:10:25 -0700 (PDT)
Received: from linux.fritz.box ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952b7a7csm33124857f8f.8.2025.10.30.09.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 09:10:24 -0700 (PDT)
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
Subject: [PATCH 4/4] drm/radeon: WQ_PERCPU added to alloc_workqueue users
Date: Thu, 30 Oct 2025 17:10:11 +0100
Message-ID: <20251030161011.282924-5-marco.crivellari@suse.com>
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
 drivers/gpu/drm/radeon/radeon_display.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
index 351b9dfcdad8..3c8aa5274c51 100644
--- a/drivers/gpu/drm/radeon/radeon_display.c
+++ b/drivers/gpu/drm/radeon/radeon_display.c
@@ -687,7 +687,8 @@ static void radeon_crtc_init(struct drm_device *dev, int index)
 	if (radeon_crtc == NULL)
 		return;
 
-	radeon_crtc->flip_queue = alloc_workqueue("radeon-crtc", WQ_HIGHPRI, 0);
+	radeon_crtc->flip_queue = alloc_workqueue("radeon-crtc",
+						  WQ_HIGHPRI | WQ_PERCPU, 0);
 	if (!radeon_crtc->flip_queue) {
 		kfree(radeon_crtc);
 		return;
-- 
2.51.0


