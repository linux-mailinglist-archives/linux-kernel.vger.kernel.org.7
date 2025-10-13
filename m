Return-Path: <linux-kernel+bounces-849926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B99BD158A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 05:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28EB63A7788
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 03:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C9E8274B2B;
	Mon, 13 Oct 2025 03:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OsiHS6h/"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC091274B42
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 03:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760327972; cv=none; b=fz4RhhS17+waJEztTJtLEj1AdUBfuCU1tsr2Q7045M2xUCjyzLlEkRkR0HkOr2h/0keBFikwTwaBCjOB68DgN08tx1UlvOspnDe21j981YLAHzQVM+Yl1oLJoHfQe/9KjKVWqrY8HKlMAIvgTFCxhyXxUiTHamtqOMfH6MXMVcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760327972; c=relaxed/simple;
	bh=4s97OXsE4t41H2WY4gfLk660rhvi503He0pOltw2Gjw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Sb8iA0CJnY3ml4L4i7bJ6Px4CaPVeFjmXSnJ2tPvC4ZrmTtX//AZ1ib/Xj8mjSQn/AEcepfLqBcS07VX00Ul3LIaYTtJw7QGGyuilBeYcoOAtZvtu0A7GBI17iwvHXVDwjGxhcw6xq4srC0cnXCy7dW/NHo9UVtE1zAJT6edhQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OsiHS6h/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59D2nE1P017738
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 03:59:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=RMNDKKR886AjMuufIuUKdsSR0GOZWJ31sPM
	ac5ueuzg=; b=OsiHS6h/PXetzJ68Vfd9KrL4bPcXsezkfZvFDHjSke8nPXovoLs
	5NYN1nzjyGwUiXfHvaGbSBOPB6jswbuVxAnRGFpfa22wPFFX0htfrKNS4gZ4+XM9
	PmwyX1RGR/HwnfHD6jyhHe0g4tbs0SQARIC0VXaugmoQDOrcyUOPyrcar8tafBKY
	t2WuEJ+MzNXR7QCh+1BfMFQC8bLMWQ+odcrLPTSI7/f43HlgVBVMx+RR1IjzkbuI
	19lCun8l1FUssEUoHq9KeyLTiURdP6Bua6GMZM1x228w7+8nlfFVxRFc1hJoYfhM
	OcH5AFCCtU5cisdBb6KDljlDs85DTgqBvFw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49qfdk34rh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 03:59:29 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-27eeb9730d9so83242865ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 20:59:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760327968; x=1760932768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RMNDKKR886AjMuufIuUKdsSR0GOZWJ31sPMac5ueuzg=;
        b=lV3UdxkCEifXtII4AGqE6jNboxuGjcIwobfFsZ75tKobMYkp1DvB7Gyy6yvmifMDFe
         L6o9RshDw8jVqjEd5kQj7F3CBXHT8KnZvZTednWjaZrVgEbsdkdhEQB0YTWJm5yvJMC6
         ZuUDDHrCr5OwPwq7bMfsvPAPdGtYxDwx9CsicGrY8iLRy6yI7VBJNFhqzZkRLmr30Lbu
         8PQg/pmkUpt1MyLZoPJRfD+50/FBdf/brDQboa84T7DmEM9vCxY/wQXApjDpO0+As2s9
         x+lnawxVECgKCsv4Y6agdf5hrCKoRFjAhcaKudmWkavdqnOMj/2ZA+ZAAYO0+z3HKgsL
         II4w==
X-Forwarded-Encrypted: i=1; AJvYcCXPi0nT688HmY4sfBiLXxhE3fWN3doVcAe7A/2fxxP9fjXHQKxey3hJ26yRyugcR/WA3fwz9F8UHbqO6oQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqzMFK7xH87qOA/nXMGhpiTBN7M03xK6YGxbD6mpwkMAAbfzTE
	lkHRh/2kwiZt4FR9B02comhFX8cQcbzfwy2Jel945CqSlonIw6KGnPGsGiP7jbvbfOrC4KQISBU
	miw5/tEgLFuA57Fe7lGM6imtCkxKHGDh6dyiQvCE/sm0FHwvFAzSVvvgHE/h8SbzM/k4=
X-Gm-Gg: ASbGncuBhgbT4ulfraPGkXxdqUuo2MbTKFUbycaxVRzGacRLtU2BA2xFINSdfUsz7d4
	6QVG9EiABbKPi04SJ/FQYGMtfvZ+cMAlTla2DeHX0lhgIrbUPodR4RwwTtjLgcojsq0GYyMf8uT
	xnwKfSQTevO8+Ji6uExgUif/Xy8Xp+Mfd4JqrksAyhUZHMDeA+BaOWk8N0ZoMPswJTHOw3Ui3x0
	OFhydJxijqrmvn7GZ6m1hUDNQiseYnQ4IbSW2OzsLPmFOdZapEyDzPy9Lt/t+lP2Z6quaDnvkU7
	cjFcCywhQ7/BXFJvJ0bycLoFonbjHCfXl72bKnxKtx05PX3yVubuM9glcfcJSuXKY5C059+1Jc8
	VMg==
X-Received: by 2002:a17:903:40cc:b0:26e:d0aa:7690 with SMTP id d9443c01a7336-29027402c79mr221611295ad.41.1760327968204;
        Sun, 12 Oct 2025 20:59:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHVGLZBxpNB4H/Xm0MJmTnYuQju81RnfMPIBs8IrHHp9PZ9c6HxbnrwU84W6QcEl3NEorCEA==
X-Received: by 2002:a17:903:40cc:b0:26e:d0aa:7690 with SMTP id d9443c01a7336-29027402c79mr221611125ad.41.1760327967714;
        Sun, 12 Oct 2025 20:59:27 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034de54c7sm120732305ad.10.2025.10.12.20.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 20:59:27 -0700 (PDT)
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        stable@vger.kernel.org
Subject: [PATCH v2] dt-bindings: usb: qcom,snps-dwc3: Fix bindings for X1E80100
Date: Mon, 13 Oct 2025 09:29:20 +0530
Message-Id: <20251013035920.806485-1-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: NVzlDhbXNpms_u0zDh8H-jGYlLTM70eR
X-Authority-Analysis: v=2.4 cv=MrNfKmae c=1 sm=1 tr=0 ts=68ec7921 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=ojRqNddluEt3zInEAqUA:9
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-GUID: NVzlDhbXNpms_u0zDh8H-jGYlLTM70eR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxOCBTYWx0ZWRfXwDg7aFXDl3z2
 6TeoJ/KwfhViZSRzg3Q0Fj+2l/YZG4ASpjbMkKZvWd52h6HOUOdzKAqr4aKdl7sh7UL35As0yFL
 DTiaxZek1gDrS57pkB12yIqRY1MFoQQMliL9etGVe5Ag93mWzWN1irTSZ6H3eMaDoThHpB+/0Tm
 Luy9KLkc5FmNGTKPS8XDVmg8K39I0YzMphVkKFtpJ3VM2zk/3kzFzfJDeQyrdsoxM4R5/5ndDDS
 a8w5R1mrTlSZryaxO1cCsTXoLhR1ko/+NaLjHGkpDHlsekNR3coHGNW4UL5++oRWWcWcUHQ1Tly
 Mq8VrMPxLDdmo+U4vgJuvR0AZ6H15saF2pnICELmXvcOYlCcefMEdfQT1fGJf9w4oznFpGFJduH
 EOoNXMRevXJMQ/H+X10Ljg1FemXC5g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 adultscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510110018

Add the missing multiport controller binding to target list.

Fix minItems for interrupt-names to avoid the following error on High
Speed controller:

usb@a200000: interrupt-names: ['dwc_usb3', 'pwr_event', 'dp_hs_phy_irq', 'dm_hs_phy_irq'] is too short

Fixes: 6e762f7b8edc ("dt-bindings: usb: Introduce qcom,snps-dwc3")
Cc: stable@vger.kernel.org
Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
---
Changes in v2:
Added fixes tag and put error log in one line.

Link to v1:
https://lore.kernel.org/all/20251013011357.732151-1-krishna.kurapati@oss.qualcomm.com/

 Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml b/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml
index dfd084ed9024..d49a58d5478f 100644
--- a/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml
+++ b/Documentation/devicetree/bindings/usb/qcom,snps-dwc3.yaml
@@ -68,6 +68,7 @@ properties:
           - qcom,sm8550-dwc3
           - qcom,sm8650-dwc3
           - qcom,x1e80100-dwc3
+          - qcom,x1e80100-dwc3-mp
       - const: qcom,snps-dwc3
 
   reg:
@@ -460,8 +461,10 @@ allOf:
     then:
       properties:
         interrupts:
+          minItems: 4
           maxItems: 5
         interrupt-names:
+          minItems: 4
           items:
             - const: dwc_usb3
             - const: pwr_event
-- 
2.34.1


