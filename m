Return-Path: <linux-kernel+bounces-888281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D24AC3A62C
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 11:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D94FB4FF61B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 10:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6326330C628;
	Thu,  6 Nov 2025 10:50:11 +0000 (UTC)
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA52C2E92D4;
	Thu,  6 Nov 2025 10:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762426210; cv=none; b=BiDTcdcQ60HHjwD9aop0z0mql9bM7XX+Z0tehbZigPoDRiC4pxgF2jt2QkutFQEN5Gol6DQkuHMz8vwrEsQPU9T8V6VINP7PgGaZ1R8WdwfuIlIYBZZy38u3w86iij0zBEuJz8p90YFZVeGfZ+f9Gr+I/VhvmdNKGP/dwL2ehIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762426210; c=relaxed/simple;
	bh=M/ZNM0BXH69JOaoZQjZBoFizMQzaO3iJpvFIMDhZqBs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DIVqpM9uh2ODR4aPwk2o4oaWIotIZTr6kyLQgiAkD9/CIgWA5giXdRzyss6fj7fn/HdMf7240CMVuQcULVQJz8nw8wOt42PYfP9CLIiJu24CBHdluPdVwVwq2VjlI+ZILPmZXNbkUH+z3yHDNrRgF7o9nTT2wqecCdalFqE3DOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0006493LT.eswin.cn (unknown [10.127.112.153])
	by app2 (Coremail) with SMTP id TQJkCgAHS65FfQxpxyQ7AA--.65325S4;
	Thu, 06 Nov 2025 18:49:43 +0800 (CST)
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
Subject: [PATCH v6 0/2] Add driver support for ESWIN EIC7700 SoC USB controller
Date: Thu,  6 Nov 2025 18:49:38 +0800
Message-ID: <20251106104938.1386-1-caohang@eswincomputing.com>
X-Mailer: git-send-email 2.45.1.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TQJkCgAHS65FfQxpxyQ7AA--.65325S4
X-Coremail-Antispam: 1UD129KBjvJXoWxXrWUWw4fur47AF4fZF1UKFg_yoWrXF4fpa
	ykKFW5GrZ5JryxJan2q3WrKF4fGanrXFWUGr1Iqw1jvw4jg3W7JrWI9F4YyrWDCwn3Z3yY
	yay3W39Yka4DA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9E14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI7VAKI4
	8JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xv
	wVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjx
	v20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20E
	Y4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267
	AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbknY7UUUUU==
X-CM-SenderInfo: xfdrxt1qj6v25zlqu0xpsx3x1qjou0bp/

From: Hang Cao <caohang@eswincomputing.com>

Add support for ESWIN EIC7700 USB driver controller.

Changes in v6->v5:
- Updates: dwc3-generic-plat.c
  - Update commit message.
  - Add dwc3_plat_config structure.
  - Add dwc3_eic7700_init function.
- Link to V5:https://lore.kernel.org/all/20251104065045.1464-1-caohang@eswincomputing.com/

Changes in v5->v4:
- Updates: eswin,eic7700-usb.yaml
  -  Remove the unnecessary properties of quirk.

- Updates: dwc3-generic-plat.c
  - Rebase to usb-testing branch of gregkh/usb.git.
  - Add eic7700 pre init in probe function.

Changes in v4->v3:
- Updates:
  - Removed config option patch dependency from cover letter, because the patch
    was applied.
  - Remove dwc3-eic7700.c instead of dwc3-generic-plat.c.

- Updates: eswin,eic7700-usb.yaml
  - Add usb_en clock.
  - Add usb_rst reset.
  - Update eswin,hsp-sp-csr description.
  - Remove the last two unused items of eswin,hsp-sp-csr.

- Updates: dwc3-generic-plat.c
  - Add eswin,eic7700-dwc3 to the compatible table.
  - Add the dwc3_generic_match_data structure.
  - Add the eic7700_dwc3_bus_init function to initialize the bus.
  - Add the init_ops callback in the probe function.
- Link to V3: https://lore.kernel.org/all/20250915085329.2058-1-caohang@eswincomputing.com/

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

 .../bindings/usb/eswin,eic7700-usb.yaml       | 94 +++++++++++++++++++
 drivers/usb/dwc3/dwc3-generic-plat.c          | 70 ++++++++++++--
 2 files changed, 157 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/eswin,eic7700-usb.yaml

--
2.34.1


