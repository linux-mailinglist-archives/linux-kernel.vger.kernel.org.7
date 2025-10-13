Return-Path: <linux-kernel+bounces-850124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 34742BD1F10
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CF28B4EE32D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 08:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4401A2EC097;
	Mon, 13 Oct 2025 08:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="SXHEWoqU"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02B12EBDE5
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 08:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760342962; cv=pass; b=folCZWksWmj17Xv2ZH6rv50DaJz87qLXWLNjDvs8tpfyuGeI3NZePMfFoYCzfD++r+4h5E589UAEyEffwrXIMeOlYEtXWRqqgY2wVmY8lHgYrOmo4e2mMyuyuLVqQywLeCYOn/B2jYC/wQpy/EgCsfU0M/PvGcEhmCcqxwDqSdk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760342962; c=relaxed/simple;
	bh=y0pyW1zRhKLOFmwinZkSWq2cB0ah/Nqq69DUfBcEk6s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=W4w83TJnX7bqnPQeavL+Lg2fPwkfh7dtqEft1tIgFbK340rwKJtDsaI0RerCVg9jLc/20FS1xsjSBu5NYmFlm5/sHj+OGuuJGk9r3P/azLP8fgRPbqC+rmvUjF5aOBQJNuXX54r+GGPdfU9T0gr80NEckfRab167DKx1u5UlaUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=SXHEWoqU; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1760342947; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XtYIluVBt05d6VWLeeqyGlauf7EmfDvfIA1NMnXYEac85XGv6jy0zKx0CNxwMzkwMFC9JQnGUgArf/afT7x/NY3SdyD23gbpDIQMK9OTl10FEZ+62jW3w+fJhanyHAXJFR3gDRQttkm0E9eSY7JJCMDeIqO4yx0aoDGtqllkWeE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760342947; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=sdNXNRoS+5obGezYMX6in2BIt6z98naqeGeF7fAvmjM=; 
	b=HcVoYQ62292xKzqdt6s3a2slw7CXdQofAhBNEE2TRu+V3+g8sOgJPuKy00Dh5F73zgevbztoaTpmVdPAfJsQurTkNSniNOwV20nsTwwTCwl13/xnk+RYyyUNS99DgBZocie+Lheug2kpAGEmMxTWQVEm4QsA0lUldYl12PsrP/U=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760342947;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:To:To:Cc:Cc:Reply-To;
	bh=sdNXNRoS+5obGezYMX6in2BIt6z98naqeGeF7fAvmjM=;
	b=SXHEWoqUhpZhNrwLO0cW3JneA34qnVFjJhJQzqzaghhS6TDYo5P24LLstuHHngjy
	f/+R42qu1eY3Cd/HgJ4L9wpYF64GPS2LyU4xs/319HqCfJt2qPqsGnArksKxtV85Lzy
	8S9QVOYf5mptfy69uLm5S2NED0pNYzbQXv3ay92M=
Received: by mx.zohomail.com with SMTPS id 1760342945538119.53598149326228;
	Mon, 13 Oct 2025 01:09:05 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 13 Oct 2025 10:09:01 +0200
Subject: [PATCH] mailbox: mtk-gpueb: Add missing 'static' to mailbox ops
 struct
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-mt8196-gpueb-mbox-fix-v1-1-d7de0cb20c36@collabora.com>
X-B4-Tracking: v=1; b=H4sIAJyz7GgC/yWMQQ6DIBBFr0Jm3WlAKhGv0rgQOloWiAU0TYx37
 6Qu/uK95L8DCuVABXpxQKY9lJAWBnUT4N/jMhOGFzM0smmVVBpj7ZQ1OK8bOYwufXEKPDJey1Z
 b+5iAv2sm1v/uc7g402fjfL0kuLEQ+hRjqL3YzV11mL2C4Tx/WUB7m5QAAAA=
X-Change-ID: 20251013-mt8196-gpueb-mbox-fix-fe6c3053994f
To: Jassi Brar <jassisinghbrar@gmail.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Chia-I Wu <olvaffe@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, kernel@collabora.com, 
 kernel test robot <lkp@intel.com>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.14.3

mtk_gpueb_mbox_ops should be declared static. However, due to its const
nature, this specifier was missed, as it compiled fine without it and
with no warning by the compiler.

arc-linux-gcc (GCC) 12.5.0 doesn't seem to like it however, so add the
static to fix that.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202510100629.3nGvrhEU-lkp@intel.com/
Fixes: dbca0eabb821 ("mailbox: add MediaTek GPUEB IPI mailbox")
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/mailbox/mtk-gpueb-mailbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/mtk-gpueb-mailbox.c b/drivers/mailbox/mtk-gpueb-mailbox.c
index 925bcf21f650..f6d2beccd91b 100644
--- a/drivers/mailbox/mtk-gpueb-mailbox.c
+++ b/drivers/mailbox/mtk-gpueb-mailbox.c
@@ -200,7 +200,7 @@ static bool mtk_gpueb_mbox_last_tx_done(struct mbox_chan *chan)
 	return !(readl(ch->ebm->mbox_ctl + GPUEB_MBOX_CTL_TX_STS) & BIT(ch->num));
 }
 
-const struct mbox_chan_ops mtk_gpueb_mbox_ops = {
+static const struct mbox_chan_ops mtk_gpueb_mbox_ops = {
 	.send_data = mtk_gpueb_mbox_send_data,
 	.startup = mtk_gpueb_mbox_startup,
 	.shutdown = mtk_gpueb_mbox_shutdown,

---
base-commit: cb6649f6217c0331b885cf787f1d175963e2a1d2
change-id: 20251013-mt8196-gpueb-mbox-fix-fe6c3053994f

Best regards,
-- 
Nicolas Frattaroli <nicolas.frattaroli@collabora.com>


