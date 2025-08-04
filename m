Return-Path: <linux-kernel+bounces-755406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B17BB1A5E7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 17:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F5A8621D41
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 15:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28E90277CB1;
	Mon,  4 Aug 2025 15:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e7nVCRSY"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6AE6277017
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 15:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754321056; cv=none; b=im6nTqPSZWTttBDJaxQWLnZJLQ62mQwYApdHVc4MEFJXidRJPv6mxljFVQJbvGx97hElfueQDKVqSfjgW8YGocQoPmMlz0+UDKfz7QBkLtjbyUAefcux33MYTtaSLYqn498mMHa+nghWYLfregHLfDyT8idSQJjAl/ZyEp7ZBIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754321056; c=relaxed/simple;
	bh=0UvZE3k+XFIsWL7U4sT1dC/irQDhudNW/Glb0WMicdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X1GPFqCQKIoMUiQghEprkIvMFi9ta7y76vCOoKRlzx/5FhfUHaW1wE3Z3nVK0sZbab6U7xM0hA1Hq91TiDKfYVWlqIxvUt4KGY30qtzyXk2pQLaFrpdW31Guxgxj/xrrIpToRMWdmPrfBHq/UYTrvVfzLuQcNe6cBgjpGhOc6ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e7nVCRSY; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3b78d337dd9so2157421f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 08:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1754321053; x=1754925853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MSMHDKm2fVBb5I+HzgHVkcktydoNZjtlzbBXl5Tc0aw=;
        b=e7nVCRSY/DwxDc0ow8FMCuAZ2rfNNrTmPb67oCsnoEz4mcv4ffR1cfX+L5Hxgmlu/W
         47F64ulDzA+gHsUlaJ+dzNDn1Ibc2Od36XkrzpWk1eLqmXYBOYVfztxIKEp/vG0i7LK0
         MmkNO7POnBLcXZg1lvHxpYdvzRxibvs4ZRDgh2fBGT0YjihXBqhvAJmh6zkcsIY7A8/j
         aPcKpenefvveIsqQUmSaneBdbEeVYAtic2DB0bCz/reQdPvywdHOt/Q+u35MhJheh9jb
         E0UIzHlBLE8O2+FyaNJF+nfNGEM1BNsPo9N8CUVvCo8MkJznq3nk7N2ku9AkhheWzq6+
         efhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754321053; x=1754925853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MSMHDKm2fVBb5I+HzgHVkcktydoNZjtlzbBXl5Tc0aw=;
        b=VTHMqW80Bm3SiBXSwO0pyl+P9rjK+ITpFUMnpd9GcMkkoeP1Xw14ZZZDs8GAOhrHVp
         5lfBz/EjAr58V7DYu8g1rO7wQSlYc6nB3TQE+wVzsDxGzDxwRCULYAfBoXQ9mOYi2guG
         JmMsVI5ZGJBy7g8227dDAuzKgH1N4SHuphX41g6IZ0NpPZ+WZvOZCp8Bik9TXV4fpuO8
         TKA7M2Y8WYUY4YsUrpJuTeCZNTLzIFI7+RX8VXa0TPgeu80SaYrYtfMFm9K6xvixFbL7
         I+M5f6MwX1WoFygzr6Q0jhje6BIRaMoVaMyTIUbGgvI401azcgilMIr2N3B354Ug3NOJ
         fqYA==
X-Forwarded-Encrypted: i=1; AJvYcCWZjDVt4gHBYttGm3OF0odp/5htDaUAVsSDZkFEMCGP1GaYsol+3AUMG+08xKlS1jK6mvhNrZKkq9ej3Ws=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1iUOy/9NosFn2pn3lmht0kqDU4hojD3EuESdDD3ggWhrA6uds
	wapjG429vp/EfBiv6v7XcDxQLtLuTmHHILfxHbMIATWJ6PWjboc4scEWjIgmhPRYry4=
X-Gm-Gg: ASbGncsYRUVGJht28xBgThcN7EkaszVlu+QZ83YDDOae50rnuU19Csnyy737/bry+/2
	OjBYFa7a0KeckS1h5YhlQhACw8p5S+5iiBC0Qs0pF86/ZTZBXg6wepZ0NmM4V4qnNJFvJk6F7EQ
	DgBTGtDlXstEHOy/b+DYnTQuJvdBu7IbUXAbznyo1iCKM+G4IYjhZEjYeAmxjs3bE4+JQ0tb3AY
	naAgLs0CydojYpFtv90UrhqfYZkXAJr0+MsQ0m7lWewKrS2dClAdet2/tPPKq/CKLbzUZzFOtyv
	TNoeDgzn69qCKKfZFNayvFh7ZypLffPjoOOWWyIVs6SF0wnsCeCGNdl0VNs6SkYymeWqV7yToET
	N23U+6BA3NFr8nypv+BxquQmDTHTMvk2dnYbtuHFQZhVL1hvX
X-Google-Smtp-Source: AGHT+IHHSKgAOk2QSQQTS8KtsNeLFrmfp5jVQGwgWUaRhP71DYG7ooscPk+f2g4vk2n5Dyr8OqNoYg==
X-Received: by 2002:a05:6000:2381:b0:3b7:9c79:32bb with SMTP id ffacd0b85a97d-3b8d94bacc9mr7805669f8f.44.1754321053029;
        Mon, 04 Aug 2025 08:24:13 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c4530b3sm16335579f8f.34.2025.08.04.08.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 08:24:12 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: daniel.lezcano@linaro.org,
	tglx@linutronix.de
Cc: S32@nxp.com,
	linux-kernel@vger.kernel.org,
	ghennadi.procopciuc@oss.nxp.com,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
Subject: [PATCH v3 19/20] dt: bindings: fsl,vf610-pit: Add compatible for s32g2 and s32g3
Date: Mon,  4 Aug 2025 17:23:37 +0200
Message-ID: <20250804152344.1109310-20-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250804152344.1109310-1-daniel.lezcano@linaro.org>
References: <20250804152344.1109310-1-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Vybrid Family is a NXP (formerly Freescale) platform having a
Programmable Interrupt Timer (PIT). This timer is an IP found also on
the NXP Automotive platform S32G2 and S32G3.

Add the compatible for those platforms to describe the timer.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 .../devicetree/bindings/timer/fsl,vf610-pit.yaml         | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/timer/fsl,vf610-pit.yaml b/Documentation/devicetree/bindings/timer/fsl,vf610-pit.yaml
index bee2c35bd0e2..42e130654d58 100644
--- a/Documentation/devicetree/bindings/timer/fsl,vf610-pit.yaml
+++ b/Documentation/devicetree/bindings/timer/fsl,vf610-pit.yaml
@@ -15,8 +15,13 @@ description:
 
 properties:
   compatible:
-    enum:
-      - fsl,vf610-pit
+    oneOf:
+      - enum:
+          - fsl,vf610-pit
+          - nxp,s32g2-pit
+      - items:
+          - const: nxp,s32g3-pit
+          - const: nxp,s32g2-pit
 
   reg:
     maxItems: 1
-- 
2.43.0


