Return-Path: <linux-kernel+bounces-784890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2686CB34320
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 16:18:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4789D3A1186
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 14:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162A92ECE8A;
	Mon, 25 Aug 2025 14:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EBqQFEmE"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EECFA2EDD6D
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756131435; cv=none; b=AHRohzvlJ+nRURIPjyUMMoWn2AKrYkLXeXi56z+sDKI5yhm4XMVcC6Wrj87NLXNkaGomG4TPU8qe9wjw6WaYzQh2iUJZnhUfQR3vo5ItyTaZw6SoQ1X6tXVo8aTkhbxSHp40NiLZ0Qbx6Glr15h/QJef+MijsA8gFM8+8/o2TbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756131435; c=relaxed/simple;
	bh=kfjbd1frALmT1ax3tPvnTDTCNGsQG/utV3Zk0tWS9yk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Zpjd4a7x5pT4PHoiQfwgUp+U+ZnZaU4AcG3wvnTCSwljMzFvg127LQ0m1Y2PsGUf/vcO94dRCfiSZpAjfn1eLqhdrya2x78jeI2IHmenDle01caplJexDE3ajZ0uLTPYxHiV8Hl+uH7IuiR/NF5NkEEVwMAyqbx5Kge8c2k7qTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EBqQFEmE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57P8Xe4H006224
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:17:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Wu59sfweUtQOepucpDZNuv
	NpI5esikaRW2HFZthjgiI=; b=EBqQFEmEb4LFZci+yyCapE1F+ikAQ0g8qStJJM
	+2Ee3zZqTkoit9ztuq36OpNHUoQxVwWxlUFMLYlW6N+oCijlS6c3B2aVMvtMBE9E
	2tLvLHYoyJG5wg+H5UyUOvokjr6tNT6v3VMxmiwn5osb3fFzaLDlfjldr/8NM7eg
	wScnU+XlKYcn4ZyavHWCixWPaL1ENSSr+BLfe1hIRP+zFd9Kod29stCbl47RYcm2
	9wZKH3QAdHgmMc/8J02f2FSKDMhI5JQs5DqtO8yucFrKYPCmG+BWKx86n7yAiRzv
	EUwRE+iQEZFIpKCs3YN70ObiecGlnaEUI3cCrdXItHYx5aEA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5wdw828-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 14:17:11 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76e92b3dde9so3906345b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 07:17:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756131430; x=1756736230;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wu59sfweUtQOepucpDZNuvNpI5esikaRW2HFZthjgiI=;
        b=nt44gcdGr42OnX8tU+tdRxeigYMYqGlW/Jg7UTla+cShco5GXHMIJrjYfdv6gDBvz0
         eurMvuOLZSlnDNb49mGvSiCYKZED17ttDIh4FpiNPCC8C/WaNmYynyGv+SiYgfzcOtw/
         rmNzMHtkqMGIAIa27qA1pwMeulKG0RQmzZeqeQ8ww9oR2heKnW1nu/BeYGkit2fwpwM2
         8zPsHstHX4Gdmcc4M7LKYfQOIq9Cl9C/wQ2NfJlQFozTdGGToPMgQHk8IsTOlVi841XD
         34TSwiixZLcLJ2ulnV2D5uDycs55TqPOBhP+1p+jK+IzsjBnRfhS0RysaM0CRAMH9klq
         yxVQ==
X-Forwarded-Encrypted: i=1; AJvYcCU11rVNWpghJRrAn85Mv4R/JSIhI1SFOEFny95fihdBUQgtN3OY0P1xgF1+CxuyxS4J12t8fAAtbDXb1m4=@vger.kernel.org
X-Gm-Message-State: AOJu0YykSDQ18IZyPCCqiDoVlEqJtQxd5ELw49pVpeZfC8SsQyCr0T7Y
	e6Blnng21rWTqfT/iYESWXr0a/Eaf2p6RFxYwngidM/cTP/+QgpY1KnvqK2GLUMmwGA9cLJLwHb
	VChf/Kf7MJPZsvlgizhWJL70G8bJO0zoKJrhN+p3uc8nPmY3RS5AIkMfrFK4W2Wg6dPE=
X-Gm-Gg: ASbGncsFhDTA98RprC4/pKWaO5Sh9pDUWvBff0GsFtEUsnWgzN+qvoToMK+Pea79O/c
	8WcxhIEocp7mePLszUrMHnfUcwOEncPAR1LdrzhWMIn2AXwsTSaheturiu3N2+lNed4M7XncDyY
	68S9TdMdjcbvq1qK8LV6RpY2QR57+yqdkTqDY6qvk1O3PJrahx9zSAKuhjLsUXLj17/z+b4/yHD
	ehZiNAJVFffOhbszcuDGsAUaru4I2fYG/RpSKyt9mpfydDyXKOE3sV+FXTiOteDB/lj+o5iZqKl
	gkZWkuhI9wu/hWAxgnHPKfolPUepuFQ2WASknchdAYXwixjYEotJdkO1PEqkEq99ospOO1s=
X-Received: by 2002:a05:6a21:99aa:b0:21a:ecf5:ea71 with SMTP id adf61e73a8af0-24340b5b4cemr18097569637.15.1756131429868;
        Mon, 25 Aug 2025 07:17:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOPO2PNUo52ZuG+6CW22LxjvJm4xtZ8v2rB+Z73p7mL0+2JIJAvhHlUHydOCE2L8s62+uKGg==
X-Received: by 2002:a05:6a21:99aa:b0:21a:ecf5:ea71 with SMTP id adf61e73a8af0-24340b5b4cemr18097509637.15.1756131429212;
        Mon, 25 Aug 2025 07:17:09 -0700 (PDT)
Received: from cse-cd01-lnx.ap.qualcomm.com ([114.94.8.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401eb20dsm7672339b3a.79.2025.08.25.07.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 07:17:08 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Subject: [PATCH v3 00/38] drm/msm/dp: Add MST support for MSM chipsets
Date: Mon, 25 Aug 2025 22:15:46 +0800
Message-Id: <20250825-msm-dp-mst-v3-0-01faacfcdedd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABtwrGgC/22Q22rDMBBEf8XouQq6WLZsSsl/lBCk1ToR1JdYj
 mkJ/veulVfrQWIW9mhmXizhHDGxtnixGdeY4jiQ0B8Fg7sbbshjIM2UUEZUouF96nmY6Fk4hAC
 qq2RwiIwWphm7+Jth35e3nvHxJObyHrIeU3KZ2RafGWmF5fcpcFp1sIwzXxUXvO5KlFiX0jl9H
 lM6PZ7uB8a+P9H1tf91QJKGjF3J2NXHIcThlvhaEQxraTwdo211DPMuId8ncWkLL03ZGCGltQA
 NeldrBcp4oXXoamc0AOhSdmyPeI+JTP/l+laVMx41lUM5UwbbCOWUDmeqBeIAuwV22bbtH3EiI
 vOJAQAA
X-Change-ID: 20250609-msm-dp-mst-cddc2f61daee
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756131418; l=8527;
 i=yongxing.mou@oss.qualcomm.com; s=20241121; h=from:subject:message-id;
 bh=kfjbd1frALmT1ax3tPvnTDTCNGsQG/utV3Zk0tWS9yk=;
 b=pq/EJ6TWfDHS3WCZCgRE8W3NSKY5/yb6xpdK0+tGEID8XzYMbOkrrSgiL1+314NLYFEBYDbna
 kkd04rYvOpoA99SBZ8b/dnTqXd9AmunH74k3s8/oK2attZF3ijBf/M6
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=zeCnFRUqtOQMeFvdwex2M5o0Yf67UHYfwCyBRQ3kFbU=
X-Proofpoint-GUID: Sg_Un5coEs2rK9r1HF4taGlgE7LdVrUj
X-Proofpoint-ORIG-GUID: Sg_Un5coEs2rK9r1HF4taGlgE7LdVrUj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX/tQi/tfThfaj
 N5PIOctCVlpCqBSN7bAj9LTboOlYcoLX9//QwZIgf/nPG1z7xpMZtJBmJEa16PWjdXCZHOrGBkq
 fHKzfmDFBOZbL97U61g51ZNX1CNL6D1673QhQy+ztQNp/bL9+AKP83JfjiVlAsuwNpAO5n0WuAX
 rdy7Kc51O6gqRButqMXnOLXyy9PqPUrYqwZQkYPOkqvw2j9ZbAjOcVBmOmk/b7Fr3eq4/i/DHzc
 UhiBE+eO0MkCaHxZ5rbyjOUTf0eIF/24RmdiPailtLwM6x9BNhfaR3P1NqWTy5eHUGGIZlur8bp
 lYvbhIDI4NsUII3M5mzfw/bQBkbHvVXn1xHWhLVa7ZLlGZmDmtlPMPg89CC6gRmYMn5oPBhqzy3
 L/Rc9dSn
X-Authority-Analysis: v=2.4 cv=BJazrEQG c=1 sm=1 tr=0 ts=68ac7067 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Uz3yg00KUFJ2y2WijEJ4bw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=tVI0ZWmoAAAA:8 a=pGLkceISAAAA:8
 a=l6kI6A2B7Aiyxt7-y2QA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
 a=Vxmtnl_E_bksehYqCbjh:22 a=TjNXssC_j7lpFel5tvFf:22 a=-BPWgnxRz2uhmvdm1NTO:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_06,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230033

Add support for Multi-stream transport for MSM chipsets that allow
a single instance of DP controller to send multiple streams.

This series has been validated on sa8775p ride platform using multiple
MST dongles and also daisy chain method on both DP0 and DP1 upto 1080P.

With 4x4K monitors, due to lack of layer mixers that combination will not
work but this can be supported as well after some rework on the DPU side.

In addition, SST was re-validated with all these changes to ensure there
were no regressions.

This patch series was made on top of:

[1] : https://patchwork.freedesktop.org/series/151522/ (v2 to fix up HPD)

Bindings for the pixel clock for additional stream is available at :

[2] : https://patchwork.freedesktop.org/series/152718/

Overall, the patch series has been organized in the following way:

1) First set are a couple of fixes made while debugging MST but applicable
to SST as well so go ahead of everything else
2) Prepare the DP driver to get ready to handle multiple streams. This is the bulk
of the work as current DP driver design had to be adjusted to make this happen.
3) Finally, new files to handle MST related operations

Validation was done on the latest linux-next on top of above changes and
both FB console and weston compositors were validated with these changes.

To: Rob Clark <robin.clark@oss.qualcomm.com>
To: Dmitry Baryshkov <lumag@kernel.org>
To: Abhinav Kumar <abhinav.kumar@linux.dev>
To: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
To: Sean Paul <sean@poorly.run>
To: Marijn Suijten <marijn.suijten@somainline.org>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
Changes in v3: Fixed review comments from Dmitry
- Fixed lots of comments from series V1/V2.
- Rebased onto next-20250808.
- Rebased onto Jessica's HPD-refactor branch.
- Fixed formatting issues in commit messages under changes.
- Removed unnecessary one-line wrappers.
- Relocated MST-related .atomic_check() calls to their appropriate positions.
- Removed the logic related to slot checking in .mode_valid().
- Link to v2: https://lore.kernel.org/r/20250609-msm-dp-mst-v2-0-a54d8902a23d@quicinc.com

Changes in v2: Fixed review comments from Dmitry
- Rebase on top of next-20250606
- Add all 4 streams pixel clks support and MST2/MST3 Link clk support
- Address the formatting issues mentioned in the review comments
- Drop the cache of msm_dp_panel->drm_edid cached
- Remove the one-line wrapper funtion and redundant conditional check
- Fixed the commit messgae descriptions of some patches
- Reordered the patches and renamed some functions and variables
- Link to v1: https://lore.kernel.org/all/20241205-dp_mst-v1-0-f
8618d42a99a@quicinc.com/

---
Abhinav Kumar (30):
      drm/msm/dp: remove dp_display's dp_mode and use dp_panel's instead
      drm/msm/dp: break up dp_display_enable into two parts
      drm/msm/dp: re-arrange dp_display_disable() into functional parts
      drm/msm/dp: allow dp_ctrl stream APIs to use any panel passed to it
      drm/msm/dp: split dp_ctrl_off() into stream and link parts
      drm/msm/dp: make bridge helpers use dp_display to allow re-use
      drm/msm/dp: separate dp_display_prepare() into its own API
      drm/msm/dp: introduce max_streams for DP controller MST support
      drm/msm/dp: introduce stream_id for each DP panel
      drm/msm/dp: Add support for programming p1/p2/p3 register blocks
      drm/msm/dp: use stream_id to change offsets in dp_catalog
      drm/msm/dp: add support to send ACT packets for MST
      drm/msm/dp: Add support to enable MST in mainlink control
      drm/msm/dp: no need to update tu calculation for mst
      drm/msm/dp: Add support for MST channel slot allocation
      drm/msm/dp: Add support for sending VCPF packets in DP controller
      drm/msm/dp: Always program MST_FIFO_CONSTANT_FILL for MST use cases
      drm/msm/dp: abstract out the dp_display stream helpers to accept a panel
      drm/msm/dp: replace power_on with active_stream_cnt for dp_display
      drm/msm/dp: Mark the SST bridge disconnected when mst is active
      drm/msm/dp: add an API to initialize MST on sink side
      drm/msm/dp: add dp_display_get_panel() to initialize DP panel
      drm/msm/dp: add dp_mst_drm to manage DP MST bridge operations
      drm/msm/dp: add connector abstraction for DP MST
      drm/msm/dp: add HPD callback for dp MST
      drm/msm: add support for MST non-blocking commits
      drm/msm: initialize DRM MST encoders for DP controllers
      drm/msm/dp: initialize dp_mst module for each DP MST controller
      drm/msm/dpu: use msm_dp_get_mst_intf_id() to get the intf id
      drm/msm/dp: fix the intf_type of MST interfaces

Yongxing Mou (8):
      drm/msm/dp: remove cached drm_edid from panel
      drm/msm/dp: splite msm_dp_ctrl_config_ctrl() into link parts and stream parts
      drm/msm/dp: extract MISC1_MISC0 configuration into a separate function
      drm/msm/dp: move the pixel clock control to its own API
      drm/msm/dp: Add catalog support for 3rd/4th stream MST
      drm/msm/dp: add MST atomic check to msm_atomic_check()
      drm/msm/dp: propagate MST state changes to dp mst module
      drm/msm/dp: Add MST stream support for SA8775P DP controller 0 and 1

 drivers/gpu/drm/msm/Makefile                       |   3 +-
 .../drm/msm/disp/dpu1/catalog/dpu_8_0_sc8280xp.h   |   6 +-
 .../drm/msm/disp/dpu1/catalog/dpu_8_4_sa8775p.h    |  12 +-
 .../drm/msm/disp/dpu1/catalog/dpu_9_2_x1e80100.h   |   6 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c        |  51 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.h        |   2 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |  29 +-
 drivers/gpu/drm/msm/dp/dp_audio.c                  |   2 +-
 drivers/gpu/drm/msm/dp/dp_ctrl.c                   | 664 +++++++++++---
 drivers/gpu/drm/msm/dp/dp_ctrl.h                   |  23 +-
 drivers/gpu/drm/msm/dp/dp_display.c                | 569 ++++++++----
 drivers/gpu/drm/msm/dp/dp_display.h                |  36 +-
 drivers/gpu/drm/msm/dp/dp_drm.c                    |  51 +-
 drivers/gpu/drm/msm/dp/dp_drm.h                    |  12 -
 drivers/gpu/drm/msm/dp/dp_mst_drm.c                | 994 +++++++++++++++++++++
 drivers/gpu/drm/msm/dp/dp_mst_drm.h                |  90 ++
 drivers/gpu/drm/msm/dp/dp_panel.c                  | 295 +++---
 drivers/gpu/drm/msm/dp/dp_panel.h                  |  27 +-
 drivers/gpu/drm/msm/dp/dp_reg.h                    |  46 +-
 drivers/gpu/drm/msm/msm_atomic.c                   |  10 +-
 drivers/gpu/drm/msm/msm_drv.h                      |  19 +
 drivers/gpu/drm/msm/msm_kms.c                      |   2 +
 22 files changed, 2529 insertions(+), 420 deletions(-)
---
base-commit: b1549501188cc9eba732c25b033df7a53ccc341f
change-id: 20250609-msm-dp-mst-cddc2f61daee
prerequisite-message-id: <20250808-hpd-refactor-v2-0-7f4e1e741aa3@oss.qualcomm.com>
prerequisite-patch-id: 0fc90e557ae4bb852757444b92af71ebb3c0698f
prerequisite-patch-id: a58ebaf429385c622869c83e83ce7ffdfe9ea27e
prerequisite-patch-id: 9840ae12755ebc1528d6719b058b86ce8ba3e5e8
prerequisite-patch-id: 8d5d7ac0302a333ecaf01d420f067d2db7195783
prerequisite-patch-id: 49532adadff58e9069a96b37f26017847fb29a3d
prerequisite-patch-id: 3d58007342ba985e1c7f0f85ebc5da29c8b67b5c
prerequisite-patch-id: 46274f99ffb986e53a48d6802e2fc05beb7b7b01
prerequisite-patch-id: 67536f5bceaf6e9aae18cb8e95874b71ef22dee4
prerequisite-patch-id: f5fb952fb63bce96161cb56db065927fa0a91e87
prerequisite-patch-id: 981c763c51c815adda57909ffe567cfa1069d5f5
prerequisite-patch-id: 3f738fbbf3634482eaf46e5bd5b83c0cf2ce0fe1
prerequisite-patch-id: 1e250d144e7bad58e2f1ea33f74ceea8e26335e0
prerequisite-message-id: <20250815-dp_mst_bindings-v6-0-e715bbbb5386@oss.qualcomm.com>
prerequisite-patch-id: ffeeb0739a4b3d310912f4bb6c0bd17802818879
prerequisite-patch-id: f0f92109d1bfffa6a1142f2aaecbd72a29b858c0
prerequisite-patch-id: 9cabb6be69b17e8580a2cffc7aa2709106cc1adf
prerequisite-patch-id: a389a2e4eca44bf62bb2c861c96596368be7a021
prerequisite-patch-id: 4f02ab9314f95984ab7dc9b852ba4d6c676746a7
prerequisite-patch-id: 62d643df7c88d8db2279def1e4b63a605e9145c0

Best regards,
-- 
Yongxing Mou <yongxing.mou@oss.qualcomm.com>


