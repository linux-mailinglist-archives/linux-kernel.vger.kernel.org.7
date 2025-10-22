Return-Path: <linux-kernel+bounces-864267-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 78478BFA56C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 08:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DF25D5068B2
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 06:51:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE42C2F5319;
	Wed, 22 Oct 2025 06:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R+QzKRGR"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00C22F39BE
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761115841; cv=none; b=Xj+q7EYl3XIMeT8wyVQbovvEF/agY3uylQA5LBCda+hmK4Q0ipmA5AVJ3XgkuypayKXvJUoL0i4F9fQG3xdjZUvkI5RnniZ8iAw6/ldtOR1eTDIsqzhiJZxF9siB+A4JV9efDdfJx/popQ4QeWt5YUTw+sd6QD9C4obcCYEzWP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761115841; c=relaxed/simple;
	bh=gHF+4pA6FtZnBUqOQl0MtcfoeZVl4BA/oIYisaYmmWo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gz8QP6ZngoUZ4Yf1fm4WVTUOzpxGdfhmQgEnKYmK28g+AG+wG5kbwGk+P7lDqKKsJv2VJgu/shaDnwM6W9L40FB0ygZiTXQl4LcUZxguJ8sum/lH/ApIkJ80dLGuWw5LKs9soBiilCDQ3ouAZsj+2e0dF9IJo39lyA6KbZOiUPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R+QzKRGR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59M2wc4C026856
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:50:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	UZEDudDcCpTGZPPYZsISbbU3+prU+iJo6gJxhAsFFbA=; b=R+QzKRGR1NgelHIg
	OeYeqbbcd4hjwxWGhLyUMDHKfzdYksC6GvigQGUVH9RVPVGKhH5iPbpl35pXxWn8
	i+dTKgNzu7aEek3VvYOm1paZpey4yFiQINnNF9VsRPxCb4FvPjBn1el2nzQvetYS
	NpqTPfCnXjGU2grMwsWo2kYghVhPH4ZwEFav+fxBh68vRLBVK0lbg5UVC3b+rOyC
	Le8n5MBU1pm9qyKQRAJ7q9o0z1A2Gz58eNVbX8Pc4jFiPnSGJ5Gwde0u32TNkbW4
	p+tE6NzOq8/muskCumGJG2YUV5BOP5p7ZEGaL82Ud94behDDmBQbkMu4MoWRxxqX
	yLxvqQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v27j3jcm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 06:50:37 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-272b7bdf41fso78868735ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 23:50:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761115836; x=1761720636;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UZEDudDcCpTGZPPYZsISbbU3+prU+iJo6gJxhAsFFbA=;
        b=PwtFaYw4xVLJ+7aRp7GijUI2ZTmNr2D1gu+ySLHDTR4xAv3f+JiTOTIvz/okTxyEtJ
         uhc/5PYnHXjNcy/W/6nYqaX5yDIq55qJvNgg01DKpu0knOH2LBiYFi4vUCNfivv+Y0WB
         Y7NUi/qoYsKobO3U4+bO1CvNTw5Ramx3zCc1Szc95SAZbrHe44il8HcwiOj90dVdVh9P
         SEjIEQQxPC/bTvkg+HUHnDR0/ZTstfprze2TeSgqVfFPged6P3HFbHZcXuTcazw67w8O
         sBg17O743szI8Lld6X5RlJlADoughfpSTi3mfvBQJUsvjX/P4kYhbi25NcviOGyUhwcl
         AU7A==
X-Forwarded-Encrypted: i=1; AJvYcCUtE9DmmmsuskQ/BBoZsTMYC4ZFignAcG3QOEIMOXiMNnfnEYk4Z3FM7+TQ3xJEs3uSVgqF55nZxE/1ufk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqnnzAaVpWYiCane3NAQaX+W7+FsqekdkZWW8pWWXrSFdIs51D
	i+ECV5xUuXqrbdtZuiPc8J+1QnHj4MjCh1HzvFb8gwjVQf8dzOINIbrOnciUZCZH07vqtxprdtj
	ZwFLcDzOhlBodD9dE40R7yJxSt1k7RgeLgCK4Sull1/32ijlgcFC1UmvYx9VeQKaVDyk=
X-Gm-Gg: ASbGnctGoXyJ6S3Imd5lqF0DqTnL0b99fhO8UhdMGN4rtwOwCb3TM2OhKRpVxHXDc1C
	5g5BcdfGsaE32riyVRfQaOxTUqVX/KJSQ6fmrlFFhO8f2A650P+Lrgo+4Gv+PLi+/DbvEKDzugp
	LbULXXs1y4jm15btO7Ry4R2AubtWM8/aQSMhfuxUEB6Cw9xftPo44cFyVmceK8xeuSoDYtExw0J
	4eHc4fnO6I62Cz74UtZC1qAGtdJjYS5/n5giMQLs2jDMimSXI0PQsdkltSyLne2hIKQJe+pWnWq
	6edkAeWacaL4nayBb9VUhGYydB0qVNcumnpFIHwPP/nXk7Ke0N4G9Rse8hDwfaE4fcI5MbazK2M
	fVluTU0c0ENYJ1tpmYBY8cxonjRhO9fAe6l6JUkSm9MF8DLu6Vw==
X-Received: by 2002:a17:903:298b:b0:282:ee0e:5991 with SMTP id d9443c01a7336-290caf831f8mr255694495ad.30.1761115836287;
        Tue, 21 Oct 2025 23:50:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCpodpjCxx4fmCbEkBSzBkPT2S5EgIPUUrmaWcMLrK/fxVAvVzC8itWrjTf66DpjqIW4r/8w==
X-Received: by 2002:a17:903:298b:b0:282:ee0e:5991 with SMTP id d9443c01a7336-290caf831f8mr255694115ad.30.1761115835763;
        Tue, 21 Oct 2025 23:50:35 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223e334fsm1560285a91.8.2025.10.21.23.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 23:50:35 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Tue, 21 Oct 2025 23:50:30 -0700
Subject: [PATCH v2 4/4] arm64: defconfig: Add M31 eUSB2 PHY config
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-knp-usb-v2-4-a2809fffcfab@oss.qualcomm.com>
References: <20251021-knp-usb-v2-0-a2809fffcfab@oss.qualcomm.com>
In-Reply-To: <20251021-knp-usb-v2-0-a2809fffcfab@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Melody Olvera <melody.olvera@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761115829; l=989;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=N04B8FuADvzjDPvyuTKyodc40jM2jOda/r7xCjpf/i4=;
 b=lyc1bzXd8D3qrqhkPjdIO4ToLd856fsMOQjTqs+gbO9UGKnkm09XbzvKE5ab1HNflxNdwWWYS
 aCllmsoNgwDCGZ+KAUg1vYrJBono8GVFYpjDq1xuqz8mek8HQWTqdZw
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAxOCBTYWx0ZWRfX49mVNzOBFqaq
 XlVDSOx1DSMFQmhhhGRITOXdnXFn0+HwTsc9ecLrRnf+3JUvNNNoII0HVDphLonDTJbiFMll3X0
 nCwhqCyLn9+c0HfkWVqyJ83+W9Qc8jpxlosrWSyTTrMYqS79ZFPUgQrL2nZUvXEMtMqH0P4a5Aj
 5I4BhQKq7nj1rUJjo4iN0AsHrVFN/sq+dDuGjMkkxiTfd1MHMmNBwhJAB54EVWQ8liid3+0Dl+W
 waJ2LZEjBg1n6bea8Nk4qJC+di8J9Mdqfn6bI3MV5LP1O05wNQj9+MTOKGdcIFdTu6cozmYtd6u
 APxobLNL0GhWmsBd4wJKXT/Wvd89Youxp27RW+eVXATe4B2KvPFGpR8tBp4VIzWq/QJE37uwI8M
 pdAfNpOsrmT26ta7MKRKUxrB4BS/wQ==
X-Authority-Analysis: v=2.4 cv=G4UR0tk5 c=1 sm=1 tr=0 ts=68f87ebd cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=4ROhr7NTa0bsJorruOEA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: SqlJ-nTepZF4F5D8TEuHw28-MQ7FpSmu
X-Proofpoint-ORIG-GUID: SqlJ-nTepZF4F5D8TEuHw28-MQ7FpSmu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510180018

From: Melody Olvera <melody.olvera@oss.qualcomm.com>

The Qualcomm SM8750 SoCs use an eUSB2 PHY driver different from the
already existing M31 USB driver because it requires a connection
to an eUSB2 repeater. Thus, for USB to probe and work properly on
the Qualcomm SM8750 SoCs, enable the additional driver.

Signed-off-by: Melody Olvera <melody.olvera@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 630fc798570f..a600d9b86a7b 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1680,6 +1680,7 @@ CONFIG_PHY_QCOM_QMP=m
 CONFIG_PHY_QCOM_QUSB2=m
 CONFIG_PHY_QCOM_EUSB2_REPEATER=m
 CONFIG_PHY_QCOM_M31_USB=m
+CONFIG_PHY_QCOM_M31_EUSB=m
 CONFIG_PHY_QCOM_USB_HS=m
 CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2=m
 CONFIG_PHY_QCOM_USB_HS_28NM=m

-- 
2.25.1


