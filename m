Return-Path: <linux-kernel+bounces-741558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD709B0E5BF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 23:52:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2FA11C85F6F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 21:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CCE284678;
	Tue, 22 Jul 2025 21:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="s0HNFwpy"
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E1E220F54
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 21:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753221173; cv=none; b=ZfHd/TDS4N0ZkHk0WUhmknYrAsQd/DjlJRa9LCoXj2HbwvlIsNRpfOu2rJfYR1Yd+6oXVfPOrv8WjK5SfRo08bAzuCHfRITwZC820TkIl4oLd9bnxXueGgGoIO0aCu+KvvxzWTuzVCr4td1H+5TF1XTq+ikUtiDF9KNZU1z6C8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753221173; c=relaxed/simple;
	bh=v2pwjQAwjOfWGq6TF4yQLTbl29WrWOQKd4awONVQcV0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=A6eQaHMywcNSaTRt6O9954vy9cFz9pOx7SnC4t00MJyWrNpy283ZQ2UDNAbmkfY2MTZgakN6e4/m3H+ONCl9Jun75fzxD+/y/Wk1Xo9pvNA7rmC3cfae2XlGavBQt/WGcNEeQVAy05UHFAF7auobz+3IhjvPtjqi6R0VZ+j8i6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=s0HNFwpy; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-73ff32d8b8aso164910a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 14:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753221169; x=1753825969; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=N3kD/kRLVYiXI7+ZhtS27j1tuw14/H2/ab2GI6uG6k0=;
        b=s0HNFwpy/Lc6GCnVgkXNi5NMAKr+uzkx5QTHkmBu0656nJAOF/eZMx4M1ZQVF3Q3b7
         e0tAe3y579rrjxQjwSoL6vYaOMv0+DObVdPDURg9++y6PjG95CC/9EdZ4TCKL+lnXhtq
         OfvMg/RaxcauI6DoYwLphpkvhjA6NeE9d+a+S6zVjkBmK5hVVRN2sY8EJqotij40yoRR
         W6sWbrvv/bXQs8P5KHnMKLXGjH0dMK0IvXtaemI/ifs/MjLzFSjvBvo2wK4EnO5fKhlZ
         tUbFBRT1bI32BYwyjHnGpmaa0GvldZt+svNUFCLR9oX7KYEzJR+GMuh7WiKihu2sMuBB
         1yDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753221169; x=1753825969;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N3kD/kRLVYiXI7+ZhtS27j1tuw14/H2/ab2GI6uG6k0=;
        b=d6Pn7AYBSpv1l1dM+iaB+JTHPBW9IeCJyNlELZ7Ulp7/LVltKgiUG3voyn0AlKwX38
         yhww+twELHdyuOoBzz4M4Nf9iOcHSOGl7negz3AtI/gLUNd7CXLVNm/sWDmnQ2WFS/BG
         PP1XygFkCse2kjBj5H8aJdVR57lHF0RsthH1YyIhjt8C0iRTHYANDW/rDURX3Q/mQL8a
         uiFGbq2SYnvu2XOnPhVZvAHIQBWBCKfwxZgLfJRi5J/rKyGUst2ldHKQGo/kQ010t/Kb
         juKwsyvWTFc4ygwt1o6NT6V/NH7WBp+VUBtgtxvhUOPMA9+N7NGHZgZeYH7kVgO5nyav
         A4BA==
X-Forwarded-Encrypted: i=1; AJvYcCWnc6EWbV4p7H+oavdHr1sM0kQGOYRRkv6k0/bscHM0neWm647M0GXMKpOCg+cq87n3+lMc1aBpToBzm3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBEcV9DeDH/3HiGP2DMLHFALEgMSW2rIcOM+1O+lK1+q7XBZus
	xR7I4wQqfxkjcHrOFtQTXVdrsE0JqCbIfupgvTicIUzC9yQgj8BycGlvIEjdwytvuqw=
X-Gm-Gg: ASbGncseKMhnwwgfNpTpuIzVk+t+8i/H2K4J/0Pp0Bp/5fInNnlqKQZlQoTI19iBfTQ
	SP/mc3lK7oNrtCKxUtUqHHy3RSAUv05OWolBhrhyIHjD1gex4Ofes5I8ukWfVyWiDBInuR1fFbg
	URkneDc8GUE+9Bripj7A+vu8PdSSZFQAiQAwEZ/92Pxu/Hivjvs3jCTOt7LlfscBYFA/aDa8XUb
	f2gwbwy697IyaSHpcatVSMP7eR4LQ6ml4FgTjfs9CJkoMSVqgvU+Q4FDgx4by/P8Bn82KaqgWzy
	ChZKF9CHpxpaoE0GOHJ9dFsVjorgUC1y4wp4htdOQl0BZmSeU1FPXtYDNI6bIHxv32roP52SM2C
	pGkfPIe62D37IQQ2f4Y2x+LiIuhFq
X-Google-Smtp-Source: AGHT+IHWtbFwx4H3f8oW0ot6nPWB5iPqH7dGagqR2/1ALDB69cOPsol6TVnxS7tDf3BrrWgjUR1hXg==
X-Received: by 2002:a05:6830:6484:b0:727:3957:8522 with SMTP id 46e09a7af769-74088ac1d3emr562275a34.20.1753221169379;
        Tue, 22 Jul 2025 14:52:49 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:2a79:4b55:6a01:85d7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73e83b06444sm3793483a34.37.2025.07.22.14.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jul 2025 14:52:49 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 22 Jul 2025 16:52:38 -0500
Subject: [PATCH] iio: fix iio_push_to_buffers_with_ts() typo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250722-iio-fix-iio_push_to_buffer_with_ts-typo-v1-1-6ac9efb856d3@baylibre.com>
X-B4-Tracking: v=1; b=H4sIACUIgGgC/x3NzQqDMBAE4FeRPXdBE1Toq5QSot3oXkzIxj/Ed
 ++2p+E7zMwFQplJ4FldkGlj4bgomkcF4+yXiZA/ajC1aeveGGSOGPj4pUurzK5EN6whUHY7F6V
 gOVPEfgjW+sZ727WgaymT1v5Pr/d9fwFEaa+YeQAAAA==
X-Change-ID: 20250722-iio-fix-iio_push_to_buffer_with_ts-typo-7bf33a1aa365
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1812; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=v2pwjQAwjOfWGq6TF4yQLTbl29WrWOQKd4awONVQcV0=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBogAgqdI7JJBtJw3v1RcJC2522e/JBY0UJ9elrR
 g+k7EmgsSuJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaIAIKgAKCRDCzCAB/wGP
 wKyECACUBQV+eb2DpCP9F0cppawj/hci0Ds/tz9YQfkbGhGiA9g7oryJIMB3UOw2oiuMe8gXySx
 0j2SIPrRxwbrdxvs22QD3iLC9l3Pq09c4Pif/lszDF0zSZtSDw+yIQxy923FiFny+7MRotGAH20
 u90nR6UZqs04pUaiLzDY7AiFIVI5ClsbzOEgwhzVD0xkMvh9PR4lJS3gPF4LNNVhUzX9Zfrd9xn
 q2mQka9qhn85hKfmhgXthtuOR5B/v2y4uA0dnii7JuwW3ZzrcBRDfXPhCxy0CS+TLMdAtyEDsij
 wsjr/XsxiLMA7drfXEgfY2nIbeuLAhas5hhYGwF5MvuSz31g
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Replace iio_push_to_buffer_with_ts() with iio_push_to_buffers_with_ts()
in some documentation comments in iio.h. The latter is the correct name
of the function, the former doesn't exist.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 include/linux/iio/iio.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index d11668f14a3e17654fcf17a4e853d4b493205019..2f5560646ee49052deaaaae1dd2b92b21c4d4fd5 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -779,7 +779,7 @@ static inline void *iio_device_get_drvdata(const struct iio_dev *indio_dev)
  * them safe for use with non-coherent DMA.
  *
  * A number of drivers also use this on buffers that include a 64-bit timestamp
- * that is used with iio_push_to_buffer_with_ts(). Therefore, in the case where
+ * that is used with iio_push_to_buffers_with_ts(). Therefore, in the case where
  * DMA alignment is not sufficient for proper timestamp alignment, we align to
  * 8 bytes instead.
  */
@@ -794,7 +794,7 @@ static inline void *iio_device_get_drvdata(const struct iio_dev *indio_dev)
  * @name: identifier name of the buffer
  * @count: number of elements in the buffer
  *
- * Declares a buffer that is safe to use with iio_push_to_buffer_with_ts(). In
+ * Declares a buffer that is safe to use with iio_push_to_buffers_with_ts(). In
  * addition to allocating enough space for @count elements of @type, it also
  * allocates space for a s64 timestamp at the end of the buffer and ensures
  * proper alignment of the timestamp.

---
base-commit: cd2731444ee4e35db76f4fb587f12d327eec5446
change-id: 20250722-iio-fix-iio_push_to_buffer_with_ts-typo-7bf33a1aa365

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


