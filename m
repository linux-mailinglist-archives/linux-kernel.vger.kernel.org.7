Return-Path: <linux-kernel+bounces-799038-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E726B42628
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 18:02:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46D941BA0235
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419742BDC03;
	Wed,  3 Sep 2025 16:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwQSVgzb"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F208E29BD81;
	Wed,  3 Sep 2025 16:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756915321; cv=none; b=Nh4b/SfAJrHrmPgli/HcVHuVw3rvyn6Wg/C46NvE/Yf5g1UBgKQzGMM56j+FUE6wh6eGb0k0IVADG8npYM13r6UfBPf0tcNouZgPWoKMDuXst9qWa3wwHOaRlqx16b+3RXBXpnz10vU0qfDolgNU+Tf6mTiYjEp3qWekM1XiPbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756915321; c=relaxed/simple;
	bh=xX6yIokNKj0jCV6W1TACUhDSxrhunHIa6lH+YP37gB0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vs8CiOA/XcyjjlAQYTNA/P3yZ6ql3FmgbAFh5F3Wok65HOQllDy+Xj0WmwNkRRwYb7HNjfLMzR6WruS46RWqgH+SQ66TgPBOmNAT6EnOlfiUfLHj1K+SxG2QPRBruvNYur/CEUHSjIgGqcybzIK1BiEIBiXUx2uCtfiivt3v8XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kwQSVgzb; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45b88bff3ebso789555e9.3;
        Wed, 03 Sep 2025 09:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756915318; x=1757520118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E5h/p1yqJU4I6O/TgMMkgtfeLqBMvX7vcsjY0UcVa+E=;
        b=kwQSVgzbnob7WeUxob0WuaTNXUrHfo4a5lfvJajhPBnl+RWyOr861qcHc4DPwOGFCJ
         Q4byMok0HQkjpVyZk5Zz6Xvc6aZzyW3HybyEViT8XpjK1K96vZkUCmzxLBZd7Oz5sCLq
         KaCcPleqOZ7Cz+bEo1+WZcdoRDpoIHy47SKwjrVvhSXmB/Z8gtgBkJbeGW3mNPvmP+3R
         dvCxOIYzjt4lTFyEwiAmRn4SSQNJQwRTDYhl7bywSkKanui8IIZoIm2afbOz93ncqpmo
         EWfpPwCkyRE9GCNCVcvVpG5I7kurYcIFMIdtPRVpZwTAiEnv/ZhFXbGTb++xzTC8hIQo
         iVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756915318; x=1757520118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E5h/p1yqJU4I6O/TgMMkgtfeLqBMvX7vcsjY0UcVa+E=;
        b=pETvs2Xx+0Qq3J2pZV9zmObAMbgSFVTzt/z7kDWTCxrYv02DuEGtqm/eiNcbi/shHR
         FtyVqfTdSixcBqGd3VsXL4YCiaPuDlqNQ05gREzggByY4VWrkQYNPseGOifAyMYst6L3
         Qg1/SRmOoEqdCuMH/BxlqUDwPp7dw9ldT6ZUSYs7VBmPYvNrNrORz2DvNxTnKTO4gDUz
         B2u6p9DmAPNEdtKqkOeM/LkEHjIsVQphbR26kKOeUa27v0X0AA1AWNVis3e7eoVq+ov+
         6nI7W+QGXSkUfKhCHsjzoOs0asV5vdHe1+N/Dm57/QiuGPVE9L5+Whasg/owkkHVRPZO
         eXXA==
X-Forwarded-Encrypted: i=1; AJvYcCVHMO4l9ClOCCAPtP0bJPct+7nsrjwTh2RLQRpExEXzHYMpDoSg1giK8NyuuQcYkZdg2VNsoIWWaFn7@vger.kernel.org, AJvYcCWg7lt0xzDuwowvWIOEBsmMNggal9islnVRjsz1TiwSrvxwrSbC1E/WR0E2AvVOogjn+JmCojmAVziax/6J@vger.kernel.org
X-Gm-Message-State: AOJu0YwKf4rdrhAOvdRAQenhhSJ/zDyfSlICiXr9h6ScigZ2MANZwSGS
	/3YxEqIFXuVf01kir/+C0TMnr2XcuTEV7Jp/3JZR7i9BNf1u4DtrZovcXcX+f9c=
X-Gm-Gg: ASbGncuaUsstfwGKGX/8+qSYajYt9Ybj0lZFuaT+Ckcyq/lWQc4zTPKjEeifiqOAiIc
	OwQs/m9vt83gUQfc2ekNkcRQDB7a1oXgWjYla074BUU2RfimVXEp9CIjYQ5ktlK7Yx8eeoHj3bt
	vDXAVPfp4KYNkBEC7pISOSEPTTqgeFdEOsxfv2f85L5i3t9SKveAF1r4ePUITQBg19F+w1FY0D9
	Qg7Ou/orsNL8Znoj1cHujebfw/66AQE3VnHXxia9Y5tf0z9ovt65RwEuEPJN1wljK9ZAmLxG/UU
	jKgRWyHr114sjZwWoqPJR2PteGQzrnl+NyJR3AZZ2/Otuhn0it0y99CJmeJxiNTQlbG6Jl3agxE
	JpaYwnf9Fzggpgr0bf4SDIW8XSXR2zfnRU2tdITMdhVSvVWtft1qc73uMmdHKvg==
X-Google-Smtp-Source: AGHT+IFhAv8L03hgVUM9qfC08OneeJdbGRylRS2DVGYIsdxaA4SNhTFR4rINKVHRTPySEA3EvoIiEQ==
X-Received: by 2002:a05:600c:3556:b0:45b:8822:d6c1 with SMTP id 5b1f17b1804b1-45b88321bf8mr125837925e9.12.1756915317505;
        Wed, 03 Sep 2025 09:01:57 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:221f:e1b9:d63e:6ec1:3551:61a6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b8f6cd502sm61672745e9.1.2025.09.03.09.01.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 09:01:56 -0700 (PDT)
From: Jihed Chaibi <jihed.chaibi.dev@gmail.com>
To: linux-sound@vger.kernel.org,
	krzk+dt@kernel.org
Cc: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh@kernel.org,
	conor+dt@kernel.org,
	drake@endlessm.com,
	katsuhiro@katsuster.net,
	matteomartelli3@gmail.com,
	zhoubinbin@loongson.cn,
	KCHSU0@nuvoton.com,
	patches@opensource.cirrus.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shuah@kernel.org,
	jihed.chaibi.dev@gmail.com
Subject: [PATCH v2 2/3] ASoC: dt-bindings: nuvoton,nau8825: Document routing strings
Date: Wed,  3 Sep 2025 18:01:18 +0200
Message-Id: <20250903160119.83625-3-jihed.chaibi.dev@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250903160119.83625-1-jihed.chaibi.dev@gmail.com>
References: <20250903160119.83625-1-jihed.chaibi.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a list of the nau8825 pin names to the binding's description to make
it self-contained and improve the user experience for board developers.

Signed-off-by: Jihed Chaibi <jihed.chaibi.dev@gmail.com>

---
Changes in v2:
 - Rephrased description to refer to device pins  instead of the
   driver.
---
 .../devicetree/bindings/sound/nuvoton,nau8825.yaml | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/nuvoton,nau8825.yaml b/Documentation/devicetree/bindings/sound/nuvoton,nau8825.yaml
index a54f194a0b4..4ebbcb4e605 100644
--- a/Documentation/devicetree/bindings/sound/nuvoton,nau8825.yaml
+++ b/Documentation/devicetree/bindings/sound/nuvoton,nau8825.yaml
@@ -9,6 +9,20 @@ title: NAU8825 audio CODEC
 maintainers:
   - John Hsu <KCHSU0@nuvoton.com>
 
+description: |
+  NAU8825 audio CODEC
+
+  Pins on the device (for linking into audio routes):
+
+    Outputs:
+      * HPOL    : Headphone Left Output
+      * HPOR    : Headphone Right Output
+      * MICBIAS : Microphone Bias Output
+
+    Inputs:
+      * MICP    : Analog Microphone Positive Input
+      * MICN    : Analog Microphone Negative Input
+
 allOf:
   - $ref: dai-common.yaml#
 
-- 
2.39.5


