Return-Path: <linux-kernel+bounces-801858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D728B44AC8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 02:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAC851BC447C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 00:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DC518DF8D;
	Fri,  5 Sep 2025 00:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gJ0Gktzc"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D184219EB
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 00:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757032722; cv=none; b=iogWiii8Lvjg5Gt+XUNvNDJto7SF2wPHfHiBNYmNoYQUCwcRsOfrT8rkm/QSuy3mX/7+WYh54Za9d4wRYgz0eZ8LCtCdNihjWnDmOynOru6w0W2wxeDwoLDkrtDWmhOLGPGNz1zckO3cKdBBKdrsBfO8jDose6VCM85ua64l14s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757032722; c=relaxed/simple;
	bh=qW6/eOo9LKWtLOPcjncf4diY+DYlgQ8HDpWPicvkcCc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=HNV8tQErSs7fXL4X3yY2c36sL1kLgqSk2XCkv0uVpI+uVfPoImrN0YkkSzkA46RUnXVUwkUpoYNNdhDo4w0Kx7ERmr/P1ZyTbHx258UKWLq/yYoinqTmItwwowH8r7ftr6mx2fHBUMHt8+YUnrzagdDyhYTQ92SiC4o9JPCoyHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gJ0Gktzc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584INShA007609
	for <linux-kernel@vger.kernel.org>; Fri, 5 Sep 2025 00:38:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ZQ1S7RqBfWQLYYMNG1n1QH
	bTBVxy2xoCDvsUe2ZNd+8=; b=gJ0GktzcYf4HvI+MGTT4gqAMCiYFFojtqKgU9l
	y25gPSfo9ocuoB/gzNafYTZAKkl406vvvTGawoU5LNIiYrWzOnVnBFk0etWfe6z4
	sHi5jnHZsVh36WkbqroVwAuhDhqzSt+TBhLvSROD1O2lVj2uLmbnEDIl0rMUHkBm
	OO0g6IFgiSea+1ZY/uW8PRLcmP8NKCofbmFAQEL7RzMESdvhFDwXxdIlkf/5iyS4
	f87MVIqYvEYN77qW2fWmAa9PlFxGqHLrulGLoYacbuHP50DrGuVwhbFb1BuKmjBJ
	p3AkeeEr/lVdIydTae/qc5yFyCDO1Rx3pfyuX57wglqj2/ww==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ura916sw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 00:38:40 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-810591dd04fso151464385a.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 17:38:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757032719; x=1757637519;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZQ1S7RqBfWQLYYMNG1n1QHbTBVxy2xoCDvsUe2ZNd+8=;
        b=i+AuXUtlEORTAUZPNRJTV1AgiEHiuRWaRNaR4cUmKIyI47igfJwBwZfVQqNhCy/Z4e
         sfPobo3ndCa3sgQBfG1VM75wrae7pJacPpZpscIOruWyQQpqVSObi30EWlrKE18QuOl+
         cbZRlpZPteao9qNkg2xALeXJ06qAoj/iRXZ0v7QpQRWKKkz/SMGocsxAtfQHWg4c94o2
         sylgfVYfKDbjrbjgGUQuyybgdBo7CiMJmss6zzxuCw7HiYXX7209RCL3bGF9iX1iFIKW
         T11HT2Ktj2F9MgkyfdIcjvG+60L/agJsBPN0I5ZCh4hMy2Yu7Gx6XQUVguen+YzrwG5d
         GyJw==
X-Forwarded-Encrypted: i=1; AJvYcCVj79EhaXNnfVJIbhvQKLnBntVEzGLbdbGaj0THbIyNawiOTxEfZONIv89cYV4oUi7KsJM8d2rZ8fddwYw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2RpdVc4ypFQ4aRUWsTo43ODdJP6mIoqYclrpe36S9sh8ylQu9
	HJl3RgPU689ut2LeqmRERTKznGYUZREgJzLZuB0W6eC/k+D3bw7AQ/i7+/z/gZQjvelLCRJEPkb
	VLfXC3a9a1qJrd8rDQGow2y8prg69VknFHwXMf5gxYGBQ+qNINusfWbWoZIqZKzJGTL4=
X-Gm-Gg: ASbGncsmCGUwioseOYMp1EySJ93bxYoy8JvmTH1enpBlvLkDEiWyGOoB44PQUF+VNSo
	mBBFQcePuesos68ZyxI7LMDB73T8Ybgs7adD6AnEH+wJKqZkElJ1MuQMW99sSqNpPUFPUGGFiCJ
	FGUykwJfYCN5BszgvaKK7cONjUlhvNL7SBiBWd52pg+j39w/+kqjAVpc3Ajk3UlKyHbU8Lauk6t
	9UZp3QIxcRWnXQH8lQjKzbzQD+XIVCFa8eu1rPJXe5iHD9xfshTDr9f6YvT5PlicRSq1D3o44LD
	wpn4lf8/cbG7LNbYsPACjXt6KpKS+Ryy32q4YasYX6ypmcN47QssdkAJ38AQnZSNVi2D54PHN+Q
	68CLJ4YZ4DA2gnkBDrZ/U0V+2q3JUZtHJ5829McNjrK94+wBMPl6+
X-Received: by 2002:a05:6214:19cc:b0:716:ba73:8b72 with SMTP id 6a1803df08f44-716ba738bf2mr270613936d6.19.1757032719193;
        Thu, 04 Sep 2025 17:38:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH78jS1CC6gp64q9CeCchmxo9IKoMvJ1QZpZ/tTHVE199OLsf88wLnqSYWQo27SKv7RW7GqeQ==
X-Received: by 2002:a05:6214:19cc:b0:716:ba73:8b72 with SMTP id 6a1803df08f44-716ba738bf2mr270613576d6.19.1757032718742;
        Thu, 04 Sep 2025 17:38:38 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5608acfd938sm1510059e87.109.2025.09.04.17.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 17:38:36 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v2 00/12] drm/msm/dpu: rework format handling code
Date: Fri, 05 Sep 2025 03:38:29 +0300
Message-Id: <20250905-dpu-formats-v2-0-7a674028c048@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAUxumgC/22MQQ6CMBBFr0JmbckUIaIr72FYtHQqTSyFDhAN6
 d2trN385P3kvR2YoiOGW7FDpM2xC2OG6lRAP6jxScKZzFBh1eAFG2GmVdgQvVpYoGkU1UYqqa+
 QjSmSde+j9ugyD46XED9HfJO/939nkwJFjRa1Pkvd9u09MJfzql598L7MA11K6Qv9ISfSrQAAA
 A==
X-Change-ID: 20250705-dpu-formats-0d5ae4d1a1b9
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jordan Crouse <jordan@cosmicpenguin.net>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1940;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=qW6/eOo9LKWtLOPcjncf4diY+DYlgQ8HDpWPicvkcCc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoujEI34ZWt8/uxOCCrSdZPDQoLW0OQwNEl574P
 Bda+7JrzIuJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaLoxCAAKCRCLPIo+Aiko
 1e3fB/sGKF68MD3l94OTzkHkplbqwsQrimwI8MrePyZDA0gRkuJ0n9rx+IjpmfrO6IfDDzUqKJa
 FAuZpjx9SdSP2qmXlwDXCwww4iSqrnFngy/BEiaY0RvhqeAFN7fY7pgmwBE8Jds1qzVyFexPbzn
 9CoNJ1J8JxNRWaeJ1t7HdF6oqTCH2yqYFkR9U2a4h5LhnNRIHXUtdHFX4wI1EMrb9NOjGphlTxO
 nS+YWShKQ+31Eqw1NDyUxyia5j/P2ewl4dS8WuqM8b0jcIPEmBRjXQb5QIZ53IYHBwxh8Z2/TlK
 U5CP94rpkwYGshLBdhDtsPIZ3EyA4siwQFts1f2UyO5toXTw
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: UYQzEIs0pqfXHGTZ93HluywDWebfNN6S
X-Proofpoint-GUID: UYQzEIs0pqfXHGTZ93HluywDWebfNN6S
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyMCBTYWx0ZWRfX96oRI46XPsiU
 /wBqCrcqHaxx7yngqt2NXX3Q/nKKIdjY+Yf0xaiRwW8N1U97o1NFg9HuS7ahmsH1sgOLPObRb24
 kosjsd3PDpeE1ZOE5ZukM/bL4P7lnLy02iG09zxxJH8jxzMD+BBmtbpAJNqXzqQ/pF5inHmRuSw
 KDUOoDM/Tu0pBcE4Kzje+d6akIweIUOfSi96RfL+Zw8PRawEEE1NM3VP7Lpm9Oe4jJ4TVyRhMZE
 7Vq5HFqUjz/pnlCUGRkLf2SKi+VQb7f6SY4q9TPGxLz0TiKYLYPI3ZCfq4AHQ3pRoeoxCJQpRI0
 5WAxWIywr7Z6vIxxdnnyTuQZwrdHnMhVWr+/KCnMdX1vLBbNQNT9WW+0itJrItgmhY9vtjhYQN5
 3XX3HimQ
X-Authority-Analysis: v=2.4 cv=VNndn8PX c=1 sm=1 tr=0 ts=68ba3110 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ilABv6Z8GYNuw7svrMYA:9
 a=QEXdDO2ut3YA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_08,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300020

- Rework mdp_format.c in order to make format table manageable
- Rework layout population for UBWC formats in DPU driver

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Changes in v2:
- Dropped DX flag from the tiled NV12 format structure (Jessica)
- Changed round_up(foo, 192) to the roundup() as the former one is
  supposed to be used with power of 2 argument (Jessica)
- Fixed undefined varuables warning in
  _dpu_format_populate_plane_sizes_ubwc() by dropping the always-true
  condition (LKP)
- Link to v1: https://lore.kernel.org/r/20250705-dpu-formats-v1-0-40f0bb31b8c8@oss.qualcomm.com

---
Dmitry Baryshkov (12):
      drm/msm/disp: set num_planes to 1 for interleaved YUV formats
      drm/msm/disp: set num_planes and fetch_mode in INTERLEAVED_RGB_FMT
      drm/msm/disp: set num_planes, fetch_mode and tile_height in INTERLEAVED_RGB_FMT_TILED
      drm/msm/disp: simplify RGB{,A,X} formats definitions
      drm/msm/disp: simplify tiled RGB{,A,X} formats definitions
      drm/msm/disp: pull in common YUV format parameters
      drm/msm/disp: pull in common tiled YUV format parameters
      drm/msm/disp: drop PSEUDO_YUV_FMT_LOOSE_TILED
      drm/msm/dpu: simplify _dpu_format_populate_plane_sizes_*
      drm/msm/dpu: drop redundant num_planes assignment in _dpu_format_populate_plane_sizes*()
      drm/msm/dpu: rewrite _dpu_format_populate_plane_sizes_ubwc()
      drm/msm/dpu: use standard functions in _dpu_format_populate_plane_sizes_ubwc()

 drivers/gpu/drm/msm/disp/dpu1/dpu_formats.c    |  174 ++--
 drivers/gpu/drm/msm/disp/dpu1/msm_media_info.h | 1155 ------------------------
 drivers/gpu/drm/msm/disp/mdp_format.c          |  613 +++++++------
 3 files changed, 390 insertions(+), 1552 deletions(-)
---
base-commit: 9be5c47908e669db4934ef9c129b28bbc879a8be
change-id: 20250705-dpu-formats-0d5ae4d1a1b9

Best regards,
-- 
With best wishes
Dmitry


