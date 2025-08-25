Return-Path: <linux-kernel+bounces-784075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAF0B33659
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 08:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 222D91B224A8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 06:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C9927FB0E;
	Mon, 25 Aug 2025 06:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="jHEA1Xrp"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3FC143756
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 06:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756103060; cv=none; b=LE2V5BRTlSY4eJGNuj7H2nw2g3q+DjLZLycgKR/5uUpU69yQeeyOo0JcpHM6S6OUYLV6psan+0u79jrTofAgu4fKcCLli7LqamVUoxaE35X+cnvKt81mw/DlDV/G2ptm1jOFGZMtAen0pf/3S8pNjmCMTJ+BVcJbH+mnVQXXZ/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756103060; c=relaxed/simple;
	bh=pDV3esVJ37rJHD18/1+4VVJFAEYwPV9WfltIHvbPOZI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WR5KEwruUnJNQEvaZ6oCPTxeHki78k7dHONB5cZvHmDCdxHHcn28eBYXyySZoaa+TfrqKrsoFaU/axx61NIy+qS3/AzDdFI4AImJVOfFZQDas+EWMO3LrmPY+1yrjPrLWtEqu+P6u43ND97I5/LW466Z+nuNGUOMz7bqFIEZLaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=jHEA1Xrp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57ONtHMI026320
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 06:24:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=6ot9aWQ/lqtBBBdIX+BGxm
	TOjLUKh2Pk/IoKU0iqgKg=; b=jHEA1Xrpsy2XRkZD9a57ao5T1DsqJy86a/+FSJ
	K1VWqsK2MmbZNvXo3W26lhJc4TP/cU1ih3dZ9cTJJhojkPdilqvOl9ZEZT7uKaU0
	luFiH9UA2bMobcAP7CWUxcF7KOgt3a+gq7McxckHSJ2Y4syAzJ1uGAKCaTyO3NDR
	hflBM4UF4NzCWlS2MDy569+Gx7Pn6hPqCZW9hAtI+GsZxnV0JgJfkAPThIJP0lpe
	1/LCDjZ9FOeWy9IaqK7lOAR9gMdWw/Q4Ob2ubZcC33XPkQXNwzpbnnIcv49eAxeI
	CL6A03X6qYafthJH2pnqUwk9Moyoqy4hrR5x3UgRYo+Y8DNg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q615by03-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 06:24:17 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-24457f59889so42093965ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Aug 2025 23:24:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756103056; x=1756707856;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ot9aWQ/lqtBBBdIX+BGxmTOjLUKh2Pk/IoKU0iqgKg=;
        b=En1+M3qGlxLEJ3Lc3Yk6PbIYeoqvzYBmblAH8DNef8KUTqmFDq7pZ28kvzZJICx13N
         GflwJ2Ud8eNm7nqMxD8kwwuo1kSjXAxpI9WKYDTgLZf8tVirzZkFMjIL172guvG0538E
         +QUhmNcBqFkFBmx81uA1PGEC+etaou25eVzZlNe/DBZWSqjphPLu8nTujya6L4pPhhxq
         0OG8W4ucBad32LDGP3TWxJUvXGlTcBCYzzErrRkYCiGjaGhZ9amtGvwA9czeHZ2curWE
         CTqufT9KD9ezfL/SxdWstFFnEySqBM2ddgnpglEvzUcZLFCfSI2lmg9x1E3qnjHbxZsN
         FQeA==
X-Forwarded-Encrypted: i=1; AJvYcCVLl10X78Fg/kMOUBpb0vunJS5Klt1aNA0XhGSzCy79bFmvCZ62skyaYWxV80R1KLCkQ1UZrm2dQdx65TQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBgVly11yI6oD6dYuHE4yBONKH4kxTWwZyRmVs3m5n0DTDTdx6
	KiMXzutENl9ivG9kAvZR9CC6XWnKShN+9eudeJ+frmkMxrWisUDosGstVqL78RG9jcsRSjBPj+H
	kp717nVyTx8B2wTEQy8Bv4WLWTjY8MxUzIH66hta09uoe9jsYJdnVnW9+945Y+BeQq00=
X-Gm-Gg: ASbGncvbHfyAuug6UG6qkguBOC+IuQ0is9ky5uNkT8Mivj0cqbGefCAdp8EfzUgL97M
	fXiq0UOd/LfAlJsciPNYzehNOIn7sd6RXo+1cBRWqZpPMdY2V5HMSlAN05zZ8QAEeWaSyKeSQeC
	a4y57SjDaNauz1NNutaryuXE1JZdwqoPuaDw46DvXGUfg7B5NHwnGBJM7VahsBD6TCkNXc79W+Q
	Z/k/R0UV7N6RmOqfG/VqQ89dcVOqQbdGlrbAXyq5ecm+KFW2Mz7501aClkgYlaRAa89cJAvwLk4
	dIgVO9ck9Vgt5Yq8TvvwLoOwpGgep7tWpxWq2ldnDsnRsC1fMdUYj6Sal799d46sHYNV3w==
X-Received: by 2002:a17:902:d54e:b0:246:a8d7:5bc1 with SMTP id d9443c01a7336-246a8d75c90mr61906265ad.39.1756103056410;
        Sun, 24 Aug 2025 23:24:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFu0PgC9kFgAqymgp5aXUs7Sk7dTEZYh9xB1L5IWXynoemPiGcLKopnUoDmeUBnPBnxGrJFqg==
X-Received: by 2002:a17:902:d54e:b0:246:a8d7:5bc1 with SMTP id d9443c01a7336-246a8d75c90mr61905955ad.39.1756103055944;
        Sun, 24 Aug 2025 23:24:15 -0700 (PDT)
Received: from hu-smankad-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-246687a582dsm57709455ad.36.2025.08.24.23.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Aug 2025 23:24:15 -0700 (PDT)
From: Sneh Mankad <sneh.mankad@oss.qualcomm.com>
Date: Mon, 25 Aug 2025 11:53:50 +0530
Subject: [PATCH] soc: qcom: rpmh-rsc: Unconditionally clear _TRIGGER bit
 for TCS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250825-rpmh_rsc_change-v1-1-138202c31bf6@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAHUBrGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDC0ML3aKC3Iz4ouLkeKh0oolxqolxYrKJRWKiElBXQVFqWmYF2MTo2Np
 aAMniJLZhAAAA
X-Change-ID: 20250818-rpmh_rsc_change-a43e43ac48aa
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sneh Mankad <sneh.mankad@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756103052; l=1606;
 i=sneh.mankad@oss.qualcomm.com; s=20250818; h=from:subject:message-id;
 bh=pDV3esVJ37rJHD18/1+4VVJFAEYwPV9WfltIHvbPOZI=;
 b=uzasWtRhJpFwi0bwMC+7XNu53NI0g+1A1LiAzvNRTHnSoXrFB1rjqbNTmoYGRFfUF8FpvflaD
 0vJ3yrVITf9CyZddjYjm5A4kF1YuXES8t4RLjyJku4imoKOiOsIsqXz
X-Developer-Key: i=sneh.mankad@oss.qualcomm.com; a=ed25519;
 pk=sv57EGwdcfnp6xJmoBCIT1JFSqWI+gawRHkJWj/T2B0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzNCBTYWx0ZWRfXzBDMj9qP/gDS
 KX8sP9wgHBYwqJqqJrRGb9aM7ZzW/TkjPh/JUSRvf96hVvbhlz7+mFy+WWdvr0uLQE5TLm3+sxC
 yQcCRUUUzdByiQ7XwuJqwI7WTBUOKR3pC/BzjU3dCjd0xJtmSk53G/gcs14EfWpvOLWpZlPtLxm
 qgG/YHJD+UvaEv1OwFC23m3N5p0VjY5LPEJuaugQWIQhIAG9y2rLozvJFDepxyFVNFLduc3eG27
 La5BDDtHKIF/MvsT1CSfeq3CGWmBIQeEwWw3/RAjzlvknRbUPkKtEJSiF4FGMrlLKaAaK62gnIr
 8cOlqfk0c5IDsB46Y8Y/hISAB6UStJNfjsBAMNd4d0FElhHpa9T+e/2F4GsZNKfOyOZgup9Cwiw
 L2FhI4ax
X-Proofpoint-GUID: BcdmabCY01WmK6uC7cRrOnw4BHbsgSaY
X-Authority-Analysis: v=2.4 cv=K+AiHzWI c=1 sm=1 tr=0 ts=68ac0191 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=FMhGUQ7S-oBDvu04OOIA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: BcdmabCY01WmK6uC7cRrOnw4BHbsgSaY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1011 adultscore=0
 impostorscore=0 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230034

Unconditionally clear the TCS_AMC_MODE_TRIGGER bit when a
transaction completes. Previously this bit was only cleared when
a wake TCS was borrowed as an AMC TCS but not for dedicated
AMC TCS. Leaving this bit set for AMC TCS and entering deeper low
power modes can generate a false completion IRQ.

Prevent this scenario by always clearing the TCS_AMC_MODE_TRIGGER
bit upon receiving a completion IRQ.

Fixes: 15b3bf61b8d4 ("soc: qcom: rpmh-rsc: Clear active mode configuration for wake TCS")
Signed-off-by: Sneh Mankad <sneh.mankad@oss.qualcomm.com>
---
 drivers/soc/qcom/rpmh-rsc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index fdab2b1067dbb13efbbef5cc3ef795a65fc2d6a1..c6f7d5c9c493d9e06c048930b8a14a38660df4b1 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -453,13 +453,10 @@ static irqreturn_t tcs_tx_done(int irq, void *p)
 
 		trace_rpmh_tx_done(drv, i, req);
 
-		/*
-		 * If wake tcs was re-purposed for sending active
-		 * votes, clear AMC trigger & enable modes and
+		/* Clear AMC trigger & enable modes and
 		 * disable interrupt for this TCS
 		 */
-		if (!drv->tcs[ACTIVE_TCS].num_tcs)
-			__tcs_set_trigger(drv, i, false);
+		__tcs_set_trigger(drv, i, false);
 skip:
 		/* Reclaim the TCS */
 		write_tcs_reg(drv, drv->regs[RSC_DRV_CMD_ENABLE], i, 0);

---
base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
change-id: 20250818-rpmh_rsc_change-a43e43ac48aa

Best regards,
-- 
Sneh Mankad <sneh.mankad@oss.qualcomm.com>


