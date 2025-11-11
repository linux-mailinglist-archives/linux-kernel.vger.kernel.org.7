Return-Path: <linux-kernel+bounces-895348-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE191C4D90A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 13:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8AA73A8E1E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB75D3587D0;
	Tue, 11 Nov 2025 11:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MPUp4iMn";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KEejvVpx"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4AAB3570D3
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 11:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762862359; cv=none; b=owMCWi3gm4miTnccyBLRiTlwyTrr8imkR30VY9u+Zv6yYsYBYDxj7xAIJqAwHSyBEV1hNs6SOTA+VPoIAdkE+ZLul5CzmaES6tpKVzHHSKaj/BpG/C6p4wN8riadVymEquqIPLhcQEgO1DQ1fuOhgvawxCf0mXpj64rClG47h1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762862359; c=relaxed/simple;
	bh=1ccshnWeHcL7yrhEfzUWoVYUaknKpcWbRsjPVmbpKYM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dyqqlq50VdXi0Q4LY6euRIVn4XnQSAmrpRIRd4RsMN55j+Davlhj6IKFReQg5e5mKkV35+KMocOF2n3fAE6YbMbSt+SSp0g6hcpSKoJ6CKWRATVvaQxgqkG+3CTE+fh12qbA+V7uv1Q3G/qBm+KI9G7pL6rAuMNT0lzHNWJe6yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MPUp4iMn; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KEejvVpx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ABBGAX92165131
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 11:59:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	oPpW1Ve0PMp0S1/wQFsf61I53LtheYEm/caWUgRR/08=; b=MPUp4iMnneZ7ci5E
	cKTJGzuXgkIL3asFgTjLqjw5A+kKEdJbxPMidQcC1JWrE8SSak6JsjEtpmEiJu2Z
	tPDlmPXKjXZms4y9dKcDB7J6Hnpx0A2fqZprMfEKHvxORUjYY2po0tSUlvuPjcED
	JNv49CEMtYvXJsXQ4+IwslIrfk7M4H7UPgUYNttT3TAAuISEkuLSOXrvVyTz9P+e
	PO+jlBiGVbwJzw5VW1mx3kVKVxtLKo0HoytwFWcboXEDuJkxM3ka5odENWJI3hEq
	mCyVQqZ8PfnmE5OVBJFKWeB5JZJ8uxx0PfLUNcXqHnzr7oAw14KMcnN5RSaTlAoR
	qd8o1g==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4abxhhh675-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 11:59:17 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-7a432101881so7506507b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 03:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1762862356; x=1763467156; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oPpW1Ve0PMp0S1/wQFsf61I53LtheYEm/caWUgRR/08=;
        b=KEejvVpxwo7RgqqbjisT617A97XWFnwED+YGvArhpPoK/ShPl2X5+h876+PYFAUvua
         tUBKfs3JIYDcTQuJbcPvU6cwdJW/6njzJ+TTeJ39LEX35OMwehXLusnnkfuQDnpofbEd
         xCb2wH0jfolG3rXULbsXJy4Fsycys8f8zA/tVGamOm0O19uJe1b2oNL7nXgnM+9eETcL
         iLH0RbGuvsQ/eucV0OlP3pPMbs6PVGLu3q6Zie1HKtngzG7M+l9aQzp2mX9FX5ASbH4g
         RBiN3vKOxE86XgFXNXhsOv6pjeViN2EJSUWJwu9KXLTHtsNnYvTmiAWb1ZSblI20KnZW
         /xxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762862356; x=1763467156;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oPpW1Ve0PMp0S1/wQFsf61I53LtheYEm/caWUgRR/08=;
        b=okCv0ne7tDRLcH0mC07WF4SCjr7jLIb1tSgnDq2NXGC42adxwsx/yIcwLE/Ovff0GY
         CMgZfhbJMaAwOtpLcGdyXSzKN8/+XJUNVJKuQ/trLPB1Q/1Kq50CMLK4VYRcE5BV+hbK
         sCqF15zP0W1CPWe5DbSAIoEZr3rnNmcXIvOOjWIQtv0w4CrxVxezha8c2hqmdSguMKcM
         ZdtlK8LgCyEOYC1mSRZ2i65noXWzVnv7vWvtxShO+x+ZrFvbG9HoYnZ2aIq4q7Tw0aEQ
         70PtipRkIdy3oMxKUFJtBc8xqghgTj21Nxm6V/PoTkoA6aHTWsP/ArfQmRlIv8kTVasE
         8vAg==
X-Forwarded-Encrypted: i=1; AJvYcCWOmiELkI+MkrOCk798wA4G/Nqo3jqjGrPigVs19IpLCAolp0pR2s9+aapnqsytfixrz7+WvVgHfEo1+z4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRC4+JlVVptjvU/K2eyjmaeM9naCP9hkPRCn1kYeGByCNqs04r
	1I/Xy978+Mdo28jmenJ7kFT4LxQg36CFPQQL7K6wUuuFAUiEHzh7ZYphRrgnt6gYoO9A8YVstgt
	u0L+Nk+n1SOci9Xojrq9KLu3AAqpaDuvqc89xb8+Mje5FWVgRhlrhLq0vYam5W8ICTUE=
X-Gm-Gg: ASbGnct3ceA/mk7MHtaLzVpUNw3yRvjRcN+ZSSS05WPDTaOh7t38/0SuPkfGx4FDVVJ
	DF1JrPQTxspPLGcNUi9jTNGrqOJoalC+6cjfFEz+HxYeFz7ZfgBwgSFAlX/lWQ1pYGwN+BjkNgj
	hi++V/BKWoAWPS/sf7Jwqz8hroHAwOdZRlJ+bH09P+DcqNKc/leTlqpHzngZyrWLlq14lahU5hB
	Yx4g8SaiezBa5136eXQGz/VkImJzsL2o+iN4kZxToWKDuOuiOdrfP5pqMt2mqdDEK67W2gkql8k
	+wbGfuzxebdryDZ2txi9CJBADCaaPTJxVErfSm1ThBh7R/ZkduoLt/3rdWqKfvAzpemTeISPSWi
	xpkW1qr39p8kQU5pJFXZRlTXPBWn9GvY=
X-Received: by 2002:a05:6a20:a109:b0:2df:8271:f08d with SMTP id adf61e73a8af0-353a11b0de1mr16056459637.2.1762862356431;
        Tue, 11 Nov 2025 03:59:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELzwwan0MKKafefmWABWYqSGEcCE5nqRTM1jX7qZAnghLB9hDQQ5qX455Hzo7ILMkz63NIRw==
X-Received: by 2002:a05:6a20:a109:b0:2df:8271:f08d with SMTP id adf61e73a8af0-353a11b0de1mr16056434637.2.1762862355949;
        Tue, 11 Nov 2025 03:59:15 -0800 (PST)
Received: from hu-afaisal-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-ba90307193fsm15420333a12.38.2025.11.11.03.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 03:59:15 -0800 (PST)
From: Khalid Faisal Ansari <khalid.ansari@oss.qualcomm.com>
Date: Tue, 11 Nov 2025 17:28:56 +0530
Subject: [PATCH v2 2/2] arm64: dts: qcom: hamoa-iot-evk: Enable TPM (ST33)
 on SPI11
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-arm64-dts-qcom-hamoa-iot-evk-enable-st33-tpm-on-spi11-v2-2-101a801974b6@oss.qualcomm.com>
References: <20251111-arm64-dts-qcom-hamoa-iot-evk-enable-st33-tpm-on-spi11-v2-0-101a801974b6@oss.qualcomm.com>
In-Reply-To: <20251111-arm64-dts-qcom-hamoa-iot-evk-enable-st33-tpm-on-spi11-v2-0-101a801974b6@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Khalid Faisal Ansari <khalid.ansari@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762862346; l=745;
 i=khalid.ansari@oss.qualcomm.com; s=20251105; h=from:subject:message-id;
 bh=1ccshnWeHcL7yrhEfzUWoVYUaknKpcWbRsjPVmbpKYM=;
 b=suDVvdfm169KfWv+hJeWYdgeMdZJ/j/YL2lraBBC154ZEcUMxMDbDY8gA0qcS/VkvXQYq8gsF
 4TtdrZAi1c6CcllYRnI3PvZCG+wJLgAuq9D7rKndV75zkz1OBp+Jfi0
X-Developer-Key: i=khalid.ansari@oss.qualcomm.com; a=ed25519;
 pk=eBXrIUgTWV0cgG+GsNeZPPgvj1Tm6g9L2sfcoxMGrKo=
X-Authority-Analysis: v=2.4 cv=Pc3yRyhd c=1 sm=1 tr=0 ts=69132515 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=PNAbdjlqmVCGte-Ijy4A:9
 a=QEXdDO2ut3YA:10 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: cDr7HLrD5x4iX7-FhD6YapZAuO-cme90
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTExMDA5NSBTYWx0ZWRfX4GkTNpxbm0rB
 NSnvdf8BzXPXMWU0MByPRSty7icpXnO62tLw41taYWs/MklOUh1lX17jOoI12MdBgp2qff5eSXV
 vZ/Ex98ZnqI8SPPpHrYgkwsJhhb2Z2HIf+GzMFjSR7C9hIWn3xolvpiu1UzXxWKOKMIeGT5PCWo
 Bv/4Jnec7ev3EFTxsXAJDXcY3SdvqNtpEyvX6MLn2SL4D2uSBZBXnqgSQ1h1ojE0HuXSEhy4EL0
 Y09r12X9CdIYKjk9ZMbqHHZdkj5pk8CHUKPieIRIs79W7gh53semD9QJuidrkhfhm4h27e5FL0/
 3NQl7iSarbYh1Ki76rVyoFXXRpl46qWjpc3rs4Qippc5xMOYuDIm3XUWRvufQTZfqFo+qWn16Zx
 Yy2z78oRYnDJlNpMIe0Stl6Q+eBTfg==
X-Proofpoint-GUID: cDr7HLrD5x4iX7-FhD6YapZAuO-cme90
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 bulkscore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511110095

Enable ST33HTPM TPM over SPI11 on the Hamoa IoT EVK by adding the
required SPI and TPM nodes.

Signed-off-by: Khalid Faisal Ansari <khalid.ansari@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
index 08465f761e88..aecaebebcef5 100644
--- a/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
+++ b/arch/arm64/boot/dts/qcom/hamoa-iot-evk.dts
@@ -921,7 +921,7 @@ &spi11 {
 	status = "okay";
 
 	tpm@0 {
-		compatible = "st,st33htpm-spi";
+		compatible = "st,st33htpm-spi", "tcg,tpm_tis-spi";
 		reg = <0>;
 		spi-max-frequency = <20000000>;
 	};

-- 
2.34.1


