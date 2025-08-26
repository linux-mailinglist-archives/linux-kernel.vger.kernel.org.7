Return-Path: <linux-kernel+bounces-785714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0BBBB34FF4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 02:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A629C240F32
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 00:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87BC347F4A;
	Tue, 26 Aug 2025 00:10:13 +0000 (UTC)
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5006F39FD9
	for <linux-kernel@vger.kernel.org>; Tue, 26 Aug 2025 00:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756167013; cv=none; b=F/4r6ktBmvK4eDYF8Dl8/b91oKCNy0ohYl4VYCHV9WRC3LIjJXO2rVybepNH48v9VomAU4hLsUvZy+z7Q+I4G9R8jsr+36HujXvz/BgWwdnxsi14U5PDVwJDOHLSpdawz98H8beEaZu5dor/VrRPtebL9QaUB8aXU+7NQCPwA9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756167013; c=relaxed/simple;
	bh=d0B9voqYEo1XKngf7852jpuT+gDiKxTJ2xcbkTBpflk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=j17sfAIFFWbfs6sZSXukPG7G607eES+tOmhHlyvaK+VLcsQsxNTehnKrEIRAU+sej5Q1pf3esoiQ8hKo2+g1tisJZwV9DLYsnpT3a5Gp1Gp0bwf4zF9DE49UnrDoKQjcKGA72RtVCpssLiQdIzjDQE+fgNSDSpGMU3m4IaLPnwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ben Collins <bcollins@kernel.org>
Subject: [PATCH v7 0/5] iio: mcp9600: Implement IIR feature and add iio
 core support
Date: Mon, 25 Aug 2025 20:10:02 -0400
Message-Id: <20250825-mcp9600-iir-v7-0-2ba676a52589@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFr7rGgC/02Nyw6DIBBFf8WwLgkq8vBXGheAM5UF1oKaJsZ/L
 9bEdjGLM/fenI0kiB4SaYuNRFh98s8xg7wVxA1mfAD1fWZSsaphqtQ0uEkLxqj3kSqUiKXpmWK
 c5IU1CaiNZnTDsfmrHukUAf3767p3J0d4LVk5n8+fsS0u3zKlOYIJ9AwTdUobVELyGk27qsvrn
 iH4uS1cKa1smK1Nr5E3WFmBEvIhF1IrzivOkVlNun3/AFpHkhD/AAAA
X-Change-ID: 20250819-mcp9600-iir-8f7ff1ad0804
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ben Collins <bcollins@kernel.org>
X-Migadu-Flow: FLOW_OUT

ChangeLog:
v6 -> v7:
  - Remove extra space before trailing \
  - Don't add extra white-space
  - Remove mcp9600_write_raw_get_fmt
  - Separate out the mcp9600 IIR series into its own series as there is
    a lot of conversation around implementation.
  - Add rework of ad4080 to match filter_type "none" logic

v5 -> v6:
  - Cleanup tabs that were converted to spaces

v4 -> v5:
  - Missed a one line fix to IIR patch (5/5)

v3 -> v4:
  - Based on lots of feedback, use frequency values for IIR, and use
    filter_type[none, ema] to enable or disable.

v2 -> v3:
  - Improve changelogs in each patch
  - Based on feedback from Andy Shevchenko <andy.shevchenko@gmail.com>
    * Fix typos
    * FIELD_PREP -> FIELD_MODIFY
    * Remove explicit setting of 0 value in filter_level
  - Based on feedback from David Lechner <dlechner@baylibre.com>
    * Rework IIR values exposed to sysfs. Using the ratios, there was no
      way to represent "disabled" (i.e. infinity). Based on the bmp280
      driver I went with using the power coefficients (e.g. 1, 2, 4, 8,
      ...) where 1 is disabled (n=0).

v1 -> v2:
  - Break into individual patches

v1:
  - Initial patch to enable IIR and thermocouple-type
  - Recognize mcp9601

Signed-off-by: Ben Collins <bcollins@kernel.org>
---
Ben Collins (5):
      iio: core: Add IIO_VAL_EMPTY type
      ABI: sysfs-bus-iio: Disambiguate usage for filter_type "none"
      ABI: sysfs-bus-iio: Document "ema" filter_type
      iio: mcp9600: Add support for IIR filter
      iio: ad4080: Rework filter_type "none" logic

 Documentation/ABI/testing/sysfs-bus-iio |   8 +-
 drivers/iio/adc/ad4080.c                |  23 +++--
 drivers/iio/industrialio-core.c         |   1 +
 drivers/iio/temperature/mcp9600.c       | 147 ++++++++++++++++++++++++++++++++
 include/linux/iio/types.h               |   1 +
 5 files changed, 166 insertions(+), 14 deletions(-)
---
base-commit: c17b750b3ad9f45f2b6f7e6f7f4679844244f0b9
change-id: 20250819-mcp9600-iir-8f7ff1ad0804
prerequisite-change-id: 20250819-upstream-changes-c89af86743fa:v8
prerequisite-patch-id: 92882274615d59f2e89c189ce0859297fca88772
prerequisite-patch-id: d2c1fd9da2dee3ad5dc240f34cc108d02980a4c5
prerequisite-patch-id: 72368205aaa96b053ba78ffe6548d0895e039753
prerequisite-patch-id: 98a8a8ee92fc0a9836975d5b216d41702860019a
prerequisite-patch-id: c24cb6dd5b2b385c00bffdbf1f7a61e4d1532f49

Best regards,
-- 
Ben Collins <bcollins@kernel.org>


