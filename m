Return-Path: <linux-kernel+bounces-801290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7818B4434D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 18:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D48ED1CC3EFD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 16:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDEF6322A1A;
	Thu,  4 Sep 2025 16:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CjiH6mer"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E46D322529
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 16:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757004009; cv=none; b=o1X1dFyfcdspI0CiNEE0rpWkqIZezl1vwMdVOLfnfaQEYR0Ghfy6hVC8F0KhAj7Z0WJeVU2/obNMUfoKPZj0CXFg6cv0IwsPrOoUp6LTF31zaAQT2K7vakS44y52pUJSyu2GuWm3SR7dn1ko9bQRuVc9/coUJ5Yf0uiyNktjiWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757004009; c=relaxed/simple;
	bh=27FWMqFCDTUwpqfJlNc8jFyWyreHhp7HJeUXTzNfhgA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ae450LHXD/2+80GUflAWbA2vMO6lopHesji8qcQZ26eLUQ26k8MJdAPPp7IlP5w7CMsYI00HsH1jZlo4Gm2poPuwfItjiYQeriB/LiBdw4Uo8QIsIPDbOQygJ6ZRZZb31X14o5K133TJDsyWs6jUo39XnKu+3XIYZvZW6f3WrKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CjiH6mer; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5849XBbk008250
	for <linux-kernel@vger.kernel.org>; Thu, 4 Sep 2025 16:40:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PBnsv8jIHnwgITCzKC089k9TiBqBMjIPeobN0jq972I=; b=CjiH6merx45R7pQw
	E/yXR046uZfUs/pwpo2Tc5v+ssI3QmcYcpwnz7YXR7mhmGKf++mpfXAJAn+/7rxf
	TcRogn7XQZAbpfd3868VtqvPU/Hb4nhk3h8Njt5SUMLjlKpuDC1nwbVsDokj4wYp
	LmAHXkYRzZAoVEylirfVRY+KZFJUrexiBmMJ9O+zXjwRlnKC95791W00q+tB4CBY
	OK+VdmEjRuTmI5VDZ14eEmYwyn1fFz6ppbUUhK7zeonJnPomYRnHykJE4JgAsjoI
	hAhUyXM2/5BK0fm7FjjlzZSBFvsb/xiAKu74cDRHgwSX2c4/hUbYfgxwfifJqny1
	KsfccA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48urmjr5r0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 16:40:05 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32811874948so1121891a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Sep 2025 09:40:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757004004; x=1757608804;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PBnsv8jIHnwgITCzKC089k9TiBqBMjIPeobN0jq972I=;
        b=V9wRx49eratSf/NyrxGeEWEMAuWIz7iF9NyxmqZ/9F5SIm+MAUuvAbG7eBqIU+Ctic
         vqylh7ScGwc0pygqRaeuTdTEpH3LVV11w3H02RJ/OPux5pD918R/S3kEaa2ICWWopuDr
         vDhvYR4H3CFBBkbgIbFIThBN6JykLpduyKg7PV9u1S4hiM/aSVmU+MaZ6qAJ67t6Dm3f
         pRyk4eTMTlUdoRB+rzG4s5+oWNYXIxUt1E05D/RlqzG6kI6Y3UgHutWkATY5cXY5T+vU
         WUwebfApuj9gsoR+pzosaHqBzHt7+VJQQFzAjwMahXFkSJcfN3pOGIYkgj0TQXq3xZ6I
         fHAQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8HMmrjC+E2HvbMTEA5S4mXFuBgWRyYgC2z8YEgI/scLRHGu4y4uKOOCfrEixRxHGSY1KrJJMyD0kJ5Do=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx99SfgBdCPk50r9TGN7jYAzIMg20KW4O7ZA254GP1LtgNQImrH
	ITuZwTeBpJ5XbWV726oHTJIPF5E3HFWqk7FuaE1KRLGu8adXZGGBGegamykj1WdSt2GoUH2s/Mz
	oNQK4Pfgj8pT1T4obuCTbg6fyO+MdUlpYqODowZzmfs3NXHYJduQz20cz68I1MMoQ1Zk=
X-Gm-Gg: ASbGnctiNOzZB265bOcL+4QTLOjV5nhEoHWXTQZZceDCQ2I8/HghRIVIFfrW/7eqPVh
	l4Spt3LPrjVwnxb0lpvM9vSiBhygtNwq/3WhjZvuuq95ZKF6dcz7ie7koajFoNuvfdJdL8Zy4xi
	qXaLjW/+7jnkz5udHfDul8sU7wUR794gxWENEZleLlPzQzyVBo5unzehrXA/2af3L9lOnKoK9Mf
	tH58Xpfp5YetnFVhQPZPdINJjjRORSopetSGu8/oqmPGz7ThKTGBk87wrXAQ1R5GnJ2V42STAJ/
	41Wb9VcScl/KuvHx5eDy8k6/GkvK5lwVvr83EObYInEYxGNG7ug4asG4+e4Oz2Y7L1NJ
X-Received: by 2002:a17:90b:2790:b0:327:8c05:f89a with SMTP id 98e67ed59e1d1-32815412e9bmr26511487a91.4.1757004004364;
        Thu, 04 Sep 2025 09:40:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETLbiF5LomcDMPddyH+6eJjA8N15yzTu1sZbM/gaEcwfgyKS7gkdIZOV07jqV2Iqp5IGsQEw==
X-Received: by 2002:a17:90b:2790:b0:327:8c05:f89a with SMTP id 98e67ed59e1d1-32815412e9bmr26511431a91.4.1757004003710;
        Thu, 04 Sep 2025 09:40:03 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd006e2c6sm17346371a12.2.2025.09.04.09.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 09:40:03 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Thu, 04 Sep 2025 22:09:05 +0530
Subject: [PATCH v3 09/14] arm64: dts: qcom: lemans-evk: Enable Iris video
 codec support
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-lemans-evk-bu-v3-9-8bbaac1f25e8@oss.qualcomm.com>
References: <20250904-lemans-evk-bu-v3-0-8bbaac1f25e8@oss.qualcomm.com>
In-Reply-To: <20250904-lemans-evk-bu-v3-0-8bbaac1f25e8@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-i2c@vger.kernel.org, Vikash Garodia <quic_vgarodia@quicinc.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757003953; l=865;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=LoxKYvMXT6w2D33TxA4UNVzhnQ1bXXJVAz3sDICoZRg=;
 b=cn9950aoCKHCLBDJ0YQwZZ3VOYSNkIexa6YkQadyz2LdSJ6QJLVSeQY/Et3Cb+sit9kRExVnW
 ja4vkVqHBA6AP1YylmP9vi7DIKXoFyrKl97WqVPitioS8TxvugA4hap
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Authority-Analysis: v=2.4 cv=OemYDgTY c=1 sm=1 tr=0 ts=68b9c0e5 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=9guL5b7EFFMc6jyTlUkA:9 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: kBQTDMkfl0GA03lHKLZ97t1nwxKd8wr_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAyNCBTYWx0ZWRfX7pZyb5tppO4Q
 2oFLGKlrktdmEb7ywW2byi9MYv10VcijiLnFb9m9/e7u+WP4Dwa5R1jlvAsrPVRAOfd/bV+7vla
 mSLsVq3l01dZMcO6WYE/o5x+dURB2Nwj4cd49OiF9BoUIZYNJIJiF7StNwr12I8qCfx/SqdltnQ
 JR06TB4vy9vO7ahyCaonCXqmUSUfBdfQ6hX9cQQh76pMnwTIr58HM9zrrEs2ICEid/owZQyIMY/
 Vp+gkI+UhBPM1ENzZC5dhQKideIoQdPlty3kc6CjcFnZENEdCdYemytUlGsyBJNU0kNwTTvHGCy
 b/qnKdHUH9+l3Qk7PpAX+cBCWE6M7gA1K7wJgVeKojHy6Te5T3Oy1cn27JtWXo4oWvifDuYYYCE
 BUgUcE4J
X-Proofpoint-ORIG-GUID: kBQTDMkfl0GA03lHKLZ97t1nwxKd8wr_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_06,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300024

From: Vikash Garodia <quic_vgarodia@quicinc.com>

Enable the Iris video codec accelerator on the Lemans EVK board
and reference the appropriate firmware required for its operation.
This allows hardware-accelerated video encoding and decoding using
the Iris codec engine.

Signed-off-by: Vikash Garodia <quic_vgarodia@quicinc.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index 1ae3a2a0f6d9..d065528404c0 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -333,6 +333,12 @@ nvmem-layout {
 	};
 };
 
+&iris {
+	firmware-name = "qcom/vpu/vpu30_p4_s6_16mb.mbn";
+
+	status = "okay";
+};
+
 &mdss0 {
 	status = "okay";
 };

-- 
2.51.0


