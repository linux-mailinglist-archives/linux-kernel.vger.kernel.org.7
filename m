Return-Path: <linux-kernel+bounces-782007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F101B319CA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 15:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FA0B1BC1B55
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 13:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213BA3074AC;
	Fri, 22 Aug 2025 13:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RNe3pLWg"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85982FFDE1
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 13:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755869617; cv=none; b=kLgIfay2wG0EvLbJZmE1fu9FqoyD8IQ8xTsocrxfv2Ib7+gduuvaFK4WjUK15hQZXPmQLD2xUy6KcP7lV+BtLpbF3343j+p+CgAalshrxtq+R5KXkjDO9KJuFly3FE8g70QCfyY15WQMY4Vha49Xbp+CVTVNiiq3s3nPv6BF+Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755869617; c=relaxed/simple;
	bh=bYTViSflE79ust8qCI2yDDQ/7mxRvAWLwJ0TYax5i3U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=czHLu6cCx13aHs1Fucwha2LRe53L/xeuJzMNFEwwU+/Wl+mrsOAPR5X6mh2e2n0uPIDCqjkENcSSUUXD3HWnC51PAV5aHrXan25R2qcdI3Cp1APUqFM5V7GGI9Gdu2+l7yr0FmcXE2zMo6OB2Pn/cB8VytuG6udAsLKnddMozUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RNe3pLWg; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-afcb79fb221so27971166b.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 06:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755869614; x=1756474414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dATF9pVYzR6PVe5YTtaWkcMACjJixdOaKzuNOuuEyYU=;
        b=RNe3pLWg/hRxm0wZ9SlDp3BX7XL6DMGlnGijhwhPuDnmFxKpZ7T4Vbr12HxSMJnxS8
         D5UjAjWkENTqpFNYE8e0wOIUyUt6FtXyn7Fd3rGvY+VGZIYm/g59l04RkhMS1L5I+Bf3
         eyTT1qBYXBPZDlxHVK3WQpPlrwRVxrbs0eIx2tXnVi+LnrRsQ7+khc/omLpM1YTe8kKp
         Nn2BLmxoLz0E7m1IB2CV3pG51i2+KwGnggwgTKamcGgYgQJ7CHSSu3kMRTb2H7K3A5PF
         U+OL9TNNaF1GduG2HRSMPuRHej7T7FXLh9Zkc2dvbw5tk9QceqmtYuMT/+5ApzOxIpcm
         +Wdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755869614; x=1756474414;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dATF9pVYzR6PVe5YTtaWkcMACjJixdOaKzuNOuuEyYU=;
        b=hov9ODPZxXDJw8j5Odyl2buHk3Kq/d6BYWA0+32TBP/RDKuViX6u2vyuFIpebPt/kJ
         WsFJYZE6zPc5+bsiMUUcT+2tE5C/sGRfum0f8ryHPTK3V9VLJ9bWTespajd4/a6631ej
         hngkpXYIkaz6MzfkGWOSXT4jq+pmznGl+J8YNHT6NeYJNroNqI947ZYRmPgab6XlmX0J
         mmd+kVeXT1DaWZBXewI0Vc6VxoiCOB+ONbruKdxURlbn6EHHOA5Amjr2/A7eRgyJijqn
         ExxQvdjuMCtKT8D9+BPdSy7DVimLijkLM6AWowz8D2/1W/E+VJFohsdt6z190QkBytmQ
         0U2w==
X-Forwarded-Encrypted: i=1; AJvYcCUEB6jEuzhZEblBE6FlK4+B6nkpVk7MLRp6fl9vBl8ilcrp17AEWFTlXLItj7wOBGovBnJ7837EFGCt5nk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhh15wx1wBPyaqDIZ78T95HuasAGLto/FemrDH4HXTtzXV3WeK
	EfIwYuk77eVsy7LAApF8qJGEm0OEFwGr8GT9k4hzRf11122asbLyDzcVyKerbQQ2gPk=
X-Gm-Gg: ASbGncto32KgEgkSA+9gGsazqdZDDteroQHCm8h8b/JQLN64S9buOwbhxuoTiM9WoJk
	+cTGO15LAmli10I70vJH8aRolMo09/KUQDsFa1FcUDq0dlDWlv23FbkiNxSzdgaRjS2wojUQG+g
	as3Nyj02Y0t0Mc6K9Iz6lnoCRNHpSI55naUQHD+QsRBjivqcgN2ZDXQGr6D+q5o3r9JS/9SbJOe
	0ZqPn9A1KNQsYafjOwZtefTuMsPfpHVJbfRPs8RbIhSNfRaB2okvttOXiqJF+sfbkwUF/W7SQH5
	qi2G2w32QPNY9+Ec0MIMING2t8mspDVNzoIJXKoFD+dDD8Uk33Ui46SlDBv/rWc87+4Bc52kf9f
	5t7D4FdsOAIF9v6+0xWp8WijI0Fdx+relvUrga5dq/14T
X-Google-Smtp-Source: AGHT+IH6qN1ECW4QhALM/CQ2NPhMzvX4p6uWPEhQ/UIi/ACqTxT43/7Yi0lQIdrNUOwBtpfwLUzTRw==
X-Received: by 2002:a17:907:3c84:b0:af9:8748:2bb0 with SMTP id a640c23a62f3a-afe29513efcmr141558866b.10.1755869614096;
        Fri, 22 Aug 2025 06:33:34 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded2bc305sm599477566b.18.2025.08.22.06.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 06:33:33 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] arm64: dts: marvell: armada-37xx: Add default PCI interrup controller address cells
Date: Fri, 22 Aug 2025 15:33:30 +0200
Message-ID: <20250822133329.312326-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1233; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=bYTViSflE79ust8qCI2yDDQ/7mxRvAWLwJ0TYax5i3U=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoqHGpSFTnv6/ZCbMEgpskXgih8YmZE9bFTXExE
 TbqLeUQ6+mJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaKhxqQAKCRDBN2bmhouD
 1/h4EACGmhvfHw298PPgaoyMuUONYIZb7OIY6Hxa+VVRj7HsQUDJxh3f1xDS5l/iph70RiN19sB
 Kk0+LSi5o5I9h7mlvKPVi0IgyW3FdFCZeh3tBR+Y8R46DWEX1Am1nIyWvY6yp/aqE0LtteiR3QB
 YKRhq83zCDQyIIsLFWB3KzIJkyG3U9zv++wDyh2lwVC8WSlxjbaPb78ZHlijIwDUnWuf/g/VgiG
 4UStLpkvFuq8+5uHk+i3krKNIebHhDbZzflBBIsi82BdJWKyqRAJCb9NJ9wL1nrCqgB853oDI0v
 5Pnr2OntXmT/lZIburftXiEw74NHd3JPF6BFubFmOdJAmi7CLXz0EWNcaN9K1pR864A5O8Yz3xd
 dMr8jpAK9yfldJ0mxqoZL/TpJeZo6NNBKK3emOhj9DQJU0k7Q7caixecUcTc16eFgJQ2jYbLCBx
 cUlzKY7ECvVkCPK2vf0+/QNdQRFQO1IsgZVmdt2OnrVlpGHQnS9kvruScv1KqQFeHTayOplag4S
 WSkAwpbLhGYY7WZSbxY5A2kTX0cLJboYQgyHvud0w1nBCl6T69OktFRSE72PSEOOKNyqaza91Db
 O8hypdE6X6G2xxfFtWE63z5gIwBkEwQ5kew7ffBpfx6L0MdxtelNYePEqT5jHAj3GvOQq/FuwKb jvDBV47J8p3fYUQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Add missing address-cells 0 to the PCI interrupt node to silence W=1
warning:

  armada-37xx.dtsi:518.4-521.29: Warning (interrupt_map): /soc/pcie@d0070000:interrupt-map:
    Missing property '#address-cells' in node /soc/pcie@d0070000/interrupt-controller, using 0 as fallback

Value '0' is correct because:
1. GIC interrupt controller does not have children,
2. interrupt-map property (in PCI node) consists of five components and
   the fourth component "parent unit address", which size is defined by
   '#address-cells' of the node pointed to by the interrupt-parent
   component, is not used (=0)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index 75b0fdc3efb2..c612317043ea 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -524,6 +524,7 @@ pcie0: pcie@d0070000 {
 			pcie_intc: interrupt-controller {
 				interrupt-controller;
 				#interrupt-cells = <1>;
+				#address-cells = <0>;
 			};
 		};
 	};
-- 
2.48.1


