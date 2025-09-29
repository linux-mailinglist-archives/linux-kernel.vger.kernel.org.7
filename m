Return-Path: <linux-kernel+bounces-836375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE93BA983F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 16:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18BD23B6893
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 14:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992A32FB080;
	Mon, 29 Sep 2025 14:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MoZku9W1"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E0B304BB8
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 14:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759155436; cv=none; b=KS+tCg6QCgdjg2cOJO/ittjiRIh0jO3Q1d7j2TRa4gA+XDJbOgabMQisxIIqfHOMvGmzhvqZSQiJtLz+g8s2Acmv6v+cV7ID64omlDQ3twyxQqKPrbZGJrykGAda948+fony1fWtGozdf2OXHWf0tIuh0/i74H2Tf+cMgKu0h4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759155436; c=relaxed/simple;
	bh=wuz6WpMR2FmYpCZb3KByeL9QSwX48+1y8xgDD41qeCw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CyLfA91OIU5InH6liFdvE78orFEWdxK8INc2KvPOsz5nMIbkF4Fx2xmLbCnEzsdUzPaAP6I3xSJO0/XA5nW8/XCYCpqpSRmHRnuFkKdzwDau9NJi7kduJkc7FamVJg+N0b6XkzmFYPkJeebv//X1gRGlJ2xBCNl7Ik2RcnfKHBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MoZku9W1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58T9wEWw032185
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 14:17:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=uSpw/jCs9xhUh5GAV+l3XS
	y8IK/VN6IuG8B8IRTx+ro=; b=MoZku9W1c+YWsHwOU08oVAt4Cd06WH5uxYJDdf
	2XT/+b1/eSBt0HnfLVtLg1NE9NaBii1LvOgPgXBPtKD6V5GCVHdmotS/blSNdisW
	fZVQVlrvu7d2FR09UgIZpkSqLEeDRB7GYJHjGl2K99PHq5EbHXLUO6KR1OhWlU86
	wtehvLeP5BWYm/SpnU7x3O6cT3ct8F0KEoF0udfhO07ZKyJTdfZadxo45r7eGPbQ
	PiC5sMoKh4Hql4iEp/TPDErwwkEyNbJhGvhUSaMU8MVYtKJnsPKCUDoCJwAi5U9o
	h4r4kRYO3sZMSB0YUMOUDjkvjBBfxDf6ArR9WZdZKn5Th9ew==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49e5mcntb5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 14:17:14 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7810af03a63so7913576b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 07:17:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759155433; x=1759760233;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uSpw/jCs9xhUh5GAV+l3XSy8IK/VN6IuG8B8IRTx+ro=;
        b=K568/7SMjVAmRxx1t/HJgTpPJI9oHJRgO8nSkkgherU9Op9sdbqMn81iew925wYYVl
         8TiHmCVhRspOycAkfsufErbjOjCm8oHe8KARtUWl+XA0bJFF+knMfTbGYjWusBGWHOuM
         nZWELAI5ucW651BPjUIq5t18PHPNKQPLXG3qcWJLhVJ06QzRUa8AAQNZyc2kPss71KyM
         Gduf3vD8BQDSwI08X+yihiv8Bq6UX/EgcTMA/DaWOMZ/7wHH705Xy7MQRvE9rH5nKxDr
         Zbo2q8g1cxn1D87nGEh8/9RSBxRcya2UeFLWbIOteFmQiSjAMhk5mi5AW/bk9Q/RCHYs
         NcTA==
X-Forwarded-Encrypted: i=1; AJvYcCUpTEab5ASTiJ6DgPGsDK5V/8mJFSmsj82Irhnt2KLIEt9MRvYl0f7eWxjMaVfifw8useRcLc8pbw94aA8=@vger.kernel.org
X-Gm-Message-State: AOJu0YywpRZwG+FNV9DwZ4ODPW2mb7G7lErkQjJ6osuN5EIjhAOyI5di
	0Qywh5ABtYFJB4NOSkOuKsLQr0mU4tYyQY+ULcSa/5e4vTkE5HTfbpcDwzjTBAyvCe+NjIFAzH2
	+pddiSlzly4uYg6H/D40K0HHRQKbgKyTCXFDJToAIeOrG9td9wvs5wH7veh9RnQ+CxP4=
X-Gm-Gg: ASbGncuG3D4o82hW8z61kLz+l81fsh147cc2B1srIrvAccdLCdzWF5ESF3miY0SDdat
	uWfZXEl9ij1zakqObXj1c6EpMVYSrcMAj+t0lKHoT9gU7SUlOzqsYNnnKDkWRn5y2zs8a3q4C6e
	jHxksqf3H/zbzU9SZKTAbMVSGHae2FRg1vO498EBtE7xhkd+23O8+IZmGWVPYN5l5ijgiMtBTtk
	T0muV7k7LjvXs3ZDaq3tbW7fSrzUiYotqqvVX9axORdDrNDSshR2banTcIcsiNsVy3lHnHSkubo
	PQ/Sk5Xa6y5jjt3pHOLX8np1T+1Zz4V+IGRkHl84W1duN26AgoaL5H2SPsHZk1NhUlvl56G7bwz
	Lte9pTRXAvJU0jGwf0fMrOb0iRvrSIqHkqlvbEVMDiFt8xmstBARHy4cigC6T0yvsPJITu/wlOs
	g=
X-Received: by 2002:a05:6a00:3e0b:b0:772:2e09:bfcc with SMTP id d2e1a72fcca58-780fcef7c3emr15809846b3a.30.1759155433456;
        Mon, 29 Sep 2025 07:17:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1gDeS5o+KAXQUuBVzHve/ZhNQQy2xaT9LbSgMWBNNxR5PRH1SP++JRQwj0MYWsqBxi1blAg==
X-Received: by 2002:a05:6a00:3e0b:b0:772:2e09:bfcc with SMTP id d2e1a72fcca58-780fcef7c3emr15809824b3a.30.1759155432990;
        Mon, 29 Sep 2025 07:17:12 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102b23a48sm11536334b3a.59.2025.09.29.07.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 07:17:12 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Subject: [PATCH 0/2] Add the missing entries in the SMEM image table
Date: Mon, 29 Sep 2025 19:47:06 +0530
Message-Id: <20250929-image_crm-v1-0-e06530c42357@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOKU2mgC/23MQQqDMBCF4atI1o1kJgaxq96jlBLjVAONsUkbW
 sS7N7ppF24G/uHxzSxSsBTZsZhZoGSj9WMOOBTMDHrsidsuN0OBStRQcet0T1cTHMcaW2U0Ko0
 ty/sp0M2+N+t8yT3Y+PThs9EJ1u+ekoALLmXTKEmVBuhOPsby8dJ3450r82ErlvAHNFD/A5gBB
 KErAVIKI3eAZVm+JPlpweoAAAA=
X-Change-ID: 20250714-image_crm-272b5ca25a2b
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759155430; l=802;
 i=kathiravan.thirumoorthy@oss.qualcomm.com; s=20230906;
 h=from:subject:message-id; bh=wuz6WpMR2FmYpCZb3KByeL9QSwX48+1y8xgDD41qeCw=;
 b=Ivd5o+1MFNJUhI+xw2CZ1QgKnBFe6oOyE6kdkgHM4X2JKrzw2QVMSDUXM6YVNMGehrsLvxFSw
 /gCxTVL/YEnDBMTr/x3FnJR95XJQ8WwPN/5oM0E0QwA3dsoYZ4bYVnp
X-Developer-Key: i=kathiravan.thirumoorthy@oss.qualcomm.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Authority-Analysis: v=2.4 cv=RMC+3oi+ c=1 sm=1 tr=0 ts=68da94ea cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=bJqOVrwxxN2ZfhMSaZAA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: 0tdu7SgvN9LOlw_80IOEWv_flPYHyLOZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI3MDAwNCBTYWx0ZWRfXwRAxyvviq7r+
 nckcZWvnB/B7QPKFYA9XPszUB3Rw67dVKD83mtbN7GUjNEJyS1NrpNAxiHzZyMAzgte6huPjb/2
 EjPzZzlZBj9mlIpJLXHU8M5CF3JCGzoiRLM+ybitM7XsyXhx+rHRYgBJJoWzY1UvV4qodB5O13f
 StFv4I1Yr2Qg1i1NVAfgCcnCUo5ntq/ggACfbvb3QdVKGkHXw8AUf9qN2fUAtZagsKbMAt6pYb7
 m+Tabz7KPqmG9X1dw9lNzl29wx5af7GQGB5dI9+xM9zlLMcAdtxJyX5FI5G2O8rkyg6RsOvJHvr
 O6Ttdmuog3ukA5lPwTgyNDFI5qyqH0KVdVcEXGmXOXB/j1v8D5RVPoonu8ub5M1xYEnSUmN4R0z
 /6JWtzsGtDcwRvPIahk3aBaqdUGIyw==
X-Proofpoint-GUID: 0tdu7SgvN9LOlw_80IOEWv_flPYHyLOZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_05,2025-09-29_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0 spamscore=0
 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509270004

Rather than adding support for one each image at a time, populate all
the image details at once for the completeness. Additionally sort the
socinfo_image_names array in alphabetical order.

Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
Kathiravan Thirumoorthy (2):
      soc: qcom: socinfo: arrange the socinfo_image_names array in alphabetical order
      soc: qcom: socinfo: add the missing entries to the smem image table

 drivers/soc/qcom/socinfo.c | 46 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 40 insertions(+), 6 deletions(-)
---
base-commit: 262858079afde6d367ce3db183c74d8a43a0e83f
change-id: 20250714-image_crm-272b5ca25a2b

Best regards,
-- 
Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>


