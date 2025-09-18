Return-Path: <linux-kernel+bounces-822911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B078B84F4B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 16:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 928183B7916
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 14:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE046230BCC;
	Thu, 18 Sep 2025 14:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OR1qvIEf"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B045212566
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 14:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758204259; cv=none; b=U+rKZCmch3SXfEpbSCMBQkA3VdwQA9aOGBsFTX3IH8H5/GMnyvfCcKHo+EHCvaQCXE8r1ODggDLpYBd2go2CciO6B3nXNI7M03KPSCZNalKYcIcz/RKswZ8kQwzli37Ne3Dlh9HbzTphcXIppjV3VaAMwRPJBO4bCJxHRJAwJLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758204259; c=relaxed/simple;
	bh=QJCrq9EVKnqtcGSGyMsia6+ZNN3uVWUCcTfFO8R7JlI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oaj/My4G4HyShzySgwNFKIW0Geabc+wdyl7AnRjLeXL79o1J5PgF+adzRtsRdglyT2Ymqd6qKhK3KtbcABDtnwEZ7W2c28/5Mc0cxv1ICZ5WZ7WBglSO0HX6HUSvq7T+XoryML8fDiZ6bmNa9A3DJFVKZjr60xlllUOsQtdTo6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OR1qvIEf; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I8B7ct007410
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 14:04:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=hCe2ZbZE5TuBVNf+FdOD2ubfL6oSGqfUPA2
	MUMjFgRE=; b=OR1qvIEf+OaL8NOWmRXRZtGkuCd7/FL97sgR6ef1cfSgNTpYn4+
	Tnv05xS0cKWk1hbBmUxiRlCZxYU7MT2N3D7PT26tc9UVb8a6qwZWYh7sWItZiTJV
	knbFr6jwNXpAJ27D0lnRtYRya9R9y1g+5xXNzbLO9hc9qncyA6+FvtKAZvHSzWOV
	g6s+VaXf5eQkfVbUEU+6Hpe70GCnLHp4oJSzoc/jSVWOxJREPB4KN9r3bHi/kMJv
	8iV0W5nuHGWETC+rDHqBESKdgoZXmz16zSCxJIRRK2Vuu5aWOfOXevCs5pf0zLwU
	a2as9UnluFRMLNkw28z/JUiRIKNblcUMNyg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 498ebes44q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 14:04:15 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b55118e2d01so206299a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:04:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758204254; x=1758809054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hCe2ZbZE5TuBVNf+FdOD2ubfL6oSGqfUPA2MUMjFgRE=;
        b=a8bhmfbBCZoVNmKeG7Y1Bu7b1Ol14p7KEXupmHpgOmrV+XKW+KGr0v5+exgbMK1RP0
         gC6hrVB0Q3ZpOAZ90w31eX8G4ZFflFYwQsHZizy4JQ7rydXU8jQ0N24rk88/ruvDWScB
         aCwWtMzCGYrgbTjxZcOzLIV26fKM37g+wO6lwwmUJbzYyvB/3ktDjuhQzazcD93E/djb
         FmaFGR79qdJtA4fWECXkDkoByBO85qyooMFpDD8wgPBSqR2maqRuBZtCch9qGw6OzPEA
         2vatMvNn4/j6Jx43kSi8f4agLkFYJYaBEE9H+vk6CFw30GAKwuRt3rqCfhqUhRrMJs8R
         nKmA==
X-Forwarded-Encrypted: i=1; AJvYcCV3drwEHwV+iu/2UwDus36xE0al5/pDXI00OqSHHVnsOIKyqGQdt26zrvXzgWSjmVQ0T7hio+hXiKnYaO4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8kmH15WapJbOorOdhcTbWxqPUIXjBlpZ3PWE8cpW+IYPElvnv
	TYZ/3YMHEUq99HIYGveFAZB6djp2mQgQhXZ3wFIUfElD2CUfdmNu4VzyvKE0c+CdFG190PsG1Ss
	dhKrt/uOSj3FfXa2Ar6JDDZ4fjcxLn1YDV3XGXrF406WUtb5oQ7J9JC3iMQ2hsqkfnhQ=
X-Gm-Gg: ASbGnct/MmUzDLM7Eso6GZ3Yt3lFcy2P7N9ot4+QJK3GIZ6UCg7qIzN62CtL6p6qni+
	tqx6wthL2F2H8q4GDVHGa+8SUIR0cb7lnUC2jk/mvgZhP9kFtD8Ita0N4dpM2GRNIhiEHpEA60w
	I6Jkd6cMnPVOUdv+Cb27rSagF9x7H07RPhqsZnf2EpqShsswebsI9jcS+LWRwmMhd1xX/WrgFxv
	mpMfJzvbSOP7he7cLD2INF7kxejIS8fyCuNezcdDiFmHM8btoisC65F4SMl7bhcMsgjvnlw8G7m
	pUMzFom9Pqkz86SNh7I/jyJH0P6S/xrVo9FI/G/USfL0rL5kJd0prQvYuMn89lm3WU20k6e42QR
	xuvZEjZnl4czF8Cjribuu8ez+HUy7hx/azuRh68btUZpvovW/09mYdT22FAdx
X-Received: by 2002:a17:90b:4b49:b0:32e:87fa:d96a with SMTP id 98e67ed59e1d1-32ee3f20aaamr6825861a91.26.1758204254158;
        Thu, 18 Sep 2025 07:04:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGENvX6pNCbs5T3xIr2t/OTES0Nse0RZmu4cE4kFv/Rf1wD33TIz25khTZjTYD5A34y0lVUTA==
X-Received: by 2002:a17:90b:4b49:b0:32e:87fa:d96a with SMTP id 98e67ed59e1d1-32ee3f20aaamr6825805a91.26.1758204253549;
        Thu, 18 Sep 2025 07:04:13 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32ed27612b3sm5624894a91.22.2025.09.18.07.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 07:04:13 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
To: tglx@linutronix.de, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, andersson@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: interrupt-controller: qcom,pdc: Document Glymur PDC
Date: Thu, 18 Sep 2025 19:32:49 +0530
Message-Id: <20250918140249.2497794-1-pankaj.patil@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: OIEF-V7o19psLPNdjfcq-dunwwIofTyW
X-Authority-Analysis: v=2.4 cv=H6/bw/Yi c=1 sm=1 tr=0 ts=68cc115f cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=9VwqXn3BcVUWGglbYxcA:9
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: OIEF-V7o19psLPNdjfcq-dunwwIofTyW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE4MDA3NCBTYWx0ZWRfXyxhUZdTJZSS3
 ae0YBwUlNTxix8avHHlogZmXezvwd66PQUOgIJ31A+zNEesX/wvjP0ngKBtrcZXlQ12O/694XaV
 KNWVchWxe2QiNOmv+hq2UOccZk+kU9N9KBgVLMKkpaAIHI6OJFlRaBEz4JH+i+veK7m6xjY653V
 sA3mhLxTW+bip9DSScuGBe7JvwEOpqR6C4l6dG/idz2v291y3uV0w4YpTtE30J1RjEERUqQgLB/
 g6V28x1VxmyXw7h0J0wVosnTrcKszJuhf/y7QNN8tu6FNLh0gCH7z3gRfgZ3ZJqDRdHRcxlIfdv
 EdETSJ/qHiHG4tZyGbA+SA3cKLE/yiTYkW/4UDYs5CLMBjUzPLtjxTrtQmhIC7OUinjHS2Av8n3
 6NcsgskW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509180074

Document compatible for the Power Domain Controller(PDC)
block on Glymur.PDC acts as interrupt controller in
SoC states where GIC is non-operational.

Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
---
 .../devicetree/bindings/interrupt-controller/qcom,pdc.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
index f06b40f88778..38d0c2d57dd6 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
@@ -26,6 +26,7 @@ properties:
   compatible:
     items:
       - enum:
+          - qcom,glymur-pdc
           - qcom,qcs615-pdc
           - qcom,qcs8300-pdc
           - qcom,qdu1000-pdc
-- 
2.34.1


