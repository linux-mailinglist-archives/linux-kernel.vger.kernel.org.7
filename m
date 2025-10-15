Return-Path: <linux-kernel+bounces-854568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B35BDEB8E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 15:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21002481A95
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Oct 2025 13:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B12256C8D;
	Wed, 15 Oct 2025 13:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YzZAZ7p9"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6466323B628
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760534300; cv=none; b=CaCTxqxdiHe6mVlERbD7R+ea944W5QzIPOkUq9F5kN705c4eVRyV28qA5PhhVQGONYApwmcgwyhVbkd4jDMCJxlQB9+G87j6/7bMyVwhtaon5KyCOu3RoanpnpLrixePJkfOp3S9KudZuqtPPObtU3f0uEjOAa3dvr2tJhRAQsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760534300; c=relaxed/simple;
	bh=mHHpksYNvrqCcT9vbu6eHsvNp/9SL9pX3pbcMgnpkWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LrSqlN1F4K/oF8dhNQz4eOBawLEv94rTO2TTM+DXh1TDB808ea6rScpPpU7ZzqbKHs0vjLF91vtx1ZkSPb8RmyZpbDkv7DbvsatMNAQEvzd/llOPZcfqoZH+MyeJbgyilvZ9CUGIJM3AY4POXidfuT3DXS3Wiv1jXmBCPILV7Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YzZAZ7p9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59FAUo3u003404
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:18:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ZT+0rRtvs50
	XRBp1BW4ZCSU4gfhMJjkd8JcHG8nO/pw=; b=YzZAZ7p9QgHqm37k8KIqAqn99ws
	ySimm3XR00UldujnpgUieFIeadi8MbVcERYqYbiERmT1EXkjUn+deWrNFLyQKHND
	nG6ilvXE2r7v0JN/vtPunzzS30Cp1PI8QsbI5D66n0REfwR9RF31gQIArYbVlLl8
	+1oUiPPMZYv7AbJ/jNC8JZRHMuUhn1jS983oE6ImW7zIqFeUU0tBauD+NC4Mpj2p
	1HJrHuQICf94amjB3/7Mie/8m1YfQfJOTMO5euyNEjQ6dtNaA1c5x8+8jShSk1tf
	pSOAcgH6Vwm0CIx5+WEp8FxW/eiilXWWMz78oBV2lzLtwcA0xSag01yCwKA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49sua8k3vb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 13:18:17 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-8217df6d44cso2711389985a.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Oct 2025 06:18:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760534296; x=1761139096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZT+0rRtvs50XRBp1BW4ZCSU4gfhMJjkd8JcHG8nO/pw=;
        b=syqIXoJVOBkFyu/bENZQu5zpwYw9riYyqXcWJJIJzchMO5e39JfuEJTlYkmyC96kBE
         K4vrg7uIYnV9NbL6Rb/8iWNroSy2Q7oxQlhGosv1qo3rriVFkPZjiyv3KKpd2nNbbWMt
         hD21+n2ldjm3RY3QddIhAAU7L3fTN5Qv8Pgc0J5rmEuimY3V7UcU2EB4gyL4iQH5ohax
         mbvKoBVmn6xSt+ve7ZwOYtzgR+kZwztsu1gGojaZaXNA2As6I87fTzRQemtUfJDlRBuV
         l+0EELweaZ9Nd5yIZD5IA3jZ0nlhQU6oukL7M223Wf1xPpjAWXuFc4bf22Sif8yJKDNK
         /EMw==
X-Forwarded-Encrypted: i=1; AJvYcCWZivU2CnrQJfPOuOY7kVxrsXqdKhb4BsXpXs2n8fM+D+Bg1P9Eix6rsVRzMVt1bEBXuzLmKeHEBLJKpFw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6g+wfwJeiyAZZ3MwtBNK0fpE18AegJKaXOX4M3cDMjjmvcu0m
	rz6/Q+7yLPJdPel7OBwbU1WqP1fW3ZE/yt+dvGXpFMCM7BFSNdTOvVqtwBB5slH/CUDpYmnmtuo
	+MPneiC/vrTzNk17cIjKss9jG5T/Hqp1BixfQCaSwHXXdgQADWs1VWLh5OK/U/gcIBjg=
X-Gm-Gg: ASbGncskG3GgWLbFd7xqQ8tpnp0s+k6EjgZA2tmzzJYmaPvEWS9PvuuOdlh9bWaJ9Y5
	dt8gPrEPsBWEZ/SKDVh2VD/igBNRB5kWvcTeymFr3q0rVc94dgZ1kopoIXflJUZCrbpqlxF6eSR
	EPWNB+3njExIZfqZubKOJK7mOmQ8jyTuY7v679Xu+F0TIXXCrrPZRrJkHlrRW85yF9aRYhSP1U2
	v0ICodc1w4dBHvKthP3HNTdg+Kj/TywPjqIIn8b10r6WEyMIHl3rHjWuCFbLdoK/KrzmY1RUY8t
	CzRjqKufOQA5FZpeGtHrQbGctmcj86FxzyfqY2nascKvrD2hC2Mc1g==
X-Received: by 2002:a05:622a:1a9e:b0:4e7:1f73:b40a with SMTP id d75a77b69052e-4e71f73b42emr156480171cf.1.1760534296161;
        Wed, 15 Oct 2025 06:18:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtim+HkRY58yGLvCgiO1qtGySVPyoWgNetwZg54hH/ZzI/xMzFzmKFFqAAZCU5tJGw/TQxUA==
X-Received: by 2002:a05:622a:1a9e:b0:4e7:1f73:b40a with SMTP id d75a77b69052e-4e71f73b42emr156479521cf.1.1760534295614;
        Wed, 15 Oct 2025 06:18:15 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fc155143fsm262081245e9.11.2025.10.15.06.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 06:18:15 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, alexey.klimov@linaro.org,
        linux-sound@vger.kernel.org, m.facchin@arduino.cc,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH 9/9] ASoC: qcom: q6asm: set runtime correctly for each stream
Date: Wed, 15 Oct 2025 14:17:39 +0100
Message-ID: <20251015131740.340258-10-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251015131740.340258-1-srinivas.kandagatla@oss.qualcomm.com>
References: <20251015131740.340258-1-srinivas.kandagatla@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: TDaXXCtFmV6JkFV9XfSpwrrcaCd_LUUQ
X-Authority-Analysis: v=2.4 cv=e5MLiKp/ c=1 sm=1 tr=0 ts=68ef9f19 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=KIUBPGGZ3vVIRF5Z0fMA:9 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE0MDEzNCBTYWx0ZWRfX/iPHXour4mb6
 heOcZc0+AxKUisT/bNG8Yb71VNp01vXBzIAEqv5suV2bJGkwjHRW/b9fDlii5jAnd/pruxV7mIv
 CWZJeztn9hcqeXhgc5FkHlxaB8S1rNRfwXNR66vRmuVn9+S5EIUZoBGRmxcOdze9fS4CSQcHc6t
 u0BcBiqbNqHNhiP/utDNt46+BAJ8v+jRUFRtEMWlZ8+DZop6lnQXpO77VaW76uWH6oEGbP2xO9d
 lT9O2YR2KfQyphGuGPoGbIkupEzR61aClBVub7VcxxRuVWsXj4rGpY64rMNcnfxJgns5pKSf2d3
 x/cLnL1UWydWT0HE1W4NBzYkc+ZRI53BcybwuHcFRkFDXyYQAUN+7mC3+0VrbCiChnV13vmN7yc
 92UlKiBRiDg7zOj0VGGNv5tlVd4QpA==
X-Proofpoint-ORIG-GUID: TDaXXCtFmV6JkFV9XfSpwrrcaCd_LUUQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-15_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510140134

Both capture and playback can have different runtimes, so set them
accordingly.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/qcom/qdsp6/q6asm-dai.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6asm-dai.c b/sound/soc/qcom/qdsp6/q6asm-dai.c
index c2a33d6a0827..97256313c01a 100644
--- a/sound/soc/qcom/qdsp6/q6asm-dai.c
+++ b/sound/soc/qcom/qdsp6/q6asm-dai.c
@@ -433,10 +433,13 @@ static int q6asm_dai_open(struct snd_soc_component *component,
 
 	runtime->private_data = prtd;
 
-	snd_soc_set_runtime_hwparams(substream, &q6asm_dai_hardware_playback);
-
-	runtime->dma_bytes = q6asm_dai_hardware_playback.buffer_bytes_max;
-
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+		snd_soc_set_runtime_hwparams(substream, &q6asm_dai_hardware_playback);
+		runtime->dma_bytes = q6asm_dai_hardware_playback.buffer_bytes_max;
+	} else {
+		snd_soc_set_runtime_hwparams(substream, &q6asm_dai_hardware_capture);
+		runtime->dma_bytes = q6asm_dai_hardware_capture.buffer_bytes_max;
+	}
 
 	if (pdata->sid < 0)
 		prtd->phys = substream->dma_buffer.addr;
-- 
2.51.0


