Return-Path: <linux-kernel+bounces-739227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57FF5B0C396
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 13:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96C413A3D8D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 11:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF8E2F4A;
	Mon, 21 Jul 2025 11:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kgdajGYf"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A343C29E0F5;
	Mon, 21 Jul 2025 11:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753098367; cv=none; b=fVpgaHNZ38rEzLTJ972Wfv/P2A8AsA7BmdJGt9DVbUTkWYuu5eQ3DLAPcpIpuL8MlPGfQO3QzR066Tujkq+8tMmopaYil1A0pHjF9zhsjxIcfACK4p+wwHP8mjIjBjbIYDLmKssHQss0G8VvlGSox60sWUF6a8cir8jZ1oXouSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753098367; c=relaxed/simple;
	bh=h+WkvhX7mj7Sv6trzUp1+E1hzp9XVaQskfPpJnKiZLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rpnK/v9yPRPUhOG8F4ltr/xWxK/Frw+XkT4qw23Y66+bnuBv+59hvkyF0AJNCdv1xxbVjgbnu9XRz45pKjUiIG63JnWqrTq+g3GQ73YASH3+Dyge2auwSt/2y0jL1fLLx09+hAXMxiPUbMZKy74w4pnDmbogQThxwpCSO1pw9IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kgdajGYf; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a548a73ff2so3973294f8f.0;
        Mon, 21 Jul 2025 04:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753098364; x=1753703164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cl5e5ZCBq0w9ErRVDKRo2EHmjuxMqpvOpJmVUtccUH4=;
        b=kgdajGYf0ApDgukgGW2LTHKavuxzy+QHFgBbH9n97d0lpcn5lPs7F/Ul+iFZwbLktR
         /PJ1d6J+QNgtBoV4Zq9ftQmAlun7KoMivSA3qH0kr0jZwrAEHFyXCXr6qq+cdVjE3FJ6
         BIo6tv8FPmXLXcdNxYbXqNKXBocPzqmodebLx4QV1EHjyIbv0AQMgFECWrhcu426RlWG
         vyKqP6O+Ap5gOhWlCT59ufYs1OLhGtu7lfryepxlHeJSO+lSHc8bq5B8bNmCJn/yytt4
         H/H79EArbvIU/PCVpsHz1QDJBOz+vXhzW7FOd2aFByy6U8x77OJyaRpF/Y7wBk8kdGYb
         fYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753098364; x=1753703164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cl5e5ZCBq0w9ErRVDKRo2EHmjuxMqpvOpJmVUtccUH4=;
        b=iSJ4XyBun4qE0L9c/+rhBeG8RuN5FDnNWNE3dng5fbSusZBZaxrCEIAv+6c8vZT+sE
         CRK3/BbwhjSN1Au3cfIkIRhOF04agcX/AgcW8Mhv2vXuKAz+lUPaf9i0GJcbHeZcm3PY
         SncnthBxYKhL0VQ2+iQgeqH36eu9yusi743Jhc0IPTj9YH9komCweQVg5hr7hFnQ9hVE
         JeI0Qjr8Q3iBIl5pROUyH30LvaSmKEEdOSOi2AfGwPN8Zd4HXENKSBOyPt/YvFWK4hVz
         TAk+fggpZ3+KR7gMkgeHIbrMv14bi0EGQxth86liOo68PSGCzSQoiQtmzwRWXNQSMiUu
         g0/w==
X-Forwarded-Encrypted: i=1; AJvYcCUyXFE2YOM4MeBHzV2LDQpwvfm0o9Xzc7cm48SCvEi1BCgzCTFNEFX9Fy82nnB12J/C9BrJemj7aB1/YOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIujBJO/6Wlfw7SuTADtZDt3oIKe52Fh9ICfLf08Ai7k9kFdXZ
	EgK9o19SLhDtAgquiMk9kT1t3Dtq8AVeyT3K47WASKAZEhlk2ikDxoj5
X-Gm-Gg: ASbGnctiB6G9RcTZPFEQ0hkqReWbKB3x0UOGxVZMFNHG+P3kCPdj/YIkjc8xyPLiHLV
	9lLN1u/rpBruI8gEdXZ/DKk2GMFd4YUNqg/vMMy2ESYzYuO4a8T8m22wdpvMmcDvMFAV0dLqbOd
	nTqMd3ypD2bgSQJptCqqtV5ef2PAtDQe43dHG1cqauCD1+27QbH4N8r9uems9c8DUEORMp3OUII
	1tU7r3GXrjzAlH353D1ReXStNv72h6njCEacjMPagsRDO2DqOOoWW4qb9MbUjB75MBdIOay3lPL
	gCREQVwR9CNgFk86gcA3rvZjkd7hlPGeaVFNSTPQNhis1+eCkqXxB4k12tr1p9aDYu47sK2GtnP
	k9+QDh4CVeF1dlFJ/TyE=
X-Google-Smtp-Source: AGHT+IFcZ+6n7SdqBjRYGmINgvvXBPcqvkndEW+W86MfsMlIcdspxrnuPUDBPX5U4fbfUUvggLOb1Q==
X-Received: by 2002:a5d:64e2:0:b0:3b7:5dda:d57 with SMTP id ffacd0b85a97d-3b75dda0d7dmr1653923f8f.50.1753098363641;
        Mon, 21 Jul 2025 04:46:03 -0700 (PDT)
Received: from pc.. ([102.208.164.18])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca254e7sm10213133f8f.4.2025.07.21.04.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 04:46:03 -0700 (PDT)
From: Erick Karanja <karanja99erick@gmail.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Erick Karanja <karanja99erick@gmail.com>
Subject: [PATCH v4] ALSA: usb-audio: qcom: Adjust mutex unlock order
Date: Mon, 21 Jul 2025 14:45:53 +0300
Message-ID: <20250721114554.1666104-1-karanja99erick@gmail.com>
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

Fixes: 326bbc348298a ("ALSA: usb-audio: qcom: Introduce QC USB
                      SND offloading support")

changes since v3:
 - Add the correct fixes tag.

Signed-off-by: Erick Karanja <karanja99erick@gmail.com>
---
 sound/usb/qcom/qc_audio_offload.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/usb/qcom/qc_audio_offload.c b/sound/usb/qcom/qc_audio_offload.c
index 3543b5a53592..711f5612a83a 100644
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
 
+        mutex_unlock(&chip->mutex);
 	mutex_unlock(&qdev_mutex);
-	mutex_unlock(&chip->mutex);
 }
 
 static struct snd_usb_platform_ops offload_ops = {
-- 
2.43.0


