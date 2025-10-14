Return-Path: <linux-kernel+bounces-851684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E8BBD70DD
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 04:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDDEC403594
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 02:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B8C82FFFA2;
	Tue, 14 Oct 2025 02:16:46 +0000 (UTC)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30AF41760
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 02:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760408205; cv=none; b=uvvqDOIKcrbDNcU/eHTAfywDGnTWxN4vU6Dcdtk3qn9Fh1OGtVA238i7iDFM04j1qIHMHdwLs/Iq2hJiWVUzvFZBtCoLgnWtWLxA/xMY5PboCnjIZdhEUeMLE+8KGOqkAu1RyKIeCc8eo7d7sPl6HKhGdbtg9v1+tdOBWGcYYng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760408205; c=relaxed/simple;
	bh=yLfJAT+PY7nSBDSvahi6KaNmIMgHTqkexrWJJHc6Jq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OC8iMVKl6Vhug/Il7m/w1YhqV2C/0Ad9t1hLdMW/VTu66oRKmkva60cksYsLLaNxWLkAN1z//Dc5E1XPepiG/K6Q3zfPLsIdTsljxm7WktFK/En4jahVzIia0Y6lQJSG84lR2hKmIbe9zrUsfaWum4HArNNuqOIGwJW0BBfL1/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chainsx.cn; spf=pass smtp.mailfrom=chainsx.cn; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chainsx.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chainsx.cn
X-QQ-mid: zesmtpip2t1760408193tcc19e30d
X-QQ-Originating-IP: L97C2AOZ3ljzEh0zDfCvPHB+yq3dBgEQHwUDQ8nWgfY=
Received: from chainsx-ubuntu-server.lan ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 14 Oct 2025 10:16:31 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2101948375338814732
EX-QQ-RecipientCnt: 12
From: Hsun Lai <i@chainsx.cn>
To: Fred Bloggs <f.blogs@napier.co.nz>
Cc: Hsun Lai <i@chainsx.cn>,
	Conor Dooley <conor.dooley@microchip.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH v4 1/2] dt-bindings: arm: rockchip: Add 100ASK DShanPi A1
Date: Tue, 14 Oct 2025 10:16:13 +0800
Message-ID: <0601AB836AE5F348+20251014021623.286121-2-i@chainsx.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251014021623.286121-1-i@chainsx.cn>
References: <20251014021623.286121-1-i@chainsx.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:chainsx.cn:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: MPcG1edasRoVrc0uw6jTurRqPKiQof/xSHsHcR3Me1R6BNRVxlgbNkcg
	/CJvXHyNctmnZOJuhW9ExrGn+Io6Vmu2sr06/2hGAOyAbR/6r9Tlpu0M3ZekNXwuxBr00DI
	zvD7a5nV18GrBduMgQ2pxZEnsLwWsacMXokdJyIcMtIMidSq/voIkJhsfTVichct+/RqA6g
	rFE/HMh7GOBlVcAIwhf66e2IlF4K4Twl502wUoXZNTI9lhs9Lbr80HUXSwUeU8XC9wvLCwu
	AkKxQPaOG3JWRqptNZKOH1mraO/YTsDh2rLpmPwA83qucO8uQzvKKu9XjDQaqSOTQ99I2Mi
	ojmEBjKqJNyO3MXlFXnuwf+0EsN62YOtft0PjfZnrDSe0trbGM4XozFA2XRLk7yjWVYu+gs
	Ban9CeNn/V6jbZ2g7aEWETkTEUk4qEhpepeh42mI5Y1d4tK9RVJM+L5wDgQNt/7PzfbiTrO
	5nK/Q1PXjGSl+zmVnIL7bM9jLDUjfdRg3khGj6Grr0O5oocJUv4bMoPTHiZJANmNDAQ6sYy
	34L7i/z9HGKtIFWCh677cpN3JGVuDQ+nmmpZNEPvWbXEPGZLxl0hFjnO5Izoo+vOh0GV7D2
	AuzKL9dU05JLhCjpwyf+nn7CP0lHc5urbBs6frv25NWQDBeEPrIhe3hYD2nmQkX+RhmXtco
	VXos+Id0OpqNk59/rHHrMhix83CdbRAp8yHSQiShQCi7hEJUXg/R/CbcmlPSh4vPwrCRhYV
	5xr2qSJDK9rL/45QJIeDbrDUFNMxXLVtNFZk7G3kV2iFZ2PD34H+YDXMYLcZXj8q18UiozW
	tXZ6LrW2akGmU0gMs0O1CofuhlsVMwrDAhEgFOltzAkNNWlYKojfWx1o5oQtpTl/usUA0G9
	Mk7+W6ni3rcWHjLxZctBIuG6dmqMX7e6qtfMPY9HvX7aNBjqnVIkWLBeUp4HLuUt5Zbx5lf
	987iHrD0uLoFNe6NUcAYNuSWZJS883UuIW2oj16ad6Mg25aP7SeojJP8kNfXKvXxdH42zXj
	xF2SdJgpthujxJG3AKVvjJH4hnJ8ZBM1MFFWuOcfdPSLpeNOHb
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

This documents 100ASK DShanPi A1 which is a SBC based on RK3576 SoC.

Link: https://wiki.dshanpi.org/en/docs/DshanPi-A1/intro/

Signed-off-by: Hsun Lai <i@chainsx.cn>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---

(no changes since v1)

 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index 28db6bd6a..033730861 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -15,6 +15,11 @@ properties:
   compatible:
     oneOf:
 
+      - description: 100ASK DshanPi A1 board
+        items:
+          - const: 100ask,dshanpi-a1
+          - const: rockchip,rk3576
+
       - description: 96boards RK3399 Ficus (ROCK960 Enterprise Edition)
         items:
           - const: vamrs,ficus
-- 
2.43.0


