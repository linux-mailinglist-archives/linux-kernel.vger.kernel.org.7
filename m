Return-Path: <linux-kernel+bounces-785876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3DDB35211
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 05:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADF3917061D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 03:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392872C3768;
	Tue, 26 Aug 2025 03:08:52 +0000 (UTC)
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7005E2C327E
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 03:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756177731; cv=none; b=W/VK+S4q9FRrIALglxJgSGC1leMkG3fGDfxZcpBtWgtsXCPncZehln6PpiNXBWXtyMjxIcct3yL4n0DBgoqfpeHia29sFqW7ouDxBZBAzEjDYi6ooHauixv+0Q0JZZFBC1vXhfA+FvuhAqNJluTyx+m8AegHfXzpTUIDYbK0t7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756177731; c=relaxed/simple;
	bh=dKbllMyJvq2cWyxNikxqDTkakDd4FTY5P/jf+amsR9U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kas0gCpUiATWZQoyI/MANJAvC4cdLStxskp4dMu07C8BbETHzsj5OGpu3jo8mStC7JHIMjgc6laTvnp57DA5J+wDk7SFrFDm7BdGQmQIefGTULDC//nBrqWWAfkrxwFKkRacCpdgdG38ggPLeT+7V30+6CeCfyw60kZCDeQk7xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chainsx.cn; spf=pass smtp.mailfrom=chainsx.cn; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chainsx.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chainsx.cn
X-QQ-mid: zesmtpip4t1756177709t5030dc98
X-QQ-Originating-IP: 8jn44H85scY8QjZCU9Psl5dy1VpOz/vAu3R++oqMy44=
Received: from chainsx-ubuntu-server.lan ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 26 Aug 2025 11:08:26 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 599651795414604186
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
Subject: [PATCH v2 1/2] dt-bindings: arm: rockchip: Add 100ASK DShanPi A1
Date: Tue, 26 Aug 2025 11:08:16 +0800
Message-Id: <20250826030818.3485927-2-i@chainsx.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250826030818.3485927-1-i@chainsx.cn>
References: <20250826030818.3485927-1-i@chainsx.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:chainsx.cn:qybglogicsvrsz:qybglogicsvrsz3a-0
X-QQ-XMAILINFO: MjqaYNLY8QZGrtXBLEHIJuw0E6gDE5DzYbA1wwxbmOWpK0TUcB8n9nr4
	yMdGwk/JS0bZ2yYbK09SSSXX3aD7ou4zQSt8tvUbpYHLgIkQ39JpZgAxQb78rpDA9ro6IFR
	sWdQGw/IZaakFriIZSgUjveYn9tjBznm5GH3EJSnjnJAxcp4QOppKSAkyXPjF5v6QSLhL8R
	AR9ckt+mi8OUNoPRlV+m2ek/EnzMoLSfugJbaqviM9uwh+RtyKtPzZLWmUi0bz05t2oMJj/
	8sA5iZeQckO7CAbJD15vi9mre0gWBe0MCxr5IP+hIC8NkwNER9JkNoZnJvkyQ5EVI2OmYRv
	cCUWbB4ljK+qTm48I/fAVf74ktkxHFiG5+VotUsUKoABCGaIr2JZVw0gIBg2srOAKIbmomb
	W99tmupINb4jaCawnR+ztTT7CWmJKieGpH6K3C0iZC2PpdWjufWV8Kml4XbvakdM2CrFpfS
	YWKOU4GiVD1AD1a8houSqjES/aVFdzKM7RiVKkFNA24jch2IsquBw2jtoVV0MVqQLDw/IBL
	PMbULVIUg4GM2mcLm5QOY1xcAcOD5hKZ1XYjOOjDjU/J+LqBnFeGoHf9HkAn6i6fI+ctnAg
	DUFnyCvg24SQKNXfrfy96R9tkueQSSD8TZDxVohztBzikOk1MUPjhdDGEELnVrcIDK6hstO
	g6McQ8EAamqkIJsnZ/o97YgaF/oktmP8Im+3yJjY26MTnGk8e3iXVTMWnEu5vgLf8cCpg8c
	FALKz623UVC/lxeuKeWcjIge6Mg0RHuJuYt31qZ9H1Gt7WJT9dT2kQZZvZF2LvGCAUl4IuT
	hMthasX/2qmMORz6p7PcGqkpji3VddU0sitWm1EcIbLuDUziEbKXpGFAY8dWB6pPfDRNHtN
	cUHpahMZFifkCmCuv0P7t1fsJeGtmafYCAQUPwCh/QuvTkpL069N7kVDdo8KU0fR34jVGFh
	5zaWUrSiL1JclaAZIFzDAe6a4mC2ZU3A1FrK7uEjC5UbWlU3BMAil8VIcx1U0f4r9cTqDkX
	rB6780Px2EsmuYH5/h
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
2.34.1


