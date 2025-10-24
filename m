Return-Path: <linux-kernel+bounces-868088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABE90C04543
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 06:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30B843B967C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 04:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC0312749C1;
	Fri, 24 Oct 2025 04:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RJn1dta0"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF5B2853F2
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 04:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761279881; cv=none; b=p+hu7A8lTOh6MgPf9gy/mVLqjKaFncH5DwMsaszuLHJWOJvs/fRfDXVXHO3DFQ+6aLk0z3VUKpDwaptVBspP42cUw1sPfvWeM9/KDSIN1ErU0kZGxNZj2Pn4o0hTaLrReJI/WqXFsTx6kz5oBnDEJeuAQ3CJbmjvYpHQ+cKNel0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761279881; c=relaxed/simple;
	bh=wGNzVDOz3JwNw1jCuRX8JskKBokuqyvEF4HMNZ+w/N4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bnabOlKKWAf3z8Cht0B0cSXksCq22rURT/QsLj9UD/CW15uJr1yqGtQxwWP+gCTyWGCstgrrOlaFeODWhhzRHmZjBWado5NMjgqfJt8nYDbK2IuNdtjvQs7fUsqaMRDnmYn/elFiLUC/EzNb7pB6z6BMaKdtso0bTG5W55SPnSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RJn1dta0; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3FFfv015666
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 04:24:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EWp2flz7HGqJJ0kLm9NGG032VbVErRRgCQrNgPRGXtM=; b=RJn1dta0y1bjM37B
	nVeID0v9553+DW5CYKMTtokUjN+bRejzX1Nej2un33QrTs8wpIVXTlxNUOd5VNyS
	+uH3dEf0cDfebhd8E59K7u1hMtABV5vm6kFhu635vhZYj1Tc+1hTx8kef2lDSXf/
	olb8w/BIdeUQ7dJze0Dd7GC4dbHkr6lOPEiB0WhKMYaSdqQT1CyUsp7M3qSaEStb
	I6B7wOC3rmsnzgY322MJshOIvJHYfVZZyAwHNI5Z3VKmTH5MWM+sqWF8801p4rhc
	Z/IRj2qqzUVjwTCkVlwKod8DtQSa5U93lGnFLhNxCcuhcqqVNP+p1/E/02odG49C
	+GbBcg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49xkpsgbwu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 04:24:38 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-290b13e3ac0so13878145ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 21:24:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761279878; x=1761884678;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EWp2flz7HGqJJ0kLm9NGG032VbVErRRgCQrNgPRGXtM=;
        b=OnNSic5tFEwOPy7cgKL2jLvbPlNupG4dmOW+JNmWpoxms7iV9sEiPZzbrua0HeDrzu
         3cvHHz7ulsWIMIArBT4Kzk7hiOzJtLM62HgCEnpnu4S5pUFGJsh7MSX57oO4x5hXzrqX
         V/1cEYMuG6228HA4o7OPdkoIpxyBxgbhYOisiECcXTiAYavf/cI3t673nQV9kFjWbU0K
         QSEUxeHL8a8/kCE4WuBX6wIxA2rPGyEeWRpIDwI1lj8uKMrZRwQIETUQGharA6Q50WNs
         YmkAwhCnTAAIF5uTHdEfqwmaylg7K8zksSK9aGGmMzx+n3CVUcCvdP3uXZ1AWxUfPA/I
         7/HA==
X-Forwarded-Encrypted: i=1; AJvYcCVYEquvFQ9i8TMM1GsRfug7KT/JlNsHKvtgTclK1AsAyrtkmRNBIN8Pm5YbBe3j7RwTq1R/mqdUhsdybpM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNxVBt5fTP7JpWtWakLva8lErFSHA7s3owmMOUt7jHThd7aAf6
	qtFbIWrONwk4XAgH2Fa+zDCAf5d7d+QuDbvxto+CdBa+DEQArTgcGUr9LX5IP1yeIcB87Odc8XF
	XvHnpjm25cAGc15KkIGA+OSUhHiTco96i2VxHK4fa2Z0TgKPmoYpcT7SOlhQCUWGP3Nyjsxk1+t
	8=
X-Gm-Gg: ASbGncupcDmM0O9Hy8wrACEnLFIoeZPQbBHcol4pfN26U43X4gk4ghFWSPytHuy2ZL9
	8cMZ7VLQ6SCenXvaW/3dR3aePSv0Z1ZBlpKmXkvCoHcuczjt0iA/RV1fZeaC8USm1F22R8WxY6c
	LA/IEuZRS7iPnr9FiKKOrthJgki/tRxao1a40E9Ajt+lYocnGSLTCX1T3Bb7vGzOypKcV8K4rmN
	xKJEclcgZ5a8Z3w7gA5o/lRn/FC3atWyJvdODIi0yfVsjAbBqzC7Md90IMpt8jGzENumxI4piVY
	hPD4YsoQw7lQeHPHXwoe8bZUDumKgEDfHAVd58bINPo7F23r8jekKrdqPhK/dM5rp8cWHJsPw3M
	W9wDZyFbqJgd5hON3hkUhX8k=
X-Received: by 2002:a17:902:d491:b0:274:5030:2906 with SMTP id d9443c01a7336-2948ba3e2a2mr11972995ad.46.1761279877584;
        Thu, 23 Oct 2025 21:24:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0wbnYLHm4VdR9+5/5V4ukesu554132nyYauCgk94HOSH08YWk280X6qGuIG3LbB57TkNvbA==
X-Received: by 2002:a17:902:d491:b0:274:5030:2906 with SMTP id d9443c01a7336-2948ba3e2a2mr11972685ad.46.1761279877081;
        Thu, 23 Oct 2025 21:24:37 -0700 (PDT)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946dfd0576sm40259805ad.67.2025.10.23.21.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 21:24:36 -0700 (PDT)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Date: Fri, 24 Oct 2025 09:54:22 +0530
Subject: [PATCH v3 1/4] clk: qcom: branch: Extend invert logic for branch2
 mem clocks
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-sm8750-videocc-v2-v3-1-6286bbda3c8e@oss.qualcomm.com>
References: <20251024-sm8750-videocc-v2-v3-0-6286bbda3c8e@oss.qualcomm.com>
In-Reply-To: <20251024-sm8750-videocc-v2-v3-0-6286bbda3c8e@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-aa3f6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDE5MCBTYWx0ZWRfX6raiwxMMtKco
 xAou90S4cllIxl5x86EvroQ9oE88Y2hkl8bsy0k3ZZAY7jwWqd6+LTm5rF0fM3lwQFRLru8e/LI
 KUbk6KiKdP72vDhfwVgpe6ll8v5zjYhzOyg3d5AHLbbw4Qga9cMxdRg91hs9o1/f1JxmKPtD0f+
 iCb3X1U2Exzt2RLKPXtMXkBdU6br3JdV6PsOw3fp7YxaEJ+6k7wQPUI52lyTjjkkicZDIKluIOR
 j4+6+X+EiOVloUbGSIJoN5cLGP6Y1GhfT1cSf/9EBkE8EDr6NepPQm9VNlD/jloka5JmNxx9Jgs
 bA0bZ+HTTmhnWyhqdci93+ishpjObf864xO/99WsLdZ/RiElykh7FznD50MagX9Ogx3eA5MC76y
 Ew7TU6HNHlFt5FHkIy/T/Z3nkeazrw==
X-Authority-Analysis: v=2.4 cv=FbM6BZ+6 c=1 sm=1 tr=0 ts=68faff86 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=TPL9fEiPDwMg0gBHboQA:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: OhmxVdHOnArB0ynuM5lqSebDWNUVJE-o
X-Proofpoint-ORIG-GUID: OhmxVdHOnArB0ynuM5lqSebDWNUVJE-o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 impostorscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510210190

Some clock branches require inverted logic for memory gating, where
disabling the memory involves setting a bit and enabling it involves
clearing the same bit. This behavior differs from the standard approach
memory branch clocks ops where enabling typically sets the bit.

Introducing the mem_enable_invert to allow conditional handling of
these sequences of the inverted control logic for memory operations
required on those memory clock branches.

Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
---
 drivers/clk/qcom/clk-branch.c | 10 ++++++----
 drivers/clk/qcom/clk-branch.h |  4 ++++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/qcom/clk-branch.c b/drivers/clk/qcom/clk-branch.c
index 0f10090d4ae681babbdbbb1b6c68ffe77af7a784..4094ffc53d0c91dfa9e4263134c3a996100ad078 100644
--- a/drivers/clk/qcom/clk-branch.c
+++ b/drivers/clk/qcom/clk-branch.c
@@ -141,9 +141,10 @@ static int clk_branch2_mem_enable(struct clk_hw *hw)
 	struct clk_branch branch = mem_br->branch;
 	u32 val;
 	int ret;
+	bool en_val = (mem_br->mem_enable_invert ? false : true);
 
-	regmap_update_bits(branch.clkr.regmap, mem_br->mem_enable_reg,
-			   mem_br->mem_enable_ack_mask, mem_br->mem_enable_ack_mask);
+	regmap_assign_bits(branch.clkr.regmap, mem_br->mem_enable_reg,
+						mem_br->mem_enable_mask, en_val);
 
 	ret = regmap_read_poll_timeout(branch.clkr.regmap, mem_br->mem_ack_reg,
 				       val, val & mem_br->mem_enable_ack_mask, 0, 200);
@@ -158,9 +159,10 @@ static int clk_branch2_mem_enable(struct clk_hw *hw)
 static void clk_branch2_mem_disable(struct clk_hw *hw)
 {
 	struct clk_mem_branch *mem_br = to_clk_mem_branch(hw);
+	bool en_val = (mem_br->mem_enable_invert ? true : false);
 
-	regmap_update_bits(mem_br->branch.clkr.regmap, mem_br->mem_enable_reg,
-			   mem_br->mem_enable_ack_mask, 0);
+	regmap_assign_bits(mem_br->branch.clkr.regmap, mem_br->mem_enable_reg,
+						mem_br->mem_enable_mask, en_val);
 
 	return clk_branch2_disable(hw);
 }
diff --git a/drivers/clk/qcom/clk-branch.h b/drivers/clk/qcom/clk-branch.h
index 292756435f53648640717734af198442a315272e..6bc2ba2b5350554005b7f0c84f933580b7582fc7 100644
--- a/drivers/clk/qcom/clk-branch.h
+++ b/drivers/clk/qcom/clk-branch.h
@@ -44,6 +44,8 @@ struct clk_branch {
  * @mem_enable_reg: branch clock memory gating register
  * @mem_ack_reg: branch clock memory ack register
  * @mem_enable_ack_mask: branch clock memory enable and ack field in @mem_ack_reg
+ * @mem_enable_mask: branch clock memory enable mask
+ * @mem_enable_invert: branch clock memory enable and disable has invert logic
  * @branch: branch clock gating handle
  *
  * Clock which can gate its memories.
@@ -52,6 +54,8 @@ struct clk_mem_branch {
 	u32	mem_enable_reg;
 	u32	mem_ack_reg;
 	u32	mem_enable_ack_mask;
+	u32	mem_enable_mask;
+	bool	mem_enable_invert;
 	struct clk_branch branch;
 };
 

-- 
2.34.1


