Return-Path: <linux-kernel+bounces-831454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45852B9CB59
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6186179A1B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F00D2BE658;
	Wed, 24 Sep 2025 23:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N6F5zZiS"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DCA2750E6
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758757608; cv=none; b=rlVw0XiQ5NMVqFkNqokrbavosCzuiOBWXv75eG1mfhYiCX9znOf8MV3VNQhw0y5Xar9nADFYRKAt7ZwY4pVoey3YaUb87udlqK1uyUfGpi3Yqs5A2YSzDlY99aL0/ean8vunZeH3IItR/TmpxBivz+T+6LjgW3/IFQE+aAjXWDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758757608; c=relaxed/simple;
	bh=lMi6BW9EoNcBf/bnUbCRXu9uKYzn+3W1WkDNAjJlCn4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XhJQDp3aS8rAmVtixkMQg/Jke41FdapSfablkwajmI8FZIPTcTNODxvs4iBjFFadrx94TZd9eexMpkpXcV8O6II7FmblQ7gmYwbXKytgMaLEfvb7EX7sJLA2O7ubU1At8rfS5mPAOpxv+N6OYhWNvWhUiwICWIbVqH3Rvhsed94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N6F5zZiS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCtHSk019915
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:46:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	d+QcUnwPoU8KIc/SQDuBGNhNOG1Bw7UbC8jOgEUWCMo=; b=N6F5zZiSIkqJzRWt
	A/LaRsykqpstVZ3XsPrMX08CDVxWYvkcjnguA0vWFJrDRkyQE48m13UT13mz72o2
	HYCH9bt+SZDcPGiInpjRNY8M3JqmNqhJo+zi+FsmTpvG2GAxGvt95YidwrBRBJ+A
	o+fgVxmIYwinETNk9aeNG0CU4xpBsjfnz+PBrSctMzcNJE2s+LubSZNigpQ5nA+5
	cBQWakdfRK6IeC5SyCWj1IY7s0uTF9cEOINHqGaoFUJJB5xWYYcquojlfWtoPe+P
	IYC3vrF0QNjnnQpRQf+RkYIMbuZdfWAND8cy85aDO+7Rc1zZBIwOrcmU/XMZ0hHI
	Fnq91A==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bjpdy9y9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:46:46 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2697410e7f9so7502935ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:46:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758757605; x=1759362405;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d+QcUnwPoU8KIc/SQDuBGNhNOG1Bw7UbC8jOgEUWCMo=;
        b=uGWk4fNrcWZjYcqyDqLgAlR7WXl4r/SCE3L2hTthui62zVx0vNa8IyiAjD3pM4mXLz
         VJdrilSyt2/EjbsRmmP+alnVdI3Pdql26MnUdBmWhEi0aJZahPZaZag4zJUGrz2Q8qxE
         j8uKMLxBT7RU0wu1rWk8mZ0obPJxBYGMjShG0Tvp+bAMoYS2Hxdph/H1KrJQ4BxxakzP
         P9o9h1gUb6NrEPA+6OnEDGq6MZKwoAj/3K1nTc6cWktBLcof4f2lBUuYhfOqPebRC65C
         cWx6cooWnwE8IibEnqgPqqGhew5X+HeQ7ZKvBu5JkT2AZBMDQfmwuBsdX+HfmwCDuw+a
         HspQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhw/x4NO70DIiZHorTeirGtNeiTdTsE5+0eCfGJaM6ErFNJIqLDwNj5BnHvjqXtlj+N4Bppm7tt+zK7Dc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVnCwemKxoOydbtzr0c+eQpIMyQmtRcAHqDyPZ0N449qGpr7p/
	yKXhVfsAB4Cc6BjyGCOJ6q5NJh5bvMIFJThEXGhp6fjZGx07JJeyeTdFpOuf2qRugzqm88GNvW+
	WQOFRNwFlsTaH2U175w9KyKVtSSjycJCQOXaS6dist0JrB4t3tmSIb1X1iRuPJ+A4nSc=
X-Gm-Gg: ASbGnctOUugawgsfAh1nz2+670keqsZJI66zwgafZcjIL+1QXlu2Rz0toXJy5V4+KuH
	X8ndp3OsU8vvIJpimT6hNyvgF9nzngRUvfzmkefI4P51aYApRELG2sv8c7+q05TPE9t9gRh1m9a
	ErgCh3rMNklg4dqFoqslJHmI4gbt9X2h3MYF+u5S055IPcPAl8jWC9qJ9oODPXegpnDcEfo3exN
	Sps6iO2hbbLLzx08HeA5Izj5Ew2biJsU6JwoW0sIcPXEvnu8DTrP3I5rpn87sEXN7netLrs8/b9
	6BRlbCsFUfpAmiFtR2gtCLooF66NhfeIU0AXcgtifrnQWD+6sMXpF9zwv+m6IN5DF90sEQSY1F7
	dDaDE4vsS6F/ze6s=
X-Received: by 2002:a17:903:2b0c:b0:275:6baa:d9 with SMTP id d9443c01a7336-27ed4a56b08mr14021445ad.40.1758757605303;
        Wed, 24 Sep 2025 16:46:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsZkCilV3B1P9UXHL4Cpdv9AoCXLxr71gZLjA1+Y/7WWXoQtNBIflcG5OnRE5Cpm3vDOfvAg==
X-Received: by 2002:a17:903:2b0c:b0:275:6baa:d9 with SMTP id d9443c01a7336-27ed4a56b08mr14021195ad.40.1758757604846;
        Wed, 24 Sep 2025 16:46:44 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed69959e1sm4318405ad.103.2025.09.24.16.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:46:44 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 16:46:37 -0700
Subject: [PATCH 2/2] misc: fastrpc: Update dma_mask for CDSP support on
 Kaanapali SoC
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-fastrpc-v1-2-4b40f8bfce1d@oss.qualcomm.com>
References: <20250924-knp-fastrpc-v1-0-4b40f8bfce1d@oss.qualcomm.com>
In-Reply-To: <20250924-knp-fastrpc-v1-0-4b40f8bfce1d@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
        Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Kumari Pallavi <kumari.pallavi@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758757601; l=3165;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=eD8yAx/YuKqA7+Hjy0aKSPReaieqfN7YL0zc+4CHM6c=;
 b=/zkxGlXtFzMJUQCd4c/1ySUM3PnK4HaXPCbz5JL74xjuvqJyZ9b1hM66HPlL8U0UGPZM0ezj7
 sofz7Cx6pHwBOjEujFDJaS7Pr1KskcN0mvAxmFk9s//g0LjiHrtrW5W
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-ORIG-GUID: CKexTKytXQj9Xlq-BrylY6JdKwCgcLMh
X-Authority-Analysis: v=2.4 cv=Pc//hjhd c=1 sm=1 tr=0 ts=68d482e6 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=v5czcFVHhVNKnq2DKJgA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: CKexTKytXQj9Xlq-BrylY6JdKwCgcLMh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAyMCBTYWx0ZWRfX453q2ILBmwyS
 3f6H1eJV8fS4O9pFxltjlAz2RFxx2FXc9WMGo6G+o9WQFVr9kWTkr1dx2YLUsGiNtaub2V2dxtL
 Ukk6oSZ36gYXc0/d9+A+iNQAB43rrK0wItcTOB/v+r7/LZU18yFYTRAsHLsZ2ES2pYFqp74Tqih
 7V0aq7209rIqxnoED3AuGV5eR7Rt+kGg7kzB0mwY/UUxrJmGFW/MuEs+d65UEkuv3n7gXt3JfWK
 RKeTi3OwJdkn1HXJZ2rt5OEPqs93C1zaXSe6nrdMkUAOwk0b3e60Op4dUHkC+4vbkp241yJPw1m
 pmcLHJ73cy9Pc2QWiHIpQeTi2yOqxU8E4i5nlOAd3JE7FeNVe5aIHcykYcMV/yHpwnxk09SAie+
 qajusx7J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230020

From: Kumari Pallavi <kumari.pallavi@oss.qualcomm.com>

DSP currently supports 32-bit IOVA (32-bit PA + 4-bit SID) for
both Q6 and user DMA (uDMA) access. This is being upgraded to
34-bit PA + 4-bit SID due to a hardware revision in CDSP for
Kaanapali SoC, which expands the DMA addressable range.
Update DMA mask configuration in the driver to support CDSP on
Kaanapali SoC. Set the default `dma_mask` to 32-bit and update
it to 34-bit based on CDSP and SoC-specific compatible string.

Signed-off-by: Kumari Pallavi <kumari.pallavi@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 drivers/misc/fastrpc.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
index db396241b8ce..e019163eb265 100644
--- a/drivers/misc/fastrpc.c
+++ b/drivers/misc/fastrpc.c
@@ -275,6 +275,7 @@ struct fastrpc_session_ctx {
 	bool used;
 	bool valid;
 	u32 sid_pos;
+	u32 pa_bits;
 };
 
 struct fastrpc_channel_ctx {
@@ -2179,9 +2180,9 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
 	sess->used = false;
 	sess->valid = true;
 	sess->dev = dev;
+	sess->pa_bits = cctx->dma_mask;
 	/* Configure where sid will be prepended to pa */
-	sess->sid_pos =
-		(cctx->iova_format ? SID_POS_IN_IOVA : DSP_DEFAULT_BUS_WIDTH);
+	sess->sid_pos = (cctx->iova_format ? SID_POS_IN_IOVA : sess->pa_bits);
 
 	if (of_property_read_u32(dev->of_node, "reg", &sess->sid))
 		dev_info(dev, "FastRPC Session ID not specified in DT\n");
@@ -2198,9 +2199,9 @@ static int fastrpc_cb_probe(struct platform_device *pdev)
 		}
 	}
 	spin_unlock_irqrestore(&cctx->lock, flags);
-	rc = dma_set_mask(dev, DMA_BIT_MASK(32));
+	rc = dma_set_mask(dev, DMA_BIT_MASK(sess->pa_bits));
 	if (rc) {
-		dev_err(dev, "32-bit DMA enable failed\n");
+		dev_err(dev, "%u-bit DMA enable failed\n", sess->pa_bits);
 		return rc;
 	}
 
@@ -2287,10 +2288,12 @@ static int fastrpc_get_domain_id(const char *domain)
 
 struct fastrpc_soc_data {
 	u32 dsp_iova_format;
+	u32 cdsp_dma_mask;
 };
 
 static const struct fastrpc_soc_data kaanapali_soc_data = {
 	.dsp_iova_format = 1,
+	.cdsp_dma_mask = 34,
 };
 
 static const struct of_device_id qcom_soc_match_table[] = {
@@ -2310,6 +2313,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	const struct of_device_id *match;
 	const struct fastrpc_soc_data *soc_data = NULL;
 	u32 iova_format = 0;
+	u32 ubs = DSP_DEFAULT_BUS_WIDTH;
 
 	root = of_find_node_by_path("/");
 	if (!root)
@@ -2322,6 +2326,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	} else {
 		soc_data = match->data;
 		iova_format = soc_data->dsp_iova_format;
+		ubs = soc_data->cdsp_dma_mask;
 	}
 
 	err = of_property_read_string(rdev->of_node, "label", &domain);
@@ -2404,6 +2409,7 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
 	}
 	/* determine where sid needs to be prepended to pa based on iova_format */
 	data->iova_format = iova_format;
+	data->dma_mask = (domain_id == CDSP_DOMAIN_ID ? ubs : DSP_DEFAULT_BUS_WIDTH);
 	kref_init(&data->refcount);
 
 	dev_set_drvdata(&rpdev->dev, data);

-- 
2.25.1


