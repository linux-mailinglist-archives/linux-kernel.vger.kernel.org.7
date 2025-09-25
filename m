Return-Path: <linux-kernel+bounces-832086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF697B9E4EC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 11:25:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7065C1BC56DA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 09:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC36E2EA49D;
	Thu, 25 Sep 2025 09:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEryQb0h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C802E9748;
	Thu, 25 Sep 2025 09:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758792320; cv=none; b=c2bvOL2UJd1jnQdTlwbOMqb93tnJuZyqyyifzZX67pDeUMWJA3Pokd6onlGFK/1bjLaWh6DOajo1UqaIwIiz9ypr5JPAHH2pKFva++6x0/CmAtlNtpXjuHNlRtppmmAjR38GOI58Ib5pnJ7ybZwPuetNukKP09DhG89CcOBYkTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758792320; c=relaxed/simple;
	bh=bkKlHZmNTjjUsP6ve1IT1avPrLEGebrhKHvE0YNEjvg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=eZKdbtyx3pni2BD7wVsA92Krc1vOxW9kVSWniUSsqUCfqH685fvLw3tugG8ovYiLUyOK12mEgEEXNWtP3eBZ13G8muz7Qf1ewNC9iPnXbL53UOrAyjymndGgKAiu6J4fDIfAcxRWRLwX9uZswzknmyKm5EkChx1NltRHBY9PMjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GEryQb0h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 15A4EC4CEF0;
	Thu, 25 Sep 2025 09:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758792320;
	bh=bkKlHZmNTjjUsP6ve1IT1avPrLEGebrhKHvE0YNEjvg=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=GEryQb0hZ/zr17+BEQiXepLmMQcSrTaqR4T8K2BrippVChyXKeZ+pSfoaYrMgE9tO
	 CoigYRcHUYP9/DOE/BCYrErEX9hj7NdooB3N0lvWRph6JKUAv9IBfmLYV7Qn9t751+
	 cA/Lh7O6m7+piuBZphLlMXLbTrmqI3UO7Q/wL0Ol3n7eX3MK6WerCqYwFNSqpZZaKH
	 OSDGIxJE6+4h3Y3hYD0whOLYVHo84OhC1mcAoaTEGTsdeFipVVUbz9Z0fCgdbohReV
	 rRGfdpgLf8TQECSjU+jqTh0A1Q80SjfGUT9At8cdnGERWj94mZnpEZQ1iJnBm+5p7S
	 tY3NKFgivAiRg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E6FCAC5B5;
	Thu, 25 Sep 2025 09:25:20 +0000 (UTC)
From: Cryolitia PukNgae via B4 Relay <devnull+cryolitia.uniontech.com@kernel.org>
Subject: [PATCH v5 0/4] ALSA: usb-audio: improve module param quirk_flags
Date: Thu, 25 Sep 2025 17:25:15 +0800
Message-Id: <20250925-sound-v5-0-2593586ff350@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHsK1WgC/23NTQ6CMBCG4auQrq1ph9+68h7GRZlOpQvBtEA0h
 LtbiCTEsPwmfd5OLJB3FNglmZin0QXXtXHkp4Rho9sHcWfiZiAgF0oKHrqhNVwriVWBCkytWXz
 78mTde+3c7nE3LvSd/6zZUS7XrQC/wii54IgKrVEWjJDXoY1/94TNGbsnWyojHEqIUkjSqYFS2
 aw+kulelptMo1RANamsBC30kcz2stpkFmUFaCsJqSkk/st5nr8qO3phTAEAAA==
X-Change-ID: 20250910-sound-a91c86c92dba
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: Mingcong Bai <jeffbai@aosc.io>, Kexy Biscuit <kexybiscuit@aosc.io>, 
 Nie Cheng <niecheng1@uniontech.com>, Zhan Jun <zhanjun@uniontech.com>, 
 Feng Yuan <fengyuan@uniontech.com>, qaqland <anguoli@uniontech.com>, 
 kernel@uniontech.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Cryolitia PukNgae <cryolitia@uniontech.com>, Takashi Iwai <tiwai@suse.de>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758792317; l=1719;
 i=cryolitia@uniontech.com; s=20250730; h=from:subject:message-id;
 bh=bkKlHZmNTjjUsP6ve1IT1avPrLEGebrhKHvE0YNEjvg=;
 b=92hFTPzzesPsn3sM0AmGSKXyf6F3fuqpt+UgLL9Xpwd3NHiDliMeK7+obnumMbruKcp05D2Bz
 0tTDDBqf33YBQyoAaEhGJ8XGnlaQjP0UzK7UTiIUOTp3KuTglsUOIJY
X-Developer-Key: i=cryolitia@uniontech.com; a=ed25519;
 pk=tZ+U+kQkT45GRGewbMSB4VPmvpD+KkHC/Wv3rMOn/PU=
X-Endpoint-Received: by B4 Relay for cryolitia@uniontech.com/20250730 with
 auth_id=474
X-Original-From: Cryolitia PukNgae <cryolitia@uniontech.com>
Reply-To: cryolitia@uniontech.com

As an implementation of what has been discussed previously[1].

1. https://lore.kernel.org/all/87h5xm5g7f.wl-tiwai@suse.de/

Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
---
Changes in v5:
- Apply review comments. Thanks a lot, Takashi Iwai!
- Link to v4: https://lore.kernel.org/r/20250918-sound-v4-0-82cf8123d61c@uniontech.com

Changes in v4:
- Split basic parse and dynamic change
- Drop usage of linked list
- Link to v3: https://lore.kernel.org/r/20250917-sound-v3-0-92ebe9472a0a@uniontech.com

Changes in v3:
- Instead of a new param, improve the existed one.
- Link to v2: https://lore.kernel.org/r/20250912-sound-v2-0-01ea3d279f4b@uniontech.com

Changes in v2:
- Cleaned up some internal rebase confusion, sorry for that
- Link to v1: https://lore.kernel.org/r/20250912-sound-v1-0-cc9cfd9f2d01@uniontech.com

---
Cryolitia PukNgae (4):
      ALSA: usb-audio: add two-way convert between name and bit for QUIRK_FLAG_*
      ALSA: usb-audio: improve module param quirk_flags
      ALSA: usb-audio: make param quirk_flags change-able in runtime
      ALSA: doc: add docs about improved quirk_flags in snd-usb-audio

 Documentation/sound/alsa-configuration.rst | 108 +++++++++++------
 sound/usb/card.c                           |  66 +++++++++--
 sound/usb/quirks.c                         | 179 ++++++++++++++++++++++++++++-
 sound/usb/quirks.h                         |  11 +-
 sound/usb/usbaudio.h                       |  84 +++++++++-----
 5 files changed, 376 insertions(+), 72 deletions(-)
---
base-commit: 4c421c40c8b30ab7aae1edc7f7e294fcd33fc186
change-id: 20250910-sound-a91c86c92dba

Best regards,
-- 
Cryolitia PukNgae <cryolitia@uniontech.com>



