Return-Path: <linux-kernel+bounces-768289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9441B25F57
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96D3B88362D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BA52ECD3A;
	Thu, 14 Aug 2025 08:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHv377WT"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4753F2E975E;
	Thu, 14 Aug 2025 08:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755160946; cv=none; b=r6Xc1O8BNIRmP+4jTKuYUR0m/+dhedJxAEzOj/f/GCh8DdP7pNpEjBiuaqOsdBBKdN8JzqnJ9gIEw736sw23SQlwvChhdcPJSQRYqIFK/+fV1g2GjvyuYaE+knAwixQxDhCMMIUszySMIwpyVDfXId1oLgV2yAMxFU8sZ4bArQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755160946; c=relaxed/simple;
	bh=6cfI3DwLE9E9SAfgkTqlf+6mrBEBP+O6XCNBkhssvfU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X9Xyl9Ue83q762tguqlPGNBBxDnRiHBhTH/N+89PxRsgHKO90pFE8TpFzYBPLxJtCEdK0557SB2jLP1zzPPYJmoRhZk2nige7qEqeg1d6R/UgVWnEzt5c1uf4ARvEzZjtoI/Oxp3yUX2p4WL99Xze1H7d2ikjMRG8X/CmVvW6MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YHv377WT; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45a1b00797dso4537185e9.0;
        Thu, 14 Aug 2025 01:42:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755160943; x=1755765743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3MIDNnIwbSHuzGfQVuyM2agKWSWdZtsoAJRl1Qc3beg=;
        b=YHv377WTLOnv0i7qCniJNb3qoW9uHSABI/wsyKQaCV/29ng1uLvVfRdkuYLApBUXCJ
         DjFKmHjC9xpFoEf7VV4W5As7hZmAAPj++b812wpDDQ/ptZOyD9fKDUzHBM9TC+owXd9C
         2MunA13MFL4hR5A+t3MSPrQ7//j2lEJ16nFvUuFzOBvztVSd2LKtkhOHovOna33TR5m4
         4y+bSCgnns6o9xOz4jHP3waTnFNCQlI4a12OvX2srY7ercukrRmBpSoPixOlO3ah3H//
         7iVQoWkIwDMMumt+E1JXywjrvphB4BoCOE6LcQT0sN27tTPTaI8ef1ycAZT2iQkAoy/1
         PX3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755160943; x=1755765743;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3MIDNnIwbSHuzGfQVuyM2agKWSWdZtsoAJRl1Qc3beg=;
        b=UpKqjFKGTGjBHLu+NzenwroyFHdFBmWIwmG+/fkRoHnk+vhMT/wkXNrnT6UWpwOIDy
         4sa8yRsmjjVLl8Oz0iPY8KP+3U7RhxHqZ4HTCy+KPsWuVVUqIn4mz2GxIFSYhxlqcit4
         Sh93qYUj8qBJRrmkrIyOVPNw1auNVAGmQETTrNA/6Y9EPCfbEbRh14XYnpQQazFtxpwB
         sSMod/nvkE7wrIhFjfQKS8eA4zRwpe22cs0CabnjgQUNONg9i/F0CJqUaKmiAbj6nors
         g/IlLjo2ZRVIl3+TfcrcaJRcKdEeNqnLryrnZEa0B+7f2O/9QkGUjdwXvTXynvn8Ihbk
         Y5Vg==
X-Forwarded-Encrypted: i=1; AJvYcCUh7jIF3ibISMGeXiyZllorAz4guKYxRKiAluIy4JySVyjRdLJr74xwDVe+iF/DvBF/JaNEb/f/yLXjJnUs@vger.kernel.org, AJvYcCVT2NVMyIkf1Kwrg6g/W5JD3O+Jf8krTaqSs7Woc0ugPexi79MFVDkRC1zUWN1yKstmqh6bmf6lgaDV@vger.kernel.org
X-Gm-Message-State: AOJu0Yz40+HlSEvJ+i5QziVKQZf3SqBjDL2kE67eJ6gMu5eXKH6eo6J/
	j5wFvEXwOVpdUPhIYRQfKbHVQePdQTLg61G4pENV0C1PdgwT6lOhfTB2
X-Gm-Gg: ASbGncscARWNA1khN1rX/bcm74Pinq2awtO1FGSqnGj1jH3IQj2TKnaOsnnmcGirNPh
	Bc4n3SW2RzNhtp8sA/vcrKhrGK8Zdfsiqu0iU/EfTpTS906DtORKJFNO5r7IHv2H1NyfS+1rXqF
	FwbHPP6shi/9TwyXvhwBER48+eMLp9hRg5ZerK/C1W4SvLXvRw4ytbIK09PWkj5sVCuja63j1Eu
	G8fVj1PxjvWdSbG2JFaoQxQvLDiNEqyantA4A5FjOq4X04/nXio/+qPLBOtJTtN/UEkWeZI+PMc
	XpwtD8GJcFsyscvYo5YU6+XJSJONTQK1hm8ZhqbGVlbCkerMsocn3ZKsJrd+Qd9X3gZbPkp8+32
	wD5s+ikfOYUwbm1Ez1BXcyl0/PdvBGVrDhQ==
X-Google-Smtp-Source: AGHT+IEgtdyxJulbukB6J1T/XYYBOj7Oz9S7GIuzZlCe2tyon9JMR3MeOA8LItQkTqLR1PTkqWrZDQ==
X-Received: by 2002:a05:600c:3b1e:b0:456:1d93:4365 with SMTP id 5b1f17b1804b1-45a1b611565mr15680395e9.5.1755160943207;
        Thu, 14 Aug 2025 01:42:23 -0700 (PDT)
Received: from taln60.nuvoton.co.il ([212.199.177.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1c6e336csm13114565e9.16.2025.08.14.01.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 01:42:22 -0700 (PDT)
From: Tomer Maimon <tmaimon77@gmail.com>
To: robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	avifishman70@gmail.com,
	tali.perry1@gmail.com,
	joel@jms.id.au,
	venture@google.com,
	yuenn@google.com,
	benjaminfair@google.com
Cc: openbmc@lists.ozlabs.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tomer Maimon <tmaimon77@gmail.com>
Subject: [PATCH v2 0/2] NPCM845 reset and clock device tree updates
Date: Thu, 14 Aug 2025 11:42:16 +0300
Message-Id: <20250814084218.1171386-1-tmaimon77@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series updates the NPCM845 device tree for the integrated reset and
clock controller using the auxiliary device framework.
Patch 1 combines the reset and clock nodes into nuvoton,npcm845-reset.
Patch 2 adds a 25 MHz refclk and updates peripherals to use it.

Tested on NPCM845 evaluation board.

Changes since version 1:
	- Tested in version 6.17.rc1.

Tomer Maimon (2):
  arm64: dts: nuvoton: combine NPCM845 reset and clk nodes
  arm64: dts: nuvoton: add refclk and update peripheral clocks for
    NPCM845

 .../dts/nuvoton/nuvoton-common-npcm8xx.dtsi   | 20 ++++++++-----------
 .../boot/dts/nuvoton/nuvoton-npcm845-evb.dts  |  6 ++++++
 2 files changed, 14 insertions(+), 12 deletions(-)

-- 
2.34.1


