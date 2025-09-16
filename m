Return-Path: <linux-kernel+bounces-819595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 716B2B5A383
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 23:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BD5C5269C8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 21:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F5D528489B;
	Tue, 16 Sep 2025 21:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="soQ+rA7h"
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A83283FD0
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 21:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758056633; cv=none; b=XQ70VdbrXae8UdVcDlzkIb1px3+RxlGEx+HnN+nG8IYrTb/aC06xnHCQ66RW6kbExFqwKN96VQuPl5NV51D0+I3lu9pNPamQbXLQdqJtQ0hOlJFoNdmZP9Fcus4hHKv1+3g43nLJcoKJqn9Qr6yigeUuW6ZiUj6Ll5Qk1ahRIh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758056633; c=relaxed/simple;
	bh=Io2scmS/z+WnjNJRf3hkBU19k8Nous3Bk+KEVXDXVgo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=XN31+XS9WxvuY5M//h8ErqauykGK0qLnje75TofGuQBATZalLd+x4TWuvmgAiixxSfQhp9Lq5Cv6LU1fJODk9k4AUkLmz/HudBeGCOjhQmTsvHjGlCgXhahxwQ9OXBIPjW8wNof0twpLeFX2ziwMnckt3Kt2yUuljK07unBaeqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=soQ+rA7h; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-331d60b0a37so935042fac.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758056630; x=1758661430; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Le06RGdi5tEECJzNJMW1XJ+7hPRqsfMSGYuiprIOY+A=;
        b=soQ+rA7hWEOJvgR2+o6YmeqBMl7M5MxkEsdkM+si/OzM/tqTQwLm/lyEzLTVtmO4qm
         HUbZD8UMdWm6Bojbz3MyVIBev04Vd/oTQrdrxvNUKDLDTUxdHP7e0bKc+Si4anWjhzQe
         HEsVYdRgCCvA/gPdi7PYc4NudWeNopSR4ymy6XCTH/1b8QPvc6+EeA6KtWt/PjVVBl7T
         VNesvrmT+00NSy+mNWURZAs/kBg4LC7rbtlku851KHcgFlA/Sq3QLH2qHIMgsZ28H3HD
         EC0xn/Q3bV9zXWxeAwa1ehO+5aU/zMt2NZQO3bFIBuszCBUvfotXcgF73q4z3VSyDqAa
         ItFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758056630; x=1758661430;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Le06RGdi5tEECJzNJMW1XJ+7hPRqsfMSGYuiprIOY+A=;
        b=ip3N0xspW+UyLE3Ixdj7uDsZ2TdPOT+X18wkxi+40OcXC6XCYH2+ZuLYVPdVdCu23q
         +WbIr+Zhq4cG/42CQOrQpXUUH9Dk0zK+GnTLselIxMUIPG5Xg5nIpvpr/KwllfYJbJFM
         X8HJev3RUm2gze/8db6f+luEaoyFLHibfRrYHSauR+BjFydApbgZqHMeLhulX8xKOrpV
         kkapq53nQENV853jle9KS8K6xzn25NvlEJElkiN5Ag69gKoTOgtzUTauvI155dkWfQxV
         qgK0X7E8WZfb7Yuke0BXZ1Q0Bz5jjnVxYWP+6Z6akRQpX/Up/OELz+Z9VHAi/1pPZjC5
         pPyA==
X-Forwarded-Encrypted: i=1; AJvYcCUstM1vj6Q1bFcHR2H/2KpLiBq3VO0tdoDbcjBMF68O8FhebjMArsU3IGTqhZJbYKbEGPpClXkI179/WiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmoLobLaVp4Puyi+n7DJTphValsF01nVeS4F7zExYnuLXAfViZ
	G/y4IQbrx/ETYmPRAWEH/y88UrC0cLsAeLdwiNHf1aPDml8oDZrtKh+ug+10usNRpzqPqttMH3U
	DRyS5KuA=
X-Gm-Gg: ASbGncu7WGGVH7PEDKddHzTHpA4+/VfgjXVNP+waj3Syej9SjEQhD8PVOIoWovxX7ku
	oVVMSA07dkQNRJIFRiHhZNiXklwthDEhFyOpgGa7V9yI2IjvwzXFRg6wKtoYWWNYTdx/PVj+bbp
	pWP2kJfIwvO74HL8lM7ZaWVazJZr2jPzA/h/tjBwhJNP6TDAoGcb3BpJfLYeMOZWK2zF//wegMt
	Cj9dYZXEiyyeRHspVPMMrlqhdyeNHbs7Y975JuqZ0tIHuR8d94Ju+ri/ps2MNOX8F4xNwqCN/Bo
	6gyPnFD95V1nXP1BaBFZXsC8gBQyfZBkP40kF4nIPKpw5OmhTy3Kdb8XARMJPSXqw9tWXmXLpzg
	bvE7tFLKOTE4lBz3GqLe1e9O3bPxi
X-Google-Smtp-Source: AGHT+IFSdP7n3cXhEVkMxAbOUR4txcADy1xra4weBsKgP9TqoZzgKeQqXEXw3x/c7+UAADgXcva7/Q==
X-Received: by 2002:a05:6808:ed0:b0:41d:7d24:e328 with SMTP id 5614622812f47-43b8d896d66mr7240614b6e.9.1758056630179;
        Tue, 16 Sep 2025 14:03:50 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:70a1:e065:6248:ef8b])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43b8294ac06sm3540044b6e.14.2025.09.16.14.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 14:03:48 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v2 0/7] iio: buffer: document calling context when pushing
 to buffers
Date: Tue, 16 Sep 2025 16:02:50 -0500
Message-Id: <20250916-iio-doc-push-to-buffers-context-v2-0-8b17937a6cc7@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHrQyWgC/42NQQ6CMBAAv2L27Jq2qBFP/sNwKO1WNlGWtIVAC
 H+38gKPM4eZFRJFpgT3wwqRJk4sfQFzPIDrbP8iZF8YjDIXVWuDzIJeHA5j6jALtmMIFBM66TP
 NGX2onK1vgZQPUCpDpMDzfng2hTtOWeKyDyf9s/+3J40K3dlar3Tl6ys9Wru8uY10cvKBZtu2L
 1/7IPrRAAAA
X-Change-ID: 20250912-iio-doc-push-to-buffers-context-df3ca98fe0df
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Andy Shevchenko <andy.shevchenko@gmail.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1697; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=Io2scmS/z+WnjNJRf3hkBU19k8Nous3Bk+KEVXDXVgo=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoydB9YzSfLhVJNZC2TJiA81VdZ9vFMqNLTMTnO
 900A7H+20iJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaMnQfQAKCRDCzCAB/wGP
 wIcrCACLw1x05Ie0qH/qUbzkpjbs+zS34Ecw8prSEvsSwJtyQ/DJPHrEtKJWVuV/wPmDIRRC13i
 7OdhLcDHsBTiUnt5uTkP5JOj1YaPzaBfQ4GIBpe2XGnSXay+Ry2ln+Ng+AsYneNwhNJwW+4lNo7
 2oJDWWTdbuf+HZR2tA/GnMziwoEiT/YQVtm+idp36Ofd380YssjuSPI/0wFI509dIiZiL4xgVEr
 UlCUcbAZagwL9UXXgsWzYlaTa9xLs8u95c4XfAAytV+2fLk0HzTKlDw7H9sUFRSYO26xp7QN1YM
 /AUE4UEhJEJgbHvHVIsWoFqelwx/jGOLdOXdWqAYJJn19mSD
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

It came up in a recent discussion [1] that we need to be careful about
the calling context for various iio_push_to_buffer*() functions. Here is
a series that adds some documentation in a number of places to make this
a bit more visible.

[1]: https://lore.kernel.org/linux-iio/CAHp75Vc8u2N2AHWtnPRmRXWKN3u8Qi=yvx5afbFh4NLNb8-y9A@mail.gmail.com/

---
Changes in v2:
- Picked up a review tag (PATCH 1)
- Clarified comment about scan buffer size (PATCH 3)
- Use DEPRECATED to signal function deprecation (PATCH 4)
- Link to v1: https://lore.kernel.org/r/20250912-iio-doc-push-to-buffers-context-v1-0-c4aad013d96e@baylibre.com

---
David Lechner (7):
      iio: buffer: document iio_push_to_buffers_with_ts_unaligned() may sleep
      iio: buffer: iio_push_to_buffers_with_ts_unaligned() might_sleep()
      iio: buffer: document iio_push_to_buffers_with_ts()
      iio: buffer: deprecated iio_push_to_buffers_with_timestamp()
      iio: buffer: document iio_push_to_buffers() calling context
      iio: buffer: document store_to() callback may be called in any context
      iio: buffer: document that buffer callback must be context safe

 drivers/iio/buffer/industrialio-buffer-cb.c |  1 +
 drivers/iio/industrialio-buffer.c           |  8 ++++++++
 include/linux/iio/buffer.h                  | 22 +++++++++++++++++-----
 include/linux/iio/buffer_impl.h             |  3 ++-
 include/linux/iio/consumer.h                |  3 ++-
 5 files changed, 30 insertions(+), 7 deletions(-)
---
base-commit: 671b9b6d7f4fe17a174c410397e72253877ca64e
change-id: 20250912-iio-doc-push-to-buffers-context-df3ca98fe0df

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


