Return-Path: <linux-kernel+bounces-778678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F32EB2E8D9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 01:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5506A26E87
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 23:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0A72E1744;
	Wed, 20 Aug 2025 23:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l+aSTJlp"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDD62E1C6B
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 23:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755733148; cv=none; b=l8fJzVwFzrZvRPLTT6wTVheU3x5G1gOfTMefojOKhh6lY2t/XjiE9gs1wODZfTM6FcwWSB0UTCxr595By00DwuH6T3vRBIYk/kzw02ko1TwCyzXG2DXQCLOO1b/SQkGnFnZ/aMXjrbyhVrdChGoPdAMETaljCWkTdxUCfA8Kq94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755733148; c=relaxed/simple;
	bh=Yh85rlS4nql62j6YKEnNgls3TAgynSOKcaoqO7FHo1E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KEj5CGvZyXHoCVUl4FO96Q3xwyU2qD1SF6XN7CPfRX/IMs9t7wUws0aAg2MwWfigt8TvOteVOhGFSqVx3XnxhaPYRHLiKE5Di0bECZv63/hhREjpUPPIkXNkUJPviqHuOi4LGXEqjFjgnCLy63J2rXgg5GxKerPvfDjADYEwUx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l+aSTJlp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57KGmsDc015598
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 23:39:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2mg5AWjqaghC/mvjk6kLruWQ/snXAYnJwKVQhGg0+qs=; b=l+aSTJlpcqgFB47O
	XttTZfcw5KAmMiF4b6ifSUAAqIkzDy8gWM+qyIseFIQJsuRHF3Wp+hMQig1S/1V6
	tAjEOYDFxWdMbCD6fhpE6N/02Litm6JmFE5Tg4DOHz59S5216XsvTNcmCgrUQiOD
	qulZlIwmt7shhq7fD9btxdjYnsxEwk67PwI03fWFLWSYf8e9AFCHXj/6SHxyjvyi
	JsWVHGUIz1IfVHzbj49X15EQFPPyou+F5TGsiR1TH3jtMJXtP1tGhhAwH9CbMtBE
	aBJOFdc0kw+6kgQ0zqq1qZNnmrHkHDIkTFdMgPBu9pyuMt3qzxRJJQu6Zegw1JDP
	UawdiQ==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48n528ua5s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 23:39:06 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-324e41e946eso824964a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 16:39:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755733145; x=1756337945;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2mg5AWjqaghC/mvjk6kLruWQ/snXAYnJwKVQhGg0+qs=;
        b=OKS1VulXYXOuATOjzVo1UxYV/hGXG1fnZo5eFF1iK1EhFeexJjjNmaF30wSceN7S1R
         eVHB6zmaA8HLJqHCeZRqU1wU+Ya/0z9Dnv5CEQrzfRlnmb619fOEM2hxWvVSXbXdYF8S
         jYjt1GJPLuPD1J4MRLXOA8z8yNbfb0xTsA4HC1/Vb2B8SHw6zDdvw6wcVX+cLaCkm5Jk
         Ca9NihmhKpskHVzmvSGvizagsQbmDElE/lPtilmgK7l4r8HNtASxNo5pufuuzWpcpteS
         xl4icVNCeLeHpRChU6Bn7+THqWgb/B6wUJwbv5gvlMxmU9WPmT07sOs2whRaG0iAVI7p
         A9lQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5tkaM8VU2zKEU1GkZYLdQqYisgT/XHRQadaB5zELwPs7uw5r0lDU5rpjYnpCSYfI5FenOS2e8YDKM2A8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3cdDQZaQNwv2afO1WxhB30p2LqZxQPeV0lXwvARDxUcTpbizR
	M6pckRoM2iquviqqe0vJwp1hDEpjqnrlnpLbMp5KqUIxyFrRl681YbbzMuptQX7MpGniwnTA+VI
	/LZGOTdxDeDuI4YL6oUvs4ZOMBN/iLbWr9EV+leISLyNg70tDK8Q1dmO4QEFO5UDqXw==
X-Gm-Gg: ASbGnctqx67f1WYcJJOSPZmZ6O+P3ovFBbhxodUp9eVUX9VYZRF8ZvSv57beYT4u8BC
	NrmVfCi8a0nydxvfXT8p1jZv8IgXcl84qnR9NSZI2yhBwIJ85hk5/yxiB0Ctl0UU6ZNFaUPbqqG
	HOEDutyRKx4ckdYUr/iFsNeFZV0sfS36i4lxrt9HJRBqqi7jW1QEiztx5KjPt/pp+pwHdifQNv0
	y6zlCQmeDuXwIEwmqmXkaBjJ4hW35P08Oz1/u25WhU34GDBMHQAsudKq1xLVRhuw/q5bF6KeKzE
	P4HVKAddBUklPipAeiQQFBYZO5Ly5R/1iR95vO9JZ0iEvTG61WXsTBSjFMWgSIBaPBqwq+07uZq
	Hezgn03cEt61fKRy7P68GxQM=
X-Received: by 2002:a17:90b:33c5:b0:31e:7410:a4d7 with SMTP id 98e67ed59e1d1-324ed17a46amr814656a91.33.1755733144718;
        Wed, 20 Aug 2025 16:39:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXK18UdIY44KcNM7aaFlARIr1CMW3Y1H8zVdLrdvIntoDG55CLQtOdtAX1cQDdnrcWsR0qBw==
X-Received: by 2002:a17:90b:33c5:b0:31e:7410:a4d7 with SMTP id 98e67ed59e1d1-324ed17a46amr814631a91.33.1755733144241;
        Wed, 20 Aug 2025 16:39:04 -0700 (PDT)
Received: from hu-azarrabi-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4763fbc711sm3233028a12.2.2025.08.20.16.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 16:39:03 -0700 (PDT)
From: Amirreza Zarrabi <amirreza.zarrabi@oss.qualcomm.com>
Date: Wed, 20 Aug 2025 16:38:48 -0700
Subject: [PATCH v8 01/11] tee: allow a driver to allocate a tee_device
 without a pool
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-qcom-tee-using-tee-ss-without-mem-obj-v8-1-7066680f138a@oss.qualcomm.com>
References: <20250820-qcom-tee-using-tee-ss-without-mem-obj-v8-0-7066680f138a@oss.qualcomm.com>
In-Reply-To: <20250820-qcom-tee-using-tee-ss-without-mem-obj-v8-0-7066680f138a@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=I4c8hNgg c=1 sm=1 tr=0 ts=68a65c9a cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=1atmPuGhRQHGwWkYLZIA:9
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: CbCY68VVvDlcwr9XGhM-lTG2L-NU8DiC
X-Proofpoint-ORIG-GUID: CbCY68VVvDlcwr9XGhM-lTG2L-NU8DiC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIwMDAxMyBTYWx0ZWRfX2lAEhfz3r0Mr
 PxcRNgZZxZL6LDbFEDsXS8hrTouPLiW7mfWtBEI7XYI0b0qjAtz7HKvwo0lGJzo0J/sk8nMt1b6
 gLp4Wi5t25FoBmQfwT/RsVFzEwexDYOt0pnZl5hu8XlOYdQTvnYYgyJLGMwayqgrfr4holmczmh
 CkzDjHhnPmMD8xEUuGYSERYZnFQMurD6ynHHCcOm/xxAyIZaKLbZsDuRCSwAG6ReFH9rMTp+wlj
 e9iEs0AURnMNfA7d0WlifM/U2pVXMK5ZRpZrK3sDgL3NDKL+HS9s8DBVxlGFASM+O5gnVR3ebJU
 0xLiJlcOhrXbURZAN22OT69G2IJ2XWYeWqZWTDJEeydp1TsDUQkg4U6NIsylDmP15JoIdp2p0Y3
 esEitElr09Sc7ofQGS9ay2XxShmW3Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_06,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2508110000 definitions=main-2508200013

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
index dcd40c26a538..33091aa21be0 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -852,7 +852,7 @@ struct tee_device *tee_device_alloc(const struct tee_desc *teedesc,
 
 	if (!teedesc || !teedesc->name || !teedesc->ops ||
 	    !teedesc->ops->get_version || !teedesc->ops->open ||
-	    !teedesc->ops->release || !pool)
+	    !teedesc->ops->release)
 		return ERR_PTR(-EINVAL);
 
 	teedev = kzalloc(sizeof(*teedev), GFP_KERNEL);

-- 
2.34.1


