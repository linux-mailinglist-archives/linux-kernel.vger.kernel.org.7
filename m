Return-Path: <linux-kernel+bounces-825646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6B9B8C6B7
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 13:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D708016116B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Sep 2025 11:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093822FB086;
	Sat, 20 Sep 2025 11:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kYTlVtsc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6659478
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 11:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758367883; cv=none; b=l/McZn4vqSiVUJNbicrLFb2SsiZjAtDEGVTisZJyke0m+znZQt5Tlp01qnOy9aTj7+EvQ1bCMrLIe6n6BuJ/uctVE6A0uYJYmfkmLHacsuwGdj04Qybjj8h6JrDgrq6WyUKmaXJCR0ZJCggEuNtSR0Z1zoIXnvmlOtvAdWR+cqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758367883; c=relaxed/simple;
	bh=wRFzW4gTxw8RSbwpMQZx26SwQa/TSHZp7SP5PI7C/IA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xc77wnqde2kGrmGpZTvSMdj1IFCNzgsMNU6XZVxUjid4XetW9aKTi7Tap+SRijUX6Nh88NYCysMTqoXGOiEowRcqioU4OuDK5z1UTUXnM96Zc3Bc/0vtR156i/6cIXVj+u/rNsDuEXgThjAEGUlQxKRF/eh1GTGN1qAkM0CgXnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kYTlVtsc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58K3Ye73023312
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 11:31:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=t2PWzWr+rmTAvxWPqAkysS0sBuB2h0DCVbB
	pWs6MT24=; b=kYTlVtscNrzvQuS/Nwh+4aZA/gfZ32XyClXtFdtfoejSUezMiKf
	TSk3wj0It1Auae/zTngf7dispx4oOGBx6t/lPmLzOMl7sLP73RzkQSqJSqFsndyY
	xBfEkzogyJhnwdm1txuHg4XN3A/SZZhXlNAn/D6IyvJR+w81oiajEPKpKX0NtXD2
	nZPUqKBPtdc+gI2Bn3Z6JNX0+ymgXtr566yo4CjUjJwLiSdkoKHukrKGHGHJvebj
	2PoP1vICOWKeLmYPmVz6Smh1WanWIt7g0359JQbH6kzGubkKLmpKDiQPH2wk6Isv
	Sv5srQXMSN+lF5OK1ZGWj6htkQY5k4u6klQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499mg30kk7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 11:31:15 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2681642efd9so26155485ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 20 Sep 2025 04:31:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758367874; x=1758972674;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t2PWzWr+rmTAvxWPqAkysS0sBuB2h0DCVbBpWs6MT24=;
        b=IatN1eUqBZ7dGHgn9cikCqkbt8reci2onI6LuRZnaJWv1EV2sBqidTexgzKJldfJYI
         O76sAFeV58Z9zu49usZOKmQ+U1rPuzj5MqIRbqXSPT4IpYDHW3roz14DQSAyQBqXseTB
         3JhuKuu41SuoH9LCdqZ4pFD00aAfSeA4lTPiRcstLenlVAQvpZRPrg1+pQbKkvEW3etl
         qPyLM0rRGREKfHP4/Y25lSHTLB3PMV98MaXBjWbFuMJQ9PgA+hBBmcg6KJ/i7D2/d25K
         5y9ngIj30lcPOPbJmw42HCZ3+EEtfc9WjOmZT3+OSNNTajMXPSXC39bI/+zrAWM1MOVN
         GKTw==
X-Forwarded-Encrypted: i=1; AJvYcCVuI33valfEckXmIZFKK36cxUxBOaV5HsNo5+FyNAYbYnYnDgbAoLWBUVCE+XbpGtXf/c78Yx0ivfNW/IQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlOCbfGaCdHf4wiauxV4XGm0X4raZRVmo27Bm+0mXqkP6ziyRX
	RgASQMiwprIOqCUQmtSkHGWo9OsZ5h5Xd/bvvwalBHYf2ucz3Lw52Q+UAzzom18Cc4JDAR4qulT
	D1JBlLDF0JBPX3dG1es0sbjsNozYk5l0aBRFWZxtY2Dpr+u1j5l1IzSC/RShMCYqX3tE=
X-Gm-Gg: ASbGncuJFEnCidhlok1cT8YDHnRjomiHTA7+yq5jJ9/12VDx+y9/vDe1h6NArw8Vz07
	KWwNPV4wOYN/fJhGBh2+g8ZCi9TUZVc5wbbGdnrAvp4N4fsxIjxZ/4qEDojhz+0YiIpeGyej8gB
	rjlSM5kiZ05EDsv65257f8qHpE8uGQ1KxNwB3YANY55I0vBUjo9UsSH0KnaoTwJmSLCk9nuoXwD
	zTNrVbOqQYLaD/dUPiZ+tzFY6FSVGCVNCTXKKXdSnMO0Xdx/+u0xiHuhGF+pimvcrKwH2Tos6QR
	VzWXd4stZMz65xyXvQos8hxL+6+NZBRDMfPOlH5VXE3XubSD7Klp0iqwGZLJ9Hr9YGYxeeSvz3n
	pVOu3VoXZf2lYI4x0HXu2OCxxRfg7IdyAnZuQ+McXJRJlCFFOkl1zcdiq0bML
X-Received: by 2002:a17:903:40cb:b0:26b:61d3:cd66 with SMTP id d9443c01a7336-26b62201c03mr69924795ad.29.1758367874217;
        Sat, 20 Sep 2025 04:31:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGHhe73x0XLBwB2louUzFMWyY5HexOtrXj3J/yR43zYP6wQ+HGnLlOCgGTD/Jfpqkyg5lA9rQ==
X-Received: by 2002:a17:903:40cb:b0:26b:61d3:cd66 with SMTP id d9443c01a7336-26b62201c03mr69924465ad.29.1758367873744;
        Sat, 20 Sep 2025 04:31:13 -0700 (PDT)
Received: from hu-pankpati-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802deb3dsm81109635ad.93.2025.09.20.04.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Sep 2025 04:31:13 -0700 (PDT)
From: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
To: amitk@kernel.org, thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, lukasz.luba@arm.com,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: thermal: qcom-tsens: document the glymur Temperature Sensor
Date: Sat, 20 Sep 2025 17:00:52 +0530
Message-Id: <20250920113052.151370-1-pankaj.patil@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzMiBTYWx0ZWRfX3meRyjxQgYi8
 sLBkndBX768SpPwzJcsj7UUPACKBdDNQPvPJ3IK2Z0CBBACcjiILA+A7VTX+agT44jIeuQtsLly
 rzgr+l1bVbmfJ2M7LCHTtJeTx8FzswWu5yEVh88L0bnucGeipozYVD31//vK7FR/tPd3dg7RG7H
 QmOBSgt7oaX4unxvjzk1qcBUyWWrBUFopG8siYxRAy/1X3nmsMjfC9uE5m/FdcXdwDJx/xxrx8U
 5+soOlEgylJX/770N7qkPsx5iajVBx17JOzUcDoXMaSA1FpHkAR0Qd6jRN3vxO6yEGrzepzbgTb
 7+x6q3+fdwmnN4QUYI0HWKl7t269aL7Qq5e9nwXVTJzglbQZ4c6fyrIgOd6JX11MJamnFRTGze5
 fhKdYFq9
X-Proofpoint-GUID: 7kp1y5OpRJCZqv6o9QTWKESzV5isGpjY
X-Authority-Analysis: v=2.4 cv=UvtjN/wB c=1 sm=1 tr=0 ts=68ce9083 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=zzSzb4EmsE6u5SiZLnAA:9
 a=324X-CrmTo6CU4MGRt3R:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: 7kp1y5OpRJCZqv6o9QTWKESzV5isGpjY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-20_02,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200032

From: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>

Document the Temperature Sensor (TSENS) on the glymur Platform.

Signed-off-by: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
index f65dc829574c..bfbacba1dc55 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-tsens.yaml
@@ -50,6 +50,7 @@ properties:
         items:
           - enum:
               - qcom,milos-tsens
+              - qcom,glymur-tsens
               - qcom,msm8953-tsens
               - qcom,msm8996-tsens
               - qcom,msm8998-tsens
-- 
2.34.1


