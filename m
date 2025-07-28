Return-Path: <linux-kernel+bounces-747927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3014AB13A59
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 14:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73A6E3BD547
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jul 2025 12:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF56D264627;
	Mon, 28 Jul 2025 12:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Mla2ryas"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0AC2638BF
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 12:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753705111; cv=none; b=XbDrqekAiJyeS6aEgDDjpDFv0L+bdEm7S9YnaoJBI+DAokAfVvmuk3yt375Os7CSnUCYW4m+BY1N8/aTsnibQD0sEEZOTz/TU1Cr9mYqSnvdkO5I+HQOPP8CwWa5nJ3hHrqdWXe3eNzBx6wkDK+23H8gHEDzt9j400pHsDmFSSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753705111; c=relaxed/simple;
	bh=M38ztUaJC2lhdH7j2nFkM9hqv0YhD+Yd8t2Mfs5xBEc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=RauGHjpmjbr8elGycq8csvI9H40whxi8Zp5QubirJJdx7w4PMjDsXRiFATw1+sd68FfULcLwK7so5RHXYmQCtbsgwxmu5/rYlRGyCVqga9JExzo12WUFUBrPMYsGBHkenD3ecfK+5chwFt/t6RWDQauhQ0B1KxzMS1mg4gqqxFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Mla2ryas; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56SAlMte012151
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 12:18:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ptZuHaxxZdoWHu82b8or6U
	lvOYiK665hzjqcsDuocac=; b=Mla2ryasFfujnFqb9TEC4V6mq2D56FmtKDPMHQ
	syaM5fiJ9ELkXzDR3qAIn5RRipQgktuXX3R23qlIugKEdTxCQXdnj3mdIzLHJNva
	T/7froIuidXw+S9MCtEB5tmDJ7x1zr5FmvBs0Ravd9pmuL5GX92CWD8a4Sa76XNP
	8vz42ZLEA8xjMnCLELqIS6GfBoSnR0h1eBI6OEdDdmZpJ99N2p6wGHvAAbg6qAxl
	NYnvSib0n7LnIZIiNYDisfpPSohTNSe+FhpX6zjRqryIKSamSTN6utpEOi4SgQTU
	1t4tdCfOT0N3Uq2WbgzrehM1K3rucrwFUn7eBhEvXVqSdVMA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 484qsk4ge9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 12:18:29 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70708748fbaso72737416d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jul 2025 05:18:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753705107; x=1754309907;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ptZuHaxxZdoWHu82b8or6UlvOYiK665hzjqcsDuocac=;
        b=rDJ97exCpoi5zzUwlEY6UIA12Q+A2gyWmIz8IaVgxBQbPJoYiS+UnLfIFt1YFBj+p6
         fuH9NoSOo/k+hLyqS1G0FkN4P6iqYC0Plo9xj3CtwsPaiFD4GAr+BFX2vXhUthHdnhgr
         /FpAO9dCW9zsjPvixXEqA4MxEnRmtx1+hb1kQpoSvy0o6TLUqcoyNeRittXluw0SuZCh
         tqT9s6SiDfHj1In9ZwJ6g8KOcGFiAE6wqSJ7es3qj8ZuqVHpP4NQt9auF+rqvQuK2Z1C
         qUZx4O1VDb65it0ZAftQEXdjGNO2jCdIc2+jxitj+oUzUpyGB2VfjkBHdivPuohDiKvN
         Elyw==
X-Forwarded-Encrypted: i=1; AJvYcCXX1RZ9qqJ8BqX0xd0wSR8NuP+ttvUa5pBXFwPHp0BdEBYbTtTM3Gb2kw+g58uDwy9O+Aorao56DhyV3BY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8BvFzM+8z1xfEANm53i/tVr7vHcyj7GybTfCyrFeZaMVgsHVI
	u3kG1gqrLQ5f6LwD6Dj6CO8ZPyEqZPAhUVSk0NStlo3eRBUQuBSwGu036X1j2dx0oA0j18hTRpW
	s/0Xjwkk2xhY1odylSXIcqjHZl6jF1xYjVXkI/THWAAkJ61itWCE1VWeut8mFAbcagu1ZIuej+B
	A=
X-Gm-Gg: ASbGnctESNjiLydN6G4/9H5elpXOSTf+XR86Lq465BnagPWXzW6bDAz3IGLb+Nv+t+D
	rqynwG0/eQx9jJcwLjVu2nogeWCq/Ytbkwz9TAe6H7+QAI2v19vGjhmLq44gBexIUbMci7tQhap
	1M0ckBO025ieNzv1tXr5bY/qsf4tzKKa72HtrCYew+joO773PI5aLj37+KjHkPVCW3xrkSb3D1e
	9jk7bD0fVLzzxzJjp3MHVvEegnfc0nYWF1QF133E/sPfnuvTe48MfPKjhCGkLdc2GNqDIyULCnJ
	BF8MsiUgmxjj5Xf3IouMvD5hckVtJz6+dAKbbaoFiQSE4lSBsG0gjwFWDOmzhQQJBapXUUrafTx
	UC30/bv9DmVRkxUvmE9lyQmRA5UuqqtdR/CkLq4F8A050U4C6iAoe
X-Received: by 2002:a05:6214:4f04:b0:707:2c79:e7e0 with SMTP id 6a1803df08f44-7072c79fba3mr117172576d6.26.1753705107159;
        Mon, 28 Jul 2025 05:18:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFN2YeovA7z4Fa9KoKkrBt/mxaEt659mNHLOy9z26g41eJUXyUfEXi6Fre24yRnj636ygzN7Q==
X-Received: by 2002:a05:6214:4f04:b0:707:2c79:e7e0 with SMTP id 6a1803df08f44-7072c79fba3mr117171596d6.26.1753705106181;
        Mon, 28 Jul 2025 05:18:26 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b633b9d7dsm1241315e87.209.2025.07.28.05.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 05:18:25 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v2 0/2] thermal: qcom: lmh: enable COMPILE_TEST testing
Date: Mon, 28 Jul 2025 15:18:22 +0300
Message-Id: <20250728-lmh-scm-v2-0-33bc58388ca5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI5qh2gC/2WMwQ7CIBAFf6XZszRAwVZP/ofpgeBWSEqprBJNw
 7+LvXp5ybxMZgPC5JHg3GyQMHvycakgDw1YZ5Y7Mn+rDJJLzXup2RwcIxuYRmtEh7w3kkO114S
 Tf++l61jZeXrG9NnDWfze/0YWTLBBSXU8DWJSnb5EovbxMrONIbR1YCylfAEj3AYApQAAAA==
X-Change-ID: 20250725-lmh-scm-5eca13e07a20
To: Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Jackie Liu <liuyun01@kylinos.cn>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=712;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=M38ztUaJC2lhdH7j2nFkM9hqv0YhD+Yd8t2Mfs5xBEc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBoh2qQzPrWOTULAa+8LQPK9aromyl5o7bomWPML
 St+6PoYc8OJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaIdqkAAKCRCLPIo+Aiko
 1ZUgB/4zTD3s+0wa80N9eIBYbJ+kXG2H5AQ9sOnzAJ2rcgICH02fujCfgkalb52Mjf4ME8EPyEa
 7Zfa4bRBYVSCjq1ga8nCUu5q4wkydwNCASDHtf/yIkDAQy53SGaCGY3YAEv2aA13eZ+vBDOy1lQ
 qPlvM9idqXLF4/WgfIZN5bWFSTRpvtyw3h3a0WvIZAnWOSXnlbQ41wAAhWPz3CR9FEfUieQKzaN
 NBpdTk6U2CgiZeX6nnno9arYjOmmDn7FzcP68OMXbRfSJyggkxzoZm9Extv/MUKbVHjM3x/eQ9v
 WRZPjCKaKdpll+TJw1+5YVl/X+sDTNXkqx8g1TYLLLV6dNEJ
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=KdDSsRYD c=1 sm=1 tr=0 ts=68876a95 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Wb1JkmetP80A:10 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=2jyfk5HOav9ef5UL-FMA:9
 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: qug9UM_0mT26hCW-wiS26PVzlfZM3Ku0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI4MDA5MCBTYWx0ZWRfXzD1M6xFa9vva
 Gtkvux/zK/gXclwJpo7uu3n6FP+OQd5sliYe+zbEoeQhP8ks+46w4W6OFsNampOMfuHp92/YOpU
 sq09yPzKBrK3i8Z6dDz4sVYD5jGxkm918pTeOBFbvfkLgViAEFnOsW/ch6Xf16TYwNwJSObAsnI
 AK6zpykCaDmJHodBDsUKEe/PO/d6Kreb2h/iSGjzA8e3mbW7fMB7pRMjqHmQ5AZ2Yp7ofX0mOxq
 uJ5k/8sngiUFzoisa9r/BnchUonrxl0/lIdMT070WbV4WR+gUB7z4bQ7SWMTm+Dw7HAzUE6tVe/
 0cEWnlSs/x2X29K8KZSA+9bnwUxTb7j0XLKehn2/Fd0e3ZZECW2NwwwwsWhkrvNmPWPFYsCn/Nh
 sN5ueGnAlcXiCFGkh/sLxzsLOGg/I63Gfw1M7kz+oHvwF+YOYnUARcqy4AoxQ6ZtMcirN+b5
X-Proofpoint-ORIG-GUID: qug9UM_0mT26hCW-wiS26PVzlfZM3Ku0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-28_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 mlxscore=0 spamscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 clxscore=1015 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2507280090

Rework Kconfig dependencies and make LMH driver subject to the
COMPILE_TEST testing.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
Changes in v2:
- Added missing includes (LKP)
- Link to v1: https://lore.kernel.org/r/20250725-lmh-scm-v1-1-84246981f435@oss.qualcomm.com

---
Dmitry Baryshkov (2):
      thermal: qcom: make LMH select QCOM_SCM
      thermal: qcom: lmh: add missing IRQ includes

 drivers/thermal/qcom/Kconfig | 3 ++-
 drivers/thermal/qcom/lmh.c   | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)
---
base-commit: a933d3dc1968fcfb0ab72879ec304b1971ed1b9a
change-id: 20250725-lmh-scm-5eca13e07a20

Best regards,
-- 
With best wishes
Dmitry


