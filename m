Return-Path: <linux-kernel+bounces-853645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BC1BDC2FA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 04:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B00A119A130B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 02:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ACEA30C61D;
	Wed, 15 Oct 2025 02:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rqpar8CB"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E1630C365
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 02:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760496208; cv=none; b=SG+IX7Z999eeTPne9FfdVXVzx7nXWPWxdCknJFR6kO5uMtuym4rC6xOJ1hOTR9DVe81mEpWdondYhO4wBN2kpkRqY5ZVqVLa7khw035ZOQS4/nej68YZGHaek0qTTbfgggODirvG8xLduAasu8JcYzRqWpdwxjdYrHJ9byv3qZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760496208; c=relaxed/simple;
	bh=0rVwPwb2voVzOHTKavO0nQGcp9y2IoeMgD6s71JHxRk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=X+guS9xS9UGfcRY07FfpKXQY8Zjc8JYMJtb2XLsRu8ndnykP+b3MlVA9Z1q5+B1NDzfrFIvLfS/eksQrpEd5ePJ0oWPBNMNYCt5xgUJAEqsADL0W+bQRu2DGQlZljYxu+yZ+/nyG9D4Bb7xVLvNwltZ7Gq79SWpJs4vyH3inXzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Rqpar8CB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59F2dY90012200
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 02:43:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=a8Qod7OOqEkFq+EpdIzWVZ
	NCKD/5SirXFq15HIYfIa0=; b=Rqpar8CBotbS2mYoRyKRjxjSXXOw69dFCHbDYK
	1Ag6n+cdgcKt1M4cX9Qq9yOnqfbUPeZ68WbA0CYxk35Pscz4yO1oIBTr5KEnAJ0R
	h1TR7kXPs7gUvCqs797FUfzhVVO58f2CHZ7MOSbtOM0cqPOgNFdzpTmXY6XXPMlL
	Cxou2uR3zUiLDRRJtgBrL8et5zA6Gmz2IJeuAZozxvE/Q1AX8sgURcmQcfVqPEjp
	ZDKxFk4JeMSKUzhit7yywQuEJCIHpFdgodoNbwtSng+AvnAmh4KRKSbddNfiKfOv
	gOjpJoRQmCJOfj6bxJ2pUWS1p1AXrlYLIO8Tfvwmbv228y6Q==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qg0c2r1d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 02:43:25 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-26983c4d708so80966125ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 19:43:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760496204; x=1761101004;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a8Qod7OOqEkFq+EpdIzWVZNCKD/5SirXFq15HIYfIa0=;
        b=VD0aJFV8slbQc50QVn8jdV2e0uNMI66S+JGLr14HGlNN85a65Tze88HvwnWG3aR8te
         yEk26uH2TLe0dSKdWURhWczTlvULj66J6h3RjqR3Xd+pyIGKkPW1YXJOtTfXcKjkDsaQ
         XdiJmeMbozT/VHjQHcHX8qOeQ5xaWWMcRT/VT7UEzPC3HoZOceTXRYqbkC8oQ9M9x5+Q
         cb341kWyN4AIv4m+mTr+F8LQw9zrzj96/N35ZdtjXLU1jsWHKFnWX47wxs4Eeo5a6LKw
         wamKutoDB2iNV8PbQ+Uj8jezGT7xOWeW3dWtfzH6P6Lz1ZpMYdZVB0BoDrk8j+jX6Amf
         18/A==
X-Forwarded-Encrypted: i=1; AJvYcCUC+6vTqyMUzpVQf3Kry4WMqIpkH9wD3nqbqiXJFBYvIxAjCw3ek9xhpLb6MxgzTbaBgQaYQDvv7sFQ/v8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJDSQ9vgpdF81h73qrHdpIgU2PL0c18wBon2bheSIdQxX+fTGl
	Fe+Dsel5vk6dYpcuA2ZuBv9P0CuPnZcWJAlbpEDCrPS3niw64uXrpHCOjLC2zQ84ylfTJ2wfcFR
	zSInyQxn98OQI+5NOjP/aIiHNwmJc8Q+dQ5UhG2pr243mhD1vMFUNvzRp6YNVM1op56g=
X-Gm-Gg: ASbGncuix1IAznkPu8p0yAtCxiChtGJse+UJAOBiSJLr6DZMAd2r1BTjJqEsYuiO/6m
	8tOrWhYZ/sWmJ9tYXQl/J0QMuc+hlN/rKSTHT8a0vux+MsF+m7JcoeezM86EMLFFm2htqvHDMpA
	EKJKF+a2brU/4Xxf3zk1/aE8Ho+nUENaKoALEoIe0pLyh3TLDvPA36WDOALoItpK5WBUvwHnTHg
	VSJeiU9Ol1wT1pm2ZBPRyE0/lViSOWqshiaVOBqShhUct9kuS4OjoCb7tIrtxv+qg7pVkGatLfB
	5tuNXu/y33hupAuXryaJsEVYyjry+ihWyTn6RZxyEPJ7YEkl8ZMg6j2kOJQVpMeGVKSBOMFJ1f4
	IvqwQ2aO5v/4ywTyLRsw=
X-Received: by 2002:a17:903:244c:b0:27e:dc53:d222 with SMTP id d9443c01a7336-290273713c8mr317468515ad.44.1760496204324;
        Tue, 14 Oct 2025 19:43:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE42hE6or4x2HxX7l7lKxe4Bot0TYcL2n/exI1bwf9/Tnqk7dDhc/fzZnCyrUZVLqkIz2RJDQ==
X-Received: by 2002:a17:903:244c:b0:27e:dc53:d222 with SMTP id d9443c01a7336-290273713c8mr317468295ad.44.1760496203842;
        Tue, 14 Oct 2025 19:43:23 -0700 (PDT)
Received: from hu-hangxian-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f366c0sm179219505ad.94.2025.10.14.19.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 19:43:23 -0700 (PDT)
From: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
Date: Tue, 14 Oct 2025 19:43:15 -0700
Subject: [PATCH] media: qcom: camss: Enable setting the rate to
 camnoc_rt_axi clock
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251014-add-new-clock-in-vfe-matching-list-v1-1-0d965ccc8a3a@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAEIK72gC/x3Nyw6CMBBG4Vchs/ZPaJV4eRXDok6nMBEH0xI0I
 by7jctvc85GRbJKoVuzUZZVi85W4Q4N8RhsEGisJt/6zrXOI8QIkw94mvkJNaxJ8AoLj2oDJi0
 LfJceTo7nC5+uVEPvLEm//8m93/cflrJxg3QAAAA=
X-Change-ID: 20251012-add-new-clock-in-vfe-matching-list-25fb1e378c49
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Robert Foss <rfoss@kernel.org>, Andi Shyti <andi.shyti@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Todor Tomov <todor.too@gmail.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: linux-i2c@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org,
        Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-GUID: DhX6KdHSaMzcNuWqTpvcMvltcavhfRXr
X-Proofpoint-ORIG-GUID: DhX6KdHSaMzcNuWqTpvcMvltcavhfRXr
X-Authority-Analysis: v=2.4 cv=eaIwvrEH c=1 sm=1 tr=0 ts=68ef0a4d cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=F0hiWKNqIihWguCrtJ8A:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMiBTYWx0ZWRfX7RDWRQ/QF5Ui
 Pf2N1gkeWC+pW8n0xkGlCMKeKle8jqQiFFzNNcDzc25Ypz/8SbthjaHY1bG6qfXQgqsKxVDqtET
 HPlaCujv4ITuYJqBKv3p1k+TcJw9tO2lGw+6zCxYz3c/SBCFvVncz95ekCtaSW8GENzj/yXbjGk
 hxFzlF0kqUDZII5JDc6u1tRvikRTAcT3rdk6OEW53QjOO4+Wdq25CnAndFH9NT6U/yXc2ZKwhRS
 TZH2xmYVtRUXelmxrbpHrthq8GK8du2yeIQH4YSVtrwau9XOfUZ2VN+IMW6tRC8ZqvkueSPq1yF
 uUMX+Rjxee6mAPe9JCnJJ5UBRuVN1NoJD+QbiNJEYH7HLCilb/U7+/TfVdUi0dUyBA/ARKODCUU
 KzlWsqimWwH9+Bg43L52uE+BAbG52g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 spamscore=0 impostorscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 clxscore=1011 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110022

On hardware architectures where a single CAMNOC module is split into
two, one for each of the real time (RT) and non real time (NRT) modules
within camera sub system, processing VFE output over the AXI bus
requires enabling and setting the appropriate clock rate for the RT
CAMNOC. This change lays the groundwork for supporting such
configurations.

Signed-off-by: Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>
---
This change lays the groundwork for supporting configurations for
hardware architectures that split a single CAMNOC module into real time
(RT) and non real time (NRT).
---
 drivers/media/platform/qcom/camss/camss-vfe.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
index ee08dbbddf88..09b29ba383f1 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -914,7 +914,8 @@ static int vfe_match_clock_names(struct vfe_device *vfe,
 	return (!strcmp(clock->name, vfe_name) ||
 		!strcmp(clock->name, vfe_lite_name) ||
 		!strcmp(clock->name, "vfe_lite") ||
-		!strcmp(clock->name, "camnoc_axi"));
+		!strcmp(clock->name, "camnoc_axi") ||
+		!strcmp(clock->name, "camnoc_rt_axi"));
 }
 
 /*

---
base-commit: 69a67cb382f428c6dd8ba63e44cd2c59cb84f736
change-id: 20251012-add-new-clock-in-vfe-matching-list-25fb1e378c49

Best regards,
-- 
Hangxiang Ma <hangxiang.ma@oss.qualcomm.com>


