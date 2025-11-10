Return-Path: <linux-kernel+bounces-892294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 157DFC44C9C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 03:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BED46188B2BE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Nov 2025 02:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AC6238166;
	Mon, 10 Nov 2025 02:44:24 +0000 (UTC)
Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78B7B1F16B;
	Mon, 10 Nov 2025 02:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762742664; cv=none; b=P7aul84nIDD14OWaDCL5ufyORGh9vSSswpIIC9ei/DbC4Aoukqd6Qdryi8QD+UsF0eO3agiIpER0wOt/HFPmHm5wiPlBrgAmjBv6GQpbaOBcVOrrr8hz5VFBaR7+c9McT0ifSnQeDd5EvUYN5+KFQRavzDG2DRdL5Wzp+IZO+vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762742664; c=relaxed/simple;
	bh=RVQQgCoaPsqrXBfn0t+evOz5/uWTb+eYqyU0YEs1OGE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FMp/JonAoB3BlTLN7hePnJulnn0CCVAsniA1fG0gi8c0BabahQO14paliPvjd3d+lB1CqzyoB5bNzIgE0b+VII7oo/6jWW6aXjHMDf3Jd8j/cmRA6FoiXnNyPu5NYx0VUaoUgm6fpiDb72th62O2Jjs9iVvmOGANVZ/4mXZaU0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com; spf=pass smtp.mailfrom=eswincomputing.com; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=eswincomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=eswincomputing.com
Received: from E0006493LT.eswin.cn (unknown [10.127.112.153])
	by app1 (Coremail) with SMTP id TAJkCgB3fmtkURFpn2NuAA--.25641S4;
	Mon, 10 Nov 2025 10:43:50 +0800 (CST)
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
Subject: [PATCH v7 0/2] Add driver support for ESWIN EIC7700 SoC USB controller
Date: Mon, 10 Nov 2025 10:43:39 +0800
Message-ID: <20251110024339.73-1-caohang@eswincomputing.com>
X-Mailer: git-send-email 2.45.1.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:TAJkCgB3fmtkURFpn2NuAA--.25641S4
X-Coremail-Antispam: 1UD129KBjvJXoWxXrW5Xr4Dtr1fWw4DAw4fXwb_yoWrAFW8pa
	ykKFW5GrZ5Jryxtan2qa4rKF4fGanrXFWUGr1Iqw1jvw4jg3W7JrWI9F4YyrWDCwn3Z3yY
	yay3W39Yka4DA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
 drivers/usb/dwc3/dwc3-generic-plat.c          | 71 ++++++++++++--
 2 files changed, 158 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/eswin,eic7700-usb.yaml

--
2.34.1


