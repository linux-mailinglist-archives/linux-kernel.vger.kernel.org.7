Return-Path: <linux-kernel+bounces-751332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E22EEB167CD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 22:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 201881AA34F5
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 20:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B733321FF45;
	Wed, 30 Jul 2025 20:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bl0o1Ypr"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749C021E0BA
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 20:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753908717; cv=none; b=Hr00qyOCr8QiZrIrSjeqx/Ql0/we4TkHIhbyAnSyxbJsBqQAZ+3x65euzo7Pfh9Tg+q5733Q6kDRC5bwcVzu6Oy1uxk+1V6LZ78f4w3s0iD7wygpWwS0DwkMOo6uOyTgzUG2R2a95VfcN+ZzVkfy+MfJP4W340PDlpZYUgld+yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753908717; c=relaxed/simple;
	bh=lNW2uz3OWthtQqMUaYd+aYMgM5tMDbL1PLPb4h1Ugro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=N4dtYCAeSAHDXDp6DT3jVRtuvleUbbVE3wzxncWStU5Qlf9lFd161gcvm7zfQkYhSJxSIQulUZcT1LTKphpufAfnZxcYchmt/vfqCqZS0iPFMPhsgfemOaGLh7Jbtn4GIP1Tlz3DYyLKOYjL8v7JJLw6UhtvCsQIVRwj/TJg634=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bl0o1Ypr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56UCbIq5029325
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 20:51:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=QrHRGi8xXiiyZOKrfIeG35
	E4fgjNjTAGkCQncHCaq7o=; b=bl0o1Ypr0qRKAdQMV6ASbEURJARxyku4nEFiKQ
	V3qSE8/wjaxLvIzmMkUTQyeFRDkOmOaxs/cSeX+SP0vIOKznS42UWV9OH5dZRsQy
	1aCxoAUvFBc+hqSeoGbI0b05FipEFwUEzX8nfkneAtUNzdeMjhM6j1k54EFaBWG+
	1McLPBQ768xi2/u4NYADsur5efLvSFLocdYx5v2E4Hv8jfLEKpGVzjbkau0TbIM8
	jpUv3q5lRVvS7rGDl7z/qjTzi3vsx0JpQbXsMFvMkJeSvuzmwq74EwKmwcv6vE15
	Mvm/wj1JDGDJwdnwjTw9YMhOkaWaHVPgxgMn9wVzKBCCyh2A==
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484mcrdg1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 20:51:54 +0000 (GMT)
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-61599108233so132223eaf.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jul 2025 13:51:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753908713; x=1754513513;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QrHRGi8xXiiyZOKrfIeG35E4fgjNjTAGkCQncHCaq7o=;
        b=Cj+D6rJ9SYpNQtvu2CXQQQW1GXWa1c1JQILvydAsyaa3SjQo3ci56lHmbiQusmTA75
         OdqX5r5eikI55SMA8Y2OklwbIrrJK6+8GLdNXvUYWgk2ZFvTzPb4lPus93OTX0tRI2f+
         mQW2v2SZs20MeDz3M8aGfFVG8t/CNjSK4j7diJwI9SAUBHgGX7G0OJ0yu0HDAwZMBBfS
         tPDPLXScJMus/j+gjv3R13G2ox0VjdwaOzQNMFCUAc94teFCQ+JuhXTtTYsNcTh7waJW
         WPPZHhqqn7scD9y9i7RxBZbMj6WGd36JSgTl8XeIgnvlsn47isJGsd9NYK2/rLcqvA0j
         m57A==
X-Forwarded-Encrypted: i=1; AJvYcCUaCqSO6VOVDmiF44DuwqdJ6eWJacg7/0KPOqFW1savJXAU2D+sC8/jh5mwJvpp39uiNycZC4aQ8htdaS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzshQdhgZLEU4lLjnpD7jC+l/IR5oRwLN9DBdqIUX7Y6vOjc5lm
	ycj9yzQxsXc/weWITasAhY9mzekVIbJCRRNsYPi/0CrRedi6MVJeNB3hwrH02EZHKdPG8CIpa2Q
	iizsvz4mfy72ArnJQcadq1m9Y7ggCrSIVL6H7XGMBaxiHXuHQ+JNS+1o1ThTJzv2UtSY=
X-Gm-Gg: ASbGncuae9WRlQmTPQGFI25+5QseET9HF4CyaPBHFVd41LS9Mcxo3xyEWjLgB8v/MbB
	XYncYvASLBX9aJpDWnRo30+tFdnIDWQoPcBLOLw4nNYgF9z+zTHAXXesLcgOwZH0iEiWApJkuCt
	arApcVyaEYde7DXzf3iMEj2Ah8dciUGbhvlEJMgk2k+lXOXQyyJVlhtr2jO/ZPPgfFfPw82+aVb
	S24cDN2eRxinl7aGvb7h0CNmwMpl6IC+GdUWTYKsTJXuAvt08dfeLkkhmck8/9ZzuOBgFRWYLoi
	4ImJ+juxQR3TopF5QOyugrgykIIc7nKRpfBEdZ5zro9Om6LO6dOW7JzSslxzakDnRBL82W40oQE
	2SZVIC8EB1O02fScR1s4TCHHIWvZawcyaBkPeAfc=
X-Received: by 2002:a05:6820:4985:b0:619:6d7e:3a4f with SMTP id 006d021491bc7-6196d7e5284mr394793eaf.4.1753908713401;
        Wed, 30 Jul 2025 13:51:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGciEHBCwSKdv9x3MWOT0GEpH+ewHi6JRMHOtpJzTpYZEHx6LjiUa3ywjEisEbjiVjGCn6xQw==
X-Received: by 2002:a05:6820:4985:b0:619:6d7e:3a4f with SMTP id 006d021491bc7-6196d7e5284mr394782eaf.4.1753908712974;
        Wed, 30 Jul 2025 13:51:52 -0700 (PDT)
Received: from [192.168.86.65] (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-61913f4decbsm1968005eaf.1.2025.07.30.13.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jul 2025 13:51:52 -0700 (PDT)
From: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
Date: Wed, 30 Jul 2025 15:51:51 -0500
Subject: [PATCH] soc: qcom: mdt_loader: Deal with zero e_shentsize
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250730-mdt-loader-shentsize-zero-v1-1-04f43186229c@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAOaFimgC/x3MQQ6CMBBG4auQWTtJoYDgVYwLoD8wibZmhhgD4
 e42Lr/FewcZVGB0Kw5SfMQkxYzyUtC0DnEBS8imylWNu3rHr7DxMw0ByrYibiY7eIcm7qa+bxs
 /tr72lPu3Ypbv/31/nOcP4+X062sAAAA=
X-Change-ID: 20250730-mdt-loader-shentsize-zero-8c99653b6343
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Val Packett <val@packett.cool>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1847;
 i=bjorn.andersson@oss.qualcomm.com; h=from:subject:message-id;
 bh=lNW2uz3OWthtQqMUaYd+aYMgM5tMDbL1PLPb4h1Ugro=;
 b=owEBgwJ8/ZANAwAIAQsfOT8Nma3FAcsmYgBoioXoR4eyRpUnmUvvN51jRKPxB4cuEYMPeLKpP
 Q9+jPQypkqJAkkEAAEIADMWIQQF3gPMXzXqTwlm1SULHzk/DZmtxQUCaIqF6BUcYW5kZXJzc29u
 QGtlcm5lbC5vcmcACgkQCx85Pw2ZrcWtpxAAw5/hHe4je/XaNCl6JU4LZWRPgoZFetCs38GFm5F
 kzhpTKr8LvKf9pzohgPgWWU+h8rap2JAjTo3/IbLV/5SYl5wb4ferXLOJXbAa6pmZIq+DXyT3Dm
 KuPZDvt0rmXPl7zqNM+qkdnri0k9XtdE0QF9naegeUXwvdsXWlg3FjL9H3Ljzindfh2WIb5yQMR
 XDoxiFBPgsfzbpS2awTgpW7oVRHOyZdTy1TkOSZ4jQMp9BjN/RpSrrVIhFIGOqftsZVQcMkoocI
 To0PI/oXtVifl0zpk1xI1cx+waNJGcEgPg0U7CwDlxaE8zQvjrffkKoRYunuIpmBWA/u/A50Fk8
 f7bpDncpvhvVVZ3oR8dohH9KAJ7rzzTivgfFbluWEtr+6oJZUdVjDnVNYr16yb+XwP4qJWjkvzE
 xi2d50bwuFYZeQlS0zp2MrLysTkSJagE8qK7JuZfU+F72KvBd8ZHRV9IkIXhVgKBBufsEZnSP3o
 gm3xwEpceybT0ha+wbr+6VPhD4/nbWz/orelNzdDGh+OOwtZoHIA1cxp4db7whgBDEW45vJ6YKS
 B75llnwHp+mIFoEMrz+7GUlyB2zYIREKbHDV/pKs2JsNaB1JJVcm2cNoZmO4q68pL68N89y+k6Z
 FNaxVZvsMtW9/hfb63oPjY3lIopPYCFFNzxCgNWYVigg=
X-Developer-Key: i=bjorn.andersson@oss.qualcomm.com; a=openpgp;
 fpr=05DE03CC5F35EA4F0966D5250B1F393F0D99ADC5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMwMDE1MiBTYWx0ZWRfX4MsAWIWskaSP
 0K9xbiJ2t4e6UGF5LS9f6qheDg1uJ7lCXS7WvJFocryqxQ8JKg9odevGsvHkRTGFZCCFs1jejeZ
 bUdRPHvTZUsAWux/vfjCcyulNin/EmXBh5UWQkFt6x04rkf5niLTlSrX5R8ls3/iQHrnoXcDDId
 G894OvaYnCsj9LsVj08HdNwNENOthqFfr0QixV8Fmd2qnf+E+OBIQtaJ30p6PE9IxwVLbF5LtZs
 kXZmww3j78cxA4pDGXYCJEKUu9+L3WIIRmVpLCZcfbmNs8ZXoBF4qhkcGdt59axzioykEThlprb
 iFBiQoJumDGYvvBi51X38NpajFlRbXxHa3m5KtSrUklw4SL5tue1R4D6dsU7dzqYU9vPeWHYWkL
 lFSbkIm1ev4kNYhlVddbblIyIzeU4Eu5RZ7Ewy9oW3YWZmk38W3/h6ReoMvzh8Fa3u5pmTN5
X-Authority-Analysis: v=2.4 cv=Hth2G1TS c=1 sm=1 tr=0 ts=688a85ea cx=c_pps
 a=wURt19dY5n+H4uQbQt9s7g==:117 a=DaeiM5VmU20ml6RIjrOvYw==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=3EGZSaILo8U2r7-FxO8A:9 a=QEXdDO2ut3YA:10
 a=-UhsvdU3ccFDOXFxFb4l:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: LmYigBFOU1niYqEEtsX-aojvUb4Mutr9
X-Proofpoint-ORIG-GUID: LmYigBFOU1niYqEEtsX-aojvUb4Mutr9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-30_06,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 mlxscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015
 spamscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507300152

Firmware that doesn't provide section headers leave both e_shentsize and
e_shnum 0, which obvious isn't compatible with the newly introduced
stricter checks.

Make the section-related checks conditional on either of these values
being non-zero.

Fixes: 9f9967fed9d0 ("soc: qcom: mdt_loader: Ensure we don't read past the ELF header")
Reported-by: Val Packett <val@packett.cool>
Closes: https://lore.kernel.org/all/ece307c3-7d65-440f-babd-88cf9705b908@packett.cool/
Reported-by: Neil Armstrong <neil.armstrong@linaro.org>
Closes: https://lore.kernel.org/all/aec9cd03-6fc2-4dc8-b937-8b7cf7bf4128@linaro.org/
Signed-off-by: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
---
 drivers/soc/qcom/mdt_loader.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/qcom/mdt_loader.c b/drivers/soc/qcom/mdt_loader.c
index 0ca268bdf1f8c579b36a04fd94417be172fc1099..5710ac0c07a8c8a56110e3fc5e30b8610e106449 100644
--- a/drivers/soc/qcom/mdt_loader.c
+++ b/drivers/soc/qcom/mdt_loader.c
@@ -39,12 +39,14 @@ static bool mdt_header_valid(const struct firmware *fw)
 	if (phend > fw->size)
 		return false;
 
-	if (ehdr->e_shentsize != sizeof(struct elf32_shdr))
-		return false;
+	if (ehdr->e_shentsize || ehdr->e_shnum) {
+		if (ehdr->e_shentsize != sizeof(struct elf32_shdr))
+			return false;
 
-	shend = size_add(size_mul(sizeof(struct elf32_shdr), ehdr->e_shnum), ehdr->e_shoff);
-	if (shend > fw->size)
-		return false;
+		shend = size_add(size_mul(sizeof(struct elf32_shdr), ehdr->e_shnum), ehdr->e_shoff);
+		if (shend > fw->size)
+			return false;
+	}
 
 	return true;
 }

---
base-commit: 79fb37f39b77bbf9a56304e9af843cd93a7a1916
change-id: 20250730-mdt-loader-shentsize-zero-8c99653b6343

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>


