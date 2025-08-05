Return-Path: <linux-kernel+bounces-757097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 905D3B1BDA7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 01:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ECB73BD7B0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 23:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAFD2BDC32;
	Tue,  5 Aug 2025 23:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZxuMsfgP"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1939F24E4C4
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 23:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754438389; cv=none; b=pHQs402SCcZFaa5YxU4emFOvheWmqIOf3rkUcYkdxbLppsz9+t4m8PwAGm4lmG1c+qOLb3NicCDlnigKL7HLRhhItiTNGY5jWlcpDMnhvLL3KluRHlg8LtStgHU/X9aYk0QvWRxx9wIL6nIbBxrUbqims/0RRVR6LuBPItUYWX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754438389; c=relaxed/simple;
	bh=V7vV+BmZuhMN5IzY3slTPuONVrTo6FHBuwP1anhy5HU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XvWkOR3MHhkH1fXyIWXrruTcO8qCmKB+w92gm66cFrg0yBI/GogKLEUqa1NEnRB1Zw+ZzJhfU8S0O9FYUYx8DXgjmYiTrL1Mi6ZY1bhQGoLSqz3cdCloD5WZC0evDGFV7D9/NsF1zQ4wLsaWcnL+vzOFY8HTgXpPlpEUTADtvzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZxuMsfgP; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-459e3926cbbso6005895e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 16:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754438386; x=1755043186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2xhiUEc9Kw/V714a7yfCWYYu6l+qIkZaBDMyW3CyOmw=;
        b=ZxuMsfgPn42b1N+nKW7eLsnbk5DFKPwex4nXF/xtvGDTNOF0VRqz8wzQDPFm8d9lX6
         bOkYlTXZXfg4CZLrjN8/yxiIaS9c2bg0B1z9tKIbg7E2GzFfQjfaJNi1OkOIQl45gAUT
         JGlreml2a0AoVVUunlEqMHwT0cAA/FuAsBGCMG2trfRkQaVR9kRZAfWTjhUXTyOOn0Mh
         Uk8lSHmmimnktbQ5LCxUcjHNnwyI+/qcxwIGuylDWMuux697zw9vwSMpxsCX1vwsWej7
         5jVxRyfiMFyqCfv2CexWu26qqbUBIdJbvDcm25+pCQKJjt5QSNrRxD//tlewlp31uD1U
         pz+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754438386; x=1755043186;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2xhiUEc9Kw/V714a7yfCWYYu6l+qIkZaBDMyW3CyOmw=;
        b=ZDnf+/QuNXuB5KIqVCicqlKvpudXBpL/nWzduNN14qrI5HyjawsRZChjRCZDtcOv9u
         a1pkn+b69+MsxE0rfH3YMrAn+Mi06qbqUwh8XGInHJcWoy9GjxDHJsnNNJfJjw7SQ7OF
         8cLOWZt4HwubW6kmpkBNpH3D7b/Zb4F5GN0V4YUyvOFQZmdLpwTI5sNtJ10KJadRhc5T
         CUTmPAoLo7YGBswpeiB/+A+2jPLAzDbMRlhqU/JzpDrPtF/kG3m5RHnFAUURnGtxkKYJ
         WZjLD4jPaGIZw1lEMOnTfn3z6MG/CR8chKFToVNDH0hejBzzn+Jjl5jb2qIIXMnnY3VB
         jqHA==
X-Forwarded-Encrypted: i=1; AJvYcCVzY8RCEipM0UJHOufblNg8Yt+SyBgnN4wubt10ICXKj3lwhb90Jw+t6yupNJmsgxp/K7g3OGJEZOftZwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMPSSHwDgcf6X7Fj2/Ly5Wm9Zuf8fRyn8SAPgfo6SZszMayoFr
	HM6eJz40YdPVKIPxFcEqOM7l7ITP7gUFD8aTtzOYcq9uDnhJMa5fdjiw
X-Gm-Gg: ASbGnctpvFTxGC5/XRyCzLdzuskDn89Tl1QPY23saWR5wFPORPyxTWvAAH2G8Js3Lx8
	jhbqQ9hodKjX6rTL9KqVYWR5t5Pw6oi2hvRuYOELH6nMNyxS+1FJSq6WY/y+Pn07ka74NUrXE5t
	MCrp3gnHKlo7XfKDhHhORzJrtKGHTFjrjiBn2BZCsNH0SRQORL8R1CKD0S5gxcIDp3BnXTafL/l
	n7TmmTwsKnpRFSF3Ai18rbZRaenGQucPxeHkCe2EJgdigYDUE3k5TSvbKkCYGiQa9E1ARm6LiS8
	33jW8lCH3ISeRA4W+PgwniZABYm+Q9uc4ysrFmot1Jkdj5FhlM87/FZfMwlpEsg/z4fR81qfk8g
	0feiUHCBdUVTG3CCCXsJAPB21nlL2XSDKpG5JCTKQCpfZ2uIin5i2S6ezuaR2eAGCkOc8P9Kz8z
	0=
X-Google-Smtp-Source: AGHT+IFsHdG6C+dK0jpCSAVCpiWRzLZUbTx+mxWcmzk1Qn9/oqFLMmf+47R0EY18CG9DIppdXP0Hkw==
X-Received: by 2002:a05:600c:3ba2:b0:456:1ac8:cace with SMTP id 5b1f17b1804b1-459e7090ffbmr5512585e9.12.1754438386168;
        Tue, 05 Aug 2025 16:59:46 -0700 (PDT)
Received: from ekhafagy-ROG-Zephyrus-M16-GU603HR-GU603HR.. ([156.204.172.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458bd5a0f9bsm90322215e9.0.2025.08.05.16.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 16:59:45 -0700 (PDT)
From: Eslam Khafagy <eslam.medhat1993@gmail.com>
To: 
Cc: skhan@linuxfoundation.com,
	Eslam Khafagy <eslam.medhat1993@gmail.com>,
	Manikandan Muralidharan <manikandan.m@microchip.com>,
	Dharma Balasubiramani <dharma.b@microchip.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/1] drm: atmel-hlcdc: replace dev_* print funtions with drm_*
Date: Wed,  6 Aug 2025 02:56:50 +0300
Message-ID: <20250805235928.236248-1-eslam.medhat1993@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi, this patch is to replace dev_* print function for the atmel_hlcdc
driver with more prefered drm_* variant [1].

It's eventualy up to you the mainterner to chose to apply this patch.
but since i am a starter to the kernel i'd appreciate it if you do.

[1] https://docs.kernel.org/gpu/todo.html#convert-logging-to-drm-functions-with-drm-device-parameter


Eslam Khafagy (1):
  drm: atmel-hlcdc: replace dev_* print funtions with drm_* variants

 .../gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c    | 20 +++++++++----------
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c  | 14 ++++++-------
 .../gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c  |  2 +-
 .../gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c   |  2 +-
 4 files changed, 19 insertions(+), 19 deletions(-)

-- 
2.43.0


