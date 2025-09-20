Return-Path: <linux-kernel+bounces-825480-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83AE9B8BE58
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 05:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29199A079E1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 03:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D2E225A3E;
	Sat, 20 Sep 2025 03:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iJCLG5K5"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39D82459C9
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 03:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758338490; cv=none; b=duvY6sZLiCxZVwG+4RFLI+mANucbj75cBfWtSiHHYgON8z339mnuRJbw/Fm+m5faBcE5ghSTGlwGJzjyfLiTdiAv3p8w4jWzYMT1ITATvQ6m6RHagJMhQ6+kDFeTMP9oWQVOV009/9op9JRKHafj3zcKd4Jrz+bkLJiQqA6xZCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758338490; c=relaxed/simple;
	bh=kP94qs9O8DLQcs2Bvirs3zIUN/e+b/TSSwwcST/H/sw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VAiRrVH5rX3QXqSlGWBnDIxP9Mr+elvZQnyuA9E4QFsmwjIPMEcUqlBSxo3Nf1WeqlLwWEbF6CmwWKqAYEYH78D9db9tHdVPCUPFUhT8DaicYB4+zWHyjQVkrcb/F/GKgB4Q8BbaBDkuV8nDDGqJnGyTir3riHBX02FiDuasJ6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iJCLG5K5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58K3FLSD019203
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 03:21:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=6uA00onJvkc
	yy2M4ZvUqeOEt+eh84BjDYyNUmNEMNdU=; b=iJCLG5K5y5LXSke0an0jS6RPOOC
	7HuyWTkzcucl6yxfe+N7K38UlJerDUYkkFwGi37UqKs6CjIvueeWpMc8JZKrB6BZ
	yjemXDDG2iP7plYqEpLHoWvhxuBRtaUFnmq49boNm8xrJcrK4UgAL6uWmHz3CiRg
	w1L0RbC0ua6TOrO0UPiI+tW74nLJG1jbu8qYba77RhnrjB2Ne7vjOK+/X4ZeLVJe
	hBGjXLloLgoaWzEMdUV3n+xYIW9MTPmqtp5twpt3Uc0btFeY7kLjAu5JC404RdRx
	7xpdmPPOOOuRZflrmDYtYCECJcBLxA0qT8IC9GcFWS4LDjbxzfKYY2cWYyQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hyeg7gg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 03:21:28 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b5514519038so2249590a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 20:21:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758338487; x=1758943287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6uA00onJvkcyy2M4ZvUqeOEt+eh84BjDYyNUmNEMNdU=;
        b=VOklQwop9ajk9xLiCnGVscXOQrdqKioaJ90oXAZBFm7jbZL3rmRWEMwKkrYhVY2dII
         L7K9tAMRvCkYr0E+BUoJxoMrTroMTGNkNtDiRXBpPsVn6RZ3smkd16lttfC9R/bYPDSW
         9qrsAPtRMopO1zubk4W3PO8YbwXFp8Kv/P9kmJgHqMBCVmmg+XTPBpbOCYbskOZNzv7W
         k8oceCziPfDoSUMfn/DPnZKl9hLF1wwSBYpeRV823Lp1UmZkD7sQNnemNVre5viyGaNM
         pS2+CyntxBIlQt3txcP4vcYw/gDQd1mE+JUddSBQqJzLLvJRLFNbrBkmYkI2OAzp2dLr
         3zCQ==
X-Gm-Message-State: AOJu0YxQxJ6tXnj6GidVv54cMtQ5ea6cl3RkUrARxGvnXdh23MMnRjUS
	XPn0cnw0JRNFy2OxgkBNT534H/FnXhUpvLlwJw3RHjZfYM7xL18rBDoSiSU/yL3EtPdJRruABI2
	Dp3rF3wiTH9n1rfkh/IUwyIcf5JP4zzZK4uZalcPVoV81AkGE5jHkRGT1WIYDcfT31LQ=
X-Gm-Gg: ASbGnctvuRSTeEtWXszx9BRRuN5p915Yo4cw5f3WmCXFc7lSHbj0PRbFiVMJAwTofj5
	4uxdTnYom2NTwa6SqHEW/o7LHhKRB0nqX2jN0PxTRbYTp0Cbf0bwesN4dL4aGbAaZuF+W4W5tVa
	K0902eqg4invlHlrkfVPD2OrPmQn9SleRYp5DMxNYQ0vMjILKPshC1sVVk/QpXvaotQg2ZzaaeF
	+rRDMyHd3jGktTcZU4UmxPwsK2HfpDIHqR5p65Y/H1S62AT5HcZirDfNV4wYUdnFHv9GDNZqAA+
	f1HlymqgkxvWZOdRhdOYVi5XlzFP9X+ZOiUhHvEResHeZZ7lybDfuZxBangopq0f+7Yr1QSEGoU
	B/0p6RFMtPTJLANRx
X-Received: by 2002:a05:6a20:9143:b0:262:cbbc:312c with SMTP id adf61e73a8af0-2925d0de225mr8589059637.17.1758338487157;
        Fri, 19 Sep 2025 20:21:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFXJwFYvetfpsIeKUWHiInvLQN1H67mlVltjKBQFq18DtwSU2ecOTFXwigElZASvrT0QR38Q==
X-Received: by 2002:a05:6a20:9143:b0:262:cbbc:312c with SMTP id adf61e73a8af0-2925d0de225mr8589029637.17.1758338486759;
        Fri, 19 Sep 2025 20:21:26 -0700 (PDT)
Received: from hu-wcheng-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ff448058sm6178807a12.54.2025.09.19.20.21.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 20:21:26 -0700 (PDT)
From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
To: krzk+dt@kernel.org, conor+dt@kernel.org, kishon@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, robh@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-phy@lists.infradead.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Subject: [PATCH 9/9] phy: qualcomm: m31-eusb2: Make USB repeater optional
Date: Fri, 19 Sep 2025 20:21:08 -0700
Message-Id: <20250920032108.242643-10-wesley.cheng@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250920032108.242643-1-wesley.cheng@oss.qualcomm.com>
References: <20250920032108.242643-1-wesley.cheng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: dk8fJ_MiG6aTPI0qKm4M4johsB1Z5jhG
X-Authority-Analysis: v=2.4 cv=YMOfyQGx c=1 sm=1 tr=0 ts=68ce1db8 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=LPx1eKQi2Xt_nUOAx-wA:9
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwNCBTYWx0ZWRfX2DKFd1IVluPd
 eIEzizwfX+iOKdWDgu/iAwggQsW0pE0XgitEK/7PQBg10jraRYayLAbMndfzVbxRG19QgVaBSKe
 F9dHMIjyTMn44qkL2qj7vEpaPsZIHoeAQ4SAk2Nu4AiMflZHy1CgdG3aAUpxkSzrVo8esEIwHtj
 EgWdzIaXfVLn+nzAkzYNG/l1zwj7vo5zgDfM2Whp5IxN3f3oOwK/JAnAXxKtXkkvOaXHqIpO/lc
 GYVNj8vqdEuTWyy+mOo1qO9QvKMTO9ljwPh7tCbf83Xh97aiAN3Xk18wGev2WjxS4E/JPOV+yFr
 VtkxB1sTzEacjU8O9F1I+8+AtejMXeQ9QE4N/0rQkrR6pHMmkomMu2e8/QxCojyJXMuteVFuYpy
 bjV0+Lyf
X-Proofpoint-ORIG-GUID: dk8fJ_MiG6aTPI0qKm4M4johsB1Z5jhG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-20_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200004

Change the notation of making the USB repeater a required DT parameter.
Issues were seen when supporting USB2 across different form
factor/platforms, which led to enumeration issues due to improper eUSB2
repeater tuning.  By making the repeater optional, for SMB/QC PMIC based
repeaters, it can utilize repeater settings done in the bootloader,
which cover a wider range of platforms.

For other repeater vendors outside of the SMB/QC PMICs the repeater
should be defined and managed within the kernel.

Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-m31-eusb2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-m31-eusb2.c b/drivers/phy/qualcomm/phy-qcom-m31-eusb2.c
index f4355d38aad9..b8ddadf78c53 100644
--- a/drivers/phy/qualcomm/phy-qcom-m31-eusb2.c
+++ b/drivers/phy/qualcomm/phy-qcom-m31-eusb2.c
@@ -285,7 +285,7 @@ static int m31eusb2_phy_probe(struct platform_device *pdev)
 
 	phy_set_drvdata(phy->phy, phy);
 
-	phy->repeater = devm_of_phy_get_by_index(dev, dev->of_node, 0);
+	phy->repeater = devm_phy_optional_get(dev, NULL);
 	if (IS_ERR(phy->repeater))
 		return dev_err_probe(dev, PTR_ERR(phy->repeater),
 				     "failed to get repeater\n");

