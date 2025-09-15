Return-Path: <linux-kernel+bounces-817837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE9AB58746
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 00:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62F5D1B249A1
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 22:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D572BF3F4;
	Mon, 15 Sep 2025 22:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="POPGjKy/"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10701311AC
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 22:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757974566; cv=none; b=A9wQRmJ63JcWI5zLd96bo2P31/phadMEQs0h6p26KcKp0EAkzrnhULdP5tstgUdcR3il91yeBQHbZgw+XwMo3I9fRqtTauSfX5ceHfo+5lUYKnlrhe4Kpcg3DSL4yKqOWvigoQO5bDScXu0EUfeVFcLE6rM9LN5d/AyJ+5WbIII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757974566; c=relaxed/simple;
	bh=2TwRQ7Odl35bnTVmkNbaQpjTJrpwNpSaEORP0ZdqABY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=bvBi/37KV07QzcRupypekkEax+eawIVakqd93e12SFqqECfrYNEHBoqONxcgqHvyozJ8M6wxsoe6u95sP6xi5LXm82BZoP6tRQnPzkQm2X8le+E4nRPzlACSPbnvXEOv49h0gS8KsCytYXUC8ean0/xYsMDfyK0Os4qwIfO6rEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=POPGjKy/; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-77264a94031so3443619b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 15:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757974564; x=1758579364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0EANtiW8Fhtl5LLMmH+RNqU0cOM8cX8a+UX3kfhq2t0=;
        b=POPGjKy/82FA8/nOaDwBMi/sWkxXVtUJMrxWz6tLgqLJXDMA35IJ9QJyd8yDAE6xV4
         4d68AR88U/3cIdWaXWKBitcJKSh/P3scD1s9NA75wcLcn7nS2aGKXN9MBKvWcYMLXZs1
         /A1Go8oZwgQxTS0E+y8nilHUB/xo/QHwlwMNJGD+7SviBHNvZj53nNMgrZYrEaSh5IlZ
         THRerBG0hDqq/0PdkhSdkqHo/H2AvNgUY18hOyyrCxNg2pm+uLejMLI5aVWqukWcmGrk
         7IKffJ0Zr3XZAUrQXKQf+m3cOiw0Mm08odYi/ObdwWH5HbCfU5SG1UdSFS/h1kvbKfgE
         ut8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757974564; x=1758579364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0EANtiW8Fhtl5LLMmH+RNqU0cOM8cX8a+UX3kfhq2t0=;
        b=g2pHxC9DEobEfDI9ARCFFlMGmhD6AxIsGbbBb4ZOiDrvsLdgHwPtgQIlt0u5VUBykM
         XMNCEotIYjLl5JeKn+jQnAUWTILB6S6rV9w9F8MLaIWRNYu24qJybZNXvmXTXhRXeWNo
         zM1wLE1UGe/iWgah4ZC0eE49eXxoxWgWW3Thf6lJRg/Q8LqY6hrpbZC9DA9vqhP+3E6Z
         HiH36M+3ZDz7um6PWhBhRaYldpQ1+VrZz/3nCgOzUc1fJmQasapxbg8r1A4ESRWm77Wb
         K9SE8wWl1L5RbZ1yJEuKjux1RCnnXYvnzEMZeaftgOxPzCO1DdlpBiI7d0arJo0hoivl
         +KkQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9X2ainz9WfPkxBsVbe7JcE8SKxOMDO93XX2bltDs4mORaOxlIg6pr6iy8CG4SpSkLkNr3Z2qKntCMiv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZfIQiLOAYaVXZZafncL1H82snYR/zMx0eJmBP4dyaEi7x8WMv
	4GKhE/7iCSj1VhFeBG46T5ALRcY4kdydKE1In6ul4Pjib+u2OgqsaQWg
X-Gm-Gg: ASbGnctdgIbiQtzzu+oRV99mMPCLBy0DOUO0AHJMpaSrdh4KFsNHLfY9TY0H3QEtBVR
	ueAHDeFyUVJeht/Kn4OmbIhLJmvfYhXxF8LowTMv76SvUyDa2vjVmfOyoYnI9/ut3Yf9p7NCOc2
	0KkkwMaJg2eajnfQgEPDxVHuCZhFWk1dgJFlfZXql7yenhBj/BDfTvPVhjM/EQfT7BRqW8dTm1z
	qEbw6L5+RxuDBfp49vGZjvgKjRBSlWWwWd38jKAHbhzMDLKAK/oUoBs15BeUUS77sEo2I72VzHF
	RnRHR/2b50mRhZDkzf+aja1eWmrLXfmLpwP6zyH5DhW/WS3RCDVGUoF/T85laHl6lPe576dHyd7
	XbRXJ6vwC/ot6F+1lMNe0FdXM88IavuR4brlBPbnWJfGohg==
X-Google-Smtp-Source: AGHT+IFh76HLO/YT0qIt7A0bFAgD4JcYWE6WuL5ntYDbwnY3Rk2Yc7swyytB/kjQnM8Lx4/O+5VEeA==
X-Received: by 2002:a05:6a20:ea0:b0:262:66d2:825f with SMTP id adf61e73a8af0-26266d28b6emr9412871637.16.1757974564051;
        Mon, 15 Sep 2025 15:16:04 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f5:b08b:d43e:6485:d878:c0c4:abbd])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-77607c472ccsm14573518b3a.98.2025.09.15.15.15.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 15:16:03 -0700 (PDT)
From: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
	Kim Seer Paller <kimseer.paller@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Marcelo Schmitt <Marcelo.Schmitt@analog.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>
Subject: [PATCH v11 0/3] Add MAX14001/MAX14002 support
Date: Mon, 15 Sep 2025 19:14:39 -0300
Message-Id: <cover.1757971454.git.marilene.agarcia@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello maintainers,

Thank you for reviewing v10, for your suggestions, and for answering
my questions.

I believe I’ve addressed most of the requested code changes. There was only
one that I haven’t fixed, I’ve included the reasons in the patch message.

I’d also like to use this cover letter to address some of the remaining
questions from previous cover letters.

Regarding regmap: thank you, David, for your response. I’ve implemented it,
and the code seems to be working fine. I tested it on the Raspberry Pi
modified kernel version rpi-6.12 with Raspberry Pi 5 hardware, using the 
MAX14001PMB evaluation board.

As for in_Y_mean_raw, the issue is that I don’t have the file
/sys/bus/iio/devices/iio:device0/in_0_mean_raw; instead, I have
/sys/bus/iio/devices/iio:device0/in_voltage0_mean_raw. I was thinking of 
adding in_voltageY_mean_raw to the documentation, so I am submitting a
patch with this change in the current patch set.

Thank you also for the explanations about the extra analog frontend
circuitry. I plan to study this further and send a dedicated patch to cover
it in the future.

Thank you Jonathan for the two possible solutions to set the number of ADC
readings used in the mean calculation. I’ll study both approaches and send
a dedicated patch to implement one of them in the next steps.

I intend to continue sending patches to implement all the features of the
MAX14001/MAX14002. Since I mostly work on weekends, I’ll be submitting
patches at a low frequency, but consistently.

Thank you for your time.
Best regards,
Marilene Andrade Garcia


Marilene Andrade Garcia (3):
  dt-bindings: iio: adc: add max14001
  iio: adc: max14001: New driver
  iio: ABI: Add voltage mean raw attribute

 Documentation/ABI/testing/sysfs-bus-iio       |   1 +
 .../bindings/iio/adc/adi,max14001.yaml        |  87 +++++
 MAINTAINERS                                   |   9 +
 drivers/iio/adc/Kconfig                       |  10 +
 drivers/iio/adc/Makefile                      |   1 +
 drivers/iio/adc/max14001.c                    | 356 ++++++++++++++++++
 6 files changed, 464 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml
 create mode 100644 drivers/iio/adc/max14001.c


base-commit: 671b9b6d7f4fe17a174c410397e72253877ca64e
-- 
2.34.1


