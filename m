Return-Path: <linux-kernel+bounces-883273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 28254C2CE4D
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 16:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 491484EED6B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 15:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5242280A5C;
	Mon,  3 Nov 2025 15:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="d7kIV6RQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MJzFsCDt"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA8E1C3C18
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 15:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762184630; cv=none; b=f0+ugBY+Rk8KQKWrU3vjdbN/t0m7mwtZDGW5XhxeWoXFxWcolbTJ86EpzY7yjdcxw+NUBtGCBFx+7JtQ3RWEqY/cTDsGNl1jV+hBRL2kQtvCdUORp/SF+TF1wUQ9ZnkhTtnjfVkZDnIF86jhqY8q55sSL5h6pbrHJ52W0TZEGqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762184630; c=relaxed/simple;
	bh=eI5cBu6QQfK3tjsQDS+FvtnmilDLe0nXXkJB8PTH17U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=JjQ3HBmq8H960T+ubgXuO+XoZlAZeaxouPd2CMScn3VT/Hr73TBKIq2TxEhlUR/J8AiHwW8Sznq7A0eq8yEOFFD/plncF8JovrKI+RqmjQVU9JdvLBH0xIgV2/yZ4zqehS/g5MtKIOP5iHxE0DFia2VXT5GwS99TSdKJ783dEio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=d7kIV6RQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MJzFsCDt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A3AIT6x2755736
	for <linux-kernel@vger.kernel.org>; Mon, 3 Nov 2025 15:43:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=MLSUVL0011U+bl1QMn4/8R
	YN+a6NKJhjMZdbnPjm8I8=; b=d7kIV6RQuk2dJu82om2Hyg0nCJdmJFIbieZBex
	UcUexBkW1A1pHw1YLH1oEZCEYQmiZyG1tTg+W+EMJjVc7J5itpALy1cgKv8fWoXa
	/Mmua1p2EkDmlEkVw/K5y4lpc8m/DUv2CQ6+gZfLw/Nl2LNFQCcXFplnTfBTApQy
	VfRThU2RC1Q/eVkipHd4nJLeOdd/dRSRi/eL389i/JIpCwTnLeU93ebfb3/oKUVa
	cGBX2AACTL1F/lbp3MEy7RbKsWlFpNStdqW3a8fcbbzZtvwANsSFu5kEghvSuh+a
	AP17TfOC1ARXeGOMB/Y/Kyg8aAsXDoWU1uqv63YR0MQDB+EQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a6th9rtvx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 15:43:47 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8a6fc271d46so1309204685a.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 07:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762184625; x=1762789425; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MLSUVL0011U+bl1QMn4/8RYN+a6NKJhjMZdbnPjm8I8=;
        b=MJzFsCDtRGdVs+pMnlYyFfqeEEcJTjRUatPUNkzJ3bFAtmMBPJxjXmL6xbiPMCU7ki
         Mdi3SpqfLIGKahBrVUjZucb9zl/WWqDGvmP+yEszQ6/S9BTDMTrWdONL8pwngDNxzCqr
         lzdUk1TDhXVt+tkMX1tiJ3f8sX/hr2OgQGcutrgZ6O/GqeNFdlSZcG4c/2dTb55zu9sh
         KRO6i4ZLS6SYQycacE+v/D4h1q92mJwt0JmwG/6SRfYsjWzAZC6MpIsl4J+uSA0JRyTF
         vtNp7wgxMrcukHQ0QuG1vPFAGMziGiCEFZT6C9+gy8rCMY0YBG3GMpj+xi9wgCLTh1Zn
         fpzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762184625; x=1762789425;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MLSUVL0011U+bl1QMn4/8RYN+a6NKJhjMZdbnPjm8I8=;
        b=a+jp4my1jPzdYWqZMK+S4ooobCa73YCo5KWvNXGZt4JiPqYOdbfk4k/ZQJTMn9z+uD
         otHruNUMUagEQfZGcw8SY3N6s5xGnzTVXLhzeIv9ej9aipBH4uYuxrYUd62oamL1+1cS
         WaeSHz4NJOn8kjh4koqdaPFhD/PTcPXhDEMISfNAfvJkkMYa6Z7Z7H5BLa29YS2YW4XQ
         DpTCOdxpPvSd19jEL6i8FEAqQhiMoghOUN09mZBYEeCDybQ54VNoKfuHP6d6p4uxjMdI
         ur1UZ8goq2pwTB4iI66L0/zuVXGMCMGS/VA9QN6reM430xvDRgKB8W+wFKfRYW03EVQj
         M9rQ==
X-Forwarded-Encrypted: i=1; AJvYcCWpiMNf0IYown2hyt0zM8uJJpVRdzVvyIRjp26GmUWkCNyuYGeKeMGC8C7yZ2riGdsgTTlQnK8Bm9t6a1M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJv1XHNuV6q7RPWDcVxeRmFQvLVpXQirI70z3OMjwdbfiQiPaZ
	x0KcGCGGp/d2IfT9tJ2uZbFib40mwpxJ+QylXRzPuAPRqA6voTgAzixYTCizH8qRO2TprZc5fCU
	wU4nBM/JNac3juIpOUNXB3NrBV50JwCgHyQy/TwG3tEAysK/Py1xx/ViRe88FFO0INqA=
X-Gm-Gg: ASbGncuxy7Qc0r+ere2m7wZAXMpzYILkubKG2Vk8MOuHl2Y8zTnwotGKKmB/svj2NkB
	oaf7r2ryaQZMTJiCYOwyDrtIVPeshjQb32OmvfS3i/10c4H6qW1dxP/BP4lrbZhwy/3Ks0Cp9FH
	VVtwhgp9Rs9Lja4onYguktPaa/h4/mx1oY77Q3bjCl4zUaf2cELOeJd2KSr9B44AbqtT+lGQLHV
	snfccFdIbiV2DrmFvdkueWOZN7T7Qv77YACKeAjbYird75WUN+Kf55SS18e3rPmqX5N0r7Ct4Ll
	gdkKNyV90++K4EyUtfOn4a5q6NRYPfOyI16DKe9N2NpaNua61Pp4WuF1zQFCOVTH6PkshKMQIAh
	p39xnJ8wGmo+ON70LcX+NWP3/OyMGOflqrTRHMEbE3xTnvqxq5ASSIfS2UD0iPCdIypFE3tI/yM
	D5eJdB3RMGxZxI
X-Received: by 2002:a05:622a:244a:b0:4e8:a7d6:bbf8 with SMTP id d75a77b69052e-4ed310bd456mr153322801cf.75.1762184624699;
        Mon, 03 Nov 2025 07:43:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGx6fdpy9ffRuVsvhz8yNjpEytEyKHoZ4q3oHwfdF2Lj12GhBZH98nF9j0PD7DIHX03P4jxmw==
X-Received: by 2002:a05:622a:244a:b0:4e8:a7d6:bbf8 with SMTP id d75a77b69052e-4ed310bd456mr153322311cf.75.1762184624084;
        Mon, 03 Nov 2025 07:43:44 -0800 (PST)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5943445901csm9896e87.104.2025.11.03.07.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 07:43:43 -0800 (PST)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 03 Nov 2025 17:43:39 +0200
Subject: [PATCH v2] drm/msm: fix allocation of dumb buffers for non-RGB
 formats
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-drm-msm-fix-nv12-v2-1-75103b64576e@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAKrNCGkC/32NwQrCMBBEf6Xs2S3ZaEU9+R/SQ5psbMA0mtWgl
 P67sR/gZeDNMDMzCOfAAqdmhswlSEhTBb1pwI5mujIGVxm00h2R0uhyxCgRfXjjVEgjkVd8sFs
 aNEOt3TPXbJ289JXHIM+UP+tDoZ/7Z6wQEqrj3g122JmO/DmJtI+XudkUY1sF+mVZvvMpUU+3A
 AAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2345;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=eI5cBu6QQfK3tjsQDS+FvtnmilDLe0nXXkJB8PTH17U=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpCM2vxYMRKRx5ca1WQ0ggB27XbRlV3JD/T9Vpx
 zk2DpptdJWJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaQjNrwAKCRCLPIo+Aiko
 1UX6B/wO+drRIoqx9TL/752F67KiRKU8cWu0rZlFvlMMTXZcBfAk5L+VM4ZQ9/jv0GQVE1AT3Gz
 B/nNq2btijArTstBZfeCr/BIaiUqC8JAENJLZ6u0Asl9piNg4FzFy4cVpLbs9xKCCijyoCHEZ/n
 xPPgbJ1J2qaHWNgXxONsRfWpZqZv4MlgM9JMSOQaxJ2SL+3hxf0s+pd1MT2XPRgyFIaVWEq0DWn
 6WpcHjXB1MqnL/7CIWrHqnYW326EiaeBrbBf/n8jNgS5T+F+hiH4F3XpXfx8762oQ6dDFl644QE
 XaaFFLmCEvkunyMKs1urQ7es0YTVxPbUPKrMSO8ZwzRnhuiv
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: RGjV0wSgjxY4UmlJRXwzu37KzcNR6mmh
X-Authority-Analysis: v=2.4 cv=ea8wvrEH c=1 sm=1 tr=0 ts=6908cdb3 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KVldPKIrq6pl5aLy4YAA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: RGjV0wSgjxY4UmlJRXwzu37KzcNR6mmh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAzMDE0MSBTYWx0ZWRfX0U6+/KQEFN9k
 w4rEG/Nqo24qOEXFOLP5eqVf2ry/qskTIzRNMvnx3bRQxzrB/L7G7oEZWNQghiBdoFRpVsZaeJa
 8FFkzh70j63fTNVztT4xNJVybRbfIidvi/z2U3GoxlatEGllEBqXoB5ZreY3+JnqAV6JslCoCYf
 K7jC0SAxqnPx14KlJsYueTQOwWhTwilsbQf5+BynEpPuD3Q5Gd2Otspgb2OS3PtGZbH0V5QbEhg
 AiqJPtivQfq+K03GqSjZ6gv6z73CAH8o4NjJcP3NmjFvEG0RQ7y1RI1MLYlIYDTTBYqOKzAm+Ea
 X9dXuN3+JBbusQDNgwUkR39w2m8EMlvatGRxzT1eXX12NBH81L0gVjF2cC+qnjCiTT8IWsdxbmY
 fdvK2ZXUT2KGH9D6r9q+vdKk5RJXCg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_03,2025-11-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 adultscore=0 spamscore=0 priorityscore=1501 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511030141

Several users (including IGT kms_getfb tests) allocate DUMB buffers for
YUV data. Commit 538fa012cbdb ("drm/msm: Compute dumb-buffer sizes with
drm_mode_size_dumb()") broke that usecase, since in those cases
drm_driver_color_mode_format() returns DRM_FORMAT_INVALID.

Handle the YUV usecase, aligning to 32-bit pixels.

Fixes: 538fa012cbdb ("drm/msm: Compute dumb-buffer sizes with drm_mode_size_dumb()")
Closes: https://lore.kernel.org/all/vptw5tquup34e3jen62znnw26qe76f3pys4lpsal5g3czwev6y@2q724ibos7by/
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Changes in v2:
- s/SZ_32/32/g (Thomas)
- Link to v1: https://lore.kernel.org/r/20251102-drm-msm-fix-nv12-v1-1-096dbcb4a51f@oss.qualcomm.com
---
 drivers/gpu/drm/msm/msm_gem.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 435c0067c2641786ca7b4a42cca0ae7e7dda3451..017411a0bf4503f02b04d9aa9177958762e950e4 100644
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
+		pitch_align = drm_format_info_min_pitch(info, 0, 32);
+	} else {
+		pitch_align = round_up(args->width, 32) * DIV_ROUND_UP(args->bpp, SZ_8);
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


