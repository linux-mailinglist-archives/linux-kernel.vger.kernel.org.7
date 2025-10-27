Return-Path: <linux-kernel+bounces-872597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C4CC118C3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 22:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A4B2B4FD432
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 21:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D796A32AAB9;
	Mon, 27 Oct 2025 21:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SrmQ2SIc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E02832AAAF
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 21:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761600177; cv=none; b=oasdFvbUDvF5D1febGwZ/TTMpJSjLKr13Bpi7ItvAfWiShyY813XSBdKe3DVa4WiAdnm2RdjumffgG0uNYju+VvpG8M2TD510AI6ws1mBOS9Zcj5qlRKPRZkdiGQ+O+IsFwnn80AxVYTaHAloKri7SydKb5KQGfF7X/snrsynig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761600177; c=relaxed/simple;
	bh=15WFbu11baGssEwYzqM7OEKjx8Dct+j+Im+Lby/4CWU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kCWvoiG7gWEWDV3jJjHeldOpvKcNVKNO7Kx4qTmoQFfsgPb7G8AUuygnKJFbI1npPQ39SN2YxBT3Px8p3RIv2uAs2NxsukU7OzPfuBJ244SbHMhXApm/Xh+KkGWdbX0CfP288DlunIYJ0lj0ryZRnQxLzVflwb7WpOvwm46Vv+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SrmQ2SIc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59RDffNx2881766
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 21:22:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=4yt5EMa1UBt
	2+XZRUTtlLXcmh555dcuWUVjp9MvVTfc=; b=SrmQ2SIc3hfCpSlh+Jj7jmS2Kzj
	IcyfLCd4TtHAEojA0A4NhoQl7YEUh1hPkPDcYam4Frp1OU844Metz9imsvEsJNFN
	5kwspgk9UaKYApccGcy2kIb9oG2pLHZmPV/wlAs9q2HJT6AApXnGx8OFIAxozC1s
	k79xP2FvaC6Z+6/knQrhAk28fGjehXTUEFbu9xUSkbmrB3+ZebbqcUythMTBlPX+
	MqfO2P/NbrYfhvdkPDZEXf3zHXrhVp+yNCIURm0RljhZGogWsjoi03BDZNa4V6RJ
	O6ePnqocgfLJkCUqr7CiKZyBk0RTiTZhZqed/fPUNA71DcgBscsMfeUxHFg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a29uh9exx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 21:22:54 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b6ce1b57b9cso3323116a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 14:22:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761600174; x=1762204974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4yt5EMa1UBt2+XZRUTtlLXcmh555dcuWUVjp9MvVTfc=;
        b=njCD9VL1ro9Ka/qOAPNCVktlTsjSVpgHumESYzdYx1aRQ+v4cx3mOpk71H/9ofGavT
         STz6EXCa2Q7I/cgcL89b9Sw9z8J4IsLqC1GFi9gPX+gGV4I2TVGX2GfQtT8biB7KY+0h
         D0do6RnONtFnRLXnRuOKsmLaaMcmZKPzjYQJdHeGKAZN8CDr1sVaurfs29l7A6mBIH3x
         8F963Z8wF1NfHtBAQuXN8K88/z4k7MgugU9j17ptuWsBDsNCUZxy9oykOoHrTeSRfoNz
         52ow7NAtrLz8Vyl/N8EqJztpY8z0dDhmf7Apip/w2Z4wrtZykiIFi2NQx2UMqLtxC8+Z
         YOHw==
X-Forwarded-Encrypted: i=1; AJvYcCWgbtw7/8yvSlfiinQP7xRY43WhWwSakf/eMR4PAjBI/E3Qpe5uYyPrsYRYfBkVZCOLyI13glzKW8srghg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2pqVD0aMH6uWO02Fnk6ypB7/shEnuV2NyURcgfvM+0xOqkSBH
	cNybkwGIYnBEPFJ3idMTWt+6a2bWT/XPaGEQP50SdwK4oZBmBd03V2naT9BYO1vK3SyjxSRB1KR
	4coWr4S4WDoSz+7/K22YCK9ze1HpRRm5N4GAM1MzVSB1FWCzImij3sjFoY9njw/xH5Os=
X-Gm-Gg: ASbGncsH3sXkKV+U/gWasflnBYv19XMfFR0YIG+mSfvDnF7HPgHaLk1lk9mOuKvq1hr
	f2HdlI1Xys04uzg4c8dd4pXnqYR4/XTDUzwLHiYUFDbd7sVDroCW0QOiSOHMJWdBQCWiCsXVKWP
	WQ2BqfbRrpv1lJiy/KVHXAJnGidP4QUyuioasnCnOJMO0wCQl635ZvgMVyrxT7DAAWL2YOEvGhj
	gMqRynqQUWvM45gnN4/AO694OW9fsq8tPT+T+RA4DGtABuvvs9Ida7Cwa36A0MaarYATRIgtJUd
	CzbXUgwV8Z3PvTZCkQ7D6OB/hCxOY1RMly4d1UPcQoMgU0fIzwIuspNHXmYXF3GCanqjXAr0ciO
	Jmrk/XyTN89ELKNnHWYHjO3IkzrV4kZCM+AD0FI2Sb9ftRuLm7gEWqQ1WhZAL2w==
X-Received: by 2002:a17:902:e552:b0:24a:a6c8:d6c4 with SMTP id d9443c01a7336-294cb39b658mr16187825ad.26.1761600173738;
        Mon, 27 Oct 2025 14:22:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IESo76O3/Qa4VuOK3yi6Na6pDZWNnApA7yUHhLu5aFshLKbptgJOUYqaaSoOxVL9DMI7ErUYQ==
X-Received: by 2002:a17:902:e552:b0:24a:a6c8:d6c4 with SMTP id d9443c01a7336-294cb39b658mr16187615ad.26.1761600173237;
        Mon, 27 Oct 2025 14:22:53 -0700 (PDT)
Received: from hu-amelende-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498e42afdsm91073055ad.99.2025.10.27.14.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 14:22:52 -0700 (PDT)
From: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
To: andersson@kernel.org, konradybcio@kernel.org, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: soc: qcom: qcom,pmic-glink: Add Kaanapali and Glymur compatibles
Date: Mon, 27 Oct 2025 14:22:49 -0700
Message-Id: <20251027212250.3847537-2-anjelique.melendez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251027212250.3847537-1-anjelique.melendez@oss.qualcomm.com>
References: <20251027212250.3847537-1-anjelique.melendez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Sl2cQD6MyGP-zU63ktTn1xInbpUJHRjn
X-Proofpoint-GUID: Sl2cQD6MyGP-zU63ktTn1xInbpUJHRjn
X-Authority-Analysis: v=2.4 cv=QuFTHFyd c=1 sm=1 tr=0 ts=68ffe2ae cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=YHN9-SCVukysFp932JAA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDE5NyBTYWx0ZWRfXyD6TQ152p9ev
 rB1BjGguym7T9Ljs6IYaCMM3PErbCtVVjO50Oe/1TnlFzhA3AfEB/nVDJwMfDe3QzkPZHaXDJHx
 1xRu6fPYuQyF2IWpu6JzST79Mocf36cjS0VNKA/xXJET1ugB9bum6MBLQsmsIFNNgrPuApNNpRO
 RvBamMBkeTsxT4DsV3iq+fUJbOazrvLdkepnQlSOTUMpAXX2dIbI6fHjy6wLYGIwDeb2mb6TLDc
 zyP132dAU/p/rDuPm0E57dY7UzgztjU49PQpbOvOkzzdQQbdOS9cHVCUGUs51vMtiJ66ioombEi
 u17ZWm7KlcG7cyqTzL0u/dpcjHxw1h/z+X2EnZXLmR9438G5cbnFG5GvAHgWixMO3Ae2j/YHfst
 0mC8grzPTocvFJa3hARg6zxZRzlDlw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510270197

Document the Kaanapali and Glymur compatibles used to describe the PMIC
glink on each platform.
Kaanapali will have the same battery supply properties as sm8550 platforms
so define qcom,sm8550-pmic-glink as fallback for Kaanapali.
Glymur will have the same battery supply properties as x1e80100 platforms
so define qcom,x1e80100-pmic-glink as fallback for Glymur.

Signed-off-by: Anjelique Melendez <anjelique.melendez@oss.qualcomm.com>
---
 .../devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml      | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
index 7085bf88afab..c57022109419 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,pmic-glink.yaml
@@ -37,12 +37,19 @@ properties:
           - const: qcom,pmic-glink
       - items:
           - enum:
+              - qcom,kaanapali-pmic-glink
               - qcom,milos-pmic-glink
               - qcom,sm8650-pmic-glink
               - qcom,sm8750-pmic-glink
               - qcom,x1e80100-pmic-glink
           - const: qcom,sm8550-pmic-glink
           - const: qcom,pmic-glink
+      - items:
+          - enum:
+              - qcom,glymur-pmic-glink
+          - const: qcom,x1e80100-pmic-glink
+          - const: qcom,sm8550-pmic-glink
+          - const: qcom,pmic-glink
 
   '#address-cells':
     const: 1
-- 
2.34.1


