Return-Path: <linux-kernel+bounces-868104-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 81395C045E8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 07:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6ACD24E5DB8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 05:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF8824BD04;
	Fri, 24 Oct 2025 05:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y3TPD1qC"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAB72AD0D
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 05:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761283139; cv=none; b=QE0BxDJJYY8NUXeihr5Nfu2rvxbhZsqsmYR5l0ZvkGFeaEftUcYm6WQm9WlEMg4mKBpuMylLxL+3Tn2jPsyjCbftwLLSbz4n8QpBjx+hfonA1W31+wx71qXKiih5K0VFustqso6mhh+Gxg65SIlCTHiUJ8ysmSoeFoIj+6ZKqj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761283139; c=relaxed/simple;
	bh=XQ+JlN74f2Jp20YFK1NOgcX3NOcIEvg0gafRe+n0rv8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ELyyqGnIWKBgcVj3z4KVG4LvfGkyfPGhFITirLdQoHJ9/M5k7AwFjqCnS0711Li1n5xPg5h9Vco8YOEDZZlyBEMj5CnJzkZiZ5KuJ+zKBL1OZZjmV/Bglj8YEg8BM32eh23i3rgM7S8JeiitponUTjZPNtDl4cVJcRfRtiMglY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Y3TPD1qC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59O3FVXf001257
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 05:18:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=YxDg8wob0BqVw0+zh6pPHL
	5Cq3vrRGqu/p4Y/OVXT+w=; b=Y3TPD1qCP/C6roN35W4+PKI5fFPhwUKEh6Znl+
	WU2HiBBvUwOYBJeQoLFK4UFSirj4oYHG8tDqSkG0qpt6lUBJHZk2SMEc6i40V4l4
	3aUGJH3BKJ/bd7XBAN7MuBr2IIw9VA4bpH+Pd/HHwMoBK44OToCH+wMKYFn7ICKy
	njaLRtgXFz+LvYLF00MC13mmnKNvnKLD7sFMtl9yJ188M0KmLiW3b5ZsNrcaKiir
	MIb3ubQ8A3X9i/RMx//Ya1qxAgZxAnOSe615ioth+dTPLnaKyq8t4mwGH0Ph+xbL
	i8JuA19qdds55g+7SSbr7CzBF8nANRMEA9ewB6X3Sg+vfnyA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49ym9j2g2b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 05:18:56 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b6ceeea4addso1388935a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 22:18:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761283136; x=1761887936;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YxDg8wob0BqVw0+zh6pPHL5Cq3vrRGqu/p4Y/OVXT+w=;
        b=hhW/63wEquz/DmVOaGUOhd5TUU25GglUicZ6YPNbgfd0KzpycEvwckTaaGF0YQSZKg
         m7/4DLDBHMhcN17SpxLwmCAkLHb/SZ2EW1GG5pOCZ4YLljdC8uAJmg7iNChqQbmU3ltT
         VPfWEm26PUkC+fHTgE3AkE8LGZ/TDF3eM/NxMlX9MVxBxErZc4HFWG4ZkGZ4h00iKS3K
         Mw6kEWfJPmwVGvv7YGMe4LnelsYYyFwyZO+UTxHY6nWWiBOiJGNZZrDl3OQv6IiFZ+f1
         c8GOGglhTbsDOdNUME7NbW4mMYHu5+xCVa+KQYiB7sdVIEc1SVoe0FgNSXgEOVVccWUR
         kfew==
X-Forwarded-Encrypted: i=1; AJvYcCX1sI3TZ9ZygSQqT9P/W99pbUmFmpi3re3USTAvynfMoKe+xpyTr1kmdZnELfpvRAW1S+Ol0qAhIcPnoSo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQae6lODB851HDD3rpkVVw9QiI9aNNx3/LzC/bbopL615Tzxtj
	F0V6IU6eKNY5NZzBcDk2XSEnqHnXqRWRz7vIBngSq2QqI9nrgEpAb+MfsHZko1qHPbehXOqj1pb
	wu+/ii9qFYkB5yTDieLgOzyZ54d2/s4ypZiAJRiE68FT29HG9xEW+KtazvBflXI7IHGw=
X-Gm-Gg: ASbGncsCklBYLwYQI0gauLrsrMeQb3RQO3UdBxdEJGo90LQVW8/SQdz+TAKtACyqJmn
	hen+O9yj6djnhOnTmWoJPYxiyfNMmP2sNqfQq8V9qTeW2+sQKDv2W9Y7CTmR9wjqp07B2itLc5a
	PdLO6AckdrE4txhZ4URgRmSzsZv/O01tmDvebOsEm15dF0FFr2fAw/jM5rl2Jnn3XUs7B1dDI1u
	GeyoTQ120GfcyciBXjaZ71rWI4W8Go5D5TvLCjk920TY/0xk3srTZISBltDTWK5L9n0oUpPV6bS
	HoYvhYmYk2bagfbIhZvkLMwKWXdOM7WzX/AT8yrBsO807N8xSJJHG+ZmMkEW7BlICTf5hFoGNpS
	tAgIqzIoPaSqLhCTjwGqKelA=
X-Received: by 2002:a05:6a21:6d9c:b0:32b:6fdb:734e with SMTP id adf61e73a8af0-33dead4c669mr1477186637.28.1761283135824;
        Thu, 23 Oct 2025 22:18:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEA3SypwBbaeYcsMylDsibkkJkFzpDnuXNKIAef7Zx6JcuxdUyRtNbCfZYucE711DH+oerQGg==
X-Received: by 2002:a05:6a21:6d9c:b0:32b:6fdb:734e with SMTP id adf61e73a8af0-33dead4c669mr1477162637.28.1761283135369;
        Thu, 23 Oct 2025 22:18:55 -0700 (PDT)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a274bb3636sm4502218b3a.61.2025.10.23.22.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 22:18:55 -0700 (PDT)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Date: Fri, 24 Oct 2025 10:48:45 +0530
Subject: [PATCH v2] clk: qcom: gcc: Update the SDCC clock to use
 shared_floor_ops
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-sdcc_rcg2_shared_ops-v2-1-8fd5daca9cd2@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIADQM+2gC/4WNQQqDMBREryJ/3YgJKrGr3qNIiMlXA9VofhtaJ
 Hdv6gW6GXgD8+YAwuCQ4FocEDA6cn7NIC4FmFmvEzJnM4OoRFPJqmZkjVHBTELRrANa5TdiqFs
 ULZfNiC3k6RZwdO9Te+8zz46ePnzOl8h/7R9h5Iyzmo+d7FCaYeA3T1TuL/0wflnKHNCnlL5mX
 ooivwAAAA==
X-Change-ID: 20250804-sdcc_rcg2_shared_ops-ea6e26185fe6
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-aa3f6
X-Authority-Analysis: v=2.4 cv=CLknnBrD c=1 sm=1 tr=0 ts=68fb0c40 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=FqA27K0koNEk4n6jG3kA:9 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIzMDExMiBTYWx0ZWRfX6opvGXzk9uhG
 vly6OEoV8U0M0BvOMTC06R/ogo17VaWMm2OmjYDmZV7NoqNFF3jGodzAZPa0Pm3/RVtri+o9ySW
 XMsdNjRj+axJtTmtrVsgLhxnIDL/mxvnDE/342PwHUHeK6X5sbfUbTMZkQ/MJEY7VIECgMHCVuw
 WU9nkDNK2GUZKDccQqB8Wvty6ujErqkXxJDguWihOORFBfg2Y2qKsFVTRKtUWJroSZYhlMC942a
 XlmfK82TpS3KeRjLonM2ot7HtLVHC6kaHbpzwFzOevJ0FHymVqFrlXsX8Xky91xhdOiap35AOhn
 3zyr0p99NDJA4C0p+npnDdHkZIEnUr+fL3z477yOj1liHfToc19c6gSV+2EyCFWxaCukFpjaGu+
 LWUEaUd+tsgxAtVGRlYAwm/hH3haHw==
X-Proofpoint-GUID: 0uhR17fv_hhhPec67GszG5Sed0O_dE4I
X-Proofpoint-ORIG-GUID: 0uhR17fv_hhhPec67GszG5Sed0O_dE4I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510230112

Fix "gcc_sdcc2_apps_clk_src: rcg didn't update its configuration" during
boot. This happens due to the floor_ops tries to update the rcg
configuration even if the clock is not enabled.
The shared_floor_ops ensures that the RCG is safely parked and the new
parent configuration is cached in the parked_cfg when the clock is off.

Ensure to use the ops for the other SDCC clock instances as well.

Fixes: 39d6dcf67fe9 ("clk: qcom: gcc: Add support for QCS615 GCC clocks")
Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
---
Changes in v2:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v1: https://lore.kernel.org/r/20250804-sdcc_rcg2_shared_ops-v1-1-41f989e8cbb1@oss.qualcomm.com
---
 drivers/clk/qcom/gcc-qcs615.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/qcom/gcc-qcs615.c b/drivers/clk/qcom/gcc-qcs615.c
index 9695446bc2a3c81f63f6fc0c98d298270f3494cc..5b3b8dd4f114bdcb8911a9ce612c39a1c6e05b23 100644
--- a/drivers/clk/qcom/gcc-qcs615.c
+++ b/drivers/clk/qcom/gcc-qcs615.c
@@ -784,7 +784,7 @@ static struct clk_rcg2 gcc_sdcc1_apps_clk_src = {
 		.name = "gcc_sdcc1_apps_clk_src",
 		.parent_data = gcc_parent_data_1,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_1),
-		.ops = &clk_rcg2_floor_ops,
+		.ops = &clk_rcg2_shared_floor_ops,
 	},
 };
 
@@ -806,7 +806,7 @@ static struct clk_rcg2 gcc_sdcc1_ice_core_clk_src = {
 		.name = "gcc_sdcc1_ice_core_clk_src",
 		.parent_data = gcc_parent_data_0,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_0),
-		.ops = &clk_rcg2_floor_ops,
+		.ops = &clk_rcg2_shared_floor_ops,
 	},
 };
 
@@ -830,7 +830,7 @@ static struct clk_rcg2 gcc_sdcc2_apps_clk_src = {
 		.name = "gcc_sdcc2_apps_clk_src",
 		.parent_data = gcc_parent_data_8,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_8),
-		.ops = &clk_rcg2_floor_ops,
+		.ops = &clk_rcg2_shared_floor_ops,
 	},
 };
 

---
base-commit: 5c5a10f0be967a8950a2309ea965bae54251b50e
change-id: 20250804-sdcc_rcg2_shared_ops-ea6e26185fe6

Best regards,
-- 
Taniya Das <taniya.das@oss.qualcomm.com>


