Return-Path: <linux-kernel+bounces-835049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 48503BA6224
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 19:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E8F954E0364
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 17:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97299226D14;
	Sat, 27 Sep 2025 17:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0JjEyKB"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4DE1DE89A
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 17:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758994790; cv=none; b=csvEHeRKnjQWnfjJcTYBTE1PBjeMmsdAfrLurEfbaHbhv4rfWO9Qus2PM12Mv/QjWhe43kY1lCdY1GCDdSbxVGHkT2bkAiTUZeb/WLjv5yNOY0OdDDzsSNkoa7obuoP7TtnWhaFZXEgz35yr08UtRVivkKOHEqtDqwJYbw4IevQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758994790; c=relaxed/simple;
	bh=CB9nqcr/wZx3sYbWSmMvdTfrkigS3UhAGNiP+5quUM8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DzhSFK3tlpSEjja7VZ6U5Vel5UYxp11FWCF1rX40B3pVKSwzzozOb6lndJ/ADEHLSkTBfkSid/rqyHc+pYggSEtEOBsH4iwN4IS09M37AtABViTNnPPUcnUVx3K0beR8w4Jb6o0YhHgA88XZ89hFI77Mj57bbzDeFYZIia6J3P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0JjEyKB; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3304dd2f119so2544558a91.2
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 10:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758994788; x=1759599588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZUqnN1F3bgHuD+82ry4kJwIftFdoS866ISrdw4jG2EM=;
        b=H0JjEyKBm4pbcFMcnKnklmj6wI4i7PHga5Kn7qd1VjKDFgEkRNo9nTI0/kA4HXMx6Z
         JgkBL8r2rssA165J+qPHsCpJaNbhBRYG3YmjrqL04stTG4J5F7oWwdf8qCQ6gnlV1Ul4
         WvNNiTRRg2D+aOi0crCD26owGoPzxpPAgBlA1alz5Fr9CJgdGnIpWGPlTFSp0TZr6T3H
         HCn6HxtepaFg+1BsaoIu9vR73KfTzqF2h3DjoIdABfPMt5kE96XWmUe0ueEFHUHZbyVr
         X1B4OigiEGxKK74deUmFqEJ061i30xyd1YCla+Vz3OnUVJPq51mDDSVDjW/ffhFWZunL
         Invw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758994788; x=1759599588;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZUqnN1F3bgHuD+82ry4kJwIftFdoS866ISrdw4jG2EM=;
        b=O/l4ceUtueZtsF8i9OR3FW5KwNihOKrVipvcAmDxw3iHltTthyZmzaE43NSFYvKxZh
         gJQspGmjyBXOLx/VyAp7OQ/cqGZHMpUaJEaJFlDSb9iLFq0jap2QNU1hqbNDMw0bySDx
         STapRioxmbA9p0DqdSX/JbHX6uEl/9mApBCDeGN96SHi928w0z+L8Q/m6IFrg22xHANZ
         mKNixoLcd9/xgKZNoXQ5/k1oIhV9lOPCedWXqG0BIg6pQE8nQYZt4HTViJng8wCUH+HD
         WFnfWSyWREsTWtfDk0789nZULDgZMTk++95zXAJPpsA/8NswmXudLVbh4kp/ttctYxdH
         F9lA==
X-Forwarded-Encrypted: i=1; AJvYcCWgXNP3gfaSgrsjb5XbHjLNs7iQDGPEKVnaXLEI9r8JX676L/WNu4VjUEQAhfMkTbSvSCfe+jHoMUIjKgE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEZ4SVYLyaQTJy3cyRs6VuY70uOoTMWvNwdUMWpuhpF8LRnqlV
	1XMe5qaZO/4GcsFBKrouVJseWXj8qQTlHlk2Ypp0CpGXl9oyqJNtR5eY
X-Gm-Gg: ASbGnctmhMZsSnkvjcs1IxY2Wz898wEVWXsAosm28BGB1nWIFURKY3CkQEig8TBDWUV
	US7NYYUFecSKh8LfhI5sRAXWTFMs9pIW/HsuC0PeQAa1RpFfk6GX5jqZKVVrhJsgpCVgwVRMUBM
	3MVTHPCP2u586yLGA4/cGInOlI47fgZjOGUHFzL+tBTP6QvpxRxQw1eoW/O2FMroalj1I8HXD+P
	qDTjegullc+flHDnsQY8pX7EGhxNcFJ+9g5xkqvGSXjKeeLia+O+Jh0Fp5ZJekuwWMpX6If/x7Q
	YkHLBX/xAAKHKEqvJyLwIWdx9xEPGevLM9qOVfko1KeD79cXb+gWKqIsLNBCgIHK5fTNL+fAAiG
	XXn0GgeDxa8f+MqkWR4sjRt+kH+44h5z0OHru1od+YvQ8d7NU730rgPwZvyFT
X-Google-Smtp-Source: AGHT+IGtvJzCfxKqyh3P6VUpzcJjl7MCBE1zezF/b+a1T0k+e3+Zv5Rfcds1WIgUWSp6qGUOi5ossA==
X-Received: by 2002:a17:90b:1d92:b0:32e:d282:3672 with SMTP id 98e67ed59e1d1-3342a2c0fcemr11749970a91.23.1758994787774;
        Sat, 27 Sep 2025 10:39:47 -0700 (PDT)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3342a3cea96sm4377008a91.2.2025.09.27.10.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 10:39:47 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: clemens@ladisch.de,
	perex@perex.cz,
	tiwai@suse.com
Cc: hdanton@sina.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+f02665daa2abeef4a947@syzkaller.appspotmail.com,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH v2] ALSA: usb-audio: fix race condition to UAF in snd_usbmidi_free
Date: Sun, 28 Sep 2025 02:39:24 +0900
Message-Id: <20250927173924.889234-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The previous commit 0718a78f6a9f ("ALSA: usb-audio: Kill timer properly at
removal") patched a UAF issue caused by the error timer.

However, because the error timer kill added in this patch occurs after the
endpoint delete, a race condition to UAF still occurs, albeit rarely.

Additionally, since kill-cleanup for urb is also missing, freed memory can
be accessed in interrupt context related to urb, which can cause UAF.

Therefore, to prevent this, error timer and urb must be killed before
freeing the heap memory.

Cc: <stable@vger.kernel.org>
Reported-by: syzbot+f02665daa2abeef4a947@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f02665daa2abeef4a947
Fixes: 0718a78f6a9f ("ALSA: usb-audio: Kill timer properly at removal")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 sound/usb/midi.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index acb3bf92857c..97e7e7662b12 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -1522,15 +1522,14 @@ static void snd_usbmidi_free(struct snd_usb_midi *umidi)
 {
 	int i;
 
+	if (!umidi->disconnected)
+		snd_usbmidi_disconnect(&umidi->list);
+
 	for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i) {
 		struct snd_usb_midi_endpoint *ep = &umidi->endpoints[i];
-		if (ep->out)
-			snd_usbmidi_out_endpoint_delete(ep->out);
-		if (ep->in)
-			snd_usbmidi_in_endpoint_delete(ep->in);
+		kfree(ep->out);
 	}
 	mutex_destroy(&umidi->mutex);
-	timer_shutdown_sync(&umidi->error_timer);
 	kfree(umidi);
 }
 
--

