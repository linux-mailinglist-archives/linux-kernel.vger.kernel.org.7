Return-Path: <linux-kernel+bounces-866213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F6FBFF304
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 06:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B1D44344262
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Oct 2025 04:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50912261B64;
	Thu, 23 Oct 2025 04:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VqlljeAx"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E681D86FF
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761195475; cv=none; b=iUSe8yPIkgTgGct/4rQSLQvfl+rYnpwT5K2tfvq3OFjO/1z4wQGKNSRWgzYbkX37v01Kloucbs96bpvYJ5/fEpXZLSNlZgjpdfXv3/A9J0roY0Cm5Hzii33nTYI+cX34w7VM0Ub1yMkMnd1CJ4iHQ+tcShnmcigSAcIoFg5msuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761195475; c=relaxed/simple;
	bh=nP3MmgM3OO/owQxwBNTpJAqNRSLheBdloe3A2buJFiE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LbLzF6NHEiDW+PYra9+iaq4bUaftzjd2iHx39Fpn3ynMP3F/DmRGetuk5t8bmd3pPHaY8NQyyLVKIRFEayTV5OsAiu2os4ku1YP4pOgdzBPHlysb+T4VAqqr54HTVyUweHK+enYqfJ2FfoQTNI6FkbKxTy0qxL7V0sYhHM/nvs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VqlljeAx; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MIeoYX029838
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:57:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eP3LilVKt+lFbxAHwFZtoyMgNlR79PwYtVYBu29OAPk=; b=VqlljeAxZ9/ZLdqY
	ul/IJSz9CO4Uqc9PWrO6LfTJEXWH8XIevDs8Ap03pxFaQ/0h4X3at2Q11HAxVCQ4
	NbzZVY28AlM2aoUnHgn0LGx4Kh2ZMecd1tztRUHtkdiSpj1zQUFtgHjD21dat0Ua
	8QyusXlkD7f98stBui3vJBsD3PiDAcO7dwMVcGi/a4sjiEabqfsJz670O5EZcSmW
	5+YCPbyqZBC5Y3mZh4oHmlLYAt/1fZS5JeR066m4UkJZ88Kny+y8aOeFBjIGJwcn
	L7KwCSUtGlNdK0WGztRqJukBPKuVxj+z/+qZgOJLh4lAruoMWLxUusQWsHdtvfSI
	MKxvwg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49v2ge7104-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 23 Oct 2025 04:57:52 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2930e2e8e7fso3329325ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 21:57:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761195472; x=1761800272;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eP3LilVKt+lFbxAHwFZtoyMgNlR79PwYtVYBu29OAPk=;
        b=ASq+y+TRfhXTJkaisZO5sDJF8TGn0GbaUyD0IXXy1g8kHrb7lDE10a4521pX+kwGx0
         wMfm/9zVPrBkABnXc1X7sfucoHTRFixECfJFP9ga0qzuNR+UK8DOcX9yue7GUz7BrSv7
         dW+aEY9aEzubwiQJEbA8wqNlkiyvbvKGAcoexgkeLq4OBCT69f0ijVMNUzOi8cI9w5L8
         iXWEJ2FMqFli6bFVSLjeD1MgNwV4SKFuw8uisqi4imwaxqxzMqDKsaTBUlmdxu6uj6r4
         Jw/HsnT1iAvGuomJhswFv2J1x1KiaXCdc+kScjdWQdxvsEcWhtBKOekBlNnmHitSmzUY
         rCUA==
X-Forwarded-Encrypted: i=1; AJvYcCXHzMHi/2yp35lZMuT/0/WPD5p6af4rsoZrfQVyNjP8xvp1C8/iFMINOGgSo7VaJ8AYb8f68qjBAU/UXwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBGiVCYzip97V/7GX1jOQMFA1a1X/+GaPaBx8PJoko/DRWF5w6
	t9m6iZAqsmr3EaXw6pX7By0dlwge+SvM+LLARaV325gIU2HNGqTNuWHVWwnwawGtWBEa2QKjA9O
	A/b1bKT8CEnFag5PgCk7FozWwEvjMQE/nN2JrRgodRkpxwgLxbmz4r2lzilT8F9YUyS8=
X-Gm-Gg: ASbGnctLMts4+ElBpPybQeo1SM22HuWdpHC7VcN4AT45id4hnGghJtNhkvckrvQeX4z
	s/cU2jsK3g/rnyC/3cE6EBnH5dGicBh+YIXoc9FDGKblmy1U30RQhUU+3aYTvSD/3N3SFs6ohrI
	gjP789jjaqBRw3PtuybbDQo4fnsKraSsk9olnzYIBV6uFQ8umwf+gJlvVftZ56BcejAb1oSbT5L
	Zh0JvJhgES13B++lhPHL/Nha6KTbmT3RXt2QBBUpFCD5UE+k9Ed2wkLlfmW9apj3o9qhWtvkXHN
	PZpstaX1BztukSCdTccmRV0D2wNJcOc5GD1BVSkrQ0f8ZKNCkPpA9IbwE15mYofgTiADqy9qlXV
	3thZEVyEnuQhsya2903VwQl5/w2DQBd/1Fxb9p0mdTVP+udQuYg==
X-Received: by 2002:a17:902:e5cc:b0:267:95ad:8cb8 with SMTP id d9443c01a7336-290cb079f2dmr335533395ad.44.1761195471565;
        Wed, 22 Oct 2025 21:57:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE+qpSBs+V8iCRJV2Qk2k/Fcf8PfbvACLZjNtJduMEIfCiFUZfla2Qz8/Nn5Aq+sQw8fr1wFQ==
X-Received: by 2002:a17:902:e5cc:b0:267:95ad:8cb8 with SMTP id d9443c01a7336-290cb079f2dmr335533135ad.44.1761195471072;
        Wed, 22 Oct 2025 21:57:51 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4bb86cbsm814289a12.7.2025.10.22.21.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 21:57:50 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 22 Oct 2025 21:57:36 -0700
Subject: [PATCH v2 1/2] dt-bindings: arm: qcom,ids: Add SoC ID for SM8850
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251022-knp-socid-v2-1-d147eadd09ee@oss.qualcomm.com>
References: <20251022-knp-socid-v2-0-d147eadd09ee@oss.qualcomm.com>
In-Reply-To: <20251022-knp-socid-v2-0-d147eadd09ee@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761195468; l=696;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=nP3MmgM3OO/owQxwBNTpJAqNRSLheBdloe3A2buJFiE=;
 b=aOQgNkbU+JOoRlizxASsWjq+JPXFnkbM+kN4iMrgdpoa65lEsGUtqKm+f9Ngn3FnMaEKnEHTJ
 2lz1XEza6ajCGR0tmL6lULyKTEFU0WtDaOlsbiOn/8AaOW4wd3ckHo1
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMCBTYWx0ZWRfX/OyK7GQeF2st
 Qx3UJPxcyuE+82CONet7PsOO6a1ilvFfYCzDM5vSRSqTJ1g1UxTNGHVewJ/Qklc9IK6KtKpt1AN
 iqfLdVRQTA0SjoWN3ZVRDxAo+SRak6IA7nJf+rgN1EQ6peRS/65Kw/VwP+E2tmyKtk+77W8fOhp
 9gxMiXKX/IcQFQd1yqH4UxH0+drG/CfBA7kLzqMbowJ3v8pYo/ACRx5Dkk//YZEy48LRdLFyILO
 nwvHVAUSZ6ojntvft/8BRQX0FdKteiXr2fXJcIsR8GFT0Sw2mRKTUZC7QdSlk8ahyfPw6tIdmu8
 VQPcV/uh3gGbhY0xUeFDolUgFMwkrw0vGrXJe4IYA/SnOR5jdvidXhipdaY316H26z7EfOWjDoF
 dyYOwaJeUy5kIHPuyy5/eliV6szQaw==
X-Authority-Analysis: v=2.4 cv=KqFAGGWN c=1 sm=1 tr=0 ts=68f9b5d0 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=-GldTGkhEULYXnHVInEA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: T11oEd7jh_JIWiSX7KeyYXf_iEfVxf-p
X-Proofpoint-ORIG-GUID: T11oEd7jh_JIWiSX7KeyYXf_iEfVxf-p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180020

Add the ID for the Qualcomm SM8850 SoC which represents the Kaanapali
platform.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 include/dt-bindings/arm/qcom,ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
index cb8ce53146f0..19598ed4679e 100644
--- a/include/dt-bindings/arm/qcom,ids.h
+++ b/include/dt-bindings/arm/qcom,ids.h
@@ -286,6 +286,7 @@
 #define QCOM_ID_IPQ5424			651
 #define QCOM_ID_QCM6690			657
 #define QCOM_ID_QCS6690			658
+#define QCOM_ID_SM8850			660
 #define QCOM_ID_IPQ5404			671
 #define QCOM_ID_QCS9100			667
 #define QCOM_ID_QCS8300			674

-- 
2.25.1


