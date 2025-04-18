Return-Path: <linux-kernel+bounces-610931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7ED7A93A9D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Apr 2025 18:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06271178DE3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Apr 2025 16:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A11AA224237;
	Fri, 18 Apr 2025 16:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RTN2QPgd"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8E5218AAF
	for <linux-kernel@vger.kernel.org>; Fri, 18 Apr 2025 16:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744993063; cv=none; b=SpRZ4xALpjZ3CfLm1U6HPMVHdOp+naaTiXQ3gTRWOWYRLUT1wik9Bbrf0rnry2ovS0WF/SbwT/4ijjcsNWSgDk/BV9r9gAk9IVG+qN2FQdD+m/t7O/7NG97VMJbICfc7C/fT2pMtdhIFpdeDfgda/W0IaIY/KH3LHcd4sjElU8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744993063; c=relaxed/simple;
	bh=nxNqUrDg4UWZQ5+BGHqH2KfM4OFOiPfHtFNtEyojU1U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=SPTWx1Z8oUoP8Vt3/O06Qs533+U4ZM9dSFvbhLXQioQ14MMJ96NdNMiVpMbXfNNOn9DCMX8Zudw6rHkmpZcr2Ro1F6BKOsavyag50Bet4kqdKmPyDI368BgcNo0JCNPB36Nz5HAMmMuAvMGQJxZsUeTnnd0/jJPizoyYL/5f7sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RTN2QPgd; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-72c27166ab3so1292490a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Apr 2025 09:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744993060; x=1745597860; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tHLMtLRk80jcoGLe8M8rmpL7eQ+RCL/Z2079hkSgYFo=;
        b=RTN2QPgdMrbUQutTJGc6Uji2/zXpaOuWh7sI5pHNITyTHvl0mMFzWOkya1cRjwAr4J
         hAFEdESmiT6FL6ktrGZbCnnXgky7Mevmwb9s838JX32iAhVhXu0ey1Wh9adTXqFJDvci
         ouPlbvQUKjAxPX3HMKoO5jincgb86MRhpZjwYURUVpL3QGaelY2g5G6vblu4UnMrJ18y
         E+fnO7Wfa6zi62FvUfjn2Lpwm/wsqYgkg0aiPggw3W/oVUYZlfUXqbJ2H0pGDXRhQIK7
         kx2KWKFSq4o9Ke5QB683FK9v9NMQxpUcI3QFrqAhNMOJMnoSJqBXg0ukv0Rbqy0GPhY+
         7WOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744993060; x=1745597860;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tHLMtLRk80jcoGLe8M8rmpL7eQ+RCL/Z2079hkSgYFo=;
        b=BsWd1GDJWL2Be3KBkvJpkUtOf5BdSTmgRFT4QZO1UVxQ/P69KsG6b+yLng35fsC04c
         KWaxeMxmdyuGAydaaxlf2G959EUZI5aWbK0OnytO123akjSPk929Y9QF8ugxa37AbZZD
         fG3XfpyA3x45rjYVB3b+5NucZgVLwMpEoL8dUi9P2yIVCEpwWxzhRw/xP0Ff5BLqw1Xq
         FPcDJKsRV62SOzZHqqKo+Lr2tYyL6zXoKdiUBTJzrktZW6wjuilRtsaQV/fGh/kcvYKt
         SnL2GtebOIJs4nWLYZjy/U+hOZrf/PpezL53ZX9tvfiZocIK4SabwmIJj4F4wF4bX+5/
         Pa0g==
X-Forwarded-Encrypted: i=1; AJvYcCW2sux3geZtMmIRZANa4jkXddPFFFXBZe4Kbx46gPX7LAazQlDDHLtwJwO+5jojniNW6ykhrRQFeMiZU9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFlS6LQIpgMJ+O7KpazRvdpAVCfl4O7CA/zY3rYoG+vwd/quTo
	0mM9hdMqNs5sdvq105LPab2Yf8JFfJn0wC9gledj9JqviUwWfIjLWiF4r4pgVXY=
X-Gm-Gg: ASbGncsyZ4CsILx2p9/B/4F/He0ArrY/e+fJODznI9fB+Ijcrw3rxZFOraDc+NdtV19
	Nk1U6LiK1RXrsL5yYQZ6lwt18o4rO4fXp2pikFz92GS/X0c0BaMdb9sZSanyLl5df786MuVcODn
	fX4tbSMk2gJtiPG4Mg4GNnjA5+3oGJtE2doXfkVmQ72mZIgSSDzcBtIKIPi68v9rRFrV/pYkZ9t
	GNIiJEKynCpxW1wQbYlykeyv4eBXTtqUSR8aNpKS7iVxIVqxuKiL+mCVd8iBCiddqX5Jqnsefiy
	W8P0PYFJRhc3nnkxTMR4vReunGZh2LEOIE1uza0EwaNs1Rg=
X-Google-Smtp-Source: AGHT+IGra3+0PzJgVGPEIu8oILAKsARii7I0u0JdLmcqpvH8+Eow3EuSHB5zQYXLZdfVi9mv2PRHFw==
X-Received: by 2002:a05:6808:4a84:b0:400:b304:2f79 with SMTP id 5614622812f47-401c0c4b2c3mr1680776b6e.31.1744993060519;
        Fri, 18 Apr 2025 09:17:40 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:dcdf:46e0:18e5:c279])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-401beeffe05sm384929b6e.30.2025.04.18.09.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 09:17:39 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v2 0/2] iio: more timestamp alignment
Date: Fri, 18 Apr 2025 11:17:12 -0500
Message-Id: <20250418-iio-more-timestamp-alignment-v2-0-d6a5d2b1c9fe@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAh7AmgC/33NwQ6CMAzG8VcxPVvDpgLx5HsYDmUUaMI2si1EQ
 nh3J4lX09O/h9+3QeQgHOFx2iDwIlG8y6HPJzAjuYFRutygC30vbqpEEY/WB8YklmMiOyNNMjj
 LLmFp8lFdcdsRZGIO3Mv74F9N7lFi8mE91hb1/f7g6j+8KCyQqSejWOurqp8trZO0gS/GW2j2f
 f8A1JGU18sAAAA=
X-Change-ID: 20250416-iio-more-timestamp-alignment-6c6c6a87ebda
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Ramona Gradinariu <ramona.gradinariu@analog.com>, 
 Robert Budai <robert.budai@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andreas Klinger <ak@it-klinger.de>, 
 Petre Rodan <petre.rodan@subdimension.ro>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1080; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=nxNqUrDg4UWZQ5+BGHqH2KfM4OFOiPfHtFNtEyojU1U=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoAnsNvlGKnXm3JC006GDqi0zucti7YyDflp6Ee
 4GlX7gshFiJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaAJ7DQAKCRDCzCAB/wGP
 wN7tCACYL74ptMcqaC1NKJZGril/Q10xPafBj5E2HVXUTvCkBEvNIJmSETwDydhiIfKHNR91314
 an63oX4lPnPmNBZYZB8c5yhmgro7xoX7LZMk9NaKbCys4INKHl659iuapVVtbNL9HwCHclP0wah
 /Z3DX0d6895KN2B/kQWlzt/N4608sNf7f5mcOXtCmNYXKzt22boJzjQhN2pE5IX+N5w9NDfBRZo
 ZJG37sB/zs7S/C4U3jd2Hxa20tgTuXs3Kz10JMwugUsKUhp4i0SahYN+bfm6XyVcZEMIjGh6K2R
 JFFYbmq6GRyL7yf7Vq/r6N3zAtXKf7MIk/9OuM1GzL73/lHK
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Wile reviewing [1], I noticed a few more cases where we can use
aligned_s64 or need __aligned(8) on data structures used with
iio_push_to_buffers_with_timestamp().

[1]: https://lore.kernel.org/linux-iio/20250413103443.2420727-1-jic23@kernel.org/

---
Changes in v2:
- Dropped patches that were already applied.
- Added Fixes tags.
- Dropped the (insufficient) bmc150-accel fix that snuck in the adis16550 patch.
- Expand mprls0025pa patch to remove struct mpr_chan.
- Link to v1: https://lore.kernel.org/r/20250417-iio-more-timestamp-alignment-v1-0-eafac1e22318@baylibre.com

---
David Lechner (2):
      iio: imu: adis16550: align buffers for timestamp
      iio: pressure: mprls0025pa: use aligned_s64 for timestamp

 drivers/iio/imu/adis16550.c        |  2 +-
 drivers/iio/pressure/mprls0025pa.h | 17 ++++++-----------
 2 files changed, 7 insertions(+), 12 deletions(-)
---
base-commit: 52d349884738c346961e153f195f4c7fe186fcf4
change-id: 20250416-iio-more-timestamp-alignment-6c6c6a87ebda

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


