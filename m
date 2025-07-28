Return-Path: <linux-kernel+bounces-747929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AE2B13A5F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 14:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE3AD3AC5C1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 12:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12308265CC9;
	Mon, 28 Jul 2025 12:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mgbPobpO"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB4E264626
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 12:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753705113; cv=none; b=WDibdt+fSyEQar/2Gczbe9/nxGC+QPzVx2sm91pUV0/pzqWmipdcIey+2Zi9Hx4ll4l9TliONRduJRuzVTstmyufscinICzXQYUKgvqdoJUj8HQEUW2qHUuYkKNSL+ncSrWNi8RDcvjoW0/7xDmPcEzKdggst71xmUfK46BS/iQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753705113; c=relaxed/simple;
	bh=9e95o5ES42Qy3NuMLEhsb824Omv6MBqqtITr/wkRRqc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XIuBLHvYv7xhipvT+p8mmQ5tB6dPMdXfzkn6UyfJAZhcHsaetb7sWbJ7RBQmtpATM0f9Lby9VD4CWhXmjMup8BYzI3apf7FoazbBwcWFLQKUJRskFdTmxKUYuQCU2CS6i64fBc+soW93+d8RNWI8hDb9ngZa5v0PVq/p7S5uUNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mgbPobpO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SAlTJU018382
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 12:18:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PH6H13lKfyjV9tH+szug2gg9c5coUKwsnv2sFKsLsV0=; b=mgbPobpOpRLovdWs
	oCZbeb8RnIr89dOgOTHFcZuzKAdWJqZ09TJv1nYTQb5tLK8jjyd1D7hC+RRqu+DI
	lHhAUSxK5jViiSFlVbKM4woCsIa5laN+2KlkUXxEuzEZ9VXtaF2pJhkfFFbSnyN2
	pqY7grx0W7XphOtY6sFBpwIeUvSLN7AowbUIzqX1A0Y7BGUmhVFua+oHTp0MbfCn
	oxNiRdjba5E+8heTkAvK/dJblBtlTKBYEyQP+LQHTRDViCw8uYL7MbaY60lUVk6W
	GOIPQzHmgliZpg9uKWgaHKG6BYB47uect26wUldvNx4O9zT2lA71lKbri0N6yqY0
	dhOXBA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484pbkvfvu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 12:18:30 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-70748301f71so15066046d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 05:18:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753705110; x=1754309910;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PH6H13lKfyjV9tH+szug2gg9c5coUKwsnv2sFKsLsV0=;
        b=s0kJ2T5roDSeCmJKeMPsr7hbilZ7ah+PMKR3oIaHZA+HIugSV1tpv4TzkO0hJAYbkF
         Xuv9UXNandkIbF3tA8C6EsKvpR0N8u2VINC6dkXxtit6nrqHCa51biPtA1HzlIsISw8L
         oTDt98d/dXhiqJpvdCXKhrFOhCktD5fjbwEF/Exwud25Q6FcYaJYhZAcNy2pB9xfKRDI
         j/4Xy3QLiBoQa390ymggC7mHxWKCr2noHuuN3Seblt4jQGLHCfobFBYI/cyjHIo86/L7
         75w6bPMev2DT9Q26PiJ4bWURiBtphySqn2yhtBD6us2wCpFoFPyjDqWRzuhGt7zxLuS4
         QaqA==
X-Forwarded-Encrypted: i=1; AJvYcCUS+VPWpofxvPmRsnqyTWUYaP1KxdW6MkxUzp12+MlGwfIFmwKKJW/D7m47NbVb1x7P+E8uz1doErMKs8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNv0RfDyuojFr4/CfRfEjvpk4FXK646+QcmO2ErsBJHMdKZWRz
	FQ/RmSJj2xQAeLKpmN46+rhIDQ2cNokG8hhDqKc9SY/P6tivHcrNRbEp7Esbk8gMSfP21kaGvBr
	cvKRBGoO5V6KhsVCCV3lI0Sun/c69Z6kFwYrv4qMRP3tsrpJr/2j38eSrSpHO3PMIoNI=
X-Gm-Gg: ASbGncv+wUhAeDLFTQxsk2r2RhcigID9x/nmaPiHO5mHx1iHX8nANKBfOGP+j00wII3
	Qz2ZaQY3dPpzkkl5qYuchyci27HSehRcUeIvB4UpJ1i+rr5wPmpLysL5Dqa2oJUk6tuqDecPuA1
	gevtn115xYE0w7QSAkR0w7OAurXs3Z8dRZW3nYipwwFwdwFVBBrYTKn1+sK0VKCe1LF3nh4HmQo
	UPiv/rnT04uHOdEeFhbGKRBLIldDEraz12bJOX3hgxELaUfkSzF50Qsl28uTcoXQja05j5PYZVC
	kSGevsmBrSjd5fTgKRhT4IFtdSKHLkSomFhROrArwertPeibdY4mX8m2rp5ZwQtWr8AqtxxVJmI
	S+4aNXOYrXIbcR1oLvtwCHBNB6DAE5ISCmjHMdxpG1iV1uJFI05/M
X-Received: by 2002:a05:6214:e4c:b0:704:f7d8:ed70 with SMTP id 6a1803df08f44-7072062e764mr184820066d6.46.1753705109408;
        Mon, 28 Jul 2025 05:18:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWy8cl4llv5EfO2hT/ONlzPkHlbcEQWhwDYQ7xVXLCwbI1g9k97zRYjQ+BvR+pAwGjmhFxEg==
X-Received: by 2002:a05:6214:e4c:b0:704:f7d8:ed70 with SMTP id 6a1803df08f44-7072062e764mr184819166d6.46.1753705108653;
        Mon, 28 Jul 2025 05:18:28 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b633b9d7dsm1241315e87.209.2025.07.28.05.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 05:18:27 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 28 Jul 2025 15:18:24 +0300
Subject: [PATCH v2 2/2] thermal: qcom: lmh: add missing IRQ includes
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-lmh-scm-v2-2-33bc58388ca5@oss.qualcomm.com>
References: <20250728-lmh-scm-v2-0-33bc58388ca5@oss.qualcomm.com>
In-Reply-To: <20250728-lmh-scm-v2-0-33bc58388ca5@oss.qualcomm.com>
To: Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Jackie Liu <liuyun01@kylinos.cn>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1115;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=9e95o5ES42Qy3NuMLEhsb824Omv6MBqqtITr/wkRRqc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoh2qQ1WIA551bGuqAkSUGwM0j9qk0fBa68M0I9
 pHWzOXudjmJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaIdqkAAKCRCLPIo+Aiko
 1bv7B/9uDaGnWjlngohMhKs+TNAb1XlN2kHqKTyGvo77ZfeJDLKtnk5nciHH4z9DtuHj8VPqGsc
 9LXAIHCZzmEfxeUzXcZZb5KO66i+CR9A7wvqWkFUSMcFzf3zo9t5K7Wp3WsjpxEK8xdFABKqCQy
 fbHHytoHK7GYbE04xf1YHoV0Y7s5x9LDY0E5OWB9LMu9xNjzgY4EyySvTGszMiZGOswXxWg/4SQ
 6RQJRZy/hvfg9+qGj/8OIb7yf/BN6k8VFTi34k7OFgnodHBGw3W4dDNhTifCvKkt+1d1rl+2sjg
 l3OleMkxa3cvRS8+r7iek9v97+2Ore5rVPpgGqJ8u75BtZct
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=LsaSymdc c=1 sm=1 tr=0 ts=68876a96 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8
 a=im9EaX7qKpYNKp65MTYA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDA5MCBTYWx0ZWRfXzlYmc7S+m3e/
 eHbr7Ociug8JQ6LuKwrRwQHPDS7vHrSen/ygfxN1PvuBd4Wv+/f4Tj15j/cG16lTraEmtz4hm//
 Tv43NI3uA3v4MC8A49o62NTk955SrAzuylgW2sDvPhpcHvHPdYg2//sYdiBS0kwlsa4CGdtB6J2
 FOYwsPXWsUVgo4YsVzalo/WA7uj6uaqzH6sP1s/G2tixGAiLFeVhX5hEsxkpaLiDmUtXezRtu/f
 doDESI/S9vUzAF9hPaIDecXNlx3+RVFMOH3AEB+rdc3igFfFN/gHn3NwCnkasD8L7mmGZH/ouWX
 13pQRbHoXs+dec82jvMTMt+zu8Q2snfGjOw18i9GNo1Za5TKl4Opa58IY94F87RcTJ+9iBuz+ad
 sr1uHzN+Z8H4zqn3+wRCSHQRAdaKNiWZOpHBywIaRI/s4i2ZD7XEicKyCHyaYiCqovcni6us
X-Proofpoint-ORIG-GUID: FmXC2m4l9KRY3z29lPg5oflo6g4Ce3xY
X-Proofpoint-GUID: FmXC2m4l9KRY3z29lPg5oflo6g4Ce3xY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 mlxlogscore=850 spamscore=0 phishscore=0 suspectscore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501
 bulkscore=0 mlxscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507280090

As reported by LKP, the Qualcomm LMH driver needs to include several
IRQ-related headers, which decrlare necessary IRQ functionality.
Currently driver builds on ARM64 platforms, where the headers are pulled
in implicitly by other headers, but fails to build on other platforms.

Fixes: 53bca371cdf7 ("thermal/drivers/qcom: Add support for LMh driver")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202507270042.KdK0KKht-lkp@intel.com/
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/thermal/qcom/lmh.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/thermal/qcom/lmh.c b/drivers/thermal/qcom/lmh.c
index 75eaa9a68ab8aad7f7dcb575b3ea34b9a12a0dbf..c681a3c89ffa0b9aa0713d6db45f444cb79bcf03 100644
--- a/drivers/thermal/qcom/lmh.c
+++ b/drivers/thermal/qcom/lmh.c
@@ -5,6 +5,8 @@
  */
 #include <linux/module.h>
 #include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/irqdesc.h>
 #include <linux/irqdomain.h>
 #include <linux/err.h>
 #include <linux/platform_device.h>

-- 
2.39.5


