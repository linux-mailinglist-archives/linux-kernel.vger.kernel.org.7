Return-Path: <linux-kernel+bounces-829560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3120B97572
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 21:29:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA4241B20E25
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Sep 2025 19:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0982A3043DB;
	Tue, 23 Sep 2025 19:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YyuQmoEm"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF67127FD56
	for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 19:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758655785; cv=none; b=E81I1b1nKHK38hwERQsGN+h/W3jDzCIijzfgLJ9vq5IhkzRmPn3wGESr8bYCOBhqr0ZPbeafMubwrWN6n4dGra8BngJ9TijPsrm2fCxLlQjzZOxEQ4n6udMK+KJxGrmAjwW7H90D3CvAuGcrl4x8iFbyKSeZpqgX8HVe5m/ADWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758655785; c=relaxed/simple;
	bh=LcfSPyxliarsrjBW8KdLJnI/wfhzpiagpiOPZ9cPBYM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QX+wFtThudG0EsO2Fu7GN9UmTfQq7bhvWByz1FPiW328yge6hmTIlqRXEAs06d3PNjigFbfeczrC064HM9sKwLj5byc+/ruAY3BjW6KyCSFXSQFdLUNS/3yBJp3pFRRbTl7itcWSGcfgrZAEhNarQGIz2DvNr97quqkgA4Hye3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YyuQmoEm; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b07c28f390eso1090034966b.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Sep 2025 12:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758655782; x=1759260582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WKw5WBcdwThDcwNolMRNTEm2HBfxrHADbBhqF6TW9ZY=;
        b=YyuQmoEmdMl/gzsCYqMtNOcgrdj9MYbs8CeLr2XUPgZJhz8I8wBEbnKzmLm2h3dnus
         VLoHGVRdrGoVxSCt4gAT00uJpHdn4ouIVh28ZPROPIyKhHI3W8gVvvRSflPvaUeRsQyt
         8bJrm8NkO+p8XOyhiVA3vQwtAfiKBl49RiRSFu0DhdlHRBocq9WCBrr0z2Ey+oYQ/9+q
         Fb5V8F9tWD27sR0HjUk/6tBXxIcP0X0OPN7n2S1fwx1ZZfFpLdHyxbRrCkWPcZouHtAa
         iz1l19z9GzJuwmqNcy5wOCAyvykl++kf9TnOLdcpF64yZmpqbFZjQu3tsEXz9DX10QS6
         5GxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758655782; x=1759260582;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WKw5WBcdwThDcwNolMRNTEm2HBfxrHADbBhqF6TW9ZY=;
        b=qOjTfju3is1Ejjs6OIuo5FtguvWfld222SSp4ZOjD8tn8yhkWqdTIX26b6mE6v5RZo
         8v+kCDyIjZjxRc3RDAiKMffbhYKsPZTAPO6VLMTBuPqdIfbRAL/qUOQ6SS+wvvYIzB+H
         b/eHl7jtfaZLFHCxaEKbMCi4Vl5dsHPYuWEzLNKzU7KUcz1XB0MVABAJyuq7NRUeQdLG
         TAoJ2cJMfEPU3egR/lAVrXy7gOUDUE/MLetxk1f1UNFkfzXaOc0g+0n8Mp9sBSPf2j9L
         CZhIeMOD1a9BkuEHPMA8d5EVfqFfNjaqEMm5oXHetoVMNNsSLfjzXiFRHh4pIH7OZEid
         Qoeg==
X-Forwarded-Encrypted: i=1; AJvYcCUVNFceS5BLFJ+OHtuEhVqYImb+X/k4iNWj4NqI9YJ9cyol9twYRgSueB+sEbmVvZLhm3IyOKuWcDatueA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwP8a+6C46RQiHtVt1MMwXmokLaM3vxky4o7ORlLJzyb3TzOMIv
	24Myc/RU7eefTRGHYLwlorfVRvs4viKmLa7MRsMVqvhzffY3L//XJvLI
X-Gm-Gg: ASbGncvAwkOhgo5FwAT/dvSGmnBiIya9CN6SSIMWq8lSWwxYY3WIA7tqZblcGT00BDd
	G8OFbh/FivAQU8GDerI3x4Ab6slT4cm9KsnUK5lmOyxB37hh8ukyT2WTqR8vNmfHJ+gkaRfITYd
	dXY9IM4cg4Vl/2yTM2vvtTkC3rAmOPcXpbxL/9FEuqLbZcYWY917wCZFqzu51/vDr3lBtz6oW/9
	ll7KH7GPS/UYEzzrJAdCxpPKvt3T2nTYvp8INWCZjKHsx7cga5AKcZU3iEfDRJlupy/3CnITd0v
	3PuUoYj7JvslXpLYHMp2/WJTqibWImQS2DESj1VSE3hZT++RDjzWc1lXbhWF1/xGAPS64IVSJOt
	fatOgvrDQMw9+LgKA/E1Vc7IYdkvmXBRoJ4OYu3sBnjo=
X-Google-Smtp-Source: AGHT+IGQZQoVuZFs1hNmyeu90pPHQt+clUVbl7wl8s1PrL/ZcHhNRHRWTlkuntkRS7bYFsGkeIHO8Q==
X-Received: by 2002:a17:907:980f:b0:b04:45cc:9d31 with SMTP id a640c23a62f3a-b302bd1dfe4mr340385066b.59.1758655781873;
        Tue, 23 Sep 2025 12:29:41 -0700 (PDT)
Received: from puma.museclub.art ([2a00:6020:b3ea:9c00:26e7:b56a:5a2d:1d72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b1fd271f895sm1370710466b.97.2025.09.23.12.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 12:29:41 -0700 (PDT)
From: Eugene Shalygin <eugene.shalygin@gmail.com>
To: eugene.shalygin@gmail.com
Cc: Guenter Roeck <linux@roeck-us.net>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] add ROG STRIX X870E-E GAMING WIFI
Date: Tue, 23 Sep 2025 21:26:54 +0200
Message-ID: <20250923192935.11339-1-eugene.shalygin@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds the new board and increases the ACPI mutex lock timeout so
that the driver works with the ROG STRIX X870E-E GAMING WIFI board
without triggering frequent lock failures.

Ben Copeland (2):
  hwmon: (asus-ec-sensors) add ROG STRIX X870E-E GAMING WIFI
  hwmon: (asus-ec-sensors) increase timeout for locking ACPI mutex

 Documentation/hwmon/asus_ec_sensors.rst |  1 +
 drivers/hwmon/asus-ec-sensors.c         | 12 +++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

-- 
2.51.0


