Return-Path: <linux-kernel+bounces-835350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD36ABA6D54
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 11:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 96312175D3B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Sep 2025 09:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FC4B2D7DEB;
	Sun, 28 Sep 2025 09:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="qCHuCbpS"
Received: from mail-m16.yeah.net (mail-m16.yeah.net [220.197.32.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620242D249A;
	Sun, 28 Sep 2025 09:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759051702; cv=none; b=aVqOwOYE5h0zvK7RghXJmJXmmX6WKpVCJpBn6ivAy3GdasEljKyE6DkjF8WQYKpCwI+HUQxLYFb4yMwPXAAenc5cCTh58UjRos98CQXKvVKCbrhyyqQGup90VnR5SuhlTWebDIEWakDmyrQBCbtcVxe23Rg2SlBUvuuxZjrkZCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759051702; c=relaxed/simple;
	bh=smPD+sEaLEsnOmqjW8jMdYNIr0pPoDEeCf42AWo6Ayg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AaLyOpbdTtpBwvgAjK+Z3Q6GPmYQlUozfuDg5zK059ga6j0SBg55vkuZbJiUHB75fs+GUarf2RFfBb20Dgs0KkouiI9wLOBxDsPGg/z+DKmOQ2UN3evehLtFZtkoy1yIMYxTz9nawkFaSDOG/7iABYFPrd6cCTLnNKR9JbvvyUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=qCHuCbpS; arc=none smtp.client-ip=220.197.32.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=56
	oS8vKLwRVlByY6n3vYw/iIRhCziIOYD8UAq+yII58=; b=qCHuCbpSyM2GOdo658
	o58WM1eKdqMszNTearlYHal3flDsAdDmAgZAK3bYywKrfTZJs/2cwbt6lAe9bcQD
	jZwJbIaE/sBX5m9SZ6cZtA1MHc2BlwbHDUyF7GyPtEBQ/i4g5MCI93kxUQj2A3hD
	gEMltHappsk2stgAD8DuYwwI8=
Received: from mps-HP-EliteBook-840-G3.monolithicpower.com (unknown [])
	by gzsmtp3 (Coremail) with SMTP id M88vCgDnz7x9_9ho1r9mBQ--.56164S2;
	Sun, 28 Sep 2025 17:27:26 +0800 (CST)
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
Subject: [PATCH v3 0/2] hwmon: Add support for MPS mp2925 and mp2929 chip
Date: Sun, 28 Sep 2025 17:26:55 +0800
Message-Id: <20250928092655.1394429-1-wenswang@yeah.net>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:M88vCgDnz7x9_9ho1r9mBQ--.56164S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jry7tr17Kw4UGry7CryUKFg_yoWfXrbEkr
	s7Way7Ar1UJFs5Wayqkr1rJryUGr4YgFy7G3W3trZ8Z3yagrnxurykZwnrta4UGrW7uF1U
	urWrAws3Ar17KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbYFAPUUUUU==
X-CM-SenderInfo: 5zhq24xdqjq5hhdkh0dhw/1tbiCQ3WpGjYtnW0CQAAs4

From: Wensheng Wang <wenswang@yeah.net>

Add mp2925,mp292 driver in hwmon and add dt-bindings for them.

V2 -> V3:
    fix garbage value issue when writing vout ov/uv fault
    limit value in mp2925_write_word_data() function

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
 drivers/hwmon/pmbus/mp2925.c                  | 316 ++++++++++++++++++
 7 files changed, 489 insertions(+)
 create mode 100644 Documentation/hwmon/mp2925.rst
 create mode 100644 drivers/hwmon/pmbus/mp2925.c

-- 
2.25.1


