Return-Path: <linux-kernel+bounces-760115-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D54B1E6BE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 12:47:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02B8216AA98
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 10:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED9023AB81;
	Fri,  8 Aug 2025 10:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qsb+8VRk"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B016D5695;
	Fri,  8 Aug 2025 10:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754650023; cv=none; b=e/Idt7Zsjt7l04F8EJbwF0Vwein81EXjOeDiAMAY95ddJCbg1NjBqTA20yLsyiOaColNIYeNMCQeI0OiPaE+APdIy8kTKD8OaxjXCY77+jXYbasFbgzsuXWe/1qrJNt8kbCXPTvBGjCSM5iCwNVpoJVSIK1/wXIjhn4D8YoD6zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754650023; c=relaxed/simple;
	bh=3ibipzUySSqHmtKXTWb4ha0TMTGI734ck1ABPHtXVpg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jo1b8+wE/djh13uav5wv4flcS+DoHJpiAmJsHgOADmplfmNxxp3zQHfbGPNvsu38G2uVBbAwfbp3r0pPNa0jMFjWtKfTO7Od0/rbcrTKvZyOwyaf9BiG6/BFleia3dSL4hlVerUTAbah57Q27RsTA2CJ5+Or5b06gAwp5CSwacI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qsb+8VRk; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3b8de6f7556so1052541f8f.1;
        Fri, 08 Aug 2025 03:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754650020; x=1755254820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9FTG6NMUrOc/WW0podSvrB6jKWxep/Y5whSGifB9nMY=;
        b=Qsb+8VRkpCNf9AtoVkKdy1FK/V7E3opyx45Cdjbn/heWk+gPU4Hq+6qstNVrmKZFTu
         cpOAzd+8nPK2Xb2+ek8cAA1u65KcwI2qotpwTlr8uuFy8ztVRdbCGUKbFS6rUg/rKNO7
         CmBmhJWxLbafy0uBuXvC8QlfbzJmtO1jlDiLyi+B97d46R9OS7C5vtFyd9g9KsqYG3mL
         rW8PRGR706Hxh+EjDhiXsytrQSUScNkTth3zheXKhJOhXSahxHnLxJm5lJ36oC0+2zYW
         8hW7Fchxp/2qOdujjBINHbkMzgeZYgZviuUDCG3CJbqrDK2RMDzzLyBu7BR71HBzhBFr
         cYIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754650020; x=1755254820;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9FTG6NMUrOc/WW0podSvrB6jKWxep/Y5whSGifB9nMY=;
        b=uYxw4QfigttdQ5YZuwYtl1l8d9LFQjL6P3YNN7qJXoQdvEIMsF8x7DI/63Jm+ZSmrZ
         XT1Sei4lQAR2Ia7IgBbvIo3jALW4UwzEvKADyNVEHw2q5HbigpYDOt8XrcvQxUTvDYpm
         YU2yntoLk8ZvKoUi4XJD4ABs07xAYQtSgy3biXwO8JF7f9YBoaoaE+OywUoUapfdR4aV
         g+8lHkO1aFGlZWLa1OYwGIp/QrKkKkjdgFbrasEpkKEMfEClyFISTR0rTe1ISTqRxOEd
         2f+WbAac+vZ8SEkffhLit3FrmOU/HDpLBq8dkpjaGtJ48HSH2cZ9wTzwyzCG44FzMORZ
         6Ecg==
X-Forwarded-Encrypted: i=1; AJvYcCUtnFWxFWnH93LyKUBrVA9snMLf7kpRmC5O1ZcDYI9Y1luGhyPYDvjfP7JvJvMDZRdBmQHInQ3Eu/ZU2Xw=@vger.kernel.org, AJvYcCWWjtlos3j1O0vRR8F4VAy5zX7Gmnv4M0sirp55NUzzcQ4KyipbnKNDnLWCZ2RuR4GiHaIb8gVmBlNIucM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwgqDAgHgE4TVYWNRScroSXdl1Hfkv1IF/a8hZOwDgE3kSc2qC
	L2e1w4U8nATc8zKaecDg3SDOqKifOb422KSlb2c6NfNZ7OeJk0XXGKjmYzCK5m0wcDXWmw==
X-Gm-Gg: ASbGncsrVZgcTb6HYQoSqTLAwGyGLY74EuL+MfN3XqbWaZBkvgDtOeXYqBcpALuJLrD
	0am3sY5AunRLCTPls6aEe6qm+brz8V7RYAzlx2rSYwqDQ5WZHx2rVOObWLyoOboeNae/GdZQ0Wp
	Pk87ZCzmK8Wc574O00FuahsULMgURaeJHdJxx+PfMHCMY7XujTTOTFMNMQmlto7ZsFpFw3UAdeb
	MEOQIFAJeZ6m2pNeQE6NPtI963Nrzxu4sJA5z8x+QyeXIH21nHKPPQWjvyTT3ogE/Y9hQ83sV7U
	t6YDtCENAwjZDhqJbSpjw/6DcWNB/lJmz/wn4hlPraoa4R2aNPMCMbZb0cwlxjdCKuGP5lQCGcT
	LOHbaYaI7nBl4VX8I5ssT
X-Google-Smtp-Source: AGHT+IEYUwqFOg/SdjZy3Bry6MSmnKWOEJY2K+fn9aIueqnuNBAKZ+hlmkh9LLEtXckFUPI6/qyInA==
X-Received: by 2002:a05:6000:290a:b0:3b8:fa8c:f1b3 with SMTP id ffacd0b85a97d-3b900b55f36mr2067409f8f.53.1754650019887;
        Fri, 08 Aug 2025 03:46:59 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b79c489e81sm30290727f8f.68.2025.08.08.03.46.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 03:46:59 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] ALSA: hda: Fix spelling mistake "dismatch" -> "mismatch"
Date: Fri,  8 Aug 2025 11:46:21 +0100
Message-ID: <20250808104621.829448-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake (or neologism of dis and match) in a
dev_err message. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 sound/hda/codecs/side-codecs/tas2781_hda_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
index 45ac5e41bd4f..e1d60da50897 100644
--- a/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
+++ b/sound/hda/codecs/side-codecs/tas2781_hda_i2c.c
@@ -356,7 +356,7 @@ static int tas2563_save_calibration(struct tas2781_hda *h)
 	}
 
 	if (cd->total_sz != offset) {
-		dev_err(p->dev, "%s: tot_size(%lu) and offset(%u) dismatch\n",
+		dev_err(p->dev, "%s: tot_size(%lu) and offset(%u) mismatch\n",
 			__func__, cd->total_sz, offset);
 		return -EINVAL;
 	}
-- 
2.50.1


