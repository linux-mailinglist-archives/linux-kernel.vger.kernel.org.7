Return-Path: <linux-kernel+bounces-766508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1D6B24768
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 12:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69288722367
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 10:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1AD2F4A0A;
	Wed, 13 Aug 2025 10:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Zfu/jMNB"
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0502B2F3C11
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 10:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755081274; cv=none; b=B++7U4a7c7/5U4kyLHgNdvIxTap9XPlmgs3KKvp+DkwqCuKaxGXQ9SNqs4xToMUCUjCbmbGSxZ+slBTOP0qdycDuDebmaRkBWDKpNdkVZZP4P/Z4XZjnkJz1TqOnlCrF7TxgNuxkxWx1NwWMnamZ0kkvfSU/GuK2hkveNZ/o2Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755081274; c=relaxed/simple;
	bh=QXJYmvp9wTnfWapEMv31m/YZSzt1bIS663ZhNyaG61I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uB2GbNaJXDQPwippaBFuO8cMS8d3j2CEbIZIm4dYegeTxYhY/jPgjVMTwEA53oRe/Bfsq95u9r1+1M4SNrGmEsnQT3GKwixVj/9jeJ8IQoXJ8gZFtyt1jU2/Ph31V8EqMbnqj/cJLZce9JgD+5thS3fQz/0Y5zBuMss84sSBdno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Zfu/jMNB; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755081270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+08CHwlWRZjXBglaG84EamhIdGb2S4rweM3TvNniamM=;
	b=Zfu/jMNBmvtBR3uSfU1TufjdalJ4OMSpnDlD3jv0aUrH35FzZ2sQbicg4G2qZIv9DF4Sid
	onnfemZ6cu/fCJ7Qsy9eX/u47W7Kg+LMrkaMbAajEjoONjQzLrKrlQZO/FWxE130fYoYPa
	tlF8LszLzm2MV5s/SdHOltuDfRejcW0=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Wentao Liang <vulab@iscas.ac.cn>
Cc: Takashi Iwai <tiwai@suse.de>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: hda: Improve local variable data type in snd_hda_get_num_devices()
Date: Wed, 13 Aug 2025 12:34:16 +0200
Message-ID: <20250813103418.164110-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use 'int' instead of 'unsigned int' because the local variable 'parm'
can be negative.

While an unsigned integer is harmless in practice due to the implicit
type conversion, it's safer and more idiomatic to use a signed integer
to properly check for -1.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 sound/hda/common/codec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/hda/common/codec.c b/sound/hda/common/codec.c
index eb268d442201..cab479111603 100644
--- a/sound/hda/common/codec.c
+++ b/sound/hda/common/codec.c
@@ -300,7 +300,7 @@ EXPORT_SYMBOL_GPL(snd_hda_get_conn_index);
 unsigned int snd_hda_get_num_devices(struct hda_codec *codec, hda_nid_t nid)
 {
 	unsigned int wcaps = get_wcaps(codec, nid);
-	unsigned int parm;
+	int parm;
 
 	if (!codec->dp_mst || !(wcaps & AC_WCAP_DIGITAL) ||
 	    get_wcaps_type(wcaps) != AC_WID_PIN)
-- 
2.50.1


