Return-Path: <linux-kernel+bounces-814465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62897B5546D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 18:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0642BAA8164
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A221DE3AC;
	Fri, 12 Sep 2025 16:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="c+gzG1O/"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F154D28DC4
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 16:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757693214; cv=none; b=nJlKcRvX3f3E+5Pg5ZeVPvqzkybIHldpQ/IwuftVMosiwnloeRCkYQWO/WcWro88KkE39+VPHhZWJdDXji40kPFIhvV49G/82kh9CzYzZAxo+eOo5P1o7koid/yYQ+rqppOL+yoxY6ExDmfSN4dZ2FAwEC+dsa/rPVqHcrP0Myc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757693214; c=relaxed/simple;
	bh=VpNE595yCdSeatal7vCh4ifyEZdobn2WH1Bf/R8GOS0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NGUeJRVVxmfE08Utx7PSYtMfffrlYIO9IYmtcNAC+9nKfLy2onT28zQRtMG/5T1rBnfmzlGq4tNlHdvwVULpLLwCa/PWaAhlTFVrEcuWReLzVuhO7JbPk7AGKzT99lLIfEgduNw6gBERDftp6Vy8TmAqizeZUXbpA1aw5d2gN8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=c+gzG1O/; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-746d3b0d926so840201a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 09:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757693211; x=1758298011; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gPGBKA/NKS+g70XoYGArtCKJfE8klIJC7bmaO8UeETE=;
        b=c+gzG1O/ROdSEvKKFSAlZ3VBKP+jUSoze7qmeYWjeqqttywKtGHPe8hpVUr4rDDmqJ
         r5ylW5k+sUQsmWQhQJtk3VXX5TWrv894ixTXeCnIELhGVgm8udfWEfxfsIVmuLxkOhmH
         JulyMzHmRcg0h/9LoHCB1OdfnRbSilBB0hUqdQlJjqj3Xrc/zRKdDStWlrfmZvGKyO/B
         R1jni0kmaM+oXim1CC7nyMnLqhI6UDNgduG+2ZC8cv6fom7TcR1iFQh/BPuVXrnaJ8B8
         WeoqQmzZVkL1ugkQ6xnHGl1lSwfte7jiIdyEZtWWlVpgx0RNhr+98wxF4StTKnaEL03k
         5bHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757693211; x=1758298011;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gPGBKA/NKS+g70XoYGArtCKJfE8klIJC7bmaO8UeETE=;
        b=OTsZhr1HWkKug1ZPpQQ5vussCLnVkTi6VMzlpLOFR8rBHX8Qr+Xa2ZjNCqkVyMPp89
         SJA67trSXCHQoq1fSk1Lh7v1302FHDPjLxXXxTeP+7UeEAGVlbevW2yxoe4jjkoQBFm4
         AZ4m9cLAeF6E3Heke2tBjRxDrN7GzFNxIaIu8SuIwgeXU6rgQUwP718zbwwitIfQ3rVe
         STNaHx2qNU2rqHByM/dta0RSpSY4Zb7tsbx7K0uImruuB7U5zbc7MrZBbr8f/RJqyrim
         uJb6QCxlY86W/qcirA9heaVqThw12kUgp/j/QpCdi5bXkkOtxxGzggmmUMsFQyoan4of
         beaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUviiCUb8t9TGNomiGUYsdF1q6c8O4mJ/LjLodbHV+n619d/J7JHIODXGR2IExzpbjPHYmPPRSOdefTebs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmoiYycnwStaivqkh0U3P0+LovkIOMJLGgVrnFwzG2F+28mdq0
	ugtsxYL04Ou9apu9JV6uMSDCPlXVN3e+7Kxrd8rCwC7oi6A1YB+B63EKXvYshZlvZchz/IKdXDT
	bPtTzxHQ=
X-Gm-Gg: ASbGncv7SqVviPBB5qOcvAL6O/ucymc/JX/jg3D+8UE8uxl1ziWBc/r1kupSqfcPhrI
	lOfzlcoikx40Z67zeY4ttaE7CoIUtRrSDHBP5E/1U68FJTc1z6Xt6PKMAXPebnk8SRXz/T0ADE4
	9N4RNjI6VueWeCJ/uRw0uPj4TSEVNpCB7dabCdbXcWsfswYZw2/+HZWOvsvWVv6+tV//GVTH0/B
	DdxRmP56BC/ZR08O1WAr6BttwpVCtENnEkqh9wKorAP6SrD0ipT7iDuu7uPBf4I435ycd62+Dd7
	vbKv5Mb8RHtVGq4tZQSOdIuPOJY5vjS7Zw3gioQhaPArHGj3upCGEKLb1J8lgpeeVmkyCRNFPOs
	hilIy0UCl9bLQrn3jXFmMmjAVBcNQ8E4AvmVypxNE2IT0uqQ19w==
X-Google-Smtp-Source: AGHT+IHMKnNk6AgBVrbblYvZ3wRj4uIOwWUYQEE27u/iIG0IIr4sc/5n0JqYHN/eN+TTu/8FNu3MoA==
X-Received: by 2002:a05:6830:6383:b0:746:d640:71c5 with SMTP id 46e09a7af769-75352995a82mr1898298a34.7.1757693211033;
        Fri, 12 Sep 2025 09:06:51 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:fdf1:f11e:e330:d3c1])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7524b8a39ecsm1073863a34.23.2025.09.12.09.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 09:06:49 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Subject: [PATCH 0/7] iio: buffer: document calling context when pushing to
 buffers
Date: Fri, 12 Sep 2025 11:05:51 -0500
Message-Id: <20250912-iio-doc-push-to-buffers-context-v1-0-c4aad013d96e@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAN9ExGgC/x3NQQqEMAxA0atI1gZqZWCcq4gLbZMxm0aaKoJ4d
 4vLt/n/AqMsZPBrLsh0iImmiq5tIKxz+hNKrAbv/McNnUcRxagBt91WLIrLzkzZMGgqdBaM3Id
 5+DK5yFArWyaW8z2M030/Xe4MbXEAAAA=
X-Change-ID: 20250912-iio-doc-push-to-buffers-context-df3ca98fe0df
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Andy Shevchenko <andy.shevchenko@gmail.com>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1412; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=VpNE595yCdSeatal7vCh4ifyEZdobn2WH1Bf/R8GOS0=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoxETiJRnWesgQhq94bDBDw0lFSGqBHLEHARRj2
 gdUHJjGRfOJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaMRE4gAKCRDCzCAB/wGP
 wP0sB/0b45i7n+GtQb5HuF3Fd4odXQ0tWeBAL+/aTZCZZfNThLkyKLZqsjuH4R3nTmzgUZNvTct
 lBClt66K1MsBjzHus+BDG5DHGamhBQCIF+o31npix6V96Wb9b5WJMxZPUi1oB6IBYuJ059LuOUd
 camjkk0gEc1vriQBuZvA7q/3wI0dkN39FjELVpTIH31muI0wRZ+pWaxras9aiAD1TkHZBD64S5W
 PP3Ph1P21XKK/VnfkCDoZqbxABmjyg26n2dK2pUzlFNhkqKf6PTa77s39Va2Ev+yyf0WIBPpsv/
 QyY0k2QYoNimev1ppSPx5k+FEfRyaFlAEmqSOIfs50g021zd
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

It came up in a recent discussion [1] that we need to be careful about
the calling context for various iio_push_to_buffer*() functions. Here is
a series that adds some documentation in a number of places to make this
a bit more visible.

[1]: https://lore.kernel.org/linux-iio/CAHp75Vc8u2N2AHWtnPRmRXWKN3u8Qi=yvx5afbFh4NLNb8-y9A@mail.gmail.com/

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
base-commit: b8902d55155cec7bd743dc1129e0b32e70b1751f
change-id: 20250912-iio-doc-push-to-buffers-context-df3ca98fe0df

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


