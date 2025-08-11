Return-Path: <linux-kernel+bounces-763609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 470D5B2176F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 23:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B25F3168BC3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Aug 2025 21:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01C82D63E5;
	Mon, 11 Aug 2025 21:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pinefeat.co.uk header.i=@pinefeat.co.uk header.b="Ki2b8kgH"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A17D2D481F
	for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 21:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754947902; cv=none; b=i99HY/RgiFghbAvHS9NysVaoen2kDe4i48hM7WCU075+4p7YS0w7HcM7QoCzRn85jlo9LLgjaHE6iAFSuH6NLihXHKxNvPRqqPUQ8mDG3XmuYuuipNCvvHjpbDv0jxpX1dOe6L57ZVzUo1YhS0JX7cthy775188H3X+p0Dg4Dng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754947902; c=relaxed/simple;
	bh=A7sBPj0UtuSH9vGuJB9qRxAejgbw0PMmS5KnCE2Na3c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Y3sasNSMbPXOdNGzHHFuHsV4TgxgnPQ8wLiTH66Fy473xb+SF2WuOtpHpmC559wDdoPUXFx9TBJBnDXOaYyUAHqUFhm3MNueD5RjAC6wprJyzV3jmOlp1qx+hMx3TXcxRSRxRGaaC06nPKbF1wk5zn4zpBiW36uOelSIB9VFNjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pinefeat.co.uk; spf=pass smtp.mailfrom=pinefeat.co.uk; dkim=pass (2048-bit key) header.d=pinefeat.co.uk header.i=@pinefeat.co.uk header.b=Ki2b8kgH; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pinefeat.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pinefeat.co.uk
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-459ebb6bbdfso31013435e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Aug 2025 14:31:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pinefeat.co.uk; s=google; t=1754947899; x=1755552699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DYzITiNffVuRdA1N1ljG/+eAuKtVyktyWrYwNqaZgpM=;
        b=Ki2b8kgHlRkL9NTL4lUhPAifvQ7VLQ+PcTJlqwGdsr9tw2UqZKyEG1relRdy2HkMUw
         dt3IX47BvVlSUgewlFlv2NesjMAlP3VqAacFV4wROCWZQ4AXccZFsO8zgMyvlxr1W9sS
         KVcEil56XRvj5/XpBjjlQxoDD6EMxc3LyIawxk5XH4hQ9pJGqXC0GH8T+i7oh9pZz7db
         fBh1tKrxSjhQDk5OlGw/noouiMmm6k7i8tTU+FrDIqRXWbt5dMWo23OrGZWScqvp9e2c
         j8nrpRuu0JwZ+UL/0x6W3jbSqZgvqs8SdxSmYLCZiwSn7t1UHifqrNMHhWw39qzRTU3w
         U1aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754947899; x=1755552699;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DYzITiNffVuRdA1N1ljG/+eAuKtVyktyWrYwNqaZgpM=;
        b=nwgZKXwERlYE5x41YtAQTf0eom0aq/evflaDRYvSdjgAbIeo4+QB7PSUO1gfpUOUl9
         zqYhZQmsKZmQmOBW0kK91o4UALydmjI7GBl5gh98/ZhChUXwOwL9M+r0iU54ITCTfAfL
         IkBw4B3qjhfN3OrOiBB5BUSU08fyDMNcaZpTuRhvklrabXfntVYTmx+gFI6rHr8rcrBt
         v349MbbBvWjP17VcRnoDsuYOWV7rGOjlVsXOAQKhXIHJD2aZvjOiO9uglJYA+VSPZV9K
         5idmNRb8XQ1CWt+Q+dqIKgp/8D0RdgnHGNXfB8/XN/J9WyaOycbmbg18s4jKYX11UJZQ
         hc9g==
X-Forwarded-Encrypted: i=1; AJvYcCUBgegNO/i/nCS6RDwdrhicjjeLp5SZXN4Ut9XA53NVIZRi0WUN/BEV9FVkII2Q2uyHwv8mesY9vVJdHRk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7WCZL5purzOiSnZj2ap8AXQroQ0uLKO4HYK9XUmKEi6wds6Rn
	Fc3ylJ8d817SlDeCIVWfYVpqfhv0cp1zBSjwY1bV5eaPs8MKDQfyTlYKmhynm3ILnZyEZtHEj8N
	hUUuHkGXYhg==
X-Gm-Gg: ASbGncuxjtq2REJjnw8fXd0hrBswlIHfxsF/97dLBtObkzNaPY03kizNe1y6KYwrP2N
	iW4i1ZXvf/lPAx9OiDNpmgiYPQihvfb8EIC2WBzI/RtaxC1JDVnQogk8B/2MJAPNwdR/WiiGlBE
	ox2I6hqpmsBR9pdHLhkPNLhBvh7SF0QAQ0r44Ka8TChjD5xTOyAYjPCBdlxiQedVU/ESHDgsW54
	gtkYTApH460r0KicIT1JZmz0N8amIf3aF9UECXwvTFgHUz+ydCdZoi58oNflm+cOizyZ5Mz8Nmd
	vBprm8ndSDgKf1NpUaq36MeEk5gK4yYlS3fNZTeyW5Jz8E+kgA6LEwY6jDXd/HzWtVfgM/JrVBF
	ylbpo9mVLjS1TNgQtHVjLjY6CIpcChOkNt5WGoTKMAZ5zMEUB
X-Google-Smtp-Source: AGHT+IG6kJ5mVgtdOC96YHAJij3E32r9WMZPowvaweTxAYjG7iGvD+92On2w6MtfqnNA7HMakNZTVw==
X-Received: by 2002:a05:6000:24c5:b0:3b8:d7fe:314d with SMTP id ffacd0b85a97d-3b9110079e3mr944396f8f.36.1754947898457;
        Mon, 11 Aug 2025 14:31:38 -0700 (PDT)
Received: from asmirnov-G751JM.Home ([2a02:c7c:b28c:1f00:f8cb:3493:2eed:8d11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c485444sm42397387f8f.66.2025.08.11.14.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 14:31:38 -0700 (PDT)
From: Alexander Smirnov <asmirnou@pinefeat.co.uk>
X-Google-Original-From: Alexander Smirnov <aliaksandr.smirnou@gmail.com>
To: mchehab@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aliaksandr Smirnou <support@pinefeat.co.uk>
Subject: [PATCH v2 0/2] Pinefeat cef168 lens control board driver
Date: Mon, 11 Aug 2025 22:31:00 +0100
Message-Id: <20250811213102.15703-1-aliaksandr.smirnou@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Aliaksandr Smirnou <support@pinefeat.co.uk>

This patch series adds support for the Pinefeat adapter, which interfaces
Canon EF and EF-S lenses to non-Canon camera bodies. The cef168 circuit
control board provides an I2C interface for electronic focus and aperture
control. The driver integrates with the V4L2 sub-device API.

For more information about the product, see:
https://github.com/pinefeat/cef168

There are no regulators on the board. The MCU is powered by 3.3V, which is
supplied either through the CSI connector or the serial connector directly
from the Raspberry Pi GPIO power pins. Hence, the driver lacks any regulator
handling. Please let me know if regulator support is still needed.

Changes in v2:
 in [PATCH 1/2] addressed review comments:
 - added optional vcc-supply property and example
 - made node name generic in the example
 - removed tree type and location from maintainers entry

 in [PATCH 2/2] addressed review comments:
 - wrapped devm_kzalloc line according to coding style
 - removed oddly formed i2c_device_id struct as not required
 - formatted of_device_id struct according to coding style

Link to v1: https://lore.kernel.org/all/20250810192609.11966-1-support@pinefeat.co.uk/

Patches:
  dt-bindings: Pinefeat cef168 lens control board
  media/i2c: Pinefeat cef168 lens control board driver

 .../bindings/media/i2c/pinefeat,cef168.yaml   |  52 +++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   8 +
 drivers/media/i2c/Kconfig                     |   8 +
 drivers/media/i2c/Makefile                    |   1 +
 drivers/media/i2c/cef168.c                    | 337 ++++++++++++++++++
 drivers/media/i2c/cef168.h                    |  51 +++
 7 files changed, 459 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/i2c/pinefeat,cef168.yaml
 create mode 100644 drivers/media/i2c/cef168.c
 create mode 100644 drivers/media/i2c/cef168.h


base-commit: 2b38afce25c4e1b8f943ff4f0a2b51d6c40f2ed2
-- 
2.34.1


