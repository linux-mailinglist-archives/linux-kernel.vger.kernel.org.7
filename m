Return-Path: <linux-kernel+bounces-896264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 671EAC4FFE1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 23:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E18314E02B3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 22:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3997A263F30;
	Tue, 11 Nov 2025 22:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P2kIxoEu"
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692E663CB
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 22:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762901254; cv=none; b=FFWR4rlbmxVx/db33Rx4/exvXfH5eqb7GzJvynwHzR1H+YyL6e3vl+DVbra9erdg41vXFKOmLRkxe5GwW3MGP7IvVlGwfesTWduxUYQAOtjFsqLqJUs54Gj3fmblKi1wtcLeGfBfYC465wTJoTtBfgCw9DsCaBi+iX64gY9sgXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762901254; c=relaxed/simple;
	bh=T1zlvBTizWWLx1b9NGa0sy+D18UfFqWTOzQfia8zTBA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AfL1VrTWRCLASOQC/faTJJcHXydm2+ID15bslOUmOO2lLuxzygumjBfO3702rSeZBTQWnL2mgIBU0BxfA1b5cekXln3WJftMH9+0KAkT7CP2iUu6zSqN4J0xPXPGUvNMnwa3Gum4F+KJg8leSIG/nTLdjbmHvxqogO/Ae3H5l8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P2kIxoEu; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762901249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yjptLzCE3l7Flv0vKYe34mrtiOciiauwKDvgQUUWCqU=;
	b=P2kIxoEuLTUjpF5TwR+N8EYrXHN7JFtRLzY1fH0fhQ4mCdKdY9AfQicuY7FFDvyHVfK0yr
	bGPfi5azs0qhQEkFLZ9YSfh9c/54QmCtMwIaXdVV6q49eTdZ6SQOtlrOJNhVCS6Q0VKW/7
	oDN2+IpDV/WK1Xv//2C7Ky/eTvBuBIs=
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
	Takashi Iwai <tiwai@suse.com>,
	Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ASoC: Intel: atom: Replace deprecated strcpy in sst_slot_enum_info
Date: Tue, 11 Nov 2025 23:47:01 +0100
Message-ID: <20251111224706.87508-2-thorsten.blum@linux.dev>
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
 sound/soc/intel/atom/sst-atom-controls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/atom/sst-atom-controls.c b/sound/soc/intel/atom/sst-atom-controls.c
index 38116c758717..799d4f0881e3 100644
--- a/sound/soc/intel/atom/sst-atom-controls.c
+++ b/sound/soc/intel/atom/sst-atom-controls.c
@@ -142,7 +142,7 @@ static int sst_slot_enum_info(struct snd_kcontrol *kcontrol,
 
 	if (uinfo->value.enumerated.item > e->max - 1)
 		uinfo->value.enumerated.item = e->max - 1;
-	strcpy(uinfo->value.enumerated.name,
+	strscpy(uinfo->value.enumerated.name,
 		e->texts[uinfo->value.enumerated.item]);
 
 	return 0;
-- 
2.51.1


