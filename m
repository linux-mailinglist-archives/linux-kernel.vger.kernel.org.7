Return-Path: <linux-kernel+bounces-858912-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 54ACDBEC39E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 03:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ECDD84E3839
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Oct 2025 01:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB8B1D130E;
	Sat, 18 Oct 2025 01:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lMr1CVal"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54B71C5D46
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 01:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760751227; cv=none; b=Nk9Dxq3XLdFcQuBlh2TZaxTBHANzYawSO2uUqHV90PqeOcoZI0Iqdo7Kk2AxrkXMJaAhxMWDQcQzmbarfNk8T8iEcAg15fDIM3a2MKB82OuCgCwmoVAI/KriJRsAw1y7nGzAxVeIBRPZiNG3cNvwpy7RkP0jZ8d4A/XjaBWicoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760751227; c=relaxed/simple;
	bh=9n2Npp64JjtwAgf393tgwa+BpFjxY3/Fbk9Q2T1oeKo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=p/qoiBDHPr2blRjem228g1eLsZ1dnGZj6gTR+uL9q3UpdwK1EJrGSUL9HX3dendsMoT01YzAUGJKHCh3b5SA4yENAkzL87oJ+3lxauszM0ylByYyn4omsutHTaPac66M859NAKuzuPNZvuKgdfJMor4pxmdDraiXfiPmh8T1dlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lMr1CVal; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59HJGKbS018756
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 01:33:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=rroNn6f0SE/dVbiqnfe2s5
	dd8O5NkJE6h1Gdc6f22SE=; b=lMr1CValIWq3Ru5jzla9NgQgrIODMG9+fvztZc
	EE3ABnSp3+ACePbdLB+8KZsYIp9ISdzXxCjd1ZsTzjTRvfynt0Z1FHGuTTMyD9Qj
	x6ImUWyfCEpUvS6IFyq3NTcqOHiYhG4/oLwiUNxVA3YvOK1B/dg/tOBeAxOlmIGv
	5rtiTwPL3dgZ9Nj+n++fpD7C8vlVe2XZFV7y36J5fv4ojji06THn2s3BIWK/hE5O
	6LdJa3R0BM3FGun4WPD8/0yatvKjR9h7VGx+DmdthDFUE9IGRhiiH8W+Z2dDxPW9
	5ewKy/RB9jkegRIGB87O7txXN30qWzukkI0xUDKqrfZxLltA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfa8p5s5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 18 Oct 2025 01:33:44 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-32ee157b9c9so2081843a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 18:33:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760751223; x=1761356023;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rroNn6f0SE/dVbiqnfe2s5dd8O5NkJE6h1Gdc6f22SE=;
        b=NQ9kPAMnnzRatmCRU2nX4jjcHNSv8XOkq6UBevLGLBy9P6kZDPQDIJbuyrxctk42xB
         jCSkyPY7aZcOyxtw2tDoJqRppV4ZnvYLE0KVGiv1bd5J9Edm7BA8uqifiUeLbkCPu4kA
         25VxKIRJOlf2HTCXHCG0UnzZgvapih1W6rLMuAhFOaaO6XOZkuIQbrAB7u9u8/Q82PpA
         EmmJ02MhFkhHxwJ6l2c+CadNX5uoOYConzP4Zwf2//OMfMjZIrhbpf604pd9osTG9Ved
         VZf15HRIXZ0q5lblUjTzJeU0Eci1+yM1srkdVBh0E1r50vhUXhrpUP8UmpWBD6pw706y
         hHzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZhCVQw4SUtf/JsDw4lAQQDNzTfvgSfojml7egegXpBSEmRC7NnLvuUA/+JdoMdiCfpBc1i8YkSUdbGcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPl2Qd6acVb2kMwo9MCeDLNaOUhYB7qX9YqO6Nqffs2PrFHQs2
	RIIG+goiQNS5VE5uqxVJ8kw0m0lcZD5Es7CUnGTX9EEwIiGbXtNzn6bwlkSpIROMTtwvEGTHzrY
	3HlDXcY3B/drMMxF7UuHEetJo6OI120WwOT05o6cCEDrvjelrMvuRmnaQahyzN0m3c3c=
X-Gm-Gg: ASbGncuwmCou2X9vjGHzh5dcBnrihFJi0CnPVxVJx02Opo4xDHOKkjMdcc78Gxtmkrx
	UjHtizPqEf6/Ta+zTDMje2SsiZCQQykmti1DR7XA9Q+8J+xf7gxBlnFkjImYzPbqcR0gK4pblJz
	StgoO/Nb0th6QRMFKHvYuNtEByt9tca3mbZarWGaIeG5nLcBQitC+oOQFDx4tCpAGx5FBmjw7+c
	m14/EofzDFm27zgQSZnTL8XcQKC7c/xTkTzhooKUZ6zkBSHi/qk7n8SA5jREI/tGh+TaNtSS+hi
	HUxIAm8lDgR+vg9NAFlK4qm0xpsawweGbVhF80drFNnipq1/THjwJmQ05SKZAzthdHj1xXJn0xA
	ZcRSsqCUDMAhlnPLQ1VMYfYjMuzTDNO5wbEi8+iKxCChZPg==
X-Received: by 2002:a17:90b:4c0b:b0:32e:d599:1f66 with SMTP id 98e67ed59e1d1-33bcf8fbaa0mr6005788a91.30.1760751223351;
        Fri, 17 Oct 2025 18:33:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHBIJRmb5oAlcn+6Y/ujWPTO6fLOct8GdacvPDO5zrGgxmmK2+JyQeUEWg8CVD/bDPkQNxCUg==
X-Received: by 2002:a17:90b:4c0b:b0:32e:d599:1f66 with SMTP id 98e67ed59e1d1-33bcf8fbaa0mr6005756a91.30.1760751222854;
        Fri, 17 Oct 2025 18:33:42 -0700 (PDT)
Received: from hu-qianyu-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33d5ddf16bcsm791695a91.4.2025.10.17.18.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 18:33:42 -0700 (PDT)
From: Qiang Yu <qiang.yu@oss.qualcomm.com>
Subject: [PATCH v5 0/6] PCI: qcom: Add support for Glymur PCIe Gen5 x4 and
 Gen4 x2
Date: Fri, 17 Oct 2025 18:33:37 -0700
Message-Id: <20251017-glymur_pcie-v5-0-82d0c4bd402b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHHu8mgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyTHUUlJIzE
 vPSU3UzU4B8JSMDI1NDA0Nz3fScytzSoviC5MxUXQuLJBPTpDSjVBNLCyWgjoKi1LTMCrBp0bG
 1tQBXDzJoXQAAAA==
X-Change-ID: 20251017-glymur_pcie-88b45bf2e498
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Qiang Yu <qiang.yu@oss.qualcomm.com>,
        Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>,
        Wenbin Yao <wenbin.yao@oss.qualcomm.com>,
        Qiang Yu <quic_qianyu@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760751221; l=2322;
 i=qiang.yu@oss.qualcomm.com; s=20250513; h=from:subject:message-id;
 bh=9n2Npp64JjtwAgf393tgwa+BpFjxY3/Fbk9Q2T1oeKo=;
 b=B+wWdQtXBETqipJFLxgfTrTpxJSNE+uVsx8vFnqTU8vyV4TO9d3EOOZDoJAI3l1+MS0/4RBfd
 T/FyzfThbcbAc/qvmsj8Cy6DDdAMf4HA8kT/XaRvFVTyczlCuzVyCdX
X-Developer-Key: i=qiang.yu@oss.qualcomm.com; a=ed25519;
 pk=Rr94t+fykoieF1ngg/bXxEfr5KoQxeXPtYxM8fBQTAI=
X-Proofpoint-GUID: oObzX7qbrPQi0v5F-uhU-hI1K25jt2NN
X-Proofpoint-ORIG-GUID: oObzX7qbrPQi0v5F-uhU-hI1K25jt2NN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNyBTYWx0ZWRfX9pOxHwVg5cFI
 GdtA+WkKWUEoHZhap5ybWvPIvmbOkbemn3dg3PFNCPcW5BAct2LU6tcy2xnu0Non6VW31fR5OxG
 QkeX+mn4e+TvMlvV8RsDnCiS/RbkAhEsa/Jo2wnQjB/nEmja5n/nDSHh5WvKiGNpbgYzv9mMlMA
 x8OflkJTgExjiNBH105Lyw4kzQ+wyw1wAZ+1QmYqdK6pPTn/DzAh60JHTdOtktDBD8iQYB/F5Aq
 VapR936hGMG5weW0wqKJku3I4f60jkbX3psPT5Cn50HeM5jxT0HYYlZ/6zcH+yMrDiZeGS+k5KV
 +DJFcixGkvk2OZzMVMejtMf0IMhxwUEL9qcnYUhuRkpG5eX6ctYXkXP+lI334zJHDAkYIe4LhB9
 L0Xf1mP90Mej3UqMeN4Vb8p+KmfeSw==
X-Authority-Analysis: v=2.4 cv=JLw2csKb c=1 sm=1 tr=0 ts=68f2ee78 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=tTp27qs2TqmI3G6P:21 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=lPERAFM6RZwBrWm71pQA:9 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-18_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110017

Glymur is the next generation compute SoC of Qualcomm. This patch series
aims to add support for the fourth, fifth and sixth PCIe instance on it.
The fifth PCIe instance on Glymur has a Gen5 4-lane PHY and fourth, fifth
and sixth PCIe instance have a Gen5 2-lane PHY.

The device tree changes and whatever driver patches that are not part of
this patch series will be posted separately after official announcement of
the SOC.

Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>

Changes in v5:
- Rebase patches on 6.18-rc1.
- Add PCIe Gen4 x2 support.
- Link to v4: https://lore.kernel.org/all/20250903-glymur_pcie5-v4-0-c187c2d9d3bd@oss.qualcomm.com/

Changes in v4:
- Rebase Patch[1/4] onto next branch of linux-phy.
- Rebase Patch[4/4] onto next branch of linux-phy.
- Link to v3: https://lore.kernel.org/r/20250825-glymur_pcie5-v3-0-5c1d1730c16f@oss.qualcomm.com

Changes in v3:
- Keep qmp_pcie_of_match_table array sorted.
- Drop qref supply for PCIe Gen5x4 PHY.
- Link to v2: https://lore.kernel.org/r/20250821-glymur_pcie5-v2-0-cd516784ef20@oss.qualcomm.com

Changes in v2:
- Add offsets of PLL and TXRXZ register blocks for v8.50 PHY in Patch[4/4].
- Link to v1: https://lore.kernel.org/r/20250819-glymur_pcie5-v1-0-2ea09f83cbb0@oss.qualcomm.com

---
Prudhvi Yarlagadda (4):
      dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Document the Glymur QMP PCIe PHY
      dt-bindings: PCI: qcom: Document the Glymur PCIe Controller
      phy: qcom-qmp: pcs: Add v8.50 register offsets
      phy: qcom: qmp-pcie: Add support for Glymur PCIe Gen5x4 PHY

Qiang Yu (2):
      dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Document the Glymur QMP PCIe Gen4 2-lane  PHY
      phy: qcom: qmp-pcie: Add support for glymur PCIe Gen4 x2 PHY

 .../bindings/pci/qcom,pcie-x1e80100.yaml           |  7 ++-
 .../bindings/phy/qcom,sc8280xp-qmp-pcie-phy.yaml   |  6 +++
 drivers/phy/qualcomm/phy-qcom-qmp-pcie.c           | 60 ++++++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp-pcs-v8_50.h      | 13 +++++
 drivers/phy/qualcomm/phy-qcom-qmp.h                |  2 +
 5 files changed, 87 insertions(+), 1 deletion(-)
---
base-commit: 98ac9cc4b4452ed7e714eddc8c90ac4ae5da1a09
change-id: 20251017-glymur_pcie-88b45bf2e498

Best regards,
-- 
Qiang Yu <qiang.yu@oss.qualcomm.com>


