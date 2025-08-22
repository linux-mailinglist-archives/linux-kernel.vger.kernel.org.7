Return-Path: <linux-kernel+bounces-782684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B47B32391
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 22:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CE7262349F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 20:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8796F2D6621;
	Fri, 22 Aug 2025 20:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="owXANOZe"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AAB4230BCE
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 20:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755894418; cv=none; b=m82wXLwuOpw8FMPLWr3XgjW5ACNXQegWoJzxwNAq838G4qQoEuWV2/x0LPhqRRKqIULotgBJ+FFz0KFUmBHIQJeoNKMXTuKKPYbxqta5bMh5GPBWbV7vMPo3iSd5ou8/A6h/rZpzI3tieHZwfKPpqaNf1kanqkSsSQgaGs00/Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755894418; c=relaxed/simple;
	bh=r+bCRhwqqwoB96EGu+SOIw3M/48tWE3cWj2qR0ZkJ4M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=G3Y1MI+hD+q/qXCpOdjTXrHNR0QC/3R0iwUpfoxM1nvk1Qdtuj9equUZ9jCgG4ka58+t3kQ/HE/Cgmxy1mc4NBggqMOvanULHL1agEWE3YVaMRYucWG39oz3VWoVyKWg0RcIpr8cL295YtTmX8saHgHckl+9f9oXBbjXIWvfGaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=owXANOZe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57MHZxTH005089
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 20:26:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=UgIXFJkpO+RIibSdUx0jxA
	E3y3S+KknfeJwPxQEopYM=; b=owXANOZeCtAZGsKEHwDz8foML/ifHtGy2CXVRG
	+WmtyUipbdvcF1DO5RTp+/zbunZDBpbjJcpuV7v2QAwINyGNluq5APg4KwHkbMjI
	8Bk+hiySA1YdzR3UKuz8PK9c7olTGhk1QCxVIEjACsIIcnd/6m8wxM2cK3V19j4m
	CBpvlJItwTdNXaQg7ZRg3rIDkHPaJ8uz24xxrWa/Cl8UqgG81w+9w5Qo/oYDqBzn
	IcSpRrRk+L1iw6INmiOOEQbNWY9z0fb8BUFK3yzOp0uNZyuIFtDm1x3IrxJJQ5Vw
	cpP0eraqPjhNbgqmGbtAt+E0v/trqoVKlrVLJ+DFMWV2+WdQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48pw3drd5g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 20:26:56 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b471758845dso2238564a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 13:26:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755894415; x=1756499215;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UgIXFJkpO+RIibSdUx0jxAE3y3S+KknfeJwPxQEopYM=;
        b=c1fEIMouXZGYqG4hZVvuckpzgEr56XuBX9xoXpqL9GgbL08AYn2Oj1ysTXdCZJKv/2
         5q4RuomEiAbOM34Qa9yh6adeXWYRup+C4mBDkOF1o2J3aRjKtRx+q/BvLqo/Yd0tn54d
         hyA3SO+ThS1zYHjmrXuq8rp5OGSogJ84iQhyzHCchoJrcp+XpztlDqdg6YMjvDPtOdf2
         OhSMJjM42QRWqYj3BWn4K0hpJK7C2it6GX7Mzg5OxuPk7w6zLCzISRsJ4gfk/h3bYq30
         aUwamuRkU+NA/ydzSaIj2hKhu0FGxUETbxRxR4IeII+jTegyjMxACFw0Ie3hhEPWwL+L
         iHLw==
X-Forwarded-Encrypted: i=1; AJvYcCWKZLaQPVuIPXxm66wwZyo+BsyqE9jMmdLJL52qsY2fAFOnx57LjxDkZmYHT1WT8i1J2R7EVXBJf74pzIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbFd/X7vmdG3mdWOdX64sasNd3kfmZLTwyGY89CjfgMTHsOC8o
	ERUNTnF2dXWqhx0eB+n3uFNNUldzaY7lW0KnUWxu9hwTBCk3b3AAJGnKy5joyMh+XEgyj7LDXK+
	kknRuk1uL8107E5+wzqb6GgoKtO0kyFk23XnwCof58BM4CVEmZ95pTH/q2oqPtBxZ5vBDG3s1MT
	Y=
X-Gm-Gg: ASbGncvnzEJTw4IijG5auq7k+BNfjKDrABKzxX8nM13cV4cX+Hq7tdVF0NojngZj0a/
	ZNZY6n9Ez17RBrsp7XEheYmEXq4Z8XCGWgDPSnalcTbqPvNPanH54bdZDfog0BrnIXnwyGEzOBQ
	S1y206clCHmAG3D4PtuuFJY63FC6X+l356gCCYBWP3bWe9XiIqI0MaxD1F0WFGZ68zzOZC03D9A
	J4vN2ERovQ8aG4aMtlni+/cbctNk/E020PlfTyd/VPpsjR6pAdSZENMqPzWAW2B4vM1Hpyiaj1r
	iezcmLcQYm/+ds5D4PiFQT7u81uLBbd2IAET0xv03jwyNSBjus70ZZI3d3S1TArQJLEyXz7BbkN
	UNmRf7YPCnTivSJuzY+fj3ACfgw==
X-Received: by 2002:a17:902:e841:b0:240:3c62:6194 with SMTP id d9443c01a7336-2462ee52164mr60159075ad.20.1755894415327;
        Fri, 22 Aug 2025 13:26:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG47RS/L1I592eDMrwsjo+HxwT/fuLxsPYqoHAKRchQq78tSDNlrkN00v2RNhPxUTPJiWeE0w==
X-Received: by 2002:a17:902:e841:b0:240:3c62:6194 with SMTP id d9443c01a7336-2462ee52164mr60158755ad.20.1755894414862;
        Fri, 22 Aug 2025 13:26:54 -0700 (PDT)
Received: from hu-kamalw-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466889e111sm4335005ad.145.2025.08.22.13.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 13:26:54 -0700 (PDT)
From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Date: Sat, 23 Aug 2025 01:56:39 +0530
Subject: [PATCH] regulator: pm8008: fix probe failure due to negative
 voltage selector
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250823-pm8008-negitive-selector-v1-1-52b026a4b5e8@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAH7SqGgC/x3MSw5AMBRG4a3IHbtJ1atsRQw8ftyEklZEIvauM
 fwG5zzk4QSe6ughh0u87DYgiSMals7OYBmDSSudK6NTPjajlGGLWU65wB4rhnN3XCZFVlRl3mM
 ChfxwmOT+1037vh/t4qtzagAAAA==
X-Change-ID: 20250823-pm8008-negitive-selector-71646975befe
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        johan+linaro@kernel.org, quic_skakitap@quicinc.com,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755894411; l=1517;
 i=quic_kamalw@quicinc.com; s=20241018; h=from:subject:message-id;
 bh=r+bCRhwqqwoB96EGu+SOIw3M/48tWE3cWj2qR0ZkJ4M=;
 b=2yNUz1i7l84ts1ajeYFFAYgXjt83VbihnQUt81z5xL2suioZk9jrw5w58DGXXRAvfwxUMTEch
 vReY+SKATQfDoeRAyfOhPa/PUUHVUrJ8CC1R5DErdME+ueN4002sshn
X-Developer-Key: i=quic_kamalw@quicinc.com; a=ed25519;
 pk=XbPE6DM5/mJi2tsiYwMCJCZ4O5XPMqColJRlGVcM7Hs=
X-Proofpoint-GUID: BFLAl_OE2nxyqmoS4ccxXaip9AVJ-w7p
X-Proofpoint-ORIG-GUID: BFLAl_OE2nxyqmoS4ccxXaip9AVJ-w7p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIyMDE2MSBTYWx0ZWRfX1mTo/D82N7ZB
 l2ToB3TIXj4GaWEnwDpcGn9mutqnRN6EzkKH+VdqZ2yKvuicyL0EXbOI61xexpvZ+6DNyGDeYER
 +CADZ1EOHXb6bbqGpUQvMH550/M0Js0QQKupERUSHCHeUocp5Tov9V0x8f+8eNKWRsXdOmXuHxh
 uHvYILnvUxXjd3rWJFZBqfnMSAJPAbG3GxBLxtRvDcdk1Tubc97Ecliinv5dbFqVGmRGw/kemRK
 T1VKDsJBMbV976rURfkUpluUZfNHx6dndjpH8E7nTDXTI/G43IXP19oQJisfHI8my/yCtq7kKa/
 LoPN2g37Bk28GsQA91ccm2ON2xK0+2ZvJoLH9Q1ptQBCwVa/jSjKlmSrEM4PCZM4290fwzrBTSm
 tZt8aTGa
X-Authority-Analysis: v=2.4 cv=WId/XmsR c=1 sm=1 tr=0 ts=68a8d290 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=qP3kmwz9wx84Yj0DIhIA:9 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-22_05,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 clxscore=1015 adultscore=0 phishscore=0
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508220161

In the current design, the `pm8008_regulator_get_voltage_sel()` callback
can return a negative value if the raw voltage value is read as 0 uV from
the PMIC HW register. This can cause the probe to fail when the
`machine_constraints_voltage()` check is called during the regulator
registration flow.

Fix this by using the helper `regulator_map_voltage_linear_range()` to
convert the raw value to a voltage selector inside the mentioned get
voltage selector function. This ensures that the value returned is always
within the defined range.

Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
---
 drivers/regulator/qcom-pm8008-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/qcom-pm8008-regulator.c b/drivers/regulator/qcom-pm8008-regulator.c
index da017c1969d0cc2c6347b68c37518ea8a7ab44a3..90c78ee1c37bf9bf69f43e0bb7798fed94590e95 100644
--- a/drivers/regulator/qcom-pm8008-regulator.c
+++ b/drivers/regulator/qcom-pm8008-regulator.c
@@ -96,7 +96,7 @@ static int pm8008_regulator_get_voltage_sel(struct regulator_dev *rdev)
 
 	uV = le16_to_cpu(val) * 1000;
 
-	return (uV - preg->desc.min_uV) / preg->desc.uV_step;
+	return regulator_map_voltage_linear_range(rdev, uV, INT_MAX);
 }
 
 static const struct regulator_ops pm8008_regulator_ops = {

---
base-commit: b9ddaa95fd283bce7041550ddbbe7e764c477110
change-id: 20250823-pm8008-negitive-selector-71646975befe

Best regards,
-- 
Kamal Wadhwa <quic_kamalw@quicinc.com>


