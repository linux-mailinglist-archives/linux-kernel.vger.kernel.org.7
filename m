Return-Path: <linux-kernel+bounces-611309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF51A94019
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Apr 2025 00:59:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B7BA7A868A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Apr 2025 22:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6AFE253F3F;
	Fri, 18 Apr 2025 22:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Mrty7JGo"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C26253359
	for <linux-kernel@vger.kernel.org>; Fri, 18 Apr 2025 22:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745017160; cv=none; b=t+rG0kasTQZd7XznKfV+I8R2Ks3hFZj+BI3tu7iFiv/jBQsiaKgOClZpZ+vGQhJ+9xNK/zTarCHoRKi07ygiifBOvhneuVZzK4/zfoNI6OwmXAWLK9G3QYa61Y9Un8NG+eqpTo5ucAyYUvurh8l1tN3co2/9I6d1qJhJgH1XVxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745017160; c=relaxed/simple;
	bh=TIiSFiaveco4i0VDBF0MkmegJ6Z89W6n75YYUq9W8J0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=bGArL1mvhcT4XctyC8rRBMVQHAUZ66q2cyO4i2FA6lPURm3sVUYYh0U50PrNOG3jAjY5pYn9YfQlWseHCqX4893u+XQ9g3cXP3DHlfLTn663ye5F8RKqBKmIpCSirYRp/3Xa+lyRFMg/xG0rtUOw6brR7CVF0oMTcdI5uQZ7I70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Mrty7JGo; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-72c1425fbfcso356573a34.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Apr 2025 15:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745017155; x=1745621955; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WXaoLC4nIoomjS8j0eqxe89fdYrGWSShSIAOAA1vScg=;
        b=Mrty7JGo1KQkiQkdaLE1g9aE12q3CcTTC0/XHVYhteYvJgZtOHVeQTLkBRpH0Q8++m
         wxTBATpVYCwYt8J0SuEYgGB3CWhTsFqRLXAudT9N6L3M3uGq0zOjpaS0dShi8zHa1zgN
         d+isgDBf7w6+n2nHYiK/6QJhiCfLDuZTvbp1r0+I31XCZGRFZmZxkciwJGoVtzflYrWG
         JR27XbzgBgqp7jwwgWkxpqFn/1ay6bmX8QBysXH044c454FpCFiIf/o+8qviA38Eh/vm
         DTxBuKNsZWZBQs6AbmT8gkRyX2nnU6wGOkRcWjwEhUFYTgLR3sl06meII4K/DBZMWJUw
         4cbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745017155; x=1745621955;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WXaoLC4nIoomjS8j0eqxe89fdYrGWSShSIAOAA1vScg=;
        b=E2nAIQL9zn9VHe2gNQaQqnSXDiEePX2BGZ/Q8EDHAHw6AdaYOK5A9oFOlmqij8Qxq7
         yWFV/0HqO1yR0JsHEciFunUlkd43IVYA48brKKA5E5n4VVqXXsPeqBmxpjCvD0onZVt/
         i1IXZdNGraPC2KqT7QIR3rmcskUvwacoryBmKV0i9vgdEhzogXVEukkp3TYplMGMQd5A
         7kS3p+OJbh3rmtA+B1cnNIskByry7bBLS3Fx7LDdQmO8qYREbfrxOTev8bNjJTIRSVh9
         dLm1UrWkloXPDlAynQObVj3jPsMvWi68wwGUR6ekU1eFdf7fzC9oZ76fKH5WBRTSsb2a
         cbeA==
X-Forwarded-Encrypted: i=1; AJvYcCXS30wvcaAeoo1+9XiamOdFysKN+JYSK3ZoKfYfIK+JlSj6oBZEGscXYpVa2+vCRsr/tkdE+H/0+QKikJc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyPk5a3guylxjKCMXabhLgcn70LxLmTTsWphF6E+T+0sbObGX1
	fXWA9wROEvd+5bEgiXmLqfzJb0uyLd5PWRu7Go6lbuVxaMUDP1sPMQZY+a8hh1Q=
X-Gm-Gg: ASbGncutTGniMoxC7LmgjFS2h9M12+xz7fTcXIyhwv98KzpUYCeQKxbEXAjPN2kyUKi
	AkLkIkCKV0GkGPL7F/UpqLNG1HQhuamSoQIFM401NWDbJHEB9axMpvHP9lMq8ZVbG4huBXUlFuC
	MDmZxINsqr1C+KysQWnmwchBQ0mXGD+VNh3ZFdpmcC/WvsIL2Phz7RPyGfEOugwkfRqXkD6ZROM
	YvI8pTplQQ5uKwNwz2KYTr34dX2TRlR6myJGYTQ+bXwVlJiZnoOqED7fCaLFQiV227vtmNKeHeN
	2/y3/zAyBuIYzA6SfCwh866CMdw67DeYH6RHqEVQaIcL1iU=
X-Google-Smtp-Source: AGHT+IFGJwjLQUB/vJZ4lrKevKfAPZ/nzsBlgi9XU9cuqk+UKX8COkW9+m4n74rL7Fud0idbvQ6SKA==
X-Received: by 2002:a05:6830:d8d:b0:72c:320c:d898 with SMTP id 46e09a7af769-730062fbcdamr2673977a34.22.1745017154859;
        Fri, 18 Apr 2025 15:59:14 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:dcdf:46e0:18e5:c279])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-730047ca051sm500187a34.36.2025.04.18.15.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 15:59:14 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/4] iio: introduce IIO_DECLARE_BUFFER_WITH_TS
Date: Fri, 18 Apr 2025 17:58:31 -0500
Message-Id: <20250418-iio-introduce-iio_declare_buffer_with_ts-v1-0-ee0c62a33a0f@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABfZAmgC/x3NTQrCMBBA4auUWRto40+KVxEJaWbGDkgik1QLp
 Xc3uvw2721QSIUKXLsNlN5SJKeG4dBBnEN6kBFsBtvbc38aRiOSjaSqGZdIP3mk+AxKflqYSf1
 H6uxrMZZH547sMOAFWu6lxLL+V7f7vn8B6kfxiXoAAAA=
X-Change-ID: 20250418-iio-introduce-iio_declare_buffer_with_ts-2f8773f7dad6
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1923; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=TIiSFiaveco4i0VDBF0MkmegJ6Z89W6n75YYUq9W8J0=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoAtkZWJrT0iPWiXxMQOblB3puxQSwi4QZxcwD4
 FdZz6R0jFOJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaALZGQAKCRDCzCAB/wGP
 wChGB/9Cex/82/dVE4DqmygR19WZetlxkznh5OKF9X8UDTbTtmFU6v2GlayCZPNGG6N2J7xfQaC
 k4gRkpC7F5EPtAX7IMTypRj4ux4DSJAfOK7Wvza6XT2EVYYSpc/Q57LGr2NBQlkEUpmhghoMu3K
 0xH0U6LqCXfQwGTgf2oiB7WcQBQW5atbzEOxtW2yJzGAa3cG32FqL4NDFBrg+UMDYEPINUCs9Vv
 rHcmgliEyB2qAE3J+OeJx3xdITjiSoOh7A2NWlZMAJhqN7dqtGBJ4xAPm29vikMHY3zQEu4TviF
 wLMulquuXxbVgcMujOMPXAkVwIgNyMG4D16muyFBIVUlCj/s
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Creating a buffer of the proper size and correct alignment for use with
iio_push_to_buffers_with_ts() is commonly used and not easy to get
right (as seen by a number of recent fixes on the mailing list).

In general, we prefer to use this pattern for creating such buffers:

struct {
    u16 data[2];
    aligned_s64 timestamp;
} buffer;

However, there are many cases where a driver may have a large number of
channels that can be optionally enabled or disabled in a scan or the
driver might support a range of chips that have different numbers of
channels or different storage sizes for the data.  In these cases, the
timestamp may not always be at the same place relative to the data. We
just allocate a buffer large enough for the largest possible case and
don't care exactly where the timestamp ends up in the buffer.

For these cases, we propose to introduce a new macro to make it easier
it easier for both the authors to get it right and for readers of the
code to not have to do all of the math to verify that it is correct.

I have just included a few examples of drivers that can make use of this
new macro, but there are dozens more.

---
David Lechner (4):
      iio: introduce IIO_DECLARE_BUFFER_WITH_TS
      iio: adc: ad4695: use IIO_DECLARE_BUFFER_WITH_TS
      iio: adc: ad7380: use IIO_DECLARE_BUFFER_WITH_TS
      iio: pressure: bmp280: use IIO_DECLARE_BUFFER_WITH_TS

 drivers/iio/adc/ad4695.c           |  6 ++----
 drivers/iio/adc/ad7380.c           |  4 ++--
 drivers/iio/pressure/bmp280-core.c |  8 ++++----
 drivers/iio/pressure/bmp280.h      |  3 +--
 include/linux/iio/iio.h            | 16 ++++++++++++++++
 5 files changed, 25 insertions(+), 12 deletions(-)
---
base-commit: aff301f37e220970c2f301b5c65a8bfedf52058e
change-id: 20250418-iio-introduce-iio_declare_buffer_with_ts-2f8773f7dad6

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


