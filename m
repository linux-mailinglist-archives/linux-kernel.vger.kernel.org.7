Return-Path: <linux-kernel+bounces-853005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1E0BDA770
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 17:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A4B1350198E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 15:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 931B8246BDE;
	Tue, 14 Oct 2025 15:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="c9HDrotK"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93184296BBB
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760456154; cv=none; b=MV4qJJF8q1PYjNLkUtXOh+X+WcD9uuL62xnxKJuovsUgtH2aYfcJraPbe+WfkNZOYy14njAnGbXCAhLD6wYy94mrzWsoqQn8E1WELr5TwDkQg2egUo+6bJX4WcDaRbPrfAUCZ0yTWewXGuFAN4tKLd0FA5WsFwkB0lsUddF0r4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760456154; c=relaxed/simple;
	bh=h9O9YfvHgRK4pYbs4jacz0KXOEx7UP+LwPtZLz0f32U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NJFFySmzBlqA1xP0Tt+o8G5hzaaByu1dWer+1fWyOcicyGuE5nvAzMBvk7QhBpD6Dzc1aOj5noAvxI3/mhkM5lcGvmjvC7Bi1d4tCaaXilyIaCjmy0XwFEV7dkAtP+9K/DRvYTVRpIZLFxNFsQ794EbqM4Sk4UTGHnP5nOUgcHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=c9HDrotK; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59E87OGH021140
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:35:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=8b75bEAsWB9Fz6VWxCILAoiZY0eXy9b9mMB
	Cdy3bt/Y=; b=c9HDrotK9WRvzSvH+E4RTMrgFphFWCCR2X8lSVcERRRttoawZM4
	cuWVKt29G/BVS9TkfGgyZKYZCre55Owd72wdUfxI2U4nV8JVlhidd+CrwJ9Xger0
	jK639aviu498OTXwRLHZU4F6scTgWwWnr3AXctnVLfNA2FWzhoGOhWvZylklPSAZ
	ov1xqhg+iWGgtqqp2uPCAPx7/6kdnMRn2W7edSOi6CAN40emqGESOEQZBe3mcbyl
	/PSznWS6ERhx1LnCzkEIB28R9Lx9dSR3loS+AO8W678JxGKFsgqB57H2BcNup/LR
	Pc4kknzGtRdJFGBpNKKFVKHhJpvj8Nhi/Cg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 49s6mwkbk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 15:35:51 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8892285b436so1187492585a.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Oct 2025 08:35:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760456150; x=1761060950;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8b75bEAsWB9Fz6VWxCILAoiZY0eXy9b9mMBCdy3bt/Y=;
        b=tM5mdVbqQjsxKKktgE++lgBHpXwodEzgpSQodpIqt5MLopBUmV1HGyr3nUFCd+Ojk8
         KeqAtsDd8v3uDx1MH/1g6f5wNICfKcWGhCIlCfp0XMmh2GFv3vZkSrTpJBhaAZe6eI6v
         cgMUr7UDA57wIA5BkSDRuVB8n1SzoMcu+1t4EED1CWxBdgS/nric1A/tnXt99oZo0hL6
         f+adR84Bk1y70NqGBtuSDZv44BUQ0ATw85ymrFhJ8GGdCXW3SXmrSZmr4KyO4u4QcQS3
         NqV7sDREzEuUlg1ElabOQnMcM3r2A2DKahk8vSzjHQK8oNibs0jUVAuWoNzU2O0XBXnV
         bh3Q==
X-Forwarded-Encrypted: i=1; AJvYcCXOwQCpj+vrUDpFiOR/gtSdPeEkiSMlW7Q3mKlzR0sClamalMrDb4LAzMDrMW9q6KuZ+JVpMVmL8ZxS+Os=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfdSm3yM2RpvEToxxzjUTwyVcqYGYhRNKQVkaXeMyBc+gt1BFr
	EMfD/YNEpUJTRxMzFoczCST3+rnPK2PEKeuAMvi48H9XkubegEQvVaEdHvev1EYVEwojNdBWLAO
	D8gNfaVhEHDz8rJh3i+EpxylcysrtkM+dpAPGpm1Bk1MATN+X4W/hPJuWVbiMz+1x7WY=
X-Gm-Gg: ASbGncvahr6FSswnwrbtU7MEzIkFdTW4ae9HMDN0uuOXyTYu9pSYk3sgVXG8vVP3OFW
	u+MMzjpIgAaFhh4eRXD09nQnx0re9l9sfl04w6Zj2MSY5Y5sqOV45qoWv7ugLlx/FAjlkrPYwTQ
	JA3Mudz66+UDGBolCmPpM2f7Ie0kHTLclXESgChVO7fLSaloCqkBNlVGd5YFgUVs0hIjrSyUHSS
	TRJME6x9q+0vbsBmUL06tLPEOeTM0zF1EaMgnT9KDCF0swx8zxzFvBtknrp7J2onVe+V8ewe0z8
	UF23K2TTX4Ou1K/aeCqzHccj7K/CfkQ3PvuAR8mA70+lsFLgQpNDGA==
X-Received: by 2002:a05:620a:1a9f:b0:864:c43:865d with SMTP id af79cd13be357-883523d711cmr3619231585a.54.1760456149816;
        Tue, 14 Oct 2025 08:35:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG9B7zyZg3oK/9ofrQ2WZP0uWvK03uQ3Ex+n06/Ha3FxT+8LJtWjP9Tb3y1S2Fn4mVp8vMjDA==
X-Received: by 2002:a05:620a:1a9f:b0:864:c43:865d with SMTP id af79cd13be357-883523d711cmr3619223685a.54.1760456149116;
        Tue, 14 Oct 2025 08:35:49 -0700 (PDT)
Received: from debian ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce583316sm24108193f8f.20.2025.10.14.08.35.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 08:35:48 -0700 (PDT)
From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
To: broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.com, srini@kernel.org, alexey.klimov@linaro.org,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH] ASoC: codecs: pm4125: remove duplicate code
Date: Tue, 14 Oct 2025 16:35:41 +0100
Message-ID: <20251014153541.283899-1-srinivas.kandagatla@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEzMDA4MyBTYWx0ZWRfX6HnvawylcE71
 oB/qmwUFoNj+dy6xq3i875TggVsxWrTguXr4ZZoSs4cx7yjDsSLmGJcd25miLKuc0VTuo6M5YNE
 pYq/BbdXNXh2A+X1bLVXwqurYRTpHdDbN+CNrY0UWzN73liq46x8BiwgiAFA1keqmFVdbdwlK1E
 PgLddTNTQkeGGipWty0zgR/a3iJoVdboEaAFdE1TaLxKNCDFABX7+6WPRCwoXmTyY3pgK0Farmm
 EVF7o6E8TRJqmthydyoCd3S6jNH+ga+AAPocnx7m8QWsCkCxYYtUeG/UZN97Alv9dLk84ErQZGQ
 U/1HmsFNGOvWQb1wv3mojp+yCUguknqpciZ5MK/emfb1usfr8MEl1hqwGlI9hJVP8scb/HLu2XJ
 eFotp8K2SS/Hfs4LNVska+aL5lURZQ==
X-Authority-Analysis: v=2.4 cv=Fr4IPmrq c=1 sm=1 tr=0 ts=68ee6dd7 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=ZsC4DHZuhs/kKio7QBcDoQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8
 a=iXy9AVFDh87vi-9b7QEA:9 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: aaU4Am2H01GALvnzBNgABD8SSqzSu147
X-Proofpoint-ORIG-GUID: aaU4Am2H01GALvnzBNgABD8SSqzSu147
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-14_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510130083

With recent addition of wcd-common, lot of code duplication in
pm4125 codec can be removed now.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
---
 sound/soc/codecs/Kconfig      |  2 +
 sound/soc/codecs/pm4125-sdw.c | 64 ++++---------------------------
 sound/soc/codecs/pm4125.c     | 71 +++++++----------------------------
 sound/soc/codecs/pm4125.h     | 18 +--------
 4 files changed, 25 insertions(+), 130 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 160c07699a8b..a952ca0d09c4 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1567,6 +1567,7 @@ config SND_SOC_PEB2466
 
 config SND_SOC_PM4125
 	depends on SND_SOC_PM4125_SDW
+	select SND_SOC_WCD_COMMON
 	tristate
 	depends on SOUNDWIRE || !SOUNDWIRE
 
@@ -1575,6 +1576,7 @@ config SND_SOC_PM4125_SDW
 	select SND_SOC_PM4125
 	select SND_SOC_WCD_MBHC
 	select REGMAP_IRQ
+	select SND_SOC_WCD_COMMON
 	depends on SOUNDWIRE
 	select REGMAP_SOUNDWIRE
 	help
diff --git a/sound/soc/codecs/pm4125-sdw.c b/sound/soc/codecs/pm4125-sdw.c
index 4ed09fbe3f54..3167b38e2876 100644
--- a/sound/soc/codecs/pm4125-sdw.c
+++ b/sound/soc/codecs/pm4125-sdw.c
@@ -20,12 +20,12 @@
 #include <sound/soc.h>
 #include "pm4125.h"
 
-static struct pm4125_sdw_ch_info pm4125_sdw_rx_ch_info[] = {
+static struct wcd_sdw_ch_info pm4125_sdw_rx_ch_info[] = {
 	WCD_SDW_CH(PM4125_HPH_L, PM4125_HPH_PORT, BIT(0)),
 	WCD_SDW_CH(PM4125_HPH_R, PM4125_HPH_PORT, BIT(1)),
 };
 
-static struct pm4125_sdw_ch_info pm4125_sdw_tx_ch_info[] = {
+static struct wcd_sdw_ch_info pm4125_sdw_tx_ch_info[] = {
 	WCD_SDW_CH(PM4125_ADC1, PM4125_ADC_1_2_DMIC1L_BCS_PORT, BIT(0)),
 	WCD_SDW_CH(PM4125_ADC2, PM4125_ADC_1_2_DMIC1L_BCS_PORT, BIT(1)),
 };
@@ -46,12 +46,6 @@ static struct sdw_dpn_prop pm4125_dpn_prop[PM4125_MAX_SWR_PORTS] = {
 	}
 };
 
-struct device *pm4125_sdw_device_get(struct device_node *np)
-{
-	return bus_find_device_by_of_node(&sdw_bus_type, np);
-}
-EXPORT_SYMBOL_GPL(pm4125_sdw_device_get);
-
 int pm4125_sdw_hw_params(struct pm4125_sdw_priv *priv, struct snd_pcm_substream *substream,
 			 struct snd_pcm_hw_params *params, struct snd_soc_dai *dai)
 {
@@ -83,19 +77,6 @@ int pm4125_sdw_hw_params(struct pm4125_sdw_priv *priv, struct snd_pcm_substream
 }
 EXPORT_SYMBOL_GPL(pm4125_sdw_hw_params);
 
-static int pm4125_update_status(struct sdw_slave *slave, enum sdw_slave_status status)
-{
-	struct pm4125_sdw_priv *priv = dev_get_drvdata(&slave->dev);
-
-	if (priv->regmap && status == SDW_SLAVE_ATTACHED) {
-		/* Write out any cached changes that happened between probe and attach */
-		regcache_cache_only(priv->regmap, false);
-		return regcache_sync(priv->regmap);
-	}
-
-	return 0;
-}
-
 /*
  * Handle Soundwire out-of-band interrupt event by triggering the first irq of the slave_irq
  * irq domain, which then will be handled by the regmap_irq threaded irq.
@@ -104,18 +85,9 @@ static int pm4125_update_status(struct sdw_slave *slave, enum sdw_slave_status s
 static int pm4125_interrupt_callback(struct sdw_slave *slave, struct sdw_slave_intr_status *status)
 {
 	struct pm4125_sdw_priv *priv = dev_get_drvdata(&slave->dev);
-	struct irq_domain *slave_irq = priv->slave_irq;
-	u32 sts1, sts2, sts3;
-
-	do {
-		handle_nested_irq(irq_find_mapping(slave_irq, 0));
-		regmap_read(priv->regmap, PM4125_DIG_SWR_INTR_STATUS_0, &sts1);
-		regmap_read(priv->regmap, PM4125_DIG_SWR_INTR_STATUS_1, &sts2);
-		regmap_read(priv->regmap, PM4125_DIG_SWR_INTR_STATUS_2, &sts3);
 
-	} while (sts1 || sts2 || sts3);
-
-	return IRQ_HANDLED;
+	return wcd_interrupt_callback(slave, priv->slave_irq, PM4125_DIG_SWR_INTR_STATUS_0,
+				PM4125_DIG_SWR_INTR_STATUS_1, PM4125_DIG_SWR_INTR_STATUS_2);
 }
 
 static const struct reg_default pm4125_defaults[] = {
@@ -369,32 +341,10 @@ static const struct regmap_config pm4125_regmap_config = {
 };
 
 static const struct sdw_slave_ops pm4125_slave_ops = {
-	.update_status = pm4125_update_status,
+	.update_status = wcd_update_status,
 	.interrupt_callback = pm4125_interrupt_callback,
 };
 
-static int pm4125_sdw_component_bind(struct device *dev, struct device *master, void *data)
-{
-	pm_runtime_set_autosuspend_delay(dev, 3000);
-	pm_runtime_use_autosuspend(dev);
-	pm_runtime_set_active(dev);
-	pm_runtime_enable(dev);
-
-	return 0;
-}
-
-static void pm4125_sdw_component_unbind(struct device *dev, struct device *master, void *data)
-{
-	pm_runtime_disable(dev);
-	pm_runtime_set_suspended(dev);
-	pm_runtime_dont_use_autosuspend(dev);
-}
-
-static const struct component_ops pm4125_sdw_component_ops = {
-	.bind = pm4125_sdw_component_bind,
-	.unbind = pm4125_sdw_component_unbind,
-};
-
 static int pm4125_probe(struct sdw_slave *pdev, const struct sdw_device_id *id)
 {
 	struct device *dev = &pdev->dev;
@@ -476,7 +426,7 @@ static int pm4125_probe(struct sdw_slave *pdev, const struct sdw_device_id *id)
 			priv->ch_info[i].master_ch_mask = PM4125_SWRM_CH_MASK(master_ch_mask[i]);
 	}
 
-	ret = component_add(dev, &pm4125_sdw_component_ops);
+	ret = component_add(dev, &wcd_sdw_component_ops);
 	if (ret)
 		return ret;
 
@@ -490,7 +440,7 @@ static int pm4125_remove(struct sdw_slave *pdev)
 {
 	struct device *dev = &pdev->dev;
 
-	component_del(dev, &pm4125_sdw_component_ops);
+	component_del(dev, &wcd_sdw_component_ops);
 
 	return 0;
 }
diff --git a/sound/soc/codecs/pm4125.c b/sound/soc/codecs/pm4125.c
index 706fc668ffe2..27fe363db8b9 100644
--- a/sound/soc/codecs/pm4125.c
+++ b/sound/soc/codecs/pm4125.c
@@ -69,6 +69,7 @@ struct pm4125_priv {
 	struct wcd_mbhc *wcd_mbhc;
 	struct wcd_mbhc_config mbhc_cfg;
 	struct wcd_mbhc_intr intr_ids;
+	struct wcd_common common;
 	struct irq_domain *virq;
 	const struct regmap_irq_chip *pm4125_regmap_irq_chip;
 	struct regmap_irq_chip_data *irq_chip;
@@ -76,9 +77,6 @@ struct pm4125_priv {
 	unsigned long status_mask;
 	s32 micb_ref[PM4125_MAX_MICBIAS];
 	s32 pullup_ref[PM4125_MAX_MICBIAS];
-	u32 micb1_mv;
-	u32 micb2_mv;
-	u32 micb3_mv;
 
 	int hphr_pdm_wd_int;
 	int hphl_pdm_wd_int;
@@ -644,16 +642,6 @@ static int pm4125_codec_enable_ear_pa(struct snd_soc_dapm_widget *w,
 	return 0;
 }
 
-static int pm4125_get_micb_vout_ctl_val(struct device *dev, u32 micb_mv)
-{
-	if (micb_mv < 1600 || micb_mv > 2850) {
-		dev_err(dev, "%s: unsupported micbias voltage (%u mV)\n", __func__, micb_mv);
-		return -EINVAL;
-	}
-
-	return (micb_mv - 1600) / 50;
-}
-
 static int pm4125_codec_enable_adc(struct snd_soc_dapm_widget *w,
 				   struct snd_kcontrol *kcontrol, int event)
 {
@@ -855,7 +843,7 @@ static int pm4125_codec_enable_micbias_pullup(struct snd_soc_dapm_widget *w,
 static int pm4125_connect_port(struct pm4125_sdw_priv *sdw_priv, u8 port_idx, u8 ch_id, bool enable)
 {
 	struct sdw_port_config *port_config = &sdw_priv->port_config[port_idx - 1];
-	const struct pm4125_sdw_ch_info *ch_info = &sdw_priv->ch_info[ch_id];
+	const struct wcd_sdw_ch_info *ch_info = &sdw_priv->ch_info[ch_id];
 	struct sdw_slave *sdev = sdw_priv->sdev;
 	u8 port_num = ch_info->port_num;
 	u8 ch_mask = ch_info->ch_mask;
@@ -1266,15 +1254,8 @@ static const struct snd_soc_dapm_route pm4125_audio_map[] = {
 
 static int pm4125_set_micbias_data(struct device *dev, struct pm4125_priv *pm4125)
 {
-	int vout_ctl;
-
-	/* Set micbias voltage */
-	vout_ctl = pm4125_get_micb_vout_ctl_val(dev, pm4125->micb1_mv);
-	if (vout_ctl < 0)
-		return -EINVAL;
-
 	regmap_update_bits(pm4125->regmap, PM4125_ANA_MICBIAS_LDO_1_SETTING,
-			   PM4125_ANA_MICBIAS_MICB_OUT_VAL_MASK, vout_ctl << 3);
+			   PM4125_ANA_MICBIAS_MICB_OUT_VAL_MASK, pm4125->common.micb_vout[0]);
 	return 0;
 }
 
@@ -1418,31 +1399,6 @@ static const struct snd_soc_component_driver soc_codec_dev_pm4125 = {
 	.endianness = 1,
 };
 
-static void pm4125_dt_parse_micbias_info(struct device *dev, struct pm4125_priv *priv)
-{
-	struct device_node *np = dev->of_node;
-	u32 prop_val = 0;
-	int ret;
-
-	ret = of_property_read_u32(np, "qcom,micbias1-microvolt", &prop_val);
-	if (!ret)
-		priv->micb1_mv = prop_val / 1000;
-	else
-		dev_warn(dev, "Micbias1 DT property not found\n");
-
-	ret = of_property_read_u32(np, "qcom,micbias2-microvolt", &prop_val);
-	if (!ret)
-		priv->micb2_mv = prop_val / 1000;
-	else
-		dev_warn(dev, "Micbias2 DT property not found\n");
-
-	ret = of_property_read_u32(np, "qcom,micbias3-microvolt", &prop_val);
-	if (!ret)
-		priv->micb3_mv = prop_val / 1000;
-	else
-		dev_warn(dev, "Micbias3 DT property not found\n");
-}
-
 static int pm4125_codec_hw_params(struct snd_pcm_substream *substream,
 				  struct snd_pcm_hw_params *params,
 				  struct snd_soc_dai *dai)
@@ -1560,7 +1516,7 @@ static int pm4125_bind(struct device *dev)
 		return ret;
 	}
 
-	pm4125->rxdev = pm4125_sdw_device_get(pm4125->rxnode);
+	pm4125->rxdev = of_sdw_find_device_by_node(pm4125->rxnode);
 	if (!pm4125->rxdev) {
 		dev_err(dev, "could not find rxslave with matching of node\n");
 		ret = -EINVAL;
@@ -1570,7 +1526,7 @@ static int pm4125_bind(struct device *dev)
 	pm4125->sdw_priv[AIF1_PB] = dev_get_drvdata(pm4125->rxdev);
 	pm4125->sdw_priv[AIF1_PB]->pm4125 = pm4125;
 
-	pm4125->txdev = pm4125_sdw_device_get(pm4125->txnode);
+	pm4125->txdev = of_sdw_find_device_by_node(pm4125->txnode);
 	if (!pm4125->txdev) {
 		dev_err(dev, "could not find txslave with matching of node\n");
 		ret = -EINVAL;
@@ -1615,7 +1571,7 @@ static int pm4125_bind(struct device *dev)
 		goto link_remove_dev_tx;
 	}
 
-	pm4125->regmap = dev_get_regmap(&pm4125->tx_sdw_dev->dev, NULL);
+	pm4125->regmap = pm4125->sdw_priv[AIF1_CAP]->regmap;
 	if (!pm4125->regmap) {
 		dev_err(dev, "could not get TX device regmap\n");
 		ret = -EINVAL;
@@ -1631,11 +1587,7 @@ static int pm4125_bind(struct device *dev)
 	pm4125->sdw_priv[AIF1_PB]->slave_irq = pm4125->virq;
 	pm4125->sdw_priv[AIF1_CAP]->slave_irq = pm4125->virq;
 
-	ret = pm4125_set_micbias_data(dev, pm4125);
-	if (ret < 0) {
-		dev_err(dev, "Bad micbias pdata\n");
-		goto link_remove_dev_rx;
-	}
+	pm4125_set_micbias_data(dev, pm4125);
 
 	ret = snd_soc_register_component(dev, &soc_codec_dev_pm4125,
 					 pm4125_dais, ARRAY_SIZE(pm4125_dais));
@@ -1716,7 +1668,12 @@ static int pm4125_probe(struct platform_device *pdev)
 
 	pm4125_reset(pm4125);
 
-	pm4125_dt_parse_micbias_info(dev, pm4125);
+	pm4125->common.dev = dev;
+	pm4125->common.max_bias = 3;
+	ret = wcd_dt_parse_micbias_info(&pm4125->common);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get micbias\n");
+
 	atomic_set(&pm4125->gloal_mbias_cnt, 0);
 
 	cfg = &pm4125->mbhc_cfg;
@@ -1724,7 +1681,7 @@ static int pm4125_probe(struct platform_device *pdev)
 	cfg->anc_micbias = MIC_BIAS_2;
 	cfg->v_hs_max = WCD_MBHC_HS_V_MAX;
 	cfg->num_btn = PM4125_MBHC_MAX_BUTTONS;
-	cfg->micb_mv = pm4125->micb2_mv;
+	cfg->micb_mv = pm4125->common.micb_mv[1];
 	cfg->linein_th = 5000;
 	cfg->hs_thr = 1700;
 	cfg->hph_thr = 50;
diff --git a/sound/soc/codecs/pm4125.h b/sound/soc/codecs/pm4125.h
index 3520c711b744..25fd3106f44f 100644
--- a/sound/soc/codecs/pm4125.h
+++ b/sound/soc/codecs/pm4125.h
@@ -7,6 +7,7 @@
 
 #include <linux/soundwire/sdw.h>
 #include <linux/soundwire/sdw_type.h>
+#include "wcd-common.h"
 
 #define PM4125_ANA_BASE_ADDR			0x3000
 #define PM4125_DIG_BASE_ADDR			0x3400
@@ -202,26 +203,13 @@ enum pm4125_rx_sdw_ports {
 	PM4125_MAX_SWR_PORTS = PM4125_COMP_PORT,
 };
 
-struct pm4125_sdw_ch_info {
-	int port_num;
-	unsigned int ch_mask;
-	unsigned int master_ch_mask;
-};
-
-#define WCD_SDW_CH(id, pn, cmask)		\
-	[id] = {				\
-		.port_num = pn,			\
-		.ch_mask = cmask,		\
-		.master_ch_mask = cmask,	\
-	}
-
 struct pm4125_priv;
 struct pm4125_sdw_priv {
 	struct sdw_slave *sdev;
 	struct sdw_stream_config sconfig;
 	struct sdw_stream_runtime *sruntime;
 	struct sdw_port_config port_config[PM4125_MAX_SWR_PORTS];
-	struct pm4125_sdw_ch_info *ch_info;
+	struct wcd_sdw_ch_info *ch_info;
 	bool port_enable[PM4125_MAX_SWR_CH_IDS];
 	unsigned int master_channel_map[SDW_MAX_PORTS];
 	int active_ports;
@@ -240,8 +228,6 @@ int pm4125_sdw_set_sdw_stream(struct pm4125_sdw_priv *pm4125, struct snd_soc_dai
 int pm4125_sdw_hw_params(struct pm4125_sdw_priv *pm4125, struct snd_pcm_substream *substream,
 			 struct snd_pcm_hw_params *params, struct snd_soc_dai *dai);
 
-struct device *pm4125_sdw_device_get(struct device_node *np);
-
 #else
 static inline int pm4125_sdw_free(struct pm4125_sdw_priv *pm4125,
 				  struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
-- 
2.51.0


