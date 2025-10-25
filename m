Return-Path: <linux-kernel+bounces-869926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4874DC0904B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 14:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE2353AA6CB
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Oct 2025 12:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E5C2FB982;
	Sat, 25 Oct 2025 12:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="J6DPPCje"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BB72FB61B
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 12:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761395355; cv=none; b=MGZ2SrKUDzwMd/cVTmmBnhk6mLF4tzWS6GQxUT/pCFBb06etQg7ybEuVcruGiK1FnTtizcLaxHOQdh7syRWQ1D7yPP8eHnIVX0De3ER3pwkYwW9T69Jv4+onweSlqljTwxrrSbGqEZi+aHS0Qo21qTUUoQfl+neYkpajXe2mS54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761395355; c=relaxed/simple;
	bh=XQWkirYiRabM/kgFOoOyIkJ/6BmPCXFy0V93LhGbmvY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Noe9pqYITMO20yZGRTzhEK+QYyRUtbF/4MmjtqY9Glumj258w5Tz5X80v5M0wAdhoIecRhqz07E3cM7oBf3I2TqW72Pcs/VLo7mjDlaW1LXPnLbv2jzfxx+BIE5Jq9Eyk22+T3XLDZW+P84YlbvUAilFiZa5CrpnVFX7Q0xIxV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=J6DPPCje; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59PCJ3dh1216291
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 12:29:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=BYz+uswMqTM
	2jZeM2Jw5ZF+wZ+GGAqMdYPNgGgIFFBM=; b=J6DPPCjeBKonaQPWzJmkREP5bHf
	gsw7W8kFf7r8g2mm1TEICl1aV1q4aXWUKJKG4eKcJYKn0jxFzMB3S6SSPvYyr3WH
	YXWDsiWyBWF2rg+ftjt7cml6wNCYE3nhs02lNfENCcIVzcAuATddpXZDXbXEJU8U
	jp+G5R2YbSfeHyBrmFOj4UjlX7go2VZ38K7tDEulwoCCrW6j45xd743FmO1KhVp3
	O3LAeH4DLbJyrCvk5nFDOnJFtnpHiBUI1Bn63KcM6Wqjpz2ar+H67dQ3KyTET6Z2
	1LnKPDbbIGr0Sfo0MsYHIr8RvPDGYLaIjeS/o7IO3BaboegMVF4PWV6EbsA==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a0qqgrg6s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 12:29:13 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-290bcced220so28024025ad.1
        for <linux-kernel@vger.kernel.org>; Sat, 25 Oct 2025 05:29:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761395353; x=1762000153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BYz+uswMqTM2jZeM2Jw5ZF+wZ+GGAqMdYPNgGgIFFBM=;
        b=CDFiYa5d5F7U35JACxO5zx/1rw5RfHEpKp/ZUg50801pO52fPvc9Bgv8S506r/x6ll
         T5gQvNVmBp5fadfsFfV1Gh2IQHvn0V57otbDZ910l3zzlfsA6Yc7V/79kOW5tWIUUD0G
         0la/fygLdlYYCscX9FO8oJk7C/Y04TSXGQXWgKebIhqadfKIgqi0EMiVlYJCsrTe1t/9
         FMEB5Ih0XqdZP5iU8QEDiwaWsCWmctTlrq7IqkO4xuQxwQLXB7j97GauhThZPmojucPh
         JhJpiM21AFPMmid42O4Bu2sHNu56C/xOj447/zkhWa9xBhzl8d20cr+ZW+X7APKuIynI
         hDFQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8M01uqa1+3rpJg5eFPW8uwmRvQyrAOVv8dVGsp8j2X8HuHguqIX6T4FPSs03DTaulcrE6OWpBqiqZhqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+mFfOp3Q+bipA1pJj0sgPMd5Raiec2R9CCFw2Q+svaaykKA7C
	onnS+ulJo1ObL4QpJS+5bZkPRP6QCqDYVl048AT0lOgia/TlhVvBJMPPYN/0VCIUSL3JBZWBRre
	fEwoAPdWAYrlzCpOaU+XV9NyR935Q4UaRX12dacCbLDA/K5wrqmU6NS0Wmb+ACo6EH7I=
X-Gm-Gg: ASbGnct44OLxZ9MUcOBLQWDM439fN6PMu/pMIE0wzl9wr1MpgeLyCWz3svmjypKSwMe
	GjjWsugTkn4dP5bS2v4FwkZ1zWSguOiZ86MapBLU/P71Uu7P/cbnK/IfDyiooFek+b00Cp84wyk
	dr1yj5R1XYRiB74qBzQuWef5Wp2abz0wJwyT81c6CKSIvYyB9VDs9KHJq/vkkEIMp0UJ41rWO0r
	/jG8gREdAPAMqbmKTAHFWll0GtwgHPdca8P/G5S+VpK0gxdwYNydJJrB8fT4v1+tnjtvb3GXSEE
	lOidxLBa33lCcvvChJU4PCr2BbuRF789umiVHm7XU7EjR1XzgDsGFa06AI7/koytblBKCYh5QrP
	9F91XGeU86wnRz28zMDgyaUuzF/kSVO7kHF6n
X-Received: by 2002:a17:903:28cf:b0:290:b53b:745b with SMTP id d9443c01a7336-2948ba0d27fmr53363345ad.39.1761395352630;
        Sat, 25 Oct 2025 05:29:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+gsmVIpmhwJMlZhETCQBHrbkXp91WsQv/yEOSOV3UpTKM85vqDZPJ4x4KmEi3Lx6U9XJMlQ==
X-Received: by 2002:a17:903:28cf:b0:290:b53b:745b with SMTP id d9443c01a7336-2948ba0d27fmr53363135ad.39.1761395352094;
        Sat, 25 Oct 2025 05:29:12 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d2317csm22381325ad.48.2025.10.25.05.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 05:29:11 -0700 (PDT)
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Subject: [PATCH v4 1/2] dt-bindings: usb: ti,hd3ss3220: Add support for VBUS based on ID state
Date: Sat, 25 Oct 2025 17:58:53 +0530
Message-Id: <20251025122854.1163275-2-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251025122854.1163275-1-krishna.kurapati@oss.qualcomm.com>
References: <20251025122854.1163275-1-krishna.kurapati@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: -sdlUR9khQBgCY4jU3tidiAfQ-Bo8Ks8
X-Authority-Analysis: v=2.4 cv=ReKdyltv c=1 sm=1 tr=0 ts=68fcc299 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=UO34u3PHWDRxg_ly3EkA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDExMyBTYWx0ZWRfX17yBZzs7XD5K
 VvcHR1vd0jEnNQZROJ9qnRPlfqR+zxExzf1MMiADZLZpUmzrPanr+xkPLlo0P1VY2KGzUwox6xt
 xW+EtZh4M4CNpp374QbLDx3sC6VWyE2k2lNkvkknPamctoJ8d47tvTO90h7ZGx6pQogDvutj01O
 P7pHAfkqMAiCaXfVC31KHVTz1V0SA/BZhXZCWgDGRsXe7/SswPLIMSOaE+F6bT9KA3wBDfhE2/R
 kQMYFUT7GbqmyH+91sj5kJ5tYlH4PErYWepJMCFNtkkM5KP/4+sjfBoEbEt3hk5iG1BBcrpn+jO
 WG/saj7dHmq8FYbRn3NGN0T0c47ScXbjSxSdh9s8BnNffZvLAsIti6OdFTzL4GMIAvCH92db6ED
 2BWmRXjObAv9eAsFZGeeI4thCZXxrg==
X-Proofpoint-GUID: -sdlUR9khQBgCY4jU3tidiAfQ-Bo8Ks8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-25_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 bulkscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510020000 definitions=main-2510250113

Update the bindings to support reading ID state and VBUS, as per the
HD3SS3220 data sheet. The ID pin is kept high if VBUS is not at VSafe0V and
asserted low once VBUS is at VSafe0V, enforcing the Type-C requirement that
VBUS must be at VSafe0V before re-enabling VBUS.

Add id-gpios property to describe the input gpio for USB ID pin.

Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/usb/ti,hd3ss3220.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/ti,hd3ss3220.yaml b/Documentation/devicetree/bindings/usb/ti,hd3ss3220.yaml
index bec1c8047bc0..7ad79aa61efe 100644
--- a/Documentation/devicetree/bindings/usb/ti,hd3ss3220.yaml
+++ b/Documentation/devicetree/bindings/usb/ti,hd3ss3220.yaml
@@ -25,6 +25,15 @@ properties:
   interrupts:
     maxItems: 1
 
+  id-gpios:
+    description:
+      An input gpio for USB ID pin. Upon detecting a UFP device, HD3SS3220
+      will keep ID pin high if VBUS is not at VSafe0V. Once VBUS is at VSafe0V,
+      the HD3SS3220 will assert ID pin low. This is done to enforce Type-C
+      requirement that VBUS must be at VSafe0V before re-enabling VBUS.
+
+    maxItems: 1
+
   ports:
     $ref: /schemas/graph.yaml#/properties/ports
     description: OF graph bindings (specified in bindings/graph.txt) that model
-- 
2.34.1


