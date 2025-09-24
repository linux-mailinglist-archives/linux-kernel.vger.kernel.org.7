Return-Path: <linux-kernel+bounces-831437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F81FB9CA96
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 01:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F39D6326AF1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 23:39:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E797C29D289;
	Wed, 24 Sep 2025 23:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P+vmaSSn"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CC82D0C9B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758757121; cv=none; b=Zrm4B7+N02k9SiofO3M+zXUyNthvfGxkF54snKBxQknLCOWcL0RgA3H6BNiUy02drPtLbI0qxb5F+NSZu3+Y5B5QECuEQjX9xGorz++wQHi+N2lZrT8gSc2mdzkgjCYSp9h9f5rKFLar/fygjAellZ/SGwlnCUGtBcw1sFwrDuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758757121; c=relaxed/simple;
	bh=EYcDLOOAdfr8YSV0Bc7gPxBXZaDX3/kgVqAiQjIqBmg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q+2NnyI+VAkOlT3aGy3DjZ+L2f0y+30zrpvEzN+7227L1yaVWfjXnGFqfkAeln5jJ6IwGMSWgIUKSEixoE5n/WQ6TuKSTJrOjGKnFkaFrM59LVu+Z43v1e8lZXlMkQu7kmkvc3wK6hFZlhvJXzpvKde6Lip8+VLkkbRZdFUh/+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P+vmaSSn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OD4q9U002127
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:38:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	NHm4j9oXZTwgXLl43jC5XXZtpL9N7hEYmckPaMSIIEM=; b=P+vmaSSnw5VwJgNQ
	/8PMpV6gFEUrX2HuhrdqsZ4pblcSOXMyr2AjuBaRvhf0Nw2ddhgvCtOGQlrY3GY4
	BwPqgvvUK5nMFn0/GRzAbhiItyeWFc85bWevwiVr+KCHkUTym7L3J6cQb7lMiDS7
	8zuNCmYqeJLwKkS9ULDzMxCzhs3982eb7gTdOVOmxMW41VP2W11NDGXmKztB9sbJ
	WY1bbua7dYaoQdwD1TMg/ZH3WA85b48oazgRReg0dXT6jtdPRgVzTx8ec7n6UWEx
	AxLZrmppveAekID+T9zZiSdY72bo8umD1fK7M3i2+DMKxDzr3npkNPrunSxgwKDG
	rq5RWQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 499k98p2nr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 23:38:37 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b5529da7771so201567a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:38:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758757116; x=1759361916;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NHm4j9oXZTwgXLl43jC5XXZtpL9N7hEYmckPaMSIIEM=;
        b=vJVGMUNgT6WsI5zQNB41jKbypx2DwDQ/dNwmdZFiSjqmt748pHMDtZ5EaBnfsb/QRT
         Draq0QPuKYVBGAd4AMMl570wBUAVTQ0TZ4PSElwZHgrXknlKEcVjJw/xXof1fRVVWy/7
         jkOPzED00IL28Nnfi6ugNnRckGLUGCvEwQ7hJv03+DxFs+KqrNlEXOloq4I6zT8yNRUF
         eVbwzE30iVKl+Ot6NXn56wbOaqxsu1458BHIYOHaWhiwwg7Yum1hyfQO25vsEfjcf8d0
         DNaZdxMS8eGBnGGv8kNMxqC8QVjHGB1RU3mBGZPaO51uQSsh+d8KCSMo7yfPk6a4HLXj
         mxuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsF+N5tyu/Us+22bnC3wQpiky67yfZR5+Q0neJTwvhGRwYo9hVFdMFrviBMq3yS3jc8JGIFGQm6bjqmxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YynoBVY9m9jsljtpGVEtKnTB47l2JmHycr2/LhJ7aJ1zC8M2bO0
	xsxgf4+hK6R3Ubybfjt8oTycqRMpdFzYu2RnsZgaHn9Cof/GnXFFfFa8OHhJvK13iKUBnhTt8L+
	fAE3iN8VNScRFm06mUxIONe/qzvQqEd08cfQ6coE687jLbmOWM4YVkjhszfs7CLBcEWhLQ9Hn2S
	379A==
X-Gm-Gg: ASbGnctzDvTcs97+Ry7pXbAddGQGaOZwcFfZyHFmpP/4sH3xPRzKnCcxjmnLqS1Irbd
	5KQpAv0IAkLOufazWHsu7oe69gGGnDUldJjd3ag1a+79WkLccx8ryDaKRbZFCb+RKqsx6ggSGCp
	D2LRINVS8J8YwcY1VCbMh//wHpMsaEvc4XyydhDEnRXj3VQccZfrmhUQHXIB5FmOLOKOHNYNztA
	/4V5P0KSzqySPvxzhKay6JCnnE15jgx81A0bhiWvsnXX99V9L2c94xHWPUNtmMoQWAmo2NLdHQq
	x9oXiRZYjzYRkP+NUG/QaTJ2MVRJ5p3L/gvfMDZEH848JTWfzb9jjyKkNYlUwNDi5GiKFwvwcgZ
	TERI9ziEOejEL3jU=
X-Received: by 2002:a05:6a21:6d81:b0:2c9:ff13:bc75 with SMTP id adf61e73a8af0-2e7c4dac23emr1484324637.22.1758757116547;
        Wed, 24 Sep 2025 16:38:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhqNaPs5182ORw0oQXYSFI6CJu5xfa7z2ky1Lq0mvlwnlX79+axvhkEWVo2P/vTVF/zwDGLw==
X-Received: by 2002:a05:6a21:6d81:b0:2c9:ff13:bc75 with SMTP id adf61e73a8af0-2e7c4dac23emr1484297637.22.1758757116100;
        Wed, 24 Sep 2025 16:38:36 -0700 (PDT)
Received: from hu-jingyw-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102c0709csm177056b3a.81.2025.09.24.16.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 16:38:35 -0700 (PDT)
From: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Date: Wed, 24 Sep 2025 16:38:29 -0700
Subject: [PATCH 3/3] crypto: qce: add support for QCE major version 6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250924-knp-crypto-v1-3-49af17a231b7@oss.qualcomm.com>
References: <20250924-knp-crypto-v1-0-49af17a231b7@oss.qualcomm.com>
In-Reply-To: <20250924-knp-crypto-v1-0-49af17a231b7@oss.qualcomm.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>, aiqun.yu@oss.qualcomm.com,
        tingwei.zhang@oss.qualcomm.com, trilok.soni@oss.qualcomm.com,
        yijie.yang@oss.qualcomm.com,
        Gaurav Kashyap <gaurav.kashyap@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-99b12
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758757110; l=1164;
 i=jingyi.wang@oss.qualcomm.com; s=20250911; h=from:subject:message-id;
 bh=SauQtavFOiOqWZeP9+kQ5KHbCT6o/Jn8ICNZiwWcqYU=;
 b=5iC5pA8Sn2kHE2uOAFyqz6MaYpKfN366zuev9tK3Q7pmmJFw/Kdu39eqhridZudhaielj5VOR
 SPtznmzhhh7AIlH+QGAuCaY71ulBCf4b929qMYwMbf6KeYURY71tAst
X-Developer-Key: i=jingyi.wang@oss.qualcomm.com; a=ed25519;
 pk=PSoHZ6KbUss3IW8FPRVMHMK0Jkkr/jV347mBYJO3iLo=
X-Proofpoint-GUID: flHkyaNH11SleotH9I66-71UtUu-j2VG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxOCBTYWx0ZWRfX04rTmkSttMcj
 H3OSKF3v6my2EHMPzEO2Nn7xWALZdOJz+MYdHPNqI+Ufdp1nDIFW1d7twI44hnqdiHoJFExkXPq
 95GLC+ZdK6rrpfZordbHyudw/M82DjkPmpK9C71V08rUodhzmKKBla1ckPt4+aUQ530GcKChAxf
 svwbToFSDCN0gLwPkqAKQ7LtOwnyZhZTkFdKAcJ+NoxnoWI0w0wojtxiATEemJjkTwLxYuoIwpt
 09l3RyvyeqIsQmgEMgSpiqy1gymuv8x5kjPdujTj5f0DLOXqFxaxKDBCgkJUDV4Nneq1WNzueYu
 rYo3ti6ZIhUT4mevHcMDHxAc8tO/c5x7GDr5DItfDBsJr7j9WlNKrUXSMwXa+pbzSpS8tp8s1mE
 pTB3kjTF
X-Proofpoint-ORIG-GUID: flHkyaNH11SleotH9I66-71UtUu-j2VG
X-Authority-Analysis: v=2.4 cv=Dp1W+H/+ c=1 sm=1 tr=0 ts=68d480fd cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=7enFwbqk3NRG6xSZt3cA:9
 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_07,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 spamscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509200018

From: Gaurav Kashyap <gaurav.kashyap@oss.qualcomm.com>

The Qualcomm General Purpose Crypto Engine (GPCE) has
upgraded to version 6 on newer socs, this makes the
version check logic obsolete and needs to be updated
to account for v6.0.

As part of this, unnecessary version macros has also
been removed.

Signed-off-by: Gaurav Kashyap <gaurav.kashyap@oss.qualcomm.com>
Signed-off-by: Jingyi Wang <jingyi.wang@oss.qualcomm.com>
---
 drivers/crypto/qce/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/crypto/qce/core.c b/drivers/crypto/qce/core.c
index e95e84486d9a..b966f3365b7d 100644
--- a/drivers/crypto/qce/core.c
+++ b/drivers/crypto/qce/core.c
@@ -21,7 +21,6 @@
 #include "sha.h"
 #include "aead.h"
 
-#define QCE_MAJOR_VERSION5	0x05
 #define QCE_QUEUE_LENGTH	1
 
 #define QCE_DEFAULT_MEM_BANDWIDTH	393600
@@ -161,7 +160,7 @@ static int qce_check_version(struct qce_device *qce)
 	 * the driver does not support v5 with minor 0 because it has special
 	 * alignment requirements.
 	 */
-	if (major != QCE_MAJOR_VERSION5 || minor == 0)
+	if (major == 5 && minor == 0)
 		return -ENODEV;
 
 	qce->burst_size = QCE_BAM_BURST_SIZE;

-- 
2.25.1


