Return-Path: <linux-kernel+bounces-892492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA26C45335
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 08:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C2634E8322
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 07:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912E22EBB88;
	Mon, 10 Nov 2025 07:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="U0oF0TZy"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E92828850E;
	Mon, 10 Nov 2025 07:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762759487; cv=none; b=oWEB5eI/P9FrIH0kWnn++IkdLPA9X6Xxd8ijxW8CBI/PmhFJ1vK4vYgQkbzNlF0nb7qFQ0w+VK6PlhZuTzU9hTT9Tp/LOX14GnK91Vn4qYQ9YXdPCFqJWw1ohzHv1US74YEeHWclVbkXSCddUdds7qlyBNp4Xc6IExc9QQ4MPxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762759487; c=relaxed/simple;
	bh=9PjwI5gHc3jzC5YILZObX8zyIIDATakeitZnEoZPEV4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gMyDQqYL8WAWCJ1Rew1WopBRUJSMnjCk7SAsxL/lSSSaYOrXIzPBOD735iqL1zwVYdgF71KLsiVDZTDDJC9TS0NR54uiu8Yxd/QzQGZYHkFNNg7ECijwjCzT4P12zxfVTStZ727pvtVag4FipLXdnXkWwWDq7X7jCTSR3KjsXGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=U0oF0TZy; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=gb
	Tl8SVcFIrhh7H7q4afRNJrfLQj4XvQ6GtKsnG8hHA=; b=U0oF0TZyztsSN/u7W+
	vYxistieOrd8omEbHfJM6OEIsdAyGpFL0zQ1LjhWoCl2e2YnrivDA50DWjxZqAhX
	/MxQV00uQVFdUGFvklOtSjv8eatCGWmMAnP8/tSWZMNXpdqWZj6Sc85UFlFVbb73
	UGyeMsg9eTHE2YssVSMns8i30=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wAXEGwGkxFpvtzsCQ--.243S2;
	Mon, 10 Nov 2025 15:23:53 +0800 (CST)
From: wangdich9700@163.com
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	cezary.rojewski@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	wangdicheng <wangdicheng@kylinos.cn>
Subject: [PATCH] ALSA: hda/realtek: Fix resource cleanup in alc_alloc_spec error path
Date: Mon, 10 Nov 2025 15:23:49 +0800
Message-Id: <20251110072349.102169-1-wangdich9700@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXEGwGkxFpvtzsCQ--.243S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cr1fCw1kCw4Utw4ktr48tFb_yoW8WrWrpr
	4Sg34rGasxGFy0yw1fJ3W7Za4rGa48WF4UWw1Yy3WfArnYqr4kJF1UuryjgF1xCrZ09ayY
	qr1Sq3y0k3y5Jr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j0LvtUUUUU=
X-CM-SenderInfo: pzdqwv5lfkmliqq6il2tof0z/1tbiRwkAT2kO8407RgABsk

From: wangdicheng <wangdicheng@kylinos.cn>

Ensure proper resource cleanup when alc_codec_rename_from_preset() fails
in alc_alloc_spec(). Currently, the error path only calls kfree(spec) but
does not:

1. Destroy the initialized coef_mutex mutex
2. Reset codec->spec to NULL, potentially leaving a dangling pointer

Signed-off-by: wangdicheng <wangdicheng@kylinos.cn>
---
 sound/hda/codecs/realtek/realtek.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/sound/hda/codecs/realtek/realtek.c b/sound/hda/codecs/realtek/realtek.c
index ca377a5adadb..9a358c072e50 100644
--- a/sound/hda/codecs/realtek/realtek.c
+++ b/sound/hda/codecs/realtek/realtek.c
@@ -1029,6 +1029,7 @@ int alc_alloc_spec(struct hda_codec *codec, hda_nid_t mixer_nid)
 {
 	struct alc_spec *spec = kzalloc(sizeof(*spec), GFP_KERNEL);
 	int err;
+	bool mutex_initialized = false;
 
 	if (!spec)
 		return -ENOMEM;
@@ -1040,14 +1041,22 @@ int alc_alloc_spec(struct hda_codec *codec, hda_nid_t mixer_nid)
 	/* FIXME: do we need this for all Realtek codec models? */
 	codec->spdif_status_reset = 1;
 	codec->forced_resume = 1;
+
 	mutex_init(&spec->coef_mutex);
 
 	err = alc_codec_rename_from_preset(codec);
 	if (err < 0) {
-		kfree(spec);
-		return err;
+		codec_err(codec, "Failed to rename codec: %d\n", err);
+		goto error;
 	}
 	return 0;
+
+error:
+	if (mutex_initialized)
+		mutex_destroy(&spec->coef_mutex);
+	codec->spec = NULL;
+	kfree(spec);
+	return err;
 }
 EXPORT_SYMBOL_NS_GPL(alc_alloc_spec, "SND_HDA_CODEC_REALTEK");
 
-- 
2.25.1


