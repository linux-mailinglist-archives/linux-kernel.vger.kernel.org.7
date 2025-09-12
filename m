Return-Path: <linux-kernel+bounces-813302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC5C6B54353
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 08:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95B5116C057
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 06:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77F328A3F2;
	Fri, 12 Sep 2025 06:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8n3I0oX"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4E12874F2
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 06:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757659958; cv=none; b=F1w0UY+eFsOVAnrA8YHvWzgnwA6Gi4ndUp3TnBDICX3Z0zQkD2suBEnRe/itHWRyyN+0bI2+2wnZiv2bn50rwkOCex7dCB7aPqoFgiRYraJgcOtDVxjObLiCFhVrsKSo0ywAM7Ff9mdsfpoye05JSxvo9GtOI/zTEGzlOUUzxnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757659958; c=relaxed/simple;
	bh=rdF4qYwMqIose4f1HE14LuIH2MhhbN0VjG6AyeqEsHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5O2FyVbQ4w8KcHnUgxEBC9Q7ZWcvsmPW4VTuYCVb3UJkBH7sDPzlvlWwWt7A7qqDPdE0I09UjWyrpQ17wqVR4K9/Q8uSKFac3/mmzCbPFF2kVkurICB3dSaMMspOHjHQiv/VRMPtv5GKVH68B84cn4yAPbW8KcSOal6Ou/YpRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i8n3I0oX; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-772301f8a4cso2169022b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Sep 2025 23:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757659954; x=1758264754; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1ePPiV8bvL2iHUV+FRtnZ0jGs7poFL8Fa/0uP04Yxvs=;
        b=i8n3I0oXrhmL06g5MtRI+1hGcKJSxwlYFVDgYHewNIs331nDxBulJEJH5NFOPBEoNY
         n6UT89mfDZOrYOzdhPjQBhzqZH8gusKXegUzRxpEhPVOdE3L/Cw70XqMx74egidhywJz
         sfke00jKEIkQ6MBUPLwSCNDRsORSi0Y2DRifdx7Llo7cTI4TYRFAGYeQcwRNUAIazo7d
         7bl3L9255fvYnqNRE+bbwpQx9X+LZBoLARuFl21MNkIbLpZlrNomS96tmZjvWM6fPtyU
         rr9EH0r/iuQwUruqQZ7y9bbukj3/5UDDYR/LMQtmksA35JO2wXOf9C3yQLU0qPVZhwdd
         8ijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757659954; x=1758264754;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1ePPiV8bvL2iHUV+FRtnZ0jGs7poFL8Fa/0uP04Yxvs=;
        b=qUu6z5Twane2ghuxenSlihbu12t8mm/bKf/Pguxj7u8PLuNC/g5dQn9vfuw9WkuXPN
         yE06iWEX54RauslMlcpaWrq6Py/pun36dZfc/vRrlWnkwC7eRFEk1LRX3vvXqlIYvSDn
         nP1vBo+V2yKz0h7cOfK05c29/lKYpfAPgDQac9o3w3VYHMeN+5ST95y+3GdJJwEtal2W
         zaO9Nq8dUIL5r/LWuhU7RSzWNf7KEuYZReNhOa2LEbS79XW6bJ5UaUnrkZqKT3BhAokH
         LnQQzpwaVHg5wX36/AoPJCuUlmTDqBBJjs6C0Ec3bDS1fyVrZx/56jmFxAkzejQs/KIO
         bBfw==
X-Forwarded-Encrypted: i=1; AJvYcCWkcdJMG05n5al2X8NaoFzJsH1bTtPiUsgHOdmfsrwTOewpVfaqEexmKs2B61+dR2sKDi/+rtcsKfJyZ/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1mtIjyHzDk78lL//Gz/JZtnKayyYJl2Sc9VJPAZuun3YMbgCc
	F2615giqb+5IhZXmxCNoDwzBNlJZWgiOvL9aJHrJkX2s6FNVwiMtNI7O
X-Gm-Gg: ASbGncvK5g3mSVbrvSNx/2WtIperXUzsEMRaKgvK8g6TlSUyQ/PfWD3mKKa6lznLmRl
	YbMwUfYaBFFubO11Xh196pVtDCdz7iG1VpQLkXUkSyOFEjll5w58fnW3UhQl5F+Ic4SJ9CZKY6V
	heY4iZClZyssJCYVv4g/kGidmfQSmtW5rcYx6WRcTfODml5b7VqegFvk5dt5lOOfOOJoMHvbh40
	S/kvB6JZD11kVrog9MHGC5kkp6BaRnQdupKIaoZepMzIaXfP8GIiEj6eMLGTWMi4F7YAqBl1H6g
	OIy8sjfcfFFtja8CmmCWSWE00gE4UyjyRQXK5wOPg6mR+1nrnBs1aNg4F+ECdKoLhvrzJuZ+eKW
	y3JGbWYpDbdE0rzSir40TQJPWoY/yAQg+XK5AZXhYNDC3sthPGfO5QmBPK9sKr7+8kGbUy+0=
X-Google-Smtp-Source: AGHT+IFcXZcrHK2ejivs/9/0uHiBiVOKUNatwcWoDTBIWQHqCZ8C21+Pp3G48WKqNHBbyfw1/ML5nw==
X-Received: by 2002:a05:6a21:e097:b0:24d:56d5:3693 with SMTP id adf61e73a8af0-26029eaa50emr2176234637.9.1757659954078;
        Thu, 11 Sep 2025 23:52:34 -0700 (PDT)
Received: from visitorckw-System-Product-Name ([140.113.216.168])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b54a36dc461sm3677195a12.23.2025.09.11.23.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 23:52:33 -0700 (PDT)
Date: Fri, 12 Sep 2025 14:52:30 +0800
From: Kuan-Wei Chiu <visitorckw@gmail.com>
To: Dawid Niedzwiecki <dawidn@google.com>
Cc: Tzung-Bi Shih <tzungbi@kernel.org>, Benson Leung <bleung@chromium.org>,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	chromeos-krk-upstreaming@google.com,
	=?utf-8?Q?=C5=81ukasz?= Bartosik <ukaszb@chromium.org>
Subject: Re: [PATCH v5] platform/chrome: Add ChromeOS EC USB driver
Message-ID: <aMPDLn05CwwEX9EI@visitorckw-System-Product-Name>
References: <20250912052919.229757-1-dawidn@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250912052919.229757-1-dawidn@google.com>

Hi Dawid,

On Fri, Sep 12, 2025 at 05:29:19AM +0000, Dawid Niedzwiecki wrote:
> Use USB to talk to the ChromeOS EC. The protocol is defined by the EC
> and is fairly simple, with a length byte, checksum, command byte and
> version byte in the header.
> 
> Use vendor defined usb interface with in/out endpoints to transfer
> requests and responses. Also use one interrupt in endpoint which signals
> readiness of response and pending events on the EC side.
> 
> Signed-off-by: Dawid Niedzwiecki <dawidn@google.com>
> ---
> V4 -> V5:
> - Fix typo OCCURED -> OCCURRED

I'm not a ChromeOS expert, but I noticed the following build failure:

drivers/platform/chrome/cros_ec_usb.c: In function ‘cros_ec_int_callback’:
drivers/platform/chrome/cros_ec_usb.c:163:22: error: ‘INT_TYPE_EVENT_OCCURED’ undeclared (first use in this function); did you mean ‘INT_TYPE_EVENT_OCCURRED’?
  163 |                 case INT_TYPE_EVENT_OCCURED:
      |                      ^~~~~~~~~~~~~~~~~~~~~~
      |                      INT_TYPE_EVENT_OCCURRED

Please make sure the patch at least compiles before sending it.

> 
>  drivers/platform/chrome/Kconfig       |  11 +
>  drivers/platform/chrome/Makefile      |   1 +
>  drivers/platform/chrome/cros_ec_usb.c | 586 ++++++++++++++++++++++++++
>  3 files changed, 598 insertions(+)
>  create mode 100644 drivers/platform/chrome/cros_ec_usb.c
> 
> diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
> index 2281d6dacc9b..e77f06f13fc4 100644
> --- a/drivers/platform/chrome/Kconfig
> +++ b/drivers/platform/chrome/Kconfig
> @@ -316,6 +316,17 @@ config CROS_TYPEC_SWITCH
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called cros_typec_switch.
>  
> +config CROS_EC_USB
> +	tristate "ChromeOS Embedded Controller (USB)"
> +	depends on CROS_EC && USB
> +	help
> +	  If you say Y here, you get support for talking to the ChromeOS EC
> +	  through a USB. The driver uses vendor defined interface and is capable
> +	  of signaling events from EC.
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called cros_ec_usb.
> +
>  source "drivers/platform/chrome/wilco_ec/Kconfig"
>  
>  # Kunit test cases
> diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
> index b981a1bb5bd8..444383e8912d 100644
> --- a/drivers/platform/chrome/Makefile
> +++ b/drivers/platform/chrome/Makefile
> @@ -38,6 +38,7 @@ obj-$(CONFIG_CROS_EC_SYSFS)		+= cros_ec_sysfs.o
>  obj-$(CONFIG_CROS_HPS_I2C)		+= cros_hps_i2c.o
>  obj-$(CONFIG_CROS_USBPD_LOGGER)		+= cros_usbpd_logger.o
>  obj-$(CONFIG_CROS_USBPD_NOTIFY)		+= cros_usbpd_notify.o
> +obj-$(CONFIG_CROS_EC_USB)		+= cros_ec_usb.o
>  
>  obj-$(CONFIG_WILCO_EC)			+= wilco_ec/
>  
> diff --git a/drivers/platform/chrome/cros_ec_usb.c b/drivers/platform/chrome/cros_ec_usb.c
> new file mode 100644
> index 000000000000..4e0370a2c3aa
> --- /dev/null
> +++ b/drivers/platform/chrome/cros_ec_usb.c
> @@ -0,0 +1,586 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * USB interface for ChromeOS Embedded Controller
> + *
> + * Copyright (C) 2025 Google LLC.
> + */
> +
> +#include <linux/errno.h>
> +#include <linux/kernel.h>
> +#include <linux/kref.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/uaccess.h>
> +#include <linux/usb.h>
> +
> +#include <linux/platform_data/cros_ec_commands.h>
> +#include <linux/platform_data/cros_ec_proto.h>
> +#include <linux/platform_device.h>
> +
> +#include "cros_ec.h"
> +
> +#define USB_VENDOR_ID_GOOGLE 0x18d1
> +
> +#define USB_SUBCLASS_GOOGLE_EC_HOST_CMD 0x5a
> +#define USB_PROTOCOL_GOOGLE_EC_HOST_CMD 0x00
> +
> +#define RESPONSE_TIMEOUT_MS 200
> +#define BULK_TRANSFER_TIMEOUT_MS 100
> +
> +enum cros_ec_usb_int_type {
> +	INT_TYPE_EVENT_OCCURRED = 0,
> +	INT_TYPE_RESPONSE_READY = 1,
> +};
> +
> +struct cros_ec_usb {
> +	/* the usb device for this device */
> +	struct usb_device *udev;
> +	/* the interface for this device */
> +	struct usb_interface *interface;
> +	/* Cros EC device structure */
> +	struct cros_ec_device *ec_dev;
> +
> +	/* the buffer to receive data from bulk ep */
> +	u8 *bulk_in_buffer;
> +	/* the buffer to receive data from int ep */
> +	u8 *int_in_buffer;
> +	/* the urb to receive data from int ep */
> +	struct urb *int_in_urb;
> +	/* the size of the receive buffer from bulk ep */
> +	size_t bulk_in_size;
> +	/* the size of the receive buffer from int ep */
> +	size_t int_in_size;
> +
> +	/* the pipe of the bulk in ep */
> +	unsigned int bulk_in_pipe;
> +	/* the pipe of the bulk out ep */
> +	unsigned int bulk_out_pipe;
> +	/* the pipe of the int in ep */
> +	unsigned int int_in_pipe;
> +	/* the interval of the int in ep */
> +	u8 int_in_interval;
> +
> +	/* Response ready on EC side */
> +	bool resp_ready;
> +	/* EC has been registered */
> +	bool registered;
> +	/* EC is disconnected */
> +	bool disconnected;
> +	/* synchronize I/O with disconnect */
> +	struct mutex io_mutex;
> +	/* Work to handle EC events */
> +	struct work_struct work_ec_evt;
> +	/* Wait queue to signal the response is ready on EC side */
> +	wait_queue_head_t resp_ready_wait;
> +};
> +
> +struct int_msg {
> +	u8 int_type;
> +} __packed;
> +
> +struct registered_ec {
> +	struct list_head node;
> +	u16 idProduct;
> +	struct cros_ec_usb *ec_usb;
> +};
> +
> +static LIST_HEAD(registered_list);
> +static DEFINE_MUTEX(registered_list_mutex);
> +
> +static int cros_ec_usb_register(u16 idProduct, struct cros_ec_usb *ec_usb)
> +{
> +	struct registered_ec *ec;
> +
> +	ec = kmalloc(sizeof(*ec), GFP_KERNEL);
> +	if (!ec)
> +		return -ENOMEM;
> +
> +	ec->ec_usb = ec_usb;
> +	ec->idProduct = idProduct;
> +	mutex_lock(&registered_list_mutex);
> +	list_add(&ec->node, &registered_list);
> +	mutex_unlock(&registered_list_mutex);
> +
> +	return 0;
> +}
> +
> +static struct cros_ec_usb *cros_ec_usb_get_registered(u16 idProduct)
> +{
> +	struct registered_ec *ec;
> +	struct cros_ec_usb *ret = NULL;
> +
> +	mutex_lock(&registered_list_mutex);
> +	list_for_each_entry(ec, &registered_list, node) {
> +		if (ec->idProduct == idProduct) {
> +			ret = ec->ec_usb;
> +			break;
> +		}
> +	}
> +	mutex_unlock(&registered_list_mutex);
> +	return ret;
> +}
> +
> +static void cros_ec_int_callback(struct urb *urb);
> +
> +static int submit_int_urb(struct cros_ec_device *ec_dev, gfp_t mem_flags)
> +{
> +	struct cros_ec_usb *ec_usb = ec_dev->priv;
> +	struct usb_device *usb_dev = interface_to_usbdev(ec_usb->interface);
> +
> +	/* Submit the INT URB. */
> +	usb_fill_int_urb(ec_usb->int_in_urb, usb_dev, ec_usb->int_in_pipe, ec_usb->int_in_buffer,
> +			 ec_usb->int_in_size, cros_ec_int_callback, ec_usb,
> +			 ec_usb->int_in_interval);
> +
> +	return usb_submit_urb(ec_usb->int_in_urb, mem_flags);
> +}
> +
> +static void cros_ec_int_callback(struct urb *urb)
> +{
> +	struct cros_ec_usb *ec_usb = urb->context;
> +	struct cros_ec_device *ec_dev = ec_usb->ec_dev;
> +	int ret;
> +
> +	switch (urb->status) {
> +	case 0:
> +		break;
> +	case -ECONNRESET:
> +	case -ENOENT:

Implicit switch case fallthrough is deprecated [1].
Please add a fallthrough; here.

[1]: https://www.kernel.org/doc/html/v6.16/process/deprecated.html#implicit-switch-case-fall-through

Regards,
Kuan-Wei

> +	case -ESHUTDOWN:
> +		/* Expected errors. */
> +		return;
> +	default:
> +		dev_dbg(ec_dev->dev, "Unexpected int urb error: %d\n", urb->status);
> +		goto resubmit;
> +	}
> +
> +	if (urb->actual_length >= sizeof(struct int_msg)) {
> +		struct int_msg *int_msg = (struct int_msg *)ec_usb->int_in_buffer;
> +		enum cros_ec_usb_int_type int_type = (enum cros_ec_usb_int_type)int_msg->int_type;
> +
> +		switch (int_type) {
> +		case INT_TYPE_EVENT_OCCURED:
> +			if (ec_usb->registered) {
> +				ec_dev->last_event_time = cros_ec_get_time_ns();
> +				schedule_work(&ec_usb->work_ec_evt);
> +			}
> +			break;
> +		case INT_TYPE_RESPONSE_READY:
> +			ec_usb->resp_ready = true;
> +			wake_up(&ec_usb->resp_ready_wait);
> +			break;
> +		default:
> +			dev_err(ec_dev->dev, "Unrecognized event: %d\n", int_type);
> +		}
> +	} else {
> +		dev_err(ec_dev->dev, "Incorrect int transfer len: %d\n", urb->actual_length);
> +	}
> +
> +resubmit:
> +	/* Resubmit the INT URB. */
> +	ret = submit_int_urb(ec_dev, GFP_ATOMIC);
> +	if (ret)
> +		dev_err(ec_dev->dev, "Failed to resumbit int urb: %d", ret);
> +}
> +
> +static int do_cros_ec_pkt_xfer_usb(struct cros_ec_device *ec_dev,
> +				   struct cros_ec_command *ec_msg)
> +{
> +	struct cros_ec_usb *ec_usb = ec_dev->priv;
> +	struct ec_host_response *host_response;
> +	int req_size, ret, actual_length, expected_resp_size, resp_size;
> +	const int header_size = sizeof(*host_response);
> +	const int max_resp_size = header_size + ec_msg->insize;
> +	const int bulk_in_size = umin(ec_usb->bulk_in_size, ec_dev->din_size);
> +	u8 sum = 0;
> +
> +	mutex_lock(&ec_usb->io_mutex);
> +	if (ec_usb->disconnected) {
> +		mutex_unlock(&ec_usb->io_mutex);
> +		ret = -ENODEV;
> +		return ret;
> +	}
> +
> +	if (max_resp_size > ec_dev->din_size) {
> +		dev_err(ec_dev->dev, "Potential response too big: %d\n", max_resp_size);
> +		ret = -EINVAL;
> +		goto exit;
> +	}
> +
> +	req_size = cros_ec_prepare_tx(ec_dev, ec_msg);
> +	if (req_size < 0) {
> +		dev_err(ec_dev->dev, "Failed to prepare msg %d\n", req_size);
> +		ret = req_size;
> +		goto exit;
> +	}
> +	dev_dbg(ec_dev->dev, "Prepared len=%d\n", req_size);
> +
> +	ec_usb->resp_ready = false;
> +	/*
> +	 * Buffers dout and din are allocated with devm_kzalloc which means it is suitable
> +	 * for DMA and we can use by usb functions.
> +	 */
> +	ret = usb_bulk_msg(ec_usb->udev, ec_usb->bulk_out_pipe, ec_dev->dout, req_size, NULL,
> +			   BULK_TRANSFER_TIMEOUT_MS);
> +	if (ret) {
> +		dev_err(ec_dev->dev, "Failed to send request: %d\n", ret);
> +		goto exit;
> +	}
> +
> +	/*
> +	 * Wait till EC signals response ready event via INT endpoint,
> +	 * before polling a response with a bulk transfer.
> +	 */
> +	if (!wait_event_timeout(ec_usb->resp_ready_wait, ec_usb->resp_ready,
> +				msecs_to_jiffies(RESPONSE_TIMEOUT_MS))) {
> +		dev_err(ec_dev->dev, "Timed out waiting for response\n");
> +		ret = -ETIMEDOUT;
> +		goto exit;
> +	}
> +
> +	/* Get first part of response that contains a header. */
> +	ret = usb_bulk_msg(ec_usb->udev, ec_usb->bulk_in_pipe, ec_dev->din, bulk_in_size,
> +			   &actual_length, BULK_TRANSFER_TIMEOUT_MS);
> +	if (ret) {
> +		dev_err(ec_dev->dev, "Failed to get response: %d\n", ret);
> +		goto exit;
> +	}
> +
> +	/* Verify number of received bytes. */
> +	if (actual_length < header_size) {
> +		dev_err(ec_dev->dev, "Received too little bytes: %d\n", actual_length);
> +		ret = -ENOSPC;
> +		goto exit;
> +	}
> +
> +	host_response = (struct ec_host_response *)ec_dev->din;
> +	if (host_response->struct_version != 3 || host_response->reserved != 0) {
> +		dev_err(ec_dev->dev, "Received invalid header\n");
> +		ret = -ENOSPC;
> +		goto exit;
> +	}
> +
> +	expected_resp_size = header_size + host_response->data_len;
> +	if (expected_resp_size > max_resp_size || actual_length > expected_resp_size) {
> +		dev_err(ec_dev->dev, "Incorrect number of expected bytes: %d\n",
> +			expected_resp_size);
> +		ret = -ENOSPC;
> +		goto exit;
> +	}
> +
> +	/* Get the rest of the response if needed. */
> +	resp_size = actual_length;
> +	if (resp_size < expected_resp_size) {
> +		ret = usb_bulk_msg(ec_usb->udev, ec_usb->bulk_in_pipe, ec_dev->din + resp_size,
> +				   expected_resp_size - resp_size, &actual_length,
> +				   BULK_TRANSFER_TIMEOUT_MS);
> +		if (ret) {
> +			dev_err(ec_dev->dev, "Failed to get second part of response: %d\n", ret);
> +			goto exit;
> +		}
> +		resp_size += actual_length;
> +	}
> +
> +	/* Check if number of received of bytes is correct. */
> +	if (resp_size != expected_resp_size) {
> +		dev_err(ec_dev->dev, "Received incorrect number of bytes: %d, expected: %d\n",
> +			resp_size, expected_resp_size);
> +		ret = -ENOSPC;
> +		goto exit;
> +	}
> +
> +	/* Validate checksum */
> +	for (int i = 0; i < expected_resp_size; i++)
> +		sum += ec_dev->din[i];
> +
> +	if (sum) {
> +		dev_err(ec_dev->dev, "Bad packet checksum calculated %x\n", sum);
> +		ret = -EBADMSG;
> +		goto exit;
> +	}
> +
> +	ec_msg->result = host_response->result;
> +	memcpy(ec_msg->data, ec_dev->din + header_size, host_response->data_len);
> +	ret = host_response->data_len;
> +
> +	if (ec_msg->command == EC_CMD_REBOOT_EC)
> +		msleep(EC_REBOOT_DELAY_MS);
> +
> +exit:
> +	mutex_unlock(&ec_usb->io_mutex);
> +	if (ret < 0) {
> +		/* Try to reset EC in case of error to restore default state. */
> +		usb_reset_device(ec_usb->udev);
> +	}
> +
> +	return ret;
> +}
> +
> +static void usb_evt_handler(struct work_struct *work)
> +{
> +	struct cros_ec_usb *ec_usb = container_of(work, struct cros_ec_usb, work_ec_evt);
> +
> +	cros_ec_irq_thread(0, ec_usb->ec_dev);
> +}
> +
> +static void cros_ec_usb_delete(struct cros_ec_usb *ec_usb)
> +{
> +	usb_kill_urb(ec_usb->int_in_urb);
> +	cancel_work_sync(&ec_usb->work_ec_evt);
> +
> +	usb_free_urb(ec_usb->int_in_urb);
> +	usb_put_intf(ec_usb->interface);
> +	usb_put_dev(ec_usb->udev);
> +	kfree(ec_usb->int_in_buffer);
> +	kfree(ec_usb->bulk_in_buffer);
> +}
> +
> +static int cros_ec_usb_probe(struct usb_interface *intf, const struct usb_device_id *id)
> +{
> +	struct usb_device *usb_dev = interface_to_usbdev(intf);
> +	struct usb_endpoint_descriptor *bulk_in, *bulk_out, *int_in;
> +	struct device *if_dev = &intf->dev;
> +	struct cros_ec_device *ec_dev;
> +	const u16 idProduct = le16_to_cpu(usb_dev->descriptor.idProduct);
> +	struct cros_ec_usb *ec_usb = cros_ec_usb_get_registered(idProduct);
> +	const bool is_registered = !!ec_usb;
> +	int ret;
> +
> +	/*
> +	 * Do not register the same EC device twice. The probing is performed every reboot, sysjump,
> +	 * crash etc. Recreating the /dev/cros_X file every time would force all application to
> +	 * reopen the file, which is not a case for other cros_ec_x divers. Instead, keep
> +	 * the cros_ec_device and cros_ec_usb structures constant and replace USB related structures
> +	 * for the same EC that is reprobed.
> +	 *
> +	 * The driver doesn't support handling two devices with the same idProduct, but it will
> +	 * never be a real usecase.
> +	 */
> +	if (!is_registered) {
> +		ec_usb = kzalloc(sizeof(*ec_usb), GFP_KERNEL);
> +		if (!ec_usb)
> +			return -ENOMEM;
> +
> +		ec_dev = kzalloc(sizeof(*ec_dev), GFP_KERNEL);
> +		if (!ec_dev) {
> +			kfree(ec_usb);
> +			return -ENOMEM;
> +		}
> +
> +		ec_usb->ec_dev = ec_dev;
> +		INIT_WORK(&ec_usb->work_ec_evt, usb_evt_handler);
> +		mutex_init(&ec_usb->io_mutex);
> +		init_waitqueue_head(&ec_usb->resp_ready_wait);
> +
> +		ec_dev->priv = ec_usb;
> +		/* EC uses int endpoint to signal events. */
> +		ec_dev->irq = 0;
> +		ec_dev->cmd_xfer = NULL;
> +		ec_dev->pkt_xfer = do_cros_ec_pkt_xfer_usb;
> +		ec_dev->din_size = sizeof(struct ec_host_response) +
> +				   sizeof(struct ec_response_get_protocol_info);
> +		ec_dev->dout_size = sizeof(struct ec_host_request) +
> +				    sizeof(struct ec_params_rwsig_action);
> +	} else {
> +		ec_dev = ec_usb->ec_dev;
> +
> +		/*
> +		 * We need to allocate dout and din buffers, because cros_ec_register
> +		 * won't be called. These buffers were freed once previous usb device was
> +		 * disconnected. Use buffer sizes from the last query.
> +		 * The EC_HOST_EVENT_INTERFACE_READY event will be triggered at the end
> +		 * of a boot, which calls cros_ec_query_all function, that reallocates
> +		 * buffers.
> +		 */
> +		ec_dev->din = devm_kzalloc(if_dev, ec_dev->din_size, GFP_KERNEL);
> +		if (!ec_dev->din) {
> +			ret = -ENOMEM;
> +			dev_err(if_dev, "Failed to allocate din buffer\n");
> +			goto error;
> +		}
> +		ec_dev->dout = devm_kzalloc(if_dev, ec_dev->dout_size, GFP_KERNEL);
> +		if (!ec_dev->dout) {
> +			ret = -ENOMEM;
> +			dev_err(if_dev, "Failed to allocate dout buffer\n");
> +			goto error;
> +		}
> +	}
> +
> +	ec_dev->dev = if_dev;
> +	ec_dev->phys_name = dev_name(if_dev);
> +	usb_set_intfdata(intf, ec_dev);
> +	/* Allow EC to do remote wake-up - host sends SET_FEATURE(remote wake-up) before suspend. */
> +	device_init_wakeup(&usb_dev->dev, true);
> +
> +	ec_usb->udev = usb_get_dev(usb_dev);
> +	ec_usb->interface = usb_get_intf(intf);
> +
> +	/* Use first bulk-in/out endpoints + int-in endpoint */
> +	ret = usb_find_common_endpoints(intf->cur_altsetting, &bulk_in, &bulk_out, &int_in, NULL);
> +	if (ret) {
> +		dev_err(if_dev,
> +			"Could not find bulk-in, bulk-out or int-in endpoint\n");
> +		goto error;
> +	}
> +	/* Bulk endpoints have to be capable of sending headers in one transfer. */
> +	if ((usb_endpoint_maxp(bulk_out) < sizeof(struct ec_host_request)) ||
> +	    (usb_endpoint_maxp(bulk_in) < sizeof(struct ec_host_response)) ||
> +	    (usb_endpoint_maxp(int_in)) < sizeof(struct int_msg)) {
> +		ret = -ENOSPC;
> +		dev_err(if_dev, "Incorrect max packet size\n");
> +		goto error;
> +	}
> +
> +	ec_usb->bulk_out_pipe = usb_sndbulkpipe(ec_usb->udev, bulk_out->bEndpointAddress);
> +	ec_usb->bulk_in_size = usb_endpoint_maxp(bulk_in);
> +	ec_usb->bulk_in_pipe = usb_rcvbulkpipe(ec_usb->udev, bulk_in->bEndpointAddress);
> +	ec_usb->bulk_in_buffer = kmalloc(ec_usb->bulk_in_size, GFP_KERNEL);
> +	if (!ec_usb->bulk_in_buffer) {
> +		dev_err(if_dev, "Failed to allocate bulk in buffer\n");
> +		ret = -ENOMEM;
> +		goto error;
> +	}
> +
> +	ec_usb->int_in_size = usb_endpoint_maxp(int_in);
> +	ec_usb->int_in_pipe = usb_rcvintpipe(ec_usb->udev, int_in->bEndpointAddress);
> +	ec_usb->int_in_interval = int_in->bInterval;
> +	ec_usb->int_in_buffer = kmalloc(ec_usb->int_in_size, GFP_KERNEL);
> +	if (!ec_usb->int_in_buffer) {
> +		dev_err(if_dev, "Failed to allocate int in buffer\n");
> +		ret = -ENOMEM;
> +		goto error;
> +	}
> +	ec_usb->int_in_urb = usb_alloc_urb(0, GFP_KERNEL);
> +	if (!ec_usb->int_in_urb) {
> +		dev_err(if_dev, "Failed to allocate int in urb\n");
> +		ret = -ENOMEM;
> +		goto error;
> +	}
> +
> +	/* Use URB for the int endpoint. */
> +	ret = submit_int_urb(ec_dev, GFP_KERNEL);
> +	if (ret) {
> +		dev_err(if_dev, "Failed to sumbit int urb: %d\n", ret);
> +		goto error;
> +	}
> +
> +	mutex_lock(&ec_usb->io_mutex);
> +	ec_usb->disconnected = false;
> +	mutex_unlock(&ec_usb->io_mutex);
> +
> +	if (!is_registered) {
> +		ret = cros_ec_register(ec_dev);
> +		if (ret) {
> +			dev_err(if_dev, "Cannot register EC\n");
> +			goto error;
> +		}
> +		ret = cros_ec_usb_register(idProduct, ec_usb);
> +		if (ret) {
> +			cros_ec_unregister(ec_dev);
> +			goto error;
> +		}
> +		ec_usb->registered = true;
> +	}
> +
> +	/* Handle potential events that haven't been handled before registration */
> +	schedule_work(&ec_usb->work_ec_evt);
> +
> +	return 0;
> +
> +error:
> +	/* Free allocated memory */
> +	cros_ec_usb_delete(ec_usb);
> +	if (!is_registered) {
> +		/* Free constant structures only if it is a first registration. */
> +		kfree(ec_dev);
> +		kfree(ec_usb);
> +	}
> +
> +	return ret;
> +}
> +
> +static void cros_ec_usb_disconnect(struct usb_interface *intf)
> +{
> +	struct cros_ec_device *ec_dev = usb_get_intfdata(intf);
> +	struct cros_ec_usb *ec_usb = ec_dev->priv;
> +
> +	/* prevent more I/O from starting */
> +	mutex_lock(&ec_usb->io_mutex);
> +	ec_usb->disconnected = true;
> +	mutex_unlock(&ec_usb->io_mutex);
> +
> +	cros_ec_usb_delete(ec_usb);
> +}
> +
> +static int cros_ec_usb_suspend(struct usb_interface *intf, pm_message_t message)
> +{
> +	return 0;
> +}
> +
> +static int cros_ec_usb_resume(struct usb_interface *intf)
> +{
> +	struct cros_ec_device *ec_dev = usb_get_intfdata(intf);
> +	int err;
> +
> +	/* URB is killed during suspend. */
> +	err = submit_int_urb(ec_dev, GFP_KERNEL);
> +	if (err)
> +		dev_err(ec_dev->dev, "Failed to sumbit int urb after resume: %d\n", err);
> +
> +	return err;
> +}
> +
> +static int cros_ec_usb_pre_reset(struct usb_interface *intf)
> +{
> +	struct cros_ec_device *ec_dev = usb_get_intfdata(intf);
> +	struct cros_ec_usb *ec_usb = ec_dev->priv;
> +
> +	/* Do not start any new operations. */
> +	mutex_lock(&ec_usb->io_mutex);
> +
> +	usb_kill_urb(ec_usb->int_in_urb);
> +
> +	return 0;
> +}
> +
> +static int cros_ec_usb_post_reset(struct usb_interface *intf)
> +{
> +	struct cros_ec_device *ec_dev = usb_get_intfdata(intf);
> +	struct cros_ec_usb *ec_usb = ec_dev->priv;
> +	int err;
> +
> +	err = submit_int_urb(ec_dev, GFP_KERNEL);
> +	if (err)
> +		dev_err(ec_dev->dev, "Failed to sumbit int urb after reset: %d\n", err);
> +
> +	mutex_unlock(&ec_usb->io_mutex);
> +
> +	return err;
> +}
> +
> +static const struct usb_device_id cros_ec_usb_id_table[] = {
> +	{ USB_VENDOR_AND_INTERFACE_INFO(USB_VENDOR_ID_GOOGLE,
> +					USB_CLASS_VENDOR_SPEC,
> +					USB_SUBCLASS_GOOGLE_EC_HOST_CMD,
> +					USB_PROTOCOL_GOOGLE_EC_HOST_CMD) },
> +	{} /* Terminating entry */
> +};
> +MODULE_DEVICE_TABLE(usb, cros_ec_usb_id_table);
> +
> +static struct usb_driver cros_ec_usb = {
> +	.name = "cros-ec-usb",
> +	.probe = cros_ec_usb_probe,
> +	.disconnect = cros_ec_usb_disconnect,
> +	.suspend = cros_ec_usb_suspend,
> +	.resume = cros_ec_usb_resume,
> +	.pre_reset = cros_ec_usb_pre_reset,
> +	.post_reset = cros_ec_usb_post_reset,
> +	.id_table = cros_ec_usb_id_table,
> +	/* Do not autosuspend EC */
> +	.supports_autosuspend = 0,
> +};
> +module_usb_driver(cros_ec_usb);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("ChromeOS EC USB HC driver");
> -- 
> 2.51.0.384.g4c02a37b29-goog
> 

