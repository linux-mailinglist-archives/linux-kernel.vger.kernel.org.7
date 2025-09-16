Return-Path: <linux-kernel+bounces-819601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2339EB5A38F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 23:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E04F1324B25
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 21:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC0A2F9D8B;
	Tue, 16 Sep 2025 21:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Z+sQQf2F"
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2652E8E11
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 21:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758056641; cv=none; b=dKDh7FgeTcCPJEd4sbfvqUr209mDalUTVbdUtHSVmc+yFGocL03fKsFo/S+EeQvDWRxRdhGKJptz4jhttFiIp24ecaq4K5EcLged61mFpi/1R9da7Vk3+2rWH5AcIdEkRw7debQEjMn3RmSmqQ4FqpZ4WBZY8gvXfySmUdmRJ88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758056641; c=relaxed/simple;
	bh=1rybI1vv2ITY3eTCg5sjd8Ca20nUymlp6uw8bi3cmFY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uQtEE/JROrNVXpNxc/bBw8wDYEF5AJKweVi+qHbIseJ/RPMRbrhptEbDHO6wKvreErd7ZksxMJqIiuCD53X5fy236Oy2X+XwtcI9gGAgPBrn4moHq996rMflg30Bm07oEcj7i/Lt5jK0CH1BAoGkN/T6re7VshCCrt1DGAaWiDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Z+sQQf2F; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-621a79a580bso863704eaf.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758056639; x=1758661439; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JY9SnjW7f5B0pmsb28wOxPI4e7Ywa7AqmRhphChUkDw=;
        b=Z+sQQf2F9XmFUuDx+ilnIwAFPJccKV0J6fV8SvBtIZ4AvUedu0Vw7zjhf29R42hQW0
         JmQMysyKXlhOSahINib5AmxicWLr1KZdDrOq/D9D5zHQfmgaGOCapl6K0ExH3hOd7QMH
         DUNohPVIbqnk4cPnW04RHxVGiaXLGu7p1Wdp6YCpF/HUgDxDHYxcVq2aJoyNteXfyryS
         GhhJUUT8E66S8u/5cZiRWrLv7v5HYxoyhNr5agOuP1Bwl6DnTf6MBaqIjwwZ5oM0a8bh
         fe1JboM/1vy3whrHCPRIYgoVdoBgQnhmfLoLvu4sWA/2G0Jk7eiUWbmPk7sYmoJq6aEJ
         bzng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758056639; x=1758661439;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JY9SnjW7f5B0pmsb28wOxPI4e7Ywa7AqmRhphChUkDw=;
        b=d+3gwp+zBmuY+vUNG+ir9mgQ1vhEjSjrbLldJx1UH0ao6EAEoTEGsR9hXUfnapCoyw
         v+hqh7yTTm4Z3jBYHGV6/Fr3DNy6D+m1vjAY+jGc7lH62ZmkM9LTgzxbSv4FIgQDad3R
         ItgeBXjX/ms+qKkGrxEBXeNNKwb0g3bwh7USzpAXYWOJ1illdtz2msiLd0TQqgAte2VX
         gr0muLFQc7fCxJpRvqbLJVC70+S+5w9mPCSvfANn1dlNKOTrHsOOgMzI99YS9ncEppd5
         JhbSMATktsgH2F7EfBNf9OlP4uvX63bhgSvdcY0x3QtK67B2o94LShmJFvwgd3594PZ3
         5xPA==
X-Forwarded-Encrypted: i=1; AJvYcCUzP8GVYwGu4QsnKTqMxORsZ19M0huz7fhr61fnqOqhimV5Kj86/Ir7iPjBcEoeLk5CJ6Yffk4ii9TaIao=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy60rH3nw8rB+IUoId90CEbDATfc4wJbrBCOZb2eZ8S58VOurH3
	qmNL5yV95bJV7E5uw8vW+BzapwOvR6UgGzZxLdO9LrIxBNHmBsZ7UF2FIUFI8D0FHwG9/8ygAV2
	mjnUVi4U=
X-Gm-Gg: ASbGncv80d7yIOn1LP0z4qEQ/8Nd8oma0ePtWLe1sbyg+oICOmNkKh0cGzQdA7A8fkg
	FLnU7HcSz4cOuZod/TcJQy5rXwYG7MxTpTKXdY+XFxms5V4TdE0Taj6b5kpqSMQbY4pU1RfK8lx
	+sHxPSiJH3D//6/YDfjkL3Zsprms7+5kB8s8z/iBRiJWg/gCihBswPPgh2Y73WyG4NaqIrigVpa
	JYqKi1rM4MBHtmkGhRi08tAhZt2fI1e4DGZ6rCEIGe/1bcb2b3lWKYz5dBKBSa5JvlN7yOCn9Iu
	MHQUrLwrlA/SNEg2rWKi/og/PEYhFY69NdBbPprcJoIWnaXdl7b/kVdTfDiTZQofDwEYnQD6k6o
	74VoJ7hURZnxqn+sqpZEucGqPSWeJ
X-Google-Smtp-Source: AGHT+IEHk33BZosh1i82c+nkRqYDNa/fiAbvNdbuGZPqdth+nn/NaiG3YhHp0+u05SSLYemTqG3NNg==
X-Received: by 2002:a05:6808:2386:b0:43b:252e:f7a4 with SMTP id 5614622812f47-43b8d89ef9bmr9876190b6e.1.1758056638874;
        Tue, 16 Sep 2025 14:03:58 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:70a1:e065:6248:ef8b])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43b8294ac06sm3540044b6e.14.2025.09.16.14.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 14:03:58 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 16 Sep 2025 16:02:56 -0500
Subject: [PATCH v2 6/7] iio: buffer: document store_to() callback may be
 called in any context
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-iio-doc-push-to-buffers-context-v2-6-8b17937a6cc7@baylibre.com>
References: <20250916-iio-doc-push-to-buffers-context-v2-0-8b17937a6cc7@baylibre.com>
In-Reply-To: <20250916-iio-doc-push-to-buffers-context-v2-0-8b17937a6cc7@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1064; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=1rybI1vv2ITY3eTCg5sjd8Ca20nUymlp6uw8bi3cmFY=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoydCnCE+nGFzQbaNy47/VytBgYM2YNKa1n8bAW
 xHGsn+TYj2JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaMnQpwAKCRDCzCAB/wGP
 wIGuCACEUGondLKwjNccm6CTYxyo1glKuJaW7oK4uWxOu61ouCVMy7zlFXhfjvV4enm4QJtMykD
 AOQT+HMJaXF2VOHT3F3ohZOc5hDds5ix0DUNi7NjzMm84I4F1xLO8E7/LpFxRzuzoQ0CF5wji4J
 ti14t8oikpcZVMS7Ez2r43vs+/Lf/nkhjzgoXteZ0kHF0YoPjD2FszS/zAk7IWgSzZQObtxMFqj
 6DMflm3Cv9dP5cGC9sKF73WZsHLRLY4ObtnjO+2DczsFMdhHSxnupKXuhXRgSE3FByWVCf5kuv/
 O3GsITZstGHDzm4hcU+jyAlfQeae/b8fWg4dWqukIH/K+QlK
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Document that the struct iio_buffer_access_funcs.store_to() callback
must be safe to call from any context since it is called from
iio_push_to_buffer() which may be called from any context.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 include/linux/iio/buffer_impl.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/iio/buffer_impl.h b/include/linux/iio/buffer_impl.h
index e72552e026f3a3c15fca04d26aaa91dbd27e17bc..0daff9ff20ce49de67fa0f2ac6191882de2f4a67 100644
--- a/include/linux/iio/buffer_impl.h
+++ b/include/linux/iio/buffer_impl.h
@@ -24,7 +24,8 @@ struct sg_table;
 
 /**
  * struct iio_buffer_access_funcs - access functions for buffers.
- * @store_to:		actually store stuff to the buffer
+ * @store_to:		actually store stuff to the buffer - must be safe to
+ *			call from any context (e.g. must not sleep).
  * @read:		try to get a specified number of bytes (must exist)
  * @data_available:	indicates how much data is available for reading from
  *			the buffer.

-- 
2.43.0


