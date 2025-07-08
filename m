Return-Path: <linux-kernel+bounces-721109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FEEAFC4DC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 09:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AA403ABD0A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 07:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A976229A9D2;
	Tue,  8 Jul 2025 07:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P826yVdT"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F2123BD09
	for <linux-kernel@vger.kernel.org>; Tue,  8 Jul 2025 07:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751961560; cv=none; b=TFH/Elh3SNimtEUmXrzcbSY8/wURWj93ku2VLburYvESR/XGRfyV7Dzgek4oTy3ujIEsHckfXxQzilcauEmHYz/LGZq9d9EY3yTu7JyMRBWjJYdoRaPGevndZHvAO0RndHaK8T2z8ahfooVreZEZgN3no6RGw0egbhCEx9CLqPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751961560; c=relaxed/simple;
	bh=WMgOLblD8ZBnLUCkFLvxuhD/UVCGzxZjs52X10UNygM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bYy/rJglmYH3UIE5R8+QYAu5iZMYx+ekaxUoMcrNQJ9iQN+izKANJhoa6ofc0oiq7WaG95tfAQ43ypNGXcAnQCkERsq05/e7UxPVKQWRqIpF+7JiI00Mwv/VGITUFqPT1VgPp2n3vWYJqDnxuwUJvbyJQHvVV9BmJp7ohnuD9Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P826yVdT; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5683M44B029035
	for <linux-kernel@vger.kernel.org>; Tue, 8 Jul 2025 07:59:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=UCai51dX7mXdNLxo9djotp
	lPyK+DVfhQNEEXwIvxOBs=; b=P826yVdTvDI/OnSI6gzmLDJwsqPS+Ori6hnC2U
	QGG8CzlRdvxeF7GIntRyGarlVLdSDxKlcRkZw6ai6KlNc/35B1qyaWI0N5uds/pf
	YZhPBimH1jD3MVpCVpL16XcKwYVZIMFoAMahhvFh381HPc85TwemWKwIQIbOpXFq
	ZpgTI7uWViiBXVpWro1b81jfD4Y8AJa5lgvmCfI1alOE3z2pgXbB32IUK4WSZVTK
	pjl5aASoptrFqDYiLHcgpo5PhYlNbc5IpYPOxUD7Jz8Us3Erz6e06Zqi+UqZMiK0
	bWXDa18uTHiIJ+Gg0aBe0laMQDtyigRTe18VFo/nOd1G2rbg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47rfq2x30n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 07:59:16 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2356ce66d7cso65528725ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jul 2025 00:59:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751961555; x=1752566355;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UCai51dX7mXdNLxo9djotplPyK+DVfhQNEEXwIvxOBs=;
        b=SmLcPf8hxCNUuEylbJJEWxV/pGC3v4SttJnh/Cbce1cSLEQUhowqkNyIV8869uyCGY
         pNcfoCnteIH2nQkdIh/7B8Ri46gipREby8wdnoaImKY5a+huplJL2KjKonmyxGczgKZW
         y8M6zl0IHPxsBkk79eOVHHyPd8fuwFgNs8oj9MlEoxTdeBmJS7dHnAHQ1cwcFwGgnpM4
         kdGsN0qU2U+01pESvtihm9hvkx0WYbyHB/WgyMrZg9qk1fJLRwUyYEZHD3kYJxp16FNe
         4stCuCpnmO4KfJfdSrakemBfGG7OZSxATIGRskp0QwLcaewixQpLDJLQDQBhtDgKdVxm
         7H3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXMLD9hBs2R4ZRSp127d7+9mhNilfZ1dXJn7wR/4ONHRVAIdpBZYU/8VeFmAkAc8gyqdIjxkKn/X0FoE7w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyjdrs3MC8cJCNqT2MA9/3iSDI6Zhg0qgRNMB1poNSSC7B7R9MD
	mM0WFRdRO4JC1B2GWAHhN92039rpgMBD4E6TAnnKxv1ATJXKNTDj0PWncqipHCozty+0v2vp8fI
	e82AefgD28nSJtZCMCzijjnxDoRlwfXv3lbjV1Xq5P9QnpTIRrfzixSp5SDsUSP7kZ3c=
X-Gm-Gg: ASbGncvcgjmVZ1w2Z8KlX+3aJlf7obAbznyNAURyoYFs7bGhhC+W3CjE81/QGpHa7Pu
	urlP9XF3c4VaxuXz0MEMiyccN6IzglFZIWGFg48hRgEn+XQp0AYmxXbWNI/sduDgXz4m6UUj/Ut
	j9f2TUWdLVvIN+pQyetYTUIpu4iVJ+ZE9paG3+HDjSHlZ1YuXgQrYX2U9ujWFtTiT3Y0wiskPUN
	3sOxx+3XJ3sQKtchOUr3KEW2qGKM6PhPOcmTOyDu/CDKnMxs6x+q8d21TN9eoBuxiOW9StZSNdu
	1AfM5ozrCQaW0Sh4PExaRT+6IiF9n9hfBJGQ/YVE9Qp/pv42Qw==
X-Received: by 2002:a17:902:f682:b0:235:cb94:1399 with SMTP id d9443c01a7336-23c8746d883mr179704815ad.6.1751961555452;
        Tue, 08 Jul 2025 00:59:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHTKm2MkZwxw4z6CvIdfQVIimKqrxTJ5MGyTVuJAPP6IUKP/mIU35ejN9jjBM5BMcC2woSMxg==
X-Received: by 2002:a17:902:f682:b0:235:cb94:1399 with SMTP id d9443c01a7336-23c8746d883mr179704555ad.6.1751961555025;
        Tue, 08 Jul 2025 00:59:15 -0700 (PDT)
Received: from hu-mojha-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8455eea0sm105290465ad.137.2025.07.08.00.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 00:59:14 -0700 (PDT)
From: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
Date: Tue, 08 Jul 2025 13:28:38 +0530
Subject: [PATCH v2] pinmux: fix race causing mux_owner NULL with active
 mux_usecount
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-pinmux-race-fix-v2-1-8ae9e8a0d1a1@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAK3PbGgC/0WMywrCMBBFf6XM2gl5NVZX/oe4CHVioqapiZFC6
 b8b3Li5cC6cs0KhHKjAsVsh0yeUkKYGctfB6O10IwzXxiC57PmeDziHKdYFsx0JXVhQSSvIDZo
 ftIBmzZna/SueL41dThHfPpP9d4zkwmglNVNGGNErFBjrg4pn6e7tKZXCXtU+xxQjawPb9gVOi
 M+vqQAAAA==
To: Linus Walleij <linus.walleij@linaro.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
X-Mailer: b4 0.14-dev-f7c49
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751961552; l=3098;
 i=mukesh.ojha@oss.qualcomm.com; s=20250708; h=from:subject:message-id;
 bh=WMgOLblD8ZBnLUCkFLvxuhD/UVCGzxZjs52X10UNygM=;
 b=EXd8wKvVZ3x2d+3yvB9XVb/kgxU+pYGi5VGiv6qCz8XuMtpnwioYdxKUcqq/zQefER1XdMTSn
 DXoNrbHGMhnCtoxOMOnTTYaD2XHnQKtkceHM+rAxDwk+H64o27BqqFm
X-Developer-Key: i=mukesh.ojha@oss.qualcomm.com; a=ed25519;
 pk=eX8dr/7d4HJz/HEXZIpe3c+Ukopa/wZmxH+5YV3gdNc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDA2NCBTYWx0ZWRfX5v3fBORahtyp
 uaFNNDJSH7usnW/g5Oe0TEzUw2B29dDVr9/c415et+whg1DFBrvAjEVGsDC1tuMMMidOzm9bWAs
 0kOPjAVSJvdZ9pq1W/1gFJZu+XeLefyWHOZ7GfYX/WR60OmrsB+xIjrqVJ67nXDHS2DjEHevXUA
 wF73X4sqroY5v/I2glWKBdaqI0QBH8hxvHSIeTuhq2NIJiT3eFXrnWyufc3ASUtoPKuK7cwwdga
 9gWHNc3xL6rkoLT3xpeEef2NZwEKWlb4M3oSfwLIrh0ObJtMm26YnvsPNi80jWiXHQJ+LdmFHSW
 nF6U7aorlasRevTTQY0G7HBJX9SeVh7LpJovCq7KFgZTQ/61G5FiJZ+LllyUjfF4nfoga+105pK
 Vk09u+iUxWVjphOLsX4wegPF5ssFqqdQb+aMuda9m8ToYDCO71dhjwlVddyq3Pwb5XfkD1aW
X-Proofpoint-ORIG-GUID: O5lrLdY4nRXSyvDHAUNjK_aCSdWqvup5
X-Proofpoint-GUID: O5lrLdY4nRXSyvDHAUNjK_aCSdWqvup5
X-Authority-Analysis: v=2.4 cv=SOBCVPvH c=1 sm=1 tr=0 ts=686ccfd4 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=ectBEQ3MwIv76SLthrEA:9
 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_02,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 malwarescore=0 bulkscore=0 priorityscore=1501
 adultscore=0 mlxlogscore=999 spamscore=0 impostorscore=0 phishscore=0
 mlxscore=0 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507080064

commit 5a3e85c3c397 ("pinmux: Use sequential access to access
desc->pinmux data") tried to address the issue when two client of the
same gpio calls pinctrl_select_state() for the same functionality, was
resulting in NULL pointer issue while accessing desc->mux_owner.
However, issue was not completely fixed due to the way it was handled
and it can still result in the same NULL pointer.

The issue occurs due to the following interleaving:

     cpu0 (process A)                   cpu1 (process B)

      pin_request() {                   pin_free() {

                                         mutex_lock()
                                         desc->mux_usecount--; //becomes 0
                                         ..
                                         mutex_unlock()

  mutex_lock(desc->mux)
  desc->mux_usecount++; // becomes 1
  desc->mux_owner = owner;
  mutex_unlock(desc->mux)

                                         mutex_lock(desc->mux)
                                         desc->mux_owner = NULL;
                                         mutex_unlock(desc->mux)

This sequence leads to a state where the pin appears to be in use
(`mux_usecount == 1`) but has no owner (`mux_owner == NULL`), which can
cause NULL pointer on next pin_request on the same pin.

Ensure that updates to mux_usecount and mux_owner are performed
atomically under the same lock. Only clear mux_owner when mux_usecount
reaches zero and no new owner has been assigned.

Fixes: 5a3e85c3c397 ("pinmux: Use sequential access to access desc->pinmux data")
Signed-off-by: Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>
---
 drivers/pinctrl/pinmux.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/pinctrl/pinmux.c b/drivers/pinctrl/pinmux.c
index 0743190da59e..2c31e7f2a27a 100644
--- a/drivers/pinctrl/pinmux.c
+++ b/drivers/pinctrl/pinmux.c
@@ -236,18 +236,7 @@ static const char *pin_free(struct pinctrl_dev *pctldev, int pin,
 			if (desc->mux_usecount)
 				return NULL;
 		}
-	}
-
-	/*
-	 * If there is no kind of request function for the pin we just assume
-	 * we got it by default and proceed.
-	 */
-	if (gpio_range && ops->gpio_disable_free)
-		ops->gpio_disable_free(pctldev, gpio_range, pin);
-	else if (ops->free)
-		ops->free(pctldev, pin);
 
-	scoped_guard(mutex, &desc->mux_lock) {
 		if (gpio_range) {
 			owner = desc->gpio_owner;
 			desc->gpio_owner = NULL;
@@ -258,6 +247,15 @@ static const char *pin_free(struct pinctrl_dev *pctldev, int pin,
 		}
 	}
 
+	/*
+	 * If there is no kind of request function for the pin we just assume
+	 * we got it by default and proceed.
+	 */
+	if (gpio_range && ops->gpio_disable_free)
+		ops->gpio_disable_free(pctldev, gpio_range, pin);
+	else if (ops->free)
+		ops->free(pctldev, pin);
+
 	module_put(pctldev->owner);
 
 	return owner;

---
base-commit: 26ffb3d6f02cd0935fb9fa3db897767beee1cb2a
change-id: 20250708-pinmux-race-fix-32a1ef840941

Best regards,
-- 
Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>


