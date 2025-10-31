Return-Path: <linux-kernel+bounces-880086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78090C24D87
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 12:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1005406286
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Oct 2025 11:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400DE346FD1;
	Fri, 31 Oct 2025 11:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Hlp8vBse";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ayuBRYAi"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E78346E5C
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761911308; cv=none; b=UFKIhO6LL7O0tiY3p/7xH74gmuwUSRp1LbUrYaEeB0PNk4JHmPkSJaAYNXnQoH3ELw/r6SkJp/F6dfaD00BSX04frYk3BOYZO4epmxQ0o6QH7kwo5nyRr0Dirr11yxLvE5uDcCdldwM3YOLqlgRQ02Wi1g1PKeUykwBl5QwU5tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761911308; c=relaxed/simple;
	bh=IjhQRZlTTXmUt5sgJp27pvl7YrbqCsNF6Y9gX3XiQ7Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ufMtAuSLoFqKrazI1RdaWRG5x09hZKt0rPmMXVbvVlcO+obBgliDJN9XWHE+fyuhxyzxoX9xSc98oaHYGlRljBOYoKp3sHMFQHJfSCMD9UJrf0Z2nO3+Q7DZM0hwM5XmO5RrDNhUJRp5qF9czSDgNaEUP2d6sctD7tEMbZeJb5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Hlp8vBse; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ayuBRYAi; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 59V73Y0j2059008
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:48:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=qgwrHL4mIWD
	XlhnJhcTW8PlWmQLURwHl1NklGm/TfcM=; b=Hlp8vBseqWneaa3Km3YHyMxDWMo
	whU9ic2x/1hC24GHsLsmsUbosJj3nd9VXL+g5NDsl7hznzKjYpo5CwaF/MVSPudy
	GUn+bw5/S76LMKbgi0IWRW8gcCGNc1YZ7nu0zoG6BvmtaF9xpQegsZ0fh4zrIzCd
	zYmMxr4wqQMaJFf/UqgCpIKSEE1qVIBakmPoKCJkanZ0dROvqVpR9jBr7bw99c7m
	WmMndsI54i2eLfRdlVXM2wppes+Xd5NgAFFLUtsndkgyI392aNlfmpY56gPWrq4T
	8wcwpb6q9xkwOxM4YzLFXau/ffY5zUzD2Y2RSk9UYSz8VkXSNvSvUu7Z7Nw==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4a4rcvgs03-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 11:48:25 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4e88ddf3cd0so52965631cf.3
        for <linux-kernel@vger.kernel.org>; Fri, 31 Oct 2025 04:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1761911305; x=1762516105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qgwrHL4mIWDXlhnJhcTW8PlWmQLURwHl1NklGm/TfcM=;
        b=ayuBRYAiSxg7cGxCeK8xF6WFtD/AaF2Zw3NZNI2RRp/1O9/3Htk5ch3zQ3gz9055u4
         B+qXfxrMzxvAZ8bTxd/ghPmBFMxrHQmrDonkwDlH5dB9hZFf0I3xyHj29FEzpbAQI/L1
         FqdU5jTXjqPdU48nyh+GNjXhNte/a0SIoVT3iQi2BdXDh/bRlEvdxvUnqnWyH43HIUH8
         icmXRMoDOSXq5iCsj0Wa6tJifezctdKuil+hLyQ+Y2ShM6GGOGM6Xn1g1hzdb7ZtUQpM
         tYlVB53kacYanUaJd7OpX60oHm8VK07s+WtJfBZRuKytzzvCY+mR3JUVwRCAuqwVbsZq
         xOcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761911305; x=1762516105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qgwrHL4mIWDXlhnJhcTW8PlWmQLURwHl1NklGm/TfcM=;
        b=jJgOgZajvA2FKukWls2dKWXfWSliRxBjnSdRgf1q6gf3UkGL5QY5olLY650Zq8N8My
         EVM8SjPjPh9TBEzWB9jN0YlVcDF4aTYlMOBgYHP+9OE9Avo9uQmhk0deZ5Dd9VfBOB3/
         FY00mmTHZl6kPqKF/LW1KVfBqDGifJU+60H0UxU4TSlUTXdvt9xvT+5dsPQfZLL1wKX5
         NkozTZwNDFY+OTWTF5IX59aq0REueOjNmM/FoLlOgX+XqjitADtGMfDRl4sCDFXbJQpL
         kdTK3hazavGB3IkwedYwJJSwtxIR/36MBu5yA/wmdXfTyInxYpimWLuzNTy8T7+2q6Q+
         r7tA==
X-Forwarded-Encrypted: i=1; AJvYcCUyDGrlt2H0w/Ezu9kZKvZsMu89r9mgBPBweDf3uf32zLIEn4BxhsxOW92JQktM8v2TePMSdIVar/HeTz8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKU3XTJZre0D5iQzG75SrTva+cO9qVfZgOeiqpinW3y8X70i+N
	OvpcGQtvKjjnUUWLx6B8+c+eq3d0oxWnbwGrA9LjRNPlFPWy4SgqMGp62piGs8g1nK1qKAX62hw
	3FrdZGGTXxTIMk84ZltRzoPW+SVKpA5GztQW71cH44lWzXt28FCbPq/KWjuFsQ6BgOKU=
X-Gm-Gg: ASbGncubkqceskZQDrlAKEQAkqZiASS2QKydhFGANRxwh43INSAY5l8urq3GUKn1DqH
	Hm8HowvLffwg6dA8Qs5cNz4gTR8VYVB6ZRUIUTStn/3j7O3blDW9KRnzKe/znAvyOMrT03VB0l2
	QuaBDuIG1lz4pXocM8G6mqtrzY/e8ejFffZoWxEnkaFbBZVH7V/Y4Qhr6+9M2qGzGLX1CQ/4bjO
	CfjqSLSYunM4d2s/4eLmLM2Wnw+9Bc7jQ+JGvJhotRzyWGj6pKP1ML/oTU2EFfC2slrzph2bIMu
	Xhkf2A/ZuGeXISnZbAJU8za8UfIP7zu6OUKP1710o2nFfijq1opsF6tTfXb1qF9SPSBimlMQ/bO
	0b2Fr6CxWXHYJ
X-Received: by 2002:a05:622a:5817:b0:4eb:a33e:6e32 with SMTP id d75a77b69052e-4ed30d56c17mr37055121cf.14.1761911304772;
        Fri, 31 Oct 2025 04:48:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6Uqx/qmZA1dGwjlYoTU2mJZKz2ZexJxlDQY0bz74P1DlKsZ4lpSFPWVkUeabKZk6Rn7XNfw==
X-Received: by 2002:a05:622a:5817:b0:4eb:a33e:6e32 with SMTP id d75a77b69052e-4ed30d56c17mr37054601cf.14.1761911304312;
        Fri, 31 Oct 2025 04:48:24 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47728aa915asm86831165e9.16.2025.10.31.04.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 04:48:23 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: robh@kernel.org, broonie@kernel.org
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
        perex@perex.cz, tiwai@suse.com, srini@kernel.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, alexey.klimov@linaro.org,
        konradybcio@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
        Stable@vger.kernel.org
Subject: [PATCH v2 1/6] ASoC: codecs: lpass-tx-macro: fix SM6115 support
Date: Fri, 31 Oct 2025 11:47:47 +0000
Message-ID: <20251031114752.572270-2-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031114752.572270-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20251031114752.572270-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=bJYb4f+Z c=1 sm=1 tr=0 ts=6904a209 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=wdEHzOyfiJQDvapTZ2sA:9
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDEwNiBTYWx0ZWRfX9gHbKN6phHHC
 6G7z5irUnkG14OV9PPwY7oDVbJHHMJ264pLk78PFFba1hBEhvRGHmtfUX6/YpDC2yHE/907Asx5
 kybX7Jp8GVuLTYdB9lXCWHk0zNmJSiY6lHDzdomqjbH1w/8UGD8/wtNGz9MTIYf/jCj4V7s+sek
 M3CKxmjv+tHMuPSYnp06jWYVB8yXUeDPTQAaA75F9EOvL8n5CYHzX5lQ61QcUh+7E7RfzIeHEfv
 M9p4VSxlg/D079RCrGSGfolQPYm808Zq7qiMZeyFr3FW3jLd5aC7Am+vEXoiNgAec6zH2Z8O097
 nBTQ/5IN8LVQms+0V9Q+mxp2Chezd0NpbG7E25+wi0S93wwZ6C7fUT9ufRXhqAV+GlLSnDIBV5V
 wu3exlxevXtDcrzhxsd+8AmDEpsojw==
X-Proofpoint-ORIG-GUID: oxXLotC_gJ5kgh9pl45ZOVyd_UdDqYGk
X-Proofpoint-GUID: oxXLotC_gJ5kgh9pl45ZOVyd_UdDqYGk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_03,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 phishscore=0 malwarescore=0
 spamscore=0 suspectscore=0 priorityscore=1501 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2510310106

SM6115 does have soundwire controller in tx. For some reason
we ended up with this incorrect patch.

Fix this by adding the flag to reflect this in SoC data.

Fixes: 510c46884299 ("ASoC: codecs: lpass-tx-macro: Add SM6115 support")
Cc: <Stable@vger.kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/codecs/lpass-tx-macro.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
index 1aefd3bde818..ac87c8874588 100644
--- a/sound/soc/codecs/lpass-tx-macro.c
+++ b/sound/soc/codecs/lpass-tx-macro.c
@@ -2474,6 +2474,7 @@ static const struct tx_macro_data lpass_ver_9_2 = {
 
 static const struct tx_macro_data lpass_ver_10_sm6115 = {
 	.flags			= LPASS_MACRO_FLAG_HAS_NPL_CLOCK,
+				  LPASS_MACRO_FLAG_RESET_SWR,
 	.ver			= LPASS_VER_10_0_0,
 	.extra_widgets		= tx_macro_dapm_widgets_v9_2,
 	.extra_widgets_num	= ARRAY_SIZE(tx_macro_dapm_widgets_v9_2),
-- 
2.51.0


