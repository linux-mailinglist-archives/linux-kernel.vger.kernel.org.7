Return-Path: <linux-kernel+bounces-835012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE17BA6097
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 16:28:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49FC13B2E2D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 14:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C79B92E1F0D;
	Sat, 27 Sep 2025 14:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T5cJW5fc"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE6B72626
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 14:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758983275; cv=none; b=bAwCbZdp5SAWDt+iz65wRbzguI0/XgI/y6+hxuDpZK144943iizDx95+mhk6v7PY9EHEipzgK8k5okUl69s1rLTrsMsXJt8nEMgTV8xrE0H9iXUi8AB6awBzu8kVHXqfAhxrFMMYSevZItegVzL6oDrULMSZz9t7JcVl/vwe4hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758983275; c=relaxed/simple;
	bh=dyfLKoOKESXQGOBuEAWWF56KSFk/HfpZmrrRYSKThgQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bbFu4SpKUM4SPZL8VXfLhOQE8r+IhBLmSdr7MuW9fI2BHLUS6lH9XgNEnzPGom9UwEzkz4q3Xyj25vsVNEeur9L7iqQ/Y+OFSSRlDyWYhfkhQyS8UWund/w43I/NVO9PpWXkBbYKZNZ70MIta6G7K9/T7SVh9epsTNltfk38W7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T5cJW5fc; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7811a02316bso1196650b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 07:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758983273; x=1759588073; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZTfdu2+eJIkTaagdZ2RGB8x/LpZGQuTYGyFSVUpM1KU=;
        b=T5cJW5fc8UY5gGyuBYHbpAX1c+OpTSJxdrb8CvHEo2yETgPkf1zFRRTyb3mFErxHSL
         sE5AG7veuUyNTBKRKYD+qUzQMTzGkBCO0dAlBQzsGOgEJrn2AKE8Rd1KnoFOXriXW35Z
         gbBarvuAuKe33jzdwGNVlB3B1g8zJl5Tnth3Ud4c/zL5+e4yL3SJ9W/xeTi0DzbFgfNV
         vyATnv/G+c2bcd+TwjPmTSBhhy7xZEPo8HoqWtQ8ejM0JdOVevB3lwFCRL23yF5XHS7U
         qhh28eJNerC9TNyvWHUsInO/0+ukPWLT8GBFWxUevJk5PeQsJc278sCTx0U2U817X6RC
         WvTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758983273; x=1759588073;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZTfdu2+eJIkTaagdZ2RGB8x/LpZGQuTYGyFSVUpM1KU=;
        b=iVrizZqq1CgFjPnUgY2h9pG1z99U+n8y0MI1Xb8Yg0v7XhcuvtbJ06w5Y6Puok7hd4
         5zv6xLe4/BbTDJz+2rj9Z0FKFFJIWyMjcFNTrHbQztdt93crwjkJZImjc/s/Xm8Smg6Q
         jJa0/7YrSs+P8di7i/Q/2JG+xCmFBdFdJlk/6VAu/oobD5PDfP0WvhawbfFUuWxbCCph
         ykjyNUtWOMkj+nlEiHZvL2Ev0AjF9lo2iqEJd/9qlsGmmp8bHXHI7c9X7Q3fHJ0Ubt8X
         ma2a6ytknG04Z9cSQ0Tywr+X8f/QKD69Myg8y5EfZEEpQM0Xb/qyCLsgjBRNuyPIpdwZ
         KR7A==
X-Forwarded-Encrypted: i=1; AJvYcCWemGaSveifawWV85GcI8FiJP9ipdmsqNDQzABBlOk30SB/tDyfQJ7b29tjo/l7KaWR1Tqj3LFMdoaXYgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YykdjGegBD4QtLDhbHz7lF1/fTRWwju5VmTP+0IAXgcjLVnO267
	zsMtm8hebRcQwV2LFJbLexYHKG+QYbK8gloolpWNHZt0L/xQeKQVLAtF
X-Gm-Gg: ASbGnctBlLTHJdrRdjflkWypIImdJ8FIqf+DN604EaggX/320MX1LMUyA1um2v/j8eU
	eEM1fjIUBL6XXDUFn/Ee5DnEeBIj2k8aUPqb3MQqBeiynt4z8WaLxVRzhaakJrKx5DA3MOiJE5a
	W5edWdtkCI3Kzz2hLJI7lg7+br9UU3Lp1aq5TmxCpYkdEGOTQeupKzD982HDlJhoMm00M3mt9/u
	yfSko40Kga7fBJXUpm5IQD2mIf0IVVpZLhi/EoavI5jHYNDqjjPsgX0QsmLOV7X3NU52B83gvVx
	Rjz7bWacr0ZQCL9a8XiidJArVA2haU3KlqBvgb8L35rf8Vd3OyyeQXbdYsQoNVnng99b3e3j/jT
	OJfCV5xcVVH0u9B8weVhVlycbsWhTxFAp2AkxAljLLVg6PLai9kacdqaRUWLMZwms73WkzQiO5P
	tZmspkZMXBHZf78g/HzGs9AWll4Or1J8HqHgke
X-Google-Smtp-Source: AGHT+IHBP8XuwQgYURmKK2+h9LjcrKEDXnmVoUNMqIkUJdAbSAeUJqkk1fQ3Bu3iJRwAImHmhVb/Aw==
X-Received: by 2002:a05:6a00:2d20:b0:781:1784:6dad with SMTP id d2e1a72fcca58-78117846eeemr7207361b3a.24.1758983273056;
        Sat, 27 Sep 2025 07:27:53 -0700 (PDT)
Received: from crl-3.node2.local ([125.63.65.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78102c06b0dsm6730028b3a.82.2025.09.27.07.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 07:27:52 -0700 (PDT)
From: Kriish Sharma <kriish.sharma2006@gmail.com>
To: Vinod Koul <vkoul@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Alexey Klimov <alexey.klimov@linaro.org>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kriish Sharma <kriish.sharma2006@gmail.com>
Subject: [PATCH v2] ALSA: compress: document 'chan_map' member in snd_dec_opus
Date: Sat, 27 Sep 2025 14:27:08 +0000
Message-Id: <20250927142708.1097601-1-kriish.sharma2006@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When building kernel docs, the following warning appeared:

  WARNING: ./include/uapi/sound/compress_params.h:364
  struct member 'chan_map' not described in 'snd_dec_opus'

The inline struct 'snd_dec_opus_ch_map' inside 'snd_dec_opus' was not
properly documented. This patch documents the 'chan_map' member and its
fields (stream_count, coupled_count, channel_map), resolving the warning.

Fixes: 5d36370f3431 ("ALSA: compress: add raw opus codec define and opus decoder structs")
Suggested-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Kriish Sharma <kriish.sharma2006@gmail.com>

v2:
  - Use proper subject prefix ("ALSA: compress: ...")
  - Add Fixes tag for the commit that introduced snd_dec_opus
  - Add Suggested-by tag (Bagas Sanjaya)

---
 include/uapi/sound/compress_params.h | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/include/uapi/sound/compress_params.h b/include/uapi/sound/compress_params.h
index faf4fa911f7f..d7db6b4e1166 100644
--- a/include/uapi/sound/compress_params.h
+++ b/include/uapi/sound/compress_params.h
@@ -336,16 +336,14 @@ struct snd_dec_ape {
  * @mapping_family: Order and meaning of output channels. Only values 0 and 1
  * are expected; values 2..255 are not recommended for playback.
  *
- * Optional channel mapping table. Describes mapping of opus streams to decoded
- * channels.
- * @struct snd_dec_opus_ch_map
- *	@stream_count: Number of streams encoded in each Ogg packet.
- *	@coupled_count: Number of streams whose decoders are used for two
- *		channels.
- *	@channel_map: describes which decoded channel to be used for each one.
- *		See RFC doc for details.
- *		This supports only mapping families 0 and 1, therefore max
- *		number of channels is 8.
+ * @chan_map: Optional channel mapping table. Describes mapping of opus streams
+ *            to decoded channels. Fields:
+ * @chan_map.stream_count: Number of streams encoded in each Ogg packet.
+ * @chan_map.coupled_count: Number of streams whose decoders are used
+ *                          for two channels.
+ * @chan_map.channel_map: Which decoded channel to be used for each one.
+ *                        Supports only mapping families 0 and 1,
+ *                        max number of channels is 8.
  *
  * These options were extracted from RFC7845 Section 5.
  */
-- 
2.34.1


