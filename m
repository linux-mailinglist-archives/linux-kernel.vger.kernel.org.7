Return-Path: <linux-kernel+bounces-739970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DACDB0CDA3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 01:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B97773A710B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 23:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F79F2AD0F;
	Mon, 21 Jul 2025 23:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZvPYGopL"
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47851C32
	for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 23:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753139806; cv=none; b=DAKEYVHVTknUJHz2/uvhxKt/8Asgvh8M8liQ5p5PaTGLLkt5VTLZb0RSFfUfMG5WvBxa30bhSk1Buj+6a6ueWngrm6ypBzRGn2nBRgXYO/Csjzh5ZT5Boyna3NX13q964v/7daB8p9OyM4GnADj2hEWvrI2JWsAQy1bjzDO3HOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753139806; c=relaxed/simple;
	bh=PPvaW0EnMm8pKkdbsd1mRRlh8QM9vSbRder81ICwCrQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=e//+6OBeU4X63VttS0iE4pntDi4NzbFa/3tRP4uOlAkqgEEjwIY4/rjbe4HRmzCN0CfnWKlO3BLrcSd5DsuG6au8wQh1lnE5PXONeiGCZKoyQs+0opWEuZ5MB21l+OhUPAaYLjWQo4Vt7ZiUbm2ni/eq0cm+eHMrdeuh5D7mjUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZvPYGopL; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-615a4b504b2so1103539eaf.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jul 2025 16:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1753139804; x=1753744604; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3fMbRTo7KXOrYlWOyPpNSRios5M5iB0JnRGzKt7FxQs=;
        b=ZvPYGopLeCpmQvB2cAmIStm+MwqFcFYsJ+7mmFCOpzvt+HkhWIr5uNYUclDIpGuuLv
         MjzG6oeVeDhSf/k0aWNHXUQLeuuCOM/UdILGq98MIg97P5Lgi/A4V4QVDp6VVQAA5zob
         CqyyJBOdEOvzsSahLDIQOYWXsRe4VOqDZQ7oLTlJRmCbU/QmFzOJmAPnQuj7/WTrGq81
         1Ezg83Z1lxb4aK0h/zkyM13DrRhHoPxUzjpK8VnEhUIqYZZbc2vk0+hfkvupNOyHACQu
         XO8olmkf1qS0BnHlZpTj0GJc8V7sQeN5U2mmQi7Zc9v2jB0ZDf9XWz6GKg/g2DcGyRgn
         O0Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753139804; x=1753744604;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3fMbRTo7KXOrYlWOyPpNSRios5M5iB0JnRGzKt7FxQs=;
        b=eoqugTXL38OpNiuPXDFCEzVN85/pSAFsT8f4dD1ooftZD0JXW2omz+qVtCA5NgC1NB
         z96w6gTS8mApqjITLG6U+FpCL37WVaJQCKxJfTYO1VlgwY7RLDcO+4QdLqSpCYe+Mov8
         OmLGjWO0sS1mboUKL4TiI3lfJHf//i5FVnsR0L2aLNxTdPrQ01bgHPKotMVti5XTwMtH
         NH/vRW4EWvpFctpBT3iZpMS+pWHxi6p8rymY4KaXk0uO17i9R7YPNrv6v9umOcYWx1bn
         gYqBjHlS9Cj32bFdLxxSoJM8pirEQRLerHc2gdjvVn09o+915lA+npaK4Pp8xTUP73qK
         41cQ==
X-Forwarded-Encrypted: i=1; AJvYcCVM3ZhWH3Uwo5Tn5fdq1DMBDpI7u06Ffd54OknX9c6Ma5wId66oSwIlAye8lnw491VWnbZhKfutEgFHF9U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqjmHKLPBQkO4f2Ab1XVKtu+TX2Pl2pxNf29ZDyyx1ZaJagJwK
	voByIJjC47RP82rGWHPq9P983I0+Ax5RSWluL0TV8GrxmU1jrEiyTvDZjX7yLtx/Iils1AO1J1c
	mgz5nZ+M=
X-Gm-Gg: ASbGnctCnWP0Wkpb0ttVRAidhjw7ux2/UYyZXenufRzsvPlwWrLF/3JoPqIBqUoABO0
	sT7z7OpELTOysFFPbaOkuIXQybiTmZ5tIQuTrOKjj9RakcAjjOSKgVanfZlfAKIlcQBBarPOD6K
	aU6yZLt7yfPmXbDTOrCRrTT9Ok7C9ew3H68Cdc6Daiutf06W2tI4BWbmDAE5zpIqysL6YpmEtcj
	fXIzxGZmg7DMfh8/hFnMFDeciPYoMxpsSP2mDkdgZcn72HXgdZnpUKl1cNHtu1wk274Qa9T9IED
	/9JZXy68pAGM42LDfxWsCPz2jVql8BX61VOWFnWPMEA0q4jCRQ3DFuWUaXV4wBaN3dIdsN3KAQK
	Fy/SMm+AuvOAcwCVKy3k0taL2aGxS
X-Google-Smtp-Source: AGHT+IEecxK8ISAcxJLFa0bhXPE/Zs+iIDulRIo3El843fns0nvMZ9Ojv3Gl8Q44sHOOoOmV6TO8qQ==
X-Received: by 2002:a05:6870:71c5:b0:2ff:9ed6:2268 with SMTP id 586e51a60fabf-2ffb22c138bmr12748201fac.15.1753139803604;
        Mon, 21 Jul 2025 16:16:43 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:2a79:4b55:6a01:85d7])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73e83b719cdsm3264185a34.54.2025.07.21.16.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 16:16:43 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 21 Jul 2025 18:16:34 -0500
Subject: [PATCH v2] iio: accel: bma180: use stack allocated buffer for scan
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-iio-use-more-iio_declare_buffer_with_ts-v2-1-f8fb11b8add8@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAFHKfmgC/5XNSw6CMBSF4a2Qjq1py0Nw5D4MaaC9lZsANbeAE
 sLeLezA4XcG599YAEII7J5sjGDBgH6MUJeEma4ZX8DRRjMlVC5uUnBEz+cAfPAEB7QF0zcEup2
 dA9IfnDo9BS4qlaWlsmlpChbf3gQOv2fpWUd3GCZP6xle5LH+31gkl9y6IqtKl2eiyh9ts/bYE
 lyNH1i97/sPfe+xw+EAAAA=
X-Change-ID: 20250710-iio-use-more-iio_declare_buffer_with_ts-0924382d38c6
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2083; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=PPvaW0EnMm8pKkdbsd1mRRlh8QM9vSbRder81ICwCrQ=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBofspTLuyOLAEWr/Rtwv0BARtcQTKfV4geMYL3x
 GIyUtM04KaJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaH7KUwAKCRDCzCAB/wGP
 wLckB/9mZiDOtmMb+OKE2Tl3ohXlqcoEcJT8V4niu5WpwweSJtRZrEAIdewuDT+Dtp5zPSEUA8A
 0rwJ3N4tgGzcFzI0ZjCzJjY6gvsA0ePRoC1JPg6yFKT5wX7kAjTlHfY54MU/4r1TlYpaCcvFCOR
 3BU3jFUv3ia0iThm/2CLUBDMnOA8eYiEE7Kz36T9pODeyvZRzpb5YYws5gjRKd0QjG0wowYuvgT
 yz9Fc7Xa6V2lyuo74qAwnXPFT5spRk84+us6k8K97wqyf3WoQJ8tjIWCAbwJC+lyrDdEqS2aSQ9
 UztpHL1tDnb4u/txXnt0pOLhod/uDwcobtx6uPgnkYLJ4lQP
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Move the scan struct to the stack instead of being in the driver state
struct. The buffer is only used in a single function and does not need
to be DMA-safe so it does not need to exist outside of that function's
scope.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
Changes in v2:
- Preserve the struct instead of using IIO_DECLARE_BUFFER_WITH_TS()
- Did not pick up Andy's review tag since the entire patch changed.
- Link to v1: https://lore.kernel.org/r/20250710-iio-use-more-iio_declare_buffer_with_ts-v1-1-df6498f54095@baylibre.com
---
 drivers/iio/accel/bma180.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
index 4fccbcb76e0423bee37463a72c637af80e356a19..8925f5279e627a67c8e2928b10bee04185663e10 100644
--- a/drivers/iio/accel/bma180.c
+++ b/drivers/iio/accel/bma180.c
@@ -139,11 +139,6 @@ struct bma180_data {
 	int scale;
 	int bw;
 	bool pmode;
-	/* Ensure timestamp is naturally aligned */
-	struct {
-		s16 chan[4];
-		aligned_s64 timestamp;
-	} scan;
 };
 
 enum bma180_chan {
@@ -870,6 +865,10 @@ static irqreturn_t bma180_trigger_handler(int irq, void *p)
 	struct bma180_data *data = iio_priv(indio_dev);
 	s64 time_ns = iio_get_time_ns(indio_dev);
 	int bit, ret, i = 0;
+	struct {
+		s16 chan[4];
+		aligned_s64 timestamp;
+	} scan = { };
 
 	mutex_lock(&data->mutex);
 
@@ -879,12 +878,12 @@ static irqreturn_t bma180_trigger_handler(int irq, void *p)
 			mutex_unlock(&data->mutex);
 			goto err;
 		}
-		data->scan.chan[i++] = ret;
+		scan.chan[i++] = ret;
 	}
 
 	mutex_unlock(&data->mutex);
 
-	iio_push_to_buffers_with_ts(indio_dev, &data->scan, sizeof(data->scan), time_ns);
+	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan), time_ns);
 err:
 	iio_trigger_notify_done(indio_dev->trig);
 

---
base-commit: cd2731444ee4e35db76f4fb587f12d327eec5446
change-id: 20250710-iio-use-more-iio_declare_buffer_with_ts-0924382d38c6

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


