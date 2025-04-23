Return-Path: <linux-kernel+bounces-615775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E543A9821C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 10:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2DE97AA169
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 08:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA9E284677;
	Wed, 23 Apr 2025 07:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="en5T9sv3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A53327465A;
	Wed, 23 Apr 2025 07:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745394932; cv=none; b=sEgckDODHVECKyFji3rx2D6AJe9h903YGHZELVDfbDobOlrnWUxNO/lS4A8D1bokvaZVt94bwOa0CBMgLn3wp98wptLEzhz9CSeSp2lYUIw3QUfTQy102W1ivzy/tbfmnnG3ICQzkSBq7UUI46RCEJ87VyH/5+SAwF8NEKsfG/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745394932; c=relaxed/simple;
	bh=cVxI83a5H3NBHRTkCPsUOKpoBtLBr5HobqXAAjYwo14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RLrvmbEgo0tfLy8ZzmFrQKBMnJVzSKBuNPmrBbq25OiYdXjGwCXNusnh66t9jrUBi5Oy/W5ttu93/MbYmuhKZ6iBJNkB/QDEe7AUbEaN39pUmFIHQyELFuuv+ClCyaC5ObmLxwkgeB4/Y0IoWhiZIh/12P4UojfrhE/uphJV93s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=en5T9sv3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AEDAC4CEEF;
	Wed, 23 Apr 2025 07:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745394932;
	bh=cVxI83a5H3NBHRTkCPsUOKpoBtLBr5HobqXAAjYwo14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=en5T9sv3f90xLk7QSt/JZ4RqBD0eC179RcJR8g2s3jorGigXUaWvKmtfxc01I6Qp+
	 lRT1mEmhFkMfrS3NwrbsNXMRg3z3pavgzusvlXvTsmu3vo29wlgp9657Gt84Wb5Ga1
	 UCz5lynaE9ML9vbpOzztRzUun4qTXJ1gQzaO52x+TMdUw25JdPHgLMu1gRY0LfbSUe
	 FTDmiRV6506e+BbmbjBq6sf3Ogstt5BCWCfRtnMh2L1y2slG9GmTOojztvsyclXvcf
	 lF7ih6QA09K652NNvjiyeXGf20KRt0GI1MbkweLvWSmYuoRNXqFXOFICKrR3CGmRxI
	 6/Td5+YmCqYYw==
From: Philipp Stanner <phasta@kernel.org>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Jaya Kumar <jayakumar.alsa@gmail.com>,
	Clemens Ladisch <clemens@ladisch.de>,
	Colin Ian King <colin.i.king@gmail.com>,
	Philipp Stanner <phasta@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Mark Brown <broonie@kernel.org>,
	liujing <liujing@cmss.chinamobile.com>,
	Andres Urian Florez <andres.emb.sys@gmail.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	David Rhodes <drhodes@opensource.cirrus.com>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 16/28] ALSA: trident: Use pure devres PCI
Date: Wed, 23 Apr 2025 09:53:34 +0200
Message-ID: <20250423075346.45907-17-phasta@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250423075346.45907-1-phasta@kernel.org>
References: <20250423075346.45907-1-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pci_request_regions() is a hybrid function which becomes managed if
pcim_enable_device() was called before. This hybrid nature is deprecated
and should not be used anymore.

In addition, the request function's name parameter should describe the
driver, not the device.

Replace pci_request_regions() with the always-managed function
pcim_request_all_regions().

Signed-off-by: Philipp Stanner <phasta@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/pci/trident/trident_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/trident/trident_main.c b/sound/pci/trident/trident_main.c
index 8039f445bee2..4e16b79d6584 100644
--- a/sound/pci/trident/trident_main.c
+++ b/sound/pci/trident/trident_main.c
@@ -3533,7 +3533,7 @@ int snd_trident_create(struct snd_card *card,
 	trident->midi_port = TRID_REG(trident, T4D_MPU401_BASE);
 	pci_set_master(pci);
 
-	err = pci_request_regions(pci, "Trident Audio");
+	err = pcim_request_all_regions(pci, "Trident Audio");
 	if (err < 0)
 		return err;
 	trident->port = pci_resource_start(pci, 0);
-- 
2.48.1


