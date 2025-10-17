Return-Path: <linux-kernel+bounces-857088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E02BE5E37
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 02:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6327019C6905
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 00:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694821F19A;
	Fri, 17 Oct 2025 00:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LJJhu8ju"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7C4433BC
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 00:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760661039; cv=none; b=mE8+N+d4qxuDgxQpLJrkj5DzMspubjE+piQs7mLQdoeesYSt21jZ5aA7prZz+YMyZBlGNrsI1FIpWcHK6lJrcdQwMcbKXtVJVTx0nGbwlJZcwcMzEzEWfEu/YUE9xK+ZVjtyc5PcthGETT0KMgzK/sFXLSN7MCnV3O/0OJ0Vy5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760661039; c=relaxed/simple;
	bh=plPCRytJPMNMkedqxfIhoirrL3iZbMoYA+6Lwx/N7BE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ja+wGSAwYDDgvRnCSqgAsd1Wwd82x9z99h4q1Phymlh6O+VpnLBDSwSnYTr5H200QGMVGvj103N3l6vTrVXZza/rf7IxzAyri4xbgiQeJgfFoaFsWddffFTbdk2V40fgElvl8evzhdg6O8ssdaoZK2zlFN+Q98RSG9bfLTUFke4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LJJhu8ju; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GKLUI9020254
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 00:30:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=WhuBaQ0vD5RlijFZMAJ7wtP6QS9Fh1//v/3
	i2yHv/fo=; b=LJJhu8judZXWCezkRLFmztBubw+tbQEn1qRtNVPWY0kvMoku4UV
	v9hYHx8YDFKk7UmCwQl07Q8xnSYHboAVRjDZh0pMKU4meF+pZuSOu76YbSceV907
	JyfDDcKSqNDK3XzzPNV/M3o4VIkT1EucjEulDpmogz8mHG2f89Vz1KLhgy9SayPy
	VNDaGpE8OVvR6QMsUp3KXorBjRL/zoB3eIGGm5fGRg8E7NMICjw6p7eib4yvmz4r
	iHSpP/f3u5CfqXYY0SJVRusMACCe4XfuCEYncnTyna1lqB0MfBnSfNithCVbqO7x
	sp9B1A/tM+xKXNtaPBCm/oCzkLvuHnZbDzA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49tqvpknhe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 17 Oct 2025 00:30:37 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-77f2466eeb5so1620142b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Oct 2025 17:30:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760661035; x=1761265835;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WhuBaQ0vD5RlijFZMAJ7wtP6QS9Fh1//v/3i2yHv/fo=;
        b=EucCX+WFlPE2FKmQEOeCyc9B2qxceQCHLArQFLXiTHJ3ofJ1efVutHTPWyswB6k/cd
         UjZi9hmpGWiACtrVgml9IO/5X3LLi58+/RBj+NTCpm/GexLNmnft4XDG6+rrHg2FlGke
         MELSJN9Ait96C0nC3lXCYYeQUqEutRWNnYwm/kK0jMMHDBorW9DjHPYBzZNZnRfBc764
         hCeURs9rgoYGMc2e5Ns6j3bRoryjCx1XjKm1zgee48lO+GxBroPuSM00ysMtEGnw6bhm
         jj+VJ33teO3MtzajBgCQmc7ufPiM+ygIpJTGgDUkDpL7saLYHpfCiEg6Z6RyBSEP3lnQ
         jIKw==
X-Forwarded-Encrypted: i=1; AJvYcCUjcab9Nv2xG++TUUJWNZivKif4pYqagoUcJpUmFeQtVfwOOi8dNAD9SVnIjrfy3KL93QIzsVnhFMYb50Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRZ8WTBu/jARIf0yXNcBrdAisTL56w5l6KMZ8CoihG36Hj48jm
	kwc5PX2n64dDIjmbq7F2CsWN89soLYIe9HQJ7OxeZmTsiSC5BXtV6ENZoDCswolmChVV76KBCEc
	2eytyJu2pfmHQjrWL665gdHBryjUnsvxDcfOMUAcGtVYKb1x8LNfQaP2I5JluLPKSoVIkaRyiX8
	E=
X-Gm-Gg: ASbGnctG/YsO6JPiMyp6vJ5KnVLJJulqVWTSZReGlqT2HDw3Ya1hgpEkJcNDFeYJuj3
	V4qiXc6Oh3Ya1LUiZnRms6vcX6l3lvuq52ZAUyLHm5+G0r+zor3yYIvGk51mp0poeQnh9YBmyEw
	FXW03/H5HA+96QGAMdtpNqZPMpfvvShyCqzfxfILlvAH9q3zfxnx6YHjdE/MHNlterl5tUipO6x
	cGQVMDffOKCwbfVb5a7p9yk9niiHsxDUv6jQexW90uyUr6dMb8cTdam0Idtp8es9avwhZCvyJWB
	KNTBWz8Z0QegtaiK6xsrsji+YzsRXrwHhEhWjcaKhxWUwvANyn0iOupcULgKu5AHAzwGGMqtC1s
	5UdWcqfaMupTJPteEhfUOVPuPliDbe7TKtZYwEsaulY6mdalGLTKJNbLQ9Jb6EA==
X-Received: by 2002:a05:6a00:9508:b0:77f:4c3e:c19d with SMTP id d2e1a72fcca58-7a2208f14b1mr2369507b3a.12.1760661035558;
        Thu, 16 Oct 2025 17:30:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGE9f0Yv8LO/RR0RoaRlY7SCaHq3pVc6vgSKnvPNDE9IgXwyKGCiHBZIwanOZsjZ3NSJukoQ==
X-Received: by 2002:a05:6a00:9508:b0:77f:4c3e:c19d with SMTP id d2e1a72fcca58-7a2208f14b1mr2369469b3a.12.1760661035083;
        Thu, 16 Oct 2025 17:30:35 -0700 (PDT)
Received: from hu-amelende-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d0966d7sm23613050b3a.40.2025.10.16.17.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 17:30:34 -0700 (PDT)
From: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] soc: qcom: pmic_glink: Add support for battery management running on SOCCP
Date: Thu, 16 Oct 2025 17:30:30 -0700
Message-Id: <20251017003033.268567-1-anjelique.melendez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=aPD9aL9m c=1 sm=1 tr=0 ts=68f18e2d cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=K_O0-d9jgD1I_3XzafcA:9 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDAxNyBTYWx0ZWRfXxVajQpuSAst4
 XPpWr+tAk6bvYCSe7JlVufzx2sgGB0oOJO2EQa/ILDjKqAPYISljCtB1JgxJU8X7xMKpoAwkOTW
 wQ9LQ+4ICyR4M95W8kFveZt3ervXLjSrv2f5UUtjeStbWeTpakWEUUOLe9bsLhR/XWpSbe82bnc
 wJ3YhwswJWV3DsvfJhtuNtyjVGfL7GBH3ZHSq7q9P5VetBNVtOiG/ucUs22lnDLjB6RbMNPtTTq
 rpGbmVa2pIPL7Sj47CIm9393WteoGZaOWT8hyZJPY+e2nEiWyC6tb0QslLLs0Jzz+8/v0k9PJK0
 f9gOmqa6aQQbfQf/uLi6p6z+cIBPhMDtfkYBC9AiZLqRlk14gdToj/ChMEvW4TapGPSokS3Lblr
 5E/IAi6vYV9Ru2PkOMbH7Kjbo0+lhg==
X-Proofpoint-ORIG-GUID: gTRmjVenl15XAbvqwPICjhV4JeslZKTI
X-Proofpoint-GUID: gTRmjVenl15XAbvqwPICjhV4JeslZKTI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_04,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510160017

System On Chip Control Processor (SOCCP) is a subsystem that can have
battery management firmware running on it to support Type-C/PD and
battery charging. Add support for devices, such as Kaanpali and Glymur, 
which are running battery management on SOCCP.

** PATCH 2/3 - was picked up in this series and prior conversation can be found:
https://lore.kernel.org/all/20250919175025.2988948-1-anjelique.melendez@oss.qualcomm.com/

Anjelique Melendez (3):
  dt-bindings: soc: qcom: qcom,pmic-glink: Add Kaanapali and Glymur
    compatibles
  soc: qcom: pmic_glink: Add support for SOCCP remoteproc channels
  soc: qcom: pmic_glink: Add PDR service path and service name to client
    data

 .../bindings/soc/qcom/qcom,pmic-glink.yaml    |  7 ++
 drivers/soc/qcom/pmic_glink.c                 | 74 ++++++++++++-------
 2 files changed, 56 insertions(+), 25 deletions(-)

-- 
2.34.1


