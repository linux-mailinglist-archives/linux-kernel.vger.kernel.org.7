Return-Path: <linux-kernel+bounces-821124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D413B807E2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 17:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2B6C465469
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0AA335953;
	Wed, 17 Sep 2025 15:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="N1UKVgw9"
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556743064A2
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 15:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758122563; cv=none; b=ACDKPwBr+Ccmh2hP8Cu0wus+KLhfyny0TS8GGDg6nbpE89NBOSTF3PlInHqiScGmSEWgXLBZ4/YHSJiDiT+ZJz4gXw8giqSSkBRU7Fv8hWRzDjUt7ZstzYoJsKVHBRm87M9ayqtk7q53CmQnrNJJgROFHADxKbtwtQi4mDeBpFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758122563; c=relaxed/simple;
	bh=zQsz9BdqYptqLS1CMsswCBOUQ6lz2yV3McAsdB6NOOE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DHA3EaCle8th0wYZbRXJgDNbyFhLB+ZWetchXKr0937ixrvw5jd7SiJ3VRmZFRRIEv+x3ArXL19fUEGeOeW647QpReMPcYfp/giKUa32D8Ah9v1qA3WVI9V1EB81ZXSF67etyDVDkgKofwHw7gLTbyotmCWfQhLGZVsMH6+r5P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=N1UKVgw9; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-74526ca79c2so2729683a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 08:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758122559; x=1758727359; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JuqG0yxquK8kD4GeaITKrOy10EcGnmyS01S1D7HLSeg=;
        b=N1UKVgw9l9iUB7fQmMQdEi8hNISkqOSIfIvcyGR1KFvyjEFT/Ct8k6jPl/p2j/4OB2
         mEdLJ2sNWrtR8IRhhVdUmKUuJM39Ig3fbbr2FsH5RwtAGsOexcViIJK759aqyUaEv9ni
         S/iAn9MqjwDOSSd+m5IHPIohel0TDKnNdJaN80CS8mHtuiK9oMLrCFBUI9lIODT+QwRX
         +lzlUvPHk2jn0Xy554nW216wt/ri6CeItcg1m/u4vqh92YkuZ8WOkOXIgPxissV4pjeu
         ok5OaHHk6uNdClpZYE+6ZqEiVZolbxRi+lbG/2Cr7hJP7EAvznIcPwbprIGjrK5fEe5j
         v0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758122559; x=1758727359;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JuqG0yxquK8kD4GeaITKrOy10EcGnmyS01S1D7HLSeg=;
        b=n16HqfNAwelIYkfKPFuGkL0PELpZL6LyTmO6CcPHh9GDVE6wp81ItErfCusKtE/ZKn
         AH9u+QHjzAywLgMi+yTxjPptEbXNhZ3/QGai3ua2hW8qpJWxaGrJKZprDh9wtJ030TdR
         vLp2a/Yag21HT6Ad5Lkjd2dym1y02qkMfIiZ+JVLlJrE4rF9J22QVZ3aakGPwwtC3P5L
         djI1NZuPJVztEjfDOqLB986UOeXid7cg/fMQ1S6CrmFobo/2AI387C6lwuvLQc11Cl68
         EJevPJK4tgtfGxeu/6RIB8HeBKKtlhWLY0BVjMQv2PKDKkk5lkasTBClnUFn5AT+9gvN
         dnug==
X-Forwarded-Encrypted: i=1; AJvYcCUsZnbzBSuu5xXxeRjl0BONwrJzDV5nTcruHr5r/7yg1i8+QpalQ79esbWXNomLxhQE5pFlZPKz5ihKiUk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9UVQBNK0Qu44YDiJIUWqGK6UrAwlhzu3Nbf5p84GlmsgWVAGs
	1zZ/IhYE0rbVal7rIiCQasw5a5R8lmmO0dKp7QDuhiiEB+npIPdjEwvfAwKcsJKuX+M=
X-Gm-Gg: ASbGncvMWBCH1bZwO1Zb+o39gV+B+a6nkWSil2q5BcaVNGB/kwBbgEy8tYwtp1pC6kv
	jO3z3VDFYASHeLy9HYUUNCUtE/Ca2qZZGf90xYO0NU8oTwuPmytnjnHQNMLYcmd1urKyg7bRilh
	MLWAwxsRC5FzK9wwktvcLg4Pu8gtdYD7sCTKUGXjqSg8gsov9FSy/ySjSTl+ipzO3tkTpYstZ7X
	pL5TQ2sB+lKbL9xaciA6TE2zNs+DwEHA5VJtkDa8ILVr5Ey/3e3+c/BSEaAtuU72W7/vNxrujNU
	75KxMqVmdWVt2oxqAoQZde5nQAz7bVvB7qC10pMH31tTtj0DDUlYwJ2bLzV3Lvv8g2FJ7EQVkER
	L3ySUb4hmyzqxboUs6I/uTDRRnlQ=
X-Google-Smtp-Source: AGHT+IGVA49Felbs27PadgaFXN++BYp8GHFxN2UZXDDxNeHRd4MCJpOkfBeMbxQ9o+r14RuVAakEUw==
X-Received: by 2002:a05:6808:1984:b0:43b:663e:270a with SMTP id 5614622812f47-43d50d72f39mr911532b6e.39.1758122559292;
        Wed, 17 Sep 2025 08:22:39 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:72c:cb37:521d:46e2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7524986ca64sm5388388a34.14.2025.09.17.08.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 08:22:38 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 17 Sep 2025 10:22:30 -0500
Subject: [PATCH] iio: adc: ad7124: use devm_mutex_init()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-iio-adc-ad7124-use-devm_mutex_init-v1-1-ff23fe3ad954@baylibre.com>
X-B4-Tracking: v=1; b=H4sIADXSymgC/yWN0QqDMAxFf0XyvKItSqe/MkRqTV0e2m5tFUH89
 4X5EMK5CfeckDERZhiqExLulCkGBvmowL5NWFHQwgyqUV3TSy2IojCL5dFStWLLKBbc/eS3gsd
 EgYpoO6N6PUvnng646JPQ0fGXvMabE343dpU7hNlwjY3eUxkq/s51Qh/5WrOu5l0orDBe1w/7S
 OQ3sAAAAA==
X-Change-ID: 20250917-iio-adc-ad7124-use-devm_mutex_init-45a297b1ff8f
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1115; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=zQsz9BdqYptqLS1CMsswCBOUQ6lz2yV3McAsdB6NOOE=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoytI3IQvdBP+yS597bPrqEJC0E63Fmq5HNfTed
 2UnEEDvaXiJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaMrSNwAKCRDCzCAB/wGP
 wHKIB/sEN4lqvOC9afRqIE/ulkwoktZ1q1wpR7WsLN8FSZH2EPNZRAJOd/rGsgs5wlyDicCwz87
 y2PSKodKgzBtH6qGPqa3HsiljxZ2cgP9HyOvLYHYTtEVa7c2RcwKeX/rZqqL3VOwr8TjaADfoKK
 3Il8XnzVjHZX9eW2A4NXPeD7fB9SJOnbWw3iI4NvNdlRJ9hAdcFa/YmaueJgvCL4q4cc9FOLvb+
 3QCb2QQQhKNzdrwkE3OZ0wN2rfRaNzuWaoH5G8xhln8MUvI9coVpMHtVFthPeRJ/YA2cQttan8K
 M3dItbxroFaw6qbHwFsc84lif24EWUkx6iLvdsvqkm3xcAAo
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use devm_mutex_init() to initialize the mutex to handle automatically
freeing in debug builds.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7124.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 9ace3e0914f5acab695c0382df758f56f333ae72..9d9250274b9a02e2982e6ceda27009a84413dc2f 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -1482,7 +1482,10 @@ static int ad7124_setup(struct ad7124_state *st)
 	st->adc_control &= ~AD7124_ADC_CONTROL_MODE;
 	st->adc_control |= FIELD_PREP(AD7124_ADC_CONTROL_MODE, AD_SD_MODE_IDLE);
 
-	mutex_init(&st->cfgs_lock);
+	ret = devm_mutex_init(dev, &st->cfgs_lock);
+	if (ret)
+		return ret;
+
 	INIT_KFIFO(st->live_cfgs_fifo);
 	for (i = 0; i < st->num_channels; i++) {
 		struct ad7124_channel_config *cfg = &st->channels[i].cfg;

---
base-commit: 561285d048053fec8a3d6d1e3ddc60df11c393a0
change-id: 20250917-iio-adc-ad7124-use-devm_mutex_init-45a297b1ff8f

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


