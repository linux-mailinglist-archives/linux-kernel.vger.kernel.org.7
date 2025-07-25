Return-Path: <linux-kernel+bounces-745855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D799B11FA9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 15:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DF56AE1BFC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jul 2025 13:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCE51DF72C;
	Fri, 25 Jul 2025 13:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="H+zCz3MJ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509671D7E26
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 13:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753451718; cv=none; b=Hun0i80AEBOwDT/rKWJgIoo7twTvPqBb33z0o+TWIESG0ZMkNCmMSMeeVM2n8ErxpE+hLlRj+XyfTPGc1+f5sZ2mshu0DULy/PetpKmnfiIYzWElnfzY9iYnZ7foxKfv8d8Q7J74Tty7rZcgl3lijrmLmqm9FX6PanWKRnRbPY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753451718; c=relaxed/simple;
	bh=7NO/5PDwCUtGR/xRI+RAWOPjqGGaa959C9g1gdCteZ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=T6ZlWARVpArzHuROvWjoFKojE6ClyeoL26/9+w3/9GkrLNEBJb1wDRQO7HQMc2XHXncd+uzIMx/4EH7dek6k6a3mPRXszh7C2z/wo75qSThS8Fbzp1YxCKbm4ikJeMk/DahBER35MDDrZSf+EcyyUk5ESJMxO17fGlN2iZKWQDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=H+zCz3MJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56P97TkU004774
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 13:55:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=4oMvR3Y0JNp+Q/I4A+Vinq
	4Xdx0BZl2sdYxQYmHG2dI=; b=H+zCz3MJMeq4RHkdpqjyve9zaCKMPCTGeFv9cp
	nrfRFDVfX84ejLK4ivFn6B9SP2ec7FrBvrJoRWJmZgU155Ax0vaSOrRrFDA6O3qG
	yOyTO/4A9Vg3jOnH6GmKr9K+FtsEul+32WQheGNrjxun8TMd9FTUiDBUaU9dHU0y
	E/mbgljJZfJGXKxnSFXCjGT+ArPOegE1Wi2RJjpittjTXnys9535iKEucUzzY1oY
	LGa5LBd4W4NsuicKPpmad3I1muimx7PqLxAEmn5QBQMDRknjlcJxWQckL60JEi7+
	RnYt6trpGOPMgttKmw1TyrY9Z4AxGn1Qw6vcExcRk3LSBVjQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 483w53a7wt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 13:55:16 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-707205f0405so15221376d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jul 2025 06:55:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753451715; x=1754056515;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4oMvR3Y0JNp+Q/I4A+Vinq4Xdx0BZl2sdYxQYmHG2dI=;
        b=jRiTDD9og10PrsCBVO8LbafbOr9k0pZPR+BZU/JHHQm2Ud8vJZMctmgRaE65aIOcv9
         Uljotrgl/nd4iJj2/WesSx21vVfPi3a5i3uR14ltjo5eqhm7y8VY+nMBaTLfaES80uCL
         QDH5IjUS8rjvoI874RVbu5NVJYDikf351UTkR0J9xS1SRdLSKXeFU0Rts6ryna/i1Qak
         ZBm/APbNBDOp4BLeeTN/vha7NEf3gHJo9P6Gj1au8cj4/i18yqG3EIg+8LPiTziVRvyL
         F+TvNgPIrekvn7Rt9+UKc0TbIb43gZsO7KdKFIHFbkvoGkP05UrafoCgbvYmGoz3x844
         MNSA==
X-Forwarded-Encrypted: i=1; AJvYcCXpxFQRi506WO09Fumbd4mcYPc5jbAPkgoh7982wCEy3oJDybGxNziLBgJxBXJ/Cof7xwiF1o0g4akrNRY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz+1ksiJHM6xXH8eF/0D/IqRR9SE7cR1WYxAFVcvPYxWNmnws6
	rOc0dLeskoK1e64WD5gt7CXCxDgVhyLkdC2Mr69q2vFwLoesC9zjA9C2MI0D76oIzXAGqcDHWAt
	KMZvvYJlN2jEmBpL34uyWnBFILrGdzIUG5vKyEUkoOTXBhkMsOa9fCYpfmApQZrMAjl0=
X-Gm-Gg: ASbGncuzOIFgZP+CRrcLJbyDGFCZitlopxm0irQMVs8WEvd5DZ9MP3J1VO6A5S3PXWX
	T7SY0//91JQGCQG4egrOebL4SGtIvnptp6e1kLXYAy9a6RGhMdgBA95pFo9G7Q+Z+4b9bXilvYQ
	h5G8Vq+u6oxUAd1gEc/LdcMTKIL271KwefWOiarbBSdLZQ46zMLK5fLoH+QYoz8hQKxg87QNZUO
	PVloqNonTfajnol7LYDZ0uJhUnD6GKiLLk0pxsy1T+4lrctA9Gg5reftEPNRjOwfqzp5dWtnV8v
	0Uh/vkQyY5JsZkzGEpIDiY1djtOBFfNKbvugYNzTptm2ucI6wuBSr47h9faePYDEYr7MYvMXkCs
	yQHjoahGI1YGrPfuGY58DVSRj5MphiYNasVzEExRyamBGsFu4QfMa
X-Received: by 2002:a05:6214:f66:b0:707:765:4041 with SMTP id 6a1803df08f44-707205a6f6cmr32579366d6.23.1753451714746;
        Fri, 25 Jul 2025 06:55:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8BZQvp5AoylRAE5PFekGXAMMw2A8WcJZlsJwh5r1hgEVz+02C+qt0QeQkSdMwmhRk2brAaw==
X-Received: by 2002:a05:6214:f66:b0:707:765:4041 with SMTP id 6a1803df08f44-707205a6f6cmr32578866d6.23.1753451714226;
        Fri, 25 Jul 2025 06:55:14 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-331f42357e6sm37481fa.54.2025.07.25.06.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jul 2025 06:55:12 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Fri, 25 Jul 2025 16:55:11 +0300
Subject: [PATCH] thermal: qcom: make LMH select QCOM_SCM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250725-lmh-scm-v1-1-84246981f435@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAL6Mg2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDcyNT3ZzcDN3i5Fxd09TkREPjVAPzRCMDJaDqgqLUtMwKsEnRsbW1APC
 WJa5ZAAAA
X-Change-ID: 20250725-lmh-scm-5eca13e07a20
To: Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Jackie Liu <liuyun01@kylinos.cn>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1290;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=7NO/5PDwCUtGR/xRI+RAWOPjqGGaa959C9g1gdCteZ8=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBog4y/Xm6i4BloCVqP/p2bHSyO+YKW3dwJLmrW2
 smAYQol2pKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaIOMvwAKCRCLPIo+Aiko
 1e1FB/9OG9rRASczPPlIvMlLvOjBiZfirMZ8cLkDk4ZKDgcWDjHlZuyb7HRgLv4AzXYHed9dI6M
 eMTbm+EHLvL7sZBKppjP2LohP+K2T7rNPqkY/HVxs1iCebRegTqvLmdxX/dDoPnjkNykQnAAqub
 XTZCbADcZHze+QmKWyZtm5KYhaGkATvL9UhCxncv98IVzPvFNRJYOMcomdvsDzlWcW1toTpQjAZ
 2LUaY/zK5GCcc7/u2VivmRQgdCnDViuG4s/7FqhuV2pVrQHcpRLY0DCvjTqzr2FHMZ8bAKZkKcU
 rLOy0rWy++qFDw7NzfWD1MDajTi8rZ28ZU9fFHCzvj39u6jD
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=AfKxH2XG c=1 sm=1 tr=0 ts=68838cc4 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=EUspDBNiAAAA:8 a=_a-utCDu36pnI6q6VeAA:9 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDExOSBTYWx0ZWRfX9CHMq0OW7vA0
 DALKmSBrDzPjlnu3XkUr1KdjP3Xe/IuMEQ4krbBb/6nPtaF7rJA9yX3H9QwW3CLpeRtdhgiUj9g
 k0gzHrnUZxQ/kkFk6qnbiEJbXfvXmHgG1+G3k1f1fIfmUyOe2BJuhzEZZDC/Ms+BUdZi+rucUpZ
 A1Dwio35jSWK3IFJlMMakrwjCcFDT2s144i+089g5QX3TV0LFqRwJqcd3zQq9X0p6Cvteb1sW5v
 wea/tRajK60wNUhAjaTgOQF6361/FZnkSMFDTEGc/v9oIoat3p6iEUX2vN6KpZVtfIX9rMgom49
 Err+1Xl8Sbo+D9BVbv6/LGFdE8YdN8YBYel+Ge+1L57rKVh/0FN5Yr78OJf2tgCo5VnZsHDIIzZ
 AwEGxR9mB8qGPXArzZxK0wLBQTHmOWTbg3mK1Cbnsq+dM6PtgLsS0dXi0+tkKQYYbkhX0bYg
X-Proofpoint-GUID: 2S6fb60nb20QtTnG9KnlhCrH9_-oexEs
X-Proofpoint-ORIG-GUID: 2S6fb60nb20QtTnG9KnlhCrH9_-oexEs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-25_04,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 mlxlogscore=895 suspectscore=0 spamscore=0
 impostorscore=0 clxscore=1015 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507250119

The QCOM_SCM symbol is not user-visible, so it makes little sense to
depend on it. Make LMH driver select QCOM_SCM as all other drivers do
and, as the dependecy is now correctly handled, enable || COMPILE_TEST
in order to include the driver into broader set of build tests.

Fixes: 9e5a4fb84230 ("thermal/drivers/qcom/lmh: make QCOM_LMH depends on QCOM_SCM")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/thermal/qcom/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/thermal/qcom/Kconfig b/drivers/thermal/qcom/Kconfig
index 2c7f3f9a26ebbba41b89c8aa5d310048e8d6c792..a6bb01082ec6978afb5df32464cf591e4670549e 100644
--- a/drivers/thermal/qcom/Kconfig
+++ b/drivers/thermal/qcom/Kconfig
@@ -34,7 +34,8 @@ config QCOM_SPMI_TEMP_ALARM
 
 config QCOM_LMH
 	tristate "Qualcomm Limits Management Hardware"
-	depends on ARCH_QCOM && QCOM_SCM
+	depends on ARCH_QCOM || COMPILE_TEST
+	select QCOM_SCM
 	help
 	  This enables initialization of Qualcomm limits management
 	  hardware(LMh). LMh allows for hardware-enforced mitigation for cpus based on

---
base-commit: a933d3dc1968fcfb0ab72879ec304b1971ed1b9a
change-id: 20250725-lmh-scm-5eca13e07a20

Best regards,
-- 
With best wishes
Dmitry


