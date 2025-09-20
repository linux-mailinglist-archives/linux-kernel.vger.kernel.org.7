Return-Path: <linux-kernel+bounces-825474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D1CB8BE04
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 05:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 808B2161E49
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 03:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA99522B5AC;
	Sat, 20 Sep 2025 03:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="R/Zf1bqJ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5013C223DD6
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 03:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758338479; cv=none; b=bs+raPfdHu1Ad636bmeeDVcsi9KStEXnDkj+tjJTN6wJmN25YfQq5GfRukx36KHl57IsYl2Lio+WpnfJNFqgTgQNuMu2la5+Rp/ps0cFu2sXygYchMKh9cC1Lk7GDnujRbgRZ7sMykg6GSG3WshMi8DHGeOtstV8P3WLXT99ZsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758338479; c=relaxed/simple;
	bh=FChmN2K25IEif5KaRFlunR0xe4GViKFxw/PGab+7yIw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JOD+rvQR2gluLSntTPW727TkynZ4hyuww5dESY74AKcsSqQhTIFI/fjcudkAz7eSflXQlZdneGNC+gKtB6D3Jx6D5eZ/cS5CT57e5HhsDQU68AP2ZMs4rTDmpp9jSY9mRhtXXdIxoYjqRz6xYvHe9gPuVBCbgB5nv4MN1zhCezY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=R/Zf1bqJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58K3FYJ2013110
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 03:21:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=v5tmMdZXUOm
	Jw/ggIyYVsmTSYyBwUp+iA2AluiqlOBQ=; b=R/Zf1bqJRVVYzeOtR0sjwOUS/v3
	IGwo1v+5nWeo5+Lb7GTgNTJNAHDVDGVdfhI0xllGRsk6CDB03tQWalWi+0IKlGAf
	2SPbTEofHdOigiA3PSqwPzdBFtIH33Q24q7Ibrnhc5bYMQ1mCca6FA1lzdhOyRwB
	l2drZvOYXJI8BhGJI4H590RH+ckv2lkm/gqbw4soyrlr9aeGT7Tj14I52DS5AdZ3
	bQ2HPh3+MiPuxn9oEYdmlfFQ/zFeYkww0VZl0PnzSVuhC1Af7105vXss2m1hqzHI
	ZTzhuTyZ4O6SwlMSkQBXeCoPT9GLgGs2orf2DzGB95XjlDI82xKW/Jk2giA==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49916x3cbn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 03:21:17 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-77283b2b5f7so4001860b3a.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 20:21:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758338476; x=1758943276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v5tmMdZXUOmJw/ggIyYVsmTSYyBwUp+iA2AluiqlOBQ=;
        b=ZONwLa/0Vsrg+DXP/lS7AfqTvhGUviQKgmUG8MMZ5bSLbLdj4mCOtkuVyUEU8uvu09
         p6rlS4KqZI7Tuc6PYF97q7PK4C9uPNFIDrPIxtx9XzxI7CXbPAsb6DnLG00sJPC3m05f
         ZGl+Y/VURRX2Mhk0uBlMlXJoUmT0Vm8ZPPhfZxXpMteKxIRVF1uffWBBZKh/jxx0oPbf
         Xv1DKmcW5Dzqy9LFVb5vBHE+VisGMHD1/4eULCS/MegzZFWnOYRpKwLm6Rj3b3DQ33Rk
         5UZfpgb6SLOZ4W0hwcnyvqpPF1M43F+Kvd3/1hmxmKaVwTYRJ4DMaOS8Un8kkyedrkJ4
         yA/A==
X-Gm-Message-State: AOJu0YwV3u5OCGB31cW0k9IFHap28r71tobTYh21Idl3dC2VhR5vG79k
	OrqLb7we1mzu802hh4pc03BqSBzIhsr4mk4OAjBg7oxAofLli4Bsr4aUBs4DEB76tfm293v1dGC
	hgC84+nJVp4B2lROJDEqQuNq2in0MqxyGzJptPkwySDrrPUpfYzrWNB3ovGGNDWAlXG4=
X-Gm-Gg: ASbGncszfNVCUEw8fI1GNyeY6xXt59Rim7CxnSMRG3Q0O/gQSDWgQE0F49qY3Zooz8M
	+fO8Fh3xQ4yHEX2ssFu2bffk9eLwAw5Msp21sUX3wpXCupHpi4/eoVAxyE7sa4Ul8dFcsxyLQze
	OMpwqiliKmUn8n/Spw2XiXMaC7JbGZBbCXg8ZBiHYm5QwyKjZATKqb4D5k6YnP1fKrvRPSWwF3T
	RUVa1ZMeT22C8UfysU7cCk5hgZjHCf//reulJgcpWg0gcguji241Wgew4ri18l/IruHLIKwGgga
	IUccAlCiTkbuKmcHxc9rYvCXIxDSQ5KvT8v07zR/x4RviA3N1tK/B+LARSvDhrDm4kiIwzKBP1f
	K08jcfg4xayi5GROd
X-Received: by 2002:a05:6a20:2444:b0:24e:2cee:9585 with SMTP id adf61e73a8af0-29274fb33c5mr8251251637.54.1758338476469;
        Fri, 19 Sep 2025 20:21:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOqZ5VhtjKbilxthQa6bXSwR4zCDyXQKASkb4d3QLk2LNVbpxHxAtIPLoxjj1rAPuc1i5rzQ==
X-Received: by 2002:a05:6a20:2444:b0:24e:2cee:9585 with SMTP id adf61e73a8af0-29274fb33c5mr8251223637.54.1758338476056;
        Fri, 19 Sep 2025 20:21:16 -0700 (PDT)
Received: from hu-wcheng-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54ff448058sm6178807a12.54.2025.09.19.20.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Sep 2025 20:21:15 -0700 (PDT)
From: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
To: krzk+dt@kernel.org, conor+dt@kernel.org, kishon@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, robh@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-phy@lists.infradead.org,
        Wesley Cheng <wesley.cheng@oss.qualcomm.com>
Subject: [PATCH 2/9] dt-bindings: phy: qcom,qmp-usb: Add Glymur USB UNI PHY compatible
Date: Fri, 19 Sep 2025 20:21:01 -0700
Message-Id: <20250920032108.242643-3-wesley.cheng@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250920032108.242643-1-wesley.cheng@oss.qualcomm.com>
References: <20250920032108.242643-1-wesley.cheng@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE5MDA0OCBTYWx0ZWRfX+N26BohBFLGG
 YRCqB28yNEHqb67hN1DpvRL50seTNB/HmtUXaaO76cdMxDP5b6k2xNAzZUbLvydncbeqoMYsknv
 alfRPn7QfBA2xJbT7SAHqENMtaAWY2l7o9oCEN+kBgqMx/Sr/kyPfBGAPV560GNUW3kOBaILfGQ
 DCiwQW6KCf1vJjtPId5uSkt06gGWbZf4zJP0fZPfigenuQocFaAjewVI+Tuu2pGxzkfpLHEnHmx
 v6078iUgYIdburkCsRd9J/yvDrD0bmk9maO//cdrYt2CVMmx4VrcfOYNina9sABZEKfAEdM1+bg
 mB9h9+j3uEkepTeJZ6qJXXv1pD5kyoFS8slsYKKZMbi844cLQdVzUY9eZLpnFHto32TeiAEockb
 qw0X4bT2
X-Proofpoint-GUID: 8TwQ3kvpat0H4TkfnKanD0qOg_Ts5LYb
X-Authority-Analysis: v=2.4 cv=LcM86ifi c=1 sm=1 tr=0 ts=68ce1dad cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=6ooe3h3ZW61ma_5lk_AA:9
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: 8TwQ3kvpat0H4TkfnKanD0qOg_Ts5LYb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-20_01,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 spamscore=0 impostorscore=0
 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509190048

The Glymur USB subsystem contains a multiport controller, which utilizes
two QMP UNI PHYs.  Add the proper compatible string for the Glymur SoC.

Signed-off-by: Wesley Cheng <wesley.cheng@oss.qualcomm.com>
---
 .../bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml       | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
index a1b55168e050..772a727a5462 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-usb3-uni-phy.yaml
@@ -16,6 +16,7 @@ description:
 properties:
   compatible:
     enum:
+      - qcom,glymur-qmp-usb3-uni-phy
       - qcom,ipq5424-qmp-usb3-phy
       - qcom,ipq6018-qmp-usb3-phy
       - qcom,ipq8074-qmp-usb3-phy
@@ -62,6 +63,8 @@ properties:
 
   vdda-pll-supply: true
 
+  refgen-supply: true
+
   "#clock-cells":
     const: 0
 
@@ -139,6 +142,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,glymur-qmp-usb3-uni-phy
               - qcom,sdm845-qmp-usb3-uni-phy
     then:
       properties:
@@ -147,7 +151,7 @@ allOf:
         clock-names:
           items:
             - const: aux
-            - const: cfg_ahb
+            - enum: [cfg_ahb, clkref]
             - const: ref
             - const: com_aux
             - const: pipe
@@ -157,6 +161,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - qcom,glymur-qmp-usb3-uni-phy
               - qcom,sa8775p-qmp-usb3-uni-phy
               - qcom,sc8180x-qmp-usb3-uni-phy
               - qcom,sc8280xp-qmp-usb3-uni-phy

