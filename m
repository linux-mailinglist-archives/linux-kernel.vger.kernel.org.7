Return-Path: <linux-kernel+bounces-760224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E69A5B1E81A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 14:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3F225A0782
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 12:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10460277815;
	Fri,  8 Aug 2025 12:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="b/e3xPUX"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756AA27781D
	for <linux-kernel@vger.kernel.org>; Fri,  8 Aug 2025 12:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754655162; cv=none; b=LLnmoc+S4TRI830DVWnEq5bfTfHtCR4LGPX12uThzdu7EzQY+wekmxyCfYCyL0NOKeScne1BvxLoTcBIvEf9Mh0JiYBIJjg0JkdEXg4bjAUii/jXHfNM5FvcT0112vggq+RA8aqzislHUWMLKM6kXk6Aq2/of4Z2FiqlgGooFEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754655162; c=relaxed/simple;
	bh=eCWEE3pAEaW1qh1/VHnkc5Er+UBRk3KCDBeNAGck4yU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=IFR32Ap3q/hQHJy7HZ2mju7b8RHSO3rMsZp3MtknTiEx+Z0KkzS51x8ip40BnulBpTPnEURbCGvdXiUk6Q3DdnBF5mZvCbw77P+o0CKYY36aO0YPJ74bR4ofikSEwJooiaIBiRLBpKK0MQYzvGGvUZ2/zFu9tC74WHlEf4OuAMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=b/e3xPUX; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5788ImgD007705
	for <linux-kernel@vger.kernel.org>; Fri, 8 Aug 2025 12:12:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=S5yNMiVryFwGG2xAA8XVh2
	ZWIiCVa+aa/y2M/HZeZ14=; b=b/e3xPUXUOnAbhnufsKKYJ1E7vSZty4jmz1Npl
	yvqbL10R/O8GcZ1vmx10uhaUtjh0Ef2u7C9c0sLszSfcxrE6B4ry+37+wzD++xUn
	1+iE3QrUEJ1sxKPsUdNMGtMaD+3wfuxfFJ2uzp6t383XXQ8duKfHLdRfENdwqGHB
	M4czaAP8+nKbp46G9tfuAlLdZyCh6o+ZegDVIHkP12TGz+SzQKjlT9h5vQH5unL5
	NdGDod3EzJ7S1kQA63qHoK7XEX5X9gPSdQT23Zt/PWJlP5ntTI5/Tq+QwFij+KIW
	QtA1CbWmCSX6ZQM3eiVyR+lmor4RiZ2M8QuhR+6NNTPk9CrQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48ddkkrpct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 12:12:39 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2400b28296fso33253895ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Aug 2025 05:12:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754655158; x=1755259958;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S5yNMiVryFwGG2xAA8XVh2ZWIiCVa+aa/y2M/HZeZ14=;
        b=EAcjb+b78aVDymLhtUBQDo88oO0qpnS4uUQjQfCFfLEwXvfrkq2Z4pQklBHVsmfznF
         w6K81GYXiGYBY4qNe8x5vBL0L1xKFXxgyXy2SwQdC6oUSQSwfvG+wVPxyVuk9WAygMnO
         HO551Qkq2+JpSJ4ju6EdOswZ6WCVD+qAUedRj/miOr2ukyrTHH1SX3TwJ5F/OKEFvrxt
         CvSWnlxxE2G0yyY+WfAo8RqJMHftYxcCYBtm3GjJ/vjb849hU2eU8ySYNYM3ZGvk+PYb
         28w8jnUxkAVt4DLqMDkfUgy/ph169wsU4V0Wt6lh1Ukrp1zkivwnSnXSZ1byXNLe9EV/
         hGow==
X-Forwarded-Encrypted: i=1; AJvYcCXsX+7tokEZoxHxo03tqWUjjhesxrvnXBGtKoHOhkRflAW4BKOsoSc7nkSjeTCkI/REMx7TDVe6R69SVx8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5Sm+y5lvy73YWsEr04wFn0IfGh71UHUOL7TWCfM4qakpThnUD
	tTNtTybCLMUxCm57HIc264zgq4PLfTIO3Lv1GL3h/Uhoj44gBa4XMIVT7Er9G/7YFUjaC1aTm2t
	yKa1s/c6ZNk8Y8WsddaeunDca0XJ3ox5XcsfnENRm3GVwAQh7i699a5D6hXmJQq1PeIXLPUDaM/
	Bu09pj
X-Gm-Gg: ASbGncudxgQtyiz5T/936qBZnpfF36C91pSW/K97tvtagqxMtPiZh7xv72Ty0aAB72g
	ziiO2z1FpwCGxRqzSJCh0jb3bPdsqmgX/N3uS7CRQgclInSvOCIIxlDL04GdAckvFj3JDXZD66O
	9bfDxmlhqiLiQsvCwiMV2V57xpUHmMB5uNhtBIcmVndNXyzeFVVNpuTf88dxLyqKQ1OYPZQpNJM
	BqDQnx7aOuCBs+LZjH69Vz3xhA6kIw5RNRQBsvztvV7a45qRXdTewYnz5RTQGFxDJMdfTsBciTL
	TEhjZ36+ZgbqQlCJelRt3n/9wx3n
X-Received: by 2002:a17:902:f543:b0:240:6406:c471 with SMTP id d9443c01a7336-242c1fdc70fmr36226945ad.10.1754655157654;
        Fri, 08 Aug 2025 05:12:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECpKQ/v5JKdeVcyVVibX/xqzvIzneVnVstvg/MXM27SuAFO3gMxlFTqtbF7/tvuRIckv++ww==
X-Received: by 2002:a17:902:f543:b0:240:6406:c471 with SMTP id d9443c01a7336-242c1fdc70fmr36226525ad.10.1754655157181;
        Fri, 08 Aug 2025 05:12:37 -0700 (PDT)
Received: from hu-pbrahma-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e899aaecsm209622995ad.119.2025.08.08.05.12.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 05:12:36 -0700 (PDT)
From: pratyush.brahma@oss.qualcomm.com
X-Google-Original-From: Pratyush
Date: Fri, 08 Aug 2025 17:42:22 +0530
Subject: [PATCH] mm/numa_memblks: Use pr_debug instead of
 printk(KERN_DEBUG)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-numa-dbg-v1-1-2ddd1ec634aa@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAKXplWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDCwML3bzS3ETdlKR0XTOjRIskIwNLo2RTMyWg8oKi1LTMCrBR0bG1tQC
 djrgsWgAAAA==
X-Change-ID: 20250808-numa-dbg-62a8b2092c56
To: Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1754655154; l=997;
 i=pratyush.brahma@oss.qualcomm.com; s=20250808; h=from:subject:message-id;
 bh=5Qo1LK7YyFgDdROrB8rkJMFFqZAABRTthFwmSEfDAhw=;
 b=64IXFmUg2VveMuqLjbn9i7qwNPt1EejsJDYTe3JlpxUWb5ZbSTuVFgcpoyH4bo1CprNNdbXO6
 tXmVM5kgSUoB79yXLpnYbnw0kcRJ4w7+HeyFc+dzbMOskoQrLATN4xG
X-Developer-Key: i=pratyush.brahma@oss.qualcomm.com; a=ed25519;
 pk=ZeXF1N8hxU6j3G/ajMI+du/TVXMZQaXDwnJyznB69ms=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA4MDA2NiBTYWx0ZWRfX/ReEu0y88DDH
 CXA1yOgdwtNYeeBt/PbxzSG1c9a7N7a46jtY6+mKxr26yhrTt1mNnEdBgtnRh1jjJAqbW25v+BP
 qGBo2t8SdJR136SDAIGb8GSsd9YMCD8TiNqXAPNIGTkGrK8OIGD+Dl09ciUTTYlUNUt9v9X1JGl
 qjCnN6yKiu9GoKc9vXTD16DVnPgLKwwOPsINpOK5u0DrnI4X9G+y99LCd2F1z5iTfd4RnoYOelU
 y52ipAxTa4HQl60tpF6EynN3QF7TSaB/1vK4hUvOUDfQ8UXSt0bxy+EfEALGO/Jlu5AhqLlb2nx
 AXaxCfILxYi1L21xRIOCR2VJ+zshp1SpcKnFM7rGDLjwhwqAKaw2tXGuwtCpDF7qZ3hCG1srqv3
 a5rxmWKe
X-Proofpoint-GUID: EM47vJDiEVn-t0FIUD_MUILbFLFAZaSm
X-Proofpoint-ORIG-GUID: EM47vJDiEVn-t0FIUD_MUILbFLFAZaSm
X-Authority-Analysis: v=2.4 cv=Xpv6OUF9 c=1 sm=1 tr=0 ts=6895e9b7 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=IjtafaaC1MEc7PSuPL8A:9
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-08_03,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1011 malwarescore=0 adultscore=0 phishscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508080066

From: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>

Replace the direct usage of printk(KERN_DEBUG ...) with pr_debug(...) to
align with the consistent `pr_*` API usage within the file.

Signed-off-by: Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>
---
 mm/numa_memblks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/numa_memblks.c b/mm/numa_memblks.c
index 541a99c4071a67e5b0ef66f4136dee268a880003..de626525a87c3ed54d31695e86f18c980c084558 100644
--- a/mm/numa_memblks.c
+++ b/mm/numa_memblks.c
@@ -76,7 +76,7 @@ static int __init numa_alloc_distance(void)
 		for (j = 0; j < cnt; j++)
 			numa_distance[i * cnt + j] = i == j ?
 				LOCAL_DISTANCE : REMOTE_DISTANCE;
-	printk(KERN_DEBUG "NUMA: Initialized distance table, cnt=%d\n", cnt);
+	pr_debug("NUMA: Initialized distance table, cnt=%d\n", cnt);
 
 	return 0;
 }

---
base-commit: 479058002c32b77acac43e883b92174e22c4be2d
change-id: 20250808-numa-dbg-62a8b2092c56

Best regards,
-- 
Pratyush Brahma <pratyush.brahma@oss.qualcomm.com>


