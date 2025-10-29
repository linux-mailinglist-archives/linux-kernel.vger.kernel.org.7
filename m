Return-Path: <linux-kernel+bounces-875488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43DD1C193EB
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 09:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5208A427DB7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 08:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA9B32C312;
	Wed, 29 Oct 2025 08:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XWqjNbzG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hCD7E0ZL"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C40328B77
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761726344; cv=none; b=MTX0Wf3ovOTe9/wjV7vepTwFELA/r0+DP7HDOqTyoTWeMPk8FbvEA+UzhQYkvy4qGNLEqkSLx9fJ3NmFFktGHY+juhwi4J84Sa+r9DFJiHLdPdtK7zOJJLJ+9BgSGjUX7b5sJYS6of2sPZmVvS+iFrXnokRqSkL+lkHyERYNHTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761726344; c=relaxed/simple;
	bh=QfKV/d3gO6255Bq1Gu06XBIiBSg6d1J1BVCrin6ruxc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D5TUykFdsHi1fLCZCbxYFKsDs036snd7OXVP1iC4sbFJXVNWraC/1AarmBtgWXWGUZWcaMaNEHw6FUqAZXYPctBquxjp3DSykOOOLDN2p9xAxXuOJ3t57VNEazIHvEJ7pBzz9v8tP8kLm9R71IMCSRLK16Uzli2b1auzk6ijfaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XWqjNbzG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hCD7E0ZL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59T4v9pn3764533
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:25:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	SI7h/T2Ai3eUH9gaMcsEZ021ub3ZOvaSkx7DIHf6TpA=; b=XWqjNbzGgmJ4xvdH
	c5/tMCN3UpRvxy+fidtNzDT6dLfLCjSFnl4d+tOkl4vqRF4ZzexTxy+BPiNfwURS
	sAn7MKbanL6dwN2FSVrjJT6SilU3guIVsmyOkELPUtdBgviGV/9VDAqxu3iTT5d1
	vbaOYhsepaPIH7suMUXUgqwtT/G55tw6BraHqbhJx4UfVxWdhyMH3J5WPHo6jF0b
	Ym4zlH3ozFCmVY7TAUGVqUX/pOtxQxhVxbJRnfBIXK3JKH82r1u0UAq7aiUZbm32
	r+pyuko4qu0EXT8oEoAdXi9xDXjJHPQtJqRcJpxSloOqxv+1/OMG7ZmZ8PS3wCMa
	zvgqvw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a34a11sfc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 08:25:41 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7a4c4eeeef2so1380117b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 01:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761726341; x=1762331141; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SI7h/T2Ai3eUH9gaMcsEZ021ub3ZOvaSkx7DIHf6TpA=;
        b=hCD7E0ZLneFnZRm/uyt3jNoL+q61WCVQhJBszkvgDj145DPpx471qmaXIs2lrTdKEE
         nSKtco2mareYiCgXft7AhjGR/r37U6hgM6yS00gX5TvY2QKl984iYrlSQHhMG8PIlW5B
         EWS602q7EwBSY81uB2IQOtJO/dwD0aKtjDW4GN6oGp8VUJpIc8Wy3jYqR/uE7U8aps6D
         pVSNXJ+AhpZeclMErfi/jW1/6rKDEnOOk1gSNDa8xf1YiLpeAWFOkTH1+kGPdUHO4Pv/
         KeQYzl51exlrFiNsKaX3YhbNUWIXt8igE0SvaJXupJD+3X4XHKDrcFsRfMJ+s50NWAnY
         j4PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761726341; x=1762331141;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SI7h/T2Ai3eUH9gaMcsEZ021ub3ZOvaSkx7DIHf6TpA=;
        b=peF4Qnpwh6Doi40A+E+YJYkZ48E+wMtga0UEvAA1gMABdxs9S/MXnziKugTu/42bJz
         PVdbaUEOnHFGQvt5iUyKII1ANvyBi17W3/eD07QugyAKipUg05SeQuqOYWExO68dmJFi
         gXFJO7KGeVhWXPkeIk/5v4/MySsbSkdO6GuKo1GHaNRp/8qC5NE0vx9Sv18AYPI6KR4t
         s9IjaiSNZ9/Tghzvg2P2uzaNfqwwpkLJ+/ssOdt8P/4WGRO6uTsgxgQkpPSpyUm7a0+Q
         c/PEazckChTwY3cCdp5WIblQnphyiO5SoYpaszjhnFq9nOqXkJNyErEld3P23r3wUBd3
         hAtw==
X-Forwarded-Encrypted: i=1; AJvYcCXOQ+hfnbKy80E8vh9ewJDuJbDh6PyhzQC+4xcYhbpsMoEhheTRuLmussBw5qpCkwfoY9f8f2RA4z3O+sM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2s3yDFLwZOp+98BoWrI3JWjN5hEQG1fdh+f1e8NS6YnL5w6pd
	qhTkw7EcCxJKUnlnggwLzaGG093Oq9P+6TexUrI3xQUfkFXYxVghQQiON0VmNaedwlZHpBBYXzg
	LaUl1IWiabGppVRXt8tyq97smNqNFEy4W2FflBo46bex23bdLwYNW8M+mM2OQlb8FFPM=
X-Gm-Gg: ASbGncsC4lijW06VdhR8bcjEOGZuX827ie3OzWcbwMc0j66WlGDxBHGfGsc0QA98i3G
	ZVr4thAhlQsfoHgBxDGUPCs1CglwGq7HFSemPzCt3QjLo8Km1VNeOqngrhtqbdozuf1v5EJb+dK
	yf0XTVj8VdwAOA++H0H4CC+TNQ8WMAmJCdAQzJSKA5GKlL0tVaydKXjkwCBgsYcVAr5Zq/RCBI/
	4aBYzbVna6ubVy/ip0Oyb+OHoZf1ZfPLszoC/atuv0XI8nUOHOTdx+7/nRN/HibwMOkirHjR5FV
	WZ6pSidr9+PziA5V1cD2DX7EM9YB5BfQsPJFTtIm7MgpQsAEPawdcns3jGphdM9LJ/ApVF8freU
	2cxrke2FmZpFU4Nb6Ps2zAB3gY48dYR/Y6BFfnPIY7uPSj5goQQ==
X-Received: by 2002:a05:6a00:17a1:b0:7a2:6b48:535f with SMTP id d2e1a72fcca58-7a4e31d80c4mr3183298b3a.12.1761726340712;
        Wed, 29 Oct 2025 01:25:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdWUMfoQSftVn+lusAOnm02Ws2xPYh2EYrN1Mtd4aD6Wz0CNiia1asitR9I0WSYSAKCYnvSg==
X-Received: by 2002:a05:6a00:17a1:b0:7a2:6b48:535f with SMTP id d2e1a72fcca58-7a4e31d80c4mr3183249b3a.12.1761726340191;
        Wed, 29 Oct 2025 01:25:40 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414049a44sm14158850b3a.35.2025.10.29.01.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 01:25:39 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 29 Oct 2025 01:25:31 -0700
Subject: [PATCH v2 3/3] crypto: qce: fix version check
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-knp-crypto-v2-3-b109a22da4f7@oss.qualcomm.com>
References: <20251029-knp-crypto-v2-0-b109a22da4f7@oss.qualcomm.com>
In-Reply-To: <20251029-knp-crypto-v2-0-b109a22da4f7@oss.qualcomm.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Gaurav Kashyap <gaurav.kashyap@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761726334; l=1130;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=omxST5DmfZwYu9h7SFMilfhE7adNC9B84PnqeP5dI6k=;
 b=0Yz0fbgUYPu256QnGv2gWtF6KiZ29fOV4bqnOkX3ltZi8omk1/WNEEktvwo5X5aVDYjd/sNil
 i6nBblXUZhvCi32cKd38ep3NI2ef4EiQ9fZekY42hyTLtNd5T7UQaea
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-GUID: lTFf2lMS3DUElmb_PCBBwIoilp_kfZsT
X-Proofpoint-ORIG-GUID: lTFf2lMS3DUElmb_PCBBwIoilp_kfZsT
X-Authority-Analysis: v=2.4 cv=A5dh/qWG c=1 sm=1 tr=0 ts=6901cf85 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=7enFwbqk3NRG6xSZt3cA:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI5MDA2MSBTYWx0ZWRfX9XlcJAVdbyVp
 CLQP55tb7wCq9iu7KCBcIkhTejhzUkl0+fA8N8HRWhTToCewCCCSCBUfACkyFcNim6LN3w7s80Y
 VhaygjrWMIxmqQ51nfi7BkUwG25Rg3djHaALsb03MpiYkKw1fkzIotQr8j7s0oyugI6o/bYgGm1
 U78Mr1Hj7RnJtIl/WbkPlseFzR68aJQIbp17jkRJnO4jewmif/qbrJddMRFObNZoABOJIB/rjXY
 Ie3mZuiegEOrWEvJfjobZ7I7RNYxQPUHDiXJeCq8hIdEN4g3qnUZdUdw/kjGM2/Ym64tg8BgyAd
 ckBdBe9oF7OATf2w/VPQCqyiqzUucIQei5H+9hnDBRHhhETuaBV84QjFKXpJLk1TzMHa97cBm7S
 ShToSnM2p30BQ50cKmn4OXv2andtWg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510290061

From: Gaurav Kashyap <gaurav.kashyap@oss.qualcomm.com>

The previous version check made it difficult to support newer major
versions (e.g., v6.0) without adding extra checks/macros. Update the
logic to only reject v5.0 and allow future versions without additional
changes.

Signed-off-by: Gaurav Kashyap <gaurav.kashyap@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 drivers/crypto/qce/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index e95e84486d9a..b966f3365b7d 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -21,7 +21,6 @@
 #include "sha.h"
 #include "aead.h"
 
-#define QCE_MAJOR_VERSION5	0x05
 #define QCE_QUEUE_LENGTH	1
 
 #define QCE_DEFAULT_MEM_BANDWIDTH	393600
@@ -161,7 +160,7 @@ static int qce_check_version(struct qce_device *qce)
 	 * the driver does not support v5 with minor 0 because it has special
 	 * alignment requirements.
 	 */
-	if (major != QCE_MAJOR_VERSION5 || minor == 0)
+	if (major == 5 && minor == 0)
 		return -ENODEV;
 
 	qce->burst_size = QCE_BAM_BURST_SIZE;

-- 
2.25.1


