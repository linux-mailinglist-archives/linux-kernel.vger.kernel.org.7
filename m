Return-Path: <linux-kernel+bounces-831413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8728FB9C97E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A415217FC61
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2646B2BF010;
	Wed, 24 Sep 2025 23:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jCuRNqUU"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD3229D289
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758756807; cv=none; b=eRh9frOc2ypxiWDwdaMj30yGujg19eRojD1+8vzMuJagQUGThvEOgImlpsExZ/nCzQPFIq9DwralbIkDMc+Jf2gcxmKvV4RGwqGkbgxrKIhmm75Z1IOq9oiwNeoHWY2RnAXWH6wp6HTFHZv+d1jKsh2FLGi7/Zhv93iojUKpFAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758756807; c=relaxed/simple;
	bh=tlF/XmDSlCSzHpDbYIYkAuUDBatLs6VY5lZmH+8tSdw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=qbQGmt61z9pbAmehvLGjPIhXnzZt3rI6M5i+qifUXTZ7/ElsfeeMDnuliH9EYK2SEkETseU9TP/OJbLeloCxa36jYF951edsw0MFwmWIVuJyPxabnf6STJvCmkSBjZQ6daHm5pRDFhpnoM5Dz4qnkHQmWMJYr04AZSSJWeE9wtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jCuRNqUU; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OD1OeE025119
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:33:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=VNIomdy5vQZBr0Xb1zY4tT
	/Acpu4g0XVUwXNo3bXGx4=; b=jCuRNqUUMjb0jv51pmB8cl8BDgQTKqHaV+MSVh
	voWepDXGh7ziPfsJsEKLw8cf8ckByRtvSAITRASobY7Rp+K8OquQQaO8YVgIAXw7
	SE7KoVv0UD8q0q3nmHnH1PYxAFoZwWw6lFzFzOS4Xrs1JlQFFvQRhioBlSzHbQir
	/5Yk6TnrO5U/Qj+w50tkFgR78EyE1p58UP1oJFC+xMT3Q9MiGVnh6OqNv9AtcVzk
	+zZZRXdFujW3s2tBEVxsQShnhWIaiTLxlJcrwmfLpsBHIxUcnB3ALO/f3+nis5Kh
	fKw2uQP9VQk99PGliSU6wISuLZFrOXulKYmQwDyQ5+T8sn8w==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499kv162gr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:33:24 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-330a4d5c4efso276083a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:33:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758756804; x=1759361604;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VNIomdy5vQZBr0Xb1zY4tT/Acpu4g0XVUwXNo3bXGx4=;
        b=FKrsaTEcrdTYKuxpl63DWRVJqLjz9N34n2GiSX6uvOOhCiQ7t3ZSwUdrGHRqh7sfDY
         kiEhVoaUsNaWSY606KL04h+gV2hiy9+WFngLKCs6OriV7erk1UPane6ph2wSF6ti3MqX
         M+TgNH9juVuYixORsJoVmDEWMoUHcxmo6Cq2wA5zf0UdaF5t7ACBkI7gk/MZQpvwj7Kp
         UsPE2jLCU6vhhiYjbf2VdswGgJ/S4wDtQmdXzshy5iYSFLyrv04WNLFRWXzq0eUKVt/M
         BxiiQqKqWzNzb4UwyylSLn5W2hQA9N2K+BO1qCuVZXogPRR2WfpMHedzFHuVAxgy6Y1a
         ltsg==
X-Forwarded-Encrypted: i=1; AJvYcCVaysYdU71Vozqhz7++DsO0glqB/QuLYN9zGtjzhxnaByY0mnLF2LQm6ygOFcwaLWdBYypwamovvzdkUwo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8XIGRRsxHIWDMV4iTgWbZtu1btmWLPk2yy+WywHSFAd1LTfGe
	twwVxJSHyPtlN3s0N6IAxlG/+mSvOtCQq9biZqIq+xqzD1NlW5D6Wfky2k2BV/bTdpjXfmX3iB6
	ZU/y4sDCovIhilrZjgUqWcYrRO8swx2qkWlnZqjCH3csqlKwaDTMeRRiP5S3nv/iYJBE=
X-Gm-Gg: ASbGncvAMBPwxBO7R1/aiiXcicPpLXBhl+0OYXD/atYtu2HP/yMZeIiE4tHfxhVYk0W
	jiUflrHsEdRQ6cWCLv5cwI4Q5WHhHZobfyOSLF0FwVLArPrkeG2dPBHQqt2O1uGetJBHqU+KzGS
	k51jxt6UdiEDXHOwBW/0G19YBGOWzrMuNP/pssypVpDhxH9VaFvM97F6Z7GFvMy4YZvM5k87Ccw
	5kPrFUPFXMp+iTVfeEt4DwHKAen6blEKViYFyVQFwZnd3vChhM7FJf4LrSfr5K//rY8R3qUnCLs
	sn6XWkp4c4RFlGL2A8qFoAsUsQhWGrlVq8rpPLzwBVic4mhe9mo2qJ+NwbRWZc0eDByYx4Oiau7
	pwaJceeqf4C8oOn0=
X-Received: by 2002:a17:90b:17c3:b0:330:7a11:f111 with SMTP id 98e67ed59e1d1-3342a300367mr1473534a91.35.1758756803651;
        Wed, 24 Sep 2025 16:33:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdtlLUNGJJSlyqnknrbjF3ipSmmLDcYIbOKelFSeVIJvhkvC4jn26Ddrkbxi9be3pwqyR8oQ==
X-Received: by 2002:a17:90b:17c3:b0:330:7a11:f111 with SMTP id 98e67ed59e1d1-3342a300367mr1473516a91.35.1758756803192;
        Wed, 24 Sep 2025 16:33:23 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c53ca107sm392911a12.13.2025.09.24.16.33.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:33:22 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Subject: [PATCH 0/6] Add PCIe support for Kaanapali
Date: Wed, 24 Sep 2025 16:33:16 -0700
Message-Id: <20250924-knp-pcie-v1-0-5fb59e398b83@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALx/1GgC/x3MQQrCMBBG4auUWTuQFgq1VxEXyfSPHaQxzIgIp
 Xc3dfnB4+3kMIXT3O1k+KjrqzT0l45kjeUB1qWZhjCM4dpP/CyVqyhYcphCFklpBLW8GrJ+/6v
 bvTlFByeLRdZzsEV/w+g4fuHf7elzAAAA
To: Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com, Qiang Yu <qiang.yu@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758756801; l=1250;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=tlF/XmDSlCSzHpDbYIYkAuUDBatLs6VY5lZmH+8tSdw=;
 b=GhjB8yFSJhE3XlM7FLgPQU2mx4t683odAMUdhaUPcxG1u0zlAsRUbnig06Uw5wi57WJUJm3AK
 VABUOcz9YyuBnBBGiNns9LLItEdxBIUGRSTsNbmFS1JSSZCmADYc5i3
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-GUID: X5YfvPSUCy8yTlO9rnuhXnsdZ19v3u31
X-Authority-Analysis: v=2.4 cv=RO2zH5i+ c=1 sm=1 tr=0 ts=68d47fc4 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=xicjnEbRADQpFcw3uD4A:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyNSBTYWx0ZWRfX42gPPoEQODyj
 4sr7UCkHXkS/hAVwjWPjaNQiBRkgEOvC0g32s9yxlVILZgZyUGUHuM00dmpDDE41IIVxihXJQqs
 Tu6ZNQn6KAzEsDBrz7nFZhEqf9A1tTyjAOTzKoecWdwI95gbCdg4qKhcP7hqIh5HzT5ft6M4UhL
 f445twCvEjjuyjBAFJVwobbNK0PTg4T+gk03M/Y/PwBVJ2h6/jUf1HRV/W80HNI2Ub5SXB4Gehy
 pcxs+Enaw7e/RS8kJRCajD2pProybF38OlUyLo20VqcUGN0bwD66xVxZX+LGSe4sl9FiXD6JO30
 +rxYH9f2/S3nyVzoM6CXaFrppLjc52ZKHXR9r5eTsISbxA5PtNZmsXJt8gCU1UYj6NIeDdJZJO4
 G8cWSEEV
X-Proofpoint-ORIG-GUID: X5YfvPSUCy8yTlO9rnuhXnsdZ19v3u31
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200025

Describe PCIe controller and PHY. Also add required system resources like
regulators, clocks, interrupts and registers configuration for PCIe.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
Qiang Yu (6):
      dt-bindings: PCI: qcom,pcie-sm8550: Add Kaanapali compatible
      dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Add Kaanapali compatible
      phy: qcom-qmp: qserdes-txrx: Add QMP PCIe PHY v8-specific register offsets
      phy: qcom-qmp: pcs-pcie: Add v8 register offsets
      phy: qcom-qmp: qserdes-com: Add some more v8 register offsets
      phy: qcom: qmp-pcie: add QMP PCIe PHY tables for Kaanapali

 .../devicetree/bindings/pci/qcom,pcie-sm8550.yaml  |   1 +
 .../bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml   |   3 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c           | 194 +++++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v8.h    |  35 ++++
 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v8.h |  11 ++
 .../qualcomm/phy-qcom-qmp-qserdes-txrx-pcie-v8.h   |  71 ++++++++
 6 files changed, 315 insertions(+)
---
base-commit: ae2d20002576d2893ecaff25db3d7ef9190ac0b6
change-id: 20250918-knp-pcie-cf080fccbb5e

Best regards,
-- 
Jingyi Wang <jingyi.wang@oss.qualcomm.com>


