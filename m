Return-Path: <linux-kernel+bounces-828813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE95BB958CA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 13:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6380E2A3D9F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 11:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0321531197E;
	Tue, 23 Sep 2025 11:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U5m1fhyk"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A909330F554
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 11:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758625339; cv=none; b=QlqBojt88QQhwa5QYM3Yr1rgLXY5ysdxiBwM5jJ9e8X7rzw8GzWm15BfybOz2gzMt+Id8v0ln2xUszge+l9bmhrfI5RQfRL6+LCq88507kYkzJGqwAhLNN8ZIqLwqyVaWjprXoo/l7LogC1CzgZS+q6xoG266mifciEymCqLaWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758625339; c=relaxed/simple;
	bh=nmg8ZlcYEZMG3b3USmC8IWsN1nAvQ+q1W6R0Z70TWqg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KvsIoKZUX5kXZCgtj1EOamxdPjKOcywtM9x0RAaiLsTzt+ONJTm3IachaJENxqEb3L6jtHKdcfPbXhIhVISgAoYjwr316DNIVaqygE46HH3cx4fuLC22fWB6pGN8e8HkLgYWzpDETq3ZXPN5hnMxiZxEM7DG7oapbiWrktHNFzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U5m1fhyk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58N8HFTg021013
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 11:02:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	bggJiQ/iD8KdHvRZgnHspKOOae/kK+TXLCdGyJ5mH2I=; b=U5m1fhykudyq96cT
	uIdvTH9hPwm5C/BfvYzxoI46mYv+5gqwcRq/uxb3ZM7Ilu87Oee2Rb3ITL5RryyW
	LKOGsroRx80cXk3Iq2YzMibp/NSUAzx4iMlDiYqYrBW2NEReMR4OlhPCuiNH3oMx
	8SqD+kbbzd/KSJO9vmddQA2Ou0/PTv8JwStszmNw6z+L8Gahws+dJdTNlo5p2ZrS
	wemUuOaZPyElgFAU0jj+iFJ7A+IMqkpiaUEgiWsBVo+p3CYfrJujpsevG4ju+RPW
	R9UcCWFHETG4d8WCLAyGCDyp0h98MH8XUuRBQa9UqVkbLwJeib9gafdAoiULC9AM
	9DRxqg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49bhvjsjaa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 11:02:16 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4d374dd29d1so15623501cf.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 04:02:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758625335; x=1759230135;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bggJiQ/iD8KdHvRZgnHspKOOae/kK+TXLCdGyJ5mH2I=;
        b=kpHxG6XaUDUMD8/xwCpnaH+eOkIS9vBL61WltXW+AjkNAe/KsQGpbi9g5+pe74RhLH
         YGE94ozao3eREk9PAukZlAB3bKXdpocveke/QLYnSZQ/LhF1YZEbbU3807+ktlUf/zG1
         jzhIbfJvVsrwju5rgkydfzlNY2emnldCRsbLQngRFbsEkSuB9vednhrvhCXv6pjADBvE
         qb19XGtDLXgD7B3JR/7FYMjxcU6LwpKpz23OzBJWvEqlc0okdMXXNqOH86G/9EmOxpsg
         fAK3UmF9V2M6dbBynVWrPqTQlEBrtNxY0+dmrgJRsicrQGFRLKW5HsAtRY1YIUTNKzCt
         2Xew==
X-Forwarded-Encrypted: i=1; AJvYcCUFOjOp2UqvcAUqbQ9a8uQ6MSlkRfnT6j1Y0bSByek4V+916v88sZ4slaUFsmplZ8aJoRkTTDEXo0kyBAw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxstWezfwIieDlHU0WlcOjOBOkv73PsAxNXwOTIgjm/t9x3Hmx4
	1tHDFCs5VV6xv9flvNVO5ZiZTVzHtf1iaD0gyVyDYMbVsqZtiIUMutb0UgRIK0ZydvGj+iqy/PY
	L0yLtgfyEccPMOOLeKd8gMvAZlt/btNKSuWjBj8IGkt43EAmL6l+2tdrgekY+OLiJsZ0=
X-Gm-Gg: ASbGncsVJ+otCer6tXTSaSwaSd9WALIWZq26TlJka+Rrs/lSEa+C6w/DvVBu0DO01mO
	W/SMM8sLm5D2ybDkMY912Na2i3YFBCfcNLCOyhmGboGU3Cmtg1J1dqeugMKTXxpbFZaHFdykPOB
	ZaWEmYsrl++BWHndmLkZRSNCOEUnhNRTXaaV6HBt4NHS465BkmWOfaxfRNj3nHjqi3xbWo4MTbo
	vGqK4mQyBtih4mPA/6jRrZlQLSuRJEuhzqG9nkj/YUzw9NCiVMoJLRsj7uhFROF+4b702wd4smR
	TBVu1ZBGCkA7gOc1MpNzR/r+92w1AcBSeCCo3wdIHQ6lySu0VpI5kl6wCp7L1w0vT81wYDQ3mfk
	4c3h4MVZG4ltkIw0PKuDizPHX7v3YaCmlxJZ+m5tsLI+lMtsPh+eE
X-Received: by 2002:ac8:5a47:0:b0:4b7:a6e7:655 with SMTP id d75a77b69052e-4d36f9242d7mr25932081cf.52.1758625335475;
        Tue, 23 Sep 2025 04:02:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJM2wgAB4zOJpUGy2PNrM5r0tqSOwBh0Qq3+wYbYrFPr1pIDnxhW6YrxdaQ/6gsBsHXah5uw==
X-Received: by 2002:ac8:5a47:0:b0:4b7:a6e7:655 with SMTP id d75a77b69052e-4d36f9242d7mr25931201cf.52.1758625334760;
        Tue, 23 Sep 2025 04:02:14 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-578a5f4537csm4075975e87.27.2025.09.23.04.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 04:02:14 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Tue, 23 Sep 2025 14:01:56 +0300
Subject: [PATCH 3/3] arm64: dts: qcom: rename sm6150 to talos
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-rename-dts-v1-3-21888b68c781@oss.qualcomm.com>
References: <20250923-rename-dts-v1-0-21888b68c781@oss.qualcomm.com>
In-Reply-To: <20250923-rename-dts-v1-0-21888b68c781@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1200;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=nmg8ZlcYEZMG3b3USmC8IWsN1nAvQ+q1W6R0Z70TWqg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBo0n4xfCzTnIfaUX+kBEtJbkW6TRmEq6I3wAvIA
 QGorh2bV+2JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaNJ+MQAKCRCLPIo+Aiko
 1ZKsCACNAh4NZx6Oz1iqHNrJ01LzIFu2mI1rslysPPaWrGwe6gCbKSmVtRfPpeaE+NJtvGOo9BH
 nl8NDnCkh4BqAKWqAkcCdw1ngwSBoHlK1Ipy4xtl/Wj2Eyat/U90v5eAq2/JMLksG0hfytF0ifH
 QmhdPObBNF6gFi/Sye4OcevWbEJrpc4ZGQfWK7VNRVad1tCUvLd7OIBn9l7PpkCs1XW5mEmi8ZV
 53UonGU8mkodAq2ibyJHlzD0nZNxE+E+/mTxChNdaHpv5r2FrfLTUrLJn96QLciburNEnqLQ54+
 JyBgUVOf1sU+SOxdf4DRU40OdaGp7qgcpgHWJSfR/zSAw4tZ
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: SrBsEXZh5LESLpnDiW3qDQkz8AglYKA4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDAxMSBTYWx0ZWRfX60pecP+RdETb
 HUcmDtk7j0ViReom15F9zIWPNzVwKwkrK5sCC2r6xDIvFgo+9VPw+cqW3iKqoRZ8/ViuB8bRCDL
 XLtq3HTQAJtUIcOdlwoBGngJl8cRGyVgK3jJ6+wyB7yzLe0cFZChOcc53epCJSgHwXn7N/HRNvf
 FtBuU8bG/ao6Dq0sLBT/qEdQ+M6U8Gn0/TV5MDYslnDTky/LF0omCXV9KccpYb2EJ4LTOMDaepz
 YFkmCwYgg1hmhFPyZHaPLb8xzUh3/wndoyqVxiod34ME5k9zRPMn4mBNKrnq4egL8cgde4AJNMx
 b+6U3lNMUnSWizfA+ndLprlJgzAY86/HJhzSgi+ePVcDH/GliCeXrtsFKVqEVIymZr5sQJjqgwN
 6oqIfp0c
X-Proofpoint-GUID: SrBsEXZh5LESLpnDiW3qDQkz8AglYKA4
X-Authority-Analysis: v=2.4 cv=Csq/cm4D c=1 sm=1 tr=0 ts=68d27e38 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=WswDrooiZKutORAMSMgA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_02,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0 phishscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509230011

SM6150 and QCS615 are two names for the same die, collectively known as
'talos'. Follow the example of other platforms and rename SM6150 to
talos.dtsi.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/qcs615-ride.dts             | 2 +-
 arch/arm64/boot/dts/qcom/{sm6150.dtsi => talos.dtsi} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qcs615-ride.dts b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
index 705ea71b07a10aea82b5789e8ab9f757683f678a..e8faa25da79f10e4c3b2849ab078e88b9b5d03ab 100644
--- a/arch/arm64/boot/dts/qcom/qcs615-ride.dts
+++ b/arch/arm64/boot/dts/qcom/qcs615-ride.dts
@@ -7,7 +7,7 @@
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
 #include <dt-bindings/gpio/gpio.h>
-#include "sm6150.dtsi"
+#include "talos.dtsi"
 #include "pm8150.dtsi"
 / {
 	model = "Qualcomm Technologies, Inc. QCS615 Ride";
diff --git a/arch/arm64/boot/dts/qcom/sm6150.dtsi b/arch/arm64/boot/dts/qcom/talos.dtsi
similarity index 100%
rename from arch/arm64/boot/dts/qcom/sm6150.dtsi
rename to arch/arm64/boot/dts/qcom/talos.dtsi

-- 
2.47.3


