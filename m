Return-Path: <linux-kernel+bounces-896265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B3DC4FFE4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 23:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 17F034E722A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 22:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2380A24728F;
	Tue, 11 Nov 2025 22:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="E+99C8yq"
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB40D26B75C
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 22:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762901270; cv=none; b=f2ZSrH8fFKlghLOVRKQ4z8dOgfQPO3Ex0inZoJDCTcnOfP6wlp9y/Mp8XvE9ILb6jVCT9qRcbbLulgw7TGxcr9Q5KX6IPaa13oOHwNJsCHGi5p5aUJIxc3YKMuAS7LyxfuQSWpiEm0u+XeABurDU4Rt5kqjFL6EikgCNjWImzK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762901270; c=relaxed/simple;
	bh=2P8c1aQuKfBDyu9QMt90TdukXfWtkr301qI8c6GFi5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tJd5KAdWAIQQMi2xlKYBq17EoRqL/6punty0aMatjwYIQ1k9N2D9iwwXy8buil95Ne3SYz/nL7IqJthXflCzPWFMo84g3VHtZDm26xwoYqq1a4ZuqYAZ0MCsjuafMru2KbFWhRuwRjKktT6cxWGTUE73wkfbFQPXvUIm9pzqHGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=E+99C8yq; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762901266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vu9Ap1A3kpxCFBsKY6SjgLxqf2YxfUvdNhcqB35dkhI=;
	b=E+99C8yqnnNxOEXXzP5L1httZTDRQP/pdJxR77mKCyAJnV6iiLDoY2F7XMkFSeLPqMYNok
	jGsphMbyr8ZCHjB93MnILTWNdvCxaMEKE8df44tXwYC7vuOUtHTgQMusoZyxl9Kll5kCfC
	+VEfC0sRG1SPGi+9nybcAJ2K1oA4xgY=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Cezary Rojewski <cezary.rojewski@intel.com>,
	Liam Girdwood <liam.r.girdwood@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ASoC: Intel: sst: Replace deprecated strcpy in sst_acpi_probe
Date: Tue, 11 Nov 2025 23:47:03 +0100
Message-ID: <20251111224706.87508-4-thorsten.blum@linux.dev>
In-Reply-To: <20251111224706.87508-2-thorsten.blum@linux.dev>
References: <20251111224706.87508-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strcpy() is deprecated; use the safer strscpy() instead.

Link: https://github.com/KSPP/linux/issues/88
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 sound/soc/intel/atom/sst/sst_acpi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index 257180630475..73624e1b138a 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -12,6 +12,7 @@
 #include <linux/fs.h>
 #include <linux/interrupt.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 #include <linux/io.h>
 #include <linux/platform_device.h>
 #include <linux/firmware.h>
@@ -356,7 +357,7 @@ static int sst_acpi_probe(struct platform_device *pdev)
 
 	/* Fill sst platform data */
 	ctx->pdata = pdata;
-	strcpy(ctx->firmware_name, mach->fw_filename);
+	strscpy(ctx->firmware_name, mach->fw_filename);
 
 	ret = sst_platform_get_resources(ctx);
 	if (ret)
-- 
2.51.1


