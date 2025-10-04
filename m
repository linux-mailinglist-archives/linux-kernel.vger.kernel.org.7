Return-Path: <linux-kernel+bounces-841901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DD72BB87F7
	for <lists+linux-kernel@lfdr.de>; Sat, 04 Oct 2025 03:57:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BB7419C2236
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Oct 2025 01:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5C5218AAB;
	Sat,  4 Oct 2025 01:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="coyUrBqa"
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D21218AA0
	for <linux-kernel@vger.kernel.org>; Sat,  4 Oct 2025 01:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759542997; cv=none; b=nWaq1gqTTABZOV5qhvcQCvWT/dXr23v1SIJznTTNIkNHvw/kfhJpkkuUOPMnVNyZAlax3qSqUzj3ttL496y6mTIsdD9ds3y/yuyUreWtCLsGjuZHvvIOWMmm6CxEmVyp1+l/QODbch9ZPTZpdp5R0STForakEY3D/66ypAvId1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759542997; c=relaxed/simple;
	bh=hORoEnA4rNo9eZ2TnSKm6bO35jEMPOOzljSvUmmDcv8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IYzHL1DnWN+9IyNDRwohoIeksaofjEG5T5Yyszit43ea1nyaDfIKBoD6mLcn0T52yL25ESspBsIeOTbhuNsQpkJfs0ZZTzqtBTfjnnvLYMf3TmjHwAe3awIbFEa7Io6XUsuiRpWHbfihjT7cEhkg5zqTbcC1EgQgE1ax4MQLBqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=coyUrBqa; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-b5f2c1a7e48so2172401a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 18:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759542996; x=1760147796; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yTEqLH7hif0P56GR/htRgCIrTJyGDU/Of++XnbDqejk=;
        b=coyUrBqapuTJexS7xn3g52pQ2K4nTdBao9aI7hgyXEBvxBzjbXPVYEPAiGkDDgmnFr
         Gj4obPiJ+uRwZUtTXaldiG4X+rsurHtUqdrb/uCZ153jMkHOB0gLvCgzT4BwNeC0IKxs
         ayKdB/OUwX42ILX/ON58RzDbMZ0gVoxf8TH+rnyzn+aDdQliK5aTFyXZ2AaehD4X7QMt
         Sou4Cb/aGyOvh30hb3OAqoLWh7RK45UhszORo/t4EDBuuaa8HL3uSTdowrwjGTG6K83o
         dg/1GmKic5Hfy1UP9LyJiFFk4IC45H9MmDQ6nfZNgZaQN0Of8cZvSqals0Y6SJCqldIF
         Oxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759542996; x=1760147796;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yTEqLH7hif0P56GR/htRgCIrTJyGDU/Of++XnbDqejk=;
        b=rt8T3ZK214Q6yo0DydTpoEh/R2oiLjEXnAWTI6iwA2RMOFV2QVj3FiFU7MJdK5rqMI
         ngVIRiahkQ0Q/T/L/lZRptvVd1pMmhACUiF9hvs3HXo9EBI0/yVI5ByGM+nG1IPiaNtb
         X6nqaOpzylNWqyVma5dvW5qJ018sI2htUUEo/Db/PDG5waMfE5JRhBm7uWUImRiAZEQ4
         8K7bidg8cfDYMgHyQM8z9nc6bd3HA95j3ySQD6lMVih0DwUzM32RHpMW76voKxymZKD3
         7yqUEs0GTU8zObeaWJSVnI1M9ETm8Uq8qIpGvAtPA2qY0OZ1/sFptRzwMn8qNHrnDnx1
         rIHg==
X-Forwarded-Encrypted: i=1; AJvYcCVC0N6dJ3DBiuOKhniqioQqwlB9r8ftPAWV8blHHNwgDvd3nu0IjnV09Ai8MJQlrLMqQiDDbEUQ+12x49c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuBjFx+uKvxPXyDPTFz13jPLVdPd83FB98QcA0Gfe6tXJ1oXJ7
	Az2GAxNb5erO5Gkzvm1yhPYgiShSbT0Ra4zDUmOZB/KdUIUfmMdjxsiK
X-Gm-Gg: ASbGncuLZuadT/14TsANktwtfVxSU6aZVX8qrvkiN8ISSko972lRw2GX6MI4LP21WnO
	BLd+rmktbKpVFRWuCtX44xZEbgq9RNg/VJdYYCwLUQ4a/KHkN0CHakDz1MQalqbNr8WTFN81BIm
	5+/oGLbX8RBIYHE+i9b6Wa787rlmhEiN0BlHQXTXkuHqE28HZ3kZB6hOxm6p7ig0eubsAcijDT5
	A7wHGXsMT4+Flty+fW3zEbRMs3dhGV0BOqMEFA6Lkk6sYTrrxclcj4XS7foGJ5lchtvNdvG3FPQ
	SdVa7Tkp+fnHK+EGxYNswbq+uJsVy1m+wJ9VSq0maLcQLTCqxL+DIWAnwX06ddN7ZwPkbh6wzAy
	ix8W4GtuzLqSpUPIoQZFwvU8q9rpIou2Wb69w1LNpMQIS1z/9HuKflag=
X-Google-Smtp-Source: AGHT+IFNiL0NAmoLijKiqKFOV1i/A4WOPLrh/tgGYP4tBcXBAwrLn0RbO3aVkg2rfnZrEJWChZJVIA==
X-Received: by 2002:a17:903:a86:b0:248:fc2d:3a21 with SMTP id d9443c01a7336-28e9a5cdd22mr51596345ad.4.1759542995628;
        Fri, 03 Oct 2025 18:56:35 -0700 (PDT)
Received: from Ubuntu24.. ([157.33.197.131])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-28e8d134859sm63197485ad.57.2025.10.03.18.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 18:56:35 -0700 (PDT)
From: Shrikant Raskar <raskar.shree97@gmail.com>
To: jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	matt@ranostay.sg,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Shrikant Raskar <raskar.shree97@gmail.com>
Subject: [PATCH 0/2] iio: health: max30100: Add DT pulse-width support
Date: Sat,  4 Oct 2025 07:26:21 +0530
Message-ID: <20251004015623.7019-1-raskar.shree97@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add device tree and driver support for configuring the MAX30100
pulse width, addressing a long-standing TODO in the driver.

Tested on Raspberry Pi 3B with MAX30100 breakout module.

Shrikant Raskar (2):
  dt-bindings: iio: max30100: Add pulse-width property
  iio: health: max30100: Add pulse-width configuration via DT

 .../bindings/iio/health/maxim,max30100.yaml   |  6 +++
 drivers/iio/health/max30100.c                 | 39 ++++++++++++++++++-
 2 files changed, 43 insertions(+), 2 deletions(-)

-- 
2.43.0


