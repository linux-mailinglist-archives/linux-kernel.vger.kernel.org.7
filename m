Return-Path: <linux-kernel+bounces-844578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D5318BC2424
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 19:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C5474F2132
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 17:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1D42E8B69;
	Tue,  7 Oct 2025 17:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvfxaTtv"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6501D5ABA
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 17:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759858365; cv=none; b=iAn9mEdHr3+wx63ZDAO+pkMh5plHrcYvgFMtz2oKmod4oRuUvw2hEoksYA5nXwWPf7kkifMKRRMAUPtZy0zCvfBU9DPwSj1APIDNFF7nLC1wtrNOAUPXVyVgVK/OsI2yID4OZc13zvpY07+tjKgYQW7AIdPzndkEEofS09Rz1d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759858365; c=relaxed/simple;
	bh=E+aX5TOHEp/d3HJVpZn2bgZqwYp9dTDEPZHCmNXbvCw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YJrNfhX/MPTlMjQWf6fRbstx4GEp/gh2nQQKqJuvCFZK+EBa8NhP/LKRQiaIIvuyRrmV5A6uIyVwIvbv6LZ4YLyiR+5IEoxeumPKPoacBt7fM7fr59sm6Y6vkhgLpnzsHsxkHSr7pogAf5rqc2jW0HyqY+8yRwMIV+sp935dGzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DvfxaTtv; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7930132f59aso1077474b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 10:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759858362; x=1760463162; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X8ZpYVM0V4I1RihtN3wza324vQ8Dd1czFpMPPhquAHA=;
        b=DvfxaTtv5unexpVlCHVdzbCGmcG9xoMWHRo1rC8VIsLC/7wyGXhHX0fdiTkEGq2UlR
         SMRHWVOHgeSFQXHDGrrVTA+ybKpkT4sIIssaCjnESDyxcuCmh4kcwVAVB7zpYtc2eloE
         OBv+cvEd2pjeoN0+o53Xx3tSx5eGQUtwXuI/5enGaqZd0PiTXcKtW8s3Jha7dLo/uzu4
         oqEaeMOzuatWyxkW1Jd4r7lHbtNT168rnMCdaUZ8ge1bHyABGjpGSdpvunZyfvAPvS1r
         SqqQYtD2mwsK2RGa/6hy8ci+AZVzcjfmIRVSPwmlqwCOaMFiami6GCBDGajry84AK72R
         Tywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759858362; x=1760463162;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X8ZpYVM0V4I1RihtN3wza324vQ8Dd1czFpMPPhquAHA=;
        b=BdhJn6905etVX88fM6FIdCYmiBirAkWpWqaMCCe+Ss0k/dATWyTsnmf8iFL1w48oI5
         LmXK8FDDDqSxJN/YV+L2lcoQVh8jEwnaFZ9OKVfrhPlmYfMFkiuPRiJUeZJEv/pHClw7
         BLkp1iWTTyrsTmJFuk6796GmC4ltBoIRQ5k49nisowo07vk7hc7K84gMm+RlqhN9RzPA
         Eu5m4C+Kh/EyI6uHdUKc4QpJ1137bsOIIAueljXCZQ2tMpHDTLj0FG52X+4yOA/YgAZR
         SiJAT//9/I9RqboQ/us9oilm86dGKH3ANuwKAzjWyXarBHXlVqNII0gNjrM/PnUIGUHd
         wPDw==
X-Forwarded-Encrypted: i=1; AJvYcCX6HQw5rg8hUxPRmHnJtajlZb+zUa2LWUS//9et+eiD/8INAJCZU/MHMXOdz/rGj+HG48Q8GTLLMM+Zxds=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3Be54/tmbzdBh1odYXOdX4cc4UbprN2r83oJD35nMD0kv+6O+
	H1VZNb0yA5VzujTuYwY8cf038gel3Myv0IErCAiPxZU10PJQldbrTHuZ
X-Gm-Gg: ASbGncuT3pFbUAoYfYH0ELeqGZ9rD1tk6JNdAfugtXfzxUWYm8O8HQv3T8eL4GITiyj
	/eyiNuTUCiAymUJ2nziO3PTbnPkfVvOIE8wucDWCtLBpJYSmIEqm8ZXgq+oeSw+IkoBy9bsVpb/
	s4VLA7zC9D/wdS4Pp6l/ddZ31qplcFxvUKx2bfvgJcbUDd/fzRRHM84vx0eOcC/tfTuEexlfxMQ
	A+I97cHdziAN6EMvjV/TzonfsZkxdcAXoshZ/PpI5HeDGUFp/0nDQAK5fXxDFP1IEqC4x6Q8PIi
	FmQ2Xh4J0SAiifw1Ztv4w4xvGR2/TxADZRwywd8pNQohlaOJomHlL4znxlVq7rV+qQgKwcriAhl
	IJFMxLVTFkTt/h+Iqqw1fAWBBNWAFR0qAwhHJRCdfji1rkuQ2sx3b0dre5I8tsmTR5YV1O9shqg
	==
X-Google-Smtp-Source: AGHT+IExWMmFTXnDVcbabTZSsSq9hWpU8JqdDhoWXYn31Lw8poGbxgJvYey6hOLOtatkbJuCV9+qNw==
X-Received: by 2002:a05:6a00:23c1:b0:77c:6621:6168 with SMTP id d2e1a72fcca58-79387e05457mr328770b3a.30.1759858362279;
        Tue, 07 Oct 2025 10:32:42 -0700 (PDT)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01fb288asm16271240b3a.30.2025.10.07.10.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 10:32:42 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	syzbot+f02665daa2abeef4a947@syzkaller.appspotmail.com,
	Clemens Ladisch <clemens@ladisch.de>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH 6.12.y 6.6.y 6.1.y 5.15.y 5.10.y 5.4.y] ALSA: usb-audio: fix race condition to UAF in snd_usbmidi_free
Date: Wed,  8 Oct 2025 02:31:34 +0900
Message-Id: <20251007173134.440372-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeongjun Park <aha310510@gmail.com>

[ Upstream commit 9f2c0ac1423d5f267e7f1d1940780fc764b0fee3 ]

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
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/midi.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index c3de2b137435..461e183680da 100644
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

