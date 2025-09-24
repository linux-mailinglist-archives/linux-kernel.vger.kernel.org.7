Return-Path: <linux-kernel+bounces-831425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A03B9B9CA08
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4614F4C17C1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DC92D0C84;
	Wed, 24 Sep 2025 23:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="X07ZGBNh"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6740E2C11D0
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758756922; cv=none; b=N4aDN/g6GY6YntlgdSP3K1Q81U8h/PicFxPHU/Lf+wcztK4kJgbIxLFElTPx8nryb7emvh90cXOZ4UzW58sR2LZq4Cm9ZvzKCtDvuEQAqBU2Xi47vEmZ2pINuaBT7Y8MFBBplwUASJjdFccibEXJCiUaqU7QgZNcQWJAhGdb/bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758756922; c=relaxed/simple;
	bh=Q7Y5sKrFJYAcd7JLFQleIjbeTi6scSpI9zSmmOVIXBE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R9lFAF1Nosm80nlsRbnG4zeBNkS8DSg39cVhZq832K+CyMqbIg4z2LGH2Vb+vOgBnxDr7wI2YV9y1N6/y5g+rZXDoyIzAat+NoPaG3tdWueL7k8CwPcRtVmTYsmG56hT9djE/OVeqcC5LsdeU0YtpO8rpe8Zhq/lfq6YoRsFRng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=X07ZGBNh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCbHr8023766
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:35:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QaWO9DEgDqVIwBTC8sgSyuuxsW+ioYv5Qng3RAcDRvY=; b=X07ZGBNhrkJS4Hfw
	hG9PrJmBLalpsAsTYTZwFlUwoy6qJc5mjZjhZoOq/b73ACt7C2QLh+shY1ijYTdQ
	Kk+6AVuaqCrIxJnyrkqm3Ape5SVp3ZZmUa/BEhQPEWOqnttXdZkkikb73tPuRIEt
	svuuBStU9+sgTRYVI2uiGhuCJ2lPw4l3ZyVJXCiLE+JoLOAmHo5HGWKvVBZgNQOu
	22aMbLxf5fzM55mYVbo//OPevCskz3au9EyJn07rrW8GgDiMiZap7ZrpgEm9q/b2
	etH6I+p4rPs4e+u3NsEkxtXcwsW0p7rY3IbnWvyXXFCI1y20prNa8DFlShQt/2/J
	I+OM1Q==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bwp0d2xs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:35:19 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-780fdbbdd20so315433b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:35:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758756913; x=1759361713;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QaWO9DEgDqVIwBTC8sgSyuuxsW+ioYv5Qng3RAcDRvY=;
        b=wZSVwtqYigv0II5dPAg0/heKYMUf3dkSFIOG6AHkGUCNKi+HgvoBABwHjSHtlIRp3z
         1ZqrO8AF+rTgjpYzmZ21FVphEhPxY/60iHP0xasx6pGDA/KFKnh3Eg/NkRNhjW8X8Fin
         eaDU60P+4eR47/0a+TK22UUWvYG8vCR3SNPb4EtqHmzXjM4KJyv2iw0rQJL+UgKdL5RC
         /KvFtN/JCsAzeifmB9b9REGMb37d2t2xtNYnAMyM/HUOKWdYngU3OfqYC8CGuLz1w5Dq
         54jmuQBn4Raa2GQH0OmwPUnM6I0Hkf81dt/owY1zB1bJ0xdg3NrBSLyLg+HJPqE2c+dB
         7z/Q==
X-Forwarded-Encrypted: i=1; AJvYcCX8t/tXwRvt5uyi++gnLHThN9Ld36EEZnfRLDf0B2ChAEVC3VYa5HOEMlOHlOZT931MX/zmhLLc0QrHNoo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOy41ndaLGQTOs70JF7x/rmP0u41pIhyiH0OV5Vgc6br0CADCp
	0hZlTACFFBXbJvQ3K4xF7UNTKncvNDRqKLIlHAxe5UHgjmypQlWM3RBjb/tfHJT88Cx+372jslx
	Yzh8+jcwxBajYvoxZv75hjjqI3P6+B2miJQ/+NkJMhcrLwuBlx+e1KXvps8hG7729OgY=
X-Gm-Gg: ASbGncuCR85HwbC8+nR+Xw9ZBFTALKUvkNq3Zf5MyeruMmP+2Nojh/3dz6Y6F7DQO1h
	0loVwPssCd77tC9oEvlkXmEb/cCfnSiQoyZdOx7STehcATrmI2kBYqIxEkGbWoH+LuU3JseZ7Wy
	JUKKzkNzOGL3+x4qi4iqtnfc11kY2fDxToBQXwvyZXxXqY1kA3VDT1+8ocVnxSXi33mhW+gv9xH
	gq7qraQCLD8rzUUWU4ywpNddGpxVeOvAi6czhXe2jBMhR6xbrLFEVFs2OwiIjVmF4ntptEudmZS
	Ux9zCYbS5rxJHTO/MAQbNxW7j4qY3zTep3fO6/GwmQdl2kmBuoS570PDFYLTZ8grGkEr6GB1Rbl
	pBTH+um68ibQfE+Y=
X-Received: by 2002:a05:6a00:3e03:b0:772:45ee:9ba6 with SMTP id d2e1a72fcca58-780fce17efbmr1909181b3a.8.1758756913516;
        Wed, 24 Sep 2025 16:35:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBpn2lzR5gwMTN21ScTg1+Ioghs8Ao0Bl/JBGqmTWGzBcRYnazeZu1NEI/aAE8+KZ7s8VCEw==
X-Received: by 2002:a05:6a00:3e03:b0:772:45ee:9ba6 with SMTP id d2e1a72fcca58-780fce17efbmr1909167b3a.8.1758756913098;
        Wed, 24 Sep 2025 16:35:13 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810238e9a9sm212379b3a.15.2025.09.24.16.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:35:12 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 16:34:57 -0700
Subject: [PATCH 4/4] arm64: defconfig: Add M31 eUSB2 PHY config
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-usb-v1-4-48bf9fbcc546@oss.qualcomm.com>
References: <20250924-knp-usb-v1-0-48bf9fbcc546@oss.qualcomm.com>
In-Reply-To: <20250924-knp-usb-v1-0-48bf9fbcc546@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        Melody Olvera <melody.olvera@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758756905; l=989;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=WnYe8cHS28Bdfzb1400w3Q/pQBsMgEBstbc7oiSATRU=;
 b=7uAglFkbwYo4jHhD7gwM2JVXFmP/o4yxCs15lZZSvumjLdI84vH7Fpy9ZL40trCRHSUoqDUDW
 CEe4pD6KhtvCG9NhhXIm71MfIYHuq4t01BYmmCRhc4C4Hro4PFs8IQP
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Authority-Analysis: v=2.4 cv=KNxaDEFo c=1 sm=1 tr=0 ts=68d48037 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=4ROhr7NTa0bsJorruOEA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: 5aiYnk5nc-VFCCROBkWhFseRVkxt5dos
X-Proofpoint-ORIG-GUID: 5aiYnk5nc-VFCCROBkWhFseRVkxt5dos
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDEzOCBTYWx0ZWRfX3xcUG0W7ONvu
 koORtXxu1mYLyXQM0xxc0mEd6objygzRIj5qGdmyH1+lo0iBRBVmajU0Ejl5sqXRisRMo7kDE3R
 lLMJcX+D5Ch588Mpd5LADaSZ5r3u3uYyMPkXwQQzxEo1wvX57fvPTMwDgeFvTcmzvQ92K939tL3
 OLJU0Od2HK3Ljhdk6OOF9eECwHXguiRvUMIDkGc8lrgslfiPMBGlWPPojhv3Bw+SYzJgdc+2Avv
 YTregfOQ3Mc3Sj3UWXqom6GJNGeMNlcnI+z+qi/23Qj4+b39OILZHIBnj/hxWOL/rsQ91jdd8EW
 ZeItyOcwlF2qKv2Sbk7Uaf9pSPv5+agLGABEojEvxonwUpsYCWfAxigV4iNJRB1816gQZYlm4cQ
 h+AVXdXK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 clxscore=1015 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230138

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
index e3a2d37bd104..24b1c943a7e1 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1641,6 +1641,7 @@ CONFIG_PHY_QCOM_QMP=m
 CONFIG_PHY_QCOM_QUSB2=m
 CONFIG_PHY_QCOM_EUSB2_REPEATER=m
 CONFIG_PHY_QCOM_M31_USB=m
+CONFIG_PHY_QCOM_M31_EUSB=m
 CONFIG_PHY_QCOM_USB_HS=m
 CONFIG_PHY_QCOM_USB_SNPS_FEMTO_V2=m
 CONFIG_PHY_QCOM_USB_HS_28NM=m

-- 
2.25.1


