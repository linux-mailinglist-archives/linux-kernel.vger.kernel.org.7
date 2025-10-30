Return-Path: <linux-kernel+bounces-877915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B25FC1F559
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 10:38:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0F67A34D732
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 09:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B945D342C9A;
	Thu, 30 Oct 2025 09:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HfwAUlk2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YeE5J0xn"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5965D345CD1
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761817078; cv=none; b=jkT5Y3/qk+xkbo2vsAs245PK6ZpFYEjfIyqj8Qr5oLb1Sa9KKSJ5vvL3WelpA0L4pKVi//eX0KOzw6HFVvv166GaLssvOVFdvvFIe5ljlG8z2pMoJkVkmK4Fy7DCRMZnwiN7rXXjyPeYdU/rDmjL/2CAF+a04yWmu57RSmzhywI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761817078; c=relaxed/simple;
	bh=BQ2WhXe+j6teCDP3HhSv+L5nC0F5n6ZZa8MJy8deAeE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LsLuEIdEQiNdbbPiIP1f/MBtoqQdPSaTWOq0FRAm2R98FXE3Yl15FzLBp0RuSu7+NNgQXU5rF5bj8IpaAjZx4HPR5f2irlTS9ZmdhDKTP/9Fzym119XYbgfz6bUyo+k0dNxqJ5J8BDia7ZgnJ4ZYeuduRBdh+v4enu8JroxmpiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HfwAUlk2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YeE5J0xn; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59U72jb41501797
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:37:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6TnRVims1/vAmiGRL6+V59BfdhehRAw+GW9WJZPj4jY=; b=HfwAUlk2peoLugmB
	Y85pqTqr8o05S10jlOgFtOxONPQvfJKA9rfR4pfr60zEAKTYCbAno+Kg+UN+BFi0
	n8LhLX82RsD7wCrFs4CZx/P3F/d7QGGrFii1EcbbYjPA4eOZOD6SVhjSSZOPYJBh
	+rJ426jNv4wUQ7rEbMgefKAhxnPZOotsfTZnhQoFevQbc3M32bpA/s1bJhsiaIVK
	12Bay5UZVhmJmpiIT5CGxHPuapuZOdq2HYzWdevtmcCQ8tRP55Qmq6uaXySfK9Rk
	+fN3pt+ztQV10rWzD3ZjsMMa9nrCRj7Xao6XeojPQAQ08m8w+zy6Y2WA6rzjkAtz
	5Bxp7A==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3t1jsyn7-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:37:56 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-332560b7171so1450991a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 02:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761817076; x=1762421876; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6TnRVims1/vAmiGRL6+V59BfdhehRAw+GW9WJZPj4jY=;
        b=YeE5J0xnh74Xb/cac/9tMI9ejla2Y6ufV0tr0xzq7fLnMuvp2yqLNE0OlUDJUsB3SO
         7VdLHSttAUH8W3CA8QNPTSjcIp0w4tCY43V2jM1WPzLZxhVcVUgHE6ochERrCovsV8d0
         /S/QNscdy+Uiie9g1L3VscoZNaxfu1ZWD393QIk1tORimcDH43+xGsdeK35Fan2ldXf7
         eLFC2FXHgFQAWMlCi8bASkhKmjlOqtgorqIxx5+IGMpDrBUu4PYf63pg5Yn3i9aXUxwG
         7TY8h9mFmkGKuJzgMV00ej5Gkh2oRtXoDSa5IZKWlH0XVvEXgjyBD6AzzCKmVYKFaHfG
         bIFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761817076; x=1762421876;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6TnRVims1/vAmiGRL6+V59BfdhehRAw+GW9WJZPj4jY=;
        b=KW7bfHQQgHskJ/kKQ8F1EyxVEenUE3YL4GZVv8Sb+udY88TRAGYY/oU9u6JrWSHlcS
         H5ycb6CVbPA4Yu+KK4DitWMFKrJhy34rNgaxQPJcur56h0LVDElwiYhcGj3C2J9cyj3c
         wr6aysZEfzstPylsrwZ7+mvuhNPs0cQOWMv3rPe6kMODJA9Y2VH6plxwklZa+gH4FhIB
         i8n3ZEEyhQkV1QPm2Plqwff3lCVJ3hnF1NxXcdELnapqFmqejIy8tEdBA+Kactow8clP
         4V6I2UYHtMas70DsOKUaOc0bvZMPXrTll9XxYJ1lno2BaW29/XWAB1JkW1uGcP0xrL5u
         iqfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZw1pCaCUR+dzcJJqSI0TTRi46mGYMwJNz3vGWUhpxvxoww2wSmHf7EhyRTwVpWbekQ5uFHScb8YCh2zk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXk+es97kZYJHVcb7TGkmBBVqkZeJYslj/5BzPKS+kgO5hawax
	WuMy05SUWWI/0tNPrD9x8fA8WTDezKtf/ESZSKYgs13OAkIy4u51wM0iIiWmT21TmxIWnM0mC6B
	4PHk2441NRJv+F8OZ2BW75r1IjzP9+EcwuYGgzB9I7buVcS7v4czpcr6I086pKkY+hSyjiMuzLp
	U=
X-Gm-Gg: ASbGncuhAcuKWoRco8Z7ePSgQ4iL0+Gfem1MluWwe1kRVFEzsysEhRlnTZQo5SUUvPU
	jfsyeYDV2vHah9RbV/Rpxp1uSDFhgIRTDtep5KVOuy5RgB75O2BDlVaGmuTy9W+kmFvoVZSNesr
	a6oJWlBqufd7WaXtInfOwxTwTwuAq6knFCUwf/odZbfI5na7E0Rg+ZvPCy7zakOAo57PQr7+Czi
	rIOSW6razE9Sprjpm8ty5i2Y6CibuWySqixWbp+N8wS7WdDAqUWB3w+sPATUi9zuuJZ7Pv1jLty
	PwM6RuRjcRcPbpa6v18sDSqCPLpdeaoWT381P+yLsGCoUyXr0PZgphFPHJBL+0z6liPQYJODMGP
	8/wYhCZXx7lE1Q1JEkeVRTBfD1prLMTimRTE7afYcWD2JvDwI0mMvbbRGfVYbuhL+4JC30x09Y0
	addyBgYgdaryowN5UdcLkiQE4j7zo8iZvDyA==
X-Received: by 2002:a17:902:c410:b0:269:8eba:e9b2 with SMTP id d9443c01a7336-294ed2278aemr32639185ad.29.1761817075421;
        Thu, 30 Oct 2025 02:37:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEI1gFEHNMVoUNvrBPPiHxU+pOMjI909UMlCs7Jjx/MCaedSt3XPMQ5zaaEHu6BzUEb+hYhVw==
X-Received: by 2002:a17:902:c410:b0:269:8eba:e9b2 with SMTP id d9443c01a7336-294ed2278aemr32638865ad.29.1761817074875;
        Thu, 30 Oct 2025 02:37:54 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-294e3ae4ba2sm49350335ad.40.2025.10.30.02.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 02:37:54 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Date: Thu, 30 Oct 2025 15:07:48 +0530
Subject: [PATCH 1/2] soc: qcom: smem: introduce qcom_smem_validate_item API
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251030-image-crm-part2-v1-1-676305a652c6@oss.qualcomm.com>
References: <20251030-image-crm-part2-v1-0-676305a652c6@oss.qualcomm.com>
In-Reply-To: <20251030-image-crm-part2-v1-0-676305a652c6@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761817070; l=2714;
 i=kathiravan.thirumoorthy@oss.qualcomm.com; s=20230906;
 h=from:subject:message-id; bh=BQ2WhXe+j6teCDP3HhSv+L5nC0F5n6ZZa8MJy8deAeE=;
 b=x1S/UFhqD6RU4L97NO2XaFBZeuyX1idIi0OfIBvSwQwsO1j4Dss3YINwdcz3QaiftuM0npAb6
 IXUNnlgm/enCbvt7YyQx6SHgc2hy5etI5qr1E6U5imImLMi5wY5x9B9
X-Developer-Key: i=kathiravan.thirumoorthy@oss.qualcomm.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Proofpoint-GUID: l6dtCK3LH7vdunTmetjwrQ8y81pDpmxB
X-Proofpoint-ORIG-GUID: l6dtCK3LH7vdunTmetjwrQ8y81pDpmxB
X-Authority-Analysis: v=2.4 cv=M/lA6iws c=1 sm=1 tr=0 ts=690331f4 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=yjR5zAPs1mNjI6YpPD4A:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDA3OCBTYWx0ZWRfX2/OY8C2xLHWF
 p5B53AYgzf1TQvFRwZeYgDNt0R0dU0Q8/Qvsq7dzakIKMwXl6T51hjl/tU1PiYQD+YzRBDHONUq
 t5Vqy4y7T8N4OC6DJeXRnwe7JApa04Ur+sO6HpaL30FqGtxjQjOOfLK2RU+0vb8PEf9QtRHNKrJ
 FoUmWV4cVI0nkWaee05TintfCFTe7PZd5jNA1H5qiQttZIuVFC7VLJEdJ4gIlyBpk/jeWigZj2a
 B5rWYB+ACFSy/6IExKpjsP5mK3BgzKI39k3gzPFINnjHxLHoLG7zQsmgScSxz0s7gMaLaKU84Eg
 JRItZ0IK19ZnoKSRaZxdG5WhXrU9hF2pHsEyw7e/cqPgvVq7y6P03A3X2el7OGoygdt0kE6dLyd
 IJF1wK83iWe2LOjiOIthPnkbVT3X3Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_02,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 spamscore=0 clxscore=1015 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510300078

When a SMEM item is allocated or retrieved, sanity check on the SMEM item
is performed and backtrace is printed if the SMEM item is invalid.

Image version table in SMEM contains version details for the first 32
images. Beyond that, another SMEM item 667 is being used, which may not
be defined in all the platforms. So directly retrieving the SMEM item 667,
throws the warning as invalid item number.

To handle such cases, introduce a new API to validate the SMEM item before
processing it. While at it, make use of this API in the SMEM driver where
possible.

Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
 drivers/soc/qcom/smem.c       | 16 ++++++++++++++--
 include/linux/soc/qcom/smem.h |  1 +
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
index c4c45f15dca4fb14f97df4ad494c1189e4f098bd..8a0a832f1e9915b2177a0fe08298ffe8a779e516 100644
--- a/drivers/soc/qcom/smem.c
+++ b/drivers/soc/qcom/smem.c
@@ -396,6 +396,18 @@ bool qcom_smem_is_available(void)
 }
 EXPORT_SYMBOL_GPL(qcom_smem_is_available);
 
+/**
+ * qcom_smem_validate_item() - Check if SMEM item is within the limit
+ * @item:	SMEM item to validate
+ *
+ * Return: true if SMEM item is valid, false otherwise.
+ */
+bool qcom_smem_validate_item(unsigned item)
+{
+	return item < __smem->item_count;
+}
+EXPORT_SYMBOL_GPL(qcom_smem_validate_item);
+
 static int qcom_smem_alloc_private(struct qcom_smem *smem,
 				   struct smem_partition *part,
 				   unsigned item,
@@ -517,7 +529,7 @@ int qcom_smem_alloc(unsigned host, unsigned item, size_t size)
 		return -EINVAL;
 	}
 
-	if (WARN_ON(item >= __smem->item_count))
+	if (WARN_ON(!qcom_smem_validate_item(item)))
 		return -EINVAL;
 
 	ret = hwspin_lock_timeout_irqsave(__smem->hwlock,
@@ -690,7 +702,7 @@ void *qcom_smem_get(unsigned host, unsigned item, size_t *size)
 	if (!__smem)
 		return ptr;
 
-	if (WARN_ON(item >= __smem->item_count))
+	if (WARN_ON(!qcom_smem_validate_item(item)))
 		return ERR_PTR(-EINVAL);
 
 	if (host < SMEM_HOST_COUNT && __smem->partitions[host].virt_base) {
diff --git a/include/linux/soc/qcom/smem.h b/include/linux/soc/qcom/smem.h
index f946e3beca215548ac56dbf779138d05479712f5..05891532d530a25747afb8dc96ad4ba668598197 100644
--- a/include/linux/soc/qcom/smem.h
+++ b/include/linux/soc/qcom/smem.h
@@ -5,6 +5,7 @@
 #define QCOM_SMEM_HOST_ANY -1
 
 bool qcom_smem_is_available(void);
+bool qcom_smem_validate_item(unsigned item);
 int qcom_smem_alloc(unsigned host, unsigned item, size_t size);
 void *qcom_smem_get(unsigned host, unsigned item, size_t *size);
 

-- 
2.34.1


