Return-Path: <linux-kernel+bounces-753657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3416DB18602
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 18:47:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 615C3AA0731
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 16:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0191D63E6;
	Fri,  1 Aug 2025 16:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kvd+qwF4"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2924119F11B;
	Fri,  1 Aug 2025 16:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754066858; cv=none; b=isWjOlQN0qKlHYaRcx53OPpXX0XMrGX52Ze5okY8QEzSXJXNOdeW0n4hD1Wy5WblKVMHMPB+TBhUVh9nhFO7h390I9rjCilRwTZJSEjjYrqesoiRb7IBy8cPLqn0QUdgZCkRi1hXDjycNTRUz5g8/znpE7oxaVv9yhOr3jo4Vt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754066858; c=relaxed/simple;
	bh=DVXPceWoO93W5jGMpS+eELG0qt4eRAZ20slZ67jjaMY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dkN1oCK7tiLGZigJ8QjC4AGeIZTXDFwvGpTWWxWtF7GIdPQhZh8iwXBsvZ7FOLKQAi8HiHEaSViO7Ouhivv2TOLp3QntqRe7QmVjn8RYf0d6wGipR+kiIIwfmzsjizSZD33KtZ/HvBPhrdKgBoutpFr+xzWAEmpcoEYW56uAZBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kvd+qwF4; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3b783ea5014so701896f8f.0;
        Fri, 01 Aug 2025 09:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754066854; x=1754671654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sjXi/K1zp/KJoXcAj8C+uMEFA5tFC8307SkRQQtBdaE=;
        b=Kvd+qwF4VM02VPvna5thcli7Pfe8hYhicfuS5rBYtpxD+aTFxq9pS5jr/FHlPV1lMh
         b+xorJMonXnJYkI0lmeyfEJIRvUH5LZ63ohkh2HiVOtjAORjOoMm4DYtVmwsuP6n7moh
         mS20mrTD+1QPpLbE/9kBzAuz+NgsD0NgIxUDJaBfEbBM4iVPvvkmUkkkVBqMy5N9Fr2D
         QsuhI8kk9I3KVwB9MA5j5qJ3C0Y5WUuGh7Lrpnnn/VLSMQP9Lu8p+QjfDWrPB8wlhwYw
         aZTWAymp+B7kyt3o5/Cw2UyCq1qAjXwforqG74V2TCugVfE/8wr9g+eUN/TP3R/J8n/+
         2m1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754066854; x=1754671654;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sjXi/K1zp/KJoXcAj8C+uMEFA5tFC8307SkRQQtBdaE=;
        b=p5uSCrzA2vctua1hzqxZWcVdU4uVLolaRLyyUZaRuaYyR2s9eRic4MeCB0QuwY/LKy
         38JE1IQg9LvhvqIFmE+79ap5BWwUh0WMoglw6lAoxzeyjfLCd2uvMc9K4zDi+8oSnWTS
         62WK9VEkkhjJmqymAED2/+rC8LyW9dW4vH0waXvxd9Kl1MI6Um0/7Jfak0kWtWohyaIO
         e6/D8iTBRBweQ65b3wmfu8rQZ5gcXp7OwP25AGhpgnP1dUa7POunFglsJfWftsq2N+nQ
         eY3lvhQdgiSPsLHoIt1c1FlY6bsNc7nIhzRRIM9JtW4xQ+UeaA6DSU/CiKiMIaZpOFI0
         /heA==
X-Forwarded-Encrypted: i=1; AJvYcCV29vVEJ274QgMc/yF0iJxNgYg2hVlRBD2dGG+BC+ErrSZyTvoEGczVlafz+uFpNUSUai9aeZ+iyNgRu+A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvoidh9fVmOpc6qpgv0K50b6Yv6eRE44BPCz3YUSiUrq+HGJqn
	lzeWPXex5rU7Pc43ZskYhetyK4x+lPWm1jjCDwza0q7nkIPJ4C7JU6LA
X-Gm-Gg: ASbGnctZm5XdEjlfVM5uc7P1V8Cm2hEFwyvKTBmlYYmBdJryF3n2lVZjieHBAk/HVrb
	R8JoVo9mXe0BWa+4bOCH9Nxxp5muZ+r63zCF8x17gDmScN03GDHvaqrNSVMD6uKOv3kauNynHaI
	ZhLdp1mLEGbZh7+TPgJsY+zohMAsH+S55XTCOAp6NCni0TIAtLDYPqA1SHFzriSyF7BhCcPta3B
	NLBKEGXJt2r0Ryd78GOTt/KcC69epjUD7WZb8H2NM2KTMRVv/mM3m9YpI4JLhQkwflB6iTA5AmB
	XMi75EbCPjLZWBUovxHE0ZuvLKsFL1oOnw4BVNLvkYMsX+8xLef8F38RA384OrGCGckeqJ/apVc
	LkDEEWB9tTHe3SIyC54jd
X-Google-Smtp-Source: AGHT+IHRUIFfk9gz4OB4Y+SE7zftDanV1i9jiDcD2IjcPO99vt6qOHujHP5z/UzIOWiXBR0Xkfe+wA==
X-Received: by 2002:a05:6000:1acf:b0:3b7:930a:bb0d with SMTP id ffacd0b85a97d-3b8d9470d8dmr446930f8f.20.1754066854170;
        Fri, 01 Aug 2025 09:47:34 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b79c3bf970sm6418504f8f.25.2025.08.01.09.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 09:47:33 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] drm/i915/bw: Remove space before newline
Date: Fri,  1 Aug 2025 17:46:58 +0100
Message-ID: <20250801164658.2438212-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is an extraneous space before a newline in a drm_dbg_kms message.
Remove the space.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/gpu/drm/i915/display/intel_bw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_bw.c b/drivers/gpu/drm/i915/display/intel_bw.c
index d29a755612de..ac6da20d9529 100644
--- a/drivers/gpu/drm/i915/display/intel_bw.c
+++ b/drivers/gpu/drm/i915/display/intel_bw.c
@@ -359,7 +359,7 @@ static int icl_get_qgv_points(struct intel_display *display,
 
 		for (i = 0; i < qi->num_psf_points; i++)
 			drm_dbg_kms(display->drm,
-				    "PSF GV %d: CLK=%d \n",
+				    "PSF GV %d: CLK=%d\n",
 				    i, qi->psf_points[i].clk);
 	}
 
-- 
2.50.0


