Return-Path: <linux-kernel+bounces-782016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A214B319D9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73CCB1D230C8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:38:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6025A3128AE;
	Fri, 22 Aug 2025 13:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MdpWcKa2"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006163090CB
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 13:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755869663; cv=none; b=HCT+5VPsR2dbMiGaB1egOVtSn0N0kRBcp/sMTDOSIFZHrJ0Rp4eLT+zILmkPI4s/3k/Mcs0PBDAqsiU58dnzlc6DanL6U/WWo9OWTL06A0fEZ34KvKO9xn/n7xpKNeZT2FW8Ugqu5h++sD/KPCRYKgGTrJlGfKmdwQto7WlqXZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755869663; c=relaxed/simple;
	bh=P47bQ66XSEuwS8+DFMM93nVxZerAVXIoifPVvrFQeRA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nu3quxkpEo2zyZICOb4w58+vgVVvUT6iWEERPiAAVw2bwJHYP3+asL2yuffQckkMSVwfflZ3U+FEYoi5drEeKPEysblrB+o4y6WXeXVtmf2WmQ1OzeNpzjUIvaOyEUfsNQC+J2odZUsZ/xvDCb+SW6mY9NOoEBkzq90cABXhWHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MdpWcKa2; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-55ce52b9c8fso531752e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 06:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755869660; x=1756474460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=81ejwExAEM46c1Tf2YMso6BqkcjZQkdPwjV0a8IrBok=;
        b=MdpWcKa2lbXkIkiG9WBCgvRFfyN/2KnVvjJimsuQPlGZoHob42Xs2Ka4mf3UuKVu2Q
         4AhdyXC7RU1Z7EUynAl2ZlQcCeciNyJOATZD+VB8h6Wx1WqIcmj0R5jQDWFPW+r1IZRC
         LkAbIj0I8pwRuC0cGqtDy2PkMBrum3uGRM8irOtI0L8UJ6r7WP7G5c4fNQNiBWvYmLcp
         5y+vQR8G5qFQIXBlHLcQjNxAJryx5GwETRwX3YlVgh/zYhc0PMmempgivuDWxMfZde24
         zqStD6ewKbTQWKfyijPLn59DH6rV3etmyfCV0ARECtyrySAaVty8s69qUVcP4vfUhfOn
         pN0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755869660; x=1756474460;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=81ejwExAEM46c1Tf2YMso6BqkcjZQkdPwjV0a8IrBok=;
        b=VEl0qsTzhjPXAAGB+0+GMecUflL1htHZGxg2hJfSOsgl/x+B1DXmy3YjYW1VwhDovJ
         IVqUofacl26FBH/9cffUx/wPpXVDclp8UigSdCHGz0DlyCueoq6M0J4lmbyYu2NWcQcK
         O2CeyCU/DOBu2DfNYE8YbtqScz6SHo+I0g3cuu/Mj0fXg+8scCv5pRkvFX2qn3lGDLI4
         YLo2/bqRQ75CkAfjfNJFczJOkqfy4QJIKxN/SnevnapmV8QY3dEVWy3A2KMMIlrZq8e3
         9boYwC359Oth1ZxPf1/+W7fsjQ70qUFp3EqgQT/spQEzIAyQrdOnQr4PjiEGJGriPMSo
         AQBA==
X-Forwarded-Encrypted: i=1; AJvYcCXq7Dglypx/CKfoRQwMVS7qNDPSSXEY1C7DJ7v6wyiJeU/ISF4Wy35z7P09QmULRQrgXVxrqkSqfJkZQ8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwseateN/0wV0MBo9gegPxwGVWMI8SuCTAdQmGghQTE+5QaYDnd
	n1k/J72pJLKo8newO0nJp1UwsayoZaAo1Sr9HP3Z5vhdz7sdKUuscZwBlYq9x0tHJGA=
X-Gm-Gg: ASbGncuLtE47qmStt1U1NQoWsW01RFww5NZ3OzT4pmBvFV7oe30WjkAybQPrJWM20Gl
	Ed5QLDURkgOf+lt5uQ3oLxLc95+H1qCE7/w5OWg2wYBeHOCT+Ry6PFsCRPFHiEhph1okyhULgp4
	6/r45a09SBHRyFj05JPmyoiq5SYLl/yM394hLdliD4wxgh0WAIJfEwG2+oKFLUYbpYaV/rCn8p5
	Jk2BeDK87Tr67HqmKHHxm7l/ch/9RXN6BV1mD0oPCX0ZcITrTqckj+IMJyRBrNa8fBiKZeJYvVy
	K6v56OuFMQLjNclfIGqjv5TeKzoOK79JVwpJ7JeI5DDDxI52O66q+pphkjGhMy5ESTFn5kRy7CM
	SARFTmWjIjmfBil2dDt6/2plIEad+fXYabw==
X-Google-Smtp-Source: AGHT+IGba0Ybvo9veKY/hDHLWA2qA1dWPIhW8WvzOmbixdwfnEXY42kkeXuLBFCpk9t4v7aF3gIfDA==
X-Received: by 2002:a05:6512:3c98:b0:553:2480:230a with SMTP id 2adb3069b0e04-55f0c3ea828mr570995e87.0.1755869660167;
        Fri, 22 Aug 2025 06:34:20 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef459facsm3556420e87.157.2025.08.22.06.34.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 06:34:19 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Khuong Dinh <khuong@os.amperecomputing.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: apm: storm: Add default GIC address cells
Date: Fri, 22 Aug 2025 15:34:17 +0200
Message-ID: <20250822133416.312544-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1260; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=P47bQ66XSEuwS8+DFMM93nVxZerAVXIoifPVvrFQeRA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoqHHYd6zkEgJCRnDIEPOewyB0q7QxAOC46A/Zu
 +nIQX2S9Q+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKhx2AAKCRDBN2bmhouD
 1+7bEACX1nv4HM3jtuZ2d1fJYtTyID75QnLGfWcFJSoOxiotKnNJVbGWuD7v2qviIUdDvlnwyyd
 526iQuJYn+IJkIsaInLe3+Kj0OGoR9QWAul0JUAzHPFreQu3AmFthp5hOJIBN0PmmionZqJTMf2
 JfJo1Tsg9nO9QNIRGfaBO/i1hBR5k4q9CcrCL9dKkkiZFjNXo9qxjGW8BTjUmONnwFJAJaiR322
 xv9SmtHEOLzJYKnWRXYmfmvVVZbMsZ152iWRCLn+aLdup7wxfEumKnGQ3JJgUIgilFVzQ5AaL1+
 96Wksfq1YtlAP68xbCAHBhOqXCSFq7XED1smwWhsYBlxv451G5A+jUeGm0pkj5DvZc9iwxw5YCA
 mQQsPAuH6ZFU+gGjPdWLAY3U1Lt1ljuUTWI7dYXNptcriTf/QRZY0fa10nZhJrH2VAqQEJNtrui
 dQIzpClGFYKyfBUkJOn87ZHA+lg3tuCLWzQ7jhs4F1iAT2ZaFBQTyRtlyCHl5PCXMNhIr7AqRJf
 JJAJTcINNrbNS/zETeFJlHvktPo2XagRHZSe+/EMuxv+/p1G3MZUlyJnWLyiuM67tuNowCCI1rD
 rizq2UqvYpje3TAgu/7Lmk36HuQrTwGRXz4xjt4NR6Wq1RDipMeMqF7OKu0wF+yLOkWOqJHLZAz kPeYhM3+lkfC54w==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Add missing address-cells 0 to GIC interrupt node to silence W=1
warning:

  apm-storm.dtsi:636.4-639.42: Warning (interrupt_map): /soc/pcie@1f2b0000:interrupt-map:
    Missing property '#address-cells' in node /interrupt-controller@78010000, using 0 as fallback

Value '0' is correct because:
1. GIC interrupt controller does not have children,
2. interrupt-map property (in PCI node) consists of five components and
   the fourth component "parent unit address", which size is defined by
   '#address-cells' of the node pointed to by the interrupt-parent
   component, is not used (=0)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/apm/apm-storm.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/apm/apm-storm.dtsi b/arch/arm64/boot/dts/apm/apm-storm.dtsi
index 872093b05ce1..1b9588f7536c 100644
--- a/arch/arm64/boot/dts/apm/apm-storm.dtsi
+++ b/arch/arm64/boot/dts/apm/apm-storm.dtsi
@@ -103,6 +103,7 @@ xgene_L2_3: l2-cache-3 {
 
 	gic: interrupt-controller@78010000 {
 		compatible = "arm,cortex-a15-gic";
+		#address-cells = <0>;
 		#interrupt-cells = <3>;
 		interrupt-controller;
 		reg = <0x0 0x78010000 0x0 0x1000>,	/* GIC Dist */
-- 
2.48.1


