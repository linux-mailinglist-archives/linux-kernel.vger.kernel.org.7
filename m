Return-Path: <linux-kernel+bounces-735299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD42B08D7A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 14:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88E863AA250
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 12:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A898C299AA3;
	Thu, 17 Jul 2025 12:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UJ8O4pKx"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A76528982B
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 12:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752756702; cv=none; b=Gfuy7uTzQzKjYDAa4al34IUrk5GI+QYqQnirhmhvH04oYDbJ5qNhLJ8R4KtrXRz9maBStK9SrD34qOoP90NYJqCZrcXBflhKMWoNEqAInmw9+AGxxhhNUlphZXk39usPyjPkDjruAIUHGi2IO74j0xZAPBDDiAEJyXP6TTj4caw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752756702; c=relaxed/simple;
	bh=DdwJLuKrerPAD/bOKsi5kAehWwLx5N9tzB5HjmoKpZw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mPzbMRvvmMI6+moz5f5bgeT0tChSWho8OIrWvduk+dFwVg2Vr0acGFfWJcpbDQSqsyP6n8D+3ARKORTrEQQNgO/G8woUtJa7tviIVMohW8pyERRVg/YIGri/LSf7i4NTUjSTc8dSUjGE5V4MrfZkbwCZNqvp2//ONx69dyhn0qA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UJ8O4pKx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HCEgNo007306
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 12:51:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=0AhCHQgosqZFk1q4UdMdh5
	Rudz9F+/AXpD99Mvdy6rc=; b=UJ8O4pKx+1DV8iaVNwO7frYjxo+C12e15QREg+
	IhhW0binc9aDco5OPD+qrY6dfMTPxrAgRwmondVUqQnJ9U7kNArYE+npseSj/BgE
	fuu836swpOxxFB3LKYFeF1GYzGZM+xHJreQcpHkrrETG5Zsx33Z00V1tir4zhv6o
	NYAUdGaMHKNCq+7aGg/DNQzJXAWW8RLb+qHs4+MBNC8oblWby9BbJXMgGeW9qzOE
	LcV4cRm9fOGtWTvnRof3/ydL3hKGBvVZQP0XNpg0RiqeSoTmwaTBc1/nIIELbrmh
	KmF0L5eDFNlf0iM2srio7TnbU+PWZSlHApETWmNO6cF80MyQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wfca8v76-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 12:51:39 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7e1b7fe85b1so157010885a.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 05:51:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752756699; x=1753361499;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0AhCHQgosqZFk1q4UdMdh5Rudz9F+/AXpD99Mvdy6rc=;
        b=F3rOOpDESpMP7meH4k8vzFPV8kbJuPeUBXwKBOgQ49tPiuErZpSRYfzD68432ZDUGX
         WBEV0m1SASA1bCFlFTlAfXOsSrBVMqk1VXD7Ole+TQGekUZcdDwbVK+GvBKHXTAiMVlR
         2EgSemQI7YP3nMPuNDQfCS2TvKN5ovDucOXOTSecEpXgjHqHCW5+1clU+o+4CfhuFVgc
         B6sVzOdzsOKd4yRDAfpB6yXlBz1Upu+AV3AG61KO+pVI/UtiISmsLAGi+ucWL/Kr/yGs
         vrrm8bfbftwJ4bdIgFkbdcBgmwTWzda6CTt7dCQkYbqLrgor/SFnpE9PI7VU/SSKn4IW
         fkjA==
X-Forwarded-Encrypted: i=1; AJvYcCWaUrkMN6VWRPDqoRiK4//D2Y8YEeeRL2Hn5PkDKJIiXA/62p1p0+njeX6bYb3G8Q6q2J9mDif6c6xU+ds=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9QLRlDHs8xmsmd+ocwxAxznr3CdV4cYT0tdOy1VFncXbnXKdy
	n7QuLEEDUAVN6uQZa9WE6pQTbAGYI/J1LDWpLOmktlRty8tDbjYzlaQHu2/3pED152e/MpL6s6B
	gEsfuAESHMkinirCWqxp7WXQlOi14B5RozD/C08DtS5TLoGx4bEcElx27fO96j32STm0=
X-Gm-Gg: ASbGnctmCqmj9VN7ByiNBqPh5eDxsEupphP6U9X5RRFEWbgijLzJHVBWgCZH+/wr4Uw
	th4xx8aMrkChlSGjQHt8V6fzeKR1FJQm/GUj8ZVfy5eJYiZSeLhknqnBMU8aSHZY2htMlrgq6O4
	OhIPl21qxTtCGwdyTowQTjmdghz0BS+J/AXFgF+hwXNr3ZeQgV0Y8e0YQZxEoib5VXcDXvcwwy9
	LPR5YHTuvfNG9j2UgURrSdjEuundVBOZLf9N/xRoKpsAhd0UNkZ9AnTOz3OuYwxZNOlLVT1FInC
	U/3yXGf+ypmmZOTBMwhRBMS5zh9roPOe4zuyeYs+EFaPLdDFDXRqH8ekdtMizTHAT/Qmjrd0OwC
	zNe7k0sQTCbKcWrtGG07gbHBW52KFMAYi9NjDPnSMHbOF3YTCT4r2
X-Received: by 2002:a05:620a:260d:b0:7db:94e6:4929 with SMTP id af79cd13be357-7e34356c191mr801483885a.20.1752756698621;
        Thu, 17 Jul 2025 05:51:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFL6Hb/qS8x6qNCLIo0L64gSkpP+LI+tUdT8SD4T3yBb6xBXZmoLFGumykrtxt/EuBxxo2t8w==
X-Received: by 2002:a05:620a:260d:b0:7db:94e6:4929 with SMTP id af79cd13be357-7e34356c191mr801479985a.20.1752756698140;
        Thu, 17 Jul 2025 05:51:38 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5593c9d08fesm3032872e87.126.2025.07.17.05.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 05:51:37 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH 0/4] arm64: dts: qcom: sort out RPMhPD domain indices
Date: Thu, 17 Jul 2025 15:48:15 +0300
Message-Id: <20250717-fix-rpmhpd-abi-v1-0-4c82e25e3280@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAA/xeGgC/x2MQQqAMAzAviI9W9BBN/Er4mFznfagjg1EEP9u8
 RhI8kDlIlxhbB4ofEmV81Do2waWzR8ro0RlMJ2hzvUWk9xY8r7liD4IGr9QcEyDpQQa5cJq/MN
 pft8PgAnpjGAAAAA=
X-Change-ID: 20250716-fix-rpmhpd-abi-2ac5b7e5865f
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Ling Xu <quic_lxu5@quicinc.com>, Dmitry Baryshkov <lumag@kernel.org>,
        Tengfei Fan <quic_tengfan@quicinc.com>,
        Jagadeesh Kona <quic_jkona@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1025;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=DdwJLuKrerPAD/bOKsi5kAehWwLx5N9tzB5HjmoKpZw=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoePHYVQfVlJdmnm2HJV6yPhAhSwgnCxmFoBkyb
 D43E4AEtYqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaHjx2AAKCRCLPIo+Aiko
 1R4hB/0Wqddk7X5MyI9SNMfQJ0dGaiJIcwQVLjMbIZsqLGnmpGegJrSher3SJtZrz+IJEiztPOs
 ZmPNcVI92N0i2fLwK9D+5u5Vg88IFfChx1nE8GBOA5XaWMAq9Bcl9/Og/N1xPELXmD9rwZuGPOG
 5/q55A8GmUj/nhmj6M/tZ0uhXteRPDbzxli+PDHLgJ41M029LHpYKbtoxz62NXzzZV87wAPkIpu
 W4xXdB1rlkG1qlIbiKKlth0FiX5JPqu7L6uH9tvDSzQk7vi88uZI1YxD+4rC6SLyzUee41ozgbb
 X72JdhzNB3bPcGW+x03Pmc+LcZ3QTe3SdgmOWiM547FhX96+
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDExMyBTYWx0ZWRfXxgWM+Zh0Edix
 8azMFO0JPREBitoDTFzZcAtB92FFb/S6Dn5kExRxHTXxUsuPRnEbqp8uALH7snhRCsJaQaqahRR
 LavGYRIBAYx3MpEHy5QKPSWtPDRbtLCxyhKbplhU5zLE7TNqmcOvnHMxDvSHXIs+Rv/H6GOZgCS
 PaKxy/1nqzhHvVu09C9LwXAU2kzR0D+pYKzKRpaY7yLAWqEPbjqe1hO6+rWdY5xSjOq0e2RE5Na
 u+KNmrAwLG8gdN55nPoQGLfjHcHuj0IrL4q22hN33n7iubAi8F124TmDQeiB11wTG8bM9fsxboX
 CpuR0A4GYwpM/tTurTOS69Ze5Q2YGRXDK81SRfcJTzme9BGpnpVgbjBbaowy1UAfjSDkwuTP8dX
 VmTrW0ZSt6M7Pa5rRnCUuzMSTeVuxOi7bnf4h7f1RJbXntb07KaMOe7g4ECzmWS5gYm9R7yE
X-Proofpoint-GUID: nDduJOF3iItouxpl03oWkMVUPxNn1w0z
X-Authority-Analysis: v=2.4 cv=SeX3duRu c=1 sm=1 tr=0 ts=6878f1db cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=OKIKnLrJKT9BaQ3qb9sA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: nDduJOF3iItouxpl03oWkMVUPxNn1w0z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_01,2025-07-17_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=512 impostorscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507170113

Several Qualcomm board DTs either use incorrect power domain indices or
use old defines for RPMhPD even though the platform should be using
RPMHPD_foo defines. Correct all those issues.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Dmitry Baryshkov (4):
      arm64: dts: qcom: sa8775p: fix RPMh power domain indices
      arm64: dts: qcom: sm8150: use correct PD for DisplayPort controller
      arm64: dts: qcom: sm8250: stop using SoC-specific genpd indices
      arm64: dts: qcom: sm8550: stop using SoC-specific genpd indices

 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 25 ++++++++++-----------
 arch/arm64/boot/dts/qcom/sm8150.dtsi  |  2 +-
 arch/arm64/boot/dts/qcom/sm8250.dtsi  | 42 +++++++++++++++++------------------
 arch/arm64/boot/dts/qcom/sm8550.dtsi  |  2 +-
 4 files changed, 35 insertions(+), 36 deletions(-)
---
base-commit: 78a8f8d4ec2bf09266a03a0a8cb0af82da0766d5
change-id: 20250716-fix-rpmhpd-abi-2ac5b7e5865f

Best regards,
-- 
With best wishes
Dmitry


