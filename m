Return-Path: <linux-kernel+bounces-816423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F01B573B4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 10:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 585D07AF0A2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 08:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68B12F39CC;
	Mon, 15 Sep 2025 08:54:42 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (l-sdnproxy.icoremail.net [20.188.111.126])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066492F361C;
	Mon, 15 Sep 2025 08:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=20.188.111.126
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757926482; cv=none; b=mLGuOo+UIb2r8otCZRxwtXh+5VldOUgdlsr3UqitXTna8uZqxodU6eon3xOTEyUiUOkpGFzppEujRtO6MoUeYpEBey0ZkPDrWEUlZQcJ3KfnbBd0cUzimc5n/kLye9FKk3TQa8IIYfKfh3OIJXo8kJeOboj9GUmiK6tB7SRb5W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757926482; c=relaxed/simple;
	bh=Y/1Xi4Ly8vXCRTp1Q91j/eDYr186iclNRGSqfMFUErM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eLkxfQLBAv1zVZnWHUg0z3KJAqbNtj69JXIfOjVY5yqC11SYETPpcjrEjeGisrP+e225EfGlXBGJUCBbQEsCXptKedPYfcQ4EOK76Km6fGbG8i5QMn81hLwiI2phzk1ts5lGd2fQrJR8Jnye0tUYOaQuj/++7Dv90dMv7Nzzl+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=20.188.111.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0006493LT.eswin.cn (unknown [10.127.112.153])
	by app2 (Coremail) with SMTP id TQJkCgAHmZIq1Mdo3E7RAA--.39265S4;
	Mon, 15 Sep 2025 16:54:04 +0800 (CST)
From: caohang@eswincomputing.com
To: gregkh@linuxfoundation.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	Thinh.Nguyen@synopsys.com,
	p.zabel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: ningyu@eswincomputing.com,
	linmin@eswincomputing.com,
	pinkesh.vaghela@einfochips.com,
	Hang Cao <caohang@eswincomputing.com>
Subject: [PATCH v3 0/2] Add driver support for ESWIN EIC7700 SoC USB controller
Date: Mon, 15 Sep 2025 16:53:29 +0800
Message-ID: <20250915085329.2058-1-caohang@eswincomputing.com>
X-Mailer: git-send-email 2.45.1.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TQJkCgAHmZIq1Mdo3E7RAA--.39265S4
X-Coremail-Antispam: 1UD129KBjvJXoWxXrW8Xw4rGFWDGrWDur4rZrb_yoW5AFWxpa
	yDKFW5GrZ5JryxtanaqF10vF4fJanrJFW5Gr4Iqw1jvw4q93W7JrWIkF1YyrZrCr93X3yY
	yFW3GwsYyas8ArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBv14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r1q6r43MxkIecxEwVCm-wCF04
	k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18
	MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr4
	1lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l
	IxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUmjgxUUUUU=
X-CM-SenderInfo: xfdrxt1qj6v25zlqu0xpsx3x1qjou0bp/

From: Hang Cao <caohang@eswincomputing.com>

Add support for ESWIN EIC7700 USB driver controller.

Those series of patches depend on config option patch[1]
- [1] https://lore.kernel.org/lkml/20250616112316.3833343-1-pinkesh.vaghela@einfochips.com/

Changes in v3->v2:
- Updates: eswin,eic7700-usb.yaml
  - Sort the attributes according to the DTS coding style.
  - Remove the #address-cells and #size-cells attributes.
  - Fold the child node into the parent.
  - Update commit message.

- Updates: dwc3-eic7700.c
  - Use dwc3 core as a library.
  - Add system and runtime pm.
  - Use pm_ptr and remove the __maybe_unused tags.
  - Add new author name
  - Add prepare and complete function
  - Update commit message.
- Link to V2: https://lore.kernel.org/lkml/20250730073953.1623-1-zhangsenchuan@eswincomputing.com/

Changes in v2->v1:
- Updates: eswin,eic7700-usb.yaml
  - Drop the redundant descriptions.
  - Supplement the constraints of resets.
  - Replace "eswin,hsp_sp_csr" with "eswin,hsp-sp-csr"
    and add items description.
  - Drop numa-node-id, This is not necessary.
  - Add patternProperties and match the rules defined
    in the "snps,dwc3.yaml" file.
  - Add "#address-cells" "#size-cells".
  - Update the space indentation, remove the redundant labels,
    and sort the attributes according to the DTS encoding style.
  - Drop the "status = "disabled" attribute.
  - Update the common usb node names and fold the child
    nodes into the parent nodes.
  - The warning detected by the robot has been resolved.

- Updates: dwc3-eic7700.c
  - Remove dwc3_mode_show dwc3_mode_store dwc3_eswin_get_extcon_dev,
    dwc3_eswin_device_notifier and dwc3_eswin_host_notifier, usb role
    detection and switching are not supported.
  - Remove the hub-rst attribute, remove the dwc3_hub_rst_show and
    dwc3_hub_rst_store functions, this feature is not supported.
  - Use syscon_regmap_lookup_by_phandle_args instead of the
    syscon_regmap_lookup_by_phandle function.
  - Use dev_err_probe in probe function.
  - Drop mutex_lock, which is not required.
  - Remove clk_prepare_enable and of_clk_get, and manage multiple
    clocks using devm_clk_bulk_get_all_enabled.
  - Remove the device_init_wakeup related functions, which were
    used incorrectly.
  - Remove MODULE_ALIAS, which is used incorrectly.
  - The warning detected by the robot has been resolved.
- Link to V1: https://lore.kernel.org/lkml/20250516095237.1516-1-zhangsenchuan@eswincomputing.com/

Hang Cao (2):
  dt-bindings: usb: Add ESWIN EIC7700 USB controller
  usb: dwc3: eic7700: Add EIC7700 USB driver

 .../bindings/usb/eswin,eic7700-usb.yaml       |  99 +++++++
 drivers/usb/dwc3/Kconfig                      |  11 +
 drivers/usb/dwc3/Makefile                     |   1 +
 drivers/usb/dwc3/dwc3-eic7700.c               | 261 ++++++++++++++++++
 4 files changed, 372 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/eswin,eic7700-usb.yaml
 create mode 100644 drivers/usb/dwc3/dwc3-eic7700.c

--
2.34.1


