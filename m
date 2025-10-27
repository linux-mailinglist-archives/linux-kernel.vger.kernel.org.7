Return-Path: <linux-kernel+bounces-871519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FB5C0D840
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:29:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD73C189197C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5753019D0;
	Mon, 27 Oct 2025 12:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XnBE/8qM"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FF7301484
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761568027; cv=none; b=dtYlQoOoPe9wDHyLntEDYGV9x7GwSzi/YYKaGHrpYw74Nxw2DPzTdkIpoTgAbCWz6YTPOJlTJbYHtShwihNOicsFU1icOzhBA49MLl05qS0Lth8O1qt6NnQRnZm/Isn4g9xr0O6feLE9DFnHeGz6erIG0MsptI54jdjYke9afwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761568027; c=relaxed/simple;
	bh=p4aWbdd50eAVtJKt/uKdmS5uIMnunOHZbwNtVYNRiI0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hqFiBh5snGaSCAmCKIpilj8TNTwgXwQAOj9rqd2ILw1vITPsH9pPKQC7bmpYIf8pOVaJTbl77lVbr0Xgg+SKTztd0hZ/3yPb8fDyJZMhQd7HxrkJnkZDlrrxoQEN5lDatvzrXfQFDn2l44Akjdq/OmQXebtIS5w7yKO7UIObEUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XnBE/8qM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59R8e1361007544
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:27:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=vI1iYCC4ve0sLABc7uHyTN
	dTtnKBM3f3GEMDPZMlmD0=; b=XnBE/8qMZs2Tfqd5yF+7dO/dPr9vGz5bNTWTZ4
	lNDsFH7XcfMOZT/7dDsS8eXPUXRWI3W/zxQjDWovbBoX6xCkNVVXcstAAmAdOFgK
	y4/XO52pHf+N8zs5oi8U0+BLf8QPrtXIiHoC1bJVoKJeurWQVugaYXbxTjgAvedj
	whVFfZ/Cr0r9ZrlCVK1oQLWqXACwz9e82mni6dkBXIlhElZd7x2CbtJLHhbO4Ibn
	HrmvLzK1Jih+q/FbNu5s+FdP9+raya6YtoCeGGxbSSvl2uxiTqQVVPn6Vb0zf3kS
	Z8dSU5d8OUNhEtqIW3zExPXuEiJp4VOgksv9Jxx4IUtSvq3w==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a0p4g4gg6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:27:04 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4ecf9548410so30759511cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 05:27:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761568023; x=1762172823;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vI1iYCC4ve0sLABc7uHyTNdTtnKBM3f3GEMDPZMlmD0=;
        b=rAvrsArtE4VWHWP7wYDT0nHtr69jEq6l/IeRW+Ga5y1VVyOiKJHfH0Jst9gv6CxO4G
         8Q4EJSwn3pQ8aKN5wZ3JI7VnvRUjVEKcc4fy/e6FPGhUsWhbqzR3lPgbfCufsDy7+Kzt
         pkwFVHQt4xguG0F85Rt84i1veZ7Jylt00qSzltfgJibLpaaw4pyRB8lknVhBzK5XNyKX
         VI9AzdR/yNv8uPBUwubc8nrrAzz/nusmYNhejj/gtxIdmKOOgJ/DIZysQSp8044GWh5i
         NgRLEWtrVPFQXgP084IxtgIHGfldv8T6p3h4qnGW8spFCYEOAEA4cHP3q5FNXnKQZHhp
         2Rlg==
X-Forwarded-Encrypted: i=1; AJvYcCXSNm1lfSGL0QyVR4TDamA8Eunhpi1ZojWxHo7hAfjElzhidgwfUUV8mpuExp9SLCg0yEOOC+67YSM1VJg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxqigsH3CdHpejeh4BkFIclN9EhlMUl2kiiaX8mkiBZ47izWgI
	zehfQNoqEqAZUrBJ+ym6EQW1cXB5GGsJqtH6U2xaxu7sd7nxWLh+6O5C/6u6I+glldCQI8W8DUX
	2DwXiEYoBkSrxHB1FbztU1EO8vMdooyFLDilplOPv9eFDaR/ijsVP4oeTKQgrYXY4DS8=
X-Gm-Gg: ASbGncsTx/rL62Qsu5bOta5d+XnwCY8nLDVo91CKNjTcoYh9nUVMOqKQmvoAUZ0uc+r
	DmmiSU0bL5BYJgiQCgT45VTY40tWDFU58CJmhWUWU3OiKhIC2A4Qvvn5v5Sp1LSI8WGUBdnfy8p
	bvzMF5CKeZtGUIr/GxXQTCAk+gW8Io4NpgNISdLOrqatiyqlola8d0h4346XR3FqDs+YPY0xCkS
	Bkuc8Jb/eX1BKWX4IKq2g2aaOPBDlgN8pL4mDIDZ3Jxg2gPmxhDnI8Ou2qFLLqJ2lNu6iESCNkz
	J4MR3/tryOQGNjhanGiiTnnbjQxEEna+lzZGOHU0T9pKYWX84KOq9h2IzxRb2bJbBjogRRK5Qc0
	u5jxWaIGOuaxtHpX/84LzbtxSumSqQ05YA67J1fp85CxeYsNpvjTTsosIz1YCDmEA7CgGf+IlI4
	7BALWkqh9GRwnV
X-Received: by 2002:a05:622a:1827:b0:4ec:f153:356b with SMTP id d75a77b69052e-4ecf15346f8mr61419151cf.11.1761568023453;
        Mon, 27 Oct 2025 05:27:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFjpGGobHSfTTedlviPN3oKKeNzeDOmc9TtNO2F2aeHe6VH7S51q/EPz1AmSgCF8HJOz98cA==
X-Received: by 2002:a05:622a:1827:b0:4ec:f153:356b with SMTP id d75a77b69052e-4ecf15346f8mr61418701cf.11.1761568022969;
        Mon, 27 Oct 2025 05:27:02 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59301f83cb5sm2253474e87.102.2025.10.27.05.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 05:27:02 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v5 0/6] media: iris: port support for Qualcomm SC7280
Date: Mon, 27 Oct 2025 14:26:58 +0200
Message-Id: <20251027-iris-sc7280-v5-0-5eeab5670e4b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABJl/2gC/3XM0QrCIBTG8VcZXuc46pxbV71HdOH0WEJlaY1i7
 N1zg2CDuvngf+D8BpIwekxkWwwkYu+TD9ccclMQc9LXI1JvcxMOXDKAmvroE01G8Qaos51qleO
 isQ3JH7eIzr9mbX/IffLpEeJ7xns2Xb9Os3J6RoFadCCh0xKZ24WUyvtTn024XMo8ZOJ6viAYX
 xN8IqTQTFcgayP+EGJJiDUhMuFEZ7BTSnMJf4hqSbRrosoEYm1NHlQV+0GM4/gB3LuYUHYBAAA
 =
X-Change-ID: 20251006-iris-sc7280-fdb797f238d8
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4523;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=p4aWbdd50eAVtJKt/uKdmS5uIMnunOHZbwNtVYNRiI0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBo/2UUxaQhREj34mGUSLxLWizps8NuGhM6hNRow
 0hmb4yqBSKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaP9lFAAKCRCLPIo+Aiko
 1cmJB/9uirBCm7GcZ+2bg5PQt+Odwe7DFmEqOETisEGeLZ6TxKU5wMsKzF8d7TOyaJjlHo4qElP
 IimSbQ1+tGvAC1Fkgd7yLFAeGgVFOi/BcZDXTCjQ4o5vZ9qO5CvdzT657tb5uZpf8fo2+E7RfmG
 0wqgioASJyjPFC5Wlv3rouGE4lXFShlgb2MdYXN6eunfxW7J1C6OYuA1Lj9JlpzfbpKqM22R9Vg
 DJuz7+OD1iXAiixZE5yeXnC+oMAUNNg/XdH/3ahdZwP2rxEvCbwbFnewiAaffe9myLGyZTintJF
 bSlDaYor3I1C8FLhVAa7pE+Ktv3tIJVw90I03RcRjT+J3DGU
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: 285FOXqtQe3mLtvwt8vVzd9h1Ji6c3gW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDExNSBTYWx0ZWRfX/CgKq2Zm57cV
 24eCj5Vyd/UeZhxDgrEC+v1QA4gYV2YS4zwleKZovVh2LBvwVt9MnDx2TNfIjhOPjSPTNP6X034
 likPBGEieDQm9Sz5OhBra0400tj7ARXgghnNp60ATvriMW+TfCUcxzw0sHLpizETqiPqAiAckY1
 gNb6am2zv9Mf0lzfZpxTbU5dLwerDAoRj9ce3sMMgYxBZI1FOCgHOnNyzwgF+fj4d1WQzR5TbPW
 GGRqrPPNdQr8SuNSBgk1ZZ/mxQ9obFAH0g5FHxqC3GqhWd0zqZQx1j0w3+bUHy4XfD+QsAOwHKs
 2QWhy4/jxS1huTX1R4W9iMwBbZ+lgdLrus36gMFya+hEqPEViOuKI+N0t9cLgMZZYP57m3K0zQf
 UyhwE0Fn22l6AprCS5XrZitRrL+Grg==
X-Authority-Analysis: v=2.4 cv=L9YQguT8 c=1 sm=1 tr=0 ts=68ff6518 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=pcU2kZSltczg-j7lHUUA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: 285FOXqtQe3mLtvwt8vVzd9h1Ji6c3gW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270115

Port Support for the Qualcomm SC7280 aka QCM6490 aka QCS6490 platform
from the existing venus driver to the newer Iris driver. The firmware on
this platform uses the older, gen1 HFI, which puts it close to SM8250
from both the hardware and interface point of view.

Test results:

$ ./fluster.py r -d GStreamer-H.264-V4L2-Gst1.0 -ts JVT-AVC_V1
...
Ran 76/135 tests successfully               in 16.903 secs

$ ./fluster.py r -d GStreamer-H.265-V4L2-Gst1.0 -ts JCT-VC-HEVC_V1 -j 1

Only WPP_E_ericsson_MAIN_2 succeeds, this needs to be investigated
later. For other tests I'm getting:

qcom-iris aa00000.video-codec: session error for command: db800000, event id:1009, session id:4bd48000

After removing several test vectors and running single-threaded:
$ ./fluster.py r -d GStreamer-VP9-V4L2-Gst1.0 -ts VP9-TEST-VECTORS -j 1
Ran 217/292 tests successfully               in 136.210 secs

Disabled tests:

            "name": "vp90-2-18-resize.ivf",
            "name": "vp90-2-21-resize_inter_1920x1080_5_1-2.webm",
            "name": "vp90-2-21-resize_inter_1920x1080_5_3-4.webm",
            "name": "vp90-2-21-resize_inter_1920x1080_7_1-2.webm",
            "name": "vp90-2-21-resize_inter_1920x1080_7_3-4.webm",
            "name": "vp90-2-21-resize_inter_320x180_5_1-2.webm",
            "name": "vp90-2-21-resize_inter_320x180_5_3-4.webm",
            "name": "vp90-2-21-resize_inter_320x180_7_1-2.webm",
            "name": "vp90-2-21-resize_inter_320x180_7_3-4.webm",
            "name": "vp90-2-21-resize_inter_640x360_5_1-2.webm",
            "name": "vp90-2-21-resize_inter_640x360_5_3-4.webm",
            "name": "vp90-2-21-resize_inter_640x360_7_1-2.webm",
            "name": "vp90-2-21-resize_inter_640x360_7_3-4.webm",

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Changes in v5:
- Fix typo in the commit message (Dikshita)
- Dropped .min field for PIPE capability (Dikshita)
- Corrected max_core_mbps for SC7280 (Dikshita)
- Link to v4: https://lore.kernel.org/r/20251019-iris-sc7280-v4-0-ee6dcee6e741@oss.qualcomm.com

Changes in v4:
- Dropped the inst_fw_caps rework, it will be sent later after rework.
- Dropped .min value for PIPE capability, set it in the same code path
  (Vikash)
- Adjusted clock index names, clock names and num_vpp_pipes for SC7280
  (Dikshita)
- Squashed the SC7280-specific codepaths into the iris_vpu2_ops
  (Konrad)
- Dropped the register moving patch, it is now unused.
- Link to v3: https://lore.kernel.org/r/20251013-iris-sc7280-v3-0-f3bceb77a250@oss.qualcomm.com

Changes in v3:
- Included the header file for the SC7280 platform (LKP)
- Link to v2: https://lore.kernel.org/r/20251012-iris-sc7280-v2-0-d53a1a4056c3@oss.qualcomm.com

Changes in v2:
- Expanded commit messages to explain some of the changes (Konrad).
- Moved platform_inst_cap_qcs8300 back to the header (Dikshita) and
  added guarding ifdefs to the haders.
- Merged SC7280-specific ops into the common implementations (Konrad).
- Split SC7280-specific config bits to a separate header (following the
  Gen2 split).
- Link to v1: https://lore.kernel.org/r/20251008-iris-sc7280-v1-0-def050ba5e1f@oss.qualcomm.com

---
Dmitry Baryshkov (6):
      media: iris: turn platform caps into constants
      media: iris: turn platform data into constants
      media: iris: stop encoding PIPE value into fw_caps
      media: iris: remove duplication between generic gen2 data and qcs8300
      media: iris: rename sm8250 platform file to gen1
      media: iris: enable support for SC7280 platform

 drivers/media/platform/qcom/iris/Makefile          |   2 +-
 drivers/media/platform/qcom/iris/iris_ctrls.c      |  18 +-
 .../platform/qcom/iris/iris_platform_common.h      |  18 +-
 ...iris_platform_sm8250.c => iris_platform_gen1.c} |  63 ++-
 .../media/platform/qcom/iris/iris_platform_gen2.c  |  25 +-
 .../platform/qcom/iris/iris_platform_qcs8300.h     | 534 +--------------------
 .../platform/qcom/iris/iris_platform_sc7280.h      |  27 ++
 drivers/media/platform/qcom/iris/iris_probe.c      |   4 +
 drivers/media/platform/qcom/iris/iris_resources.c  |   2 +-
 drivers/media/platform/qcom/iris/iris_vpu2.c       |   6 +
 drivers/media/platform/qcom/iris/iris_vpu_common.c |  34 +-
 11 files changed, 161 insertions(+), 572 deletions(-)
---
base-commit: fe45352cd106ae41b5ad3f0066c2e54dbb2dfd70
change-id: 20251006-iris-sc7280-fdb797f238d8

Best regards,
-- 
With best wishes
Dmitry


