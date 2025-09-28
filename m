Return-Path: <linux-kernel+bounces-835208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EFABA680E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 06:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76B46171B55
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 04:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFE91EBFFF;
	Sun, 28 Sep 2025 04:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EX3bEQH1"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED492222C4
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 04:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759035528; cv=none; b=FdmgS+g8kt0EKJwYqbf6MRYfIISLlVPhPeeB7gvL1goSIRn9J9JCIfszjFOa0fRPAqJtxNyavMOpWpTFm6Ph24BPn3qztGotuAIZLMh7Po6v42bhCVq9r5DeRxE0WUuqRJgKngYiCiPSgi13n5E8wGnqfbfnv+Oqu49mzgZ+fLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759035528; c=relaxed/simple;
	bh=gBdIOP8VAofWeg0VuDnNTI1eOLpqvNJeatbnz/SutbE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CDicwN+Ek/MwzHF92rmGmAxuQhJwPWOVPOWdvk3mcXtKkDtwHc3XlLI0K3PsVYC/cph6c+LS2HRLLezLaFo+rqc6qchA8lNbwJezSqG6znD8fqAT2tDdYUftNvsqL2N5y8Tl9SObRXLojiD8A/J5QZ02GlU67I53rtg4K1cEtHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EX3bEQH1; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7835321bc98so316996b3a.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 21:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759035526; x=1759640326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WxpcNLUlja4tVEmgOEAKXd31nleDdtBAzU43V4PpQ1k=;
        b=EX3bEQH1RldiCz6Q6x9VieCZGV1PZUGMArvm3sRj1ayX0+TKVJD6PdZFV/LkHOpWwc
         AafowvR+AN339b0To54H+IYTmtYx7lHkhdUIBrWGtD7x65GnLq48zS9VeE//n8rbp5/W
         pX/XFNIOfgGGYUlyh+A+a8TqkANRKYVzIxW0fUuVEo3q/IUvCGg7KsSxZZ8cgCmc7A1Y
         0ekTXeY44Udkc4naOIjrn6D9fniySPkxwVe1UEi9dxwwWLbCWSLr7nXpthRqALkXP93G
         iNt6kfCmV+nJkkFz120EciWl9Wq8cq1LOE+Goz3oV0OpbnEiRstm64xXLfZZqdUsbZf5
         Dp0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759035526; x=1759640326;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WxpcNLUlja4tVEmgOEAKXd31nleDdtBAzU43V4PpQ1k=;
        b=PeKFBt4ZOwLF7LbNGtMNsLN3wlUWCyWHxycugbhwXM1Srera0ZFkash32tiiUJ3+9+
         zfdYOd3s36lEVz2CvK+O70DSPFutusOGMh14AVySuUc2gCIopoGg1OJDTFv2J34iowsq
         fGTGKiFYNU3beO2CitvzSorZg/ZIJk6N2qQbWaDJez4v5Mq1doMBcsja0CpwLiiwx8kH
         SWCb6DGPl1PVhSBlTamcvhVz4Ky4Xd0B+ZoNqqjPOMCXMFQ472s7VRhu2i4YjxTIRMgd
         GGwSvjFxMGo3LKwPaRVvDhgCDCYMqajOHsoWlROy2kxhViTpciJkFVfXbWZpB6vlMQTl
         IM5w==
X-Forwarded-Encrypted: i=1; AJvYcCU0uma/+N1TbqRe5ha/TI8irH6uElkuZC6mHOJ5e9k5TBYvLurtDqXqL5SyqATujlt+OxpYdcmhHRGViP0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzdm0hD9qD2mVf52Kb5NW4NTV8xLo50iFmMiLgHDhzWyFSd6T0K
	LzLoQg3XS1OWE0mXEYb3ZF+vdHVGV+5nIQlbmMlxCKws0Wl5W/hQIF05
X-Gm-Gg: ASbGncv/PxBffP9kW1R8f1sVDvaekBEBczZHXKsqkfhYgENP6Nw4o7uer8xpqEvcwOp
	ShZRYV7HYiM1XhnTlzZQK3KfmZ5zH/c+S/lsCZlzWvBlgWU2Si+jgruDSmS7+1/0Sdwq5lc3oEG
	08+hI8vscUlnEVHjtdDLBk5eGUg7u0h9CiQhEQbGTjLHEt1/mCO9DJofpp3vQ2Bl84Mtj7Z20tV
	Ed1CopEZX7tP1vnPRjG914UglcDLPFkmNhXl+gXCT0hoXBqvY/6TsCxyarPK8p+si/aoLWdBPzJ
	vIf1qt0L/VW4xHcnvGPZ/4S/pEfKx4Q838gM2y+3yBKqIYEnsocT0UN61Dl1GKw1YwK5qW7UtG7
	63Zsj7uz2o+ZLZyr/pvUiNQ==
X-Google-Smtp-Source: AGHT+IE0uum1cQjjCYy4XHrx9Lz7DJLQZgSgm0Y7FIM4nk9ZjG6E7r6a4gPVs87kQ4KMF3PhUwjdGA==
X-Received: by 2002:a17:90b:1a8b:b0:32e:59ef:f403 with SMTP id 98e67ed59e1d1-3342a299099mr13890106a91.17.1759035526242;
        Sat, 27 Sep 2025 21:58:46 -0700 (PDT)
Received: from archlinux ([179.113.184.101])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3341bcd9afbsm13383430a91.0.2025.09.27.21.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 21:58:45 -0700 (PDT)
From: =?UTF-8?q?Eric=20Gon=C3=A7alves?= <ghatto404@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3] arm64: dts: qcom: sm8250-samsung-common: correct reserved pins
Date: Sun, 28 Sep 2025 04:58:17 +0000
Message-ID: <20250928045817.37384-1-ghatto404@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The S20 series has additional reserved pins for the fingerprint sensor,
GPIO 20-23. Correct it by adding them into gpio-reserved-ranges.

Fixes: 6657fe9e9f23 ("arm64: dts: qcom: add initial support for Samsung Galaxy S20 FE")
Signed-off-by: Eric Gonçalves <ghatto404@gmail.com>
---
Changes in v3:
- Actually fixed <40 4> indentation
Sorry, I still had my editor on 4 spaces a tab

Changes in v2:
- "Fixed" the formatting of the <40 4> line
- Added Fixes tag
---
 arch/arm64/boot/dts/qcom/sm8250-samsung-common.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-samsung-common.dtsi b/arch/arm64/boot/dts/qcom/sm8250-samsung-common.dtsi
index 96662bf9e527..7696b147e7da 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-samsung-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250-samsung-common.dtsi
@@ -159,7 +159,8 @@ &pon_resin {
 };
 
 &tlmm {
-	gpio-reserved-ranges = <40 4>; /* I2C (Unused) */
+	gpio-reserved-ranges = <20 4>, /* SPI (fingerprint scanner) */
+			       <40 4>, /* Unused */
 };
 
 &usb_1 {
-- 
2.51.0


