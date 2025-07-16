Return-Path: <linux-kernel+bounces-733106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F266B0703F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 10:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22861189F4E4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 08:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E2C293C6D;
	Wed, 16 Jul 2025 08:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1tDsFby"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33633293B7F;
	Wed, 16 Jul 2025 08:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752653913; cv=none; b=nxZFsaFc5nd+PPJutaGq19x3+tWtWkCTLCMJJUVHEsfjM1pkJBI8QRpr4bztQnGhrcg8/Ics3B5DMvJau/I+/AMEILmo2SHM+x6E4uw/XO6uxpF+JoBT/m2Bjr7VfTvt+Nt4a3GaDnHPbjwF7vfRqJLkfy4Z6wOqGy2sOHRo2pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752653913; c=relaxed/simple;
	bh=Lft2VjhL3Z+RgugXcrOc+U6+4yRTKoSIvkErlX7DsJs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z84vO+JJkom826wYVoukTKwYxCU4WlzhfQsZrSWVZ6mwnzIlWDbFa9vxyj41zbg3oK19lMMQJTliv/uegQeD2AmkG605jgFo8WfOYE4g5ipEGIM52ibZz0ssRWI3wwLnnebci+CSHn6mF5b2nbIFOaCy6uvyvGKoNzmltLx08nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q1tDsFby; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3a4e742dc97so341177f8f.0;
        Wed, 16 Jul 2025 01:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752653908; x=1753258708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qNA0n9eSMTU9UccBKIS13e/SkdDO98rlQB7qYVwQ23k=;
        b=Q1tDsFbyvHfr7nFmWTp4RQkexSTmpkIr2YNShAdNrtKaAHGDAoqVKrfa5S+ju9pLK0
         7wO5c0HdqaORpYT4wkuj2opwU+TmdfdmbqqBJwb0N8aLgTGy21bV56x6bxfPabplIBcd
         qUR7vHqj+bqwJjAoiV2CO9JxQ+AD43YnPwikzkECDH21maQmhsKVgriWL2U/HXXEACQT
         WfFxfyRm9CdBV8eGzFMbvoOk2Q91nc3QJoPOF61Ral5ffQWeeyPnlumuOYC+eNDZWIXc
         KmGIMVlgNlg0wiZKIMBRWH9gq2wvJseETb8YEO6HDsqRbUKuqZPrFnoLnWHw5dkFtsfP
         HUSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752653908; x=1753258708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qNA0n9eSMTU9UccBKIS13e/SkdDO98rlQB7qYVwQ23k=;
        b=EOfvfPvqtPl995i93DEZD7Milh/W0V391AvlA96Udc5c4KoyAzVGUR14gsLE+2Wv19
         6u8pwmkxvVJ8GSqjPCeXavgxEg/0wUzS9YESEwDRNS7DQ5QZfh0UqUKNt4uq4MuPK2gl
         U19sR1RAL+aYX9OnHGk2NdJQRMbfIcHv2bzaCAxsAgitEPD+UW3MBAG4lI1cQW8FGnL7
         /6r0d7n44mJ5TyaJARvDsuXZZxa1vMWmeUyiAYNiVZfV0N6B0jYZJ7WBLpUAP5hnEp20
         M1T5QyJYiWw+r5HqWTUZnzwAZSCvDAiSd7uuE0IRPrWVXs7o6ZOGTZZxgGYUOAZPNqGw
         Eu7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXQm0eJTg0RTxhBRq6NPbfvAXCE9lWOlokSTNF31h8zd4c531vTGWC3AqKkS/qwQuYuOvxgbFK8YTAxR60=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAPlWdSEWF9UgHgP2sqU3EjXSXRmS9X34Wk9pwOFZ3PaB9IlLZ
	ehJ1bba7DeUxviAzNAwDvXJsd/XQxL2LFsBpScjexuMAd1aEdpUqV5zz
X-Gm-Gg: ASbGnctFZ9rI5qhENj19SflhwgJ2uSHHtcCVgSzgb5mfNPIqjux+ym3cpuvdOxbWq0L
	7BBNoCL9KrOL1ZCs/uW61sycRvCgnogxMQXNyrPVh9FCnFjUPiDdLH37Y37pA88wWykSMh5LcYv
	P7GF7dTSgwHDdXo6qvZIC6AvskT0OUcanzlXvaygKQP0P8PMZliPC9lDpGJpYgwpzRoj9tUO1e4
	s8pEYD5UvOf0dehbLVAlw+nX2syVJsKmRm7MA9wsOrBL5c8Jmi8geYQdopKY0xgdTpVYc4GRrN8
	1npmnFxJfmyWQhq2b/DGiiSM0cXo4VLl6F9sX60Ih/aT/RTKvanYuWes3h0shlnb39J5yWHob7h
	RSo8793vHaCGXOYvZP5g=
X-Google-Smtp-Source: AGHT+IFwAPRR4IOT/bLxwFOqchlFcVDbwbwxP6dToKersdNJBrQoWQTfNJL4K6CWSSLEY7KGVo8F2A==
X-Received: by 2002:a05:6000:2307:b0:3a5:8934:4959 with SMTP id ffacd0b85a97d-3b609544322mr5393236f8f.27.1752653908127;
        Wed, 16 Jul 2025 01:18:28 -0700 (PDT)
Received: from pc.. ([102.208.164.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc1de0sm16991700f8f.24.2025.07.16.01.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 01:18:27 -0700 (PDT)
From: Erick Karanja <karanja99erick@gmail.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	julia.lawall@inria.fr,
	Erick Karanja <karanja99erick@gmail.com>
Subject: [PATCH v2] staging: sound: Adjust mutex unlock order
Date: Wed, 16 Jul 2025 11:18:04 +0300
Message-ID: <20250716081804.727623-1-karanja99erick@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The mutexes qdev_mutex and chip->mutex are acquired in that order
throughout the driver. To preserve proper lock hierarchy and avoid
potential deadlocks, they must be released in the reverse
order of acquisition.

This change reorders the unlock sequence to first release chip->mutex
followed by qdev_mutex, ensuring consistency with the locking pattern.

changes since v1:
   - Applied the unlock reordering in other functions with this pattern.

Signed-off-by: Erick Karanja <karanja99erick@gmail.com>
---
 sound/usb/qcom/qc_audio_offload.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/usb/qcom/qc_audio_offload.c b/sound/usb/qcom/qc_audio_offload.c
index 3543b5a53592..a25c5a531690 100644
--- a/sound/usb/qcom/qc_audio_offload.c
+++ b/sound/usb/qcom/qc_audio_offload.c
@@ -825,8 +825,8 @@ static int uaudio_sideband_notifier(struct usb_interface *intf,
 		}
 	}
 
-	mutex_unlock(&qdev_mutex);
 	mutex_unlock(&chip->mutex);
+	mutex_unlock(&qdev_mutex);
 
 	return 0;
 }
@@ -1865,8 +1865,8 @@ static void qc_usb_audio_offload_disconnect(struct snd_usb_audio *chip)
 
 	/* Device has already been cleaned up, or never populated */
 	if (!dev->chip) {
-		mutex_unlock(&qdev_mutex);
 		mutex_unlock(&chip->mutex);
+		mutex_unlock(&qdev_mutex);
 		return;
 	}
 
@@ -1921,8 +1921,8 @@ static void qc_usb_audio_offload_suspend(struct usb_interface *intf,
 
 	uaudio_send_disconnect_ind(chip);
 
-	mutex_unlock(&qdev_mutex);
 	mutex_unlock(&chip->mutex);
+	mutex_unlock(&qdev_mutex);
 }
 
 static struct snd_usb_platform_ops offload_ops = {
-- 
2.43.0


