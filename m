Return-Path: <linux-kernel+bounces-815631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C448EB5692E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 15:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D43B33BC8FE
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 13:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24601EEA31;
	Sun, 14 Sep 2025 13:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fnLDNEpb"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C25819F130
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 13:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757855791; cv=none; b=n2e+gYX/PPFbCWA50Z2KhQOHEGUbGwjQkxo5SN3rwnowcyHdY/yJ4cUoSwgtJwJTF/9X4LUnoVhWgy3Shmh/YsW3DdV4LEo3v6dLztOOh9VcVrh5SCy33dxOj2JQYqdKeP6m0XSg9TsJCcw4JRufOFRGJkVh/hU3BWroStSZQcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757855791; c=relaxed/simple;
	bh=HQfw+08pmHc2Pan7DP4bs8Xiq8bd38U1jE7h+zbEfAc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JAMmcY6qx3AsU+jyHpXovNuAxT+/DJqI+B8+HfkOqHz+yVJef7365PwXJ9WLM/Ltf/UXI/tJQs983XfAa2Rxu8d+eNlEXdp+ZdXG0pl9G2+o9Nr5TfSVTE0aTlHLyBJq24jPb5O9N6XFvXVhM84+4qa2r4fa9uYbgST7YqRlZqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fnLDNEpb; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45dd505a1dfso27329505e9.2
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 06:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757855788; x=1758460588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G1Q1wojRT+pPDpvbjQ6/3VZuSR/nnFa4c+/btLbdc58=;
        b=fnLDNEpb87wvqjUXHborj2OQdwukX/Td9Kk7zrswws1PcvgbFM/4M16PV/CLTOK0th
         5QVA5mOOeb7uhhGWU3HV6WnQ1orfYx5HbIwjHJKiPMveqkAXnPyoHm5EEVEcd20V+7WO
         RNdhB0gV1RrIjaoZjwPKGU3SHw6QcHzdMVJXb1Dd5H9hosix/9oh/wf6sjo7SMHPNCS5
         U42iRpU4hZkE0ZiHNqYbs92Z7STa4kwaH9e0Fsgw0BTb1cw3GKxnfk2SQ+JXsaq/fw5+
         N8O299NKFGKZvjOGaOp5bk+l+nQofNoMcVeXjwaoL/imlj6dNHsq75+/BMlntiqgwcuE
         8JTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757855788; x=1758460588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G1Q1wojRT+pPDpvbjQ6/3VZuSR/nnFa4c+/btLbdc58=;
        b=KC5bBXkIgzw3F4VBooCmbKUWNxZwZdlwuJ0i/BuzX8vfLj0BC3Uo3qHD8skDKZ7e/r
         8hpFmJP5/CTjy+4VwXU31u9GtSc5bwZ0OMvBnmcGEy663+EgkPhh73//1vfI5SBvXrQP
         xV+m99Os37SJUz/kbfGg1CQrlseTF6oM1dBh/0b8kHozRTUny3ZJjf4apbxEgW6jNAe7
         ADAqVRZ7WU22cOmCeFH/BYx5naKXzTR9twrlJ2byJos2uK8pl2/1B48em8aNhr9d/RGo
         TApOUZ372oT/bkARbazMwnJl/xmmiKaGbHhdcOjNlr6i29tEoko+ZA7WfOPhPtxcJ8Hm
         zJZA==
X-Forwarded-Encrypted: i=1; AJvYcCV1Yfr7XUD80ggUMSCt+ZT4kXtjNmR/Lv3s1ugQ+VYe7OpWsqhaDA/mQjFup1Vtx99CeF+B+8ghR/+Xwnk=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh98D4VBdaVyzOekU4l5XnUim2gSl/GTnTvSKj4bw5BIc1aOPn
	0KzSrvpgxbMDYGoD9rQJoqxm6ZT4aZwGd8M1Ncde04rJlvfUmV+Ma80J
X-Gm-Gg: ASbGncsaG3XPLEd1om5v7ddagw6yS4Iv1I+ZXkVYt1sS8+HGWlMgdjNIzSohgzgXeZY
	zf+n0Y3soAolILK/Mz9JurEum/H2nTJ1Gh14HXD/C1iCvR4IgSjjy2r33aNfLv14f/Hqoe5GmkE
	Q1RMCkYNL2Ls3S1L+EKuZKxybtp7WF0ddVKB/KwkADNpxuGgvXY3NDyJ/+7CbczwtrPh71Dqk9/
	8mICsGkrFQ5Wky9NZrrKbakj9SrUWHTWUJjvDjMOsyyMMBaRMXPWfDi5IRKoy8T/RJKb5wa6Yrt
	yreyXY0cLqvamI90IA2tiy21Gf/asecpktNV6O3UayTHefbNCMBh+k2s5iMj20eeNLLmDdBjwQ7
	dvadb3MM7SpiI97DGA9HvWTkRJyoc+mqnbXlWBi8W1x7Y0iJeTIGlkNxiCcKeOxThODjNt44ucf
	vCAWPxYlOq
X-Google-Smtp-Source: AGHT+IHIQ6hL02vX6IP4GwQbuLCOZOqv85KBgOtJmDEVCj4YcKxCCJes3RvY9fUtp3IRzwzcuDbaqw==
X-Received: by 2002:a05:6000:2908:b0:3e3:5951:95ff with SMTP id ffacd0b85a97d-3e765a18d9emr7675234f8f.62.1757855787801;
        Sun, 14 Sep 2025 06:16:27 -0700 (PDT)
Received: from ivaylo-T580.. (91-139-201-119.stz.ddns.bulsat.com. [91.139.201.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7607cd0a7sm13602468f8f.39.2025.09.14.06.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 06:16:27 -0700 (PDT)
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Andi Shyti <andi.shyti@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Conor Dooley <conor+dt@kernel.org>
Cc: linux-samsung-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-i2c@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] dt-bindings: i2c: exynos5: add samsung,exynos8890-hsi2c compatible
Date: Sun, 14 Sep 2025 16:16:20 +0300
Message-ID: <20250914131620.2622667-1-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add samsung,exynos8890-hsi2c compatible, reusing the 8895 support
since it's compatible with exynos8890's i2c controllers.

Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
---
 Documentation/devicetree/bindings/i2c/i2c-exynos5.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-exynos5.yaml b/Documentation/devicetree/bindings/i2c/i2c-exynos5.yaml
index 7ae8c7b1d..ead1818c7 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-exynos5.yaml
+++ b/Documentation/devicetree/bindings/i2c/i2c-exynos5.yaml
@@ -33,6 +33,10 @@ properties:
               - samsung,exynos7870-hsi2c
               - tesla,fsd-hsi2c
           - const: samsung,exynos7-hsi2c
+      - items:
+          - enum:
+              - samsung,exynos8890-hsi2c
+          - const: samsung,exynos8895-hsi2c
       - items:
           - enum:
               - google,gs101-hsi2c
-- 
2.43.0


