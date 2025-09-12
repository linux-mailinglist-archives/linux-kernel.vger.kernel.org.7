Return-Path: <linux-kernel+bounces-814469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1229EB55478
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 18:08:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCCBD5A19CA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50B431DDB4;
	Fri, 12 Sep 2025 16:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ApXI3buA"
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608D031CA5A
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 16:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757693222; cv=none; b=EBIxhGRngCGR7Y//YYavD+8Zbc4jIpKU+n10V4U2DDImNOesy3wx7K5Jgqs4RNbAnJRRKdZ9OalqN0YIf2coa0AiqeuJUvwKPcZEtn9IM9fHvxJrnn90ryRdqwrrDcJoDXRFnDGyNd/A22sBbI4Tfit+UKUOQu+dyiOKVlncTBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757693222; c=relaxed/simple;
	bh=7TqvcYTMBp51/HUM9YZ5b9Xwf4ZwYLxzxeeJRmV5Wp8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U3XyNyUDVcQOu4ED+ZGO0HYebViiTGFwuc0hXdQmVPKWYgsL8xedCRARCUPV9csX83LlYG5F576WheYB987E4aZdlO/R2gGIp2wkY6RcYInG9jupyKXKkXOrnvspqp09C05UmLtfl/1LvleNm1houDe5w1k2Bk2ZAGcJ9VyXR+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ApXI3buA; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7459de59821so1898037a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 09:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757693219; x=1758298019; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qarimMMaMap40cHQ862INRj1ctQccJze110lxw4H9TE=;
        b=ApXI3buAH6MS6fB+GlsXaD/0SBig6KoammngD5DbWMgRcz7ntvKXbq1+yx+/Zc9oF5
         l6d5IcdwZooKmkUHxCtmeF1qRjxD8OkwthnjVIrjpMXFgitWZ62kMNN0yPhE2AA9Kb7C
         NpFUSz/Wjq2ojjvOuDDyK40dZDEXigcCtBXcnEsUH/AFnZNE08HksjhCoB0al9IvGm9Q
         BLptMVRCuatMoPLce4jglYr/BYL3NbFw59vyWzVMkdAxFPkAG8jiXR/DgJB9uWNPhWtU
         ObYRJO6QkR20VnIL3FSYGOx+lzJmpUB1dJkaBz+a12QZnXzXcgUgK/C/3uCxG1jKEIpp
         FDMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757693219; x=1758298019;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qarimMMaMap40cHQ862INRj1ctQccJze110lxw4H9TE=;
        b=bwe0/JhNVYW0z9UVc0mWaj48ABqVasAQQYvVU3IoIyqKPX8vuOpy84fFkI8Tjp+Wu4
         Acg0sMoOXElKX3N73eTNlHcDbkkLlxlczIOMqMri6BKzkq6I8B7nchAx3ymhOyM4m0yD
         zp9+7gtxBRsmNAzo19mabBfeQhDNibpi9UNOXajZMYfEh1SdC4HTtYBSo76nLksjj9X4
         VhwoVazO9fjZpLM/9WeElMKRFoEvCTD9hFY8wD9i4VaNFux9Pt9NBW/F5bAno21tZH1/
         4EUl/iFq89DyzZ3UAS2hPk/GPO9aNwb3sSkP0jtKjo5c3bFi6SqfofzIViYWP0ddi6ik
         LE/w==
X-Forwarded-Encrypted: i=1; AJvYcCUMKnYJQh9rx+TWtx/eTQ4ZTLwnQIfNE+7BldrPYDdJf4JHb7mdaX89uSudPSaB/3ZspHWf/Z87rb5Dljc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhlkARgpA+e/UqdK3KTskjJ/6mdhQwQ8DDbsyh4fJgkzUQlbnl
	+A3zBUvCxFz0j0yOURYhZs/AAZwTRqWSKELZI6VSSSRxBVWTOKzneO71GYobndXmrwE=
X-Gm-Gg: ASbGncslkUTA7pZnhjxaXNxrVcsOGBnG6nybexWnmJYIZrV04cHGVbzqskmUshU9+zM
	7QrvHmAJBqSJmktJRsxvbuxaqoT0jdV4ztfvHhE8PtnDB+9rqKLrc30XWWK0B1JY9bYOj/wIqCl
	wOIDiCYMU4f6evu4uavxYUScAQTb3w6XL5Hyaig6nbyckDZO0CSXI2Ed3pRFJlGQViLOgst0jUo
	F/fW88Wib6K55lAHdlRD32GfOieLSu9zB8ulsZ/tneXBzWFARPNqs90BYoBmtc0K2CrlqXRYlNt
	SYZy7vnqkqWw412TuNRTNP8HjvcsqJJnOATzbR8ZgeqjxSFRQaSdgJMU98/7oNo4vzLthLqPO77
	i5jkw8D92f6AYVZR5Yvua64/m8W/mn7DoPjaNxWE=
X-Google-Smtp-Source: AGHT+IE9e0ybyQKyJ//4kGPLbVl7PIgqS7VfHCK6F815HZBFYxMRTycI2FtsrSV2yYmsxyF6/hyorQ==
X-Received: by 2002:a05:6830:2a0e:b0:73e:8c8b:749 with SMTP id 46e09a7af769-7534fb80fdbmr1972971a34.0.1757693219400;
        Fri, 12 Sep 2025 09:06:59 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:fdf1:f11e:e330:d3c1])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7524b8a39ecsm1073863a34.23.2025.09.12.09.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 09:06:58 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 12 Sep 2025 11:05:55 -0500
Subject: [PATCH 4/7] iio: buffer: deprecated
 iio_push_to_buffers_with_timestamp()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-iio-doc-push-to-buffers-context-v1-4-c4aad013d96e@baylibre.com>
References: <20250912-iio-doc-push-to-buffers-context-v1-0-c4aad013d96e@baylibre.com>
In-Reply-To: <20250912-iio-doc-push-to-buffers-context-v1-0-c4aad013d96e@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1229; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=7TqvcYTMBp51/HUM9YZ5b9Xwf4ZwYLxzxeeJRmV5Wp8=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoxET+EJWYdQcYzUzsp9PpgPfnKKv+VZ6ATmTtR
 8v45AiaQYSJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaMRE/gAKCRDCzCAB/wGP
 wO2OB/0RD7F8XblbmZb46MSGf0H/G+n0y0/cLLx62zICRmCS+uOEJ20tCR5dztCnXNneYsq7Nbs
 UpxXnyxZaQ41OmRfleXqJgMQRhJgu0/Chk9rerrmdQNwuHpMd5RcNk+7vutTVwdIVebvTeSP62n
 s4PeRVnR4XtplcouUtwSl57pk6Xapq479vfPZJ2EaOfBiBEDl/GPa+V3ubfiO1YPfBYxkk21pAD
 YSbuz9THFWk3fJ5etbtfj7nupMCNBzqsb9br+NSsCfaaEWG/UpU40+VFtXJ5O0lumtIgWOSn1qP
 tKyfg2noBPxtmzPehzk2px+PWxrH4vBSPZKZ7RBMFt8Hsiei
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Replace the documentation of iio_push_to_buffers_with_timestamp() with
a deprecation notice pointing to the preferred alternative.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 include/linux/iio/buffer.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/linux/iio/buffer.h b/include/linux/iio/buffer.h
index 47f23bc0470eaf308fc3a739faaf9b56cac0ef67..f07f6bae0cb25b0f51bd671206177508d1064b79 100644
--- a/include/linux/iio/buffer.h
+++ b/include/linux/iio/buffer.h
@@ -26,11 +26,7 @@ int iio_pop_from_buffer(struct iio_buffer *buffer, void *data);
  * @data:		sample data
  * @timestamp:		timestamp for the sample data
  *
- * Pushes data to the IIO device's buffers. If timestamps are enabled for the
- * device the function will store the supplied timestamp as the last element in
- * the sample data buffer before pushing it to the device buffers. The sample
- * data buffer needs to be large enough to hold the additional timestamp
- * (usually the buffer should be indio->scan_bytes bytes large).
+ * This function is deprecated. Use iio_push_to_buffers_with_ts() instead.
  *
  * Returns 0 on success, a negative error code otherwise.
  */

-- 
2.43.0


