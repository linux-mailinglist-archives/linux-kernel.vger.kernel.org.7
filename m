Return-Path: <linux-kernel+bounces-832353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0520B9F0DC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 14:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2FE7188DCBE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 12:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B772FB977;
	Thu, 25 Sep 2025 11:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WIty5TSR"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3052FC01B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 11:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758801598; cv=none; b=RT5y2gHNcbGsqpA3vaahVQAZaJee7wlpBfiG37NwseXM04K/oHle9iiv0Qw7prmyOLpB6HvdSkz7wC6KxMIUt/mKkEq7r6gnKbw4JKrUOGPrRHsFCtaJHoyVa1mMGgywP3vjSE0gLkadKr0Ut+gGimfERJuXQHrknVv/kGiCBiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758801598; c=relaxed/simple;
	bh=yRoUXc7iM5E0Q4HeKXKIYrccPXhjgW1c57VO6navqQg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XECSGW1Zwo+nn6lODy5LCPHoBEoiajnglAu//udTVWNwXlIemggyX/hZuf64ikkz6l0chvSrMjHYZHtY8VOIX9FXb52gUOGUJd+NFwDkaFh6nlBOK7V/gZBNpIA5uHCW8XHx2cAw4nyxKi14KrePmXZSK+55VGBnLmA2QYWRx9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WIty5TSR; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-57a292a3a4bso991443e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 04:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1758801593; x=1759406393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JrqoW50S86GQruERN9yWcjsCpx5n9qTugCw8eRLUCCw=;
        b=WIty5TSRAghnp92PNmf/cfYbhC+hqsmgBhxeDJuAR/pm+72Rl+fRAQtSbOG7izUPSl
         +7N9pchgYwVzCFobdgrx5cluwW3sUemZ54KwTyYS35BIyRb2OlGtY/xG+pcstJP92gGb
         gw7++jTZUqCkWLlN/IJJ93HwR+Smlhtneh4FLkfbXDpE9YisSC9WCwJ+93xn64whF233
         9xsz+E4lHY+SahUM95YWtQLxor/PL0zGGLMN6LwRI8z5gi22kRk7R2OTh3wHIBU0jwpm
         80/lFEhU4NjwcNWqEKdxCSQtHqvKqkTcaoFtzOP5hKNY2ePxhDvcbguHZacwDl1nBdGE
         vpQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758801593; x=1759406393;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JrqoW50S86GQruERN9yWcjsCpx5n9qTugCw8eRLUCCw=;
        b=WuxIeJcntyJuN5PiY1iXPNcJmNAe7Fp1s5asGhH6trMeu6AjAFI1DXh/uJfKYfv5Ps
         4u654KynqI4MTEPhKxw3lVCf+Quuva/FQlDrjKhp5XQ3yjpUybArAW/yjeTx6Ea6PCGK
         pqCdHqIV/KOEq87tBGBMbuPXUxZLylzN9xyhCnxqBNOfuPTj1EopZ7aimxQVXkAnQhNW
         mQroRELG7UF+5imThrjSt5fAho1WdTBjlKHFbazazF8qxpH7JO3ZFhedQvd5Ez5hQpfE
         nnJBI9cI2SX+RPoCUIMjAbU0m0MG8QCSzAs0hQqtQhKDA7IRql+Fi9c1yTwzGfvx6Sw3
         lLmQ==
X-Forwarded-Encrypted: i=1; AJvYcCU46tpYtGwNGqhWotqPEPYMm2TGBRD/sDR5RwBkjkClGu9qkIAuhD7gB/yOcx/qffizcbe4DD3sk6J6CcM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4i3/QnaD3A6A6jB5a483ssuqaIuLhdsGvuxB3QWIUXXu5mgGT
	zZo5xhJeblP6QcIoC97RqVpaxGudR5BqvYWIaed4oMfxi3LyfZ4dDnfE0Sh5A8nQ0pU=
X-Gm-Gg: ASbGncvktRn9l2TZ/tdbIQiFANOC26nXdTYqGgUxq5hO9emg64t8Ow6yU6K/23RLDtJ
	SaaZJyOdZCBuC1ouC0Y/LjVxu/cf866X796OqyyvzCYcYpFsr1JBZI0QIBGDydI2fpSyRRiMM3u
	jUezZBx4KRxrsaoGrEKOqDAWqsU31i3RmkkVDdQjYdnIpyGwMwxyy7dPteyJwrnErsUgaHoRwDq
	veaG+LiRn2hyGE6NZCJIjWW2u9pOjDX3/9SN9TMqDc71nFJnECVErOWcMp7SSSlqSLiYdQ2LKEB
	AG6keVYAqF6fv5l7TnocweeW9LJpooJ7WrXqxDoo1LE2chQ04kIdYYHwoLoK7gEEI7GuTSc8hIx
	ZYYE9OVcKMezLSTy3BRzKvfLDMLQjnZ3IsZTtdpRpbVAmMwn7PDVt8Q+aJmlmb+s6uf3BjR7q
X-Google-Smtp-Source: AGHT+IFPtHO+U+hfSDkSoOkmowZhRO7citbEHLMZx0tIaudapfQghvW6tgSpLLBuhT/gfWZEbOcBFA==
X-Received: by 2002:a05:6512:238d:b0:579:ec3a:ada2 with SMTP id 2adb3069b0e04-582d092e4b4mr1134751e87.4.1758801593122;
        Thu, 25 Sep 2025 04:59:53 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5831665697esm675382e87.78.2025.09.25.04.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 04:59:52 -0700 (PDT)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: Saravana Kannan <saravanak@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pm@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sebin Francis <sebin.francis@ti.com>,
	Diederik de Haas <didi.debian@cknow.org>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Jon Hunter <jonathanh@nvidia.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] driver core: fw_devlink: Don't warn in fw_devlink_dev_sync_state()
Date: Thu, 25 Sep 2025 13:59:24 +0200
Message-ID: <20250925115924.188257-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Due to the wider deployment of the ->sync_state() support, for PM domains
for example, we are receiving reports about the messages that are being
logged in fw_devlink_dev_sync_state(). In particular as they are at the
warning level, which doesn't seem correct.

Even if it certainly is useful to know that the ->sync_state() condition
could not be met, there may be nothing wrong with it. For example, a driver
may be built as module and are still waiting to be initialized/probed.

Ideally these messages should be at the debug level, but since the
->sync_state() feature is under an ongoing deployment and the prints
provides valuable information, let's move to the info level for now.

Cc: Saravana Kannan <saravanak@google.com>
Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reported-by: Sebin Francis <sebin.francis@ti.com>
Reported-by: Diederik de Haas <didi.debian@cknow.org>
Reported-by: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index d22d6b23e758..97eab79c2f3b 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -1784,7 +1784,7 @@ static int fw_devlink_dev_sync_state(struct device *dev, void *data)
 		return 0;
 
 	if (fw_devlink_sync_state == FW_DEVLINK_SYNC_STATE_STRICT) {
-		dev_warn(sup, "sync_state() pending due to %s\n",
+		dev_info(sup, "sync_state() pending due to %s\n",
 			 dev_name(link->consumer));
 		return 0;
 	}
@@ -1792,7 +1792,7 @@ static int fw_devlink_dev_sync_state(struct device *dev, void *data)
 	if (!list_empty(&sup->links.defer_sync))
 		return 0;
 
-	dev_warn(sup, "Timed out. Forcing sync_state()\n");
+	dev_info(sup, "Timed out. Forcing sync_state()\n");
 	sup->state_synced = true;
 	get_device(sup);
 	list_add_tail(&sup->links.defer_sync, data);
-- 
2.43.0


