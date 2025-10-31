Return-Path: <linux-kernel+bounces-880033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 075F0C24B60
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:12:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 280493B240F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22EA2344040;
	Fri, 31 Oct 2025 11:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CKSvxiuX";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WI9tNwf6"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A202E6CC0
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761909111; cv=none; b=VyZvcBTZ7fC5J5eVYpqSNqhE3GY0tA3h9zFvxgb89nJPE7OOiHJGooVZKDmHdfsjmG+2xoZ7JY3vMKz+cNsF3ebSAbTABddWiqa2LLPyRUYNvfiW1xYzHZOlpFfTUcTuxoFTYBI/Gfl2CKtwrg7YoJAQl4kybhH0+0JwSiLLvng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761909111; c=relaxed/simple;
	bh=IDcTRTACFiYoEA0iAfZy79mZ6MD8hp5U9LyFyCMpZDc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NBMe/RlQY1o2xuQAGXCuyWGO3tDtiA9fq6v5N1nzCfv9aG8MC8vJoIKpvpI1XlX7bLxg4MR2fDP0WoPMYJ1JMomCHNaVh7X6ZZLTcWZNLOv82NKxKMdS2TY444njGKGBlY28BowuqSXxf5bbmZjtpvmA19FT8W/tKJnXATIPeEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CKSvxiuX; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WI9tNwf6; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V832fN873870
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:11:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=O8jmHsfI7j3mpprPC9vCGVH2KzWiYloucUY
	A5jACBSU=; b=CKSvxiuX99BiWWBH7sdy/10FT0T00zMIbKRh1hMcjdfwuF3FaGM
	F0liTDiMwkFD6uV1kC20obvTbWIziQnbTUy3kqBxnsCO/ZoKAyNDF6Qs4+R1j1tA
	mPx1MB/F2GGKPnZLb+3U44bL08abUrLxYPxMtW7fHoyQs2b4HyRqIXiGEd/t0ltO
	ZGhs/6Q+MpwEabC7tGdQufUlVRV6sJP+ehzPwVVcVmCKLjDWo0jCyJJHT8wv3zJ8
	ord/ybLg3FL0oXP+kVOedsamRdvPQO3ewKnaSistx2mQRcqeP0JPRjApfY93YCEM
	3HZskL7d4sDRhnekcIf2Sv6KulyJH2oWJmA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4fqn1x2a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:11:47 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b5edecdf94eso4108399a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 04:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761909107; x=1762513907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O8jmHsfI7j3mpprPC9vCGVH2KzWiYloucUYA5jACBSU=;
        b=WI9tNwf67EN4nW2RbVDND/8C0PVDPdFR2aZmeXJntddgpuWMgjamBKQC11InHEh6M4
         dpma6ikFVaeGgPaC1WY8VJQYE6NdLQIcfUdFumVvP22n+z+wyBbkvoLAiD5Tw0HHjat8
         5wSEnfcPeV9ZCT08tISsLeNgAEUa6LkMy+Ryi+/kTDWaXDkLTM/0yQQkoxm6Biz9OMbi
         MQOiAJWkKQcBRh2svUoZ1gg9MyLRVja93k4FqopcgoUOtveC+Xl4G/ncZ+xfArczwmI7
         PfImZha3m/J347BKUvqFHQn641GDkvY4sKBG5CaSeyPw23eNn5o7CmKGh20WmbkTZt9e
         7ijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761909107; x=1762513907;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O8jmHsfI7j3mpprPC9vCGVH2KzWiYloucUYA5jACBSU=;
        b=F5ChO7Mw/4re53ix9U21sfmo0+VSmunw2w2ffFPbQXKf7Cxc234X659RRErRBgHJFu
         Gpd4yKjALzjdiriRx3mNvow/Fr+DDnKzuRB0sxzBSJeWGOtdGw+ez2l2pUqaebi2W8Fl
         9h4sGRCDO1abz2mIJNstcjC6Hm4SbknH4vfn1vmSG0EZBDwbQXEPtoOOfCIRApnQlkWK
         lFh2XP8UC8iGAI8gLQDd2TPwhy2y+3gyCLjO7T9EcGymc/HEPei9e268MuaihKbIJu1+
         kWMWOBVSIy1dAEnDEI9y6XHLUr13X47j9zeKUsQqV/aqMs4PHJbGaOgAtdFXTLT8Y48c
         FBow==
X-Forwarded-Encrypted: i=1; AJvYcCVcgRa7IpGd110E09ZaRS2IG61NSOhSDiS2/ql7c6ErQr7PHFGukiG4rbA/ZBzDyUdtXijgXz6ysaCDg2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzRdpzG+U9yKvkbnzEBqZWSiylJPt8AkcWrqa2fcjNC38MV8Xa
	Nc0PhUu1Oh4g395rPCVBMDCeIDarTAHL6L7hFVJO9BmlUOsBgtqkNy94p2JriyoXiObLUI2KTPY
	T05giMKHuruy35xQqdSAMuG2tB8EupqxDNpEYZFRR+dmlVJAglUmcvDzHtGxpWlTF8JA=
X-Gm-Gg: ASbGncu3olgk/q65+TWawcwJUDBoOcWK8hfzhHbE21cz5okQFCSBb372MrFp/isaP4k
	y12yPifaqn/vWLm6fGUKt+tuVKHg+/+YJYeqQ5Y3t/lOROdra5P72OC3Bt/JTTBr16EbkigOJxv
	sxwEZ22r0d2Xticvwg0h7uSz84VjXQES4ZGbDMrUaUNnh0OLcM0Q2wA77vBLBOMGSDN+CZz2+dv
	pLIfZ12S+19iwLGH/pTX69q4HcldsekCtwHbnqauiiqv3l5pI0r7th0Mx31rt3yuzltZo9Z4od+
	/uvCUd/MFF1MS8Mf60UA73PZW/BcjmN00YWkVSv1E4Ek9xEpGPD9Snp/wZGJQ47hHM8ILcp4p1r
	y8LWpRcOLhvVEGvtHS0l+4jyUOfVMaxhgXRGfniONoAqAVRuZEQVp
X-Received: by 2002:a05:6a20:3d8f:b0:334:8d1f:fa8d with SMTP id adf61e73a8af0-348ca762efamr4261435637.18.1761909106544;
        Fri, 31 Oct 2025 04:11:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3afHY3dtpovWcwdTrIQcCAO+PFFAWXBTqpskCU1j8Lnzsmy595gMOOo6WBgKFOobKc8G+0Q==
X-Received: by 2002:a05:6a20:3d8f:b0:334:8d1f:fa8d with SMTP id adf61e73a8af0-348ca762efamr4261385637.18.1761909105915;
        Fri, 31 Oct 2025 04:11:45 -0700 (PDT)
Received: from hu-punita-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b93b7e197cdsm1804407a12.4.2025.10.31.04.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 04:11:45 -0700 (PDT)
From: Punit Agrawal <punit.agrawal@oss.qualcomm.com>
To: catalin.marinas@arm.com, will@kernel.org
Cc: Punit Agrawal <punita@qti.qualcomm.com>, chenl311@chinatelecom.cn,
        liuwei09@cestc.cn, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] arm64: acpi: Drop default console log message when using SPCR
Date: Fri, 31 Oct 2025 11:11:36 +0000
Message-Id: <20251031111138.1262202-1-punit.agrawal@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=RL2+3oi+ c=1 sm=1 tr=0 ts=69049973 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=o1th0WQ6fIS9ZaslAAcA:9
 a=bFCP_H2QrGi7Okbo017w:22 a=HhbK4dLum7pmb74im6QT:22
X-Proofpoint-ORIG-GUID: hAqA8Ge8k1K8RJGQjScDkT6uwi9MGjIj
X-Proofpoint-GUID: hAqA8Ge8k1K8RJGQjScDkT6uwi9MGjIj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDEwMSBTYWx0ZWRfXwCCSBpR/TSAO
 LYZv5PgCrab4XEi+ZBitV27iX5m0P2HFWGcBl9Yq0MCBbsAfHXvkdNk0+YpCy+ReRXv5OEYXu9O
 6U4r49ACZZOqRgkNOnbqxp+1O7BhYAdJhI9pZEvQEr/UCJT/14lygBAqakuwyNK/AwASXtISYb2
 z4x1SaPXMD+ebOnqsHqRncNluwkrAscCRhM/9/UfiD96rZ+IenuknZkUyDNOArx3yUL2B8gutn0
 8erhrT83NzFaN+ReQ7I3OGyawO5dBA8CBXKF46GXmkDfKNxD6fMeww2eEhr2pmE6DA8HhSQ90sD
 8IutJPkTZQzRqpx5BXuKOsS9RvO/j42eGA6+f6IKk9Q33UwbntoxEZbWKhidpJfi5VxUZa/TsCX
 S5wXlIXF7OhOgEjezfOoGU8PgZmR4Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 impostorscore=0
 phishscore=0 bulkscore=0 adultscore=0 spamscore=0 clxscore=1015
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510310101

From: Punit Agrawal <punita@qti.qualcomm.com>

Hi,

Based on feedback, I've updated the original patch[0] to instead drop
the default console message when using SPCR.

The first patch reverts the incorrect assumption about the return
values of acpi_parse_spcr(). The second drops the logging.

Thanks,
Punit

[0] https://lore.kernel.org/all/20251027141941.3089914-1-punit.agrawal@oss.qualcomm.com/

Punit Agrawal (2):
  Revert "ACPI: Suppress misleading SPCR console message when SPCR table
    is absent"
  arm64: acpi: Drop message logging SPCR default console

 arch/arm64/kernel/acpi.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

-- 
2.34.1


