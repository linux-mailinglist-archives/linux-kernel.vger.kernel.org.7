Return-Path: <linux-kernel+bounces-796379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B83B3FFEA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 14:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C04555E3258
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 12:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CA1302CA4;
	Tue,  2 Sep 2025 12:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPbbPB5i"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96933019BA;
	Tue,  2 Sep 2025 12:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756814850; cv=none; b=tpatGmUShmvXDtAqYPbyCIgoDJe38JEykmOwLP/Ggd49UpSaub+KU7Gw1UKzBvYMxCS2Eh5V5zQWIT+rEoX34l+iVi0LndlVI0N5REuiZthJ09kJ+5NkO/LvPKSln6iefbFsPhkxQjsAUgwoAAtIrQOJUD5RCZPJ2S/NiQgL4Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756814850; c=relaxed/simple;
	bh=REVUoomLAJZclmtWiP2XudXja6GJhV9CKjtUpJ+tR9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=njb1QeNQINEhJmCQdSu9/eryFF0InkNobAChLzpG+b/cexzdcuxlax45udLix0bBGaeu6024FU5CwJeVkYY28g8Z4pdvPqOlVw90vGpKtt8AVpQwZM7LWIf4D1tXnTC0GHrbPbSYlHB4hec2aRDpT00raOOsj/7YW1KpD4dTXXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CPbbPB5i; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3dae49b1293so335795f8f.1;
        Tue, 02 Sep 2025 05:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756814847; x=1757419647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yHi6esc6xWnHBFPt5kmv45QR9np7D0h5gaBaysBxNhw=;
        b=CPbbPB5iIq86NU539E7cYZ2SxAtxuEzYfleQkhA/2M7Cq4QSMovOg3TAQ0DdUeRaOm
         JeKses+zfTdoLEX7ziw/UUVRET6F1c8i3TLbWIJmTuFsGDwMF948OGd5pNk3OBtjdi8X
         4Of0astpWkY74hACjajmdbmCLNEgFNVq2to2/kX777Q6Aa+d65wgHzddGZmS75Y4h2cA
         CKOMgL3zxseSBpieOu1i9oHud43Thw9dBEOzUdmfAj9JSEOI4cbhzSNyZlSe8BcCEIuL
         MGphzjVYlPTDyChUCSdls6Bp4RpSeLmC228sxusD/vS2m5H4prQR6cVs/ZIO/AIbIhfm
         Z6wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756814847; x=1757419647;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yHi6esc6xWnHBFPt5kmv45QR9np7D0h5gaBaysBxNhw=;
        b=Ey1JUprvenBo9yB+j9VHy4zPkxYALSnYkpsoddN2OwiVA3wAsIqd7fZUSI68p+ukmp
         wab0PG0KEKjfkeuIa74dMYKeGAMJ4bjzTHMG5OG5E0f55pHYXTF1sjpeA1lZxfs+F8ae
         G0MLfcNW31ximGBJdyNt6IHthCeLGZc3JRmq2ZJKpn0bO55CQssMtHDFDneP3ooTkJpW
         vNXWAisJe2g2osFpevuxY/I/sYLF8uGrGN8u+uDXTQMh7fcGfchCNwiNtmrjzISznWOr
         e7sa/j4gk4iLL5dB+GujS7sRSdqqPbT5E4reUZM1CuFQYLATvOOtk99+oDHYKGUBRcC4
         EYJA==
X-Forwarded-Encrypted: i=1; AJvYcCWoS5kalyOGdhUKR/RYqOfU8bQsj6ai/HlHJCsYxCGruDnTSMwfG+MSjSd59tpoKqqx0dp1rwY90oxWqyk=@vger.kernel.org, AJvYcCXwqXEZiL5g0qZr+J3PN80J5WS+h4wDC10Pw2FXyskOHcvo2W6VE1qUIkjyBrV/fWpuQWoFVKgqQ+emZjo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/pg7jtemz6t+Ik0fLjTQLrf5c8P9ECc6ZMwsRl8lSXugfQ9WX
	ROBX6+JlwGYRH95nLmOS4hItCPgEWX+yPFUzgVSIaFUH3fJAlh90eOR0
X-Gm-Gg: ASbGncsGhbcTK+Sy2etljKZcqQnEbgcHjmO6kuTrotK5DEsorbwgqLwh02Yyfk55v/t
	ZRoy0eGGeCRMec0Q+IQ0iGDnq9XEq1jqIMCv0t0RTcbn0UYVnxnSNGuZ02bBVWb1pLHNitLFQf3
	Ccrpu+SvL1ff/heWrmgT2zx6IlAJ4x5ETguCFxu8AyXzDuADrsD1g7dyv6c06BG705VJ/S7Aj/I
	Gq5MFgbYInaLmOAnDdSseCeACGQRy0MF8lp5UdPmL32O7NcIazED4Odg1AtE0sMPnpqzAvdm1vH
	O3ckJFG3d6JWKjuHVh8308PrQQdidnO9cKKOu4Y3lyNoJWXlOsUTqrn5um605or2npubfQhr8tz
	59/349mEk1KSjCoZ9ek/d
X-Google-Smtp-Source: AGHT+IEC1qGVZIGdFWWUaDmFj3WEpMRuFaZo0xUy7X1JITS1B2cpohTDvt28I9fETEUvVtQ2zjiNXA==
X-Received: by 2002:a05:6000:1a8a:b0:3c7:308e:4dff with SMTP id ffacd0b85a97d-3d1e07a9d97mr7395781f8f.57.1756814846650;
        Tue, 02 Sep 2025 05:07:26 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3d701622b92sm8136088f8f.58.2025.09.02.05.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 05:07:25 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Keyon Jie <yang.jie@linux.intel.com>,
	sound-open-firmware@alsa-project.org,
	linux-sound@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] ASoC: SOF: Intel: hda-stream: Fix incorrect variable used in error message
Date: Tue,  2 Sep 2025 13:06:39 +0100
Message-ID: <20250902120639.2626861-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The dev_err message is reporting an error about capture streams however
it is using the incorrect variable num_playback instead of num_capture.
Fix this by using the correct variable num_capture.

Fixes: a1d1e266b445 ("ASoC: SOF: Intel: Add Intel specific HDA stream operations")
Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 sound/soc/sof/intel/hda-stream.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sof/intel/hda-stream.c b/sound/soc/sof/intel/hda-stream.c
index aa6b0247d5c9..a34f472ef175 100644
--- a/sound/soc/sof/intel/hda-stream.c
+++ b/sound/soc/sof/intel/hda-stream.c
@@ -890,7 +890,7 @@ int hda_dsp_stream_init(struct snd_sof_dev *sdev)
 
 	if (num_capture >= SOF_HDA_CAPTURE_STREAMS) {
 		dev_err(sdev->dev, "error: too many capture streams %d\n",
-			num_playback);
+			num_capture);
 		return -EINVAL;
 	}
 
-- 
2.51.0


