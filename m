Return-Path: <linux-kernel+bounces-760882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B65B1F189
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 02:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D16D5A04B86
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Aug 2025 00:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB21239E6A;
	Sat,  9 Aug 2025 00:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nU4a4UC9"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6599237A4F
	for <linux-kernel@vger.kernel.org>; Sat,  9 Aug 2025 00:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754699741; cv=none; b=a9krAcMur1fNW2ENvd9U+78GlN8o85OxVx2SrebRQKG5J2R3sRkO+nUkgVDEGBE5BOG5Wp5Ibhevls3kJKtNvhfRXHc8/b1+7727LV02Unn2lYCPVe7TSJ7yZh1RtBbB0wzr+hHIeC4X2qcc5a520g0jHo1b08278KUSDUIFT5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754699741; c=relaxed/simple;
	bh=GcppbpLyBA9b1yf2lCD9BuTJMMUuGA+FkmOmn+rmg2s=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RgIejjwEOAW4rPPU5UDIx19LoXgi/+AZMKmWC9KXl1fCD9Jk5g6cBr0qspu+1fdPWFq+WWdAjDIHH/DbxCez10b1bak1tSdF3IFCO9ENATwoF1jHOhX8064Ip9av5yisFGfRAaL+Sjs+LoBqOmF2pbdf25Z5DdIC6IChi4aBJPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nU4a4UC9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 578NGfuY024518
	for <linux-kernel@vger.kernel.org>; Sat, 9 Aug 2025 00:35:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ZbGX5bxjJoDa8OQ/Re32Qt
	hpJZzf8LuGqJ7nEgpoBBU=; b=nU4a4UC95r8zh3UAkKBuonofP0oxbbv8+V3dDP
	PndUx+IBRExGN8NXOBqhVI7ID2JemTF52Ob6pZDlIe4G1kWt9zrB2ir6P25AXoVy
	WPnzUZD36lEyNS4ggguh0zGywmljQAlOCyJL9qUsDiLP+v95qzukPN8LlziTkU8D
	vpVl5mF9wBYTnWARh7BjZKiO6bEA8Sz4eH43p5rl4kxhsnzR8kmC6C/kQ26ThHx4
	7A0Cw/jboAOjQRKQYxeraPD4JNBiMIWOkwM2Acl+4kyzcoucwVlbhgEDdY+s/YxI
	p6dNVoT+2gBozw1F6iEjkbtk4Pi/TvhGKGhj8jw8z3F1PCGA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48bpybkm5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 09 Aug 2025 00:35:37 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2403c86ff97so37969395ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 17:35:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754699736; x=1755304536;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZbGX5bxjJoDa8OQ/Re32QthpJZzf8LuGqJ7nEgpoBBU=;
        b=NYFkAppefaVS4GkMUGj72xSAWN8JwjE0mnD2lNFWne9pH5tXtT/9RaFmDFTklO3R/K
         CGeZh0U99ZARkbsycw2h/JNSsIHPqdbhkTGoThw+8z7hpD4RcMEUpHszzkcz7kwlkbLu
         z5ToQLbfilPKIdUKH8bcRPBS9YX24PCH8egxw+Ej/BXv6KYXMEbN5eup6V/6qW9STGdU
         pT3YaQSbmr2S2r+qI/C9cRU0lOTZ5gYfPcZ946Ha250FqixZ+FiBAY6GUj7s6B8k3gPB
         vRWHBwhyGQRmiJrz7WZlFDKXCA5razc7S90nnOV7lm2Ddy0uQ8Wpxx3yktCTpcPUfZHT
         3QWQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+mFQS4830q/P5+R7E4QoGnb5wFBxIRxk872DWprH/PT+z0oWrnZRb6Lyz5UP7m8YnuUN/cPBsCFxwY/g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl0guV/cNULEax9CtGVIGgnrsi+m+7jERdu5AIMqbp6aohgZxw
	G4qgwsFtHAoD2ybTARYZV6rzIOt78PzuvRGbMp7MqAFG0uS59jKrrJTyCgYR9/TjkGZ/F8UwQmy
	IPTI+JawH4KsY6Pc9qcA1PVWtamkWGjYDu0idMWFdfP4OlwYVh79VYS+5XGjKlmbSnpk=
X-Gm-Gg: ASbGncv9jR0NWeYosourIkrp+TgLk0QXdIQckgwCbniUphArGmiqkW41jz06HCxGLQd
	ybAjMh4n5CVcFkQaEwcptv5CDcB8JUp9kNPtAGGhdzsHjbJdhuMdYS4JXpj3ALODhdM+0g/pap8
	6m2OLX5fqrCwpY01S2LTAlqG6E6rxRhEI8rrjD5/WBEZMTeLlWATl9HVVFxXqHm6eG7aiWKIFuG
	xP4dBVyLJK+05bXabFQq9rIQL8djKrtQr8fVUe0VJ3DSfvOecqICE31Xo3cS+7FwvsUCGTUE3e0
	I7x0HooSDw3ZBGtyZB1lU6AcYVOVLCBUDJB2LNmiyYcrA13aQCa0RXVYruXz9xnu1fupZmbl6BB
	yS5C22dg/aSrummIIDjMzFNea
X-Received: by 2002:a17:902:cf04:b0:240:7308:aecb with SMTP id d9443c01a7336-242c21ff8f9mr89428185ad.32.1754699736240;
        Fri, 08 Aug 2025 17:35:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGi+7fe4uPTv690KlXyI03z9asGDkSfIXdbnLoKLJoKkTTJSV1FDnOhicgZI/Utxq39clnAPQ==
X-Received: by 2002:a17:902:cf04:b0:240:7308:aecb with SMTP id d9443c01a7336-242c21ff8f9mr89427815ad.32.1754699735782;
        Fri, 08 Aug 2025 17:35:35 -0700 (PDT)
Received: from jesszhan-linux.qualcomm.com (i-global254.qualcomm.com. [199.106.103.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241d1ef678dsm219865355ad.39.2025.08.08.17.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 17:35:35 -0700 (PDT)
From: Jessica Zhang <jessica.zhang@oss.qualcomm.com>
Subject: [PATCH v2 00/12] drm/msm/dp: Drop the HPD state machine
Date: Fri, 08 Aug 2025 17:35:12 -0700
Message-Id: <20250808-hpd-refactor-v2-0-7f4e1e741aa3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMCXlmgC/1WMQQ7CIBBFr9LMWhoYijWuvIfpglIqJLa0oETTc
 HfHunIzyZv//9sg2ehtgnO1QbTZJx9mAjxUYJyeb5b5gRiQo+IKJXPLwKIdtXmEyNrGouqVOiL
 XQJOFEv/addeO2PlEtfduz+L7/YlaIf5FWTDOpDS9NieUo2wuIaV6feq7CdNU04GulPIBJLDWG
 K8AAAA=
X-Change-ID: 20250523-hpd-refactor-74e25b55620a
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Dmitry Baryshkov <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yongxing Mou <quic_yongmou@quicinc.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>
X-Mailer: b4 0.15-dev-a9b2a
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754699734; l=2514;
 i=jessica.zhang@oss.qualcomm.com; s=20230329; h=from:subject:message-id;
 bh=GcppbpLyBA9b1yf2lCD9BuTJMMUuGA+FkmOmn+rmg2s=;
 b=4JF/mkzCvIDHNqLd9NKmhnVuxsW0hiYQreE5SpMBbfbel+6PDV1d5C+Cb38ZRK1JqxcUnFZ4s
 mmHrn7CAiP5AMbC+8MtborBGBd2E4rpRpdWZ1V5/XNJtMoaJgUAEPlk
X-Developer-Key: i=jessica.zhang@oss.qualcomm.com; a=ed25519;
 pk=gAUCgHZ6wTJOzQa3U0GfeCDH7iZLlqIEPo4rrjfDpWE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA2MDAwOSBTYWx0ZWRfX7f9l80KzV3Yo
 w/7Oyal2koP9zlrbcYh/eO2dpSTbid5luk19syz9XySKC5EjYRsGWquvcENtjtkgj1UnY10sjv1
 IjYxUgpQ7/ZT/3xKKbWLlHfpxWKfXdbQ6YoHrgNv6WD8f/hgWisrltrPd2WmP34loJ58rCTXD23
 2xFPG5MzJ0s1cJT9ZDSJfFSLVIUoqN+HSSz5OpRcusaGzQdY81hxg4fyt3/Ss40QA0UNc+y1h9U
 jIG4tXE6OVeDyaGhVahL2uKlllA2X5oCDpiOe/QZgqUFtEK4O7CVUzLR1viqYkC8ibbF+evLbPX
 RNORNrHBJx2kfVDz7qYTzBmBuu34J2mlTA/z/xIq5bd4oJu9eUQuqJZ3U85lmU1JIydn8WvGPuB
 ffU6q6jG
X-Proofpoint-GUID: u_P49NhKqyidmXXUEU1rDKz49rwYc-PK
X-Authority-Analysis: v=2.4 cv=EavIQOmC c=1 sm=1 tr=0 ts=689697d9 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=ykQkPS02loRjcs06OSIA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: u_P49NhKqyidmXXUEU1rDKz49rwYc-PK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_08,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 adultscore=0 bulkscore=0
 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508060009

Currently, all HPD interrupt handling must go through the HPD state
machine.

This has caused many issues where the DRM framework assumes that DP is
in one state while the state machine is stuck in another state.

As discussed here [1], this series:

- Removes the state machine
- Moves link training to atomic_enable()
- Changes the detect() behavior to return true if a display is physically
  plugged in (as opposed to if the DP link is ready).
- Remove event queue and move internal HPD handling to hpd_notify()

This has been validated on x1e80100-crd and sa8775p-ride. Any help
testing on other platforms/use-cases would be appreciated!

[1] https://patchwork.freedesktop.org/patch/656312/?series=142010&rev=2#comment_1201738

---
Changes in v2:
- Dropped event queue (Dmitry)
- Moved internal HPD handling to use hpd_notify() (Dmitry)
- Reworked bridge detect() to read DPCP and sink count (Dmitry)
- Moved setting of link_trained to plug/unplugged handling
- Dropped msm_dp::connected (Dmitry)
- Squashed all hpd state related patches (Dmitry)
- Link to v1: https://lore.kernel.org/r/20250711-hpd-refactor-v1-0-33cbac823f34@oss.qualcomm.com

---
Abhinav Kumar (1):
      drm/msm/dp: remove redundant checks related to ST_DISPLAY_OFF in plug handler

Jessica Zhang (11):
      drm/msm/dp: fix HPD state status bit shift value
      drm/msm/dp: Fix the ISR_* enum values
      drm/msm/dp: Read DPCD and sink count in bridge detect()
      drm/msm/dp: Move link training to atomic_enable()
      drm/msm/dp: Drop EV_USER_NOTIFICATION
      drm/msm/dp: Use drm_bridge_hpd_notify()
      drm/msm/dp: Handle internal HPD IRQ in hpd_notify()
      drm/msm/dp: Drop event waitqueue
      drm/msm/dp: Return early from atomic_enable() if cable is not connected
      drm/msm/dp: drop the entire HPD state machine
      drm/msm/dp: Add sink_count and link_ready to debug logs

 drivers/gpu/drm/msm/dp/dp_ctrl.c    |  22 --
 drivers/gpu/drm/msm/dp/dp_ctrl.h    |   1 -
 drivers/gpu/drm/msm/dp/dp_display.c | 580 +++++++++++-------------------------
 drivers/gpu/drm/msm/dp/dp_display.h |   1 +
 drivers/gpu/drm/msm/dp/dp_drm.c     |  20 +-
 drivers/gpu/drm/msm/dp/dp_drm.h     |   1 +
 drivers/gpu/drm/msm/dp/dp_reg.h     |   2 +-
 7 files changed, 187 insertions(+), 440 deletions(-)
---
base-commit: 8290d37ad2b087bbcfe65fa5bcaf260e184b250a
change-id: 20250523-hpd-refactor-74e25b55620a

Best regards,
--  
Jessica Zhang <jessica.zhang@oss.qualcomm.com>


