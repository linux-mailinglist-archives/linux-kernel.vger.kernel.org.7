Return-Path: <linux-kernel+bounces-785764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 965B2B350CC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 03:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB9277A73DF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 01:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DF028D8D1;
	Tue, 26 Aug 2025 01:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eAdwvXwd"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BA328B7DE;
	Tue, 26 Aug 2025 01:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756170566; cv=none; b=IxIgaVFbPAg1/HCMmc+ke/pRFhqep0kR3Y8bsLW+xtOFMRhvLJq1qNzoVeRsigiIitvxr7u/+jvKhQoSfJ655gNRhqx9mX9pk7vQnGTRvMDPzcrDDYF1apBJq8g9sNZekZaPvHLSVNIbbIjoE4ZFOXVfbFORPNFsdzlg6toz19Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756170566; c=relaxed/simple;
	bh=9O3lc/9bQ64hPLns61H0Mu3QkW7B+M2abebASMpzows=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=FJ2d+WxcYVX3KHiXYcIh2EoA8iaI0IPNX7DaHMpsvSsnMGgBk6AEfxKUX7McO8d5B8el95+HFKefINKU4VhRCmMgEBkinW8kEf/mavAZMERjXdAO5PY6GcJCC/HmeiyfCTH9Vc9aRS7O6wCB88UMN1hwRY4QTsy18zNDD8FcZWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eAdwvXwd; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-61bf1542ecbso2390180eaf.1;
        Mon, 25 Aug 2025 18:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756170564; x=1756775364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jNepx41UElk7QS0w0sFASE9HqsxLVcmPU4Fw7Uj0xgA=;
        b=eAdwvXwd2N/gifqvDd7Df7bwKaZczFOWRIS3FOdLHpWE18LP+7T0jji6n6yZYNPW6X
         di1+MZgMU3AFdoIXlpqozk3jQddoYS2owb+4nznqcmQko/WhtbprT4kMj6Xl84sCJkSX
         Kvb6xwbXPPA0iEqzH3qjTMHPED1rFdITLEC7QtPagB0lCN36plOl+KdDPV3mwDo1Chzd
         JfhSYTWBkz0KPrA9ByXkeb/3PbM6ivAlmNzNTj2eUfcnxPC2iT+MflcpbJ+uq8ABS8z8
         1+fsvTyAx6deC9RP+T0wD+uSvltC4MoZwHZ8sgf/0OPqpZtygT6LF4TsAyLXC/Yyk6Nw
         c6zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756170564; x=1756775364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jNepx41UElk7QS0w0sFASE9HqsxLVcmPU4Fw7Uj0xgA=;
        b=pfvbk+MeIBlXVY3YID0RT0657X0kuAYVzZfA9DSuAPKBz8BIdoaqYOvTsD+ZDJK+8g
         /fgCH9ncJ9dK/YN9xLFCoPnt7jCihErYkOz+3uBuEiOWPns4Q4+mZ4ZTvUbTUi/aBO+/
         7btgCa8Azun13KdOIB1HC0wNO3UYglwgRob7HtwVKed9/gqd69auihCrWczgh9vM0Sud
         OUQIE48PbdiJgIXcOiy0bBbM0K+oO8IuspxzjZytsQHXnNaIH+4OvrVwHLYURKguPsTj
         mpjO/CpqmgI0wiImb21wk3SbSoVnA/GeaVpamguRuctgsZ2kdFBsATQbJnyb4OuWintG
         79jA==
X-Forwarded-Encrypted: i=1; AJvYcCUCNET/4dIlkgKb7hqiIyUocPeEXPMfBFtbdw7wZT4Z/qa811WB9z5tnGMXp0boq++0lhH3H+1buCaNdpUH@vger.kernel.org, AJvYcCXqBKTdwR2JmlfpaSTX7qCPRlLXHzlI93i3CJV6/u94xoLRjy4a0JQmQJzwXvRSmfwvf/fRIJ8YRDfJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyjVXGTTgLhOzdHUnWwB7UUy8cLndHmt1OBbN83O4FIxQtWzm9v
	90avJL5i8QldhbbBhfnLVG1BAedeTfxnha+npI5a8QCJ0LwPvR/8XlsZ
X-Gm-Gg: ASbGncuWpqksyeTyaipBwpeH7tTn0S0Zw7QkErTFVJAIGmzKR9Gc4paRLpxZUTJrUDJ
	27ZIS07qJvD2BGGvRFQwN1ZlawDkOMScZQHom+UrwmtewjVpcb1plm7ozwzhhUbyI5pGE3nsvJH
	Ni3k/sZYP7bTOhFQDkQ1oegomNdrBApjKV7XZcFSEMn8PuP0Pgl1wI4LgMqKJeY0pyrdluyMTmh
	3emiKHpMMg7VzK/ZzTMYDLw/XYZ1FiIB91ymDjt/6jLEEhCEnJDoX2yzWTzg8wLLZx9Q7K8AqXi
	EpifNPsDyJdic3Yj0ylcEomM0D3UYh24ag5RDR+RUFJM7eOkCArRH3tSB5Vb+4vSzcpkNB7EAbE
	t6nqmlVmbZ/MGaj4/MgMNnVPRV6pRlFSe
X-Google-Smtp-Source: AGHT+IGBtMv/0WW6P6N98C1dIhOAFBvRCQyuAP3X162OIex4ax2CK73yYgTB3SfjwxO4OMw9LImXvw==
X-Received: by 2002:a05:6871:3a11:b0:315:3dd7:91be with SMTP id 586e51a60fabf-315439e84c7mr937923fac.16.1756170564040;
        Mon, 25 Aug 2025 18:09:24 -0700 (PDT)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-314f7ca7ee6sm2168480fac.19.2025.08.25.18.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 18:09:22 -0700 (PDT)
From: Chen Wang <unicornxw@gmail.com>
To: u.kleine-koenig@baylibre.com,
	aou@eecs.berkeley.edu,
	unicorn_wang@outlook.com,
	conor+dt@kernel.org,
	inochiama@gmail.com,
	krzk+dt@kernel.org,
	looong.bin@gmail.com,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	robh@kernel.org,
	tglx@linutronix.de,
	sycamoremoon376@gmail.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	sophgo@lists.linux.dev
Subject: [PATCH v2 0/3] irqchip/sg2042-msi: Set irq type according to DT configuration
Date: Tue, 26 Aug 2025 09:09:13 +0800
Message-Id: <cover.1756169460.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

The original MSI interrupt type was hard-coded, which was not a good idea.
Now it is changed to read the device tree configuration and then set the
interrupt type.

This patchset is based on irq/drivers branch of tip.

---

Changes in v2:
  The patch series is based on irq/drivers branch of tip.

  Reverted the change to obtain params of "msi-ranges"; it's better not to
  assume the value of "#interrupt-cells" is 2, even though it's known to be
  the case. Thanks to Inochi for the comments.

Changes in v1:
  The patch series is based on irq/drivers branch of tip. You can simply review
  or test the patches at the link [1].

Link: https://lore.kernel.org/linux-riscv/cover.1756103516.git.unicorn_wang@outlook.com/ [1]
---

Chen Wang (3):
  irqchip/sg2042-msi: Set irq type according to DT configuration
  riscv: sophgo: dts: sg2042: change msi irq type to
    IRQ_TYPE_EDGE_RISING
  riscv: sophgo: dts: sg2044: change msi irq type to
    IRQ_TYPE_EDGE_RISING

 arch/riscv/boot/dts/sophgo/sg2042.dtsi | 2 +-
 arch/riscv/boot/dts/sophgo/sg2044.dtsi | 2 +-
 drivers/irqchip/irq-sg2042-msi.c       | 7 +++++--
 3 files changed, 7 insertions(+), 4 deletions(-)


base-commit: 8ff1c16c753e293c3ba20583cb64f81ea7b9a451
-- 
2.34.1


