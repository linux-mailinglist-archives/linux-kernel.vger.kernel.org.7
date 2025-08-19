Return-Path: <linux-kernel+bounces-776362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C060B2CC6E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 20:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C83637B1B50
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 18:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D637631CA6A;
	Tue, 19 Aug 2025 18:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lU0I3Br4"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1D72EB851;
	Tue, 19 Aug 2025 18:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755629499; cv=none; b=iB8pA0PrG6GLI58AigwGmJNHO12LpLotYPZl2JVsA//kNSv93nnjlANhPu64FK4RL0mVmn9xmWFFT1G31cy5sKAXhOWpACy1g9VK7A4z7V9L08/lP2r9dowM+V4mS6FET3xyC3ZEZwIF4mk6vhFdCbFPhgZfjbiwslIbvO6UQ4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755629499; c=relaxed/simple;
	bh=glPXpSqU7EPo8oQAWr9g0aH+3EfAjj+J2Pat4S9P+D4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cAjBoA0Szf6o5EngVVSn9NRII8y12oco3e6fMgCYEaP0iVsmzoZO2AEXwwjlv175AONwDo3fv1DNv20kEImd1Nz8zLyQ6YprJIzk67iZj2HvxQOGtRT4rrCFkuFJeUNx/Qf+sNz/cgsdCn1P0PD0ntR6R/3yyEcwuIjHD/KhyC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lU0I3Br4; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afcb6856dfbso36210266b.1;
        Tue, 19 Aug 2025 11:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755629496; x=1756234296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Brn2kGl8u5LDFhY5EdF9T38fEAsVYfGMVQtXxcK82As=;
        b=lU0I3Br4mAz50QI319IdN/FDbLo9RmAx+eQy7mqRlESyJVtHTKydMe7Q55fX5MDmA3
         GPE9lPWD30z0gGTdlu+6x5ooKhlYAfu62HWRgSQTDorOwzDbtCyMp9mMFQd2fbQt7cvc
         oIFmsp8wLePyqRcxkk20PFI7y0rlg/n0Nmbbs5GY9KUtY1Dnix/gwuuB8sJDXhNXLjYu
         RMBO27eHmm8WA5I8zmPYUwGpGGLHP+t/eDAzCWrl3u6IHOMEyW2ZslSDPkj+q9lBQlYA
         CJUj/87wYYUJ1LSHn2CLPvPYRBKVCifN+RX8uEuYEx640dHtI90pMFRoV3U6PVvsbGo+
         MszA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755629496; x=1756234296;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Brn2kGl8u5LDFhY5EdF9T38fEAsVYfGMVQtXxcK82As=;
        b=KRNZuDqXHwAkJcFkNINl1AKvGUZVpJ/kjpOw9GN2sIFxinsAMxJR+WdHVGG2MhH2ri
         xH9wN9KhQFj15ruKxJbt3UDZtz6f8QNm8tnAfm4CGximZbN1y0oMhPIk4InIjSW5hfD8
         k51hyElXoVPxq+SUWBOfaHkXe7xpL8l6nAaVp5RTwbSdVevtesikOMi1LS8waGjenAZG
         Lrikoxb9mM6aFVeWAKh9cB716wfiFKS3TB91Bkpj9a426r8e9TMVghkFXbNNPlKXDCtu
         UlnWqNIcJYlNxwSqEUbRVTOrVusmfnvKlPW3Gp7TMuDINid9677q6Ujw8Bk+EMkPNgZU
         WPzw==
X-Forwarded-Encrypted: i=1; AJvYcCVL1dXyCdIqmTcuzNxTh4sA9+A/aS72KF5whYYKDAWbQLkH6D9hDV/kGMt7gkwxmJ/SRJLG2dWu7jFAtLI=@vger.kernel.org, AJvYcCX8vYkevDX6c2Fc+hi0CuajBPtn69sm6D6tWSiz+KlTvTURotzQjJMNZYktuIaBBx6VKd8db2d85NFhh0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgBgW8SmtKWxlcWJTtn/Lqk4FIWOx3uxXzg2utPCGRiZIW+8y6
	RoYaJ0vZVSRvWL0CruJ5905Tz2oZIF1JFsP2HgirQCWSbu7Be1AC94/X
X-Gm-Gg: ASbGncv6t0jWz3qHb2y2KaAfJbGD80f8vTsLE4BDGNuzsiTEb58hg3j8pqLkQr32qjK
	1QPonuIQI+8YIAIeBkCM449HU1oh656apT/lorZpQE67kwYGrXcVtfZz0KBf9oQsUYkJNCLsfFW
	AHwrhcBDK7dmc+S7EDnxPTucszW5vhLwfun8gcD7qOdyAu0V1vUmK7aiANHD+8+R6d3EG2255gt
	j8vIN8bXag2knhtGiSXwtmj5kw5uRJwhdJrBm9BCFPaF4lgkr/qNv5i5lBqw42GzRruf6TkxViA
	AhUEfpQ8OL3slXmLotfv7qTsQONHV0zBse+3w/C9L+FjaoSZKzHbzVHPdMk+bYZO5tymB/XGMaW
	JcmhKJiiUWrimnhxH5pF6N7dWbQBn9frcYwyTCGQGZXSpyDBdfjtBE6ECKNNoJBMHlBhv3u0t
X-Google-Smtp-Source: AGHT+IEUQ8ifV0sQoU+D+0TDRTQpfGI1s/Ii3IRk0I8Z0F/dNuUc0EYyeyOulHAwNPqHLlPnEvbyOw==
X-Received: by 2002:a17:907:d1b:b0:af9:6863:9d41 with SMTP id a640c23a62f3a-afddecf2db4mr361992366b.14.1755629495792;
        Tue, 19 Aug 2025 11:51:35 -0700 (PDT)
Received: from cachyos-x8664 (93-87-121-239.dynamic.isp.telekom.rs. [93.87.121.239])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded2fc568sm31584766b.38.2025.08.19.11.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 11:51:35 -0700 (PDT)
From: =?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>
To: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	=?UTF-8?q?=C5=A0erif=20Rami?= <ramiserifpersia@gmail.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	lkp@intel.com
Subject: [PATCH v2] ALSA: usb-audio: us144mkii: Fix null-deref in tascam_midi_in_urb_complete()
Date: Tue, 19 Aug 2025 20:51:33 +0200
Message-ID: <20250819185133.10464-1-ramiserifpersia@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changes in v2:
 - Removed duplicate call to usb_put_urb() on submission failure.
 - Removed extra blank line after the function.
 
The smatch tool reported a potential null pointer dereference in
tascam_midi_in_urb_complete(). The 'tascam' variable, derived from
'urb->context', was checked for nullity in one place, but dereferenced
without a check in several other places.

This patch fixes the issue by adding a null check at the beginning of
the function. If 'tascam' is null, the function now safely exits.
This prevents any potential crashes from null pointer dereferences.

It also fixes a latent bug where 'usb_put_urb()' could
be called twice for the same URB on submission failure, which would
lead to a use-after-free error.

Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202508192109.lcMrINK1-lkp@intel.com/
Signed-off-by: Šerif Rami <ramiserifpersia@gmail.com>
---
 sound/usb/usx2y/us144mkii_midi.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/usb/usx2y/us144mkii_midi.c b/sound/usb/usx2y/us144mkii_midi.c
index 5759f6010..08b04aa39 100644
--- a/sound/usb/usx2y/us144mkii_midi.c
+++ b/sound/usb/usx2y/us144mkii_midi.c
@@ -41,6 +41,9 @@ void tascam_midi_in_urb_complete(struct urb *urb)
 	struct tascam_card *tascam = urb->context;
 	int ret;
 
+	if (!tascam)
+		goto out;
+
 	if (urb->status) {
 		if (urb->status != -ENOENT && urb->status != -ECONNRESET &&
 		    urb->status != -ESHUTDOWN && urb->status != -EPROTO) {
@@ -51,7 +54,7 @@ void tascam_midi_in_urb_complete(struct urb *urb)
 		goto out;
 	}
 
-	if (tascam && atomic_read(&tascam->midi_in_active) &&
+	if (atomic_read(&tascam->midi_in_active) &&
 	    urb->actual_length > 0) {
 		kfifo_in_spinlocked(&tascam->midi_in_fifo, urb->transfer_buffer,
 				    urb->actual_length, &tascam->midi_in_lock);
@@ -65,8 +68,9 @@ void tascam_midi_in_urb_complete(struct urb *urb)
 		dev_err(tascam->card->dev,
 			"Failed to resubmit MIDI IN URB: error %d\n", ret);
 		usb_unanchor_urb(urb);
-		usb_put_urb(urb);
+		goto out;
 	}
+
 out:
 	usb_put_urb(urb);
 }
-- 
2.50.1


