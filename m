Return-Path: <linux-kernel+bounces-815998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AEDAB56E07
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 03:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6EE2177E3F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 01:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D747D22A808;
	Mon, 15 Sep 2025 01:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkktv2Y3"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70EF2248A5
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 01:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757901180; cv=none; b=r43WRTlw2moAGZY2yDj48m9Z4W6DLQ7NJ+8umo7jKJvwfJxBV81L2lplvgm1Lcg1nxJdFaHG+z9spvhqqYROJZkkK9KdKlhg9l7Vval47aozuSOX3PIZG26fFwyfwDgP+zJlEJknA1+10BlYPM6yU4wvP3krrXGAxsTR/OxLvTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757901180; c=relaxed/simple;
	bh=SoJ2s/7xaJZqpkZFG/E32MO93SiVWiC2LB23uiW2KAI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RvIinVS3GbbSRZVHvrMe2+J/CuOzyNysd4rXtGbyLvD0s9SsBehhlmjKrmMjQb/Ak9zk1PYaBp0XcgFnS1DIw590QYYPA8LwruItzcsI8gRjNPwLvhu9zWIRaOYnH09AQjbXcYtQlOs7WSitKxCJayAqaYmajpXaHzf5FyvISUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kkktv2Y3; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2570bf6058aso48817615ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 18:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757901178; x=1758505978; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5H5+bfFpWI0JlLzmp/SN5iCuvqCago9oAPrj5EA3s9w=;
        b=kkktv2Y3QZfWr3+P3REjOnFq9rqxOraT6bgy2+W19pSk4BGCteDUH06g5DxQJmt/H3
         3sWCGbW3puKn2N/opnvlT3agat6Lii1UTHVvNgaPh+4Yc1sdYzNbo4O0ws1rG3odjfXT
         cSzRa7ojnnLKZwtWzScETgFOkFeyT+ppZOvk58Y292uCxUBQ54NPmXh4qK1QlYSdVmW1
         NdR/Bu4GqO9AQkl1UGUNvn33EF3AroiT8sGmswe1MiIc6qFyJiyRUXyHSRd6G3o0+5uj
         VRvKiqN6UMnr2UqwJm36niMcg/K2nw3S3Hy33YL6A2h/DioDI+zINsOtn+vvjwmlpESD
         mqgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757901178; x=1758505978;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5H5+bfFpWI0JlLzmp/SN5iCuvqCago9oAPrj5EA3s9w=;
        b=HD8+oz2amKaQe0ifZFKZo46CsNXhKAm0bFHBxzQVbNSSuGZXpA4k62TKlMYRu5wQ50
         SYc9xGVqY8AR4YB7ckJM/oNxCP6ZUzM+kIsPgclV4p/ycBY0ehYIppcJz9DdSpqh0C5g
         HquhPhvWRR4MNCJzyJYTiFcqATr+Pm264CVy1SHQRXwfrL/6eHDFWNfgQIjp1sXd342x
         7PDY7S+R44s+Dm6s4/mZbOWb7bbFmS7kFRFeZ8w0oO9hyfyMkcUGM18DW6KmhOTRwyli
         GTLOsxvHX7QRxQZx24nO2I9NBLaK2n99kBaqgcthasgwDB2ocgqD7Eug8fuK/gwRVqUL
         swhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmEwQWEghBB6fu+BwHicDWJbWsReXp9VdogBxP209RtEI/VTyMqwd7/yobLARTz5wXNXAgAzfh0w+e7DI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl/YUFN6DJLpRps23fWfaU3PJwDB3xv+k/xmrP94oo9xQ5JnR2
	CLs/rDZjo2g1rfAFcfBPHED64eFHvzvQv9xFovhYL9P+RVYhfW9Oo85X
X-Gm-Gg: ASbGncvSbPsN7FnLnjvf/lYNtVHil9iDJjb5h/n4sBSUlrGhRNb9IevMwJoTD7QiUfz
	7cKDTtiIy0gvPt0IU1iRkK9rccXdNsz2ztz8WVdFVIgVI9n8byzUb2ciRQcFj1SAeaY+TwD4LGS
	ZFDdpjYak2xrcRwss2pPaSKz82zked+DiDoOd0ory1z+aKunoJPV5UupbyrKJ+bmkkdgx/M6wL4
	L/VHCp/r/1821KGJ2XcTBCid0A1kq0l8IpOn9hDjjIxq1iOcggvCMfuWpjc3SlZLAyicfeZL59c
	Bt9TU4xorq8skRWmynUU+y3RujxA+mUyqj3Q3tBmwgcHxxzZDhPh9p9+EZ0wkM1ZG/Yje9cIG1y
	ybv/Y5eJzOXHLtSAb9Kw5KZm+rkavG/2NfV8=
X-Google-Smtp-Source: AGHT+IHMm6zQWGhC4CRJdwqcwAn6ExfzlmynisceaUa39WHIvw//bJ//An8p3b+Oihj72okwQgAGDg==
X-Received: by 2002:a17:903:2b0d:b0:267:95ad:8cc7 with SMTP id d9443c01a7336-26795ad8ec0mr6064675ad.54.1757901178029;
        Sun, 14 Sep 2025 18:52:58 -0700 (PDT)
Received: from [127.0.1.1] ([59.188.211.98])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-262df893ec5sm41565255ad.46.2025.09.14.18.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 18:52:57 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Mon, 15 Sep 2025 09:52:25 +0800
Subject: [PATCH v4 2/3] arm64: dts: apple: t8012: Add SPMI node
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250915-t8015-spmi-v4-2-758620b5f2ae@gmail.com>
References: <20250915-t8015-spmi-v4-0-758620b5f2ae@gmail.com>
In-Reply-To: <20250915-t8015-spmi-v4-0-758620b5f2ae@gmail.com>
To: Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Sasha Finkelstein <fnkl.kernel@gmail.com>, Sven Peter <sven@kernel.org>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1145; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=SoJ2s/7xaJZqpkZFG/E32MO93SiVWiC2LB23uiW2KAI=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBox3FxeqmBzqAGD0XoST/Z92rIDU/5LkiQ3p/3r
 NRJnPkuJ6+JAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaMdxcQAKCRABygi3psUI
 JFfQEACShZQC6WLqLE/aDkYMN3XdssIhvINVp+gaUZw3BZ2/6GDq6jyuhu8I6j6HpOthCOP9PXf
 lQPdknQu8U7P5vGITb510PzdyI5GWk2tbjECEFM2GCrHvua2OCaPvKU8iTDapw4oG7QvT3mrda0
 kHmnObP36QBiuawsVeuw9y/7fm7cz3vPVI1FiSOFdyQC7+yBpWurCfYYNd0/vaK0nQOeiKtiKy9
 Rhg9nG67+GSijrBI3Rciv8VSo5Gcd8txQyJ+xYiA35aadAukvnNgtrk88YaThNPq5rRokB9DBuQ
 6Q1hszoSx9I29qdqBn9p0APfkumQ8PuLxVtDGBox1B6yDL9pH3iQg3IHFxWAimt7LU4QC/TZBrG
 Pjbsh7PBXLqUMLHb6KtjFEBe/U26LpKKv6v13cZeF91cKWJczxVrTwfYb0TkILbH/z3fMGFvow5
 a5rAvPuRoDL/sPa/SBnTnrWOdC2m5YgwaWR1bNc9cHCcirB+G9x9kB1kaBBTVY93dwpCGLqPpJE
 FJL1IBL9PMnQLCY0b9+QD/urD9nMlZT4z7bZdT9cynrka3jO0AhveaLQftQ7s+Ls2THKiN/ZiyU
 26L0cky6XnlQ42ZRnyi+Yj2EsQJTTJIiM2lfd4O0Ixs12EFrLSNT9C+zCAWZwroItStwD4ZZyIo
 G6LJq9iuN4EqQ8w==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add SPMI node for Apple T2 SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 arch/arm64/boot/dts/apple/t8012.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/apple/t8012.dtsi b/arch/arm64/boot/dts/apple/t8012.dtsi
index a259e5735d938cfa5b29cee6c754c7a3c0aaae08..e7923814169bd4060706945561910ed1d5c2e0c8 100644
--- a/arch/arm64/boot/dts/apple/t8012.dtsi
+++ b/arch/arm64/boot/dts/apple/t8012.dtsi
@@ -11,6 +11,7 @@
 #include <dt-bindings/interrupt-controller/apple-aic.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/pinctrl/apple.h>
+#include <dt-bindings/spmi/spmi.h>
 
 / {
 	interrupt-parent = <&aic>;
@@ -220,6 +221,13 @@ pinctrl_aop: pinctrl@2100f0000 {
 				     <AIC_IRQ 137 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		spmi: spmi@211180700 {
+			compatible = "apple,t8012-spmi", "apple,t8103-spmi";
+			reg = <0x2 0x11180700 0x0 0x100>;
+			#address-cells = <2>;
+			#size-cells = <0>;
+		};
+
 		pinctrl_nub: pinctrl@2111f0000 {
 			compatible = "apple,t8010-pinctrl", "apple,pinctrl";
 			reg = <0x2 0x111f0000 0x0 0x1000>;

-- 
2.51.0


