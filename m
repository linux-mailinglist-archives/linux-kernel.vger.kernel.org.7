Return-Path: <linux-kernel+bounces-698885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3D6AE4B3E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 18:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE32F7A4326
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jun 2025 16:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9500728851E;
	Mon, 23 Jun 2025 16:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FGlv40rA"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2337628B4E7
	for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 16:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750697035; cv=none; b=Kls/3zhFhj87TnwI1Uxf192VL/aos2B6xvQ2zHEufgRIAmKqVwwYFVAAqRne/shZLNtmWgxPaDUIiWhGdXeH9uUhN6WcHuA414WdAo/p7gs3K4le50nzC/VjOGCPK6091GRfKz4ZbRffCItvKRkXuvpjtxDUavUaGRrz3Szft6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750697035; c=relaxed/simple;
	bh=+xh7iWI1XaIIwG71AgAWrgrmqQs6ohZttUREPGQvZt0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=aV4nDS0ijevDu+giHF/NHlNhZ/1dqi4NHN3dAS4CoYyMAw3JvGap6+vsfcFFKkcSbqwL+MqlgCkD0uH8dzgUFuQNwCyp8sZj+DESLlUL8/Yg1KGsPh8nVOckPJ2YRYqG6MrqH4kZikeh5x8Ea8f0JGJK5mPSPMruwGWEBDCjqyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FGlv40rA; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55NElHE0026183
	for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 16:43:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=bWyrqJlmlGwMCYw5gBZfWx
	7GFNIpY5/L3zNzJU4uklw=; b=FGlv40rA4/DllP2Ja7sWGrY3xon1+mrVQow9bU
	ZG9E1MJygKTOjbH1ojIFHyNnil0m8P3oJo/r23fWUvRB0rogKe/gF1CJM5H0JODR
	B3+8+/GRkp12o28F4Rp8nGJ0/z9VTf9aLBfnjXFEjrzXTKfnnDkx77upjnD0Y7CU
	LjoKetxktHVM6Qf2KE+oemPUyX1nf8f4qQxq8SDVI2wZyVgmDAn14qAyilyBclMj
	ZyQFe+Ib3bCC2uU8H85Lum203DKspY6HpM/6jgBRvTxKogdtDzdehDLExEmCvtBl
	WLw8LGQMONPIxW51VchI8fnvLoahWZYzWM880Ob4JZyu1d4Q==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47f8ymrb8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 16:43:53 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-313f8835f29so6448532a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jun 2025 09:43:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750697032; x=1751301832;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bWyrqJlmlGwMCYw5gBZfWx7GFNIpY5/L3zNzJU4uklw=;
        b=E1r9o2mneEUXYMyhXAhDbtgCS9hsMKQOqa9/nuYYUbabKQ1Jz4HC/JbOu5uaECdRfm
         /dOEbiUFsUSGIUtETrxUIPo/y4CJnapT/3DlTxSMJiDIZnZuu+Elvm8x4MFd+Cn3hAeK
         p8iaXITmzQQgYTS/kYz8mN3qW7rrgS/avQN1hyqK1FPria/cVf4n8k7MdJM2nfe+yYZz
         /0gQggQPagIoh/iJae7/HFvE2Wex6HTqwrnGE5/JcWIRT4YE8UwHuZcml2TGuhvyCY6l
         DRI1O/EKtQbWToh5Wt7Q4A0GmJ6jgCSYhkUxk4YeuejpB4iU0AQueQMGwW2Ud9jA9AZF
         HzFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXT1KysZvy5dL7tKO/asHaBM2thavcThWPKXtMmETd7KZs/ZpLV4bP8mlx1sD1B2BwE+UZA5yOWTUwGvuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzftRvqseXq0rm4xzxJiozyrZWHjY1oB3UAjF7g6jTQSCahnSia
	s8k1GnJnvNuIgHbXGjbedn/ev00k0V9bBHnKr0ncObErAuCS4ZezbkNn5Gb/YML5iAlxpdeeudm
	H6glpEX33cxd13kTsQqDstjESX6gC3UCu76icWvBTFvGK3kOrzCJ/+wteSu6hqI4HUiU=
X-Gm-Gg: ASbGncvIopKYkouQgeoUGJwq1MdPm/iWD4EOWw6vNO1fglmxb8xBothQRZPgp4VLnfR
	1cuYbn67BwY9iMnOUJde2dKFYPNDSaR9pb46Lt6W83GU+I0Alida86N+Qcw4goTHZQySnXYV62U
	SQ+Aa25kZxaPgOjKs8E37tTuWwaGCMV5RG3VsyvvpK7wTrtfHN8qjBu4Q/Whhh0Q0lT7UfKFwh/
	CKSH7kPM+1GrsaSA14/u+EpFwn6v3i8OspLf9HvBif3EIkPWaRjtYjJAjI09tgJaTYG+aU2UyAd
	BEBnxbMX4VIBslWDNUsLEY6eaOTFEtbyajtpsnGzlbN9DzlggjNr
X-Received: by 2002:a17:90b:2808:b0:313:f83a:e473 with SMTP id 98e67ed59e1d1-3159d67bbd3mr19290514a91.15.1750697032240;
        Mon, 23 Jun 2025 09:43:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNE3QbHOKDKgzhaZfq32KMG5TznfGz7my+Rpt+vl1t/WKa2yZmTq/7E3S6hmoL0wuHPAhT4A==
X-Received: by 2002:a17:90b:2808:b0:313:f83a:e473 with SMTP id 98e67ed59e1d1-3159d67bbd3mr19290472a91.15.1750697031788;
        Mon, 23 Jun 2025 09:43:51 -0700 (PDT)
Received: from hu-kamalw-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3159e048346sm9271254a91.26.2025.06.23.09.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 09:43:51 -0700 (PDT)
From: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
Subject: [PATCH 0/2] Add support to read RPMH regulator settings
Date: Mon, 23 Jun 2025 22:13:39 +0530
Message-Id: <20250623-add-rpmh-read-support-v1-0-ae583d260195@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADuEWWgC/x3MMQqAMAxA0atIZgM1RSleRRxKGzWDWlIVQby7x
 fEN/z+QWYUz9NUDypdk2beCpq4gLH6bGSUWAxlqTUcWfYyoaV1Q2UfMZ0q7HmjJucnZEMh4KG1
 SnuT+v8P4vh9llP7xZwAAAA==
X-Change-ID: 20250623-add-rpmh-read-support-3288f83cc20a
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Maulik Shah <maulik.shah@oss.qualcomm.com>,
        David Collins <david.collins@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750697028; l=1925;
 i=kamal.wadhwa@oss.qualcomm.com; s=20241018; h=from:subject:message-id;
 bh=+xh7iWI1XaIIwG71AgAWrgrmqQs6ohZttUREPGQvZt0=;
 b=lyhAsnly9G2lCiSKkMKmJ2nvZRO4QdkeMGrdps0A1jaINvH/xnrdcuxcBXrwMGpjRTfQeIdiW
 PW/CHxzE2YSB+raDa2wrWt3HdseeBhKRVFFNGBUQuX3AUM8dXmydv7T
X-Developer-Key: i=kamal.wadhwa@oss.qualcomm.com; a=ed25519;
 pk=XbPE6DM5/mJi2tsiYwMCJCZ4O5XPMqColJRlGVcM7Hs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDEwMSBTYWx0ZWRfX9tVOxrCFD7Fx
 lVZWbqvzHitqA1SktnozNb7oWvPdvNZYaeMImSFSSPGYYAByCET5sEjBo1wvPkOvO3eMxaNBjU5
 3u9rLumz9UB6xoD/jZazMXO4uuuDjLDgQ2AteFGTuxLG5ueedA3fVNdPSnhDSA8SZBqkyMSSF5F
 u1NsR6d1yFYIY5QxF9LE5TguycWUp6f63YpwwZWABRnIRXl4gYgjOujTj93emGO1l0/rJF5As9I
 w+dF0+h8hCLIRxcCkbZrmaPieeIKIqfanmsTqhAoWnPuJSYSwg+Ie/1+jCE3Zft3mvqzgVXqMq6
 1mmyVD2PyEpoYn/G6nIr8wCUoqItz1U3kTNeoZlaYgWY22zX5Y8T3y6yPR+T02ZpLC9kvtb0O70
 iJai7cZrxWFCFVrIIsB+vhOv++NnOWQ5OPWxR1V5jAZDDMi8t8u8sWZf166bGha5gfeGJy7G
X-Proofpoint-ORIG-GUID: 82ol048M1EYgbHQrwaxhW2VqzQnETiw8
X-Proofpoint-GUID: 82ol048M1EYgbHQrwaxhW2VqzQnETiw8
X-Authority-Analysis: v=2.4 cv=GLYIEvNK c=1 sm=1 tr=0 ts=68598449 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=EUspDBNiAAAA:8 a=vB4h2DdS89cme5NDu5IA:9
 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-23_04,2025-06-23_07,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 mlxscore=0 mlxlogscore=812 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506230101

This patch series adds a new `rpmh_read()` API to allow reading RPMH
addresses. Also, using this new API, enhances the RPMH regulator driver
get_regulator* APIs like `get_regulator_sel()`, `get_mode()` and
`is_enabled()` to allow reading voltage/mode/enable setting from H/W.

This is needed because current design has a limitation - regulator
framework can only get the cached values from the last voltage set
operation. Because of this right after bootup a `get_voltage_sel()`
from regulator framework will return -ENOTRECOVERABLE error, causing
regulator framework to trigger an unnecessary `set_voltage_sel()` call
with the `min_uV` value specified in the regulator's device tree
settings, which can cause issues for consumers like the display and
UFS that require a consistent voltage setting from the bootloader
state until their drivers are probed.

With this change regulator framework will get the regulator voltage
and other settings, as configured during bootloader stage, avoiding
unnecessary voltage adjustments and maintaining consistent power
settings across the transition from bootloader to kernel.

Signed-off-by: Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>
---
Kamal Wadhwa (1):
      regulator: qcom-rpmh: Add support to read regulator settings

Maulik Shah (1):
      soc: qcom: rpmh: Add support to read back resource settings

 drivers/regulator/qcom-rpmh-regulator.c | 71 +++++++++++++++++++++++++++++++++
 drivers/soc/qcom/rpmh-rsc.c             | 12 +++++-
 drivers/soc/qcom/rpmh.c                 | 54 +++++++++++++++++++++++--
 include/soc/qcom/rpmh.h                 |  7 ++++
 include/soc/qcom/tcs.h                  |  2 +
 5 files changed, 140 insertions(+), 6 deletions(-)
---
base-commit: 393d0c54cae31317deaa9043320c5fd9454deabc
change-id: 20250623-add-rpmh-read-support-3288f83cc20a

Best regards,
-- 
Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>


