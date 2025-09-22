Return-Path: <linux-kernel+bounces-826973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3667EB8FC30
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 11:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D85418962CD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 09:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FE628A3F2;
	Mon, 22 Sep 2025 09:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KWLDslP+"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5BD279DAD
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 09:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758533578; cv=none; b=GfE462Bi557vZub/A+sXf1YW/ODaH/ensKSBtr0q+neQGxOu6x/bBTKuuuYbU15HVep/mQgeI4QVV/rQ4lJVjwSbdsKV9W/sW+rwUEJ0e/Gx53kVFqj8BoT+RKq+gBGdywoC3/dSfhWvqXlyX5WDWlxizJevL4irRhsvegAn77o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758533578; c=relaxed/simple;
	bh=rdQMUCcOfuFM8VWa9dObjPWFxlJNnKkOSfw2YBt2xzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ckFURELXbHgnAGM0pYhiw/9E56vBy9ZdtoStAsjHMGKxIX7MryX1z5vjXnWEfp2PoTzuVjZwAlVwtyffPuRHjdD9+Z4ep8DtAZXWXouwjpZ1FCT5LyAokl0lSL/Oqs9ebNLxx7aad3wbQwwILKgJwz0nQa/Pl6McMFrXcV2TNdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KWLDslP+; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3e8ef75b146so3903266f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 02:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1758533575; x=1759138375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QNvi+wp3wynpPPhrWSTZf0UAlT0FrurlnalPogZVUb8=;
        b=KWLDslP+nnRjBWMY7L2t7ImgImU5j9V7N6AqJMvDs0RPFdfh+jrruOcTEiK/o8m3LU
         RdaGSMK9EtiGQduzEHuPf9xQiARYV9nBJbfN0dmLiOeQ+BvyrkM/aCrJjkRrY8WF7ozg
         kqVJWfOM63LIrmrvRUGscmLl6v0AtzqDNe6+fbMXLKsO6wltWZ+GxhnsieMP8O3FRy1d
         BR5K+k9tDXiAq+X54H0ImPrJccRniDWvpczejilqt1Xfqu7NBYqqms+QeEpy2FKEspma
         eqKHaMa1hfzYuuPn47O4Vls7gGl/QT9SeOY+ti1yS5Xo0tYrHZey7n1tPLMRwTuFzCU1
         1pUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758533575; x=1759138375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QNvi+wp3wynpPPhrWSTZf0UAlT0FrurlnalPogZVUb8=;
        b=ZdH39s9GXuqul5qe3kgZg1sJPjrrILSEL+VzfnVS8t+ZQdvJxw8QEuG9Wc7vcCq3eO
         /14/hoTZ54NJbaR44Uei2WF4pJh+4HuenYNHu2yEPkw02cHB9vDwl0ft1WV1WWg4t6SB
         Bp4SdmfchH2woTRdwc9xp4G6u0UqMh9094V81jZxc49VuUEzObwoBMELImZIB8U7NFl2
         nrZn/dOwHH5qxn0tGLtZkYs6lNRpIiRsxOsq5wXbE84wm7tslHJlHORIokB0pjpYZxuI
         5HFUTfR6wW/jbRNU7ntNnC3C6ntrtEF7Htt/nbQgSTtGO6gZTPx2oFwuw8X4oR4A3bEB
         y3oQ==
X-Gm-Message-State: AOJu0Yz892c2vcdf1Ws1bYjw/LCbAnSkkz/vcYZUw8mM5Iug+S9ULsjb
	zAOAslES1EMsts1SfklIHRhGXdDObnZiFk8F0uRMzGVEEvORJWNTlPDvuri3Teci5Hbpus65UGz
	xtlqP
X-Gm-Gg: ASbGncskMNWGioSK2ClI54V2eS+JVco+b0V9wBbn5m+elzd6Z3wzZGGrtJdYHjCFoaQ
	YgKgU7bSMvoUot/JdRy6OLPuD9UGhY1QM9B4NloOui9jT6SR+evtW0SU5dlU+atmIRV4mpDjuj0
	/To2Zw9IcNLQhBXcKL4WAoVZzB/mNBtX9Dn3TIXJpoPzNncI6uoic7bS0WTbEq+A+0W1A8EFfsr
	MXB/jZHfgKlceUMyUdoMc55Pn4VcPjNRScVs43o3sU1DH93+i1MlVvEw5UCmiTR/uAzqoPGVR2w
	aiTpzjgHyrZp57kGuKvVlfsZqEjJQpxV/ggXYtMn/f0aAm00rZxLMqJEj6dY51Rsmzev8Im1I2/
	54hRswwLMSkZNC6ugF/vwGfaCYgu2jGU4bp1oWaHJdL3dn18=
X-Google-Smtp-Source: AGHT+IF172Viy+N81eYJ2CoLILxSyY4CzYyBCvvGt0Ua73puGJtp9nP2xby0yD++08WnBK7gTICZyQ==
X-Received: by 2002:a05:6000:2c01:b0:3fa:2316:c20 with SMTP id ffacd0b85a97d-3fa231616fbmr3621066f8f.5.1758533574771;
        Mon, 22 Sep 2025 02:32:54 -0700 (PDT)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee0fbc7188sm19735964f8f.37.2025.09.22.02.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 02:32:54 -0700 (PDT)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: [PATCH mt76 1/1] wifi: mt76: replace use of system_wq with system_percpu_wq
Date: Mon, 22 Sep 2025 11:32:43 +0200
Message-ID: <20250922093243.140946-2-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922093243.140946-1-marco.crivellari@suse.com>
References: <20250922093243.140946-1-marco.crivellari@suse.com>
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

system_wq is the per-cpu workqueue, but nothing in its name makes that clear.
Because of that, a new system_percpu_wq has been added and all the system_wq
users updated accordingly.

system_wq will be removed in a future release cycle.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/init.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7925/init.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index b9098a7331b1..95764b82da39 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -343,7 +343,7 @@ int mt7921_register_device(struct mt792x_dev *dev)
 	dev->mphy.hw->wiphy->available_antennas_rx = dev->mphy.chainmask;
 	dev->mphy.hw->wiphy->available_antennas_tx = dev->mphy.chainmask;
 
-	queue_work(system_wq, &dev->init_work);
+	queue_work(system_percpu_wq, &dev->init_work);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/init.c b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
index d7d5afe365ed..e33ab4849e8a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/init.c
@@ -420,7 +420,7 @@ int mt7925_register_device(struct mt792x_dev *dev)
 	dev->mphy.hw->wiphy->available_antennas_rx = dev->mphy.chainmask;
 	dev->mphy.hw->wiphy->available_antennas_tx = dev->mphy.chainmask;
 
-	queue_work(system_wq, &dev->init_work);
+	queue_work(system_percpu_wq, &dev->init_work);
 
 	return 0;
 }
-- 
2.51.0


