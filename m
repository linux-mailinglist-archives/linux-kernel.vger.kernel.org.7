Return-Path: <linux-kernel+bounces-765706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BADB23D28
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 02:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DD973AF523
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 00:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F5A5155CBD;
	Wed, 13 Aug 2025 00:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="a5JbHF57"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE4D273FD
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 00:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755045424; cv=none; b=ngNcLAmXaiqD0a0OAz1w8uyNsj/96rTdO0WCSA+61vTbL6+80S+KPL68R48XKNHpZp7ebFms/bJ3pmj8WwUy03/nsVqgnY8Wi7gjHBNdxdzfDKWZ6fenhh8aG28uVvWw2zszd1hMCMs85/eMDozAY/1dss3dYdpLAypogjBR7+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755045424; c=relaxed/simple;
	bh=oYBmYKyNuJgx7AjR/DtMe3YDtEmf5yTSQmNY45/h+Mk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dHp4CN3AW5t20jSGBPs8r7XwEafnZJJHDbNMv/sRbjZK66fOPDoduoq3veW3qXkH9FM2mHguBF50kDSrCIJh6tsc1CMithTEsdf/krlivbzHmhp82dN2q+qzHmE47Wh6avRVxyf2uEaavqFqEvNFQGacStP/L13yHQ6mMZDRyCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=a5JbHF57; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CL6NAK018204
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 00:37:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aOcaZQdsCvBu0o12Lc511EeGDT2I7mkwnOLM4V2+Xso=; b=a5JbHF57vjtIG3Y+
	W9ifcik6dLYxdmud4XMvyhpXMtAJgEnVfwGGmbO0UtupfpoDEts8WtUNyKtyMU7M
	1xnLjB5lAP5sdW2bPRkFPZiEyZtjmPSfggk6B1Lv5bZIoBcgodGg19V8hsJgN3am
	0y4pxUNbeJJZDZS4DIWqA4D0MV2OCrxOX355vPVIHcyMB1dKNpiPt7xfNLBZpe0t
	40yumk4FYi8PvHDmEgDJ8khzdpJmnOVVU+OKEQb4VH8bWIPp4XpobsMotIl8tMEh
	4BKi6qJfQATmehkWHM16/CEY/kxVwkXsS7Zoqv+2idXUi6VkptW8BluOXGMqaDyt
	7qTQzA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48fem4dvk1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 00:37:02 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b42bcfe9c89so8659002a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 17:37:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755045421; x=1755650221;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aOcaZQdsCvBu0o12Lc511EeGDT2I7mkwnOLM4V2+Xso=;
        b=UKT4Vf4MPnd5cdDpRqOC5rZOoyBuVDqGXnkyLQNdnAfS8OAgdy4As+7od63671zpDG
         cEdoJ/WvFewduxe2KjBR5nj9WYIQK29ZLzMLZaVp7bltoAgKIVsBvE1SSu4H0OKq3D5E
         FYEyRpgIgTaMJIv/SQ9KFTULryhmFTZBGrx6WeeE1yzPNPxYgMyVZZbEK8r6Zv9fNhw8
         4za3eBqETIGs3Oc1UyKhg3OggFOKdJsEbRrYVHVnxDsjF0pO93nAAUtPIo0eoyZ6pifc
         LOCY17ryfdvgdLasJ339H5FsakwDOOYSdIihAZF6zZPRFkkJIJFRdlhUj+FY8OW4B0XD
         G1qg==
X-Forwarded-Encrypted: i=1; AJvYcCU7EzQGehAmiSMciagGZodmzhEb2ZACdF3bFbBojyPFucq4GYlb9Pvocgk/HiDndoqMDpO9qs7xCeKWn7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxUVpNcc8W8WyEm+PxRAWLqYluxzZFWMfthM+XkxFGLAAhmBVj
	+vkLuLjHrJthx++Ck+tqOeCkWxloNkDCwfePBq+EsrWXzibsSObRr6mO/RrFCRkMfuotRpek32H
	Bu87sSEz/XDkzNz6nJsr8VgLggr//+GGT8GaOAs5BVbDlZrAgOOveof/QN1Xq76c20A==
X-Gm-Gg: ASbGncsn0lk0fyTI6+yNrUqfCAeJJVmlP1NqfpRHcL/sWOihOEKb0OBGOG/N9zrVAYL
	G9QzfFg1i2b+aQN/eai7tZ66YP4JQiej0UR2UOuFirxlIvnHC4Qi+AMJu2+l6TgUvEVXfoIu4dO
	cid7Zhx7b6xWtk3+u7IrxeMN3fd3qzPvUni8a5sINiEL0NcVWoppdGDVjOl4RRTnAbmCnSJbk/l
	iLOc1XbWhFAxM9OAjaINP/ebtrTlJsWw4lEcBzKeQACJlS886EAB04wIQ1Hea3LUPaqZ+2csGXD
	1XMulZz8LNJw4bguYZJmJRqMUZMmZRPH8THNNzc82nEcoWjbo8m1UWE0HAyySLP9HZoLl964hPp
	6Byith9rJEjIFoaBpxFW1B98=
X-Received: by 2002:a17:903:2290:b0:243:3c4:ccaa with SMTP id d9443c01a7336-2430d0d4d45mr18426435ad.19.1755045420812;
        Tue, 12 Aug 2025 17:37:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF98zX42RSwWdppbMzosqG0TdHr9UoXTpkldnh54KBhgrVV7+MPU1d8WuN43VIfE3fGM3u3QA==
X-Received: by 2002:a17:903:2290:b0:243:3c4:ccaa with SMTP id d9443c01a7336-2430d0d4d45mr18426035ad.19.1755045420387;
        Tue, 12 Aug 2025 17:37:00 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-241e8975c89sm308781585ad.96.2025.08.12.17.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 17:36:59 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Tue, 12 Aug 2025 17:35:30 -0700
Subject: [PATCH v7 01/11] tee: allow a driver to allocate a tee_device
 without a pool
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-1-ce7a1a774803@oss.qualcomm.com>
References: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-0-ce7a1a774803@oss.qualcomm.com>
In-Reply-To: <20250812-qcom-tee-using-tee-ss-without-mem-obj-v7-0-ce7a1a774803@oss.qualcomm.com>
To: Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Apurupa Pattapu <quic_apurupa@quicinc.com>,
        Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Harshal Dev <quic_hdev@quicinc.com>, linux-arm-msm@vger.kernel.org,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org, linux-doc@vger.kernel.org,
        Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>,
        Sumit Garg <sumit.garg@oss.qualcomm.com>
X-Mailer: b4 0.13.0
X-Proofpoint-GUID: TmMEM5UsEE-Ob2OW7YeqUj4cTMHS_pmS
X-Proofpoint-ORIG-GUID: TmMEM5UsEE-Ob2OW7YeqUj4cTMHS_pmS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA2OCBTYWx0ZWRfXyN7AmuY2rg9Q
 4d3AdRh895HW8sFIYcbArrMCI56yqS8Mb7MLDKZ8uzRMuqGN3uGgxk9rzKZeu4/MeRQk50obIlE
 TInFfNQ3ObHklbCHYBqd5uXxkn1O/TEZCRpQDAqWQCyOLe7BUmk2bdmStNipUAhTs5D0luzRCyV
 4KN6SUCMin/AiQ9Q4PBEfUj2yuWhp3stx/SRwNg9W5IeNPJ0XQwKSDXMbs1jyDsTtMyrtdL7Sw3
 sRhnh2SzxJT+4Loshab3UBVNd0ltBqwIMw0Lu2duPvI8bvGgQnu9m4HAgFfbnBVPPc7jRM3Jn6F
 hPrwWVbJC/+tT/gFw73B6Xuzh9j4FcxYdo2ngflTLtiuopF+S4Ena0OVl6KopO/TC/mVNYaR3p6
 /GgN1S4K
X-Authority-Analysis: v=2.4 cv=YMafyQGx c=1 sm=1 tr=0 ts=689bde2e cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=1atmPuGhRQHGwWkYLZIA:9
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_08,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0
 adultscore=0 impostorscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508110068

A TEE driver doesn't always need to provide a pool if it doesn't
support memory sharing ioctls and can allocate memory for TEE
messages in another way. Although this is mentioned in the
documentation for tee_device_alloc(), it is not handled correctly.

Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
Signed-off-by: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
---
 drivers/tee/tee_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 944f913f8592..e47a68d337b4 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -889,7 +889,7 @@ struct tee_device *tee_device_alloc(const struct tee_desc *teedesc,
 
 	if (!teedesc || !teedesc->name || !teedesc->ops ||
 	    !teedesc->ops->get_version || !teedesc->ops->open ||
-	    !teedesc->ops->release || !pool)
+	    !teedesc->ops->release)
 		return ERR_PTR(-EINVAL);
 
 	teedev = kzalloc(sizeof(*teedev), GFP_KERNEL);

-- 
2.34.1


