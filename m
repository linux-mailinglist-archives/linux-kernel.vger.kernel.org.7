Return-Path: <linux-kernel+bounces-825686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCC6B8C850
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 14:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4C3C621E49
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 12:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3932F5301;
	Sat, 20 Sep 2025 12:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VJuF/4PD"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2DC2C327A
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 12:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758371815; cv=none; b=HDbP6WTCarJMxdWd2vmIJSp9I77tdP3tfXoTTDbRpy0dO2eKTqWhmiwcWxCmxP/qY6xezl9y21FxXoBPggLcod6kIjCu4boU/SxAm+8ydowuQ0zNhJiAn9BDWSveMzgDtC8mfkQt9NYivSEg/jdWIx0zoezgWf+hZEmhvemBLKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758371815; c=relaxed/simple;
	bh=NlAyY6gwj3GgebzwwaWrY6Q6kn6D5Bsn1jK4HrmHOC0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=F5fSgdwi381ntu9JeLKbqMaqmKjo5j3LG3CBoKYn6sFVK+8HZ0N1792jGUBgaoHbXRxfLd7lXzBGsIY+oLQx2DC4bX8UbzOk9NbkpqMAHwgnyeiFxLn1yOOgUtXifngowWnIwmEZrchydgcEF6JUxvgTfEELoyyCgIRDkaOZHKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VJuF/4PD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58K3FYAW019489
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 12:36:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=kQEsxxv9s/GhWRr7hiHaTvJE9W1ROnl+URj
	6ByZUdys=; b=VJuF/4PD18F/7WIjaN88QgYYik45597UonMuLRqhx29D+ZdW5Xv
	9u2rMCS0bi/iJYIrBQftBA+DGrMYviAN/PgsASh6O041JQ7OlWDo00Z3QjjSjHqy
	dAL6xl4C6SHiMWDFdqeazvSEUkB/G8QqQ3CrCeKmxKA32Wn4MN9RWBLI3KjjyTmY
	jlrMHgkhiStxPwpguJbQ9oX65mi7noXHNt/6vskAbwMaSpAEnVAQ1NDw5OtUqfPK
	+njqbmzuEIS1caUVDDLhI0r+SjwxO5nv8oLPpTHHJ0mFJWr5hmR1fSf1T4u1Epc/
	s6OP1tvt/ksly1O6O7tgeAkqUKeU+nm76qg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hyegxe3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 12:36:51 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-77dff701fb8so1771607b3a.1
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 05:36:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758371810; x=1758976610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kQEsxxv9s/GhWRr7hiHaTvJE9W1ROnl+URj6ByZUdys=;
        b=ogVuU4jYjv/1YCjzDISi3php2vvgzpu8Rs3Vc6x+jntawPlQ08GEP7O7ypzeFjv8QL
         JufAvwuRRuE9axuzOCl6++DQgFTbyT/Ntv3gS+nhhiUgKCW2R/hJVknNLZh1cNjvzpNx
         K1ZODRONt52ZFO/pdiU8wB3HtLJegXaRb9FHvFQ7ur/qXZTggYIvZClTnSs0tM5oF/iH
         CEEkZYfm+kB5nT/x7HCvhJRjCA/vzv+W0g9toxnW/P/O3fvT8IGf400x3aH37zRX01tj
         yD3L6njJbryyrCknMXZGPMByGbacFpGTEC1kq++oGnO/qTakIHdOuwpszoi5DOfnd5Rx
         O07w==
X-Forwarded-Encrypted: i=1; AJvYcCWy/7C7XdHWEsR29V0u9E7+knAeQZG491WoGI/HosCN1ozUaibTeH3EZ7CIt0suYqLBIuRwR81aiHSQjZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMo18O7uKIRIpZ9BVShGfIeqwsD9dpLfWnN41E7J5fqwxcS3cS
	U0+KVI5B8gjqj89geTQTmASWLk5USU2MaQ7LrJI6DEcqVT/XbTe/CIkbM87vsXgJfY2v59IH9ss
	Wdsg1hf3StZ3/uJdWeY7ayHPsqzG2edhEEiAkuPLTM4pZYSL/Ffx8PjLJMmsHo8l/8Ws=
X-Gm-Gg: ASbGncvgzXqS0giBIRhMqdBBQZEn+sFoViYolHkeWPBHyo5+H5kb+Zlr5p+XgRRivDj
	u2HL0NUEvADrVWthK4/WNiihI6zxgAUGvbhqV49ZuSlTmndTP1uMczOWAzrd4DqjTgTKibdGjhL
	OFxPoI14YRGdgfHhBXZdUmRWP0X3ZWW+VFULVA4BF2gXWd2hxtxyeN+Z1fOaB85QC1IChlknoUH
	DsFyRRj1c29lGK63Ck+SfwOoFX+4651eDbCPAo6C8y9oVXXTW9N0YcKx8CqxOWjN7G0IsNlzWQT
	9cpGtLd6UcqeU5sbhhWBUhGHCDS9l+XoOrXN06X4tZpBPl9EkOUtiNwCG+bFaTYsUmIR0aqoVd6
	fpUqahrrMjbjwB5FCnenCds7yGdyJlPyodSkO9TVuYyqKKo2OhtJtLMIXtxlC
X-Received: by 2002:a05:6a00:1889:b0:77e:325b:f614 with SMTP id d2e1a72fcca58-77e4d21fd65mr8295127b3a.12.1758371810349;
        Sat, 20 Sep 2025 05:36:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgWzB5nkqqfDCZX9CuCLhkrbY8TKa9vwIXS5YrzuVH3x6awEHxf0i/Xsr/JFw/xJ+CoTCA+A==
X-Received: by 2002:a05:6a00:1889:b0:77e:325b:f614 with SMTP id d2e1a72fcca58-77e4d21fd65mr8295094b3a.12.1758371809932;
        Sat, 20 Sep 2025 05:36:49 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77f1550f70asm2911274b3a.13.2025.09.20.05.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 05:36:49 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
To: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: thermal: qcom-tsens: Document the Glymur temperature Sensor
Date: Sat, 20 Sep 2025 18:06:31 +0530
Message-Id: <20250920123631.281153-1-pankaj.patil@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: EWlEDsTxf9aUHrGrgIqXfSrB5Kn5rYjM
X-Authority-Analysis: v=2.4 cv=YMOfyQGx c=1 sm=1 tr=0 ts=68ce9fe3 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=8GdNKlHnjaA04NifdkAA:9
 a=OpyuDcXvxspvyRM73sMx:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwNCBTYWx0ZWRfX5eq+mpaNXYUb
 my7s1E58Nl/xwxiFfOlE2XcAn90c2luoznAQTMwJ1q1G5tUnVD2mMvhSvh4MhPyOGJjGEt73nv3
 Oc00oZezimt1/tXGoa7JbrjGlYVMgUlSMYQAbSKXlFi0PAa44o+BLBfwfSktfKCqbC9WAr2s49a
 bsVe4YwHlpxt1uKvgNStd4Irz10W6+RSVJIupRufHo+tjHI9cLd3D/mR8DbZkLl8PUU/0+HsBHs
 p1ALrt5cVtu3M5B/y/d0ubg4U57UZ9TnH7ELo9NsSM3tm3NyjSOPEMLpuWNO7wvkyJudc2s/oYo
 2K3qDWqtCJPFWAUEiLDJgR6NpxN077w+/2oni7fApFRXzus5t+sCO1m8bflY9v7MYn/upgJKBuI
 660Rw7yA
X-Proofpoint-ORIG-GUID: EWlEDsTxf9aUHrGrgIqXfSrB5Kn5rYjM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-20_04,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200004

From: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>

Document the Temperature Sensor (TSENS) on Glymur Platform.

Signed-off-by: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
---
Changes in v2:
Fixed to sort entry in alphabetical order.

 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index f65dc829574c..78e2f6573b96 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -49,6 +49,7 @@ properties:
       - description: v2 of TSENS
         items:
           - enum:
+              - qcom,glymur-tsens
               - qcom,milos-tsens
               - qcom,msm8953-tsens
               - qcom,msm8996-tsens
-- 
2.34.1


