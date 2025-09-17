Return-Path: <linux-kernel+bounces-820993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B28B1B7FF3C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 16:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40E797227F9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 14:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75192BE635;
	Wed, 17 Sep 2025 14:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="w3ggX6aJ"
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080402BE032
	for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 14:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758118660; cv=none; b=hBJREULi5L+2gBv1lr0SCgqVFy8toAwV83uaynaecGC/tPpz2DpZ/tuj8wxlh9bWdR4wh/w6338/bsEOjrUJaNx8PmIM8EaboGGch3aWf8jQPc7FZWCfV3xMFGqgNNY/vWbi87jcWp4DvibRKPFzD/LRdEVOo7FSqtf9b+gfOOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758118660; c=relaxed/simple;
	bh=6hv63xN0KYQWhz2vAf0QB/EYtmLibBjQj8kn4Burfa8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QBBeKKxo97WZClLdsbfhkIIPrQBEcQKE36xWPtn6ERUEIfw4G1GiQtf2woLnlKlVZ3ILD6jJe07XGoMo7UQNhwOH68Ymf8XowHhIwCISHolc25XxVENxwYPgJ7SOcOsw+Y4HevDiicbgzgA0o5oyzoBxx8elFGQjnxK71fTf6DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=w3ggX6aJ; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-331503fdc51so1900257fac.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 Sep 2025 07:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1758118657; x=1758723457; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2dcnvqhytDHVondi2QamJr5XwZgrzeEnuwXkS+adOZY=;
        b=w3ggX6aJwEfAkv8C+yCDG6IhqDP1TWgV2D08BtHZGWC8iACU634hW01VK2hlMpwsyy
         qTyPipes8FkQH869QxQJJhcEdzpKOr/ZdsIqyXsbJRPa+tswVPBWK3l5iDWXNBjBdAuL
         phKu6jbBO5f8oMUgUny58d8jrDiHoSRZ1ltyEcYvScFbPuP5mp1HSeJTWuY2JbLC4Je3
         zTrF21SjiP0Q1RmjcXYEVvO5eFyZfRRvdxeVBYZfP1GrAR0KZUOc/epWnDaITVF4enfZ
         EXJxrqX16d+hstYruK24is3dLTFqZcC+VhqRgQ0eHyBluuteAx8x63RhCRueaoX20UId
         kPew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758118657; x=1758723457;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2dcnvqhytDHVondi2QamJr5XwZgrzeEnuwXkS+adOZY=;
        b=sOTJdfeT+c4zPCMXXD2x4Lk2VJAa+1RtKIbu6cpsObD9TOpbVh8GQmaAX1RidMN2zu
         GC9XlVvCnqA9i8SJMp6/FoxDr3piBUy+qWhioOf2Fs9tPwI9H5uicyx+3qIiO3eRY4bz
         5XjTraegTyKhvWb7jX3akvupGYWM3LHPPHQOR5354FTGoYDLp60lre/SUsNVixP+QFZn
         RX0mwDYDSsiK2smLNe62KdTlltl8BBrkYmU+02pFeyFdn6Wwehq8VjFFda+GG4qd2MrK
         To9JUbOv6w8pWLu9SGzL7wBF9n0lWAIiBTC9aNVFj9UVxjbfOjKgu/P0ClCcoCdGVmY7
         yxOg==
X-Forwarded-Encrypted: i=1; AJvYcCUd2b1aB+qc6oXxQx5AT8wh2dCLPfQVktLn1RubHAlAvEmAfGz6YqdqUmMzyTCA6aQhoB1C28cf/pY85Ds=@vger.kernel.org
X-Gm-Message-State: AOJu0YytVeGYsAGqUDbr8cHHSDPMp7SERbwN2KNGeObC6zV5DzVu8kYM
	H7midkECD+7Y9k2rbidyo5FGIft9SynMcZxBvS30JXsZxrXBn+4iuWJlzF5/M3nXPXM=
X-Gm-Gg: ASbGncuHzDV1nIjmutoeNDdSJDEyob37JTj0GdIQd/EsRghRMZIlL58uqUj5blqsGjv
	EuMUdzEkDOy9CielM3t0Z2vDkbSk8TKXORvMxuWDYJq0BEXr7TAC6gSGBwRsz1R0w891tzvlaKp
	14DtK7iZR78zUTf77H/5+R9W1IS0IfG1VixVzilPYEWrlWZHEUY2GvzldE5+QF5qPgK10BdaYZP
	68tMz1ANtyQwdFD+b8m37VPgjYEECRYS9q6lHdwqssbWCEi3szoScnUxfH4e07qyhTalqNnLRWM
	Je+AhxJ+dSzH2pIrJ6adj49Tp99R7+04Vazn9QBKTZKmEd3GB7GDRdGnrsPlhB//2RJ8or0H97u
	Zv0y4JDueF1TCGuPg6aXhg9ZTAJ4=
X-Google-Smtp-Source: AGHT+IGzJt9Yn527W26iNrzT+3DLjLySBnQVi7hx6OsN1flWKGl/+FA+2GwgxmExVcRHcBhks5H4ew==
X-Received: by 2002:a05:6871:54b:b0:31d:6b5b:6b57 with SMTP id 586e51a60fabf-335bf82124fmr1142378fac.30.1758118656946;
        Wed, 17 Sep 2025 07:17:36 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:72c:cb37:521d:46e2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-32d3537ebdesm6344406fac.21.2025.09.17.07.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 07:17:34 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 17 Sep 2025 09:17:23 -0500
Subject: [PATCH] iio: adc: ad7124: use AD7124_MAX_CHANNELS
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-iio-adc-ad7124-use-ad7124_max_channels-v1-1-70913256a8f8@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAPLCymgC/y2N0Q6CMAxFf4X02QUYw0V+xRAyt4pN3IYbGBLCv
 1vFh6Y9be+9G2RMhBm6YoOEb8oUA0N9KsA+TBhRkGMGWcm2utRaEEVhnOXStVRiyfgfB2/W4as
 J+Myi0SjbRjut1BnYbEp4p/UXdO0PTvhaOG8+lnAzbGWj9zR3BX/nMqGPfC05suQ+Uxih3/cPO
 y69y7QAAAA=
X-Change-ID: 20250917-iio-adc-ad7124-use-ad7124_max_channels-37e2537d7446
To: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=949; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=6hv63xN0KYQWhz2vAf0QB/EYtmLibBjQj8kn4Burfa8=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoysL4Y6PZZASzbARRTWo8XbiFHTsKjzxIp7iVT
 +U1g1EyyxKJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaMrC+AAKCRDCzCAB/wGP
 wDu3CACainziwIbk5oQYsKEeTpfcpDEY4W1ivRUFcy5ptJFOpGTh3PIlUqewWCL0BIJf9QRjMVv
 J/d+Ir3tKUK50uGCn4G4aD0dY5iwIrByozihTuO2mgEKBYjixu4WmMBKV2/ZGNV6/EQPGMebj7T
 eadxB+IeyXTHT02xB6Oh5SG6X/TcsXde8EEF2h/IPk7iGp6yDq4rBBH0QlC8dJU9oDVTrBHLR+u
 f0eHBS2MdnGhWpodPXHgNNBgJzesXpGU3G8RHqDuj+NM4PghshOcQD6pxXaM++0rH8F+YTHTyO8
 ax0f9IhdovMJC3c7/tTNYGLi24iEgGzF8i8W2tfk4H4fD9LO
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Use AD7124_MAX_CHANNELS macro instead of hardcoding 16 in
ad7124_disable_all(). We already have the macro, so we should use it.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7124.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ad7124.c b/drivers/iio/adc/ad7124.c
index c24f3d5127cb83eeab0cf37882446fc994173274..9ace3e0914f5acab695c0382df758f56f333ae72 100644
--- a/drivers/iio/adc/ad7124.c
+++ b/drivers/iio/adc/ad7124.c
@@ -702,7 +702,7 @@ static int ad7124_disable_all(struct ad_sigma_delta *sd)
 	int ret;
 	int i;
 
-	for (i = 0; i < 16; i++) {
+	for (i = 0; i < AD7124_MAX_CHANNELS; i++) {
 		ret = ad7124_disable_one(sd, i);
 		if (ret < 0)
 			return ret;

---
base-commit: 561285d048053fec8a3d6d1e3ddc60df11c393a0
change-id: 20250917-iio-adc-ad7124-use-ad7124_max_channels-37e2537d7446

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


