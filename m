Return-Path: <linux-kernel+bounces-811338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0220CB527AD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 06:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16CB11C21A5F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 04:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C500423F439;
	Thu, 11 Sep 2025 04:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="L9l6WgOm"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C8D241CB7
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 04:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757565219; cv=none; b=pYmbWAQ2cdnzJNAqly9Qb985WO1jSPiYJ/6W+HU+BL/K7tppJcrjB0tg1F3Ie62YRkoZuLR5eshxF9jgqmrZ/Xi04A1UkgI00mEXvoH3mkUXDlf1AECH0cfoHFJ1yPFEwpMxi1r7FZAOexebVrwwoqPtwIZsUFLI+gp2e7o906Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757565219; c=relaxed/simple;
	bh=6Em4YRvhzUdiai6MIke/qRQ6ZKbGJwjjHbIVhAuggC0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cv8j4iYLNiuOWDnMgqDormatqmnARyd5+cy99zWO/FWvWMLBESByCFbrUmxkDYFrPWepuA7ChZQDhy//w+fxanj/yh3fzuw09AqaTVyC82KA77SO3tgtwuE2iKElQOvfQsoWZn8v6Rndjc42TLWRpg8Fmj9b0R5yfMSvHUD6x38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=L9l6WgOm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B41kqt002215
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 04:33:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=DOg+t76LDtT
	Tfe4i4G48ZKjea2te61QR8gT2wG09EKo=; b=L9l6WgOmgm6VnseHYqhBp74pn4d
	k1mxDB9Pfsaa2pj5E///GeblD+rJEedqBzPkJzbWmC7sZm8PCyJWJk/EouKallZp
	yP42Lfa2x+ySFSA+F2uFhPi2CHfIp2/jaVA6jzjSF3lhWgoJECCjril9dXS+KAAn
	8Sz41nx1aFyOiArHoMYQ1KWzpJtaii3obDMFlWMMZFSDtkGjd60RyBkiBtuSSKKc
	wrkj0hkiOO1MrhWJr874F/gvanr4GXq7PuISZ/P9MPxXFogZTNGnsVowh8iirrgF
	/r2cZanOm3WoIbzTRybpWzAnQq3gOYBL9XNfnXQYN/kZB+BFCC3ZWmB/30g==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 493q1cr24k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 04:33:35 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24456ebed7bso5032575ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 21:33:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757565214; x=1758170014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DOg+t76LDtTTfe4i4G48ZKjea2te61QR8gT2wG09EKo=;
        b=e6/kjUM1Mh9OVpNqqLGd16aYEcxKRtcrXlGE+XJsf/F7VEXnpHR1rcm9yDpgnZPAiu
         7d9aJV18psisDb2ecMDwmH4ZLmLbQSY4P/J8NBmTQ7MTdLao+X81/tPJIasOYnRyMfLG
         JcR6wBYo68KHFblvvUWFGgEF9Wu8rc6UDMJ98z1tJj+In9knbr61dm61eIKRJpSFJn3c
         wR3g0vWvAz33SNVJPL0m5OzXYwrTvwLA2Bez5PzVlCOMpokTCVRHYSr2DA8n5df1/yvx
         BQP5WROfycOCccq6wBsRqmUqZrrrkUkq/nM07bLbxxKmv8mGNPbkwYDjiZJyNBlwn9SO
         8gtA==
X-Forwarded-Encrypted: i=1; AJvYcCUDggW89UTcrNbuhx44MynFglktY+wtuVBGlnG3w2Zk6l1Dr8AAZRvZii9YpWL65AcCoTTnxxb/qHTAocs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwW1jXVTl5LrxkC6dYDXGrDtw/0nIsnc2O6+KrxIIniRDLDAH1d
	PfFZ4kOIxroINi17PmytPunwt2uYkTfZEW9zqJAUdd+pv1vpN9GYunR5w+sH1SV4uhdd5Ygi6YV
	kOEEywhtfP4WD1RaesLlRuPEh41Kh7MnJBFHjaAzUMc/mitIMaPWyMJso37uSRaEY+c4=
X-Gm-Gg: ASbGnctPck1lFoo819vPYsmkguoXp8aX8v4g0fhx+SY0kIN7IHxA3/MaF0kAlSuKkLB
	edAzSnjh8nfRVEEZljxYmtwhRZU9z/If9Ny9c6womUwgH8M9P5DkZ0GJtxzte71mkQomjdYsNts
	TmD+w+hDJnN5inDJJEcrjSifo5NBB/X8K0z+HXziq3dDi/OLYAlZEyD08IGHNTWnXg4HhbInvzf
	WeFm19n/qCPh/doRHi74Y+MSs37nfD1dZFUt6PWo2Vr/NlPR47GWsZsFejeouf01GC0e+o42kFC
	pVLksVhJqrJWimIN8hkgJ00TKRIhNiIsKTUhxJO9+hsEJ9rn327QKvzlYE9W3y1FLeKaq+ZH8qM
	O
X-Received: by 2002:a17:902:d4d0:b0:25c:718:103e with SMTP id d9443c01a7336-25c07181344mr11953445ad.14.1757565214202;
        Wed, 10 Sep 2025 21:33:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPw1//ZVt+iheHquxaZ5YbXEJk3lIzvUDWdJ3kz7+gJhuLOwoAA0GVIuvq2MXtauftFCP+uA==
X-Received: by 2002:a17:902:d4d0:b0:25c:718:103e with SMTP id d9443c01a7336-25c07181344mr11953065ad.14.1757565213690;
        Wed, 10 Sep 2025 21:33:33 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3a84a46csm4323975ad.91.2025.09.10.21.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 21:33:33 -0700 (PDT)
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
Subject: [PATCH v7 4/6] i2c: qcom-geni: Load i2c qup Firmware from linux side
Date: Thu, 11 Sep 2025 10:02:54 +0530
Message-Id: <20250911043256.3523057-5-viken.dadhaniya@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTExMDAzMyBTYWx0ZWRfX8zfF2gv346P1
 XrxCnyVuXKivn05s4P4IOOCbT5U3IZ4gAvsfGOq+T/bG6J/9qMVTEu5RVAG3qRWII+J+pKZUWh/
 FyqlA0psCFGi17A2PFs1JiFF7snpQ2O1SbOYOeuzAcOLX5/Fat0rDlAxob4VtZEHqKSfFPNku3G
 wHkDuStr3GNHMXeZ9Dk6ngaVHvinHEqOFaY/kgn8UzMmgzlY+ofvx+EYBNTtLFU+Ecrey1WJ8JT
 j14UbUTQJKlaEyN6yLtPwMZlK+V9kVB3RajuJ5PWBUr8IjIhznA2TkDOv1rYNqgyg+S5FNXwciy
 P5h5q/QL4zzC8wF5jpJZOId/T7u9pkQf/XDZtLVsc8eavsPJEHFToomaDyFKwG5jPx7hC77zPZ7
 oE5zr3XW
X-Authority-Analysis: v=2.4 cv=P4c6hjAu c=1 sm=1 tr=0 ts=68c2511f cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=9JGZuxy38fRfBSF6gCkA:9 a=1OuFwYUASf3TG4hYMiVC:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: _lyPJfUeDfEeU9N0X8u6p1KKAeD6z1DV
X-Proofpoint-ORIG-GUID: _lyPJfUeDfEeU9N0X8u6p1KKAeD6z1DV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509110033

Add provision to load firmware of Serial engine for I2C protocol from
Linux Execution Environment on running on APPS processor.

Acked-by: Andi Shyti <andi.shyti@kernel.org>
Co-developed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Signed-off-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
Dependencies:

This patch depends on patch 3 of this series.

v6 -> v7:

- No change.

v6 Link: https://lore.kernel.org/all/20250822072651.510027-5-viken.dadhaniya@oss.qualcomm.com/

v5 -> v6:

- Added Acked-by tag.

v5 Link: https://lore.kernel.org/linux-i2c/20250624095102.1587580-4-viken.dadhaniya@oss.qualcomm.com/

v4 -> v5:

- Updated the email domain from 'quic' to 'oss'.

v4 Link: https://lore.kernel.org/all/20250503111029.3583807-4-quic_vdadhani@quicinc.com/

v3 - >v4:

- Add a patch dependency note.

v3 Link: https://lore.kernel.org/linux-arm-msm/20250303124349.3474185-8-quic_vdadhani@quicinc.com/

v2 -> v3:

- Load firmware only if the protocol is invalid.

v2 Link: https://lore.kernel.org/linux-arm-msm/20250124105309.295769-7-quic_vdadhani@quicinc.com/

v1 -> v2:

- No change.

v1 Link: https://lore.kernel.org/linux-arm-msm/20241204150326.1470749-6-quic_vdadhani@quicinc.com/
---
---
 drivers/i2c/busses/i2c-qcom-geni.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
index ff2289b52c84..95a577764d5c 100644
--- a/drivers/i2c/busses/i2c-qcom-geni.c
+++ b/drivers/i2c/busses/i2c-qcom-geni.c
@@ -870,7 +870,13 @@ static int geni_i2c_probe(struct platform_device *pdev)
 		goto err_clk;
 	}
 	proto = geni_se_read_proto(&gi2c->se);
-	if (proto != GENI_SE_I2C) {
+	if (proto == GENI_SE_INVALID_PROTO) {
+		ret = geni_load_se_firmware(&gi2c->se, GENI_SE_I2C);
+		if (ret) {
+			dev_err_probe(dev, ret, "i2c firmware load failed ret: %d\n", ret);
+			goto err_resources;
+		}
+	} else if (proto != GENI_SE_I2C) {
 		ret = dev_err_probe(dev, -ENXIO, "Invalid proto %d\n", proto);
 		goto err_resources;
 	}
-- 
2.34.1


