Return-Path: <linux-kernel+bounces-737159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC04FB0A898
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 18:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98796A84580
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jul 2025 16:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3814E2E6D08;
	Fri, 18 Jul 2025 16:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LQTN3Eu4"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237DF1C863B
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 16:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752856664; cv=none; b=VgqiXAQcDh9upa38f4EU/xm7w/raHN3kWEaZur1kTtbQaxYFpHtWsXbrKAX6xT6q3247iDroWaL4d+A2b0DgBhQTDggW7KMAS7gBsZhKNu7gY4uOA4TOcPNQT5XVHydDEu+B0Te7l4LqyCtKj5PpywLWATd7VgVaTpUU+WrUYUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752856664; c=relaxed/simple;
	bh=gmfr46OFYmUccWZSBc7IaVgajR2Vt394m5Ncm1zzRZI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U54n0kcwgN98JchVFMS3gKon2qIPGwo4io+kEU+Piwi9mG2B0CCURaBTHIq17jwM6h9IAzvGFyVOxhOoqqQ8KqSQFQHQ1cpXnTDqmcD1O1eCH7Wb7G013BUqjdzOzxWvH00dqYx6hd/sp+edlaqUiy1pTou6DMm0/cgzl5Wtfg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LQTN3Eu4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56I8NjLR008518
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 16:37:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GyGX0yCNyB/fJpepU8CmcL0R5Xf5NuixqQQS52Ar6fE=; b=LQTN3Eu4FoyTKj3e
	pR5PMtaGCqha8gKjJVV/Gwwk9cnsGI5dLZPpSDaQPLi0Vhoh3lHiVZd6uhKybHOu
	qT7iVSelDoOi9gUzEgfLH8liFZFv2tyZGrDA7G0sorhDVM5u5ea2I8mfXcj40/42
	0eaLlMFGev+oyslpBUESeUV9n4JtQL3N8+1CmTUoJnbjKioDo0Pldl3w+RPyvLOU
	Kt211uds2/+zEvs+4LpjTv2nMgcu/ilWVoWkcx4vkcjly6Xo2NHDX8uanHvAZkLE
	Wl/asb6LFk0Uk8XkTBX5mB31VX/id5rJBwfP0gFlU96fnXs9yDuVtRC3EURfJsbB
	Jc5WBQ==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47ufxbc9yt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 16:37:42 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-87edf585bf9so2650887241.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Jul 2025 09:37:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752856661; x=1753461461;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GyGX0yCNyB/fJpepU8CmcL0R5Xf5NuixqQQS52Ar6fE=;
        b=Kw9ZKH9WoM052VJ1+QvDg1lpBz0IjMLyRbVK2ppHt12gC9aBUEp4DKPzazY2MGOWi1
         z78RiafVF2xRJj+Ul+EnNgEbPWP1r4TeFfjnlTXbCoD5ELSYJwDRqY6vY7OyG2mc4MLX
         uuJz8ZsunZBPWDnOvRmUrv/tyEA2QLmgusD28r749+S517yhm+j4oVjL/Sk5+HH4aV4y
         IuloSAoRK6fC8Y05FS7aKP4G3XxG6367CU0qpLdVOmWNoGAOy7EkwaPpb4tRVpb7Y3a7
         InYR0gvG+MEMJitvqhXgHmGWqvDqWwapOJEw8ZCr8mnoVjFB9KebIkGWG67XjPwpX644
         HGmw==
X-Forwarded-Encrypted: i=1; AJvYcCU0XX+65vWNgAxRz5H03mbJ5otCq3jmIFivtMji/R8RRck8m8OQBmjZB2gb9biuM8rFlWpljd8AI+buTcM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6Rx2FHrSXAHijBoMGc3hdaZhkCS4e/jNOegZNmFZAqtsleO6+
	3a4KN3K7v99EG6B5XCeExxKJ7jGzv1gdH8zsyBmiw859jjlEGVZXfB3oeWYIVnnekyW3a2+MG0g
	jXvR7JHLwsjCkOR/9J5rsEyIXgOol9JImyvAlsRrCNJAEC4ATBNGEcuLoQ2oqlG35wDA=
X-Gm-Gg: ASbGncuoiXvR4vO2acEPRcUfxrNIyU5TV8L9cQj/irl5MEH9wR6jd/W/EZO5HVeMkR5
	lYvi82E2qsPZZSgemHrlPHBZaAb38ZY1zFWJ5T381qbum+wCgP1kWqAugjlpvXQ6A9n8tdKLvWl
	9UNmcN3bF/E+v8NSxg628KNvtBK8+IpjCEl8ZKsikHCJYn0xyIDirhlpxsM/08pNMRoP47HqsRQ
	e0CjHkq8qY+Ke5be+f+uFeS0DYDzxl1MlhTA8MA3V9kDWzA862opX+FJihh3ew168/QS24pMaan
	H2Ikzfkm0uk03/PREk0AcQ2zRRGbE0fjW07RRHHW8K+vvuW9aYwfKth4dLzvfiIGQ7cwlKRqJpP
	3o9e8Du85daikEBOuRdP1jc9Db7OVXoSk4fSfZPX5VmJsOcNoYKTh
X-Received: by 2002:a05:620a:4111:b0:7d4:5db0:5b95 with SMTP id af79cd13be357-7e342b9c9d9mr1695736485a.58.1752855239290;
        Fri, 18 Jul 2025 09:13:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEF5+LPdchdvDPtfa1f7zPMhgf1TwpIBYaXASh9HQnX2GtnD+tloD0jFjFD+zpI1ErW5YaIgg==
X-Received: by 2002:a05:620a:4111:b0:7d4:5db0:5b95 with SMTP id af79cd13be357-7e342b9c9d9mr1695731985a.58.1752855238785;
        Fri, 18 Jul 2025 09:13:58 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-330a91c1ab7sm2388131fa.50.2025.07.18.09.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 09:13:57 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 18 Jul 2025 19:13:46 +0300
Subject: [PATCH DO NOT MERGE 8/8] dt-bindings: power: qcom,rpmhpd: drop
 duplicate defines
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250718-rework-rpmhpd-rpmpd-v1-8-eedca108e540@oss.qualcomm.com>
References: <20250718-rework-rpmhpd-rpmpd-v1-0-eedca108e540@oss.qualcomm.com>
In-Reply-To: <20250718-rework-rpmhpd-rpmpd-v1-0-eedca108e540@oss.qualcomm.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2189;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=gmfr46OFYmUccWZSBc7IaVgajR2Vt394m5Ncm1zzRZI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoenK4Ky2laV+OIQFpLhQXvV3YcdhKqF4v3szYM
 L9s+c2reICJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaHpyuAAKCRCLPIo+Aiko
 1TFkB/9zASb2ttqh4bUFeLr7tB6UPx+zGOKm5Ru0OqSNEZ4peWOE+CyEuXuLPlrnvrfqaSBc9Xy
 UKYbqiqaYolNJ6zGX6WYpRw5Il73+W1GbOG7remVMF0EcnsLxEWZ1NnS/mcYJ8ayu9C2ZlEdc6S
 B98tNfPuHTmNR98CKd9AceXSoztM3VTaGTKQ0OvBbdrFt+hLg/IaE/+GtrZFfTw624cGDyMH6Vj
 qzjpibaFgupAuzA1ZmtudzlnszBzvkA7/7PPVLdBmCdeNbJ5Zx1Q5VGbh3BgVD7OR7fbjiS4GfO
 BDKDeHj1ZRpF6mEaVuZg+6HydBzIFpSMy/IVMqgnrAZM9h/j
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: wXsgee2SJqu4knjgCTWF1A5QnoUB0kYP
X-Proofpoint-ORIG-GUID: wXsgee2SJqu4knjgCTWF1A5QnoUB0kYP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDEzMCBTYWx0ZWRfX+3LRXyTL1RYs
 LwbSEFAaAkLLa4Gfo84Sb6aQY4QXgkZJ9kDa7AW38C7Zk9NRd2xaKOtq9xxtjUio5vgdrdpayjO
 ptySWwY5m07kZsjV1a2C3MnS9k1aiFUuiHigHkWRS+NXYftqmtsMxjn2jcCJm/ZxwdJQicWZdXG
 PJB4dGk6NQCusVQMXBSZOwGiVX9V7hPB1DgQXS2Ej44Iz5A8tVtEdLu5c96phg0MVdEb40b5s8a
 anUZ35yzBIsBVBJWTSI5zgkDtowF4G3PR/6fCHP/01kR3FtgbbRTXNhv6SXeLhwg+Byzew66hXj
 dvBV/OYIGo5M92n0srfSFZ94njU+NQeAyw1mVCy6kso/BRsSEZjeCDO6dRfHx8tNUevb6Y1pbCk
 oQbvGzzKsVGXiL5yb5M/UU+UAT+puG8cUKcx6JhjCqjWxYgMGmeRo0BsZScypcLjn1pwWf+n
X-Authority-Analysis: v=2.4 cv=Xc2JzJ55 c=1 sm=1 tr=0 ts=687a7856 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=Ucwj6ZyNMwC4X40j0pUA:9 a=QEXdDO2ut3YA:10
 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_03,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 mlxscore=0 priorityscore=1501 adultscore=0 mlxlogscore=490
 phishscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180130

In order to prevent further confusion, drop SoC-specific defines for
power domain indices for platforms which were converted to use
RPMHPD_foo indices.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 include/dt-bindings/power/qcom,rpmhpd.h | 58 ---------------------------------
 1 file changed, 58 deletions(-)

diff --git a/include/dt-bindings/power/qcom,rpmhpd.h b/include/dt-bindings/power/qcom,rpmhpd.h
index 73cceb88953f705106486b7e111b3ffc39c85664..ccf47b4670d905b166a9a39badc3535c8f9a05bf 100644
--- a/include/dt-bindings/power/qcom,rpmhpd.h
+++ b/include/dt-bindings/power/qcom,rpmhpd.h
@@ -146,64 +146,6 @@
 #define SA8155P_MX	SM8150_MX
 #define SA8155P_MX_AO	SM8150_MX_AO
 
-/* SM8250 Power Domain Indexes */
-#define SM8250_CX	0
-#define SM8250_CX_AO	1
-#define SM8250_EBI	2
-#define SM8250_GFX	3
-#define SM8250_LCX	4
-#define SM8250_LMX	5
-#define SM8250_MMCX	6
-#define SM8250_MMCX_AO	7
-#define SM8250_MX	8
-#define SM8250_MX_AO	9
-
-/* SM8350 Power Domain Indexes */
-#define SM8350_CX	0
-#define SM8350_CX_AO	1
-#define SM8350_EBI	2
-#define SM8350_GFX	3
-#define SM8350_LCX	4
-#define SM8350_LMX	5
-#define SM8350_MMCX	6
-#define SM8350_MMCX_AO	7
-#define SM8350_MX	8
-#define SM8350_MX_AO	9
-#define SM8350_MXC	10
-#define SM8350_MXC_AO	11
-#define SM8350_MSS	12
-
-/* SM8450 Power Domain Indexes */
-#define SM8450_CX	0
-#define SM8450_CX_AO	1
-#define SM8450_EBI	2
-#define SM8450_GFX	3
-#define SM8450_LCX	4
-#define SM8450_LMX	5
-#define SM8450_MMCX	6
-#define SM8450_MMCX_AO	7
-#define SM8450_MX	8
-#define SM8450_MX_AO	9
-#define SM8450_MXC	10
-#define SM8450_MXC_AO	11
-#define SM8450_MSS	12
-
-/* SM8550 Power Domain Indexes */
-#define SM8550_CX	0
-#define SM8550_CX_AO	1
-#define SM8550_EBI	2
-#define SM8550_GFX	3
-#define SM8550_LCX	4
-#define SM8550_LMX	5
-#define SM8550_MMCX	6
-#define SM8550_MMCX_AO	7
-#define SM8550_MX	8
-#define SM8550_MX_AO	9
-#define SM8550_MXC	10
-#define SM8550_MXC_AO	11
-#define SM8550_MSS	12
-#define SM8550_NSP	13
-
 /* QDU1000/QRU1000 Power Domain Indexes */
 #define QDU1000_EBI	0
 #define QDU1000_MSS	1

-- 
2.39.5


