Return-Path: <linux-kernel+bounces-785665-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC770B34F40
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 00:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A82E188AF3F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 22:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E522C1591;
	Mon, 25 Aug 2025 22:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="glXsLktQ"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D526E227EB9
	for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 22:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756162543; cv=none; b=ldcM0WSxAo/ueYP540MFfZQWlQsI4gQPY1M03l1eS2k5sA05uUSXIxo3txvmWX0mOxzZfhjrsh4XvYvsuAFUROodxXVlHBYo+uVE/jRWtBtVOlIRrZatT0J4KQ/ETx8abYr9xdVUVxj+4JNqIeg0CXE23ZLkuLCHWxCqgBP5APQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756162543; c=relaxed/simple;
	bh=CZtdnoVEalHzWzYLwK7E8e1YLjYq1SDqTbG5ZdQs84Q=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=glnNSO68y2dh6Pe+ebfEc7G7AUd6w2Nan+m/nr7jbx4VyRe/TK0lPLZYSxRQZOrybk6YOXHOfFK29KLF20B3EY1sbK856HidKjEexmeDnwmwvOo5MMterteNLcnpWPVe1OAg6RynFqS2wgdCDWwC200q4RhBtFO8lBu3+I/ck4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=glXsLktQ; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-74381ffff9fso2325915a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Aug 2025 15:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756162540; x=1756767340; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rCS6DLcEySz3olHWHzOFv+Ewqrwb+xd07eC1nN6zlK4=;
        b=glXsLktQ2OC6IuGFyCpiPX/xmMrOhTnN0m2w3e3WQ+MjshJ/2nVety7CVneQCizArq
         2xA+QkQ/g3t8OVxYxd1+WlFXIwn4hyEzAXWVPYO0RJWUXloUo5XocYW2tMQVePooBe3V
         DiT4JtIiU0qe9i7T4lELLyLExRaoIdYUuJHA5sql/9QwLTqt1Y+/ab5bwKeB3SmbGD0V
         gj4ZqLhUUu3utM/eYRVzDCZERgL4jy5qorOHuRn4SztH8YNmI5tnpl2gxJfEBYxzRzA9
         5B4saiOrggDQGW8p9cMaptO2/Ea2x/+XuOHChRMOR7zn7XL/u3MRYRzIjcdkRCK1QNCY
         fT4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756162540; x=1756767340;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rCS6DLcEySz3olHWHzOFv+Ewqrwb+xd07eC1nN6zlK4=;
        b=Cdw5sFMOWFWpJvJ3R9NSp6UK+MwrsWkuU6BDjQKla0hpXueOjxnMk5zY66TRjDvu2e
         IH0opggsnHuWUOo65sZy0IZpuHbCxuwA019EUcOuSjJ6g/VUyXEv8MpqvxEzf0ArtVue
         rUq1b+Yjd9tRpfVeybHnRqykGexYalI5OfSKucBwbh/+QDGyncA4uByw/lPWAziEKwCh
         h5wJ1ycSQOv/qdNSK7HqJvgPsq8EKCmTyDnZh+fUHkdfZhDgqzSqrkFTJwDz1NArENiq
         z++yMYrbelN5aDiyqXBzKKYeixmDnT3itJT/B1maWToxpOT9gS96ptKBAvRcAzVOWteF
         glIg==
X-Forwarded-Encrypted: i=1; AJvYcCWoT6DvoIihyg8Q54bCfTCyAh7MCXipwz7wlmpoahZIYCgmouU8altCNEM+UgmqrIxtlQhgqvNi9lER1Yo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIQCIJNvuFcMi1WJ7I5J4j2WXAWvqZE1VGWX5aDb0SFV+llhLm
	lnV3NPH2uhZ7QgRy4L17AKzUW5KOqZqLFurll7Q5ri/qHWf4oji3IeT/m3b2gzlNXfqXTIJZocG
	bJWJF
X-Gm-Gg: ASbGncuev1szGaBf/94Xpaj55xNlauReZjAUgjBwfQmMAOisbg/61oza0Fnuj1Qf5u9
	eMUojMfEKmhmhVeAGH+LlOkOYFB7/O9m5E265ExVsur0rk/Jd1hWyDzfmIHHACeq23MPbd22Ms5
	cQvzn478kzBV2DdrNCaua6dvoGEjTjoUrZJ3hE77/UR5Kj1YgCTb0eXcNx6lFjVuSf756Kxzme2
	GShBLUGsTiBzG/WUwZ1uxKgggsf/SK+2FwHt1a5DOEkAlCVKYySxGs0zT2IsyPJ7u1iqmp6488F
	/qm5RrWuacWo3PxxKjVNO2G3nZlxwYHrYlJLViWvS+5/TlqFQiNo1o0FqcujpZCOdJsL1WxQ2/V
	VBGgLkHWZsjIxpSXu8vLnp6v70vKraLH8j0GCvoY=
X-Google-Smtp-Source: AGHT+IESiJY5iqqsvItpm4Sh7rsORevtB2B5egj8A4x6z3Lz4XrFb1LlPBxzSpo81Oj8l1v30WNahQ==
X-Received: by 2002:a05:6830:2813:b0:72b:872f:efc8 with SMTP id 46e09a7af769-74500a70e38mr7712241a34.24.1756162539764;
        Mon, 25 Aug 2025 15:55:39 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:5075:40f3:ff25:c24c])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7450e49d36esm1991747a34.40.2025.08.25.15.55.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 15:55:39 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH v2 0/4] iio: adc: ad7124: proper clock support
Date: Mon, 25 Aug 2025 17:54:59 -0500
Message-Id: <20250825-iio-adc-ad7124-proper-clock-support-v2-0-4dcff9db6b35@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMPprGgC/42PQQ6CQAxFr0JmbQUKBmXlPYyLYSjaKMzYGYnGe
 Herxr2Lpvn96X/tw0QSpmja7GGEZo7sJxW4yIw72ulAwL1qgwWuigYrYPZge6fVlFhDEB9IwJ2
 9O0G8huAlQYP1pkC0TVVvjCYFoYFvH8pur/rIMXm5f6Bz+Z7+8uu/8ucSClivh2rVdzg4O2w7e
 z9zJ7R0fjT755cpdLnqQ+kLNp2NBOqPnNpML4q50OjVzZWZa088HXT5+QJq5GcxFQEAAA==
X-Change-ID: 20250723-iio-adc-ad7124-proper-clock-support-7249022a7349
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2036; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=CZtdnoVEalHzWzYLwK7E8e1YLjYq1SDqTbG5ZdQs84Q=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBorOnHIRZT3xyR6Lhb2S7qFJnWk7zLyV6iVl+UJ
 5p7FttrEJOJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaKzpxwAKCRDCzCAB/wGP
 wOsvCACTgIMTCTxzrWY1441pyDEnoRZbgmuc9aEK94TaP7Xs0zem878uOUld4R7OmpzNRoSWdPo
 QaAsjv8olnME3kr+8FK612SQFS1WJek5zS5Ekm+896DHLDEapWx0niiXLEuZpxFItYMmHmbedv/
 dsvn8W9x37uWl6712MatGiScSCms9rODDDfkb6xAyb0jF9I/HlQqNZxSSQ4uM+a68CsF7yDRbr/
 7kSNxcbMBPjWiUinQyieCtz/Kl/P6PKNy8WozTfwDYY2LTGCwZp4QsMfmSVcq7ByeJ7RGrz4wWl
 zwgN6w4S53gOHkyVyFI14JooSIhxIynuX3VtR2svpSY7RTnx
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

I started looking at adding some new features to the AD7124 driver and
noticed that the clock support was not quite right. The devicetree
bindings had a required "mclk" clock. MCLK is actually the name of an
internal counter in the ADC and also the name of the external clock
connection on the evaluation boards, so I guess it came from one or the
other of those. However, what the hardware actually has is a CLK pin
that can be wired up in one of three ways: not connected, input or
output. So the existing bindings making the clock required don't make
sense.

Furthermore, when looking at how this clock was being used in the
driver, I found that essentially this was being used as a way to
select the power mode of the ADC which is not at all how devicetree
bindings are supposed to work. The clock rate is fixed and the power
mode can change no matter what type of clock is being used. Again,
this just doesn't make sense.

So here is a series to fix the devicetree bindings and actually
implement proper clock support in the driver.

---
Changes in v2:
- Picked up review tag.
- Wrap some long lines and tweaked some other odd line wrapping.
- Dropped mention of "hack" from comments.
- Use __free() instead of devm_ to free temporary name variable earlier.
- Link to v1: https://lore.kernel.org/r/20250724-iio-adc-ad7124-proper-clock-support-v1-0-88f35db2fcaf@baylibre.com

---
David Lechner (4):
      dt-bindings: iio: adc: adi,ad7124: fix clocks properties
      iio: adc: ad7124: do not require mclk
      iio: adc: ad7124: add external clock support
      iio: adc: ad7124: add clock output support

 .../devicetree/bindings/iio/adc/adi,ad7124.yaml    |  21 +++-
 drivers/iio/adc/ad7124.c                           | 139 +++++++++++++++++----
 2 files changed, 134 insertions(+), 26 deletions(-)
---
base-commit: 91812d3843409c235f336f32f1c37ddc790f1e03
change-id: 20250723-iio-adc-ad7124-proper-clock-support-7249022a7349

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


