Return-Path: <linux-kernel+bounces-814471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7377FB5547A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 18:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B01DAA8259
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6BE320A11;
	Fri, 12 Sep 2025 16:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="tmvTEtqz"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B32D320389
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 16:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757693225; cv=none; b=UHeNqiI7ubxp/5lBc9+jbqp9vvRg+QhS+42NdYOKhC6Hga4h/lLrbr9FtT2xwuVeA/ff48gzhlX4+L4iUsWe/qIS9Dni+lNwgIk7zLkqUxaAsG6SYMePH4Qqod4mLoa/PzG8ZCH6aPNZK4cq2Hs0lqkgHnNaoAE8lzRsyCWS1OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757693225; c=relaxed/simple;
	bh=1rybI1vv2ITY3eTCg5sjd8Ca20nUymlp6uw8bi3cmFY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KrpJt7VjKBtILzwFOQ5RVR5FHBPOre7okrl+VlFjdDh4PHehscZ3SYbikTTeFYwOnSJKU0T9cnngW6L7MDZgQSBcgCBgJftuBH1JEjqC1xqBgUNalf5LNJV8VnpIgoJpxzKss7ZQaloaxKgEeE4W9iXVuir15aguSPMxPncBXmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=tmvTEtqz; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-61e783a1e00so1265171eaf.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 09:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757693223; x=1758298023; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JY9SnjW7f5B0pmsb28wOxPI4e7Ywa7AqmRhphChUkDw=;
        b=tmvTEtqz57PZdjSjBqMRnzRxWHo4pXFhDwIy9sCe7c3QpdSCyOrqoKi1yo0ky2Az3T
         sO9SvdSqTA0vQb6fOlj9sbktLwW4/wCzMGmssVBzjJ8L1qe46bqbbfzRYMAbH4f4BesZ
         Uj+VOL4EYOVO9MA54LxQqkaCFNGpcggvKKZS4RMt3gF+jU4F5lck35bYbVaXOYqYfvij
         x0BC2IOghWY+h3DVqNtSt7382YC18h1YIFRl0mZKp90kNQDYxNGc3Jm9CQu69gnCKiu3
         smCg6OlH9yhDwQ2LzQwObkTGYWt4PvTrkcn+Z6YVblDzmDoVCQPXVAhJOf5xkJHktMsh
         kaMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757693223; x=1758298023;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JY9SnjW7f5B0pmsb28wOxPI4e7Ywa7AqmRhphChUkDw=;
        b=PDwhlp1sOHprwVgV3WRFS8n3Ul4aXKEjTZuuO228wW67FdevDvQfjp+IwLLIysSnDJ
         fWt2XlFMNNhDYcxKrqBpKFJdZ64FtBUPANzKTzRTyHrX1fZ5HLKgLt8TfIamic0/BbSp
         9EnwnfQPAbUP3FoXaljTlC2SX5oCh7sm+qUEJFZf9KyiSeE/gBS03Gr+NTs37Nvl8rLR
         uXc5ynCbc6LN1mKGyhl5yCkZ+aRS6ihw6x48KMN399CyogOSsov6YMeVgti23tD3psdq
         ZwKo9TvtqkuixMfvmq6+QEkNhTuaUbKllD/LMkizhtP/zJtLL9pzUm09YxZrh95d2BZy
         zulw==
X-Forwarded-Encrypted: i=1; AJvYcCU/P14qE+/+b5bSuGZ2LI9UzP2n1B2ZpoMkMphb16CY6khLX9aejNu3CW13C1+r4iONBgG/OqIegbQg20M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL9CLLTsh9dIIB4XPFUeLEWZCou+dpvGwBGY1EX4kO1VTALdQ6
	Ge6ZS+BmaxAO9IZmfjM013IZXdzGCbFqaImKSke7GJgCOpUkHrkTMeaqhlV/10bZHJo=
X-Gm-Gg: ASbGncs6+1JZ1zVMLTV+cj7JGf9Q4Uo771eCsBMPxrMlw9mipZ43DwS5T0SH3Wn8/YN
	FygTjJlGYiqDBHIZmFBMKCLUw9bDrPOyLzvrK6YHZDWRi84vEiUjfQPYq6zdPBhDQTvt5zd5tmm
	n8mtjdIbFZuX4FeqrYbH5uvWmJh0njKniMFEe1fyUZ1yubzw21e8pGxCcGmny9IVhj8l6I7yCpY
	ldwktwnQ4Rcruz9kESuChDIqd1K23w+ywABmlN7Kq2c4kFFVw9vgA6Eq87h2f52Mk0B6dpwP8h8
	gPhpwphkpEGenwmhe8XC+Jw4YKYSKnTQ5N4RZmum3xO5laiaSqqa46iR+xc8TMD9vYb8O6OnPaL
	6Lo+GVE8G0y7ws+Vxj6YpnXGUhEKM
X-Google-Smtp-Source: AGHT+IHMOztiaVGzRz7rukjpCk5kdql225PnQGUNUIhnzM3TiNlqeaD37c447kUVVSWjrGASmy1PtQ==
X-Received: by 2002:a05:6808:1513:b0:439:ae79:5643 with SMTP id 5614622812f47-43b8d8882dfmr1392931b6e.3.1757693222992;
        Fri, 12 Sep 2025 09:07:02 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:fdf1:f11e:e330:d3c1])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7524b8a39ecsm1073863a34.23.2025.09.12.09.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 09:07:01 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 12 Sep 2025 11:05:57 -0500
Subject: [PATCH 6/7] iio: buffer: document store_to() callback may be
 called in any context
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-iio-doc-push-to-buffers-context-v1-6-c4aad013d96e@baylibre.com>
References: <20250912-iio-doc-push-to-buffers-context-v1-0-c4aad013d96e@baylibre.com>
In-Reply-To: <20250912-iio-doc-push-to-buffers-context-v1-0-c4aad013d96e@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1064; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=1rybI1vv2ITY3eTCg5sjd8Ca20nUymlp6uw8bi3cmFY=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoxEULj2p4TQ0UmeX9SpiTgGCnq8mSbABAwI/DF
 +4alrzPtXGJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaMRFCwAKCRDCzCAB/wGP
 wPleCACPlwbeTkXzOlbhi3MHTAxj9mGZSIjn/7Q8Noe8MyTTIRJ1Gkw388AassYPrl1F3YotbxR
 R+rLr/Js9KWqAq+1pLLvDbasKSPleElEnaNn97ilKzhtzIWBqHlyWHilm3uziVB7iBy4lqbeZGK
 +V3GmKcZVvK9ZvX+0eRGhR+AhLp2do5QZC5+79WapO7DwnQrPQ1JH70Egy8GF0ZiN/dm7a59hSk
 yij+viUESMbNUmsK0FzgZ0dU8Ui9fDVeCx3GzKwvZ/YMSAomsi1eicAaqKeXCUOObXKVHAtZVi+
 xRrm/kuXMCirC5yLKqw2ZGWi3NZDVwIZcLIdrp5+yxLlBC3w
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


