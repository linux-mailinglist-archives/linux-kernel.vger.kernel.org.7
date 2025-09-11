Return-Path: <linux-kernel+bounces-811339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 57581B527BD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 06:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B2DF7B3FBC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 04:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0DE724337B;
	Thu, 11 Sep 2025 04:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oa0oKpGn"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1615C241CB7
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 04:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757565224; cv=none; b=FYGDa5eH1+KQ+cw61dWiLsf8S6hZuzeoUVQdjyqIxYD3MLvCp4dxcowgRyrX5XxHNdy95lkWJdrzYNa+7+tOODGTAqzoR97rIjoAInEWhawtVhC9pnTmqFA+ebEk2Pxvf9rzRJCvTVET/7zMeA9fcSR0PnQ11j4JtTmOUjX0x7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757565224; c=relaxed/simple;
	bh=xnmykQAcvyckgw0YxmPQiHFgobP+L6bZcjG7nwsTZ4E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mt40PlfC0blIuhXRKRCN4DfYFOvkiK4SJSeHVTyontXgurwRIUAnLTf8GDkpBXRoJDtRGWKstosUckIff/sFewRLY/S7ndvHwpxBVSk8gDKrk/2ZotjysbaK1jxX8LH+VyZQ2bOFCw/UgH5uOC/MGo7Wk+WpbPxeNbCaatnmOOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oa0oKpGn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58B2IuXt002518
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 04:33:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=TMAgZU7buYT
	Kdw/GCsn25V+u3dQ6le/rA4xiN+RqdIk=; b=oa0oKpGnm9vX89tSlkKdzpEXM3E
	hyjU98B2SSu85jS+T0SgRLqZEeDm9X3iq0eI4N56fTtOq3fAY063usGWXh42njtZ
	fq8OSbj0E51bM+dFq1mhB3ILDIieDjJLYR+m2RjqEnJ3MEInBn0r7AbN6AXtwlIg
	MEyKCx8AgPfuvbGmSapbAtG+HNt1RtjsZpLB7tfPROGvER/EwnGrERiXYM1yB+UK
	JM3vD+iZQaKqa2rjMgraI4YyPuPmQS0k2dP9QIEAG0PYLW6hsCADk38/shHkjOj4
	l5zYZDZGhsluxXdDTgs3LNGM0nXMzgtFN75cnFoLE/6Hhz+jNf2uwyjVEUQ==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490db8p97y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 04:33:41 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24cda4063easo4112845ad.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Sep 2025 21:33:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757565220; x=1758170020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TMAgZU7buYTKdw/GCsn25V+u3dQ6le/rA4xiN+RqdIk=;
        b=HvjZpiOhwvGcDv5Kbcswyanv7wyGLwS+sp+TipMdgwdqzKqJRWmLxalK+qlNtePJt5
         yZZMFi6u/FcONbzzsiVCklz/1NwRsyWlac798IY50SyT4yzg3vE8bIC3cumvTfH+zFVv
         hD0QHptO1fMdi98Z/wMx6EINm1zb9KNYyGijn8VcoAWc4FB4cxIpBgTsi7SjyNeUf7hH
         pc24rz76bJO4akyr0pbQCKXF+89ZAmnj6fr7ffAtzjwDdDQx5KnKDe6BLZPu+Jo61m95
         koQhtQFhbLHTSdsAt+uZWKz51H+8OlpOZpEWupHk6ZdB20DyOIhqyM5enOXAf36Q0pJD
         XXxw==
X-Forwarded-Encrypted: i=1; AJvYcCUKR3nph3j2v0/qrNq0nAiKUeXWXuZQmnwaL1j1jwSYDGrOnHdj5CNmUM97FpA9zdXby4quF3NpveWWHbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjrYMu5nvkKvwb0mcEK0/ipIF843J+tQ7KBXSFaXolM/EFeG1C
	ET/1aWsSC6xul8YCTrn24xRwT08Brq2k5ENlL0AiNsc9+XJb1f/dNq6Mhr4NvvMTAvpAdCzbosh
	5Tgdsf2KSurZy2ZO9jCRjoez2IUKiO216gAEurB4Tl+Xu0nWYcofidLVgsl8zf8Q8giw=
X-Gm-Gg: ASbGncsny9tiNDCi7nmnIl7JXgDi0SoedSIce6DSCiwNbyDB75dee3UQ1FkJtXJ51rC
	bhra9/6ynAaJI3KantYToAqutJjF+7evCviNjlUA5+L6JlFahslBXpf2+US73wonCJLAFmvjiYN
	MgwbOlrScRTiy11thz9UVnlFJxBrFNhkq+WDg9U4opibr5viOGa+sZ1O/DfmcXr/4TdKRw/pgQT
	3V7wyPPcAbbK+QLlQeo6o2AsJdnlM6oNC3OK9tIn3WuLXMq1LeewgdS98CrBhg8RrTtgI4gp3IU
	nEtfmvlc14thOFrSDqo6EyRRWPSNVSM0SCrbGOaFZ3zSnZp1oyFl/T6GAqKraQhh1n3WocJghP3
	c
X-Received: by 2002:a17:902:e843:b0:24c:7f2f:d9e6 with SMTP id d9443c01a7336-2516d81a032mr222003915ad.10.1757565220548;
        Wed, 10 Sep 2025 21:33:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELSjPwhaKp6l0XXdzH3iIcNWUNMNNrVth7UkdZKu33009b6miMEtFPBuSlwEwOyhB4Px9PPA==
X-Received: by 2002:a17:902:e843:b0:24c:7f2f:d9e6 with SMTP id d9443c01a7336-2516d81a032mr222003575ad.10.1757565220099;
        Wed, 10 Sep 2025 21:33:40 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3a84a46csm4323975ad.91.2025.09.10.21.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 21:33:39 -0700 (PDT)
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
Subject: [PATCH v7 5/6] spi: geni-qcom: Load spi qup Firmware from linux side
Date: Thu, 11 Sep 2025 10:02:55 +0530
Message-Id: <20250911043256.3523057-6-viken.dadhaniya@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzMSBTYWx0ZWRfXzhwbsBWQdE4X
 A22S0pFNJk0BZlI6m0bV9yEZfXKx83Srr22ApCpjh6A4WPTnpxhO/E2AIWG4DQhD1h1NHjcwvQ1
 HPeOVdc42/3L7jTXmqQcjbVuWW7YQCwZCxA7bled7hv8+zucVtZXnM64Xkbyz4WiePXQHw+dCY8
 066FvNGheEhrRD8f7nQo6qaYl6AF/T9LDZtCi5rpil4AYPJIw95uO9bu0gdt8z7SzKrgtRDjA0u
 r0JKgMmQ++3pwEhRqHDtjBRI9e13cZgVF6efmkWOtv6CRKfuxquUx1nxomfrqoGpBKxiLnWQSpw
 nKypSpQh29l1DFUjFKEyjgv6uzAW/EfZL1/0ISWOR5ZteHUKK7MXTk4SAJVw3NBN0NmfYipv3xi
 HiQJEMv4
X-Proofpoint-ORIG-GUID: JxYIwuAzG1DYzUifwuqEfS0FSgFR8Def
X-Proofpoint-GUID: JxYIwuAzG1DYzUifwuqEfS0FSgFR8Def
X-Authority-Analysis: v=2.4 cv=VIDdn8PX c=1 sm=1 tr=0 ts=68c25125 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=zIdmu9zckVospZd7ahEA:9 a=1OuFwYUASf3TG4hYMiVC:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_04,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060031

Add provision to load firmware of Serial engine for SPI protocol from
Linux Execution Environment on running on APPS processor.

Co-developed-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Signed-off-by: Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Signed-off-by: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
---
Dependencies:

This patch depends on patch 3 of this series.

v6 -> v7:

- No change.

v6 Link: https://lore.kernel.org/all/20250822072651.510027-6-viken.dadhaniya@oss.qualcomm.com/

v5 -> v6:

- No change.

v5 Link: https://lore.kernel.org/linux-i2c/20250624095102.1587580-5-viken.dadhaniya@oss.qualcomm.com/

v4 -> v5:

- Updated the email domain from 'quic' to 'oss'.

v4 Link: https://lore.kernel.org/all/20250503111029.3583807-5-quic_vdadhani@quicinc.com/

v3 -> v4:

- Add a patch dependency note.

v3 Link: https://lore.kernel.org/linux-arm-msm/20250303124349.3474185-9-quic_vdadhani@quicinc.com/

v2 -> v3:

- Load firmware only if the protocol is invalid.

v2 Link: https://lore.kernel.org/linux-arm-msm/20250124105309.295769-8-quic_vdadhani@quicinc.com/

v1 -> v2:

- No change.

v1 Link: https://lore.kernel.org/linux-arm-msm/20241204150326.1470749-7-quic_vdadhani@quicinc.com/
---
---
 drivers/spi/spi-geni-qcom.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index 768d7482102a..a0d8d3425c6c 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -671,6 +671,12 @@ static int spi_geni_init(struct spi_geni_master *mas)
 			goto out_pm;
 		}
 		spi_slv_setup(mas);
+	} else if (proto == GENI_SE_INVALID_PROTO) {
+		ret = geni_load_se_firmware(se, GENI_SE_SPI);
+		if (ret) {
+			dev_err(mas->dev, "spi master firmware load failed ret: %d\n", ret);
+			goto out_pm;
+		}
 	} else if (proto != GENI_SE_SPI) {
 		dev_err(mas->dev, "Invalid proto %d\n", proto);
 		goto out_pm;
-- 
2.34.1


