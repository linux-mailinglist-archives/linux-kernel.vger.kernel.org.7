Return-Path: <linux-kernel+bounces-815724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DB8B56A5A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 17:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A21E117D430
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 15:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6372DE70E;
	Sun, 14 Sep 2025 15:57:32 +0000 (UTC)
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBB32DCBF3
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 15:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757865452; cv=none; b=EJmOwlxnu0AC06jL2CDzY+0qvCiGPECqapF00DNf6HSVkXBsjt0RSCOfwyzIuvnVht+DLz220ccIH1MAH/g9D/GLivXdwOz3lB9YkpeBYfXRDoMABBNRZwITzFojp407dI3mJ+FLpphazJ4LmxMPxO5Vm5N3yW+I/NydHNKD9TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757865452; c=relaxed/simple;
	bh=EiMdQ56FSpoh+jezouVccupggQusRUgVW7KiFFuQ6YU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sdZo9JWHjhVQRjy1aYUnWu3IighHfXk4ZLawiqRvFlNPPjtNlOSgfEq2NajfUBvFsl3MrgLmVx0cAwLo1glv4TyUSxbkT8060xcmv70BzfT3Orj7UXrAlA9BI8+yXZiyaEIpepyohq3pR3isa+cNgPnt1iCzr0oOznbIUtsFKuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip2t1757865439t8f0c438a
X-QQ-Originating-IP: pLxyR+EOCK0wlpAMNCC3ZcyEEqs9dXvj/pHWXxrhJUc=
Received: from [192.168.30.36] ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 14 Sep 2025 23:57:17 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11041455606322930672
EX-QQ-RecipientCnt: 12
From: Xilin Wu <sophon@radxa.com>
Date: Sun, 14 Sep 2025 23:57:07 +0800
Subject: [PATCH DNM v2 4/5] arm64: dts: qcom: qcs6490-radxa-dragon-q6a:
 Enable UFS controller
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250914-radxa-dragon-q6a-v2-4-045f7e92b3bb@radxa.com>
References: <20250914-radxa-dragon-q6a-v2-0-045f7e92b3bb@radxa.com>
In-Reply-To: <20250914-radxa-dragon-q6a-v2-0-045f7e92b3bb@radxa.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
 Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>, 
 Ram Kumar Dwivedi <quic_rdwivedi@quicinc.com>, Xilin Wu <sophon@radxa.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757865427; l=1799;
 i=sophon@radxa.com; s=20240424; h=from:subject:message-id;
 bh=EiMdQ56FSpoh+jezouVccupggQusRUgVW7KiFFuQ6YU=;
 b=fbUhLxQn5wBUDSAGSmNf3hIJN57m7niTXJBgwUIp19I/qzEeC1040BKNYAc6cYTIy9XbJEWtt
 IUo4oXqyqTzCSO1Ihz6qO5xqj7TLS0gKofkY6PpXdNb1yN8xoZvrywO
X-Developer-Key: i=sophon@radxa.com; a=ed25519;
 pk=vPnxeJnlD/PfEbyQPZzaay5ezxI/lMrke7qXy31lSM8=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: M0nQrSdIAURgSrWQF2qUyWVvF7Iru/VOSFh9WTSkZcG8Px1gCsNI1qlD
	lIvT8zLp2NlRqAJS05BJ6wQ7yuryBwsiEKBtpxC4yGCC5xc2REAfpDClds+JPZK1LdlqVpw
	z8UNlKkbc33jsWobvF/9LZcq+MDG9hGJ71R6C49GWt441FWZnuX7lavtYrlTWn0prKewaMq
	XD7sCGulC2CQ9dKkhwbpbiWWQvfq77Zo3IagKsB6irUUboHwZR4hTmbqOm0WkyoXbacjp8V
	Vqm+6nZmyVgPiZIluEvt9pLl2aWkIEc5b94PCrwrBen1Qi7ve5OwUO77hnHTeWCU+f//nkr
	vif8EMfnblsXUTdUdRjSbgDTtofWFsXBM7sJSsL1913j1L/opLqj+BZ3ajm/e1nS/t+f+jh
	foFtJZszqtjqYZcUUgzC4djtZ3PpedQnMZjjYkznVFx5pEKgF2l7dWY8o2yiXvdUOFGA0jt
	Sz6FpZCAT+PXhZyfYu4DSV6rCQ2BxBAv2xngwQ5ANwFw33Tyj53nAk0i6KzPPPFwWkjt3tt
	WDT97jbKL51FNND5IpX/VhLaoZkr7CNHVl8ji5BCIuEU1NidD3f9mxH0E/XQ1F/h24f7zf2
	s1JRsijOYIRfAEUJWLfcDL771b2Lipl8xMR7d5AA7Mm/B3hn/liZd9aGQQLwMNAcDPCrblo
	wqIi8H/QEkfP2UoFbwOuwZKklsyeQXZGx1ZA3MROhdUOQx+EHaat0kUviAkYbddbTKYxSwW
	aRg3VYP3Ip1FxAedj/uAzC9nATpna9lV6zRmS3HFJQ98eYLTeljG7bJo0w4azolW80AeQwu
	V4uMJK1ScSTi/MQQhnj9o6ZQ7PbQL+9z/FwH+EX4m84wkbef1xLTbL9La5hTZ8m1qQXl1Gw
	E7afPoDaET1CxBEjGh0Hzp6Ftazk8ilVWkU0kaf46DiYlga/um6fp+F0nOVkSkYNzT8YxLx
	ksVmyjKB3Ex330215lg3heOcypYVVW1SjmxVOcYzZSg3kB0LZSipy/mIM7tB+eDvbCCR11J
	m+v1AlUcG6wCKbAhHIsZNQvvaYBfP0dN+Fct1G/FV+7okCD0CDg4/vQNv1AdMwfcrDlH9jz
	Q==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

Add and enable UFS related nodes for this board.

Note that UFS Gear-4 Rate-B is unstable due to board and UFS module design
limitations. UFS on this board is stable when working at Gear-4 Rate-A.

Signed-off-by: Xilin Wu <sophon@radxa.com>

---

This change depends on the following patch series:
https://lore.kernel.org/all/20250902164900.21685-1-quic_rdwivedi@quicinc.com/
---
 .../boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts     | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts b/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts
index d30cddfc3eff07237c7e3480a5d42b29091d87d6..3bf85d68c97891db1f1f0b84fb5649803948e06f 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts
@@ -482,6 +482,11 @@ &i2c13 {
 	status = "okay";
 };
 
+/* It takes a long time in ufshcd_init_crypto when enabled */
+&ice {
+	status = "disabled";
+};
+
 &lpass_audiocc {
 	compatible = "qcom,qcm6490-lpassaudiocc";
 	/delete-property/ power-domains;
@@ -938,6 +943,30 @@ &uart5 {
 	status = "okay";
 };
 
+&ufs_mem_hc {
+	reset-gpios = <&tlmm 175 GPIO_ACTIVE_LOW>;
+	vcc-supply = <&vreg_l7b_2p96>;
+	vcc-max-microamp = <800000>;
+	vccq-supply = <&vreg_l9b_1p2>;
+	vccq-max-microamp = <900000>;
+	vccq2-supply = <&vreg_l9b_1p2>;
+	vccq2-max-microamp = <1300000>;
+
+	/* Gear-4 Rate-B is unstable due to board */
+	/* and UFS module design limitations */
+	limit-rate = "rate-a";
+	/delete-property/ qcom,ice;
+
+	status = "okay";
+};
+
+&ufs_mem_phy {
+	vdda-phy-supply = <&vreg_l10c_0p88>;
+	vdda-pll-supply = <&vreg_l6b_1p2>;
+
+	status = "okay";
+};
+
 &usb_2 {
 	dr_mode = "host";
 

-- 
2.51.0


