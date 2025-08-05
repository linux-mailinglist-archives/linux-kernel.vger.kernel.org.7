Return-Path: <linux-kernel+bounces-756283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC73B1B247
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 12:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63BD67ADABE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 10:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC21242D89;
	Tue,  5 Aug 2025 10:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="mFiuW5NL"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FDF241103;
	Tue,  5 Aug 2025 10:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754390991; cv=none; b=u+91ckLy0ZvztUhqq9giXkEyiHyJO8NXJfSw6WDpyq3SAwadoBt70P/4fePA2lT6BSenuV/PNftmwq8D7eaopaqOMOiTnWyDVEfeGTjmzjZiwHGgNcHwty4QKhQ5GVVTfOIMjq0B2L+ipsTY7ztcMQZT04OS2moOlp8jqZMSlRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754390991; c=relaxed/simple;
	bh=eUJpBM5UpflGQEfCOru7b6IABxwniVB1XvP15ppypv8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rlhuqfyhJ5aXQyWh5SBRIFIJXgdBQ0A5LrGJZ93Hbai5aGaLGA8YAL0qCgtBZO23bcwWxBH3F2Op1QNzV3lKyofgzMKqrSCwg2cr5/m138KD+Pz65B9Nuh4YE3T+NROMCWr0BA8roGn0MM08xcmCjZQ5pBnuuktN0lMnVJeYEdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=mFiuW5NL; arc=none smtp.client-ip=1.95.21.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=5O
	i2gXp3dD6thDxh8W8Dfdr/GcxBxdT2oC/oe+OASrw=; b=mFiuW5NL0kmFrww2GY
	+ZkZaRNwXwnracuQthonUdkgbx9Pp8eXA2+u7x9kQdYCQTh+EUZzRnitKXR/KKac
	lkDgoSlvXXwA4tLazixJ4ooOhTA9+87BVJW9AkhVeM3U9l57cMEvzDC6wriy7YJJ
	fG7A7YI8phODuXDOSejJzLPLk=
Received: from mps-HP-EliteBook-840-G3.monolithicpower.com (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgD3tG5v2pFo7LkQAg--.55756S2;
	Tue, 05 Aug 2025 18:18:24 +0800 (CST)
From: wenswang@yeah.net
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	jdelvare@suse.com,
	linux@roeck-us.net,
	corbet@lwn.net
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Wensheng Wang <wenswang@yeah.net>
Subject: [PATCH v5 0/3] hwmon: Add support for MPS mp2869,mp29608,mp29612,mp29816,mp29502 chip
Date: Tue,  5 Aug 2025 18:17:54 +0800
Message-Id: <20250805101754.749492-1-wenswang@yeah.net>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:M88vCgD3tG5v2pFo7LkQAg--.55756S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFW7ZF4xZw17CFW3Xw1kXwb_yoW8JFW8pa
	1vy34Syr15Jr12grWfKF15GFW5J3W8G3y2krnFvw1FqFnxuF92vr1akryYyFnxAF15AFW7
	tF9akF4vg3Wjy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Ug4SOUUUUU=
X-CM-SenderInfo: 5zhq24xdqjq5hhdkh0dhw/1tbiNhBR9WiR2nAKzAAA3X

From: Wensheng Wang <wenswang@yeah.net>

Add mp2869,mp29608,mp29612,mp29816,mp29502 driver in hwmon and add
dt-bindings for them.

V4 -> V5:
    1. merge dt-bindings
    2. modify the syntax of mp2869 driver code

V3 -> V4:
    1. split patches for MP2869,mp29608,mp29612,mp29816,mp29502
    2. add description for vender specific registers

V2 -> V3:
    merge patches for MP2869,mp29608,mp29612,mp29816,mp29502

V1 -> V2:
    add Rob's Acked-by

Wensheng Wang (3):
  dt-bindings: hwmon: Add MPS mp2869,mp29608,mp29612,mp29816 and mp29502
  hwmon: add MP2869,MP29608,MP29612 and MP29816 series driver
  hwmon: add MP29502 driver

 .../devicetree/bindings/trivial-devices.yaml  |  10 +
 Documentation/hwmon/index.rst                 |   2 +
 Documentation/hwmon/mp2869.rst                | 175 +++++
 Documentation/hwmon/mp29502.rst               |  93 +++
 MAINTAINERS                                   |  14 +
 drivers/hwmon/pmbus/Kconfig                   |  18 +
 drivers/hwmon/pmbus/Makefile                  |   2 +
 drivers/hwmon/pmbus/mp2869.c                  | 659 +++++++++++++++++
 drivers/hwmon/pmbus/mp29502.c                 | 670 ++++++++++++++++++
 9 files changed, 1643 insertions(+)
 create mode 100644 Documentation/hwmon/mp2869.rst
 create mode 100644 Documentation/hwmon/mp29502.rst
 create mode 100644 drivers/hwmon/pmbus/mp2869.c
 create mode 100644 drivers/hwmon/pmbus/mp29502.c

-- 
2.25.1


