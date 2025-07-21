Return-Path: <linux-kernel+bounces-739632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD262B0C8D3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 18:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D535D1681E0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 16:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E942E2E0924;
	Mon, 21 Jul 2025 16:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ePn2qgyb"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCFDF2E041E
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 16:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753115556; cv=none; b=RbewqBLIioHD/chCe94zENbFHiUh58m4LobEBl3pbtIBw01oCY3hMMWBATxPHK6K5KqqWQvzXYc+x9FPkLmO1rc7i34EHDO5srxHv9GRSaYfIzXr+jpVnLPO6PfC6oiXu8I2qXSb5S1UnB1xOyNiiCUZJlcmA7xrt44kQItXV0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753115556; c=relaxed/simple;
	bh=iyIzr+jC5KDjXspPRwBZrSh9tU6LfOxoBKt9zdZWbdo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PvZXqDozuY7jUQOElAjtNSaDu9MXUp79SZKRRzpbajDg6CknKXlmJKmKdlmt4YmtBY2Sz2G4TO8mLs3KZqrjX2iyPwy+41zq6PzvpY2m5pfdeoewFD2M/d3qrjbBF61goMaBtXvz8JhBCUdRR53RGsBfshnuXinKJK3FiCs6yXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ePn2qgyb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LG4ucl016289
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 16:32:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=T4Klmseu2Mfh86rZxIp8QLkDs/hpniEhGQD
	JVIutbVc=; b=ePn2qgybduqreyyB2iatoTEJLk+Y5+qbVXVWb1lH8TqElslkGqK
	PGuIBlt/Z+2PeiO5IrPjxbITe6w2H6iFkZgpIPomx/uaxVp/f5IPbdbsiJXQhggy
	W6gIdK4smPLuBgv3gHHo2lE3sP//tD/E0AWJWNWqh/m7CzrTFs37WA2FiO94ig9g
	AInNEnPmktoTJwmGKYWbMkJAmM3z50m1Ercf7GEivxsWl2UU1zHUCCcC9OzBsEFX
	rTbJYbp434LGvKVQ7Rr97W1jb9oFxNjCrVtBo3Y4m4a/djNnzdPfDbvD9MblzGEF
	psXZE15Dw2U1N0D7pQlyqBPRpNZ2lblu7LA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48048rx9ew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 16:32:33 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-235c897d378so42181375ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 09:32:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753115552; x=1753720352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T4Klmseu2Mfh86rZxIp8QLkDs/hpniEhGQDJVIutbVc=;
        b=CXjRaSyLD4TkcirVqXd2aMpOn3fAz9JHnayskwKF6GQXlJ5aQOiCNMhUQB/hwYZieJ
         1J/Y9imlKRpLCuZXSBwA698J60MZcIVVmnjKqVza9csAMv/C2Zk004dMTmOqnmcKQKSq
         Q60U2vgMZeszu4oa8W4I4fpKg0VN/WT2OWCg+JUWOnpoytXi0hhRbjDR2YR40z6N87BU
         AwPj7CTpJPinNPVPpcZdpTsMdX4K3G+ASABUsBl3zsSpkcEttGZlq2ZDXg/8nPkx1AG1
         pb5YGQQeHzyb2V7IdmWPIbC8UDLaYocZyITtsENIrLdg/cXbmkZtr9ARblo6gdj/nxHk
         ZqPA==
X-Forwarded-Encrypted: i=1; AJvYcCX6yTE2uAhz6nVNFEemY+RnJRhBRvWhAFQy2wcziTmLrxh9dM8ZJVK0XkmfcOPCBSIDvra8Jo7DDwk3e1w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFw5ttWk56/OTeo3JpsDw+7B083HYeL31he5X23M3qfIV8mm8i
	rEC0W2D7jC2RfWYw4vqT/FfwfsMl0n+y0VXDyYOWtK2DLRH4QOBk32gm2/k5Be4A8kWbAdF526g
	hUyTPzAqP9nu1Gnbh46ZvBD5UF+yE8N/jRaXU5iDhOaEKJgEji+AAEqAU+CrVhjCzGAw=
X-Gm-Gg: ASbGncsGK9baLFQnSkHOKWF+OSPLQrU7kpvP2vx17t8Sk6Wi41MUgy4lwViiwh3g53T
	XMcG2PnoPOhPsknM8eeXjMbIt0D1P/MKdPhDUoKrHZt6Zbly6F/BIv65l3hdWxk8xVVs/Uka+sv
	rTEyLYxvNEppW2CdH3/CdstlXcfkHF0ESy/t/1PGt06l/ABBm1fK52FFjpzdDTYSZZqZLJkvwl9
	z1WsqPSXU0CpAxMbDsg8uQnWUXhA+YoWOOILmSri3DhkBLwd+NKk3SESYB8J9Ol96deFHTgv2ic
	1/4vAgU31KCKGRh9QM+VqtvwnGpuZzpHYxwLYr79zMcCPmd6y2ol9kvqbgi0S0psfhhy1zww7QO
	a77YUtZVmCsNCZYyWzqS+NCktOfGWdfSfa6kLNl/+fKW9aLjoSpkDQ7AKwYNg
X-Received: by 2002:a17:903:b8d:b0:234:986c:66bf with SMTP id d9443c01a7336-23e24ec7396mr273613925ad.11.1753115552385;
        Mon, 21 Jul 2025 09:32:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGC0qoXvxpN+826ak4QR0pKSE6QgwEdRBv235JvB5HIj/InSR7Zq+Oi7gRegvz0g7tfqG2gRA==
X-Received: by 2002:a17:903:b8d:b0:234:986c:66bf with SMTP id d9443c01a7336-23e24ec7396mr273613485ad.11.1753115551964;
        Mon, 21 Jul 2025 09:32:31 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23e3c3b2c4esm59893255ad.189.2025.07.21.09.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 09:32:31 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
To: andersson@kernel.org, linus.walleij@linaro.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, quic_rjendra@quicinc.com
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] pinctrl: qcom: Introduce Pinctrl for Glymur
Date: Mon, 21 Jul 2025 22:02:19 +0530
Message-Id: <20250721163221.310746-1-pankaj.patil@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDE0NiBTYWx0ZWRfX3Fyd1M2VvLmm
 QElNV0H6YgH84fHjML1GJchfrpi+dLJIiEiU1qRME1WSI2B+wVTytQszt1v/IdwNpY9tAtp5Dg6
 wCQ6rB2lKy35bTj4LrGmlOOs6Xo1xehSp5vDJtayGqTtLZjLhBZjwRW+SO9uxi/BmTuS3FwMI1J
 PpcRKDzR9PBQkS+S9hcQGHoLi6NDhdNCoP9bhOheDxoAECQS+BMIiEKiB24C9goPDFhiLpqfiwl
 IJvIAAZC7C8H48sTzsOqam0c7AzvC/KJtSNW4TbvPNyP3AOfKxaVsNBLJVejEBZF93a5NvwQA5f
 HCMY/ZHUHAeuYStmsT7vdI+24kMNVVgn1eWCamKfgKr7FDx+rj1yWTtiBr9Lml84c65ZuDtGuMf
 6SvinUnLtuhZ6Dsd/Z3V4mdyutmOr8n56iKTLnriEC2HoV7LAh/KaCyWbG98k7gPjiaEGqcw
X-Proofpoint-ORIG-GUID: IzMrlugLBrim5zvl_cwZzEqFIpF1LVzh
X-Proofpoint-GUID: IzMrlugLBrim5zvl_cwZzEqFIpF1LVzh
X-Authority-Analysis: v=2.4 cv=OPUn3TaB c=1 sm=1 tr=0 ts=687e6ba1 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=Wb1JkmetP80A:10 a=TVyXueylgh4vxAmsgxgA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_04,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 mlxlogscore=892 lowpriorityscore=0 suspectscore=0
 spamscore=0 mlxscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507210146

Introduce Top Level Mode Multiplexer dt-binding and driver for
Qualcomm's next gen compute SoC - Glymur.

Changes in v3:
Fixed indentation for example tlmm node in bindings file
Fixed s-o-b and review comments in the driver

Changes in v2:
Fixed dt-bindings error from example node's reg propery
Fixed gpio-line-name maxItems
Driver UFS_RESET macro updated
Removed obsolete comment for pingroups
Updated ngpio to include ufs_reset pin

Pankaj Patil (2):
  dt-bindings: pinctrl: qcom: Add Glymur pinctrl bindings
  pinctrl: qcom: Add glymur pinctrl driver

 .../bindings/pinctrl/qcom,glymur-tlmm.yaml    |  128 ++
 drivers/pinctrl/qcom/Kconfig.msm              |   10 +
 drivers/pinctrl/qcom/Makefile                 |    1 +
 drivers/pinctrl/qcom/pinctrl-glymur.c         | 1777 +++++++++++++++++
 4 files changed, 1916 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,glymur-tlmm.yaml
 create mode 100644 drivers/pinctrl/qcom/pinctrl-glymur.c

-- 
2.34.1


