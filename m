Return-Path: <linux-kernel+bounces-735422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08042B08F1E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 16:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B1AA7BD0DD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 14:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 997382F85F7;
	Thu, 17 Jul 2025 14:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YNaiegbu"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CC62F85C6
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 14:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752762190; cv=none; b=NomNd/k3eUGRqSmSE0ZaXUwe64NnLQsRao8OJ7MLFHrtZlq5f8t+IGR+rXiPu9RXjR/paHEel1K8sklzTXoLDF7R/5xGsqFQJml80999XKkOhsHoli111y14bdf2H1w34Y0W3+48Qy72ay8+ESydHvgSaKSrMMWu5zDRqL3D3oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752762190; c=relaxed/simple;
	bh=5lS5PcV+SW9LtXN/oJ09BpDx+tl0xtlpI3fH+scoObE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gt9f234iUO+YpcrxlHJ0N+eAWJe1PRZQJVZm5sda+FW9w/hZRYiFl0DWoQavgKm3NXoGwiJv04Yjdx7W7DJXMepHsAqZ18XrvgsiQkPwOPC3LEhaYq9Z0C6+SsQMYnwpqvj2JLB8zFPTer9QnsgXhUxJ14GzddKAH0MvnsddGAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YNaiegbu; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ae0b98ccc57so15685766b.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 07:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752762186; x=1753366986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uC7B9qKhN/4PoZChB8nu5mHDtv7dsKlcLqC+7kIFNiQ=;
        b=YNaiegbuP15tagjYMrMhRpxeqPmWr07haVZpIDVV4DqTkHu3uGILJqG8aWwGvKgg64
         mknTMqDZEm87I5sxstqSB9VdEzPV4G/TXxOyfNtCZ076my/8YTGzyhGIxKgAWPNe+cWz
         xQ+rz9eai5WLZlSHOdzQ7pPdJnlCXudW/jTgK053B33uwDW97uTkjwX/QSXW6dDg5Dia
         H6BlrCH6AnARVtuTBG1PfvfDfw/YUhRUMtcJHwv4H7P+MhaD2XySPEzOBtyHJRwOdhWM
         AEHahdHbn4XPchsfjsbhMR4ZvJa70qWoKamUYqMv04T/e+6S+24SCQjB7Yoz0G7KkwgF
         qTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752762186; x=1753366986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uC7B9qKhN/4PoZChB8nu5mHDtv7dsKlcLqC+7kIFNiQ=;
        b=sGYPlFs1j67SVefHxQiHIB069DpB0QQsy6xt5J8Rx86/xSh1KQvV06Md2vLqteFAAX
         Bj0SiAbzybIDZ1nMbB0uTi6xOeb0spbv80NpKt4gMNzREgIjhC5wIn9Sss59VPS3pqK0
         mQOCeA4Iz5C0RywiUfT5AF2yaviqFMFXXfaEXcCDPAXl2BaHX+tMlHEglbq94Byfq9lo
         g50UkenyFM4S97ZrcdpMiZUxGUnat0fdYmJL0529jb6O5UEsUfbRPYst2C5RZ7hchIW0
         k5Nbo2ztR5qAwt2q3+EW6m5jJ9DxStWrObg/gyorG6tPxtVr2Omh+ERw+aDrYRVc1wKo
         s6Qg==
X-Forwarded-Encrypted: i=1; AJvYcCW59Qga8VcFcB+auxh5pylH6RbhM1ZU56rilpiqMDaqKuazXk6UuUd+VhTdK2Eu32ppg+4BWlS/mpbSKMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YygAZKQxPw/SLlDTboVFnUYz72VLFASS8370D+T968FaIKGGsOU
	0Wq9MeMgmzJQTXbzoYN8QUgYBUOUibt85xG7wwJ6/njjKmJPY1NU89icLCLoZerD6b4=
X-Gm-Gg: ASbGncv4d5WRx7uTytFRQIusN3oU2Uv1bUf+vkm2z7NLlRtSevhkxelwTpkpk72OHK0
	g55gtPPvEZt+R1oxmuboZvdsToMt8J1Hpmm3+e5bKP23iQtJIkxbjjr4vpPro5Aky7bGyHXvM34
	WwWC6D5MLufd29TcV0PMZvJ57kZneS3DNnOiNvrhnsD2JpgP5tbiGHu+j/NALVdcI5pGvH4GnJc
	SspOmfPKHF94DrX1XKwyVPQFhmF8HkShic33zkjo1XACMElocD4+tBsDdBPGWZgX9MxjOKOoUhr
	j1ou9VZTdjVp/ee1m7a48WanhkXa10Mrj94OStRlt0RqE7n894SOzcBXmgrdoSBIBPTkYPREm3L
	8peElFs3/TZsCMRktds2wcKOI5QSlJZJ9
X-Google-Smtp-Source: AGHT+IGuuLa3Vb/KSBwUg2zTekQ5l5vJ975p9f4R+T5/YcFzGiBqvq9lyW2cY6LpT2UokeowN2VhEA==
X-Received: by 2002:a17:906:4789:b0:ae3:617a:c52 with SMTP id a640c23a62f3a-ae9c9955332mr273565366b.2.1752762186554;
        Thu, 17 Jul 2025 07:23:06 -0700 (PDT)
Received: from kuoka.. ([178.197.222.89])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae6e8294c0asm1347281266b.127.2025.07.17.07.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 07:23:06 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Avi Fishman <avifishman70@gmail.com>,
	Tomer Maimon <tmaimon77@gmail.com>,
	Tali Perry <tali.perry1@gmail.com>,
	Patrick Venture <venture@google.com>,
	Nancy Yuen <yuenn@google.com>,
	Benjamin Fair <benjaminfair@google.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	openbmc@lists.ozlabs.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: nuvoton: Use generic "ethernet" as node name
Date: Thu, 17 Jul 2025 16:23:02 +0200
Message-ID: <20250717142301.92548-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1445; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=5lS5PcV+SW9LtXN/oJ09BpDx+tl0xtlpI3fH+scoObE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoeQdFiZYpYveODGEOcCSwOy+4ytz1aspSwdXmV
 bupbLY4UWCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaHkHRQAKCRDBN2bmhouD
 1+lCD/9N0B5vDrapB44zfaRMBd43QiAg4+VWkXSnAgNQcc6bl6s55kbQqIMGG675vjFEDbDqnHC
 ckMHUTmLHs7sEGIOmymhIPTsXYi2KDDgr9htpgc0Vl+hsyrSFhA0KJU0vtp8mEAJIPY/4UhjPfi
 l2uQ6MQarJHIif3xCNhuBuz3l98DL7zobU/Zetk2c128ecapJZBIQ7tlSsB6V25DqtG692sk/FU
 BrkIlo6aoUscY/dut/b5dK3jKYHXbQ7DeFDMSf3SO8cgH9gQAmkEOcFPBeXHUUMZWY9NfTN7EH5
 R2YVrE+pGK/2CjP/2c07LP3GpFIX60cTWIYsaPZFAChfFCtxoOio4fnZTr5V39Rhx4jknvBcQ2t
 /BwsGtGw8SvF+3bzZbN0xWdiufQXogE8Kfzb2ICBYF1cOcWjQilh7+AEvEINUDTqBvK3QunNoHW
 NeNGWC47Lb7Xah/mo3pSFzfE1z9Z1XhRnxfeE6gK9+U0te37YjFZyBB+ZIodGOBcVMJuvKCR3BO
 oNzzgMsg6C4+UEkiPyK9wfScJNePWJWi1i4ZSomYW8auswpUhBwFNuoYT7k2bdzSBT+L95CIGQi
 OWuFhkloN2hNg6PjOVIYJH4+4hh0tl6luYfLvnMVans/0CM8h3Gn54MhJmKcAcchtb/tt1ElpL6 1qF8eLJ2mQFDk/Q==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Common name for Ethernet controllers is "ethernet", not "eth", also
recommended by Devicetree specification in "Generic Names
Recommendation".  Verified lack of impact using dtx_diff.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi | 2 +-
 arch/arm/boot/dts/nuvoton/nuvoton-npcm750.dtsi        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi b/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
index 791090f54d8b..98c35771534e 100644
--- a/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
+++ b/arch/arm/boot/dts/nuvoton/nuvoton-common-npcm7xx.dtsi
@@ -134,7 +134,7 @@ mc: memory-controller@f0824000 {
 			status = "disabled";
 		};
 
-		gmac0: eth@f0802000 {
+		gmac0: ethernet@f0802000 {
 			device_type = "network";
 			compatible = "snps,dwmac";
 			reg = <0xf0802000 0x2000>;
diff --git a/arch/arm/boot/dts/nuvoton/nuvoton-npcm750.dtsi b/arch/arm/boot/dts/nuvoton/nuvoton-npcm750.dtsi
index f42ad259636c..65fe3a180bb1 100644
--- a/arch/arm/boot/dts/nuvoton/nuvoton-npcm750.dtsi
+++ b/arch/arm/boot/dts/nuvoton/nuvoton-npcm750.dtsi
@@ -44,7 +44,7 @@ timer@3fe600 {
 	};
 
 	ahb {
-		gmac1: eth@f0804000 {
+		gmac1: ethernet@f0804000 {
 			device_type = "network";
 			compatible = "snps,dwmac";
 			reg = <0xf0804000 0x2000>;
-- 
2.48.1


