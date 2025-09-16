Return-Path: <linux-kernel+bounces-818817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74349B596BF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 14:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AE9A3A7C5A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 12:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54C16223DFB;
	Tue, 16 Sep 2025 12:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ddYDXekm"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CC621CC6A
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 12:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758027568; cv=none; b=g4SFX62Bka2BlBt517UYRtUqWobH24Hgjg9Lng4f+1AC4I1auhRm9lcg/ScwU06mWU3komGzhQXC23IU/cm7DPDIMuuu1sfjpfZf5h134wtmcIqd+6m+dBzLh88Bh0TlpZpp3SYuO89R0qSJ2bTdYpCAwZnpPfRSk5YR6sC2WxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758027568; c=relaxed/simple;
	bh=P0qwYvA0hb3DcRu8UXrOaavNtZ/NhaQ2xXab7mtLRyc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DXMgciALXYM7rlBjrIrr6jaMGa+NjN8hGs9J++LsOhXlCm9vASBxnNj+VVBIVA6z6ywmPSlkF/szBYMrhuM6qnxzA2eTBP7RZ9Fwomz4v8TeCdWpqnyECMXMRiWp+MbvovCzBngqdVyyTQ08p+k8K+EecYsN0k5FXGb71q0jssY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ddYDXekm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58G9dsXn005334
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 12:59:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=DDS7iQ2sUp2SmkYHHdOoYA
	K+CHQVWqs2GBO+RrVwbH8=; b=ddYDXekmwC8EO2CA3hhIo7Vzt6ni0/AXWoUms3
	y8mGTTelw8jGKE5wCo3NxL7ZRVHO1xOWCVfwrxz78LeTspwmA9d01QTsyWowDKI7
	vk1zhVklMIn9FcqcD27eJIomMcrkenJ9G9/yp8YbfIvr8lCy/aVtkS2CBqx1mCv1
	tORdW7Up1TDx0y0AfFHuJveyDnhW8OttlyZuiL4PydgdL3rA/RRAiFHCAW2GNc0m
	S2axasTtPOfyK52Xjo0TB5TMAiplb74BBV46EydYcxIvM8PUKRdGR3HWKQxSns5T
	wCbN2ZPQmVDzI9ccM5gq4f3S5v/NKqSZlZXjw4EEytZ33/tw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 496g5n4jht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 12:59:26 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7725a76dcb4so3830703b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 05:59:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758027565; x=1758632365;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DDS7iQ2sUp2SmkYHHdOoYAK+CHQVWqs2GBO+RrVwbH8=;
        b=hrITt8TYYbnsw+cAlS5g8eR6/DUVVODTAN6TO5yjd0qB53I41VqakjbttaRnpuAmiE
         2/a91KlsvAT9Fu2K82m/7d/y2fdFklTdzOSlSxsHkCRWQ2jXr+XlMAPjwIapXI6akrtg
         2yFR0av8pdErS5jg58qXo2+8nKrP1Qa/TMCw6MAU3gQsc70sWK2i9fj26qO87NrdTgpO
         dWjS0FSiu7OwkpESKMn2bP9hjCiT70PAJ8rsHTuYPRpjyQun0WK1StpISXJ9QvTuPcl0
         QP+S9e+GaPUNULuxS0GrhbPYlGiabiqzSfYO6QSNvdVHQEWyPE0ew+F7xZLysTKNqIe5
         mckQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZRZs5aWnpC+yacVjxfkh8cP2MCU/rxNxGfSPNF7E5INig7wfXw4ArtjrtaUl6SYhJGj+JbKpY6EFqoHU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1X+gb3T0ff7G9VQIdEYvxl4CbJyIxwcCqda+ctv3NDtQDTTro
	u9JXZ2H5UFpYu5AM5nX4/qTdNR7TUNKY5h4W9sl16IMQ1XEkjzhKXjtkqubSiBpWPxyTFq2F3kp
	WFe2HDrJcbJlWl1lNsnNjuTMBFtlytSMQM6Dx1h1JlPM6E8j4dQgTMcLqBJ3cvc907o0=
X-Gm-Gg: ASbGnctlTFNvXWwo0V78L2bBDe6sWHwvHddElseLjrvOZLKgpEWRU/btaw0rrU7AkHc
	Gl9xrW+fAD7d1qyPR3hLNHJtPvtCs3Hm1iufsmUOb1WDAzKBuh+s6tYvWi9jI0lMH6PVOzosTKo
	MBp5GUfJNQMfqm/c6vo9qT7nOONWnzexpBs1pnXeZu/dzXggG5jrBHv6eWww/vNgsGZfJvZ4Dn+
	OtBhQuacHm2TjI9bMqHEJK7RjCqDjsFEPidgMztd9NQRxnbgSAsmQXKxhE9pUeeGqxkxTmlRo3b
	uNci6VOEwogIRXCXlFjJMl7jhk6iIaG4q7v5B8Xl26t0N8rbFkHrG+1WPWaGhaoE/dIH2fSM7GM
	i46cR/OGVGbsqZ7xpGCqr70Jm/w==
X-Received: by 2002:a05:6a00:1915:b0:772:490f:e31e with SMTP id d2e1a72fcca58-77a8432bcc1mr2458551b3a.3.1758027565356;
        Tue, 16 Sep 2025 05:59:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNCEXypeYOzurtCkAx+/w7KzjXac9vn7A0jWvpleu1CWy7D2+PPFBYaKHUtFTpp8QbDgBXvg==
X-Received: by 2002:a05:6a00:1915:b0:772:490f:e31e with SMTP id d2e1a72fcca58-77a8432bcc1mr2458507b3a.3.1758027564846;
        Tue, 16 Sep 2025 05:59:24 -0700 (PDT)
Received: from hu-kamalw-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607a46b7asm16057113b3a.22.2025.09.16.05.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 05:59:24 -0700 (PDT)
From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Subject: [PATCH v2 0/4] rpmh-regulators: Update rpmh-regulator driver and
 dt-bindings for Glymur
Date: Tue, 16 Sep 2025 18:28:51 +0530
Message-Id: <20250916-glymur-rpmh-regulator-driver-v2-0-c6593ff9b4be@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAtfyWgC/42NQQ6CMBBFr2Jm7ZAWhFhX3sOwKO0ITSjFqTQSw
 t2tnMDNT97Pz/sbRGJHEW6nDZiSiy5MGcrzCcygp57Q2cxQirIWSjbYj6tfGHn2AzL1y6jfgdG
 yS8R4FUbVl8pY2xBkxcz0dJ9D/2gzDy7m9Xq8Jflr/xQniQK7TnVCkKp0I+8hxuK16NEE74sc0
 O77/gXgnYyTzwAAAA==
X-Change-ID: 20250916-glymur-rpmh-regulator-driver-80c9543cdd6e
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        dmitry.baryshkov@oss.qualcomm.com, konrad.dybcio@oss.qualcomm.com
Cc: linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        jishnu.prakash@oss.qualcomm.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758027560; l=1492;
 i=kamal.wadhwa@oss.qualcomm.com; s=20241018; h=from:subject:message-id;
 bh=P0qwYvA0hb3DcRu8UXrOaavNtZ/NhaQ2xXab7mtLRyc=;
 b=kv9ZkeOg5ihX1LqJtdrpD7Q2u1Jlub9ilXCJrCJkeUmT9HkA+9Rj9nMiBZoV7m8b9n1nWWjVI
 NICLs4WLD3bAt+rsM43/XIBufStIj7uzc1xJdZigGi08hq050AViRKd
X-Developer-Key: i=kamal.wadhwa@oss.qualcomm.com; a=ed25519;
 pk=XbPE6DM5/mJi2tsiYwMCJCZ4O5XPMqColJRlGVcM7Hs=
X-Proofpoint-GUID: N_y82F3JBD8aLKRmq7PvKGav8ph1VnYW
X-Proofpoint-ORIG-GUID: N_y82F3JBD8aLKRmq7PvKGav8ph1VnYW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA4NyBTYWx0ZWRfX/7aB8WIT6C0F
 ucg1BtbwLV3oDAc5AIlk//tREH/6yOlTbQHOZJ5RxdYxBXTvyR/89b/+KCRveEaDwBCfM2w086w
 p45QbNtfVLkgAciT+ImztkHRg4GPp2SbBafRjXB4XEeyuDn7Tc3227KspXs5ZyEO/J4WTMqGmul
 5y0y3sh/s+LW0MNG8f3He+lTE6S5PCApQD1nG+g8Ub89S6DItrmHIyVfplSDEXfHFX2qVDHrgCC
 9mVSYAt50g5ndzGI+DU71uNckZL8zkVa3bsUGIBOS/PMAQZmZX1j5EBkMK56O86UNjLCEbsr5CH
 YSsW/1u/RdHcwipte6vihjQSSFWX1GEfp+D6K9/vGZJFzyULELNN5PLfjLyPAg6dJVSgTEtDeXy
 YNuKS8yp
X-Authority-Analysis: v=2.4 cv=SaD3duRu c=1 sm=1 tr=0 ts=68c95f2e cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=1jzprTmAGkQg8sxLlQ0A:9 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_02,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509150087

This series contains patches to update rpmh-regulator driver and
dt-bindings for supporting the PMIC voltage regulators present on the
boards with Qualcomm's next gen compute SoC - Glymur.

Device tree changes aren't part of this series and will be posted
separately after the official announcement of the Glymur SoC.

Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
---
Changes in v2:
- Updated pmic-id dt binding's change commit message to elaborate `why` the
  dt-binding change is needed
- Updated commit message for driver change related to new resource name patch
  to clarify that `resource name` refers to `cmd-db resource names`.
- Link to v1: https://lore.kernel.org/r/20250916-glymur-rpmh-regulator-driver-v1-0-bb9b00e93a61@oss.qualcomm.com

---
Kamal Wadhwa (4):
      dt-bindings: rpmh-regulator : Add compatibles for PMH01XX & PMCX0102
      dt-bindings: rpmh-regulator: Update pmic-id property description
      regulator: rpmh-regulator: Add support for new resource name format
      regulator: rpmh-regulator: Add RPMH regulator support for Glymur

 .../bindings/regulator/qcom,rpmh-regulator.yaml    |   39 +-
 drivers/regulator/qcom-rpmh-regulator.c            | 1322 ++++++++++++--------
 2 files changed, 811 insertions(+), 550 deletions(-)
---
base-commit: c3067c2c38316c3ef013636c93daa285ee6aaa2e
change-id: 20250916-glymur-rpmh-regulator-driver-80c9543cdd6e

Best regards,
-- 
Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>


