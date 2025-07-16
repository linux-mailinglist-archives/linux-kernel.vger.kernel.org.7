Return-Path: <linux-kernel+bounces-732933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E57ADB06DD1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 08:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6015C1AA05BD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 06:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E643285CB2;
	Wed, 16 Jul 2025 06:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jqB+IbtQ"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B9E171C9;
	Wed, 16 Jul 2025 06:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752647037; cv=none; b=Gnbbi/Qe0Xda59MKriyEindusikKcgIVoiiuzkaDOIDTxCuC4oT/cPmqE3KEItTIdgNBJuoz31T79GhQTrjUbE6JsDZmVgBNW7vPwXB0SCjHRMvStPvnUNZIYeLpB83QqUYMw4mDJqFWqCMiaXzEOC9R45AmFKkfTUXcJZuvj1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752647037; c=relaxed/simple;
	bh=lPc/ujMBbkY7GsxfeqrA9n5TEa6uTkdv7TU2NdYla+E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EYu4Z2FD0ryvB5hsbqLaL6koq+SrkdmpZT2/wTc7phw6Gvjc8l6kYWdKTNn/a8GSt/nhDnxCMYsvIpjn/rxOvbanNljDH0WY1XGIqX3apqPD+BawMzN0XFLh8NNWpZb54ex8sbSC/2DRw3ZZQs8ioKGw611o6Wz13tHJhbu9MzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jqB+IbtQ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45611a517a4so1657665e9.1;
        Tue, 15 Jul 2025 23:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752647034; x=1753251834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bd54qPKhtf5xoLinfnzyD3tXrm9xf5NqVgbA6PNgyHo=;
        b=jqB+IbtQQBhMCU4PRovuA+TVZT3SWnOAcdC0OG1VEAZ1s3MqBzQmcWy68F5c9HGNMF
         buzCPVRMiVjchp08slLz426AgY2gl05i16ONDLr2rTzarX9bRlUaA/+Ok6GX8nidOjwT
         9flbDceqRe9HwdQ447CfWe+S1chU9DzfAArgYQyVgBiVJi/JM3F1HfrJf2Ju3SgiOk2J
         2KzwGc0szmGjqKxeEWT1CbIOgsVB4neQyy2xFWD4Yo8lUlSZycLTFDui0J6jtRmiaPA5
         PVcsaBGPPLv1RGNBQTJNv3g35aT5UFBISrBEdjruSHam6YHJ6Fg3BFoq7mTaqK7kFrPE
         FXyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752647034; x=1753251834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bd54qPKhtf5xoLinfnzyD3tXrm9xf5NqVgbA6PNgyHo=;
        b=FvbCwC5RMbnAybrXLP3T4/bjdtvUcMd3Q4FuPvjHnZiGIgBhRbAEu+ETOrJXcIAWMa
         5yQPB4h5w6Q/PZKK6t3bsGogFWTB+RPH92xQHiUyrrgMEIQSYUxTkoOtedCB5teotc6m
         v0hZr3moVt+rolVT2HCJe5tyoSL0fnVr+n+MfHG8W9xd0W0g0xSCg/6asktFvL9kIoJY
         4Js/m2kRmQBf3lZeo75PrqCfNpaw7hWLESnNJDPmGR1zEgHZBQNyDgtmz3PclCKfvUY7
         VGTjgOhyFQ3VhOsupKL2Sgu+4l7+GXqrCJRiL8PVqlCM6ePWpNe7v46aYtJNZb0juXA5
         8tqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcEGLMYkLO3MHpYyyx2yxqHFfF6psED4gXjMLmK6n+rdQJLl/w/ocP6/0cqntmBH4wm/Crmb4MSyX78uA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqYXKk42J4XffgJtUR7ryx+WTdcaSNsDA/mZgS0DGaM3MkJeFh
	EcGUuwTFp0o42J39mR4d+dWMTQneGGu8VlZHbnLis60knSIYyM3MY+c5
X-Gm-Gg: ASbGncvzIpPjZWuq0OENgD/KU8J/2JO9UEeEoVd6sHNaPqLS6Up0D6AlqU9Pr4a2bsh
	cQ9/+vIoVa9bPFOKqJpadadlqBFcM/CSGcFSgEFgzoefCAOhqY9/qF9gCtSPApb+aTzuHGrIASs
	z0JCENMEveyjILRm6Kpx4Deq7SFnmsriU4tsqxYpW53bPSL3ye83CUCjg7kIIwYvPjSpGhFAMYi
	BkRu3vhlcJ1hr2No+DNhY1eXW26E7Ojn/VALdOBd1/z8YESCLknyjM5JEfdh8H8zNuLNLXMqYMW
	cRbxHaJoHDQFHNOuBTfO7pEpJ9B3ncmznc/vxphPuSRODLfT6cpnaYyzECa39S8rsums1XHwM89
	GPjL6yCoFPno4BvXP87M=
X-Google-Smtp-Source: AGHT+IHf7i0NZrLbzAC0UiYFgVB1buOpOiVctBkvZdhK0kOWkSWOPjIZfEecQaZg8VVvRDvSTTu3CA==
X-Received: by 2002:a05:600c:a207:b0:456:23e7:2568 with SMTP id 5b1f17b1804b1-45625e78e2bmr38912645e9.13.1752647033991;
        Tue, 15 Jul 2025 23:23:53 -0700 (PDT)
Received: from pc.. ([41.220.242.241])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e7f4294sm10731675e9.3.2025.07.15.23.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 23:23:53 -0700 (PDT)
From: Erick Karanja <karanja99erick@gmail.com>
To: perex@perex.cz,
	tiwai@suse.com
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	julia.lawall@inria.fr,
	Erick Karanja <karanja99erick@gmail.com>
Subject: [PATCH] staging: sound: Adjust mutex unlock order
Date: Wed, 16 Jul 2025 09:23:30 +0300
Message-ID: <20250716062331.375090-1-karanja99erick@gmail.com>
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
potential deadlocks, they must be released in the reverse order
of acquisition.

This change reorders the unlock sequence to first release chip->mutex
followed by qdev_mutex, ensuring consistency with the locking pattern.

Signed-off-by: Erick Karanja <karanja99erick@gmail.com>
---
 sound/usb/qcom/qc_audio_offload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/usb/qcom/qc_audio_offload.c b/sound/usb/qcom/qc_audio_offload.c
index 3543b5a53592..ef144d2be7d2 100644
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
-- 
2.43.0


