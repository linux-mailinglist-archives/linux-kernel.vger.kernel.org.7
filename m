Return-Path: <linux-kernel+bounces-726571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE49B00ECC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 00:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA926644798
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 22:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D42D2BE7B0;
	Thu, 10 Jul 2025 22:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="KNsu+QWJ"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073372206B5
	for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 22:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752187238; cv=none; b=GS8BaKPVyJnNZC3TOip1QsiKAPJBQbzvt2nWN0L4aMbqTmyp4o7MzGbiJOGhcjSqbPmF7kWow4/1l5jvzym5XtlTN0eCjM6RFQxalN/ZJ2bDFe2KW9Ttj8o7ADw2j2s+SNww5q6s685/4RX3idTIpEVmI064oNDnusMVZBn+O8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752187238; c=relaxed/simple;
	bh=7t04OBjwHZ+UTchnoJ/u+hKmQ4x1U/HwdOa1mpsishU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cpBWp5f3GfwR/AZbvHQ06tXB/xy4sTvlzXUJweO7DJniyB3E6dlkZ6xHMN7UjopZSz9dqzze/j7Xm+nHJ+iCoU4m0Qe10HLbTstKFs8ry3MrGUfftfGqCremQOWzKC98vw2/XnRL8THmPQMTjr5GQTmPdWvHAXMtxemnGe7PvkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=KNsu+QWJ; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-73cdff9a27aso355433a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jul 2025 15:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752187235; x=1752792035; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mMWTlCBkcYJ7/ria9BlXYNln9Cum5MLQPXIqgZhIUDk=;
        b=KNsu+QWJHeA8oTRmCtkjY9AuMF/dL2q8rmwiUNUZaYHN49bzMuucROtPvU2MYrLwcT
         YCINSbPx3oaCr2LHKNuK2nMnhdlW29zXe9xtXrQ0Gqpl7HfAU+KwNIhMydXB38VDj/Z3
         6Erw9Eyi8eFfBLy9+bgGxHqwo2vsy+acHTLYQQDA+aU8B8J+VNr/lVQ9rqBqkCUufMyY
         gTuTGmDYf+S+hTgM3ygPYpOiFo/bIjNkyUuZFzC9Le2t1Tac0ofNkQRK2cVILZeGrVdF
         iCgP1XyGQe1ZSiB7XlSZdzwi5o3tXi0WpA+FngvzQ/7lyxZ62GgfdT3PNLpAittX8whC
         YzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752187235; x=1752792035;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mMWTlCBkcYJ7/ria9BlXYNln9Cum5MLQPXIqgZhIUDk=;
        b=o6xRPUJlzFGYpYELN4EbLlqUSXxd8o4AV+6oG9RjYVfpyoiQEtpMLaPg27tDYl50aM
         L5UrpnBZfJ2LMnQTwnrLhitpbwszgfCfjtaJ+sZ+wxVG/ftZestkU1Nci07viNn4SScl
         lPE8diXvZjwi1Mal1NaUP1Q7U8fjpMdMMX/98R+wALuITWKW0zMEb5N60AWBQXUl8odO
         VRBLhJn4CBjNi07Duau90yFXA7m79begtMTEn9aXOSb30kRqPWD4BTZqwEOV1p37uNOZ
         8rpSYNjR+Yhi+tMaf7Cp1SPPVYKxLoSruOmd3EdQVGfHLl9S3BNtb6tu9qdD0LtJvXHR
         kksA==
X-Forwarded-Encrypted: i=1; AJvYcCXywZBDhcNRPHunH08rtwgGtmE1pKiyWSLUYvahH+5r6XcDaBkxVg+HY8Axx7KE2o+389YM4WAV49cifpk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyRmJOai3mc6IR8ETEzmUWfk+NesjQ3XXAul89rJ78Cw2AJhWy
	CYlFOQA1luVol/B2+xMet3fea1lmpohDbHFhzvRy/683gq2XdSUmzCNLp7UzAaJ1l3M=
X-Gm-Gg: ASbGnctF46zFyk8n5LSME2LQ+ePq1M0UXhR5qA5WSW/kWo4RnqmtTPiAVl36JyJKnne
	ONzSujAsqPNHc0rSfl8YUHFCTpSPbwyqILU6MV12pXGXZtLeuUKYnPMpN7FAG29sPPXps1ArT8y
	P2sG+hmIsdGYkn4iR8z3yqHVHPhOYfWzEwmWP9XV1qSSjIvCOKKbfmvVyEZzfYOz59XRWSacPA8
	yJ7VVZUZZC9zU1apb1FCTN8EIKbJgIcd4J19wxXZuyJiByTacvrD6HZWIfxOs3uCu5TA7TezVD/
	jQ4XmC9xUHIrjSITJCCqyg0axXYWCEcMbAPWvaoA4gYYayCl7POrqrnCw9cHpTibTw1L106w6hu
	yf67ThqG0YLJ08QLeMA8TpV74D2DOdp0heaak
X-Google-Smtp-Source: AGHT+IED1e1R/ISgIGptpuodfAL1KpJEKFMICy/lsOIml+rwfQbZWjvObE8t3FadGwgxvSEf3UWmMQ==
X-Received: by 2002:a05:6808:6f81:b0:402:a5c:906 with SMTP id 5614622812f47-4151210b9cfmr870158b6e.34.1752187234939;
        Thu, 10 Jul 2025 15:40:34 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:891b:7836:c92:869])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-613d9d950f1sm305944eaf.18.2025.07.10.15.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 15:40:34 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/5] iio: adc: ad7137: add filter support
Date: Thu, 10 Jul 2025 17:39:49 -0500
Message-Id: <20250710-iio-adc-ad7137-add-filter-support-v1-0-acffe401c4d2@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADVBcGgC/32RYWvDIBCG/0rw8w7U1CTmr4xSNJ6dkMRMTeko/
 e+7rivtRrcPIifH+zx3nljGFDCzvjqxhIeQQ5ypEC8VG97MvEcIjmomuVS8FRxCiGDcQKcVdUu
 XAx/GggnyuiwxFXDce2O0NH7QjHKWhD4cvxiv22ud8H0lVLk+3kl9deXw+genrYlxhEvbjGOGM
 Ds8go/E/MiDGYPdTdEhbLTd8A1qjXzoD4I9DvF/9LxOuzzGkiHOMMVcCBaWDFZ3UvLGSG5Ff6i
 fJ3aPibX4lr1oJVNonzdxELpD1yinLTd/+ulnfhnLusCaEcYwBdLkRjlpG9O0Hf8r6tdv3aNKm
 PcQXaJFwpKiRdBC6VYSHbubmTVEG+JEuL7ynVfUoaRTLduez593DHYNOAIAAA==
X-Change-ID: 20250710-iio-adc-ad7137-add-filter-support-d0ffaa92afc9
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2182; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=7t04OBjwHZ+UTchnoJ/u+hKmQ4x1U/HwdOa1mpsishU=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBocEE4pp29GETvugTpGEczLA05yJd43bXcsRU0A
 aRkYn+mk+eJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaHBBOAAKCRDCzCAB/wGP
 wK1iB/9DO19zyd0Q9b4el5eMZZWDgtRzeQbWI8sjKLwKkrXE6jjMZlr3MGf+DeA0YOP+wHMKBOt
 Q1hGh9wec21KGQ7GJWeixJKVZp8VB38PB6xib/gtjJvxUsDpR+cX5/2Mvpjg2Cf46ivRzN4Cdto
 5niohcSfJk0Ca6v5D51T9tJZt3q7F20AuUuOdcLx9+MbtANpDVna4sMoYMA1StDLit0BEHHsL8E
 UpRnQZde8AH0PNrjKHRMWazFQRv+C5vBz8HcOvBRyDUeuMNGIO+KSq0i1fHBFH8uF1qrsbcI/BI
 +xtlIGcQCwqhNhUo5qcejlExvhNv5EXkaigk+tTQYJP2R3oq
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Adding yet another feature to the ad7173 driver, this time,
filter support.

There are a couple of leading patches to rename some stuff to minimize
the diff in the main patch where filter support is actually added. And
there is a bonus patch to clean up the ABI docs for filter_type first
before adding the new filter types introduced in this series.

This was tested on the EVAL-AD7173-8ARDZ evaluation board.

This series depends on a bunch of fixes, so we'll have to wait for
those to make it back into iio/testing before we can merge this
series. There is also an outstanding patch to add SPI offload support
to this driver, but that doesn't actually have any merge conflicts
with this series, so they can be applied in any order.

---
David Lechner (5):
      iio: adc: ad7173: rename ad7173_chan_spec_ext_info
      iio: adc: ad7173: rename odr field
      iio: adc: ad7173: support changing filter type
      iio: ABI: alphabetize filter types
      iio: ABI: add filter types for ad7173

 Documentation/ABI/testing/sysfs-bus-iio |  25 ++--
 drivers/iio/adc/ad7173.c                | 204 +++++++++++++++++++++++++++++---
 2 files changed, 205 insertions(+), 24 deletions(-)
---
base-commit: f8f559752d573a051a984adda8d2d1464f92f954
change-id: 20250710-iio-adc-ad7137-add-filter-support-d0ffaa92afc9
prerequisite-change-id: 20250703-iio-adc-ad7173-fix-channels-index-for-syscalib_mode-49b404e99e0c:v1
prerequisite-patch-id: 982dde330c34b57a76a3e48ccfc73ea6977833d1
prerequisite-change-id: 20250703-iio-adc-ad7173-fix-num_slots-on-most-chips-b982206a20b1:v3
prerequisite-patch-id: 350fb675f3e0fe494e0ce4ddf5685d9369ffa11a
prerequisite-change-id: 20250708-iio-adc-ad7313-fix-calibration-channel-198ed65d9b0a:v1
prerequisite-patch-id: b94476eb0399877093321fd5010965d44738c097
prerequisite-change-id: 20250709-iio-adc-ad7173-fix-setup-use-limits-0a5d2b6a6780:v1
prerequisite-patch-id: 8ca40138b61bcf4eac7437b8184276576308536b
prerequisite-change-id: 20250710-iio-adc-ad7173-fix-setting-odr-in-probe-915972070e8a:v1
prerequisite-patch-id: 0f79cb2677f8a249283e239ca9ae9ae1a1eeb365

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


