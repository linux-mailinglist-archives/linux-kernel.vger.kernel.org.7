Return-Path: <linux-kernel+bounces-879525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A48AC234E6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 06:51:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3291F4E270C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 05:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 519402DBF47;
	Fri, 31 Oct 2025 05:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ntjqJ7xK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="T3OhUHYK"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6E129AAEA
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 05:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761889876; cv=none; b=JVYsFy+K3fyV73tgCLoUfqxHKZRxDRx0bcUYCI57lOWO7SRJVV7s0uIfUkzXj5f08z7JYlpM4aDC+i5EjLfmmf++P54+mDNcR3BrAYet8syUL9/u0njID28BeoL7BdNxHxkySkpHRgH87HxKvwbpdR+Yx4YncgDMDmqq5qBYSF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761889876; c=relaxed/simple;
	bh=/DzIKQ7XWn6XEbzai7GAbGUo88mw4Mg+1am0ONKm6R8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nFeMvycOn9IlWt1e+o9+tIYaBjZP5kbDsqKsbM3GfvnbYqlcQaLVdeHqgpfWPkfMhLOx7vjZV4yQzhtGt3Ss7v9MN1Bvc8kIalrlZzLqCGd7X/Wit9bo/cEq2pEwHis96hi0u6XArZEXjS4bvR1jzKRPmb9vl0lIMYruA/W7XXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ntjqJ7xK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=T3OhUHYK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V4MCVP1827950
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 05:51:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mIQz1cokq4RxQicP2F0TuAgbqbuY9MrpCe10+qTKnY4=; b=ntjqJ7xKyRf4CAK2
	UMWsTAvnQi2xc3lYCX19cdLfe3Csdh/Y1lx3F/mSnEptQbEBQFsKCgxXrrwu31nc
	qmhfl4hVj3svScLPa7MAgYVuxajk+X8KwZkUM5Y8nlT7jLLCqZp7dFjyXF2O8IY6
	/PqijMO3puRW1TBCZ0YZjrU8ON+mhtqlGJtsyCaRpSuvk6iuKReKnvHgHEof2vS8
	h0lRK1NBKhqoxFE0GRZI1ErbRlLJwd/BxzB1+OTWwR52fG3HwLU+CreIPXq0I5/3
	ktSJ3zSx2WVQSvmO2LkOFjFZzSpB8WGFhv8RPgf0mwPGW5BHse4de8GcM3ECIbfH
	moiAHQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4p11r5n9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 05:51:13 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3405c46a22eso1642126a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 22:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761889873; x=1762494673; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mIQz1cokq4RxQicP2F0TuAgbqbuY9MrpCe10+qTKnY4=;
        b=T3OhUHYKC5iXopJ6pTUGpDFgZ1R89afEsoXyCW3HuFkMOfYd8Q+EbLLWPAglhWvkcV
         Iq01EwU8Zr+WKe7Yx9mxetWG0Kv8qRSA/pDWTv+H9hJ4P75AoDSBVGkv55FduvxtZ4vK
         UDMORmaNBbKGHoQX/bICCo1JwAP2k8SSD0iI3EBZ5dK8EaclooBj/haO+QoGgGznq7OP
         hA23vZT4ufJp283B0H7Jge0mID6dqUyELurfzQFijDF7eC2PM3BuRknpvv/m6V6OAavH
         cGYym8+GBFsTgaAxWqu/ibNdE119rzF8b5SPvM0miclui5O/d+flsQjzgHX//jbZF0lb
         bIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761889873; x=1762494673;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mIQz1cokq4RxQicP2F0TuAgbqbuY9MrpCe10+qTKnY4=;
        b=XjfmQHJqnHCXdoazsoLEmuJqe/wmP3Q7yw2C4ao7aHr03R2GB33mSaHu+yMvoQMPpF
         eEPfRBSv43bUPqpKm4MpkCxGmVRfsj3B3WnSHfn2kI0ttjTLxFXJQVnaLFqMJiOzA86Z
         nf/MT49o3/PmbrV3hy0AP8sSkznnmkUbQ3O3dFYfKfYOXFc1R2N7BhOrVXJK13EzBTu9
         Be7R+3rJQTK8NOjzEvlWliJ6J8UeDeC0/tWwqgRUAD/PGn6mNhsioRO52+qD5jdCA/RN
         AhW3OLzbbTAAXJlsg7ufInzidd6hFKLprVUDjeXRdf2/BKn6EnJNQ4kg7bWimVqj93L6
         9tMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUphdZXE5PLDjNZ8RRi4oLwqgwAXYM8e82xKO8YmUVOL53riqAFfHpebqK2S3CDO6K7aH9zAcReR6S3coo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz93YnssQeAbNBm5vfSz3vpH6Tsi2LObBHqfcVeyUwV/RACmrhe
	WctND2QZxkWKDixgL4D+95tC4F7qQ61c/KOXOcTkdqP6Alad0QddrPmBXB2oAUNm62YSbSiCEJb
	kzmo4Iyd9hJ381AyMppz0fCZ3T9QxLVfWDxVQn0cNNkbuDiZAQ0P1+/9X3xuffJlQfhKq7+oUTU
	k=
X-Gm-Gg: ASbGncthj43wD03nvYkdWNAoAFlmdJEn0bz/6tmXsSlSFuvoDSRfB/sO1jKo0SDspMv
	c6wFbU8Iv2hQUI8rKbdvrT1ntG0Rqi7rTb9by/i49U7o8zaO3+GQzMS/8f3Nj5EXfsKNrFdHMix
	GwiMeWWFvpS+jNRtRTCrsVgn0yJGw3BDbZ6sYo4ugqa9MOCOcdb13vizeDIJpPfRoexN0p0yHSm
	+8CPmNuoByLm9N+l3Z6nh3eji8n/ICB/3jCZ/rjlT5OuRgr+jOtV6rI6xIeZKwuA+rPGzKbkCuz
	rJ8hclG7gMrfAwH5ckdWzIL/E+go8kWlBwS+bglREIpGJ3Zll/ur7IHpjii8Jqwe6gpRejL7eWa
	MIqvsaYIdwCUF1jJIefDQH5sHBNV7DdAXthuQioI7yCtd/J6dvofxttduKDDaRw4j1/OyiAFWxF
	SGcsSF7AELMdi8ka4ORuo2sy++ck+B4TRDYg==
X-Received: by 2002:a17:90b:3f84:b0:340:7b2e:64cc with SMTP id 98e67ed59e1d1-34082fd8a43mr3260736a91.15.1761889872729;
        Thu, 30 Oct 2025 22:51:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3AZ8PsZSTaBHXCxCrRX2eM4z237NcEQuf3OD2MDuS3VO//02j2ns8S3wP0lbEic9bGqUkUQ==
X-Received: by 2002:a17:90b:3f84:b0:340:7b2e:64cc with SMTP id 98e67ed59e1d1-34082fd8a43mr3260712a91.15.1761889872226;
        Thu, 30 Oct 2025 22:51:12 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34050992f92sm4646049a91.6.2025.10.30.22.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 22:51:11 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Date: Fri, 31 Oct 2025 11:21:01 +0530
Subject: [PATCH v2 1/2] soc: qcom: smem: drop the WARN_ON() on SMEM item
 validation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251031-image-crm-part2-v2-1-c224c45c381a@oss.qualcomm.com>
References: <20251031-image-crm-part2-v2-0-c224c45c381a@oss.qualcomm.com>
In-Reply-To: <20251031-image-crm-part2-v2-0-c224c45c381a@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        chris.lew@oss.qualcomm.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761889866; l=1196;
 i=kathiravan.thirumoorthy@oss.qualcomm.com; s=20230906;
 h=from:subject:message-id; bh=/DzIKQ7XWn6XEbzai7GAbGUo88mw4Mg+1am0ONKm6R8=;
 b=EmmL9RtBsT19xYNzFlFV3D9fH7m+/q8Ar9OgehVu4RKNmgYGXsB5YCVDb/IY1jwpcIoaUYb8e
 aA5eHfjpo+6DSoH7NHtk/NdIRbjps2usQXAPRthYSPW3cok0go9fJLC
X-Developer-Key: i=kathiravan.thirumoorthy@oss.qualcomm.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Proofpoint-ORIG-GUID: Rut6ZDWs0tkHENKiMyaLT96GQA5tASfp
X-Authority-Analysis: v=2.4 cv=RbCdyltv c=1 sm=1 tr=0 ts=69044e51 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=eyY2OFHguXDrM2cP1SAA:9
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: Rut6ZDWs0tkHENKiMyaLT96GQA5tASfp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDA1MSBTYWx0ZWRfX7h2GjNwfINiM
 xnCosarahTnN5S237/np0qPyo9x+Re2BnQAzfq5fbvy/wla8nfw7dvxnc/pBbqvpO4/cIGB5by5
 W5rDEAbU/99xirYyMA03YyZWvwaS0vp6wD8LqS8IkviRmGDaCo4t68TEriURsNGME/jnmdERxgD
 CQJ+5RjVLEeFcsm0m5vhGDRwHJlR2ADOKOVhX64OE5veFFPz3VMmKv1MJ5DQmBOZkBkg4n8qZqC
 A/AwpDKrZk+hZYFTGFsGIZA10tbNYJhwk0K63rWc9RD3uFrrNUxFX0ysv4OkLi7+vEXhZI8xOdJ
 mrch5kPcCLt1pEwKiEaKxZkWPjm+3lfpgJp38pdReHZdI0MrYCs7a+Ul1y3YwXszJkL1Q4DYYyr
 Kk2fnyQQyAu+sGOIDHH0Zk8pNINg3A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_01,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310051

When a SMEM item is allocated or retrieved, sanity check on the SMEM item
is performed and backtrace is printed if it is invalid. But there is no
benefit in dumping that information in the logs. Lets drop it.

Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
 drivers/soc/qcom/smem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index c4c45f15dca4fb14f97df4ad494c1189e4f098bd..2c8f2494118378718bd40949aeff7af20465d2f9 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -517,7 +517,7 @@ int qcom_smem_alloc(unsigned host, unsigned item, size_t size)
 		return -EINVAL;
 	}
 
-	if (WARN_ON(item >= __smem->item_count))
+	if (item >= __smem->item_count)
 		return -EINVAL;
 
 	ret = hwspin_lock_timeout_irqsave(__smem->hwlock,
@@ -690,7 +690,7 @@ void *qcom_smem_get(unsigned host, unsigned item, size_t *size)
 	if (!__smem)
 		return ptr;
 
-	if (WARN_ON(item >= __smem->item_count))
+	if (item >= __smem->item_count)
 		return ERR_PTR(-EINVAL);
 
 	if (host < SMEM_HOST_COUNT && __smem->partitions[host].virt_base) {

-- 
2.34.1


