Return-Path: <linux-kernel+bounces-752570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4447B1774D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 22:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0A86587143
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 20:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472EF2135AC;
	Thu, 31 Jul 2025 20:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JgyEu9mt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49EF259CA5
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 20:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753994703; cv=none; b=HAkfdhm7ph5Ol3NC5RXZr9G9W5aV4vT5GpFzRefW7NpAyLsw1gZdy2tUfwp7yHJEB2Yr4rurfZTjbUIfguC8R2TXcvw6a47/PAM3lD8rlwsOQoU9PsYQ9gI4E8UVgySTo0VyuE7QrEmW9d3ChmwGcwKhv7NZdHcITAqhwtl7tKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753994703; c=relaxed/simple;
	bh=oCQZFJWOdximZopCsYrFhkMEzCNDEexUxz2s73gm37U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hcfedXP6FUGu4eLwQREqxR45NwImhJjbZP0hmuch1ZhYi/Yvob5Xyc/bGMgDc946Nz9FmvgaLnofb5LmBS56f/oZiODxaiVAmKICpVxTWbTkWnNaPY65rLE7sN8VlZEb+6wcS5ShZs1b6Y6IuD7zbDyRZDgJeNLclIjIRuHTvVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JgyEu9mt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1667FC4CEFA;
	Thu, 31 Jul 2025 20:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753994703;
	bh=oCQZFJWOdximZopCsYrFhkMEzCNDEexUxz2s73gm37U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JgyEu9mtqBCLNdyevFWUXYJ6OZ0Scu/E6sAjm7Jr+m/4lc2kn+sFw8P2ab3LNO7L/
	 AW8FZ8i3FzZibcBWdKm88QjkMRDq22dPFympglBjnzrpK6p3wk2A6QV7LY19fMYKwr
	 UI23WdSbgMaX2BHb8oB0hr/K3Lqg14DxfZ5PUZ/k0OQldY7cTKCkjZ74o9LVHG3KlJ
	 75UABgEC/Lel81Vo1vvEtgffw9U5gEfOiHixU4gT3OAMN+SIWnn+coM9qjv0I7Kqqb
	 FUZefu2jI8BB9lp3WfKHwkt564JVHyZCJWdEQ2FQnh7iqzpkNMi6T8CtRNJD2u9nbo
	 PjlMbKpYJ94TQ==
From: Mark Brown <broonie@kernel.org>
Date: Thu, 31 Jul 2025 21:38:19 +0100
Subject: [PATCH 2/2] regmap: irq: Avoid lockdep warnings with nested
 regmap-irq chips
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-regmap-irq-nesting-v1-2-98b4d1bf20f0@kernel.org>
References: <20250731-regmap-irq-nesting-v1-0-98b4d1bf20f0@kernel.org>
In-Reply-To: <20250731-regmap-irq-nesting-v1-0-98b4d1bf20f0@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=2940; i=broonie@kernel.org;
 h=from:subject:message-id; bh=oCQZFJWOdximZopCsYrFhkMEzCNDEexUxz2s73gm37U=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoi9XKLt1q2xiPZf4RQJHdNAYT5Xn5IsA4u8d/s
 Ki70RcffAWJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaIvVygAKCRAk1otyXVSH
 0DoyB/45gFIs1Q68j9r54brTjixBFSLvwRnyefmGELT75rUz0EeQ3vahBL5JyU6pV2+srSPXrNc
 RyVgsvea3loNP+NmsXskXZI8vUwrw+AK0wAZ9FlHoDckkVHFCyz6+XgsdOdp7QjkF+glrUtKla1
 Uq/axtqIEuFNyCAvRwHFbW8gAOQT4vXsyg2ph9M7jFXWxQhZRlSSvGA+oxqwVLY5PGohyIRh8ru
 LNRPMg4q+Mkh18O0UioXR3SjeGxhzYtQUiPMh1C/Ofv/721Vwcx+bds5xb4HquAWwVPhfpZdLX9
 oQiCz51/ffL0yVefwX/No+BZgK7KNDEiFhlNELBMWNuJZgXA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

While handling interrupts through regmap-irq we use a mutex to protect the
updates we are caching while genirq runs in atomic context. Russell King
reported that while running on the nVidia Jetson Xavier NX this generates
lockdep warnings since that platform has a regmap-irq for the max77686 RTC
which is a child of a max77620 which also uses regmap-irq.

[   46.723127] rtcwake/3984 is trying to acquire lock:
[   46.723235] ffff0000813b2c68 (&d->lock){+.+.}-{4:4}, at: regmap_irq_lock+0x18/0x24
[   46.723452]
               but task is already holding lock:
[   46.723556] ffff00008504dc68 (&d->lock){+.+.}-{4:4}, at: regmap_irq_lock+0x18/0x24

This happens because by default lockdep uses a single lockdep class for all
mutexes initialised from a single mutex_init() call and is unable to tell
that two distinct mutex are being taken and verify that the ordering of
operations is safe. This should be a very rare situation since normally
anything using regmap-irq will be a leaf interrupt controller due to being
on a slow bus like I2C.

We can avoid these warnings by providing the lockdep key for the regmap-irq
explicitly, allocating one for each chip so that lockdep can distinguish
between them.

Thanks to Russell for the report and analysis.

Reported-by: "Russell King (Oracle)" <linux@armlinux.org.uk>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/base/regmap/regmap-irq.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/base/regmap/regmap-irq.c b/drivers/base/regmap/regmap-irq.c
index 4aac12d38215..6112d942499b 100644
--- a/drivers/base/regmap/regmap-irq.c
+++ b/drivers/base/regmap/regmap-irq.c
@@ -21,6 +21,7 @@
 
 struct regmap_irq_chip_data {
 	struct mutex lock;
+	struct lock_class_key lock_key;
 	struct irq_chip irq_chip;
 
 	struct regmap *map;
@@ -801,7 +802,13 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 			goto err_alloc;
 	}
 
-	mutex_init(&d->lock);
+	/*
+	 * If one regmap-irq is the parent of another then we'll try
+	 * to lock the child with the parent locked, use an explicit
+	 * lock_key so lockdep can figure out what's going on.
+	 */
+	lockdep_register_key(&d->lock_key);
+	mutex_init_with_key(&d->lock, &d->lock_key);
 
 	for (i = 0; i < chip->num_irqs; i++)
 		d->mask_buf_def[chip->irqs[i].reg_offset / map->reg_stride]
@@ -937,6 +944,7 @@ int regmap_add_irq_chip_fwnode(struct fwnode_handle *fwnode,
 	/* Should really dispose of the domain but... */
 err_mutex:
 	mutex_destroy(&d->lock);
+	lockdep_unregister_key(&d->lock_key);
 err_alloc:
 	kfree(d->type_buf);
 	kfree(d->type_buf_def);
@@ -1030,6 +1038,7 @@ void regmap_del_irq_chip(int irq, struct regmap_irq_chip_data *d)
 		kfree(d->config_buf);
 	}
 	mutex_destroy(&d->lock);
+	lockdep_unregister_key(&d->lock_key);
 	kfree(d);
 }
 EXPORT_SYMBOL_GPL(regmap_del_irq_chip);

-- 
2.39.5


