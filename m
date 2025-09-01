Return-Path: <linux-kernel+bounces-793688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F2AB3D6D2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 04:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4BF61896D2B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Sep 2025 02:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275EF202C5D;
	Mon,  1 Sep 2025 02:51:18 +0000 (UTC)
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788AE28F5
	for <linux-kernel@vger.kernel.org>; Mon,  1 Sep 2025 02:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756695077; cv=none; b=PJsdJWWVGXN8bpveFehln2g6vbF3VIgTGTK68clwRcgCVYpPrAtP/aVlABptTXt0+ivmZSmh2NTSjHMCApmnlbvIdxpw4ecZnggCZ7jodyobUY64nU0lNGH2pkoNGh3QOoHb72AR+U6TgCyPO7Fllg+muMY2hOEVKJCA5hlyILM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756695077; c=relaxed/simple;
	bh=dKbllMyJvq2cWyxNikxqDTkakDd4FTY5P/jf+amsR9U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=d3G/UHlBC+SHrU8bCFC4/UIRF002Kz9vuvR4LNNYWWayPnvhNte9OmwwZ5Nf3H3rZs9C5Tt27oB+UL8AsZM/NxJJQ4pChsBTj5998CvoNpoHwhchCdD5M2+UxYC1/QOKpHLkDUhjW8fYfu4oiJR0KZDHqZpzFlohB51B4aEyfRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chainsx.cn; spf=pass smtp.mailfrom=chainsx.cn; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chainsx.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chainsx.cn
X-QQ-mid: zesmtpip4t1756695045tc264b712
X-QQ-Originating-IP: ap5qtfwFLDiWsWjGBf9EO9zRS7YU1uzGqHMrPqJn1wo=
Received: from chainsx-ubuntu-server.lan ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 01 Sep 2025 10:50:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5940222375455868438
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
Date: Mon,  1 Sep 2025 10:50:36 +0800
Message-Id: <20250901025037.81548-2-i@chainsx.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250901025037.81548-1-i@chainsx.cn>
References: <20250901025037.81548-1-i@chainsx.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:chainsx.cn:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: MPOEa4kVfRKznh3wDjqYJCYaz3YTHkCvUl+OTlfn/oRAPC6tNlX34ywV
	/qpWB+AFXEDhII8ROEy8b/IMVO6q5AajaWuwIWVIHEwYfGWTODmg5lCaxcW8OGRTX0DEEXl
	1Ei+skdWZFANKB6cAe7CLhxUPb+rNLA6v8RFRnryO8OkFrJFD9QaG8lZZR/lBuj6ITHKFhr
	9/hUHAJOV6i/FlwL2RkyEw6JvPPBqT9yHpOGWlKy9v48qeGK3848szLYhDfKyEDMJ8Lhj3w
	U3MDpbZAyMfw1Rn1J9VaOK75X74K4ien4EEbbJ9LcgGcqr6CqyqB2+/YA9x6XsmyXFRYtgF
	LuD9G7LbM3hIm3jQ6d9ED37HBHg8FmdQOjWiaZZfgLrjM9Vr7HixYPmFUriHHVu20mpq1ba
	F72AXujjp9fUWhm/el4mOsiU2GTbugma40B3hxxbNU1EGQkH/0XM67O0VO2eHSmn3fZDR6l
	vaRw8/R4iuHeHjKeRBYRpblc7Fa5taOdZIIwn5rTy7/YS1qKjg28wkE+3WBxdBEivIPntTj
	+XR3RTVyKaYI7k12QGu/d7m5njaliCK0UhbY0cSGIF8AjZflOVk58/JAZbFlexoKuHOW4xX
	0lhn56FLicqC5Lg10lg+ZFb5RTF0dwanEitF1m+BxZAv5inVi4pHjwloIl59q8ttN6H5PZo
	6LP80xXI9mdaHrGdZPS+Amz5c9xWBn9UjQQ8ys+dPfpodB+F6x/6IWN9ioveAxrpb/jZMWk
	LcPHjS9Yb3cKVtGZw1V9WJTh7bWiEkVWms2BXHKF1ozM1nmRZAo5ZfljUtvZo+51wPKT47v
	G0UlDRUWTBfJEq1iV+KXAYoI50Q6s2LdASNkAaQjNnlu9tb7PM1M5pyqx3dxnoPHVGpBEYK
	/UdZop8Z9rr2s1JixwUK4HjaZJsT3X6+soXypk01hF5RB/Z27X88AppdI/cF6IqfKBfITrn
	mx6pgf3MO2CenGltcGTvoItqCgobjM7KkfpFTXsSjcMMCKSohdYHTXtkA41zKVFO4fD6S8P
	bfUFJb+wBGxh4HWApHlaTNNUZJrrsMqL+okXgq/8b9vubihsroXmFzRM1rmEI8dYL7+CErz
	Q433zUciqxyS50thx1IXVyv8AovF1iJqrycIamvpvrAjchegCoOW8Yvbr2W2Lywow==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
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


