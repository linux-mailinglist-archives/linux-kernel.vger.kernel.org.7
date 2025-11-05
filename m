Return-Path: <linux-kernel+bounces-886729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A118C365AC
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 16:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FFD51A41E6C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 15:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FB333342A;
	Wed,  5 Nov 2025 15:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ENnTy7mo"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24EF32ED3C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 15:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762356036; cv=none; b=shb7Ah6nAhS7WNNufUfsV3T1nWKKEX4ITGkyPQhJaoZ+CWG7XMXjVZalI8nBgkUOBanry06FYodpt8wQ4xEpvHS5T8d1JOMVLaEsxdQ6HxfV7gY4bhYS31OzXl2tqO6SnWPu7C2vMRpkI+6spHzWN8oK0jMKvxXHXlB6NTtTb1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762356036; c=relaxed/simple;
	bh=8dIdbSkcxpAle4ECYuajmQXxUWr4HYu0z+pt1GG9lcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mdGfQxnCW2+8R2eAehwqk1UiLxDaSZlh8xB7VkKN/KEeZn6DgYe5F1j/gtl2Epv4rBGpqUSzhGA61O2huYOANsVSFZzkvLjhChH/T0gNdhTRLSJ4IHohBClFe1mmK3WCOAzXVeZFqEsNVA5yTUiJ7Bxv+YVAOsjuxJoUdGrkggs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ENnTy7mo; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-426f1574a14so4213473f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 07:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762356033; x=1762960833; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ranMJA7nhTTLeDvlm0qxHCF2jeri90ZrthFQur/cI2M=;
        b=ENnTy7mobWBxCy+VN5gJ4+vuzuU/GffwqNPw9byniOpr4tcQ8NKGF+S7uE8pUCdYi8
         sg7aGLjIsVg0Fmda2UZUPrnyeblmKPzHmES5FZ8Q0vujsqFL6uHsUee2fVed2T+mBESN
         YkBoMnEY/Xw+erETb7sEhp8Ba+b1UiP5RqkhQ2Y5khaairbLTSIZfvlZqxoK7uRsUdEu
         oYbnrW6zY6AKRPRzKhnkJa9p/FqyTLtqHrfKQ4AQLmHtEa5aiNga2zHAIcfQrjkOqffU
         sgQNMjQH3WB5VpH4BfMVEi9YYsNXOm3LqZX/4XXDutv/6hA5PKsgQtxZMwJzp+ntZc9F
         XwNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762356033; x=1762960833;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ranMJA7nhTTLeDvlm0qxHCF2jeri90ZrthFQur/cI2M=;
        b=MnI5jqRhxK3OqFpIsQ8KA8jafqodoEJQ2ntLgMmKVWsP4jCPFbz6j2FIE+dTAZOQ4v
         GfKhTX2lhurqw9CUInKHqkHk3xY+iD1/VpJbJGcYkkL+YkPhy31GElsQKLuwbU92jg9X
         K+e6ADusROeawPA2tovWKccqtakSJO7cgD5nqiKHMJHF8hvfxvxfZy+YGwTIKrdpXU2s
         dCC0g1mMNhESwWR+prZl+mj4MSF2j3ZiNOijet2c+XnjEsoFxt/FGrg7EgefVhMSl2rS
         GFjGy7sQWyWWY7+xmYTanCvpXJSx5r0EII8JpTGCWZCgMsEd1LcxCM+0gK9PjCdU5tUJ
         sYFg==
X-Gm-Message-State: AOJu0YxzvBB9wUsewNJyCeBwVHoqfAy/YJa+X+z8IKzi2QRC+ftMzLMG
	ntfbpXzkafTYWkfi5HUcrGwh1SALrIaGAO3aIIxMX1wH7poCSuLkFkNmyr5ZWe7CzHjetQ+Da6E
	oBrKk
X-Gm-Gg: ASbGncvFFbUbJrOQpIpJZJSY/tSKjNAQU4/KCicY7heUCV1T9pzMAmZn2aMzd/vaGc0
	fqjzn6th09ELwMCYe5Yw0Or+5oHpDDG11IroXDBM2cj/iojMExoV1i2MNJ4lJ3MwKkN52MbCi9w
	k6RGky7OtAH/lzDvadTBTOCQ6jLTJehpEYHy609ZL1mdvsFdu/d9khhmc+vJuNujd9z9IunQgIL
	VrWPvhthUTUTTsEJCUVFKUOPcanZVKLRgS5urmDPJQ5LAdKqnggGRhsrJ765r4RwdA5ahJ7ksnd
	ipUYPG1eGfDbnhg19iL6AxAMd67HAyC/VRvnq16TdaiHT8+yjApYtKwqcl0aajaQyz3ZkX+pcOC
	pS94qYmjDjpuoxQFwaWuObOHBy3OMObzmPNERU++mTzoP/YY8Cjo9DRKcYRZI04ClhJBnLY4ZyM
	lzQzkKNmveERw6HthXEyS+Ttg=
X-Google-Smtp-Source: AGHT+IHUa1UagvSj8MVB8CHfM78Fkv+vbGeo68mTbHX615SxRGVOlXbaT5kn8JdN3BRCGmBUMVJgvw==
X-Received: by 2002:a05:6000:22ca:b0:429:c774:dbfc with SMTP id ffacd0b85a97d-429e32c8168mr3259102f8f.12.1762356032871;
        Wed, 05 Nov 2025 07:20:32 -0800 (PST)
Received: from localhost.localdomain ([2a00:6d43:105:c401:e307:1a37:2e76:ce91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc200878sm11018117f8f.45.2025.11.05.07.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 07:20:32 -0800 (PST)
From: Marco Crivellari <marco.crivellari@suse.com>
To: linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev
Cc: Tejun Heo <tj@kernel.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Michal Hocko <mhocko@suse.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>
Subject: [PATCH] phy: sun4i-usb: replace use of system_wq with system_percpu_wq
Date: Wed,  5 Nov 2025 16:20:23 +0100
Message-ID: <20251105152023.259813-1-marco.crivellari@suse.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently if a user enqueues a work item using schedule_delayed_work() the
used wq is "system_wq" (per-cpu wq) while queue_delayed_work() use
WORK_CPU_UNBOUND (used when a cpu is not specified). The same applies to
schedule_work() that is using system_wq and queue_work(), that makes use
again of WORK_CPU_UNBOUND.

This lack of consistency cannot be addressed without refactoring the API.

This patch continues the effort to refactor worqueue APIs, which has begun
with the change introducing new workqueues and a new alloc_workqueue flag:

commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")

Replace system_wq with system_percpu_wq, keeping the same behavior.
The old wq (system_wq) will be kept for a few release cycles.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
---
 drivers/phy/allwinner/phy-sun4i-usb.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c b/drivers/phy/allwinner/phy-sun4i-usb.c
index 59d38d88efb0..e2fbf8ccf99e 100644
--- a/drivers/phy/allwinner/phy-sun4i-usb.c
+++ b/drivers/phy/allwinner/phy-sun4i-usb.c
@@ -359,7 +359,7 @@ static int sun4i_usb_phy_init(struct phy *_phy)
 		/* Force ISCR and cable state updates */
 		data->id_det = -1;
 		data->vbus_det = -1;
-		queue_delayed_work(system_wq, &data->detect, 0);
+		queue_delayed_work(system_percpu_wq, &data->detect, 0);
 	}
 
 	return 0;
@@ -482,7 +482,7 @@ static int sun4i_usb_phy_power_on(struct phy *_phy)
 
 	/* We must report Vbus high within OTG_TIME_A_WAIT_VRISE msec. */
 	if (phy->index == 0 && sun4i_usb_phy0_poll(data))
-		mod_delayed_work(system_wq, &data->detect, DEBOUNCE_TIME);
+		mod_delayed_work(system_percpu_wq, &data->detect, DEBOUNCE_TIME);
 
 	return 0;
 }
@@ -503,7 +503,7 @@ static int sun4i_usb_phy_power_off(struct phy *_phy)
 	 * Vbus gpio to not trigger an edge irq on Vbus off, so force a rescan.
 	 */
 	if (phy->index == 0 && !sun4i_usb_phy0_poll(data))
-		mod_delayed_work(system_wq, &data->detect, POLL_TIME);
+		mod_delayed_work(system_percpu_wq, &data->detect, POLL_TIME);
 
 	return 0;
 }
@@ -542,7 +542,7 @@ static int sun4i_usb_phy_set_mode(struct phy *_phy,
 
 	data->id_det = -1; /* Force reprocessing of id */
 	data->force_session_end = true;
-	queue_delayed_work(system_wq, &data->detect, 0);
+	queue_delayed_work(system_percpu_wq, &data->detect, 0);
 
 	return 0;
 }
@@ -654,7 +654,7 @@ static void sun4i_usb_phy0_id_vbus_det_scan(struct work_struct *work)
 		extcon_set_state_sync(data->extcon, EXTCON_USB, vbus_det);
 
 	if (sun4i_usb_phy0_poll(data))
-		queue_delayed_work(system_wq, &data->detect, POLL_TIME);
+		queue_delayed_work(system_percpu_wq, &data->detect, POLL_TIME);
 }
 
 static irqreturn_t sun4i_usb_phy0_id_vbus_det_irq(int irq, void *dev_id)
@@ -662,7 +662,7 @@ static irqreturn_t sun4i_usb_phy0_id_vbus_det_irq(int irq, void *dev_id)
 	struct sun4i_usb_phy_data *data = dev_id;
 
 	/* vbus or id changed, let the pins settle and then scan them */
-	mod_delayed_work(system_wq, &data->detect, DEBOUNCE_TIME);
+	mod_delayed_work(system_percpu_wq, &data->detect, DEBOUNCE_TIME);
 
 	return IRQ_HANDLED;
 }
@@ -676,7 +676,7 @@ static int sun4i_usb_phy0_vbus_notify(struct notifier_block *nb,
 
 	/* Properties on the vbus_power_supply changed, scan vbus_det */
 	if (val == PSY_EVENT_PROP_CHANGED && psy == data->vbus_power_supply)
-		mod_delayed_work(system_wq, &data->detect, DEBOUNCE_TIME);
+		mod_delayed_work(system_percpu_wq, &data->detect, DEBOUNCE_TIME);
 
 	return NOTIFY_OK;
 }
-- 
2.51.1


