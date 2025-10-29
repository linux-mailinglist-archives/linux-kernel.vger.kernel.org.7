Return-Path: <linux-kernel+bounces-877211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 345D0C1D740
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 22:32:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4448F404B57
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 21:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA7E31AF14;
	Wed, 29 Oct 2025 21:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VSnAiSc9"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB6FB31A062
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 21:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761773443; cv=none; b=StUIa1VaPzQS058puRqlS9ORRN1KuWSkBDBUkOGePCjq1eY4jCqNL1xeMfhfnSJ8L4qOkJx/WrHTkp77cQgQcjNuXmE/ZoL/NoH3iPElHfv70ryp4X5/YGrONs5yhjejbA5uDpmodHuen9XKA0CI+Fu/UQDJ10IQ+4YpGRmGUuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761773443; c=relaxed/simple;
	bh=gQBv8QyJ2P1jjtV6AA0m325q9CwWFLoeKdBX4iFHs3A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E7T55XVwxSKZQMV7Lpq7VAM0COUcJuKI5O9XXf6mWCrD3gZOPNMx7ii4m6g7KRl97JSjDInOghFoJdnjFwvb6khpvmNfCj/LKudFVhItz5w2XEol/SmKm95OQQ6uk5df4uuOgUSasDCQD731KRBB0F3HrMbwYgaBSdNNwgcLN48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VSnAiSc9; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4298bada5bdso276969f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761773440; x=1762378240; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fgOXG7TGyvNy5LNqojYEnuxpJ1Y18mLxSMAS8yysg9I=;
        b=VSnAiSc95SWSdNfLFuepNMpCd08W84DclzuwcaPxvSuaCdbKoQP2usO7ZKL1hkFGjT
         BtvVhr3uqpVYIeYoet9RI4jSgtrKrZPkdhQh/t/NdeCTItZApD+2bI4uKAhTI7MpvCCO
         aDmXAy7I9ov79PIACj9P4teDv2F1I7LYdj1dj0FL84fz7oyax3rvJjA/JSCh3LsHaGg4
         dKEK7+I+PiZNi0nFrYFzircPQiKYRU8bZ829+VHI5cSHLTMwx49eRZMVrs6WblE6M8qh
         gJdecWwaXC9Je6CazHTwsH9P2p2A3ceETw48LmZdcorw70F/5Hjn7I/PtbTCxStiDe1c
         aPvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761773440; x=1762378240;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fgOXG7TGyvNy5LNqojYEnuxpJ1Y18mLxSMAS8yysg9I=;
        b=Ur2CSGZv7PGXLG+LdY5bYeJzxYmVVS81SkSyU62MyGZMXuWMWbHAGAIZrXUw0ZdMpx
         N2ryyJcMU9CmXg0pCKpoXSrBkuJPcN+cWgLvB6Sc3x1JYaSWdDSC0KgzqRSDP3fpLH6p
         U1gmysMljE8kTSHBPgELEKzqx5A9q7IhmEwog9AbA+i6SofYrt8BNzJHwNVBukt2uDDv
         tEh1v37NHLslrDgtVdj1F8wwf5BoyDu7kEhTaUAVZU2gmqN30/akUk8CAJnATid0vNij
         KoutI133vG9lh5HmcOQHp3M4uWopluwsZwIMY9e6kPzzahOW8JTHh/kQDHypFse48Fty
         f/yA==
X-Forwarded-Encrypted: i=1; AJvYcCVlFqSob+JdPHQXZB1gHAhMZTCoDT1rbsgKHisL7+NoIq1PPyygBYi53SKnpMVnYuIxnw7fyy+s9wOD1mk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzec3BT5UIzTDSIKI+BAjDqrR35iaWIwiUAxg2ZawB10coTRW7c
	5SGUzzCygwEtvkbNZcrD+RFWIO29q2rrlxkj8ltqKW9jmthH8Wr6ovoRZrHUiErt3dM=
X-Gm-Gg: ASbGnctWLwzA8MsTpC3Y7fTEfSEk91LCpN/aPD/A5xrDyy7LL/1UYcgH5rNfdGAG8Ag
	uKYKh8Tcuu1CGlb1dszOjxPKX3DtqQvA83M0pn+E4fOKT6O9p80Fx0XYH0BLhYukedThq4H+FS6
	/I/u8SlRUWLl+l09UpcIitxI/RIyjClha919UP4wBUM0h6ZJrFuErxec2Yj+NWxx95qbbbDXDE+
	1rGSY/wVWWPX8Gy19G1+trTvLB18zuEYcOeiTLGfxzElRJi0L7hubQHEBJowB6dIPgNsA2hwe4E
	d1u6m2v5AD73vDqB2HnScDZtgj5VD+97CV157aGVCXgq4n8XTKJomQKHC4jK3B3ipLdRixm77hE
	AkB8INNZkItlsTccbOKUUilQlw5FR001ZkTQWcfe1UXUIA4wNji9QNH964bBX6lsBRDpMyR63g/
	UHay47NUr3hicKzIHEQYAmmqjgkULmmQ==
X-Google-Smtp-Source: AGHT+IF1NqZoDJUY6TeuGYBLJNKGQkEzwN/DgNFQGT2wXbkV9AklBByYcgAlF2eMqVlmtU0H31lLUg==
X-Received: by 2002:a05:6000:4020:b0:425:6866:6a9e with SMTP id ffacd0b85a97d-429aed3223emr2945906f8f.0.1761773440213;
        Wed, 29 Oct 2025 14:30:40 -0700 (PDT)
Received: from gpeter-l.roam.corp.google.com ([145.224.90.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952b7b43sm28573457f8f.6.2025.10.29.14.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 14:30:38 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
Date: Wed, 29 Oct 2025 21:29:23 +0000
Subject: [PATCH v2 2/4] arm64: dts: exynos: gs101: add samsung,sysreg
 property to CMU nodes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-automatic-clocks-v2-2-f8edd3a2d82b@linaro.org>
References: <20251029-automatic-clocks-v2-0-f8edd3a2d82b@linaro.org>
In-Reply-To: <20251029-automatic-clocks-v2-0-f8edd3a2d82b@linaro.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Sam Protsenko <semen.protsenko@linaro.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>
Cc: Will McVicker <willmcvicker@google.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, 
 kernel-team@android.com, Peter Griffin <peter.griffin@linaro.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2207;
 i=peter.griffin@linaro.org; h=from:subject:message-id;
 bh=gQBv8QyJ2P1jjtV6AA0m325q9CwWFLoeKdBX4iFHs3A=;
 b=owEBbQKS/ZANAwAKAc7ouNYCNHK6AcsmYgBpAod3kd4vJM8za+qKnMN/EagAer8MUvMl1qLx5
 DjNy+dcNgeJAjMEAAEKAB0WIQQO/I5vVXh1DVa1SfzO6LjWAjRyugUCaQKHdwAKCRDO6LjWAjRy
 upJ2EACgknbxo8pYwwy3izcG3w2u3YzfOxNI7RlPV+Ql41r13R/QNJmqtMXsdkCOMLsNEjUdy1n
 +IdAYRIQarupDaFo5ZjuCWj7ymVajk+hrFUox9z7eSKilmbn3uVnfMB629gD0soxgnurqFBa4hn
 SbOOToZX/TPrFdf5ypy0Gy6PlzwzlY6pZMMgkphERHWmnGDOpUvfun6K3RT3shee0/9Y8LGhEEe
 yX94UFCulK9w6QxDXKJkuI2fvJiP2iezrz2BlSbd0WvdEHI2Jd83l63nj2uinJewjHZolne+lRe
 r9pf64Ob44HQ+eJJKKimB+f2XYmPEqQFPzLQay7SeosYrquIY1Y+XOWBtYn+oIHnIanb73MkNKf
 FLBpk6gHNojbh2hivl/0XPV+Ss7onM5L3Und0HMnr2OqDxZcrVeQQk4rfHWfBgrnDojmxrM+kDp
 XUuQV6Pfi/lHv2Xa2Q8q4fyZJzqM1A3+b8xgHXFm2Y6i20ML6MdIuPRjkBwlTsXOhhtQo/rxGit
 sGgTJiSuZPDLombSTXyMMFViKRZNqM1PyP1UKQAe5QaB0o7GVBYRQpm2hr34t7AH5vrsWwzaxCE
 EKYUq87a84MnO8MnERoMrZ2E2SyWf0MyVY7Cai+ofN9UoJUC99gu2ATKludB2wJwpd3+1Qmu2Ki
 dvzax6MjLXgjlzQ==
X-Developer-Key: i=peter.griffin@linaro.org; a=openpgp;
 fpr=0EFC8E6F5578750D56B549FCCEE8B8D6023472BA

sysreg bank contains BUSCOMPONENT_DRCG_EN and MEMCLK clock registers that
need to be initialized in the CMU clock driver.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm64/boot/dts/exynos/google/gs101.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
index d06d1d05f36408137a8acd98e43d48ea7d4f4292..c39ca4c4508f046ca16ae86be42468c7245561b8 100644
--- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
+++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
@@ -578,6 +578,7 @@ cmu_misc: clock-controller@10010000 {
 			clocks = <&cmu_top CLK_DOUT_CMU_MISC_BUS>,
 				 <&cmu_top CLK_DOUT_CMU_MISC_SSS>;
 			clock-names = "bus", "sss";
+			samsung,sysreg = <&sysreg_misc>;
 		};
 
 		sysreg_misc: syscon@10030000 {
@@ -662,6 +663,7 @@ cmu_peric0: clock-controller@10800000 {
 				 <&cmu_top CLK_DOUT_CMU_PERIC0_BUS>,
 				 <&cmu_top CLK_DOUT_CMU_PERIC0_IP>;
 			clock-names = "oscclk", "bus", "ip";
+			samsung,sysreg = <&sysreg_peric0>;
 		};
 
 		sysreg_peric0: syscon@10820000 {
@@ -1208,6 +1210,7 @@ cmu_peric1: clock-controller@10c00000 {
 				 <&cmu_top CLK_DOUT_CMU_PERIC1_BUS>,
 				 <&cmu_top CLK_DOUT_CMU_PERIC1_IP>;
 			clock-names = "oscclk", "bus", "ip";
+			samsung,sysreg = <&sysreg_peric1>;
 		};
 
 		sysreg_peric1: syscon@10c20000 {
@@ -1566,6 +1569,7 @@ cmu_hsi0: clock-controller@11000000 {
 				 <&cmu_top CLK_DOUT_CMU_HSI0_USBDPDBG>;
 			clock-names = "oscclk", "bus", "dpgtc", "usb31drd",
 				      "usbdpdbg";
+			samsung,sysreg = <&sysreg_hsi0>;
 		};
 
 		sysreg_hsi0: syscon@11020000 {
@@ -1637,6 +1641,7 @@ cmu_hsi2: clock-controller@14400000 {
 				 <&cmu_top CLK_DOUT_CMU_HSI2_UFS_EMBD>,
 				 <&cmu_top CLK_DOUT_CMU_HSI2_MMC_CARD>;
 			clock-names = "oscclk", "bus", "pcie", "ufs", "mmc";
+			samsung,sysreg = <&sysreg_hsi2>;
 		};
 
 		sysreg_hsi2: syscon@14420000 {
@@ -1697,6 +1702,7 @@ cmu_apm: clock-controller@17400000 {
 
 			clocks = <&ext_24_5m>;
 			clock-names = "oscclk";
+			samsung,sysreg = <&sysreg_apm>;
 		};
 
 		sysreg_apm: syscon@17420000 {

-- 
2.51.1.851.g4ebd6896fd-goog


