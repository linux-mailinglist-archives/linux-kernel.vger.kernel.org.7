Return-Path: <linux-kernel+bounces-814466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BBBB55470
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 18:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C1A91D662D7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB37231832;
	Fri, 12 Sep 2025 16:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YNmnI7SX"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB6630EF64
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 16:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757693216; cv=none; b=SuKnWftICz2SD2fIeyJPm588K+AzTVk/X/RuRMwPwJfTh3Ng54CT8xnuxHVJh0CXGxDs3EtiTJMZU8VKAj+9ZohzLd687i8AF7VfJ5Jt/DOkIYDhmdcInOPBN4SUj7yG5jOoTeWe3Y1oc7wOZWvwuygPWTuEuZSoptIk1DSVFOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757693216; c=relaxed/simple;
	bh=HnuQ+TkaU2snLpnK9vKwpR+SRQ6mSUlBuodkaXdQJ0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SaZPaxJ5UVPFUL65B91KUXg/M+/pq/Q87r6gihZIrHZ1H2gtC3aNq+Xn5681K6hElLLiVXeIS87wXdOeH651yArGEVo19gXc4L+qj0UqCOito5Tx8YnA4bbcl11agJb3mKQPSUufgXmhqTQrX4Zm5VmT34DKKON1VjLJvRvl60k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YNmnI7SX; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-74d3389cd7eso690505a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 09:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757693214; x=1758298014; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tVWBEP36MuutXOJ2sHz8OS+ojTXGpyXc0pw+qLA/60g=;
        b=YNmnI7SXGzNKvi/ISkAv+RSVIhDoc68SfTmzdwDYPF9us960C8IwLuHvcnYSsICB20
         lxX/L9NstrOepo1Tz+aAcoVwW1uvGlp38eEYDcahKfEo6J4wo4WiLa68tfLnOWJZ8FJA
         LRgBvTYuzonlXzDw8+T51uwi8/3mD2NMXaEtaYRmtpL1kCvY5Bz7v2IdQ2i+CpbW4GWW
         IAembYlP9mcYTVyTgL132eG7EHNe+u5Iaw+JrpxzKMpF/ev+IhhYcKMOD/hClttUxjdZ
         bnvCPMjoczIWLBUAXjgL0+iBjdyb4V4VXexoY1xhrDejV80vSeEmsO79gQ8FEwIafcip
         c1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757693214; x=1758298014;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tVWBEP36MuutXOJ2sHz8OS+ojTXGpyXc0pw+qLA/60g=;
        b=Gj1JJuHN4+1NfMPS1uZ4ymLfOuax+zqPgIL0CPV1dnfUwpHL3w6/5LO4QN8X09jR+H
         nB5FFBi6y2ZZZrSCnoy6JCNoNhy9JhzBdNwJv6mnjpDtBO/j4Hyh0R/B6IpPhXE/def/
         4UHtcHoFgf7uO8f4YvmD3ofdO3KFoffg7aY/TcfOIObuWWU5X6ADsXA5XxgUuTFmpJsI
         LMh/DiJWNjxf+L4gsrpp/f8Oj/MNEeckecrc4SG5LGsallbFtWSy849Rtuuuuzt93cb8
         7kJy9dO3iOCsUfQ/uDsW4hicoi/TrYvwM7K6rZt2+JPhfa+b6jogGKwSKU3erbHR2S6X
         nrjw==
X-Forwarded-Encrypted: i=1; AJvYcCVveM7NgfCt+qaCkWULkXA1+4q/xjcin0zidu7w6Cc+UnWmIElp2e5ycpEv3E2zl9+wYoGv8TcuqLZfLPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRQyuYB8BYPr6StKuvave96nOIQaM4hTNXtp224Hj9D/mpsUoG
	gnpkJHV2pGbZmecR+0ywkKSy6boMm9UBIuldiv6TOXkZqzDTUB6OT1w/jBcqg0XDJHg=
X-Gm-Gg: ASbGncs9Y4frb+pxA54cjRVao0aIPccT9Jth19nL3OY5LixLo8AQCdHL59SfW9h2uOW
	ktAzMcmogidTvl7tOm9YjuJrQdPf+nSVKuKcOgfxyzmjRXgUwSpexWd+KZrSbTPsr9IDI7l4nlm
	NwKQ5MxqOFdZYLNnBLo9tSb84Hvd2Fe9Kvs4/fRvyYJeNQSL6CNtcGvS6SnTesJsmcfZszUsCYq
	CUSLsj7sk7XKBQ6Mc2bvOAOwkUAbWAIkE+PSnTSXgdwCWjraRU3qPMNYeLKp00LIc3ytOJZ+huV
	ZX1wZnAmjVuwBlgRr5D+myo6zqR0aLzKfLAQ3w28HTlTXf51TO0ALYp/FR5WHMWf9lG2FCXZDE+
	bUwqoUq9Ph7kyaJpCg1f+l18rBZYu
X-Google-Smtp-Source: AGHT+IGeM+CYMUpEcZ24r4ZKd4sVaJiF4l6pF+Y+dXMOaA4zkK9SGuAO6TPmM+gZCQqUURx0Ga/Syw==
X-Received: by 2002:a05:6830:608c:b0:745:9769:ea51 with SMTP id 46e09a7af769-7535b3535b6mr2051528a34.9.1757693213913;
        Fri, 12 Sep 2025 09:06:53 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:fdf1:f11e:e330:d3c1])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7524b8a39ecsm1073863a34.23.2025.09.12.09.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 09:06:52 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 12 Sep 2025 11:05:52 -0500
Subject: [PATCH 1/7] iio: buffer: document
 iio_push_to_buffers_with_ts_unaligned() may sleep
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-iio-doc-push-to-buffers-context-v1-1-c4aad013d96e@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1107; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=HnuQ+TkaU2snLpnK9vKwpR+SRQ6mSUlBuodkaXdQJ0s=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoxETp+6md8mJWssX1SSdWOWoeoKGUIt3kiNN1W
 WRFFP+wto2JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaMRE6QAKCRDCzCAB/wGP
 wHQDCACCdxTb4qkaDzQzvAtqHBw7OqjnneQI+T8fuZqQSpGhl65KizDftuHhsHk6RWLBKe7AGdR
 av5/QYyoAc4HP/736f0X061nBrCjaIAt01UemyzbgxfSBIwJi1IuyF2IIkhcHhcBEfLFceq6t3K
 1HVjSIHECRdldlpsYdtsjFBLlmGC3Ljtaz09ePNfpYB/jVYt+bfhwPx1/lmQKUWOQcJKXCgyZZ6
 j0c62LNUvokHnaojUkGIOqNPsqz6EkHk1GGJJHwIjCsiDW9T4q41j1ktlsONwEACNRLq9T9WZaQ
 zRAJ4l/LRxDZxsmg55rnFbprvUfkRe+dqUcRJ5xwXPA7kSpO
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add Context: documentation comment that
iio_push_to_buffers_with_ts_unaligned() may sleep because it calls
devm_krealloc().

Also document Return: value while here.

Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/industrialio-buffer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index a80f7cc25a27109cfe22ce447c4117fc94bc8310..7da43a1f2f75f32dc93b9a5fe903378a79e82fe3 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -2401,6 +2401,9 @@ EXPORT_SYMBOL_GPL(iio_push_to_buffers);
  * not require space for the timestamp, or 8 byte alignment of data.
  * It does however require an allocation on first call and additional
  * copies on all calls, so should be avoided if possible.
+ *
+ * Context: May sleep.
+ * Return: 0 on success, negative error code on failure.
  */
 int iio_push_to_buffers_with_ts_unaligned(struct iio_dev *indio_dev,
 					  const void *data,

-- 
2.43.0


