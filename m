Return-Path: <linux-kernel+bounces-618771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D2BA9B36C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 18:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A9CB3BFCFA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 16:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB45D27FD7D;
	Thu, 24 Apr 2025 16:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dZPqWYlK"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7148522127E
	for <linux-kernel@vger.kernel.org>; Thu, 24 Apr 2025 16:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745510853; cv=none; b=Hu2rlN/ZZ0bp56vgEgxuRW7lky2FmXouFQoHtt8W8FweIh46T59VsS6H6mBVRQnS6rtjgXuS4wvhhGzUH/Z83lZJuRAIsrBJ80ukIRW1AxRl17XGHggq7SOnvy102rGTIcRzG/A2fpZPkwYTQ4oQkYsR2PMbO6wOWwx6DGI8aCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745510853; c=relaxed/simple;
	bh=0Px7jvGhuJRiflMflGOKgJJn7q3qCKBYZy5iMa70b04=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Li9U4lcIcF8saMArHfavhizzCLsvMYKAvCnCtNQaAChJlaUaxRssBpUAetYHYNsPoLRsDKuZz+ntY6LuH/BQblednluxySTT1oHKdLQKH+DfYSHVjeFzUBqU0TfwfENHsGYr7XX8q2kyAG0mspZnvU6xFG8rIfsz35iKHvayKlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dZPqWYlK; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-227a8cdd241so16580885ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Apr 2025 09:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745510851; x=1746115651; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3ztM6ZhwbBzqofjKNReosW9oAapXnNeASiHQKoNm3Vc=;
        b=dZPqWYlKWVPgLCUMHvDxknlfp3vYBqrqa4qtrSEbn2Ehx1qWrqHMh8q8FeDByfZrZy
         duMK3/3IF5pjV/18OVb2IunKvvFMdfKG7qGOfR4xynUB3MFZL7odf8M4hIy+kJ91MPxl
         S320QPIZiC0CYHvL1iMdMj5Q2Z6dIsgEwPQa4mep+Ul8QiomgxCwER4TI57hmwWSEQqp
         zYq4c6fGEAx3KlZsDmGfxS0R3qSPhR96iQ0+AZhlPZODWOIPIDnpci3h56eG0chN3wyI
         0d5pOihxT6ezzMDewvRyqDbL0qxuL9Rk6Wy4RwKoe8KMKkJ4YsalNDN0OFdl9afBy+TP
         XgQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745510851; x=1746115651;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3ztM6ZhwbBzqofjKNReosW9oAapXnNeASiHQKoNm3Vc=;
        b=npHvgqzrDsge4VO+L3PXhi1LNnutHV+xCVbL3VqlKVAL6pYVdCpdPMY7tnvB0MEZqi
         tSgcQyYKhLwb8kq4i3io4pkCtsyHFu68KBA3x7r1nCBrGrBWfgN2BrM6d/upzoMA0cVm
         DbIs3XlyJjAoo+DaYj5nYuT6QHZBpsz5QjF/3NGISGNFU2DrMZ0ILO4VTVuLXJLy0fsn
         1XyO+4EdvSlTSR+c1Z/bSwjed9XWdXxF58HTePy94oTCFzTPrCqQZgmSP9dRultP8LSU
         4BPQph7N8AT/14n7WuKwTvyYrlHJHGnAHel18Y4wS0r+xP3JIXB6zMbUKzt1WpSwwGXT
         hHBA==
X-Forwarded-Encrypted: i=1; AJvYcCW2LG/rJ2QhnYDld6kxEqnXxXBUlWJSSHIuwGD54CzIHS2NOyyjy6IvgjA/EZbsRtDXrx2kKUoYzf2mAGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlkaSSdLPaFMDubrETDV/lSxPLmgRyr2OAsixPbBAOtAcZbm0v
	04XunEe9DkVn8hhJ3GuCattakAZwh6s6SlDW+A2A3Hub9K4rotUc/5n5IMIaoP2RY34sQ2Zm3n0
	=
X-Gm-Gg: ASbGnctmtoTEWgXuk/9domTghz+nR2Zrw7VOlwUJctuV6tfqCkK1pPykpw07px7GBY9
	/eVSIWjw26ESix2SBwGWrATAXnwlyi0vdiytix+J0hjURLEdM2IDbJY1bBKgLcWJswEDn5/qAmD
	b9+Q/MffpyqJe9IaLw7cLvw7xt2zlnfYoBrpcepoJm25oUJP1aBsIpx8a2LYtYzLb3fQhIdTavR
	KzIYBOmxgIsnBkU69/5g5oG0Zg6ya8X+xAqsi7UBQxaHDdWAXnDJvDnDuGYedx5rCcnl8vNmfmv
	VEE9r9al8PcQ4dQD4kGtpjZlsWWv+NY+69xLWi57Ok6lOeFwhQrtRbE=
X-Google-Smtp-Source: AGHT+IEBGkJA01XOR5juVSwEwgYSL2iayGzzvTy9VnE5/0UWjwW9zVp7Des8tZPmxJhpSTd3lAmX8g==
X-Received: by 2002:a17:902:e54f:b0:21f:1bd:efd4 with SMTP id d9443c01a7336-22db3be36b8mr49102425ad.19.1745510850701;
        Thu, 24 Apr 2025 09:07:30 -0700 (PDT)
Received: from [127.0.1.1] ([120.60.77.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db5221656sm15262275ad.252.2025.04.24.09.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 09:07:30 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 0/4] PCI: Add PTM debugfs support
Date: Thu, 24 Apr 2025 21:37:15 +0530
Message-Id: <20250424-pcie-ptm-v3-0-c929ebd2821c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALNhCmgC/23MQQ7CIBCF4as0sxZDgFp11XuYLoAO7SQKBBqia
 bi72LXL/+Xl2yFjIsxw73ZIWChT8C3kqQO7ar8go7k1CC56LoVi0RKyuL0YDr25GeGcdQbaPSZ
 09D6ox9R6pbyF9DnkIn7rH6QIxpkd5quVF6WM0uOTvE7hHNICU631C8KwCH+hAAAA
X-Change-ID: 20250324-pcie-ptm-e75b9b2ffcfb
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Jingoo Han <jingoohan1@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3677;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=0Px7jvGhuJRiflMflGOKgJJn7q3qCKBYZy5iMa70b04=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBoCmG+CKMLlQHtFHJTVixNZ7ukdMa0FsFzKc+qh
 4qGb57vvxGJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCaAphvgAKCRBVnxHm/pHO
 9Q/+B/0bm65cttTnyoDield/0CiSmBJ764HbXm0MKPCvBvVRSFVsN1BG3LvQrr8MmvBiLks7yIk
 vlb00IomkkH63L5oLmeHC4XroaRk4V13luz7xBaUJ1ouMI1IgN2wk5tdgRhPS2SWsKukpM5I2vZ
 I/9HPtUPMjpK6ahCJGc2pWkSdkBrJnPZF+uC8hUQhGhPE4sc8GvXBddv1sTYvONR/a4KT6XDIwX
 U/NlxK2n8Xl2UHWZDIPMAYu2EmNBvGBYMX5vXQ4+jVlSN0kjUnVhqnzMMKeqBPNqH5Nj4lgpIbq
 VegBAQwXMxpOHOEqdBEDJmRmTUnXwJy5m3IqikhugMNIvAsi
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

Hi,

This series adds debugfs support to expose the PTM context available in the
capable PCIe controllers. Support for enabling PTM in the requester/responder is
already available in drivers/pci/pcie.c and this series expands that file to
add debugfs support for the PTM context info.

The controller drivers are expected to call pcie_ptm_create_debugfs() with
'pcie_ptm_ops' callbacks populated to create the debugfs entries and call
pcie_ptm_destroy_debugfs() to destroy them.

Patch 1 adds the necessary code in the drivers/pci/pcie.c to expose PTM
context over debugfs and patch 2 adds PTM support in the DWC drivers (host and
endpoint). Finally, patch 3 masks the PTM_UPDATING interrupt in the pcie-qcom-ep
driver to avoid processing the interrupt for each PTM context update.

Testing
=======

This series is tested on Qcom SA8775p Ride Mx platform where one SA8775p acts as
RC and another as EP with following instructions:

RC
--

$ echo 1 > /sys/kernel/debug/pcie_ptm_1c10000.pcie/context_valid

EP
--

$ echo auto > /sys/kernel/debug/pcie_ptm_1c10000.pcie-ep/context_update

$ cat /sys/kernel/debug/pcie_ptm_1c10000.pcie-ep/local_clock
159612570424

$ cat /sys/kernel/debug/pcie_ptm_1c10000.pcie-ep/master_clock
159609466232

$ cat /sys/kernel/debug/pcie_ptm_1c10000.pcie-ep/t1
159609466112

$ cat /sys/kernel/debug/pcie_ptm_1c10000.pcie-ep/t4
159609466518

NOTE: To make use of the PTM feature, the host PCIe client driver has to call
'pci_enable_ptm()' API during probe. This series was tested with enabling PTM in
the MHI host driver with a local change (which will be upstreamed later).
Technically, PTM could also be enabled in the pci_endpoint_test driver, but I
didn't add the change as I'm not sure we'd want to add random PCIe features in
the test driver without corresponding code in pci-epf-test driver.

Changes in v3:
- Switched to debugfs interface based on comments from Bjorn
- Added locking for context read/writes
- Rebased on top of v6.15-rc1
- Link to v2: https://lore.kernel.org/r/20250324-pcie-ptm-v2-0-c7d8c3644b4a@linaro.org

Changes in v2:

* Dropped the VSEC changes that got merged
* Moved the PTM sysfs code from drivers/pci/controller/dwc to
  drivers/pci/pcie/ptm.c to make it generic so that other controller drivers could
  also benefit from it.
* Rebased on top of pci/controller/dwc

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
Manivannan Sadhasivam (4):
      PCI: Add debugfs support for exposing PTM context
      PCI: dwc: Pass DWC PCIe mode to dwc_pcie_debugfs_init()
      PCI: dwc: Add debugfs support for PTM context
      PCI: qcom-ep: Mask PTM_UPDATING interrupt

 Documentation/ABI/testing/debugfs-pcie-ptm         |  70 +++++
 MAINTAINERS                                        |   1 +
 .../pci/controller/dwc/pcie-designware-debugfs.c   | 252 ++++++++++++++++-
 drivers/pci/controller/dwc/pcie-designware-ep.c    |   2 +-
 drivers/pci/controller/dwc/pcie-designware-host.c  |   2 +-
 drivers/pci/controller/dwc/pcie-designware.c       |   6 +
 drivers/pci/controller/dwc/pcie-designware.h       |  24 +-
 drivers/pci/controller/dwc/pcie-qcom-ep.c          |   8 +
 drivers/pci/pcie/ptm.c                             | 300 +++++++++++++++++++++
 include/linux/pci.h                                |  45 ++++
 include/linux/pcie-dwc.h                           |   8 +
 11 files changed, 713 insertions(+), 5 deletions(-)
---
base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
change-id: 20250324-pcie-ptm-e75b9b2ffcfb

Best regards,
-- 
Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>


