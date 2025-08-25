Return-Path: <linux-kernel+bounces-784472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7C9B33C51
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 12:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CC647A4C00
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 10:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4872DECCB;
	Mon, 25 Aug 2025 10:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="WZIikFne"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA972DCF5C
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 10:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756116785; cv=none; b=gSImHhBxHkKKhh8oCK57XkssHf2BDauJUmGeh2PG5Uc8zPoXo+GHAB+H9HxXmfuHVN20SeYjIpg/V+y+pqM8GEvwGlX0gjzYXdIqXpRfC0bsLRKoiBN6tXubc2F+stuN9RsbRW4uK9wLie24G7dLb40+yLsU0sSLcktJQLPDzio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756116785; c=relaxed/simple;
	bh=FcknmGm+9WiIX6l8pOQPi9nRhprVfJbtqLcJynflUEc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LFtJ2bCGZkkVm/ijr5HM4nr0I+W1F+qehn3BiwA/sKWDwCX5qnXhaR9ds7T1R+IonTNHT/9xa3gRb8Qv95Q/bS2IBV02WvgtGNPgiQF6TuW2ygAwJRyYzinM7kwcL6yAl37dS4GtRaRVv8ZdcvUFUl5Tx9VfqXpOivn6w3LD/fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=WZIikFne; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57P8F3ud004377
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 10:13:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=70Cd69PzEsB
	YLosF81sclPZtndOuxMvCiDYzgDLZxnw=; b=WZIikFneb69cFXmAqt1KNINOjUk
	koB1wjgz6xzbJxl65tMfytRWpG5pZmD5T5sDNHijhRYrgN2Q+GOwUr8aeFCP1M4X
	u1qpHRhgbarz26xIdRPn/vg7GCNm6AbW3/QQpnDemXZI5ynZdHG7KDun4X3J/jRG
	LAHYni0BLmoaj+BF7XZGWp9zNjRIl6lueLyrBqucpLWfTFvvC4+aH4vLPSgzsN12
	IQpVWjDHZqkYaNXccZRamFfwgExTb994y4sg7Vcahq7UBr0d68sPRL3uXUN9QOSt
	fH58gnSQ5LVUtrSkh0B00hd0xRndxEJb94ZbH9bru1J18Xn5wwMTNhqb1ZQ==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5xpmsn3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 10:13:03 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b109bccebaso124568401cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 03:13:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756116782; x=1756721582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=70Cd69PzEsBYLosF81sclPZtndOuxMvCiDYzgDLZxnw=;
        b=UdJqyBWC+LTUl7b+ACdszaqV9/34+8ckf3m0bvrO/KnB2r6n4xcoL3DYUm17uZJdqv
         OJCborQq4tLkDPViel38oV79dDhSMHErE2Gfu62OmUFsomZcI1VlzAJcT/TUB6HrdBaR
         4QaQxJhL+O7QTcLP8Ex5kls870/EOCz+PwTLPf7S40dQdgNTTBpCfnJlMW95AWXs8gll
         7I6C6yBTEnp2V5Rdn55tjVAPCVzpMpug7KQPlV+JABV5ng1P9x0SFTf3LsruAkoPtUjf
         pp6SolDqC7WajC+J5H1Mzg5TRDPco20YX9lHfKxxTUQdmVQ5xGTBfP+Io1iHzxBUVWtR
         fKrA==
X-Forwarded-Encrypted: i=1; AJvYcCVwFDoNfSt/aQUy6p0xFLRzE1pneAhcm1sObB2VIc+npNc5iikLhPSh3pyaRlhXXjehNnvCIctSOm71mzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMrvvKEAisYgOYQOwP3P79mwOoyEWj//SunBsX9zlJT8HhgHJ5
	4jcp+bUS16iwGEq1gOjAZpH64NrR45xQ+B5VXkGPz3tFqQPq/9y7lcJCZ3VmyjX7aoQyv/CEIg2
	QXrlBow/OEO/XCuvkoqyT0LEfBSgkv2zUE3FRwQR+gTnDKFsaMKoN5YOsPw/GbYKo6gRFYV0YSU
	A=
X-Gm-Gg: ASbGncuegdjMhXhHB6bD83V4ngjC3QcQiEt+ufgAMp1dJ3Hxqu3k8QGa4jMdu+nlrrM
	PtMTgt7iVaL9fOl/PGH/YVjW00sDNO5V51eEwsMaPryD/9+RBpqxsk0WjcWZqWQhpl4AP9Cuvz7
	szkluXuI7sT94SAO+o6C8Rst2w0mKVDrAqFiMJSzxLnz0dinLNlZiPKNIzYTAim4DaDq3nuWlhS
	/lDb4uHeGHDg/r4byZB8pt+zSZv4byzZeQhR63DBdfjnKTE9dC8cBGDi/jD/+2V84CLgzfIJIrL
	Q6V0jc4Zlkqc9UsslvkBSsr4qSB1Drxuvj8X7aNtaNHbMh2HaQYHYA==
X-Received: by 2002:a05:622a:4c7:b0:4b0:61fa:19b4 with SMTP id d75a77b69052e-4b2aaaf9fd3mr124162281cf.46.1756116781770;
        Mon, 25 Aug 2025 03:13:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYQRWrfm0H/XKlro+Vf5EWtN7Tv7phUWtVwKFsMpl7Jna8Co3ls3l7ua2pKZf+Phx1OGRlsw==
X-Received: by 2002:a05:622a:4c7:b0:4b0:61fa:19b4 with SMTP id d75a77b69052e-4b2aaaf9fd3mr124161981cf.46.1756116781115;
        Mon, 25 Aug 2025 03:13:01 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6359b8d6sm5798645e9.4.2025.08.25.03.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 03:12:59 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, lgirdwood@gmail.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH 3/3] ASoC: qcom: audioreach: convert to cpu endainess type before accessing
Date: Mon, 25 Aug 2025 11:12:47 +0100
Message-ID: <20250825101247.152619-4-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250825101247.152619-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20250825101247.152619-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=KOlaDEFo c=1 sm=1 tr=0 ts=68ac372f cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8
 a=OR_sDe2PA-1rWwznPDAA:9 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-GUID: PlkqLiPfOsXhPu6THn96yyFWsyROJ1-L
X-Proofpoint-ORIG-GUID: PlkqLiPfOsXhPu6THn96yyFWsyROJ1-L
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMyBTYWx0ZWRfX2Sxct7rJcLfI
 2v6+F/kzGRPKTVVtGvpXgKFzt+P8W/xqVq1ULwSMpVtdkHoHMJR2vlokT6kh58iEOBzLYDyE2dh
 puFPqDmR8ICD7hV0cWjTcl6aNgnMqBvlT8mEpXIap9yOLg2bGoPz2JD4ZNLVByyF7zY9i4BgFoU
 A9I5+Fili13YHFX4W5QRxdmlgAuWcEQY3OzAUVzASlpvGAyeVEGqKFBacV0np6dlxdJOdQlVzYD
 apHsQLnULlqcyk4LBLAvlp0vXBfY5MapAJonAx60SGe1HdcMB2hBV7bBGQ9hdWj9vOFrqh+98EL
 DNa6rpy2bdF5PH82pY68XmKIb2GACg0ZrP8XAE3seBPfh8OSRE//SIGoE9ZkxXaB6khuNyah5SC
 /j4cZF5X
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_05,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508230033

Looks like some of the members of module config are accessed directly
without converting their endainess to cpu type.

Fix this by using le32_to_cpu() where required.

Fixes: da9881d00153 ("ASoC: qcom: audioreach: add support for SMECNS module")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202508230830.Rkp7HHbG-lkp@intel.com
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/qcom/qdsp6/audioreach.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/qcom/qdsp6/audioreach.c b/sound/soc/qcom/qdsp6/audioreach.c
index f4c53e84b4dc..bbfd51db8797 100644
--- a/sound/soc/qcom/qdsp6/audioreach.c
+++ b/sound/soc/qcom/qdsp6/audioreach.c
@@ -815,7 +815,7 @@ static int audioreach_set_module_config(struct q6apm_graph *graph,
 					struct audioreach_module *module,
 					struct audioreach_module_config *cfg)
 {
-	int payload_size = module->data->size;
+	int payload_size = le32_to_cpu(module->data->size);
 	struct gpr_pkt *pkt;
 	int rc;
 	void *p;
-- 
2.50.0


