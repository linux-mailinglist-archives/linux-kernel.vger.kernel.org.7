Return-Path: <linux-kernel+bounces-877874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E5F7C1F3CE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7F5D734D763
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04270340A5A;
	Thu, 30 Oct 2025 09:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="OdX1LBb3"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694EC3195FE
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761815946; cv=none; b=ZGyjdsT728q2hkICtE6incG5XczMfFhsmR6gwv7iHoPNawqvvzyTrfaUAqlXYFYgj3LGcT39XRQXBcI8Pa6rVGVb42Z8FKTYsqolQrXD8YrKtH9V4x0CvTFcdwjIqKBtOGsB05igEugtgrBsYPCIxkmS67K9+sVmJg+sk356CJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761815946; c=relaxed/simple;
	bh=CD8jS3mi5l0ptE5mloshmhyPStp+3Ujo5r6yvkMZV70=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pd8cIRz4rNM/B34ex9IEdUCVMhc6YBvwgEHK/ZUH8Zif+F4oZbB986iLnox+WvDt+AG1qbvm8Q7FLxF4ZsY0k+oHmLcEY2hbgwruDJdxBx+N0qQ/7IvevGgCneZUIo5vIfzVv9tJ6Gx8IjXIQEOiExMrkThcwIdpscCPJqb6gtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=OdX1LBb3; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-475dd559b0bso10569975e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 02:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1761815943; x=1762420743; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qKLAYC4j9KDlgpKElsaQCZMFHUJovZT20hAAdQtCFec=;
        b=OdX1LBb3lA+jY1zgep3ugHjX3+AqmCRh3ei1O6FLRZQLstQ4UGbTdxnqIf9XgheRDP
         FPPop7/UR7jsk2JN6eRx7IuDEQ2KfWhTTKrzAfds/M8cppT8Dd9npfiYo+Ee9SE76Tsr
         CBBGQraWlXmpoeNVnu4rCN3PO0uVBFA81KOHyi97Jn6ONRkKvCw9QKjfr3RsHa/tXv0c
         bP5qxGybpBIGjDiXTDmmE1rgNSlp6juYbYgYM2c09QfEwVW0CUZEexDYrhyTJMVWZJnQ
         +SzOZ3jnhONipFQHwRI7PFCudwoNkxzLmNkIQ99O+YBJISFpQFROKaJm9eFn8XelexHW
         /eTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761815943; x=1762420743;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qKLAYC4j9KDlgpKElsaQCZMFHUJovZT20hAAdQtCFec=;
        b=BVkMZr4sedMMFLroEhPbD5QL1sKS2e42bmeWmZOJ3Vv/a5aRevsa5cNq355jTuGZ0e
         a2HkKEy0d0yqslhvegBg4HUV0Luq8ZRYuISbiAPlOLI1vi4FQGZWC1KiyrVoe/+rpfZX
         xsTzmiYziNaKBaunsQhrx4KNn/8drGKh9YBYI2lDw6oR1PXui4jghaoBp+80fVIahOyh
         rJ4EHNG+ycG4tMauhp14cMJrk6K5H21GN0JMJ5//SdPY5riyxzd+c9gGJYJyh9em+5A4
         JeCA81AS0kkNMG225HWOQwOn9fGAFjM0oa4/PCDg4mTgnQbJrF364vRAHK67tk+DMTKh
         RKBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOHfcCr4LE0LrLhtC0DUysU8GQRg4ZrixWx3JUm/hMKa3YGmqMebn4I+2yrVkEmOnXBV2JV+yRymf0+wU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuN86NKJuaKySu9c0G5Yn5oaSYdxZMCcvCbcTnPrpbDmHLjJDw
	AHyWVAOefL9azeenMts6kPDR1x4oKFzqvaf+t6mdjgN4QeRt9h0b124FkZQochXjziY=
X-Gm-Gg: ASbGncuwF7fiQxO8AngNN38NO1Oe13TTIeaKegl4JgMEN1WU7rKZq07S2CdU52xsfrn
	1q2XNX+5gHIhniTNpcELZvo3eydRXqxAzJTOW7H+x/biMdD2SfxBN+GvoBXTetQ+HPQBd2/WY3O
	Fc6/p9W9niDd27f9eaOM/ZDZO/FtVSyI/SC3igPgxnEk9Bwe/OEsWPPqiOeHmAcRLUavkecehK/
	uxyDJ3SZWznnGBr23XiN/ZpcGcTVv0PfCFDQnQLup/MZvxdV81+pmY9OIwZ0VOS3IMWiQfin7xl
	BGdfdPgfGGS1qL5VtkHYdyJ4OiqRDmKMGgc8GToMdx8fcyvVDvKAPYrqxP9C8efYY4BJd2J9m40
	grCcdd0FHp/dah2QO0/ybaHCm54IAbZaFGyXPMrNkPdDvfv7RB5Y2pbCJxgOhlIk2fWfavSFfqg
	==
X-Google-Smtp-Source: AGHT+IHztpojphTrK7hZm2oje3psepYoKf66hj0yoiU6QXzl2hG676l4YpdtXTbxbphCE6chpMgWXA==
X-Received: by 2002:a05:600c:c16f:b0:477:c71:1fc7 with SMTP id 5b1f17b1804b1-4771e1d9248mr46322525e9.26.1761815942698;
        Thu, 30 Oct 2025 02:19:02 -0700 (PDT)
Received: from localhost ([2001:4090:a245:8496:49da:2c07:5e9a:7fb9])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4771900dad7sm64230725e9.6.2025.10.30.02.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 02:19:02 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Thu, 30 Oct 2025 10:17:23 +0100
Subject: [PATCH v4 1/6] arm64: dts: ti: k3-am62: Define possible system
 states
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-topic-am62-dt-partialio-v6-15-v4-1-6b520dfa8591@baylibre.com>
References: <20251030-topic-am62-dt-partialio-v6-15-v4-0-6b520dfa8591@baylibre.com>
In-Reply-To: <20251030-topic-am62-dt-partialio-v6-15-v4-0-6b520dfa8591@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Vishal Mahaveer <vishalm@ti.com>, 
 Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, 
 Sebin Francis <sebin.francis@ti.com>, Kendall Willis <k-willis@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1217; i=msp@baylibre.com;
 h=from:subject:message-id; bh=CD8jS3mi5l0ptE5mloshmhyPStp+3Ujo5r6yvkMZV70=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhkxm3YjSC1lFYsIRXHW1IbGyxxzaVD2iDZ5ycbnwvZtic
 dm4yKejlIVBjItBVkyRpTMxNO2//M5jyYuWbYaZw8oEMoSBi1MAJvJuDyPD8rXW7UzBFTKBrkt2
 XV2TtuveP+OHDM/vFHbOE79l8G7iJUaG1S1HrqSqzzM4czBtya37zDs4rvdMr4u98Gpq0noF449
 2zAA=
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

Add the system states that are available on TI AM62 SoCs.

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 arch/arm64/boot/dts/ti/k3-am62.dtsi | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am62.dtsi b/arch/arm64/boot/dts/ti/k3-am62.dtsi
index 59f6dff552ed40e4ac0f9c7077aa25d68d3b5283..b08b7062060ca12ecae83917a831ee779f1a288f 100644
--- a/arch/arm64/boot/dts/ti/k3-am62.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62.dtsi
@@ -46,6 +46,28 @@ pmu: pmu {
 		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
 	};
 
+	system-idle-states {
+		system_partial_io: system-partial-io {
+			compatible = "system-idle-state";
+			idle-state-name = "off-wake";
+		};
+
+		system_deep_sleep: system-deep-sleep {
+			compatible = "system-idle-state";
+			idle-state-name = "mem";
+		};
+
+		system_mcu_only: system-mcu-only {
+			compatible = "system-idle-state";
+			idle-state-name = "mem-mcu-active";
+		};
+
+		system_standby: system-standby {
+			compatible = "system-idle-state";
+			idle-state-name = "standby";
+		};
+	};
+
 	cbass_main: bus@f0000 {
 		bootph-all;
 		compatible = "simple-bus";

-- 
2.51.0


