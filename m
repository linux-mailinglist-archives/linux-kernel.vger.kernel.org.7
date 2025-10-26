Return-Path: <linux-kernel+bounces-870380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68BD7C0A8DB
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 14:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80C9D18A037F
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Oct 2025 13:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA30220F37;
	Sun, 26 Oct 2025 13:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eKk8WPi1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFE429408;
	Sun, 26 Oct 2025 13:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761487166; cv=none; b=nJdv81hneybOw33UOpA4r0NrLc3xDfNzRLEzHkmgU/PT0awcDHvtYac+j5dzIQZeSFA1UHZPo1Rc+0NpYPqMvvaS8sLyqkBD67kRNkCeuennc09u3FUviP6wWApUtC4/6BKzAV/MbdIAFE2geDdGYpbd0EKuIEJ1FAObV5x0+mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761487166; c=relaxed/simple;
	bh=Wmo/Tp+nodkOP3qLtdxCP/AyRTQN1yeys19spP2bHXw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=q5kDwXC5CxG0RW5EWHxPbReMVYuA5AUqLlSB/PAnqu2J3Zqhr66UvWtkQlENEwDJktR6NEl2oNywZhgR/KsQjUka9rcSHEi83O3xrh/IiWCELqMi9kOkW0paOBdoREMNZ4SPidt8TsYlPKG283qyQ8o/lzP/q1rPeiBPEZl1p0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eKk8WPi1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD8DDC4CEE7;
	Sun, 26 Oct 2025 13:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761487166;
	bh=Wmo/Tp+nodkOP3qLtdxCP/AyRTQN1yeys19spP2bHXw=;
	h=Date:From:To:Cc:Subject:From;
	b=eKk8WPi19WQ34cfAXrA7jBNGMGmj+OX586me0H7Sy3Qmv6/+65rsiovni9mfqBEvd
	 e/HcgCGHfTyGxopwGDZVCcvCj0Xq6unXHNBv0OPKQ3LHyGECwYq0vfzdZaEOfXGfJM
	 UoKO/HC6onVpysYfWb81pf+gfbps5rv80uHPZqAY=
Date: Sun, 26 Oct 2025 14:59:23 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org
Subject: [GIT PULL] USB driver fixes for 6.18-rc3
Message-ID: <aP4pO8V4UAE3XEiY@kroah.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 3a8660878839faadb4f1a6dd72c3179c1df56787:

  Linux 6.18-rc1 (2025-10-12 13:42:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.18-rc3

for you to fetch changes up to a1b866f2018748282fa026eb4c92d032dfda11a9:

  Merge tag 'usb-serial-6.18-rc3' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus (2025-10-24 13:52:58 +0200)

----------------------------------------------------------------
USB driver fixes for 6.18-rc3

Here are some small USB driver fixes and new device ids for 6.18-rc3.
Included in here are:
  - new option serial driver device ids added
  - dt bindings fixes for numerous platforms
  - xhci bugfixes for many reported regressions
  - usbio dependency bugfix
  - dwc3 driver fix
  - raw-gadget bugfix

All of these have been in linux-next this week with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Andrey Konovalov (1):
      usb: raw-gadget: do not limit transfer length

Christophe JAILLET (1):
      usb: dwc3: Don't call clk_bulk_disable_unprepare() twice

Greg Kroah-Hartman (1):
      Merge tag 'usb-serial-6.18-rc3' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into usb-linus

Krishna Kurapati (1):
      dt-bindings: usb: qcom,snps-dwc3: Fix bindings for X1E80100

LI Qingwu (1):
      USB: serial: option: add Telit FN920C04 ECM compositions

Mathias Nyman (2):
      xhci: dbc: fix bogus 1024 byte prefix if ttyDBC read races with stall event
      xhci: dbc: enable back DbC in resume if it was enabled before suspend

Michael Grzeschik (1):
      tcpm: switch check for role_sw device with fw_node

Michal Pecio (1):
      usb: xhci-pci: Fix USB2-only root hub registration

Neil Armstrong (1):
      dt-bindings: usb: switch: split out ports definition

Peter Robinson (1):
      usb: misc: Add x86 dependency for Intel USBIO driver

Reinhard Speyerer (1):
      USB: serial: option: add Quectel RG255C

Renjun Wang (1):
      USB: serial: option: add UNISOC UIS7720

Tim Guttzeit (1):
      usb/core/quirks: Add Huawei ME906S to wakeup quirk

Xu Yang (1):
      dt-bindings: usb: dwc3-imx8mp: dma-range is required only for imx8mp

 .../bindings/phy/fsl,imx8mq-usb-phy.yaml           |  4 +-
 .../bindings/phy/samsung,usb3-drd-phy.yaml         |  4 +-
 .../devicetree/bindings/usb/fcs,fsa4480.yaml       |  1 +
 .../devicetree/bindings/usb/fsl,imx8mp-dwc3.yaml   | 10 +++-
 .../devicetree/bindings/usb/gpio-sbu-mux.yaml      |  1 +
 .../devicetree/bindings/usb/nxp,ptn36502.yaml      |  1 +
 .../devicetree/bindings/usb/onnn,nb7vpq904m.yaml   |  1 +
 .../devicetree/bindings/usb/parade,ps8830.yaml     |  1 +
 .../devicetree/bindings/usb/qcom,snps-dwc3.yaml    |  3 +
 .../bindings/usb/qcom,wcd939x-usbss.yaml           |  1 +
 .../devicetree/bindings/usb/ti,tusb1046.yaml       |  1 +
 .../devicetree/bindings/usb/usb-switch-ports.yaml  | 68 ++++++++++++++++++++++
 .../devicetree/bindings/usb/usb-switch.yaml        | 52 -----------------
 drivers/usb/core/quirks.c                          |  2 +
 drivers/usb/dwc3/dwc3-generic-plat.c               |  3 -
 drivers/usb/gadget/legacy/raw_gadget.c             |  2 -
 drivers/usb/host/xhci-dbgcap.c                     | 15 ++++-
 drivers/usb/host/xhci-pci.c                        |  3 +-
 drivers/usb/misc/Kconfig                           |  1 +
 drivers/usb/serial/option.c                        | 10 ++++
 drivers/usb/typec/tcpm/tcpm.c                      |  4 +-
 21 files changed, 122 insertions(+), 66 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/usb-switch-ports.yaml

