Return-Path: <linux-kernel+bounces-738210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ECD4B0B5DB
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 14:17:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C1621896E72
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 12:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721911B0414;
	Sun, 20 Jul 2025 12:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MVvYvTWT"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030B5204C07
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 12:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753013818; cv=none; b=rUqu9jzeVB0VMTm7hZB/KeCKlIF8fTKPARRjfodXDiFp/Kkl9a7tC/NPtbRDCX+tuBbIiUyfFYknASrd824hjPGt05iZ3sUerwgdZdeuO/OM6YVKHmYxhc1IxyWTUlAyemABLL/7hjwzE8wqTOi5sP74weQeJozi72/a2dXjVMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753013818; c=relaxed/simple;
	bh=ji+f74TQTXhSJNywxVcexEvz4zhxi/UIu3IXlExTfoA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B3McKHNPeNLpBJZHkn5ewG5gTiECqDQNYXW6OsXL3bbavQwmjWudCNHpKo7/1ltfDyRfMyuvxUC/m4JxpIya3TFsJ4lHtExsHz/TQBcWjhorCmiIeNkGPUku+F7YIEFwh39t0hGJF0Hs0wln9qSx0jk5iISngo1Ww25Pu3B4NIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MVvYvTWT; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56KAPHbJ006942
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 12:16:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	RghYj3as/mFUON2I1wz5/fAj1x0bQSOJ2EkHGXZdsjY=; b=MVvYvTWT9/RfiFAT
	mRu0Jvbz2/SOQ/CrUd1Mu1oI0E+n2YTXKicJ2IkAFeIwuVOoaQdV19qqpE3sk6mT
	FrfaEr5UdLhTAlrdCpGFF8IyEUshtjAL0Vt9zkLgoq20I/TKv0FSNxN1OeZZxPpL
	pm6t8qP5RVtz9aYEZLSFMvqdiThbKTcrTaGvZl7rT0M3ZEPzdJbBtdN4qFzG9Guv
	m/yfhQHYi+Um0DquLTB2hQs23iOlvWFsOEfp0gIFv8Qsoa9YnBxmTrU/rDgbOcpi
	tSmpkvGSQGFYP4RGikOok6ahRlS35RMdK9VhaoLjzqR9fuxnfevXNBhQgx2I52TK
	/VtpMw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48044fa72w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 12:16:55 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-748f13ef248so3327923b3a.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jul 2025 05:16:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753013814; x=1753618614;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RghYj3as/mFUON2I1wz5/fAj1x0bQSOJ2EkHGXZdsjY=;
        b=rYjH8y89QCg7OkeCu9+2wJKx1u4jQ9dcTZ1xMC9jE4BrMxa81iRgEjQVn7s3+d/KBh
         HOnfHI2KMA2x/oFBlCIlzPGPrE/yyJBN96QKJlMHbnsdbhcLtAAPK9XY6ZRQ2CiUu7PT
         8nzmDPfaMa1s0Dlmdzr5Yu1fzQ1pbyKdJOmqK4N5EDnvjGZOg3gJYC0ERYBHV2mT5WxB
         NRYV21lDln/klNZWigajN4sCd2Quewv46kOwf72OK7V9wDor/EKitMvVQziOBMaAqDq5
         EeyzeAV3F7pei9tIoUxERbgbavN01JBwzJZOyrWW7RixGWSGUfXqBpUHio66CWI+NTJP
         SdiA==
X-Forwarded-Encrypted: i=1; AJvYcCWrnc22VtNdjEEzxxvJuefsk+lVc7y3URZ5qLwr54KnVK8xWt/fYkUG8HO7BvZvlwiCuFbFcEkAWEkS3yE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdHrM/4BqB5WPzoV/s0qLsQ8T8mONpqSsG7PPjrQ8j5nrTmM8f
	GSMkQTNV6zAYqmVmJvyIhtOnid7Awt7OwEDbVgg10ZkTvFKuzCHu4FG0i312fwRYItdhparynQq
	l4/nfqYcjSYthL6J71vB+0vPC+dQA+urH5L1zJgjobwkMOaiw7bOvQB7MY+3Wv31dNeA=
X-Gm-Gg: ASbGncvNf3UEcqcLr0xy4cOot51P7YC7ZF6TgOx+lbO8NQtBGTlRiCkG5esrpTSD4P5
	evI2JDx67f4YZ4t6XgqV8Q8WHoYk1wMSABMExj6IbQZ40mvbjP2NySC+vQvUbpabiyEf/RFGkwV
	3ku+VbfvFytUwU3g2rYvQjCQN4sJHB0nXX0sOaO0l55snZViUlCvWk5CoRxOsaxs3dEOcb89wvO
	V265XK4Mg90QP8uvbtgHN1I0lc1XtVoCGBdEWwIAhcOU4noO8N/Cszi5/rEe0XijIQapTpxP97i
	bq4uw4cQB0Ez2A9TNtbSCj84d599ZW4DfMz5FjkGVyrvndzYa6cqxI/CL91aZKI0
X-Received: by 2002:a05:6a00:2e27:b0:748:3a1a:ba72 with SMTP id d2e1a72fcca58-7572427e405mr21973331b3a.20.1753013814141;
        Sun, 20 Jul 2025 05:16:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHm+33dVG/fds/ip7b4Ih0P+9rPGCwWYA2APgeQY1skgsNIAhOHZiM8LTIZzxoKQic2JN+5Ew==
X-Received: by 2002:a05:6a00:2e27:b0:748:3a1a:ba72 with SMTP id d2e1a72fcca58-7572427e405mr21973302b3a.20.1753013813630;
        Sun, 20 Jul 2025 05:16:53 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb154755sm4097933b3a.69.2025.07.20.05.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 05:16:53 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sun, 20 Jul 2025 17:46:02 +0530
Subject: [PATCH 01/17] drm/msm: Update GMU register xml
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250720-ifpc-support-v1-1-9347aa5bcbd6@oss.qualcomm.com>
References: <20250720-ifpc-support-v1-0-9347aa5bcbd6@oss.qualcomm.com>
In-Reply-To: <20250720-ifpc-support-v1-0-9347aa5bcbd6@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jessica.zhang@oss.qualcomm.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753013805; l=2416;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=ji+f74TQTXhSJNywxVcexEvz4zhxi/UIu3IXlExTfoA=;
 b=DzsW7cZ/8jSLmGH8hgbMy+4u7Cb41SK7Sn6nWDaSM7JFVA89fFUVKAqxE9i28wKmCfy1N64KW
 xs8lQx1uahLCy34eKdSSDxVvUFlIXiaM0Kf1ehSyEE7hj7qDtvNcXvD
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-ORIG-GUID: cC1ANHTixNkqfO45qf7AL0sjB2bJMGJ9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDExNyBTYWx0ZWRfX4YPGhfabvszx
 PzM+W1Q2yY2r8fFmWc5c5UwZ8/pyGLuBGFjWGfA4G0Ye8yyI8r4V+s9ZuViAZH5alIep66lAyhs
 geiIjgD3iqWwXbLJ/ggqVkJZ9KhoI9H3zKXnqbRY2thJlnBSSoQX5bKztF8yRC10VpJWHuJlauW
 rONIIi+cZPF8wl12pDMjlpanjTee71BYBz034LFy71T7RuQlxm+Nhe6xD4Ku1+wewZh414u1FB3
 wx0psyG2Xvhaej4jbjJTT85IGFPlDe864UfNvEn+hi7Kyd+ZsLOsaLFc8odnoLN7NWmm73cLu+x
 LTcmQXHcZmddAqLAfSVDEDKgJH/ksst/9GnU2JBTtJ0RML3gl0vSjiyp284lv5jCAFW69wYNimH
 mgR0DlHyzppY0mHKm0krIG8z7T33LG1Ywe9f9qnk9CTnqOt6QGncWxDcA9D+96cHk8gcHK0R
X-Proofpoint-GUID: cC1ANHTixNkqfO45qf7AL0sjB2bJMGJ9
X-Authority-Analysis: v=2.4 cv=YtcPR5YX c=1 sm=1 tr=0 ts=687cde37 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=e5mUnYsNAAAA:8 a=EUspDBNiAAAA:8
 a=FORX3M3cBL6yUa9eRaQA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-19_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=891 suspectscore=0 clxscore=1015 spamscore=0
 phishscore=0 adultscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507200117

Update GMU register xml with additional definitions for a7x family.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml b/drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml
index 3d2cc339b8f19c8d24b2c9144569b2364afc5ebc..b15a242d974d6b42133171c8484d3b0413f2d3a4 100644
--- a/drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml
+++ b/drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml
@@ -99,6 +99,10 @@ xsi:schemaLocation="https://gitlab.freedesktop.org/freedreno/ rules-fd.xsd">
 		<bitfield name="GX_HM_GDSC_POWER_OFF" pos="6" type="boolean"/>
 		<bitfield name="GX_HM_CLK_OFF" pos="7" type="boolean"/>
 	</reg32>
+	<reg32 offset="0x50d0" name="GMU_SPTPRAC_PWR_CLK_STATUS" variants="A7XX">
+		<bitfield name="GX_HM_GDSC_POWER_OFF" pos="0" type="boolean"/>
+		<bitfield name="GX_HM_CLK_OFF" pos="1" type="boolean"/>
+	</reg32>
 	<reg32 offset="0x50e4" name="GMU_GPU_NAP_CTRL">
 		<bitfield name="HW_NAP_ENABLE" pos="0"/>
 		<bitfield name="SID" low="4" high="8"/>
@@ -127,6 +131,7 @@ xsi:schemaLocation="https://gitlab.freedesktop.org/freedreno/ rules-fd.xsd">
 	<reg32 offset="0x5088" name="GMU_ALWAYS_ON_COUNTER_L"/>
 	<reg32 offset="0x5089" name="GMU_ALWAYS_ON_COUNTER_H"/>
 	<reg32 offset="0x50c3" name="GMU_GMU_PWR_COL_KEEPALIVE"/>
+	<reg32 offset="0x50c4" name="GMU_PWR_COL_PREEMPT_KEEPALIVE"/>
 	<reg32 offset="0x5180" name="GMU_HFI_CTRL_STATUS"/>
 	<reg32 offset="0x5181" name="GMU_HFI_VERSION_INFO"/>
 	<reg32 offset="0x5182" name="GMU_HFI_SFR_ADDR"/>
@@ -228,6 +233,12 @@ xsi:schemaLocation="https://gitlab.freedesktop.org/freedreno/ rules-fd.xsd">
 	<reg32 offset="0x03ee" name="RSCC_TCS1_DRV0_STATUS"/>
 	<reg32 offset="0x0496" name="RSCC_TCS2_DRV0_STATUS"/>
 	<reg32 offset="0x053e" name="RSCC_TCS3_DRV0_STATUS"/>
+	<reg32 offset="0x05e6" name="RSCC_TCS4_DRV0_STATUS" variants="A7XX"/>
+	<reg32 offset="0x068e" name="RSCC_TCS5_DRV0_STATUS" variants="A7XX"/>
+	<reg32 offset="0x0736" name="RSCC_TCS6_DRV0_STATUS" variants="A7XX"/>
+	<reg32 offset="0x07de" name="RSCC_TCS7_DRV0_STATUS" variants="A7XX"/>
+	<reg32 offset="0x0886" name="RSCC_TCS8_DRV0_STATUS" variants="A7XX"/>
+	<reg32 offset="0x092e" name="RSCC_TCS9_DRV0_STATUS" variants="A7XX"/>
 </domain>
 
 </database>

-- 
2.50.1


