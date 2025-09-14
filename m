Return-Path: <linux-kernel+bounces-815651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D36B5696F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 15:45:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F44317BA00
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 13:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D209F1F5820;
	Sun, 14 Sep 2025 13:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ND6q329a"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04511A83ED
	for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 13:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757857527; cv=none; b=devNQ4IV+ERFEHsAccxZTnuk3tDkouqbxwW/nH5JVwnerMYF3nVxQzcqf27TxfLH362GfpCoJDZ8UM5pvYNErUXfdT6KHy+KA4xZon+4q3aTPF/ezKwrc8vw6TanZNOvRg7UcU77AKMYwBhc013B/2By9hjIoLGdX+uwY9dOIvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757857527; c=relaxed/simple;
	bh=FV8p+SLdKIFqO/3EWnCpzCmMf+GNL0Rh41XOQVklt44=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=chf5XD/e5Oo2BVvqMt3nvKiiZXDxzzQAziXmWqo4Nn9fExS9aM7I+vjBWOKGJXIhlUoqCKis2Gy0TAP01cr03YFRNxn5Dm39eAOQARVhfOzqvAN3DdeYfqrKuNsuYEqVbPxrPdYtizYP/kIGcxSr3aed5PPY8zhLv45+AELyMDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ND6q329a; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3e957ca53d1so580098f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Sep 2025 06:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757857522; x=1758462322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SKUqexZEitT6bzSaew+b19nnDz+WShkm3n1xJnkdMJs=;
        b=ND6q329a1EGIWzr9X2KIU+52m34E5prmFatdZ+tX0K33TUQMiGGV4gk7iSJsD9ytIG
         w+yipH6/RROp+7xDLkUpb8OHQtuey3YeTfp0roesklnuepHQXhZ6fRxgLOueVdtF7o61
         v9qmMqyUNP/Wy0NilM4L53w2oyPR8Iar3uoLYfN83Oq3YVyTT+vXFZZqUMmXQow2WFGj
         6IczwMeT41IFdRwKYke/p7TAtwoJCmbeaAwhqS7H4BWfxdjcbyT5eDJfrKnYgiilIjDK
         RoCYhWRAMqVJOb2mFnX1FRH5FU1t3r7lzQyG8llMrzOFjG2a+iShmgtUtNUyPQv/s6pg
         akAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757857522; x=1758462322;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SKUqexZEitT6bzSaew+b19nnDz+WShkm3n1xJnkdMJs=;
        b=P7w7r1TqnywrZfHqvEaY6rz5KxFRMRvkrL/MEvRYJgDQbEgQYSOlZcG0uGUxJWiUtv
         vLTUUhDhyt/asJcmWo+qwbuVSSMvT5d2Hw6pyyV5XgERR/fDkpkkKAJhUkc7QZuysSpl
         G/y9ShPztjd3IgCZjuUZMHPYgUpTvfwoPdXseXew0Zl23vHKRBUkZRsziwBZiSkLROjf
         swI9jH/dniJOmIbTaEEYlDcP2VH+EkjXGYvqhtbUZdRwDILDIeiSWXHrFzWMttQ8BTw7
         cAS2ybXjOrWIXm6XB/twd0bllvZSDlqNR1v1/oAwNRuoPaLjMAS6RShvYT9mWZAWQRZd
         3aVw==
X-Forwarded-Encrypted: i=1; AJvYcCW5utKcawmo0eAqBC5zySS7cKTZRuq6tRGu67prU2whUkYZYf7SxCzseOsQpZ4t00usLLLujl72LaPfaMk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzb7I86ty0QQG3CP1mySAZDNT/LwY7Z7h03/ZzOhAP2rh8jPp32
	W0nC3fwR+0GlUCCicg8XV5oMWSuYbtKuN6B0/v5qxyddrb6zBK9d4a6j
X-Gm-Gg: ASbGncuP5qxHKg0mauaMBbBs+Zlw8V4OL3NCx3fOqV3xnQbK+ywCCCrv+lw7VQRBFfC
	KJ9kqXMIgCn7ig4tRVCkLgqJdFzy+oHY1e+fJFNrv+xcqvrWQEjF16WwjV2DYYUZ7vEDuQYRano
	LjSpy/vnPmTbpF3DzMMIOSbYzWGzyWW9wNAnyP1P49M4lxIIhgsDobPOVjCIAonWqcDaKS6th0L
	uGPh1Toclso8g5si4C9cz+ikKj7q/2wHvKJ2tEu1Sux9npk5cyXFdP5hl/L34aYNc08bjekaDoB
	EHDyD4fSE2yOC7G5TsSjFSRmDJQu/4kjxfmIZ5AtilruDw2ee2B1BLvhD2p6vAt9ivbyhlyIGhO
	xwgwc+CgIUDrp9m+zhj9T0qxmpADoOaXPpmkwKms5TsYwlMVPtbDyYd2qwRy+JdlGgxh+yaGHEZ
	K3ASUIWupj
X-Google-Smtp-Source: AGHT+IHBvWsNWGPacN8UTX5YfRqDAFI5tNEvxSQah7xL7TEoK8EoMA73bDud3VP/tlRdpm4BfsNPjw==
X-Received: by 2002:a5d:5f53:0:b0:3e5:6297:dd21 with SMTP id ffacd0b85a97d-3e765782ab3mr7606735f8f.12.1757857522073;
        Sun, 14 Sep 2025 06:45:22 -0700 (PDT)
Received: from ivaylo-T580.. (91-139-201-119.stz.ddns.bulsat.com. [91.139.201.119])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ea4b52b7fcsm1467591f8f.33.2025.09.14.06.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 06:45:21 -0700 (PDT)
From: Ivaylo Ivanov <ivo.ivanov.ivanov1@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Henrik Rydberg <rydberg@bitmath.org>
Cc: linux-samsung-soc@vger.kernel.org,
	linux-input@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] Input: s6sa552 - add a driver for the Samsung A552
Date: Sun, 14 Sep 2025 16:44:55 +0300
Message-ID: <20250914134458.2624176-1-ivo.ivanov.ivanov1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hey folks,

This patchset adds support for the Samsung A552 touchscreen controller.
Naming is based on the current s6s* convention, used for Y761. The
IC is similar in functionality to 761, but has enough differences in
registers, bits and functionality to deserve its own driver.

Best regards,
Ivaylo

Ivaylo Ivanov (2):
  dt-bindings: input: document Samsung A552 touchscreen controller
  Input: s6sa552 - add a driver for the Samsung A552 touchscreen
    controller

 .../input/touchscreen/samsung,s6sa552.yaml    |  54 +++
 drivers/input/touchscreen/Kconfig             |  11 +
 drivers/input/touchscreen/Makefile            |   1 +
 drivers/input/touchscreen/s6sa552.c           | 439 ++++++++++++++++++
 4 files changed, 505 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/samsung,s6sa552.yaml
 create mode 100644 drivers/input/touchscreen/s6sa552.c

-- 
2.43.0


