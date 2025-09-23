Return-Path: <linux-kernel+bounces-829117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7435CB96546
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 16:40:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A17DF3AE1BD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 14:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E17B25C80D;
	Tue, 23 Sep 2025 14:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="aVyagMFW"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E92E23A989
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 14:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758638085; cv=none; b=jaQoqDC0otn+6ibL4BW/No0azFrtOqKTiwYoqFjO+OHtP25j47RDE99k5LY3Frz5Rk9vYEcHWNzFR1Pqz0VhpYgy3jUi4UDDt6r6nOjY9iSUbz39sc/VkADFzQ/4KfiKCaRMsc7H81fKt6//uUOJmq0jQWc4MQLQF4abp0QMLXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758638085; c=relaxed/simple;
	bh=/lziSapCEzH2gqTs6jMXh7MDQ4LI28NR9zhl2YHnVE4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FRhzdkmnVafRnFs1tNQsZ6V5OtshvTxs81lFuqa4uXJSfp1jgVad/2vEbmum5ihdgudZKqOaPwFx3coQXHMUaC7jMIyOShS6q8gKg2nSCg7JmyxMrBKaX0g/yh508Wv6ZdGQuYUejfkTiDECn7pyQgFNggl63t3gkNJqEfBlN/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=aVyagMFW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58N8HNpR004736
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 14:34:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=iHjpdqs7eCb9fs9KxqbTEla33T54OtQRS2i
	QSrd1H1M=; b=aVyagMFWf7gJ3+5rtZNOb35mFxxF/ClZb+3MTCktfqcnDbHWfPK
	Vi0iUnnNjM0dUWkyR3qPx1npO/vRMd70ozViV+8s5RNqGqrmgjYptKm2LkkbrV3f
	ZFAyQ+4myrq2N6Pb+jNl/DFP8MxoAr+/01XZiO+RODF/MoEl15zz9SvWPZdVRBCl
	5z3ebEAvnX79YJ66OtXUEmMR/iJqkzf1NyH3lIgt6SaTzssCrWOW40MHYLSJLfht
	xiv2pqSt55jc98th59RotUbHAiWhbviByN0nnU0VMaTw0W0CVuGllXMxG/53+S3B
	UqKj/dfIusAfqCIvPegVGkFO7k11b31tDXg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hmns821-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 14:34:41 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-329c76f70cbso4774902a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 07:34:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758638080; x=1759242880;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iHjpdqs7eCb9fs9KxqbTEla33T54OtQRS2iQSrd1H1M=;
        b=TwH+lEParmPAZwL+anxIJTFLSMNLkG3smsrB1pM6xcXS2AtQpsp/LXUMVHaInNjl72
         FsaFDb51n8q1BYFn6guepztnRtyOMPLcZXeHZw1Gx1ybtjCDKbTZ5hvZiYFuY/h2jByo
         apbd9d0/zDPNpoz+IBCr0hgHb3cmd8Ijde3gBPOO4AyExYj1dDw49HmQd1S5piU0KI83
         3p9Skcb4XNC2/BZoAlu6c0ULOrDp5zpqQJEQ1Td3JmmGn7Nc6RQVQnIvxR/FzpWwk46Z
         hlB4cxoYkswaGkAnVIew+EL0+kIeZ+4w7hFzJSG+NQxZIL7zdNnD5FeZQjT6c9OqGjCa
         Gw6A==
X-Forwarded-Encrypted: i=1; AJvYcCX3Nhpd8XGAhvhM+H+TswIuteX8TfLAozNQuPnn0sBPY4IKApnRC+z/FaRvRYdOhhSv9l+zz8SJWkb4Dac=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjzdHBa104Gb4NMZUsKLwXAOcN8+ZvbKuqJkB5S9DByllg1ED8
	krpQf/2n/UgdnmKrc4VU5KEXUQCqYoNzQ08hKcWhmWLzRqeuK3rel2i9rIp2/9SFv1m/73eOFG0
	GPJKt+IDZ8Ae+7bdnE4tVhxvLZ0EbkugGj+5FIe+qbcf4Wwxs33HAuddUhY10yLtnY60=
X-Gm-Gg: ASbGncteIcH6XN5SWUaG+GTFRQXX801ggP5X4NGuR6pwVUZAVK/ejsABvF4ee9U7iAk
	LQwain8oGtxPFuUGF0+fX6jrmxIMf18lqYPUfvNJzsk+AI1phR/lQPaXiZM6q1NCvC3+cVvo/Nm
	iXJIkaHLJypuo60o+tbLfNbVLWunyWXEOLaUAqiA/1vVb7qNWBDP48TVw+z3/8Xbvbf60CsJXYI
	sDMsvtY1+yVyL+++vSThQE9kqJj8iWE/gfdLqTteO+5vdpwUv24BkC9sdYnNXYUZKHjJNyu4xwW
	30IJi98AgyF33QsZWJFwh1Cv27QRPGrDxXjISPtqHEQcDJeGQz9TjEfiJP/Gq87EreSahP5bgmR
	P
X-Received: by 2002:a17:90b:560f:b0:31f:5ebe:fa1c with SMTP id 98e67ed59e1d1-332a8d243a4mr3540120a91.0.1758638080290;
        Tue, 23 Sep 2025 07:34:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwGhl6ZWmSj85Mjuc7FJXLjxNRqQjqt729aWTla6N7ewM+DbD5u9AnCsCrlBb44Z46976trQ==
X-Received: by 2002:a17:90b:560f:b0:31f:5ebe:fa1c with SMTP id 98e67ed59e1d1-332a8d243a4mr3540084a91.0.1758638079868;
        Tue, 23 Sep 2025 07:34:39 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3306064f420sm16676047a91.11.2025.09.23.07.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 07:34:39 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, luca.weiss@fairphone.com
Cc: --cc=mukesh.savaliya@oss.qualcomm.com, anup.kulkarni@oss.qualcomm.com,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: [PATCH v1] arm64: dts: qcom: qcs6490-rb3gen2: Add firmware-name to QUPv3 nodes
Date: Tue, 23 Sep 2025 20:04:31 +0530
Message-Id: <20250923143431.3490452-1-viken.dadhaniya@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=YPqfyQGx c=1 sm=1 tr=0 ts=68d2b001 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=pdVGFcHJ2_4qoVWHVlUA:9
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: Vhc2bxM5ZSNbsfgpvx1gMnuUMjzYmFZi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwMCBTYWx0ZWRfX7mqbP10FAhYu
 96hhlpA8Wr3Ok23ymiwRTO+G7kcqg6JavheUrhh/z8QJxo4/Myoi+v4i+Ne78eN0ZlFcI0hnHOT
 TVuuIqHFnmkcb9THEE7aO123kHkL7qvNagbTJXp+KU0X91rcJM38NdT09WrJ535WFljhHhvSQ0d
 zkRgn42u5mStVNkmy9IvlUrMPbnwODvTtK8h02loyeBEQdujJRNn8dIy4f/W8ktk8P/CKchiUUP
 DQetTZbQEpY4OYEt9cVyPwGuJ+f6U1lBvkh46Baxc7pJvHFFOZMj3hN/IDvZmJ1JBeJuYEdc2PH
 yMsUQkoJX/iu4M1QNws6iBDOd1xxKRHfycNDERpF0awR4njmJP471XJBFLJ6VhhKB0xSDKoLF5g
 swP/gZdy
X-Proofpoint-GUID: Vhc2bxM5ZSNbsfgpvx1gMnuUMjzYmFZi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_03,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 phishscore=0 adultscore=0
 clxscore=1015 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200000

Add firmware-name property to qupv3_id_0 and qupv3_id_1 to specify the
QUPv3 firmware ELF (qupv3fw.elf).

Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
index 18cea8812001..4e361580ddf1 100644
--- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
+++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
@@ -1009,10 +1009,12 @@ &qup_uart7_tx {
 };
 
 &qupv3_id_0 {
+	firmware-name = "qcom/qcs6490/qupv3fw.elf";
 	status = "okay";
 };
 
 &qupv3_id_1 {
+	firmware-name = "qcom/qcs6490/qupv3fw.elf";
 	status = "okay";
 };
 
-- 
2.34.1


