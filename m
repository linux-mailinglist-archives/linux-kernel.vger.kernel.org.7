Return-Path: <linux-kernel+bounces-749541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55FD9B14FC8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 16:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A4F6174EA3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 14:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5219228724A;
	Tue, 29 Jul 2025 14:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IiqUseA7"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E011F78F2
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 14:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753801063; cv=none; b=CjLUIQx/PFelBsbcQs5aFoudsfzapd5ZzjgmEvYEsejz+LL6uyU2uNaPFBQXLZFZ28aZmiQ60H3PSi9REJ/NRssdv9i7NnO11ZVT/yQHRCtKcBaHIZw7gLkAIOApF/RR1iIVqGVu+u5xR2OFvOYLQeGYuXGphbrFwtzxn1qokfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753801063; c=relaxed/simple;
	bh=e6x/dDP5ia/NlQH+0MKdj/wLpx5h4B+ZdMfBV+aj6qw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y72J4Hx82UDeVDzgyzNOzuYxBsc90JxilECczdJdJu7BkBhxYS8rOtlwXvAFHvf+DPwjH7is6duiy4+LBp6myn8yJbcpTY+Ta7swWxtsvk2TvLcwg4rlOZbOT+AR1rfTip0BL46hdqJlcduWp4Th4ODBwJDPZF9u2l9LZiTXjkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IiqUseA7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T8rsLb023590
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 14:57:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=0qBkf9JDSmf
	FwdkCS8a187SNR+0cTRqqV9Ya3fpJH68=; b=IiqUseA7ZxZPmNVf5O8ZEZd1UjI
	snNXRY+1zeGSC0McZYDyiy3tCUSqCWZKN5mQJbLK7Gg89m1ZgWtPV7/p5wxlq/0M
	nUW2js4rF28MoR8IZJtfLwdB/+SxEZ89AZ+20387HNM3Kn+TtpUzc35HkkOFAIVs
	nH1ChZ1XwEWuKW3c5gGgc3o0iB4rr6pbROPIU/K4mEft3R6ED0X+eTIEyXzIyeF7
	VU+Nly8soc0ZPqljK5L8SNDaqD7O77bs1yKd8CMMaKukeSBWyMWe0LsrGAjgprF5
	tMmhAUIJX1songUbbQ2tXmdkk7UJ8uc48fv8Jjua/b88SH1Qvuium1K34Ig==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484r6qrfvw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 14:57:41 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-23fe26e5a33so39044345ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 07:57:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753801060; x=1754405860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0qBkf9JDSmfFwdkCS8a187SNR+0cTRqqV9Ya3fpJH68=;
        b=B4uoclpSD910LqnruCzqflnvRuYKeoYptnufE0CKpp+nFhTWDljakg0KPYDKMUb7la
         ailo9GicKUAq7vCRwBTfqvogzPI2F5OebOKHzJTmb6E+tqgbT/dCsofQhDEqvLx7lyCc
         SGchEgUHPdENaF9i/ZQD3Z9QOv/tzjzBBZ3QugZt23vZUwcLpMg/zp/WzpiDscTopvXQ
         q52WAyFDZP53ZNOPNm4doj2w53pRyVb1tT9tWnbosIV16FE8Ng28K8eTcSnYX6ly7jrf
         Ok/yuw33GRemH4lzlBatiZOxUwFQpYwLlwd5gJBei9WCiEB/v5JKueHC+wI51SCwcJ9J
         9I+g==
X-Forwarded-Encrypted: i=1; AJvYcCX1BByao8LTYXzcoDmjKbobUAKsXAVq4j8hObLEmn0FXtzM/jayPOu1HUTFYfpUcd/VX+9x28pdLA62g+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfKROFFl0akS+HE1qJLe1qqkjZr9dZ/QMMBIZzf6wxIHwflkoY
	skKUy2a6w07IrCStJjCX30Ua5f9yycESdms7QPsioArWHhS1Ssm8RK06tP0aFaiFsrnSxJlnUu9
	+wXyQEJvuEfzWS5H/fs96PX+X3lQrq1Rt3vvBBM7Q0RvC1w5AbNqp2Rt2jASJ8biVQtY=
X-Gm-Gg: ASbGncsWidiqYjlXbLHHPeKQquPJLXXo9/UZ4vSuV9e99+4AaJr7fpCGQnms22jbTBW
	zAZGQx4A/AuuDdIpnFixXxVbVAHhP6ocixmFyu8wqpdDZSwVt3e/QBcUNIP//ydfpIdYDxhLGzM
	nm9Aw+47lde2AKOi4DqV/QJKMav8RCiKfC4nNbNd/xfVk9IzPLokNa7HSmEQod3dc1Z4oVSB68Z
	4rJFVA1U3ZECSOue2O1RevH9V1OE0Kq3vTGw09AWOVSvWxNWvB9VoxNhd39q0ZZw5NXyBKHAH2a
	Bt8+CxgJiSHEb9P7j7b5cAiPO/dIWCfl3Cb+yU58H6EIwycCHaY=
X-Received: by 2002:a17:903:ace:b0:240:1953:f9a with SMTP id d9443c01a7336-24019531719mr133423945ad.2.1753801060222;
        Tue, 29 Jul 2025 07:57:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGD4GKtP2sJEpJJxujTV2ZRkIuCi7nOh6GWilBcpkOTveTX8D8XdwMAVNRZGCDv3ocJrDEVyw==
X-Received: by 2002:a17:903:ace:b0:240:1953:f9a with SMTP id d9443c01a7336-24019531719mr133422875ad.2.1753801058983;
        Tue, 29 Jul 2025 07:57:38 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:5b3e:de60:4fda:e7b1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24029726586sm48279835ad.19.2025.07.29.07.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 07:57:38 -0700 (PDT)
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
Subject: [PATCH v2 1/7] drm/msm: Add missing "location"s to devcoredump
Date: Tue, 29 Jul 2025 07:57:18 -0700
Message-ID: <20250729145729.10905-2-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250729145729.10905-1-robin.clark@oss.qualcomm.com>
References: <20250729145729.10905-1-robin.clark@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDExMyBTYWx0ZWRfXwiplwFgl7iC9
 UXZHFL1pAaUOnsvNNRpdu+xjvzWfCIvAyYXzBfythWm3ng4aP5iofjw4wRPCBbuJ+7Bgg+CtMp+
 tjIxhi5E0o435mIL3QduwBLNz/YKAS7ODzb5uclWvBdkTrs6crI09gtEiMcmIjzjeeH7LgrRo8Q
 /CDVbbliBlxAqUgm/yc4xGhLUx/rULBsKlK6ysotOzq+nVanYr+D+ShiQzWQ1Jx+VASd1U7cyMk
 MMDZg7FVVC9BYDjHlVwzxpwBCMNafrdZH4ha1Ba0HJ0C27sFUl8yBXkfua5w+qxL/0mxNW7Jsbj
 xiKU8iM438KUbdFKYG3NsWfBpBW3rPFbgv/fOCJ63gQrJpHQmm9c58HtDr3XFKsDCPhG7qQgwnt
 7i5oJgxadte1ouLQKWX492SspfdBUCzYzZcjdeBk2sSOpLGIErNBiuaNVuJP0EhXi9VYlhkK
X-Proofpoint-ORIG-GUID: -UTFqw6lZN4Es9puBTuAYCO9R3782T20
X-Authority-Analysis: v=2.4 cv=ea89f6EH c=1 sm=1 tr=0 ts=6888e165 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10
 a=EUspDBNiAAAA:8 a=YFM8xwheDJGXjHaRWHsA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: -UTFqw6lZN4Es9puBTuAYCO9R3782T20
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 adultscore=0 clxscore=1015
 spamscore=0 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507290113

This is needed to properly interpret some of the sections.

v2: Fix missing \n

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
index fe38ea9328d4..a35cec606d59 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
@@ -1800,6 +1800,7 @@ static void a7xx_show_shader(struct a6xx_gpu_state_obj *obj,
 
 	print_name(p, "  - type: ", a7xx_statetype_names[block->statetype]);
 	print_name(p, "    - pipe: ", a7xx_pipe_names[block->pipeid]);
+	drm_printf(p, "    - location: %d\n", block->location);
 
 	for (i = 0; i < block->num_sps; i++) {
 		drm_printf(p, "      - sp: %d\n", i);
@@ -1877,6 +1878,7 @@ static void a7xx_show_dbgahb_cluster(struct a6xx_gpu_state_obj *obj,
 		print_name(p, "  - pipe: ", a7xx_pipe_names[dbgahb->pipe_id]);
 		print_name(p, "    - cluster-name: ", a7xx_cluster_names[dbgahb->cluster_id]);
 		drm_printf(p, "      - context: %d\n", dbgahb->context_id);
+		drm_printf(p, "      - location: %d\n", dbgahb->location_id);
 		a7xx_show_registers_indented(dbgahb->regs, obj->data, p, 4);
 	}
 }
-- 
2.50.1


