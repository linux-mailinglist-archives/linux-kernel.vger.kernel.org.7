Return-Path: <linux-kernel+bounces-778305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B715FB2E3FC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 19:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF2635E6AAF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 17:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C94525A626;
	Wed, 20 Aug 2025 17:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YMEQ6+o2"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB9423C33
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 17:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755710800; cv=none; b=iz7fIAy+rHnO8mwG7+Ed2Mc6zBuL2xaQLdJJEb6z/eTuWzTA0N5p7fK8Cc96yNYOF7AdmAXytkfqRTJXKwf7IWp5NBbu6RjV82YBwDLVtWCqksv4M07h1KRNBPkr3YU4LTACidSwRoAQDsMTiDY+YKotcB0E29Ny1aRTz5JGEwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755710800; c=relaxed/simple;
	bh=Q/jdaiM+kgJ5R5FKhEvQDUDNp4Rjp1tV7zovBjIkSS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lOStOC+/P/bKAh8Db+5+HR4OF8XrzxFBI+27G8Oko3CD2XwaMxhN5CJH1EHd4lLVaoZYw/jep7F+fBHw1MF+n6ERWxVZcGHIyDk92guCeklgZJoIXdYNjivOGH9QCF9LACtP4dYhcbbhSQA3R5FU1FYeEWhcHcs6F491wqdmYNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=YMEQ6+o2; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-76e7af160f1so142124b3a.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 10:26:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1755710798; x=1756315598; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1JeiRrdVegjLxsA+/HodUZYtkAW20pYDME1GTqkfc9k=;
        b=YMEQ6+o2XklB6VOsup27KmJHRRiaYJqpp/CN5nAKdczf3kaBVp6QddLLc/p9dI5jRS
         Fdmd2USEUzhr7s2qWbU4x1jxQUwj8ixeHCBBXIqRsr18zNJ5trZaOVcAmrC9cXppp8SB
         ziorirC0tfty4x0UstQqCRaT9vBKHCXexXdZw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755710798; x=1756315598;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1JeiRrdVegjLxsA+/HodUZYtkAW20pYDME1GTqkfc9k=;
        b=DQD3ENW9d1ohPQIlvtDvCcN8/mOCjP6LIvC32q07gjQH0R+N/6dMs9npDd+CwICs8T
         SHQ6nno0ldVwUnwAXMHKe7CiDCjozDHA6sD6ySuSsaO1p1gMKMleyETP3jL8ITjms40r
         2QXVY0/1AgnV8235kcRWr7PBfldJqHqZjZXK8+83Q9Ehg+wrG7JnPSghXrgd/XZWQjAz
         aXKcJ+6DV5fhhIAoWWAppOiqrZDDO2wEuB4Ap0BafUfaK8J67/3zMwCXIF7vLTH2CpRx
         FAAOtqnS5ZApZxeldlMWoYSykL6Z6c1ebK+9MVCNbp4KXVecAXy3wV/PR9Wqjrf/sv/S
         fHhQ==
X-Gm-Message-State: AOJu0YyJNVGwzNOzsJ0i6jGiDHfY3q1tPNNtSRzMWTKUWpDvDvW2L/RU
	DRiyo3NTkDNcBNwDu5ZTEEJJQFRlP21WogRDuPfFzEMK0+zWQV1Blmgephn0RqDBE5mz24wKVUB
	ufZE=
X-Gm-Gg: ASbGncsGnn2BIElxQZhcNKMd0IXBfpnGI5bRN0n1texTBjx+oc9FyiVmfT7qC3Bn//4
	421Ejw8M3mip4Y7fFOjyVJ+MAYpySgKzfQoNBEkGKyf+adtrmYk7yav4hp8FMFWp6J8Ybzp9dLg
	fLI2ITEWHm5cFWrLhWx/IISmXgr4dmGI6NeuVsPtwfhyPduu9SMtgRaZ1Yptzm+iHeJMlHAWFMS
	lKwIeKRoTIWdLbfqHEME7ZOxMcsEz50fV4+1zlEjtlDlIxiajmJgOXp+8167uZrABV0hKlksXPQ
	nKNJg1KArwmAHp3krbK+dJLxuzHsQB8a+mgWpcacBdfCStkozxa9p+7MYS09MvVQIzIumeUfUs7
	e8Wb6/cWI/Tk7yKhmo+DUxc0Arnb2wNFsIia+yP+YKGplKgqeO5jEkUn/dAJP
X-Google-Smtp-Source: AGHT+IETJ+xPBqhU4+maX5eUwNiVCa9GIut+/TM1ucGF0aqZzfLGdLF7Hth81w5j8Rptxhmmo/r1xA==
X-Received: by 2002:a05:6a20:7f8e:b0:243:78a:8284 with SMTP id adf61e73a8af0-2431ba55cb3mr6389305637.60.1755710798151;
        Wed, 20 Aug 2025 10:26:38 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:635f:74c7:be17:bd29])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-b4763fe3047sm2735821a12.17.2025.08.20.10.26.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Aug 2025 10:26:37 -0700 (PDT)
From: Brian Norris <briannorris@chromium.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Brian Norris <briannorris@google.com>,
	stable@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH] PCI/sysfs: Ensure devices are powered for config reads
Date: Wed, 20 Aug 2025 10:26:08 -0700
Message-ID: <20250820102607.1.Ibb5b6ca1e2c059e04ec53140cd98a44f2684c668@changeid>
X-Mailer: git-send-email 2.51.0.rc1.193.gad69d77794-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Brian Norris <briannorris@google.com>

max_link_speed, max_link_width, current_link_speed, current_link_width,
secondary_bus_number, and subordinate_bus_number all access config
registers, but they don't check the runtime PM state. If the device is
in D3cold, we may see -EINVAL or even bogus values.

Wrap these access in pci_config_pm_runtime_{get,put}() like most of the
rest of the similar sysfs attributes.

Fixes: 56c1af4606f0 ("PCI: Add sysfs max_link_speed/width, current_link_speed/width, etc")
Cc: stable@vger.kernel.org
Signed-off-by: Brian Norris <briannorris@google.com>
Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 drivers/pci/pci-sysfs.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 5eea14c1f7f5..160df897dc5e 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -191,9 +191,16 @@ static ssize_t max_link_speed_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
+	ssize_t ret;
+
+	pci_config_pm_runtime_get(pdev);
 
-	return sysfs_emit(buf, "%s\n",
-			  pci_speed_string(pcie_get_speed_cap(pdev)));
+	ret = sysfs_emit(buf, "%s\n",
+			 pci_speed_string(pcie_get_speed_cap(pdev)));
+
+	pci_config_pm_runtime_put(pdev);
+
+	return ret;
 }
 static DEVICE_ATTR_RO(max_link_speed);
 
@@ -201,8 +208,15 @@ static ssize_t max_link_width_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
+	ssize_t ret;
+
+	pci_config_pm_runtime_get(pdev);
+
+	ret = sysfs_emit(buf, "%u\n", pcie_get_width_cap(pdev));
 
-	return sysfs_emit(buf, "%u\n", pcie_get_width_cap(pdev));
+	pci_config_pm_runtime_put(pdev);
+
+	return ret;
 }
 static DEVICE_ATTR_RO(max_link_width);
 
@@ -214,7 +228,10 @@ static ssize_t current_link_speed_show(struct device *dev,
 	int err;
 	enum pci_bus_speed speed;
 
+	pci_config_pm_runtime_get(pci_dev);
 	err = pcie_capability_read_word(pci_dev, PCI_EXP_LNKSTA, &linkstat);
+	pci_config_pm_runtime_put(pci_dev);
+
 	if (err)
 		return -EINVAL;
 
@@ -231,7 +248,10 @@ static ssize_t current_link_width_show(struct device *dev,
 	u16 linkstat;
 	int err;
 
+	pci_config_pm_runtime_get(pci_dev);
 	err = pcie_capability_read_word(pci_dev, PCI_EXP_LNKSTA, &linkstat);
+	pci_config_pm_runtime_put(pci_dev);
+
 	if (err)
 		return -EINVAL;
 
@@ -247,7 +267,10 @@ static ssize_t secondary_bus_number_show(struct device *dev,
 	u8 sec_bus;
 	int err;
 
+	pci_config_pm_runtime_get(pci_dev);
 	err = pci_read_config_byte(pci_dev, PCI_SECONDARY_BUS, &sec_bus);
+	pci_config_pm_runtime_put(pci_dev);
+
 	if (err)
 		return -EINVAL;
 
@@ -263,7 +286,10 @@ static ssize_t subordinate_bus_number_show(struct device *dev,
 	u8 sub_bus;
 	int err;
 
+	pci_config_pm_runtime_get(pci_dev);
 	err = pci_read_config_byte(pci_dev, PCI_SUBORDINATE_BUS, &sub_bus);
+	pci_config_pm_runtime_put(pci_dev);
+
 	if (err)
 		return -EINVAL;
 
-- 
2.51.0.rc1.193.gad69d77794-goog


