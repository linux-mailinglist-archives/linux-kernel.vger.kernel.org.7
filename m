Return-Path: <linux-kernel+bounces-831472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F1CB9CC31
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 02:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31F724A0C65
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 00:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2744A00;
	Thu, 25 Sep 2025 00:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HUajbL52"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00631134AB
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758758487; cv=none; b=lRp2ZQTaF4lUs2KfMNz/UNCxaZupSTJtALJL15UALIOyFTlaR9CvDFUUY4mZRi5dOgk9LsXy+cLTM9saMppwu2jXUDMeQqf/TDqD8puMtMYzub5NOCbU5BGJkuzinb0FwyPIOcDJJWFjZwc3Qm/CMomfAnAvfIaK83f4QdooX8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758758487; c=relaxed/simple;
	bh=gSe2sTkMlehwOWAj3Y2GzOp6hubU+YrwNgErV3spKTc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IWo3wOOu784zjRxVLzxizQcRWfTUSX4jH0ZSd43WryiVK4yogq4S9uB53bO8/0ptY+IzNQJtMQ95QpFLvtVEA6hiw24a8qJWheBLX5NXQRmxFFVLHYVXa78mBtd93C/ZJW7qNJMjh94fTrmHlTibymShPgwbDmLv7Rw7XNhgUOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HUajbL52; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58ONobA5025518
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:01:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=h0/VaBuKZbPhV7llk3SByA
	RHcqJl0nQLuGkL0r8T90g=; b=HUajbL52dsjBR0X6fZqUhywMiafIQy6AbygzSZ
	dcAY+SKuAB7P1ikwvVw5DwTCxi5n+jin9jayDaSFlhMp+bqTSmxgXZuZTCpG9rG/
	KLnZXafI9okZ5Qt7Mb02HP1IB8E1mDx9CyJWr05xLHIe6Lbm1ss24hn1IjfmqhDH
	puF7F21hRbKY7sqqzlTPGzhdPY9XI4OvmT6tQuDouFlqt0aa2NbK9nKIaoTUJdXQ
	4xSK7por7o2uC4QBSdbTZyIkfsB077hVvja3Up6XU3kYAEAnH69EUUgOL7f6DcSj
	MrdwE1vCBwlRTqMIxx5SGmcPwV3yXhvhBDzUAcNDS+yW0BJA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499hyexe49-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 00:01:25 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b54df707c1cso227967a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 17:01:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758758484; x=1759363284;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h0/VaBuKZbPhV7llk3SByARHcqJl0nQLuGkL0r8T90g=;
        b=b+qHHIvqCKUE9rFnyStyy858FCUWimdSZToei2MwmWwoz9UQIsZA1J1GAN8sUkjHLR
         z24+pDD34RqTZL2tDCGKq9hM1mu8lGXu6Lo9ojtTCIXPTk2CxAHjq87dnm/GfpRbGLdk
         g0ZpjX+i58aeX7803KOXRNAUDRJRY05gvvQQfuizpyp4wfAMwb1hflidYqzWs4FrME3M
         INUSdxIgaaCnI9uejAZg6VvPJS4OTRwVnNwTJEYnWAO+RJWCwab1ateaAbwxm0F3csHd
         hMR088xUyT1ILTHPcPMsKKw1jIndVmMTEJC1ReF2oim/e5PcCNHT5YIxFj1nOnFxM6ZM
         hizw==
X-Forwarded-Encrypted: i=1; AJvYcCWntjOPePsLzv+hPXj75tsKvBN+1IPSYjywiFwclxQcrUdBvIL9eu45yRiv4WaU6dnL6IE1jP5KlOWK8Gs=@vger.kernel.org
X-Gm-Message-State: AOJu0YweyqrVHuu+rNZJUi8W7N8a/8allAvvMad2GQnNuzGqhX3sKPdU
	OxzRDMsPMPI3PStrB8mbxP7w1IAQLGiJekjodUHOhbrM20eo1EFiyHzCeiulhGzg7nHpkjmv0/S
	NnCTs72Ko5N5oHwwPAtwm2zOyC8yNUVy5aRtztYFXnrxqvwrpADeG2V3vMY3Ky02FZFo=
X-Gm-Gg: ASbGncuzCihnS2FlWomU/CVsxU/Eq3IhwKNk+WTstL8UHAQSUDXnp7TZS9Ecw1bVOeD
	T9Z6hSoia8aMCDZ8F6OaWDlLvMoSZTT/DneRgxrCv5jfQzTAyyw3Gq2I93KZmpRHfEoQ/TyvJAM
	FQWrHLP0gPmr8j7QKQznVOPYpaLtjEjKn0CtgicAfGNreqcSgqDdFbbVBK32z1WmXfuZ7Q7QkkQ
	qj/OsR/SXsQXmC1a8PJ6z+35cO6rM+msjBdU0i7Uyvv4Iv/4sr/vIHHJPqt4v0DkT1NI+nm/Qk9
	uJ9TJ515tVd6f+uNssPIDxmozxTRbS/42ssznZB9kBQn8INwRMLgWGaqbYfnl+WkGEe2z58bF6B
	FfJZvFUdI5xJZzb0=
X-Received: by 2002:a05:6a21:7e87:b0:2eb:770c:c184 with SMTP id adf61e73a8af0-2eb770cc4cdmr85805637.9.1758758484139;
        Wed, 24 Sep 2025 17:01:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEAv63UMjIFcouANiCEt3S6/Qb1aK+wQ0LLx3QRqdx4S1D1zTwEc3rhW3+Dv9QYaPvnprP4eA==
X-Received: by 2002:a05:6a21:7e87:b0:2eb:770c:c184 with SMTP id adf61e73a8af0-2eb770cc4cdmr85768637.9.1758758483585;
        Wed, 24 Sep 2025 17:01:23 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c55a1bafsm423152a12.43.2025.09.24.17.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 17:01:23 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Subject: [PATCH 0/5] Add Audio Support for Kaanapali MTP Boards
Date: Wed, 24 Sep 2025 17:01:14 -0700
Message-Id: <20250924-knp-audio-v1-0-5afa926b567c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEqG1GgC/x3MQQqDQAxA0atI1g2ojO3oVYqL6MQaSkdJVATx7
 o5dPvj8A4xV2KDJDlDexGSKCcUjg36k+GGUkAxlXlZ5XXj8xhlpDTLhk70j79xrCAFSPysPsv9
 f7za5I2PslGI/3ocf2cIK53kBTdZyCXQAAAA=
To: Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rao Mandadapu <quic_srivasam@quicinc.com>
Cc: aiqun.yu@oss.qualcomm.com, tingwei.zhang@oss.qualcomm.com,
        trilok.soni@oss.qualcomm.com, yijie.yang@oss.qualcomm.com,
        linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Prasad Kumpatla <prasad.kumpatla@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758758482; l=1345;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=gSe2sTkMlehwOWAj3Y2GzOp6hubU+YrwNgErV3spKTc=;
 b=d8EikvJp0rl+AOqQG8C6joTZKxp0/8ffP5mK5zQOjRpg6fffxqkObTRk2+rAGzugH/yFGjmA2
 9rfOXn1dChBAav6s94j5bKHdgwIeP1VEhw+XeQaMh7I1t5nRavVn4U3
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-GUID: 0921sOF5d3k2eEPPDpGWDAYCMuqYGxoV
X-Authority-Analysis: v=2.4 cv=YMOfyQGx c=1 sm=1 tr=0 ts=68d48655 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=JQyddCt1Ae9KdOiSsPQA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAwNCBTYWx0ZWRfX16DTWuLOjwGb
 v84Fe82nGkTheEr6cxO+lFlr5kLRJNrgCjda3TA8zRxeKu82aJteOinoIcLx3ELlOI9pO142Pb6
 //F+e2UWUcrhxLTDYMOAKw4tavaSbEnefUrs5edayhJA99kAFEFqofkVVsq3dMN5q+oA1V2mjBV
 aYm19kyPCJGOw3pDyqITDU+Z1VFyV1p5/jYZ9eXwh2ca8sPoQtyc1aDvkBJu6B6V96QlOoNjkqj
 rVTkdObtG5aDIMvr9Ttf0T6YniWC7Gg9iDtHLhbKW8lJB2Luu1c1VHmLo9pXqnj5pDcjsmDx6VM
 U3cDBRJTPJP+z0zb09/BsOk5E9bUUZppnyno+8NBy4GOBgK6/Db/Ay9hX38Sl9bJWEkHaCKrB52
 aZfQmUhq
X-Proofpoint-ORIG-GUID: 0921sOF5d3k2eEPPDpGWDAYCMuqYGxoV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200004

Add audio support for Kaanapali MTP boards. Introduces supporting
dependencies required to enable audio functionality on MTP platforms. 
These changes have been validated on Kaanapali MTP hardware.

Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
Konrad Dybcio (1):
      ASoC: codecs: va-macro: Rework version checking

Prasad Kumpatla (4):
      ASoC: dt-bindings: qcom,sm8250: Add kaanapali sound card
      ASoC: qcom: sc8280xp: Add support for Kaanapali
      dt-bindings: soundwire: qcom: Add SoundWire v2.2.0 compatible
      ASoC: dt-bindings: qcom: Add Kaanapali LPASS macro codecs

 .../bindings/sound/qcom,lpass-rx-macro.yaml        |  1 +
 .../bindings/sound/qcom,lpass-tx-macro.yaml        |  1 +
 .../bindings/sound/qcom,lpass-va-macro.yaml        |  1 +
 .../bindings/sound/qcom,lpass-wsa-macro.yaml       |  1 +
 .../devicetree/bindings/sound/qcom,sm8250.yaml     |  1 +
 .../bindings/soundwire/qcom,soundwire.yaml         |  1 +
 sound/soc/codecs/lpass-va-macro.c                  | 89 +++++++++++++++-------
 sound/soc/qcom/sc8280xp.c                          |  1 +
 8 files changed, 69 insertions(+), 27 deletions(-)
---
base-commit: ae2d20002576d2893ecaff25db3d7ef9190ac0b6
change-id: 20250918-knp-audio-6e84a8447fdd

Best regards,
-- 
Jingyi Wang <jingyi.wang@oss.qualcomm.com>


