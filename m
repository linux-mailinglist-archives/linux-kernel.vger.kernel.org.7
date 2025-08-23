Return-Path: <linux-kernel+bounces-783138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C0FB329E4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 17:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6D879E8765
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Aug 2025 15:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7231519A0;
	Sat, 23 Aug 2025 15:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ME5bT/ld"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F67523E352
	for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 15:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755964441; cv=none; b=IAZNeZYoboXSG6m8Tdv9ERuaIHuO/CtERgtLhUjB/Vuhh82raJQ6MjNd9sjyQ913rRxR4CAbFnghYZoZQgWreeUnhbrDlMUMuYuQ8lEyu12XpClcaq68DUjK1mBMbotnYcRoE4/X9I/LOpirMyKHvWd7z1Q8RHdbGq4fjC0ZZpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755964441; c=relaxed/simple;
	bh=BEBwXHerw3ntKO8As508E0PNezsgrG0rfZYdMmUmjv8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=vEsi6hnh9h2pHRTB3KJGr3lXkCszta/Wud0GB7vDA8HDXWNg84FBbd0YeeKF2nElxjhNxzaPPE4aC40SwNLJw1l+yj+Xu9VGqrWt0YXcRYzqceuz70RLfbWxivrP54sa4KAdOGjP3Ty6fFBvxcNkdg2Ibos9Hrns0EPuqX0nnnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ME5bT/ld; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6188b7895e9so465343a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Aug 2025 08:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755964437; x=1756569237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zt9xEnK/GMUK8D+qIpymS0lulZPj2RfyNpNrWhUY2cw=;
        b=ME5bT/ldwKFVylukKYI1Mfwv5ms3nQgJoVpPdNmHrduHmfZXcwbqnmEdvi+/gLFYSP
         bs5aQrhMuc3DIT0BCw5K1zWfY/T9EnV/R7CRFJaNBaKR8wPTtKpkm4e3LG5mDnrRyvMH
         6XxIl/tEkYeHxiZQVWK0yWM1D6PYJydGp59arPEVlXIgQEYUp73EHMZSd96tGCcUqBY0
         ZRdRblfGk5XGZZ3rmBWStx6b9UJtOIfR5woMlRQk2NOXlwwr7PoGyor8FZC0IHtSHKdq
         B6FA76tknJcu3JZ2vL66BDO4F7G9Dz4MIDiAgrJHIWnH6zt/lonpPmsawCghjjKEr9pA
         z0Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755964437; x=1756569237;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zt9xEnK/GMUK8D+qIpymS0lulZPj2RfyNpNrWhUY2cw=;
        b=XvfatksiZghrF8r4D4ehpkSccUu7JS9ELyCv76WVJCcY1f5GEcW119bVIxVOKgAuBU
         R8C7T9mj3JEK+6GGIlA2cUXe+D2niKtbKkGOyggtF+ca3vdczV8QD/C+I7J07U4PMzXy
         /Cdte9qY9TtpBC6Nrl0FD2tlDhFaYm5klW2NeJuV5wdz0tP1m/hZ3XhmlIOnKJ2R9r1z
         /8J8F9IiMA1IfUwI6O7x531F7VbdW79C4KKzXLjSY9dZ39xeDv4kC8ILCDzxH9iyZFSR
         RuSwpbcW4MBGGLrHXEhkJtUSO/l9Pwab3VttVcJjNSm2oEUMzNwWUvOh+4KFc/wNwQcR
         e51g==
X-Forwarded-Encrypted: i=1; AJvYcCUa92Qag7/wVuGDY2Rv0dFS3DrxF1v9sX8cv1Me0nX7BG+/lgFiJ7nZ84izJQmKl5k9oIEG0qyuQgzU/Zs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu368OxtKNoJ5PTILZniOAxxeTZ85PJTM5wD0ATkw+Len1wgqz
	DL9YG+smF9oP70QtarPbWNW8FjnynHeJ9yqQLqUvdLo8Y1dJd2eJfEWeWY+pm9X3Uco=
X-Gm-Gg: ASbGncv0McOqLtyx0V25LBMqtXbpL4H0iZxLhVJG5vEVhgIsx9S6670ClgJ2Ir4zmaB
	G/v9ghjt4KlyhovkoqZ0du91gTSRQV4Pemd+71tp3DEloLFDThUMjnvjGx6rIuUAoTBxFGB4eGu
	SyHm6K+OetqalANJilSs3L6qb7fOMRGdD3XTQiPI8jODLTyo/yvp1JNqerb6wSZzivPPCZLEC9j
	BbWKzejmFeS9QZdLSCkPFNrSgTbwNzPmshpARdLBsPC8++fyqkJLnK5flqSs+6brHT26mSr7Fps
	R90yVQNL83urTLSr5xeRc6V4jc5HZsG09L6R8DV/lyVUyMN45EGAT/GEdk5THlnY5IHoiO0r3ow
	3z1y1VqADAV643C+VVqP13oHEQSVaMk1khw==
X-Google-Smtp-Source: AGHT+IFx1wcVLNhS6MBGIutE/EnJRngjDp/qfQ6MpvV6BFouq2K1E1mpaTjSPi2NhS8iAUEG5SPpyg==
X-Received: by 2002:a17:907:6094:b0:af8:fc60:5008 with SMTP id a640c23a62f3a-afe28f09244mr306080366b.4.1755964437314;
        Sat, 23 Aug 2025 08:53:57 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe4937a15asm189236566b.115.2025.08.23.08.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Aug 2025 08:53:56 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Vikash Garodia <quic_vgarodia@quicinc.com>,
	Dikshita Agarwal <quic_dikshita@quicinc.com>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	"Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-media@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] media: dt-bindings: qcom,sm8550-iris: Do not reference legacy venus properties
Date: Sat, 23 Aug 2025 17:53:50 +0200
Message-ID: <20250823155349.22344-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1917; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=BEBwXHerw3ntKO8As508E0PNezsgrG0rfZYdMmUmjv8=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoqeQNhzvYWTV96Z2wePTHgAsg+wDg0fw28p+mM
 oqvJpaQEHaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKnkDQAKCRDBN2bmhouD
 14K6D/0XM7xhbbPWhNOrngsV02OIU+OD4BrFRZoMj9RvaiNDicnJQ3tq4bUf7TNBkhIdbVjQ339
 KLDDxSYa/Kbg4IPo8CNYpzNFBcgMmR0seGyjS4CPMMimCl3P73+PV2vsGdCJMSKTisPwrT/P6yh
 6mNE295Z7uDPPKaethoNziW5KtvB0PwSWsSDPjCejD6+nfmtuYM0Iyys16+zPZmCl9MSTWUPYt8
 K+E3Z7T430XoCYi19JbevyJn+Udv0Cb8wQFLfq/eYUGF4Bt2MrEruLacnIvNBKow1hkdJ7ZJqTi
 6U564isiBJts6WDHoSMYGubL+ha4zjbUIChF2xAYEOWxv+V681pMmO/96x7ONB6ukGICM2P3qqn
 tnwLaEfV0dXJhAarm7KQZf3t6NmB5krs2mylYyrifcfabmK0r+fN8dyLoWvoOTSRTkeVpgEtmPS
 qrvP+fdsCWW1T1a7zG0PgQNAS4S5DO1VKsSzUQ4hYjE1qDzTOgJmI1I44EabQLzLQ6TkTuGbrHr
 p2SD31IDxdh6Vjc2OKiLleXSkw0zLBJR2afj5VsDP99tq7Yk4zkAhaL+mxfTIxTbBZk/XZSdFMv
 LuuMzx+2fbZEBPHaNHSt7A9+4D2bTByfNcvl90uaic4gxWUZA7uCniWIRGfWc3jShsvo60NQase rcweX2hLXnAxytw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

The Qualcomm SoC Iris video codec is an evolution of previous Venus and
it comes with its own Iris Linux drivers.  These new drivers were
accepted under condition they actually improve state of afairs, instead
of duplicating old, legacy solutions.

Unfortunately binding still references common parts of Venus without
actual need and benefit.  For example Iris does not use fake
"video-firmware" device node (fake because there is no actual device
underlying it and it was added only to work around some Linux issues
with IOMMU mappings).

Stop referencing venus-common schema in the new Qualcomm Iris bindings
and move all necessary properties, except unused "video-firmware" (no
driver usage, no DTS).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/media/qcom,sm8550-iris.yaml | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/media/qcom,sm8550-iris.yaml b/Documentation/devicetree/bindings/media/qcom,sm8550-iris.yaml
index c79bf2101812..320227f437a1 100644
--- a/Documentation/devicetree/bindings/media/qcom,sm8550-iris.yaml
+++ b/Documentation/devicetree/bindings/media/qcom,sm8550-iris.yaml
@@ -26,6 +26,9 @@ properties:
           - qcom,sm8550-iris
           - qcom,sm8650-iris
 
+  reg:
+    maxItems: 1
+
   power-domains:
     maxItems: 4
 
@@ -45,6 +48,12 @@ properties:
       - const: core
       - const: vcodec0_core
 
+  firmware-name:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
   interconnects:
     maxItems: 2
 
@@ -69,6 +78,9 @@ properties:
 
   dma-coherent: true
 
+  memory-region:
+    maxItems: 1
+
   operating-points-v2: true
 
   opp-table:
@@ -85,7 +97,6 @@ required:
   - dma-coherent
 
 allOf:
-  - $ref: qcom,venus-common.yaml#
   - if:
       properties:
         compatible:
-- 
2.48.1


