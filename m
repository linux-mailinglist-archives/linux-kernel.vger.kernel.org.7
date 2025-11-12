Return-Path: <linux-kernel+bounces-896547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3BBC50A4A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 06:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DF803B488A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Nov 2025 05:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE1A52DA757;
	Wed, 12 Nov 2025 05:52:56 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.142.27])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5BB1B87C9;
	Wed, 12 Nov 2025 05:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.142.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762926776; cv=none; b=qSzD3bIegbTWj5ebXi7xgQGeGkQB6xSPqkXTwt5C04Z/NcN8xD2CA8Zr7kKJmxEClSq3faYzqRWtkb7E9yJ/zn9ujZrNwQAhGRfxB5DI9e52F8/KqdM8QPvVpQKL1mtbKWAE3EoteR0ve9+3S208MuaP8NdQt9oBQ8d6vyOEOak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762926776; c=relaxed/simple;
	bh=BP/VZhhjFMlzny6ykV73squvQ1IA6zZrpaDr16JsXnI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gH6QIi5cr/DycxakT6xq6B3pjIYSvq+/21fPoHz4RX5D1p7TnDLYpH4C6A6aD9KSVKKvH0X1wAxtfJ9u8GHHYWmOtVdC69dRpz3LJeaAm5o5582qEvcDRj+AcRt9+bUnMHmdDBjHftIeOTU7XEnm5oTsM0bHfBsgc7iacCGWubE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=13.76.142.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0006493LT.eswin.cn (unknown [10.127.112.153])
	by app1 (Coremail) with SMTP id TAJkCgB3cGihIBRpC+x6AA--.28338S4;
	Wed, 12 Nov 2025 13:52:35 +0800 (CST)
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
	Hang Cao <caohang@eswincomputing.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v8 0/2] Add driver support for ESWIN EIC7700 SoC USB controller
Date: Wed, 12 Nov 2025 13:52:30 +0800
Message-ID: <20251112055230.1609-1-caohang@eswincomputing.com>
X-Mailer: git-send-email 2.45.1.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TAJkCgB3cGihIBRpC+x6AA--.28338S4
X-Coremail-Antispam: 1UD129KBjvJXoWxXrW5Wr1xuFykWr1DZryxKrg_yoW7JrWxpa
	yvkrW5Crs5Jryxtan7K3WFvF4fGanrXF45Kr1Iqw12vw4jg3W7JrWI9F4YvrWDCwn3u34Y
	yFW3Wa9Yka4DZ37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202511110121.BwTv4Fex-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202511110504.qfGuRVHY-lkp@intel.com/

Changes in v8->v7:
- Updates: dwc3-generic-plat.c
  - Update commit message with acked-by.
  - Fix build error in in probe function.
- Link to V7:https://lore.kernel.org/all/20251110024339.73-1-caohang@eswincomputing.com/

Changes in v7->v6:
- Updates: dwc3-generic-plat.c
  - Rename dwc3_plat_config to dwc3_generic_config.
  - Refine the error message in probe function.
- Link to V6:https://lore.kernel.org/all/20251106104938.1386-1-caohang@eswincomputing.com/

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
  - Removed .data
- Link to V4:https://lore.kernel.org/all/20251016094654.708-1-caohang@eswincomputing.com/
- Link to gregkh/usb.git:https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/tree/?h=usb-next

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
 drivers/usb/dwc3/dwc3-generic-plat.c          | 71 ++++++++++++--
 2 files changed, 158 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/eswin,eic7700-usb.yaml

--
2.34.1


