Return-Path: <linux-kernel+bounces-814467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17015B55472
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 18:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1B5E176C7D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BEC531B101;
	Fri, 12 Sep 2025 16:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Cm8pqs2O"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C743168EA
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 16:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757693218; cv=none; b=V7tnUP8fMi2EmKFftC7J/B+iMoFqE9WxMNTeEVbOqB4bz/E3jbrQ/hGyyzlSp1xb0jsbf1UWGIqV7P4N0NbgbATj0Tl/CBPZuuweHfi2BiwQjn9pLps5nE+GGDFIUMthSwRQnPr7BS/vGu7zmb2NxBYEI8a2r3RAZjOT6lwfBNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757693218; c=relaxed/simple;
	bh=HoTnMUccGdCvWwXyGGvfMxbeyG3DCTAB887pRo015M0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TYShNaCNC7W0s/n9RbNgKvPnwpeVujfDELNTlB3em0ZwxJFF97jrOAUQnYoX57xyEmeP/vgEBsoFrHr15h/heWPrksSR+ONlPVQ7lETpB4SWAwdrxxOKTKiNKg13qqhz5TkhUdeRltYpkpJ+VFE9W7bctkZFJGrNyk5hGZY9U9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Cm8pqs2O; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-74382048b8cso1763139a34.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 09:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757693216; x=1758298016; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kOVMpRKYtwkqS0W7XsGFd2e24mnObLP4dosBsaN4f+k=;
        b=Cm8pqs2OvPdH5sF5FR41yCK6IFktodNX0gdYPqukF0rXOPEtXoT1NRQoL68iXlCSbS
         TiIpVhT2NC4WiOAaJqGtyCPIYfDKQYc9aTp1c5yxbnJKSt/pUWdO9Y0E5fZsq3TLFKvk
         4WPjSVmKwOTGSSHzIQzTlHqKZY18yU4Bh3uV7wuXGvnlAtnu06RiRxzgmZWF7i+YKeZQ
         vTANbLEwYGnj/2Q2f/MxNM/fSL7kmFcaW7jBMf5+T7Ng7lKDG6PnlbIo3LwBKCj3mFha
         kF7A3zMon5puzA/HnyPRLROM+p+IsdFkO0hInWPUR+8iDUkrCKheZHE1XtI8N674+bAo
         hGYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757693216; x=1758298016;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kOVMpRKYtwkqS0W7XsGFd2e24mnObLP4dosBsaN4f+k=;
        b=dSLXWd0z8WrT78hPtxtu3vishcUDCaaWcYPZtHhhK/Cwv13I/sY8VX20YPUsAQB/ix
         /GaYrZF5kYmtkpamFr+rkukNYJhcSrp/uqJ2BZ0grZ1zg5O5m7R53tCfxYFydHYsJTwy
         Y8bBvUad7Gr3K45sumKTJ2ujfXSWi4zh3RgkJXNM3U2VQJy/jKgHC+OLnElUY8XS1V6L
         n2HF+F701Wfy0G0GeLIt4CDUtVJNVFM+3v1E4JSzB+tsP9BJ/tnAScoTn+yd5JcN4W0I
         XmOH+lgf4LeREgP2O+0Bbj8uTci7vqwPJezq+w4WNpycEB4X36iSLyjTisbIAwgUiMPm
         Zl6A==
X-Forwarded-Encrypted: i=1; AJvYcCVLK41gV9Ryt0aSuhZuKHftS0QqwBTQNKVMERicuk8h5CZLVWPBYPDd276WSi6B4bB+u7IOG6gxbIJbAIc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg6PezHSYky/Zehx6uH/Lk/5otllLSuuM4LUkLJkpvndUsrmBv
	Dz331dpvFJYZV750He03ez4Z6nUr1k8KjOoiZw71rWwxtXO2DLwLAnnSvq25M5uyAVQ=
X-Gm-Gg: ASbGncvWKUtQsXY8F4gD/za+4gYo6VeI5SZ0uG92AgfzTq783NFumVQd+g6IWNH8HRu
	J7hB3qPXGonk8gtwVqrKsulr61O/xf0TyiZAbSLA/S+lhRU5vG6mw8eGISyw8wtipa8oJQyu2Z9
	jMzt1eBsZ+KY15NHfzbNRnVjooKj3Rl13ghz6MbnGS1b/DdTPLJjmTxl9r/lj486G/cLSjZdrP+
	02NQg8odsUYu6iTmNmUUAne8kaivXTakl7XHY8xA8o3qRvncyWYGnGVReyWWAkMk7Roi9E7pU2o
	Xu5FfBAGPNNQMCD5GxNQefSvCuLb4H1t1oAWHBxj5AUmzZ75K+3u1fM9vx6e123EAB4fzo8328G
	A/ikI4DuKykmMA4uoNXPjPQe7aHOr4EHSr6hblUE=
X-Google-Smtp-Source: AGHT+IEs54PO6N0rI207rx1HplFfPlWuO/pKvW4GXQTqH/1uT1Bd1BRiYYZhzYSgWeVoLnAZGg8V0g==
X-Received: by 2002:a05:6830:82db:b0:743:9758:113c with SMTP id 46e09a7af769-753532776c3mr2042722a34.12.1757693215709;
        Fri, 12 Sep 2025 09:06:55 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:fdf1:f11e:e330:d3c1])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7524b8a39ecsm1073863a34.23.2025.09.12.09.06.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 09:06:55 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 12 Sep 2025 11:05:53 -0500
Subject: [PATCH 2/7] iio: buffer: iio_push_to_buffers_with_ts_unaligned()
 might_sleep()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-iio-doc-push-to-buffers-context-v1-2-c4aad013d96e@baylibre.com>
References: <20250912-iio-doc-push-to-buffers-context-v1-0-c4aad013d96e@baylibre.com>
In-Reply-To: <20250912-iio-doc-push-to-buffers-context-v1-0-c4aad013d96e@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Andy Shevchenko <andy.shevchenko@gmail.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=930; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=HoTnMUccGdCvWwXyGGvfMxbeyG3DCTAB887pRo015M0=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoxETw258yNRARhwR77D2UgPbrc/zmisGccaZuz
 rySZbrjeWSJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaMRE8AAKCRDCzCAB/wGP
 wCvfB/9tnxLNQhNprmYBwwnum801uPCKAeES0y5nk9ybnkP+83kJv4h0o/fgYuUodKFWxPpFkZ2
 hbthrxGiW3DFmubTSz2pvIZGkP7J8EfZ0L6TPvxxeMJsvDXtpZLS2rs9DXz1qnj/HoRzpDaYsV7
 t0kD3OwzvmOtNTd8EQc0W4B5ztjFV8IZex3vj9H2h23GJZ5c/QZxNkTOzFAjh9xz//PPhWWgeEQ
 czVvs8aYh3htKfECNbx7abY2Au1xpsd7nD0Mlq+SvWKmDXGvEwYHnlC/Z0XXMyTFby/9hMnk2q5
 hxS73CmdN/6DkHWB2/V0ox4j23W+TU/tUAWyirU9hQpXapho
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Call might_sleep() in iio_push_to_buffers_with_ts_unaligned() since it
can allocate memory, which may sleep.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/industrialio-buffer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 7da43a1f2f75f32dc93b9a5fe903378a79e82fe3..5599fa37b698dda6ff126496f62939331c12f524 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -2412,6 +2412,8 @@ int iio_push_to_buffers_with_ts_unaligned(struct iio_dev *indio_dev,
 {
 	struct iio_dev_opaque *iio_dev_opaque = to_iio_dev_opaque(indio_dev);
 
+	might_sleep();
+
 	/*
 	 * Conservative estimate - we can always safely copy the minimum
 	 * of either the data provided or the length of the destination buffer.

-- 
2.43.0


