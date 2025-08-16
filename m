Return-Path: <linux-kernel+bounces-772119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 313BBB28EFD
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 17:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E07663B0EB4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Aug 2025 15:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B4A2F83C0;
	Sat, 16 Aug 2025 15:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oCAgJmfF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0521D2F90F1
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 15:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755357583; cv=none; b=Mhe0gzvm0iMl/IlGd9VFzbKm96lFLiJK3v+aUike86iNeADH+9Hz4Io0RYgKizlksMwytuYRVkG3oJFpO31Ehn4powMsxmKSuc2+wt5aAqXH0BN8F/xxMztgdLEJjKflv7c3nIaf/xus4cZflJz4KZtklGWcmtbxLmYEPU73ZBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755357583; c=relaxed/simple;
	bh=A/d943iupZVCsxCU+H3jAnKd2fBEwptYqE3Wnl3fWfg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=einueChCfikBSUcJSMi+yVV4dJkqjqBt+Nm57E0x1DxyaWUIz0Io8BQyfIvZobYYUE11NZmAAUFwsJFnyOPDn1gVYfNrJLtzRgWAIAtbvWd+CF4azLugAn71ZYsUMQz/0yB4lOjHERoDiGcS8+3LQ8RfJYv+dP+unj4bhGKBKnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oCAgJmfF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57G7ImBu007649
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 15:19:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=5lryexlqd0cwKQzcmybpaI
	+3EMl9PhbQcl2IWaTvkAM=; b=oCAgJmfFi/I2hzZFvUUpZcIkfXUtBg3UORsCZf
	JW43oqB6fB7mnzKdW1JpGIZ9TtzLtE+W3jZ36ZMH0RXXf53Mhu96U37P8XUnxarY
	oimPLzWmgJZFXbICcXB0HBA1w1gu09hc1CXhdn16cHauAmztii6bPGsJnEFJoSC3
	aYiCb5CpR3aeAnly/872UnqG7qWifllQ4xar86OOnxToYp63YUVDlMLJ7cDGODHY
	oH6TvRWa1VymRh1hvQ7/2Lbt+4Mcrs7mZQrgFZ+OPFp7MRkfVs3ANWt4JXNERfd9
	6AHTINJsBENxDPhLNKJRYyljl1ij1Dn+lNT1choVU6dt8tAQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jk99gqkp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 15:19:41 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e864817cb8so1036725785a.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Aug 2025 08:19:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755357580; x=1755962380;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5lryexlqd0cwKQzcmybpaI+3EMl9PhbQcl2IWaTvkAM=;
        b=H5de/ufs4bmGq5l27EhNiF/t/K5pFf4evf42tcjGMqEwgTnLlRF4Z383AgB54hbHTX
         GxiP1AaKm3FclLwb/J0x7Urz0AcOzyyvWHXONV+Ym7R0MwHOsNjvQ/gn1QkfeE7LMW1j
         uqPOHb9OZ/NgozDkM9372y32mwohCPBI/1FevxtIiy1mLpTQKVK2pl9ytpfInsYM+chw
         szHOhMpznWJEnC+VVzSej1n/zSry44gZB5LepAmp/PUq3BQbZKDDemERBlCGM7khgU+L
         LFoFBgUVeBH9ChZlHrkAk+VxRzglQ6t2lSF2nEYohiuRjrAx1t/2chlSY9BJuUcioyoL
         XZLw==
X-Forwarded-Encrypted: i=1; AJvYcCVRpRp4ZojjFE9idVjOuaODIFytsb4C6COsAOT3TfSWukJ2PEA+QM4E1lHRF0g3M/exJg+nBWpbhPUTpnI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf3tJK67CwnvfYQT4vCIESJu93DtmG5H+HA71pz4gighL9C2ic
	NiN2WSax0O6H56uIsp2xQa48vhAB4WDOr3HX1fC4e5B0jkURoUpRT6/qSGRFAlgkX5hpBKcQJXc
	M2pngivdk8JB4HMefznQh2pZvaLmbym+d2saqheAwwPdckOQu1bxxpyYs7dfogRmP5ig=
X-Gm-Gg: ASbGncuX5tlPYdwS2SVjd8h7+qS/iHzItEDPwHtrBxi2I8RbWJdj2lr0lM90avajq+x
	ULW59e0bP67oVh04rclEr5GnwwQ3iOmD1CMbHu/UTuSt1rvzcic4Oix08CQynXwl4euKjdhL6VD
	OALeHGWXNG+wqdgvtIfAWli0vhkP61zjOcyu9jY0ArCX5UY3b1YgFHpoI6BN4U+0FRLTXRQuGwk
	rRGpj2NmhO+uViS9zRJdWNePbxEODB8ZkS/+6JHIzyFuDgBRo8mLLT0Yk3xPrHahyZy11ubpYij
	hXcnNfkKflxvCPuYVPKZBnybCR54JJT8cbJhhTUBo2Qb5znmx+q8QJ9OKXsDFbx29zPHI3OMeNt
	eu386qWcgnr7prkpn/CfsNaS0w+oDXxnfNcNvv31BpMM8Q2kOp/Vp
X-Received: by 2002:ad4:5587:0:b0:70b:ae3b:4fcf with SMTP id 6a1803df08f44-70bae3b53demr47856636d6.23.1755357579692;
        Sat, 16 Aug 2025 08:19:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfelfomvA5wci6xz+3wi0J8SULNHFeOUuYXDPXJ1C+6Dag8vtfdR/Y+CaRJy4U66cTGuwdXA==
X-Received: by 2002:ad4:5587:0:b0:70b:ae3b:4fcf with SMTP id 6a1803df08f44-70bae3b53demr47856216d6.23.1755357579187;
        Sat, 16 Aug 2025 08:19:39 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef35965fsm907579e87.37.2025.08.16.08.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Aug 2025 08:19:38 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v2 0/8] drm: writeback: clean up writeback connector
 initialization
Date: Sat, 16 Aug 2025 18:19:34 +0300
Message-Id: <20250816-wb-drop-encoder-v2-0-f951de04f4f9@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIahoGgC/3WOwQ6DIBBEf8Vw7lokKtZT/6PxgLBWkioKaG2M/
 17U9NjLZmeyM29X4tBqdKSMVmJx1k6bPgh2iYhsRf9E0CpowijLaEETeNegrBkAe2kUWrhxQSX
 PapUpTkJqsNjo5Wh8VEG32nljPwdgTnb3f9ecAIWCpXma05Q1XN2Nc/E4iZc0XReHQartZFgcp
 /CsP0GkFg5hP9K+jJTtoNNOXn8L9Lj4EN2+MNFAzu8AAAA=
X-Change-ID: 20250801-wb-drop-encoder-97a0c75bd5d7
To: Jani Nikula <jani.nikula@linux.intel.com>,
        "Kandpal, Suraj" <suraj.kandpal@intel.com>,
        Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <siqueira@igalia.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
        Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        Louis Chauvet <louis.chauvet@bootlin.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2260;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=A/d943iupZVCsxCU+H3jAnKd2fBEwptYqE3Wnl3fWfg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBooKGIGMd13UWHpYiChLD84LKwc5yW7HTOFZ5Nc
 BeTRdJYMi+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaKChiAAKCRCLPIo+Aiko
 1VU2B/4olLxWynZ6yiMZ4UeXGeUOQWFTHVS0OmcvLMCYAz5OQG0aZQ8ccKIlHwyxoHSBsBg78Mr
 5QdHuJQEQDktITLER+XgXzSQGcAgijiinR/nhTa+NfpLIGR/EZrDmm2Pzno0MlDiSYg29IhxB4T
 kEyqTv5mjfkGwilg9DYt3nua1zSszeQdW1SnwwmS2bJ5BNDrwFKw9Be1apeVE0V5bbt3gjV9cJ1
 CTyH4/m6IJr1ZW1Z9GAeYcsmchIGnAeuuUGT6OENI6yZkiEVDemT5O54HW7bSXSXNU41/Le5fiv
 QQeKwVTkV8cEZ7a13v/GM/cWDBTcehtOQTW4bxGUsGsKFDS6
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: DCW3493crhER6Gz8EWp6BgzxQKCznTDN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDA0NSBTYWx0ZWRfX5wtJLbXNpP0i
 X5ELg8aSETLSg+6Gnc4MDvsIRJmx48X6WzoAwZ6xH+jdV8JcT8LAXccgnpC0wRKKdrrrUr6rgqK
 P3gs9d0mFLFuJHCAkkn8FBwZ2OuJqJV08MroVnfuSGp2aemQ+QkNrfbeePfpbSv10Pmu+w9xVcH
 1H9IfRh0TdJObK3oEeXxmBbhB7j90h1VjihZ5ewcwLRQxbnX/KDxbR//JdQrmelDeWU4rT4YBQE
 VWqhsPbiHar4RslMJKdhJwaFLKrUuyoGXvqJeg9LdHGmY12NGHiZ1On8KYclAtuBqkEodB9pP2/
 jo1bSMS2yM5P4nxa0gG82yPjqkj6njs2R33KSoI230MuU/fraO89LhafQqRUK2TekRZ/G58ZR9A
 IEbdeGPu
X-Authority-Analysis: v=2.4 cv=IIMCChvG c=1 sm=1 tr=0 ts=68a0a18d cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=cFjmsF-WLDi_aLc5EnEA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: DCW3493crhER6Gz8EWp6BgzxQKCznTDN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-16_04,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 clxscore=1015 impostorscore=0 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508160045

Drivers using drm_writeback_connector_init() / _with_encoder() don't
perform cleanup in a manner similar to drmm_writeback_connector_init()
(see drm_writeback_connector_cleanup()). Migrate all existing drivers
to use drmm_writeback_connector_init(), drop
drm_writeback_connector_init() and drm_writeback_connector::encoder
(it's unused afterwards).

This series leaves former drm_writeback_connector_init_with_encoder()
(renamed to drm_writeback_connector_init as a non-managed counterpart
for drmm_writeback_connector_init()). It is supposed to be used by
drivers which can not use drmm functions (like Intel). However I think
it would be better to drop it completely.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Changes in v2:
- Switched to drm_crtc_mask() where applicable (Louis Chauvet)
- Link to v1: https://lore.kernel.org/r/20250801-wb-drop-encoder-v1-0-824646042f7d@oss.qualcomm.com

---
Dmitry Baryshkov (8):
      drm/amd/display: use drmm_writeback_connector_init()
      drm/komeda: use drmm_writeback_connector_init()
      drm/mali: use drmm_writeback_connector_init()
      drm/msm/dpu: use drmm_writeback_connector_init()
      drm/msm/dpu: use drmm_writeback_connector_init()
      drm/vc4: use drmm_writeback_connector_init()
      drm: writeback: drop excess connector initialization functions
      drm: writeback: rename drm_writeback_connector_init_with_encoder()

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  2 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c   | 18 ++++--
 .../drm/arm/display/komeda/komeda_wb_connector.c   | 30 ++++++----
 drivers/gpu/drm/arm/malidp_mw.c                    | 25 ++++----
 drivers/gpu/drm/drm_writeback.c                    | 69 +++-------------------
 drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c      | 10 +---
 .../gpu/drm/renesas/rcar-du/rcar_du_writeback.c    | 23 +++++---
 drivers/gpu/drm/vc4/vc4_txp.c                      |  9 ++-
 include/drm/drm_writeback.h                        | 22 +------
 9 files changed, 77 insertions(+), 131 deletions(-)
---
base-commit: cb640b2ca54617f4a9d4d6efd5ff2afd6be11f19
change-id: 20250801-wb-drop-encoder-97a0c75bd5d7

Best regards,
-- 
With best wishes
Dmitry


