Return-Path: <linux-kernel+bounces-881989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D5DC29635
	for <lists+linux-kernel@lfdr.de>; Sun, 02 Nov 2025 21:18:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BF3C64E1E0C
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Nov 2025 20:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3D91DC9B5;
	Sun,  2 Nov 2025 20:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eWBWx/yB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C3qVeoht"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C4E33086
	for <linux-kernel@vger.kernel.org>; Sun,  2 Nov 2025 20:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762114698; cv=none; b=ZyW5vaTrLcYiMVj8FeYw/yDItow2tTj2jX1p8W6hXHGR8kr7oBAQt9EzY9FYA0/L7qcI2GpGTT/Y/qB2J9ImUxc+tQu+0o8FQS1HYoYrTOoXUkGmm+a/0b2bu0gxKSTvBQgPCuwwwUxeWVwhVAGwDVNLrU1EcjkPmEAjtRXX2Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762114698; c=relaxed/simple;
	bh=erLQdH2hFyuTRZMYIjIe/j6tIxDdwbeINvkt2RfUKbo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=W5UKYphn18eJpbFwd5CEEBKCF3e0DJtOO8jHwe+gd49R/E2J+WR99Hjltz4MUo8AMbBNMusZNv7+AqITAIlkWNXnB8Xsi+QPHytov4kVTBGNDAvdhB8w+M9mTHLIr8HU/ZWLpUBZlFhbcNwlNMkgPgn2F/GkKAYKBvKheTDhLq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eWBWx/yB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=C3qVeoht; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A2Gg6Qx653176
	for <linux-kernel@vger.kernel.org>; Sun, 2 Nov 2025 20:18:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=OdVVm5Vn5j16GpFoAhqQIq
	kr1rOrtokzqAEudEAWiB4=; b=eWBWx/yBwG72a6CpbkESp/9Gkwnt77AY/pYIwS
	yYqyC+jqv8tPPpasAzcKX2ocmcQeO+wWq1d7898YSkuvqCkSwI7R1rPjxyAQ6Z8F
	0YtfdiuJwp5evM8vkC+u32rVIcTUswoeCkp1lkiLl21HDkX9jCEv9NPPmyVBxNN8
	wwsa2otK4V6BRpNwmCeO6lVcTpnauY+RTyssg6Z/1ynVA0bHBRiDhR4btXmEsq9z
	3kzbS7Ljtfnm4hnLZvJAO+IMH3n7vPTOpJJG+/pjKsS5zqIghfXd0MLrfpDj6UGL
	zCE9X6b4/yqu6GD8M2//ibphGpg2xa6ARf8a8n7ubcu6HxJQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a595rtp8e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 20:18:14 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4ecf1b7686cso151806821cf.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Nov 2025 12:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762114694; x=1762719494; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OdVVm5Vn5j16GpFoAhqQIqkr1rOrtokzqAEudEAWiB4=;
        b=C3qVeohtF9TOuMnXaklc8+zsJOyOW8/Acm/zuuRNEsaAkJJDTStI8s13+u65WsViPN
         25i0atlFpXgt91JWvmFM3PLIteh7OKH/ICpbLmrWC7KWqASpp2VlitW/DbFW3raPOzUU
         Bn/DwYgNPv7f1lV2yrU84fXp5OzjcbGSZ5R3RfbYAByoco3OlZBTiwHIOQFaVrEy857n
         v1GxcuRJ3hwHKPljwI9YwU1bVNCzfOEx0xhOSuVxaNwK4mTrM0ooux3Q++UbOXtdgHZT
         RqvtsGrdLtWIohuFLZqorflISOKvYd5tWPaqd5s6HX1E2zFrCPMIvoczoQq3RbfwdmEm
         0nRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762114694; x=1762719494;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OdVVm5Vn5j16GpFoAhqQIqkr1rOrtokzqAEudEAWiB4=;
        b=XTlIzROxdy4NQ1XsQfk/tu6qKUr/QU6veujyx+8s4S5vTxuo3CF4x77HWSvHIv0rTZ
         ZYl47OOPifsq4tWBHooUuPaaeQiILXvZrv3clbAgWBl3fjlIORQeC87Dfi3Cfq1KEEk6
         hqkLBrSJoHeSPKCICzqaxhTcovzfeKS9tJss7nhZpr+cabywPShp+26G/kdWIwzXHr2x
         jj20c1zpK1ZJKLjvJhrMBkQCRgej/GkXDixFQmj7pWOkFPyj+9pvNA8SSMQ/VbkJCS0U
         QJtQ11EegX8s6zl/iuJqEhg/+TIMLEAqDKvSoWJ0JruYrnTPHCvKao1+lchTG6DCSBh3
         2SnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLFhooxCRo6cyY0q845WSZF5bcXuQC7NHnEMtZg/S0E0Kj046EstzAbNo3WsB8x1jmE6cJdADTqTnVGtI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNUq1+aQy/X/EIh+NXEPgK52WgbDLuNgKv6JE44m3m3Ulb8cDh
	OJ1FYHdvdXy38dQELud0D6KgC1aWbnlsbHLbqgeqxKe085fkHWDbHLFVeO6oN8NyP8yrQ2xxmVW
	7PFj46yf2fXAkYFySZXqdhrLf7UsjZfVQ/4BuFSaEtApwuqDyNYBdV3Aazi2UU/DPNVs=
X-Gm-Gg: ASbGncso62rw/cKMW4ksEWJa2Y8Rvyl4L9rp6PI9TfS2OHoL9nkcJqpCSawLQW3Id7y
	DnyQfCQ27ZdVQ+Mj3sXwyWqA6+m7Tp3G8ALS4JyXNIaDKHljmJld4ozyMSddz58AJHPPpnLCC1D
	mUmUO2zH2a2jIHX1fjpR0GMPoNSh2IpvemF7WCLQ8y84bDuChfpaC1z/D25gA5Mvj0isuH5DZUk
	Sw+IwxH3qysMxeYRWeOqlAJbq7z4mJcv7q7SeONyXPYAq4ngu4cS2aOqoUFPqv5DVg5lGhSwOKh
	8IscV7WqHf/qA/GtOs2YNm0JP8uzfBCNpf5s6cNch5MIqwGxSI7ae97g12A47w3FzUHtQUrG9kH
	QUJV/Zg9laL4tPhW5UvZvv1I6Adxzxn2gXiM87Qo6rl1lfRrGTfNuxy8Bgq89liADYdZTvhdhtT
	WO/CvuQvB9gzEF
X-Received: by 2002:ac8:5a93:0:b0:4e8:a1f9:cdd4 with SMTP id d75a77b69052e-4ed217b672fmr170989271cf.1.1762114693610;
        Sun, 02 Nov 2025 12:18:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGNY0tTsWpJIEVOwgyhh2aDBh15yHlc+p7d7sVA9dguQynWO7J16BHzPL9ZYWnQ2g3x4FEhEg==
X-Received: by 2002:ac8:5a93:0:b0:4e8:a1f9:cdd4 with SMTP id d75a77b69052e-4ed217b672fmr170988921cf.1.1762114692957;
        Sun, 02 Nov 2025 12:18:12 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37a1bfb45easm17907781fa.16.2025.11.02.12.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Nov 2025 12:18:12 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sun, 02 Nov 2025 22:17:48 +0200
Subject: [PATCH] drm/msm: fix allocation of dumb buffers for non-RGB
 formats
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251102-drm-msm-fix-nv12-v1-1-096dbcb4a51f@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAGu8B2kC/x2MSQqAMAwAv1JyNtBEBPEr4sElag6t0kARpH+3e
 ByGmRdMkorB4F5IktX0ihWocbCeczwEdasM7Lkj8oxbChgs4K4PxkyMRLuXfm1pYYGa3Umq+5f
 jVMoHgmpqXGIAAAA=
X-Change-ID: 20251102-drm-msm-fix-nv12-11f0e8c31b2e
To: Rob Clark <robin.clark@oss.qualcomm.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2149;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=erLQdH2hFyuTRZMYIjIe/j6tIxDdwbeINvkt2RfUKbo=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpB7yD/G8dYX1IJ/v5RG27i7L8oP+YwceUGEdgy
 xxQklGIHouJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaQe8gwAKCRCLPIo+Aiko
 1YAlB/9GFWDG6Qs9XLi9san0VImTyWb/8ucy6+dKwfetnjjNWWqTV6h9suB0PIILnfPIg/PvwWR
 HSNwXfM3XHKNL+ap2sUdQ1/2zyqeYN/xgSXQzDherzVvdQ6JYyb87GrkigsAvK1KNURR5B+KhP3
 RDuf0rkmPcK0qVB70Juu3bUznxyVR7vWMsin/XP9HOWYyi11I+VJx5fE0Pa8RYmkYcVC5lsL6p6
 HFB2Z7SbxxwfCFUX4ylfzgD68J+OAhPZEKiVASwIxQKosrFAR2A9vGNM+mhaWzKT9v51A0UeC6W
 gEna0BLv7NPDxHlGTYOkuBLUZ3wU2u1uNDlODZbduVbi8s5l
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: EPJQEZE5Y7pc2gHi3Vh4hIqrZDTcSGiT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAyMDE4NyBTYWx0ZWRfX+X2KK8Am9Ycq
 tF/wiJW7ip7KzTVfEqDKTlNT5Ug6fD7tSY2F3xzJkv24HypyaTALBQs2X26I/Mx0UP2dRvRZVMU
 8oVpZb8tfIQY+JBGyWdDbC7uQCDQ9JBioybjXgs/9iBkIOmKy/P6ctv5QtGScOoISmN64KNXphD
 FeJnNAjMqASkD4gbR8E0tvlQwrW3O+dQVac7Ts8Nx8+06WI+uvnMSw7a0aft3h0e3xBXwguvaU7
 FRixuO+dnkgrmircC61SIxMEEmIBrWVVKE/ZGgVl/luvoDTyyoG7tdAAslEenVEDsYgBnARg9vy
 NxrbgDkcZozMmwfVAbExqmMjridxdY88SHwiQRnulH3N49JlzyMbAG72tK5ABLkFfXvunDte81X
 1tP+f8D/lN6B2s1vIEK4wo0cp+JIHg==
X-Proofpoint-ORIG-GUID: EPJQEZE5Y7pc2gHi3Vh4hIqrZDTcSGiT
X-Authority-Analysis: v=2.4 cv=XYeEDY55 c=1 sm=1 tr=0 ts=6907bc86 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KVldPKIrq6pl5aLy4YAA:9 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-02_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511020187

Several users (including IGT kms_getfb tests) allocate DUMB buffers for
YUV data. Commit 538fa012cbdb ("drm/msm: Compute dumb-buffer sizes with
drm_mode_size_dumb()") broke that usecase, since in those cases
drm_driver_color_mode_format() returns DRM_FORMAT_INVALID.

Handle the YUV usecase, aligning to 32-bit pixels.

Fixes: 538fa012cbdb ("drm/msm: Compute dumb-buffer sizes with drm_mode_size_dumb()")
Closes: https://lore.kernel.org/all/vptw5tquup34e3jen62znnw26qe76f3pys4lpsal5g3czwev6y@2q724ibos7by/
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 435c0067c2641786ca7b4a42cca0ae7e7dda3451..b9cfdb2ff33b63b92cff2568db491d0692bbe459 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -701,7 +701,6 @@ int msm_gem_dumb_create(struct drm_file *file, struct drm_device *dev,
 		struct drm_mode_create_dumb *args)
 {
 	u32 fourcc;
-	const struct drm_format_info *info;
 	u64 pitch_align;
 	int ret;
 
@@ -711,12 +710,16 @@ int msm_gem_dumb_create(struct drm_file *file, struct drm_device *dev,
 	 * Use the result as pitch alignment.
 	 */
 	fourcc = drm_driver_color_mode_format(dev, args->bpp);
-	if (fourcc == DRM_FORMAT_INVALID)
-		return -EINVAL;
-	info = drm_format_info(fourcc);
-	if (!info)
-		return -EINVAL;
-	pitch_align = drm_format_info_min_pitch(info, 0, SZ_32);
+	if (fourcc != DRM_FORMAT_INVALID) {
+		const struct drm_format_info *info;
+
+		info = drm_format_info(fourcc);
+		if (!info)
+			return -EINVAL;
+		pitch_align = drm_format_info_min_pitch(info, 0, SZ_32);
+	} else {
+		pitch_align = round_up(args->width, SZ_32) * DIV_ROUND_UP(args->bpp, SZ_8);
+	}
 	if (!pitch_align || pitch_align > U32_MAX)
 		return -EINVAL;
 	ret = drm_mode_size_dumb(dev, args, pitch_align, 0);

---
base-commit: 98bd8b16ae57e8f25c95d496fcde3dfdd8223d41
change-id: 20251102-drm-msm-fix-nv12-11f0e8c31b2e

Best regards,
-- 
With best wishes
Dmitry


