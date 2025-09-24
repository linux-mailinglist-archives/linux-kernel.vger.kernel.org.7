Return-Path: <linux-kernel+bounces-831093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A718B9B86A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 20:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7B2619C8384
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 18:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A8131C59F;
	Wed, 24 Sep 2025 18:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OePsLT0r"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668E8319865
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 18:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758739096; cv=none; b=hr80AG+NJMO9ws4FIvCbaOzdee0DJx6LvHWRmdCUrQg1bwPlr7lmWfX03ScdWcotNQFbCJMcfeeNyiol3O4H7taBSwP+x+Auvr8WlmA4Gqz0RCzSk5GnrcNFZyJakqJ7B8ZbZOra6xk9QkLEY9SOgCFuBtpTHUW0HzGCRCwwrRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758739096; c=relaxed/simple;
	bh=k9CkL2qkm+Gq+OsTV8Xqcli2o6B8i6gZkt12KJczsqM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MJLO/sM36tJYLAsTPYW88vVrjYU9kfqYaWclfvVj+WI5bbIrKE9X4wlpeaz/CNOmYqir9i3XTHA/OFZRg11aV0CJA1wWYIhqd33hktvmWmmVufNJCAvUG/hcdAe+XQSELQNJ9qM5bYtAd5FqFlIc3FXTHePtErJNlzAmRKtY1HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OePsLT0r; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OD8HnR019945
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 18:38:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=D/76oTdLGn3
	8H8eHzIbnSh0dnKY4nS7/Ubm15EkVBLs=; b=OePsLT0rP3C5KSJ48BTLLYYzDye
	YOsJgJSKMJ+dViCi5lNreoTP+N96DhyjMRRsB/JspqyNN8SbyVZD3LkLLez11wCM
	X4JYWtR2ThFJb2cOBJUwkJMEXX3WAAumrFT85wX8cUQWuONJBhHKkSZyzARK4JO3
	lPhS73x5vSHASWNllmI/fpICOQCCDW+LTVWZxQeZ/lVCOaMsolF9KY8LAvLw5qVd
	ubqNKabtAraU7CXLQecw4zdwhEbdNRWVI1UH5PfFJVQdqzWuRP80okibmoaia60q
	l5/zUZjXe2DBTcEgdoYT7qwEPhRtlvD/MUpwW7UXPhh2wMqXDn91Qc9rPOA==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bjpdxmnj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 18:38:13 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-77e7808cf4bso101256b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 11:38:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758739092; x=1759343892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D/76oTdLGn38H8eHzIbnSh0dnKY4nS7/Ubm15EkVBLs=;
        b=jHIoevMPWYNt2qsKYRogBKYVV9TRKOLjGbEhwlFSpJgk+nLOO/74u0YtwTjFpXU4Mi
         4OAOdznk0xWlOgOEuXERLPsIgXfsSuyGyHw2tvUqf1WQuN6uiNzBmh1Al9sEGVyw/enM
         lv5uBhe3tXLyAWFhs+cuDzbkGgfGE1GRIxmP0vjU4+KW4/ttJu7QHiowwcNRRsvyKUBn
         bCffOHfuL+L7yGNXwr0sFgRgfGZKC4S+30VfRQxNGXxouQrzXrxvmHpQi/2oGXILUgWf
         jvhPciHrS9TpnWIHa1FEZX6DTtzt/i8R76iEYAEw5YBztPGZ48RiZV+321QiWyCt4x26
         UqDA==
X-Gm-Message-State: AOJu0Ywgo9K3r0SCivjXKMi5OY+naaP0vlPrF4ZI0/C/kXKy6NWvju25
	B5y+S2iFmY8gkvk4SLM1SiQj0llK/4G0Hw/XeJQ9ra1WuKiC9+lJBDc2uNT32XPntLr9S+Dmtcq
	dNFdBE1j07Hss/dP969vCxAP2CySIHM6y4vzOMfMzoMNeZO7aZM9M06BJbHjW8hWpBK8=
X-Gm-Gg: ASbGncuXQLbohWH01Pw11+dUPTIaDEkyLbD44ucNoQ9ZnPG7v1J/Q5KGkY7WsBCly1n
	J5iOb4DjU8wv+MynxFYVj8RAAttjNdM2M5VhiraT7Eu+4E83mT/uue6HzivOZXn4DTmjp1Bnk/e
	U6qZh5HT/ahurJdNMS82AqjzwLIj+8mcclCVcCfWK0OP4/EPyUN2e8DPGw7bbNkRG5rYaVkU2pF
	wbT0YKpEsxfp26+1YIWBTtpmr08jji+OgNKED9t8TpD+AzUOoD43vpqEsA2rOhTW7hxYv45MQeQ
	I98AHRDGWVRHpvnfYDhL2ikQVOsrJIe8TOm+STFIuFESE4y9gTQkq7g+GgUc/fGSqplKluJzFPL
	Cg0zmyi6ti2YaaYbdHf9kc/izotLkUs6JPg+mTS1bxHltC0Q6dv3Ia2w=
X-Received: by 2002:a05:6a20:2587:b0:2e5:c9ee:96ed with SMTP id adf61e73a8af0-2e7d0ad23efmr792537637.43.1758739092162;
        Wed, 24 Sep 2025 11:38:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWHNu98C5qMUkkEF8Wz0kUHwZ/TobJChUZfOqfDNQhuDyK9wb0zE0W+cDeaQIS/hn4PG2+wg==
X-Received: by 2002:a05:6a20:2587:b0:2e5:c9ee:96ed with SMTP id adf61e73a8af0-2e7d0ad23efmr792496637.43.1758739091597;
        Wed, 24 Sep 2025 11:38:11 -0700 (PDT)
Received: from hu-sibis-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b555adca754sm6523412a12.16.2025.09.24.11.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 11:38:11 -0700 (PDT)
From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
To: jassisinghbrar@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, mani@kernel.org, andersson@kernel.org,
        mathieu.poirier@linaro.org, konradybcio@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: [PATCH 5/5] dt-bindings: remoteproc: qcom,sm8550-pas: Document Glymur CDSP
Date: Thu, 25 Sep 2025 00:07:26 +0530
Message-Id: <20250924183726.509202-6-sibi.sankar@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250924183726.509202-1-sibi.sankar@oss.qualcomm.com>
References: <20250924183726.509202-1-sibi.sankar@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 8H-j6jD0XjW0ED7UwUmISrbA5GBxdwBo
X-Authority-Analysis: v=2.4 cv=Pc//hjhd c=1 sm=1 tr=0 ts=68d43a95 cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=_X9-DzOTpKYA3bgxq-AA:9
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-GUID: 8H-j6jD0XjW0ED7UwUmISrbA5GBxdwBo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAyMCBTYWx0ZWRfX2TpX1vb2zUXC
 ov7CukiIQwS1Xnct6ARxwVjRgMz2eOR9FGM5LZDJbSU2mIeYR3EWhP2pnYzWj2oFOSwBw4QbLxa
 kpy7rRDEmmgtJf5qcstxOSTUV013oUkqAQrn7S7kT7lo0kIwaoLkE8cAOeSZCG8cggRmvSR9Qhx
 Rtcu94X1YS/OEmiRCw2lThx8s8fsrDExoYNRRn1fuR5qSjpCuoM1bmA1/1ri67y/OJecVKev8d4
 qZj1xNrXCxZK/+J3BxHkgFbXH2NeRomnY/Qq2YlTlXxEiIwoMR7fKz0vYERvUNiuh/R4yOsOmT9
 6mnR5929IHoqgs58RkxZKhh0EXg37yUQtOkLrpSmIMHEHp79bFGo6mre+B85q8JC9bjtBU7Ab0H
 h+44bKuw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_04,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 suspectscore=0 clxscore=1015 adultscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509230020

Document compatible for Qualcomm Glymur SoC CDSP which is fully compatible
with SM8550 CDSP. Also with the Linux Host running on EL2, the remoteprocs
need to be hypervisor independent, the iommu property is mandatory to
ensure proper functionality.

Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
---

Dependencies:
Peripheral Image Loader support for Qualcomm SoCs running Linux host at EL2:
https://patchwork.kernel.org/project/linux-arm-msm/cover/20250921-kvm_rproc_pas-v3-0-458f09647920@oss.qualcomm.com/
This patch has a dependency on the iommu binding added in ^^ series.

 .../devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml     | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
index cba45ce2865e..8a15e0c47a78 100644
--- a/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
@@ -35,6 +35,9 @@ properties:
       - items:
           - const: qcom,sm8750-cdsp-pas
           - const: qcom,sm8650-cdsp-pas
+      - items:
+          - const: qcom,glymur-cdsp-pas
+          - const: qcom,sm8550-cdsp-pas
 
   reg:
     maxItems: 1
@@ -98,6 +101,7 @@ allOf:
           contains:
             enum:
               - qcom,glymur-adsp-pas
+              - qcom,glymur-cdsp-pas
               - qcom,sm8750-adsp-pas
     then:
       properties:
@@ -227,6 +231,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,glymur-cdsp-pas
               - qcom,sm8550-cdsp-pas
               - qcom,sm8650-cdsp-pas
               - qcom,x1e80100-cdsp-pas
@@ -247,6 +252,7 @@ allOf:
         compatible:
           enum:
             - qcom,glymur-adsp-pas
+            - qcom,glymur-cdsp-pas
     then:
       properties:
         iommus:
-- 
2.34.1


