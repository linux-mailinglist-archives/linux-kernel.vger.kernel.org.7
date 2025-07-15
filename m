Return-Path: <linux-kernel+bounces-732519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D58B06809
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 22:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C41C18963C8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 20:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E730D2D839A;
	Tue, 15 Jul 2025 20:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FCrVWsn7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952BB2C17A0
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 20:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752612492; cv=none; b=YLYPDbyLHvSonD9Sftg5n9k+GzU3zlRtOdZSLG9eSHS/F/l+QeJ9/O49UnTxBEQVbiM5UvoIyvLrhGaF7v6meTl4x02jWFixP8YT8y7MgaRCmxyUUh9P0mXTQ+ibikixkMJaiRES3k8lcB71PAohTrBRwaRLL+EqkDxvWbQtuOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752612492; c=relaxed/simple;
	bh=BnlN8BH0y5miKc7waS4rKUqhxFa14KCTqJylMT6SIe4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ju2dRzWXh+CnGuqgEFpJGRuGQqbgxpFC4ax8+rAe1pqdp6H3zarETy9mJlRN95aaMkgR6+qSo3xH6Pz2mbyXnLeVe4wVwhbM23ud4eQmqZabj3om7ZZjzhcduwAaQNmlJzlL5vQ2PPN0WP/822Nv42Q+UgLm1vEECqimnJ3bOM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FCrVWsn7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FGDJRl026137
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 20:48:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Ulnnyakmdjr
	TKRRwRremdAmueSN3wLLHqGlctDxytVc=; b=FCrVWsn7DwpAiRU03Bf7J3G10cA
	8p25K05EY7CBZRIGQM6AyjVxlOR2oIwb+DQI997+Iu4vcB6XSrTzDCFrC0dQb/xI
	Lxt8a+/oP4Seb8DmW8DUObqPyyACQYchIeaNbicANBF/pIQLlHKDz7giOsKzw3FA
	dHayKBpV9m8wbC0seZUTD1UHxcVO3dntGfzcPnBx8ve0fKr3K4VThehhsntDZPWW
	YNqnT0TTq5IMisspE5kfQ1GDHWA8D5KAOCPAG/IEZ/tF8TdgA1TLP3bXMPtgyYMA
	hdbTLK4pV73iw8411U5bEvioVR/tSq3CapeCa0KH8HWC+tbV4ZmXkk0HjcQ==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47wfca2ugy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 20:48:09 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7e2e8a90a90so385325385a.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 13:48:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752612488; x=1753217288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UlnnyakmdjrTKRRwRremdAmueSN3wLLHqGlctDxytVc=;
        b=BeXxHLKqzxOVgx3Lv6Ra1/8REDjKyDDs+2u5J5cVejiCsNis1NgfOCT5gkNNNOqur8
         j1iIp+JhRsmWbV01yIKRMoQmOrak+/5z6auD4kvvKCwIx+mRwcFypisL44uANLO42cxs
         jRrtW4STGbBwl8GkAQBxJpoI+pnqUZSNlhtOLBVcUex56mrwoSdAnbiitXBEzYOZXrwD
         pnbtBfmPPu4CxjFGzdUkBQqBzM4yJGGo2lD0b9w4fM67J9F9HMyDSKw/sX0sWvxDOazq
         NDQW3vI0AnFVWBQJ1lwHsKbJdYy5OD7Ne+/wojSZJufzARNYPdfexihGp75XSHKUgdSQ
         NULQ==
X-Forwarded-Encrypted: i=1; AJvYcCUg9G3k+0iW5wwvlx/Yji8bEkoCLL6WkKu0I27FVZ34BwAZpRbnT4a3RVpH30uSIawHKdcMLuWfSDi9byc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbWdDCkuihNmYqFJ16JOmwZFV14lFgMP1mLoseYJWKkEo8an46
	xRUTW+E1SwXFff3liR70FokrORy1KwdG/OsoM6/p20UvtyljFR78KCV0Wbc6gRlZ0dg+PImLK0+
	vzrbz12VVt7ZaOb2wnq8Q3bNESSriEejtqB4CPXz6RdHGRvSMU5sOzY98q5CMjiOUjKc=
X-Gm-Gg: ASbGncszdcbDs4PwH9VmaSvF8bLAekpkqHPloZzsJFrTkHOJZBWMHR/ANimLnnEhxoG
	4Z9eexDh2oQEJiN27NSRZAydukkIEkUkBDEsmWEI+G4r4qZR52cTUo4L+0OFmzJzPfboPhMIp/O
	/CgGvkPUyUW9bYGjcho3s+xaAW/HGdTdhaa+ZzT+ZggVU+9vS7XJsajqJcCCyijpF286/J5piNl
	abIf73af/oWkP6dmpjclZIrhyJVhu3yeMSbeQCJt6o2RFQ6kCipvt9xKWEaQjQmEExGi/SMKKHz
	yWp/7YO81N5l6MUEVs4moyrGW82SFcKPyXcjyZ/2lrjMEqtWlUwPmB22Nk0fNan0LQ0oxeJ5xik
	dXOM0ohV5d/EW0SKOzw==
X-Received: by 2002:a05:620a:468e:b0:7e3:3065:a6b9 with SMTP id af79cd13be357-7e3433486d1mr52337485a.7.1752612488360;
        Tue, 15 Jul 2025 13:48:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlw27oAr+iNWanGODjwWubXZcxp8SV4xbSVfakE6bozSVtRFetzaqd9UG4J7kX9ItIp+YXDQ==
X-Received: by 2002:a05:620a:468e:b0:7e3:3065:a6b9 with SMTP id af79cd13be357-7e3433486d1mr52333885a.7.1752612487970;
        Tue, 15 Jul 2025 13:48:07 -0700 (PDT)
Received: from trex.. (153.red-79-144-197.dynamicip.rima-tde.net. [79.144.197.153])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc2464sm16331877f8f.38.2025.07.15.13.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 13:48:07 -0700 (PDT)
From: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
To: jorge.ramirez@oss.qualcomm.com, quic_vgarodia@quicinc.com,
        quic_dikshita@quicinc.com, bryan.odonoghue@linaro.org,
        krzk+dt@kernel.org, konradybcio@kernel.org, mchehab@kernel.org,
        andersson@kernel.org, conor+dt@kernel.org,
        amit.kucheria@oss.qualcomm.com
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 7/7] arm64: dts: qcom: qrb2210-rb1: Enable Venus
Date: Tue, 15 Jul 2025 22:47:49 +0200
Message-Id: <20250715204749.2189875-8-jorge.ramirez@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250715204749.2189875-1-jorge.ramirez@oss.qualcomm.com>
References: <20250715204749.2189875-1-jorge.ramirez@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDE5MSBTYWx0ZWRfX+WOJ6lmj/e0y
 45YP5+2DDELNxBmwgHeTpom5OYUZKhWY7hY1b10Lvd7mLlNN0GBca7v+fcdXPRx2rRKz1GhXkj/
 T4NCmA7wUbp6iNJIOLczsFCMF39VpTtR+EE5dbFEeF71UQEypcjhuL3TW+Dhx9WRoLPsMnZ6Qnq
 AMyRlEGw6cXHG0N18raEAWgrFLBgK4TZXpAdjVQoKcm0ZBOTf4+GqMI/19+ap0Cz2mf4KwunREx
 OYqItmwsrhdlfFF3IJsh7VTVslp+g8Q8Fs3UhOJXLWNDKbmb9jmkwiS2rjR7qbVxS6X3TyRVHMR
 z18oapdLHRSBtG8YydL7k0mAaqXvTYkPKHp3XnCTu/Trf2nKxKxyONJQ3G7sBt/MnchlZG0ov0y
 y14mcYhTzhkn2jyEc919EYQqd34co5Yjs8Hv/nubBu+K8o5sj+6sJQ+HrqNT7Pf0esUdHRQu
X-Proofpoint-GUID: w9GDMQ3PJ0DJ_E1vge9AtQqiHCWWerRK
X-Authority-Analysis: v=2.4 cv=SeX3duRu c=1 sm=1 tr=0 ts=6876be89 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=Ki5fnJvzvo7yLsyA0quaxQ==:17
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=Qms5JgQ9tnEuTiNUcoUA:9
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: w9GDMQ3PJ0DJ_E1vge9AtQqiHCWWerRK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_05,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 mlxscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=732 impostorscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507150191

Enable Venus on the QRB2210 RB1 development board.

Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
index b2e0fc5501c1..8ccc217d2a80 100644
--- a/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
+++ b/arch/arm64/boot/dts/qcom/qrb2210-rb1.dts
@@ -711,3 +711,7 @@ &wifi {
 &xo_board {
 	clock-frequency = <38400000>;
 };
+
+&venus {
+	status = "okay";
+};
-- 
2.34.1


