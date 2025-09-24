Return-Path: <linux-kernel+bounces-830930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F099BB9AEED
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 18:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A7491B27F2D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Sep 2025 16:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89443307AEB;
	Wed, 24 Sep 2025 16:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ejo8DnM3"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A3731282B
	for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 16:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758733048; cv=none; b=fvAuzUJgNzvv3PJ+6677ensmtjnLpmfOC/kv2Ori18TRqnV1pjE9Zeir37TM1KcYG9UKiQpOXYq5H0VVr2uB6BJPkttImVC6TJbuN0GQtpMJ/h09KLGOfnsfTnVDJL7PlNnPIxTLAanc7k2JzTmqr26jukwNguwaJ/R05LS9fLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758733048; c=relaxed/simple;
	bh=tPg4Wqz8J2TompQpzQza/5UmS8Zm70sbPvTEcMI6BDU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IOzPJ8/9HkVM/oqhnIL4Pdl/ww77GYud2RETc021FFYJ+EMFoTopjmUMVf2QCXrcU4rkOjMzuMzgwlZaqxZ525/Pb2Omuqzh0bojD/9Ns1f7BB1VbHekzQbSY33651pVZ05lch70tCSUWQTGedcz3b4usPODL4t2M0ePGRlSv0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ejo8DnM3; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-77f32d99a97so60050b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Sep 2025 09:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1758733047; x=1759337847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w7w7BZfusfh40TgUumBQVrwOU9Hw6Y9fKIpILWJTmpI=;
        b=Ejo8DnM3kav7ByBkn3OXAdhFpXyC3Cdwo1tBD3NLsbxCprYwu36tZ6bcmMNBDKRe8X
         17NwpQ6yXn0U8HM+UG1D/FjL27nQ9gpUCvxpQxVyt/koee3pfix4asxuG3spdJ03HPr+
         AbHfXGURHM0/SYnLsdEH+yn5DdtyPRlkCndbk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758733047; x=1759337847;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w7w7BZfusfh40TgUumBQVrwOU9Hw6Y9fKIpILWJTmpI=;
        b=MUVima+PFSdFDPHfQoeyFDw6kBDb5UzYf8laHiRsU0oRXqKj1kuKnZmwAeFOy7i+8j
         qGxu0JFvP3OBTlHZjRuO5HkBwhahpe6VpMO5VOmisiPFDocudFTa03k4PDDdJWqgSaob
         sCAGuwIsdQs152KMncLh4QSRM11i40tsL+n2P6vqkRpcu0J2gJHRT1OfJ3p5LstqG617
         f16TywxFfCevkhEvptEIUbSH6WDW57lpdiSzhIBdl0hwKgdeCo3bc24Gro5ImM5qvnzc
         jTeb0ttnHk0UY3M5ocJvHGxucc3oeAlwPxU2PZEu9vD6LZtZKgM5n1aEy+8ls+l+M7Bo
         R2ZA==
X-Forwarded-Encrypted: i=1; AJvYcCXWNjdWXsLOXPe/5nBTgaz5v3SYh3lWtQdv9y1RqOttxAG2x49Bp29frYWi1ulsGPVoN6O55zJwPxK82VM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyS1gFAl8wIWCRMXldKzw6Dkk1HX2SP04V3TzWHEWQs16GGPHyB
	1IDUuWRe3LzawUmk95NsvRdLpEkwCAhRFQkaf0N1ZU0sA2s+siCTbbrDvuXW9KqM0w==
X-Gm-Gg: ASbGncvuJuaBJ03/9iUaZiXi6RDy3I4/aihNaC8KFnL3ynOdlAk9JFmj2/aMZppYXKI
	C6AlueHS8UCkT0IwbwcDUX1pVhP7bYQQKQkaxep0w9gRRVy+TrRfef/xRszETxv+b+it5P72gKU
	Lws7s6Uxx/DiymCjdnHiAG6dnIWZ5Mzpv0Smkl930w9/+hvnr1/Ph+jGrzeYoAYW0WuLp1MTqzP
	brdygHI0FunnJYQOwnHBkuHAwuHPgYMCdI4+MDGOub9VwnxCSXaHgn5DkqyRls777kiGg8TgUEW
	nhs/Y/QwZXpz5X8r2q/6qYIVZWr25em9TLRZ9Y0qF4hsWYdsXyMp0h8QxM1VLagtd8BXxUqI5/a
	zifG7Ro6FX3NhbcOkhCdHW0yoqNBCebDuDW85QQPyz9OChfua4CGGP9udPg91
X-Google-Smtp-Source: AGHT+IGx9dCGSc8hHfADXStah33h7Nc5K9qEOotJoi6vkmLXbBDnOjcgbEXkXllnVBgpY/TI8WgxrA==
X-Received: by 2002:a05:6a00:8703:b0:77f:3a99:77b1 with SMTP id d2e1a72fcca58-780fce13c75mr503942b3a.9.1758733046668;
        Wed, 24 Sep 2025 09:57:26 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e7c:8:26d9:5758:328a:50f8])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-77e0bb98790sm16815959b3a.9.2025.09.24.09.57.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 09:57:26 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Ethan Zhao <etzhao1900@gmail.com>,
	linux-kernel@vger.kernel.org,
	Brian Norris <briannorris@google.com>,
	stable@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH v2] PCI/sysfs: Ensure devices are powered for config reads
Date: Wed, 24 Sep 2025 09:57:11 -0700
Message-ID: <20250924095711.v2.1.Ibb5b6ca1e2c059e04ec53140cd98a44f2684c668@changeid>
X-Mailer: git-send-email 2.51.0.536.g15c5d4f767-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Brian Norris <briannorris@google.com>

max_link_width, current_link_speed, current_link_width,
secondary_bus_number, and subordinate_bus_number all access config
registers, but they don't check the runtime PM state. If the device is
in D3cold or a parent bridge is suspended, we may see -EINVAL, bogus
values, or worse, depending on implementation details.

Wrap these access in pci_config_pm_runtime_{get,put}() like most of the
rest of the similar sysfs attributes.

Notably, max_link_speed does not access config registers; it returns a
cached value [1]. So it needs no changes.

[1] Caching was added to pcie_get_speed_cap() in v6.13 via commit
    d2bd39c0456b ("PCI: Store all PCIe Supported Link Speeds").

Fixes: 56c1af4606f0 ("PCI: Add sysfs max_link_speed/width, current_link_speed/width, etc")
Cc: stable@vger.kernel.org
Signed-off-by: Brian Norris <briannorris@google.com>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

Changes in v2:
 * Don't touch max_link_speed; it's cached, so we don't actually touch
   the hardware
 * Improve commit message

 drivers/pci/pci-sysfs.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index f28fdf6dfa02..af74cf02bb90 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -209,8 +209,14 @@ static ssize_t max_link_width_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
+	ssize_t ret;
 
-	return sysfs_emit(buf, "%u\n", pcie_get_width_cap(pdev));
+	/* We read PCI_EXP_LNKCAP, so we need the device to be accessible. */
+	pci_config_pm_runtime_get(pdev);
+	ret = sysfs_emit(buf, "%u\n", pcie_get_width_cap(pdev));
+	pci_config_pm_runtime_put(pdev);
+
+	return ret;
 }
 static DEVICE_ATTR_RO(max_link_width);
 
@@ -222,7 +228,10 @@ static ssize_t current_link_speed_show(struct device *dev,
 	int err;
 	enum pci_bus_speed speed;
 
+	pci_config_pm_runtime_get(pci_dev);
 	err = pcie_capability_read_word(pci_dev, PCI_EXP_LNKSTA, &linkstat);
+	pci_config_pm_runtime_put(pci_dev);
+
 	if (err)
 		return -EINVAL;
 
@@ -239,7 +248,10 @@ static ssize_t current_link_width_show(struct device *dev,
 	u16 linkstat;
 	int err;
 
+	pci_config_pm_runtime_get(pci_dev);
 	err = pcie_capability_read_word(pci_dev, PCI_EXP_LNKSTA, &linkstat);
+	pci_config_pm_runtime_put(pci_dev);
+
 	if (err)
 		return -EINVAL;
 
@@ -255,7 +267,10 @@ static ssize_t secondary_bus_number_show(struct device *dev,
 	u8 sec_bus;
 	int err;
 
+	pci_config_pm_runtime_get(pci_dev);
 	err = pci_read_config_byte(pci_dev, PCI_SECONDARY_BUS, &sec_bus);
+	pci_config_pm_runtime_put(pci_dev);
+
 	if (err)
 		return -EINVAL;
 
@@ -271,7 +286,10 @@ static ssize_t subordinate_bus_number_show(struct device *dev,
 	u8 sub_bus;
 	int err;
 
+	pci_config_pm_runtime_get(pci_dev);
 	err = pci_read_config_byte(pci_dev, PCI_SUBORDINATE_BUS, &sub_bus);
+	pci_config_pm_runtime_put(pci_dev);
+
 	if (err)
 		return -EINVAL;
 
-- 
2.51.0.536.g15c5d4f767-goog


