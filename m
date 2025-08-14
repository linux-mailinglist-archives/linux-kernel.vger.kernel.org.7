Return-Path: <linux-kernel+bounces-768108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD374B25D17
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 09:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 945DD3BEF04
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 07:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6734B26B2A6;
	Thu, 14 Aug 2025 07:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mLHFlrFq"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3990926A095
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755156151; cv=none; b=pBu24ViAyAAAUNeMvqOjUyb3BaOL3UQvFuDqRLxe0aagc8aNZKEdvtYERLVgsE1ly7Cf4/ONiLPLZQk1mjpwyxVkQMExy0Fpz12DUWac0K9y/hrvQDEHUPruUpx4See3e/iTsk5WK2tFx6d1Nw2ouF4Jlh5GbPHX64oMmRPXEuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755156151; c=relaxed/simple;
	bh=BdCL04OAptKdQWGchPijTezBT64XWbmizjFr1nay0y4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d6zl1kvsoRUgOxinyHmI3ZPavqRXgylhOnBj0PhLShtBH5U+NiMJwEjoABVsn5NfK2UZ0Zc/eO16c5w9qoMazTgs4RyEF81ADJREBtAE/NKepbrHZS9TrlZRr2SsKx0gsQrwSYVzPEP0SzrDNZDYZQAUqdecS/AjKV1EXxi82xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mLHFlrFq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DNBTv9023999
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:22:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TQc6bIMTdxAC6yFDpDqhMe0BhKN2QLBxitGDduPp3Lg=; b=mLHFlrFq7xPKYeGD
	/gxkYUZfP9nDkU49zg6LplmyyNyT4fEy57gHo06/agQ08Weda2LZ835LdSilTCE7
	emFfJx+GRlgowkiS95obz4+r/dCv21d8FgDFWmAATW3yKxYm6XlqZ+HM/vhjP3+v
	FTInK7jn7LOEiGrX4ZxWaKHsvA8ya0nC6pMGa6ee2m19LxtOBY2hYsu1OvbMlqmP
	pAqAli+gmB9AWkviDHQVRtUWZ7ckUgWedJ8bhNY5rGCxDUq9t82CxxqHzy+8c9He
	jIetqOi/CgyKaCu3F9pIslbCLo5t8zrHpHKCbg7AETyzOqyfqb6ylHVHPpW5c2oI
	mLWP+Q==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48gr9rudg0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 07:22:29 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4b109bb3e22so20057391cf.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 00:22:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755156148; x=1755760948;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TQc6bIMTdxAC6yFDpDqhMe0BhKN2QLBxitGDduPp3Lg=;
        b=MLyHBEs0ZiHmLHwEyH8DHbtCAz1C7YUHKa8Yu1Rll8S8YnHHekThgsfC9ZtTibPcMS
         rR3ZCax8pNFRrP7FGhJTqNtVnDZz+f34uFOw/eR4zfOlxaZkwM1dCsLGyqqGRayx7Lms
         YVKr4MMPBdf2G05SZfalMut2G0ip+4Bno0nkKLWisW6asjMvyRJrqQzOIusNYHRASLbK
         7ZwLGlgujbkRKmAy8NSAMvHhqHkMmfJKZFkwriywlL+g/QZ4AK3f+yEIXJhdKkvFFiLO
         i3SN+hX1QoODckYEckZImgbadrsXnIZnGgk3Uyg7ILXug1gvczQ9Fs2kMr5SzvgAA/Fn
         kJ+g==
X-Forwarded-Encrypted: i=1; AJvYcCUSdnbgc8Be0B2XscTTr30uYgqpTzscjnfKIovoAgdCTol6lp6LBfn29ifpRcVwmWPIRMMoNDOzHmXyFjg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5gqgZ0UVsK6vLOPqOuSeIJ83G3Oqlhz6EhUNHwTAO8RnAfEAH
	a2sswmRnCHbyqZRJBLskxK91yiDa0DJlUoIOihWFWkoUUisZgluJs7/srOl9NgoVdKRRFnCvU2p
	Etug7iQipMS4ar4CQiajgI2DstJzDi16qxyle5PBCwVehvYEAzegkzEbLnYAYAsofkIs=
X-Gm-Gg: ASbGncuJ8+prnQKyAlz0jTp1bNCqG3gKlQaBM4zuZj+r9hjmdN+hVk1/nUDOTN/G2+G
	D1nNfq5jTzN3XczJjydGc9HlQ/uyJ/Z6j4ps64CD7MaF3pvVVdLqB3Mf3Y2edD3b7Ppqww9u9Ix
	S6+7VCvnct44i9lSsg107C/k5cmrbR5R77AbMBzhniyyEamW/zGNATqW7B+cN7K4qdOEjJe2VOc
	BeqF3TW8/NG5a7XfKK+xRD88jmeLWbUm6sCkOCesouUR5hDDOuRGHar5Zw63y0lz6LsCGXR5wYG
	S2k4Z9O7tjF1g+EWbbzBddooxriGDDW9cAtJMIGMcIGmLQwzqE8UsOM6OZtOXIgkqXICfD/zzTB
	rOJvIMxiGlHO5u+2eGzYx+TmK5Zn3FQ4UJnrpr9gSgQMzdFqhBrZq
X-Received: by 2002:ac8:5783:0:b0:4b0:692a:d430 with SMTP id d75a77b69052e-4b10aab672fmr27451061cf.43.1755156148097;
        Thu, 14 Aug 2025 00:22:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNFBrlBr1dNMCyhmaJIm96Smu0B1IphGMBdlZj0GJem7QsVNBtQvGX3YL14smSqPKLK7uA/A==
X-Received: by 2002:ac8:5783:0:b0:4b0:692a:d430 with SMTP id d75a77b69052e-4b10aab672fmr27450711cf.43.1755156147622;
        Thu, 14 Aug 2025 00:22:27 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a0c3-3a00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a0c3:3a00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b8898bde5sm5648258e87.3.2025.08.14.00.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 00:22:25 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 14 Aug 2025 10:22:20 +0300
Subject: [PATCH 1/4] soc: qcom: ubwc: use no-uwbc config for MSM8917
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250814-more-ubwc-v1-1-d520f298220d@oss.qualcomm.com>
References: <20250814-more-ubwc-v1-0-d520f298220d@oss.qualcomm.com>
In-Reply-To: <20250814-more-ubwc-v1-0-d520f298220d@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Rob Clark <robin.clark@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1222;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=BdCL04OAptKdQWGchPijTezBT64XWbmizjFr1nay0y4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBonY6udRYZ5ORJnkEqhveAjpyCwQyXvyjNpd42F
 vIs9mOUiXqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaJ2OrgAKCRCLPIo+Aiko
 1eDhB/91ysi69q80sRB5MQBUiIr8YwpDizYVm78VUvgFL/feN4Yw4bb1gcseaH3A7wdrJIzDR9L
 U7q3/oE8UNEQjP/8rc927Jb0lXSTUfUgFBXUt8k1YjETmyfanKP2jLo0z4LkiwKydFgGcjOGuld
 aijspVK0wHJgL3r+DvjkF59fieNIYg6FtvQrkCsxKK4yczRA8hn85WGOZ/xJvkcDYn6bx7TUyOR
 tZwuD0Fwkxj4iXm4ZORtSwizuKCV0HEZQe5WGOVECTBQi+LwUGuJ7+PzrX1TFlaVmuVtndL/pz6
 df6Ca97aKVUBebAVHio2u5Ofsn6qEK1etaWQgJhcNiQs1KIN
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDA5NCBTYWx0ZWRfXwfwVzyoxNhpq
 uGpjOrF0XvM+UkJTghS6MwHqZka5CCOMxPlp0jK/toTEfC1eDKCOcAm0ktnKuhTVNGr5DqPSReG
 0lpGgmJZfGTphZ8uMT2iDFmI98TGt9b5VHe0xEFr5TwGd//dwAQ8Puq0AUm0IIHoW+dONEkbWNC
 bcvDDRSQmcYckQOwW6Nek3UN8lSzoP/NPXiZk8506R93Vi4Ldvh7yblMCnu6jFdlr7Z07AAqJ9E
 hOcgjHQcaM4ue39RkDToeJI8LldoaJcxcnNBcRxpc5fmBy4+l7W+0HQvs8ts5vpBUI/3dWijTRG
 7M0/8/Tod1Y2GUy7hxkBUsephjcTw/ZSNfzPnfEVvckp66Vb3ErVDAur7mlSSI0hkxzgUt+RZ8O
 7trN/7b/
X-Authority-Analysis: v=2.4 cv=NIrV+16g c=1 sm=1 tr=0 ts=689d8eb5 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=MyDQx4m5f6BJRij3LbIA:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-ORIG-GUID: G7flMyppMBGqXJPylGh25SzGw433-ISx
X-Proofpoint-GUID: G7flMyppMBGqXJPylGh25SzGw433-ISx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_02,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 impostorscore=0 adultscore=0 suspectscore=0
 spamscore=0 malwarescore=0 phishscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508130094

MSM8917 has MDSS 1.15 and Adreno 308, neither of which support UBWC.
Change UBWC configuration to point out that UBWC is not supported on
this platform.

Fixes: 1924272b9ce1 ("soc: qcom: Add UBWC config provider")
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/soc/qcom/ubwc_config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/ubwc_config.c b/drivers/soc/qcom/ubwc_config.c
index 1490a7f63767bba176e8e2e76891d7d2c424bb7f..5113c2902bf2ba3711bb14b35bbbb8a2b49b8cfe 100644
--- a/drivers/soc/qcom/ubwc_config.c
+++ b/drivers/soc/qcom/ubwc_config.c
@@ -225,7 +225,7 @@ static const struct of_device_id qcom_ubwc_configs[] __maybe_unused = {
 	{ .compatible = "qcom,apq8096", .data = &msm8998_data },
 	{ .compatible = "qcom,msm8226", .data = &no_ubwc_data },
 	{ .compatible = "qcom,msm8916", .data = &no_ubwc_data },
-	{ .compatible = "qcom,msm8917", .data = &msm8937_data },
+	{ .compatible = "qcom,msm8917", .data = &no_ubwc_data },
 	{ .compatible = "qcom,msm8937", .data = &msm8937_data },
 	{ .compatible = "qcom,msm8939", .data = &no_ubwc_data },
 	{ .compatible = "qcom,msm8953", .data = &msm8937_data },

-- 
2.47.2


