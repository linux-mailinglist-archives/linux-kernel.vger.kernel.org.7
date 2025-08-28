Return-Path: <linux-kernel+bounces-789610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D44F4B39830
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 11:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AFB917E9BF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 09:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0CF2E229E;
	Thu, 28 Aug 2025 09:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FqeLVVHg"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADAF62DF6EA
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 09:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756373250; cv=none; b=CLBlcW4S5Z0U/r2NnyYo9PByz6+hTnp1d/p9x8uQxLJUl31pk2Pbs0Pe4SetLRXXxWC+uLP8oukASM/Lxi6TT3gWpLvpY2AMVyAa6Ale4mUEjitzh5KLUrrPtoqnwYhBaO3vEWh7DhdPZZf6g7KNcYQVyBWl9kOBWIpe1FxTmJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756373250; c=relaxed/simple;
	bh=UZn1e/0QvG5mcFs0SicONTgp5MkJcxhTgH/qXUOPqHM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=LofhEdaHqu/BSYI3laeH2VQQW0x55ju2B/T4CKdAA3k8poz9mDjwvHQDBhZVzXUxdwweEYsN3ZR8HN61hD3jwVsUuCkvE4gKLyOgQ0UkN1M95Vn1jlAYoXcsbZ3hHKev3VAn85Cfui5nGnio0IaROffd3quhL4zOUUoxF6UsRFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FqeLVVHg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57S69grT031913
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 09:27:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=+R9FlvtB5DBD9MbgaBe0G9
	oR+n+eBr41Ts62Yq9hEFA=; b=FqeLVVHgNUrUFUccrdByhf8d7BEAeH7Q8u4jmB
	2RoWLGv0WmXidDQHub+XHpq7WBHRjzQ3hZZ3tA04xZMOpGYqj9A3O8XTURouXu3A
	jtVy5XI6ug8wXUw9568htF3N2s6q0ma7OSM52bNnLvGybzqC0uAeRJohm0Ql+Wgo
	pl2ApNDTJAOIkQofpHy1Mf9SfvKpVdzZ46iiBSLoa0nCTUzKatMjZCoRqBdIvlEF
	vUZATbqJjruvJIrSQKkyBkwviR4Hx00nZJ2gVdF6ua7WcWnr1xiMajgFIJnFJ/X3
	yQ06XHkjZYJjHmDB7eCHVDAtZiPHaiR0HJgF6EdG2b82R4iQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5xpyw25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 09:27:27 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24456ebed7bso11170405ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 02:27:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756373247; x=1756978047;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+R9FlvtB5DBD9MbgaBe0G9oR+n+eBr41Ts62Yq9hEFA=;
        b=sf7iky8K5+ClpiVDPYbNRR7OfdkQXPpQO0V6bjj9t/icAaeRl3/pZ4BzMZEUOzk8AX
         I8vT+NSBgFfOwUj9f7V01YpNj8GBI/QOJQM/iQmQ6Vaq2DQ9QIye/5MG+FZeZXRH/IfJ
         yhDNw2U6x7xULcb4EksEvQZh69O3mkjr5iB249bCQVZ4IoDbRkEXKAhS+uFcoQqG3gcV
         rIrNXbNrtdDZn2FrQBuOCUyXDrhIXR7HmQAjl+1ugfwnmk64aJrvC8nmPRTwTJJ16mAo
         d2KZqjXW5qM1Xj05s7EOB0FNZOVgrKda6t+T0ZhCmzqS7tDl6C0xdx5Od4cUF/zmJLMf
         Y0VQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1z3Er8cJ9Y+iDhnbvYi0epvglUlFTNg2eQxd6lsNPjvI7fI9xmiVz2K7XNg2ZbNYZ0ROKHhDJ08mKwJA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yybp1fvQLxFYJe7oXPrQvmEEzbDfcgO0rfIEbteOe2auIV+vFaa
	KR3L5r9+GEKVsunsaF0+/5X7x4xYMra0ZOdLhXpjjnGm3/71fuYH7ACZH/kYZpGjrj463fNyRHm
	ra0ruMd5hhC+XvhOUfewzyCMA66B+I4XkGnjXi8Jr+14Vf6z2bT4NP0uXagLePVRl6lw=
X-Gm-Gg: ASbGncvoeOP6PhCcYZYr+YPYozjs6t+Q6Sk6ySZaJcK7XNL8nB0rY4PztBC7AK5+nMg
	1pFSRF99AX2gHqwCFKEYFO9vZ+YNUmv6B8tdWX4yjJrS6Gp73Zvh1nZGSu40amJVlDQ4SL75gTj
	MLjeD4JeAdAu7OXeqFREdVh11IFKl2yvYx30iEhXi6PllGb6Dxc/6E59nNIjPGrueooi4W+/WYn
	EbhTqiIV1Jer9QYQqekEhYuQgIxVfEdLUN+7W8CWvvCkDv2I2+81CdIbtkJ+8yDW5gFMjnAHfTK
	E66BODgNzNSchUW3mK9fAHFeS7cu7Ixmv2DaFAFPoUBdV/tr8/G9LUMXmSSpAceQj/al51YH+YV
	jifMd6Vmz7LV06ub9A5wKTg==
X-Received: by 2002:a17:903:38cc:b0:246:2cb3:5768 with SMTP id d9443c01a7336-248753a2bd8mr119449225ad.30.1756373246889;
        Thu, 28 Aug 2025 02:27:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFxz54QfBeeANm1Mg3jqliReUDNjYOnWOmNkEg2Int6lFhWZh1T5+xjUbSHeCwCMBvkxsM8RQ==
X-Received: by 2002:a17:903:38cc:b0:246:2cb3:5768 with SMTP id d9443c01a7336-248753a2bd8mr119448925ad.30.1756373246396;
        Thu, 28 Aug 2025 02:27:26 -0700 (PDT)
Received: from hu-yuanfang-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246ed91ee20sm92497015ad.136.2025.08.28.02.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 02:27:26 -0700 (PDT)
From: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
Subject: [PATCH v3 0/3] coresight-tnoc: Add support for Interconnect TNOC
Date: Thu, 28 Aug 2025 02:27:21 -0700
Message-Id: <20250828-itnoc-v3-0-f1b55dea7a27@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPogsGgC/22MzQrCMBAGX6XkbEqySX/05HuIhzbZ2gXbaFKDU
 vrupgVBxMvCLN/MzAJ6wsAO2cw8RgrkxgRqlzHTN+MFOdnEDAQUopYFp2l0hutSQKWsbGthWNr
 ePHb03Dqnc+KewuT8a8tGuX5/C1FywUswNequaqyCowshvz+aq3HDkKfD1lCEb3n/kSHJYAWWL
 WqN0P2Rl2V5A/SpbjveAAAA
X-Change-ID: 20250815-itnoc-460273d1b80c
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: kernel@oss.qualcomm.com, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756373245; l=1882;
 i=yuanfang.zhang@oss.qualcomm.com; s=20250814; h=from:subject:message-id;
 bh=UZn1e/0QvG5mcFs0SicONTgp5MkJcxhTgH/qXUOPqHM=;
 b=5VRyT8mvsMZTvKcbUoKzMdYJSJHBUeFfYA72DcRGlU9FwKOHc3xVkJXJ0DKDPy1rLuzZyvRMr
 bBSAjcTFTVKAPlKlLEDBXtfxAFVXeekAglNonHiaB8LbqnCy41XIA8K
X-Developer-Key: i=yuanfang.zhang@oss.qualcomm.com; a=ed25519;
 pk=9oS/FoPW5k0CsqSDDrPlnV+kVIOUaAe0O5pr4M1wHgY=
X-Authority-Analysis: v=2.4 cv=KOlaDEFo c=1 sm=1 tr=0 ts=68b020ff cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=s8j_kBg_6ddNrZYoh_kA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: Rl4YXyAdJzCiGl64mukzGEPnBag5DxOC
X-Proofpoint-ORIG-GUID: Rl4YXyAdJzCiGl64mukzGEPnBag5DxOC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfXw5QSo50bklyk
 H3uTBNa7UiABRzjIxW46igsMdGHZdQRNAM7GZWzc4q3//dQjGP1JJ7bh9g92XjB/dwMcL2Irp62
 4y47yzwOl79fSYMl4w06jaA+cvwLyWBrSUwqaKpaSoshHXE7uzSH7WcwoTCvRI2B58KEmOIfk2W
 ILhqy8IEAHo0/Mysjr3ziUw1eSrPhgXBjoZzL52WZ83NF2+EDbfoDA0BSSEs+6Hn44f+mPGJyyw
 Iw6/9Lzl1b7WXxMTFPhP+1OOBr7gl1UxS6dYlIkLnh9x5DcnO/nqsjW0gX0wLSzWTnVhxSsKI/Y
 j1Yl/5WIpYnMnp/k4U83gXY9kdrDA99/NYalsarBro7ea60qVhFX3b4viK1JpgA25LprtU3wnDe
 M53mEZ4t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

This patch series adds support for the Qualcomm CoreSight Interconnect TNOC
(Trace Network On Chip) block, which acts as a CoreSight graph link forwarding
trace data from subsystems to the Aggregator TNOC. Unlike the Aggregator TNOC,
this block does not support aggregation or ATID assignment.

Signed-off-by: Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>
---
Changes in v3:
- Add detail for changes in V2.
- Remove '#address-cells' and '#size-cells' properties from in-ports field.
- Fix comment indentation for packet description.
- Link to v2: https://lore.kernel.org/r/20250819-itnoc-v2-0-2d0e6be44e2f@oss.qualcomm.com

Changes in v2:
- Removed the trailing '|' after the description in qcom,coresight-itnoc.yaml.
- Dropped the 'select' section from the YAML file.
- Updated node name to use a more generic naming convention.
- Removed the 'items' property from the compatible field.
- Deleted the description for the reg property.
- Dropped clock-names and adjusted the order of clock-names and clocks.
- Moved additionalProperties to follow the $ref of out-ports.
- Change "atid" type from u32 to int, set it as "-EOPNOTSUPP" for non-AMBA device.
- Link to v1: https://lore.kernel.org/r/20250815-itnoc-v1-0-62c8e4f7ad32@oss.qualcomm.com

---
Yuanfang Zhang (3):
      dt-bindings: arm: qcom: Add Coresight Interconnect TNOC
      coresight-tnoc: add platform driver to support Interconnect TNOC
      coresight-tnoc: Add runtime PM support for Interconnect TNOC

 .../bindings/arm/qcom,coresight-itnoc.yaml         |  90 +++++++++++++
 drivers/hwtracing/coresight/coresight-tnoc.c       | 139 +++++++++++++++++++--
 2 files changed, 216 insertions(+), 13 deletions(-)
---
base-commit: 2b52cf338d39d684a1c6af298e8204902c026aca
change-id: 20250815-itnoc-460273d1b80c

Best regards,
-- 
Yuanfang Zhang <yuanfang.zhang@oss.qualcomm.com>


