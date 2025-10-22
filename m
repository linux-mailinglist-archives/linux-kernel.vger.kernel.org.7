Return-Path: <linux-kernel+bounces-864127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D605BF9F9A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 06:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31CCF3AF806
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Oct 2025 04:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 274812D7DD5;
	Wed, 22 Oct 2025 04:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=reznichenko.net header.i=@reznichenko.net header.b="G7JBiS9L"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F31F2D73B1
	for <linux-kernel@vger.kernel.org>; Wed, 22 Oct 2025 04:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761108433; cv=none; b=hQxveniR31CFGk6wLnp8ce8FqkyKjKVWJAgYE0ghg2WMS6Hl9acQOaGdTko4ShH9JLoEymacHOnKT6nvOjPdPNg/i0lHgcF7f11m4YHhil2ZtQvUQKGc4PQHzdI/LQcqVns4ldqGN4hYldhTiT26krCv1aDKQyULGIvGO9QGgug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761108433; c=relaxed/simple;
	bh=DWS7b0OXi35GUhqaHArR2mIysKoute9ykjs7q/LnTyM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aXOX+ZnSi/Fp02wEhRtJrBgy2E59p+AV6zd0Qz+T3AXEkK/L0XVb3fC8OxvCMXZvY6b46DHyEBEjckU+Sb5yB3E10f0qPR9lhEK7wrFeh8zGfXVgy5za4oInOB2IMmxYjlUYFU6n6CRDUGYZGZDsmdIb+la2PmdGRPnC5nlr62I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reznichenko.net; spf=none smtp.mailfrom=dpplabs.com; dkim=pass (2048-bit key) header.d=reznichenko.net header.i=@reznichenko.net header.b=G7JBiS9L; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reznichenko.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dpplabs.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-290b48e09a7so76943345ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Oct 2025 21:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=reznichenko.net; s=google; t=1761108430; x=1761713230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OBuTemYA/SGUaF+DBF41ycHM+zeDM425yx/z5PlZWVc=;
        b=G7JBiS9L+3GrHf4wseXIOFIEvK+EEblLVdX4IdLaVMl0KvPb+gWbsg5C2sdCX9cS4J
         MUOlVR8FexBqW2BMo8wMzqCSP/4GKhYw9ryofYizqLgk8oeJGKBTSDLNtJgSkYl9dmEv
         GZQZzmhp3v/AzLb+g8Vt/CdQBxf8mt4zgqByQNOLsIi3C9WOrL5Ig2MKrPGmeZ5xiYhk
         6z2IDXfqpBcxAQqCtUKpCVFMjehAfpMJhqzpTLr+J2oxyl+GlDsbHEhLQfwoV79mVJQd
         tG239J3aCJOCs6sYiNfDFINEEMsYQcLJ0ZkDKyTYm4T8wMHdZiyGWQzmW6aV04+OiU9C
         JHtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761108430; x=1761713230;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OBuTemYA/SGUaF+DBF41ycHM+zeDM425yx/z5PlZWVc=;
        b=ghOcCbpbyFp/5lcR/235VLaICxHXijBVusIq7UcJu2xBDTySkW/YMHAoOg2vFzWWkY
         VQy/QxTDMqLPve0+kdoLJi5W1U8Jukg9F20PVNdSrH73gT2X0y+jHTF4/D7UpMNbpLn0
         j6/Wequ8k1Lg0ySQnSycBCbODX3/kAtG92vFKqFCQa3ZppkJGzpt7TqpaXeW7kyu58pd
         8MTuGx4fgaW4eRiBbKQyI0/CzCmZfSYKUgCwAoxETjAK2/MILj5nX/2yoUhMUu1AUVuj
         waU00/XVVl0Hbpxpc0sMK0qnQdLK4n9VHxZ/24gcBE9ua/KsbtyFK2xxn/+F/FA2J7My
         ZnlQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0m/WmIutB/mv0ZvzdNmFFxfl6svBXzphTwMWfxoTI6EQMmyaFdaO2O7a1iy4phl/5e0WOEv8wn9SiA6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXzdM+zUO9TyJxBo9muVXw77Pi/SyAXGf6cxEx2c759YaKSjZS
	sVJJV0K3wpJIxmP/1PzuUGrBppMoHYzuOm3ogdEyaJ/3adrVrAQXEc1GK2K1bsmwY0M=
X-Gm-Gg: ASbGncuqiFJLcZYgdLjI5eLmmz7WjKF1zb76sxeBkpd+i+CUvQ0PT3cjH7I5zIHZxHL
	9R4FmKOeA7Jy5VPOQ1ZXULlpLEvvvWTULofS+6w2AY9oklNdlxqJ5vu1U3xfpIqXU5SoCYy+Y8U
	s4AfC8fNZvSP//u8mbKICKyVampo6hayg0kKspcoZR/voQpXHUN/zFeYNVCQ+sTcsK8qY2+yCeq
	ntShmaAHvxMS2Yb0z6qiCvCPSBwkr73wW/6mG4XEx2T7udz8Xkhr++l26R8jz+NQMWVgzMDNRn5
	mIU7BF8t9M3AIuytvXUn8XFIwdx3K2IvXPSEqMmFEf1U4zfkQ4zDnjneZzVL7OOT4fBLtHBK7qg
	tOWHg33e709PQCROKPmcZv5r15Sr35ZwKx24XWyNeQnavqe2XMXrt+ZEe9zOLM1sjnkaiaVeOWW
	no5P3vQgKXMz4rx7Y=
X-Google-Smtp-Source: AGHT+IHMzyYghXKArrXF4a3abFsvEWo0yK9xR3k3Ts3BFNdVJw1LghdAf673yg3EmO+eQ2pXjMB9AQ==
X-Received: by 2002:a17:902:ce8d:b0:272:a900:c42e with SMTP id d9443c01a7336-290caf850b1mr243342655ad.35.1761108429966;
        Tue, 21 Oct 2025 21:47:09 -0700 (PDT)
Received: from z440.. ([2601:1c0:4502:2d00:8004:e310:f3d:dd0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223dd9d6sm1257413a91.7.2025.10.21.21.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 21:47:09 -0700 (PDT)
From: Igor Reznichenko <igor@reznichenko.net>
To: linux@roeck-us.net,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com
Cc: linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH 0/5] hwmon: Add TSC1641 I2C power monitor driver
Date: Tue, 21 Oct 2025 21:47:03 -0700
Message-ID: <20251022044708.314287-1-igor@reznichenko.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series adds support for the ST Microelectronics TSC1641
I2C power monitor. The TSC1641 provides bus voltage, current, power, 
and temperature measurements via the hwmon subsystem. The driver 
supports optional ALERT pin polarity configuration and exposes the
shunt resistor value and raw shunt voltage via sysfs.

Tested on Raspberry Pi 3B+ with a TSC1641 evaluation board.

Igor Reznichenko (5):
  drivers/hwmon: Add TSC1641 I2C power monitor driver
  drivers/hwmon: Add Kconfig entry for TSC1641
  drivers/hwmon: Add TSC1641 module to Makefile
  Documentation/hwmon: Add TSC1641 driver documentation
  Documentation/devicetree/bindings/hwmon: Add TSC1641 binding

 .../devicetree/bindings/hwmon/st,tsc1641.yaml |  54 ++
 Documentation/hwmon/index.rst                 |   1 +
 Documentation/hwmon/tsc1641.rst               |  73 ++
 drivers/hwmon/Kconfig                         |  12 +
 drivers/hwmon/Makefile                        |   1 +
 drivers/hwmon/tsc1641.c                       | 801 ++++++++++++++++++
 6 files changed, 942 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/st,tsc1641.yaml
 create mode 100644 Documentation/hwmon/tsc1641.rst
 create mode 100644 drivers/hwmon/tsc1641.c

-- 
2.43.0


