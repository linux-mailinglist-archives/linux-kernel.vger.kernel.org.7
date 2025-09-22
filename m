Return-Path: <linux-kernel+bounces-826716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB7DB8F2D6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 08:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 399FD3A785F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 06:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105C22ECD15;
	Mon, 22 Sep 2025 06:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdPZHB8E"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5460242925
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 06:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758523091; cv=none; b=IdxGCsKdf/t41yH9ouFNvONvBFQjlXVAMlL1X1wf1O7oZ8C5/Gd81/bbw181XO3Yuz3utErfJPRRuS1BhYXWzFK2/cunEmXzobn1q3nyUWnu4cs4rl9N/kuwl6FkpJQQWAThc5bnwRPXchuDWkpQqmR2aG0CXNBVBI9eGtxbTDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758523091; c=relaxed/simple;
	bh=WIER8c2mKqkhk+RGmQeGAh8ClSePfIreHUbcG9aeDJM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KVAI+b8TxhXcIT04IhA18VgtJryNyJRw1UwYoQ4P6O1p2O8TM50URNzo5aMjdneGYT+zqGIjQcFhqCEkk4AjKDKxhNsWgBnnBmb7G/rDobhEYnYCm5FjozbePe/hTGcCNwesPnzV0AWR92PR+HP7OEltDROlZ44hqa0pKilR4A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jdPZHB8E; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2698384978dso33493855ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 23:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758523089; x=1759127889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kbZxxzNbGXKFGJ3KpKcsJGk+kSH40TJzWJbjDNAzLEI=;
        b=jdPZHB8EuQ5sc9rcDdA3fqY17jIV+dKSpz3nQnj7c4YpEoDJoVcbe+RR10VufWl6y9
         ipeXo2D7BDZBGw+yDmxsvBuRfm5aAL4kXWxpQandPYe1VsVicrsIU+q5VwELIefSkpKr
         K8iwCOFFyC/QKKLnMSEbdtUWrt6uQID8JxHWpPsllaqUg8Lg3GUlRxKb+pmR9b3eMyrS
         uTCRUbwrOX2wJvAyzGDU3tLMqxpceJ9Ft0QnYmMrd6EwJXh82wFfxQQZDNCZuVahueta
         hHVJSZhWoEHtu1DaOUwY+xtS25V909wxLze1fu1+hNjiEJ0tk71lOfcjJ3gftmnTHJUn
         Skgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758523089; x=1759127889;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kbZxxzNbGXKFGJ3KpKcsJGk+kSH40TJzWJbjDNAzLEI=;
        b=QgXaH/+B/alDJqcgFwHrStPRxs6mJnUM3atQwMKBCzN5kKTYrkRCBcl93ofSv8A8jZ
         bXcJjxmvQdc6XdVjiCDDuIB/O50Fu39tZ1jxur28HUImrgnsrMBhylh7m2A6yzMdXoJY
         JI4KIvl+8D/fybvgo1y0CVzixRF4Nzn0FyUZpLPmBlB/bSaZMSwGaAgosgDaxRZhAHKC
         v/8//E1JmbNbucNTbjTVSHZLsHzNk4nYws0YjSRgvXoDoirwlKwLNO1pu0AyXHbDE+2w
         ryFmwjWZUOYo5QTvAjWB9j72pYse1ia0dymoQFSdRDz2fdZRByaVlFTQ+/1khHRnYb9y
         qYqA==
X-Gm-Message-State: AOJu0Yz5nQNl303l74SQ4r338XsLKnp0TDr2LW9ypjYSNgKz/xGo26IE
	acZ0uS9Jo5ALlc3T9vJFwytQvQdwqGN+rERE6OeOYw+hYbp4OUckHnje
X-Gm-Gg: ASbGnct49fCFPLUjQAW8PU0hp0h+A2XfK4ygGoXieyEDWohe8VhuHHZBTL9PH4lwj8j
	1qoGQZ8zVRZFq/i+iT72F3Z0QV3XlyurCwgRdZaXu8ZY2fmP2t1k6OVSkWxxw5Vg03JpBaMVq7s
	Hvls+/51+rqzm4oSbLJuyH5Ki1GVVgdaOtKi4704QXvOb7VM8NWsZks0/Epx45UT40l2wfaRJJ6
	DToqX0eJJrSr1eOUyDFdpJA+KGlgzuM0DMfYOCNNAFbQ0PpgIz0vtoUM26H2xCXEKhv1WmCHc6n
	CvsHZ4RqgzLPkeh4lpgOEjFFOom4QAWgluroNvluHLrwKMC7NcETF6hu78uhZsN5J0NjkimC89G
	5i/LFa8JbOukP7OR0P4Ue1Q==
X-Google-Smtp-Source: AGHT+IEueJ6WL1Yk1kHKY6sJjKww7EG4lz99L2dAxOx0yuQwLDHaIcxLIKhyrFcPWMrloura1GOrSg==
X-Received: by 2002:a17:903:1b0b:b0:267:a942:788c with SMTP id d9443c01a7336-269ba3fa0afmr175389435ad.1.1758523088903;
        Sun, 21 Sep 2025 23:38:08 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698033d2a7sm119488145ad.132.2025.09.21.23.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 23:38:08 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 1BECE423FA7F; Mon, 22 Sep 2025 13:38:05 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux IIO <linux-iio@vger.kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] Documentation: iio: ade9000, adis*, adx*: Convert IIO subsystem cross-references
Date: Mon, 22 Sep 2025 13:37:54 +0700
Message-ID: <20250922063754.21190-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5064; i=bagasdotme@gmail.com; h=from:subject; bh=WIER8c2mKqkhk+RGmQeGAh8ClSePfIreHUbcG9aeDJM=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkX3uVFTLs6y2Pf129elw0Do3dILH92auvMBWbdIuevN TUpZ1ie6ShlYRDjYpAVU2SZlMjXdHqXkciF9rWOMHNYmUCGMHBxCsBEpFUYGV56Sqq4zXOpvM0s V974+kX4DL4p9+pvrth3t1FdvimAZT3D/7wSCef9YVNObxA8+P3ktHkvZrH2zPmxO8xDfNO7xey vHdkB
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Cross-references to iio_tools.rst (IIO Interfacing Tools) and
iio_devbuf.rst (Industrial IIO device buffers) are shown in inline
code instead. Convert them to proper cross-references.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/iio/ade9000.rst   | 2 +-
 Documentation/iio/adis16475.rst | 4 ++--
 Documentation/iio/adis16480.rst | 4 ++--
 Documentation/iio/adis16550.rst | 4 ++--
 Documentation/iio/adxl345.rst   | 4 ++--
 Documentation/iio/adxl380.rst   | 4 ++--
 6 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/iio/ade9000.rst b/Documentation/iio/ade9000.rst
index 43d4b8dc1cb72c..c9ff702a42512b 100644
--- a/Documentation/iio/ade9000.rst
+++ b/Documentation/iio/ade9000.rst
@@ -264,5 +264,5 @@ Configure RMS voltage event thresholds (requires interrupts):
 8. IIO Interfacing Tools
 ========================
 
-See ``Documentation/iio/iio_tools.rst`` for the description of the available IIO
+See Documentation/iio/iio_tools.rst for the description of the available IIO
 interfacing tools.
diff --git a/Documentation/iio/adis16475.rst b/Documentation/iio/adis16475.rst
index 4bf0998be36efc..89a388490ab735 100644
--- a/Documentation/iio/adis16475.rst
+++ b/Documentation/iio/adis16475.rst
@@ -374,11 +374,11 @@ Obtain buffered data:
         00001740  01 1a 00 00 ff ff fe 31  00 00 46 aa 00 03 37 f7  |.......1..F...7.|
         ...
 
-See ``Documentation/iio/iio_devbuf.rst`` for more information about how buffered
+See Documentation/iio/iio_devbuf.rst for more information about how buffered
 data is structured.
 
 4. IIO Interfacing Tools
 ========================
 
-See ``Documentation/iio/iio_tools.rst`` for the description of the available IIO
+See Documentation/iio/iio_tools.rst for the description of the available IIO
 interfacing tools.
diff --git a/Documentation/iio/adis16480.rst b/Documentation/iio/adis16480.rst
index 4a2d40e0daa798..cce5f3e0174158 100644
--- a/Documentation/iio/adis16480.rst
+++ b/Documentation/iio/adis16480.rst
@@ -436,11 +436,11 @@ Obtain buffered data::
   00006b60  09 63 00 00 00 00 1b 13  00 00 22 2f 00 03 23 91  |.c........"/..#.|
   ...
 
-See ``Documentation/iio/iio_devbuf.rst`` for more information about how buffered
+See Documentation/iio/iio_devbuf.rst for more information about how buffered
 data is structured.
 
 4. IIO Interfacing Tools
 ========================
 
-See ``Documentation/iio/iio_tools.rst`` for the description of the available IIO
+See Documentation/iio/iio_tools.rst for the description of the available IIO
 interfacing tools.
diff --git a/Documentation/iio/adis16550.rst b/Documentation/iio/adis16550.rst
index 25db7b8060c421..c9bbc0a857b03b 100644
--- a/Documentation/iio/adis16550.rst
+++ b/Documentation/iio/adis16550.rst
@@ -366,11 +366,11 @@ Obtain buffered data:
         0000ceb0  00 00 0d 2f 00 00 05 25  00 00 07 8d 00 00 a2 ce  |.../...%........|
         ...
 
-See ``Documentation/iio/iio_devbuf.rst`` for more information about how buffered
+See Documentation/iio/iio_devbuf.rst for more information about how buffered
 data is structured.
 
 4. IIO Interfacing Tools
 ========================
 
-See ``Documentation/iio/iio_tools.rst`` for the description of the available IIO
+See Documentation/iio/iio_tools.rst for the description of the available IIO
 interfacing tools.
diff --git a/Documentation/iio/adxl345.rst b/Documentation/iio/adxl345.rst
index afdb35f8b72e78..bb19d64f67c3d2 100644
--- a/Documentation/iio/adxl345.rst
+++ b/Documentation/iio/adxl345.rst
@@ -433,11 +433,11 @@ Obtain buffered data:
         00000f0   00004   00014   00015   00005   00012   00011   00005   00012
         ...
 
-See ``Documentation/iio/iio_devbuf.rst`` for more information about how buffered
+See Documentation/iio/iio_devbuf.rst for more information about how buffered
 data is structured.
 
 4. IIO Interfacing Tools
 ========================
 
-See ``Documentation/iio/iio_tools.rst`` for the description of the available IIO
+See Documentation/iio/iio_tools.rst for the description of the available IIO
 interfacing tools.
diff --git a/Documentation/iio/adxl380.rst b/Documentation/iio/adxl380.rst
index 66c8a4d4f767e5..61cafa2f98bf36 100644
--- a/Documentation/iio/adxl380.rst
+++ b/Documentation/iio/adxl380.rst
@@ -223,11 +223,11 @@ Obtain buffered data:
         002bc3c0  f7 fd 00 cb fb 94 24 80  f7 e3 00 f2 fb b8 24 80  |......$.......$.|
         ...
 
-See ``Documentation/iio/iio_devbuf.rst`` for more information about how buffered
+See Documentation/iio/iio_devbuf.rst for more information about how buffered
 data is structured.
 
 4. IIO Interfacing Tools
 ========================
 
-See ``Documentation/iio/iio_tools.rst`` for the description of the available IIO
+See Documentation/iio/iio_tools.rst for the description of the available IIO
 interfacing tools.

base-commit: 561285d048053fec8a3d6d1e3ddc60df11c393a0
-- 
An old man doll... just what I always wanted! - Clara


