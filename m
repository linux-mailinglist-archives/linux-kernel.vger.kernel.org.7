Return-Path: <linux-kernel+bounces-836500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC20BA9DDA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 17:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ED151921CA8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 15:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28E530C344;
	Mon, 29 Sep 2025 15:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="DIzRsHFw"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6BB21770C
	for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 15:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759161078; cv=none; b=VCSS61C+OiwfEpCHe09VMRftQ4Ib50NfhA20m/3qS2Jjrp2RZUV/QBrUft0fQ6d74l948eRqSQkUnaCh6jYdG5ZT0F49R67kEQL20P6D5Th5BQ1c/oVKWvBs/NiCFpbszzsribSV8KjlrxRq1F8xDn38zlTBUebadBtwAtEVpjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759161078; c=relaxed/simple;
	bh=2RFi8t7u5d0OGImLH+WhTG9JijiM1lPYcuRSmV4EAQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PkBoWEY7Xd7qkH+3koRT8i2pw4tTPHRAidu8bqKRXz8v+xuyp7Cf1y+3Layvoe2sM0YzC44ivG5Usbd3Aj/fdgll7nd9hM9sF7qILXoHh+DItpvCGU3jx6BGrHrFfPub7FYYidpQT/BFqlYgPBLp2TqbGjMVrqn8Y6pVahTY+9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=DIzRsHFw; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3ee1221ceaaso3967077f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Sep 2025 08:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1759161073; x=1759765873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r5gCczzP9DZedxxkxub2HSik/+Z3R8aM7AcKb12bFgw=;
        b=DIzRsHFwI6pYCQ5hTTAdpih/RrE43QhUTbu/K4Nk5h9SJQOpuwgSorzBbmY43L52ef
         BDkgz/oB3W+tBr1AWQbjoFSb7PZfBusrUj9Y0aEcx22u5g3HC3CkDYncpSkY3yRAJx6G
         fHAHGPYunrqWad3iWmxZt5hXx0v6YP92mR6M3rcs1k3oFxU0PuHzPgTvQmPLd+RKMZnh
         DlhNw6EPyt+FJDabChVQAjCbvg1296pDA23RwblXN4dy88RxZjEW7WbheOd+AdbdE0gC
         8ocT/dGPvkhDDAk2+BmbElkbgPwfpk6xcF1JdVCFg4V+dcgjKN64eW5knJqhePJUOYCE
         kDmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759161073; x=1759765873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r5gCczzP9DZedxxkxub2HSik/+Z3R8aM7AcKb12bFgw=;
        b=RwdMrkpcgMyp0dTNK4n85Ct5P8b4/7Fh+RbGXs6eWlg8uFRVyhKaSwmdvJHUBpvHpW
         3Ist6n9+Y8gD7aduYgxACPXv+bt0zdwDKVcIWqRY324s8owuFAuBZQHWKLSWQkBw8Uaz
         J7dbb+s3Xguccy/9XwBYsSfS58Xw0CMddscnVYd+R3VJfOvLceR2MjzHaKeCGYH/2stA
         22aq2cFUpGE8Id2D53YvHZhVrS8v5tdlr/93kjscHhdp0s4jalMXzn3fcSCikZzvLeky
         Oly3iFBPEn5+TMj16yXwpn6IUtqEFwPmYKZD1CHgAjQI2dKBcxXbAY+sOuHMB23Auspu
         WU3Q==
X-Gm-Message-State: AOJu0YwT8qR436wpG5pngD32YkGhmeYH6QlQkgcez0/dibtEI47syEh6
	gT1r8Qi5AhJnfvQ/zRkO3rKtpRJvfoDAExas6/tMDRiFqhCXzwVprwTNjnxuFSdpEx0KJNHOIG3
	H/We1KM0=
X-Gm-Gg: ASbGncvDe3Zk9Ic/q2BUKJyWB9UrSTlYqplQenFelGBONYyrwaS0HFBFrUCDUPjOOMS
	IQzXngez2ptAcamNE28ORQLq0fRI6kP1bgoAlRv1TaeQigCiZZiyWchPAGCt/gp6kpNbPiCL1bc
	MESie7QYRBv6y88/6Busc2dk19N6kA+0bNn8lqFHeW+PZWbSdXz5ThaFYp8kbIXplPRHORQ03Mn
	vtsf4/ePSLaBL1ZpDmhj7sbkvzlfmcsekGpnyYXfXAiaJuiJRTIDidfl2V3GUOZddvX8hv5zmnC
	sL02NX/Wn8lokXtLJiqfvKujRQIU4IilCpGAnyp+GZwOHo74Xikc5G+5xPnaD2hS8bJ2Zp1pBV0
	D/j34P57QvpYS/I6+6aSEbdDq4mMmaJUku+nzIA==
X-Google-Smtp-Source: AGHT+IFF32/rsDtJ+GJeyWXkPt3vpOMwATqh5cAGgzNTveNPyHscEzZ7kWqBWYqSYKVdEAVTVNmQZQ==
X-Received: by 2002:a05:6000:1ace:b0:400:6e06:e0ae with SMTP id ffacd0b85a97d-40e4cc62efbmr15567124f8f.47.1759161072947;
        Mon, 29 Sep 2025 08:51:12 -0700 (PDT)
Received: from linux.fritz.box ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4151d0ae6f9sm14328581f8f.51.2025.09.29.08.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 08:51:12 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Subject: [PATCH v2 1/1] ASoC: replace use of system_wq with system_dfl_wq
Date: Mon, 29 Sep 2025 17:50:53 +0200
Message-ID: <20250929155053.400342-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250929155053.400342-1-marco.crivellari@suse.com>
References: <20250929155053.400342-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueue a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistentcy cannot be addressed without refactoring the API.

system_wq is a per-CPU worqueue, replaced by system_percpu_wq. Despite that,
system_wq in this change has been replaced by system_dfl_wq, because there
aren't per-cpu variables.

The old wq will be kept for a few release cylces.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 sound/soc/codecs/aw88081.c          |  2 +-
 sound/soc/codecs/aw88166.c          |  2 +-
 sound/soc/codecs/aw88261.c          |  2 +-
 sound/soc/codecs/aw88395/aw88395.c  |  2 +-
 sound/soc/codecs/aw88399.c          |  2 +-
 sound/soc/codecs/cs42l43-jack.c     |  2 +-
 sound/soc/codecs/cs42l43.c          |  4 ++--
 sound/soc/codecs/es8326.c           | 12 ++++++------
 sound/soc/codecs/rt5663.c           |  6 +++---
 sound/soc/intel/boards/sof_es8336.c |  2 +-
 sound/soc/sof/intel/cnl.c           |  2 +-
 sound/soc/sof/intel/hda-ipc.c       |  2 +-
 12 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/sound/soc/codecs/aw88081.c b/sound/soc/codecs/aw88081.c
index d61a7b8c5470..34316748bbd1 100644
--- a/sound/soc/codecs/aw88081.c
+++ b/sound/soc/codecs/aw88081.c
@@ -779,7 +779,7 @@ static void aw88081_start(struct aw88081 *aw88081, bool sync_start)
 	if (sync_start == AW88081_SYNC_START)
 		aw88081_start_pa(aw88081);
 	else
-		queue_delayed_work(system_wq,
+		queue_delayed_work(system_dfl_wq,
 			&aw88081->start_work,
 			AW88081_START_WORK_DELAY_MS);
 }
diff --git a/sound/soc/codecs/aw88166.c b/sound/soc/codecs/aw88166.c
index 28f62b991ef2..86b9d0709e50 100644
--- a/sound/soc/codecs/aw88166.c
+++ b/sound/soc/codecs/aw88166.c
@@ -1310,7 +1310,7 @@ static void aw88166_start(struct aw88166 *aw88166, bool sync_start)
 	if (sync_start == AW88166_SYNC_START)
 		aw88166_start_pa(aw88166);
 	else
-		queue_delayed_work(system_wq,
+		queue_delayed_work(system_dfl_wq,
 			&aw88166->start_work,
 			AW88166_START_WORK_DELAY_MS);
 }
diff --git a/sound/soc/codecs/aw88261.c b/sound/soc/codecs/aw88261.c
index de11ae8dd9d9..ece6b4411c33 100644
--- a/sound/soc/codecs/aw88261.c
+++ b/sound/soc/codecs/aw88261.c
@@ -705,7 +705,7 @@ static void aw88261_start(struct aw88261 *aw88261, bool sync_start)
 	if (sync_start == AW88261_SYNC_START)
 		aw88261_start_pa(aw88261);
 	else
-		queue_delayed_work(system_wq,
+		queue_delayed_work(system_dfl_wq,
 			&aw88261->start_work,
 			AW88261_START_WORK_DELAY_MS);
 }
diff --git a/sound/soc/codecs/aw88395/aw88395.c b/sound/soc/codecs/aw88395/aw88395.c
index fb563b4c6971..727aae2dd727 100644
--- a/sound/soc/codecs/aw88395/aw88395.c
+++ b/sound/soc/codecs/aw88395/aw88395.c
@@ -75,7 +75,7 @@ static void aw88395_start(struct aw88395 *aw88395, bool sync_start)
 	if (sync_start == AW88395_SYNC_START)
 		aw88395_start_pa(aw88395);
 	else
-		queue_delayed_work(system_wq,
+		queue_delayed_work(system_dfl_wq,
 			&aw88395->start_work,
 			AW88395_START_WORK_DELAY_MS);
 }
diff --git a/sound/soc/codecs/aw88399.c b/sound/soc/codecs/aw88399.c
index 58846feb013d..6a05dbe5ee71 100644
--- a/sound/soc/codecs/aw88399.c
+++ b/sound/soc/codecs/aw88399.c
@@ -1340,7 +1340,7 @@ static void aw88399_start(struct aw88399 *aw88399, bool sync_start)
 	if (sync_start == AW88399_SYNC_START)
 		aw88399_start_pa(aw88399);
 	else
-		queue_delayed_work(system_wq,
+		queue_delayed_work(system_dfl_wq,
 			&aw88399->start_work,
 			AW88399_START_WORK_DELAY_MS);
 }
diff --git a/sound/soc/codecs/cs42l43-jack.c b/sound/soc/codecs/cs42l43-jack.c
index 867e23d4fb8d..68a4ce7c2732 100644
--- a/sound/soc/codecs/cs42l43-jack.c
+++ b/sound/soc/codecs/cs42l43-jack.c
@@ -300,7 +300,7 @@ irqreturn_t cs42l43_bias_detect_clamp(int irq, void *data)
 {
 	struct cs42l43_codec *priv = data;
 
-	queue_delayed_work(system_wq, &priv->bias_sense_timeout,
+	queue_delayed_work(system_dfl_wq, &priv->bias_sense_timeout,
 			   msecs_to_jiffies(1000));
 
 	return IRQ_HANDLED;
diff --git a/sound/soc/codecs/cs42l43.c b/sound/soc/codecs/cs42l43.c
index b61df09f20cf..a11d8ed8fa4e 100644
--- a/sound/soc/codecs/cs42l43.c
+++ b/sound/soc/codecs/cs42l43.c
@@ -161,7 +161,7 @@ static void cs42l43_hp_ilimit_clear_work(struct work_struct *work)
 	priv->hp_ilimit_count--;
 
 	if (priv->hp_ilimit_count)
-		queue_delayed_work(system_wq, &priv->hp_ilimit_clear_work,
+		queue_delayed_work(system_dfl_wq, &priv->hp_ilimit_clear_work,
 				   msecs_to_jiffies(CS42L43_HP_ILIMIT_DECAY_MS));
 
 	snd_soc_dapm_mutex_unlock(dapm);
@@ -179,7 +179,7 @@ static irqreturn_t cs42l43_hp_ilimit(int irq, void *data)
 
 	if (priv->hp_ilimit_count < CS42L43_HP_ILIMIT_MAX_COUNT) {
 		if (!priv->hp_ilimit_count)
-			queue_delayed_work(system_wq, &priv->hp_ilimit_clear_work,
+			queue_delayed_work(system_dfl_wq, &priv->hp_ilimit_clear_work,
 					   msecs_to_jiffies(CS42L43_HP_ILIMIT_DECAY_MS));
 
 		priv->hp_ilimit_count++;
diff --git a/sound/soc/codecs/es8326.c b/sound/soc/codecs/es8326.c
index 78c4e68f6002..f3b25220141b 100644
--- a/sound/soc/codecs/es8326.c
+++ b/sound/soc/codecs/es8326.c
@@ -812,12 +812,12 @@ static void es8326_jack_button_handler(struct work_struct *work)
 			press_count = 0;
 		}
 		button_to_report = cur_button;
-		queue_delayed_work(system_wq, &es8326->button_press_work,
+		queue_delayed_work(system_dfl_wq, &es8326->button_press_work,
 				   msecs_to_jiffies(35));
 	} else if (prev_button != cur_button) {
 		/* mismatch, detect again */
 		prev_button = cur_button;
-		queue_delayed_work(system_wq, &es8326->button_press_work,
+		queue_delayed_work(system_dfl_wq, &es8326->button_press_work,
 				   msecs_to_jiffies(35));
 	} else {
 		/* released or no pressed */
@@ -912,7 +912,7 @@ static void es8326_jack_detect_handler(struct work_struct *work)
 					(ES8326_INT_SRC_PIN9 | ES8326_INT_SRC_BUTTON));
 			regmap_write(es8326->regmap, ES8326_SYS_BIAS, 0x1f);
 			regmap_update_bits(es8326->regmap, ES8326_HP_DRIVER_REF, 0x0f, 0x0d);
-			queue_delayed_work(system_wq, &es8326->jack_detect_work,
+			queue_delayed_work(system_dfl_wq, &es8326->jack_detect_work,
 					msecs_to_jiffies(400));
 			es8326->hp = 1;
 			goto exit;
@@ -923,7 +923,7 @@ static void es8326_jack_detect_handler(struct work_struct *work)
 			regmap_write(es8326->regmap, ES8326_INT_SOURCE,
 					(ES8326_INT_SRC_PIN9 | ES8326_INT_SRC_BUTTON));
 			es8326_enable_micbias(es8326->component);
-			queue_delayed_work(system_wq, &es8326->button_press_work, 10);
+			queue_delayed_work(system_dfl_wq, &es8326->button_press_work, 10);
 			goto exit;
 		}
 		if ((iface & ES8326_HPBUTTON_FLAG) == 0x01) {
@@ -958,10 +958,10 @@ static irqreturn_t es8326_irq(int irq, void *dev_id)
 		goto out;
 
 	if (es8326->jack->status & SND_JACK_HEADSET)
-		queue_delayed_work(system_wq, &es8326->jack_detect_work,
+		queue_delayed_work(system_dfl_wq, &es8326->jack_detect_work,
 				   msecs_to_jiffies(10));
 	else
-		queue_delayed_work(system_wq, &es8326->jack_detect_work,
+		queue_delayed_work(system_dfl_wq, &es8326->jack_detect_work,
 				   msecs_to_jiffies(300));
 
 out:
diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index 45057562c0c8..50fdeb8f0606 100644
--- a/sound/soc/codecs/rt5663.c
+++ b/sound/soc/codecs/rt5663.c
@@ -1859,7 +1859,7 @@ static irqreturn_t rt5663_irq(int irq, void *data)
 	dev_dbg(regmap_get_device(rt5663->regmap), "%s IRQ queue work\n",
 		__func__);
 
-	queue_delayed_work(system_wq, &rt5663->jack_detect_work,
+	queue_delayed_work(system_dfl_wq, &rt5663->jack_detect_work,
 		msecs_to_jiffies(250));
 
 	return IRQ_HANDLED;
@@ -1974,7 +1974,7 @@ static void rt5663_jack_detect_work(struct work_struct *work)
 				cancel_delayed_work_sync(
 					&rt5663->jd_unplug_work);
 			} else {
-				queue_delayed_work(system_wq,
+				queue_delayed_work(system_dfl_wq,
 					&rt5663->jd_unplug_work,
 					msecs_to_jiffies(500));
 			}
@@ -2024,7 +2024,7 @@ static void rt5663_jd_unplug_work(struct work_struct *work)
 				    SND_JACK_BTN_0 | SND_JACK_BTN_1 |
 				    SND_JACK_BTN_2 | SND_JACK_BTN_3);
 	} else {
-		queue_delayed_work(system_wq, &rt5663->jd_unplug_work,
+		queue_delayed_work(system_dfl_wq, &rt5663->jd_unplug_work,
 			msecs_to_jiffies(500));
 	}
 }
diff --git a/sound/soc/intel/boards/sof_es8336.c b/sound/soc/intel/boards/sof_es8336.c
index 10b189ea88db..41b7545581e0 100644
--- a/sound/soc/intel/boards/sof_es8336.c
+++ b/sound/soc/intel/boards/sof_es8336.c
@@ -163,7 +163,7 @@ static int sof_es8316_speaker_power_event(struct snd_soc_dapm_widget *w,
 
 	priv->speaker_en = !SND_SOC_DAPM_EVENT_ON(event);
 
-	queue_delayed_work(system_wq, &priv->pcm_pop_work, msecs_to_jiffies(70));
+	queue_delayed_work(system_dfl_wq, &priv->pcm_pop_work, msecs_to_jiffies(70));
 	return 0;
 }
 
diff --git a/sound/soc/sof/intel/cnl.c b/sound/soc/sof/intel/cnl.c
index 385e5339f0a4..c4b58738d74b 100644
--- a/sound/soc/sof/intel/cnl.c
+++ b/sound/soc/sof/intel/cnl.c
@@ -329,7 +329,7 @@ int cnl_ipc_send_msg(struct snd_sof_dev *sdev, struct snd_sof_ipc_msg *msg)
 	 * CTX_SAVE IPC, which is sent before the DSP enters D3.
 	 */
 	if (hdr->cmd != (SOF_IPC_GLB_PM_MSG | SOF_IPC_PM_CTX_SAVE))
-		mod_delayed_work(system_wq, &hdev->d0i3_work,
+		mod_delayed_work(system_dfl_wq, &hdev->d0i3_work,
 				 msecs_to_jiffies(SOF_HDA_D0I3_WORK_DELAY_MS));
 
 	return 0;
diff --git a/sound/soc/sof/intel/hda-ipc.c b/sound/soc/sof/intel/hda-ipc.c
index f3fbf43a70c2..94425c510861 100644
--- a/sound/soc/sof/intel/hda-ipc.c
+++ b/sound/soc/sof/intel/hda-ipc.c
@@ -96,7 +96,7 @@ void hda_dsp_ipc4_schedule_d0i3_work(struct sof_intel_hda_dev *hdev,
 	if (hda_dsp_ipc4_pm_msg(msg_data->primary))
 		return;
 
-	mod_delayed_work(system_wq, &hdev->d0i3_work,
+	mod_delayed_work(system_dfl_wq, &hdev->d0i3_work,
 			 msecs_to_jiffies(SOF_HDA_D0I3_WORK_DELAY_MS));
 }
 EXPORT_SYMBOL_NS(hda_dsp_ipc4_schedule_d0i3_work, "SND_SOC_SOF_INTEL_HDA_COMMON");
-- 
2.51.0


