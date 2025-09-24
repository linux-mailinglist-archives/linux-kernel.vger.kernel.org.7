Return-Path: <linux-kernel+bounces-831088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E91BB9B830
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 20:38:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19D3F4C5324
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 18:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7862D314B71;
	Wed, 24 Sep 2025 18:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CY1gpxMA"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4169E29DB6E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 18:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758739078; cv=none; b=otjstysVjSpoMRreZhsn74+TUUOqUB0lPle+X1rOOkqXlnZyi/idkJCuj41u1x1zOjMqnJRnDczX4pBgu4CNyr2URCPsW/pC25/zbf/EVxJbz5YdR8lxsqhjRAV2qjT7h+Ki68GylJMMD6jVdkcZbeMrxlePH8OLLC4lT71uOxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758739078; c=relaxed/simple;
	bh=mzcBpIew28uM32FyQmevqMPECn+YhIPoaGvu5PHcgPM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nPbwZ3uvnJ6cd2ubCJC+8v6KgrV2pUujv3VKz1PVlM7oHKrurCVZ6tiNY12MDLUxtZVCooXqECNSm5IxUW1RtV9t98BM/g3JkmJYURx8Iv3Gqt3uBP46RDMaoDH0xxEwDPZ6Hiu/WAVoxSXFhSJx3kvoL95tIL3zftVYMtAilMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CY1gpxMA; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCQeJY022115
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 18:37:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=2YJp0AJoPJela+qIoEKQr2oyB8xKumCAl4d
	Z3LNuFmg=; b=CY1gpxMA5Wirdr3GLCnE+1AEoi9PX0us9Fyf8LxOeRDJzqekzc6
	PbyyDitdDPaPEv2406hToa/CCclZ/S3erCFVNfad1V6FwSD934rgkJNiyOYgiSiU
	0QiU8DkqEKWOk+QrIHzN7e9SUuiUFC7KZsSIopfxQ/gx8BkSFFkc3WQ10BdDEX6B
	FZzYZ78OWCgmH7eIYfTrEtYxfFuyNDEu3jSAGaqxwbggYgWJe+sxcRxwkLqqcOJZ
	mLtzjWPJ3t+Huo6hBSRTiOXlHR39sC6G2TsfevRNRlFkSiPsbSXUFK834U3UR/kr
	hHt7TrXlufUv9avDC1arHMVk2yHaXDVnreA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49budacyuw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 18:37:55 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b54d0ffd172so55663a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 11:37:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758739074; x=1759343874;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2YJp0AJoPJela+qIoEKQr2oyB8xKumCAl4dZ3LNuFmg=;
        b=whzSywLwIkj12qX+ErZuzwo8enM9jcnI1IdKQjch5ih/MfWysSuy8PU5e4SvgEZi0O
         KL4MFC/s0//GtSNzh6d7/eUpsjSRVQmfnc11n7+qA3tg+9FWBJPBO7xaSMoiLz6GSraP
         S+64WU0RGGJEZW/20gwgJK/4UzK1lRr1P7KADuknVLc3ACh7wI9pQbCjfmdDVllTWwmi
         6hGAUG1RuE4LF+OgvrWWP3RonHFbwmOknO+p77qem8z/7Heh41KArNI5vKWIm87dYSAG
         3m8XtD130OYmMaXYQMd/2Fvin17mH2koTG7yXHISsaJBaFvdCGFI8CPi8RtjCNZqxeyJ
         mX6w==
X-Gm-Message-State: AOJu0YyvxSfDOSuiYk+h6SmJoMvg1N5aAUqonhH/ich8c0NwCQwpYTdN
	DDjT5fm5YjIbHWwWm5+IcM+Xsw8ICmyMN1Jq22BGfg99e1K2QdAs//YIo/sQTVqQaXrYd3NU0Xh
	BUaDiwmFctW2Gtgg16QkxypzILSV3cMqCnhb2MIuT8QbaXNiwGnNizVNFVSfakXXmQ3Vh+2wwlW
	4=
X-Gm-Gg: ASbGncsssn/CtrjjBaVKBbzd1Nibk4zsN/A7iK8XwgCPv2zP+RFhNn5FrMHC5yndMAM
	242stHeCTtC6olX/CarnpVbZH+eILWrdrc7JSmcuAw9izfwGQRS+S/IOuoekjE7QygGs3H8blE/
	8SrB06pdqH/xqknMKnn3XubT+RpyD7ZYo+kShyM9z8EvRBH5spH6e50wIE5wi+Z9YUZcKO3TIgf
	Yk8b1ZJJTIMy39zA/o4TJ9dKQC8RukxoOy3zETPABzh3W0c1Y6znyVDS0vV//ZhULECDQx/trEF
	k+a3vvz1uKMA/dROMH+DQezWBAunf7sfAuTKUYbt5OxtmmXXNFeSOsWQjbG951313bgt76aD0p8
	5RoOEu0k/So9pvPGFKw/oCotoF/dhcdVfUoUcITM4urnEseAEJ/azSMc=
X-Received: by 2002:a05:6a20:7348:b0:245:fc8e:ef5b with SMTP id adf61e73a8af0-2e78f003672mr806192637.5.1758739074413;
        Wed, 24 Sep 2025 11:37:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJgBc1x8MlTWvXGM1116gCob5y5IWdsvIyBP1B7OfN0lEnpPv4P9NKMSOaFxcOpNFSOkokkA==
X-Received: by 2002:a05:6a20:7348:b0:245:fc8e:ef5b with SMTP id adf61e73a8af0-2e78f003672mr806160637.5.1758739073966;
        Wed, 24 Sep 2025 11:37:53 -0700 (PDT)
Received: from hu-sibis-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b555adca754sm6523412a12.16.2025.09.24.11.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 11:37:53 -0700 (PDT)
From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
To: jassisinghbrar@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, mani@kernel.org, andersson@kernel.org,
        mathieu.poirier@linaro.org, konradybcio@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: [PATCH 0/5] dt-bindings: remoteproc: Document Glymur ADSP/CDSP PAS
Date: Thu, 25 Sep 2025 00:07:21 +0530
Message-Id: <20250924183726.509202-1-sibi.sankar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: S5ap8u2va0vWH326Aidq3m_acxVlLxmL
X-Proofpoint-ORIG-GUID: S5ap8u2va0vWH326Aidq3m_acxVlLxmL
X-Authority-Analysis: v=2.4 cv=Yaq95xRf c=1 sm=1 tr=0 ts=68d43a83 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=_X9-DzOTpKYA3bgxq-AA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDExMyBTYWx0ZWRfX6wRXqngkSDMh
 l71mNg+0WDXZgzzz79Vq1jnV9p4rQkF61jtCaU1DavSVRKkNwHGxLevnYjMHRTAMbGRSQKdNqbZ
 zST1S83/FWCe1zFLFf7oWpWY+MSfdCz26JZFCYtOZmNRrJio6IiVtIWHG8hKGeu9pYicb1ViR/G
 Pctd9FUMy3cpuuIUMyzQpooJvov7p2tO0L6bDRbjqOnBOt7MkTTWmsOyZ+Mb/x0NanlalFsbGVs
 iYp0S9wQi4rrmHfz0t8zYlqTG9DgnBzAefYUdG5Ukd5GgIsvGqrXnEDqdkuWdNkaeynamQeZkXA
 Y9MEVnFDSelLKxBo50NHId4wewyrb2YmkPTVs5Di0qLfy3cpVOtwu7Zg65XKHZKnNsbzT+h6NFR
 qqlCuX/1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_04,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 suspectscore=0 priorityscore=1501 phishscore=0
 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509230113

The series documents the AOSS, IPCC and ADSP/CDSP remoteproc bindings
required to add initial support for ADSP/CDSP remoteprocs on Glymur SoCs.

Dependencies:
Peripheral Image Loader support for Qualcomm SoCs running Linux host at EL2:
https://patchwork.kernel.org/project/linux-arm-msm/cover/20250921-kvm_rproc_pas-v3-0-458f09647920@oss.qualcomm.com/
Patches 4/5 have a dependency on the iommu binding added in ^^ series.

Sibi Sankar (5):
  dt-bindings: mailbox: qcom-ipcc: Document the Glymur IPCC
  dt-bindings: mailbox: qcom-ipcc: Document Glymur physical client IDs
  dt-bindings: soc: qcom,aoss-qmp: Document the Glymur AOSS side channel
  dt-bindings: remoteproc: qcom,sm8550-pas: Document Glymur ADSP
  dt-bindings: remoteproc: qcom,sm8550-pas: Document Glymur CDSP

 .../bindings/mailbox/qcom-ipcc.yaml           |  1 +
 .../bindings/remoteproc/qcom,sm8550-pas.yaml  | 22 ++++++-
 .../bindings/soc/qcom/qcom,aoss-qmp.yaml      |  1 +
 include/dt-bindings/mailbox/qcom-ipcc.h       | 61 +++++++++++++++++++
 4 files changed, 84 insertions(+), 1 deletion(-)

-- 
2.34.1


