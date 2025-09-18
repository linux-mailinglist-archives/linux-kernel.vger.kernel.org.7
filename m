Return-Path: <linux-kernel+bounces-798407-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30692B41D7A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9895683F22
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE0E2FF646;
	Wed,  3 Sep 2025 11:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="JC/pRYKb"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BD52FC873
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 11:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756900091; cv=none; b=tod+zcYZBE6du++9l8mH9mcc9fg0sciBIG1y2wqUF3awPnwWcUwTnX9vQXJv5I0EWmQ/1ShKJVZ3bs4PsYVi36dsUeREznKlLOtXZb/Ab27ZfrnqNNtHF/74duI3xo+bRxHUghz503DD36rqmNq6wLRcqQ/vIX45rlr5QudxDz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756900091; c=relaxed/simple;
	bh=iL/XzmseyPpV8hK/O4kgQg+47B+ikK5yJ0SDgvgg8R4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E7RJGtq018qt/otA6HMjLU1+dg3Ry/urXFqmMRJINGN3Qco0WSrsC3hzB7cV8sUGswnJc65pvtxoyRbAXi+ox8jeAJOnWCqhSbqXHE0hB0W/ZUgdwOSIs+s2pqtLFFqp0+0PrhT6EIpUvZSDeOQS9duLGa707GcVPTMspx5DWso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=JC/pRYKb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583BF5Xx004720
	for <linux-kernel@vger.kernel.org>; Wed, 3 Sep 2025 11:48:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ptzMoe5mzU7pe9gfLF0XACcwJawnpCLYmxbK3KE0HEw=; b=JC/pRYKbK3k92BXV
	5ieyjJGR9qqYiy+gkh88U9g4nNfZu7a3VAN3jfwXRwRECPXGNv7ZBqbXM/rXtxni
	XJHx06jOf79N1jS6Bd3FeJzQQ6hv0wCgx0VkCFisoZUgtpM3Y1uP1rkJRLKrwqmv
	mS+k/a5MQp1pdznDFX0B6Nn7zoBWSSFyv5oOjDYEdJ9a9acvCu1DaI1iSVYRx1CH
	hjHlh0P382tqnb+7a+kSnrwq/87v5r5XWZBabzacV4sWe6BNrKU7Fek7l8KAq9Rs
	yhoLvW0VErBp3KYDBF0SBypIMvpTZTPn3nwzkUjBsDxZFNTWFoKLF4+JV+uqVv2k
	EJLm0w==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48upnpbnts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 11:48:08 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7725b4273acso5184919b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 04:48:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756900087; x=1757504887;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ptzMoe5mzU7pe9gfLF0XACcwJawnpCLYmxbK3KE0HEw=;
        b=CyXJL9QM14ZzpYg+i9qaNdAQ0J9VOBvZytpOyPHJPcXn688YeQvntF82EB/vM4e6tP
         aCmuWdF23eaIev+FxGjwqMcxST06UULdZvfj8q0nw8aE5xLLCw354OoYOa+CxniAxSBG
         vVcGdUap7QjlOuxg76m75PXYk20BJnNuUWWrexIRQKHGAaeRLIKDfeJQE/qB/ZG03WYD
         o2OjGN9Pp7O/P7FQb+R3/pJA9rXqjHzwMy22Q4O+Mtw3YfEwE6omrJXqB5RBEZ9UnAs6
         b7pldpkagu6khmPZ1uDUKYU104o7m68tJaM+5OHo4vh3utsbQ8jSZAjiHAYJfjd17tt7
         TVSg==
X-Forwarded-Encrypted: i=1; AJvYcCUJM95xdqsZozYqtyhS9LDiVe/oLNhcGxnf/Cl+hCMLQOoxbTj9UZKaLvTgBC/JIXsjTWtgVWaAzQ+nHB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMoIOugr9cLqLy/ppeRkP6dXWn6tikFO+yqFYpOh93v2irUZKf
	SZXavDy8UUt96h1xQMpqFTUnfJRcXvenGi8FGL3Di9DdlBULkKJdkzKK4ZB9aMaDoxzcvmf5rux
	qBGVrDIPQ+S48j1DWmoJmyUu7RWhJrQeUYjKdk3gTypyBE1ijL9GtJ1li783GfBo+6p4=
X-Gm-Gg: ASbGnctIACfKLjlu5hLkB3X1jZyPnE3pIapJxjWLl7/rF3eD7v1si7RnxZhDS89helZ
	IlP7V4lG1X2aA+3U5z3L9CD/x6fZ9w89onUYNgu+xJjsOpaDCD/1pWTRSwfyRGoBFfdBUwWkNc0
	+ZwSYirkvoinET/hTO2XwND6t5z/WiJPNCXKb7RRWpX2LBA9elvV57gn0metSwlnH4BNeVps1le
	+gvnw8mRu27JB7x9yQ87vKOYNZ1J4hC045Htapdrd6gKCUv+Q0eoPS/PGzwiiOAvUHNunKG8CLM
	7Ywrrj2o8SrcyPt7L+UXEbXbOJDA1BpDQve77zMfAjAMaoY9DnHY/UCzTglq8wcW8S/e
X-Received: by 2002:a05:6a20:2e1e:b0:245:fb85:ef69 with SMTP id adf61e73a8af0-245fb85f22fmr6898052637.40.1756900087300;
        Wed, 03 Sep 2025 04:48:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESmO9fuCQGZL0dDqdivH4Yd3OgnaOimF5E4/NDsZ5Ka2qIuzRAwLWEesSF7738knmXbVKR1Q==
X-Received: by 2002:a05:6a20:2e1e:b0:245:fb85:ef69 with SMTP id adf61e73a8af0-245fb85f22fmr6898025637.40.1756900086874;
        Wed, 03 Sep 2025 04:48:06 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4f8a0a2851sm6584074a12.37.2025.09.03.04.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 04:48:06 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Wed, 03 Sep 2025 17:17:08 +0530
Subject: [PATCH v2 07/13] arm64: dts: qcom: lemans-evk: Enable remoteproc
 subsystems
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-lemans-evk-bu-v2-7-bfa381bf8ba2@oss.qualcomm.com>
References: <20250903-lemans-evk-bu-v2-0-bfa381bf8ba2@oss.qualcomm.com>
In-Reply-To: <20250903-lemans-evk-bu-v2-0-bfa381bf8ba2@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756900050; l=1181;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=iL/XzmseyPpV8hK/O4kgQg+47B+ikK5yJ0SDgvgg8R4=;
 b=ehU7262fiOcOFmjWpHiqhp3CyfXbLbOyDWLLhlZwJMNZYrcsDHNXGKfhHqTPFDGcrJDmqUoZ6
 mp35mSc0QhTArkAIimiorimSB98rb2w81w6HnSuE0LJQC0RT8YEwLK3
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-GUID: NXBsZ527SgSq26fUrDFU7uSoJ-hdho45
X-Authority-Analysis: v=2.4 cv=Jt/xrN4C c=1 sm=1 tr=0 ts=68b82af8 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=08pr6S3s0jzPFaFj3AwA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: NXBsZ527SgSq26fUrDFU7uSoJ-hdho45
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAwMSBTYWx0ZWRfX0nXFLrConfN4
 2kEXZjkz1RfLUY1CCVYSJ5S0o9MMQGIBDsGWilo+3FrYXDl0FDgTP+gGx7J+NNiCRXzMBDO0OsY
 peGbxrvPHWNqOQ/Dvy3vPvv/J+2X9+01QEOdPm7eVDBBvP6/aUKwLpsYiHaCIXMr9hTTTUNLwvV
 Y3v38gv62dff8zAarLO0QnMT/4F+X5NRqLuDhrB6I1r+017oOnpaNHnwkMm7A6PJ/Gj0zkXB7U+
 bXrMyQuve2udqo/nQhZ9M3+dPoyRqdSVVwdErX+ZkzFvzphcRxRGqrBwAt98p6bg3vJGqAVhRrF
 9sxhiR+ybM/XTgfI91ZBj3DHmG/LFGqsoDr2Iq2iTNOgTzxC9JLReO57AN/EmYko4zuK8hcFAdO
 UNKdU3bY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300001

Enable remoteproc subsystems for supported DSPs such as Audio DSP,
Compute DSP-0/1 and Generic DSP-0/1, along with their corresponding
firmware.

Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index 7528fa1c661a..eb7682fa4057 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -425,6 +425,36 @@ &qupv3_id_2 {
 	status = "okay";
 };
 
+&remoteproc_adsp {
+	firmware-name = "qcom/sa8775p/adsp.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_cdsp0 {
+	firmware-name = "qcom/sa8775p/cdsp0.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_cdsp1 {
+	firmware-name = "qcom/sa8775p/cdsp1.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_gpdsp0 {
+	firmware-name = "qcom/sa8775p/gpdsp0.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_gpdsp1 {
+	firmware-name = "qcom/sa8775p/gpdsp1.mbn";
+
+	status = "okay";
+};
+
 &sleep_clk {
 	clock-frequency = <32768>;
 };

-- 
2.51.0


