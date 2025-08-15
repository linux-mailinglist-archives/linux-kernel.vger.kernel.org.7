Return-Path: <linux-kernel+bounces-771047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E20FB2822C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 16:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3F74B2036C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 14:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B79624C076;
	Fri, 15 Aug 2025 14:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aa3g5Nsz"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BDC242D7B
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 14:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755268664; cv=none; b=qV4lgHu26jg+sm7c2jlCqJ5sKvVOU74eL6gfvpV3rd+pHCklcIcy0qJwL6V12A8c/Vnr7FtwXzfPSHa+UYblKZWNZlZJem5oQ54hi1qNcgpQY2OcySGk2RAhyXK6DI/Doywfw696+7cJQrEXOHcnyokr+CNV9z7eYZTOGauAajc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755268664; c=relaxed/simple;
	bh=yWDpvk/g5ulq5XtwiLjjXMBryGLsje9g0j50Egsq7B8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pDAMYRTDw7mDrS7h2t51kihlp7kLcDDXO3KDhX7KiNCFX5zXHPESSNpWgHO4HnIrvRZwdFOH+xg1k+FdnoykOGdkxO78x4J2SgeHZpbpg0LVbiSY5aqhH5VhEDoafiY/2o6ebnU8dNCuNo06AmPtiIGl10xa6oiLfULfN3chquw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aa3g5Nsz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57FEIo3b011654
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 14:37:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	s9UkRA4sDNiNVDXOCr5lj213AjA/7qAtrMJayniryuo=; b=aa3g5NszGnvkQYXM
	XP1rBUB0Qqbto9SgBArkapt9Y/U4STlPLdmYuJjspx006Q4jIHO/tmyFA4/Ay0Hu
	YPMNwFCzTyiFm2kepSFeQrzdXVRjpuEqvyuBnowQfeQBilpi0m83TBS1tLJiLqGl
	vcSvydvI2CJ0HgPlEPhY24Y9AmZ2E9qb6h+DagkFy01ClOLRsCcEVriD4o6brSs6
	qHYKhpJMzZUPpiONRKpO5vCXo156o2QT5BKCCkLt7mjOKZ3gT7YhWMMhUZ+bb6Zb
	DcZf6VdfI8JZ6Wu7UvXtyOWPLdWh/Vb5/vBYK+GGPY71RD+uxr6lZ14g2Wc9mum+
	jzRyMw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48gr9ryxhr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 14:37:42 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-76e2e60221fso4135202b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Aug 2025 07:37:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755268662; x=1755873462;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s9UkRA4sDNiNVDXOCr5lj213AjA/7qAtrMJayniryuo=;
        b=lf6hcwdmnTL1GRecLPLLfAV0XyqDa5cUHcCVq4yqxQZcGr8ZdWEzE1+dcDLlRpK0q5
         9SqtaVS2SKAO2IJo3aNKHo5S1w90s0Vqy50ymuiYc62P/2li4IRhqRyEtHqiuCUeYYO9
         MzNi74mFbIr6qtkz492hkACR7lyXNNMvlrNcAPaehcgGwMZoI60g7lsUp5HTV1LqEiuv
         O44P3rr+64QDhaxbejo9d7lUXoJons8cYOqNGkcKuuOSTQnmJdTw6NlOHchfBoyO6a/O
         sWznVDkWBP0ipGKkTqK8Zek3hptKRs96oSe2/94eoRaybnSZQPYlWe/ca7jO3zSl2v3/
         f3wA==
X-Forwarded-Encrypted: i=1; AJvYcCU4KcJhm0Y8qx6asT6wflMjQ70vMWduwqtQW0TVyYc86f69js9JQ5pfZ9UAa/KCGCi8BNYnjDB6WuErJs8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7rDPpnuetErVQE/VR+Z/wPcAVyXLKFpVH98lVmWuWje17Qi8M
	h7+npFK8xYulcAy2rZfVBPqQDd9FEGiGKLmA8escsBkmw+4VyosQSKvOKgzGCtBEyB36gGHnx+a
	wrys0LO+k0ny8FhA/c/viGfoIfB8VxAGO9ojhlqfFRPqTdSrR3TWEh6HLbYGy2YlYs+Y=
X-Gm-Gg: ASbGncvWVYAmZ2b04GxF/M3yDVyNkjWbI9CF2lD3j7FLBRyQ09w4HRZZREtNf8fTpUF
	JIxHGdHEi/TEcyRZsxoIjHIck1P1rL1LF1JuqLEJjEfTM6n70qEcCzShMJl9U4H9FnNrJKSdaA5
	8QyqAGj5ILaSlwKNh7Vdzsgzzf9+s1KsTzOv6IwU4yxOmvdKMx4S01xTE3UnOdA/TnDRyC8PORw
	2LE7Y7bMP8FujoazpCvn5tnUU9o+BAFwj3ClKFlSdHY5utjATTzE3BjiAD9tPGtTzZtclNp+bNt
	/DiiMrGUbsUPlFBdw+LtlytWvp5PqoHuBNEpTnZ8KoLh5gza4dKHpxO0JP+MM4z6kocVEhC2hzV
	u
X-Received: by 2002:a05:6a20:12c8:b0:240:104c:8e14 with SMTP id adf61e73a8af0-240d2f2145emr4641304637.38.1755268661623;
        Fri, 15 Aug 2025 07:37:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGEYKvm7YlLHtN5zoWFya9n6lHhS331aexLq0ePnq21K2fM39A6b4KRmUKen+GVL40Mqu92Hg==
X-Received: by 2002:a05:6a20:12c8:b0:240:104c:8e14 with SMTP id adf61e73a8af0-240d2f2145emr4641265637.38.1755268661201;
        Fri, 15 Aug 2025 07:37:41 -0700 (PDT)
Received: from hu-spratap-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d73619fsm1437576a12.39.2025.08.15.07.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 07:37:40 -0700 (PDT)
From: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Date: Fri, 15 Aug 2025 20:05:14 +0530
Subject: [PATCH v14 09/10] arm64: dts: qcom: qcs6490-rb3gen2: Add PSCI
 SYSTEM_RESET2 types
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250815-arm-psci-system_reset2-vendor-reboots-v14-9-37d29f59ac9a@oss.qualcomm.com>
References: <20250815-arm-psci-system_reset2-vendor-reboots-v14-0-37d29f59ac9a@oss.qualcomm.com>
In-Reply-To: <20250815-arm-psci-system_reset2-vendor-reboots-v14-0-37d29f59ac9a@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755268580; l=1185;
 i=shivendra.pratap@oss.qualcomm.com; s=20250710; h=from:subject:message-id;
 bh=ux79/gmiZ2LdMiEPzsFxhfTKa+YcpSdHQfwMeKSsyq0=;
 b=W31B5yI47L4hb70bhxr6KolbTw/wP2Y7bRpdOBNeoS+yDhcadTJqAp0/QGVYybfT5t8rTSAjW
 ZIxT3KTCjkHA+dUGzT1lsBcJ1JaQEXxYPQFMBN5CETvMfxeM8c5RxeA
X-Developer-Key: i=shivendra.pratap@oss.qualcomm.com; a=ed25519;
 pk=CpsuL7yZ8NReDPhGgq6Xn/SRoa59mAvzWOW0QZoo4gw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDA5NCBTYWx0ZWRfX7LWLY9h5hi6C
 N5kooh7r5nDWBCdH3fUB/O9YUO1PVEWiScXsogUFI54JNj8aqgz6EMoF7RdgN9Qhjo01wVrLhK2
 haSqLmhNO3ivFT4UH5umrbgS6QzWz2ya/RwT2vhR7uPOFFi+OysoNM0ROcIINwK5uUBQvQ7YEQY
 ln3K3j/iWo4zoTlyl8Bc7/ukC7w+hIvTJeyU0U4ifFuWmJMoSZFmYw9pP31KazV2sTFmdn/Bj2o
 xDVS+2ZKNLsswNaDYAQQ5X7eR5yBG4Yk2hgY3SkiUiez4DQWa4VzpwA8q5Pw5bbFI9ZNu8NPRsy
 lKnr1dsWVKPIKrJvYRmP3KQb0CyF8v41mGVIfwPA/I3Hq+ShY0/YW+YdaGkp+i5lJq5DcfMBSSx
 Dmm0RmkX
X-Authority-Analysis: v=2.4 cv=NIrV+16g c=1 sm=1 tr=0 ts=689f4636 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=0YKNsV3nudetVglqpTMA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: Omespu8c3r2NHYtBCMjQu2ykn5IJEjcK
X-Proofpoint-GUID: Omespu8c3r2NHYtBCMjQu2ykn5IJEjcK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-15_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 suspectscore=0
 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508130094

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
index 7509c27bd3f8f3e43877ded3b898205bdb66a847..621628311a3e36cea70697872b63282d1ba83e1d 100644
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


