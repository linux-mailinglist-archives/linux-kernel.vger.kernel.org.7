Return-Path: <linux-kernel+bounces-778710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C715AB2E932
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 02:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C23917C990
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 00:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430ED1632DD;
	Thu, 21 Aug 2025 00:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oGm/QCW+"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FA78F54
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 00:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755734680; cv=none; b=kIqFSC3CFHf+/lt3OaIkG/ryeoGaRVrRoQNI8g/BCBvOPxv6ycMVawS/gVsBUWwLZLrvF0qr8vbqTTH4hsupKiuHKaEdZJTn27f4rxWz2AIDkMJoCNmMuP6T7ZrEKf8uQp1tn3tjIhHZho00uxzrE6ZcCNYw5B6YDEtGqDGYhsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755734680; c=relaxed/simple;
	bh=FTfonb6H2UF2nVmZnazTx3PEb2S6ZWHLTuGTK0lDTo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qEHOgSGPsa8p7CZqc18hLRZC77G5RHPdwRayZ2tdTHZXwGaTMn8/vD6BVSs0yLgIRzMYWhWgLaDvAfq8+FPRDatd9WGgyP1HvsSC6tALY1b2AXZMbT/Dug25K+RS6M/eo9OiSVrqQb1Xc3tKtRrG5hboI02TmSVVi/lwDafjfFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oGm/QCW+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KI3sQe024699
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 00:04:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=7GonE0I4O86
	IMbS9YwA1nRfKE7NxszsWoTIBBuaYOXQ=; b=oGm/QCW+yDsDLwFUlm0BTzAsCYm
	Q3CdZT4IjuaTN2G6iLwc6GW7VGglHZmkUZukV92bpXX4V5kbGIC76Cu9ZyHPWlmH
	DuGjCb+i//M4OxZdUvRD1pL5ypAUeD8M5AjOxq99w7eCKNNsIOsiEVghoMtWOkRO
	UsWIDXmuauwZPcQlh/xrHB6izFBDSdwBu+lAk/C9SkLgvc9/WtnBb7VDLGHORcjI
	XEHLWzbMzTZKuh6Fd8kuddbByOwqHQJVpnobWTOqftGoy1X1qwk9FfbwSZKoinQ4
	O6rEKr672qi1+tVLsEDEZ3NCRbVZMiSvz3A307bdxB0VdjWoB36PWgWuBxQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n5293ebg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 00:04:37 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-323266d8396so461372a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 17:04:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755734676; x=1756339476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7GonE0I4O86IMbS9YwA1nRfKE7NxszsWoTIBBuaYOXQ=;
        b=AYF5h/enuilhSCOVwXt1g8RF5laKEpaiSlKIsYQZexKAfko5Zaq4jShS8pKBQqHLR8
         t/otzsD+8Xbg7NVE+8phWhaLFPqOHbHYPjpJr0Af41qR2xvYcS1TL4cK9dvucvTo92r2
         NK8zCE0rh6zAkHOOa/LdMtANtTrYqmlePwXHUIPLQzxLIR3mgfL3+lk8bDtNECTEP0zD
         pIuNlMTB+BNm1L9JOW/xaYcRNZjAIBgDWqPz/p8DeyqcGO1dSGKvgvNeVGOn2cOi7mjc
         2oARDNballu50OC3WteZmly4t+ELzneZSX5SWoDd1X6LjcpbeDTkz7+wM4jCy2WRODn9
         Byjw==
X-Forwarded-Encrypted: i=1; AJvYcCUMbPBXnnRo9Ifv0PsQ7oDl0XxogUaChKAXs2SXjSmYeW8qxdTXsIJ2Tpd2q5KaWTt6BusBUOzbORVNLhc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVegNitR/doouNkWmWwNPT9bSH9iGpE3iKoTrNPp+UjTMrsPxj
	Rg0eYQGB4gKxewVcGUVP74CV2lewQ8/LmmKT5KmGtTfjNHzvZT2Tcv5vwzijcBWoND3vwu4NDPW
	zWMHcmeWoADnCV9jBQxgBSmoe6F88KM1Z+71lnPtzsM8C08733y2cSR06PMWdL73WcLg=
X-Gm-Gg: ASbGncu12CvNdTvgp7K8zPOQNZrFAdpNaAysdZI8MyA4VLRIDF5og7RSj93VJ+BHAAp
	ztUfhXQEYhkscnnBV21QG3h3/2EeaNppayhKYixemPyzuZfct3LWaYbIMqL7KN+mgOUH9PezgLh
	yGvASYKk+CqYy0gU9Nn2HIiFAm4C8JO9cIvzMmiFjBeW7t8BODvNCpFwcx+rhSGk736T8bDiMc5
	m/2ZryzxuPDkii2RsKpIm6hoZiK9Wx9xhHPu/VHtRGrHKR2M8xPQShib69UmTlLpLEmbwiiHKP3
	jIWlZ6krARap828t3Wm9ne5GQ52T2HyDfGjjc4Z+qcj8U7SfG3s=
X-Received: by 2002:a17:90a:c890:b0:321:c8e1:82e with SMTP id 98e67ed59e1d1-324ed1bfb25mr758857a91.26.1755734676233;
        Wed, 20 Aug 2025 17:04:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENGaAHhgimor5pJiOH4MjaweNyjNHnC1m6WbGg+qru+W8Qt7ZVMax/uq24M3YIwwpqMOR0CQ==
X-Received: by 2002:a17:90a:c890:b0:321:c8e1:82e with SMTP id 98e67ed59e1d1-324ed1bfb25mr758824a91.26.1755734675703;
        Wed, 20 Aug 2025 17:04:35 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:5b3e:de60:4fda:e7b1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b47640d3e3fsm3201333a12.56.2025.08.20.17.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 17:04:35 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Connor Abbott <cwabbott0@gmail.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/3] drm/msm: Fix missing VM_BIND offset/range validation
Date: Wed, 20 Aug 2025 17:04:26 -0700
Message-ID: <20250821000429.303628-3-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250821000429.303628-1-robin.clark@oss.qualcomm.com>
References: <20250821000429.303628-1-robin.clark@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=ZJKOWX7b c=1 sm=1 tr=0 ts=68a66295 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=xd9qGtD1qYZMgD9OdIwA:9
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: gQk8NFPVagtyCWAc1n-TK7yf2jsFBwH6
X-Proofpoint-GUID: gQk8NFPVagtyCWAc1n-TK7yf2jsFBwH6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfXye+uKoAIUsHH
 /nt8hOPF49PHqSoMrUQKAJSHMKfuE5T2xne9ws0/DfKPu/fFlp1d7ROf+rOSGUbwDMRET3uXdIM
 cg5cHbzXHVHSjB/F8YskidSjeLQ2GRcg0fzkWxeBOoqvwmwFZyMdUXK04jyQ1j7OPNxl1CPEVbW
 YfDepdXSzZxenfJviOhToBZCkrYmcf8tWsemUOjmB3Fs/GGWBVW8ulTB8hetwgPFqshKxRNdu7t
 pfcYHIzkczmEcUK5eZp8C3UWtcE8RGMPtRs9/BXsfAaI5H40r23Hn83ycvRQOQIpdNqpzebpSE2
 9qFqA4juUmYXA8QGMX7PcoTgg8VO12MzroBO7uL+reEZ+sHJi6OJ93e2DaBME68hwDKZvuj623A
 3q9CzZUx1bZqpcdL7GVuY3Poap+nNg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_06,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

We need to reject the MAP op if offset+range is larger than the BO size.

Reported-by: Connor Abbott <cwabbott0@gmail.com>
Fixes: 2e6a8a1fe2b2 ("drm/msm: Add VM_BIND ioctl")
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
Tested-by: Connor Abbott <cwabbott0@gmail.com>
---
 drivers/gpu/drm/msm/msm_gem_vma.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index 209154be5efc..381a0853c05b 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -1080,6 +1080,12 @@ vm_bind_job_lookup_ops(struct msm_vm_bind_job *job, struct drm_msm_vm_bind *args
 
 		op->obj = obj;
 		cnt++;
+
+		if ((op->range + op->obj_offset) > obj->size) {
+			ret = UERR(EINVAL, dev, "invalid range: %016llx + %016llx > %016zx\n",
+				   op->range, op->obj_offset, obj->size);
+			goto out_unlock;
+		}
 	}
 
 	*nr_bos = cnt;
-- 
2.50.1


