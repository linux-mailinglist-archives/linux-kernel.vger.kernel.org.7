Return-Path: <linux-kernel+bounces-856799-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 235B4BE51D2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 20:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1D0E5E0517
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Oct 2025 18:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6198E23A98E;
	Thu, 16 Oct 2025 18:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WQG5y/db"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CEFF2163B2
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 18:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760640810; cv=none; b=FBHTf9rQ0EBDLlx/q0LS+ZLvg77EXTfI5CO8+Y8DurgomAkpH6OF1kgfh9fybNXHWvBYpE1lyH14jw8V9sa/Lb9sYzYj+3Noha3FlH0lLq5+j2Smku9dTCvmIlQfujsqEJQMsgIPGhnSWnx3EYawXNtKchnoe+imK0RJORZhGds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760640810; c=relaxed/simple;
	bh=vJdrxH1k/5YPLXLEsFF6fCEqg23MPLjbDBgaeSQtCi4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=nwjJTKF6sQGtYZJBeMj0lzYG33T2cat9Sgk6+P5kupEefI04HomMqU1RtxF2cblIAkTPX7XYqlRpHsbYNrx3Roo/r7zbqLF2hkum+TM1gnor1c++E7lSfjHOU/hO4zQxEPP8n8hNNgestFz26JIkNCS+txU9D2O7uwcbBA59fic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WQG5y/db; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GFXgjQ004236
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 18:53:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=eFHiPMUq4Md01wD5fLIaoT
	nzLwYa7cZa7iBHCmHZPxk=; b=WQG5y/dbHZrZhhomPGevKA6ey8HuAOK7ka3L8k
	AK5TnbBydvUMEhxn3JU4wGIUdqPAanNsRqEqgD+jBa+pNjB8gTB1GGKNS2LJqStm
	cEq64VFtRvmrTAnSC+BwYLytfnjLFWdpY2+SCU+1owd2bF3ct4XKtd4Yy/3IAQdj
	/rSsy3aXga3WiXxfpFnCemRleMG461ZX4GZHySLS/kdXEvMyP53GUBcMSY1a1sBg
	HKLvwYB53/nTHHPVCNUSSEbjELIeRVWWVG5BTQaLVmZj1z+Fl/jh/DT4UT15vjUJ
	Zw76xBrJsNq9zoz25XFOu89sxJNOUBQqnbcxhLpSCxQ7TkRQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49s6mwuq7x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 18:53:28 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-792722e4ebeso1177482b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 11:53:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760640808; x=1761245608;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eFHiPMUq4Md01wD5fLIaoTnzLwYa7cZa7iBHCmHZPxk=;
        b=hZAi6yqwd5Ps/s2G/gIQ0c1zJy/WRPef4rLQKEZDczGxEaN2vyctbArBkpEaG1XTM+
         MwMAAgF5BgFyXrXgWzvEu3QMCB82ItpiFJVqrDj7RPqN/O4nu8FFmBQno/d35+4P80Xx
         evjwF3mEbx1GpBPn0Ia0MhrUPs73pv7X2Ee9SqguHchMTP1p5iw3XPmqpF4OqFPri4DB
         O+Ve6aBOIWLhw0keFiUZ80Lm30hZIcD6ZHKuA+sJHMx0RUsdL/UCNmenAzDvMndnZTGv
         ikAleUPtgDeK/VqItZK1F1xmbV7pN76PcKZBij1jstMqMmg9IiLdkOi7mnjufhSC1J3P
         WEUg==
X-Forwarded-Encrypted: i=1; AJvYcCXxaQNGfDQb8n7TDVKzjr6WCAw/Dta2iB6S0jNxk+sLfYrmyDvvemIEvljOX9TxBZ1JyQidjtBWC92siI8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv58M5YlIQ/OyhIo5e18gyj9g1BoKxJ/39Z4EJxpZUhsauM1vO
	EJnTEsMBRn3EcWckLmiq7ZzkcG/kV90Z2vz8RGQYbN3ENygTClnD6KIXB3d/cKtR32tpAvsClw4
	iNKIS+/yTzLoBBmn6545UxbUkmPA66+7zaL+D3Viq+0bpcjTaXRQGgBTwzqHJwEPGGo0=
X-Gm-Gg: ASbGncs5Ypfz9YjUjwij8bisBKPc4sz/DeeyNK1zUMEAD+S1APhGB2K1BU8KzwCLFy0
	Cny/50qoiYSLEIWblz7qLHzYtgHR6YU0hGsVWQLdk9HMnL+IRGljjwLC+F0xg3SDLOGwmiPCb92
	60qgGMOfbQIoSfKSRt0fJBuwO+QrqBgmJ2TCPlU/mERH2w/YE56oLmBSfXGxX4jtaFzpRqlUld5
	3W/T3fRh5dwoEdx+NGY28gmf6vM/BDg6R/XJvtEijHgOGz6lacSLQzaAJ6jpflp8otAWSTPVfKZ
	1/SWkLb8ynEnf1yBAjfqvCrrC3nBpk0z5NtE08rdU3hqDg8ibhZB3Z3agt9uzbvCy7Ghh4+BrrG
	jJkEpIo6VzU2WahPUwi23GVo=
X-Received: by 2002:a05:6a00:13a0:b0:792:574d:b20 with SMTP id d2e1a72fcca58-7a220aff329mr1132981b3a.25.1760640807531;
        Thu, 16 Oct 2025 11:53:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHI9YEwO2q4DvEuCB2iTjQevF/8YkUPQABypLhGfV7GQxCNyKDaED8fqQ3J6JkK10r2HG3qzg==
X-Received: by 2002:a05:6a00:13a0:b0:792:574d:b20 with SMTP id d2e1a72fcca58-7a220aff329mr1132947b3a.25.1760640807047;
        Thu, 16 Oct 2025 11:53:27 -0700 (PDT)
Received: from hu-tdas-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0e1336sm22897713b3a.59.2025.10.16.11.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 11:53:26 -0700 (PDT)
From: Taniya Das <taniya.das@oss.qualcomm.com>
Date: Fri, 17 Oct 2025 00:23:15 +0530
Subject: [PATCH] arm64: defconfig: Change CONFIG_SM_TCSRCC_8750 from m to y
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251017-update_defconfig_tcsrcc_sm8750-v1-1-34b1b47a0bda@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIABo/8WgC/x3NQQrDIBBA0auEWVfQgDX0KqWIGUc7i2hw0hIIu
 Xsky7f5/wChxiTwGg5o9GfhWjrMYwD8hpJJceyGUY/WaPNUvzWGjXykhLUkzn5DaYhelslZrSy
 Si8a62YUAPbI2Srzfg/fnPC86eVtXcAAAAA==
X-Change-ID: 20251016-update_defconfig_tcsrcc_sm8750-5ce7d157b7aa
To: Bjorn Andersson <andersson@kernel.org>, linux-arm-msm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
        Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        linux-kernel@vger.kernel.org, Taniya Das <taniya.das@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-aa3f6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDA4MyBTYWx0ZWRfX/UF/3cs0Rj7n
 LUtrRrbEqCvQx9qTAB9HGqm+WHvNXXRuiJuQS1EwDZiqH7JAGUBx2ahu9HF3Vbntrr7pqa4KwfA
 OCITBKpAYDL5JG0ZTB4Q3cNlXZyK/gKXvsQmCrFhbI5G02N0crPpN2YTamjwOBe8JVpMe/tflM4
 rbSNTNFumqMqfw0KGcI2sN82L2xHBNFklfhBWltwFYhDm/KjAWtP48jPHdiNt4dH2tWLStCvZAj
 Bq7mhJvwaoABepdeOdh8KsIMy/qeKPAJfOXh+TTJrPmu677cIF/g38SL/K76VRAs2XSCoK5Yi9O
 0ZqtcOsDuOGSGlZUFPl12uWWYF1IHU+HrvVb1QeUe9nP1MWJLjlm9eSWFvvJtUM+P48hfMDgzFW
 65e8TdmBKL3AurIj4qe7C/Cgx4TQeA==
X-Authority-Analysis: v=2.4 cv=Fr4IPmrq c=1 sm=1 tr=0 ts=68f13f28 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=fjpNi09VKJx1qQd3FNAA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: OuOj_cpvvnO-U7aWjWMFtn_K5Bvp-D6e
X-Proofpoint-ORIG-GUID: OuOj_cpvvnO-U7aWjWMFtn_K5Bvp-D6e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130083

The TCSR clock controller is required  during boot to provide the ref
clocks to the UFS controller. Setting CONFIG_SM_TCSRCC_8750 to y ensures
the UFS driver successfully probe and initialize the device.

Without this change, the UFS subsystem fails to mount as a usable file
system during boot.

Signed-off-by: Taniya Das <taniya.das@oss.qualcomm.com>
---
 arch/arm64/configs/defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index e3a2d37bd10423b028f59dc40d6e8ee1c610d6b8..85e3afc07598a99cfdf804ce1f320ed76717fcc3 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1449,7 +1449,7 @@ CONFIG_SM_GPUCC_8550=m
 CONFIG_SM_GPUCC_8650=m
 CONFIG_SM_TCSRCC_8550=y
 CONFIG_SM_TCSRCC_8650=y
-CONFIG_SM_TCSRCC_8750=m
+CONFIG_SM_TCSRCC_8750=y
 CONFIG_SA_VIDEOCC_8775P=m
 CONFIG_SM_VIDEOCC_8250=y
 CONFIG_SM_VIDEOCC_8550=m

---
base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787
change-id: 20251016-update_defconfig_tcsrcc_sm8750-5ce7d157b7aa

Best regards,
-- 
Taniya Das <taniya.das@oss.qualcomm.com>


