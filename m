Return-Path: <linux-kernel+bounces-844042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A115BC0E1F
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 11:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6543C189F32E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 09:43:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23A22D6E51;
	Tue,  7 Oct 2025 09:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y7Abe05p"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C4E158874
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 09:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759830205; cv=none; b=h08m+cYLvHFtxSGahp/zU2+6Vw0aODwA7a8Qz9JKcolhzi1ymh977GU1hjS0wbf4aqzUjT4kfwlXFnyvB8zoEbJKOxjyN8Ka06ZPWBxVt18RTc4NO/+4B5Hsl+eDt6ppFlKl+eEbGxys+0FVdME1v3ILVhACTlKNPpRGdPU8rtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759830205; c=relaxed/simple;
	bh=c6HwI8L1IlpZvsCzHGuSxeQ3GszR4eLOsRtO5jFSI+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E/NKt7MigE/aDY+p4qfUBXUGyIO6jwHUXvPWrQHjAFPsssXhpOZTj+S05FHnkX2mnVSNDD6JSfBI8uuDrAWijUIwtel2FeQvfUiinC31LGHJylAkILRsnWS3jgu+T73MFHKjOAe0Kjs9PNOu2vw1vlrBRjlRIwAWUUaTdav+ags=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=y7Abe05p; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-36527ac0750so56951541fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 02:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1759830200; x=1760435000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hSmNQbC023YaXpseHaoEKu4/PJTwQxs0VDin5nInWZ8=;
        b=y7Abe05pFKOPzXObl7W5zVhChsWCXMj7Q9+K0WVRdS4jSpPe6l2DyFvhZmr3cKhtMT
         9SzZPXPVUO+CgVfmn4dOWvyHWsi3HDya4AEWtatzNfLKvPJPrpgUXaanTUJSilCm5afX
         rAsAzfHy7KRKGW0l9ihwgTXsrkMD+Vc2PWhuya4Y1QID/+9rC5p+PEzY7mX8hh8sTCPb
         9csC9oVcxCtYe+bQSPf0qeoOaBK8kvfqn6j71SiuPXAF4hStKUW3NBovakQ3nAU5BIJ0
         /b77+nzwllkrZ4UE2QoVXtA07JDwcf4vJid7dCLV0korrAW9/kze7ZRxeemsF1ROJZtt
         xUbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759830200; x=1760435000;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hSmNQbC023YaXpseHaoEKu4/PJTwQxs0VDin5nInWZ8=;
        b=kxWryfgstdpTnnX6tPK7aFYISgpWAqEmLmnw3HKH3F29a/qgiPFZKkeYRF/Sz+7TUA
         um6KzivG/dhDtFmQUZIJp5kRQMgrMq8Q8/E5p1e/0CYmlnZ/m5aUEhS37ShvvnL6+amQ
         ssCEcyJuft3qHcVjbRqTaE4+pErBEe0138+8tyFKlfrZQ56Qyr8Jq/weA9g5vm0u4OEP
         dw0Ssq2sJTmegsZ0OB5wZ1I0eeqRUuhgbMa+thhvWYtSaWBK+RGQ7pnvWn0gSKT+e0El
         Ee1R3caNZTKXkGxmWt5U/V9YrWkdLgGvfLcCHpJbWY++xjXTQza8+h4ntNiJVkV8A0WM
         fe4w==
X-Forwarded-Encrypted: i=1; AJvYcCX7fnVRD7ELul+pOuvh2v/c39hfzJv3TnDNaxWfWTKSjjKXWccX6VNjD40/TYelKN6jqTT2BOLMF74N/nQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLtLjstxqXuzWjbOFHVLpE23OwwoNczNUGySDW22lJL7T01ua2
	1BxQBQRmD5YW8or6WrPKS6znKNVQmYKENB9FoI315d0XkTHyy2zo2T81YlthEIKvK+k=
X-Gm-Gg: ASbGnctXJ5hNC7MOiWhKmI/gBfWNdOJxZHg4YCtpgIcjw1FEWY4+LfZpluizctzEoEy
	YRfKlf4koxXz02bOqr87jqTWw7FOPBlyiOVZY6SsJ5QtJVrZMKDzqEttU8VmvIcm8Fp1VKKd+Rm
	U2wyPzKQ2bWPsQHR2dzzsdH731XLO5nHGk4M0J8RASJd99S5P4qmib5JHlEEmCXN1qiDcmZrUlF
	ODcWQjmJEn7Px38egC0/YajcfYdQRpNCww599Pkxxf+qb/9pzMN2YC52rXppwlAM/+la8m6szcb
	flvRHgk25YWIhm6KxX5a9rsRcAdpejaGHUPdzbpXfKy9SGsZaYhSOzzenkZecrnh1jdOq4rdj63
	DdvHR9qx6OdUHeX65u/Cw3xAYCpA6NKcljiS11s3nTntE8/DIyFnwOLAiPrydOBCth9eEFjeym5
	EqLpm6U1nEa5RXvU6ERnzsoGD5
X-Google-Smtp-Source: AGHT+IHun025wmd/VNOXL9AvwM+T6Skk1T6ZSwLUE4guDBJ/m66mfRMTd3uDpjq7T4WB14NukVXiGg==
X-Received: by 2002:a05:651c:2222:b0:36d:3113:63ac with SMTP id 38308e7fff4ca-374c36c4a1emr49732751fa.7.1759830200228;
        Tue, 07 Oct 2025 02:43:20 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-178-174-189-39.A498.priv.bahnhof.se. [178.174.189.39])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-58b0112438fsm5940932e87.14.2025.10.07.02.43.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 02:43:19 -0700 (PDT)
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
Subject: [PATCH v2] driver core: fw_devlink: Don't warn about sync_state() pending
Date: Tue,  7 Oct 2025 11:43:12 +0200
Message-ID: <20251007094312.590819-1-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Due to the wider deployment of the ->sync_state() support, for PM domains
for example, we are receiving reports about the sync_state() pending
message that is being logged in fw_devlink_dev_sync_state(). In particular
as it's printed at the warning level, which is questionable.

Even if it certainly is useful to know that the ->sync_state() condition
could not be met, there may be nothing wrong with it. For example, a driver
may be built as module and are still waiting to be initialized/probed. For
this reason let's move to the info level for now.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reported-by: Sebin Francis <sebin.francis@ti.com>
Reported-by: Diederik de Haas <didi.debian@cknow.org>
Reported-by: Jon Hunter <jonathanh@nvidia.com>
Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v2:
	- Due to discussions on v1 and because the default Kconfig is to use the
	FW_DEVLINK_SYNC_STATE_STRICT, I suggest that for now it may be best to
	keep the warning level for the "Timed out.." print and only change the
	"sync_state pending..." message.

---
 drivers/base/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index d22d6b23e758..c62e428b95b0 100644
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
-- 
2.43.0


