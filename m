Return-Path: <linux-kernel+bounces-807238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 472F4B4A1EA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 08:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18B2916B472
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 06:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421E8302160;
	Tue,  9 Sep 2025 06:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iwHrR08l"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F71D315D36;
	Tue,  9 Sep 2025 06:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757398635; cv=none; b=jbCLoyjAmOKtulNm7dR8aPQ1+EBkuBey4eFVVPcpYbOKT+QHemx0f5bVZaLvJtM0HaGfnuhumHaA7qt5sG8GN84yNbylQNuaaJWx2QF70AwDtmhHqeO8u4BgVRMdp977DVtxY98zq9/L/qZcimGJ94iGhvaWN6HL7lDzoxMQJC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757398635; c=relaxed/simple;
	bh=yoHhQ9CgBx7px++zQ5XjK1tbH2Daas08llkbF8aNblQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u3E56BybowBwo0zUVMu2BhRUJC/yh/MeM9vwcPQkNYPe9udAmBQ1D+EL21kG3uFfQElGNTQv2bXagOgtogpTVYsVqI/6buz/LK13tCYMDEinPDkz9mq5zcRrJOSBIdV5M+3i9rzz9/zbhNZH60GwqPzBgHL4rHLKEhCsl9TaqKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iwHrR08l; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3df2f4aedc7so2956900f8f.2;
        Mon, 08 Sep 2025 23:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757398632; x=1758003432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2FFPJcPGJNDsgjdC7NcMD9qGE/tE0wRplyMDk1rByxg=;
        b=iwHrR08lZPRQ9pnoiEPqGeGqDjWm8urrvpOWVOF9ggdMR5CCW3QXGv3iVD36jmdRFe
         G4yLgm1HHBW3+N+xFXHMUX8ALt7Aj1xQ02Sr9MeeyD1GpZu/zE02gZIgnYcZPwHD77GD
         gMUtwTwFBaGDOq58bKHn3SVeTGA63YKL3+KhbuQMlcpN2ouxK9zqKEOCLhdOaUcjiY4K
         lwJv4Yd7czDUroB6xc5529Bn22/gtmR6eVcm7YJYRlBuzSr9H7MIyStSpbxtOgRKl83c
         zF/wLXvzXNmsgTHBA7EAISD4LgnANXp426QIVL2gSMq95iON7Ce4Zqks7edtvYg/I/q8
         YaNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757398632; x=1758003432;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2FFPJcPGJNDsgjdC7NcMD9qGE/tE0wRplyMDk1rByxg=;
        b=ZtlAr/XrTavLClzCcBvOAprODW0G+y/mZI6+0cN3A9Qd9lHQKEMXuCEALoEX8Oze01
         q29rsUF6jK/B4oIvhio2SOEL9GCpN5jWqCRkq9UGRehunlAf5xJlI+ym9WMroHRh00Rs
         kY1Xbn15pnrLfLHokbmAYeM2QGipP+R8VNIHMVd7BWr/Ow6HbJSpFc8Lfh6/lz770DHB
         d3JI3QSAU6inAs1T3ZiXeKKLea09Mez5mt/BxwB6UJEx3pnMZ4/EIoRysGTVqSCgr2/N
         s/yD7P8ENYaX10dAXHktP0Tb6URYp19TjBwyzpACjB1RYE1mj2NCV48kpIf3Rtj69JKY
         6SWg==
X-Forwarded-Encrypted: i=1; AJvYcCV/0hkTP+oAwbdpsjkCELAh97+h34IgfBOu64949ojiogCmfm4FOHmzmAxKfkTLGYUNlTw3HKTkyWwRsmE=@vger.kernel.org, AJvYcCVmb95hqOg5WAYpzQBM7BTfwJOOjULl/1WW6Wh5Ia7hze3E2Bg8eLIjnsB0QHEOx4/G0omTsKSFF/99Q1k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPf01cdiqFNm2yp7Y+yEsnC803zRqDP05NZJVqn02tM6EyeOBD
	R3r2pfpjuILelnA0I96wwh/+N8zAA0gWFhwJVAA5cxnfsrGgNaSlY0gQh/lmdGwL
X-Gm-Gg: ASbGncvm96ptgSSJyRynCnd990YHPj5NUoMKZs9XJY4VzrIoKEoy0Qh/2JGg+jqp42O
	g2kqbrmFHO4cxq5qrdAkAwqooCTaDRphupHcppUdJsK15IQuDxVU38fVyklveNi4oDNGgkl+MWC
	HQlmUsYGk4I6jDdzyMa6FmRM/2AbPgnP7gsfw6UCwh+TvcErdehOLaLmqbP9gSVg4pY5tfvO2PB
	FRNiWFX3bT3JuJfG6cLm9bfqTGx6UwcvfVvpE2yyxiEtLWNeFhdj95PY0CWeqdeCaoNyvbZ+vyw
	dBLC6l/0Utw23ORa74hiT9pPNScmR/cm3HiipBpa1joPsWbJz/I3xNHIDwuiZJH+tPhxWSmVi5+
	mTJVf8ESCaaCuIONHZbgo9MLbJtwVW5Ob/KGHrGi9NQbtMswvdN1qc4+F
X-Google-Smtp-Source: AGHT+IFRsjA4jE5CQ530QLjZI5/Qn+p26X75xpQcc4lXNl3iHmepdOFyHFjbdzj17gqaz1pQxgFZIw==
X-Received: by 2002:adf:a345:0:b0:3e7:27b9:40f3 with SMTP id ffacd0b85a97d-3e727c88694mr5794698f8f.15.1757398631565;
        Mon, 08 Sep 2025 23:17:11 -0700 (PDT)
Received: from pc.. ([105.160.50.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e7521bfdc6sm1204949f8f.8.2025.09.08.23.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 23:17:10 -0700 (PDT)
From: Erick Karanja <karanja99erick@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Julia Lawall <julia.lawall@inria.fr>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Erick Karanja <karanja99erick@gmail.com>
Subject: [PATCH] ALSA: spi: Replace lock/unlock patterns with guard
Date: Tue,  9 Sep 2025 09:17:02 +0300
Message-ID: <20250909061702.350164-1-karanja99erick@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace lock/unlock patterns with guard.This simplifies control
flow especially with conditional jumps and improves code readability.

Generated-by: Coccinelle SmPL

Signed-off-by: Erick Karanja <karanja99erick@gmail.com>
---
 sound/spi/at73c213.c | 99 ++++++++++++++++++--------------------------
 1 file changed, 41 insertions(+), 58 deletions(-)

diff --git a/sound/spi/at73c213.c b/sound/spi/at73c213.c
index a0a7f90b6146..944bc3d56e4c 100644
--- a/sound/spi/at73c213.c
+++ b/sound/spi/at73c213.c
@@ -275,7 +275,7 @@ static int snd_at73c213_pcm_trigger(struct snd_pcm_substream *substream,
 	struct snd_at73c213 *chip = snd_pcm_substream_chip(substream);
 	int retval = 0;
 
-	spin_lock(&chip->lock);
+	guard(spinlock)(&chip->lock);
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
@@ -292,8 +292,6 @@ static int snd_at73c213_pcm_trigger(struct snd_pcm_substream *substream,
 		break;
 	}
 
-	spin_unlock(&chip->lock);
-
 	return retval;
 }
 
@@ -358,30 +356,30 @@ static irqreturn_t snd_at73c213_interrupt(int irq, void *dev_id)
 	int next_period;
 	int retval = IRQ_NONE;
 
-	spin_lock(&chip->lock);
+	scoped_guard (spinlock, &chip->lock) {
 
-	block_size = frames_to_bytes(runtime, runtime->period_size);
-	status = ssc_readl(chip->ssc->regs, IMR);
-
-	if (status & SSC_BIT(IMR_ENDTX)) {
-		chip->period++;
-		if (chip->period == runtime->periods)
-			chip->period = 0;
-		next_period = chip->period + 1;
-		if (next_period == runtime->periods)
-			next_period = 0;
-
-		offset = block_size * next_period;
-
-		ssc_writel(chip->ssc->regs, PDC_TNPR,
-				(long)runtime->dma_addr + offset);
-		ssc_writel(chip->ssc->regs, PDC_TNCR,
-				runtime->period_size * runtime->channels);
-		retval = IRQ_HANDLED;
-	}
+		block_size = frames_to_bytes(runtime, runtime->period_size);
+		status = ssc_readl(chip->ssc->regs, IMR);
+
+		if (status & SSC_BIT(IMR_ENDTX)) {
+			chip->period++;
+			if (chip->period == runtime->periods)
+				chip->period = 0;
+			next_period = chip->period + 1;
+			if (next_period == runtime->periods)
+				next_period = 0;
 
-	ssc_readl(chip->ssc->regs, IMR);
-	spin_unlock(&chip->lock);
+			offset = block_size * next_period;
+
+			ssc_writel(chip->ssc->regs, PDC_TNPR,
+					(long)runtime->dma_addr + offset);
+			ssc_writel(chip->ssc->regs, PDC_TNCR,
+					runtime->period_size * runtime->channels);
+			retval = IRQ_HANDLED;
+		}
+
+		ssc_readl(chip->ssc->regs, IMR);
+	}
 
 	if (status & SSC_BIT(IMR_ENDTX))
 		snd_pcm_period_elapsed(chip->substream);
@@ -401,7 +399,7 @@ static int snd_at73c213_mono_get(struct snd_kcontrol *kcontrol,
 	int mask = (kcontrol->private_value >> 16) & 0xff;
 	int invert = (kcontrol->private_value >> 24) & 0xff;
 
-	mutex_lock(&chip->mixer_lock);
+	guard(mutex)(&chip->mixer_lock);
 
 	ucontrol->value.integer.value[0] =
 		(chip->reg_image[reg] >> shift) & mask;
@@ -410,8 +408,6 @@ static int snd_at73c213_mono_get(struct snd_kcontrol *kcontrol,
 		ucontrol->value.integer.value[0] =
 			mask - ucontrol->value.integer.value[0];
 
-	mutex_unlock(&chip->mixer_lock);
-
 	return 0;
 }
 
@@ -431,13 +427,13 @@ static int snd_at73c213_mono_put(struct snd_kcontrol *kcontrol,
 		val = mask - val;
 	val <<= shift;
 
-	mutex_lock(&chip->mixer_lock);
+	scoped_guard (mutex, &chip->mixer_lock) {
 
-	val = (chip->reg_image[reg] & ~(mask << shift)) | val;
-	change = val != chip->reg_image[reg];
-	retval = snd_at73c213_write_reg(chip, reg, val);
+		val = (chip->reg_image[reg] & ~(mask << shift)) | val;
+		change = val != chip->reg_image[reg];
+		retval = snd_at73c213_write_reg(chip, reg, val);
 
-	mutex_unlock(&chip->mixer_lock);
+	}
 
 	if (retval)
 		return retval;
@@ -473,7 +469,7 @@ static int snd_at73c213_stereo_get(struct snd_kcontrol *kcontrol,
 	int mask = (kcontrol->private_value >> 24) & 0xff;
 	int invert = (kcontrol->private_value >> 22) & 1;
 
-	mutex_lock(&chip->mixer_lock);
+	guard(mutex)(&chip->mixer_lock);
 
 	ucontrol->value.integer.value[0] =
 		(chip->reg_image[left_reg] >> shift_left) & mask;
@@ -487,8 +483,6 @@ static int snd_at73c213_stereo_get(struct snd_kcontrol *kcontrol,
 			mask - ucontrol->value.integer.value[1];
 	}
 
-	mutex_unlock(&chip->mixer_lock);
-
 	return 0;
 }
 
@@ -514,29 +508,20 @@ static int snd_at73c213_stereo_put(struct snd_kcontrol *kcontrol,
 	val1 <<= shift_left;
 	val2 <<= shift_right;
 
-	mutex_lock(&chip->mixer_lock);
+	guard(mutex)(&chip->mixer_lock);
 
 	val1 = (chip->reg_image[left_reg] & ~(mask << shift_left)) | val1;
 	val2 = (chip->reg_image[right_reg] & ~(mask << shift_right)) | val2;
 	change = val1 != chip->reg_image[left_reg]
 		|| val2 != chip->reg_image[right_reg];
 	retval = snd_at73c213_write_reg(chip, left_reg, val1);
-	if (retval) {
-		mutex_unlock(&chip->mixer_lock);
-		goto out;
-	}
+	if (retval)
+		return retval;
 	retval = snd_at73c213_write_reg(chip, right_reg, val2);
-	if (retval) {
-		mutex_unlock(&chip->mixer_lock);
-		goto out;
-	}
-
-	mutex_unlock(&chip->mixer_lock);
+	if (retval)
+		return retval;
 
 	return change;
-
-out:
-	return retval;
 }
 
 #define snd_at73c213_mono_switch_info	snd_ctl_boolean_mono_info
@@ -549,7 +534,7 @@ static int snd_at73c213_mono_switch_get(struct snd_kcontrol *kcontrol,
 	int shift = (kcontrol->private_value >> 8) & 0xff;
 	int invert = (kcontrol->private_value >> 24) & 0xff;
 
-	mutex_lock(&chip->mixer_lock);
+	guard(mutex)(&chip->mixer_lock);
 
 	ucontrol->value.integer.value[0] =
 		(chip->reg_image[reg] >> shift) & 0x01;
@@ -558,8 +543,6 @@ static int snd_at73c213_mono_switch_get(struct snd_kcontrol *kcontrol,
 		ucontrol->value.integer.value[0] =
 			0x01 - ucontrol->value.integer.value[0];
 
-	mutex_unlock(&chip->mixer_lock);
-
 	return 0;
 }
 
@@ -583,14 +566,14 @@ static int snd_at73c213_mono_switch_put(struct snd_kcontrol *kcontrol,
 		val = mask - val;
 	val <<= shift;
 
-	mutex_lock(&chip->mixer_lock);
+	scoped_guard (mutex, &chip->mixer_lock) {
 
-	val |= (chip->reg_image[reg] & ~(mask << shift));
-	change = val != chip->reg_image[reg];
+		val |= (chip->reg_image[reg] & ~(mask << shift));
+		change = val != chip->reg_image[reg];
 
-	retval = snd_at73c213_write_reg(chip, reg, val);
+		retval = snd_at73c213_write_reg(chip, reg, val);
 
-	mutex_unlock(&chip->mixer_lock);
+	}
 
 	if (retval)
 		return retval;
-- 
2.43.0


