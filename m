Return-Path: <linux-kernel+bounces-748764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94FBFB145CB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 03:33:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D997C3AEB55
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 01:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12571FDA8C;
	Tue, 29 Jul 2025 01:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="DHsDonNy"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BEE1F4282
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 01:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753752761; cv=none; b=CpqYr1y//2sJJ1uSI5oqGj0TNv3vY9mAUtwTntckYDE/zqJ7L8G5DOBJ5NxyPYfHML8hT4HF70uF+XL/pZd/Gc0Sqmn5lAaimUFZ4CJ0VHjPWsdnA9/BL1dIvHiexZSN+xY8L1dbsf11UZ+NbUJo5NGDvk91OrBNbcYx1POwSk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753752761; c=relaxed/simple;
	bh=dpxW8aShh2RYLX9CjF0k/XEH2duG8LnixEBwdfov9eo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZRw3esWdZf2QJKYQUteVvDPe2v4wchvtRI8CJhO0868McWfxUTtsY9yIQLs+OoyI2wZYejv9SCEUlZlZydGLSNbffneMoLvFg8R0k7WoUHRCxtfWvJ3os6K1fkivO2xOnhJy/12g2AbB7S1lr1UueNWepjFgx8g4vjWelyF+vG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=DHsDonNy; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SLNO2H014622
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 01:32:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	+WbtO0JaeN1fhr4oYLduWJfFLHLQ9helHJAYmSQJKos=; b=DHsDonNyDMW1/nJL
	H0QD1zPT/Wr2sOoN+J2WSnmeN1MDNfkiyU50Vjf9GrplMkmMrHHtfOiI1IFPxwFV
	mubLeiF4KD9lm36BRGUvkFjxxgbi5EMlax+19bG9O39QgJIaFfpJXchMK7A1+rAJ
	itSxJHFndtpTB9Ln4bCGTiZwOzJek4wzbTcNEHZjlzGn6SKECPohgXMt74av4CCD
	7IpIXNgfOkoGLwS2Aoi+srRaBSp0CQoImISiEns1qSK7e6Euq7cPlg7+xeIajMY/
	/vsw9gejnqeRmc6MoBwj07FQTf1zRgu64qfDV63X8D/nP/oInbveb/el2CD9cTn3
	tP+BMg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484q3xpawj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 01:32:38 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-31eac278794so2334885a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 18:32:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753752757; x=1754357557;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+WbtO0JaeN1fhr4oYLduWJfFLHLQ9helHJAYmSQJKos=;
        b=pof8RwGPNjVD9l04oQg7EB/Nkn6+ehAFbo70UBlo7t3ru2p3sKexrpxagsW6Te6K4u
         yXcGRZ8jgzVPh/fJYXBmv8woNFrt0W42yr4oh9utSlHgUxyxc6XoQZsN60VskVuO4Ftc
         LNRKGsxPJNWJCbp7lEyiTtP5PLXyandfee2IuHktiKJMZx5SUdKaQTJsToOCtUDeZH1e
         EOpWLVA9kdJeomYXLFcWc+a6fb0ld5yV+xz2gUyAbtVGAxfQnMQJWkCfx+bpRFKGTxeS
         /AtAPAaD3mU+jEN7Ixxus8my2B6TSv33v+Pa8Cp80iuDfFSH/k6p5BKnE/EQ+wu3QvcT
         JjSA==
X-Forwarded-Encrypted: i=1; AJvYcCVnSIyQR5WlV1f72K0QpTpQ5uREse4fptBO4C//OZlIoCAYE+dXxQsHki2/2M4dOS5SkwvQytSW0+Xi3js=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQeqixSq+TcI8itmCpmDGWK8okA0WQUl9yjXsNuyFlJUek9MGt
	Wr0kFrmbybltpX3xMZvhbMnkcTZO5Jh/37f/IzlArNsYDx/a9KiGTwEG6hBpd7VlB60o9Aiix2C
	12bIBZyeXLhix1Sa90ZoEDvftO0X9IL/PtZgsiIT7dZbf+J0knwWf0Bm21YxAdfKaq0Q=
X-Gm-Gg: ASbGncslSTo2fEcfgHfOYXdoVAivkXzrdfHrsTTqFAq3qQkUSZ5iNI4dVXxLSFzC75c
	56Z+LTcM3hGj7IDJmQJ3BguQR+3/XTfi55+cc94zWKUqTms6ibGpD6EYXmi2ZnZ9qZFAJZo5oRZ
	2eW/B2Qml9WAkxR9XmxiXSPMWvjw0U050eLVght+GYz2XxL3dtqfkL4s23fGFNOwNmt3pkfkIN3
	lI0hnvNL+SCQLqmwLJh1l2tvf2jjCUOuTH2/zDOJIJ9VFNTkJoW9wDD4FIflVe4FRgtfgEKWgda
	kNJG4h0Jddbz24Uye3mYXZbix7Uv7jop95fEzjrpXQKHEtS5Q1E5/xetQjI4AizbntfY++QvMgl
	/yAGvBNvhZ/XJxqkUYwUIrw5Z+21KtqUSng==
X-Received: by 2002:a17:903:1c5:b0:234:986c:66bf with SMTP id d9443c01a7336-23fb2fef327mr178451015ad.11.1753752757371;
        Mon, 28 Jul 2025 18:32:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGa3hRcc8uYaZE3mUBUkpRF0ee2DHpWPplGSLAHNpWv/FMvjfBEx8xAapx8JkFCzhryUd99CA==
X-Received: by 2002:a17:903:1c5:b0:234:986c:66bf with SMTP id d9443c01a7336-23fb2fef327mr178450575ad.11.1753752756809;
        Mon, 28 Jul 2025 18:32:36 -0700 (PDT)
Received: from yijiyang-gv.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2405bca90ebsm11210625ad.6.2025.07.28.18.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 18:32:36 -0700 (PDT)
From: Yijie Yang <yijie.yang@oss.qualcomm.com>
Date: Tue, 29 Jul 2025 09:31:58 +0800
Subject: [PATCH v3 2/4] firmware: qcom: scm: Allow QSEECOM on HAMOA-IOT-EVK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250729-hamoa_initial-v3-2-806e092789dc@oss.qualcomm.com>
References: <20250729-hamoa_initial-v3-0-806e092789dc@oss.qualcomm.com>
In-Reply-To: <20250729-hamoa_initial-v3-0-806e092789dc@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: Yijie Yang <yijie.yang@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1753752746; l=902;
 i=yijie.yang@oss.qualcomm.com; s=20240408; h=from:subject:message-id;
 bh=dpxW8aShh2RYLX9CjF0k/XEH2duG8LnixEBwdfov9eo=;
 b=8Q7Q8nlyZKIFvBTCy9gXYcFEMWitIr6B5ietc72n5mFzetjwBg2rFJQ5W3k/hSmyXKfS6x0PR
 Tesb7L2qmL2DsNEwx3u0OjoadRF4KZTJwef+H1OCiDK9yJQXTWYTDjg
X-Developer-Key: i=yijie.yang@oss.qualcomm.com; a=ed25519;
 pk=XvMv0rxjrXLYFdBXoFjTdOdAwDT5SPbQ5uAKGESDihk=
X-Authority-Analysis: v=2.4 cv=JovxrN4C c=1 sm=1 tr=0 ts=688824b6 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=h7II6S6JRGbW-U2bcKQA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: 08LHv_huJfcMXSBRPxwMW0AAHFcnRREB
X-Proofpoint-GUID: 08LHv_huJfcMXSBRPxwMW0AAHFcnRREB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDAwOCBTYWx0ZWRfXy2W81n9rchQt
 hZ0LpeDVLN0wriFp3qwA9Qe5sHdMRCdHRys3NsDzsJqO0oRduin0NJAXQdSI/qNL7gIK7AB/njB
 A5spOkqvgS1miUVbsDpxVtIqFYgjxDyzpcnVFLW3DD1lyEDHbUBGhqGDtCJc2NVvKjeIyFOj1pa
 UooIttMYry70B0J4cwiPpnphundSRmx0vt6W6vIL2CAeDrVYVFYsgz8H3QYNsadSKivCPwxrt8u
 lpcSYHhi9xMEMotdmigE6Ywmwk+B9eM3Gl3MPVpWqIqenTQSgEu4JY8muR8g6230PqeoUEZxFet
 TQofI2PZLqIk6vuwoH6ezrYn6I74w/MjSAdUCd4kaUvnx6HS9S6m9ATO8Sxv3UBWCoHuDSn3Ke2
 H84/7ol5xvAPLrHFknTmn3xg9cg9Hl3aUqgMFeln6dMro73dQG+Ic6T9mXkLVHEtAyQdCSra
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_05,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 bulkscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507290008

Add the Hamoa-IoT-EVK board to the list to enable access to EFI variables.

Signed-off-by: Yijie Yang <yijie.yang@oss.qualcomm.com>
---
 drivers/firmware/qcom/qcom_scm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 26cd0458aacd67dcd36f065675e969cea97eb465..27c9d4a0912646415efac2df089ddedaf971fcb1 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -2006,6 +2006,7 @@ static const struct of_device_id qcom_scm_qseecom_allowlist[] __maybe_unused = {
 	{ .compatible = "microsoft,blackrock" },
 	{ .compatible = "microsoft,romulus13", },
 	{ .compatible = "microsoft,romulus15", },
+	{ .compatible = "qcom,hamoa-iot-evk" },
 	{ .compatible = "qcom,sc8180x-primus" },
 	{ .compatible = "qcom,x1e001de-devkit" },
 	{ .compatible = "qcom,x1e80100-crd" },

-- 
2.34.1


