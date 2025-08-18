Return-Path: <linux-kernel+bounces-774434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56277B2B22A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 22:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25312684320
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 20:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51ECF2264B7;
	Mon, 18 Aug 2025 20:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SsjrAwXa"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F12B822615
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 20:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755548142; cv=none; b=BbeRGtkwaJ6krAioSibarTBEduR71U8Oi6PYn20+TYmqHVpGhEBs6nrRxTHkIaALTnqTT3/RdHad0tDcxOlvoA6Bfc2WWlEg33cxBs17rvdtBMmqsLDzLMJusu8eQFMPLY4QpK/3z02LyUnrlInDS58oCJh8HLm41pQkQy7x0ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755548142; c=relaxed/simple;
	bh=AJRr1pmfwAFojoj8scQGayhsSG5RjYydyI+9N43dH0Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=U5pmCZitIHAFkM2UH1CG9QccfxW5mO8a9xht0VerUeULt6kTf68pogzxWPofGUwvlYtzE1nij86WC/9//O3mC6zk9BnD+M1BaX78g8uOCkiaQm3XIys42wKtmwuHKhL3IY+yPJ2PpSl2zyUeYWAA1DuY8cmroSBWpTfqNVw7q1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SsjrAwXa; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-55ce509f80dso4492096e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 13:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755548139; x=1756152939; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3pQTw4pj+T7PRPBakG+ijRSJnANn71d9h/koPyWygvM=;
        b=SsjrAwXa++UN5sfgF7L+n7fEi/mYt3bHoIwaoMx1QhR0Fm3OR8xtG47tkdxLcbSxQl
         9T6J3sP5zcecSVfYEeNnVLJChEcPmVOKLZAOKio1VKDJJafbQNPSatSRf6zfMH2GHXmM
         0p8zm2FEJXarFZHGe5tcddKDktc37fZtq8/ME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755548139; x=1756152939;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3pQTw4pj+T7PRPBakG+ijRSJnANn71d9h/koPyWygvM=;
        b=vrQlETCXUILutvdSqRS6m8cm0dMGoLW4KcFkPF5tzMGw7gjNXw2x1oR+lBaVToaNqE
         fpqaYDLnRsoHHpUIEwd5TDZRJ6a1ShvlwG0LMeSnr14T8mlk+Fs2S7Y6W3yUW2P5jIbE
         KkaO6J6VMNjFSEYdd+feyApe7qZvQr0RqSeOtlCBGZ2zRYe4Qa0NN2ZERR95pfPSzLm9
         1ypDBPccI11mkcvQINKoM9vW1J9gg3Kb3oV1Cy9hJVWQ04sM5RNaewQB3t5sfZHujQXM
         9nVKzbmi0vqc0faQNJVtdn/kHvx0o8HdReVtR0levzv8G1sZJARbSX3TyVNYpIoQigTj
         3Tww==
X-Forwarded-Encrypted: i=1; AJvYcCVXHUFwlx/RQQSFC+EQm8wAlVqRADY3CFfUCc/ad9EkYfxrS8Re/HcTZs3k3XftpV2iOklM32FhnVNkiug=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe6C1WYg4OpKWvwEDe4rygsNrCkqIxYmyAR6QJWLnBvWnA0CMw
	MJAMfP8Afhulwna+IoLm+tqxD48oqif83tRULGVg9G7wjWERoVBh0QD8DyfbfjgGyg==
X-Gm-Gg: ASbGncuKcoqyMzDwbaoXCq5wqrgR8XyvUz9R+3hYztppvZqDdP050Bri8Vj8Ga6/72A
	S2aaS1K3pOCTGyyGBWWqpqBRVYElD/ggFa8aZriI2cs5eCr78fAm2/MoydsadUj4aWfj15qXHum
	5/QcyPlyxaIf/UA6LhwqBdPprritItM/4x8DyVUB2Ty6YcdiZT/youQgnt/r2dzPibitF694wpL
	+R6YlvOcMTbv2cwTX8vMhmnjf7g75DY9HbhOAMph5crZ9D8sVx0onEp0w/uIx7JYxSylWPJC9Hu
	L3f4P1ycgSVsdOV4Q7lTNWE9hiXPjemXVkv51c0t/3y3AODAkLL1FIAgRq5S9Xbww4eeAaz+jPv
	Bc2oJXypteNcuMJDg6l30j9t/Mq8ljG2/ASfXLaOoheNm7wlF8qaGTk7wAJtVGEwaA5r+63iuaN
	g=
X-Google-Smtp-Source: AGHT+IG3TFzShY6yfe6XJmMNX+zhm5pE0AhCdI1YMtdo5PB/hPLK1e4o0t2sgzIesjN97Glq5qiZsg==
X-Received: by 2002:a05:6512:ea5:b0:55b:9647:8e64 with SMTP id 2adb3069b0e04-55e0082d2ebmr42174e87.36.1755548139043;
        Mon, 18 Aug 2025 13:15:39 -0700 (PDT)
Received: from ribalda.c.googlers.com (237.65.88.34.bc.googleusercontent.com. [34.88.65.237])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55cef3f3476sm1789268e87.107.2025.08.18.13.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 13:15:38 -0700 (PDT)
From: Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH 0/4] media: uvcvideo: Add support for
 UVC_CROSXU_CONTROL_IQ_PROFILE
Date: Mon, 18 Aug 2025 20:15:35 +0000
Message-Id: <20250818-uvc-iq-switch-v1-0-f7ea5e740ddd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOeJo2gC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDC0Nj3dKyZN3MQt3i8syS5AxdY/M0EzNDM1PzNEtTJaCegqLUtMwKsHn
 RsbW1AAQehqRfAAAA
X-Change-ID: 20250813-uvc-iq-switch-37f461657f95
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hansg@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Hans Verkuil <hverkuil@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-usb@vger.kernel.org, Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.14.2

Add support for switching the IQ profile of a ChromeOS camera.

This patchset depends on 2 patches in uvc/for-next:
- media: uvcvideo: Fix comments in uvc_meta_detect_msxu
- media: uvcvideo: Move MSXU_CONTROL_METADATA definition to header

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
Laurent Pinchart (1):
      media: uvcvideo: Move MSXU_CONTROL_METADATA definition to header

Ricardo Ribalda (3):
      media: uvcvideo: Fix comments in uvc_meta_detect_msxu
      media: uvcvideo: Run uvc_ctrl_init_ctrl for all controls
      media: uvcvideo: Support UVC_CROSXU_CONTROL_IQ_PROFILE

 drivers/media/usb/uvc/uvc_ctrl.c     | 41 ++++++++++++++++++++++++++++--------
 drivers/media/usb/uvc/uvc_metadata.c | 22 +++++++++++--------
 include/linux/usb/uvc.h              | 22 +++++++++++++++++++
 3 files changed, 67 insertions(+), 18 deletions(-)
---
base-commit: 078f1a7eb48eef9b3cb78bcd2254356f3a332358
change-id: 20250813-uvc-iq-switch-37f461657f95

Best regards,
-- 
Ricardo Ribalda <ribalda@chromium.org>


