Return-Path: <linux-kernel+bounces-750674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07EE8B15F93
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 13:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2080316C99F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 11:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39B0285CB0;
	Wed, 30 Jul 2025 11:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hfhYQeLA"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B2F253F2C
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 11:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753875256; cv=none; b=ihBSe4yRBbWAoZheRSORHZ1mfhCm7chFMcaT8dkwotbFvuNZc8iaSCUrfxQy6EK+GMGh4uO0Yh9rAbcJnLnPtqsIG88ohvB6BJ1BaCXydH5Sx1qacfQ5BZToTYkLZz7TyonFKHCOSJ3ixTzLYEHebJf5I3Cwz1MWneXAwGKcvHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753875256; c=relaxed/simple;
	bh=cS3jzH5qD+TtuznAs0NDToiNIM9fmacWZBMDom9qNmg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HgpHCxBx4aE5qDwRh6uGRXjN4k3PURO5S7dNu0428lzYDeqBRN6/8K+JR68YBiAlQW/mDFXr8SGEAbeUW2IpGdHrkKMkrOJixtP7YaGluVQ+6N5Leqy+r8DDX6t05E/RlPExaHvqH+BBRonBBSzTcvyDRXUf0aKLswIlZ1un3Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hfhYQeLA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56U5eu11005041
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 11:34:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=BhCKTD8r+PtEiCiOXNxswbUmBHQNdQ6OsmN
	mzxRSaec=; b=hfhYQeLAjdvpelqJbPDopViDbil4yS3ew278zWna8mHW849q8Co
	heEhRK2hkJ7DFS/TAZnH4jTsAmufVP8GJC2WVNGwW3F4UCxkoPqXHlHGKBaNoahp
	Ek5GTUO9alBX1gkUfl1H8wDOeAfNE4B+ZTwkKkiauxcT7uU7ZjhUkScXrkWSA2T1
	IzQgM449PPm1iMay7ZozZz1XEYnzFumm35sjuB9os8W9bl8cnZS6HpCdMCiAzQUp
	rwn/50M4gkuCYlvyLatOM9sdU082WZ+Ns4t5Y0ZCtH8z5g8cHiP26dKQ5BYxKvY+
	ZJNvdkIiLDyan+cnEYP39QJRlkjHVDEXkhA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484nyu3w4c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 11:34:13 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e348600cadso172876585a.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 04:34:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753875252; x=1754480052;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BhCKTD8r+PtEiCiOXNxswbUmBHQNdQ6OsmNmzxRSaec=;
        b=L6/AAEtXh02meCKQXg4/Q1X/nG810GKCiRm6cY3PU8Jk1mPk4mLDu16x34IA3d9CvZ
         eVYV/3u8iwreIbPr+UO+QywKgwwrp/PUo6NMTPVWVJXhAbvi8RiL62a7SHDEnjF1TZHk
         06KF0edIf17WdfxIE3BQtIOvr2Lv2IYhhsuJ6GS4VRGtYyERdR1m1UHEIcoyb5QJzlkX
         LDaKtH1QzQT1Sh01HXjXaUHsNzJ02SptTF0AHRBPypxpYjDf9OQaUrCvsNiytES7GOqY
         HEMIe/4Ye3u3pYQ2E+lMzpOjxrFRl0beAHpNOB9O98tdpxOghyo1pd8uNpB5If4c/XcG
         dQLg==
X-Forwarded-Encrypted: i=1; AJvYcCVVQSt7LO/6NXRhI17Cv2ce5+ZKxfJaPIUoFTCsRpIH2fP+prbB4rXq6Zmir3BoGbgZCI2DpsX4xGPg3KA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPRVyR8dREW57gy1oxdeDbTNGGBUjcv6KFHDOgZJc5g3HPd5Qq
	3bjP9WAUn+EisZcj/Mb2/ZW/Naexf0m0J6CKwbg/OjQFGRxnYSwAQSHlH15JWoacbYIXFMvdENY
	if6pXO7SVRzGZCtAoJxMZPSN9OMpWyJ4RC3+Y1sG1RhVOTRQGwN3Nbq3BUfeCDvKDqOc=
X-Gm-Gg: ASbGncu2R4wimVq/yC4+wMJ845rtS9+j1USYD+XRa5VGM3I/VNgRNOiloJeLCy9Xd+p
	O8GkAPGZw5PGdfG5/NKvv75M+dCTQUtdhkPPNgtO4qFPoqJ28gfezYeZBPeIAvlY030W4HaGi4w
	UhrAshSmgEsVO5JEMBU3wDBZdZaM94FK8ozFRiBEZnZLgBhbP3hNtO8cusPkes1/elUhh6ynO5k
	VEPxuGM5yt7MjctDu/hv1QJs+LtCbX8RuiKZSLQE1e3p5NCP1ebah1HA2UUNO0cesVZNjd+YUZd
	F6rP+zAZbX7hiX9vawQnD5/PTPAjrSkyXg2Di9B2nMkGHkQO1Pr8DFs/IseG
X-Received: by 2002:ad4:5aa3:0:b0:704:ac29:dda0 with SMTP id 6a1803df08f44-70766e7f5damr42274066d6.18.1753875252417;
        Wed, 30 Jul 2025 04:34:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGexGDGuxaehZW2/cifgkeDlHP40UB5yPKGc7P/QMgOHs9eSLCivNSPwq4Mlwv+4EQiv5YxTg==
X-Received: by 2002:ad4:5aa3:0:b0:704:ac29:dda0 with SMTP id 6a1803df08f44-70766e7f5damr42273556d6.18.1753875252021;
        Wed, 30 Jul 2025 04:34:12 -0700 (PDT)
Received: from work.. ([117.193.215.211])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ae9951745asm64937751cf.6.2025.07.30.04.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 04:34:11 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: willy@infradead.org
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: [PATCH] idr: Fix the kernel-doc for idr_is_empty()
Date: Wed, 30 Jul 2025 17:04:02 +0530
Message-ID: <20250730113402.11733-1-manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 6rbQO3WeIka_tiub5PJ9boiWuPWxprxF
X-Proofpoint-ORIG-GUID: 6rbQO3WeIka_tiub5PJ9boiWuPWxprxF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDA4MiBTYWx0ZWRfXz2XmAHUKVzaE
 yBgxmgCt8wo75Ts7FUqBMB9hapfiSGVUzA80crFniuO6HiM6PS3n6XVIxtMBgvjpqa90Lm5tCj0
 7MIsKr67YyBQDoJgisLKz9sL7ensAdH+A7dPOQY2v7/aihPo1SEeC1Y4Qr7Mp++44Zv4IKSacVS
 LxJhD89r4khLqeHyaD0vn1jUAzP4H6qt4+QenjHvd0nh+MqqMU/EImmcqdno9S1BCUzQTI/dGM/
 qL7Dyt140WBhfVwty0l/5y1EjqyUhWRNbnIQkT4CLwxh2tbaUq4xY4jY7yOaRKvxixBEGXNk8KD
 EJjadmfpkdMWIT8EmJwsPT7Fu+4Xe+9GJwiw8OwSrrtuYiVr9AZSdoszNeWFr6eU1aBNUBaOsIL
 Flr5O/BKE4m4daftVLu3juq0OTDQvdfS0cIb0ly2NeYNLxGMhQqqMzY5MVrwOKAoY3JsW9QQ
X-Authority-Analysis: v=2.4 cv=CLoqXQrD c=1 sm=1 tr=0 ts=688a0335 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=+urnqZw5vKot7juVQre6pw==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=-2WPVV21f4NiumMF_pwA:9
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_04,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507300082

idr_is_empty() will return 'true' if IDR is empty and 'false' if any IDs
have been allocated from it. But the kernel-doc says the opposite. Hence,
fix it.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---

Btw, I'm not sure if we really need the radix_tree_tagged() check in this
function. It looks redundant to me. But since I'm not too sure about it, I left
it as it is.

 include/linux/idr.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/idr.h b/include/linux/idr.h
index 2267902d29a7..4955cf89e9c7 100644
--- a/include/linux/idr.h
+++ b/include/linux/idr.h
@@ -172,7 +172,9 @@ static inline void idr_init(struct idr *idr)
  * idr_is_empty() - Are there any IDs allocated?
  * @idr: IDR handle.
  *
- * Return: %true if any IDs have been allocated from this IDR.
+ * Return:
+ * * %true if this IDR is empty, or
+ * * %false if any IDs have been allocated from this IDR.
  */
 static inline bool idr_is_empty(const struct idr *idr)
 {
-- 
2.45.2


