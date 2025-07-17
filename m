Return-Path: <linux-kernel+bounces-735295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA86B08D72
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 14:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE1145A17B8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 12:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D10B2D4B47;
	Thu, 17 Jul 2025 12:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LGbiqt2X"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2BB2D63E3
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 12:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752756516; cv=none; b=HvWRqugfryLyp2XFgscbDDJTyEdf6KL8zVBdWfwf0tIlEjcDGNY3zxyqEpjYkP4zYP5X3Iu+asIOoeCeLMg8TV8yixNYMF8abpf4NUBFdbwVtWbx1tAH3PfEm1clDbShBLjn4yi36FqWUxXd7lrPe51jfJEs4e0FxyxWq4zs/rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752756516; c=relaxed/simple;
	bh=wwP0wgs37G7SIgdBXKyajalMO8uencXdkJwBMyqMQK4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y53w4zmdab9pzxYnmTvETzdTJm35ULvLnYIjJLIErbTJBVka0fLUpTWqY3FzLuHPenTqDKMt8T3inrktgBoB8Q3ODFfjcZimGk+mXSsJa0W2Y/Zp1dAwUs97Y//wou52/clRynLAVoMMocbhrWq2igLL0P8S7ykValtvXo/0uno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LGbiqt2X; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HBPmfv003058
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 12:48:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	751t52RdbCcwhdqGfw2MHgsiZQ8ax24R2DVj0BioALo=; b=LGbiqt2X17LP031m
	pxacikIzoEWgrYhQvwMNhiCNOL59xdHJz5aL1u+U+aKHOGrsfuM2B/805zmzKG9w
	J7szGKPuWi/Np7FiRfqbkiO8jm7bB8R9TCO2vKpGPZaZ9DlSYGSJ0yN8QMcT5K/m
	WWOmbPDp4S09DONkrVAxOCktNlcBwZs+Hm7Bwd7VLT8q7o98tcHb4PwNAvmywWJQ
	QE2sts5wQyk8tcxpRnv4kwsP9m5E/2tNk0gKZb4zpdvRmteqHSdQicpjfyLYmPpO
	3Ei06IQj2d7V1sgDzYx6ZjNMlQDuvBfC+CudPkBveTUC0xUZTtwOBAKvHtzm2+3Y
	OTm1iw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47xsuksfrn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 12:48:34 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-235e3f93687so14741285ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 05:48:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752756512; x=1753361312;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=751t52RdbCcwhdqGfw2MHgsiZQ8ax24R2DVj0BioALo=;
        b=DQ3rCWwJofS7ZfoRnoVms5t04Ey/ssJ72Hd5lVaOOWs18CPSAPu7+WxpSSewjNPKQF
         sFAEAf87unlgNk6ZZF0v8KBmtlRrvhSAMVuk+fX1yaa1qdgSeHH4fzHISYDCj4xtyZCb
         7jLQxy5TVFKXiiTwSfbWvTUcmEfM6/8DID+yflXrT/Rm2XuiPslYUmBhOkDVfwRgZ26P
         piRNLg2wMHn9YsFjin+KclbxZ+DDUM7WkODCnGsY+auojbnzg92lFxTjVjyaRe0Q7AsK
         7eJLL8H1kNla+oVEc/R3MQGBisD1svnsYubM6PbiSYJ0yZfh/MMoxBsu4rJbtw/V6d5W
         YWTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtfja3QdykADkHwuxp0RGyz4/zLHM/rvkKRLNlqteaczqLIwdohfKSNArU+mzmden7aL3FQxHAqG1HX58=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMeXAJ7R7erkBCMwGe8ZhaCFgmT07lO0PJVHzuAatY31Jq2u8z
	eXO7nwlXJ1A49yJpGnBx7ERnuXZ/IXkTfCdtOgJvri9Ze1aJM0/RLxmtD3Ma4kmpyMu+QR6byEC
	mfUEEaZqnvDSM98sxG/C/JnfUK3Hm1eke3LNs2u4W9l2GyqMOnsz8heY1DtLnNrJ0lMc=
X-Gm-Gg: ASbGncuuQfz/Vw6Wp1w+q/DHNtqXWDPYzHE3veeDX2/dHsT9BbdpLWID1BQjQllqoeQ
	6rnKw20zhD5bsFgSpNDD405jlSld03GJrwEVpqhTpk0DpHzOn/z2byIP5rsxvb8/L2k023XfrOV
	7LlnyVLlCH3WTVI0pZJqCIDMzFzfI3s8ir9tk7PImAr8zjHPPXsdTSVP1l+FwIhVLDRsaYROoYl
	sRGIp00QTrwA5cax/uNOwI5SPgQ12/cgr8hdVyBdmEVGgKRu3er1qb+9tSIE8tPQsyAPsO5FRAm
	t2kwrY4KPqShLg8XswRoKzLa1THUz56MyA5SFE2EqgFTnHEeAevSd3/Eue2yHiqXk6qcDouvJLO
	G
X-Received: by 2002:a17:903:230b:b0:23d:ddf0:c93b with SMTP id d9443c01a7336-23e257435e3mr88941275ad.37.1752756512227;
        Thu, 17 Jul 2025 05:48:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE8DUsFwY4tYypfpmfxBilLBUvP2Z+g2tucXJh7Sk3ZEP6OFjznFBKFx5xkkD6zUVMZmlHT7w==
X-Received: by 2002:a17:903:230b:b0:23d:ddf0:c93b with SMTP id d9443c01a7336-23e257435e3mr88940755ad.37.1752756511748;
        Thu, 17 Jul 2025 05:48:31 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31caf828a0esm1505283a91.42.2025.07.17.05.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 05:48:31 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Thu, 17 Jul 2025 18:16:52 +0530
Subject: [PATCH v11 6/8] arm64: dts: qcom: qcs6490-rb3gen2: Add PSCI
 SYSTEM_RESET2 types
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-arm-psci-system_reset2-vendor-reboots-v11-6-df3e2b2183c3@oss.qualcomm.com>
References: <20250717-arm-psci-system_reset2-vendor-reboots-v11-0-df3e2b2183c3@oss.qualcomm.com>
In-Reply-To: <20250717-arm-psci-system_reset2-vendor-reboots-v11-0-df3e2b2183c3@oss.qualcomm.com>
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Andy Yan <andy.yan@rock-chips.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Konrad Dybcio <konradybcio@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Vinod Koul <vkoul@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Andre Draszik <andre.draszik@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        Elliot Berman <quic_eberman@quicinc.com>,
        Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>,
        Srinivas Kandagatla <srini@kernel.org>,
        Elliot Berman <elliot.berman@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752756455; l=1185;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=rmo18nL+UB7XAtgXRRqne0fPUU/Z0j3760cEPwsemB8=;
 b=ppLcpvC8rVl1IEadr9ZLl9ZareIhC7diBss7JmDD0pOFm/RzNVRac0cIFzMaJsT3pSWLwEtkk
 xwfXL7h/RO3DNbgHkoFJAo3qHKOrXDxQ7WVxfN1TuspSeNiFGreIQFp
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-ORIG-GUID: ya0-M1rtbENMSbrgt55GtdASfXWetqJe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDExMSBTYWx0ZWRfX+hDmqwZS/h66
 4b7fs9/3a4UQVNkkBzKFXbaLxs4a/fBg1O4Bko4gIpzlayEeKu5SRE3ZNRjxkxEt5g0xSUZcHJN
 KX2ng4rtYb49/JJWLamOLXPsQZ9zxkDLjGqSdjaVw6dY1RMJPFO76XUjY5ohwYI1YJR5Hkctik1
 1XAgkkwFfQVsMhMuC07Xc3mp4I+pIK1VpohEfC7utt79QZ6izdn7vOVdgCCHDdaDd8EC+xkiujC
 CVg/amJhE6ief1VIGrcj/MR5opwON8lkUssWEx9Srte9l1Aoy0e3rU4MT+1GFElGPYYgxELIW+f
 W5NbGBcyS7IbVOzOek8YQgAUObTsaTDH3Lh9dz7FeSyXAx8KRqD3VK67iUgbG0a1hsenyrbWFFF
 AgYRJc8h5AUmEEhd5URpkkSi2WxwoxYDSijghGqn4X1P9yuSkLR+vBQBK/lgeYrkksZmL+/w
X-Proofpoint-GUID: ya0-M1rtbENMSbrgt55GtdASfXWetqJe
X-Authority-Analysis: v=2.4 cv=JJk7s9Kb c=1 sm=1 tr=0 ts=6878f122 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=w06kbW2hXDg5FjFnD0gA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170111

From: Elliot Berman <elliot.berman@oss.qualcomm.com>

Add support for SYSTEM_RESET2 vendor-specific resets in
qcs6490-rb3gen2 as reboot-modes.  Describe the resets:
"bootloader" will cause device to reboot and stop in the
bootloader's fastboot mode. "edl" will cause device to reboot
into "emergency download mode", which permits loading images via
the Firehose protocol.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Elliot Berman <elliot.berman@oss.qualcomm.com>
Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index 5fbcd48f2e2d839835fa464a8d5682f00557f82e..8cf289a3cfc4ac7014885494c27fb003a7258519 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -966,6 +966,13 @@ &pon_resin {
 	status = "okay";
 };
 
+&psci {
+	reboot-mode {
+		mode-bootloader = <0x10001 0x2>;
+		mode-edl = <0 0x1>;
+	};
+};
+
 &qup_uart7_cts {
 	/*
 	 * Configure a bias-bus-hold on CTS to lower power

-- 
2.34.1


