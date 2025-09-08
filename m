Return-Path: <linux-kernel+bounces-805071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0655B483AF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 07:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F4DD17882A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 05:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2EFC22CBF1;
	Mon,  8 Sep 2025 05:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="kJgTUo3G"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CBB239581
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 05:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757309852; cv=none; b=PdoxKYG0Ppnanr110b4o8QwxcpS6L5lW6i7GGtppcZ4gamgZ/+2t3ElPvJkBAtkHJHIFNgRkqX7V0s+/IOTIf6N4c2hTj4WPc0S4xdfNMvxojZpbLQX0OSuxMGOdE4Q1n3rNS+7hT6suZK41e0oQ2ET7q6sFA9gy3wvTvn2E3qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757309852; c=relaxed/simple;
	bh=z+gGsuW1nP7yJtlnfXfDq453MF7xeDeN/7Bqp1rigus=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C7RfU8kXvi1qfNIi6P7RtUgb3vfIQ4apoDuEBsRIzmGDEoC3wAXe2oFKVBeo2oHVBP3ra+xEDxPwX+uSyfjbpckCVrCozfb/SuxbbDFFq7fO1CvyxkLZX7c0b9via75vE2DIxlX8x+6ivJ/37KJBFByYrn9rBoHh6xcgw64R3ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=kJgTUo3G; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587L0GbL008077
	for <linux-kernel@vger.kernel.org>; Mon, 8 Sep 2025 05:37:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=Q4ORjV3h/Ug
	G8t1QXMHoEv//ijDc+HhKRFWyrdBcOJg=; b=kJgTUo3GtKfTXy3jwEQpjWCBS+V
	RG3m1bVfT8HIcEfzzGhPjML2UL8WuWhcbtmNtCnsnPcIDtN5pl8NkkCvtooPUD4m
	CNnpzlKWn4gOccAyr7Qpot2nru//y1hwWw2BAhsriDKqnDLYql+NHPpcRfynXAEj
	yqzbewruE/3KszbIqSTCuUxn5EIZzb6mm4J6awhOR1dDHiOguCXDGgFQTUMsm87w
	q5CbolB0KbzHNjx/UWs7CpP1om6zYzbTeZ8TPhCjNYbueXtsgTXyjklSOAByB9LX
	7LYyFHVtjryYgibdyhehuhh4uX2Ux4n1nqo6BXNshXf2BXlyFeLTl9SsaTw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490d63baem-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Mon, 08 Sep 2025 05:37:30 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b4c46fbb997so3886040a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Sep 2025 22:37:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757309849; x=1757914649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q4ORjV3h/UgG8t1QXMHoEv//ijDc+HhKRFWyrdBcOJg=;
        b=wUxVdqYAyTsElAiYvRy7YvkpEzG588YwqY8OuVF2Hl9cqct3hQ7UC+OUQWM8LckSoz
         H5KxHvRvNcy8y/VJtrJNAoGBDef5YX1JSBdA72ehQQJcUGaden33O0T54IfmFRhPuQsA
         3lzIr0tLsJvs0S+f/ZRiMR4DA4CcsPSVqHff2tB3lQdzM+yF4E6lc9abzD2UqoPwjubH
         ufOmIoIyq0dmXEgWobD8uZ+wfsJnXOt4LUhhI8/Z5Ey1Dcm5Wssn0JuMnN3sDrdZrP5Z
         0Sirm8TVdJW6WdaQ2TpQFTJ+TLYzHSpRo84WkpfEThIgLLsG6sJWqQC9J3wBAA/t2mXS
         MHLg==
X-Forwarded-Encrypted: i=1; AJvYcCWhoKqOPAF55MQ7aXjW9xnGKT4c0HEqsCxuti9QvRLkldb6pHvWW9jIJufXo7bgiPpEXf5Ko4dOENORHas=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzXrV3pQG9pdUqKRV+inX3Yseh/hxjglgdhw8hTBOiXtMRkI0H
	26tvX7KxJj8ujBvqOEz2gsA8eD0BoY3wHYY7JV3ol7I27AU6y/HbSuo0coWWpgB2wEDBM9uRqCN
	MunJWqyKQ8mu9EMTsNgRs9C2K7ikpwaKcu344iKnGWTPhEp0YvxqnPYSSfbPgZOMcpAk=
X-Gm-Gg: ASbGnctvMnDbrSXeNDbeeg8ytuNaM2+CM/37yRFKrRhKJx2lK/dbHyLzNBl/Bm1UcAv
	JV572MGCI2DhoUlBK3phFpIz85ESMmuIC3ScgJEdTyJ5GW5PfqM+o2WXDK9PBg2nVFMRhkSmEH7
	z79tkYBwwYJnx3CepBeA2c/Hvl3xYQ2Vk12ppB0Ho3X/PZnNH2BgUanF6raLYsrfTyFBhMH275/
	RKm9w528FT0EBGTBKfuSHFJO0Lz4WyLPElhQaC5Py8YRMt1FQ68mw/HCncCzKvwtjUUKgGFq/2a
	f/m0ko/wCKCdG01TdoK6cXhnojIE9tFk7GVcWDHyHznXmxVF2uROzlPmypq4aKbVMSHgXWGZ88Y
	q
X-Received: by 2002:a05:6a20:7d9e:b0:24e:2cb:673b with SMTP id adf61e73a8af0-2537e066fcemr7667951637.26.1757309849242;
        Sun, 07 Sep 2025 22:37:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUB3fffQc0dYIvBmhNho3Grz0OULGZkqOb9HQi9BruK+kfs7gs6X1rClEeQVcaz0XcgWbw6g==
X-Received: by 2002:a05:6a20:7d9e:b0:24e:2cb:673b with SMTP id adf61e73a8af0-2537e066fcemr7667929637.26.1757309848724;
        Sun, 07 Sep 2025 22:37:28 -0700 (PDT)
Received: from hu-mohs-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7722a4e1d4fsm28013488b3a.73.2025.09.07.22.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 22:37:28 -0700 (PDT)
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel@oss.qualcomm.com, prasad.kumpatla@oss.qualcomm.com,
        ajay.nandam@oss.qualcomm.com,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH v4 3/3] ASoC: qcom: sc8280xp: Enable DAI format configuration for MI2S interfaces
Date: Mon,  8 Sep 2025 11:06:31 +0530
Message-Id: <20250908053631.70978-4-mohammad.rafi.shaik@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250908053631.70978-1-mohammad.rafi.shaik@oss.qualcomm.com>
References: <20250908053631.70978-1-mohammad.rafi.shaik@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyOSBTYWx0ZWRfX0Q/w1s21rttb
 DFkCgv/Y3RpMhyy6VL0TNgGBLiiYNpsgi1StvZfM37I4t8gTEeFEQN3cwKmSWOp5iJLlfeyX10/
 BuIg+9eMR7Puuusovp/vLTGF7N4iBp53WFHL687k3GHK5Q9q0Pymuz0lvGKiXc3RHWineEIkGT5
 TSjQI1JKbil/isGjc1TxNY7VnxSSYqLF831msGE6j7kazFP6nEw/L3IL35F+gusNazuCjPRjukT
 zlmnYdT136BWqYJ0TPTGzxH3uiQuWpenEaVyZi7N2zXjEsFgsCcUHNh+SBW+9f44Z4muCW1hCzL
 /hm1S0e4lAGUJZ9W5h88l7CCXjBzKh4pP1LNAvc8Mj80/lZeDbq2a7tfZeUuHn0OQkUbMs81Qiu
 5ro+jeXs
X-Proofpoint-GUID: ImKOpGf8DTQ7pZRoLlhCmjxGtdgq73DA
X-Proofpoint-ORIG-GUID: ImKOpGf8DTQ7pZRoLlhCmjxGtdgq73DA
X-Authority-Analysis: v=2.4 cv=DYgXqutW c=1 sm=1 tr=0 ts=68be6b9a cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=wtrncf1qwap5WzB382UA:9
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_01,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 spamscore=0 impostorscore=0 malwarescore=0
 bulkscore=0 suspectscore=0 adultscore=0 clxscore=1015 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060029

Add support for configuring the DAI format on MI2S interfaces,
this enhancement allows setting the appropriate bit clock and
frame clock polarity, ensuring correct audio data transmission
over MI2S.

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
---
 sound/soc/qcom/sc8280xp.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/qcom/sc8280xp.c b/sound/soc/qcom/sc8280xp.c
index 73f9f82c4e25..3067b95bcdbb 100644
--- a/sound/soc/qcom/sc8280xp.c
+++ b/sound/soc/qcom/sc8280xp.c
@@ -32,6 +32,10 @@ static int sc8280xp_snd_init(struct snd_soc_pcm_runtime *rtd)
 	int dp_pcm_id = 0;
 
 	switch (cpu_dai->id) {
+	case PRIMARY_MI2S_RX...QUATERNARY_MI2S_TX:
+	case QUINARY_MI2S_RX...QUINARY_MI2S_TX:
+		snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_BP_FP);
+		break;
 	case WSA_CODEC_DMA_RX_0:
 	case WSA_CODEC_DMA_RX_1:
 		/*
-- 
2.34.1


