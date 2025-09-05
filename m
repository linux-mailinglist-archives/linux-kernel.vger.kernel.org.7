Return-Path: <linux-kernel+bounces-803630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D371B4632D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 21:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 681595C74D0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 19:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F0A2798EA;
	Fri,  5 Sep 2025 19:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vPs6pL+I"
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4FC1169AE6
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 19:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757099204; cv=none; b=cPJ5sFkkZ67s0oi3WmQKh2cTGdBNmh3IMJHoJI/DgBDx8sYQzvVq9uPIADn+eeMC5zDOdHLZSTkoRf5SA32MOzFbWociloPIjfOGeExYY3fYliehIaKNrJInukXldJ8AUpxy2ydFVy/mQ/WuGLogPeZswXwm3jWTU3D2BSUNfbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757099204; c=relaxed/simple;
	bh=93EhVVZhULK/BcUO7hlfIxF8zmoh1P/I2P3k3od0jQI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JWWGwHkWUthQcSbhg/1hawSP1kFofr8xifQ87cpTGWCjbCs4W6vJbLvGwS5QpNvk6gJ29OMloVsZnmjXiQEu2u1WcfNg3XxpkxlhTEBQdZ2pNvVBcZ7jKcnCK4fWXWTr+tcGT6OvF9bMnHnUEA6A9bYMXwxPBbTgge3pZIw2VHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vPs6pL+I; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-746d3fd3a04so1666478a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Sep 2025 12:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1757099202; x=1757704002; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ix85II29/02WD0yF+tRgyZz0RHm97JrSD6a2ejVM9PE=;
        b=vPs6pL+I4G1LTewy/3zZL8g6/8fllXW0CeMng3vZao03+t5nAsD0vqHYtDmTTZI6Mt
         8ino+AKiiDUq9iKYoo+Qb4c5k/CZb/iTM+jt1jWietn/ypaHgq/t3OZaLwY6ZESB4eKf
         A3Qu/W69JbTPYxHVRBxRZmwfy2DbeF3SO0Vww4Bj5/PPxS4cYwHhdM4ndy6xi6pVCNY2
         FBu1bn7bZjLzx2JwwOTpMsvWHHJTkmsuXJ/uUq/3Q4ez51RuoA0Ytlyg6d5RtBTlxUZS
         eyoRkiZx32wsUmuyfxF+4maVpJu3sf4JGlFFGdloilVLvjop6RiFZUNEOrwDZfBnbDme
         PR3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757099202; x=1757704002;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ix85II29/02WD0yF+tRgyZz0RHm97JrSD6a2ejVM9PE=;
        b=ofn1qxsAbvxQJKV2qu7J+BsVg/hQsL7dIVeIDIuBZ6AY0YDC6JuBL7Oq+tYRADdvqr
         k6RVSyT6dDNbfGIVc9+NaTtBufbZGSSlSnp8bz9oAdE4jhERDWLqJr5uovmTH2nLIniv
         Xq8rpMaBPeiNVyXBxNawWvAaUgM50KZfIAR8TrC4Ss3INLjoCqBg+UxC4J3sv7LE5HrX
         5fd/J2CGL+02XuLR/Tb5/K2KKUO1Hokeh84YSr8nmUXOgsq3LUg0mysUtJQI0O/OfBzr
         IzJ5SzIZxM7YmeYhh0L74vWm3IGx/4TzMxoNp6y1p2NoFYXE2oJzEZ6o3IJs5vZEC8Az
         MxaQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7vm3J4gOocaguGnUIRsZFcV05xEBMRuavsj2BIkRvqjEeZpWRMO5YbhN3vFVxYtxAGeGBFeAXCt6FAb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YydJRqmGZtqRyiqrg92hZr3h6nwWrtEnm/NYgfwHeoyQ8mIFJXG
	qpwI+5myMtXckP8Wau4RXZ3fZAaHDgsiegoOJz9cHMEFK31mQ8bn9bFwmpc6w9c3lSI=
X-Gm-Gg: ASbGncuta78RGjLmc69DSMellhPJq3AzoDyv7E+MZusUBuuG6cCd7LGsKLN9LHnP0mu
	wVb7gSdJIWb0lBeQrM2PdQdSOnFp27zM/iUuUP1+UcxiKx0CGCO/BFZe6tFO76BEEXmqDA+sd0t
	UBN8OcEmnFvv9dDCRMFq0X38/UFZGkjWdoi4f8BSc5KZ8g5PJ5Aq5mVOBcXEGzvQEd5LVn6c/6u
	6juF+EcOxLeLHu6BRU8zzzpw2FZGZ4istXxsA5u+SABZemyz/hBUWtSIvFnqChiEqiGWYH1Z60n
	eeVCVPVSoKr3n81qhDWGah1ezcxSVWj4oaenx3yJHzS+BmbVbUHDBDEL0LLTCg8nMlswa97kORR
	FWrpOnJudBveUh7lAlMKh7LthKpI=
X-Google-Smtp-Source: AGHT+IGVCsDxDNnDhn8FwNhJe/a8kaDRYPwj+DLMUG8/cU+Qv9Z4lLedKV5/iJsKeG5KTqFexYt5Yg==
X-Received: by 2002:a05:6830:2112:b0:745:9907:3fed with SMTP id 46e09a7af769-745990753ddmr5884075a34.26.1757099201832;
        Fri, 05 Sep 2025 12:06:41 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:52e:cda3:16cc:72bb])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-745743cdea4sm4474018a34.39.2025.09.05.12.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Sep 2025 12:06:41 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 05 Sep 2025 14:06:20 -0500
Subject: [PATCH 2/2] media: pci: mg4b: use iio_push_to_buffers_with_ts()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250905-media-pci-mfb4-iio-trigger-improvements-v1-2-55996f077a02@baylibre.com>
References: <20250905-media-pci-mfb4-iio-trigger-improvements-v1-0-55996f077a02@baylibre.com>
In-Reply-To: <20250905-media-pci-mfb4-iio-trigger-improvements-v1-0-55996f077a02@baylibre.com>
To: Martin Tuma <martin.tuma@digiteqautomotive.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1242; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=93EhVVZhULK/BcUO7hlfIxF8zmoh1P/I2P3k3od0jQI=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBouzS54ZbdBdAErj/m3sxDyJNlAsjqtxUds2Xbw
 WzX6PxyBc+JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaLs0uQAKCRDCzCAB/wGP
 wDhhCACD/3CWrtFQQV/+Plk6nvOcCddSfGgN8Dtj+/aThu1vTXijwv0KLdDKuyLR0dnmRMxmuT2
 7Jl/W/e4ShE3P2J3EFc6W48Pm70FA4r7SBVXnjGR+guH6YESWIZZ5Rm6n3sWU9ZpTCMg5lTOQt+
 //mejAXwnqUL6qnuAzv0BZlg8/Xi6OGS9ghthpv/HYnfFS1aE4ZnETaUFj5pfJ3ap3QWZ8TOVY3
 Voq/4Nm9AxeZfouEG7qP5JWeWsG92T9vZZSrCMUhPXs6yiJeI2wEwHpKkixkagJAZU/OsMfonDV
 e6fiDAbR4kMc/bR1xald+GKugwmVXMBlmGoCvKAD+pqeMdQw
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Replace iio_push_to_buffers_with_timestamp() with
iio_push_to_buffers_with_ts(). This adds an extra argument with the
buffer size to ensure that we aren't writing past the end of the buffer.
No functional change.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Closes: https://lore.kernel.org/linux-iio/20250724115610.011110fb@jic23-huawei/
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/media/pci/mgb4/mgb4_trigger.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/mgb4/mgb4_trigger.c b/drivers/media/pci/mgb4/mgb4_trigger.c
index bed8bbd4bc595d1d131b9919c6f3b705e43ba3c4..4f9a35904b4186618a554e3047d6b46ff7ed74be 100644
--- a/drivers/media/pci/mgb4/mgb4_trigger.c
+++ b/drivers/media/pci/mgb4/mgb4_trigger.c
@@ -97,7 +97,7 @@ static irqreturn_t trigger_handler(int irq, void *p)
 	scan.data = mgb4_read_reg(&st->mgbdev->video, 0xA0);
 	mgb4_write_reg(&st->mgbdev->video, 0xA0, scan.data);
 
-	iio_push_to_buffers_with_timestamp(indio_dev, &scan, pf->timestamp);
+	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan), pf->timestamp);
 	iio_trigger_notify_done(indio_dev->trig);
 
 	mgb4_write_reg(&st->mgbdev->video, 0xB4, 1U << 11);

-- 
2.43.0


