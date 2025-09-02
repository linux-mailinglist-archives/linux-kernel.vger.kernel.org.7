Return-Path: <linux-kernel+bounces-795618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A2D2B3F561
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 08:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D15E5203DB3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 06:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC462D5955;
	Tue,  2 Sep 2025 06:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mHOAGJ+L"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EE02E36E9
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 06:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756794202; cv=none; b=EcU+cdxdMXnCIjGktnKB2k3Pq/5j6Ifq2SfSh+uGwIXtzKfn1m5RYxBQsqV8ieT/OfVYZssPtBhRuM5MElHUkEHCLbJWbgH+BBg9S+Fl7CYND1Js9b8CgD5kdKUpgrdaE0d+51DPS9TynQ05ZjHFKoYGnxRQbWrwd43UU5MdlmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756794202; c=relaxed/simple;
	bh=cM8cHbk2w2OZZmrz8yTgYSsbAJdpFmYssbRnSJz7abs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l7B4IsnP9PO/1LD/6I9TLD2CXh/mEdxUeQVjqC+qUvRL25G0KswJp9zfgODx8us64qC3rhT6y5foZrVWnSteeKFLKKN8Ne8LE5mycamxhUG6zO7+S8m7yjW4IwcJVpD8YoiK+QCwIIlysnBN1GTW/jsP1jeYaS1UVB+ofAimXmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mHOAGJ+L; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5822RomY024996
	for <linux-kernel@vger.kernel.org>; Tue, 2 Sep 2025 06:23:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=5ty6U2xSO9fd8vI4ZNE2UCnYZYglW+cz1tw
	BcARdgyU=; b=mHOAGJ+L7STTd7ew6jwzMWFFK1WRI268+ko4OtvjWE6XiSqGQqy
	TYqF6rPlrx29ppH0p5FivNLORFKpL84C0OeioyFRELf3kfAB/L+Igz///gibEH6F
	LSNxOnpcZ7FEH5axlEiTky4iECmFOQqXxcE2/b7er91xdZOOCOh8fz4YUB7hfQsH
	mOJ+Hg88D0EWV1cgNHe5z+2rYxT8HlZDXCQqgZuffQnjrRRQ6PoJNpnqVFluIXpX
	GzILJqrbOv56P5ha6dLYvdFGBIhAObZlYkGzBX5qYGY0xhkl2IQXOXO38XFf5ElZ
	vxAlVK2tDwCTeHz0AWgVNuo3qczDlKqAKcw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48uscuxsen-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 06:23:19 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-248fbfc35ddso73450745ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Sep 2025 23:23:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756794198; x=1757398998;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ty6U2xSO9fd8vI4ZNE2UCnYZYglW+cz1twBcARdgyU=;
        b=GhBj1JgEfMpdbq8GxqBEfx9T9q096vp2Wa1W0qtgIfXN788oNQGTGWRpKEA26KA4e1
         CZ3FMjwkm3FIzq7MuKrWo2iUzvyKvWOqWjMurtGaAFOiRKSHGwWJzxxL74IbaZr9DWeT
         JLVNe4XiVoBixt2jl9/tdbgD7kLVLwOYLLuoCYW+7pHHnLYmFdhYgSanNjR29xdOORcd
         U7RkSNfQDMizteg0+wKcgr0wjA89tn83MQF4rY0uiI+gheijhEtK9JjV0peMG2TfwpTX
         IQok+KLI6U4SKoO1vINlvDKXKI7mSfpZLuK7RPriC2g58RgfDL0vY97TvcTr4tD5d8Ya
         KXSg==
X-Forwarded-Encrypted: i=1; AJvYcCWJ7EEhVT8Kvu36HKAMFQexTaLTiLFV0BjVxXBAg5BgrX2u66yQGov4eruLWbFIzXJDigrVw1kiz+tUeCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMHJnytcrKnYmVBvFfJH4JP7ij6N8fEKqxda0Fo4/V3yKr1Nja
	aoy/yz4tVPyTf4Bg9mTrnszBghsWIeV7RaoLZ8SlC49Dn4qQwlHlGn1bByNG8ZxPOTGYbjyONnO
	MfoIeAyB93ORwaJhfKAAyLc9j5BJ6GS+xB1qAV8aT2m2M8JWfB0u/nR6J+W4RP3FCkB8=
X-Gm-Gg: ASbGnctYF4NINaGbZBRxLQEHUUTQG3i7OOvVpJTEg9Wuif7rIEyxK6euH53aQ4+x5Yg
	4qNONp3MfXOMmCEgnd57h8gVZq9eL1UM0xekIJ2Ol3piY8Izkl/6Fy15AYcO3KnJ6+E7Jlno7AO
	WuPLFck0ye1L81+940RIXm5uM3Ik3kQUJGwLLkN/XxkRdkVZ50x6vY0+okKbEcEDY/OWtGu3QLf
	3Ka0sV0SWVDYfMvUsSPZ11xbd1p7fxW5QvXLIrPgRHx8awcvXe2dd/Nr04o0UcHd50y82/R8XsU
	R8NxVIIh50qzDMjnPZIvRYOtx9wcuSz3r/jYLwJVrUsytJVpNjUHn37tHoqhvv3MhGcY88nRxHJ
	t
X-Received: by 2002:a17:903:1ac6:b0:240:83af:e2e0 with SMTP id d9443c01a7336-24944ae7beemr128467115ad.47.1756794198505;
        Mon, 01 Sep 2025 23:23:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFflNm60kP5vvYAR/1um79Y/dSnIfm6IPaMoEH9Ts6y42H+X93PKZ2oPk6BBwsDEUByGv+wtQ==
X-Received: by 2002:a17:903:1ac6:b0:240:83af:e2e0 with SMTP id d9443c01a7336-24944ae7beemr128466795ad.47.1756794198004;
        Mon, 01 Sep 2025 23:23:18 -0700 (PDT)
Received: from hu-mohs-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-329b641fdc0sm1894231a91.7.2025.09.01.23.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Sep 2025 23:23:17 -0700 (PDT)
From: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
To: Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com,
        prasad.kumpatla@oss.qualcomm.com
Subject: [PATCH v2] ASoC: codecs: lpass-macro: Add support for channel map mixer control
Date: Tue,  2 Sep 2025 11:53:00 +0530
Message-Id: <20250902062300.212021-1-mohammad.rafi.shaik@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMSBTYWx0ZWRfX7A+bKIX9obB2
 +pyNDqFr/icy1dSYa+h+ujUNzDmvNd8NMED5KW3A85TBjbMlPM3lqP1wpJN61Z+xj83SpMYKAlF
 r4nEVNJYeKc1VuKCINgpAyJlCyUu2g+ZVs8yR5YK4QH1Kuk1/NlhF2sskFa6UIDmY0DkYTfaYKP
 pr/kYX2EI/125GgunCHa432/kyFBgo+HZLB9tiG3JYoOzR5kff+k2TZUxkuhuLGQSJrBG6RW6HJ
 qB3RTR0jeOYT0MLLgz0xipK5d0a8UT8xvDyEwvjue/OD7Z/NsmvvPIR3IFBgDmcRk28Sa/rfKJQ
 4+t7ZAecXA6o34S6sCn6nZgp8TxZAEOa11YV11ob3krFBuo90EukEK3iQLXHPx3O7SrfBoQRdm6
 nr2TFDea
X-Authority-Analysis: v=2.4 cv=A8xsP7WG c=1 sm=1 tr=0 ts=68b68d57 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=zFJH257Hk5x_bgKGl4gA:9 a=GvdueXVYPmCkWapjIL-Q:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: LDvfqjcZLN1qiWXJV-DRYNOBalGjlfGY
X-Proofpoint-GUID: LDvfqjcZLN1qiWXJV-DRYNOBalGjlfGY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300031

Introduce the channel map mixer control support for LPASS macro
codec Digital Audio Interfaces (DAIs). The channel map mixer controls
are required by APPS to configure usecase-specific audio routing and
channel mapping.

Signed-off-by: Mohammad Rafi Shaik <mohammad.rafi.shaik@oss.qualcomm.com>
---
Changes in v2:
- Updated patch with improved commit description..
- Link to v1: https://lore.kernel.org/linux-sound/20240930053111.3986838-1-quic_mohs@quicinc.com/
---
 sound/soc/codecs/lpass-macro-common.c | 55 +++++++++++++++++++++++++++
 sound/soc/codecs/lpass-macro-common.h |  2 +
 sound/soc/codecs/lpass-rx-macro.c     | 12 ++++++
 sound/soc/codecs/lpass-tx-macro.c     |  9 +++++
 sound/soc/codecs/lpass-va-macro.c     |  9 +++++
 sound/soc/codecs/lpass-wsa-macro.c    | 12 ++++++
 6 files changed, 99 insertions(+)

diff --git a/sound/soc/codecs/lpass-macro-common.c b/sound/soc/codecs/lpass-macro-common.c
index 6e3b8d0897dd..777af4885245 100644
--- a/sound/soc/codecs/lpass-macro-common.c
+++ b/sound/soc/codecs/lpass-macro-common.c
@@ -8,12 +8,67 @@
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
+#include <sound/control.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
 
 #include "lpass-macro-common.h"
 
 static DEFINE_MUTEX(lpass_codec_mutex);
 static enum lpass_codec_version lpass_codec_version;
 
+static int lpass_macro_chmap_ctl_get(struct snd_kcontrol *kcontrol,
+				     struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_pcm_chmap *info = snd_kcontrol_chip(kcontrol);
+	struct snd_soc_dai *dai = info->private_data;
+	u32 *chmap_data = NULL;
+	u32 rx_ch_cnt = 0;
+	u32 tx_ch_cnt = 0;
+	u32 rx_ch, tx_ch;
+
+	chmap_data = kzalloc(sizeof(u32) * 2, GFP_KERNEL);
+	if (!chmap_data)
+		return -ENOMEM;
+
+	snd_soc_dai_get_channel_map(dai, &tx_ch_cnt, &tx_ch, &rx_ch_cnt, &rx_ch);
+	if (rx_ch_cnt) {
+		chmap_data[0] = rx_ch_cnt;
+		chmap_data[1] = rx_ch;
+	} else if (tx_ch_cnt) {
+		chmap_data[0] = tx_ch_cnt;
+		chmap_data[1] = tx_ch;
+	}
+	memcpy(ucontrol->value.bytes.data, chmap_data, sizeof(u32) * 2);
+
+	kfree(chmap_data);
+	return 0;
+}
+
+int lpass_macro_add_chmap_ctls(struct snd_soc_pcm_runtime *rtd,
+			       struct snd_soc_dai *dai, int dir)
+{
+	struct snd_pcm_chmap *info;
+	int ret;
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	ret =  snd_pcm_add_chmap_ctls(rtd->pcm, dir, NULL,
+				      2 * sizeof(u32), 0, &info);
+	if (ret < 0) {
+		kfree(info);
+		return ret;
+	}
+
+	/* override handlers */
+	info->private_data = dai;
+	info->kctl->get = lpass_macro_chmap_ctl_get;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(lpass_macro_add_chmap_ctls);
+
 struct lpass_macro *lpass_macro_pds_init(struct device *dev)
 {
 	struct lpass_macro *l_pds;
diff --git a/sound/soc/codecs/lpass-macro-common.h b/sound/soc/codecs/lpass-macro-common.h
index fb4b96cb2b23..23ed6836addf 100644
--- a/sound/soc/codecs/lpass-macro-common.h
+++ b/sound/soc/codecs/lpass-macro-common.h
@@ -40,6 +40,8 @@ struct lpass_macro *lpass_macro_pds_init(struct device *dev);
 void lpass_macro_pds_exit(struct lpass_macro *pds);
 void lpass_macro_set_codec_version(enum lpass_codec_version version);
 enum lpass_codec_version lpass_macro_get_codec_version(void);
+int lpass_macro_add_chmap_ctls(struct snd_soc_pcm_runtime *rtd,
+			       struct snd_soc_dai *dai, int dir);
 
 static inline void lpass_macro_pds_exit_action(void *pds)
 {
diff --git a/sound/soc/codecs/lpass-rx-macro.c b/sound/soc/codecs/lpass-rx-macro.c
index 238dbdb46c18..db08be2600ea 100644
--- a/sound/soc/codecs/lpass-rx-macro.c
+++ b/sound/soc/codecs/lpass-rx-macro.c
@@ -1953,10 +1953,22 @@ static int rx_macro_digital_mute(struct snd_soc_dai *dai, int mute, int stream)
 	return 0;
 }
 
+static int rx_macro_pcm_new(struct snd_soc_pcm_runtime *rtd,
+			    struct snd_soc_dai *dai)
+{
+	int dir = SNDRV_PCM_STREAM_PLAYBACK;
+
+	if (dai->id == RX_MACRO_AIF_ECHO)
+		dir = SNDRV_PCM_STREAM_CAPTURE;
+
+	return lpass_macro_add_chmap_ctls(rtd, dai, dir);
+}
+
 static const struct snd_soc_dai_ops rx_macro_dai_ops = {
 	.hw_params = rx_macro_hw_params,
 	.get_channel_map = rx_macro_get_channel_map,
 	.mute_stream = rx_macro_digital_mute,
+	.pcm_new = rx_macro_pcm_new,
 };
 
 static struct snd_soc_dai_driver rx_macro_dai[] = {
diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
index 1da34cb3505f..934b814b7a01 100644
--- a/sound/soc/codecs/lpass-tx-macro.c
+++ b/sound/soc/codecs/lpass-tx-macro.c
@@ -1210,10 +1210,19 @@ static int tx_macro_digital_mute(struct snd_soc_dai *dai, int mute, int stream)
 	return 0;
 }
 
+static int tx_macro_pcm_new(struct snd_soc_pcm_runtime *rtd,
+			    struct snd_soc_dai *dai)
+{
+	int dir = SNDRV_PCM_STREAM_CAPTURE;
+
+	return lpass_macro_add_chmap_ctls(rtd, dai, dir);
+}
+
 static const struct snd_soc_dai_ops tx_macro_dai_ops = {
 	.hw_params = tx_macro_hw_params,
 	.get_channel_map = tx_macro_get_channel_map,
 	.mute_stream = tx_macro_digital_mute,
+	.pcm_new = tx_macro_pcm_new,
 };
 
 static struct snd_soc_dai_driver tx_macro_dai[] = {
diff --git a/sound/soc/codecs/lpass-va-macro.c b/sound/soc/codecs/lpass-va-macro.c
index a49551f3fb29..69224c7805bf 100644
--- a/sound/soc/codecs/lpass-va-macro.c
+++ b/sound/soc/codecs/lpass-va-macro.c
@@ -938,10 +938,19 @@ static int va_macro_digital_mute(struct snd_soc_dai *dai, int mute, int stream)
 	return 0;
 }
 
+static int va_macro_pcm_new(struct snd_soc_pcm_runtime *rtd,
+			    struct snd_soc_dai *dai)
+{
+	int dir = SNDRV_PCM_STREAM_CAPTURE;
+
+	return lpass_macro_add_chmap_ctls(rtd, dai, dir);
+}
+
 static const struct snd_soc_dai_ops va_macro_dai_ops = {
 	.hw_params = va_macro_hw_params,
 	.get_channel_map = va_macro_get_channel_map,
 	.mute_stream = va_macro_digital_mute,
+	.pcm_new = va_macro_pcm_new,
 };
 
 static struct snd_soc_dai_driver va_macro_dais[] = {
diff --git a/sound/soc/codecs/lpass-wsa-macro.c b/sound/soc/codecs/lpass-wsa-macro.c
index da6adb3de21d..62ed1173fd1c 100644
--- a/sound/soc/codecs/lpass-wsa-macro.c
+++ b/sound/soc/codecs/lpass-wsa-macro.c
@@ -1354,9 +1354,21 @@ static int wsa_macro_get_channel_map(const struct snd_soc_dai *dai,
 	return 0;
 }
 
+static int wsa_macro_pcm_new(struct snd_soc_pcm_runtime *rtd,
+			     struct snd_soc_dai *dai)
+{
+	int dir = SNDRV_PCM_STREAM_PLAYBACK;
+
+	if (dai->id == WSA_MACRO_AIF_VI || dai->id == WSA_MACRO_AIF_ECHO)
+		dir = SNDRV_PCM_STREAM_CAPTURE;
+
+	return lpass_macro_add_chmap_ctls(rtd, dai, dir);
+}
+
 static const struct snd_soc_dai_ops wsa_macro_dai_ops = {
 	.hw_params = wsa_macro_hw_params,
 	.get_channel_map = wsa_macro_get_channel_map,
+	.pcm_new = wsa_macro_pcm_new,
 };
 
 static struct snd_soc_dai_driver wsa_macro_dai[] = {
-- 
2.34.1


