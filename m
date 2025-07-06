Return-Path: <linux-kernel+bounces-716817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC2C6AF8AFE
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jul 2025 10:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24C7680352F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jul 2025 08:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2E92FCFD1;
	Fri,  4 Jul 2025 07:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BsqkHNXX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6C52F94B8;
	Fri,  4 Jul 2025 07:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751615718; cv=none; b=IabFet3ySfXPvRKEqdoZNZUVQXVUxZ48oN2ctOnouV3QIde+XbLDqLfkfCn5RUnlzr7ce8GuxPh5+n3VFwrQSD1y/kr5Scyiy85+rEaGGrmkyzg9BspcR0ZwpE+gtAfUM2vFAYehapptWRS3wh9lwEXiAsk1kwwuUWlbN/UQy5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751615718; c=relaxed/simple;
	bh=MAtO8lnZc2zwN2BbUqr7YcklCzUg6svdKjWVDBhrsb4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k0YUdW7ncy3J3MMG141sgvpjPMrUvaaSllaf3vwk05u2K9UazTejhCavFDic09YTmWLt1ilWDe8CbJUdyrj0GIY7DE70Q1hF2YwuEUk04ovDHbmaMTgF+yjFGBUBwVbGI9epvztNKWQYVXl4wENbAS1CpVymhxTcE7GAvWCiQoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BsqkHNXX; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751615716; x=1783151716;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MAtO8lnZc2zwN2BbUqr7YcklCzUg6svdKjWVDBhrsb4=;
  b=BsqkHNXX+SxFxsVTT3bXJUIDZVC7xj2NnN94M3V7/4vYXQ6XyK1UoK69
   F8LfVtFb96i4LbqedsXH02XPnkorbeiPQNXxE6Ils2X5ZfYuICJC4y2N/
   +ZIFEMgtVBwETVUaO0KW+NAK9USs9ooFvfS7HsXRTecIqrFvxdjpTgrY7
   MbMAt+hBKxqho/OtpHo17+etG6JoI6veQdicaMBeF80+TLbyRw4YCs0/c
   Vv5C2Qwtemm09ghNqusRDad5HH/Lre7glqIsJSl3IvYL9QpYsK6/p89nx
   d4ky86KkD1UI01KjcykDhCmBg1uc+K1Jb1LBieKAl01zOBFYFX0lBLGiZ
   Q==;
X-CSE-ConnectionGUID: mmkK9o2sTX+8dvKnPqfinw==
X-CSE-MsgGUID: vtGkXfLaQKKG2FlfO2tpSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="64194365"
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="64194365"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:55:05 -0700
X-CSE-ConnectionGUID: yffOr3ZZREWQnRRooa6TeA==
X-CSE-MsgGUID: gbTLSKQxTF+wuJh8zlh2Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,286,1744095600"; 
   d="scan'208";a="158616727"
Received: from jkrzyszt-mobl2.ger.corp.intel.com (HELO svinhufvud.fi.intel.com) ([10.245.244.244])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2025 00:54:58 -0700
Received: from svinhufvud.lan (localhost [IPv6:::1])
	by svinhufvud.fi.intel.com (Postfix) with ESMTP id AF1EC44394;
	Fri,  4 Jul 2025 10:54:56 +0300 (EEST)
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6 krs, Bertel Jungin Aukio 5, 02600 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Oder Chiou <oder_chiou@realtek.com>,
	Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>,
	Srinivas Kandagatla <srini@kernel.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Cezary Rojewski <cezary.rojewski@intel.com>,
	=?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= <amadeuszx.slawinski@linux.intel.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH 71/80] ASoC: codecs: Remove redundant pm_runtime_mark_last_busy() calls
Date: Fri,  4 Jul 2025 10:54:56 +0300
Message-Id: <20250704075456.3222642-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
References: <20250704075225.3212486-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
pm_runtime_mark_last_busy().

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
The cover letter of the set can be found here
<URL:https://lore.kernel.org/linux-pm/20250704075225.3212486-1-sakari.ailus@linux.intel.com>.

In brief, this patch depends on PM runtime patches adding marking the last
busy timestamp in autosuspend related functions. The patches are here, on
rc2:

        git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
                pm-runtime-6.17-rc1

 sound/soc/codecs/arizona-jack.c    | 2 --
 sound/soc/codecs/cs35l41.c         | 2 --
 sound/soc/codecs/cs35l45.c         | 1 -
 sound/soc/codecs/cs35l56-sdw.c     | 1 -
 sound/soc/codecs/cs35l56.c         | 1 -
 sound/soc/codecs/cs42l42.c         | 1 -
 sound/soc/codecs/cs42l43-jack.c    | 5 -----
 sound/soc/codecs/cs42l43.c         | 2 --
 sound/soc/codecs/cs48l32.c         | 1 -
 sound/soc/codecs/hda.c             | 3 ---
 sound/soc/codecs/max98363.c        | 1 -
 sound/soc/codecs/max98373-sdw.c    | 1 -
 sound/soc/codecs/rt1017-sdca-sdw.c | 1 -
 sound/soc/codecs/rt1308-sdw.c      | 1 -
 sound/soc/codecs/rt1316-sdw.c      | 1 -
 sound/soc/codecs/rt1318-sdw.c      | 1 -
 sound/soc/codecs/rt1320-sdw.c      | 1 -
 sound/soc/codecs/rt5682-sdw.c      | 1 -
 sound/soc/codecs/rt700.c           | 2 --
 sound/soc/codecs/rt711-sdca.c      | 2 --
 sound/soc/codecs/rt711.c           | 2 --
 sound/soc/codecs/rt712-sdca-dmic.c | 1 -
 sound/soc/codecs/rt712-sdca.c      | 2 --
 sound/soc/codecs/rt715-sdca.c      | 1 -
 sound/soc/codecs/rt715.c           | 1 -
 sound/soc/codecs/rt721-sdca.c      | 2 --
 sound/soc/codecs/rt722-sdca.c      | 2 --
 sound/soc/codecs/rt9123.c          | 3 ---
 sound/soc/codecs/tas2552.c         | 1 -
 sound/soc/codecs/wcd-mbhc-v2.c     | 2 --
 sound/soc/codecs/wsa881x.c         | 1 -
 sound/soc/codecs/wsa883x.c         | 1 -
 sound/soc/codecs/wsa884x.c         | 1 -
 33 files changed, 51 deletions(-)

diff --git a/sound/soc/codecs/arizona-jack.c b/sound/soc/codecs/arizona-jack.c
index 9c15ddba6008..22f9c431a0e5 100644
--- a/sound/soc/codecs/arizona-jack.c
+++ b/sound/soc/codecs/arizona-jack.c
@@ -319,7 +319,6 @@ static void arizona_stop_mic(struct arizona_priv *info)
 
 	if (change) {
 		regulator_disable(info->micvdd);
-		pm_runtime_mark_last_busy(arizona->dev);
 		pm_runtime_put_autosuspend(arizona->dev);
 	}
 }
@@ -1127,7 +1126,6 @@ static irqreturn_t arizona_jackdet(int irq, void *data)
 
 	mutex_unlock(&info->lock);
 
-	pm_runtime_mark_last_busy(arizona->dev);
 	pm_runtime_put_autosuspend(arizona->dev);
 
 	return IRQ_HANDLED;
diff --git a/sound/soc/codecs/cs35l41.c b/sound/soc/codecs/cs35l41.c
index ff4134bee858..224d65987a8d 100644
--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -483,7 +483,6 @@ static irqreturn_t cs35l41_irq(int irq, void *data)
 	}
 
 done:
-	pm_runtime_mark_last_busy(cs35l41->dev);
 	pm_runtime_put_autosuspend(cs35l41->dev);
 
 	return ret;
@@ -1328,7 +1327,6 @@ int cs35l41_probe(struct cs35l41_private *cs35l41, const struct cs35l41_hw_cfg *
 
 	pm_runtime_set_autosuspend_delay(cs35l41->dev, 3000);
 	pm_runtime_use_autosuspend(cs35l41->dev);
-	pm_runtime_mark_last_busy(cs35l41->dev);
 	pm_runtime_set_active(cs35l41->dev);
 	pm_runtime_get_noresume(cs35l41->dev);
 	pm_runtime_enable(cs35l41->dev);
diff --git a/sound/soc/codecs/cs35l45.c b/sound/soc/codecs/cs35l45.c
index 432a19f4de2b..d4dcdf37bb70 100644
--- a/sound/soc/codecs/cs35l45.c
+++ b/sound/soc/codecs/cs35l45.c
@@ -1427,7 +1427,6 @@ int cs35l45_probe(struct cs35l45_private *cs35l45)
 
 	pm_runtime_set_autosuspend_delay(cs35l45->dev, 3000);
 	pm_runtime_use_autosuspend(cs35l45->dev);
-	pm_runtime_mark_last_busy(cs35l45->dev);
 	pm_runtime_set_active(cs35l45->dev);
 	pm_runtime_get_noresume(cs35l45->dev);
 	pm_runtime_enable(cs35l45->dev);
diff --git a/sound/soc/codecs/cs35l56-sdw.c b/sound/soc/codecs/cs35l56-sdw.c
index fa9693af3722..ee14031695a1 100644
--- a/sound/soc/codecs/cs35l56-sdw.c
+++ b/sound/soc/codecs/cs35l56-sdw.c
@@ -283,7 +283,6 @@ static void cs35l56_sdw_init(struct sdw_slave *peripheral)
 	}
 
 out:
-	pm_runtime_mark_last_busy(cs35l56->base.dev);
 	pm_runtime_put_autosuspend(cs35l56->base.dev);
 }
 
diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index 1b42586794ad..b1c65d8331e7 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -871,7 +871,6 @@ static void cs35l56_dsp_work(struct work_struct *work)
 
 	cs35l56_log_tuning(&cs35l56->base, &cs35l56->dsp.cs_dsp);
 err:
-	pm_runtime_mark_last_busy(cs35l56->base.dev);
 	pm_runtime_put_autosuspend(cs35l56->base.dev);
 }
 
diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 56668c392063..78bb093fa0cc 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -1775,7 +1775,6 @@ irqreturn_t cs42l42_irq_thread(int irq, void *data)
 	}
 
 	mutex_unlock(&cs42l42->irq_lock);
-	pm_runtime_mark_last_busy(cs42l42->dev);
 	pm_runtime_put_autosuspend(cs42l42->dev);
 
 	return IRQ_HANDLED;
diff --git a/sound/soc/codecs/cs42l43-jack.c b/sound/soc/codecs/cs42l43-jack.c
index 72a4150709de..2a0a4986a9ce 100644
--- a/sound/soc/codecs/cs42l43-jack.c
+++ b/sound/soc/codecs/cs42l43-jack.c
@@ -242,7 +242,6 @@ int cs42l43_set_jack(struct snd_soc_component *component,
 error:
 	mutex_unlock(&priv->jack_lock);
 
-	pm_runtime_mark_last_busy(priv->dev);
 	pm_runtime_put_autosuspend(priv->dev);
 
 	return ret;
@@ -429,7 +428,6 @@ irqreturn_t cs42l43_button_press(int irq, void *data)
 error:
 	mutex_unlock(&priv->jack_lock);
 
-	pm_runtime_mark_last_busy(priv->dev);
 	pm_runtime_put_autosuspend(priv->dev);
 
 	return iret;
@@ -461,7 +459,6 @@ irqreturn_t cs42l43_button_release(int irq, void *data)
 
 	mutex_unlock(&priv->jack_lock);
 
-	pm_runtime_mark_last_busy(priv->dev);
 	pm_runtime_put_autosuspend(priv->dev);
 
 	return iret;
@@ -496,7 +493,6 @@ void cs42l43_bias_sense_timeout(struct work_struct *work)
 
 	mutex_unlock(&priv->jack_lock);
 
-	pm_runtime_mark_last_busy(priv->dev);
 	pm_runtime_put_autosuspend(priv->dev);
 }
 
@@ -768,7 +764,6 @@ void cs42l43_tip_sense_work(struct work_struct *work)
 
 	priv->suspend_jack_debounce = false;
 
-	pm_runtime_mark_last_busy(priv->dev);
 	pm_runtime_put_autosuspend(priv->dev);
 }
 
diff --git a/sound/soc/codecs/cs42l43.c b/sound/soc/codecs/cs42l43.c
index 41a0f4529ea1..b0c27d696c58 100644
--- a/sound/soc/codecs/cs42l43.c
+++ b/sound/soc/codecs/cs42l43.c
@@ -1080,7 +1080,6 @@ static int cs42l43_shutter_get(struct cs42l43_codec *priv, unsigned int shift)
 		ret ? "open" : "closed");
 
 error:
-	pm_runtime_mark_last_busy(priv->dev);
 	pm_runtime_put_autosuspend(priv->dev);
 
 	return ret;
@@ -2356,7 +2355,6 @@ static int cs42l43_codec_probe(struct platform_device *pdev)
 		goto err_clk;
 	}
 
-	pm_runtime_mark_last_busy(priv->dev);
 	pm_runtime_put_autosuspend(priv->dev);
 
 	return 0;
diff --git a/sound/soc/codecs/cs48l32.c b/sound/soc/codecs/cs48l32.c
index 9bdd48aab42a..a306af4289ad 100644
--- a/sound/soc/codecs/cs48l32.c
+++ b/sound/soc/codecs/cs48l32.c
@@ -1385,7 +1385,6 @@ static irqreturn_t cs48l32_irq(int irq, void *data)
 	result = IRQ_HANDLED;
 
 out:
-	pm_runtime_mark_last_busy(cs48l32_codec->core.dev);
 	pm_runtime_put_autosuspend(cs48l32_codec->core.dev);
 
 	return result;
diff --git a/sound/soc/codecs/hda.c b/sound/soc/codecs/hda.c
index dc7794c9ac44..7e4df1481486 100644
--- a/sound/soc/codecs/hda.c
+++ b/sound/soc/codecs/hda.c
@@ -162,7 +162,6 @@ int hda_codec_probe_complete(struct hda_codec *codec)
 	snd_hda_codec_register(codec);
 
 	/* Complement pm_runtime_get_sync(bus) in probe */
-	pm_runtime_mark_last_busy(bus->dev);
 	pm_runtime_put_autosuspend(bus->dev);
 
 	return ret;
@@ -262,7 +261,6 @@ static int hda_codec_probe(struct snd_soc_component *component)
 
 	snd_hdac_ext_bus_link_put(bus, hlink);
 
-	pm_runtime_mark_last_busy(bus->dev);
 	pm_runtime_put_autosuspend(bus->dev);
 	return ret;
 }
@@ -300,7 +298,6 @@ static void hda_codec_remove(struct snd_soc_component *component)
 	 * not be called due to early error, leaving bus uc unbalanced
 	 */
 	if (!was_registered) {
-		pm_runtime_mark_last_busy(bus->dev);
 		pm_runtime_put_autosuspend(bus->dev);
 	}
 
diff --git a/sound/soc/codecs/max98363.c b/sound/soc/codecs/max98363.c
index fd6830a7579d..25af78ab30d5 100644
--- a/sound/soc/codecs/max98363.c
+++ b/sound/soc/codecs/max98363.c
@@ -188,7 +188,6 @@ static int max98363_io_init(struct sdw_slave *slave)
 	max98363->hw_init = true;
 
 out:
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	return ret;
diff --git a/sound/soc/codecs/max98373-sdw.c b/sound/soc/codecs/max98373-sdw.c
index 43b52bda6ad5..88ff215f52b3 100644
--- a/sound/soc/codecs/max98373-sdw.c
+++ b/sound/soc/codecs/max98373-sdw.c
@@ -458,7 +458,6 @@ static int max98373_io_init(struct sdw_slave *slave)
 	max98373->first_hw_init = true;
 	max98373->hw_init = true;
 
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	return 0;
diff --git a/sound/soc/codecs/rt1017-sdca-sdw.c b/sound/soc/codecs/rt1017-sdca-sdw.c
index 88fc23a4999f..a9c000876be8 100644
--- a/sound/soc/codecs/rt1017-sdca-sdw.c
+++ b/sound/soc/codecs/rt1017-sdca-sdw.c
@@ -362,7 +362,6 @@ static int rt1017_sdca_io_init(struct device *dev, struct sdw_slave *slave)
 	/* Mark Slave initialization complete */
 	rt1017->hw_init = true;
 
-	pm_runtime_mark_last_busy(&slave->dev);
 	pm_runtime_put_autosuspend(&slave->dev);
 
 	dev_dbg(&slave->dev, "hw_init complete\n");
diff --git a/sound/soc/codecs/rt1308-sdw.c b/sound/soc/codecs/rt1308-sdw.c
index ea708068f0e8..b6c224832a43 100644
--- a/sound/soc/codecs/rt1308-sdw.c
+++ b/sound/soc/codecs/rt1308-sdw.c
@@ -291,7 +291,6 @@ static int rt1308_io_init(struct device *dev, struct sdw_slave *slave)
 	/* Mark Slave initialization complete */
 	rt1308->hw_init = true;
 
-	pm_runtime_mark_last_busy(&slave->dev);
 	pm_runtime_put_autosuspend(&slave->dev);
 
 	dev_dbg(&slave->dev, "%s hw_init complete\n", __func__);
diff --git a/sound/soc/codecs/rt1316-sdw.c b/sound/soc/codecs/rt1316-sdw.c
index 960b6c4f5a66..01a977398864 100644
--- a/sound/soc/codecs/rt1316-sdw.c
+++ b/sound/soc/codecs/rt1316-sdw.c
@@ -302,7 +302,6 @@ static int rt1316_io_init(struct device *dev, struct sdw_slave *slave)
 	/* Mark Slave initialization complete */
 	rt1316->hw_init = true;
 
-	pm_runtime_mark_last_busy(&slave->dev);
 	pm_runtime_put_autosuspend(&slave->dev);
 
 	dev_dbg(&slave->dev, "%s hw_init complete\n", __func__);
diff --git a/sound/soc/codecs/rt1318-sdw.c b/sound/soc/codecs/rt1318-sdw.c
index 4eb636e0c9ed..70db5450d6d2 100644
--- a/sound/soc/codecs/rt1318-sdw.c
+++ b/sound/soc/codecs/rt1318-sdw.c
@@ -434,7 +434,6 @@ static int rt1318_io_init(struct device *dev, struct sdw_slave *slave)
 	rt1318->first_hw_init = true;
 	rt1318->hw_init = true;
 
-	pm_runtime_mark_last_busy(&slave->dev);
 	pm_runtime_put_autosuspend(&slave->dev);
 
 	dev_dbg(&slave->dev, "%s hw_init complete\n", __func__);
diff --git a/sound/soc/codecs/rt1320-sdw.c b/sound/soc/codecs/rt1320-sdw.c
index 015cc710e6dc..b13d7a99bf63 100644
--- a/sound/soc/codecs/rt1320-sdw.c
+++ b/sound/soc/codecs/rt1320-sdw.c
@@ -763,7 +763,6 @@ static int rt1320_io_init(struct device *dev, struct sdw_slave *slave)
 	rt1320->first_hw_init = true;
 	rt1320->hw_init = true;
 
-	pm_runtime_mark_last_busy(&slave->dev);
 	pm_runtime_put_autosuspend(&slave->dev);
 
 	dev_dbg(&slave->dev, "%s hw_init complete\n", __func__);
diff --git a/sound/soc/codecs/rt5682-sdw.c b/sound/soc/codecs/rt5682-sdw.c
index aa229894129b..055bea0a4a3b 100644
--- a/sound/soc/codecs/rt5682-sdw.c
+++ b/sound/soc/codecs/rt5682-sdw.c
@@ -474,7 +474,6 @@ static int rt5682_io_init(struct device *dev, struct sdw_slave *slave)
 	rt5682->first_hw_init = true;
 
 err_nodev:
-	pm_runtime_mark_last_busy(&slave->dev);
 	pm_runtime_put_autosuspend(&slave->dev);
 
 	dev_dbg(&slave->dev, "%s hw_init complete: %d\n", __func__, ret);
diff --git a/sound/soc/codecs/rt700.c b/sound/soc/codecs/rt700.c
index 434b926f96c8..8f6d569c8f25 100644
--- a/sound/soc/codecs/rt700.c
+++ b/sound/soc/codecs/rt700.c
@@ -338,7 +338,6 @@ static int rt700_set_jack_detect(struct snd_soc_component *component,
 
 	rt700_jack_init(rt700);
 
-	pm_runtime_mark_last_busy(component->dev);
 	pm_runtime_put_autosuspend(component->dev);
 
 	return 0;
@@ -1230,7 +1229,6 @@ int rt700_io_init(struct device *dev, struct sdw_slave *slave)
 	/* Mark Slave initialization complete */
 	rt700->hw_init = true;
 
-	pm_runtime_mark_last_busy(&slave->dev);
 	pm_runtime_put_autosuspend(&slave->dev);
 
 	dev_dbg(&slave->dev, "%s hw_init complete\n", __func__);
diff --git a/sound/soc/codecs/rt711-sdca.c b/sound/soc/codecs/rt711-sdca.c
index dd6ccf17afd4..16c351779243 100644
--- a/sound/soc/codecs/rt711-sdca.c
+++ b/sound/soc/codecs/rt711-sdca.c
@@ -545,7 +545,6 @@ static int rt711_sdca_set_jack_detect(struct snd_soc_component *component,
 
 	rt711_sdca_jack_init(rt711);
 
-	pm_runtime_mark_last_busy(component->dev);
 	pm_runtime_put_autosuspend(component->dev);
 
 	return 0;
@@ -1662,7 +1661,6 @@ int rt711_sdca_io_init(struct device *dev, struct sdw_slave *slave)
 	/* Mark Slave initialization complete */
 	rt711->hw_init = true;
 
-	pm_runtime_mark_last_busy(&slave->dev);
 	pm_runtime_put_autosuspend(&slave->dev);
 
 	dev_dbg(&slave->dev, "%s hw_init complete\n", __func__);
diff --git a/sound/soc/codecs/rt711.c b/sound/soc/codecs/rt711.c
index 5446f9506a16..af3a49aee618 100644
--- a/sound/soc/codecs/rt711.c
+++ b/sound/soc/codecs/rt711.c
@@ -480,7 +480,6 @@ static int rt711_set_jack_detect(struct snd_soc_component *component,
 
 	rt711_jack_init(rt711);
 
-	pm_runtime_mark_last_busy(component->dev);
 	pm_runtime_put_autosuspend(component->dev);
 
 	return 0;
@@ -1331,7 +1330,6 @@ int rt711_io_init(struct device *dev, struct sdw_slave *slave)
 	/* Mark Slave initialization complete */
 	rt711->hw_init = true;
 
-	pm_runtime_mark_last_busy(&slave->dev);
 	pm_runtime_put_autosuspend(&slave->dev);
 
 	dev_dbg(&slave->dev, "%s hw_init complete\n", __func__);
diff --git a/sound/soc/codecs/rt712-sdca-dmic.c b/sound/soc/codecs/rt712-sdca-dmic.c
index 4d044dfa3136..42f8f7b8bed0 100644
--- a/sound/soc/codecs/rt712-sdca-dmic.c
+++ b/sound/soc/codecs/rt712-sdca-dmic.c
@@ -236,7 +236,6 @@ static int rt712_sdca_dmic_io_init(struct device *dev, struct sdw_slave *slave)
 	/* Mark Slave initialization complete */
 	rt712->hw_init = true;
 
-	pm_runtime_mark_last_busy(&slave->dev);
 	pm_runtime_put_autosuspend(&slave->dev);
 
 	dev_dbg(&slave->dev, "%s hw_init complete\n", __func__);
diff --git a/sound/soc/codecs/rt712-sdca.c b/sound/soc/codecs/rt712-sdca.c
index 570c2af1245d..5b298db5f0f6 100644
--- a/sound/soc/codecs/rt712-sdca.c
+++ b/sound/soc/codecs/rt712-sdca.c
@@ -479,7 +479,6 @@ static int rt712_sdca_set_jack_detect(struct snd_soc_component *component,
 
 	rt712_sdca_jack_init(rt712);
 
-	pm_runtime_mark_last_busy(component->dev);
 	pm_runtime_put_autosuspend(component->dev);
 
 	return 0;
@@ -1925,7 +1924,6 @@ int rt712_sdca_io_init(struct device *dev, struct sdw_slave *slave)
 	dev_dbg(&slave->dev, "%s hw_init complete\n", __func__);
 
 suspend:
-	pm_runtime_mark_last_busy(&slave->dev);
 	pm_runtime_put_autosuspend(&slave->dev);
 
 	return 0;
diff --git a/sound/soc/codecs/rt715-sdca.c b/sound/soc/codecs/rt715-sdca.c
index 7fb02654c16b..db7d43349d7d 100644
--- a/sound/soc/codecs/rt715-sdca.c
+++ b/sound/soc/codecs/rt715-sdca.c
@@ -1065,7 +1065,6 @@ int rt715_sdca_io_init(struct device *dev, struct sdw_slave *slave)
 	/* Mark Slave initialization complete */
 	rt715->hw_init = true;
 
-	pm_runtime_mark_last_busy(&slave->dev);
 	pm_runtime_put_autosuspend(&slave->dev);
 
 	return 0;
diff --git a/sound/soc/codecs/rt715.c b/sound/soc/codecs/rt715.c
index 2cf461852091..0fa445d88e23 100644
--- a/sound/soc/codecs/rt715.c
+++ b/sound/soc/codecs/rt715.c
@@ -1129,7 +1129,6 @@ int rt715_io_init(struct device *dev, struct sdw_slave *slave)
 	/* Mark Slave initialization complete */
 	rt715->hw_init = true;
 
-	pm_runtime_mark_last_busy(&slave->dev);
 	pm_runtime_put_autosuspend(&slave->dev);
 
 	return 0;
diff --git a/sound/soc/codecs/rt721-sdca.c b/sound/soc/codecs/rt721-sdca.c
index ba080957e933..f6f7c2ffde1c 100644
--- a/sound/soc/codecs/rt721-sdca.c
+++ b/sound/soc/codecs/rt721-sdca.c
@@ -327,7 +327,6 @@ static int rt721_sdca_set_jack_detect(struct snd_soc_component *component,
 
 	rt721_sdca_jack_init(rt721);
 
-	pm_runtime_mark_last_busy(component->dev);
 	pm_runtime_put_autosuspend(component->dev);
 
 	return 0;
@@ -1548,7 +1547,6 @@ int rt721_sdca_io_init(struct device *dev, struct sdw_slave *slave)
 	/* Mark Slave initialization complete */
 	rt721->hw_init = true;
 
-	pm_runtime_mark_last_busy(&slave->dev);
 	pm_runtime_put_autosuspend(&slave->dev);
 
 	dev_dbg(&slave->dev, "%s hw_init complete\n", __func__);
diff --git a/sound/soc/codecs/rt722-sdca.c b/sound/soc/codecs/rt722-sdca.c
index ac9588284a95..333611490ae3 100644
--- a/sound/soc/codecs/rt722-sdca.c
+++ b/sound/soc/codecs/rt722-sdca.c
@@ -339,7 +339,6 @@ static int rt722_sdca_set_jack_detect(struct snd_soc_component *component,
 
 	rt722_sdca_jack_init(rt722);
 
-	pm_runtime_mark_last_busy(component->dev);
 	pm_runtime_put_autosuspend(component->dev);
 
 	return 0;
@@ -1559,7 +1558,6 @@ int rt722_sdca_io_init(struct device *dev, struct sdw_slave *slave)
 	/* Mark Slave initialization complete */
 	rt722->hw_init = true;
 
-	pm_runtime_mark_last_busy(&slave->dev);
 	pm_runtime_put_autosuspend(&slave->dev);
 
 	dev_dbg(&slave->dev, "%s hw_init complete\n", __func__);
diff --git a/sound/soc/codecs/rt9123.c b/sound/soc/codecs/rt9123.c
index 242e8c975a62..b162824526d6 100644
--- a/sound/soc/codecs/rt9123.c
+++ b/sound/soc/codecs/rt9123.c
@@ -77,7 +77,6 @@ static int rt9123_enable_event(struct snd_soc_dapm_widget *w, struct snd_kcontro
 	/* AMPON bit is located in volatile RG, use pm_runtime to guarantee the RG access */
 	snd_soc_component_write_field(comp, RT9123_REG_AMPCTRL, RT9123_MASK_AMPON, enable);
 
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 
 	return 0;
@@ -140,7 +139,6 @@ static int rt9123_xhandler_get(struct snd_kcontrol *kcontrol, struct snd_ctl_ele
 	if (ret < 0)
 		dev_err(dev, "Failed to get control (%d)\n", ret);
 
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 	return ret;
 }
@@ -168,7 +166,6 @@ static int rt9123_xhandler_put(struct snd_kcontrol *kcontrol, struct snd_ctl_ele
 	if (ret < 0)
 		dev_err(dev, "Failed to put control (%d)\n", ret);
 
-	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
 	return ret;
 }
diff --git a/sound/soc/codecs/tas2552.c b/sound/soc/codecs/tas2552.c
index b56dd279d90a..43449d7c2584 100644
--- a/sound/soc/codecs/tas2552.c
+++ b/sound/soc/codecs/tas2552.c
@@ -724,7 +724,6 @@ static int tas2552_probe(struct i2c_client *client)
 	pm_runtime_set_autosuspend_delay(&client->dev, 1000);
 	pm_runtime_use_autosuspend(&client->dev);
 	pm_runtime_enable(&client->dev);
-	pm_runtime_mark_last_busy(&client->dev);
 	pm_runtime_put_sync_autosuspend(&client->dev);
 
 	dev_set_drvdata(&client->dev, data);
diff --git a/sound/soc/codecs/wcd-mbhc-v2.c b/sound/soc/codecs/wcd-mbhc-v2.c
index 4b7c3d6080a1..26ebcdadeb7d 100644
--- a/sound/soc/codecs/wcd-mbhc-v2.c
+++ b/sound/soc/codecs/wcd-mbhc-v2.c
@@ -825,7 +825,6 @@ static int wcd_mbhc_initialise(struct wcd_mbhc *mbhc)
 
 	mutex_unlock(&mbhc->lock);
 
-	pm_runtime_mark_last_busy(component->dev);
 	pm_runtime_put_autosuspend(component->dev);
 
 	return 0;
@@ -1319,7 +1318,6 @@ static void wcd_correct_swch_plug(struct work_struct *work)
 	if (mbhc->mbhc_cb->hph_pull_down_ctrl)
 		mbhc->mbhc_cb->hph_pull_down_ctrl(component, true);
 
-	pm_runtime_mark_last_busy(component->dev);
 	pm_runtime_put_autosuspend(component->dev);
 }
 
diff --git a/sound/soc/codecs/wsa881x.c b/sound/soc/codecs/wsa881x.c
index d479521a6d50..636e59abc377 100644
--- a/sound/soc/codecs/wsa881x.c
+++ b/sound/soc/codecs/wsa881x.c
@@ -775,7 +775,6 @@ static int wsa881x_put_pa_gain(struct snd_kcontrol *kc,
 		usleep_range(1000, 1010);
 	}
 
-	pm_runtime_mark_last_busy(comp->dev);
 	pm_runtime_put_autosuspend(comp->dev);
 
 	return 1;
diff --git a/sound/soc/codecs/wsa883x.c b/sound/soc/codecs/wsa883x.c
index 13c9d4a6f015..188363b03b93 100644
--- a/sound/soc/codecs/wsa883x.c
+++ b/sound/soc/codecs/wsa883x.c
@@ -1491,7 +1491,6 @@ static int wsa883x_get_temp(struct wsa883x_priv *wsa883x, long *temp)
 		ret = -EAGAIN;
 	}
 out:
-	pm_runtime_mark_last_busy(wsa883x->dev);
 	pm_runtime_put_autosuspend(wsa883x->dev);
 
 	return ret;
diff --git a/sound/soc/codecs/wsa884x.c b/sound/soc/codecs/wsa884x.c
index 07d8a2645404..2484d4b8e2d9 100644
--- a/sound/soc/codecs/wsa884x.c
+++ b/sound/soc/codecs/wsa884x.c
@@ -1941,7 +1941,6 @@ static int wsa884x_get_temp(struct wsa884x_priv *wsa884x, long *temp)
 	}
 
 out:
-	pm_runtime_mark_last_busy(wsa884x->dev);
 	pm_runtime_put_autosuspend(wsa884x->dev);
 
 	return ret;
-- 
2.39.5


