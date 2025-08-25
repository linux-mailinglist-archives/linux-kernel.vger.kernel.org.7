Return-Path: <linux-kernel+bounces-784184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D963BB337BE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 09:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D5EB480FF7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 07:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2471C28B7CC;
	Mon, 25 Aug 2025 07:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YAx4wDEu"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD2452116E9;
	Mon, 25 Aug 2025 07:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756106770; cv=none; b=Q4Pr9jaKzpRozs4pqpLr4ZjHypoOv8EyIbVVMykeqm45p9pYbfppJlcM3xdBNLyIA4fupjHdnIzcyKPAlO+UFIz8eggorHQZdrRhWNVGmqlHbdnQ26NU6w5IzAg7ouLAt7FAqBeNrBibhWskN83uQxFY4f1qScjpXZa6qYRIj8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756106770; c=relaxed/simple;
	bh=9QK8KkIHKhcfQflDQb19Jjrs4UyawTA8XPgfVuRLJpI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PbpwJxKOIlJ6q/gQsLuBl+NuCv67/W3LCLWWg3PxxmJZXGARxIhPtajhyCJ9k0nHZlF016i0M/xxGwYuDJnMtYq4VUWLnq/Ib8zs1+Fsv39KtkEtq9+dMO+6/lS49wjdyv1tVh02uuRozuuWs7SAHUGGIgKlykpqVQpbNC33yis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YAx4wDEu; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-afcb7ace3baso724767466b.3;
        Mon, 25 Aug 2025 00:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756106767; x=1756711567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i83Ubiy7GBrk2qSsKCWz4m4ANjWjQBr67uBLa/oY6eA=;
        b=YAx4wDEu2WzJWpRwAF+UGdx/g1Us6+H25X/HIosKQo1zb/63dI1UrWdygZXfJ5m3jq
         e5rVT0cMQtwurThrZH6FCMN9aTYDVpUVIBxw6/ZVyEAxFIyfYA05hMyRHkTl/LPA67xu
         WTdYfalRJNggVqkN0hOj6xF94x6jmXpc+6oBUySfwrMIdJK/UJ873D17KlEvwo+zNPFO
         4TIdvhQx3Q1UKpTLMfhkFq5wCQ6AynTf8HpEcApqiOUWbovCaqV0MU0LZzYkmyukpHIb
         JaItPPlTsZANhZUyCAiQYD2XHsV2UIfS5C/Oj85zKRXOLQRWT/zbCc8/QOh1wVQPM8BX
         xLdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756106767; x=1756711567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i83Ubiy7GBrk2qSsKCWz4m4ANjWjQBr67uBLa/oY6eA=;
        b=LzeCBthy1p3ywvaBB6qXsFlHQ6+1bIAeDOeDOcnQOaX2wcgzI+Jn3rqtrnZii301Mu
         QNq8+RJ8V4Q1VPvFk+jTlYNP7S55pfefEhClWO0JlXbQW8NGISFytS3wkmTRuRtMwzg2
         1lahs9YlmK6SZys8CMrMiEqv4ttrS5O88g7gdJO04vCGmXIXKItr6KpUrlDFzV0wAum3
         DlUGAbRJi9lcfs1dYxQ2wa7NaaaAZuUvf/1TpmQQIirTFdhuqcBCzKR0HkOvWnHMSfhF
         kn2Lh0XwIfoD83YYRhkaUYED1D/ROKCpcFvNJtyqlfm02u6cjS8o/1rudU+/fUjLWLa0
         r79A==
X-Forwarded-Encrypted: i=1; AJvYcCWRN2hLZnd3xRdPFg9Lkmwmrj8Psl/p0yZiwLWNGJl6h/7HpeXmPNY8hWUOVabA8w51bSZn4ryRTiW7gtg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDdZXsOqCHqBSqyvZdRCdVW4mu8EJqlzmky0gcRlKAbbVqTsCv
	Xq+WN9+7Jrulop/Wk4TrJ8+wiszSSrz+fgSzW48N8kpnY8D+29GjxwQK
X-Gm-Gg: ASbGncuISs4ZL00uN0v02yzACSdqYQO5YrENJZcgoz9X5Mogou7UVaSPgzzMpm0+JjY
	2PIvcM5+J5rJewxkJoWfjtabj4tvpQuHPARzXGxD4NEuflcfsGuF56MkOTq50vAT0RWG9bX0Zgm
	iwmxUAMOgQ3U1yEGgj16Oz7vxRlDLllwnooWbprOYAj6O8JrT/fZb7xvXOUhZrBklkHiowF6omQ
	HEpMCJ3sT0+ukPr+n7ZLPTEgrRsR7WqfdGIwB7UHTGaAbZAcJ2p5yNVd4bOKULvCHOYJt+JhyhX
	2lgTchFKvHHsuLRE41V+F0IkaLIRGMni5eVHZ3m+l/4EFtetmjjotW/piacnYQ28bfXrUi+mphI
	UK7465tsU/4Ssq5oCspV9vSvDtS/rub3p5SLdoCiZ/6u/UWOPgNk47qseX8IX3q4x28jytMxPnL
	zxaGoRvKERvWMefkofDfOl1iwCmHYAp/4DO1yQzx2ziECE7oG1w3O2
X-Google-Smtp-Source: AGHT+IHOBqfH8kFoxiw1qNS6rxcwJYCmvvakLJPwx92KlOeYRXHGTrYIX2gTCyD/0BXBCwK+J/uU4w==
X-Received: by 2002:a17:906:3759:b0:afe:6881:79c1 with SMTP id a640c23a62f3a-afe68817d5bmr352521666b.35.1756106766822;
        Mon, 25 Aug 2025 00:26:06 -0700 (PDT)
Received: from localhost.localdomain (93-87-121-239.dynamic.isp.telekom.rs. [93.87.121.239])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afe7d5553c3sm178142966b.76.2025.08.25.00.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 00:26:06 -0700 (PDT)
From: =?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>
Subject: [PATCH] ALSA: usb-audio: us144mkii: Fixes for handshake, MIDI out and cleanup
Date: Mon, 25 Aug 2025 09:25:57 +0200
Message-ID: <20250825072557.7670-1-ramiserifpersia@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a handshake value of 0x32, which is required when the device
was previously used by another OS with the official drivers.

Correct the last byte of the MIDI output protocol to 0xe0.

Also, remove the unused DRIVER_VERSION macro.

Signed-off-by: Šerif Rami <ramiserifpersia@gmail.com>
---
 sound/usb/usx2y/us144mkii.c      | 2 +-
 sound/usb/usx2y/us144mkii.h      | 1 -
 sound/usb/usx2y/us144mkii_midi.c | 2 +-
 3 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/usb/usx2y/us144mkii.c b/sound/usb/usx2y/us144mkii.c
index 3127a3206..f6572a576 100644
--- a/sound/usb/usx2y/us144mkii.c
+++ b/sound/usb/usx2y/us144mkii.c
@@ -454,7 +454,7 @@ static int tascam_probe(struct usb_interface *intf,
 	}
 
 	if (handshake_buf[0] != 0x12 && handshake_buf[0] != 0x16 &&
-	    handshake_buf[0] != 0x30) {
+	    handshake_buf[0] != 0x30 && handshake_buf[0] != 0x32) {
 		dev_err(&dev->dev, "Unexpected handshake value: 0x%x\n",
 			handshake_buf[0]);
 		return -ENODEV;
diff --git a/sound/usb/usx2y/us144mkii.h b/sound/usb/usx2y/us144mkii.h
index ecc4c2fed..95c4341f0 100644
--- a/sound/usb/usx2y/us144mkii.h
+++ b/sound/usb/usx2y/us144mkii.h
@@ -15,7 +15,6 @@
 #include <sound/rawmidi.h>
 
 #define DRIVER_NAME "us144mkii"
-#define DRIVER_VERSION "1.7.6"
 
 /* --- USB Device Identification --- */
 #define USB_VID_TASCAM 0x0644
diff --git a/sound/usb/usx2y/us144mkii_midi.c b/sound/usb/usx2y/us144mkii_midi.c
index 08b04aa39..ed2afec2a 100644
--- a/sound/usb/usx2y/us144mkii_midi.c
+++ b/sound/usb/usx2y/us144mkii_midi.c
@@ -257,7 +257,7 @@ static void tascam_midi_out_work_handler(struct work_struct *work)
 			if (bytes_to_send < 9)
 				memset(buf + bytes_to_send, 0xfd,
 				       9 - bytes_to_send);
-			buf[8] = 0x00;
+			buf[8] = 0xe0;
 
 			set_bit(urb_index, &tascam->midi_out_urbs_in_flight);
 			urb->transfer_buffer_length = 9;
-- 
2.50.1


