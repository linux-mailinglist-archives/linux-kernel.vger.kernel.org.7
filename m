Return-Path: <linux-kernel+bounces-773402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5246DB29F5A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 461317B14CE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 10:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419012765E6;
	Mon, 18 Aug 2025 10:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CyQ4oDw+"
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5D02765DC
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 10:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755513901; cv=none; b=qJ/YUWz9zVridHjkuYT+1EEJbBiMUcrCf2TgQt1A4DgBw9WkR1Kg52uWSFIFm1ojZC86evp1J0u6a19l9PbohRNmkrcy12lUCFzuiJXKbr1LQ+k5tP3Bbamjb9EJ7ifF0Lgk1ZZGFL2v7KZ9vzKzWLVdxbTspk63RGQnN5/7T6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755513901; c=relaxed/simple;
	bh=MBA6o00TkcecMryApG+WnoZ7je8vQgyjmV3JMU0jG0c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Giw0JcZOhN9F1OUBSS0rSrO7LswBuJNQl76ietSPDDh11kFr+tGMCNa28t3pJzX3rNqnenEFzAG3WRiJ5u4NqutiDvHfGiLtAsLCK7yJnOpbwQk/IbOlw0FAwl29EXuOddKmVMmRel927UUythpyw1yblYUXVsrirqtx2HKON2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CyQ4oDw+; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-321cf75482fso4436785a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 03:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755513900; x=1756118700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zI/Nt7+AGO/rMAajmGnpXgwvKkgy60LC/B+5yT8wMm4=;
        b=CyQ4oDw+AMo3W8KR2eoWaD0wqH/cxTw2iAToqNI2AFRoWa4HjbuADJBN9B3Gag6Aq9
         djuWtMNB3dIqq9C10cnAZdY8aIurCsaQFmp2UA7HquR1okP7OI2SYhQ1yziz6quodUk4
         W0wRhOsF8vlI8MQDrNiUO2CZsuDhY7KIvu+vWeIrUSfidHHiPyyVt9RdrUMpnwTyDWs1
         5iq4AxqKkVweSysE2tAnGJtX7bu7XqC/Ij7kDWTq/cJjmeLsTrnnjr5HiHUt486krKOP
         zVIWMKEwWkC/CM3Q7lCZCH47pKbix/BFO+bEEcTXFnqCXkoPDcflKAyVfdvLzlJu1GSq
         EdTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755513900; x=1756118700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zI/Nt7+AGO/rMAajmGnpXgwvKkgy60LC/B+5yT8wMm4=;
        b=uWxjxh6jiNx0KfP9tVu3vjNvWUrwCCkbqeuNoPGNexEBKJqlILC0dKq2ta8NxNd/XL
         xj6TF1sS2+zCwky9EZGAyAo73QK/3NMzyQNmCfalRSw/qpBfG2e2kyjXoJSjTmrxkd8X
         gkYdKTXHc/fn4ZKGVCirj9j6Fwl1lQt4vDaj+7J+0t2WBn8Oj3EQltOOOIi6eaNXAvmw
         Xwj8p9dvviF5ZzG9uSY9mCf0FLvABuIwKHxtC/4TdWUm1Xk55WsmOY8KL3spa03CUWZJ
         4g0XM2UD5iueyznU6h65HfPgtpuzyybwMOytvH1op9O5/3gYImmm+UrCt3gzV+puzjeO
         BZ/Q==
X-Forwarded-Encrypted: i=1; AJvYcCXHXISkkzyuc9DarFicm5kKp23dVjMlYuOoCRM4iHSZuHaRaRgTojsxCbvezeag9WfIBUpM7aFjS0CaFSA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeNyOXguMXhqlPPNi2H4/I0lrHBASTJq7e0Vq2F5XhrO4UMNmk
	jtMCsgQulYCekjmkI5Bs/MECGi1W/1M+BIhgf2w4wdQy+NGykHyN51F8
X-Gm-Gg: ASbGnctvE0hQT/TEy6WlpNaug68ZJ+lJySjR0wl3jW/fnNbbAAqj83s1el8FDoM5UmB
	oLWtGKOkEHcS1svhTT5tFgUmv/fpKoHa2gGDQkC6IKoWB7wTlfJRPJ/4eTDnZxIFBrJ+H8DTauG
	wVNNmX8TcMfxYKSiLDWS2hEWqiysnFaiitr37qJi1I602+z7XZs2G+XqJKcNxbsxncllOloX0Ot
	qVb6iQ4W3uJLBJFxy7RhtQOhQzsZCTJqnKlW7ZAtiyERKkqAR8hAekKu5lhKmfeJu3OV3o+eg4E
	ucGYLWqGhvs8QnlFhl5kw8Uz+rvvsrWQJvH+VOiXWEeH2ywrLToGp7k2zLm9MuUQQ62/kauvfg3
	c6ec5Nx6U2ogEWjgdwm00f0Mi7DF0p3AttBrOJDbDKwNalSc=
X-Google-Smtp-Source: AGHT+IGc3taSpgAHHOh+V9gwAudEbx1xMbNbGjmO8awFFHCg5952fVvLo7stUlBiQSuCkc+xHp06sg==
X-Received: by 2002:a17:90b:2c86:b0:31e:f36a:3532 with SMTP id 98e67ed59e1d1-323297ac223mr24272393a91.13.1755513899400;
        Mon, 18 Aug 2025 03:44:59 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:8899:4b76:ead:acf9:f900:1070])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d5a6df6sm7793773a12.1.2025.08.18.03.44.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 03:44:59 -0700 (PDT)
From: darshanrathod475@gmail.com
To: lyude@redhat.com,
	dakr@kernel.org
Cc: airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Darshan Rathod <darshanrathod475@gmail.com>
Subject: [PATCH] drm/nouveau: move assignment out of condition and fix spacing
Date: Mon, 18 Aug 2025 16:14:51 +0530
Message-Id: <20250818104451.916585-1-darshanrathod475@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Darshan Rathod <darshanrathod475@gmail.com>

Simplify conditional logic by moving the assignment of pll_lim.reg
to reg1 out of the if() statement. Also adjust spacing in an if()
statement for consistency with kernel style.

Signed-off-by: Darshan Rathod <darshanrathod475@gmail.com>
---
 drivers/gpu/drm/nouveau/dispnv04/hw.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv04/hw.c b/drivers/gpu/drm/nouveau/dispnv04/hw.c
index 8b376f9c8746..165ba41422a5 100644
--- a/drivers/gpu/drm/nouveau/dispnv04/hw.c
+++ b/drivers/gpu/drm/nouveau/dispnv04/hw.c
@@ -172,7 +172,9 @@ nouveau_hw_get_pllvals(struct drm_device *dev, enum nvbios_pll_type plltype,
 	int ret;
 
 	ret = nvbios_pll_parse(bios, plltype, &pll_lim);
-	if (ret || !(reg1 = pll_lim.reg))
+	reg1 = pll_lim.reg;
+
+	if (ret || !reg1)
 		return -ENOENT;
 
 	pll1 = nvif_rd32(device, reg1);
@@ -747,7 +749,7 @@ nv_load_state_ext(struct drm_device *dev, int head,
 			/* Not waiting for vertical retrace before modifying
 			   CRE_53/CRE_54 causes lockups. */
 			nvif_msec(&drm->client.device, 650,
-				if ( (nvif_rd32(device, NV_PRMCIO_INP0__COLOR) & 8))
+				if ((nvif_rd32(device, NV_PRMCIO_INP0__COLOR) & 8))
 					break;
 			);
 			nvif_msec(&drm->client.device, 650,
-- 
2.25.1


