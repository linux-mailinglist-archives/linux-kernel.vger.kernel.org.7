Return-Path: <linux-kernel+bounces-743910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D1DB1054A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3231E562D73
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24ECC275B06;
	Thu, 24 Jul 2025 09:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="MrF50OdG"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A03B917996;
	Thu, 24 Jul 2025 09:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753348286; cv=none; b=o8HlfEfH7VKroTlyvimCxxIhgDvpvEsM8nRouZ1p6DuQH5jpNCegVd9dVo7E5NupdjiR3PT+9t5TA0PPk3PyEfWKc+sBqtF56w552vnA1bg8WjzcGF1iEuNItm57zxj6NNQFY1mqAZZakul35xVStelEPgN6vwSAH38qj2JAMyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753348286; c=relaxed/simple;
	bh=EY4Lm9np97kXOWmb6DEH9ulto5gdHv4JQ7VDq3ShAT0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FnkjB1qoSMXMSnlnDaiIPcAM463/DVmMrsmyZaQTcRQYTXvlSlbzl7+6cvBzEpSwKVYyzmyV6dWBLOPFVdntuBykEhRE3APUHA8N2OqunpVQmSlcUv1aswF+Qd5feWqzj6P8A+NCuy6JBl/vj2R/w9xCWrH6e+DOF1NSRqzxyks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=MrF50OdG; arc=none smtp.client-ip=220.197.32.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=IV
	iP1Av41O8lpFMr9Ant3BobFeE5rdGG24b2RDVqLtQ=; b=MrF50OdGZUtA9X2SL8
	GQTfurgbqgxg3xFcHA8tZmy0W3En84OLGs5RBsDRUvUCglTqLZmalNxZzn+tsFI6
	OkEbpYZA9QT7R5NW/7RNSbebrOJkUfFOOhfJpAuc/spwP07+UPvbx2XduWpBZEU/
	mg21SUT8L+RwyHkF+4wGCAJ9A=
Received: from mps-HP-EliteBook-840-G3.monolithicpower.com (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgD3t9uF+IFooKlMAQ--.35578S2;
	Thu, 24 Jul 2025 17:10:29 +0800 (CST)
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
Subject: [PATCH v4 0/4] hwmon: Add support for MPS mp2869,mp29608,mp29612,mp29816,mp29502 chip
Date: Thu, 24 Jul 2025 17:10:11 +0800
Message-Id: <20250724091011.550761-1-wenswang@yeah.net>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Mc8vCgD3t9uF+IFooKlMAQ--.35578S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Jry7CF48AFWkuF17Wr1kuFg_yoW8JrWkpa
	1vy3ySyr15Jr12grWfKF18GF15J3W8W3y2krnFvw1FqFnrZF92vryakryYywnxAF1rAF47
	JF9akF4vg3W7A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Ug4SOUUUUU=
X-CM-SenderInfo: 5zhq24xdqjq5hhdkh0dhw/1tbiARuUpGiBt0vpRwAAsR

From: Wensheng Wang <wenswang@yeah.net>

Add mp2869,mp29608,mp29612,mp29816,mp29502 driver in hwmon and add
dt-bindings for them.

V3 -> V4:
    1. split patches for MP2869,mp29608,mp29612,mp29816,mp29502
    2. add description for vender specific registers

V2 -> V3:
    merge patches for MP2869,mp29608,mp29612,mp29816,mp29502

V1 -> V2:
    add Rob's Acked-by

Wensheng Wang (4):
  dt-bindings: hwmon: Add MPS mp2869,mp29608,mp29612 and mp29816 series
  hwmon: add MP2869,MP29608,MP29612 and MP29816 series driver
  dt-bindings: hwmon: Add MPS mp29502
  hwmon: add MP29502 driver

 .../devicetree/bindings/trivial-devices.yaml  |  10 +
 Documentation/hwmon/index.rst                 |   2 +
 Documentation/hwmon/mp2869.rst                | 175 +++++
 Documentation/hwmon/mp29502.rst               |  93 +++
 MAINTAINERS                                   |  14 +
 drivers/hwmon/pmbus/Kconfig                   |  18 +
 drivers/hwmon/pmbus/Makefile                  |   2 +
 drivers/hwmon/pmbus/mp2869.c                  | 719 ++++++++++++++++++
 drivers/hwmon/pmbus/mp29502.c                 | 670 ++++++++++++++++
 9 files changed, 1703 insertions(+)
 create mode 100644 Documentation/hwmon/mp2869.rst
 create mode 100644 Documentation/hwmon/mp29502.rst
 create mode 100644 drivers/hwmon/pmbus/mp2869.c
 create mode 100644 drivers/hwmon/pmbus/mp29502.c

-- 
2.25.1


