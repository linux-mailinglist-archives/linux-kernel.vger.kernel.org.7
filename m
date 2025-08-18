Return-Path: <linux-kernel+bounces-773615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1928DB2A286
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 14:58:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F42819605DA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 12:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9325C32274C;
	Mon, 18 Aug 2025 12:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c9SwftKQ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F8931CA50
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755521470; cv=none; b=M7IS6083eDAYpL1B1B0DEedMnyHNG4XCSZVqR1IUOKg2FZLIc1oqgyz97wVeCxz6JaE5URDR+7GLg9YTX0g7X6CgRIU50VuJkjUdPqlYLAUw507FG7PMpf3FY6V8M1nKV6b6lU5A7Sy7Nw2PS09bP40IWLmPe/vOtJLHcf+SDaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755521470; c=relaxed/simple;
	bh=MXxOA0e23yUVQE19DoFyqAM/igT2n25s22U/pbkdpu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FCGQkkCxCeDyS75bAh6qVbX7JZs68PNS7sidrEjBbJnwk5H4ViPiV+8VcWeJaLfPhxWPGBu3YgfnS1QNjVJwEZOtWGGBbIjmYdY4w1D4MZenG7WxRmYW/Rvf+MOedn9R/c41RRkBY/Ag2UnbT/eh/D/CRFSIL/D2k9gCQlpQyjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c9SwftKQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57I8UqFN030081
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:51:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=T9OutginLD4
	JovrJM4X4CKlX+fhBcBPqmCHNdCEWKNo=; b=c9SwftKQIR74PiFy9Ts9TikpQ/d
	3tXHf+yU3kM/eAHA/zIj+X5W8RdzPDW09cRaNmixQQOSxODRyecU8xMddw5XJTQV
	hVnJ+16+vHTQA2Ga3DBu6ftt8s4HEwDiMG41CXxeGyYOfnMQFHHf/lErJmPVFO46
	n3kqtRk4TduwwQzKDZlfkqD1BHvfdtU3ON1b89BCORAHHCxYzMFIeF8A9hgAtQCY
	f1Ehyjw+NVpEJ4HR7D239cLM6JReoRiLCoo8qXQBbphz5gGdDFO2CKBKWLVNQZRz
	iji7v0Q21lC+lHkN0o+8QXYbBKhiejRnuepbeT4npd/p4poS9PdRwdflkWg==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48jj744q0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 12:51:03 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-70a9f6346f8so90332736d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 05:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755521462; x=1756126262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T9OutginLD4JovrJM4X4CKlX+fhBcBPqmCHNdCEWKNo=;
        b=tIop/voc/NMfBghtO4iozhtVMmr2GpWFrMsAukXw7N2QHPG90WWFQwYgbG6nt+x0jj
         scB9Nud6mgOmkJsoEscBZuKArmepZMDBOVkxFZnS0vW4wcWdRU4XPj36yg0PBpbdHVlC
         V6qfZ/c3lwLLYeqJtsvB546gz8B9TaMIQq31pfKVqP278w/KlwSqZxy3SiczBCDWNqqx
         JH3HKL5hZPun7JnQxEafsXnlNgDGvhsLAHEkq9Gp86ib4hpDfofyUQEsmSzQnd3OF3kP
         9fddIKbOxJcDge7AXttn9jZbkdeV297mPRLiw2xerbEFXgc0qUYR4GC1sJR79gPmvE06
         Xrjw==
X-Forwarded-Encrypted: i=1; AJvYcCUXCxcEhNlbxP7Fxy9qD83o1c39LP6zgiZFcYbG0HaOlhcvtDr20gGxEnP197++pNj7MliNJu/OeDbuGJI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5DMozqHiwX/gdRLt61vljS1lw3DDU2KW2V0TFsVCGO2hpS/5B
	oqLBsx8+jX2pCcHEs/Td58DR8YS8zNCriUj+EFtWp6K1VjtIuu4ExpdwPjde7qO/jqOM1ObBv6f
	mWrWC+sOQXDadn9UeoB9XYyQQ5kSpyPZ6MVKP9rWJR0d/DY9oqJTljfZy41NNrLtI44g=
X-Gm-Gg: ASbGncuIMeDJvo1o4VQdtSQ9UzrOC2/sexaYFHhYT4gX0VvZda5fPUqiFBtOHJfBlNV
	e5P+43ilrSDz+otxyAind8NIJn/FnGuxEV48L1fGdEK/fD9TE2QzgPSG4UDhk6Q8aWVCpxW/bxg
	D+Vw5XU5Bsm3WHEPizu4bRERfRq4/3kf3PkeknNXPYhWlqFn1BI5+RdrmAiJ4hCMTrm2FGSsPqm
	8jdbhTg9w6kiyYxcaBuue1Rkbvd8z9qiGo+nPqCNVXCa7mPegB4K5AIVqpLUISOI769pSHYOU0S
	Q4jTRtmi8s56495uwpCmsqPvxTSw+oSa6KmxeyOCBvWn5zdGhJts5g==
X-Received: by 2002:a05:6214:1250:b0:70b:b660:4d62 with SMTP id 6a1803df08f44-70bb6604deamr48746906d6.2.1755521461654;
        Mon, 18 Aug 2025 05:51:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPgoUzQkhRctOz2bsEP6KkdrUtGiGkLED0ER7M4x3mmHheX7uMf63MEYPSJMwsa22+gItE/g==
X-Received: by 2002:a05:6214:1250:b0:70b:b660:4d62 with SMTP id 6a1803df08f44-70bb6604deamr48746656d6.2.1755521461193;
        Mon, 18 Aug 2025 05:51:01 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb676c9b27sm12537347f8f.44.2025.08.18.05.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 05:51:00 -0700 (PDT)
From: srinivas.kandagatla@oss.qualcomm.com
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, lgirdwood@gmail.com,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, krzysztof.kozlowski@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH v3 4/6] ASoC: qcom: audioreach: fix typos in I2S_INTF_TYPE
Date: Mon, 18 Aug 2025 13:50:53 +0100
Message-ID: <20250818125055.1226708-5-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250818125055.1226708-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20250818125055.1226708-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Rn8VUDAzZMR3iyYpErQ3FjlPyz38olak
X-Proofpoint-ORIG-GUID: Rn8VUDAzZMR3iyYpErQ3FjlPyz38olak
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE2MDAzMyBTYWx0ZWRfX1bjUy0VQ8WxF
 qRElg2FbXYoZNxvAPN0pJPws5b3k3kcbSCdNPENvolr8RrIvitEYDM5DDo/dYTSEDpSSG0lGvZg
 TIVUCtyUMQDOKnXiHAQ1w2IhcfePa8QDOp/tyJgYG9oZXKwWmhX5GJFD9uswIc4QnRAVRJuHGU9
 6uKFLNbx/5aS75lV9fe1vi6I+jN9JIe1saKuuswX4P+LWWESeu7SD+ufyaUODJy1LRXW0RQHR0m
 OrpOgWqMxdwZMsi3qB6nXI6tsJl9iNsg8Mx+EjZufCbC7o4Rf3yURC0N2lE+e7NKowg1khixQH3
 JeQV3G13T5TI4kmri1R9ZZ/sgrPtVuxnl14qTm1IDwW6Ax2qjWvKRYF5riWcQmJ5XDY1edC5SQI
 iamSow0i
X-Authority-Analysis: v=2.4 cv=MJtgmNZl c=1 sm=1 tr=0 ts=68a321b7 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=2ggkzc9sqBovd5WwaRoA:9
 a=1HOtulTD9v-eNWfpl4qZ:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_05,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0
 phishscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508160033

From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

Fix spelling mistakes in I2S_INTF_TYPE defines.

Reported-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/qcom/qdsp6/audioreach.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/audioreach.h b/sound/soc/qcom/qdsp6/audioreach.h
index 617bda051cf8..efc918452e2a 100644
--- a/sound/soc/qcom/qdsp6/audioreach.h
+++ b/sound/soc/qcom/qdsp6/audioreach.h
@@ -462,8 +462,8 @@ struct param_id_i2s_intf_cfg {
 } __packed;
 
 #define I2S_INTF_TYPE_PRIMARY		0
-#define I2S_INTF_TYPE_SECOINDARY	1
-#define I2S_INTF_TYPE_TERTINARY		2
+#define I2S_INTF_TYPE_SECONDARY		1
+#define I2S_INTF_TYPE_TERTIARY		2
 #define I2S_INTF_TYPE_QUATERNARY	3
 #define I2S_INTF_TYPE_QUINARY		4
 #define I2S_SD0				1
-- 
2.50.0


