Return-Path: <linux-kernel+bounces-869668-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D179C08782
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 02:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00FBB1897EDF
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 00:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D20C216605;
	Sat, 25 Oct 2025 00:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="gIPVC4Is"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA025205AB6
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 00:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761353283; cv=none; b=kNr5QFUuHmtpEWEWCx28DFImXgEPDU3IF9BoCp//TydA/z0UYS4/CSF5etp+bi//fVa2Z7RjQBccPdh5/f9zxUYg6CQA/Mci2WR46NH7E16CZzylJFJUqykbSuC2UlxPXwpmbYSA2eAwfRWiqTJy4/oIRSKrz/gadtmxAhMCWdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761353283; c=relaxed/simple;
	bh=Gc+9GTCwE6Q65glT/UspkMZu20/gwwKg5czwnmi0HQ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LNt8rr116FKLzyRrew63EEiKIWK2r+3cP9Q/GbsKjSIDUGQJ7GzLqdpJUmHu3sxNgqt/BS4yMuIDk5k0ts7Fzy8Ccu8t38dSH4FfLoR4bgCowIV4WXttLn0e8844uxsb0QIYtOil14zhYEkUK4pQIUYpVcEgN69utLNFglrCKJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=gIPVC4Is; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59P0m0Hi013376
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 00:48:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MqQ7CuFg2uQG1J5bdN7Vc0a8C6p4JOXok+RrLgiol44=; b=gIPVC4IstAIeGAZY
	p3EmUYOi5T3klfJuMPlp5Yc1XMa7YbQ7LjFKdBUfgm5YhWsTYuyGhmxIvBAL1VJr
	TgZLhrQ9+zOlgHnfzEIZMkqixMFkZwk40d5r1htH92nD3oPyXTyBgjNgHbu2+2Ht
	T2WpI1LY3iIww9+8xydDJgJV10/SjhQGGWeT410c0Y6cB/kLL3Wop+Gnn+PygSEm
	YtQki+WIRuWKDflsHnNhepxZ7sWYJ6KpTX7sADLRVdoviHyVcQAi1ygJ0mtkVS7E
	yYUMMtdqFDfUkwlWyvVjgTeXwW6Qaj1TdtyjEHWpWZLhReJLmUqIVwD3zs9hZGma
	2wpRvg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49xhe0uk7a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 00:48:00 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b6cedb7bd41so2002594a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 17:48:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761353279; x=1761958079;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MqQ7CuFg2uQG1J5bdN7Vc0a8C6p4JOXok+RrLgiol44=;
        b=GlnOK7ondzQ7+uOW4yjZ5QJEe9YmvkVqKMbcv06C85V+fqtfrKYSv4dvNRzcgoho9m
         WhwvpnMRq0gLKjYrZ1cFhsdp5fjZZcXYL9HbsExXHDWMkWoW3/BznbotEFHcFQAiNzoq
         N1c49Uslvo7R3EWkuS0bqDqPQg2m9yfA09lWHThnsGRFaY+0iCJ6NHMr7GbaO3DvEg/v
         WJbEkGIM2WZXQ91njNCkREnzZG0FfEe2cFEKfvCixNL5WkMVqfr5lOn+6n7gcueA8du3
         WkKpSO00pbxWYSDQS/3CbAvb3cs3LT6ZQF6wkCE8pSb2pgsZnGdA1FWOCqhUzmQVy6Vn
         qDIg==
X-Forwarded-Encrypted: i=1; AJvYcCVL9HL4QKvJGIzPMXSUQ09jwVpMJ8H3suZrJcYZdRzo1kZuwmsc2bU/uxDBztFXz3o9yP/iTz2hjO2qErU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwljjKOjucKGLbfnYDtFQ7vpvfCo7ysSmP2/a1yO1T+AT19b1OX
	VC8gBEkwmoAIDiF1HF0ZUDj2f5200xM5AJN1/O4v8/LpuWHb6yqRc32PFM31DLebxU0TafDlSay
	VeUA9O9ZIVF7lFBqpLGfiAESMyv1OuNQ8ip+g+/0hB8xR0BZSEv+YkmxIBQesOh8RXlE=
X-Gm-Gg: ASbGncu8IAzZtkqf2aWHJQicZgg+vnTPNV6Pge27MWSJ2Qa7NZlqtstn+QoSQ7cK7Ae
	oYHplVs+QKPzMJrCA+FX+Al93ZaU08VpicbIgZHfsekVc8xsDqXiMvb79a0Q3L9MhtDMULocFhJ
	FvlK5G2VnTrok7w5/y3xHWnbPYKTZeTl4dR0qx6Qfczvhq3EuBY9v9TeLxd8matqEPZ29HDLfhz
	4rVvWR4Lsdko8T2FVjfDuQtfPyZ5uPxKlMT81yID3dqPBHAT8mhSAmIp6Wt935/G2OQt7QJj3bn
	ukS4oWhWlM5oqOr6vLngXqgDZBjMwvHzlPzV7Iv8MOo8iqDKciqqWWCyQgLzzEXw5iYT1WlzSdb
	kYrkzpcXS/F0+XFTgKAD4rRH2ll5DQuy031RvONq4JhaS88/XzWk=
X-Received: by 2002:a17:90b:1e12:b0:33e:d66:490d with SMTP id 98e67ed59e1d1-33fd3a598ffmr5633377a91.7.1761353279264;
        Fri, 24 Oct 2025 17:47:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEh+lfmmLQDcK6Q7DNJ2kGNQg7Sd82z6UskjFMialiSd/3Btxw2kiuVr800TtDd5MuGzZwxAg==
X-Received: by 2002:a17:90b:1e12:b0:33e:d66:490d with SMTP id 98e67ed59e1d1-33fd3a598ffmr5633362a91.7.1761353278794;
        Fri, 24 Oct 2025 17:47:58 -0700 (PDT)
Received: from hu-wcheng-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33fed3eca8dsm167352a91.0.2025.10.24.17.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 17:47:58 -0700 (PDT)
From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Date: Fri, 24 Oct 2025 17:47:42 -0700
Subject: [PATCH v6 4/8] dt-bindings: phy: qcom,snps-eusb2-repeater: Add
 SMB2370 compatible
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251024-glymur_usb-v6-4-471fa39ff857@oss.qualcomm.com>
References: <20251024-glymur_usb-v6-0-471fa39ff857@oss.qualcomm.com>
In-Reply-To: <20251024-glymur_usb-v6-0-471fa39ff857@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Abel Vesa <abel.vesa@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIxMDE2NyBTYWx0ZWRfX8yAnCvf2MGqi
 7vb2DKQOq8xOyNUr4UCtvBxJTZDOkjb9/NErfNFSVVww0XcfW1ODmePAuswHdVhhNQjOTXXD0xR
 aeBaTGOYc4bRR8ZMSZMPMhswK4q64bZqg0/LV0esapZvpnhvlIK9/FseOWn+CrWK2mqUNVI72+X
 1d88gP3gbdAj7Sxj9mWP5QxM43KPSiMHK29uWQRErwMKEeZy4zP9zCrDjJlb3rYyrAW7/2tFJXC
 hKOs0HmZpe1UL/JjkXMrZGubPMgzpBPmkhknZmTh9jX6Fw4jUWkfwo22ncr5Kn8IbwdhL7sEOEo
 yfIGcF5tBamQr04C7oJxhP91prSLA+vxqKk4ES/HifV6sF7UGlMV/fFS0Qib+/CokBJGc0oTQt3
 NRQw1vy1Mx1ORcqjCyv4I7CL2NXJHQ==
X-Proofpoint-ORIG-GUID: j4HitfixzgDJriA6-DAXhLZIEuvUP02j
X-Authority-Analysis: v=2.4 cv=WYUBqkhX c=1 sm=1 tr=0 ts=68fc1e40 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=9ZGL9VZrYHwIVTkvpzsA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: j4HitfixzgDJriA6-DAXhLZIEuvUP02j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-24_05,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 clxscore=1015 malwarescore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510210167

Add the compatible string for identifying a SMB2370 USB repeater device.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml b/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml
index 5bf0d6c9c025..0f015a4c2342 100644
--- a/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,snps-eusb2-repeater.yaml
@@ -24,6 +24,7 @@ properties:
           - qcom,pm8550b-eusb2-repeater
           - qcom,pmiv0104-eusb2-repeater
           - qcom,smb2360-eusb2-repeater
+          - qcom,smb2370-eusb2-repeater
 
   reg:
     maxItems: 1

-- 
2.34.1


