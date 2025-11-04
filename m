Return-Path: <linux-kernel+bounces-884147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0CFC2F74F
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 07:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BEC3189C4CA
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 06:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00ACE28000F;
	Tue,  4 Nov 2025 06:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q3HAhkor";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eTCc3Vz/"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDD22BD03
	for <linux-kernel@vger.kernel.org>; Tue,  4 Nov 2025 06:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762238408; cv=none; b=n/HbbkpwRFp84Kc9NTs4MHItZ+8q1oFXI+4GMaTjzeM+fCzB/Kogv3pfLmZZ6aCT9sGfso9L607xXFP1dyb5Zd1OVa2JTDS8tkn8zohgst/orgtbfrLFN1EXcCw7VeRSF9fZACoyWSA7yOZvTi+nONdPcOTLc9iOKoC1Nd1m7Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762238408; c=relaxed/simple;
	bh=1zqqsPIx4Ao4Gmn1fq3GLOSHJZ6ZN1z3c30WJS9f1aU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kobj7nS381P81H4of3aly0SoWQ8te41n6CrEUozNcVfGNFsGlJeUVdKHS7pVtG76U+vY4v278P8zH8p51Q46S9yM7YGUFqxCe8N2jtty0w3z9EwAiw0+TbLWOYo9xtCUBM5aJUVo23Pt8bpns8sCTx/Agcm7UFQAPpA/9pzNPrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q3HAhkor; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=eTCc3Vz/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A438hOA3658791
	for <linux-kernel@vger.kernel.org>; Tue, 4 Nov 2025 06:40:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=/eLxjMvN7dLCIi+NES26eyPLirCLrXl/WFV
	AM3oswmU=; b=Q3HAhkor6qY/3+Gk36GpBcdW6rhHHgKSUSNXY3FTWu/wAKrauMH
	PtgCm22k+/gqwpyJXrCN3VD6znWONVidzKBKeKrndZ9QqU+nNPkjUZt34kMFqFCI
	Og6QTHRowueIbKlQtPQDsdhTFCVcNivb17Kap+HOILuAXfT5EuStkaPP+F6ZTmUu
	T7G2eciq4TglLIEeHbVgI+t19O/cEJKXixBBXG6JF4Baafz0TevR20cEXjEnkg32
	+Owr8Pdp4fOtGbPOBbbHt3JfBewsijHnjXppD4a3nfxUNdlaND5JScNK3cwhmlxR
	buR6pTNhwVnegdWQiORLPLgYfMZ7+7s46LA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a70ge9wnn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 06:40:05 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-295592eb5dbso31239115ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Nov 2025 22:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762238405; x=1762843205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/eLxjMvN7dLCIi+NES26eyPLirCLrXl/WFVAM3oswmU=;
        b=eTCc3Vz/wCrfEKgWfSSOrvqAsO9eC66S8iXSpivpl0M9m69xf2zDRrnaElwRPp4tG0
         rWBbGp7sq626f29ES7Uo1WxHNWQwWu03NoqK8vafHYhXEkwf8p4AcxeIYtmEr/QAi6F2
         m+LMA1iIJkrbN4a49VXJwbbIADbnAhNOWRhkQQKk02PiQJG2a5c2mo8GnqmjzIF8Djby
         Jl90J4Icv0Voak0xZxBmVGvITtCLJZlOZE3vOtZV1CTmAUefxyiREvS+B9NrQqSwGDUO
         pgBmebGr1FzjeNQyfcr1CUcCracZ+fpPHE3qRiRN1ykBoCtOF+HhzHmbtyRB8vFx4v63
         dXfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762238405; x=1762843205;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/eLxjMvN7dLCIi+NES26eyPLirCLrXl/WFVAM3oswmU=;
        b=qtMC1tOwiudC003RG2xvMmJNKhv4m3stI/BQcoof/UT5pHcinONO2D0mY8ErwYeUpa
         MZHKvKG3/2UhQCxM2jOFjJZEjN2cNv6LYJ2cb/fWpfLC2HANJAN8niIyl4f07b/rCWH+
         +Lz804BY8CaTs03e0GEx0O/Lp0rnC14w5yeC0/XBRd2UWtlJVop6kPFRZNM3icl6COh8
         gjuaj+pGIHCGQt2tkhhbsLcy9EdNrrMAA6znU5bnUqkpDnNxj3FzZpfaKBFmGqGPF4Yv
         gMCeCx1v11HtG0OyHkaRfZ0IU9Zp62Jb+KPs2YdpruPU9ZxSUCLyM8szbtssuWyVe+0A
         02gA==
X-Forwarded-Encrypted: i=1; AJvYcCWIpH3Gibjo177U425+rWD4l2G7yHt4I/+qMzrjpO2GEDR2ccjVAbGnznO/+FoODvO8w6kXd6TF9w3NEdo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpIAaukzAvAe2MekXtTvv/FbSMT0vx4ONB3A6yyoNJce+8/Rn9
	Fe1E0lYGRvN5kNuHPfGhQXZr9GRT2Fhr1dCCjbp3uOGmmrQAuVJBQIwnKYc95sWn0yT12QwYXNZ
	UfKcH/OqwkGPdaWygWl/6Qpp2fmP6r9pF7ckJLr5ijgsYSpf9e2A+0RL276HIpMvTobMlkIvfM0
	Q=
X-Gm-Gg: ASbGnctFrUOxoFz5d5GsA3/gnWLD3R1syhLbNP2iSA+/LZAGxBBccLfWKsD304Twy97
	1VnxjafC2REHHSZg97EH/gr0Fjz7qSeT2kspZhfarp5oc21dyR5hc83CgL86puzF6W7JmT2qEtd
	dYCZPopjC+ih+UFhuil0HUyNqPotNY3FZS/aEk8XJsbbN8tcNqIYgVpTSbFvqSNSk4YdsEqhOje
	iZm5HBEYHkkTxuyQiBci9r/FHen88F9ZFLRzeJkclCBXpbkrwrRb2bXx9lAVkLWj8CApeVEGovk
	7IyyOLPtMWb6p9TAG4JNPpGeLgYEZRB+fv6+6jMQYfAA9gfww/uLUsCYPmlbkGj/iy2w/aneGii
	ztZTEc6SX7L9+lwhzQnC0T3wT/7MH/g==
X-Received: by 2002:a17:902:dac5:b0:295:888e:9fff with SMTP id d9443c01a7336-295888ea0dfmr114992405ad.20.1762238404801;
        Mon, 03 Nov 2025 22:40:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZzc1gK6aEGU4kh5W4B9zeXAGjoHqkQ2owMT3aqeKlsqObQB8xBxtxLpCSTSz4228El6jqmw==
X-Received: by 2002:a17:902:dac5:b0:295:888e:9fff with SMTP id d9443c01a7336-295888ea0dfmr114991975ad.20.1762238404256;
        Mon, 03 Nov 2025 22:40:04 -0800 (PST)
Received: from hu-nainmeht-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29601998336sm13712935ad.31.2025.11.03.22.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 22:40:03 -0800 (PST)
From: Naina Mehta <naina.mehta@oss.qualcomm.com>
To: wim@linux-watchdog.org, linux@roeck-us.net
Cc: linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Naina Mehta <naina.mehta@oss.qualcomm.com>
Subject: [PATCH RFC] watchdog: sbsa: Update the W_IIDR Implementer bit mask to 0xFFF
Date: Tue,  4 Nov 2025 12:09:37 +0530
Message-Id: <20251104063937.839138-1-naina.mehta@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: iuEYN-MAlCeXYkq9M71bKul7BwQuMyti
X-Authority-Analysis: v=2.4 cv=bqBBxUai c=1 sm=1 tr=0 ts=69099fc5 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=zM6BruqjD1Q-ivkGMqcA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA0MDA1MiBTYWx0ZWRfXyOKp7MJDH3d9
 QjolydHpvXYCtVfvUra/VCa0u2xQer4zluZPnE28g19wA4CJ5bLYMpdu8irjFSyipmXCRxVq0Og
 O27HtCJGwqKD7HO9tzotuW8HZScLk6o8p/dbVKYmFJzk5qjfSoag9x23SVAbmwjQbqrPc581NcO
 v1WlCpgLzSTZPC9l3yMrZi/3vWkVTq6mG2qOW9r1pOO0uajkj0+mYeMYB1sWnWST235+Dyg6Oq/
 F0z7ZbK9Az5xLuRYcEWDoFNNEhAE8Fz0ps7mHiCuCbPKTVkA+U2FeGk1y4EPWkJw9SdAm5lIjdR
 KUtiwRSG0hQ+6VAI9SpdIm/Lvv+oh4Y7Tyq96RiJ18dSBojTeEc7NcFpvdP42PmBBzcjy72P/Mx
 3IQ2fmEd1NN5AjtJ5l+YGtMqWUHBAw==
X-Proofpoint-GUID: iuEYN-MAlCeXYkq9M71bKul7BwQuMyti
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 spamscore=0 priorityscore=1501 clxscore=1011
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511040052

We noticed that the implementer mask defined in the driver [1] captures
bits 0-10, whereas section C.4.2 of BSA specification [2] indicates that
bits 0-11 of the W_IIDR register represent the implementer JEP106 code.

We were hoping to understand if there is a specific reason for using
11-bits in the driver implementation.

Looking forward to your insights.

[1] #define SBSA_GWDT_IMPL_MASK    0x7FF

[2] Implementer, bits [11:0]
    Contains the JEP106 code of the company that implemented the Generic
    Watchdog:
    Bits[11:8] The JEP106 continuation code of the implementer.
    Bit[7] Always 0
    Bits [6:0] The JEP106 identity code of the implementer.

Signed-off-by: Naina Mehta <naina.mehta@oss.qualcomm.com>
---
 drivers/watchdog/sbsa_gwdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/sbsa_gwdt.c b/drivers/watchdog/sbsa_gwdt.c
index 6ce1bfb39064..80cb166582df 100644
--- a/drivers/watchdog/sbsa_gwdt.c
+++ b/drivers/watchdog/sbsa_gwdt.c
@@ -75,7 +75,7 @@
 #define SBSA_GWDT_VERSION_MASK  0xF
 #define SBSA_GWDT_VERSION_SHIFT 16
 
-#define SBSA_GWDT_IMPL_MASK	0x7FF
+#define SBSA_GWDT_IMPL_MASK	0xFFF
 #define SBSA_GWDT_IMPL_SHIFT	0
 #define SBSA_GWDT_IMPL_MEDIATEK	0x426
 
-- 
2.34.1


