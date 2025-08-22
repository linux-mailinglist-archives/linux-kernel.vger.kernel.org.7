Return-Path: <linux-kernel+bounces-781802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F434B316FA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 14:07:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD1A0AE7480
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 12:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A952C2FD7BE;
	Fri, 22 Aug 2025 12:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xtpn+do6"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0142FC861
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 12:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755864279; cv=none; b=ldZYjWx8ybgiXCATCE+omIzHCvM2jh/sdYQBDUwCWoM0s6asZhnKYlrrUtgSEVhMwgxa+KoBHwtjt5dvU0WT6IAkDDmoEE2ByTIUZcinSD4/Im1P2YEUQ8XKEA7O/JR4lZxAVyKPRRhMXdHXxP/mwJuaCZv4WB95+1nkA3JPWto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755864279; c=relaxed/simple;
	bh=Nl1AXiz2Z4p4lnOPqKJY0yE8Po/M1Mgx04XR9zxm3Tk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GJUfnbmp7gExJFg0WDPMQB2czziEM4MAO/PM12Ix4U6Vwk6dh6WlpCAU4kFd6Iqk3zXrIIAsMRoKTvZ8A5sFcOcuhycuC8mtQp1ivsS1gQAOAEloTU6k6ZsICOZil8mdTxCGNQdkYNxfqRrALH0aIfC+orWi3ogtnG7Jy9XHW38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xtpn+do6; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6188b72d690so289684a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 05:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755864275; x=1756469075; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xMcFKpEDgWBT+etZLF92eWJ1yCZY3x23zxoGyN3QfTo=;
        b=xtpn+do6kXyk/L4sLAhDKvejKTskAcVQ76XY8+P6b4OpcDlgGT/xX/jIXjWNOlwHkZ
         oXZWZ7a2Iu/uWEAtsKXpjGzaNfQzv7p3IOcMfFzkjsvo5fDa1uWLw+RrCPjFyxkP1xAU
         OY1BzVA7itxXFz2KsVwtKf8ZgwRiJ2O0P/Q9nFE6sd2UadgsEtMg9fJNNOaJ9CdqQi1d
         xZE5Q8hO2ZGS+6JBBpYgtY763BcDRoQfcU+3/3PcvqjXBSJ4gqI8akzlDQ3mumz/8RWt
         nDdViY2TqIjwGr1ws4rQc4mhW5rhc3c93OwtRkF00sdK9dfkwEYYv9u0NYgBY5ObWTBw
         GuIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755864275; x=1756469075;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xMcFKpEDgWBT+etZLF92eWJ1yCZY3x23zxoGyN3QfTo=;
        b=Q431t4eRXIPpAUlHmg9X+Qfk3H92ijBSY/JlLl4OkP1hzow4xhb1pQGOzs2qqtLKDC
         HBmGfxBTW0955sFY2adnDfTIt9ZYyHse6OZL04Noba9d5uBbNlmRoNgp+/XTj27R/O1v
         K5pXd5cWaFhi7hv0eVnzgSpE9knospu73Bf16uo9bivLnjfw0Lq3AfSE6ux8QXOj0881
         XeC0GWyTYuWQr6ii5WKuN4PJYG4TQO0W7l3yofb7ccamZkybAojGeU0FqiJaIxc3n8b4
         7ji+M2bncqx+zHKC9/7JYKF2J8amfDMhCtc7a/NQjOCIsUg71l1CebOWVGYTR+ZVw4h/
         Qqfg==
X-Forwarded-Encrypted: i=1; AJvYcCXjkiG9iwVa1q8svbCc5amnhBS/wVpYy8pdo2NRiJ8La/0AkhXm77YWjApRsVkTrzs/mCVzy6Z2KSJv6ns=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEU9v3c68CqZN8907UwrRTJC71Ex5yWeuiroRfWeTOgvQxnh2x
	BiD2r3v/qx/1ZyvmJj5oSnSJCIKei5SMCO5D/B1OqSULpgRrHYXh2S90x9Hm93pF+AM=
X-Gm-Gg: ASbGncuPHAw8jwfTsqC2gNWdsXEuwMPBk1/S6h6CbHZGQhonX8ITzwo3QbSxE8idfkk
	tfe2jsUbl1I4ULME6UXgzDtexBGZFSG45iAL5cxywS837Oimp9aVSfXdQ0Y4Zi7T3DKVau6WA09
	3r6YbXun7xhDZrB8/I9KcfKQj0R6LfjjPoVwaXlpTtJNPY3LeTbJpj9yzZby4cf50u5xQ58Z2Ae
	ilkU+2dBlG8Z7Y+Zmcb0LVX1o9QwP4EEsjexfZ/BpRFWIMmCR6AfLwRI78BX9C4uQZMx9a2gAd3
	irp9nObL9owWNVJCJisPSo2H7le2pPaEV9uuea1tB5qxOM8KiWYEyzGcxRYcQAX7lDLD5bTGftx
	tkYHRL4BTiGJwICGZvXa1/KAQibZ65KTkJe36lXE=
X-Google-Smtp-Source: AGHT+IGZefs+jdspMhzdczulgQGXpkdifF4QchYehdEQHjFUlWkkkQVzWgH7Few0eewPyo+ZKZFA4A==
X-Received: by 2002:a17:907:6d11:b0:af9:aaa6:a86c with SMTP id a640c23a62f3a-afe294b1326mr123442166b.10.1755864274713;
        Fri, 22 Aug 2025 05:04:34 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-61a757b9b39sm6690444a12.48.2025.08.22.05.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 05:04:34 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 22 Aug 2025 14:04:06 +0200
Subject: [PATCH 06/15] arm64: dts: qcom: sm6150: Add default GIC address
 cells
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-dts-interrupt-address-cells-v1-6-d54d44b74460@linaro.org>
References: <20250822-dts-interrupt-address-cells-v1-0-d54d44b74460@linaro.org>
In-Reply-To: <20250822-dts-interrupt-address-cells-v1-0-d54d44b74460@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1399;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=Nl1AXiz2Z4p4lnOPqKJY0yE8Po/M1Mgx04XR9zxm3Tk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoqFy/eT4zsGdrv2SZdTZqoRptOxs1Ylg9uKiZl
 9vnv3/VpEaJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKhcvwAKCRDBN2bmhouD
 1+C5D/oCNG4FNbsZ9Sc7bDm9tU6Xrse/38u8SBGpqvtNK1eBEC1NSZkz7A4f1VrF9srH7jsa8bD
 5/HaGJVAbjsRm51zX2jivr857MN1RDzV80KAUsPLOZ0sb0Tzz8KJjwafkahZm1KSK7XFwe45vWr
 GZWIHR3W3lRzPMwKecEjFxcwY7pMpU4qRriYo06MC8cAZQuF3cre8vL9zxDZzg7O85VIwnpHUe6
 Jq5IBumIjR5VxVUi2PpBdhVjJFN2OwJgYUb6ot+rDNwwdNvXz4c1ipexeyzt9N9R5LGBfFVHkgp
 5Sc7KkYL8MWvpwo3i42dfdANGFYL7IkMibbbYC4Idldgz+W6HmZt1Tg3CF1u8rx+q4m7sU+ZUr1
 QpQH6nLqG6XXLugl54aix6MZHH5CgiAKZFHsoFF8umEO5+2Q62X7eKvKpkP20qUy/khCY5KHv+a
 Q16pvRwsRRhciaI9kNrSzni63LFBPKwdZYKPQy+hooJbuQc9JfSIK1e+h0vQr9eXFPpLnFRzx8Q
 Wj27dAvjos7OHRb8+E7obp4I1Rk4Imy+k9YXNPHxCeXv32kBCV0BAD0LpGWOpsoS+yB8EL5YrbL
 Wa99+OhX2oRq2tHisUcoEcZxT5EwPiJ2GKUSnZllt56PQi2P8fK2ISv+cUOGXXQsNvydpja6p+z
 F2Ac0Isq2n8EW6g==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Add missing address-cells 0 to GIC interrupt node to silence W=1
warning:

  sm6150.dtsi:1122.4-1125.30: Warning (interrupt_map): /soc@0/pcie@1c08000:interrupt-map:
    Missing property '#address-cells' in node /soc@0/interrupt-controller@17a00000, using 0 as fallback

Value '0' is correct because:
1. GIC interrupt controller does not have children,
2. interrupt-map property (in PCI node) consists of five components and
   the fourth component "parent unit address", which size is defined by
   '#address-cells' of the node pointed to by the interrupt-parent
   component, is not used (=0).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6150.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6150.dtsi b/arch/arm64/boot/dts/qcom/sm6150.dtsi
index b66bc13c0b5e337bf9a95b4da4af33b691c14fb5..09887b3687d42ce59e1dd1004ea19f05b42b66ec 100644
--- a/arch/arm64/boot/dts/qcom/sm6150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6150.dtsi
@@ -3659,6 +3659,7 @@ intc: interrupt-controller@17a00000 {
 			reg = <0x0 0x17a00000 0x0 0x10000>,     /* GICD */
 			      <0x0 0x17a60000 0x0 0x100000>;    /* GICR * 8 */
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+			#address-cells = <0>;
 			#interrupt-cells = <3>;
 			interrupt-controller;
 			#redistributor-regions = <1>;

-- 
2.48.1


