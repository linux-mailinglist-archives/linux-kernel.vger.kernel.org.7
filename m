Return-Path: <linux-kernel+bounces-887713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD80C38EF3
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 04:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D2E54E491B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 03:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226B521D3CC;
	Thu,  6 Nov 2025 03:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EdLAfYJk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HbcT+XQK"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9C11EA84
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 03:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762398055; cv=none; b=cRC/HH60L9+smQg4AYAES6Cv0Sps+7o94V5VHbXHZ1cUaI0E/E48bEchL3Jr4OybNaRjpk0jauSIPoYYtHTAnvu184BWjekx8ssiynJQLybxMOaCwzH/Wxz0P6pOqXeQH+DEewsMNdjqjF0pqtSUmrnzApwxCREY8Fkts8QFrYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762398055; c=relaxed/simple;
	bh=YK1LS/nDg6RooL2XQvj5xJvpZ2yxWM7TCRt02SGpA1g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Ve+oBWL4TP+KWqfbzwLHobfvIFnBhQVzeSuVWk2Fv5h2wiZvyCxMWkniqKw73S2Ie/hfly/Wlvm4fVd3jrrVenqoD4Ht1/rOriWeyGkZpLFylJgJ+XYJN9aF9OVSRsIpWoVne4E8kYyBPK9E9CYs4tQJ65yMjFFI3l7TjcCQccY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EdLAfYJk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HbcT+XQK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5A5NLXQQ2164514
	for <linux-kernel@vger.kernel.org>; Thu, 6 Nov 2025 03:00:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=Xp+eOpdBP5YViuKYG+hCDq
	2cAhMK9zpyuiSB/SJ26gI=; b=EdLAfYJkm0IyS1U0z6v/7o1DwWq7Dx4kTgHSN/
	eZEWQH0IekrxKvOXnG1oLo6jYM1rtH6x39/sIgSUM9T/Jd53eR6vqoSstl/NELSO
	KpiLhj6QIRkaVzewa+KHjdu4NbGj7PrrdngJfvf3hcuh0JRmrYAS92E0GpaWtOeA
	tUWwB4PFcwEvKf1fyVupreL3RVPtOeqtVEvT7QqFrXrzvL7/GsedTZJzjUEUh8G5
	2uN3ir6cfBxt5tqxjHfm2w/z7/re4jSCnwo4dVT6+WLUcktAOmrCeQ5BrBTD4HHr
	/MsaCQSgIW+bOnK10azM9IG6iAYyak0P9rmwzQBxMlM2diew==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a8g6erh0v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 06 Nov 2025 03:00:52 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7aee84f1defso666632b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 19:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762398051; x=1763002851; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xp+eOpdBP5YViuKYG+hCDq2cAhMK9zpyuiSB/SJ26gI=;
        b=HbcT+XQKh47XHlz4/4jMN0AqDVX//FBRR2/7eOGIQH954JGU4R1l5foUEyrD7b9o6B
         nNPfXYgLr2yVzj/wPgt/Ndm4c1azLLcdyo6r6YUKlw32KqalQaTTVhfxORDBSEIbZcZN
         azL8JVQb3r+cEn1PALGoDc5k5BNd9+ORRFuOcy3W013MDVJtfTrDdc08TaX3McqA0oej
         O29KTBcROu4U1kjk4lpRjz2XJ4O1NgrxKWGdLoXud2Zk4pZCWnQ5+cRPgqVjZ87VQVgu
         lwU2TAyxLIwtEyeMHhpUjj43r6oZr4sxomN2YnknxoToExPCBxku4yvKQX8Hmo85FbgD
         rmTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762398051; x=1763002851;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xp+eOpdBP5YViuKYG+hCDq2cAhMK9zpyuiSB/SJ26gI=;
        b=beCSRW9yPlE/8ujZkM/NfKCNTivfCgGPHopKBYUXneUAULtf9wYWSHciLy3a0DP3NV
         Ptelshz5LJLq5q8VK4Vdv+zgeEwAKaP17QHc/hheGaLyG2kVLSYF2fQ1Keox3QiIV1Yr
         sFng2WkFTP8bgevezsmgP/VdbcgYK7kkNxDK0lW02tLv/kQrLVkwP7vM6biFLYqQPRTH
         cdd7kiLOj8IjmMfHd1HWbLaBUXroOousz0OXagkfv2zYTvHhXsXDP4EuSuVW3YdZycM6
         zHT7QGbWhK9mk2aol+Qhv3tXV7HpjLUPqZkoFqHzXTn9Gp4s2C0FXgFwpr6piFoaeOiU
         7iug==
X-Forwarded-Encrypted: i=1; AJvYcCUJjaf2q77hZS0hQrIUp6WpO2xosfRWemEhn7mpnhpiRrWezfLVx/mSXxsc5IXbwsV3Gf6+8CSLvas2VIQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyBnp5Qg9NmTklcEsn4tJxPIEqfeZZLql0MByKyTRO0DlFAeLJ
	LKoZoIciKn2SHab7RtjIxKUCKpkUrKLRG5zIoJI40ONGWziFbbLACbQePidxEOt64JXmgdDc9dB
	dyw9PzJS6onLaRllpR3Agu7KG/hp2kutn/jjafnH9daDxa/Pzpi+bZIRZ2vDwdn/Tn24=
X-Gm-Gg: ASbGncuT7YqwrMD0Pi68S8tlDisuvxtgnmw7E5gJYkSUvedQXG+i7nyIYmWYqJ+ecXI
	50PMX4Ds5lo11N5KtctSUfVuimwJxUPButq67O6QyOU6TN/Rjw12Jw7CD1ctOwy7zhmlS8X/Ufq
	zJrbya3XiX8YpiTz87lX/ujoeBbSO22x4AKvnF4c/1lol359nNMB2JOfEVFnXgbJ0c22OBczWtM
	Q5xC4rAcoKZoUWkb1CGUuwei/bIcFgDi2slXx71FRl4/yU3CPVeayNluVz10pbFzJx5OSEBkHzR
	wHj+blt8W2iYX3hyiJSOiTeBgoZMfNHsx8Cjkr1RbS1H2jyXkSyYzlXDqGmkmLAs0U1FIHvKwW7
	OuTA3RRgYxvvTeOZd3AdSBixc/2tVw5yQtPwkDd8q7OBsF97a9Q==
X-Received: by 2002:a05:6a00:1489:b0:7ad:df61:e686 with SMTP id d2e1a72fcca58-7ae1f09d94cmr6631204b3a.16.1762398051090;
        Wed, 05 Nov 2025 19:00:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgwrrg7cp91QSvUVFSqI/IEjRGJMmXj5Dw11j5JffWyzYZoKZhr6Euy+Lve0sw8DvpR3/+Yw==
X-Received: by 2002:a05:6a00:1489:b0:7ad:df61:e686 with SMTP id d2e1a72fcca58-7ae1f09d94cmr6631178b3a.16.1762398050533;
        Wed, 05 Nov 2025 19:00:50 -0800 (PST)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7af80343b12sm894909b3a.31.2025.11.05.19.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 19:00:50 -0800 (PST)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 05 Nov 2025 19:00:42 -0800
Subject: [PATCH v2] dt-bindings: dma: qcom,gpi: Document GPI DMA engine for
 Kaanapali and Glymur SoCs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251105-knp-bus-v2-1-ed3095c7013a@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAFkPDGkC/z2NQQ6CMBBFr0K6toQZpARX3sOwKHUqjdpiR4iGc
 HdLF24mecn7b1bBFB2xOBWriLQ4dsEnwEMhzKj9jaS7JhZYYQNQNfLuJznMLC1BjVZZBViLZE+
 RrPvk0qVPPGgmOUTtzbjv0zZro+N3iN/8b4Fdzumqw+M/vYAEadGiUaR027XnwFy+Zv0w4fks0
 xH9tm0/eKmRFLwAAAA=
To: Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>,
        Pankaj Patil <pankaj.patil@oss.qualcomm.com>,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762398049; l=1331;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=VGiAXykF6nW9JWD/DX6DfJ9GU1iNRdm3YR11WtNZFPw=;
 b=0coQCqFLnaySDJSF7ZD0a+eqcoDPKj9Q1RxsWIBuTh1d17VVJgVndJK+onsi/4mJjZuQ4UFkH
 KxrSOkdU0vUBrrFrqpGjvrzsEtNcJ6zDlOl2mhrPoBSEV3NP7WVZjel
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDAyMyBTYWx0ZWRfX2h9sGdroL54C
 guwiziUzOOPplpo8Qaz3SZrZ/f494CYjnRMjZEk23yQRH3CSdXx4ITt2eGHYj7Q2YQsFLmtPA09
 Xerw3S1lki63UDsQkSiYKv23qb0fWaO/ak+9rvrXcJ3fDUUxUT1vLDyNc7525/SauJFuCKkY0p8
 nLdGk/K5np66jRw7bSZE+brfNONHJs1bp2iccbpB3QCw9UMmv/KsJaH55AZiKXbRx+Ey3lkCSrS
 SDjJUSnJp6A4wh0SZ//jT482BQvZPcDEejhBpgCSSBpcuSTGJySUFhMkhdJw0JV2gXdCc1cKMBq
 JWIZNfLxgTrAv97KhdMuYU8ygipfAqsvO9vYmcIpJnFfGD9tRUgfCw13WEp+Twuq4Eny0JxuqvC
 hJ+VpbHs89IvFjnVwoqwu7cl9QpiZg==
X-Authority-Analysis: v=2.4 cv=D5FK6/Rj c=1 sm=1 tr=0 ts=690c0f64 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8
 a=Y-Bf7sG_Jlmm6xCwmVkA:9 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: kjZq8gcCDjY0r1TqTzz1Xy7LfGej__48
X-Proofpoint-ORIG-GUID: kjZq8gcCDjY0r1TqTzz1Xy7LfGej__48
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_09,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0 impostorscore=0
 adultscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2511060023

From: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>

Document the GPI DMA engine on the Kaanapali and Glymur platforms.

Signed-off-by: Jyothi Kumar Seerapu <jyothi.seerapu@oss.qualcomm.com>
Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
Changes in v2:
- squash glymur binding: https://lore.kernel.org/all/20250920133305.412974-1-pankaj.patil@oss.qualcomm.com/
- Link to v1: https://lore.kernel.org/r/20250924-knp-bus-v1-1-f2f2c6e6a797@oss.qualcomm.com
---
 Documentation/devicetree/bindings/dma/qcom,gpi.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
index bbe4da2a1105..4cd867854a5f 100644
--- a/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
+++ b/Documentation/devicetree/bindings/dma/qcom,gpi.yaml
@@ -24,6 +24,8 @@ properties:
           - qcom,sm6350-gpi-dma
       - items:
           - enum:
+              - qcom,glymur-gpi-dma
+              - qcom,kaanapali-gpi-dma
               - qcom,milos-gpi-dma
               - qcom,qcm2290-gpi-dma
               - qcom,qcs8300-gpi-dma

---
base-commit: 9823120909776bbca58a3c55ef1f27d49283c1f3
change-id: 20251105-knp-bus-fe132f6f6123

Best regards,
-- 
Jingyi Wang <jingyi.wang@oss.qualcomm.com>


