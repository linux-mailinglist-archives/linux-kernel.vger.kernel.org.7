Return-Path: <linux-kernel+bounces-765529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4ABAB23983
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 22:02:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8B5AB7B4707
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 20:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBC62D063B;
	Tue, 12 Aug 2025 20:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yv0Tzctc"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBE32D060C
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 20:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755028885; cv=none; b=Vaerpc3olQsGBpRhYZu91hwjezfVBmfRrp/QG5U4cwOwYlrdp6yqsS1fsXeo/ZM1Ezyr/lciXz4hphzHJ3Lw8VrtBe7AwT4/YGQde9rWFXBCpnz2ZUf9TVDni5vDCOgQkuo95VRrQP+ScxFzxRsxNcQ08Zk4+Rcz73plfNJWrVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755028885; c=relaxed/simple;
	bh=tpem3ugXEXY+sza7Z065QDPEzGqVly+Nz2CDIYGjz8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S0AMnFKI11M8j5A+jKS0S5mvj6LXdLUquob1SjvarL3yT/3vJ55kpAQZqLUxj48sAW/znZIwncT0Z/nwOXMfJWfKz1DtkmVSOB/3zdllzupmIJMh4bLWj2TdvAUW69o8DfTt33VYEkSpmvMApJw5gzazicR2wLTVUJnucx40W1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Yv0Tzctc; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3b78294a233so4856223f8f.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 13:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755028882; x=1755633682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ZIFIadWiEXjzSuKWo1v9+wZy0Xasz/GeS9q0g0hnKc=;
        b=Yv0TzctcM/hTIm5SgXxsYKiP49iK3e9oy84XRdFlDKGxfoD4EJLxntIg43WFhcE1HX
         nuz312eFvRpGDhwmZ+mZEFYxs7UY4qf2xM5emIkINzLvzi3yPJIqBsrvzMV6OJ8ykZvz
         dGy5z2FDDxZiR8nHT/m9zGVKOv5mASa91XB/W82FiCEQiQ1UABuMH+q5SaePqwnuOtI/
         +U1ZxhbAG6UuEXTQgb+TelIB8hRtLrHkJxKTVlvPQvjL0Zrbdw1vfAQVLANPeSCFy9mF
         Gtm8VwsOmgPAr6IQd8Ff6bv6MGnKyYpHysuv4JmKkqClk0ZolZLdII5G4XADZ07lB2+y
         RHbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755028882; x=1755633682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ZIFIadWiEXjzSuKWo1v9+wZy0Xasz/GeS9q0g0hnKc=;
        b=AZDI5fRikUGcxNtJgL4qAnF6ChPZznkISSFfm0Seqz+Ms07KxJCUyvoDeW7dV16yew
         kTB3V1D8VNIHu/Q5x7aLdj6k0TtUzUl2Zt5iFElo4bPTpeyxJDElc1ciY+u8wuz3p4d6
         xLkGxJa+xqs0SPndQ7eCWf+g4dg6Aa+WR1js8BzpmI1eG1i7h+mFms9bvkv00+XTxH1X
         W9cdMup1nJK5v7wcFTW8+olzhm4RFtnC8euy8m0Gn+KWM+icti0REgJSR0vZ745k+8WU
         TGbRgAZNXRAt0/k6LohZMgRG1ZVL37l1xcn6i49Ls8LlpjV+i630bwA6f0F3ND95n9uH
         7qXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWobkZFRHjJQMuTrrUKfcHt3gH6aI5KoNsA6qOYuqgkYdLhMfILJ0i5A68mdA2xl/hXSZMq7V2h5tc8DHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF3z6hGUTvYbOSoRhNAfJm9+hEGsPW3/y7TjCu8C88iXroKMK/
	015ffJ4prgGcUh0tksDL1Xiaa52KsbBJj/Cxc8wrce/Ei7XXf3/z/kzKvZ3JfrQEeiA=
X-Gm-Gg: ASbGncv1lF2WXbO4MsqhdpuG28RY9RdIUeq3EHKNFHitPiryBgmKfO9r2zlqRYr/jfy
	ljPjl8V07fzgkCmoHdRNEpb1aLw8LSJSCXY3PEmkHT2XeF+Dxc2waziVlRhy3WgMjDCGFVMj8Qe
	LNevq7K9aXSz06bkmPqRL3UJOE0yngev1p1yOp7Z0Dd4lZantZ1SC6Kt5kXAzNjd700/YJ+ggiv
	kDqak1yK+K+dZrnVpD4ilQ8Lh9y1PLKhpIQfdQMul+KjksXYyrXF6AtCWke7YcjNPc8X8IFdXLY
	qolrlYMfB5rY7p+o2YHJZ6Sjivw+6RXwQWWgk7KYB/HfQGn9NHT1e4aVuxtQDDzzFkaqI6hIvez
	tTNsf8lu6cu/T3aB0u6f08wx4NSeLQyu5ixCLWsj7ju1lxZ83
X-Google-Smtp-Source: AGHT+IHYvFBKyRBNQT4SWy4ddmhtgjeZuvH8xiyy6GkD7MVBNItPLtFOXFw2Iy1w8kyMUzjogW7vMQ==
X-Received: by 2002:a05:6000:4285:b0:3a5:298a:3207 with SMTP id ffacd0b85a97d-3b917ec5064mr177688f8f.48.1755028881970;
        Tue, 12 Aug 2025 13:01:21 -0700 (PDT)
Received: from mai.. (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c3abed3sm45143947f8f.10.2025.08.12.13.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 13:01:21 -0700 (PDT)
From: Daniel Lezcano <daniel.lezcano@linaro.org>
To: ukleinek@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Frank.Li@nxp.com
Cc: linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ghennadi.Procopciuc@nxp.com,
	s32@nxp.com
Subject: [PATCH v3 1/2] dt-bindings: pwm: fsl,vf610-ftm-pwm: Add compatible for s32g2 and s32g3
Date: Tue, 12 Aug 2025 22:00:35 +0200
Message-ID: <20250812200036.3432917-2-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250812200036.3432917-1-daniel.lezcano@linaro.org>
References: <20250812200036.3432917-1-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The S32G2 and S32G3 have a FlexTimer (FTM) available which is the same
as the one found on the Vybrid Family and the i.MX8.

Add the compatibles in the bindings

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 .../devicetree/bindings/pwm/fsl,vf610-ftm-pwm.yaml    | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pwm/fsl,vf610-ftm-pwm.yaml b/Documentation/devicetree/bindings/pwm/fsl,vf610-ftm-pwm.yaml
index 7f9f72d95e7a..c7a10180208e 100644
--- a/Documentation/devicetree/bindings/pwm/fsl,vf610-ftm-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/fsl,vf610-ftm-pwm.yaml
@@ -26,9 +26,14 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - fsl,vf610-ftm-pwm
-      - fsl,imx8qm-ftm-pwm
+    oneOf:
+      - enum:
+          - fsl,vf610-ftm-pwm
+          - fsl,imx8qm-ftm-pwm
+          - nxp,s32g2-ftm-pwm
+      - items:
+          - const: nxp,s32g3-ftm-pwm
+          - const: nxp,s32g2-ftm-pwm
 
   reg:
     maxItems: 1
-- 
2.43.0


