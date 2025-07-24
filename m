Return-Path: <linux-kernel+bounces-744249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E18B10A10
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 14:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 605CB4E5728
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 12:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763832D12E9;
	Thu, 24 Jul 2025 12:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VGkPFzjL"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428342D29D7
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 12:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753359836; cv=none; b=a4Vlh6Re4RyzGbNcRlSksdLAiSzHA1iw2BnsgrUC4rOW2T5+RbdeyWERxRvLeuN+GvOpYy9G2q8VEuz7SnglmcpzjxxMKxxS2d66LjYFe4fzJQZL/zB1Luic+24MTfgfli0X+ka/53DmFdCdS7YYSw90BU9CgMY/rrD2897rSEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753359836; c=relaxed/simple;
	bh=/Uwc/zZkhPQQjTQmHwxW8tbPaiZKFK3b/RduRUcE5pA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DeX8+aBz/PoyWdwkQAXc5+GDYzBwWKYXQ2+LriE78ucMum6gfC5YPDgCFhCzl+dSK7smUiNKROWwjrg355UCkyyo8z11DpGOsK/YKdSH1MMP+OghZLxaBz8LCHzneauRNPqG46tr/wtH8w6lacmfwWnQDNu4QDzJErzhV5q6RdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VGkPFzjL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56O9RCRS028558
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 12:23:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4fa7B7F/ihIT2weJo5JWkNhZb5xr33osr1/iUGbdYqo=; b=VGkPFzjLWvCMua/Q
	o4ua9L17Z9jbKB5Msl/JgaGJdPG5Y1dyEUXu0d8dyY4vdVdjvixl8ydvdXKuzzHd
	HvRwDa0eN0DhsvME8NSJC5PXTaU+3li4/50cgthDi09GIgv3CL1e/T2C3NMPYzDF
	SPrtzs4pFqf+jBDLP2EMiVYG36FkzaLAqc3lI0001toFgEIBdFWhRQwVfS7eL2u+
	KtLvKWGqmLCsCKSrTpuD9kkQbeQeV0N1/AY38WPYKqcnIwScn4+2XO02Lk9w1o0t
	uGiXNhJgkuouT2hVDm0OKLhW04jZyZHxGJPxG40JKZk6I9uPLfdh/UXZUJBbT3Yb
	1Eup3w==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4826t1g0n3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 12:23:54 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70707a55da1so31008956d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 05:23:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753359833; x=1753964633;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4fa7B7F/ihIT2weJo5JWkNhZb5xr33osr1/iUGbdYqo=;
        b=XNx2g6ctH6X4G7jgMTmU6WyWf5Blf5hApXeqXurPJWkbtKfdacmDocF8A7NwWLuNUV
         gf6tPg0NVW4NoBXImOW7hbpTTkHr3YG8q37jR7nzbMwRxPgzUgDRcjsOE1iUXBQOFDm/
         UHQcXtIOakwmqwV3eIy7UlRRPZA15niXePL4GZm6j+vGmvu0FkCiLjIs9YIyCfRG+mad
         eradQFjBS9cUnQ2ONgV5uLXwcVqLWQWBL4TfFyzdU9AymN0uEfsp8oPHksFD1zJWfJy+
         3GvE+yDzXHL0Cm5KIp4qsvPCD1keJVyr+SLrPUb6A1olritMx8CTg0ia1r1snn4zX0NB
         4O7A==
X-Forwarded-Encrypted: i=1; AJvYcCW9gCjrbKiaM0xOJ7EiMJJdNXXFtOXp0grA0PgJPL4DO0lvFKgmS5L1hRCkeXSDPnvDZUbQZTwp8Xtgcsc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz19B6SnUu0IGa55NOdO0Hk6CCOSo8a6/gJ6hFxbll978Bu42WV
	u/6XTtMdoJ95JSzLSTGJc1fxfCKdRGg1jjG59NCYFCy+uMaMXSgojvc6C6q9PYnbDyAoQmJmIgr
	PEvw7XjNR0KSEYimeL6sRboCSLP0n/6nrcn58s+StR4f/akC3bCYWHhOZvTEBamsfCL5xuLB2JX
	E=
X-Gm-Gg: ASbGncvgamwR1ErAyILjZwTsP19moRpSHHVSBHlkVhH9QG5gh8jG9IU6jc89SL5pST5
	PGay2o5xNyw2SFIIXuGgGIBh0qwPwBQvtATLDELxx2ECmPan1KW38i4pDVRr68zxiBn1SJ8XEcd
	7m6dlw7jmTDHTfiHyEroAd1whBVo3yufJt2pJt1m4mqeZXxnhCEzJoDglV5LmnvlC6cQodBU3oW
	a94/WUn0d5ZmOd67R8jG/jFfzOGuIgMya86zcocFdjpfB8GQjzwe1QW4gWin3x/pLVyHGMk85Vn
	CQglbiMWFUm86GEhZNe+4CAN5KzNMwRHbBN/ygIJmyQc/uPAVI9qRHYmSh+v3JuCOY9NeX9B/UF
	9XNWAG0V+FyZj7NMnO9GfZsFvn/V2DNASXL+d5x81HtDGpwYOMdJg
X-Received: by 2002:ad4:5cef:0:b0:704:a0be:87e9 with SMTP id 6a1803df08f44-70700711556mr93527126d6.27.1753359833166;
        Thu, 24 Jul 2025 05:23:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEU7Va3XtsiGXNCtQMIZbUsmTz0HlJZfkSSDIQOMK/GUPCGVH20FwaQuVO4LmH+YOiBA75gDA==
X-Received: by 2002:ad4:5cef:0:b0:704:a0be:87e9 with SMTP id 6a1803df08f44-70700711556mr93526636d6.27.1753359832597;
        Thu, 24 Jul 2025 05:23:52 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b53c83978sm327389e87.126.2025.07.24.05.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 05:23:51 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 24 Jul 2025 15:23:43 +0300
Subject: [PATCH 5/5] arm64: dts: qcom: sc7180-acer-aspire1: drop deprecated
 DP supplies
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250724-move-edp-endpoints-v1-5-6ca569812838@oss.qualcomm.com>
References: <20250724-move-edp-endpoints-v1-0-6ca569812838@oss.qualcomm.com>
In-Reply-To: <20250724-move-edp-endpoints-v1-0-6ca569812838@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=761;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=/Uwc/zZkhPQQjTQmHwxW8tbPaiZKFK3b/RduRUcE5pA=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBogiXQ1jb18xu/Fj5JWf6JNHbkput8cQRevi24j
 DgzIJpHtMiJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaIIl0AAKCRCLPIo+Aiko
 1e0+B/9Fuyzpo+FU5Zb+PoVDgfp1J2Zahoj96Kk1jU/yK+37jrAMp5I+mnGFQDL7DUL6wmh4Egq
 7oyo4dIEU0t0kaey9h8vIZWSD+KNw15wDIRjtjXzIutve5n8OV+N1V72WyzE3+1KQwIYgqt3kQM
 00g5Eahr4KrI7vOEaEdEwZkUtidRrB2uoSrk6liGxqexVYKDPVNRLZGcG2LwoDOViE2iZch2XRo
 3vRRi0cOzmrDfxR2PwWl7bamT6CiVRAoLFyZh3X9QjgAeIZL1QmOdQgi52/hVTKDil//73o3KzA
 E3uZxbftvFntGbI1QI/RZYd2qSx2wOcYwwGdyt5RlYf2M8y6
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: A1ZxGiYmKdMlaLo1m3EMCmyg9RByQZ9l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI0MDA5MyBTYWx0ZWRfXz/qCFGZ23Yar
 yWOqW/+94wUgL2QmmnIIE/aGJm4KHtZ7x3pxoIGYF50Ns7m5cwmb/kxC8oAVJLe6SROlVmft4k+
 SwC9K9ABEetHhgMQygobCclWgL5RyznKh0VNwNt72Gw8Pt3fXiJbZwgb2FV8sRRAaMEAZ3mmYnI
 qzcZUBQVNJ0ux0kSAC11+4JjQ/8TsiaWr7U2+nN0kUaDIIZCugctXQfvaag0w6F9YHR+FxpFbyR
 kP5S9bZxIigtnpXlw1pYnVWcsDt73mSALR6jfok2ugcVq9GCo6GUSELdmRR0ggoQFSudF3KOFy9
 WP5/iUnIuncX71YUHFzWZhpS8LKKaBZEOsiFHzUOlBNosXILsaYZjpkney8vOYkOGSdD7upPDJo
 uDe1u76uTeFqejaufwMLZ2EBITOKhUGeYW20ol4hdHnGKQ3ApkWbR7TeYop9vk8ZIhImBsu3
X-Authority-Analysis: v=2.4 cv=E8/Npbdl c=1 sm=1 tr=0 ts=688225da cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=b1PHIvHk7SdLWIRam4QA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: A1ZxGiYmKdMlaLo1m3EMCmyg9RByQZ9l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_02,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015 phishscore=0
 mlxlogscore=759 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507240093

DP supplies were migrated to the corresponding DP PHY. Drop them from
the DP controller node.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts b/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts
index a70396f250f0cc7509128bd49b3c69e0e78cffc4..ad342d8b7508c543984f166300bea04b6d7de88f 100644
--- a/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts
+++ b/arch/arm64/boot/dts/qcom/sc7180-acer-aspire1.dts
@@ -438,9 +438,6 @@ &mdss {
 };
 
 &mdss_dp {
-	vdda-1p2-supply = <&vreg_l3c_1p2>;
-	vdda-0p9-supply = <&vreg_l4a_0p8>;
-
 	status = "okay";
 };
 

-- 
2.39.5


