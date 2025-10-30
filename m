Return-Path: <linux-kernel+bounces-878266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADF2C20225
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 14:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 259C8344788
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 13:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0652355053;
	Thu, 30 Oct 2025 13:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ldl8GfmU";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PYOPtTFB"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0403557E3
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761829236; cv=none; b=CCa0HF5f5AVq5grgDnVnIr2eLaUiED5z4ivgaPQJQIik6DHR7A4rwhQE6AP5hkVIz8mfpTMjnuQ3K/cAa6OOyYIdSlnn+jufPIJuZ5mhMV3wsMLqBWgWIKj7/GfHL8+FDCdZHjWBAoVesUOkMQcNSWnnBNsz6JeVi7vrhWtsHSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761829236; c=relaxed/simple;
	bh=LGW7hdfvroyMNsS3xnEjeZR4TQUPNzO2Hk/wStLQaew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PDf3NPDdRa6pVq0YCUM6qYDPQyrFrOf4x+MmcS18xdacZi6xZT2UH7iBgs6mN1pVj7SGjMiEZLQYQ+mZGrwMenSyiz7YlpzR+KHOXoSEEa3q/1E78SATlmg1v50cplqVKlDeszXiWlxpvfbam2x6G0ETg1sVBAX3IwaFb/Joai8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ldl8GfmU; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PYOPtTFB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U7XTBD1578960
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:00:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=YBSYMbXV4wP
	o16RGwlAGSta0tp2sRbEpfdJq3GdZt0I=; b=Ldl8GfmUBy+qMs5f4/aExlHoCB2
	OnxBk6QH7mUDJrtuKZLarliPTm3O8N86zUXw/ydl4KgE7bxNEKkLES7DxCCH6XNZ
	xKeiZJ4sy649qK78+H4IY5zw5G/VUJZW32t0KVDSskRZkc2J8MnEb37T1nRfvSnD
	YuLnWXnBze7fy9gBby0sfw4sPTtErld2X+5zmnnofshJbuZxKrRXyRmRu1OGS0Uh
	2ho5L44zEwrTexQyT47DZ/DKo4VuwDyo9THCNDTi2XeeraDxByvUv81WmFN2CrhT
	wHIPjwhUhVOzGn6MaJMyZpcgxguqF2ENOU0LuxIHZHjVhnui1/lBingW4Rw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3tjejd5f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 13:00:34 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-783c3400b5dso694787b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 06:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761829234; x=1762434034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YBSYMbXV4wPo16RGwlAGSta0tp2sRbEpfdJq3GdZt0I=;
        b=PYOPtTFBufX4uQJ/7oDX3jbG42xXH2xB1CvhVTEU5Yh865IK5gYvKZkSIqZw0FiuRL
         53XExQsBv0pGjuwYI/zHWEKRgNh6KoOEEFr7uiryg459xA+G4LKlKrutIgoGvYf3zs8C
         QWr+6OU7l5N0Uv1KAYUa9Z+F9if8nYF49YolYAzvjX//CnoChtAq1C0SM9OpeM24ijL3
         9lxywHjmzlth5AIFsVx7EmCTxitYjUXxGFK35fOCAe0JmEJ30dGW0xgJb93mhMUTFt30
         BeavY/KM2j8znAmT530ttmnVR6W8rC9n9q8tmPW0R5JkMirFjqgLDKy9sAXnyQSphn8/
         apVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761829234; x=1762434034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YBSYMbXV4wPo16RGwlAGSta0tp2sRbEpfdJq3GdZt0I=;
        b=o6HlsMesvzEdlfmxsGRcjFZlX5pgXAc2DsoClEevdq0PNHfUQp/5VWgf7N26Z7TSpv
         zk2taDNXQK8yVGhnqHsGsl/cROPSzBVQbfm6zu2okvpyYe/V6eK3RJPYjpD7ZErfdaE3
         yAbeYapDkFNM50Eixa8NBHS8hguSB2Eqyj3iFyYDypZGUL5coBZ02k0kXMzledAaKtxC
         zt3noO491WQllNFq9asTZdIdzg6cHKFewGSh0oMG0zOtt9joijHGYZuO3DLzzmOXHERE
         PlHxbYcPx792OQhz/29PVgKfYStlnyD0pCL3vZr9SRt3NB6Fxtwh0rvplrlwt0lX3cNv
         ggHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXb+ir0mdgExzvTt6RudaZWxljGXBWT+tEEg2ZdC66Tr+Shii2l8jWX+/tXxDtrcwSwn5uUSqXE22okvs8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1E35sj5QhAovBPUWzeItG41CMFcnKfZtt1XBqEutaIIdXdRBG
	x4oixP8nCnx+iwiuUwfQCwpRhkZgI9ImU24mRGDWTPOJou80XbWBkZKFCPTD/IFmAunDEmo2h08
	TLJORgB5Bt+bIexkDGkqkU5XCkOFGvEdZoZnW5Bnc0QuyXXNZzoNA/uhspzwtruywBA0=
X-Gm-Gg: ASbGncv4wfS71bFkI0573gffSH3GiY8zPTbdK6XVfXCks1z0Vm1QPwEIMFuqS6cd+qz
	G8DHmklJBQMS69HwjafmDpV5GTkbbVPAcWew2Yb4IkqDmdWbUfvB4ClIEQa0aziW0kiNb9CKXfQ
	7C1pdUDyxHJJJQ//4Yern5HMonS9+hvuguT8m/MvvnYcOaUoN4oKnEBVvysUaCed8P4MP4PdmzP
	iPa2OoxtMZuvx1Jn/jMZr2fxB0HlAuPMKxc2O/TUDSUjz8dEEXuAVJJT5enR+xshOe4hlDlhWJm
	9+tGZnL3IPGuArGGKkCj5hJZUhYFhZD19uD78huLLyvCvip53l+sm4Yw79GoOeBkhBEr/GblkRv
	4fhz2TclZ3dPxGPgGcbbefZ+SXJjvVB5gB9Q8AFtz2pd1uedsbm7WmaTMcSexhVGU8Q==
X-Received: by 2002:a05:6a00:14c7:b0:776:1c49:82f8 with SMTP id d2e1a72fcca58-7a4e2cfc4f7mr8535171b3a.8.1761829232272;
        Thu, 30 Oct 2025 06:00:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwUbo2rnq1u5I3smURzqZgV3UkEDWSY8iTqhS1M3qZiZ/dcfDt2ClBHzvIFP5gbjiY99BDhQ==
X-Received: by 2002:a05:6a00:14c7:b0:776:1c49:82f8 with SMTP id d2e1a72fcca58-7a4e2cfc4f7mr8535091b3a.8.1761829231545;
        Thu, 30 Oct 2025 06:00:31 -0700 (PDT)
Received: from zhonhan-gv.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414068addsm19078757b3a.44.2025.10.30.06.00.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 06:00:30 -0700 (PDT)
From: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
To: jjohnson@kernel.org
Cc: ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhongqiu.han@oss.qualcomm.com
Subject: [PATCH 2/2] wifi: ath10k: use = {} to initialize bmi_target_info instead of memset
Date: Thu, 30 Oct 2025 21:00:23 +0800
Message-ID: <20251030130023.1836808-3-zhongqiu.han@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251030130023.1836808-1-zhongqiu.han@oss.qualcomm.com>
References: <20251030130023.1836808-1-zhongqiu.han@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: jyLkVoZttZMcIK8UJA7fd87x-wyyJyRv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDEwNSBTYWx0ZWRfXxtRS6g82Uoky
 VI19tCqHfAigAjzD5cy8sd9TDRDZFpOet3Ph8nWbgx4/7xHEocKRbxko+sdetlWrTrFdF4F75hF
 6cgpqSCL0Y7cBaBFccsEj40V1nRxWCmJlZ/0Uju+gURTdvzDyIuipDJVnbqxPMCbd0X3kiD5jrD
 GE9Zf31dapkZa0BNF+oANHmOg760/h5XUoKg/l4OnPwRI+GDyuRgFxeA4xUCe24DLq1DFAH+TL1
 FkHiCwPpa1zWGsyyJxOh5dCKt8LgZMGNDG47OllFmMQ6bPBJDbZlFoeCzXZK1Vsz2XmnebdAMA2
 AfTV8z06nPWFOOvcHdhhbhMpFD1KyEWAcAvumtgRQpRNSIE3d9G/XnUhjze3ZRemZHZ/tk3SxzB
 lzS0w/vXpuWLnonQrvk/5sWFTub7oA==
X-Authority-Analysis: v=2.4 cv=a/Q9NESF c=1 sm=1 tr=0 ts=69036172 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=vBECTLBiNrBzeQB1dycA:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: jyLkVoZttZMcIK8UJA7fd87x-wyyJyRv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_04,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 adultscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510300105

Initialize the bmi_target_info structure using = {} at declaration time
instead of calling memset() in each bus-specific code path. This
simplifies the code and avoids an explicit memset.

Signed-off-by: Zhongqiu Han <zhongqiu.han@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath10k/core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 670c31a52a12..7c2939cbde5f 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -3352,7 +3352,7 @@ EXPORT_SYMBOL(ath10k_core_stop);
  */
 static int ath10k_core_probe_fw(struct ath10k *ar)
 {
-	struct bmi_target_info target_info;
+	struct bmi_target_info target_info = {};
 	int ret = 0;
 
 	ret = ath10k_hif_power_up(ar, ATH10K_FIRMWARE_MODE_NORMAL);
@@ -3363,7 +3363,6 @@ static int ath10k_core_probe_fw(struct ath10k *ar)
 
 	switch (ar->hif.bus) {
 	case ATH10K_BUS_SDIO:
-		memset(&target_info, 0, sizeof(target_info));
 		ret = ath10k_bmi_get_target_info_sdio(ar, &target_info);
 		if (ret) {
 			ath10k_err(ar, "could not get target info (%d)\n", ret);
@@ -3375,7 +3374,6 @@ static int ath10k_core_probe_fw(struct ath10k *ar)
 	case ATH10K_BUS_PCI:
 	case ATH10K_BUS_AHB:
 	case ATH10K_BUS_USB:
-		memset(&target_info, 0, sizeof(target_info));
 		ret = ath10k_bmi_get_target_info(ar, &target_info);
 		if (ret) {
 			ath10k_err(ar, "could not get target info (%d)\n", ret);
@@ -3385,7 +3383,6 @@ static int ath10k_core_probe_fw(struct ath10k *ar)
 		ar->hw->wiphy->hw_version = target_info.version;
 		break;
 	case ATH10K_BUS_SNOC:
-		memset(&target_info, 0, sizeof(target_info));
 		ret = ath10k_hif_get_target_info(ar, &target_info);
 		if (ret) {
 			ath10k_err(ar, "could not get target info (%d)\n", ret);
-- 
2.43.0


