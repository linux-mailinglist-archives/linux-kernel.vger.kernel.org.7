Return-Path: <linux-kernel+bounces-822270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D554B836D9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 10:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE6D23A593C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 08:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7428C2EFDBE;
	Thu, 18 Sep 2025 08:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="XDnrHYkw"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35BB221265;
	Thu, 18 Sep 2025 08:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758182701; cv=none; b=h57X2CYwq41gnAkd28GOxpi58zmn+x7IdjLGjqJJ+GK9oAAisUqxFlXxJDz1iaE8uIHlJ7QDtUOC24FNJYcP0lHXAT8rIHYKDD9RUEItMK5pBbXpl1ggrYaqvSJwpRgHiMEaV1sD2vHc3eN1MwqdOrnkRrOONBdKLDCv5y7m4VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758182701; c=relaxed/simple;
	bh=E9qm+Sxn0Q/YmM7Ik3UwApGlTfQ+ELCuukT5Rsf7PJs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HOb9GVktRVceWPKxTfTr5QBQar97fss57zqAcv7DMMUNEb4dgxZHF1IpHhNdagyhbZwO9OnBwa+rCFGQy8jcenLg2Qx2vpH95Rznn7JZXF/vEfz/+13SoOreRCDj3o2dbN1+K5+mKL/ZixgsaXV1yj7uE7UauzCRMc5DQdlus6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=XDnrHYkw; arc=none smtp.client-ip=220.197.32.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=mj
	Q3QJ+Fs+nA/I8gfkukX+TgwxN0n2N2A3SiOVEoz44=; b=XDnrHYkwIPBth38kbn
	ujyBOMIbjr7ninLZ20/Nlc0gZb09CmWR/RMGUVTI2vZPr9WKHyhBwB6/1nernSNJ
	um9I3ER2LrKTMn0+sYSZ5ziKC4HVpLyrFa9kBkulbiVRl89P91rNsApcxKjO2g+a
	Eg96YqKXGCaXbEclg9izj7R5Q=
Received: from mps-HP-EliteBook-840-G3.monolithicpower.com (unknown [])
	by gzsmtp2 (Coremail) with SMTP id Ms8vCgCHnwPzvMtoRFLLBA--.60510S2;
	Thu, 18 Sep 2025 16:04:04 +0800 (CST)
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
Subject: [PATCH v2 0/2] hwmon: Add support for MPS mp2925 and mp2929 chip
Date: Thu, 18 Sep 2025 16:03:49 +0800
Message-Id: <20250918080349.1154140-1-wenswang@yeah.net>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Ms8vCgCHnwPzvMtoRFLLBA--.60510S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jry7tr17Kw4UGFWkCr1fXrb_yoW3XFbEkr
	4Iga9Fvr1UJFs3WayDCr1rXryUGr4YgFy7G3W3tFZ8ZayaqrnxXrykZw17ta4UGrW7CF17
	uFW8A393AF17KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbYFAPUUUUU==
X-CM-SenderInfo: 5zhq24xdqjq5hhdkh0dhw/1tbiIRR5HmjLvPRY1wAA32

From: Wensheng Wang <wenswang@yeah.net>

Add mp2925,mp292 driver in hwmon and add dt-bindings for them.

V1 -> V2:
    1. add Krzysztof's Acked-by
    2. pass 0 for i2c_device_id and of_device_id struct

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


