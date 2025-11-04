Return-Path: <linux-kernel+bounces-884008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2CFC2F175
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 04:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8D33C4F42C9
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 03:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1293426F285;
	Tue,  4 Nov 2025 03:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hgox6UKv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M9y9w5OJ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED0D262FCB
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 03:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762225700; cv=none; b=mpeBIubWtczG1h7by2BPWNwlnZNdjWqmEyHKWoMEiortqbRkuzo5pI3RKwh+UsI/CTCXZjdOLb89gRE9FksmSeGOWLb/9YX34lt8pcJjHhsLY8DVG6ko+i0XUH/rtrZFoNTsczqT/nrp7hW6LbPpCmzO8AMP9XZoI32CIivrhXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762225700; c=relaxed/simple;
	bh=a1Tilr0P83WI7yzkN8cDPjsIRf8z31cBdrQD5U+XBoo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=idVXWCGASAaGrouyLRO+tq6nyxt2mCd0X/WUJ04Lp6CFXY3NtvvSetEAigUIVEAK8Yg3DXA8gNUwGubNJD6iUDjX5rMoFaGWBNttMQjxwTCNMPs4v6IBzj6w1HhtiRbs9ACh+ga3epdr2v22fsbg2fump5IfijXE6QWeP+P1tSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hgox6UKv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=M9y9w5OJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A3H39Eh3595373
	for <linux-kernel@vger.kernel.org>; Tue, 4 Nov 2025 03:08:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=vqo3axmtYai2epioe5STd9
	sXidmtUtS5fufJX0MIH5I=; b=hgox6UKv/PG5c/rTeXtHJ/cJ5/dtFSlCjwZXS0
	1ew/AFiheVx0hdHDCo9EHdGwiQ/SkjLeuVyq+1mvflEtb5gKg9W63be8wV99GzD0
	UNKglHxeYhzXulsUdImBBKzfvw5katWN4/7d2HJnCVjNe/ns8dEhaeU9WtYHZW6l
	u9uKqWXyTwtrkr2f/Sa6Ye2why0hy/u2hiYdcIehs8qPYNOM3BCwlVagsa/aPOJP
	Uw9kzxJOumvWW20dB/buxH5qqU1aRnlijEwwjs0vh49BV4Oe2IAdnV3/Gky/juad
	S1h1hJzLKHXBq1XvYQNuKIqsm+GSGjRxXlbdIyAC8ROrjEog==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a70exherd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 03:08:17 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b522037281bso3670811a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 19:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762225697; x=1762830497; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vqo3axmtYai2epioe5STd9sXidmtUtS5fufJX0MIH5I=;
        b=M9y9w5OJxLFEO2iHHEJ2qT234BUa90Kdsu1H+OKh/RKkuusWNu1ZZlsPkrAU3vBYZJ
         oR47xg3EcEVoySlfnDqEW04dx5Tefz+Gv7QqLSN+B9ik10vVq/ZQ7OrMRnUeNAr/lZiC
         BYKisBzqAeDh0S6MerUzk6KXGTPX4bzBnMylWGVjdy8Z3aAkk3pQbvnuJ3Hz2FXTVNRt
         m37sHxC5UuVmiU3w3cTHK8NHNXB/+wx/PFkEKrEwz1CouGnIIB1BP+hpMW6lJDO8r73e
         s5ap1XjjKJ2c41d5Hwnml8VhzZ6so3j4PpX9y4y6eEpWSGBySPepEwNaESa/olNU9okQ
         yewQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762225697; x=1762830497;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vqo3axmtYai2epioe5STd9sXidmtUtS5fufJX0MIH5I=;
        b=FRcB2HfPFEZiNpBv3oHOE3JDv91sqYQVkM+CqMKKHBhQlEiIPtBqygExZ4ozDQyw7u
         kSqp6Pbk+qNdkWCFlSRs82SC9QDsnbPFW3m4TOqbYojOHpyChYzOk5MEEkjJDPkWVh4Z
         nMBZkigfevErgwlELfBViBCQRNBCb+wOcgP109HaYNTKdZNxDR3Xi9MR+KikIxavpout
         0MkfxZdN+XC/zNLsXb7jxI/ptT6I+TTsrnUAxO620MwsIGBFK5OZmBiUL16dTr5RvgIn
         e7xJmrSh4yl5rs9/ij07PqhnByZXp+QCN1qIzhJjsko+8bnK950BflNIatGS38eyJasa
         Y6BQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMhS8l3rEDRucolNvDB/Dsi9J1S+Y1Bfga1cqk0jHZomJ13fddsz62/DIfxKVfR1ZoixieIBW1HQYASKA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuWhgbhOjO60dxb77DUURUy4qVgv672fcWkhtYRAtJrPMnMnPm
	iwN7E5yR4Ih6jYQsKPYQ9ihY15yZmNNMryyQyST1jCqXoyf6/I0h5t+Rr3flxB2kdXtJ+5Wnuil
	1gj4PqTakEZ6LrRxPCdlqPVfJ2A9vluxQSoCQs98xJ+XUVG/zvN26BH4i9ZTuBuvcjqI=
X-Gm-Gg: ASbGncvXabLJfpsil4nIfR+JDSoZEAPATBWi1e8XAVuww7DOhwfi/IsXrlf6Igq/LvS
	Fj1Ide83X/6ritMC+oGiKk8vArAmxSfSGZcPi7/2982agrIHf1U81HQ7b4lmdIYi3BHj3M13r34
	UujazD0UAzlDZ3zkkTAyyl7UbXfzCLvHnM6jzS3069HskFWNa1sZREZnwHiCNpvulFmAiTllMP5
	tHsmqc1hvwPRQc6xGyuN7YrzOoa99NmV6eCjwbYKK3tMphQtlT0/b8E+JvSVJRYe+xwc3PzNZVc
	P84OpwLA9c1bMueF5M7lrVNpkzODgb6Bq7ZFi6CH7r4UWnXkQW3fRVUx6XM7T6XLRZGZS0yzGqL
	wlABGvOx9kL1cGtzCLljGxLKKnWP34F8yTfeRMnoeG855pg==
X-Received: by 2002:a17:902:da89:b0:295:5945:2920 with SMTP id d9443c01a7336-29559452ee2mr129451615ad.34.1762225697032;
        Mon, 03 Nov 2025 19:08:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHHApLBf34Rsq9YgCVoLCQNNS4Uf5GmQUiEe6iL/8vGo6I+Pp9mPduYICD6kaKgk8EqGlCt0A==
X-Received: by 2002:a17:902:da89:b0:295:5945:2920 with SMTP id d9443c01a7336-29559452ee2mr129451165ad.34.1762225696495;
        Mon, 03 Nov 2025 19:08:16 -0800 (PST)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601998da3sm7357365ad.27.2025.11.03.19.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 19:08:16 -0800 (PST)
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
Subject: [PATCH v3 0/5] Add PCIe support for Kaanapali
Date: Mon, 03 Nov 2025 19:08:12 -0800
Message-Id: <20251103-kaanapali-pcie-phy-v3-0-18b0f27c7e96@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABxuCWkC/x3MSwqAMAwA0auUrA1U66d4FXERNWpQamlBFPHuF
 pdvMfNA5CAcoVUPBD4lyuESTKZgXMktjDIlQ6GLKs+1wY3Ikadd0I/C6Ncb64ZspYeZjS0hhT7
 wLNc/7fr3/QDIfx7/ZAAAAA==
X-Change-ID: 20251103-kaanapali-pcie-phy-67a850bfe384
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qiang Yu <qiang.yu@oss.qualcomm.com>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762225695; l=1637;
 i=qiang.yu@oss.qualcomm.com; s=20250513; h=from:subject:message-id;
 bh=a1Tilr0P83WI7yzkN8cDPjsIRf8z31cBdrQD5U+XBoo=;
 b=0AXPVa9ISGQPMd5VsQ9UGmClrvg/EEmfE7kqap9r5buflV/VE1Ac4rLFpexktAWmp/SIzHBrr
 I8wRt1IxVMEAbDncM9icOsBalp3kdU22hmHhd6jNQ+NMMjmlCinazMV
X-Developer-Key: i=qiang.yu@oss.qualcomm.com; a=ed25519;
 pk=Rr94t+fykoieF1ngg/bXxEfr5KoQxeXPtYxM8fBQTAI=
X-Authority-Analysis: v=2.4 cv=APHuRV3Y c=1 sm=1 tr=0 ts=69096e21 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8
 a=gau1cqUgYdTfV32JTLsA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: dZF3tJ9NakzIjPeFqlGW5Fi4sPc-jXS1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDAyNCBTYWx0ZWRfX1nig1xd9fIIY
 kfeu6xEanC1x0ekNeUC6tD3Us51oCj13bnd6LIpMNc0F7GE3Gjbpx0hOkU49uByBLKhNBxE80xv
 4ir8VU66/+xJqYhZO0aEHCInP9KqF829G+L9528NjmIqqNJqm0WFIc1JzsyBss0Zgb9nMA7NB/E
 GOKCXk5GJdd45NFoLMtXcEGhfcLVrluS/shGHVUQb55SN2WLk/OFyhbI85D0JM/QK5qpLwL7AyN
 93erMfOcDX6NS63woni8jMVQS/HsRapdQ88t7Uq44zlgmZOC40REuICM2EulYb5c9wXHoMPmWUU
 pbtH2CPT492BWgchEqbC/rbmmRv9riJWC6Fd36PSRbYI0TE0PjRWn993Gbgzo3RT8NoSactS02u
 BbqnLyUxTKUeOr5bf+CW9M6h/vaQnA==
X-Proofpoint-ORIG-GUID: dZF3tJ9NakzIjPeFqlGW5Fi4sPc-jXS1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511040024

Describe PCIe PHY. Also add required system resources like
regulators, clocks, interrupts and registers configuration for PCIe.

Changes in v3:
- Rebase on 20251017045919.34599-2-krzysztof.kozlowski@linaro.org
- Add reviewed-by tag
- Remove [PATCH v2 1/6] since it was applied
- Link to v2: https://lore.kernel.org/all/20251015-kaanapali-pcie-upstream-v2-0-84fa7ea638a1@oss.qualcomm.com/

Changes in v2:
- Rewrite commit msg for PATCH[3/6]
- Keep keep pcs-pcie reigster definitions sorted.
- Add Reviewed-by tag.
- Keep qmp_pcie_of_match_table sorted.
- Link to v1: https://lore.kernel.org/all/20250924-knp-pcie-v1-0-5fb59e398b83@oss.qualcomm.com/

Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
---
Qiang Yu (5):
      dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Add Kaanapali compatible
      phy: qcom-qmp: qserdes-txrx: Add complete QMP PCIe PHY v8 register offsets
      phy: qcom-qmp: pcs-pcie: Add v8 register offsets
      phy: qcom-qmp: qserdes-com: Add some more v8 register offsets
      phy: qcom: qmp-pcie: add QMP PCIe PHY tables for Kaanapali

 .../bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml   |   3 +
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c           | 194 +++++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-pcie-v8.h    |  34 ++++
 drivers/phy/qualcomm/phy-qcom-qmp-qserdes-com-v8.h |  11 ++
 .../qualcomm/phy-qcom-qmp-qserdes-txrx-pcie-v8.h   |  71 ++++++++
 5 files changed, 313 insertions(+)
---
base-commit: 0688945f3e5f85f64c7fc9157223f92e0fc5cfad
change-id: 20251103-kaanapali-pcie-phy-67a850bfe384

Best regards,
-- 
Qiang Yu <qiang.yu@oss.qualcomm.com>


