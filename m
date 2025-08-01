Return-Path: <linux-kernel+bounces-753730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73286B18710
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 20:01:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05F146284F2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 18:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C695D28F93E;
	Fri,  1 Aug 2025 18:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="GmOizVTF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CCF28ECD1
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 18:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754071228; cv=none; b=pGB1Uf3Vr2CAGWwET8njWRXF0Oysq0O4n6gzcCOuGCeQ001vUwR6u8HurtHoK7TlKWh2TzxWEgh9Bqe3Ji3wWnfXb+eC4kxN6K9GgpGlIIyb0Lj2hMMx9kcKEkZumnpdvIuZCh4wN28Z+CnPdOKzt3JquAG1lYJwcCQdlM5kGfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754071228; c=relaxed/simple;
	bh=L/zCN5DqVWoqFJzonuWzb53I2szPlr/4Jcv/Fb8vfd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QH+czqQVm5wv2GXBVuqYSxSqvjSEiM1v3zwaubAs2+yG/oTSaOeKK1MVv/m2MacIHJlfVBqyK+/kAu5xoxtWHqmF0W4uQ32ARK4uRCHwZZ4SejO0PTEiW9zE8t8mFvSHyM4n0iBlJxkwQG9cIzS7i8Cdn6nRv9x8sRudfdJy37I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=GmOizVTF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 571Hg9iS008585
	for <linux-kernel@vger.kernel.org>; Fri, 1 Aug 2025 18:00:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=3TY7JajUGvg
	SQAFX3ZoHDjZ0l2tg+rnsIJNFhfiXB5I=; b=GmOizVTFpFkXh8LhaF8YLtKApVo
	4TfIABwqGfxA73oKsdDx699Dvb1VgoTq9XgleS0+7GOMI88g7klEjKW8R6oBwWDT
	55jd3WJDZZusaPyam3JgmK3W31YzkcVQgUwk/SIF2moOs3CGyMlLWioiMpWK23EU
	7WveXX9E6ihf+CijRH9+Lm6F4c6ox9piNFH+QY37X5XcVLNjpfRaNGmel4+JLlaO
	pD66DNl5cMAFZCqmWGexPnyG8v4MFfYKuyclH1U1lazq002YjO7neXWwmrCufRN0
	kuAkunvG9fZjnRVa8SR/dxub3UFl9blVg97QGG/eDd4RPFgjKakAesguVVw==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 487jwghc60-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 18:00:25 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-31edd69d754so1175530a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Aug 2025 11:00:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754071225; x=1754676025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3TY7JajUGvgSQAFX3ZoHDjZ0l2tg+rnsIJNFhfiXB5I=;
        b=TYeKp8+/YxpwIDjO+dLQuNld+9ROsDIlkAhHfY7JrP6GMv/DFyOWbxYkUk+rU2XFM1
         MOmdWtgs+2fLNG32/Rt22XfJN9YJn6ac21/9XbLxzFtv9n5Vtsy4Trj/5apbTEOYdAQv
         bRxY8SGrhAs/K5Ss95OMEIplviB9zTLh62HUKYXt9AETE/tDbZ9ey5lVOCxT5YJYrBm9
         vcPJZbecwAkPckf+qg8D+25d2U+/HdQoAy8cDVZaczHMOTFGrX3MlBs+dKgSHebJQo6A
         dnJ7//OWS7H2YV8rJrHi7eVTF5kIoQB0rs0xcWlTikWI3u+iuzDmJcx/fqZjyf7po2s1
         QqGQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXCqpUX/NSoFPbl3snTgPHsb3idqsQEvyLJbckvR8T0udoYOEY34XNfgS5A3TuyDbaS2EoGhtYVjHKlnY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7hu1gR/efnuTL5VdhaCGAMhUJXDFM3nskQ5JSd1bODWiJRLNi
	11O/G80TB7duIdv4O7Q4voIxdQsONmy46rw0HaBo1YFTKrS2ta11POpoHeJLXBUf8Fc5fxID6uP
	s1Hk366pU3tFCHPNZnKuegPK9lILc8ZwvOFyFOXIfqluloQJSWAINgjNu99g/mtP8LeU=
X-Gm-Gg: ASbGncuvnhkDpK75ETW0yQRuFgt+UX/fqUz+uH6ddZCmzp9lAG2VCSmyc3VLzDL2ybS
	r+NescHnvO2eQBVnAHa+/w8FWr+9vMW6ebMf9C/XeIS0oqOZ72Vaw77FpSSbWdEqHmvtN4sUCQn
	QBcLHZGJCCFSEcbtFRlwKsP2BiR54+Q4v55As6gpWFfaadt3ZA2z297Nbe/Ry+pkInE4Ydx7a2i
	mw3/w/o1hhQBc2jlCffYWhtyNWmFxsFs2hhIoCNaIjZs5HJriLDrYoe30aH6GeCBCeJDvoGf3NC
	cCvgJPJdggEDRVleXDjCWEP9coKSe0LB10NAXhxA0RYDITkFflA=
X-Received: by 2002:a17:90b:2246:b0:320:fe6d:860a with SMTP id 98e67ed59e1d1-3211629d087mr935851a91.18.1754071224714;
        Fri, 01 Aug 2025 11:00:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEX5MtZHVrDtRtNwnDqwNS5CiFJn1C83bZxhXU0qOaY2Ye0o4TdoGfd9YmU32DzzAJKMfk9aQ==
X-Received: by 2002:a17:90b:2246:b0:320:fe6d:860a with SMTP id 98e67ed59e1d1-3211629d087mr935769a91.18.1754071224045;
        Fri, 01 Aug 2025 11:00:24 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:5b3e:de60:4fda:e7b1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63c25f0dsm8105815a91.0.2025.08.01.11.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 11:00:23 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>,
        Connor Abbott <cwabbott0@gmail.com>,
        Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 6/7] drm/msm: Fix debugbus snapshot
Date: Fri,  1 Aug 2025 11:00:03 -0700
Message-ID: <20250801180009.345662-7-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250801180009.345662-1-robin.clark@oss.qualcomm.com>
References: <20250801180009.345662-1-robin.clark@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=WvgrMcfv c=1 sm=1 tr=0 ts=688d00b9 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=Q8ed3UK4sgpFGPsrdooA:9
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: qqeJA-Jw7gojhLaiJZc9-n8s21wzYUU1
X-Proofpoint-GUID: qqeJA-Jw7gojhLaiJZc9-n8s21wzYUU1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDEzOCBTYWx0ZWRfX+gXjuXj+yFXA
 dU108HOSe8n1tMx0CBWSQD2S4v8xIrzbREhmYSl0lEucYGWItmffjvkR4FLptRPa4AG2Iuj2KD0
 ttX6fqTAYt3YydPkocmwd89VHGPkUGCMtz6hzBhyzkc+tdchkIc1iAAlTiYbnB6goOdfdchQA6o
 Ah7IOceeL3hIPDO8oNx3LkoSd+A47p8PmiPcT8vB/nxt6auWv+HsxCxVHWZUgTKjIazbXEEWFHH
 gTprFuSK/mppsFVE2ym4lTvF5bFa7WyfJ3vDMwTjgEi4M7eJdfbIL3ul238BedU37+aWp1MPehT
 zd8Ukm+HE5dzT8vUu2GUtpOGx6ZQa5StUIHNHAJzxRm59ND/PO0kAMDRclwu02qn9oq6hLNJV1n
 SXDkTIoNpMy900oME+euFm+WbYEGLm5cCj8HUPJGz/OzxEK/pGwSZa9yZt9WRNtWv1YiTANJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_06,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 impostorscore=0 adultscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508010138

We weren't setting the # of captured debugbus blocks.

Reported-by: Connor Abbott <cwabbott0@gmail.com>
Suggested-by: Connor Abbott <cwabbott0@gmail.com>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
index 2c7a52fb0b9b..4c7f3c642f6a 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
@@ -438,8 +438,9 @@ static void a7xx_get_debugbus_blocks(struct msm_gpu *gpu,
 				a6xx_state, &a7xx_debugbus_blocks[gbif_debugbus_blocks[i]],
 				&a6xx_state->debugbus[i + debugbus_blocks_count]);
 		}
-	}
 
+		a6xx_state->nr_debugbus = total_debugbus_blocks;
+	}
 }
 
 static void a6xx_get_debugbus(struct msm_gpu *gpu,
-- 
2.50.1


