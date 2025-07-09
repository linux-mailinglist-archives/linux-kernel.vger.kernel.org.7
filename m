Return-Path: <linux-kernel+bounces-723180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 114C7AFE412
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 11:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 133CC3BEF0A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jul 2025 09:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C7827FD71;
	Wed,  9 Jul 2025 09:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="AYln+JiL"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507F2284687;
	Wed,  9 Jul 2025 09:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752053341; cv=none; b=qYPMwbj0KawDYpydonDiHiUoJaMaerPK71PFnkY7zE+RjbpvbMkpcWNuVZmYskKQ4e0ieCbWkAGXJFw43hPRFwlK0yqgZ9QG+G1YCKr1KOycOOCZ66cP1YlPN4KHlU7afwnvNTuRyTQV5Ug7IfXzYteo03+a7R5rPNNfp21Fusk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752053341; c=relaxed/simple;
	bh=SUUPu1TK3vLUbU4R1qK+dOtOfweVWwDvXy6gG2NmyMU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K+r+SPIbGGa56tUTH3NlEDeIbO95wDF16RNufPP0yid03r26mqiSkByAtX1v7BkRo84SNY5tQ9Dg2YsILTtMcjdJ5q8Z/+c7kewrsbTx8cVR82CwcJn0TpqAwBepYfYpqjfLlKmYrX8YeZ7CnN2FAd9RLYf+WdGPuCR7LTjcuA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=AYln+JiL; arc=none smtp.client-ip=1.95.21.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ra
	2XD4FbWuJFaekuy5bOA91tXw3KGrTkuZ3e+KtFUTw=; b=AYln+JiLa31fX4Dehg
	Hw4rTC7Nydz9C3kAqsfOIpolQgaRfj9qi1t8ClKThDSmzwILT94AWmPyheOmX5Bf
	KXUuah2Js89g3wadbbHBx7VK8oojA5EA2t2xvpp3m1uTEIL41ZBIiR0zBxGavNyS
	jhqR81wlnRWL3ZQjP9v44Uzj4=
Received: from mps-HP-EliteBook-840-G3.monolithicpower.com (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgDXH7kSNm5orlQbAA--.56013S2;
	Wed, 09 Jul 2025 17:27:48 +0800 (CST)
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
Subject: [PATCH v3 0/2] hwmon: Add support for MPS mp2869,mp29502 chip
Date: Wed,  9 Jul 2025 17:27:34 +0800
Message-Id: <20250709092734.455976-1-wenswang@yeah.net>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:M88vCgDXH7kSNm5orlQbAA--.56013S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jry7CF1DGF4ruFy7GFyfZwb_yoWDJFbEkw
	sFgFZrAF1UJFs8WFWDCrn5uryUtr4FgFyxJ3ZxtrZ8AFW3Z3ZxWFykX3sFya47CrW7uF13
	ZayDAws5AF17KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU87l1PUUUUU==
X-CM-SenderInfo: 5zhq24xdqjq5hhdkh0dhw/1tbiIBRI7GhuNhTOeAAA3C

From: Wensheng Wang <wenswang@yeah.net>

Add mp2869,mp29502 driver in hwmon and add dt-bindings for them.

V2 -> V3:
    merge patches for MP29502 and MP2869

V1 -> V2:
    add Rob's Acked-by

Wensheng Wang (2):
  dt-bindings: hwmon: Add MPS mp2869 series and mp29502
  hwmon: add MP2869 series and MP29502 driver

 .../devicetree/bindings/trivial-devices.yaml  |  10 +
 Documentation/hwmon/index.rst                 |   2 +
 Documentation/hwmon/mp2869.rst                | 175 +++++
 Documentation/hwmon/mp29502.rst               |  93 +++
 MAINTAINERS                                   |   9 +
 drivers/hwmon/pmbus/Kconfig                   |  18 +
 drivers/hwmon/pmbus/Makefile                  |   2 +
 drivers/hwmon/pmbus/mp2869.c                  | 711 ++++++++++++++++++
 drivers/hwmon/pmbus/mp29502.c                 | 670 +++++++++++++++++
 9 files changed, 1690 insertions(+)
 create mode 100644 Documentation/hwmon/mp2869.rst
 create mode 100644 Documentation/hwmon/mp29502.rst
 create mode 100644 drivers/hwmon/pmbus/mp2869.c
 create mode 100644 drivers/hwmon/pmbus/mp29502.c

-- 
2.25.1


