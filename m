Return-Path: <linux-kernel+bounces-756006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A17B1AEA4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 08:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C21836203BB
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 06:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D3F244679;
	Tue,  5 Aug 2025 06:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cp4beBu9"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF40A21CA1D
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 06:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754376290; cv=none; b=q/9LE8lKS+JsNYIA62T2bnTJhqgaBi4j7cjqfxS3sVq5Nd6jJHYHnEkpZOnRdTJi+UG/SkeJs2EoWlWLvA6V3QHOOTfjpopYbHaRB5q+PLV9LHm+aUvATdX3CmEvCV/j/3g+31VbfqLQ+gCGAUDFY7khMDT69Ssn1YDGWAsuyEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754376290; c=relaxed/simple;
	bh=QGTu9QxACBWwGBtZKQkCZpc1XZafgh+NUqcrEBKsWfY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iZlHDV2vz1RG6N9bgXUE4wva/0uiDXI7gJyP9nEK7KSbIyefHFMLgIrQKlGrfscIl0/EUtHnIn4J+/QwdPHAunx7+brgsW+XfG8JEKO3pJO74J0N3Z6vK+vjC3E9aiqlFDNV0D5lohjIekJbhX/gH300pHXGXBQfC8xaol/84C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cp4beBu9; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5755TtGT014194
	for <linux-kernel@vger.kernel.org>; Tue, 5 Aug 2025 06:44:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=rzzUExB5oi0
	2Ea7zkpkwb/zIf32msjJwgM31Jx4lZb8=; b=cp4beBu9BPseW8mxCUvuttbsqZs
	uonNeKVqqQ5ZKCNrVMmidhnEK4fAMo7yIoYyIY9jknHJEjo/kMLeXNgQdSLvURtf
	DELe0Xwc3FABU3aZkvSeDS12XsbTf8xZ1QLNW/52m+Ru5SQ9WnozpFkZkqIfWt0b
	871em1YiDkZuvEGSqecpIvJKBVX4i6jsiuQH4VnsVMKSsnbdH0a1b/gWwjpfHTOe
	bsVE73jBt0pNyp2Fm7tUsUja2YOx9hKy8T1kXiNdU3SSG2zwxHCmG3VWBGJ9UcI1
	HX1FfgK149wYVyp/YfHjXh/klV+vKDl1mOTI/ZSWYBaCuHqDGtU1SziCSDg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 489buqqfbh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 06:44:48 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70771c19c64so100298346d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Aug 2025 23:44:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754376287; x=1754981087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rzzUExB5oi02Ea7zkpkwb/zIf32msjJwgM31Jx4lZb8=;
        b=MeYX2KQH6JMOnpaL+X6NImVBgfG1e9siY+FIICDns58Rnw2ppTumeTGfMjw15kYaaB
         sjMUkz038552WKDNpHHCYZUNrb5hE0lw5Yzs9X+i92+pxqpaoM+5dr6+YJ7TidYUPy/B
         ll4ZqdA39fMCjAVYkppRHf1SlqUKdqPDkFFBU43XhgAq3DIV7b6H+elVFFWgof9uW+6F
         ShF/NDzb3axG40XlYD+mGt50KeZkGd+T/22rhnwIKQ23GoPGaAn2dAJ66v058XIwe4Vg
         m7wP/PRNzJ+jX25mkE8tC/IcTzoH3QacnLF/pBC52LqpmQwCRYp3X28l2AcqYsxClIDd
         7fKA==
X-Forwarded-Encrypted: i=1; AJvYcCUwmFrw0LR0JvhV5boigCVbOKm1jNIiVMgq7sqdmgnbZIPZ00Nxl2E5WLxYjsKBM77FermoeaTqONwHRdM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNU7+vG0E6u/Y5jrG0AJERRwMW9N+BR9DcoQl84qvEBxOAD0+l
	w5yPeZK+iP+YUm1dpdo3KBpAQfszYcYr2QHhAUrszF7pmRbVVXN1abRYfyFLymBbfHFG2m7Qnjs
	MpSYp31I9VKUrP+5we8l5/ahJsFZp23QMuwSCM15o+fKDQ2i45lGqEfeLvkni77wdAc8=
X-Gm-Gg: ASbGnctneZU49gFtDHj/DkOIJsobEfxwGE1GhGfs/VpLajQsySzYVIXJ/mXt6++9lP6
	Qvi5rWruFDASD0VAi0kCOQuKgqyy81S/MdyAHl05Y310zS7EKTTfeLRl0ExEeNAYKAA7kJ7OoeP
	+V16z3o+2xovl8VpDNeVxt4g0QNNEOG+6OWShDsR6ysx7Pm+PH2jFC5TOKLjq0migqpSfobh2mW
	w1M1ioYURssoiH/BjeA/bZ5uNolI5fkW2XqzSMMpuobXJQ4KGOY2Rso99kc6gPVz8i1Qjv+kaTy
	7k7jbqksowlFjYqKCVbU+fxn7gmY1vA+nabN2tZj189hp989uawnt2KvuFC8TwlutWtkmMuW06J
	tKPUiz2Ls6Q+h
X-Received: by 2002:a05:6214:248d:b0:707:6cf8:5963 with SMTP id 6a1803df08f44-7096697fb56mr30656756d6.9.1754376286818;
        Mon, 04 Aug 2025 23:44:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE65nbtLDD/3t/KLzicnVLGSD/iwnbyxdIJGzB2Ftm964kvRn4z2OK8EPLsDfgZP6N4VYmTpQ==
X-Received: by 2002:a05:6214:248d:b0:707:6cf8:5963 with SMTP id 6a1803df08f44-7096697fb56mr30656486d6.9.1754376286385;
        Mon, 04 Aug 2025 23:44:46 -0700 (PDT)
Received: from trex.. (205.red-83-60-94.dynamicip.rima-tde.net. [83.60.94.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4589ee57922sm194015815e9.22.2025.08.04.23.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 23:44:45 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, bryan.odonoghue@linaro.org,
        quic_dikshita@quicinc.com, quic_vgarodia@quicinc.com,
        konradybcio@kernel.org, krzk+dt@kernel.org
Cc: mchehab@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 7/7] arm64: dts: qcom: qrb2210-rb1: Enable Venus
Date: Tue,  5 Aug 2025 08:44:30 +0200
Message-Id: <20250805064430.782201-8-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250805064430.782201-1-jorge.ramirez@oss.qualcomm.com>
References: <20250805064430.782201-1-jorge.ramirez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: qeWetI-RkA9dKzvnDH6yUuuZ6NqtlncO
X-Authority-Analysis: v=2.4 cv=VZT3PEp9 c=1 sm=1 tr=0 ts=6891a860 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=Rr2dNH5/fcnoRoBmcVUeRg==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=Qms5JgQ9tnEuTiNUcoUA:9
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDA0NiBTYWx0ZWRfX/eJeT+SvdoGJ
 6sXVWPTtL3VRXOsoL17qH08/rKs6llfkwvlPf0vmyhZTvdAGzrwKQ6qzVNfDjuRXQ/hJKDPjgmn
 f679FyXMV4/hlJuMJzSx6sswAAKKv7ayaRBwtKLmxlCfXQJDAqPVQgG52vdTEhAoWYoS12dw1mF
 9Jahhf66VhC+PjnIehDOYkJO5YX16dUKjIQ8Yn02l8lnSyaPvPQ7ZtMehqcjHBoCiVOiLqwNI/8
 QkrEENjCo6Ab6HyYUKdBBa4Hp0aSQEPhU1cRS1hKSEtJpov3bilImQlVMXp6m/KHY5VBZzp5sLz
 cOnaRT1t+lXUgP4eiZcvmT7s7w9qRyqaLlvnPfhXHsKZV7oT49MTfbPqwrrhvb5qTk9O9kbceye
 qiAcJpd+lhPjhdR3qFkZKQ0GNYRBepvRq58gnhCjVSLJ4nL0pJIQA+fsB545bYIi11eSItWd
X-Proofpoint-ORIG-GUID: qeWetI-RkA9dKzvnDH6yUuuZ6NqtlncO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_01,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxlogscore=637 malwarescore=0 bulkscore=0 phishscore=0
 spamscore=0 mlxscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 impostorscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508050046

Enable Venus on the QRB2210 RB1 development board.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
index b2e0fc5501c1..e92d0d6ad1b8 100644
--- a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
+++ b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
@@ -698,6 +698,10 @@ &usb_qmpphy_out {
 	remote-endpoint = <&pm4125_ss_in>;
 };
 
+&venus {
+	status = "okay";
+};
+
 &wifi {
 	vdd-0.8-cx-mx-supply = <&pm4125_l7>;
 	vdd-1.8-xo-supply = <&pm4125_l13>;
-- 
2.34.1


