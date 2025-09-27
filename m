Return-Path: <linux-kernel+bounces-834806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA6ABA5902
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 06:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 411FE1BC7D40
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 04:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAE9225A5B;
	Sat, 27 Sep 2025 04:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdVWnDfT"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434DE1925BC
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 04:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758948213; cv=none; b=pC0TsfMLujnKAyXN/m2hxAww/VX1dGV3e1OdRqlAfTER7DAWrV6jmM6GX1J9pZ5zqMjSBfBJOIGyyrvjiI/HVZ1InHmd90uM/nx20mGnqY1VWcd9Y7VzIqkNOipePcYD74dDX2qtG4woDIBN6SDaDsLrf/vL5AaRho3ndGwVt3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758948213; c=relaxed/simple;
	bh=e/qEH9tlcTF6ZGczycty+bDdjQIpv409fmI2gPtm0Aw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZiQ0I+4CSqVQZif6q4R+etDF4gZgtvQIKKM28qGO9GaDJheWDDcloHXlQIVU1JaFvTtkDBO3RjV+743Gf64IafAaFkziJF4eWsHQ138oPnkX1eYW2Z0nsVqfPhWVhSTw5KGS/f4p3OygaiL79QqidJYoTrCzgNel1EdEgS7DpHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdVWnDfT; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b593def09e3so349023a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 21:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758948211; x=1759553011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dKJeS2CDtsADQhZCOXcT1ATZiZ5XIcTlE4PH32ZdpZQ=;
        b=bdVWnDfTKkwfA3PIY4XJcMdK6xIWH50sbaDzbSlMWc8i2WUfj3GpYC+/KTAV2oKWOE
         32Jmlkxhf2araQqdwzYsIZJHmEPsHucKp88rT04Nfathu9AtyiPSOWmWpIat6U1FTegO
         YWpXuvGbry5Nmf9zJ8KaB13e/eflb5EdVZdbOY2HMP+VpzawwLkB/K5nNy7/56gGd4m0
         M+Nkj7fDHyWhxOTZ5ThqS8Sf9TnZNDBkVu/qOme/s3qao/h/eBHmHRpI0JxiMeik8a13
         OFJRGxAwn5Qm1nIJqiFC3/8sy90iHbpvMpufu+7Oy+2MnbGG+FTJWCeQUzbZYwF/tdsU
         HbFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758948211; x=1759553011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dKJeS2CDtsADQhZCOXcT1ATZiZ5XIcTlE4PH32ZdpZQ=;
        b=a1cpBU/VOgdod6U69Q283jF7NihcKwqpYj7uJy9yJOSNQBHDQntH8YrCODKZlmFm0V
         aRJFXPqivAzAl5sVW6JYl0RVS36rqqGOfJg/brj5Nc+Sehzi8mlByDoyACfM5lKBRZeN
         9aEgvz/0Y2HyaGU8WOK39IbJeiq7hflO4OHsRRTwchYkUc/7uqeRUG0PdhWtrjxTOjSB
         2gxuY/yBDCgdgL15E8srVjRLMWRPWP0ReJSBMCW6WEzdZhqLyvL3Z9STRmlX5Z9r/Uxm
         /2/e1Z+iZJ4AfNIsjlzyoZBZQyKl6pracca7hqtKPgjPX6NCNE8RZ7EjnQfvULW7gjtc
         WtTw==
X-Forwarded-Encrypted: i=1; AJvYcCXzX5nqxSMz6gV+9CgqHb3fSybCH69+M4HB1OOOrG2Q+1ZQ/AnhnSGV0xQz7GXJDwQomTIlj8p86XoqcOA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7dpov/p0ExxDiRINbwjMxbTKZmcqzcPtqaG6ECyFPHHXOXMDu
	WLB+k/1vq4bTCbqGFaD1NoghQmDUM2TtI+QKpI4NqgPfpfffYUymXG+K
X-Gm-Gg: ASbGncts1K8b5tZpafVcNWWDnbpHfSLHlEsGzRQsVjGdHuwOeWOK323Ctljt8uB5yGl
	14IDoB2kOmu/jLtZRoSvgUw5lSeXTaF7G2Qn8Hqzg7IJQhtD9abz6Ls5ljnjy32UH6xu1mB+c8H
	fL6X28jDgJuo7svtY5Ta2MVmyErap8zmlfTDD+Y0Q4AzCAwonHT3wznz5vgI9ujm2T+8joT+Vau
	A9m4SoyzZEVLhnoZ6LZJFcbYojv+2DUmS2wkDLRU7MqNt5tJ18Gtz+FhmX4fCnj3xo8q7vxrKng
	RyH9YY3nQe/CWyOa2XHZbjq6OHg6eTGrKFdfdT16ghegTcXO1lQmKmwZ3pqO0zNjIXKMgtvwfDK
	pAW+XgrHNmzU6pCkI4mUl7713upxr+Vi72z2IjuLPbTvv/N6npCiZJT2sSCI5nlovpQRu9uc=
X-Google-Smtp-Source: AGHT+IEY3eTrZUiwTbercFWJQUAUjNTQOGASGgG4KnUUAungvsFhTUVY/HHdH4iilZbaAJZYw6rUQQ==
X-Received: by 2002:a17:903:41cf:b0:266:3098:666 with SMTP id d9443c01a7336-27ed4a2d5bamr96103885ad.32.1758948211465;
        Fri, 26 Sep 2025 21:43:31 -0700 (PDT)
Received: from name2965-Precision-7820-Tower.. ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed66f9257sm68318205ad.35.2025.09.26.21.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 21:43:31 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: clemens@ladisch.de,
	perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH] ALSA: usb-audio: fix race condition to UAF in snd_usbmidi_free
Date: Sat, 27 Sep 2025 13:41:06 +0900
Message-Id: <20250927044106.849247-1-aha310510@gmail.com>
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

Therefore, to prevent this, the error timer must be killed before freeing
the heap memory.

Cc: <stable@vger.kernel.org>
Fixes: 0718a78f6a9f ("ALSA: usb-audio: Kill timer properly at removal")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 sound/usb/midi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/usb/midi.c b/sound/usb/midi.c
index acb3bf92857c..8d15f1caa92b 100644
--- a/sound/usb/midi.c
+++ b/sound/usb/midi.c
@@ -1522,6 +1522,8 @@ static void snd_usbmidi_free(struct snd_usb_midi *umidi)
 {
 	int i;
 
+	timer_shutdown_sync(&umidi->error_timer);
+
 	for (i = 0; i < MIDI_MAX_ENDPOINTS; ++i) {
 		struct snd_usb_midi_endpoint *ep = &umidi->endpoints[i];
 		if (ep->out)
@@ -1530,7 +1532,6 @@ static void snd_usbmidi_free(struct snd_usb_midi *umidi)
 			snd_usbmidi_in_endpoint_delete(ep->in);
 	}
 	mutex_destroy(&umidi->mutex);
-	timer_shutdown_sync(&umidi->error_timer);
 	kfree(umidi);
 }
 
--

