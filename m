Return-Path: <linux-kernel+bounces-863255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF96BF764B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47E6E19A0651
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160443446BB;
	Tue, 21 Oct 2025 15:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M8S0M7hg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1633343D9B;
	Tue, 21 Oct 2025 15:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761060599; cv=none; b=SCSE4sX9YVpo285QAuHiBfnjf8rWc2DXdf0dh+vV7d5Fl+9ZyHaTAk6qO9wCU1mjRIMVNkJbB3B9oBL316qXSxFAB1g8ezhBW+dV8HosPSvrC6f5UNk4XnHZ1z5zxaJfQDZrnze/tRhW7tsJD3blG9RJd4XKX7fxfe1fGCooEFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761060599; c=relaxed/simple;
	bh=W1/IGcGO3eeUsvCTs0pZ/QQQZAaVFKWYqGsrV88yhas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DeL61gzLvanCBV0OaCWfTeoS3fpNc/z+YNUGEcY+CTc4QW8WKb1e8deok+AOl8vO4djxti11UCeuyRSYDWhLJvYcliUF2jKmp4hjXmDS7i+o7H2sV1Q8YcP9bz0GwemlPMe+piqGkD3LQKvLpwZEqpTNEMJYZooYk+G3zNHqgYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M8S0M7hg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50588C4CEF5;
	Tue, 21 Oct 2025 15:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761060598;
	bh=W1/IGcGO3eeUsvCTs0pZ/QQQZAaVFKWYqGsrV88yhas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M8S0M7hgM87/c8PeLnRUdsAN5HsofDCu5S+kGGafjeUH59mclOuiNspMd0K/TCEyN
	 ehwakxZ3uvjZ9aOgKm5FIDY9N/NAgJGnRWQn5QiIaRX16EP+/U/0ztK6iq4bQtdIab
	 MUuWfz/LLcJ5HBaNNer+vYWsksA+QUBOMD01gmKtQnuSoPgqJZ4qYlH9LfAlSF3BST
	 dx5+ijq9MHO0kuyTCIUX7NlPJQwuYT4WdE+R+8KSQdLaeEUaZNSMqlPqxz9w4fPrF8
	 lT5ww26aCg+vGzZTaO9umvzBpvESsM2tyrc1qbbDQWu8BV5ht4cJH6tNStTA7nOj4H
	 BfYSred9RCUbA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1vBEJH-000000005oR-241J;
	Tue, 21 Oct 2025 17:30:04 +0200
Date: Tue, 21 Oct 2025 17:30:03 +0200
From: Johan Hovold <johan@kernel.org>
To: hsyemail2@gmail.com
Cc: Oliver Neukum <oneukum@suse.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sheng-Yuan Huang <syhuang3@nuvoton.com>
Subject: Re: [PATCH v4 1/1] USB: serial: nct_usb_serial: add support for
 Nuvoton USB adapter
Message-ID: <aPem-8w3LLkP_r2d@hovoldconsulting.com>
References: <CACW=pY7KgEQRJfVOkiSjVSAHDO0b7kOVWSW1GPE_SzLPrb9r6Q@mail.gmail.com>
 <20250820081011.11164-1-syhuang3@nuvoton.com>
 <20250820081011.11164-2-syhuang3@nuvoton.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820081011.11164-2-syhuang3@nuvoton.com>

On Wed, Aug 20, 2025 at 04:07:14PM +0800, hsyemail2@gmail.com wrote:
> From: Sheng-Yuan Huang <syhuang3@nuvoton.com>
> 
> Add support for the Nuvoton USB-to-serial adapter, which provides
> multiple serial ports over a single USB interface.
> 
> The device exposes one control endpoint, one bulk-in endpoint, and
> one bulk-out endpoint for data transfer. Port status is reported via
> an interrupt-in or bulk-in endpoint, depending on device configuration.

First, thanks for the patch.

Could you say something more here about the protocol here (and in a
comment in the code) to make it easier for reviewers (e.g. the split
data packages)?

The number of ports is also configurable in firmware it seems. Some more
details like that would be good too.
 
> This driver implements basic TTY operations.
> 
> Signed-off-by: Sheng-Yuan Huang <syhuang3@nuvoton.com>
> ---

When sending a single patch it's generally preferred to skip the cover
letter and just include the changelog (of what changed in all previous
version) and any meta comments here underneath the --- line (so that it
does not end up in the commit message when applied).

>  drivers/usb/serial/Kconfig          |   10 +
>  drivers/usb/serial/Makefile         |    1 +
>  drivers/usb/serial/nct_usb_serial.c | 1532 +++++++++++++++++++++++++++
>  3 files changed, 1543 insertions(+)
>  create mode 100644 drivers/usb/serial/nct_usb_serial.c
> 
> diff --git a/drivers/usb/serial/Kconfig b/drivers/usb/serial/Kconfig
> index ef8d1c73c754..3c4871de56f4 100644
> --- a/drivers/usb/serial/Kconfig
> +++ b/drivers/usb/serial/Kconfig
> @@ -112,6 +112,16 @@ config USB_SERIAL_CH341
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called ch341.
>  
> +config USB_SERIAL_NUV_MULTI_UART

Please place this one after CONFIG_USB_SERIAL_NAVMAN to maintain some
partial sort order.

> +	tristate "USB Nuvoton Multi-Ports Serial Driver"
> +	depends on USB_SERIAL
> +	help
> +	Say Y here if you want to use a Nuvoton Multi-Ports USB to
> +	serial converter device
> +	
> +	To compile this driver as a module, choose M here: the
> +	module will be called nct_usb_serial.
> +
>  config USB_SERIAL_WHITEHEAT
>  	tristate "USB ConnectTech WhiteHEAT Serial Driver"
>  	select USB_EZUSB_FX2
> diff --git a/drivers/usb/serial/Makefile b/drivers/usb/serial/Makefile
> index c7bb1a88173e..c07919a52076 100644
> --- a/drivers/usb/serial/Makefile
> +++ b/drivers/usb/serial/Makefile
> @@ -41,6 +41,7 @@ obj-$(CONFIG_USB_SERIAL_MOS7720)		+= mos7720.o
>  obj-$(CONFIG_USB_SERIAL_MOS7840)		+= mos7840.o
>  obj-$(CONFIG_USB_SERIAL_MXUPORT)		+= mxuport.o
>  obj-$(CONFIG_USB_SERIAL_NAVMAN)			+= navman.o
> +obj-$(CONFIG_USB_SERIAL_NUV_MULTI_UART)		+= nct_usb_serial.o
>  obj-$(CONFIG_USB_SERIAL_OMNINET)		+= omninet.o
>  obj-$(CONFIG_USB_SERIAL_OPTICON)		+= opticon.o
>  obj-$(CONFIG_USB_SERIAL_OPTION)			+= option.o
> diff --git a/drivers/usb/serial/nct_usb_serial.c b/drivers/usb/serial/nct_usb_serial.c
> new file mode 100644
> index 000000000000..da6553e01cbd
> --- /dev/null
> +++ b/drivers/usb/serial/nct_usb_serial.c
> @@ -0,0 +1,1532 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2024-2025 Nuvoton Corp.
> + * Copyright (C) 2024-2025 Sheng-Yuan Huang <syhuang3@nuvoton.com>
> + *
> + * Nuvoton USB to serial adapter driver
> + *
> + * This device interface consists of one control endpoint for configuration,
> + * one bulk-out endpoint used for transmitting data for all serial ports,
> + * and one bulk-in endpoint for receiving data from all serial ports.
> + * The status of the ports may be reported via either an interrupt endpoint
> + * or the bulk-in endpoint, depending on the device configuration.
> + */
> +
> +#include <linux/bitops.h>
> +#include <linux/errno.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/serial.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/tty.h>
> +#include <linux/tty_driver.h>
> +#include <linux/tty_flip.h>
> +#include <linux/uaccess.h>
> +#include <linux/usb.h>
> +#include <linux/usb/serial.h>
> +
> +#define NCT_VENDOR_ID			0x0416
> +#define NCT_PRODUCT_ID			0x200B
> +#define NCT_USB_CLASS			0xFF
> +#define NCT_USB_SUBCLASS		0x0
> +#define NCT_USB_PROTOCOL		0x1
> +
> +#define NCT_MAX_VENDOR_READ_SIZE	8
> +
> +static const struct usb_device_id id_table[] = {
> +	{USB_DEVICE_AND_INTERFACE_INFO(NCT_VENDOR_ID, NCT_PRODUCT_ID, NCT_USB_CLASS,
> +				       NCT_USB_SUBCLASS, NCT_USB_PROTOCOL)},

Do these devices have more than one interface? Otherwise you can just
match on VID/PID here.

> +	{} /* Terminating entry */
> +};
> +
> +#define NCT_DRVNAME "nct_mtuart"

Just use the string constant in the driver struct directly.

> +
> +MODULE_DEVICE_TABLE(usb, id_table);

This belongs directly after the table.

> +#define NCT_MAX_SEND_BULK_SIZE 128
> +#define NCT_EMPTY_PORT	0xFF	/* The port does not exist in FW (For device status) */
> +
> +/*
> + * The max loop count when disconnecting for the
> + * send-work
> + */
> +#define NCT_DISCONN_QUEUE_LOOP_CNT	10

This one does not appear to be used so drop.

> +/* Hardware configure */
> +#define NCT_MAX_NUM_COM_DEVICES		8
> +#define NCT_MAX_PACKAGE_SIZE		4096 /* The max size of one writing package */
> +#define NCT_MAX_BULK_IN_SIZE		512
> +#define NCT_MAX_BULK_OUT_SIZE		512

The last three are not used either. Might they become useful? Can you
expand on their meaning?

> +
> +#define NCT_DEFAULT_BAUD		14 /* 115200 */
> +static const unsigned int NCT_BAUD_SUP[] = {
> +	/* It should be the same as FW's baud-rate table */
> +	B0,	B50,	B75,	B150,	B300,	B600,	B1200,
> +	B1800,	B2400,	B4800,	B9600,	B19200,	B38400,	B57600,
> +	B115200, B230400, B460800, B921600, B1500000
> +};
> +
> +/* USB request */
> +#define NCT_VENDOR_COM_READ_REQUEST_TYPE	0xc0

Nit: use lower or upper case hex consistently.

> +#define NCT_VENDOR_COM_WRITE_REQUEST_TYPE	0x40
> +#define NCT_VENDOR_COM_READ_REQUEST		0x01
> +#define NCT_VENDOR_COM_WRITE_REQUEST		0x01
> +/* Index definition */
> +#define NCT_VCOM_INDEX_GLOBAL	0xF
> +
> +/* Command */
> +#define NCT_VCOM_GET_NUM_PORTS		0
> +#define NCT_VCOM_GET_PORTS_SUPPORT	1
> +#define NCT_VCOM_GET_BAUD		2
> +#define NCT_VCOM_SET_INIT		3
> +#define NCT_VCOM_SET_CONFIG		4
> +#define NCT_VCOM_SET_BAUD		5
> +#define NCT_VCOM_SET_HCR		6
> +#define NCT_VCOM_SET_OPEN_PORT		7
> +#define NCT_VCOM_SET_CLOSE_PORT		8
> +#define NCT_VCOM_SILENT			9
> +/* Use bulk-in status instead of interrupt-in status */
> +#define NCT_VCON_SET_BULK_IN_STATUS	10
> +
> +struct nct_vendor_cmd {
> +	__le16 val;	/* bits[3:0]: index, bits[11:4]: cmd, bits[15:12]: reserved */
> +};
> +
> +#define NCT_CMD_INDEX_MASK	0x000F
> +#define NCT_CMD_CMD_MASK	0x0FF0
> +#define NCT_CMD_CMD_SHIFT	4
> +
> +static inline __le16 nct_build_cmd(__u8 cmd_code, __u8 index)

Throughout the driver, replace __u8 and __u16 with u8 and u16. The
underscore versions are only needed in headers shared with userspace.

> +{
> +	return cpu_to_le16(((__u16)cmd_code << NCT_CMD_CMD_SHIFT) | (index & NCT_CMD_INDEX_MASK));
> +}
> +
> +static inline __u8 nct_get_cmd_index(__le16 val)
> +{
> +	return le16_to_cpu(val) & NCT_CMD_INDEX_MASK;
> +}
> +
> +static inline __u8 nct_get_cmd_cmd(__le16 val)
> +{
> +	return (le16_to_cpu(val) & NCT_CMD_CMD_MASK) >> NCT_CMD_CMD_SHIFT;
> +}
> +
> +#define NCT_HDR_MAGIC		0xA5
> +#define NCT_HDR_MAGIC2		0x5A
> +#define NCT_HDR_MAGIC_STATUS	0x5B
> +
> +struct nct_packet_header {
> +	__u8 magic;
> +	__u8 magic2;
> +	__le16 len_and_idx;  /* bits[3:0]: idx, bits[15:4]: len */
> +} __packed;
> +
> +#define NCT_HDR_IDX_MASK	0x000F
> +#define NCT_HDR_LEN_MASK	0xFFF0
> +#define NCT_HDR_LEN_SHIFT	4
> +
> +static inline void nct_set_hdr_idx_len(struct nct_packet_header *hdr, __u8 idx, __u16 len)
> +{
> +	hdr->len_and_idx = cpu_to_le16((len << NCT_HDR_LEN_SHIFT) | (idx & NCT_HDR_IDX_MASK));
> +}
> +
> +static inline __u8 nct_get_hdr_idx(const struct nct_packet_header *hdr)
> +{
> +	return le16_to_cpu(hdr->len_and_idx) & NCT_HDR_IDX_MASK;
> +}
> +
> +static inline __u16 nct_get_hdr_len(const struct nct_packet_header *hdr)
> +{
> +	return (le16_to_cpu(hdr->len_and_idx) & NCT_HDR_LEN_MASK) >> NCT_HDR_LEN_SHIFT;
> +}
> +
> +/* The definitions are for the fields of nct_ctrl_msg */
> +#define NCT_VCOM_1_STOP_BIT		0
> +#define NCT_VCOM_2_STOP_BITS		1
> +#define NCT_VCOM_PARITY_NONE		0
> +#define NCT_VCOM_PARITY_ODD		1
> +#define NCT_VCOM_PARITY_EVEN		2
> +#define NCT_VCOM_DL5			0
> +#define NCT_VCOM_DL6			1
> +#define NCT_VCOM_DL7			2
> +#define NCT_VCOM_DL8			3
> +#define NCT_VCOM_DISABLE_FLOW_CTRL	0
> +#define NCT_VCOM_XOFF			1
> +#define NCT_VCOM_RTS_CTS		2
> +
> +struct nct_ctrl_msg {
> +	__le16 val;
> +};
> +
> +#define NCT_CTRL_STOP_BIT_MASK		0x0001
> +#define NCT_CTRL_PARITY_MASK		0x0006
> +#define NCT_CTRL_PARITY_SHIFT		1
> +#define NCT_CTRL_DATA_LEN_MASK		0x0018
> +#define NCT_CTRL_DATA_LEN_SHIFT		3
> +#define NCT_CTRL_FLOW_MASK		0x0060
> +#define NCT_CTRL_FLOW_SHIFT		5
> +#define NCT_CTRL_SPD_MASK		0x0F80
> +#define NCT_CTRL_SPD_SHIFT		7
> +#define NCT_CTRL_RESERVED_MASK		0xF000
> +#define NCT_CTRL_RESERVED_SHIFT		12
> +
> +static inline __le16 nct_build_ctrl_msg(__u8 stop_bit, __u8 parity, __u8 data_len,
> +					__u8 flow, __u8 spd)
> +{
> +	__u16 val = 0;
> +
> +	val |= (stop_bit & 0x01);
> +	val |= ((parity & 0x03) << NCT_CTRL_PARITY_SHIFT);
> +	val |= ((data_len & 0x03) << NCT_CTRL_DATA_LEN_SHIFT);
> +	val |= ((flow & 0x03) << NCT_CTRL_FLOW_SHIFT);
> +	val |= ((spd & 0x1F) << NCT_CTRL_SPD_SHIFT);

Shouldn't you use the masks you have defined above here?

> +
> +	return cpu_to_le16(val);
> +}
> +
> +static inline __u8 nct_get_ctrl_stop_bit(__le16 val)
> +{
> +	return le16_to_cpu(val) & NCT_CTRL_STOP_BIT_MASK;
> +}
> +
> +static inline __u8 nct_get_ctrl_parity(__le16 val)
> +{
> +	return (le16_to_cpu(val) & NCT_CTRL_PARITY_MASK) >> NCT_CTRL_PARITY_SHIFT;
> +}
> +
> +static inline __u8 nct_get_ctrl_data_len(__le16 val)
> +{
> +	return (le16_to_cpu(val) & NCT_CTRL_DATA_LEN_MASK) >> NCT_CTRL_DATA_LEN_SHIFT;
> +}
> +
> +static inline __u8 nct_get_ctrl_flow(__le16 val)
> +{
> +	return (le16_to_cpu(val) & NCT_CTRL_FLOW_MASK) >> NCT_CTRL_FLOW_SHIFT;
> +}
> +
> +static inline __u8 nct_get_ctrl_spd(__le16 val)
> +{
> +	return (le16_to_cpu(val) & NCT_CTRL_SPD_MASK) >> NCT_CTRL_SPD_SHIFT;
> +}
> +
> +static inline __le16 nct_set_ctrl_spd(__le16 val, __u8 spd)
> +{
> +	__u16 cpu_val = le16_to_cpu(val);
> +
> +	cpu_val = (cpu_val & ~NCT_CTRL_SPD_MASK) | ((spd & 0x1F) << NCT_CTRL_SPD_SHIFT);
> +	return cpu_to_le16(cpu_val);
> +}

These helpers are apparently unused and should be removed.

> +#define NCT_USR_RDR	0x01
> +#define NCT_USR_ORR	0x02
> +#define NCT_USR_PBER	0x04
> +#define NCT_USR_NSER	0x08
> +#define NCT_USR_SBD	0x10
> +#define NCT_USR_TBRE	0x20
> +#define NCT_USR_TSRE	0x40
> +#define NCT_USR_RFEI	0x80
> +#define NCT_HSR_TCTS	0x01
> +#define NCT_HSR_TDSR	0x02
> +#define NCT_HSR_FERI	0x04
> +#define NCT_HSR_TDCD	0x08
> +#define NCT_HSR_CTS	0x10
> +#define NCT_HSR_DSR	0x20
> +#define NCT_HSR_RI	0x40
> +#define NCT_HSR_DCD	0x80
> +#define NCT_HCR_DTR	0x01
> +#define NCT_HCR_RTS	0x02
> +#define NCT_UART_STATE_MSR_MASK (NCT_HSR_TCTS | NCT_HSR_TDSR | NCT_HSR_TDCD | NCT_HSR_DCD)

I would add an empty line here.

> +struct nct_port_status {
> +	u8 index;
> +	u8 usr;
> +	u8 hsr;
> +	u8 hcr;
> +};
> +
> +struct nct_serial {
> +	spinlock_t serial_lock; /* Protects the private data in structure 'usb_serial' */

I guess you meant 'nct_serial' here.

Not sure how useful such a comment is however. It looks like you've been
running checkpatch on this patch during development with the --strict
option (aka --pedantic). The latter is typically not needed and warns
about style issues which are not generally agreed upon.

Do continue to run checkpatch, but skip the --strict option, or at least
be very sceptical of the output with that flag set. And always use your
own judgement.

> +	bool device_init;
> +
> +	/* Reading data information */
> +	struct nct_tty_port *cur_port;
> +	int cur_len;
> +
> +	bool status_trans_mode;

Please rename this to something more descriptive like "bulk_status" or
similar. Or inverted "has_interrupt" since you mostly check that
the current flag is not set. Or similar.

> +	u8 en_device_mask;
> +	u8 last_assigned_hw_idx;
> +	struct usb_endpoint_descriptor *bulk_out_ep;
> +};
> +
> +struct nct_tty_port {
> +	unsigned long sysrq; /* Sysrq timeout */
> +	u8 hw_idx;
> +	u8 usr;
> +	u8 hsr;
> +	u8 hcr;
> +	/*
> +	 * Flow control - stop writing data to device.
> +	 * 0: Write enable, 1: Stop writing
> +	 */
> +	bool flow_stop_wrt;
> +
> +	spinlock_t port_lock; /* Protects the port data */

Similar here.

> +	bool write_urb_in_use;
> +};
> +
> +/* Functions */
> +
> +/* Read from USB control pipe */
> +static int nct_vendor_read(struct usb_interface *intf, struct nct_vendor_cmd cmd,
> +			   unsigned char *buf, int size)
> +{
> +	struct device *dev = &intf->dev;
> +	struct usb_device *udev = interface_to_usbdev(intf);
> +	u8 *tmp_buf;
> +	int res;
> +
> +	tmp_buf = kmalloc(NCT_MAX_VENDOR_READ_SIZE, GFP_KERNEL);
> +	if (!tmp_buf)
> +		return -ENOMEM;
> +
> +	if (size > NCT_MAX_VENDOR_READ_SIZE) {
> +		dev_err(dev, "%s - failed to read [%04x]: over size %d\n",
> +			__func__, nct_get_cmd_cmd(cmd.val), size);

Please drop __func__ from all error messages in favour of spelling out
what went wrong (concisely).

But here you don't even need an error message as this function is only
used in calc_num_ports() with a constant argument. You can keep the
check if you think there can be other user in the future, but just skip
the dev_err().

> +		kfree(tmp_buf);
> +		return -EINVAL;
> +	}

Verify the arguments before allocating the buffer.

> +
> +	res = usb_control_msg(udev, usb_rcvctrlpipe(udev, 0),
> +			      NCT_VENDOR_COM_READ_REQUEST,
> +			      NCT_VENDOR_COM_READ_REQUEST_TYPE,
> +			      le16_to_cpu(cmd.val),
> +			      intf->cur_altsetting->desc.bInterfaceNumber,
> +			      tmp_buf, size, 100);
> +
> +	if (res < 0) {
> +		dev_err(dev, "%s - failed to read [%04x]: %d\n", __func__,
> +			nct_get_cmd_cmd(cmd.val), res);
> +		kfree(tmp_buf);
> +		return res;
> +	}

You should also check for short transfers I assume. We have a couple of
fairly new helpers that takes care of that as well as the temporary
buffer allocation. Looks like you may want to use them here and below.

	usb_control_msg_recv()
	usb_control_msg_send()

> +	memcpy(buf, tmp_buf, res);
> +	kfree(tmp_buf);
> +
> +	return res;
> +}
> +
> +static int nct_vendor_write(struct usb_interface *intf, struct nct_vendor_cmd cmd, __u16 val)
> +{
> +	struct device *dev = &intf->dev;
> +	struct usb_device *udev = interface_to_usbdev(intf);
> +	int res;
> +	__le16 *buf_val;
> +
> +	buf_val = kmalloc(2, GFP_KERNEL);
> +	if (!buf_val)
> +		return -ENOMEM;
> +
> +	*buf_val = cpu_to_le16(val);
> +
> +	res = usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
> +			      NCT_VENDOR_COM_WRITE_REQUEST,
> +			      NCT_VENDOR_COM_WRITE_REQUEST_TYPE,
> +			      le16_to_cpu(cmd.val),
> +			      intf->cur_altsetting->desc.bInterfaceNumber,
> +			      buf_val,
> +			      2,
> +			      100);
> +	kfree(buf_val);
> +	if (res < 0)
> +		dev_err(dev, "%s - failed to write [%04x]: %d\n", __func__,
> +			nct_get_cmd_cmd(cmd.val), res);
> +	else
> +		res = 0; /* Set to 0 to align with the design. */
> +
> +	return res;
> +}
> +
> +static u16 nct_set_baud(struct usb_interface *intf, u16 index, unsigned int cflag, bool *found)
> +{
> +	struct nct_vendor_cmd cmd;
> +	struct nct_ctrl_msg msg;
> +	u16 i;
> +	u8 spd = NCT_DEFAULT_BAUD;
> +
> +	*found = false;
> +	cmd.val = nct_build_cmd(NCT_VCOM_SET_BAUD, index);
> +	dev_dbg(&intf->dev, "tty baud: 0x%X\n", (cflag & CBAUD));
> +	for (i = 0; i < ARRAY_SIZE(NCT_BAUD_SUP); i++) {
> +		if ((cflag & CBAUD) == NCT_BAUD_SUP[i]) {

Consider inverting this check to reduce indentation below, that is,

		if ((cflag & CBAUD) != NCT_BAUD_SUP[i])
			continue;
	
> +			spd = i;
> +			dev_dbg(&intf->dev, "index %d set baud: NCT_BAUD_SUP[%d]=%d\n",
> +				index, spd, NCT_BAUD_SUP[i]);
> +			/*
> +			 * Create control message
> +			 * Note: The NCT_VCOM_SET_BAUD only set the baud rate
> +			 */
> +			msg.val = nct_build_ctrl_msg(0, 0, 0, 0, spd);
> +			if (nct_vendor_write(intf, cmd, le16_to_cpu(msg.val)))
> +				dev_err(&intf->dev, "%s - Set index: %d speed error\n",
> +					__func__, index);

nct_vendor_write() is already logging an error including the command so
you can probably just skip the dev_err here.

> +			else
> +				*found = true;
> +
> +			break;
> +		}
> +	}
> +
> +	return spd;
> +}
> +
> +static void nct_serial_set_termios(struct tty_struct *tty,
> +				   struct usb_serial_port *port,
> +				   const struct ktermios *old)
> +{
> +	struct nct_tty_port *tport = usb_get_serial_port_data(port);
> +	struct usb_serial *serial = port->serial;
> +	struct usb_interface *intf = serial->interface;
> +	struct ktermios *termios = &tty->termios;
> +	struct nct_ctrl_msg msg;
> +	struct nct_vendor_cmd cmd;
> +	unsigned int cflag = termios->c_cflag;
> +	int ret;
> +	speed_t baud, old_baud;
> +	u8 stop_bit, parity, data_len, flow, spd = 0;

Don't mix multiple declarations and initialisation like this.

Does spd == 0 mean that the speed is left unchanged below?

That may be more obvious if you set it just before creating the control
message or just use a constant zero there.

> +	bool baud_found;
> +
> +	baud_found = false;
> +	baud = tty_get_baud_rate(tty);
> +	if (old && tty_termios_baud_rate(old))
> +		old_baud = tty_termios_baud_rate(old);
> +	else
> +		old_baud = NCT_BAUD_SUP[NCT_DEFAULT_BAUD];
> +
> +	cmd.val = nct_build_cmd(NCT_VCOM_SET_CONFIG, tport->hw_idx);
> +
> +	/* Set stop bit */
> +	stop_bit = (cflag & CSTOPB) ? (NCT_VCOM_2_STOP_BITS) : (NCT_VCOM_1_STOP_BIT);

I think you can drop cflag in favour of the C_CSTOPB() macro and
friends here and below.

Also, please void using the ternary operator which tends to make code
less readable.

> +
> +	/* Set parity */
> +	if (cflag & PARENB)
> +		parity = (cflag & PARODD) ? NCT_VCOM_PARITY_ODD : NCT_VCOM_PARITY_EVEN;
> +	else
> +		parity = NCT_VCOM_PARITY_NONE;

If the device does not support CMSPAR you should clear that flag in
termios before returning.

> +
> +	/* Set data bit length */
> +	switch (cflag & CSIZE) {
> +	case CS5:
> +		data_len = NCT_VCOM_DL5;
> +		break;
> +	case CS6:
> +		data_len = NCT_VCOM_DL6;
> +		break;
> +	case CS7:
> +		data_len = NCT_VCOM_DL7;
> +		break;
> +	default:
> +	case CS8:
> +		data_len = NCT_VCOM_DL8;
> +		break;
> +	}
> +
> +	/* Set flow control */
> +	if (C_CRTSCTS(tty)) {
> +		flow = NCT_VCOM_RTS_CTS;
> +		/* Flow control - Set flag of RTSCTS */
> +		tty_port_set_cts_flow(tty->port, true);
> +	} else if (I_IXON(tty)) {
> +		flow = NCT_VCOM_XOFF;
> +		/* Flow control - Clear flag of RTSCTS */
> +		tty_port_set_cts_flow(tty->port, false);
> +	} else {
> +		flow = NCT_VCOM_DISABLE_FLOW_CTRL;
> +		/* Flow control - Clear flag of RTSCTS */
> +		tty_port_set_cts_flow(tty->port, false);
> +	}
> +
> +	/* Create control message */
> +	msg.val = nct_build_ctrl_msg(stop_bit, parity, data_len, flow, spd);
> +
> +	ret = nct_vendor_write(intf, cmd, le16_to_cpu(msg.val));
> +	if (ret)
> +		dev_err(&intf->dev,
> +			"%s - Set index: %d set configure error\n",
> +			__func__, nct_get_cmd_index(cmd.val));

Please use brackets around multiline statements like this since its way
more readable.

But as above, not sure how useful this message is if you're already
logging io errors in nct_vendor_write().

> +
> +	/*
> +	 * Set baud if speed changed
> +	 * Note: 'nct_set_baud()' also send the speed to the FW
> +	 */
> +	if (!old ||
> +	    old->c_cflag != termios->c_cflag ||

I don't think you need this one.

> +	    old->c_ispeed != termios->c_ispeed ||
> +	    old->c_ospeed != termios->c_ospeed) {

And checking ospeed should be enough.

> +		spd = nct_set_baud(intf, tport->hw_idx, cflag, &baud_found);

The helper does not use anything but the speed bits so perhaps just pass
those for clarity.

Also no point in returning spd it seems?

Seems like the helper should return 0 or an errno (e.g. EINVAL for
unsupported rate) and you can skip baud_found.

> +	}
> +
> +	if (baud_found)
> +		tty_encode_baud_rate(tty, baud, baud);
> +	else
> +		tty_encode_baud_rate(tty, old_baud, old_baud);

And this should go inside the above conditional.

> +}
> +
> +static int nct_serial_break(struct tty_struct *tty, int break_state)
> +{
> +	struct usb_serial_port *port = tty->driver_data;
> +	struct nct_tty_port *tport = usb_get_serial_port_data(port);
> +	struct usb_serial *serial = port->serial;
> +	struct usb_interface *intf = serial->interface;
> +	struct nct_vendor_cmd cmd;
> +
> +	cmd.val = nct_build_cmd(NCT_VCOM_SILENT, tport->hw_idx);
> +
> +	return nct_vendor_write(intf, cmd, 0);
> +}
> +
> +static int nct_tiocmset_helper(struct tty_struct *tty, unsigned int set,
> +			       unsigned int clear)
> +{
> +	struct usb_serial_port *port = tty->driver_data;
> +	struct nct_tty_port *tport = usb_get_serial_port_data(port);
> +	struct usb_serial *serial = port->serial;
> +	struct usb_interface *intf = serial->interface;
> +	struct nct_ctrl_msg msg;
> +	struct nct_vendor_cmd cmd;
> +	u8 hcr = 0;

This function should honour the current HCR value.

> +
> +	if (set & TIOCM_RTS)
> +		hcr |= NCT_HCR_RTS;
> +	if (set & TIOCM_DTR)
> +		hcr |= NCT_HCR_DTR;
> +	if (clear & TIOCM_RTS)
> +		hcr &= ~NCT_HCR_RTS;
> +	if (clear & TIOCM_DTR)
> +		hcr &= ~NCT_HCR_DTR;
> +
> +	cmd.val = nct_build_cmd(NCT_VCOM_SET_HCR, tport->hw_idx);
> +	msg.val = cpu_to_le16(hcr);
> +
> +	spin_lock_irq(&tport->port_lock);
> +	tport->hcr = hcr;
> +	spin_unlock_irq(&tport->port_lock);
> +
> +	dev_dbg(&intf->dev,
> +		"index/cmd/val(hcr)=%X, %X, %X [RTS=%X, DTR=%X]\n",
> +		nct_get_cmd_index(cmd.val), nct_get_cmd_cmd(cmd.val),
> +		le16_to_cpu(msg.val), hcr & NCT_HCR_RTS, hcr & NCT_HCR_DTR);

Please drop some of these dev_dbg() which should not be needed once
driver has been written.

> +
> +	return nct_vendor_write(intf, cmd, le16_to_cpu(msg.val));
> +}
> +
> +static int nct_serial_tiocmget(struct tty_struct *tty)
> +{
> +	struct usb_serial_port *port = tty->driver_data;
> +	struct nct_tty_port *tport = usb_get_serial_port_data(port);
> +	struct usb_serial *serial = port->serial;
> +	struct usb_interface *intf = serial->interface;
> +

Stray newline.

> +	unsigned int res;
> +	u8 hcr, hsr;
> +
> +	spin_lock_irq(&tport->port_lock);
> +	hcr = tport->hcr;
> +	hsr = tport->hsr;
> +	spin_unlock_irq(&tport->port_lock);
> +	res = ((hcr & NCT_HCR_DTR) ? TIOCM_DTR : 0) |
> +		((hcr & NCT_HCR_RTS) ? TIOCM_RTS : 0) |

Either stick to open-parenthesis alignment consistently, or use at least
two tabs for indenting continuation lines.

> +		((hsr & NCT_HSR_CTS) ? TIOCM_CTS : 0) |
> +		((hsr & NCT_HSR_DSR) ? TIOCM_DSR : 0) |
> +		((hsr & NCT_HSR_TDCD) ? TIOCM_RI : 0) |
> +		((hsr & NCT_HSR_DCD) ? TIOCM_CD : 0);
> +
> +	dev_dbg(&intf->dev, "DTR/RTS/CTS/DSR=%X,%X,%X,%X\n",
> +		(hcr & NCT_HCR_DTR), (hcr & NCT_HCR_RTS),
> +		(hsr & NCT_HSR_CTS), (hsr & NCT_HSR_DSR));
> +
> +	return res;
> +}
> +
> +static void nct_rx_throttle(struct tty_struct *tty)
> +{
> +	/* Handle RTS line for RTS/CTS flow control */
> +	if (C_CRTSCTS(tty))
> +		nct_tiocmset_helper(tty, 0, TIOCM_RTS);
> +}
> +
> +static void nct_rx_unthrottle(struct tty_struct *tty)
> +{
> +	/* Handle RTS line for RTS/CTS flow control */
> +	if (C_CRTSCTS(tty))
> +		nct_tiocmset_helper(tty, TIOCM_RTS, 0);
> +}

First, can you even control RTS when the device is in hardware flow
control mode?

Second, I think you're supposed to just stop reading from the device
here to exert back pressure so that it in turn deasserts RTS.

> +static int nct_serial_write_data(struct tty_struct *tty, struct usb_serial_port *port,
> +				 const unsigned char *buf, int count)
> +{
> +	int ret;
> +	unsigned long flags;
> +	struct nct_packet_header hdr;
> +	int wr_len;
> +	struct nct_tty_port *tport = usb_get_serial_port_data(port);
> +
> +	wr_len = min((unsigned int)count, NCT_MAX_SEND_BULK_SIZE - sizeof(hdr));
> +
> +	if (!wr_len)
> +		return 0;
> +
> +	spin_lock_irqsave(&tport->port_lock, flags);
> +
> +	if (tport->write_urb_in_use) {
> +		spin_unlock_irqrestore(&tport->port_lock, flags);
> +		return 0;
> +	}

You need to be able to buffer at least a single characters, but it's
better to just use the write fifo that has already been allocated for
each port.

But instead of doing a driver specific implementation you should try to
resuse the generic implementation which is also more efficient (e.g. by
using two write urbs).

Take a look at drivers such mxuport that use a similar protocol do this.

> +
> +	/* Fill header */
> +	hdr.magic = NCT_HDR_MAGIC;
> +	hdr.magic2 = NCT_HDR_MAGIC2;
> +	nct_set_hdr_idx_len(&hdr, tport->hw_idx, wr_len); /* The 'hw_idx' is based on 1 */

Try to stick within the 80 char limit unless breaking it improves
readability.

Note that checkpatch won't help you with this since its a soft rule
(that it is okay to break occasionally).

> +
> +	/* Copy data */
> +	memcpy(port->write_urb->transfer_buffer + sizeof(hdr),
> +	       (const void *)buf, wr_len);
> +
> +	/* Filled urb data */
> +	memcpy(port->write_urb->transfer_buffer, (const void *)&hdr,
> +	       sizeof(hdr)); /* Copy header after filling all other fields */
> +
> +	/* Set urb length(Total length) */
> +	port->write_urb->transfer_buffer_length = wr_len + sizeof(hdr);
> +
> +	port->write_urb->transfer_flags |= URB_ZERO_PACKET;
> +
> +	ret = usb_submit_urb(port->write_urb, GFP_ATOMIC);
> +	if (ret < 0) {
> +		dev_err(&port->dev,
> +			"%s: usb_submit_urb failed, ret=%d, hw_idx=%d\n",
> +			__func__, ret, tport->hw_idx);
> +	} else {
> +		tport->write_urb_in_use = true; /* Set it as busy */
> +		ret = wr_len;
> +	}
> +
> +	spin_unlock_irqrestore(&tport->port_lock, flags);
> +
> +	dev_dbg(&port->dev, "returning %d\n", ret);

Like I mentioned elsewhere, drop dev_dbg() like this one.

> +	return ret;
> +}
> +
> +static int nct_serial_write(struct tty_struct *tty, struct usb_serial_port *port,
> +			    const unsigned char *buf, int count)
> +{
> +	struct nct_tty_port *tport = usb_get_serial_port_data(port);
> +
> +	/* Flow control */
> +	if (tty_port_cts_enabled(tty->port))
> +		if (tport->flow_stop_wrt)
> +			return 0;

Here too, doesn't the device stop sending on its own when in hardware
flow control mode?

> +
> +	return nct_serial_write_data(tty, port, buf, count);
> +}
> +
> +static void nct_write_bulk_callback(struct urb *urb)
> +{
> +	struct usb_serial_port *port = urb->context;
> +	struct nct_tty_port *tport;
> +	unsigned long flags;
> +	int status = urb->status;
> +
> +	/* Port and serial sanity check */
> +	if (!port) {
> +		pr_err("%s: port is NULL, status=%d\n", __func__, status);
> +		return;
> +	}
> +
> +	tport = usb_get_serial_port_data(port);
> +	if  (!tport) {
> +		dev_err(&port->dev, "%s: port->private is NULL, status=%d\n", __func__, status);
> +		return;
> +	}

Drop checks like the above two that will never be true.

> +
> +	spin_lock_irqsave(&tport->port_lock, flags);
> +	tport->write_urb_in_use = false;
> +	spin_unlock_irqrestore(&tport->port_lock, flags);
> +
> +	tty_port_tty_wakeup(&port->port);
> +}
> +
> +static unsigned int nct_write_room(struct tty_struct *tty)
> +{
> +	struct usb_serial_port *port = tty->driver_data;
> +	struct nct_tty_port *tport = usb_get_serial_port_data(port);
> +	unsigned long flags;
> +	unsigned int room;
> +
> +	spin_lock_irqsave(&tport->port_lock, flags);
> +	if (tport->write_urb_in_use)
> +		room = 0;
> +	else
> +		room = NCT_MAX_SEND_BULK_SIZE - sizeof(struct nct_packet_header);
> +	spin_unlock_irqrestore(&tport->port_lock, flags);
> +
> +	dev_dbg(&port->dev, "port=%d, room=%u\n", tport->hw_idx, room);
> +	return room;
> +}
> +
> +static unsigned int nct_chars_in_buffer(struct tty_struct *tty)
> +{
> +	struct usb_serial_port *port = tty->driver_data;
> +	struct nct_tty_port *tport = usb_get_serial_port_data(port);
> +	unsigned long flags;
> +	unsigned int chars;
> +
> +	spin_lock_irqsave(&tport->port_lock, flags);
> +	if (tport->write_urb_in_use)
> +		chars = NCT_MAX_SEND_BULK_SIZE - sizeof(struct nct_packet_header);
> +	else
> +		chars = 0;
> +	spin_unlock_irqrestore(&tport->port_lock, flags);
> +
> +	dev_dbg(&port->dev, "port=%d, chars=%d\n", tport->hw_idx, chars);
> +	return chars;
> +}
> +
> +/*
> + *  Starts reads urb on all ports. It is to avoid potential issues caused by
> + *  multiple ports being opened almost simultaneously.
> + *  It must be called AFTER startup, with urbs initialized.
> + *  Returns 0 if successful, non-zero error otherwise.
> + */
> +static int nct_startup_device(struct usb_serial *serial)
> +{
> +	int ret = 0;

Redundant init, and please place short declarations like this last
(reverse xmas style).

> +	struct nct_serial *serial_priv = usb_get_serial_data(serial);
> +	struct usb_serial_port *port;
> +	unsigned long flags;
> +
> +	/* Be sure this happens exactly once */
> +	spin_lock_irqsave(&serial_priv->serial_lock, flags);
> +
> +	if (serial_priv->device_init) {

You should use a counter here and submit the urbs on first open and stop
them on last close.

> +		spin_unlock_irqrestore(&serial_priv->serial_lock, flags);
> +		return 0;
> +	}
> +	serial_priv->device_init = true;
> +	spin_unlock_irqrestore(&serial_priv->serial_lock, flags);
> +
> +	/* Start reading from bulk in endpoint */
> +	port = serial->port[0];
> +	if (!port->read_urb)
> +		dev_dbg(&port->dev, "port->read_urb is null, index=%d\n", 0);
> +
> +	ret = usb_submit_urb(port->read_urb, GFP_KERNEL);
> +	if (ret)
> +		dev_err(&port->dev,
> +			"%s: usb_submit_urb failed, ret=%d, port=%d\n",
> +			__func__, ret, 0);

Similar here, consider using the generic implementation for reading as
well.

> +
> +	/* For getting status from interrupt-in */
> +	if (!serial_priv->status_trans_mode) {
> +		/* Start reading from interrupt pipe */
> +		port = serial->port[0];
> +		ret = usb_submit_urb(port->interrupt_in_urb, GFP_KERNEL);
> +		if (ret)
> +			dev_err(&port->dev,
> +				"%s: usb_submit_urb(intr) failed, ret=%d, port=%d\n",
> +				__func__, ret, 0);
> +	}
> +	return ret;
> +}
> +
> +static void nct_serial_port_end(struct usb_serial_port *port)
> +{
> +	struct nct_tty_port *tport = usb_get_serial_port_data(port);
> +	struct usb_serial *serial = port->serial;
> +	struct usb_interface *intf = serial->interface;
> +	struct nct_ctrl_msg msg;
> +	struct nct_vendor_cmd cmd;
> +
> +	/* Send 'Close Port' to the device */
> +	cmd.val = nct_build_cmd(NCT_VCOM_SET_CLOSE_PORT, tport->hw_idx);
> +	msg.val = cpu_to_le16(0);
> +	if (!intf) {

How can intf be NULL here?

> +		pr_err("%s: No intf => do not send 'close' event\n", __func__);
> +		return;
> +	}
> +	nct_vendor_write(intf, cmd, le16_to_cpu(msg.val));
> +}

Just fold this one into close().

> +
> +static int nct_open(struct tty_struct *tty, struct usb_serial_port *port)
> +{
> +	struct nct_vendor_cmd cmd;
> +	struct nct_ctrl_msg msg;
> +	struct nct_tty_port *tport = usb_get_serial_port_data(port);
> +	struct usb_serial *serial = port->serial;
> +	struct nct_serial *serial_priv = usb_get_serial_data(serial);
> +	struct usb_interface *intf = serial->interface;
> +	int ret;
> +
> +	if (!port->serial)
> +		return -ENXIO;

Remove.

> +
> +	/* Allocate write_urb */
> +	if (!port->write_urb) {

The write urb has already been allocate by core for port 0.

> +		port->write_urb = usb_alloc_urb(0, GFP_KERNEL);
> +		if (!port->write_urb) {
> +			dev_err(&port->dev, "%s: Failed to allocate write URB\n", __func__);
> +			return -ENOMEM;
> +		}
> +	}
> +
> +	/* Allocate bulk_out_buffer */
> +	port->write_urb->transfer_buffer = kzalloc(NCT_MAX_SEND_BULK_SIZE, GFP_KERNEL);

And so has the buffer so you're leaking that memory here.

> +	if (!port->write_urb->transfer_buffer) {
> +		usb_free_urb(port->write_urb);
> +		port->write_urb = NULL;
> +		return -ENOMEM;
> +	}
> +
> +	/* Set write_urb */
> +	usb_fill_bulk_urb(port->write_urb, serial->dev,
> +			  usb_sndbulkpipe(serial->dev, serial_priv->bulk_out_ep->bEndpointAddress),
> +			  port->write_urb->transfer_buffer, NCT_MAX_SEND_BULK_SIZE,
> +			  nct_write_bulk_callback, port);

See how mxuport sets up the port endpoints in mxuport_calc_num_ports()
so that all ports use the same bulk-out endpoint. That way core will
allocate resources for all ports at probe.

> +
> +	/* Be sure the device is started up */
> +	if (nct_startup_device(port->serial) != 0)
> +		return -ENXIO;
> +
> +	cmd.val = nct_build_cmd(NCT_VCOM_SET_OPEN_PORT, tport->hw_idx);
> +	msg.val = cpu_to_le16(0);
> +	ret = nct_vendor_write(intf, cmd, le16_to_cpu(msg.val));
> +	if (ret) {
> +		dev_err(&port->dev, "%s: Failed to open port: %d\n", __func__, ret);
> +		kfree(port->write_urb->transfer_buffer);
> +		usb_free_urb(port->write_urb);
> +		port->write_urb = NULL;
> +		return ret;
> +	}
> +
> +	/*
> +	 * Delay 1ms for firmware to configure hardware after opening the port.
> +	 * (Especially at high speed)
> +	 */
> +	usleep_range(1000, 2000);
> +	return 0;
> +}

> +static void nct_update_status(struct usb_serial *serial, unsigned char *data)
> +{
> +	struct nct_port_status *nps = (struct nct_port_status *)data;
> +	struct usb_interface *intf = serial->interface;
> +	struct nct_tty_port *tport;
> +	struct tty_struct *tty;
> +	struct usb_serial_port *port;
> +	unsigned long flags;
> +	bool found;
> +	int i;
> +
> +	if (nps->index >= NCT_MAX_NUM_COM_DEVICES) {
> +		if (nps->index != NCT_EMPTY_PORT) /* Un-used port */
> +			dev_warn(&intf->dev, "%s: Receive wrong H/W index\n", __func__);
> +		return;
> +	}
> +	if (!(nps->hsr & (NCT_UART_STATE_MSR_MASK | NCT_HSR_CTS)))
> +		return; /* No any state changed. */
> +	tport = NULL;
> +	found = false;
> +	for (i = 0; i < serial->type->num_ports; i++) {
> +		port = serial->port[i];
> +
> +		if (!port) {
> +			dev_err(&intf->dev, "%s: port[%d] is NULL\n", __func__, i);
> +			continue;
> +		}
> +
> +		tport = usb_get_serial_port_data(port);
> +
> +		if (!tport) {
> +			dev_err(&intf->dev, "%s: Get NULL port data for port[%d]\n",
> +				__func__, i);
> +			continue;
> +		}

No need for these checks here either.

> +
> +		if (tport->hw_idx == nps->index) {
> +			found = true;
> +			break;
> +		}
> +	}

Should you just keep a lookup table for this to avoid searching for the
port on every status update?

> +
> +	if (!found) {
> +		dev_err(&intf->dev, "%s: Decode serial packet index failed.\n",	__func__);
> +		return;
> +	}
> +
> +	if (!tport) {

How can tport be NULL here?

> +		dev_err(&intf->dev, "%s: Decode serial packet index failed.\n",	__func__);
> +		return;
> +	}
> +
> +	spin_lock_irqsave(&tport->port_lock, flags);
> +	tport->usr = nps->usr;
> +	tport->hsr = nps->hsr;
> +	tport->hcr = nps->hcr;

> +	tport->sysrq = (tport->sysrq & ~0x01) | (-(nps->usr & NCT_USR_SBD) & 0x01);

What's going on here?

> +	spin_unlock_irqrestore(&tport->port_lock, flags);
> +
> +	if (serial->disconnected) {
> +		dev_err(&intf->dev, "%s: Device disconnected, skipping update_status\n",
> +			__func__);
> +		return;
> +	}
> +
> +	tty = tty_port_tty_get(&port->port);
> +	if (!tty)
> +		return; /* The port has been closed. */
> +
> +	if (nps->hsr & NCT_UART_STATE_MSR_MASK) {
> +		if (nps->hsr & NCT_HSR_DCD) {
> +			if (tty) {

How can tty be NULL here?

> +				struct tty_ldisc *ld = tty_ldisc_ref(tty);
> +
> +				if (ld) {
> +					if (ld->ops->dcd_change)
> +						ld->ops->dcd_change(tty, 0x01);
> +					tty_ldisc_deref(ld);
> +				}
> +				wake_up_interruptible(&tty->port->open_wait);
> +			}
> +		}
> +	}
> +
> +	/* Flow control */
> +	if (tty_port_cts_enabled(&port->port)) {
> +		if ((nps->hsr & NCT_HSR_CTS)) {
> +			if (tport->flow_stop_wrt)
> +				tport->flow_stop_wrt = false;
> +		} else {
> +			tport->flow_stop_wrt = true;
> +		}
> +	}

As I mentioned elsewhere, you shouldn't need to track CTS manually like
this when the device is in hardware flow control mode, right?

> +
> +	tty_kref_put(tty);
> +}
> +
> +static void nct_usb_serial_read(struct urb *urb)
> +{
> +	struct usb_serial_port *port =  urb->context;
> +	struct usb_serial *serial = port->serial;
> +	struct usb_interface *intf = serial->interface;
> +	struct nct_serial *serial_priv = usb_get_serial_data(serial);
> +	struct nct_tty_port *tport;
> +	struct nct_packet_header *hdr = NULL;
> +	unsigned char *data = urb->transfer_buffer;
> +	int i, j;
> +	int actual_len = urb->actual_length;
> +	int len = 0;
> +	struct nct_port_status *nps;
> +	unsigned long flags;
> +
> +	if (!urb->actual_length)
> +		return;
> +
> +again:
> +	spin_lock_irqsave(&serial_priv->serial_lock, flags);
> +	tport = serial_priv->cur_port;
> +	if (!tport) {
> +		/*
> +		 * Handle a new data package (i.e., it is not
> +		 * the remaining data without a header).
> +		 * The package does not need to be combined this time.
> +		 */
> +		for (i = 0; i < urb->actual_length; i++) {
> +			if (i + sizeof(struct nct_packet_header) > urb->actual_length) {
> +				/* Not enough data for header */
> +				spin_unlock_irqrestore(&serial_priv->serial_lock, flags);
> +				return;
> +			}
> +
> +			hdr = (struct nct_packet_header *)data;
> +			/* Decode the header */
> +
> +			if (serial_priv->status_trans_mode) {
> +				/*
> +				 * Status data is also transmitted via bulk-in
> +				 * pipe.
> +				 */
> +				if (hdr->magic == NCT_HDR_MAGIC &&
> +				    hdr->magic2 == NCT_HDR_MAGIC_STATUS &&
> +				    nct_get_hdr_len(hdr) == 24 && actual_len >= 28) {
> +					/*
> +					 * Notice: actual_len will be decreased,
> +					 * it is equal to urb->actual_length
> +					 * only at the beginning.
> +					 */
> +
> +					/*
> +					 * Status report.
> +					 * It should be a standalone package in
> +					 * one URB
> +					 */
> +					data += sizeof(struct nct_packet_header);
> +					actual_len -= sizeof(struct nct_packet_header);
> +
> +					nps = (struct nct_port_status *)data;
> +
> +					for (j = 0; j < actual_len - 4; j++) {
> +						nct_update_status(serial, (unsigned char *)nps);
> +						nps++;
> +					}

This doesn't look right; j is an index, but nps is a pointer incremented
in steps of four bytes. Seems like you will read beyond the buffer.

Either way this needs to be cleaned up, for example, using appropriate
helper functions. Six levels of indentation (like line lengths well above
80) is an indication that some kind of refactoring is warranted.

> +
> +					spin_unlock_irqrestore(&serial_priv->serial_lock, flags);
> +					return;
> +				}
> +			}
> +
> +			if (hdr->magic == NCT_HDR_MAGIC &&
> +			    hdr->magic2 == NCT_HDR_MAGIC2 &&
> +			    nct_get_hdr_idx(hdr) <= NCT_MAX_NUM_COM_DEVICES &&
> +			    nct_get_hdr_len(hdr) <= 512)
> +				break;
> +
> +			data++;
> +			actual_len--;
> +			if (!actual_len) {
> +				dev_err(&intf->dev, "%s: Decode serial packet size failed.\n",
> +					__func__);
> +				spin_unlock_irqrestore(&serial_priv->serial_lock, flags);
> +				return;
> +			}
> +		}
> +		/*
> +		 * Search tty port
> +		 * Search the tty device by the idx in header, and check if
> +		 * it is registered or opened.
> +		 * If it is, record them. The record will be used later for
> +		 * 2 purposes:
> +		 *   (1) If the current data package is incomplete, the following
> +		 *       incoming data will not include a header.
> +		 *   (2) To determine which device will be used for transmission.
> +		 */
> +		tport = NULL;
> +		for (i = 0; i < serial->type->num_ports; i++) {
> +			port = serial->port[i];
> +			tport = usb_get_serial_port_data(port);
> +			if (tport->hw_idx != nct_get_hdr_idx(hdr))
> +				continue;
> +
> +			break;
> +		}

Could also use that lookup table.

> +		if (!tport) {
> +			dev_err(&intf->dev, "%s: Decode serial packet index failed.\n",	__func__);
> +			spin_unlock_irqrestore(&serial_priv->serial_lock, flags);
> +			return;
> +		}
> +		/*
> +		 * Calculate the data length.
> +		 * Then, check if the length specified in the header matches
> +		 * the data length. If not, it indicates that the data we
> +		 * received spans across two (or more) packets.
> +		 */
> +		actual_len -= sizeof(struct nct_packet_header);
> +		data += sizeof(struct nct_packet_header);
> +		/* actual_len: the data length of the data we got this time */
> +		if (nct_get_hdr_len(hdr) > actual_len) {
> +			/*
> +			 * It means the length specified in the header (the
> +			 * custom header) is greater than the length of the
> +			 * data we received.
> +			 * Therefore, the data we received this time does not
> +			 * span across another packet (i.e. no new header).
> +			 */
> +			len = actual_len;
> +			/*
> +			 * cur_len: Record how many data does not handle yet
> +			 */
> +			serial_priv->cur_len = nct_get_hdr_len(hdr) - len;
> +			/*
> +			 * Record the current port. When we got remained data of
> +			 * the package next time
> +			 */
> +			serial_priv->cur_port = tport;
> +		} else {
> +			/*
> +			 * The data we got crosses packages(not belong
> +			 * to the same header). We only handle data by
> +			 * the length in header. And we will handle
> +			 * another package when 'goto "again" '.
> +			 */
> +			len = nct_get_hdr_len(hdr);
> +		}
> +	} else { /*  Handling the remained data which crosses package */
> +		if (serial_priv->cur_len > actual_len) {
> +			/*
> +			 * The unhandled part of the data exceeds the data we
> +			 * received this time. We only handle the data we
> +			 * have, expecting more data to be received later.
> +			 */
> +			len = actual_len;
> +		} else {
> +			/*
> +			 * This means the package has been fully handled.
> +			 * Clear 'cur_port' as no additional data needs to be
> +			 * attached to the current package.
> +			 */
> +			len = serial_priv->cur_len;
> +			serial_priv->cur_port = NULL;
> +		}
> +		serial_priv->cur_len -= len;
> +	}
> +	spin_unlock_irqrestore(&serial_priv->serial_lock, flags);
> +	/*
> +	 * The per-character sysrq handling is too slow for fast devices,
> +	 * so we bypass it in the vast majority of cases where the USB serial is
> +	 * not a console.
> +	 */
> +	if (tport->sysrq) {
> +		for (i = 0; i < len; i++, data++)
> +			tty_insert_flip_char(&port->port, *data, TTY_NORMAL);

This doesn't look right at all. I guess you never tested sysrq support
so probably better to just drop it for now.

> +	} else {
> +		tty_insert_flip_string(&port->port, data, len);
> +		data += len;
> +	}
> +	/*
> +	 * Send data to the tty device (according to the port identified above).
> +	 */
> +	tty_flip_buffer_push(&port->port);
> +	actual_len -= len;
> +
> +	/*
> +	 * It means that the data we received this time contains two or
> +	 * more data packages, so it needs to continue processing the next
> +	 * data packages.
> +	 */
> +	if (actual_len > 0)
> +		goto again;
> +}

Wow. That's quite a function. Please try to make this more readable
somehow.

> +
> +static void nct_process_read_bulk(struct urb *urb)
> +{
> +	struct usb_serial_port *port =  urb->context;
> +	bool stopped = false;
> +	int status = urb->status;
> +	int ret;
> +
> +	switch (status) {
> +	case 0:
> +		nct_usb_serial_read(urb);
> +		break;
> +	case -ENOENT:
> +	case -ECONNRESET:
> +	case -ESHUTDOWN:
> +		dev_dbg(&port->dev, "urb stopped: %d\n", status);
> +		stopped = true;
> +		break;
> +	case -EPIPE:
> +		dev_dbg(&port->dev, "urb stopped: %d\n", status);

dev_err() like the generic implementation?

> +		stopped = true;
> +		break;
> +	case -ETIME:
> +		dev_dbg(&port->dev, "urb ETIME t: %d\n", status);

ETIME t?

> +		break;
> +	case -ETIMEDOUT:
> +		dev_dbg(&port->dev, "urb ETIMEDOUT t: %d\n", status);

Same here.

But why do you need to handle these two separately? It's all logged by
the default clause anyway.

> +		break;
> +	default:
> +		dev_dbg(&port->dev, "nonzero urb status: %d\n", status);
> +		break;
> +	}
> +
> +	if (stopped)
> +		return;
> +
> +	ret = usb_submit_urb(urb, GFP_ATOMIC);
> +	if (ret != 0 && ret != -EPERM)
> +		dev_err(&port->dev, "%s: failed resubmitting urb, ret=%d\n", __func__, ret);
> +}
> +
> +static void nct_read_bulk_callback(struct urb *urb)
> +{
> +	struct usb_serial_port *port = urb->context;
> +	struct nct_serial *serial_priv;
> +
> +	/* Port sanity check, do not resubmit if port is not valid */
> +	if (urb->status == -ESHUTDOWN)
> +		return;

One check for -ESHUTDOWN should be enough.

> +
> +	if (!port) {
> +		pr_err("%s: port or serial is NULL, status=%d\n", __func__, urb->status);
> +		return;
> +	}
> +
> +	if (!port->serial) {
> +		dev_err(&port->dev, "%s: serial is NULL, status=%d\n", __func__, urb->status);
> +		return;
> +	}

Again, the above can't happen.

> +
> +	if (port->serial->disconnected)
> +		return;

This should not be needed either, at least if you use the bulk urbs
allocated by core.

> +
> +	serial_priv = usb_get_serial_port_data(port);
> +	if (!serial_priv) {
> +		dev_err(&port->dev, "%s: port->private is NULL, status=%d\n",
> +			__func__, urb->status);
> +		return;
> +	}

How can this happen?

> +
> +	if (!port->serial) {
> +		dev_err(&port->dev, "%s: serial is NULL, status=%d\n", __func__, urb->status);
> +		return;
> +	}

Why check again?

> +
> +	serial_priv = usb_get_serial_data(port->serial);
> +	if (!serial_priv) {
> +		dev_err(&port->dev,
> +			"%s: serial->private is NULL, status=%d\n",
> +			__func__, urb->status);
> +		return;
> +	}

How can this happen?

> +
> +	/* Processing data */
> +	nct_process_read_bulk(urb);
> +}
> +
> +static int nct_calc_num_ports(struct usb_serial *serial,
> +			      struct usb_serial_endpoints *epds)
> +{
> +	struct nct_vendor_cmd cmd;
> +	u8 buf[8];
> +	struct nct_serial *serial_priv = usb_get_serial_data(serial);
> +	struct usb_interface *intf = serial->interface;
> +	int ret;
> +	int i;
> +	int num_ports;
> +
> +	//Send init command

No c99 comments please.

> +	cmd.val = nct_build_cmd(NCT_VCOM_SET_INIT, NCT_VCOM_INDEX_GLOBAL);
> +	ret = nct_vendor_write(intf, cmd, 0);
> +	if (ret) {
> +		dev_err(&intf->dev, "%s - Set COM init error\n", __func__);
> +		return ret;
> +	}
> +
> +	/* Get ports' index supported by the device(/FW) */
> +	cmd.val = nct_build_cmd(NCT_VCOM_GET_PORTS_SUPPORT, NCT_VCOM_INDEX_GLOBAL);
> +	ret = nct_vendor_read(intf, cmd, buf, 1);
> +	if (ret != 1) {
> +		dev_err(&intf->dev, "%s - Get COM port index error\n", __func__);
> +		return 0;
> +	}
> +	serial_priv->en_device_mask = buf[0];
> +	serial_priv->last_assigned_hw_idx = 0; /* Note: hw_idx is based on 1 */
> +	dev_dbg(&intf->dev, "Enabled devices mask:%X\n", buf[0]);

nit: space after :

> +
> +	for (i = 0, num_ports = 0; i < NCT_MAX_NUM_COM_DEVICES; i++) {
> +		if ((buf[0] & (1 << i)) == 0)

BIT(i) may be more readable.

> +			continue;	/* The port is disabled */
> +
> +		num_ports++;
> +	}
> +
> +	return num_ports;
> +}
> +
> +static int nct_probe(struct usb_serial *serial, const struct usb_device_id *id)
> +{
> +	struct nct_serial *serial_priv;
> +	int i;
> +	struct usb_endpoint_descriptor *endpoint;
> +	struct usb_interface *intf = serial->interface;
> +	struct usb_host_interface *iface_desc;
> +
> +	serial_priv = kzalloc(sizeof(*serial_priv), GFP_KERNEL);

probe() is not supposed to allocate memory, do so in attach() which is
paired with release().

I think we have one or two drivers using devres when they really need
some memory this early but that should generally not be needed.

> +	if (!serial_priv)
> +		return -ENOMEM;
> +
> +	spin_lock_init(&serial_priv->serial_lock);
> +	usb_set_serial_data(serial, serial_priv);
> +
> +	iface_desc = intf->cur_altsetting;
> +
> +	/* For bulk-out */
> +	for (i = 0; i < iface_desc->desc.bNumEndpoints; i++) {
> +		endpoint = &iface_desc->endpoint[i].desc;
> +		if (usb_endpoint_is_bulk_out(endpoint)) {
> +			serial_priv->bulk_out_ep = endpoint;
> +			break;
> +		}
> +	}

And by the time attach() is called, core has already done this for you
and set up the bulk urbs for port 0.

> +	/*
> +	 * Initialize the mode as 'Status data is transmitted via
> +	 * bulk-in pipe'.
> +	 */
> +	serial_priv->status_trans_mode = true;
> +	serial->type->num_interrupt_in = 0;

You should not be overriding the type data here.

> +	for (i = 0; i < iface_desc->desc.bNumEndpoints; i++) {
> +		endpoint = &iface_desc->endpoint[i].desc;
> +
> +		if (usb_endpoint_is_int_in(endpoint)) {
> +			/* Status data is transmitted via interrupt-in pipe. */
> +			serial_priv->status_trans_mode = false;
> +			serial->type->num_interrupt_in = 1;

Or here.

> +			break;
> +		}
> +	}

And similar for the interrupt-in endpoint.

> +
> +	return 0;
> +}
> +
> +static int nct_port_init(struct usb_serial_port *port, unsigned int port_num)
> +{
> +	struct nct_tty_port *tport;
> +	struct usb_serial *serial = port->serial;
> +	struct nct_serial *serial_priv = usb_get_serial_data(serial);
> +	unsigned long flags;
> +	int i;
> +
> +	tport = kzalloc(sizeof(*tport), GFP_KERNEL);
> +	if (!tport)
> +		return -ENOMEM;
> +
> +	/* Assigned the hw_idx */
> +	spin_lock_init(&tport->port_lock);
> +
> +	spin_lock_irqsave(&tport->port_lock, flags);
> +	for (i = serial_priv->last_assigned_hw_idx + 1; i < NCT_MAX_NUM_COM_DEVICES; i++) {
> +		if ((serial_priv->en_device_mask & (1 << i)) == 0)
> +			continue;	/* The port is disabled */
> +
> +		tport->hw_idx = i;
> +		serial_priv->last_assigned_hw_idx = i;
> +		break;
> +	}
> +	spin_unlock_irqrestore(&tport->port_lock, flags);
> +
> +	usb_set_serial_port_data(port, tport);
> +
> +	return 0;
> +}
> +
> +static void nct_interrupt_in_callback(struct urb *urb)
> +{
> +	struct usb_serial_port *port = urb->context;
> +	int status = urb->status;
> +	struct usb_serial *serial = port->serial;
> +

Stray newline.

> +	unsigned char *data = urb->transfer_buffer;
> +	int retval;
> +	int i;
> +	int actual_len = urb->actual_length;
> +	struct nct_port_status *nps;
> +
> +	switch (status) {
> +	case 0:
> +		/* Success */
> +		if ((actual_len % 4) != 0)

Please use sizeof(*nps) instead of constant 4.

> +			return;
> +
> +		nps = (struct nct_port_status *)data;
> +
> +		for (i = 0; i < (actual_len / 4); i++) {
> +			nct_update_status(serial, (unsigned char *)nps);
> +			nps++;
> +		}

This too looks broken since i is a byte index and nps a pointer.

> +		break;
> +
> +	case -ECONNRESET:
> +	case -ENOENT:
> +	case -ESHUTDOWN:
> +		/* This urb is terminated, clean up */
> +		return;
> +	default:
> +		break;
> +	}
> +	retval = usb_submit_urb(urb, GFP_ATOMIC);
> +	if (retval)
> +		dev_err(&port->dev, "%s: Submit intr URB failed, ret=%d\n", __func__, retval);
> +}
> +
> +static void nct_disconnect(struct usb_serial *serial)
> +{
> +	int i;
> +	struct nct_serial *serial_priv = usb_get_serial_data(serial);
> +	unsigned long flags;
> +
> +	/* Reset status */
> +	spin_lock_irqsave(&serial_priv->serial_lock, flags);
> +	serial_priv->device_init = false;
> +	serial_priv->cur_port = NULL;
> +	serial_priv->cur_len = 0;
> +	spin_unlock_irqrestore(&serial_priv->serial_lock, flags);
> +
> +	/* Stop reads and writes on all ports */
> +	for (i = 0; i < serial->type->num_ports; i++) {
> +		if (!serial->port[i])
> +			continue;

How can port[i] be NULL?

> +		usb_kill_urb(serial->port[i]->read_urb);

But you've only (allocated and) submitted a read urb for port 0 so no
need to iterate over all ports for that.

> +		usb_kill_urb(serial->port[i]->write_urb);

> +	}
> +	if (!serial_priv->status_trans_mode)
> +		if (serial->port[0] && serial->port[0]->interrupt_in_urb)

You only need one check here; either status_trans_mode or
serial->port[0]->interrupt_in_urb.

> +			usb_kill_urb(serial->port[0]->interrupt_in_urb);
> +}
> +
> +static int nct_port_probe(struct usb_serial_port *port)
> +{
> +	return nct_port_init(port, port->port_number);

Just fold the init function in here.

> +}
> +
> +static void nct_port_remove(struct usb_serial_port *port)
> +{
> +	struct nct_tty_port *priv;
> +
> +	priv = usb_get_serial_port_data(port);

I would declare and initialise on one line here.

> +	kfree(priv);
> +}
> +
> +static void nct_release(struct usb_serial *serial)
> +{
> +	struct nct_serial *serial_priv;
> +
> +	serial_priv = usb_get_serial_data(serial);

Ditto.

> +	kfree(serial_priv);
> +}
> +
> +static int nct_suspend(struct usb_serial *serial, pm_message_t message)
> +{
> +	struct nct_serial *serial_priv = usb_get_serial_data(serial);
> +	int i;
> +
> +	/* Stop all URBs */
> +	for (i = 0; i < serial->type->num_ports; i++) {
> +		if (serial->port[i]) {

How can port[i] be NULL?

> +			usb_kill_urb(serial->port[i]->read_urb);

You've at most submitted a read urb for port 0.

> +			usb_kill_urb(serial->port[i]->write_urb);
> +		}
> +	}
> +
> +	if (!serial_priv->status_trans_mode)
> +		if (serial->port[0] && serial->port[0]->interrupt_in_urb)
> +			usb_kill_urb(serial->port[0]->interrupt_in_urb);

Same comment as for disconnect().

> +
> +	return 0;
> +}
> +
> +static int nct_resume(struct usb_serial *serial)
> +{
> +	struct nct_serial *serial_priv = usb_get_serial_data(serial);
> +	struct usb_interface *intf = serial->interface;
> +	struct usb_host_interface *iface_desc;
> +	struct usb_endpoint_descriptor *endpoint;
> +	unsigned long flags;
> +	int i, ret = 0;

No need to initialise ret.

> +
> +	/* Reacquire endpoint descriptors */
> +	iface_desc = intf->cur_altsetting;
> +	for (i = 0; i < iface_desc->desc.bNumEndpoints; i++) {
> +		endpoint = &iface_desc->endpoint[i].desc;
> +		if (usb_endpoint_is_bulk_out(endpoint)) {
> +			serial_priv->bulk_out_ep = endpoint;
> +			break;
> +		}
> +	}

This should not be needed.

> +
> +	/* Reset driver internal state */
> +	spin_lock_irqsave(&serial_priv->serial_lock, flags);
> +	serial_priv->cur_port = NULL;
> +	serial_priv->cur_len = 0;
> +	spin_unlock_irqrestore(&serial_priv->serial_lock, flags);
> +
> +	/* Resubmit URBs */
> +	if (serial->port[0] && serial->port[0]->read_urb) {

How can either be NULL?

> +		ret = usb_submit_urb(serial->port[0]->read_urb, GFP_KERNEL);
> +		if (ret)
> +			dev_err(&intf->dev, "%s: Submit read URB failed, ret=%d\n",
> +				__func__, ret);
> +	}
> +
> +	if (!serial_priv->status_trans_mode) {
> +		if (serial->port[0] && serial->port[0]->interrupt_in_urb) {

Only one check needed (as above).

> +			ret = usb_submit_urb(serial->port[0]->interrupt_in_urb, GFP_KERNEL);
> +			if (ret)
> +				dev_err(&intf->dev, "%s: Submit interrupt URB failed, ret=%d\n",
> +					__func__, ret);
> +		}
> +	}
> +
> +	/* Restore status flags */
> +	spin_lock_irqsave(&serial_priv->serial_lock, flags);
> +	serial_priv->device_init = true;  /* Reset initialization flag */
> +	spin_unlock_irqrestore(&serial_priv->serial_lock, flags);

The urbs should only be submitted when you have at least one port open.

> +
> +	return 0;
> +}
> +
> +static struct usb_serial_driver nct_usb_serial_device = {
> +	.driver	= {
> +		.name =		NCT_DRVNAME,
> +	},
> +	.description =		"Nuvoton USB to serial adapter",
> +	.id_table =		id_table,
> +	.num_ports =		6,

You calculate the numbers of ports so this should not be needed.

> +	.num_bulk_in =		1,
> +	.num_bulk_out =		1,
> +	.open =			nct_open,
> +	.close =		nct_close,
> +	.write =		nct_serial_write,
> +	.write_room =		nct_write_room,
> +	.write_bulk_callback =	nct_write_bulk_callback,
> +	.read_bulk_callback =	nct_read_bulk_callback,
> +	.read_int_callback =	nct_interrupt_in_callback,
> +	.chars_in_buffer =	nct_chars_in_buffer,
> +	.throttle =		nct_rx_throttle,
> +	.unthrottle =		nct_rx_unthrottle,
> +	.probe =		nct_probe,
> +	.calc_num_ports =	nct_calc_num_ports,
> +	.set_termios =		nct_serial_set_termios,
> +	.break_ctl =		nct_serial_break,
> +	.tiocmget =		nct_serial_tiocmget,
> +	.tiocmset =		nct_tiocmset_helper,
> +	.disconnect =		nct_disconnect,
> +	.release =		nct_release,
> +	.port_probe =		nct_port_probe,
> +	.port_remove =		nct_port_remove,
> +	.suspend =		nct_suspend,
> +	.resume =		nct_resume,
> +};

How about dropping the "_serial" infixes above and just have a common
"nct_" prefix throughout?

> +
> +static struct usb_serial_driver * const nct_serial_drivers[] = {
> +	&nct_usb_serial_device, NULL
> +};
> +
> +module_usb_serial_driver(nct_serial_drivers, id_table);
> +MODULE_DESCRIPTION("Nuvoton USB to serial adaptor driver");
> +MODULE_AUTHOR("Sheng-Yuan Huang <syhuang3@nuvoton.com>");
> +MODULE_LICENSE("GPL v2");

Overall this looks pretty good, but I think you should try to reuse the
generic implementation (e.g. like mxuport does) as it should address
some of the issues while simplifying the driver.

Johan

