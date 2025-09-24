Return-Path: <linux-kernel+bounces-831091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 905E1B9B84D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 20:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7E2844E242D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 18:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F2A43164AB;
	Wed, 24 Sep 2025 18:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LMAa7bno"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 664BA31AF1B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 18:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758739087; cv=none; b=e+ug65ZegBpk8UhkDbgmliI+2BCeZ+cTvHr8r830r4BQC0SirpmNEIGiHqtS4BIkZp4e9AHwnjUIZM3c/aYJy64iJvLBVw8L0bRdQOPBfgba5bnFbn+09M+QBw3zMov83AzVeNazAwaBtKzDhMah4SrmBc0ymA4cuotMuW4UNc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758739087; c=relaxed/simple;
	bh=mBFH8HBfqW22uJUINYJENu8VktqxDzTFaEQMWWeNb7E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JFMfGX4xKZ495FGBGOY/30fqA8Qe5VvN+kPNweDvvlgOmekiZJhWEFlEuJWmx5Ecmcry2KdMzPIS12pMya0/bqD4gFnzcdJf5HPYx8So0oJkA0PAdynjo80woCKJfy0Cd7r6jlif7Cvd4DWyMDHE/L1QRkck3r5gDHQiZrad/VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LMAa7bno; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OCqxxB025092
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 18:38:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=/NakND+TfYX
	aLShyyTMVoDpCY/wzwExv9wBqupV4OwQ=; b=LMAa7bnoQg1w/P1Pw18MSBMN9mc
	AJhL3AsN58DCGER4VlDoLObg0fXayRL1kLzcvWIcHolmEJs/edR2iYgjhK92Jjih
	CDVUlal4/RVxEjofTUSVP3PFuuMFmo+IQ6OdrxaHdyYbVf7eX3XgulT5vKPNKFN7
	vIGjU1s7Od6XlcJje0Zn53cZ5SLur7JaGKehdIXgjagToa9a14YBGrw3b6pGTzLN
	tPKJRVr7Z3bplh6yvt0fVfL9A5rP82xuVn30LZjuYy9CBKBR09SwwaHccyjsQOyF
	nIJ89AjrpTVpnYlebkVVxXCayQ8sU5N6nQW3dDx8OtchErxXB2L5IScXpiw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hyewrgf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 18:38:05 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b54d0ffd16eso67301a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 11:38:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758739085; x=1759343885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/NakND+TfYXaLShyyTMVoDpCY/wzwExv9wBqupV4OwQ=;
        b=GKZq6ELeQnTYP9SSBst39UJVYVUZG2CW0RCeIlF6g+udbW0plvf+YVfbyr+yTgJjrK
         fMGyMX4LR+kuLZZV76vKEUW9e/no+f4kO77HpVjwPHzXSHV5oZasnXFt7LY82RA9osGd
         3emCy3X6dT3eVCyxQysBbaZm2OzZWHbofi/taftiI/O43Jj6ef3aKbXhumq9ZOu8evzJ
         4epAg6ph1vz4J6igBaqp0xSGuYGIVRJHZ04FzAVTFVDpvoxlbPt2s4UOGfIUJibE+/p+
         yC7Mb7cMfOw3hJwSITIoxU5paTBsVIwjxugmS0plKgR9xzkSb12fOaRnoKY44qYwjG8g
         Slhw==
X-Gm-Message-State: AOJu0YwRuWjZdscwEQ6t7bhyfvp31S1P/oqi3Y9Yi+HnKmvEW4E6de7o
	aoxkugA5iuY5LVeh9HS+qYS17gUYqkAXEQ7/Z8LShYBf8XFApflXBthOzaX/g9VVDdHrq3wAkxa
	qPq6CslQxMDjfeeClfdncUkzZIlUf1Afl+iDGOzEwTnwSiajqDDjETNEybC+/Q6fCh9M=
X-Gm-Gg: ASbGncsdqQQ6EHW4xcf68qwG5FkX8RsHsn1KAkPOtjDusZuOKKbPoPhbaEKu1Lxc4rT
	NaTayRpK1qDLLbnptKLbeSyFDbD4ZDWr5hk8k5WuWzl602hUzMdZdlgpkoaSEcADljri36WgDiL
	C6amW47VrbC9U4aANyViQs8AvySdHzzX6ljDHUGNXGUKZa0+jXUVGUang8EmqR1IjanIUVLaWxC
	ABR4vE4//NlffLFRHRhRULpG/gn9yiu0inkgAcKrZgt0hwpaDdsF+bOCxiNs9FKshWa0xT1M4aQ
	5T3eXCCFlM+tm4QAmNyAzfGQbsdeFy7+Hq4bD6kMbGeSChBOgeTYeeg4CAuNH8sJHroD60+GiyW
	TCGwxk56tuqg9hpJjF+R5inrQXF6qgyihfEPR5E99AsG/9tVIQxZ+SCk=
X-Received: by 2002:a05:6a20:2447:b0:2d9:b2ee:785e with SMTP id adf61e73a8af0-2e7da45fdb7mr675813637.53.1758739084983;
        Wed, 24 Sep 2025 11:38:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFu6mDes8yvj7I+bjPl9snWfmZNJZ0/XQrsak+gbcpzmtWRDO1fd+YneD8ujyEQDYBhSr3haA==
X-Received: by 2002:a05:6a20:2447:b0:2d9:b2ee:785e with SMTP id adf61e73a8af0-2e7da45fdb7mr675786637.53.1758739084602;
        Wed, 24 Sep 2025 11:38:04 -0700 (PDT)
Received: from hu-sibis-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b555adca754sm6523412a12.16.2025.09.24.11.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 11:38:04 -0700 (PDT)
From: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
To: jassisinghbrar@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, mani@kernel.org, andersson@kernel.org,
        mathieu.poirier@linaro.org, konradybcio@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: [PATCH 3/5] dt-bindings: soc: qcom,aoss-qmp: Document the Glymur AOSS side channel
Date: Thu, 25 Sep 2025 00:07:24 +0530
Message-Id: <20250924183726.509202-4-sibi.sankar@oss.qualcomm.com>
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
X-Proofpoint-GUID: XneI5lGxl99h-x6NIQFxxyzI8B40fTkw
X-Authority-Analysis: v=2.4 cv=YMOfyQGx c=1 sm=1 tr=0 ts=68d43a8d cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=44w1v6iwfB5DCniY308A:9
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwNCBTYWx0ZWRfX36o/gHdBrUkd
 v0rBXWGDKonZ0rNFEbCXYIWHtla3dSNyn2qiLZQivP63p+RXSBjhZptC5eRecvO/0CUJidIWzQ6
 58MhId4XTidUat01MIsV49jug8FqgglHK03jlJenP8H6I7Zo72J+wT2Lgt35cl0Sc1Whb0wqryN
 bPGk+EHUQdLqV1hYYR2Lq/llt0R1dfIjze82pRCc+8hMpXVrPH4NarcYUVyhkrQnrq9IzFt1tHO
 WIlqNdkPvfydoyYssGQIjklR8OubnTSYYkslLiQB3FUet4XeM/U28REjh81+dciY9r8/wTKKC3p
 bZZGe4TfJ9ZOEmPMC0wldx9k3AzTIwarkPPa8ynDFlnRah8DnzA4ggRUNpTSZsD2Buh0DVuVp+b
 tyjjCANz
X-Proofpoint-ORIG-GUID: XneI5lGxl99h-x6NIQFxxyzI8B40fTkw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_04,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200004

Document the Always-on Subsystem side channel on the Glymur SoC.

Signed-off-by: Sibi Sankar <sibi.sankar@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml
index 851a1260f8dc..bee107bf7e81 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml
@@ -25,6 +25,7 @@ properties:
   compatible:
     items:
       - enum:
+          - qcom,glymur-aoss-qmp
           - qcom,milos-aoss-qmp
           - qcom,qcs615-aoss-qmp
           - qcom,qcs8300-aoss-qmp
-- 
2.34.1


