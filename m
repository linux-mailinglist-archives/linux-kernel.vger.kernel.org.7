Return-Path: <linux-kernel+bounces-857264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E3476BE65BC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 07:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A29624E3791
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 05:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039F91F4165;
	Fri, 17 Oct 2025 05:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PlsFYDXD"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA12319D065
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 05:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760677574; cv=none; b=Rvx9Gq4PnPu7snz3qXY4zxGLmXHe2dkHCMAScipJSJ6M534JVBdfoRHd9I1HnsBa8BI2/447GaaAcyW9QXEsAd1CcyropvkhCts64e0sppQ966GUkttWRW2kfcbaft4R3U4qgYuyoDt/fXniPbdGGnH5vxeCteW8M+HQeS63kVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760677574; c=relaxed/simple;
	bh=9a/4kkHMcXDzTdUVtOV6+gPflZeZm9CcjJjD0jh9t1A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=haHWjHpQIGunScoYKSP1xJGbQLZno2pULA7XHJtpJFmkeLA1leFzX/NgDJcyZTABGMnlVJ7j/rXxjnbIPKHtZFVbSh7Cd1k/Sr+9UjruM0f1dCvQmH886yjyxc9eoJKdsTl7Bcoj5YFtQuq9wPToWRs+SUdZKMVo54+0KqC51Lk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PlsFYDXD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GKLNAm008871
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 05:06:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=lv1n4r7agZ/IsMA7Tl3tpW
	tn/T0oKJtryheIrqHwlsk=; b=PlsFYDXDpkhZy9vGxNbwjNOFoumA9YzF9ZdLmh
	10paSA6NIgSRNKABGXyR8r+KXjkvQwCPDvAjkR0I6xHIT13PhTL81hXN/KrbAgVk
	vcQgijyxaRsN5cSVTt8Eq//kTnytbdeaFmUlVAQhu/nPq5E3iGknU0BxIYGfj8OS
	UOrnhZLva4nR7FHm0atv0dCX+oWhmHf5RpDa2ISPFTeOVwtjROXR7Zyf3f5S/e1M
	7dxgVnoBQxHRZBteJTym5CwWuYms2Tf3Ng3CrEvsmHGiafKqw896FVnegJiqQOTq
	nXR3N5XopA3DSt2XqpLJC78Wg+y+AUptkrgpABIrLoYGgzPQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49rw1aq53c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 05:06:11 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-87c1d4f68fcso60737156d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 22:06:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760677570; x=1761282370;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lv1n4r7agZ/IsMA7Tl3tpWtn/T0oKJtryheIrqHwlsk=;
        b=cqI4cJ/g4bvPxvnayS9jAWUTKWXIU0C3Z1z0YR5cvEpA911sJyJP6TkMs7IV0pet9D
         R++UeuU2gWwZXp84r0Jph4Zvsjp64ib1l1D7RxxJKOOdKXifsdSj7ayxOUnQDX5ncxZv
         cyoLhtpbiqAUzYQxEJFOWdXnktqCQHznNZfIJJfiPqUuTp1Hio5OObIb6ImrBGa7Pe4/
         Jq9YfPX4Ui0UgS7hUYNnxq5Wv0RADH0VH++tBhxvZnJu9FXQsXfdhRQ/v2I9//LX3V1a
         HAvFz5V4CO9b0srPXgcRz0ajTsknUIe2znlsADCH01i2IP73ovQtNq/D+/KpBd+SshFX
         k6kQ==
X-Gm-Message-State: AOJu0YxwL1MQ4JOzlVMxnoYWBt3XOgwPBCnkz2k93oNxP8MlZc4bnFjT
	bMrMh/HwWicM9WGjMbF1mLltov8m5FbcGhQMecZoEaoWdsmulUAuiIKCzucsdEqy4vn5ac8WE71
	JqtI2tR/kfevdoVW1UJaEDrGVSJKtlk/sb0Ueof0tO5+OB91IdUteN7P2i5QDYCqnImU=
X-Gm-Gg: ASbGncvBLK8Tdx3ShuVqpHTuzkbIFIq3oE3xwaXQob0N/jEK/sk2+7ydc/y/sy6RWPB
	gf3z5ub32nAw1/qwKQq08ivGaYNNijzWyzDiJP2A17+EN58qc2tpoiOWpXE/xEaNnlvQ/pyn0qi
	L6AiE6sngK3p3kMSv4ndSLoxuoWlShV0RHkwx0LCWnf931/fTHJhWv9IjuK7pZevJP02Q5wcamC
	NElZrUtvXZNQAEgJz/2fucVhtwUaMr3g34L45pmjsTmhgE4h5sYBYJQl0A/92Gi3XOQcljD3eTM
	Fl1f8sxjpPqa4+U9RDQg3xl83fA+Zc4GOYnVgwPBMjF+VxNc7Bt35XbonMLURD9jbLr7M2T0zKk
	7+xPPkHFuXiBi3JMiTK46pfaVC0eFfk3IzxuuPAZC3mZRC7gi38WewuKZB+ZwyzsHjw==
X-Received: by 2002:a05:6214:d4e:b0:80f:517d:2647 with SMTP id 6a1803df08f44-87c2058e520mr29915986d6.22.1760677569504;
        Thu, 16 Oct 2025 22:06:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVYw/Pl2PWSDOWshIw6UGLpfvG20KYW6sJytzqvKPEHhK+XpxIoHGhrkbNj0IkO4NqzhZrew==
X-Received: by 2002:a05:6214:d4e:b0:80f:517d:2647 with SMTP id 6a1803df08f44-87c2058e520mr29915696d6.22.1760677569001;
        Thu, 16 Oct 2025 22:06:09 -0700 (PDT)
Received: from WENMLIU-LAB01.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com. [129.46.232.65])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87c0128c9d8sm57641916d6.33.2025.10.16.22.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 22:06:08 -0700 (PDT)
From: Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
Subject: [PATCH v5 0/3] media: qcom: camss: Add LeMans and Monaco camss TPG
 support
Date: Fri, 17 Oct 2025 13:06:00 +0800
Message-Id: <20251017-camss_tpg-v5-0-cafe3ad42163@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALjO8WgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyTHUUlJIzE
 vPSU3UzU4B8JSMDI1NDA0Nz3eTE3OLi+JKCdF1jI4NUI8M0A9OUZHMloPqCotS0zAqwWdGxtbU
 AQ7XEi1sAAAA=
X-Change-ID: 20251017-camss_tpg-320e21f05dc7
To: Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Wenmeng Liu <wenmeng.liu@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760677563; l=2992;
 i=wenmeng.liu@oss.qualcomm.com; s=20250925; h=from:subject:message-id;
 bh=9a/4kkHMcXDzTdUVtOV6+gPflZeZm9CcjJjD0jh9t1A=;
 b=+9t88JMrvkzztfqdsMS/kPGO+wZl/BsdyMF/jP6cP8my0tvgQN+iDHXuVEzSb4Cc06b+C6jpM
 7jwEOonwO1RBVtJB7A1NU0/FQ0rxzEjTQleCegRDGLY8O2aS5bDeqyK
X-Developer-Key: i=wenmeng.liu@oss.qualcomm.com; a=ed25519;
 pk=fQJjf9C3jGDjE1zj2kO3NQLTbQEaZObVcXAzx5WLPX0=
X-Authority-Analysis: v=2.4 cv=K88v3iWI c=1 sm=1 tr=0 ts=68f1cec4 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=ZI1NeSbMC4-MBL2ZwWIA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 6_N3jzGhNCnjOtfSNPiyqX-FuqKL60MC
X-Proofpoint-ORIG-GUID: 6_N3jzGhNCnjOtfSNPiyqX-FuqKL60MC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDAzNSBTYWx0ZWRfX9m6+ntBShIpg
 kkqKcBPtT+T99bm2m70hTm7fJ1/iUTXnywA9UrfnSipdPS12HK+J5SlmhjAXaO4diF3sL0P8JF3
 wk3j0Y8iH45DZRfOb3VZFh/BtI6PyTARAxGJMWhf70Hx/EnvnfvI1FXoIMVRROF0RmeOGEClE6L
 WwaNDSchjQS7rsCDE63XLHV/gidaIKdlOfiNgi0TJb5QRhNKn/KI16MtSEoLsphtzyhYKuoLsQ9
 R35ULwopML9VJZXLqkamaf3czAyh8cWwvw93lojyL+NaoXy3E5vsSXAADOR2SFc9PpXDRQsae17
 uOpCIcXoBTZ3OAGMZYiVAMd4zqIqHIdHvvB+d3feZoI15gEtFXm0Z9h/B7zsjw3PAYt29KTWyRK
 yWIsW0SMDkyQO8InhNGYO0a5bGljpA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 adultscore=0 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130035

This series adds driver changes to bring up the TPG interfaces 
in LeMans and Monaco.

We have tested this on LeMans EVK board and qcs8300-ride board with 
'Test Pattern Generator'. Unlike CSID TPG, this TPG can be seen as 
a combination of CSIPHY and sensor.

Tested with following commands:
- media-ctl --reset
- media-ctl -V '"msm_tpg0":0[fmt:SRGGB10/4608x2592 field:none]'
- media-ctl -V '"msm_csid0":0[fmt:SRGGB10/4608x2592 field:none]'
- media-ctl -V '"msm_vfe0_rdi0":0[fmt:SRGGB10/4608x2592 field:none]'
- media-ctl -l '"msm_tpg0":1->"msm_csid0":0[1]'
- media-ctl -l '"msm_csid0":1->"msm_vfe0_rdi0":0[1]'
- v4l2-ctl -d /dev/v4l-subdev4 -c test_pattern=9
- yavta -B capture-mplane -n 5 -f SRGGB10P -s 4608x2592 /dev/video0
  --capture=7

Changes in V5:
- Modify the commit message and change the chip names to LeMans and Monaco.
- Add the header file to resolve the compilation error.
- Remove the definition where tpg_num is 0.
- Link to v4: https://lore.kernel.org/all/20250925-camss_tpg-v4-0-d2eb099902c8@oss.qualcomm.com/

Changes in V4:
- Rebase changes
- Use GENMASK to define bit fields and avoid using tabs. Use FIELD_PREP and FIELD_GET uniformly to access bit fields.
- Link to V3: https://lore.kernel.org/all/20250822-camss_tpg-v3-0-c7833a5f10d0@quicinc.com/

Changes in V3:
- Change the payload mode string
- Change the method for setting the TPG clock rate
- Remove the TPG IRQ
- Format correction
- Remove unused variables
- Merge functions and eliminate redundancy
- Modify the register write method
- Change TPG matching method to use grp_id
- Encapsulate magic numbers as macros
- Link to V2: https://lore.kernel.org/all/20250717-lemans_tpg-v2-0-a2538659349c@quicinc.com/

Changes in V2:
- rebase tpg changes based on new versions of sa8775p and qcs8300 camss patches
- Link to V1: https://lore.kernel.org/all/20250211-sa8775p_tpg-v1-0-3f76c5f8431f@quicinc.com/

---
Wenmeng Liu (3):
      media: qcom: camss: Add common TPG support
      media: qcom: camss: Add link support for TPG
      media: qcom: camss: tpg: Add TPG support for LeMans and Monaco

 drivers/media/platform/qcom/camss/Makefile         |   2 +
 .../media/platform/qcom/camss/camss-csid-gen3.c    |  17 +
 drivers/media/platform/qcom/camss/camss-csid.c     |  43 +-
 drivers/media/platform/qcom/camss/camss-csiphy.c   |   1 +
 drivers/media/platform/qcom/camss/camss-csiphy.h   |   2 +
 drivers/media/platform/qcom/camss/camss-tpg-gen1.c | 220 +++++++
 drivers/media/platform/qcom/camss/camss-tpg.c      | 696 +++++++++++++++++++++
 drivers/media/platform/qcom/camss/camss-tpg.h      | 125 ++++
 drivers/media/platform/qcom/camss/camss.c          | 119 ++++
 drivers/media/platform/qcom/camss/camss.h          |   5 +
 10 files changed, 1216 insertions(+), 14 deletions(-)
---
base-commit: 2433b84761658ef123ae683508bc461b07c5b0f0
change-id: 20251017-camss_tpg-320e21f05dc7

Best regards,
-- 
Wenmeng <wenmeng.liu@oss.qualcomm.com>


