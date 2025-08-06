Return-Path: <linux-kernel+bounces-758172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C18B1CBF3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 20:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15B321765A9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 18:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C986429B8EF;
	Wed,  6 Aug 2025 18:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YP5E4yDB"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E181FF1B5
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 18:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754505059; cv=none; b=G2VSaqpMhLATO/bd0MuNSrxRGm6Rnz8m2YtaY/doRZISm85jMSZi94k5xDTMoFdGRrhJffquMc3cRLnFyWrX8e2IULUCIHFXfr9rwp9ZkvDDjKGoVukMI2W78k6jayvG8ijLP9fwvf/mT9rsE/mDnczA+yd0/OFURdyJ9SS1bdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754505059; c=relaxed/simple;
	bh=KWxT/Z0XevdKPJcB/smws+AGDpoaRtiBJlNZtpcW88I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SbuOKCQ8dVOPrrPBK3pqKn/mLzFBVteFw1fFnk+olS7HRpkRymQSy21BboTiFCn3UiRS0HUBpMR8OedaA2PvfXEPYPTWwVKUUzW9fa4yg0GyiILFSZ7on3aMaLkMqZ6YyEAvkfVUWbHhKJdk+nKuFPKj912a6W7+epiKf7aV2Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YP5E4yDB; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-459d62184c9so1619155e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Aug 2025 11:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754505055; x=1755109855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i9tF7LI6280Rqv7Cfa6VisATQ2AWLBgyuKrf+KPfB4A=;
        b=YP5E4yDBL24FbZB09WoBWsypo9cCQtZ+eisNiiKPl+VX9KoavdqeV31u0xXUA+XBGz
         Q2SZT5Co05zzkA5rA9n4znuMlIv26C/NOjyGnKNllbZLCqKaqg4IWXa+nTs/1evNtwJG
         Yq1IbQgrC5wSdpnPNmlP97nQZbEd99hceaU3VDtH5yYT3Kc7SHkAnuQ2D40NMCFbW/i0
         PtTcMXTr4q4aq+3W1pKoI/8RmazLvJm7+rlLvpqdmunDP1UzuqC6RHRQ0s4XkLFoHFeA
         PitV+ku2kCthTsWtwz6HR52RouqoKGHeHGa5NEohXrmQ3v2HYYeE67g3tmNEqone2Mmy
         fcPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754505055; x=1755109855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i9tF7LI6280Rqv7Cfa6VisATQ2AWLBgyuKrf+KPfB4A=;
        b=sEyl4EqTQt29Uea4nmfYytGVNRGKdmTliK5r5sjsVx5iL3OrB6FhjH4eXVYoOfP7wJ
         qAj9NnXJSJFiFUmesbDJ/dsThvXbtmsUu2C9i0NX7wR4OoKQRUNdmneRSY4WEKtgLvww
         jeDThwKZCpNOmwrg0koRWfhv32wCJhTWhuoSzrlF7a1fApfCAv/sXckLeM8Q50giMf7+
         RQe9pncIRo8Xpv0KZQvdBXQ8hUPTarnzTYVp0L78Lkkro08u2zarn8QIcq6+vQ5DkWoy
         /bc5Bfjvj3EFXnF/PcZdjcbrXKvVVlHEC/R4AOHFvT97XosVbQnYNqqKYtakDMUTaSft
         8yMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUw9KEpCEqwUbH3ksh7ekdKb/ZRdetl8QpHZpxPnqus/suwSEuZCImZKBB/RO0MBSXiWoimfBMT6GyaoOk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0DYwEnOiHH8FTFppSrmQ+P6wRAaGNPzziQEWO64v41U6a5xtU
	lFwWXaXlDi+GBliGLBPMCrVzt76pfxAeKtcZbU6BqEB0oy0d6zSfK1vB
X-Gm-Gg: ASbGncswesfqZgip6KL6/grSpasnNFV6tgWN1burMzYJqDCG6i5TdnsMNIiP2OfD9Cw
	S6I4ZSjW4POTFuvMWrwUnaGFKk4zPegGnen5lL95FZZISPFCAmpLbn0qeqqg5y3HQ+w7VBEEBgK
	O8ZQEtrySB1RPnPAvFr5yc3nknRmyYDoH6TedBLxpRU7HULCOn/L/xpt9FxgZ2IWWvL0GrQ78so
	tL74cYIXJmpIfTHgiFpSiV+SXvLt5f2aQvzb8asVGFONtOO2DAFNaTxqW6joCwe76KlUw7Hkyol
	7cPYQTKxyeBxMt6Lh8LjIwXrfbyCJAfqqsUDEdcxeA3oDPJJcFQrR1Z/Rab375K/sEFiN4RWNNe
	yMvzxUge9afTjsb0djLsm4KLjZG/aL/0vb6I11P+mUcPe96C56pfkutnod21di3jjr7+O/JO8BP
	U=
X-Google-Smtp-Source: AGHT+IH6HaHyzrxaoLtYAvA1b+HYXwJxcd00pdb2pcxvIAdn4XhD1N71vIwvp/Bn4tXqtLYoNd2ieA==
X-Received: by 2002:a05:600c:6610:b0:450:6b55:cf91 with SMTP id 5b1f17b1804b1-459e70797ddmr32849155e9.6.1754505054523;
        Wed, 06 Aug 2025 11:30:54 -0700 (PDT)
Received: from ekhafagy-ROG-Zephyrus-M16-GU603HR-GU603HR.. ([156.204.172.189])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-459c58ed07fsm156104065e9.22.2025.08.06.11.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Aug 2025 11:30:54 -0700 (PDT)
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
Subject: [PATCH v2 0/1] drm: atmel-hlcdc: replace dev_* print funtions with drm_*
Date: Wed,  6 Aug 2025 21:30:40 +0300
Message-ID: <20250806183049.52112-1-eslam.medhat1993@gmail.com>
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

v1->v2
change dev_dbg to drm_dbg in atmel_hlcdc_place.c

Eslam Khafagy (1):
  drm: atmel-hlcdc: replace dev_* print funtions with drm_* variants

 .../gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c    | 20 +++++++++----------
 drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c  | 14 ++++++-------
 .../gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c  |  2 +-
 .../gpu/drm/atmel-hlcdc/atmel_hlcdc_plane.c   |  2 +-
 4 files changed, 19 insertions(+), 19 deletions(-)

-- 
2.43.0


