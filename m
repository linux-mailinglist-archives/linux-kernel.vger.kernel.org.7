Return-Path: <linux-kernel+bounces-782009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B74DB319F2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:42:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C978AC7509
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C2D27462;
	Fri, 22 Aug 2025 13:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ud6xamC8"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E19308F06
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 13:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755869628; cv=none; b=NMKE/5mxsB7aK9N9DitUy+zDZI7Dvr2pzysJktcwvwwDG6RMgkX2HJW/i0Fi525zOMJk7JtWcLK0n4A4tUWbv3eZRnB/y/GacSUKizBX0Vdzapztw3kZ3+Eh0+/q4DHYCOcAZFinhYbHuhMDaA50mGDFx3vNtxvvE6i9i53Cc9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755869628; c=relaxed/simple;
	bh=EwmjMlE2QoCSD0hZhfDTNhzQLPoaw5YuZzcqGRT0sdo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VjHjvsvIH5QovIb8XdFD9wmdVCDASS96TJ/JlneoshUZLBJHqMKlluaEZP4tlGstKmQ9h8fNfEMnsF0JKl+Da4pxlS0oDV3XyTZe2xKfaYNxCuM0sI0081ollMUna91eUx4cJoclQlDcs+F6lRREB7PJgaHBO6Uq+gjdi549r5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ud6xamC8; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-61c20df01a9so96251a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 06:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755869625; x=1756474425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KONnmUwM9SvGBu11jgjxTCrWYcVMEKLZtMiY4/idju4=;
        b=ud6xamC8m36sVHJsCaCMnhqOn7V4/7Z0Oae6dppvryu20Er1dcpyMkJjz7nVP+qOwy
         15gZJ8CicG7hdkxXYXDZ69me9JoTaLUOD37fLvThEivprj1IUn153GKnZn/0SF15mqaP
         AAmUeGD+XcMPy384drN21OYBWZPbhHqwkivr3KmuIFE4Y0WQJGa02coeeo92VkSah0HF
         8oU5RLv96ZZavYnRDpzdLfi/gqWiQcVKqGoVNe0kki6PxTR57MbOKtJfdVbJVm9wTJlg
         Yvgvi8akT/70+5MyekViSrAmw8TQ3f3MWHMOyID/C7EdBfaGjpZ1tK1kf35eShaL7CHt
         yjyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755869625; x=1756474425;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KONnmUwM9SvGBu11jgjxTCrWYcVMEKLZtMiY4/idju4=;
        b=PsXHeZTI2lRpQM+sb/gjRJiFvztyGbBMRscti9Pi/0oegde2kIoNwwaL9r9Yoce2EH
         d8k3NKzzuDosaZ1TESjodvmlqUVcZJlpJALGyMIQ0RRFUHsAkoX4Fni16OyWqtIjTA74
         NToSVR/lG1ldMAEuZVaaqiHCzNHMuAUu9qBCsG5J4O8ZLceS5nOjJavt0/DoY4TSgOfc
         CHriHr43AdrTi/zr6q9W4Q+A6cHDuonElt8zMxMLgR2Q0z9d6BFIhcNU/C1+l1kMSo/J
         Ty4GjGPOk1Gr4UWcUVAn8kWGbUg/3P7x43W1R+YVb0GuSRlCSPM1ebtNBfpFSoizFfZS
         v6Ow==
X-Forwarded-Encrypted: i=1; AJvYcCWtGP4KIxrxLn7FeyDOwzKgsU5XIXrdYKJqXOlaJoGZeAopk9jrdN3caCgk3r+nA3+HvCw+og6h9Sp6oJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkCgIrgN35T4mip0sbUoXc8o2qud+smzCUEVFQQEjtULbxYvv3
	revR8USVk/UWOmXasdsOCFG2+S4BoL7lDnNtxE1SjZ66DesoscXv6g0v6H2Nx5sBUSY=
X-Gm-Gg: ASbGncvnFbUwnKE+7PvVC3GWFBb3xe1oN1hzOT3pxlEK7tEPz0Zv2uw++44miQ3rSDc
	PPu/36L4qWjPwskSo1sTbpXZExJwo1kJSvNW+VlgwBXM2sFNxQFPWaze+Ekykd6H6gZqr5hN588
	L/9dV8zZrNlDqxPjmfkl/+Q9fPJFee9FKiZEDwqy+tN5Xkx+tBMpAY6UU6BWqwPhiCHS8YsksWC
	OyJIobXRwpFNQdgCcbQn6gHTcxZro+1DW0ZFjGFi+2RWQsHv5xjrc58fCOfa1+8jniP2ioT2zmI
	aVAmE0/g9H7vLNvWEAq5dqaCUk7I7VvGEThjCPspfOBKm5iBu2y+QOxcP1P6AhrGN5XdBbNbERN
	aUY+aPP97iyKitHGHxJx9bgVnKF1s9Fryrw==
X-Google-Smtp-Source: AGHT+IFpYwdc24M4q3Jp60pzxtQAgr0ziC8W1Ke7bARfbzg/UMd2+blxA8BthoNYN3A2mZIz4HJZuw==
X-Received: by 2002:a05:6402:42c7:b0:617:d608:86e0 with SMTP id 4fb4d7f45d1cf-61c1b217ddemr1344251a12.0.1755869625190;
        Fri, 22 Aug 2025 06:33:45 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61c21c1ec40sm1045635a12.34.2025.08.22.06.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 06:33:44 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: toshiba: tmpv7708: Add default GIC address cells
Date: Fri, 22 Aug 2025 15:33:41 +0200
Message-ID: <20250822133340.312380-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1313; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=EwmjMlE2QoCSD0hZhfDTNhzQLPoaw5YuZzcqGRT0sdo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoqHG0+KJ8AlZBjN90rASeESPQk+Xbrw7EXTxxM
 C26Gtbq0ACJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKhxtAAKCRDBN2bmhouD
 164zD/9acTS/9E1FVVWEILncwx8XHawpXiTMW7e5otqY2qwf6xiPxH1yEsXJmYV+u8oRndpzpFD
 pdYUziWbns9btuGRFLcftayyCeBBWLrfhBE543S2SHMEAcPQh/rrlkka8W4L7Gl2Yju3bFrT06N
 mEn+6ZIvaUHwKDRTXTJgIm8/jf5adW5fbaAr2XXxkLybzJFcTnf2TEegwvWhUqTo/yM38Qt+WaL
 uCY3AK0A9LzMw+WEsPeYhW7IPPFNmxZpMFOYimV8PmU46WuW5ElrSkHpfilNCqAvGC5XdlQlelN
 oZetB+JCeKWAvUjKzLIxOh9J6KR7wmB5j2s9K2m554LMqmf+Cmtlcxt9aHfCCzX15tq3JfLkfWq
 2rz6Ab0vTtXOxmgi3OswS5O68FBRU5wBP0J/3V0Yl1ERS4Q0IccZ4DhufNgKjZH1bf2A7tY6ncm
 pPYNwQLeSL184DHDSY5seWMwzIXKLAK3qwvxiExx2y4ySgiK8pq5II+zrwu5EmI2BM66O/UChpr
 gT9sfwt5DUyVVe+J4OvbwECGvIG/N4Yh7d3ZKYfm42gkGOBNKzahMUET1ojFYOGxSKlosfDrOqN
 XedZ/EZzKTxFPDTkGvRR/ccLEB4Z4uJWKVBFoaB0qgPdr81y8jsCZS2a9K6QLEMOShKkwL/4/4z nXMs61bjJIwMVMw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Add missing address-cells 0 to GIC interrupt node to silence W=1
warning:

  tmpv7708.dtsi:503.4-507.28: Warning (interrupt_map): /soc/pcie@28400000:interrupt-map:
    Missing property '#address-cells' in node /soc/interrupt-controller@24001000, using 0 as fallback

Value '0' is correct because:
1. GIC interrupt controller does not have children,
2. interrupt-map property (in PCI node) consists of five components and
   the fourth component "parent unit address", which size is defined by
   '#address-cells' of the node pointed to by the interrupt-parent
   component, is not used (=0)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/toshiba/tmpv7708.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/toshiba/tmpv7708.dtsi b/arch/arm64/boot/dts/toshiba/tmpv7708.dtsi
index 39806f0ae513..9aa7b1872bd6 100644
--- a/arch/arm64/boot/dts/toshiba/tmpv7708.dtsi
+++ b/arch/arm64/boot/dts/toshiba/tmpv7708.dtsi
@@ -152,6 +152,7 @@ soc {
 		gic: interrupt-controller@24001000 {
 			compatible = "arm,gic-400";
 			interrupt-controller;
+			#address-cells = <0>;
 			#interrupt-cells = <3>;
 			interrupts = <GIC_PPI 9 (GIC_CPU_MASK_SIMPLE(8) | IRQ_TYPE_LEVEL_LOW)>;
 			reg = <0 0x24001000 0 0x1000>,
-- 
2.48.1


