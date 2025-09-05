Return-Path: <linux-kernel+bounces-802484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 490D9B452BB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 11:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12C071C87270
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 09:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA93C28314C;
	Fri,  5 Sep 2025 09:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dPbjTzMR"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEF21F4190
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 09:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757063432; cv=none; b=FOCxJoqo1l0TALhD0Gxtjo9Q96AsIErKhF/ZfQRD/aQzYe4eqBAaHH6Z/0yvu8RY7Z2SOToCsDERqYn8njxM5Wojax0cOdd2cfvn0Shctis4J2zubMxjHru6pSd5ZNu16T3hCQFg8qs3PopbilQPsxaYZnHarHQVnUn7Wx7uLl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757063432; c=relaxed/simple;
	bh=H8tlBxo/I4QKoAzzAETioGThO/7phy21jo5gPXQ6OIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hm9P3/8bLYG8b58ue31DaoveseJGpLAe+TD5wbAmCE2XtPzWc+CQRjw571KqNdVzMC7d+xb3ximlgLa8JZppxx2UTna9orG4p7ghV9PgnM3Fs+VDoPLElKHFUSr97AQjel+fCg0pER42d1AZ4AxBCAOG65Ghq9iAbTN8tMaeepA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dPbjTzMR; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3da9ad0c1f4so1284780f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 02:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757063428; x=1757668228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nTbLiixSPe1l4QCB72UnekC/gzC3UfcTOHYnl7T9UCY=;
        b=dPbjTzMR+xzQihcYtBxCIO0bX+frgXReHFLTc8mCewTsSKfineCir2IkEntwjiSg/B
         ZA1rGnUvNwNJS2lTw3SR+TZedyazSY6+UzLm04+/MkwBuOv83wxzYYsuKqpQUPLaMBnw
         byTssY+ig3QYMpO7hODJNSDi63ld+mwaConagKtJhwQVAukDTyqHTc8iDESBdBvdhXlK
         paNK+vZ+4dM+S8UwCdc6NlMuRf1KAF+1q/+09A/1h+BPsR2NnawMyeU6Y95YTN674POm
         HLJXnFjpi5nLD5BM0RSK2TT7SGOmCi0yvv/aR5pHxhWc3JgKlyyemFyaYQwbj/jvm4L4
         +8yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757063428; x=1757668228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nTbLiixSPe1l4QCB72UnekC/gzC3UfcTOHYnl7T9UCY=;
        b=jgVixgAKqF/uLNzC61LOETbTIaNKYUDY0B9/YJ4NjpoXIpyPpL16YIcoizIYN0JvQy
         ouqUDSvO6bPYCSj6xFW2qKvNzly2pqCajWK4DN9Bx7z0c791uTI24zPmWezJKL1j/k5l
         pcSz0qPEqWYcAw+V3QKJ7mayEu4Xdp7izBAOBstmtvTqJk9f7lt7kpVQgRxfMOJO46ZH
         0ggILuWm75wJ+I09HBLaYGEsaX7vMAcnfcc94PX8SfNKXSEPOXBN7BFrh5ywT1tZAqnp
         8/E3ImCd2eAqPNoY2yKq7CXV6440m7uiLWEU/49mFk2hXYX+6UXIUIKXYeCih6eCl01A
         DkgQ==
X-Gm-Message-State: AOJu0YwLcfG0+pfC4L3Phfp0yuc9lmUJi4WzU5efgLdWsb4V0TpiN7SH
	VR7ReTRwY5QMw/vXHxbIzEeGWSPi19q6EWmzgfnwlXYYGUNcKNGw5FjNVZwlJEoytMVYfQo5f4r
	mMdj1YfM=
X-Gm-Gg: ASbGncsdmwazX/f5fzOs8SW98sUml0Vd+EaDdLBxR2ueqOZRrsastoqcOfMK0ngju9M
	SSF9h8EMK3QXhqn04AHmEzDmKwZCTZGLw2tiE6Hgqglp8trCYqptUDUYFBNwpu3h3yA+OcunPK2
	putpQRBodOIyCASgq3InYgy9vnpuJVtIt3hOa97uQqbp9G4oTbToU0ds6kg1nq/iSveElnxezP5
	UdrZCaRV4Uw0KX/nezq7TtqjGYWX+sKZC9O+eIn+/wkoMl9UNcadMmI95/cRekxNB4vaPotWtPb
	PJqgpzS9XAIMuJkXdzyOsVbbqe9bzCr2C2MdFxuzJL84cK4BI/LneY54TU0WCDEDW1HTTXE77SN
	gKlamorabbeKpjyZbVAcNAMXpGdVJ5ZRLL+taDMSkV2eJXzs=
X-Google-Smtp-Source: AGHT+IH70qfE1sbG5B6EhOVJFRp2gPCSNeuRweaStAWJqdo0xRxChgSl7UjLXO4wPAWOfEVCXvXh3A==
X-Received: by 2002:a05:6000:4403:b0:3d4:15a2:11e9 with SMTP id ffacd0b85a97d-3d415a21498mr9589221f8f.61.1757063428151;
        Fri, 05 Sep 2025 02:10:28 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45dd4affb6bsm39726915e9.1.2025.09.05.02.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 02:10:27 -0700 (PDT)
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
Subject: [PATCH 1/2] ASoC: replace use of system_unbound_wq with system_dfl_wq
Date: Fri,  5 Sep 2025 11:10:15 +0200
Message-ID: <20250905091016.109428-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250905091016.109428-1-marco.crivellari@suse.com>
References: <20250905091016.109428-1-marco.crivellari@suse.com>
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

system_unbound_wq should be the default workqueue so as not to enforce
locality constraints for random work whenever it's not required.

Adding system_dfl_wq to encourage its use when unbound work should be used.

queue_work() / queue_delayed_work() / mod_delayed_work() will now use the
new unbound wq: whether the user still use the old wq a warn will be
printed along with a wq redirect to the new one.

The old system_unbound_wq will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 sound/soc/codecs/wm_adsp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 91c8697c29c3..c8fff8496ede 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -1044,7 +1044,7 @@ int wm_adsp_early_event(struct snd_soc_dapm_widget *w,
 
 	switch (event) {
 	case SND_SOC_DAPM_PRE_PMU:
-		queue_work(system_unbound_wq, &dsp->boot_work);
+		queue_work(system_dfl_wq, &dsp->boot_work);
 		break;
 	case SND_SOC_DAPM_PRE_PMD:
 		wm_adsp_power_down(dsp);
-- 
2.51.0


