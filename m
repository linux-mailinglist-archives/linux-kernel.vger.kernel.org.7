Return-Path: <linux-kernel+bounces-805275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F153B4864E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 10:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CC1E7AC32E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 08:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008C12E92B7;
	Mon,  8 Sep 2025 08:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQXch6qe"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF59F2EB858;
	Mon,  8 Sep 2025 08:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757318560; cv=none; b=DpyugJ5rqSA8CUAGNcLUQXo8yhLPiqj6Ou8Q7TprFII3X/UX+q5QHktklqMh/xxIgdsreYhqiYbNuKBRp89mcTfKKVlzqgqoDoYb2ubRvrIsWpBlO61epXTywn5+HRW3aaCmt/Y2X7VlN77p5TBGxK4hJV0GefNLuoTxzERTiis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757318560; c=relaxed/simple;
	bh=Ns33pVwWmvDByyk2ziC58pMyuMxDXTJqJApKV/dAHFI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UB5tLWb0UCNexiLGnCqU8kbYOBhD/D/5mh8ytB9fHF2mdMlqrv56sc7Y2iYC5354beIVuGdG0XKJPtY3WiLceapofsOcREVHrt6apVib8b/51YM3cVEBNuXleHCEdTATfCIVGBcHcPM2rdu3l7GoKbbkc892W26CtYoCb/1NCmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eQXch6qe; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7725147ec88so1582816b3a.0;
        Mon, 08 Sep 2025 01:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757318558; x=1757923358; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1m1HPXvt7ktVSLEbN3p8RtTbvarkVCnLkg7YZFQj7Rk=;
        b=eQXch6qeJ6oSFS53zxFNjHU+lYmXMJePYP4So1MpQFjhP63Zc3tnBf06gwZtEMxJjw
         7KCbKIiekOBa1V5ILofXjMd0e9tyOYFWhAKmJM3BiGVabkKd4ti+MqC9zjalflexj2YY
         FsBVEXKLj+GeiQG75k2vzSkZ6tObSEcOxjY+8PPHjnocarq3m2gun/ESU9wgzB/1xIj4
         Jhos7RgQ56FBueJvrWMKP8b6T1CBZph+jdRS8rR4E6Yc6Uk7tauspzEAvAvAye6iqAaz
         2s+4zKKfpV9W1zIpdQ/sJ5pOuDA4E45LBAY9IcJl3say+RSbG1JPdNR8M3d0IjuAjf0Y
         gTJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757318558; x=1757923358;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1m1HPXvt7ktVSLEbN3p8RtTbvarkVCnLkg7YZFQj7Rk=;
        b=CRFpRYtS6rwi/b7PqFizRBXfD+nKljPBdlz4yBGQfNOfjUowJuQEh9PtdHHrJ23+6p
         q8hXlDAO/gY72ILLkIMmJ3F54018j/p4E+gRH5KH62bsDZccDTEVsA+SG1EMyWMUoWbg
         W/UoO7dzFxZBXpIJOKFkCvxgDjLJwoDPbxBrdv6/m1QQuKeIfCTSa/90p3vTyez+KkIF
         j/HIWqIYvIjB217pPK/ugvPMzejhDQ/S5Fq5C4SMHSt0OROmpAaXAKc73rT+dWu7qENm
         6o43kDgFCHZvC53iv13uFX9nBOGrBnNoFEvx4NeK9UAqNOSyFeK1TGwWzTSU1JhBR8ce
         ZhiA==
X-Forwarded-Encrypted: i=1; AJvYcCVJuNcThtkRkpXtb1295trI/QCvzWcoPxlwpNJMggrmUJ2M7rW0d0CYlBX3QS/Vi2fJxssFBXEGdWW305LR@vger.kernel.org, AJvYcCXGDHRnRMTf0uet3qHFddYdrDN/1N1C2hNk7GHOavDZP4cSN+8t7qxp3qpHfaviBP/m5cRcrBxxM+me@vger.kernel.org
X-Gm-Message-State: AOJu0YzLA7ETQaLhMc9s2gL1kA1ClOGqvxXSPX9O4SFWgBdNOUhuh8tI
	p00KwPjfwpmJUHc69XKsiEphOnJyD6aW49Q8e/Xn5j6yrUdV5rPofqha
X-Gm-Gg: ASbGncvwqVboUzlB3SrQpHAK/D3PJhBrh0wvQ3GdXKPSQ4yHwFkhrtv8RnPPDyi4Rd9
	M3xSLUvdGV4czg8/ZfOikTZXuu6XKDschc1RBLRwhBEUXTbT/zMpnz912uBjpJw5fWFL5IKdHH0
	x3L5gS953eott69t2w6GyUj36FOxErhAVVNtfirxGTBsJvG+1N4HronMJZDcskZlnvTC0Hv2LDF
	F04weQDSHIN9wl8dRE8UjlYGYeQGcT5AA/E6x5EoniYxUVOFUUmidfz0DJcmQUw0RnXjBK1Djyw
	INHSBjWsmyeB9ZVkDMxjSfcg4C91dfJn+eQypa/7Rc/BxYOSIGICJK4fPH+34/sYA33CI28CVxI
	TlTrA9d6ClXTkD7lC6k1XK2SFjS4T0wdftI4Rfob/JhmK9NErv5DR2Hbur3/FmF3IiCWXREMe/T
	7swwmR7blGWleBdDtjALiPo6XniaQb4LWfyK2kJdEFs3wTS8MY3H/30l0kNPEdxLI+4APCaq56J
	gZ7SOrKKKRSJ3AH
X-Google-Smtp-Source: AGHT+IGGZJOWnBMUs56283wgft2cbmKqgdlDx4FfdiUkPllQ+scrxhIKHbQGrDZ1bM5Tn41ggy0nJQ==
X-Received: by 2002:a05:6a00:852:b0:772:736e:656c with SMTP id d2e1a72fcca58-7742e3b5b6bmr7614551b3a.5.1757318558156;
        Mon, 08 Sep 2025 01:02:38 -0700 (PDT)
Received: from fred-System-Product-Name.. (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7727bce1b58sm15186600b3a.9.2025.09.08.01.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 01:02:37 -0700 (PDT)
From: Fred Chen <fredchen.openbmc@gmail.com>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] ARM: dts: aspeed: santabarbara: add sgpio line name for leak detection
Date: Mon,  8 Sep 2025 16:02:15 +0800
Message-ID: <20250908080220.698158-5-fredchen.openbmc@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250908080220.698158-1-fredchen.openbmc@gmail.com>
References: <20250908080220.698158-1-fredchen.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add leak-related line names for the SGPIO inputs that report chassis
leaks, so userspace can detect and handle leak events

Signed-off-by: Fred Chen <fredchen.openbmc@gmail.com>
---
 .../dts/aspeed/aspeed-bmc-facebook-santabarbara.dts  | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
index de624f4a33f3..c86471fc6314 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-santabarbara.dts
@@ -1766,11 +1766,17 @@ &sgpiom0 {
 	"PRSNT_LEAK_CABLE_1_R_N","",
 	"PRSNT_LEAK_CABLE_2_R_N","",
 	"PRSNT_HDT_N","",
-	"","",
+	"LEAK_SWB_COLDPLATE","",
 	/*P0-P3 line 240-247*/
-	"","","","","","","","",
+	"LEAK_R3_COLDPLATE","",
+	"LEAK_R2_COLDPLATE","",
+	"LEAK_R1_COLDPLATE","",
+	"LEAK_R0_COLDPLATE","",
 	/*P4-P7 line 248-255*/
-	"","","","","","","","";
+	"LEAK_MB_COLDPLATE","",
+	"LEAK_PDB1_RIGHT_MANIFOLD","",
+	"LEAK_PDB1_LEFT_MANIFOLD","",
+	"LEAK_MB_MANIFOLD","";
 	status = "okay";
 };
 
-- 
2.49.0


