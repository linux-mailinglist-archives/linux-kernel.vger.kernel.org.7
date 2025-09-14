Return-Path: <linux-kernel+bounces-815639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD549B5694A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 15:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E8BE17CCD0
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 13:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A4D221FAE;
	Sun, 14 Sep 2025 13:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvMmUtNl"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EFA1D9663
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 13:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757856225; cv=none; b=DQYhcroHom02AYyhkZKEJ/UvkTd4Hx/1b1RAIOcMAKa+cdrPoW35R6im+Un9Q/fEPgc7t0hA61yP+acMy+kESmg/vMq84Ixm8oWxfNFN/U1Gk5D8zWtutmuNws0RojklS0Tkm5+P2Jj56alNGcvtMHzvFWyvnrACQ9kOzdHnbHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757856225; c=relaxed/simple;
	bh=noXhz4Y24g4PHVqA3gPgMnDwLUm3u7HC/TSG+gMVjrg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gsjwR/uZtY3dqjZlzy34Btrf77LEOPtMcKi9ZI7ZEK26EoxxyJ8wfvZmTqbCsUTkBAFFVNmpK7sd6PX93DgeB2vVbf4yKB9TDZGFgShLzCfeUGzHjfwjvaRj9eyrhAp1oZKe9bK1ztzTSKHNB9aMhJaPbJIssA3347Ma0rfgh+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PvMmUtNl; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45f2a69d876so3086655e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 06:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757856222; x=1758461022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kaljxPkcfQHPyVYy5h8ZrWxk1AbMPnNmiDPm6nh1Er8=;
        b=PvMmUtNl902pqZ+1PCWZWhFfD26WqEdkDtx5KNSHi6DMvpS+qGn3Lmdi+AHAl5dAMO
         pQc3OHxArbWhcSv5cDNq1og4WbP4HMYRXMVsB2WvxccAMBVJxCAC4S+Id4xnVeSy03CY
         gYUx9Xx2uPUnEnA80lpLNMIVKcOYANPovYfQkcNwl+s+xxpO6x9wcINV1nFG6v47vPKq
         JMyW3Pld9PXmyGWrcV4E9eOaO7AtbS0YiPQOWHVgSGzQq/UoU2EUhjr4QkU/nKmecVmj
         zLW+dT/j+BsDIdBSPd1Tw/N6dPKy/pqzmKyImDhkv4uQyCpcWFjJhFU/Nq7fkV0HQnR4
         WQyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757856222; x=1758461022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kaljxPkcfQHPyVYy5h8ZrWxk1AbMPnNmiDPm6nh1Er8=;
        b=o/NHO5IIaqw6xgWt0RBGcvRQAX2I8EXDQmvRb9gLH+YB630Qkm8W0tJyPlgyj6z9ul
         aCB/P/whz6BGrM3TLFiBPrmFmD/P/oqpXRlo8Se3GifObwsYL9yf2fuCoobsVf6ldwCJ
         1eA8vfUaQoISDAOrCAIwG+hCjhHzAWaMSp9Hvrsr0rqMl/Eygjy6TyvwVT3ZqulNoJVV
         1z2AevpCUT/s1zQ2Wpe3Ip6H3FdOq8y6MVLVFtWXMmVjKfAhz+nQCYSIG4/rCTrWBtJ0
         6QMpsqwdm6oujdV70PlVyhHobGzrQZ5ZNUZ2/d0woUu2i2AE1Wc5yIzXhhUhgFBxCjTY
         msFg==
X-Forwarded-Encrypted: i=1; AJvYcCWRXdQR2iR8hC7gY2To3jcd5Dkt4MNvA6gvruSpRnQxVYxihMk87d6DXeWe4F1sOe4HLNJGVGvWqOQ4buw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkLn5PXlZ23IAZeZqmfY8Q5nOHwv9nZTyH+Ve16g7Fo/82sHsx
	J4C8uNTRi5/GEl0Cg+21qdswEU0s+Jnf+8NelM46mL3tG0FO9HX+e0fd
X-Gm-Gg: ASbGncsLA2PQiLnTvYSe4N35hVIQwT7SOwZylRGd5fM+CBpW4p2S35t8ny9IfeeWG0C
	xfIIDriRTOqlxAv+VVI7Vgxgw8k3ty6pGbkObTvW2JcFtSjhFSIaOnUTX1lW/WwNGtJNgJx+rdf
	2hLE+cXKZ4WWRrSF04Qj+BA+6ikY/YEjB8pxam3bWQFxSRMFZj0p4gloyOy2FCRWM43xO4MeD61
	FWhBWa/MGeydIX6oNWYReDIq/jP17Rk0LpfqSveYCjX94ov1I3RarAap8B+7AZGNaGG+/jrfsp0
	0c2QUNTypCGdFRMxq8WIrrvdlow9Shjule0PhzbTHXRyc/AC6KfMZeki1ItnlWlYOWwXMiXaNzB
	uSSO1VRpDqkHZilDmtoXXV4AgCAvn936cjMsP4zn9CpEHLqLV+UASi2q73wSiSE941MPXysueT3
	pq4Q9RZdrn
X-Google-Smtp-Source: AGHT+IEDzY27XIjmb+pnfP0KAuMr1rdHFrYSHqkjaYiv+DONBXw4koHR1jE3FQkMkK1VOsljfrgsZA==
X-Received: by 2002:a05:600c:1c0b:b0:45d:2ac9:4240 with SMTP id 5b1f17b1804b1-45f211f7099mr102931935e9.17.1757856221985;
        Sun, 14 Sep 2025 06:23:41 -0700 (PDT)
Received: from ivaylo-T580.. (91-139-201-119.stz.ddns.bulsat.com. [91.139.201.119])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45f27f44093sm61736025e9.24.2025.09.14.06.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 06:23:41 -0700 (PDT)
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] dt-bindings: timer: exynos4210-mct: Add samsung,exynos8890-mct compatible
Date: Sun, 14 Sep 2025 16:23:39 +0300
Message-ID: <20250914132339.2623006-1-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Just like most Samsung Exynos SoCs, exynos8890 has functionally the same
multicore timer.

Add a dedicated samsung,exynos8890-mct compatible to the dt-schema for
representing the MCT timer of exynos8890.

Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
---
 .../devicetree/bindings/timer/samsung,exynos4210-mct.yaml       | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml b/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
index 10578f544..2c01e8bdb 100644
--- a/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
+++ b/Documentation/devicetree/bindings/timer/samsung,exynos4210-mct.yaml
@@ -34,6 +34,7 @@ properties:
               - samsung,exynos5420-mct
               - samsung,exynos5433-mct
               - samsung,exynos850-mct
+              - samsung,exynos8890-mct
               - samsung,exynos8895-mct
               - samsung,exynos990-mct
               - tesla,fsd-mct
@@ -137,6 +138,7 @@ allOf:
               - samsung,exynos5420-mct
               - samsung,exynos5433-mct
               - samsung,exynos850-mct
+              - samsung,exynos8890-mct
               - samsung,exynos8895-mct
               - samsung,exynos990-mct
     then:
-- 
2.43.0


