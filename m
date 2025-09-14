Return-Path: <linux-kernel+bounces-815722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B6FB56A58
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 17:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CC4017AC02
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 15:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974822DCF69;
	Sun, 14 Sep 2025 15:57:30 +0000 (UTC)
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC692D9EC7
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 15:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757865450; cv=none; b=jE6HL2apQeC4KbVMZkZyltpo71wxmRtoRseDZeWVJgtoZ1Se2LmPRPpeLfgYzT20CC0LsLgKUezTgFvbLTGxTuw/XnKmdkgO//s9u6GE5nZfSqo3rZdRUQNI+0nocXKCdzVryFYIxWzkE7LyTp4nBLD6XzOBAjQFUVa/1L/SpUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757865450; c=relaxed/simple;
	bh=1V85CMmb+/2qUjFLnDfCZdknLQA+oopxoMSIenFyMe8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pElyxOJLxa7qzAaSENoeJ9OdCyXkM9m3h5UBtbvgjvEbMjx130wXDm1OutZzhvDYV4Qg5LQ0zjb/vRRhbaUjQdOIck4B7a+ex+4PCOIbC+Q5xDDw0db2CVZdYNAWnAke4vInzC2XA30I6Jttcstke1aANnF3mLChEqwpgFrWAgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: zesmtpip2t1757865436t268d2bd4
X-QQ-Originating-IP: 2Q1cFhD5gOQXixb34p8OokNnhzwwe83d0wIr9TsTHJY=
Received: from [192.168.30.36] ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 14 Sep 2025 23:57:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14379417210709123630
EX-QQ-RecipientCnt: 12
From: Xilin Wu <sophon@radxa.com>
Date: Sun, 14 Sep 2025 23:57:06 +0800
Subject: [PATCH DNM v2 3/5] arm64: dts: qcom: qcs6490-radxa-dragon-q6a:
 Enable all available QUP SEs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250914-radxa-dragon-q6a-v2-3-045f7e92b3bb@radxa.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757865427; l=2330;
 i=sophon@radxa.com; s=20240424; h=from:subject:message-id;
 bh=1V85CMmb+/2qUjFLnDfCZdknLQA+oopxoMSIenFyMe8=;
 b=TuFr0pwF+lxMqslNRC/5jwCyurLqwTBpmtsP9Cr0xeR6dCj+txxmdR3drRAjStdz2sTCkJRiw
 iG2Gz8jHapiDZh7r05lbakuRs7cAdbYdWyMPCbu+H6ndn0x0HGCKIMU
X-Developer-Key: i=sophon@radxa.com; a=ed25519;
 pk=vPnxeJnlD/PfEbyQPZzaay5ezxI/lMrke7qXy31lSM8=
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:radxa.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OQDnMK6ucigbOsVUkPafzjTw4D1SAUl+vBEygNYkBqa3J4jX896aWgBJ
	8VMR9P5ddfUToFaya/h35hMVlu0zdVYYvqyADke45wnzZbuo6i1HWmWa2z9fKFRwOsDhy3s
	Fj1Eq/vSIJp0MxSyXa1uHEaStHU7/dgIkGG9zbvVrnYf2e4AUAGQNp+UJJpq6C6T5JNOEmP
	bNU21zsRdXoLenRXG1AEp+iPOLLRKOh1Mmoj7ruyJuuKnGeRU/3DscOs/sO8d12EGiC6j/t
	aTAvzPdWp2p4uuhoXo7JLM1VXu1+hgi7tk/giU0henFYj+7OtFgelsMTkseB89Dkn9UV6rS
	uSWrS15nXxvjoffSrUN7/6Q6uiROg4BpGYA/RSpxOQDIIoplrwoY9D+X/dO9GX/T9yEcDEU
	McUHI7KnGUWvoQLBdgw4D56+eWRk9Ea/nIHf2fo/t9Sk4V/IjVzSPpS7w8EzB1aJDAP1YaK
	mh7ElldcfkTEoFd3qoL8QJA9ZI1xM2RdJvy6gYVlEX5OVvrTvLf7YvsDsffasUI6zDrHbQw
	2tuAn7BxvC2HFevTTsYXXRc51CCO+oEpBPR5CTVvN0UKKypZhMm8c2Yd4CWoCZe7twznEKx
	ZcnXfDGNFG783Q/+WzLq6ynvjZRSQcbYk/rs44LhuP4HjVT1DKTGaNU60wVO0pato2u42dK
	/REt1nfDIvLjmkMadgpQE9Dzf9338QoGd1JrikESqWzCv3IX/wo4tJaXMzUIsUhrfnxTsrV
	uaUE+1zHMsFxY07Jf9PC6nGUdyoPoMGiy49BugZrmrk0S1b8kn8NT9srawflBtkTndaH43f
	FYDxJl3ar5XS/kK6aQAx7irZd2NUtWT0AiczRI4JIfUMzL1KMGUSQuH4iRq570eT3V0QKHb
	I6f7i+wjRJDo5OchZjmoZYW1itNL4r+fk79hdy/q4WYSNnD2D9v6z4L0Qn4c1eeTDGV0hK0
	YeHMHAd0i8nL6bVai6dapwf4DnOark2q/wD1WEoYs/IF7g2J59FSk+VjZB+aw+3wP6KQJ3+
	JUT4N2kI3a52I5CbsPVCwiyurW9pFCVVgs1S6A+4fBhSjk8IBfd4ZlWsK9fK4=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

Add and enable all available QUP SEs on this board, allowing I2C, SPI and
UART functions from the 40-Pin GPIO header to work.

Signed-off-by: Xilin Wu <sophon@radxa.com>

---

This change depends on the following patch series:
https://lore.kernel.org/all/20250911043256.3523057-1-viken.dadhaniya@oss.qualcomm.com/
---
 .../boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts     | 66 ++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts b/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts
index 85465702279efb7ab324baea0663bdbdbd5fb5ac..d30cddfc3eff07237c7e3480a5d42b29091d87d6 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts
@@ -432,6 +432,14 @@ &gcc {
 			   <GCC_WPSS_RSCP_CLK>;
 };
 
+&gpi_dma0 {
+	status = "okay";
+};
+
+&gpi_dma1 {
+	status = "okay";
+};
+
 &gpu {
 	status = "okay";
 };
@@ -440,6 +448,40 @@ &gpu_zap_shader {
 	firmware-name = "qcom/qcs6490/a660_zap.mbn";
 };
 
+/* Pin 13, 15 in GPIO header */
+&i2c0 {
+	qcom,enable-gsi-dma;
+	status = "okay";
+};
+
+/* Pin 27, 28 in GPIO header */
+&i2c2 {
+	qcom,enable-gsi-dma;
+	status = "okay";
+};
+
+/* Pin 3, 5 in GPIO header */
+&i2c6 {
+	qcom,enable-gsi-dma;
+	status = "okay";
+};
+
+&i2c10 {
+	qcom,enable-gsi-dma;
+	status = "okay";
+
+	rtc: rtc@68 {
+		compatible = "st,m41t11";
+		reg = <0x68>;
+	};
+};
+
+/* External touchscreen */
+&i2c13 {
+	qcom,enable-gsi-dma;
+	status = "okay";
+};
+
 &lpass_audiocc {
 	compatible = "qcom,qcm6490-lpassaudiocc";
 	/delete-property/ power-domains;
@@ -624,6 +666,12 @@ spi_flash: flash@0 {
 };
 
 &qupv3_id_0 {
+	firmware-name = "qcom/qcm6490/qupv3fw.elf";
+	status = "okay";
+};
+
+&qupv3_id_1 {
+	firmware-name = "qcom/qcm6490/qupv3fw.elf";
 	status = "okay";
 };
 
@@ -702,6 +750,24 @@ platform {
 	};
 };
 
+/* Pin 11, 29, 31, 32 in GPIO header */
+&spi7 {
+	qcom,enable-gsi-dma;
+	status = "okay";
+};
+
+/* Pin 19, 21, 23, 24, 26 in GPIO header */
+&spi12 {
+	qcom,enable-gsi-dma;
+	status = "okay";
+};
+
+/* Pin 22, 33, 36, 37 in GPIO header */
+&spi14 {
+	qcom,enable-gsi-dma;
+	status = "okay";
+};
+
 &swr0 {
 	status = "okay";
 

-- 
2.51.0


