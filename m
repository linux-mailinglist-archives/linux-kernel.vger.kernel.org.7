Return-Path: <linux-kernel+bounces-812906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C18FB53E03
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 23:46:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC207188798F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Sep 2025 21:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8D12E54B9;
	Thu, 11 Sep 2025 21:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="gkUS0WyN"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A562E2DEF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 21:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757626982; cv=none; b=TanOgU7OaYG0KlpGIWleaqXMZ4xazJ5ibsvWkqMEwDoi1SH+GBVP3SO8+vQfrpP/w2eZ4w0BsYiBpJFivEPNTqmpIyY77k8CZtGwcQAsoVZ+V9EtF643GPlmkofZYgE1T709B59fg0giLUEsWLsMUPA94ZJsF1AYd1Bx0dEaUCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757626982; c=relaxed/simple;
	bh=BMUZul4w2Wdqu3+6ZxGgii/wI/FeYD/KgRdlY83CvQU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rDKkCfiaOXk/keO03r5t/8HMVI8i3PDzEszWmkpVnCShkmMYz0Il+r2+oF+Yks3LQc15fc5Uz3w+9lK5kJnCVSfRR+/ItHOxQHK13L2/Ob5uTogmFhVZZAQK0TrNcwAEnhEB9MXMQ/EFecgEBKyo+rCtf25fa6Bm+nyvfaXZ62s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=gkUS0WyN; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6205e2b7a8fso610862eaf.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 14:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757626979; x=1758231779; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IcSrjebCEmD8D7u4qyd0fiTNVHOhu3JhXWISUNqvRUw=;
        b=gkUS0WyNy7NGXBQs0bzGgeceZNEjQFEwjZ3DGP/QodTUDc2ZU7aq2ggbYnxqmroyFM
         LkS+Nzf+RFumzbCHJmUn7ufvpeFFuCOs3NByZTD83tguhj08N/AxibYZpZaxn7I8TYyO
         GJJL5PtsoY9ZIvCsHnjcIP/dGOLZOzPRJGq6lJ82cAgKMna+CVfYwFzD4FG7s/BfF5W1
         OLFpFNoqIJKuq5Ur83MJq6UjQhMU5tPlZdF2wZ9I0vda7z3J89/s400nIXxKqXBE1Tk+
         mfAsduUIFc9t0XhwavD5y80j4J2rnjcN1/EG50YAbhCo2dQBgStOq/KgsO5dfCORNRKU
         6Dfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757626979; x=1758231779;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IcSrjebCEmD8D7u4qyd0fiTNVHOhu3JhXWISUNqvRUw=;
        b=eyrqpdO88byv1IKhLZw4OvHwvKt9pOsdj4pR6ghwRinJIPW3aysnFqYgCypOhxpMrx
         nTJy4joewhJsSfXUEVZ0TQemJQD6Ep5iZ6poQ7wABAyPBkfw5qVq02D3ohhh+/75voz+
         xJjFaXckqwuVww/aT5td6bpcnuuIncMSa0oUAXpLq+MAZHT5OKETMOCbHiLFg0l05vhG
         7fUwSOMuQSRV1pLDWIqKk3N+1T4fLzgj5eJA0K1lP5+ooD/kFag8BYfPheu2VLrMpcr/
         PDHTg7hkyKHuhrs1j7o1eldZRUrKjnzb5S8l0ZkskTQHr+pXDKao7gzz/CXSPj1Dsvfu
         Aq0A==
X-Forwarded-Encrypted: i=1; AJvYcCUK6ya+//aw8prXA14WLFRs67hps6e0P0wfBN2jCWPE1ruwYg/JFesCQ8zrrYuEzu3+b49fj9h9DxNbIoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpiYspT+vzJDGOUSw0irhX6zQbjKTM35/ATVKUw+hOs4VOt4ck
	D3ZzC2Z080DjdfGSkR1uap0ck7Zx4YsBOOknFudOcrp3Ed1KQGkGmM9uDTD0IEyrlSs=
X-Gm-Gg: ASbGncuQQb3cayCsSbnbq6TpUHqi4axpCoz6Gm9PS/e9NIFjmp/6FqOy924uiJWrX58
	UuflaO2+0rbL8RrSQo0BO/LjLTt97vqsnAkuIi5idgDJcushLrcDDsHbOHdnjqW4zCvmH04CRS6
	ZjNarSZT1KGqK9NgNdZvtnH046xX3IoPl0wgZna/Pp8PQ02zJTvF4pCHMGdyW2y8jWhFq9re3a9
	CHZlOykChGLETTjGF0CF32ccQXdk48tCjCj0l90JppL+mDLhWNNzPvqyr8wdiTg/m9Gn0iPQECI
	NRh7D2O1EIXEKtPfgakciEb6gvlXlGfe6m2U1Sb8M8VROO8so0VT4S+V0xS/ZmQ6ALzASZkVf7x
	2w3MWISBlxU9P7sq7EiS5AGe2BXuH6+q7MphI/Wc=
X-Google-Smtp-Source: AGHT+IF6EmKy/M6sMmOkz7IT/ipRKY0iTQyQA6+wygNDE7llSpDWhnsTp4ifJ4gi9JoybvuSYwiLLg==
X-Received: by 2002:a05:6808:218e:b0:438:25e0:bf82 with SMTP id 5614622812f47-43b8d72c7d9mr315007b6e.0.1757626979315;
        Thu, 11 Sep 2025 14:42:59 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:d684:59db:8b2a:5451])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7524986a7c3sm604188a34.10.2025.09.11.14.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 14:42:58 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Thu, 11 Sep 2025 16:42:05 -0500
Subject: [PATCH v2 6/6] iio: ABI: document "sinc4+rej60" filter_type
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250911-iio-adc-ad7124-add-filter-support-v2-6-b09f492416c7@baylibre.com>
References: <20250911-iio-adc-ad7124-add-filter-support-v2-0-b09f492416c7@baylibre.com>
In-Reply-To: <20250911-iio-adc-ad7124-add-filter-support-v2-0-b09f492416c7@baylibre.com>
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=838; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=BMUZul4w2Wdqu3+6ZxGgii/wI/FeYD/KgRdlY83CvQU=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBow0JTtu85rjP1ShuAEpkAIG3qtLVmQ4OyaDOKe
 XucV62AfSiJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaMNCUwAKCRDCzCAB/wGP
 wABlCACF0wJCj9x2/tTQzrpNuclD6Z9nH9qotv5HHDdleCHFdeZi6nwrliqg8flSyLEy7Y8h+Az
 X3x5dejvhWgmkYkKpQpFZlISbIVtDKAC4gPeSBdabbdZNcyEepoMJzb3EgJF4+VkkMSOJeLxI8D
 xgqsnhNBwnmuCLSgLleYj7Ftw8YPHoB9mwf+ckHaBuqDGPGfW0TEz2XSqyLYT2yzRyfXdB12Sbj
 sRLDJJfzQPsMeWcwpPk9Oka1PJ3lOLNpi5yjH0jD0EIkbZcRoks799PXGyeQqFv0NdNNcYtrj0+
 W/Mbv0b5NQsZB6oZM/bEHRok+TKC0QpRu6nzilDnvF3npSQb
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add a bullet point for "sinc4+rej60" filter_type that is used in the
ad7124 driver.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 Documentation/ABI/testing/sysfs-bus-iio | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index 2fb2cea4b19249743398b1ff0b538b03ced0340b..829ccfd902f2ca4e5ae38ca025eb3c4a9fe1389d 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -2292,6 +2292,7 @@ Description:
 		  1st conversion time.
 		* "sinc4+sinc1" - Sinc4 + averaging by 8. Low 1st conversion
 		  time.
+		* "sinc4+rej60" - Sinc4 + 60Hz rejection.
 		* "sinc5" - The digital sinc5 filter. Excellent noise
 		  performance
 		* "sinc5+avg" - Sinc5 + averaging by 4.

-- 
2.43.0


