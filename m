Return-Path: <linux-kernel+bounces-835305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DFABA6AF5
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 10:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21330178085
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 08:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3C32BE7D2;
	Sun, 28 Sep 2025 08:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IMqOPF2R"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D5E221554
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 08:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759047900; cv=none; b=LRWVYjdr87oPVmpmdpyLCuZJOoV4X93xKs0QFg9dgT9haMVSR1DMpWz/Ca1fRoJgrhaq9Ybu5hrgmSujP2a56hYbHDrKk8ULW3z77nS8VWfvyqAEyFSWJn7isOrPvHtXM36vpu11YkyBm2FZd6cWAqx+sjj2vULTubffs+1d9is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759047900; c=relaxed/simple;
	bh=wXdpgIK2nMReHeFFkBUwQqE/S6v5i1Ns3S0QQzaiDpU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=McD4Lzo/t9f5ONQ0h1CRHtyXG82BF0Z75lrg5xf5550iHzIAb9Li5co5cSI9xE31cxI/G1jYpha7502dM4NFWcQw2adUt1fTC4TJyDfuB5iC/gNmvROp3PVSA6nDNGJBO3Q8zaPGt4mD7fmHp/B9D6ZcQXC9NV6b9s9tdnmL9Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IMqOPF2R; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58S4NOm2019182
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 08:24:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=rc2O4wz2Xp3rHoz8/mUbsM
	fKLduyX74HJKpJIAxeyFQ=; b=IMqOPF2RwTNjYzv3tzCtFIDfj53rMbYzw9zi5a
	Y9LeTo/S+tjjGF9oJRxXAfKeFY3aIlPfVF7ujyjbB4MuT9rzcb703ByiNhpuxby1
	qY0pQRVdJB2gbPUSLPeC/V20uBZlwzoVbN2DgFnVxwXKYzHQnBqoXB+3wj89AXTv
	T5iQOHTFezAh18vkMe3bQuChogXu+EPxkSeoMcBmKrv1gVIRYH6ojpNWd/7URQAt
	HHBtgI5Qh0P598ZSc0tiu+zecOUipf5VdRGswtuO7JomOBiXqVek9SRrPBZ1H2MM
	5uJMjr/0yRfOhNGRl7NkImgXclV789e+a33pyEW5mTgSz5IQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e78ftfha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 08:24:56 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4df60ea7a1bso15991371cf.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 Sep 2025 01:24:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759047896; x=1759652696;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rc2O4wz2Xp3rHoz8/mUbsMfKLduyX74HJKpJIAxeyFQ=;
        b=Kt5k/9XU+mEvQh/v4E+rcRo+D0faPNq7HFiUYxEvgukvPi6GH7lSmhwZvp6frGTjD0
         +4dcH1tpg6/CBEW6eBV+8ocGNs3S0yHOXVsrSB7EFApUrklB6n+4RQwktzYcyybjizWO
         ySGMRcQpeuoQe74083O0U5BWY5jh+fQDs+QyPy/AT3ETq+a4tjuXjnbbFST9/j0KKUnp
         SvbkMTsCH76Dc57QH+PGd+f5ZVCEbNtkS4L0Dly9QIr4w6TDuVFVafMB00CsfW5zvhav
         DP1nmaG0NbjZA4Q0dJbdhhbb9rUOUZQfrhh3aK1H+ell6b8uACHbufeK5e/qWzrpSIPB
         e7zw==
X-Forwarded-Encrypted: i=1; AJvYcCXVe4TcNbAZcrA2Rr6h73qOFDiqxUaY3d04SKdk6TdcheXZ6u51jEubhlvSUUbwBvdd8xcxuK8GGWCvvqI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2Y8cor/t7XsA6EDnpyrla0R9k5jKNuRKd975c57JOkm4dVZ/a
	K03Nfd7PDHTNN7Ri5JSSy6Y/Byk4RfqAUrub65+R4PXRfNJkIQHCvGnhbKeI5NAaa3v1O6qZtUJ
	WwP9y7I/iq4wwSvFRWQaw/0FZ8/fcjzrDMbQOxfPcDJbhVk9u13z0w1lne/ouI3ehdwk=
X-Gm-Gg: ASbGncsfshN/zl37HjJh9ok+veQGd1j4jSlC+XTuxES2YQTxMfBBKgzeTkF1WgLO9DT
	lr4HHuqd6j2kbzML4i1NVv2ABj3LPckdGntcgHqMGQv0Kkb6KMNPdAlI7epdouRI3eHRgodlhfv
	7+KI6NUNfHHb/VVsA8HrUY/A3NaGoQeeiY8dQT57x7G2JS0jKveuNCwxf7bpqjzgm+zWFk2/nb1
	jA1Q0Jbx8BzVNaPcWxq/9CNjcxB8FdHRHwLIWEb6a09hcIJnrOui8anuMA7D9XGyCuzr7oj465+
	0UUi31tIzqTh1JIL4RlsbqhRTLCk84YhyBD86hyThLCUXdMWM1JOqMNqAFHae2cqMZP13lYG7NR
	TJg73v2rXcklXvJLZd964qCEYPKJPvyDFyUqBfYizz7wh1cJdi8yf
X-Received: by 2002:a05:622a:19a3:b0:4df:194:b46d with SMTP id d75a77b69052e-4df0194c12cmr55268831cf.80.1759047895948;
        Sun, 28 Sep 2025 01:24:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSQGqS4aJ7VDAivVQk/ANpuwQy7ctS7IE9D3fgBdrHjHXtkW+JEen25AcKMFhLLPIqmo1upQ==
X-Received: by 2002:a05:622a:19a3:b0:4df:194:b46d with SMTP id d75a77b69052e-4df0194c12cmr55268701cf.80.1759047895487;
        Sun, 28 Sep 2025 01:24:55 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-583166561c0sm3244298e87.81.2025.09.28.01.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Sep 2025 01:24:53 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v2 0/9] drm/connector: hdmi: limit infoframes per driver
 capabilities, second approach
Date: Sun, 28 Sep 2025 11:24:45 +0300
Message-Id: <20250928-limit-infoframes-2-v2-0-6f8f5fd04214@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM3w2GgC/32NQQqDMBBFryKz7kiSEiVd9R7FRdSxDhjTZqy0i
 Hdv6gG6+fA+/Pc3EEpMApdig0QrC8c5gzkV0I1+vhNynxmMMlY5U+PEgRfkeYhD8oEEDVatO5N
 1jmrnIQ8fiQZ+H9Jbk3lkWWL6HB+r/rV/datGhZWrrdZtr6xqr1GkfL781MUQyhzQ7Pv+BWNgR
 Ue7AAAA
X-Change-ID: 20250927-limit-infoframes-2-6b93e599e79a
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Liu Ying <victor.liu@nxp.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Sandy Huang <hjc@rock-chips.com>,
        =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Andy Yan <andy.yan@rock-chips.com>,
        Samuel Holland <samuel@sholland.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2537;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=wXdpgIK2nMReHeFFkBUwQqE/S6v5i1Ns3S0QQzaiDpU=;
 b=owEBbAGT/pANAwAKAYs8ij4CKSjVAcsmYgBo2PDTB73mP/OiC/2SDbHHGonN3evfKMNBf+mFV
 TAqz55+BLGJATIEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaNjw0wAKCRCLPIo+Aiko
 1QGaB/dCkhCFXM3rS/LZOxNFSLK33p0eqjXUwRLj/k1HSm4nPT5ACqB10fJ3tODSDVscNubP0oR
 jfmyJiJzo6t6DoZD77G8Nj64HnQj5ie1loe2Gq8taQC/i6+qO0ReHUV68PcRZJ4/RjIU3SFWYGr
 B0zT0V5KzHabbu+gztU9ddfmCS5QCau8INJXipea8RT1wLTnGNAWjHjycLW4akzsWGYMGmTD3dy
 eYpOMrWIfTBaRqxQh18GUkTypkJLT/cx0JwTR2Tg040mVGp2fCpVCbTwweZgCSWyuuaRHRVeK52
 pmZkVNSrt+Wnj6FEnoqFtN3ELK6yNEwAzYWXHwb2GyWEDPE=
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=DZAaa/tW c=1 sm=1 tr=0 ts=68d8f0d8 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=BiG78YgtQv3mHEaFN1cA:9
 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAyMiBTYWx0ZWRfX9bKbOXi9yfME
 bEMUk797lqsvIut6UEFqCmbt+08i+TCt5WJPznLx5C7rqzEyjHQnDCZDcVObnVgGLJET+T5i+ET
 PbuGeocaeSdIxjH+465GiDHKwLr6seyU1H3lqhXt1iy2KbK42t8srmdMLgIBZoAO4auGtuWQQlN
 CuRJmW5HMxN29mhZQOZO8zenHcS0i5IfQlZ4GubCWy318QkSnsfCEtQevBhLwQ4lm2Gmnb3/RDG
 PcrIvhnjdVfSi2wLRaN33GGnUSmSnXJ5JA7Og88aEoGgkI20JwRuJ+55/BH95KAQgf72Y/Hj84h
 q83zossD3Fd0Hka2+XiZxrwwE1LWRXzDP23IYqO87WObKsirlgBzIQFckSA7PsPBRP5fA0z0BQ5
 l/lEuIxRlnFBZinA7VB6YK81BP5BQw==
X-Proofpoint-GUID: ZCiYgmWG8anwcWOYAqITgwjBc9Eugk32
X-Proofpoint-ORIG-GUID: ZCiYgmWG8anwcWOYAqITgwjBc9Eugk32
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-28_04,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2509150000
 definitions=main-2509270022

It's not uncommon for the particular device to support only a subset of
HDMI InfoFrames. Currently it's mostly ignored by the framework: it
calls write_infoframe() / clear_infoframe() callbacks for all frames and
expects them to return success even if the InfoFrame is not supported.

Sort that out, making sure that all interfaces are consistent:
- In atomic_check() callback verify and disable unsupported InfoFrames.
- In write_infoframe() / clear_infoframe() callbacks return -EOPNOTSUPP
  for unsupported InfoFrames.
- In write_device_infoframe() / clear_infoframe() functions warn if the
  callback returns -EOPNOTSUPP for the frame which is set (or was set
  beforehand).

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Changes in v2:
- Fixed build issue in common code
- Fixed comments regarding HDR / audio frames (Diedrik)
- In adv7511 actually check for the HDR frame (the comment was correct)
  rather than the audio infoframe (c&p error).
- Link to v1: https://lore.kernel.org/r/20250927-limit-infoframes-2-v1-0-697511bd050b@oss.qualcomm.com

---
Dmitry Baryshkov (9):
      drm/display: hdmi-state-helpers: warn on unsupported InfoFrame types
      drm/bridge: adv7511: handle unsupported InfoFrames
      drm/bridge: ite-it6263: handle unsupported InfoFrames
      drm/bridge: lontium-lt9611: handle unsupported InfoFrames
      drm/bridge: synopsys/dw-hdmi-qp: handle unsupported InfoFrames
      drm/msm: hdmi: handle unsupported InfoFrames
      drm/rockchip: rk3066_hdmi: handle unsupported InfoFrames
      drm/rockchip: inno-hdmi: handle unsupported InfoFrames
      drm/sun4i: hdmi: handle unsupported InfoFrames

 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c    | 20 ++++++++--
 drivers/gpu/drm/bridge/ite-it6263.c             | 27 ++++++++++++-
 drivers/gpu/drm/bridge/lontium-lt9611.c         | 22 ++++++++---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c    | 20 ++++++++--
 drivers/gpu/drm/display/drm_hdmi_state_helper.c |  6 +++
 drivers/gpu/drm/msm/hdmi/hdmi_bridge.c          | 19 +++++++--
 drivers/gpu/drm/rockchip/inno_hdmi.c            | 47 +++++++++++++++++------
 drivers/gpu/drm/rockchip/rk3066_hdmi.c          | 39 +++++++++++++++----
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c          | 51 ++++++++++++++++++++++---
 9 files changed, 208 insertions(+), 43 deletions(-)
---
base-commit: bf2602a3cb2381fb1a04bf1c39a290518d2538d1
change-id: 20250927-limit-infoframes-2-6b93e599e79a

Best regards,
-- 
With best wishes
Dmitry


