Return-Path: <linux-kernel+bounces-806653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D960B499F4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 21:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 327143BD919
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 19:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139B228DB71;
	Mon,  8 Sep 2025 19:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bD2KKydy"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC08328C849
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 19:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757359832; cv=none; b=GttzF/tx40Te/uzeo/zU28fnEw9hkCzV9YYwNMIzNf6Ph6lWecVcxANbu6NCXJ/yPE0Vq8VauxUTp3Ldg+p8gu71y+2n7DERB1zV/zsQnWfG5OtjhL68U35uabmE27N1e70yb3jP7ziRe8iafkXjMYK5yCoV/r9CvGrhJypznBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757359832; c=relaxed/simple;
	bh=1WFJr7YQvbq8VNUx6ycrIGIPBwbXuM0dZ15JKqwlK3g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DkQ90M7v0mO3WZ3SWtRF3g3FfCzXbvhXNKpZL3wH/eGK0ABSE9K1Z5Pg0E05xR7TSCskeeKDS4s8sJSK/UiuSIQ5YFTqKrvJGsZuI7jvahfmfROUlhZ9FO2XbS0EGGqETP2rQhyB/DntBtHsEwniLOwLUyY8vIj/iTs4x4VH1EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bD2KKydy; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 588GbJJr017315
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 19:30:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=DBYI1s0Kwcsc+/IUwfNSLMfLO+qO59pSIyk
	O91Hb1MA=; b=bD2KKydy0P6KX/3DNWpba6zELRUdSd7WvClpkUSAmJg/sT/0d2i
	9SUxhFAcksIG1o93lwlbVwxNU/SX0CGDd1i6WRmeWeNLfpS354JjMFQGuC6ejBsV
	+oa2NbkvX6kFWWuGP0D533F9pRyF+BDAfok9iOZC5FcCqWO39hKamZiauFBaXrzW
	uJ8YKwkignKXrthfIcRiL3Zg8Qi9fHDZioVsr5NNx9rI3cv310b5z35f+FU8QE55
	0dR2jLA4Xnstm1ECuMMdxyU7rH0uOFFNzKQrOVoM3BVhst70cSVnHqFO3p++lbwo
	AIO6GxSrH0yuWSmmfXN8g23cQ2C501arY+A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e4kwmmv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 19:30:30 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-244570600a1so60580485ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 12:30:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757359829; x=1757964629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DBYI1s0Kwcsc+/IUwfNSLMfLO+qO59pSIykO91Hb1MA=;
        b=CharT+SwMXN7kkP+52pagRmg3ofZRm3X1ozduxjc26RlDY9wfHt0qRdy6YIXwNwvqr
         CoxXHOJ0T/GBHhLgLuzRPhfhFjVI8UVRCJQZzvyl6kONgX05ukjYzOaOAuA4it5a5IuA
         kCnFQiJGMxABzcGzznxGpkhmaU5e8hZFBb2YTHjJYp28l3GQsi86012ow2iOBb95fmO1
         2JmLPaxO2ax4jOzLnthgYKwVeiGYTfG55GnZed+seHAofSTU57GbuYWwI6nWv9FIO/G0
         8qCTuZ3iLo/t0mXnRFNp3BGcYSmD1GNv+j/nZLVYaUkrUAZ/c58zuUx7tqrFdYYlp9cq
         fTHg==
X-Forwarded-Encrypted: i=1; AJvYcCXqvVg+4byWxxSORTdjyPuS/3Gn5f3k50t2257moEVYyAp7uujpp7l47sIFMWc5GLgXitvDBZVhSOpHAxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTXm1/dIfIaHOACPBfxGFbm0trviTRLvkxun/XiLA8zoLj7UHP
	R8kS07uPCILai39JsfPY/EDzNIwno69YnaZuizzH4iEDTRjeeFKtwlhCfPSgJ3Dcb3tKz4BcZoM
	TDYZUYzpSVsShKAh4cx/ppDm2St9q+4BWGKQZ8yS6sCwtxk1dRQmAHm/3vVIpGIY0n2KFzZg89k
	k=
X-Gm-Gg: ASbGncs+gpXmvZKnKxEFtljJs5z9yyLIbb9u+IBdBLgcStZineDy9vj3s4GonP+9SWn
	UnHVfubI1dpeUYt3OwsqWJmxl2Rbx2zjH/lviKYdGGBNTln2pazw9kOK9ISS/KHQnLvLbNxBWMM
	5ePbDjzAFzm7z8z8Jlvz5TL4JkY3E2rRx51DYZP8o3Il3OPpR1yOedTto34P+P6lp3lRCgDYCgd
	HeTKmQ3hB+34QYWSR06oR3fuZ7AZq2hegFIknLBVTIDAs0RTBndlfLrtOSh3sTJsvM7LhXwFxun
	WNUSZ2WqFW3V3OLQ58n3Gk0cS+rgO5C6gmwgCkjA9zTXCLjJftE=
X-Received: by 2002:a17:902:d58a:b0:24b:270e:56d4 with SMTP id d9443c01a7336-2517427c78amr113285335ad.4.1757359829209;
        Mon, 08 Sep 2025 12:30:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0Ni+T7orgU9Tutacd+01JeovMGTrJRiaBNcvzJAbWLaTKOdvcEbz6Jlp0yDTmRpvFr6mVXg==
X-Received: by 2002:a17:902:d58a:b0:24b:270e:56d4 with SMTP id d9443c01a7336-2517427c78amr113285065ad.4.1757359828730;
        Mon, 08 Sep 2025 12:30:28 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:5b3e:de60:4fda:e7b1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24caffd7beesm136191685ad.121.2025.09.08.12.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 12:30:28 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        David Airlie <airlied@gmail.com>, Dmitry Baryshkov <lumag@kernel.org>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-kernel@vger.kernel.org (open list),
        Marijn Suijten <marijn.suijten@somainline.org>,
        Sean Paul <sean@poorly.run>, Simona Vetter <simona@ffwll.ch>
Subject: [PATCH 0/5] drm/msm/registers: gen_header.py and regs sync
Date: Mon,  8 Sep 2025 12:30:03 -0700
Message-ID: <20250908193021.605012-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOCBTYWx0ZWRfX73uKj4DiYDud
 CgkPC7g+HJI3UgUlSvMftFQmSEKnFDrrYXQD3VoGzmEbsYzzO5NZKrBHgIjoRCKin7L88ve9Afi
 l48jZ5epglL4MWPKpNkkrax32qsCuLDmjd0qn8hVEv97AE3/fAXnY5fIce5DgV/S5KYGdj53kdf
 bGnz6xMJsViZ3sgKg2Ytq03QPTWr3P9ZfnYm3CneSSh3dqWj/nCQ3Q2XcJdo0kqKXA1gPXOZBvP
 /ASZBAfyrgASg3Z/MVLgtM5JnKprsJYjdi8AQ+m5ysTIgL789WDmZnWobX7G6F0bbwcKkiF4dcm
 vewwz2LnPyIhV+IYqSbZPrk1Mz5NcULsw4VrMcVokSDfFR92sgQRRt++Wn0xlVSC28odaJDXZF7
 2erU+hTU
X-Authority-Analysis: v=2.4 cv=J66q7BnS c=1 sm=1 tr=0 ts=68bf2ed6 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=e5mUnYsNAAAA:8 a=E6oEVHbn0fKM42HpNhsA:9 a=324X-CrmTo6CU4MGRt3R:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: mEz5hY3gkl_Svo0VO78fLMf-YKiDThgq
X-Proofpoint-ORIG-GUID: mEz5hY3gkl_Svo0VO78fLMf-YKiDThgq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0 phishscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060038

Now that https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/37216
has synced kernel side changes back to mesa, this completes the round
trip by syncing mesa side changes back to the kernel.

Rob Clark (5):
  drm/msm/registers: Remove license/etc from generated headers
  drm/msm/registers: Sync gen_header.py from mesa
  drm/msm/registers: Make TPL1_BICUBIC_WEIGHTS_TABLE an array
  drm/msm/registers: Generate _HI/LO builders for reg64
  drm/msm/registers: Sync GPU registers from mesa

 drivers/gpu/drm/msm/adreno/a6xx_catalog.c     |  10 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c         |  18 +-
 drivers/gpu/drm/msm/adreno/a6xx_preempt.c     |   4 +-
 drivers/gpu/drm/msm/registers/adreno/a6xx.xml | 718 ++++++++++--------
 .../msm/registers/adreno/a6xx_descriptors.xml |  40 -
 .../drm/msm/registers/adreno/a6xx_enums.xml   |  50 +-
 .../drm/msm/registers/adreno/adreno_pm4.xml   | 179 ++---
 drivers/gpu/drm/msm/registers/gen_header.py   | 201 ++---
 8 files changed, 639 insertions(+), 581 deletions(-)

-- 
2.51.0


