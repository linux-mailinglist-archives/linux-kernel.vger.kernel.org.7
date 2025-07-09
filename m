Return-Path: <linux-kernel+bounces-723715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDA2AFEA3B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 15:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D7313A8ECB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 13:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAAD12DC352;
	Wed,  9 Jul 2025 13:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HmbiKadI"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3090292B5A
	for <linux-kernel@vger.kernel.org>; Wed,  9 Jul 2025 13:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752067752; cv=none; b=uhORBRImQQAfZSMQj5BCcC+yaoGjgdX2bZvjA8MipTv0F7iA3+KqBjeTJ9cF9/EnyBIWKlTYydBuQrhb+n3PG69a6HoOZFgwpil9OUuMMRXocSxoWCbn9dMme8S161NzGj9xYq0EtcbS32OG9ssm4u+N5hVR9k6/GxtGOfvLyko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752067752; c=relaxed/simple;
	bh=O1sRYtFIa91eRFyE169T7pwwXOo8vibbwjrf4WOSfQc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XnddJ0Jf8LA60wPpcuFCo7NaT6J/u4xs4LkBv6g/1ZOasA68zheMjix/j2MBdEjLyXniMI2XKoDr+kIhqaz4v+mykiq5MzLJD14PTFCxyM0MDbjRWl2sceJ/zehOq/MueXWRBkCuZAjPvDZsgMBdMBzZQdOISaNritMcur1qIZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HmbiKadI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569CobnQ016787
	for <linux-kernel@vger.kernel.org>; Wed, 9 Jul 2025 13:29:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=wExzXfGx7fVDJM1zX5REeYphpIZx0vWkU46
	ZWHHNWtc=; b=HmbiKadIKGp0fUVDC4eIAyN4bMw9PUvK496PeVSxZgvIQjogdZT
	B0vA65jF5+J9o0CMzfwATsVWtrSx5h6/vHGFQWzt0azxM3jWEavdF5Ug4DTHZOgc
	MJSqELwbtoL1CqaJTkFB9RczkNkAkbWe9PmKx7NPiWNf1iA+npHpCB3yATw+RaOx
	us3yQCsbQwcfCmG1SRo0NLat/nOh7rGtPYlMpZ+pI/4j5r9cfGHN69avZWaByayZ
	rXf3fX14mAXUIXf+AC/j5ENuhdXj3eX0197TxQY7M8kw8k4E6Lg4LPMDKQTJQGjA
	It+9RB/AWE7lVrQt9C02vxQHPt9rGjImoVQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47smbns3s6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 13:29:09 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-748f13ef248so4814584b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jul 2025 06:29:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752067748; x=1752672548;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wExzXfGx7fVDJM1zX5REeYphpIZx0vWkU46ZWHHNWtc=;
        b=EF0uo45iJRaas2RMv+/EROocZs27CR+GdV4lDRpt9aSCZlr3w2IP1fCwXVuseWb6yD
         uKpZpSZdczYxKo4Q22xzGL1cbZeY4CcALnikwJ9b6TzpwAnJd9TAm/6CzaABod3p3QMA
         vnIf7lRSXd1sYO0PJe3/INeOuLFgAoWVg+qKLG0Y8AKfxHTf9L5WYk8UTtmDXcKDxCw1
         hH1D5hIQY747PDbMnpV71jXYt4VQ019KsPutOa58xbFOxTtcWrxwQBcJGHVPkj/xMl1F
         F/5m2V3j2AjUGm90JMDHBlGTH1KnxuKEPkv0XZrmGz50uTdwEOzuFJ9xdjzygMJwrb3i
         mqOA==
X-Forwarded-Encrypted: i=1; AJvYcCVW/oTJvjMi+oHGst1qAN9wxbNuNOZ5hWcfqS91G9LdpHii2EUxg8Rn4dQyBNltJye889sMDPr4W77jqsk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yww7O6w66dmOVp3FmzSS1EIKBes6JK/sdZvLiX9yGmlEUrZahTL
	ZKYOMBXDBS47ngOsAg9m5BLcaraWaOc6r0mD91p2YGDV4/UDzAFrbFCI8UdWGemzNlYHHN65Ml9
	2snf7dGJtGz1RZ9D83B/dedLTRFThRsFQOlqCNuuO0JsF3cgPcEQXetLYFEAcyGphqF8=
X-Gm-Gg: ASbGncuHgqvZPKiP++ABlCscFPqI022w5UJZjj13zQ/Qvb2SnwysIBieXHv59zFe/oO
	4526Yx4gWdjbrs0wFT7jNeEHVtgK0J9iP2fjVpeTaAiRFurE6mma6XjkixlZxjxwUNqzF1o0l4P
	rzFQGbaIgPF8eX1YI+MkhqB7XxWBUZ/FXwxibFtOVp1RHHR8qOaMUMWMm+wmngp7z1Az1MST4OJ
	4UqpWy6VELwULH7Cn2gRCCmC8juWdM5cRbhG7bP7qYPPK1pB3Mu3zWoko1VCcEHCKACl+J4Zlmn
	dbh8yY5fR+he5sU/KUi3Y1SE0QejFVhczEQBoMgSeil9IijoOs25r1XACzVs
X-Received: by 2002:a05:6a00:84d:b0:742:3cc1:9485 with SMTP id d2e1a72fcca58-74ea66317a4mr4024380b3a.12.1752067748155;
        Wed, 09 Jul 2025 06:29:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzRHaHSO44BBzmOOKO6MwOJrBeEiWuMWa2dHzR3KNz7K+mwg+WYWP5MCNJ/+DbJj2XR1mU1A==
X-Received: by 2002:a05:6a00:84d:b0:742:3cc1:9485 with SMTP id d2e1a72fcca58-74ea66317a4mr4024340b3a.12.1752067747675;
        Wed, 09 Jul 2025 06:29:07 -0700 (PDT)
Received: from hu-kriskura-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce42a4117sm14062393b3a.125.2025.07.09.06.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 06:29:07 -0700 (PDT)
From: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        stable@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: [PATCH v2] usb: dwc3: qcom: Don't leave BCR asserted
Date: Wed,  9 Jul 2025 18:59:00 +0530
Message-Id: <20250709132900.3408752-1-krishna.kurapati@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDExOSBTYWx0ZWRfX9qmj1arnQcbA
 f1WK6WNdFRNbZToJmnwy3Xg28Cibdly2N1JlwX2CgMVUwZJR/3I5K2yaiEOZrE35PfAOkPX/Xsm
 IHZPEZHNqz18QeKFV0+csoMbBhFUuCig7oXGViH2xbfcNfemDuKUPkQCVjAJSq/PrY6xaS07L0Z
 Av2bp9mptPcnXwZ6t/q05R9+7/35cXSiFWaJlYmgARGia117IQQUwtzXnK0uPQt82BIp4++o8L1
 3p9l5d7l/AEHbIkBrjD1g3hmXaVmdiTNpS4CpaN8GM2FVfLcPgkMfnapULc2N2UBtsVp8hNCrwN
 FEnRwYROCKLSkjZYdJkApBYDDwvQl1a0Ny5fH9gVsxwU1Ve5wsak9/h+ZE/zjIFjnry+i9O+NyF
 Aq1Zsjfg84gvcFAeabREfNEiuVhZc2DV/6f+FQkEj0o5hgYBItel6Dyxa/kq6FZSIJPJp6WM
X-Authority-Analysis: v=2.4 cv=QM1oRhLL c=1 sm=1 tr=0 ts=686e6ea5 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=jIQo8A4GAAAA:8
 a=rzSUB_1TqBMNDQYVAdkA:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: CDVJKZ5Fe_QsRrhNOfcM7r3Brc_BrcV9
X-Proofpoint-GUID: CDVJKZ5Fe_QsRrhNOfcM7r3Brc_BrcV9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_02,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 adultscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507090119

Leaving the USB BCR asserted prevents the associated GDSC to turn on. This
blocks any subsequent attempts of probing the device, e.g. after a probe
deferral, with the following showing in the log:

[    1.332226] usb30_prim_gdsc status stuck at 'off'

Leave the BCR deasserted when exiting the driver to avoid this issue.

Cc: stable@vger.kernel.org
Fixes: a4333c3a6ba9 ("usb: dwc3: Add Qualcomm DWC3 glue driver")
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
---
Changes in v2:
Added Fixes tag and CC'd stable.

Link to v1:
https://lore.kernel.org/all/20250604060019.2174029-1-krishna.kurapati@oss.qualcomm.com/

 drivers/usb/dwc3/dwc3-qcom.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
index 7334de85ad10..ca7e1c02773a 100644
--- a/drivers/usb/dwc3/dwc3-qcom.c
+++ b/drivers/usb/dwc3/dwc3-qcom.c
@@ -680,12 +680,12 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 	ret = reset_control_deassert(qcom->resets);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to deassert resets, err=%d\n", ret);
-		goto reset_assert;
+		return ret;
 	}
 
 	ret = clk_bulk_prepare_enable(qcom->num_clocks, qcom->clks);
 	if (ret < 0)
-		goto reset_assert;
+		return ret;
 
 	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!r) {
@@ -755,8 +755,6 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
 	dwc3_core_remove(&qcom->dwc);
 clk_disable:
 	clk_bulk_disable_unprepare(qcom->num_clocks, qcom->clks);
-reset_assert:
-	reset_control_assert(qcom->resets);
 
 	return ret;
 }
@@ -771,7 +769,6 @@ static void dwc3_qcom_remove(struct platform_device *pdev)
 	clk_bulk_disable_unprepare(qcom->num_clocks, qcom->clks);
 
 	dwc3_qcom_interconnect_exit(qcom);
-	reset_control_assert(qcom->resets);
 }
 
 static int dwc3_qcom_pm_suspend(struct device *dev)
-- 
2.34.1


