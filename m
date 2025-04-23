Return-Path: <linux-kernel+bounces-615779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18605A98224
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 10:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44E823BD75B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Apr 2025 08:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285CC2857C7;
	Wed, 23 Apr 2025 07:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YtHnxn5P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878AD27056C;
	Wed, 23 Apr 2025 07:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745394955; cv=none; b=glqY57yLzoWsC8qJ0Hjz+wgjAIYdbXI3GXIyjMeUUT7d6370kvDjh+bVBIbbiKSa5T3ruqDpPGjVf/abyMTAe9xcVLrV1C5wOa6tN0K3mEpi1HEsFwTFlmWuN1cVAgwSR/eE8eHgw2rw4CFH8tqItp24hg90el0DSR1H+ls3Ais=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745394955; c=relaxed/simple;
	bh=QI9SJ6Qhx4A/06Soeoid2rgK4QHLZtZI13FnozHxHRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gwxvvmLw19UGzBaiTaMWTx4hDXz9PAlE1Ak2tM8XRXSNTDHId1IRX/WYoAuzAAVvqX4A158O04wDBmktchrM9q71EShRqZEfee8jkkB8MvOkhx1K7lIeqxJYXSD4WEV/uNWS1JlHmz/lc5nR3Tev4689GmEBr0N1ba55THVSsxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YtHnxn5P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C008CC4CEEA;
	Wed, 23 Apr 2025 07:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745394955;
	bh=QI9SJ6Qhx4A/06Soeoid2rgK4QHLZtZI13FnozHxHRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YtHnxn5P6K9s9t00m1Kze9DGrK8XahFwlalKKY4BvAkZ5nTBwwBxB8Q6GzAFaoYT6
	 fIxipIjTc7JzLLME1ZaqpaY6V8LQ6gL0sZa79BJ1Fag2tnicru9XCjhfXupxsSqP4g
	 RG/ntuDncgPQaOdxC11NbbEVaIzewcjezN6It/YwZGEQFLoBGjoagu3MfqamiDK9fH
	 KhK3I/GKqDt1lJKG4WmnVrZAJrbqAXCtKAtTn0V2eGE8vuAFItJaTsES219EhH+AyB
	 sRhIn0Hftq1qOhjo63wua+81JAYXNeT9vIm1GMaRBIErdOTp2r0YV4sh+ELOFfJXRJ
	 HKw901TM99J7w==
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
Subject: [PATCH v2 20/28] ALSA: nm256: Use pure devres PCI
Date: Wed, 23 Apr 2025 09:53:38 +0200
Message-ID: <20250423075346.45907-21-phasta@kernel.org>
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

Replace pci_request_regions() with the always-managed function
pcim_request_all_regions().

Signed-off-by: Philipp Stanner <phasta@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 sound/pci/nm256/nm256.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/nm256/nm256.c b/sound/pci/nm256/nm256.c
index 44085237fb44..cd4dc43dbff1 100644
--- a/sound/pci/nm256/nm256.c
+++ b/sound/pci/nm256/nm256.c
@@ -1447,7 +1447,7 @@ snd_nm256_create(struct snd_card *card, struct pci_dev *pci)
 	chip->buffer_addr = pci_resource_start(pci, 0);
 	chip->cport_addr = pci_resource_start(pci, 1);
 
-	err = pci_request_regions(pci, card->driver);
+	err = pcim_request_all_regions(pci, card->driver);
 	if (err < 0)
 		return err;
 
-- 
2.48.1


