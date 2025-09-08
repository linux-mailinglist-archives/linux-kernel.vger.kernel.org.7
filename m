Return-Path: <linux-kernel+bounces-805603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 637E2B48AE4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 13:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D66B63C6995
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 11:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C912F7442;
	Mon,  8 Sep 2025 11:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="EztwRgTB"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481FE222568;
	Mon,  8 Sep 2025 11:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757329263; cv=none; b=NEne8KQsxnfCwUVUiblNbQT7WIYfUTRw0Fejk7XyQaaHGX6h4HeVDrZIn/UOgnYpPXN80I3ofxSdaCSvaHAAdn0B5wXgQ9vYv/t9t88dK/gqiA9ZSVF8XKxtVnMNnSFz6/nCQtWm25AILiWTTgVAEodk2HCdhsX4w/eaibbEqvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757329263; c=relaxed/simple;
	bh=r6VAaXHvg+3DRXyFI/Ihb5Tt3ZWpo4mQmD8YbbFMhJg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Wd/xiWGAyjGzgc0fK3XNhqBKJEL4sXvMIOZCrJbvG6P7CbB2PhRaMZwgnCElgBDDsDSiUod71+mPyhPV3MZblh219NA3vU2hNsc0n5A3GrM2q5n2+Xo302UTcdn4UoNGCSJJ/gLfF4qO3nveMyvmeccPfT1JLehCYrGT34wlhHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=EztwRgTB; arc=none smtp.client-ip=1.95.21.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=x5
	A546zWvZjZP2uaOIuqp3Ffcz89zAlaBIan1vzIGy4=; b=EztwRgTBJV3A20X4Rn
	i0J7wlF6XcgPbkpWmZCMdn/1Zvp3/YVUIWbW1HqDRGnCjPNvRNffrf/9OE1f5hvy
	ZYWzhgOwxHhbzWazNcKi0MTFD+8/75sQTjqyXCUuZcBwtQga1K2UVJGa2uM19j22
	hc6oKnAsoSQqQMYbItEbfTsYM=
Received: from localhost.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id Mc8vCgDXK4Qzt75o6kUqBA--.30965S2;
	Mon, 08 Sep 2025 19:00:04 +0800 (CST)
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
Subject: [PATCH 0/2] hwmon: Add support for MPS mp2925 and mp2929 chip
Date: Mon,  8 Sep 2025 18:59:51 +0800
Message-Id: <20250908105951.1002332-1-wenswang@yeah.net>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Mc8vCgDXK4Qzt75o6kUqBA--.30965S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jry7tr17Kw4UJrWfXw47Jwb_yoWxAwcEkr
	4IgFZrJr1UJFs3WFWDCr1rXryUGF4YgFyxG3W3trZ8ZrWagrnIqrykZw17J3WUGrW7CF17
	urW8J393AF17KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbYFAPUUUUU==
X-CM-SenderInfo: 5zhq24xdqjq5hhdkh0dhw/1tbiIRTEaWi+tzT6bQAA3a

From: Wensheng Wang <wenswang@yeah.net>

Add mp2925,mp292 driver in hwmon and add dt-bindings for them.

Wensheng Wang (2):
  dt-bindings: hwmon: Add MPS mp2925 and mp2929
  hwmon: add MP2925 and MP2929 driver

 .../devicetree/bindings/trivial-devices.yaml  |   4 +
 Documentation/hwmon/index.rst                 |   1 +
 Documentation/hwmon/mp2925.rst                | 151 +++++++++
 MAINTAINERS                                   |   7 +
 drivers/hwmon/pmbus/Kconfig                   |   9 +
 drivers/hwmon/pmbus/Makefile                  |   1 +
 drivers/hwmon/pmbus/mp2925.c                  | 312 ++++++++++++++++++
 7 files changed, 485 insertions(+)
 create mode 100644 Documentation/hwmon/mp2925.rst
 create mode 100644 drivers/hwmon/pmbus/mp2925.c

-- 
2.25.1


