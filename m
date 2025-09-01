Return-Path: <linux-kernel+bounces-793680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88943B3D6B9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 04:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BED91895709
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 02:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C471E102D;
	Mon,  1 Sep 2025 02:39:10 +0000 (UTC)
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B768322301
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 02:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756694350; cv=none; b=CDWqNGtd0jEgSpHHXxyrje28RqschAlcYNkmGGGVPla4XX+dmPVZvy9dMmxmT/kE5CpPAXFpM0/t+y/GxHdywLHf9I7N1UNk0YgRgEX1CM0VYcVqhwY3TjQMQDsXvnQHtD+qqaR9hWUSk6jnzMc7xfxKLgTT2GJUwYTxUDzOW7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756694350; c=relaxed/simple;
	bh=dKbllMyJvq2cWyxNikxqDTkakDd4FTY5P/jf+amsR9U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fS4NFcfHyDMNlGQIRHK6IKoH+S8eRpRv4ZCCZxu7uTL8rNv1ECSLSHdf7zApBcHFclol+2nKzSXi4ciYYLGdzq5A9sq+txZzcrj8UnCFiQ7UZCPquwEackGMW3y8+ihg5Mu4pmgcZ/F0BUyhG81mbFS/T0kGM5hV2dk7ealWxUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chainsx.cn; spf=pass smtp.mailfrom=chainsx.cn; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chainsx.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chainsx.cn
X-QQ-mid: zesmtpip2t1756694311t8596cf93
X-QQ-Originating-IP: G25zQTT6Y1mPNENVgNoK5LLwMttRCYTYnFgzC58leWM=
Received: from chainsx-ubuntu-server.lan ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 01 Sep 2025 10:38:29 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6995873977878562389
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
Subject: [PATCH v3 1/2] dt-bindings: arm: rockchip: Add 100ASK DShanPi A1
Date: Mon,  1 Sep 2025 10:38:22 +0800
Message-Id: <20250901023823.75199-2-i@chainsx.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250901023823.75199-1-i@chainsx.cn>
References: <20250901023823.75199-1-i@chainsx.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:chainsx.cn:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: MD5XEDocxEOLc3QUQA6ik7TBRsXGsbRNERt4/rdMgW5qH+2E0EGZfEQQ
	yBRLzsFqwB5BnKFSR5YOX/mi7VnzJJuOiej8QB4XEA7L2lFUzt0dCkR6MmgwPQrDoSxPyHv
	NJab1V5w75nG+DqHEADPBZWzpgiEGmEHLEvZYkVpPcZXhrZ4h87Rgz6LR4zCV/iWt1yUcbY
	RsA0yG/NfXk9HKjGvNuGcZO9V5lOzbJb0/wuVqB477wIwaf6nbJlGvSheVSn8YiiO0lRQqq
	ltBfepwqdU1l11f2l/k4sY1JIzOHHgmp3TXqZ1oOI8CBxh/SWTQXfFKYrIFPeLaZKYRUSqI
	IhtT6ZaBGqWiqab5w/Lis3hjGrh9CaJkTikZkLKTYwqq3VglaUUzB+zGztHIj3LOFxs3iyo
	WkSJqsHjCD/TFw17WSShxru5/AA9GWmUNvPJ1GDbGvnNuSxISBfHUVARiBapOqJOcXSkT/L
	WerOOZZBQHRALU5aQQ8Crc1pc3RDdVsNCA+qbaglT2nWes6ojkAizSe0nF4iervByxsLQRJ
	c4C94WBnH8H29QefLXG6PEKK69tunOtZx37necr3xBc2MIjcNaLI0xOwsgyxZ6lQjjiHDHU
	oXAbSjyAVXkQMrlCNBG75fTX8j68n6noC+1v27jdW3GK9RVsxF8Tqh+vjmZcNtriqZSf24B
	Cq6/zmg9yqetfqShUbusod4E6FhlE25nTjWXAuiVvjF/bK0dIXodSiew6/Ia5TSx8iZbQ28
	deRAts89pbxgIHjOq7pfuJBDFDeT8Yfe4LeRAATpnSUSVeAK1Mr07qQHKW4VdSGTCYtLq0W
	k0amV28P8K6QN9+dGcLW8j3An/hAAZXyw6nqVv+huWw0r/pjiyBpxPUTZbvqZrWHncMh2cx
	3daaIXHVbu2WvKMaDoqJLuGA8RTiUn9F4ZPxL1NDYT0OtK/YL0PVmpQmc3ABRPTmEpQwbxx
	FRfazgNM3NU3QMp6dmLYIDHDTtj5jbOmMS7OCdGeh5bvlWUNoKKiJxSo7p/nCZC7bmnCEiy
	f4gbFrFK64Btya3W7i
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
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
2.34.1


