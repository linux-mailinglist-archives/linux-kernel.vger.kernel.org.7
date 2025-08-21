Return-Path: <linux-kernel+bounces-779595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6848FB2F614
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 13:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CC69AC1B8F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 11:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633E230C362;
	Thu, 21 Aug 2025 11:11:47 +0000 (UTC)
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194CF1DF271;
	Thu, 21 Aug 2025 11:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755774707; cv=none; b=iBdY15bbHi0cKyC9U1IenYD9eYZwxq0rYAykXGgIv3lMQWjPOoP6G+MUwKZwYKWRxEbdXDm3xtvoNza1aGobyWlSGGswYfBfymPEpDV6UwBiJHd7bWCYo6XG+Kqszghnx+Y2N52G5ni/P5JQf1q8IY/KzZXvPyp0hSuMxbBBVTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755774707; c=relaxed/simple;
	bh=adO14fuYJ5yqehwrSznPIOFEMUFv94+LQYJ6lal0CB0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gUcf9MnJNHl7mg+oV8hFsRAircKt1HoCRUdP1UPaf8pVuO05fEl512dxTEB7aWO1L3o1ulMVPibsKKXnAsaICDbDGk05dfXIMUp9Q39NrAYEDRJDfjU6w2ucU1I1ug0vC563+cdXRtZTjjaBIYCP2L/8gbA00w1unszhPE6uqIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chainsx.cn; spf=none smtp.mailfrom=chainsx.cn; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chainsx.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=chainsx.cn
X-QQ-mid: zesmtpip2t1755774593t81369842
X-QQ-Originating-IP: Ag73yM+7wvdFdbNm9yHrmkwzqg+tb/7BJP3xAKS4ils=
Received: from chainsx-ubuntu-server.lan ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 21 Aug 2025 19:09:51 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14449137100758401658
EX-QQ-RecipientCnt: 16
From: Hsun Lai <i@chainsx.cn>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: i@chainsx.cn,
	heiko@sntech.de,
	andrew@lunn.ch,
	inindev@gmail.com,
	quentin.schulz@cherry.de,
	jonas@kwiboo.se,
	sfr@canb.auug.org.au,
	nicolas.frattaroli@collabora.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	krzysztof.kozlowski@linaro.org,
	linux-rockchip@lists.infradead.org
Subject: [PATCH v1 1/2] dt-bindings: arm: rockchip: Add 100ASK DShanPi A1
Date: Thu, 21 Aug 2025 19:09:41 +0800
Message-Id: <20250821110942.172150-2-i@chainsx.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250821110942.172150-1-i@chainsx.cn>
References: <20250821110942.172150-1-i@chainsx.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:chainsx.cn:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: MAelC2bHk4BLleqiFxdwbElLhtVCFq+8q6HzPL2LSfVow4E4fJZE25rr
	aqXkpqwlOsm/7p4WHg6dZTVsRXUGyIXTOPQN9TeE97ypeT++tvXu5EzzbLSHaJwr53ulS3v
	ev21guAEavBM4xPDT6vHQ6Ohs3wnRqZ1W3alFqEqV3kWtGomzmEdSSer8uIYnEHJqIT2/Cg
	RLpRTPZLVytujgo5xe8YSSlmkHVzJH46kWuj4rjLSsrIhZ57l8BLBL98awnyZiJAqD8OguO
	O0AD/jdyU/yUQx044c3OlgJxTM3CfLNC/SvXe7FVcw69qUj4SnQK1uExPWiaFVTvjLeYhaI
	cDKBI/hiL5LFrp/k/qH0W5HNhXGnadd4VPR3BKBtk93T4GDR22b5lycQfEfi+7H+6l+gu6E
	siFtu9+X38XfTjAFfjy0rKygpHEZtMMzjmZ6HE6FaMoS9FHdB7Tf6P+RRVLUr9Y3jWorkJ8
	mcmmyuGXfGAVCgG0cFLidwflhnwgQyEHjwhHJ5wtDTdMRvMYFoiiEhBAZHEWqVhT6BPbWhP
	/5SLSCbg3/E6J6PalEl6qt6qQfIQPiPReYjHabufZB+NF4x2OLwxFTrB7ysX5URCwaQKQIa
	mZlD4H1q7vOaB3NGljCVaEEawmffcgXHn+LX+O5k75jhVVGUr7ibcIxNVbFnZyhy7GOoM7X
	wi3l3aZcCcvWqTKChBcbsRlDESzpRexB6LrbTpyW+cCVaCotEWBPb/GA9RSVem3YislCF8R
	5MNGdGDwRIZOUeYpESYI9wcaYHMCI2Mv1oRni930UUP/xAoHHpBUpxsUV/+2vt0gNEw5x50
	1mPkBKnLIdOGOyMN47VKhKrvkeeNeDeogRGYRl8Zi2t8TvPlC+edmhUu7Ljbaz7EqQfZAOJ
	64V5qSPsBvSzWs8LJzy4FeiwI/+z2D9xdcz8Ff86aTbEZcvqlt7Fgg/9Vn6l10dmR36AT/m
	1S7erGwVjau1MHvmErv+PsDJVP6iNvn3CEMThj+GIJQ67jvwrrD67So9mXJRFo9CeKlcsI9
	6p6VQQLT+YXBI7Zh3alIaX95WkTNI=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

This documents 100ASK DShanPi A1 which is a SBC based on RK3576 SoC.

Link: https://wiki.dshanpi.org/en/docs/DshanPi-A1/intro/

Signed-off-by: Hsun Lai <i@chainsx.cn>
---

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


