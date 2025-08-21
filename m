Return-Path: <linux-kernel+bounces-780199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B06EB2FE87
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 17:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F41837BE4AF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 15:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81DD274B34;
	Thu, 21 Aug 2025 15:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="tmaCO3mN"
Received: from smtp65.ord1d.emailsrvr.com (smtp65.ord1d.emailsrvr.com [184.106.54.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7839F274B32
	for <linux-kernel@vger.kernel.org>; Thu, 21 Aug 2025 15:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=184.106.54.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755790583; cv=none; b=Jgfyb6B0peY6mqU4kulVvSzFNgpep2EdPFzTgPgQxsiLFvS2/S/ea5BJ5zsQtHuYgWzT1xpCEUL8CAO8nDWwREKzZfbOob9jhTCLiXhqsKNlAXls6yCNlBcoU87drm3tWK7dLaIqh6y8zo9kDum5IrimX35Mcgnne3M8FBVLJtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755790583; c=relaxed/simple;
	bh=SG1gH1S+Q/2q/qnzTJYiNEVyBNWclNkM4ATzvPU8Svk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IpNB2QlkmHhYhm6SBGB0DiGWjTdAN1wP3Dyk7XPTX+p4XvSuEE6rLZJuXIqzon/XL/0Qs6tz0cljPLgE0xNpKdOwSUI884AQ0wD7Dawxk2KKXHO+Ev30NKTNJIV+bBkak6zWdrO2xmB6r0cpJ6CYOZ8WDuzWLp5sX6vb9hZUQRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=tmaCO3mN; arc=none smtp.client-ip=184.106.54.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1755788370;
	bh=SG1gH1S+Q/2q/qnzTJYiNEVyBNWclNkM4ATzvPU8Svk=;
	h=From:To:Subject:Date:From;
	b=tmaCO3mNrNl/D085QmPnWVWk1ZqdtoCGuDXh1Noz5QVCfZJn1xj/OekSirXWJHD29
	 ZMQ0au6yQmNmsSqKxdimi13dGIwLaZO1IYMXJf0VdaUuhfidJWdXOYZ/uMcanuss9z
	 aj26451PMs2bLemrt0Z0Rmqi96hhsbge/bNR95Gk=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp9.relay.ord1d.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 28246C00BF;
	Thu, 21 Aug 2025 10:59:30 -0400 (EDT)
From: Ian Abbott <abbotti@mev.co.uk>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>
Subject: [PATCH] comedi: Add new driver for ADLink PCI-7250 series
Date: Thu, 21 Aug 2025 15:59:14 +0100
Message-ID: <20250821145914.10445-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: c2302bef-6737-4cec-8e9a-941242ae7ea8-1-1

The ADLink PCI-7250, LPCI-7250, and LPCIe-7250 are PCI/PCIe boards with
8 relay outputs and 8 isolated digital inputs.  Add a new Comedi driver
"adl_pci7250" to support them.

It is possible to add up to three PCI-7251 plug-in modules to the
PCI-7250, with 8 relay outputs and 8 isolated digital inputs per plug-in
module.  We cannot reliably detect whether the modules are fitted
without changing their state.  It is harmless to assume the modules are
fitted; they just won't do anything, so the driver allows all 32 relay
outputs to be written (and their initial state to be read), and all 32
digital inputs to be read.

The LPCI-7250 and LPCIe-7250 are low-profile boards that do not support
the plug-in modules, but except for a newer variant of the LPCIe-7250,
they cannot be distinguished from the full-height boards by their PCI
IDs.  For the newer variant of the LPCIe-7250, we can assume that there
are no plug-in modules fitted and limit the number of channels
accordingly.  This newer variant of the LPCIe-7250 uses memory-mapped
registers, whereas all the other boards use port-mapped registers.

I have tested the PCI-7250.  The new variant of the LPCIe-7250 has been
tested in an out-of-tree version of the Comedi drivers by someone else.

Tested-by: Ian Abbott <abbotti@mev.co.uk> # PCI-7250 only
Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 drivers/comedi/Kconfig               |   9 ++
 drivers/comedi/drivers/Makefile      |   1 +
 drivers/comedi/drivers/adl_pci7250.c | 220 +++++++++++++++++++++++++++
 3 files changed, 230 insertions(+)
 create mode 100644 drivers/comedi/drivers/adl_pci7250.c

diff --git a/drivers/comedi/Kconfig b/drivers/comedi/Kconfig
index 93c68a40a17b..6dcc2567de6d 100644
--- a/drivers/comedi/Kconfig
+++ b/drivers/comedi/Kconfig
@@ -705,6 +705,15 @@ config COMEDI_ADL_PCI6208
 	  To compile this driver as a module, choose M here: the module will be
 	  called adl_pci6208.
 
+config COMEDI_ADL_PCI7250
+	tristate "ADLink PCI-7250 support"
+	help
+	  Enable support for ADLink PCI-7250/LPCI-7250/LPCIe-7250 relay output
+	  and isolated digital input boards.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called adl_pci7250.
+
 config COMEDI_ADL_PCI7X3X
 	tristate "ADLink PCI-723X/743X isolated digital i/o board support"
 	depends on HAS_IOPORT
diff --git a/drivers/comedi/drivers/Makefile b/drivers/comedi/drivers/Makefile
index b24ac00cab73..7b99a431330d 100644
--- a/drivers/comedi/drivers/Makefile
+++ b/drivers/comedi/drivers/Makefile
@@ -73,6 +73,7 @@ obj-$(CONFIG_COMEDI_ADDI_APCI_3120)	+= addi_apci_3120.o
 obj-$(CONFIG_COMEDI_ADDI_APCI_3501)	+= addi_apci_3501.o
 obj-$(CONFIG_COMEDI_ADDI_APCI_3XXX)	+= addi_apci_3xxx.o
 obj-$(CONFIG_COMEDI_ADL_PCI6208)	+= adl_pci6208.o
+obj-$(CONFIG_COMEDI_ADL_PCI7250)	+= adl_pci7250.o
 obj-$(CONFIG_COMEDI_ADL_PCI7X3X)	+= adl_pci7x3x.o
 obj-$(CONFIG_COMEDI_ADL_PCI8164)	+= adl_pci8164.o
 obj-$(CONFIG_COMEDI_ADL_PCI9111)	+= adl_pci9111.o
diff --git a/drivers/comedi/drivers/adl_pci7250.c b/drivers/comedi/drivers/adl_pci7250.c
new file mode 100644
index 000000000000..78c85a402435
--- /dev/null
+++ b/drivers/comedi/drivers/adl_pci7250.c
@@ -0,0 +1,220 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * adl_pci7250.c
+ *
+ * Comedi driver for ADLink PCI-7250 series cards.
+ *
+ * Copyright (C) 2015, 2025 Ian Abbott <abbotti@mev.co.uk>
+ */
+
+/*
+ * Driver: adl_pci7250
+ * Description: Driver for the ADLINK PCI-7250 relay output & digital input card
+ * Devices: [ADLINK] PCI-7250 (adl_pci7250) LPCI-7250 LPCIe-7250
+ * Author: Ian Abbott <abbotti@mev.co.uk>
+ * Status: works
+ * Updated: Mon, 02 Jun 2025 13:54:11 +0100
+ *
+ * The driver assumes that 3 PCI-7251 modules are fitted to the PCI-7250,
+ * giving 32 channels of relay outputs and 32 channels of isolated digital
+ * inputs.  That is also the case for the LPCI-7250 and older LPCIe-7250
+ * cards although they do not physically support the PCI-7251 modules.
+ * Newer LPCIe-7250 cards have a different PCI subsystem device ID, so
+ * set the number of channels to 8 for these cards.
+ *
+ * Not fitting the PCI-7251 modules shouldn't do any harm, but the extra
+ * inputs and relay outputs won't work!
+ *
+ * Configuration Options: not applicable, uses PCI auto config
+ */
+
+#include <linux/module.h>
+#include <linux/comedi/comedi_pci.h>
+
+static unsigned char adl_pci7250_read8(struct comedi_device *dev,
+				       unsigned int offset)
+{
+#ifdef CONFIG_HAS_IOPORT
+	if (!dev->mmio)
+		return inb(dev->iobase + offset);
+#endif
+	return readb(dev->mmio + offset);
+}
+
+static void adl_pci7250_write8(struct comedi_device *dev, unsigned int offset,
+			       unsigned char val)
+{
+#ifdef CONFIG_HAS_IOPORT
+	if (!dev->mmio) {
+		outb(val, dev->iobase + offset);
+		return;
+	}
+#endif
+	writeb(val, dev->mmio + offset);
+}
+
+static int adl_pci7250_do_insn_bits(struct comedi_device *dev,
+				    struct comedi_subdevice *s,
+				    struct comedi_insn *insn,
+				    unsigned int *data)
+{
+	unsigned int mask = comedi_dio_update_state(s, data);
+
+	if (mask) {
+		unsigned int state = s->state;
+		unsigned int i;
+
+		for (i = 0; i * 8 < s->n_chan; i++) {
+			if ((mask & 0xffu) != 0) {
+				/* write relay data to even offset registers */
+				adl_pci7250_write8(dev, i * 2, state & 0xffu);
+			}
+			state >>= 8;
+			mask >>= 8;
+		}
+	}
+
+	data[1] = s->state;
+
+	return 2;
+}
+
+static int adl_pci7250_di_insn_bits(struct comedi_device *dev,
+				    struct comedi_subdevice *s,
+				    struct comedi_insn *insn,
+				    unsigned int *data)
+{
+	unsigned int value = 0;
+	unsigned int i;
+
+	for (i = 0; i * 8 < s->n_chan; i++) {
+		/* read DI value from odd offset registers */
+		value |= (unsigned int)adl_pci7250_read8(dev, i * 2 + 1) <<
+			(i * 8);
+	}
+
+	data[1] = value;
+
+	return 2;
+}
+
+static int pci7250_auto_attach(struct comedi_device *dev,
+			       unsigned long context_unused)
+{
+	struct pci_dev *pcidev = comedi_to_pci_dev(dev);
+	struct comedi_subdevice *s;
+	unsigned int max_chans;
+	unsigned int i;
+	int ret;
+
+	ret = comedi_pci_enable(dev);
+	if (ret)
+		return ret;
+
+	if (pci_resource_len(pcidev, 2) < 8)
+		return -ENXIO;
+
+	/*
+	 * Newer LPCIe-7250 boards use MMIO.  Older LPCIe-7250, LPCI-7250, and
+	 * PCI-7250 boards use Port I/O.
+	 */
+	if (pci_resource_flags(pcidev, 2) & IORESOURCE_MEM) {
+		dev->mmio = pci_ioremap_bar(pcidev, 2);
+		if (!dev->mmio)
+			return -ENOMEM;
+	} else if (IS_ENABLED(CONFIG_HAS_IOPORT)) {
+		dev->iobase = pci_resource_start(pcidev, 2);
+	} else {
+		dev_err(dev->class_dev,
+			"error! need I/O port support\n");
+		return -ENXIO;
+	}
+
+	if (pcidev->subsystem_device == 0x7000) {
+		/*
+		 * This is a newer LPCIe-7250 variant and cannot possibly
+		 * have PCI-7251 modules fitted, so limit the number of
+		 * channels to 8.
+		 */
+		max_chans = 8;
+	} else {
+		/*
+		 * It is unknown whether the board is a PCI-7250, an LPCI-7250,
+		 * or an older LPCIe-7250 variant, so treat it as a PCI-7250
+		 * and assume it can have PCI-7251 modules fitted to increase
+		 * the number of channels to a maximum of 32.
+		 */
+		max_chans = 32;
+	}
+
+	ret = comedi_alloc_subdevices(dev, 2);
+	if (ret)
+		return ret;
+
+	/* Relay digital output. */
+	s = &dev->subdevices[0];
+	s->type		= COMEDI_SUBD_DO;
+	s->subdev_flags	= SDF_WRITABLE;
+	s->n_chan	= max_chans;
+	s->maxdata	= 1;
+	s->range_table	= &range_digital;
+	s->insn_bits	= adl_pci7250_do_insn_bits;
+	/* Read initial state of relays from the even offset registers. */
+	s->state = 0;
+	for (i = 0; i * 8 < max_chans; i++) {
+		s->state |= (unsigned int)adl_pci7250_read8(dev, i * 2) <<
+			    (i * 8);
+	}
+
+	/* Isolated digital input. */
+	s = &dev->subdevices[1];
+	s->type		= COMEDI_SUBD_DI;
+	s->subdev_flags	= SDF_READABLE;
+	s->n_chan	= max_chans;
+	s->maxdata	= 1;
+	s->range_table	= &range_digital;
+	s->insn_bits = adl_pci7250_di_insn_bits;
+
+	return 0;
+}
+
+static struct comedi_driver adl_pci7250_driver = {
+	.driver_name	= "adl_pci7250",
+	.module		= THIS_MODULE,
+	.auto_attach	= pci7250_auto_attach,
+	.detach		= comedi_pci_detach,
+};
+
+static int adl_pci7250_pci_probe(struct pci_dev *dev,
+				 const struct pci_device_id *id)
+{
+	return comedi_pci_auto_config(dev, &adl_pci7250_driver,
+				      id->driver_data);
+}
+
+static const struct pci_device_id adl_pci7250_pci_table[] = {
+#ifdef CONFIG_HAS_IOPORT
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_PLX, PCI_DEVICE_ID_PLX_9050,
+			 0x9999, 0x7250) },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_ADLINK, 0x7250,
+			 0x9999, 0x7250) },
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_ADLINK, 0x7250,
+			 PCI_VENDOR_ID_ADLINK, 0x7250) },
+#endif
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_ADLINK, 0x7250,
+			 PCI_VENDOR_ID_ADLINK, 0x7000) }, /* newer LPCIe-7250 */
+	{ 0 }
+};
+MODULE_DEVICE_TABLE(pci, adl_pci7250_pci_table);
+
+static struct pci_driver adl_pci7250_pci_driver = {
+	.name		= "adl_pci7250",
+	.id_table	= adl_pci7250_pci_table,
+	.probe		= adl_pci7250_pci_probe,
+	.remove		= comedi_pci_auto_unconfig,
+};
+module_comedi_pci_driver(adl_pci7250_driver, adl_pci7250_pci_driver);
+
+MODULE_AUTHOR("Comedi https://www.comedi.org");
+MODULE_DESCRIPTION("Comedi driver for ADLink PCI-7250 series boards");
+MODULE_LICENSE("GPL");
-- 
2.50.1


