Return-Path: <linux-kernel+bounces-839787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB89BB2683
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 04:58:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 049B34A0275
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 02:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3528F28BAAC;
	Thu,  2 Oct 2025 02:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwCU5cbv"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274B92BE652
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 02:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759373865; cv=none; b=N4m0dpvkn/RHIX2bZ9mtSTMQ/Q+Yc1Fj9Y0bm0P/U7s40A2Nuj9MjnbASrShCM38QY5xKK4Ad8ytaEPoSw0ybGpnbhttWAP3vHZ6S7MRUVwt0Krli+DnyfbkwYJmso6MgHpWkZ9goQLxC+cxEhsSFPRxYYKqbkhUzcqs4UpVUus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759373865; c=relaxed/simple;
	bh=caEnrJrbDTSnBBK/eonWkRY3j1UDsNBgc2z4QmoRzU4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Au6yBr6wD6DK30wwBA623suSGb/YqgHfYLHnFz7BzDttYfLXfACn6XnMuUhah/07OfL7xh2tmy1MUNqX2p1PQRE2/c81EDQ3/XSuOGv5q2Wov5W4q+8XoC/71t33HD1QOIXeYtsTTWxRZbny1adisTKfrgwHMnWxWVpzjfzZ0ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AwCU5cbv; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-78af9ebe337so455712b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Oct 2025 19:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759373863; x=1759978663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J82Z56xOWTI27M4LZYheLiy5OIEEBunWj+Vbpah8nWE=;
        b=AwCU5cbv4nS9H3fxDuimuKYG/S/w0oaV72jxSqGnGAMuG3BEhQ3+Izh7pZ8ZyHAjMg
         Kv+1WPPt2V6zlu8eEadR2a/fn8CtcAsA6rjDK7wtG/08dm2BHMLQD86DNqH25RvY/ofb
         Nqzlx+H/1i4WqTFMLxXKkXo99eggmMyyvPmlOzyLZXTSMuhdEEa3rJvmCV8/pPhK/pCQ
         Us1ehVoLpnNOY45WsbUSWBIh7Cm7wH2fuTZ5s9coLIR1EsmdLiPSaleNNDvh8VZ02NAF
         EbSjuBVhdEoJSC9kwX3tRgb7XeHoouc5Y03pgtsoQOxvnSo5fuXhCRNxkjCuuqhHep+w
         owFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759373863; x=1759978663;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J82Z56xOWTI27M4LZYheLiy5OIEEBunWj+Vbpah8nWE=;
        b=oiFxqP4NqMyWs6OwFIUf/9PZ/iGkDbN1FVvZGbr49iWdtaeCLj+D7z0+39wcnWwp9B
         Jw0k4jOQV0pssvFuCrD3RaLmdYyD0K8YQMeNo4ieyQ3CnsqZQl6Kjppo77FfaoDfRTZf
         aVqds2Va1iyDqsyfUrZ/Fo93zdkXEgwh+WHfJGh8cM4V6VtR3JU2a9xZ3fXIcODB1WYV
         yRm5XuebCFjsKw3F/WBWrW14oOQkkOKW2GvPkm6ceW1MsJO2dn8FCx7g7JM6wPY2WGDW
         DfquZptpLFgIUpU0wZymB1Wy+E8AGQKlR+hp51jIQEn+oAITKRWSb9WMOlL/NrHjYfEG
         1F3A==
X-Forwarded-Encrypted: i=1; AJvYcCWz2Nc2POSdLGeu1s13Ax72nVBU7BozwpFvv/uNt7npEE5HN+3cFvZTszAL0OLradvzb0TPjTGIK8xKWBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxS7NoVA3PIrPPwba9fxpdPSGb593ak7v/4vY9IFOL7REs1EJ94
	Pi5/40NNGMvP3p+NFEgJYchJxR02EdH6R6XnROCALsg6Sgf2hA9L0YzX
X-Gm-Gg: ASbGnctvotRAADzyw7n8ZKdvei2iRWgaBb7y5KbF9NCsCaeDV8mPkROERkn1PQEGjHL
	EyuJ4MiX9olGyeI8nzaNZ0dODpq50Bp4IqXsznGaYtMyyaGJTCH3iygYgJ/UMWYMbtJs1a2R4PE
	T5hXTZ64DUgfCNbvXt5l6nub46F7WGdr6RVR1+1Fd1k/H2ldPYZEE91Dzu8NGzvkR0Dn0ZA6y76
	4kyArWRAKqJBpwU/pYazJ0omDrfAz3pmjvavoGXTfZ3j8cEeAIlnIdJpLTcKqr4lM1OvTsf4zWf
	7A+RQOSkiAvPOvzFVpWlGaBvupssyyCf+BdyTcZ+bMNiih5OHCYVkOfry8JRzGh0JSNg0sOjndf
	7lqmrGDtHPFMlJJPJM7O6Owgu7ukao6zNUxJPFiw/HGpa6FUkhv0JKsOk8fccICLtOCvKCU2C7x
	dXLQ==
X-Google-Smtp-Source: AGHT+IELr6NndrKlAnm5EF8uU1znjKk+zekuloU2u1bUXPL0pBVBvgbb8LT9E38aM9+bGWXS6JGmgw==
X-Received: by 2002:a05:6a21:32aa:b0:2cb:5f15:ebf3 with SMTP id adf61e73a8af0-321e7e3f5dcmr7711795637.44.1759373863298;
        Wed, 01 Oct 2025 19:57:43 -0700 (PDT)
Received: from cmpatel-home.hsd1.or.comcast.net ([2601:1c0:5780:9200:2327:e4d:63c9:c38d])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099f73537sm849839a12.43.2025.10.01.19.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 19:57:42 -0700 (PDT)
From: Chintan Patel <chintanlike@gmail.com>
To: maarten.lankhorst@linux.intel.com,
	maxime.ripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	syzbot+147ba789658184f0ce04@syzkaller.appspotmail.com,
	Chintan Patel <chintanlike@gmail.com>
Subject: [PATCH v2] drm/vblank: downgrade vblank wait timeout from WARN to debug
Date: Wed,  1 Oct 2025 19:57:23 -0700
Message-ID: <20251002025723.9430-1-chintanlike@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When wait_event_timeout() in drm_wait_one_vblank() times out, the
current WARN can cause unnecessary kernel panics in environments
with panic_on_warn set (e.g. CI, fuzzing). These timeouts can happen
under scheduler pressure or from invalid userspace calls, so they are
not always a kernel bug.

Replace the WARN with drm_dbg_kms() messages that provide useful
context (last and current vblank counters) without crashing the
system. Developers can still enable drm.debug to diagnose genuine
problems.

Reported-by: syzbot+147ba789658184f0ce04@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=147ba789658184f0ce04
Tested-by: syzbot+147ba789658184f0ce04@syzkaller.appspotmail.com

Signed-off-by: Chintan Patel <chintanlike@gmail.com>

v2:
 - Drop unnecessary in-code comment (suggested by Thomas Zimmermann)
 - Remove else branch, only log timeout case
---
 drivers/gpu/drm/drm_vblank.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index 46f59883183d..a94570668cba 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -1289,7 +1289,7 @@ void drm_wait_one_vblank(struct drm_device *dev, unsigned int pipe)
 {
 	struct drm_vblank_crtc *vblank = drm_vblank_crtc(dev, pipe);
 	int ret;
-	u64 last;
+	u64 last, curr;
 
 	if (drm_WARN_ON(dev, pipe >= dev->num_crtcs))
 		return;
@@ -1305,7 +1305,12 @@ void drm_wait_one_vblank(struct drm_device *dev, unsigned int pipe)
 				 last != drm_vblank_count(dev, pipe),
 				 msecs_to_jiffies(100));
 
-	drm_WARN(dev, ret == 0, "vblank wait timed out on crtc %i\n", pipe);
+	curr = drm_vblank_count(dev, pipe);
+
+	if (ret == 0) {
+		drm_dbg_kms(dev, "WAIT_VBLANK: timeout crtc=%d, last=%llu, curr=%llu\n",
+			pipe, last, curr);
+	}
 
 	drm_vblank_put(dev, pipe);
 }
-- 
2.43.0


