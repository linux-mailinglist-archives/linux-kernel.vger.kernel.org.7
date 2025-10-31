Return-Path: <linux-kernel+bounces-879994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E21E8C2499E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8D40B35008E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 10:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CDBE340DB2;
	Fri, 31 Oct 2025 10:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RWsq7Quj"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066F4340A67
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 10:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761907734; cv=none; b=UKv4h8ULUI/+GU7k3vs4ZV+ivlfy6RVsBDv42G4Jj+2PmJLcTAtjudY3H94sbT1cspcyXnWsEKX9ojoWthrW5ONYR5PFYv5Ybj8K4oAzEC/RDyvH0i7PdDope34T86CR4N+0fnrZdWEc+lcfvJwNDMxSyJKMaH1zFh7kbnU1hlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761907734; c=relaxed/simple;
	bh=Y7KqlH0jgGsbG0apCFjRZ1OIFfkb2CeESscso2XsCvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J9eDGunrhVW2ubJ+UXga4qIsR2ruc8/zUgWaWMpqDyvOCM8ad3uJTRW+/XkMzyNEivUfjFy3cDjOXBZuTsOO21k9i46LOY+G809jLVbMJx61ZnODwRPPWExhDA+YSbc8w949WHUm84CpXwf4oIUBmHIF/t/lbBe5BnwH6XrEyAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RWsq7Quj; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-429b72691b4so1874632f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 03:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761907731; x=1762512531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBWYxLlmhmMlhJEcwlD766MutyyLNrX1V09UkWZeUf4=;
        b=RWsq7QujtWbL2MenjA5KsMAupz/+YrZxSCC1GcwadcGFTd1mq/PfbqAvwuOMNZoT29
         shpG2iZ1pDmBwpNAdWeThA7R9fU9Ri0DPJCwKR/+5Ms6xOt03lfb6n6sQp8hTcPE1pFi
         m4PSwYburRcWn6vkANHkh0oKBLiEwdlqvxWA2W2rQK3phb9P9McNYyTrJ3/MIr9HU4Am
         vz6iL6xfPhwJ51I04EXZVjQujMnvlvawJsYw19FyUTvD87Z9bjw8RtKfkKqOYD76Qvno
         R/WV4+0KJ6fRpN7VUMnJeydFJtjgIwU4JI4AvAAXWdYqbItB29L2Su8rrwFizQXWWDT/
         mzmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761907731; x=1762512531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OBWYxLlmhmMlhJEcwlD766MutyyLNrX1V09UkWZeUf4=;
        b=wx/e0mGSFJaUpVevhBkpmVE9yq9jodzXzFFkNT8ohOkfql4bHAcH+AmBWRfwI8/4in
         xs6SnnQ2a8ScDeXvxErVeUn9+XAoxIRff/H05s/6oQzpLxYwxt5JxW8ddT2wqgfi/Jau
         0IfRkVYHnNhm3O9/j+ozhX4eDOoZBObLZeK9Jk4Dpb43yU4bZMXC8bT6KpSeUhVNipNo
         4mv1b+evpXCc6ulZMWNS+/vi+jnrvDVD7HcZ5pGLgtGY5gjloANbNdKA09BrIJx8QHx9
         7oZsW6X5m+AzP68AaaWiAhiafzsG8tLjodvj5hPDnqoHL+Se/otCkY35uK7Wjy+X2daL
         tkSg==
X-Gm-Message-State: AOJu0Yxi59fHbEdwW4YztRcSOHrMBSyw/sXxFe4Trzx/gjanYpTx45aK
	enkmQO5H5TvYsTT5DFeth0p64qJkLfJcNCU2Zn5QEE9n9agS1vNEkBJc/xNWZtyWtWQVnzUgnMz
	h2Ik/
X-Gm-Gg: ASbGncvuD3HUxEJkjvsbD1UpqB1SwPUQBf2Tlby1oSLA3OES2Rj543oFhk0KdUm2GTe
	qHmQCJRYLpqpLrUSijfd4dGLrJu9XNd7ap4lrtoHjNFUtUZaO8VWIYEnbcmgmfoqPQnjYJDd5Wj
	Z1TmjWg1/aEqJ+H8Fbr9yis7oCChMpd5qV5qBHsCUkdPye76gaXH2CVlZE8C0PWNowPUgTcZH0B
	jixhNdLDxGIV0NUMXbzsig1fZZWtBBEcjMYat0c/RfQQfFSaza/tX8Zai3yIdIsJQbMGF+mDzWU
	ZjOV5AHNOREAju8K4/Qdiv1oO4tVjnCjBDW9ltaRsrpK8mZSSvlkR8P4e2y4jQGRYsIyPlOpOau
	YCHFM4tMFT5gRXFPqHAbfaHcIK9onKw5LxUvn8vGBTmblC7tQRilU/dkkbdUt7kHMeSV1uFYLP9
	ZZZxZ/P3ylHLgwqfwL06dMDbFHq00ywiYZLDg=
X-Google-Smtp-Source: AGHT+IFXAzHg/iq6w+vdzj/m/7FqAE/8oRdJB9oVXLVeXcIgN+TApftuVAX0hFowdEb6GbjwPbphjQ==
X-Received: by 2002:a05:6000:2407:b0:428:3f7c:bcf3 with SMTP id ffacd0b85a97d-429bd6bf68emr2653726f8f.49.1761907731032;
        Fri, 31 Oct 2025 03:48:51 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c102dfd2sm2961635f8f.0.2025.10.31.03.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 03:48:50 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Sandy Huang <hjc@rock-chips.com>,
	=?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Subject: [PATCH 1/2] drm/rockchip: replace use of system_unbound_wq with system_dfl_wq
Date: Fri, 31 Oct 2025 11:48:45 +0100
Message-ID: <20251031104846.119503-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031104846.119503-1-marco.crivellari@suse.com>
References: <20251031104846.119503-1-marco.crivellari@suse.com>
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
 drivers/gpu/drm/rockchip/rockchip_drm_vop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index ba6b0528d1e5..18393c8671eb 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -1770,7 +1770,7 @@ static void vop_handle_vblank(struct vop *vop)
 	spin_unlock(&drm->event_lock);
 
 	if (test_and_clear_bit(VOP_PENDING_FB_UNREF, &vop->pending))
-		drm_flip_work_commit(&vop->fb_unref_work, system_unbound_wq);
+		drm_flip_work_commit(&vop->fb_unref_work, system_dfl_wq);
 }
 
 static irqreturn_t vop_isr(int irq, void *data)
-- 
2.51.0


