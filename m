Return-Path: <linux-kernel+bounces-745589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92827B11BEF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 12:14:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 002A0AE16A7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 10:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D392ED86B;
	Fri, 25 Jul 2025 10:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E0wVWMqq"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442822ED169
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 10:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753438142; cv=none; b=NNBBLq5B3MWcWJhwFlbSDB+i7kXpiQwUrcmMYHP6FRe1A8f2F8LIm8tXSZRaxtQZ2PhhfCZs1Dus7nDzyDwYDTn+rBzgwzQyXu2GjS0JC0WQ8BMQMH7ay0Pdyl9EIkJP0xeABE2GarBQkYceFfmqCURaoiQQCQKygw81KjpQT7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753438142; c=relaxed/simple;
	bh=QuD88quV2+ZZSG71H8tKu1kO0ROT5crAafRmiD8dmdw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BNtZkQjgqoyI7g6jyIPzqx8bcp5FqSgt7XSKddcsmD4YoewTQReuxVSui0+MD75ctJycwQOyjqn8DafAAYtoY5n856xs56rLgiIW5iaAY/vYBnZ0ioAN2Kz9xq9iGReIUP3KEomu2Xfq9qw9tUTGe63Hn3lplXD+5oMMvL0E3g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E0wVWMqq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56P8Zamw004365
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 10:09:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=xKWmqQzdMPq
	FddVCcAzQVRWG47+T57+MG8ITHFHowHo=; b=E0wVWMqqwSs+37BgbCMx2GYgHY8
	s0mrSrqQwMl0bYaGZ9i0NFqJ9gJgVqs/jMajTvLlLySGl0O678VBmOnLzNDMpzJR
	qeZjqlmO2+1ZFVcVaDg89YoelX96dJ7A9P7MpaWVdI42AHnRlHMMVtgkDmbqnKAr
	FU14+Uxt7JHjMCY8pVSZOq5EyEh2V7ixw/OBkgHnkb5nhPNf8C6sXzAo8W/OcGBH
	ZCdQyv4xvoKG6i5xTvxipRt602EbplRuyyHRkLV3XpV2+9ZqmKyQpjk5q25QRZIO
	i2Z7JPL8CN+iIval3G0F9rdF/WxbID53eECxwxz+7Bn9Ey1hPRJVNPK9dWQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 483w2ksq2e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 10:09:00 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-235196dfc50so21351515ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 03:09:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753438139; x=1754042939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xKWmqQzdMPqFddVCcAzQVRWG47+T57+MG8ITHFHowHo=;
        b=SPKe8OtB7Xe1mDobQLe2MQs8H738w6U2Phqo5OzIUWCskiOxOge9dxkY6aYryRCCTE
         jAllBF2zAha4eDDoTQa0zBYrDryMDtDsLcGV/mbManoZBH3KddrECbuacLYs6LnTiM63
         lMBlbxw3hP0TWPp/LStl7KvoAv+oP56NiERkIvKij7VOyFJYDxRMTcwu9bPchTBK9Kfu
         vVE1pnLOxpm7PIYnkoWAOFS9MGFcEdrXTWxWgvo5SkVCpjUycWOVLbFumu/e+SBk9Bcb
         4FhwCTldqwJmoSbhLwrcp3qF6XLzFEn3EaT8ZBV/gZLtdHRfkxhG4Zce/UQ8SKGLDYEh
         EjRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVD/BtTzU/lOTCeXQP37SP4jlcyzRY6pEVhkGAHOso28CgLlv3z8FkRfY+iHnFYeucrQfKCHpm6iPW5xLY=@vger.kernel.org
X-Gm-Message-State: AOJu0YywJIes0Cv423gGIgQbEGdOEY/QPeL/PasJsMBbU1Ptz9RTkGpG
	nnJ/UeKU14VHZUeWdnC4GXgp7Yt0xWBXUdMrQYdbgOHeDEE3dZh537LLK8hBz0MJ+0wz5hIi85e
	zRoLXu7Kr4wqVkIEDhkkiemTd6Gv5Uo5fOzXd0F6lSTrQqebnlBkRbMffZgInOOf4CDE=
X-Gm-Gg: ASbGncuEjDOWyoVMYbIlznIPFVJmPALo7ihraV5nt9wZ0lzLPKtyMVBRQ4bqxRE25wj
	TmUFWV9HtNN37vOCWqBAwlEgXi6WtqYIqOPsQzzfVhtfGCHXYSlm7591+yWMg2On8RlinvJmDp3
	2NFWttVUq0Na6w8wFDJecsfy6UKxXgjSgGSV10ChRpDFTrBw9beCs7C+3wXLQT3gnMUIOXqi6u2
	sswvm3ZMQQOCwCJfBYlSIrOzTkPuf+rz7cZYM1zTQK9Zh5Auwm/s1vw61dLwPU4AxNEvqNCc5Id
	MsB3ORebyXVSEgNdCrer2C9jFH5NHMl8nOtd0ZlT2SxhkGads43KBZQ/Y8fGabXbQ8O4AlFtjKq
	RjTR+HklJkPXdbxn07qI=
X-Received: by 2002:a17:902:e887:b0:237:f757:9ad8 with SMTP id d9443c01a7336-23fa5cd3ac5mr77420535ad.1.1753438139136;
        Fri, 25 Jul 2025 03:08:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGOWyYvFuXyRYBG4B08FA0aT8mJsXIF3dBXE+GRdj5C2GCVY3bEFepxa0+JYY4aakya4DCUA==
X-Received: by 2002:a17:902:e887:b0:237:f757:9ad8 with SMTP id d9443c01a7336-23fa5cd3ac5mr77420045ad.1.1753438138713;
        Fri, 25 Jul 2025 03:08:58 -0700 (PDT)
Received: from jiegan.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fa48fd29dsm33641435ad.176.2025.07.25.03.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 03:08:58 -0700 (PDT)
From: Jie Gan <jie.gan@oss.qualcomm.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tingwei Zhang <tingwei.zhang@oss.qualcomm.com>,
        Jinlong Mao <jinlong.mao@oss.qualcomm.com>
Cc: coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Jie Gan <quic_jiegan@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH v4 10/10] arm64: dts: qcom: sa8775p: Add interrupts to CTCU device
Date: Fri, 25 Jul 2025 18:08:06 +0800
Message-Id: <20250725100806.1157-11-jie.gan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250725100806.1157-1-jie.gan@oss.qualcomm.com>
References: <20250725100806.1157-1-jie.gan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: cPVPew-os9MqtXN3CsoW0kEKvDUWKVeV
X-Proofpoint-ORIG-GUID: cPVPew-os9MqtXN3CsoW0kEKvDUWKVeV
X-Authority-Analysis: v=2.4 cv=QNtoRhLL c=1 sm=1 tr=0 ts=688357bc cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=gBkj9RZkAcI1HbXH1KoA:9
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDA4NiBTYWx0ZWRfX5vXfT+SRVyAw
 VAVKkl+19VpXWMROfY484covGLNGEY3yk9yHu2YkAFeze/PI4iO9GSAwWyK7Kih8MrSk5+udtJJ
 C72KeuXS6I4dUFPEMoOStT6Kqi7eP3CnVJM41Yq80r8V7b/huMf2dAVbR1NKx27SxDw0Ua6sFvV
 PCRRqLMMiirscFMfsZx3yZp9ZhgcIBw8Its3xaPA0Cvs4fYpOPc9pFeQPvQyD8OlAB3ooP8dACl
 zxQIgPfbCav4RsmgvQM/0NwMpuLGAA+Bj6rTI94pUcQJA1XIXXIWvnC6RMTl/jAYwciYrbZ09CG
 5fh9gMv3IVgr/8AwbbkZKmjSD9Nvr8b8AqgzoHPAt7oDj70ORKpBP6G7q2McW4310Hzvell5/rJ
 vXNPKvpDkv36FbKsVggMIaMAZRFS9juGmIc70PctrqOX+wiRrTXN8rwestFE8jarCjLxU48W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_03,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 mlxlogscore=824 bulkscore=0 mlxscore=0 suspectscore=0
 spamscore=0 malwarescore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507250086

Add interrupts to enable byte-cntr function for TMC ETR devices.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Jie Gan <jie.gan@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index 9997a29901f5..4e6684a6d38e 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -2762,6 +2762,11 @@ ctcu@4001000 {
 			clocks = <&aoss_qmp>;
 			clock-names = "apb";
 
+			interrupts = <GIC_SPI 270 IRQ_TYPE_EDGE_RISING>,
+				     <GIC_SPI 262 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "etr0",
+					  "etr1";
+
 			in-ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
-- 
2.34.1


