Return-Path: <linux-kernel+bounces-878908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AB8C21BB3
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:20:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1901C1894D9C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 18:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6769F32ABD1;
	Thu, 30 Oct 2025 18:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="OKK26kqk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AXtjIDlV"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5312EC09B
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 18:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761848420; cv=none; b=DYPzG3Mw2X8MgZ7vw/GMjGmUdb5H0ATE7sNKnSKzJBElrbo99MlJ3/MmsoQE81ZRnk26boo0dIt1dvqwgPKV880byeamj+fbL6A6RByj+1hGJpDLdCV+0nYNY8IzwbPaI6WyBCV9YW5OL9+v7n5ZWGHPFlcDfCqRtQ10MP/k+Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761848420; c=relaxed/simple;
	bh=5xP8+4rP7ynBZz/qPycqSQTi5O2NlQ7OMGayAdVqr6E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hJmEEckNkk4oUn890ydwZQAhSei0pJ/OY+Twvx19BOC5gV4jYB4zVp1bwtvakPNexWCdA/0LskSHDkKkBsnzmlUliNbDIZxsExoLGqqJFstcLVjfrcYqUWKt5/EibBUPv6XKQw6ReYtBOPVzo6IA2s7unUlLoiAXHvFvyyHh4D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=OKK26kqk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AXtjIDlV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59UG2T341656017
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 18:20:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=VrqIbmGtF7SrQK/qdTNg8W
	lvealR4T3AYcoZMnwJb8U=; b=OKK26kqkLDvWfhVdvZbcipmSaFSFQ2W+WNLNpA
	duE1WTbhmBH/sGo61YhdfUXKAVvkmGey0qcny5VIzZO9VnEKqKJ74kxfz2P6wv0n
	vSeMQJINgE5cvNMXbapGTwRqXQvAo4QKzEqzPYs6fdnDo96FcvluIX4uT18ZZks+
	2GmPCFp7GYzXt7dZC+Mso16d4v+FyD4zSlYz1iW6+mAu5IGir8D1k1JlNQziDGlB
	E9PdsFRnUJ9bns4Sf5ljH5z/Ee1V/MID2R2TMPWCGvwjorjeMtFxmsFm8d+gg3jk
	VTe6/hmqr540YQ8OAlpjJOYohtQkXSt43+fCBDSZxUxt6+Yg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a3tptua48-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 18:20:18 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4ed18b4c621so24825721cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 11:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761848417; x=1762453217; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VrqIbmGtF7SrQK/qdTNg8WlvealR4T3AYcoZMnwJb8U=;
        b=AXtjIDlV8UVwpVn04SjTCckw9qZvuYDmn9Kw0sgp1wauy8VALIyQ0QHHtu9xT/bZUW
         bBrDN0tqKyTjwGTg/3hhQH/VEKjbcm4Jerig6NghQd2hiDRONo2+1U71zOgLUFgKqgmj
         D4jQwI6UlaZT/jGAr1FY1KRowLENS4HOIFF13Fhciun4AcybMD8ywBPKk8T0MGfeRbsW
         M1IV93++jwoybX+bojLL/Xx1oypQzG5hvEMNjH5/T2Lf2bhJb8ikpmhCTUKyjckN1V7z
         T2QT3zBeyghLdc7xdJWbbdpbfnQekpz39dQxgLGJPBlh4naJW211WD5/q3dv8VwHjypB
         07ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761848417; x=1762453217;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VrqIbmGtF7SrQK/qdTNg8WlvealR4T3AYcoZMnwJb8U=;
        b=Vk/sVxtwEnEbeigJOreLkurAJjcRBY+1HqhABveStoLC1X9k55BMXb1SsK4Opg5e7y
         hK+KEjAy3ARzLKUcwnYoWK6y+EvQRdk5T0G+M5bzcqJT+k+K84kITq4ItHyJjxkcbFXB
         qezJCspgCQIzZJ5KjByhWhX26weR4I9e0mSAZObmbiDfmysvmR+saekdjdfdUMiQ7A/+
         op8nz4/tDkzTpiqKCu7nvZMxaOeqKJVaUyAfjAOXhl56gmRaC5fvryIFvMUD35gJjBF4
         mNdVvls0GnSFkaS3xTA40wIrTiXOlS41UECEahMEfei3KUjJC47JhVI8zIVqIxaXreIl
         zxXw==
X-Forwarded-Encrypted: i=1; AJvYcCWRCoOUD9wEQ/8ic7PayBKP82gtm7FhCIpzCD1wOhKcaT9LDtXq3xVbKeJ64fpSXUtC+7k1RxLJTo1iuKY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1ioSv37tydajNDKPm2pQZthmwhuzaH3//PimjpAnI3548OMIm
	LRljjQSgYdNe3GQKFsFoB1l8tVLWrxgoDxalS/TjIa7tEg0EYzIKgi+2oBmKudYyoACpjpTKpyA
	BAz8DZeNR+GUSivwfowXRXnn4RVJ4U5GGw0M1sxfUHBtzOUtoWpsoCCvfQzQMo/CnQ7P5ftDK+A
	8=
X-Gm-Gg: ASbGncvGKWftJNlzqUREDdfrQdJw5z6/PNUlhTH6lbnBhZUSskQqp2G4yGZ4KleXYym
	on5YHkWfphI1ttt5nW9BlqvhanKIXBPLXj3y29LYvFfHcZEYvQTEqzc6p7koWjNugtG/8FpM/iM
	lPrUeHzQPeRh/HQAMKRa/iWKaMLWCg+b92ZWVStmOQR7uCCPPkF301rmZBZGTSVp3up3GNtFx2c
	7gG5aq+Knp3a8g3xDY3hom5kWWxGJXFNRd2/GRjbIvyCK26phtfbDq39XGcQFUWqajZL1tqy9Cv
	K4gjDI8SIXiZH4LzJduEEgIDA5J67jaJOldMxQCBSTswfy2RXabVagdGPxmQWe1sNtnLEDo4bhd
	/b4squec8NkkXYFTQsQ63F/F4MR9WZsKpEqZPucmxFlBMB3vTowRI5rwb+tHWnLwy3zjBAlPEwg
	wJDoLzg1WhWzri
X-Received: by 2002:a05:622a:1793:b0:4eb:a6c5:f6c4 with SMTP id d75a77b69052e-4ed218b299bmr52393171cf.24.1761848416772;
        Thu, 30 Oct 2025 11:20:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoxZiLZSCojQg5w58LesDccbxK5rdGeSMtWV+HOmxw12ucoPv1euhGuvqr4mgLUoXvIx/8FA==
X-Received: by 2002:a05:622a:1793:b0:4eb:a6c5:f6c4 with SMTP id d75a77b69052e-4ed218b299bmr52392891cf.24.1761848416315;
        Thu, 30 Oct 2025 11:20:16 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37a15c5436dsm3843171fa.33.2025.10.30.11.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 11:20:15 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH 0/3] arm64: dts: qcom: rename dtsi files for qcm2290,
 sc7280 and x1p42100
Date: Thu, 30 Oct 2025 20:20:12 +0200
Message-Id: <20251030-rename-dts-2-v1-0-80c0b81c4d77@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFysA2kC/x3MMQ6AIAxA0auQzjYBlMWrGAeEqh1EU4wxIdxd4
 viG/wtkEqYMoyog9HDmMzWYTkHYfdoIOTaD1dYZ3WsUSv4gjHdGi2agxQYfo3YBWnIJrfz+u2m
 u9QOX27KDXgAAAA==
X-Change-ID: 20251030-rename-dts-2-14eb2cadd05c
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1744;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=5xP8+4rP7ynBZz/qPycqSQTi5O2NlQ7OMGayAdVqr6E=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBpA6xeKC5fWF/bFE5Lau8y7qphYnMImPnJucSBq
 Eg6nTiaPyiJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaQOsXgAKCRCLPIo+Aiko
 1egyB/4vFPnu3JuHoOvl0vqIGRUQwrnuJ/uJch/ssaEQQ1lpv/yPhXCURjbp8wJQOpoBqLp27Hi
 KOIK4CWfmy/GrCUARlMfwIMWZz1+x1FOLoXzt6hdECV/SMnAShMDdQJ/LTRZhg5ApKzbBlZaNcp
 PZ5EkbyxGRS29eJFqz6eV0MGv70SqutqTCONcjCR2xRSLu1Jrj4StyR6MjrUQDziUILKrgCAITN
 G752yOnxplAFzFiMwBGrPgkeVOUd0t0T+3sX+f1lv2i4KflkYGIy47bjj+TsLP2BNnnPRCWJDcf
 XqLDdvhsbv8mU70/xBKzKd452f1mDbmRkw6xNX4ySAx8Mj7h
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDE1MiBTYWx0ZWRfX+daKR5yrABiZ
 Tw2K/ap+5JkajqLD2avwJy3aN8pWhY0TlAXegnbNx3PjWVWIeHBEzzw63miC2PFhIG54XgUhC1G
 txbG7ECRb9xdPnOU7Ci8gcsbREYKKlxjKlsbziJyx1gNJXfbSHLiFPJruGMty1nNqSMNxSw9wlp
 gYoJKv5IEK+7kEiTvfvs5S6HIVfiyqWY5SJvzCNsXq0IvQ1Wlb52gr3kBAIy3nTn3I5mfe1Pk1s
 KRqRIdhnsYs+G41rFDidWHRsoZEmvPsClkJUQubDIxt1uJ4G7MEArMrzQE3AxatbBlYbMjLRP2c
 Kc1SV8C+Ek7f0BY+EOL1GF8wZtcBm7jQNEp/rVY0Js6ywwXeJRjj5w+TdH9eKsO6bs2aC8FAwcc
 xlYe5F35sdyQdUzG1feVxX7ABDNHjg==
X-Proofpoint-GUID: -y9ueyrxWx8PJQQEhEXvtm8xGcgDoxwC
X-Authority-Analysis: v=2.4 cv=MuRfKmae c=1 sm=1 tr=0 ts=6903ac62 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=WSwQQHQvUKblJ0kXEVsA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: -y9ueyrxWx8PJQQEhEXvtm8xGcgDoxwC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_06,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2510300152

Follow the earlier example and rename several more base DTSI files for
the platforms where we have (or expect) several SKU ids for a single
platform.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Dmitry Baryshkov (3):
      arm64: dts: qcom: rename qcm2290 to agatti
      arm64: dts: qcom: rename sc7280 to kodiak
      arm64: dts: qcom: rename x1p42100 to purwa

 arch/arm64/boot/dts/qcom/{qcm2290.dtsi => agatti.dtsi}    | 0
 arch/arm64/boot/dts/qcom/{sc7280.dtsi => kodiak.dtsi}     | 0
 arch/arm64/boot/dts/qcom/{x1p42100.dtsi => purwa.dtsi}    | 0
 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts        | 2 +-
 arch/arm64/boot/dts/qcom/qcm6490-idp.dts                  | 2 +-
 arch/arm64/boot/dts/qcom/qcm6490-particle-tachyon.dts     | 2 +-
 arch/arm64/boot/dts/qcom/qcm6490-shift-otter.dts          | 2 +-
 arch/arm64/boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts     | 2 +-
 arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts              | 2 +-
 arch/arm64/boot/dts/qcom/qrb2210-rb1.dts                  | 2 +-
 arch/arm64/boot/dts/qcom/sc7280-idp.dtsi                  | 4 ++--
 arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi                | 2 +-
 arch/arm64/boot/dts/qcom/sm7325.dtsi                      | 2 +-
 arch/arm64/boot/dts/qcom/x1p42100-asus-zenbook-a14.dtsi   | 2 +-
 arch/arm64/boot/dts/qcom/x1p42100-crd.dts                 | 2 +-
 arch/arm64/boot/dts/qcom/x1p42100-hp-omnibook-x14.dts     | 2 +-
 arch/arm64/boot/dts/qcom/x1p42100-lenovo-thinkbook-16.dts | 2 +-
 17 files changed, 15 insertions(+), 15 deletions(-)
---
base-commit: f7d2388eeec24966fc4d5cf32d706f0514f29ac5
change-id: 20251030-rename-dts-2-14eb2cadd05c

Best regards,
-- 
With best wishes
Dmitry


