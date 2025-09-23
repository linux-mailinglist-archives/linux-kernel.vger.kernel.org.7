Return-Path: <linux-kernel+bounces-829631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D672B97808
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 22:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB4B91AE08E3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 20:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9081527F732;
	Tue, 23 Sep 2025 20:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="X9jYXv3a"
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F652DE719
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 20:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758659612; cv=none; b=XxH5xJy9indmPsgKrCvuHXW4xKAiglOiv/DS+5Xw+/dFkvg8CM27WjkGhQWDVjqJhTqBJpDpxC/c958XIJYyONKJBwrvUozQdwWtf+C4/g+NVqdagK0SJ0MZXCNHadQDkVxiEwCqjCqfNPm69h17IGBtFIgsL/NTcUY6klqH5Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758659612; c=relaxed/simple;
	bh=+DhdgqQltkw2hScFiBAxkQGAjQ2e6q78cMhqyHEpH7Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=u1tG90yAt0JCQVIMI20/0G+ORVUGSg4/q18m+7GtRqzoqH9zxiEEynw+HvlBs8kF8iYos7X4t3dLmsprMPiWjbjtbrSWXxQ2fpD0/1TPK65dW5VzckT+yLaF7vuhlf9iEZYbspo2owDjyblcCE7cnyCgN+FC4MlDmX9YNR1CB0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=X9jYXv3a; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-35178913a03so434553fac.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 13:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758659609; x=1759264409; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dZSTjKSlX0R0kFR5RB8/EHp0gnnUio4a77VM37necPs=;
        b=X9jYXv3ah00+V/ZZFqqYEmN9QvePOWznc2l3BxtJzBwLFid/HIn+SqJ/BP8qH67oAQ
         9Ci0Fn+05VO4hrEIVQiKcqKqGy25x942eRD9j9skteN/hE65076iI3/1Y7huOLfvLqjq
         h6xwKSXZpP/hcXBuGIGeTbgkEerU1bbufSQnh6CIydxSBYKJX1H/Bcuc3/vGwVkv9Lnt
         i8BAR6EV/TBqGDhPMvQLVh3/RHD5jS6Nmkb2w/xFd4kX7MyMSv7TMETzkLRPko6JJPpJ
         X/jDE8njINGg7ERRCmzvHZFiYcGsUfxFDF/hOAT8jFSL7rkqqu/lxdfrEyazzOs/IHPZ
         BLjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758659609; x=1759264409;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dZSTjKSlX0R0kFR5RB8/EHp0gnnUio4a77VM37necPs=;
        b=i/aQHYk+7MlM8MSTENzQIAuye2auFTuAAYjp4aISux2kG7bn8n5EQnGmFRVmL/9dNc
         +vDdYig3Y1bOMkoiJElR3U1EL7Zup6XSpx2alKhLMX07ibwMQP+5s8iDIWHLUGk2Abxq
         WRnWjor7KFvzsJcKojpkJ4njELWEEqQndb/jjL/JwN8Px06hzSmz0QQsGO1zzN5tWdG8
         jrfliIZCpZOtz9kDdCzdbe033zTmd0TJ2SQld7MlYXglHhrCv7zetENhQ/n8YJd3OPpn
         i19IGyRF6gTWxlJUI3yXZTHPt1JopwG7OxTPEhB1krsCzT0Az2LwWPQeqYSMuwWcVwdn
         mFow==
X-Forwarded-Encrypted: i=1; AJvYcCVxbIvDFLHcxjp25DT2KTATXKw0CpF0UCB8ZYSrboJmXrB20EOjUfutvc5crkoCzI1YETtCpcyeoj9TK2E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8s2DzPzMtzRLa9FukKQ2mYnPh+pEr5UyURRJQVeOGXK2xPKHK
	v++t14tA8MnDNKd6nOPEYc4qSirYwyjTUMdVFl8ftlzFpRR6+Q87H43/r3PBF4XFtf0=
X-Gm-Gg: ASbGncsjwBXpEmGY1MtIxR0dvtFopPE1iGP00BJm5BbZcC1wZ/77hPerOOXi+2Ug4JV
	poN6fxzzeJtV5WlJgbY9/TW7CUXszaHxRwNXk7mVMsCshpAGfAGBogiRYmyrKkY0KMuspMMslwp
	q10z6v11gpYZkWkdP22JHEnglXtMYrpvyIkHvtcgcQEzTKhEtAChYXw2WOGo4POZCXpGyt+yPzs
	RHIETqJ7NGItBHq05D2zyXkaExJnZIvVr4aShrmFFcC/33Dt3f7Ld383En86GuKhxoJozSexrYU
	5H750OsJQqk+jgQieAda+z6mvy3Eh6CLIHf/mzBRQ4Dk6OPT+qbmlWhK8p6WnDDPRpBGfbrTfVY
	UMUJRRg6RmQDMxCC2W8mbPjXMkgJX
X-Google-Smtp-Source: AGHT+IHcw0owZw1fn+XSOe1OAyBiZr3BP++yAhZpjUvMDxjLzrwigsK04pPk5tdeb9uhj5lMfsfDjA==
X-Received: by 2002:a05:6870:f683:b0:315:b264:f221 with SMTP id 586e51a60fabf-34c807ef85emr1887144fac.24.1758659609094;
        Tue, 23 Sep 2025 13:33:29 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:505f:96cd:1359:fff4])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-336e5a2ab2esm9453116fac.17.2025.09.23.13.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 13:33:27 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Tue, 23 Sep 2025 15:33:18 -0500
Subject: [PATCH] iio: adc: ad7124: add ext attributes to temperature
 channel
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-iio-adc-ad7124-add-ext-attributes-to-temperature-channel-v1-1-173baac28169@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAA0E02gC/y2OzQrCMBCEX6Xs2YU0tUp9FfEQm1EXtK2bjRRK3
 934cxiGbw4zs1CCChIdqoUUL0kyDgXqTUX9LQxXsMTC5J1vXecbFhk5xL5oX/ttsciYjYOZyjk
 bEtvIhscEDZYV/KkZcOcYu11Tty4idFTqJ8VF5u/08fRjxTOXB/YP1/UNlVWb4p8AAAA=
X-Change-ID: 20250923-iio-adc-ad7124-add-ext-attributes-to-temperature-channel-dd963150dea9
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1080; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=+DhdgqQltkw2hScFiBAxkQGAjQ2e6q78cMhqyHEpH7Y=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBo0wQQeh8R9pqHoBfjPTMxGPyrY91yBOail7dSW
 NRDMPo2qd6JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaNMEEAAKCRDCzCAB/wGP
 wESDB/97N29ff+hTa6KyBgItw87M2niMaRLBtSezsIUxe8KolSICaxBNS58szW6IRLXJzHqAl2r
 A8Kpq7TNo1Vwn7hUpgwC6aShxp10unK7PcPmKkh1NfPc2FL0RUyZmwCsy9UvjDjc55Y3ReMexSE
 NJ2cw992bpZ3BLlrlbdEw7KYPwzg+AGwtzF8aFlOBJOhCa42KBmtl2/u3cSfPX9N3kJK+irnd1a
 ZO++tR9PHMhPIoaUwjoW+9VqDYQEUsm1izfktk2hl/c4/PtFKU0GodoRdnE/vS2C+NPvEvHOzyg
 02Ykj6w4nNKuNTqlT57UWuMPxozM3ns4rUqsTvtGB1AjOWR/
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use the same .ext_info for the temperature channel as for the voltage
channels. In the ADC, these all go though a mux to select the source
and otherwise operate the same.

These attributes probably won't be used much, but since it is trivial
to add this, we might as well include them.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7124.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index 374e39736584f55c1290db3e257dff2c60f884d2..7ed31399a875b76be08491f56acff55032c95ced 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -1348,6 +1348,7 @@ static int ad7124_parse_channel_config(struct iio_dev *indio_dev,
 			},
 			.address = num_channels,
 			.scan_index = num_channels,
+			.ext_info = ad7124_calibsys_ext_info,
 		};
 	}
 

---
base-commit: 411e8b72c181e4f49352c12ced0fd8426eb683aa
change-id: 20250923-iio-adc-ad7124-add-ext-attributes-to-temperature-channel-dd963150dea9

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


