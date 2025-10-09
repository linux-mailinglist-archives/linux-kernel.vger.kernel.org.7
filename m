Return-Path: <linux-kernel+bounces-846310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F77BC78A6
	for <lists+linux-kernel@lfdr.de>; Thu, 09 Oct 2025 08:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A4E4D4F26AE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Oct 2025 06:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAEF2BD016;
	Thu,  9 Oct 2025 06:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L6vUhfmK"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0412BDC05
	for <linux-kernel@vger.kernel.org>; Thu,  9 Oct 2025 06:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759990778; cv=none; b=AJtw3r2p55bs3ZL0/2pE4dgVuzjFdECVUfAoTkEfD/xPqdsvLKwb2cywTT2Fw7kfaZqco8TKcycHhzUiDWOzyOSR9v7n2Ak4aNKSC+yUeIdv3hQRV3xRXMMoLF0i2g0bw6WlgWkBPItcav2+iFKCchoMGtZ4pDZ++jJ46FH8P+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759990778; c=relaxed/simple;
	bh=oj3ZGY6/IILJHtVhKA2pv4u2cYCEUcRJUrt5ILBWwaY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LN8Xubc2VOmm52ayL1USHed3Iqi465Uq4LmrNy18bC/vdx2CFmhZxJOXXEIFoZqR7S+cY341faES1Gn3H833UfImouFkdJ5f6W1rCZwzDOKktW3F5CFIb6MhXxnl7q7dFfJLe2GcIlW1avy7Lnpb5AtH8d3umPKza2VuWA/ZmzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L6vUhfmK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5996EL2Q012393
	for <linux-kernel@vger.kernel.org>; Thu, 9 Oct 2025 06:19:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mKq3yr9dCGurHHla7xpzo8tVBMxkbqg8w1/ZkAGSJww=; b=L6vUhfmK/kuMOSQ/
	12D51qQOvUVVgKtQvZL8CUrNFBD8aC57zU0NNY9V0jZLOh7RWd9tiY2BXUixtyxv
	Ftel022nfyjLoCfNrUZ4rAuJPq91t/GxCmxoNEeKQCRIm7mZ2Z9IR7Zp809TikfN
	kcuyMN9xTOuC3ZWxlCnjI7aXH4M1ZxMrdYrY0dXpTfjtraQKmGmK9pSXHzlBIlVw
	3Z/tEZ2rLRYHxTmykUIDhLKwzyD4uObx8yi2s+4Nfx0i1VUhH4GECTjwldOa65wt
	rYNBsnXD2iVQ7ENz+GBvsLZ2GCUj8WtlRghJT0hJBD0id/+BGYiRjek5K1F4lzvN
	enlm0Q==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49nv4khpya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 09 Oct 2025 06:19:35 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b5516e33800so1215916a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Oct 2025 23:19:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759990775; x=1760595575;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mKq3yr9dCGurHHla7xpzo8tVBMxkbqg8w1/ZkAGSJww=;
        b=ltbeL3Vj/aaL8CJ5ziRW/Oz5l2NrKLLrWUZjGkyuMpmPIQ/CyidpZEgEzp8YloMWtf
         xwhdbqVl1H8rxJIf2oLY5GkvqDqtc8ydBypdfP4PXrlH7IRzcg7Cux2yg+pa3/xob6GO
         XJApeBmrQcGKPDaLAGeW66kMGt1TalQ0ml1STY78Xkeq1RfLhDwXMljdQ0sOduIpmulw
         EhfcaF07xR67o2GsKbhQ5PkXAAxXNU945C4jD4XN8jS7ycaYvg1zJa1+GMyzEgu6Ev1V
         020airoytXOyaMc1cUjalsrNp294gwuL1Z6mo3Us01NJYjYaRh3QtpgsMoibi5stYRFH
         9MtA==
X-Forwarded-Encrypted: i=1; AJvYcCXYBhgrEpW2tkR8BnIqxaqDCHopSI0QWccOYZTzOd/jYQmRbHFrZbQ+oBwgqqgbpNWWQwGdQwtBDgepes8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuITnUKjKNPNqgBoRh24au8uQKv7MxRSt4eViML0S4qBsA/Xoo
	X7BxQIltDs/KH0G3GAqzqBJ711kNHyh+hWzutoNKuk4MtL7Ado4tc4rbs0G1LwP/6aEZpHqJPgq
	JHjPQNHT1Uz1uwDPa7ure8DQpOt9QTxKDAQM2Xk6BkrM8h44XTyt5144pa6mO8RNGoV8=
X-Gm-Gg: ASbGncvpw7dCNEzdvdRct1yFF26rzlX7lHjv7JzHKYuSEB/wz7PZ9CpiiajVbBijQz5
	VsQ7s8qS172i+vaSucTTbuPr5qa4PHJWE8kMH19IpyiGkaXojA2MaTQPNwlVilRtJP+LfZAUOoI
	D7DIuURPxLy2OfudvFYZ91uYdia+NsGOTAadCzXUi0l95LZSVCaRAR+vA8Cwy2kKZ4nKqS3yDQP
	uSZk9RNC1Kb5TnVhBUDbTfdegWVKLmU36n8bRPjBh99dUbpOuc95oUTFK5JeTCh/HFRaJ7gz13F
	493wQ+Bdq7oGx+BZiKxwVvgGzKyd40J5K4Ec5tU4D3q60+xRyUNQAZJYczrbp2AhiwKhUN2yDKo
	xPEfd8u8=
X-Received: by 2002:a05:6a20:1611:b0:2fc:d558:78a6 with SMTP id adf61e73a8af0-32da84ed6b9mr8614520637.60.1759990774878;
        Wed, 08 Oct 2025 23:19:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHkgqFYMmy2IRS7a6u6Iwn0slDhgJRib+1JAT43YjU6dOCmUekP/T+l8jn1xHIvBWMdRcySFg==
X-Received: by 2002:a05:6a20:1611:b0:2fc:d558:78a6 with SMTP id adf61e73a8af0-32da84ed6b9mr8614477637.60.1759990774374;
        Wed, 08 Oct 2025 23:19:34 -0700 (PDT)
Received: from hu-arakshit-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099adbcbesm19239671a12.4.2025.10.08.23.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Oct 2025 23:19:34 -0700 (PDT)
From: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
Date: Thu, 09 Oct 2025 11:48:55 +0530
Subject: [PATCH 5/5] dts: qcom: qcs615-ride: Enable ice ufs and emmc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251009-add-separate-ice-ufs-and-emmc-device-nodes-for-qcs615-platform-v1-5-2a34d8d03c72@oss.qualcomm.com>
References: <20251009-add-separate-ice-ufs-and-emmc-device-nodes-for-qcs615-platform-v1-0-2a34d8d03c72@oss.qualcomm.com>
In-Reply-To: <20251009-add-separate-ice-ufs-and-emmc-device-nodes-for-qcs615-platform-v1-0-2a34d8d03c72@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc: linux-arm-msm@vger.kernel.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Authority-Analysis: v=2.4 cv=dojWylg4 c=1 sm=1 tr=0 ts=68e753f7 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=EUspDBNiAAAA:8 a=FZPswq4iDIBThNNNJiIA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: QHKzoca3ezyB42hph19MqqDPJNqHgBJz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfXwae/8ohgtJ4P
 Sr7sw/RBEfCrXZrI9veOkGDN5BE7/ZkwfDymztlqpy/NxZSb4yozFz/i+GeJYM75mtKniSuBbAp
 ++Y4x/4QtzwnxUKgE1JSzOa/UnDL4TdLGQCd9QIy4vUAqwOv99UuV9msmmHvHvJDWQAj6NAWxRK
 h8Z0/HPsfqQl119ZdKncCjIpojDczCw+cRuCFQKopkgVB19QeD2OCOz7kZArQdEm90H32wJ+yZL
 mUBD/FOqP7LmZLcmh0beN3upthrGk+3SboevtGh66/XUjWLqDktlFi3Gd6WMopUXOPmAv2yW4/7
 qT4w8yKifZ1lAOVgbLbWj7X+whBPKBu9H2OykRh+TjLA5w906OTuICyVYMuoSidO+/KUcgGfLxs
 MGhcsqx/mJCL7qQKb7+ZZHJl8Lh1TA==
X-Proofpoint-ORIG-GUID: QHKzoca3ezyB42hph19MqqDPJNqHgBJz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121

Enable ICE UFS and eMMC for QCS615-ride platform.

Signed-off-by: Abhinaba Rakshit <abhinaba.rakshit@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs615-ride.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/qcs615-ride.dts b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
index 705ea71b07a10aea82b5789e8ab9f757683f678a..6e80951c4159fd1fee2f737e0b271a9abaf82a49 100644
--- a/arch/arm64/boot/dts/qcom/qcs615-ride.dts
+++ b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
@@ -288,6 +288,14 @@ vreg_l17a: ldo17 {
 	};
 };
 
+&ice {
+	status = "okay";
+};
+
+&ice_mmc {
+	status = "okay";
+};
+
 &pcie {
 	perst-gpios = <&tlmm 101 GPIO_ACTIVE_LOW>;
 	wake-gpios = <&tlmm 100 GPIO_ACTIVE_HIGH>;

-- 
2.34.1


