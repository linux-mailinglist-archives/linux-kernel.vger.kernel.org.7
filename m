Return-Path: <linux-kernel+bounces-819597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFBD1B5A388
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 23:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A09185269AB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 21:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048F32D9493;
	Tue, 16 Sep 2025 21:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GgdJ6iPh"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE82284695
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 21:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758056636; cv=none; b=bW4WSx7jwWBFnWkrRSkBSmpWlpj1/+88rPoiWNMOpkPP6EwxLKlc7TxCGr2nuFZ1ryjoHvCsBZG65Bu9NGnizi5dSQPHGVZODkIUTQhbP0RxtDHhRsWSsbUETvN1EJm5agjJS2rO7SZun2HmHp3eQxMQHTD7sdIFv1VQdmp8TPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758056636; c=relaxed/simple;
	bh=HoTnMUccGdCvWwXyGGvfMxbeyG3DCTAB887pRo015M0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=baj7dwXSqnlZMQWVVXm8pW1oqimTlVgUAr2pmnxyWv2KybrzAN3MGJyqHkOV8Qc2wCebauNOb0whdHIf7NljUFTTdggG0r4oQWDU1ShYOzBksyTOeQxp18h+PcvPUaq/s4B14v86yGcapv38LYAphiE0q5/xFoj8+Gl4ry3B88M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GgdJ6iPh; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-62340cf6870so594909eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 14:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758056634; x=1758661434; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kOVMpRKYtwkqS0W7XsGFd2e24mnObLP4dosBsaN4f+k=;
        b=GgdJ6iPhgdLsRto22Ct49HrljSfJKLogfvRAFL/NCa76o77OoQLyA4/FIdvA0lY1AM
         1LPArmlzFCpo6emdOsWvKg2OsJmaMeF4hLLW2iXb5c4WVEiG9SpJz+tceMTnfnxiwXAG
         z/IJl5lXvMQeZNxY5+E32YJB9eV7aJQVWPV88lN4mJRFhdVl9iuUuI4rbj7Dm42Z6Cfx
         Dd0J+Y5MgKt3vqEaPg61X4H88tIlaTY+pX7flIsNHXZdgEhLjxy9TjTkkTHtFLosrgq1
         zz+2ZbHUUUseCOdOHSr+XSfiRgHY6JVBi/tuHeBr6BXr75OcaC6X6Fy9cCfBwxuBpRJi
         3Zyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758056634; x=1758661434;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kOVMpRKYtwkqS0W7XsGFd2e24mnObLP4dosBsaN4f+k=;
        b=KfxImxom3i0j3dRVS0DpUaZd1CCvnHHtmYetFLMMpfE9HgoH36eMzsBR+kUcDPb15Z
         lvgE5AD8GDR4n4EkjynyNjb6rI47zi9Tuiv6Rsvws46F2rPo2hLxntCVnjfeSDn3H9RA
         kM+6rlrBAL0ub2pg2g34y6Oz610kVck52TI0qJbLHyWVj+Zu3m2Wl1/hyPKYc4W8Ll0u
         jGxWg3L5KgYk6KHM1mjH6rQtCu+OadJymuZIlcBP6SOpOLaknEkw+S368nAw1LvmIb2p
         PwxquagC+4A8riMlUaDlNvDNigPocIN8SI38KMlcHGgXBdyamC80ByRFvX/W/qpiC1pw
         jDGQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9wFiJZ4MqjachKBNSWoyvP3bSLfchfH3cTmDWwXQcKDvgfdTopK3f7cC8Ct06io+cUtaS0qHi9WlmViQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxslPbY+Y3PzyFtnolZeyKOXif3CNxRLZsBBlCo4cTuefWLQFK/
	KqWub8dkK+76bCF+OQqrWqEQ8c+l4uMMwtxhurPbpr9BGvLs7SNs6j9sDMFZMdTigao=
X-Gm-Gg: ASbGncsFscZ0DknfANYqD9zbU+YSZCiVUlhqZuGm9p0uYQ4sKY1NnHltDqCgKFsmu7B
	Sw7UVCiG/fcGzWtb5pow6xRQXQABYlecGxknNbIhIfwvFaqTdk7FzYbJetArPPYicV0LnHdZK8t
	LTKegRGm3Yx4PcaMTJJHlNb267tGHxBkYs2NB8fW4HF7l/auj/hfCOiZ54cXSZkM7Xn5v+NTr8V
	bPVCxUuhl3Zby8babzk94ybJ+5VqiuXN129MMQ66EiSIwUCWGTnWGQUkNionjgRUbPCZnffeW9m
	mAoiKE/SwKbjNWVt9j28t7qjvjPPRRimdPSRxR0sS2Z/uKZ+3Ldw5+s0MtxydNe9gEQM6XvmdLk
	IHrQWaqbKqvk2sQIpm+oTLcvmIoE+
X-Google-Smtp-Source: AGHT+IEq2WegxDh+JawxjX24U+s0jfDkaIxMyIzj0ZGVHv917cLK+IqJ3aqvbEKryHr4qPYyMNgNiQ==
X-Received: by 2002:a05:6808:180c:b0:439:af0a:dc9e with SMTP id 5614622812f47-43b8d898f0amr8955078b6e.12.1758056633706;
        Tue, 16 Sep 2025 14:03:53 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:70a1:e065:6248:ef8b])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43b8294ac06sm3540044b6e.14.2025.09.16.14.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 14:03:53 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 16 Sep 2025 16:02:52 -0500
Subject: [PATCH v2 2/7] iio: buffer:
 iio_push_to_buffers_with_ts_unaligned() might_sleep()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-iio-doc-push-to-buffers-context-v2-2-8b17937a6cc7@baylibre.com>
References: <20250916-iio-doc-push-to-buffers-context-v2-0-8b17937a6cc7@baylibre.com>
In-Reply-To: <20250916-iio-doc-push-to-buffers-context-v2-0-8b17937a6cc7@baylibre.com>
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
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoydCM4/ZBJypY4RqFfOVFr+SIr0EoCjftkSc1a
 LJQYC1aXDKJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaMnQjAAKCRDCzCAB/wGP
 wK76CACNp6QD0HROicFUL8liuWxC9iVMce8icL36jCtetWW9CYxuOKducms2hbgn0TL+BWosS2O
 lWqjuzxWXUyAXe4uik92GGTTaK40OJODEa59txQDqyyBFY5+7+DlMHm53iYZA0CkVSkFn775Yma
 e5T8s8wCi9UJAVjnHszxbhzvhZKOXZqdGUQWsVnaFcVu1SLPr99Mob5VNiHfdLlVWyZ6dqZCMpE
 Z2lTPhJ9BEla44ps/f7BJXv4P5Yzgo6CuWvjzqwBcpEIVp4ij6SNsMjXTDFIebeVq5I//UBXo3B
 p2yyb5mA2gHlkXnZStC/buVF1BMM81+dvnA20p7rEtY33Dbq
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


