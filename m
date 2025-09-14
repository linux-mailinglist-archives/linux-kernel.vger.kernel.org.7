Return-Path: <linux-kernel+bounces-815673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8463B569AF
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 16:18:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E4993A6AFB
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 14:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66EE21D3CA;
	Sun, 14 Sep 2025 14:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOaoBPDo"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290132036ED
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 14:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757859482; cv=none; b=LY7hs9n7dPDt0pyTsdlbpaU8YdM/NEXyoBYDkXyso/5lDZWq0GQ/YwC2ZO6nuBhTEfZbg6yuy7Zsf6wbwdVk+3SsXHRF85M3QDXYwjh8xcFNL/cDT3t85glij9Gc5lyO7cxENpIC5uqwXiD6joxYpdVS1M3l78uHSGdpgZw7mVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757859482; c=relaxed/simple;
	bh=G/YgUWwYgipT54ZkK5S7t4iIid/jh16TP1NiVGcDIfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=APpfIRl2kVEVtVc141rmyV0d8r6E2/6dpUsBtamaw84O6l4VoOuXJfkrMaV4as2o/G38AYtZk5Dz7Y9TtceLCzHmL0c0kFwZqvcDoW+G+Wf1CsT/ZLpSqphn0KXo4/gxcPA8RnLBgBe3ZcO7AIItCOVs+zNTK3mpMj6GS9pmJ+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bOaoBPDo; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3ea7af25f42so129390f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 07:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757859478; x=1758464278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2UA8yGhG9kMHYtx0Te9toutlRddNLKPlgFwt+Jj5ZBw=;
        b=bOaoBPDoCiLOai8Urih7VD5ZEWw8uQOxpdMbaMY+nhC+HuQE3Dud2SrUjgYNtQSV5q
         LW/hJgq9/+3WwWrTZ92ulIbpbuuBugVDGEm6HcUB2vkdkXSkt6rXlinhkxU0vUk6ocY3
         7/YelEm+ubW3DIvMKH/aYJDcvPbXH6ZIR82fImPTd98hk6L1EfAxGe/r+IS4H0g09MIc
         lcR8Mh9DJO7dLO7vl3XEPeMY0+7Bqm3H+lydqVxzFto1gv2vp4OTh3EH8I2IabtYMm5d
         cOS6vmCDrzBjQw8cdFA/PdFlZ9EQWAptwSCMlK5IBd6Sy/hby7wqwiaHY0Y847ReFMA7
         tbNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757859478; x=1758464278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2UA8yGhG9kMHYtx0Te9toutlRddNLKPlgFwt+Jj5ZBw=;
        b=LIVgYnBB+szevDfN6nVNEqbI3Fnhi2blLQdq5ZpxF7XJ3aCbUpXP/Q0jNFf2xr0Mxx
         a/WfAVx3H29mpGSXEAu27xfvh40PwlFv4ELseQm8zGik6/PmVQPw+kdKnZBqvjsUaxy8
         IrDuJ9w/vY95LOxgkQfnKhjmf5pqfjzYpSwd0B68DsY/hm/vnFa0a/vHPP1hkZkE2VFr
         nxDfVHBjk5T5RE420rS8hA5whJuzBARnlZWbB07xu1U4IP88EpmbbG3bNY6hZLFG5KNx
         Ht1hXjJPp4i02pYQhf2fZkr5AFxtNr/UfJuYAOLrxS0JRPGWPHykjBa1P9NGy2gAgS6P
         7mjw==
X-Forwarded-Encrypted: i=1; AJvYcCW8VetuPGcziPhh3R9OG/21P9PMNcDE4jOUPoBdFh6+cyjTC5u33fLt3juVxmqj3P5FiND8cvsGFTYInlo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd/t9yRCZdLbTGj6Mz7no1nbJSTRCHGnsYgwngiTXVFHaZR/Uz
	GJa43YNkmlZdeYPD/91FDpSVtnQTU2hJHiRlHE8X9uarOaQrfKKZaMbF
X-Gm-Gg: ASbGncs8emrRNuCYNdtKUQyXfiXU44mrWqzvsT9ZeUrVHeQOK/rnEfPcOEH0k/QFwIc
	A3cd4+TbDyP8YvTV/JFEGVaqflAJoYOl6m4B+8Fvdlbfr/W0MtWmYl4MvDpoRvWUzT9R/nfd0Ho
	gvqHQtrD4jqcdIfHGLksXUE4LfDI0p3DPVYENhLKrFeVYA/ecA0xLGccvPxoC7CjeClbh8SZ2Mh
	8lH1TIRz+OSHIHydVRWvuI7L4DmmvV8cNq8gSoDRq8AgU7hA1gnxM6qmIJNJIURKt+P597fzlZ0
	I1rikCvQUvum43RTNKsP4NqxyK+HFNAAgO3lpeJfdXyBSw5vgRI/wOeXxI/slnTKBaHuFCwYSP8
	1UAxm3eVxCQxfpIaFbW4wJSGuKl+4MZ0SO9yG8bZbSTLREyG56rW3hnZ33PWK5kCY7KcGMY/VJg
	==
X-Google-Smtp-Source: AGHT+IEVZ6Z6kRbK2/B6B8AOG5votgND2aiK+Fq2TrFsSb/gyiSqAj2GfqraBbQ0O5p8f224y8alHw==
X-Received: by 2002:a05:6000:420a:b0:3e7:5f26:f1f0 with SMTP id ffacd0b85a97d-3e765a13179mr8756668f8f.40.1757859478364;
        Sun, 14 Sep 2025 07:17:58 -0700 (PDT)
Received: from ivaylo-T580.. (91-139-201-119.stz.ddns.bulsat.com. [91.139.201.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e813eb46f3sm7319270f8f.23.2025.09.14.07.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 07:17:57 -0700 (PDT)
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] dt-bindings: usb: samsung,exynos-dwc3 add exynos8890 compatible
Date: Sun, 14 Sep 2025 17:17:43 +0300
Message-ID: <20250914141745.2627756-3-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250914141745.2627756-1-ivo.ivanov.ivanov1@gmail.com>
References: <20250914141745.2627756-1-ivo.ivanov.ivanov1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a compatible for the exynos8890-dwusb3 node. It features the same
clocks and regulators as exynos7, so reuse its compatible.

Signed-off-by: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
---
 Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml b/Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml
index 6d39e5066..6ecbf53d8 100644
--- a/Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml
@@ -21,6 +21,9 @@ properties:
           - samsung,exynos7870-dwusb3
           - samsung,exynos850-dwusb3
           - samsung,exynosautov920-dwusb3
+      - items:
+          - const: samsung,exynos8890-dwusb3
+          - const: samsung,exynos7-dwusb3
       - items:
           - const: samsung,exynos990-dwusb3
           - const: samsung,exynos850-dwusb3
-- 
2.43.0


