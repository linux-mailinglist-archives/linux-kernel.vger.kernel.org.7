Return-Path: <linux-kernel+bounces-811340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 916D6B527BE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 06:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 179B3189979D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 04:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B3025A34F;
	Thu, 11 Sep 2025 04:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U/H6jqJN"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48BD25B1CE
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 04:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757565231; cv=none; b=r6M6BAT6PYfqOtr3etCCr56Kkj89oXUxikfF1Rseas/Mo6oByimbInTbvnjgqvFhU+Acr5cgn3d0qf4t5suYqlUkGmI/K8qn9nr9wk8+keSykrJHMARYrjs1zuwQxjd4+NULF+gsbM4gZIB31TYP6SqU+liIK7xocc0LDTgJ664=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757565231; c=relaxed/simple;
	bh=mx4d1AM06bO2S1IONf8a/pO/zrCQyz3bPkPpHgejOOg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jgjTq5dmHLOUsfdjt4cRxD0elSkEu0zefqamnprDTc4TqevXT/1dfidFsOaSWBbnsPDi20ZoOx3JRppiZzKuwcx1VyviUOaI2klx8e+xe/xwpxOP0sWxWTtO3LjF1LdxGxDboO9PPUz2Pi4NLr5RbyF4QMsgQ4neyFldOcPThRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U/H6jqJN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B2J3bE003255
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 04:33:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=kcphrBZS8ap
	5SJ3Zmdf0DUuuF1sTIEHZQlGDR6UGNHQ=; b=U/H6jqJNTXVfBG/btaflFrby2c5
	7fuRKskqtI9rpIgBmNvsFCtvNfPhQ5mKFn0ba4eTLfDFaRuyh6Ao4AlNw5AZdP0E
	k3J1uF7NNnGizXcDrZ7q8c8t5j/7C2ySA54Ro6r2jnXz9JYMjFQrS6ORPmJC+w+U
	f8lK1Uzy0atFuwJ3TnptBSy1bgk8EvFkJeW3tN0oKxxR0Wm+0hOfz2oFpymQCU1p
	9rFjxieKXS44b5rmOjzYAgP2GbPpq2+gQV8hLzV2VxaQvIayZfVbnwvBiCLoCsUv
	Obz3BPq13zNqwh2GtYiuG6WlsyNc/RhmhMx08UXKcWiYBp+2ax0KjfUoQ5w==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490db8p989-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 04:33:48 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24c99bd543aso5540545ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 21:33:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757565227; x=1758170027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kcphrBZS8ap5SJ3Zmdf0DUuuF1sTIEHZQlGDR6UGNHQ=;
        b=j3Jm6q9zUVIDinLjZGrz2G9Ch8tPFTz6Qmlr2QBXsc8ASTG8RgxFHhpPsPp8u2F/Gv
         fIWBSKXT0ZdGavIkF0tB18VdDfO526btXkQn8C80YuUE6khRneg7ejYjUh7zu6LqSG/J
         wHVPEJQ68wOkrObn4S6+jB8wRACIRy7Gcnu2fWm/6IqxoDj2vhCEFjOiFXMUIRHfxbWX
         xNy4NxtEstryz1DT7us8LJz6e5vqnRZgxF52w4aLdIZ+zNujiqx7jwEx6lBbDX/wlRGS
         aJvWhfeajTAksr6TrP2n268ilFvGZUAuAjnpOc6Yuj5Qz8GZLqv6ugFVI/XrCqlCbrgU
         HC/g==
X-Forwarded-Encrypted: i=1; AJvYcCXDwiGTMsbcnBB639yGvXzoYk/uzZQKSCCAulGlu1zXbTYZ0oD3bt52LNlRW9TWn2mnZnUj/2Msbf7HjKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAlfbjqpqhIdtsOBbnHAHXRHd+PnjxmidK8jS5vQPsmR/sDCE5
	5+l4leVwQ1ZbEEay8AXmwGcVtXSWCP8dt8G3wi4I0PcTvbCj7aHP9I6DXw1VEOdrHlbNNhFp+kk
	nDL0Q9BRFnM6blnSX1LjZL5XfhV7y9lGSKCXqZ1dW7caFPPkjxHM1gfZKJDyxbNML4Hs=
X-Gm-Gg: ASbGncuGoceNrqeWvYRz+vnhg7PP+8a+JWl4Zw3soXsThIi0HRmYnckz2UTpUVKyCkR
	SzqYzAISiclZYAwVC9HzTPmhZ4T6yZgKxG8MTItPlh6qfgXt0zwaIjNb5oyHSR9PbDg6IiVVPXh
	VGimJVt2lsTZjSuzG3617QfxfFa/rBpPKSuGA79hVSp6uwY7MOPT/PsUS6tT+AmdxxHWPxxIhsJ
	QEIgHYanE+Hd7LopwCZj0eM0IFSJ139D2QqXp4U2Y1A7k1pkuZdP/U3FtNUsv1YFPyrS+08tcjm
	U0tKA0VAC6NOnOHzBsMKFPxHbQA1zvbgjIbUrQPpjx7Oqy70KNag+RWQ6hF7Vjn0Rr6triVlzvP
	W
X-Received: by 2002:a17:902:db0d:b0:25c:2ed4:fd7f with SMTP id d9443c01a7336-25c2ed50044mr8373355ad.42.1757565227078;
        Wed, 10 Sep 2025 21:33:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJSDLFBIfEII/dWtZuLvluQE5OM8yus/jL1cVR398t46tsI0mtRTv1Sd8hk0JJ82ColwGboA==
X-Received: by 2002:a17:902:db0d:b0:25c:2ed4:fd7f with SMTP id d9443c01a7336-25c2ed50044mr8372875ad.42.1757565226545;
        Wed, 10 Sep 2025 21:33:46 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3a84a46csm4323975ad.91.2025.09.10.21.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 21:33:46 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
To: andi.shyti@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, gregkh@linuxfoundation.org, jirislaby@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org, broonie@kernel.org,
        johan+linaro@kernel.org, dianders@chromium.org, agross@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org
Cc: mukesh.savaliya@oss.qualcomm.com,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: [PATCH v7 6/6] serial: qcom-geni: Load UART qup Firmware from linux side
Date: Thu, 11 Sep 2025 10:02:56 +0530
Message-Id: <20250911043256.3523057-7-viken.dadhaniya@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250911043256.3523057-1-viken.dadhaniya@oss.qualcomm.com>
References: <20250911043256.3523057-1-viken.dadhaniya@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzMSBTYWx0ZWRfX48XyYed+o/+G
 bumGlqwP0DIJVV85OMp04T6713wW7sd80xV1RGKKw0d3FTU2IhRAHkxv8tqstUvWawuVA2C/h+c
 Ky6fP+mYGXRYnG6ADvVkxFD7bie/C1xgsGf92dfKGYiLbwUL7FR34LfYHcTtyDSyCun5yibOCCi
 eBoCb06678vVfhfNWk5ezaViC1lDEPEY0qhq4P4pBoKqJ/7Jc48zYzJmY+MPhFb5cwXPFJucYrS
 UOa5U/0EzypDLJcWCutU5mYkHj/hMVVV7hWIV6PVWlrupMDPiwz2R31x2vbzIv+FOioJ4jki4zQ
 pGa4aG6Ah++eTNKL0XuwUI4JonfJ15lT0yR0vRnq3sipZbGYdhgwh1y+wSUy11JGwh9NQHTelCh
 mfEUmgxC
X-Proofpoint-ORIG-GUID: SzufCgFJp6Zhevx41kMOB8rIBa53wS8n
X-Proofpoint-GUID: SzufCgFJp6Zhevx41kMOB8rIBa53wS8n
X-Authority-Analysis: v=2.4 cv=VIDdn8PX c=1 sm=1 tr=0 ts=68c2512c cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=9JGZuxy38fRfBSF6gCkA:9 a=uG9DUKGECoFWVXl0Dc02:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060031

Add provision to load firmware of Serial engine for UART protocol from
Linux Execution Environment on running on APPS processor.

Co-developed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Signed-off-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
Dependencies:

This patch depends on patch 3 of this series.

v6 -> v7:

- No change.

v6 Link: https://lore.kernel.org/all/20250822072651.510027-7-viken.dadhaniya@oss.qualcomm.com/

v5 -> v6:

- No change.

v5 Link: https://lore.kernel.org/linux-i2c/20250624095102.1587580-6-viken.dadhaniya@oss.qualcomm.com/

v4 -> v5:

- Updated the email domain from 'quic' to 'oss'.

v4 Link: https://lore.kernel.org/all/20250503111029.3583807-6-quic_vdadhani@quicinc.com/

v3 -> v4:

- Add a patch dependency note.

v3 Link: https://lore.kernel.org/linux-arm-msm/20250303124349.3474185-10-quic_vdadhani@quicinc.com/

v2 -> v3:

- Load firmware only if the protocol is invalid.

v2 Link: https://lore.kernel.org/linux-arm-msm/20250124105309.295769-9-quic_vdadhani@quicinc.com/

v1 -> v2:

- No change.

v1 Link: https://lore.kernel.org/linux-arm-msm/20241204150326.1470749-8-quic_vdadhani@quicinc.com/
---
---
 drivers/tty/serial/qcom_geni_serial.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index 0fdda3a1e70b..ce5cb97d60a7 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -1184,7 +1184,13 @@ static int qcom_geni_serial_port_setup(struct uart_port *uport)
 	int ret;
 
 	proto = geni_se_read_proto(&port->se);
-	if (proto != GENI_SE_UART) {
+	if (proto == GENI_SE_INVALID_PROTO) {
+		ret = geni_load_se_firmware(&port->se, GENI_SE_UART);
+		if (ret) {
+			dev_err(uport->dev, "UART firmware load failed ret: %d\n", ret);
+			return ret;
+		}
+	} else if (proto != GENI_SE_UART) {
 		dev_err(uport->dev, "Invalid FW loaded, proto: %d\n", proto);
 		return -ENXIO;
 	}
-- 
2.34.1


