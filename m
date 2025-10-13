Return-Path: <linux-kernel+bounces-851524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 75136BD6A78
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Oct 2025 00:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AADAE4E4683
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 22:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926DD2C15B8;
	Mon, 13 Oct 2025 22:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YaZG/LOT"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A031FDA89
	for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 22:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760395555; cv=none; b=STKsNzdFr5csdWlNefgz9fHua3R4iu9OHw9qpZjTN2pZNBhWyz78omHZu8X6ixWRRmooWqfucVmN4Bwv2qaqjdMcfXcaoIEqK8MeUPWThflCksNaJfJiShARl9PcK16qOzb9G9hYWoB5RkcUqWdyZVrjxJvcXxcFLWekD/v5Ha0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760395555; c=relaxed/simple;
	bh=s+cTaBWTRDjPjcFMe3RvmWxNHr8AfIUjpqzv0AL7Lao=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IOkcQH3dE37Nf0P4YpQqDz1XZxv6FoKD8BBL5/Alj0/Ewm0VQBU+Foebhn/3705XFUcbZLPdTry2d7HR8UJjAMEjKeMsz1wLwLM5oDPZODN4S+cmUWewzBKdUoWHffCUkjbuSrLuzkBbSMLpXZD6EMltkHLbey5IZn4/JfGaMxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YaZG/LOT; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46e29d65728so28093085e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Oct 2025 15:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760395552; x=1761000352; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VbdDBDcY2xvlnlZbqQQm+AeL3Y4hgQFO9QkB/T0NiAk=;
        b=YaZG/LOTbwAEtMZOUaZtt1Ve+DvNP4nPgDx8GUdjgF0EUiLKg8zWRmKAIPchvN0690
         2gDF1kjVWPfRJXGO4lxu+Ldmp/BYvg2hhEbf0UyHXb49Luf1lnmdqa6ZW1JT3aD3CSyQ
         NfMc0T3zaMZu7XTvk7Y7xDHbfj91C+XDkzqdSy5fedGRNHblyDOhy5kl5N77yCpYga5q
         +vyEwyVPmqM4qm/4QLZMrXO9KP0x1vqZycMTCl6XyA+JWi/5n34063RGCZSCyMzgNcAZ
         yVWLg2nXbhcjKL48SMP4+pWwS0TU92TgZk6N//cFYmkJvGjDu/QD7S/6oj0odMVzeJnr
         UF5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760395552; x=1761000352;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VbdDBDcY2xvlnlZbqQQm+AeL3Y4hgQFO9QkB/T0NiAk=;
        b=a9U0U9+xPrcOeiwv3b+7FgG62lukdhXMPINcRfqV42o3ppYqqizG5Y2uQrMDzHptyW
         Vi7bd7Kll93LrVTtlaRTkkdpJm087g7xeDW3qw0kGPTE9OzU9GVfGaCyPNgED9z/WWoo
         UEheeSWUlAF56IjbPI6JUhPbpt2fxZTU6P6Tj4XjFWqJZ6uP+YkqD2AxgUE6URiXovsS
         a2/YN7K+YQ+1nUKr6JdnF7gkPGq7EtPFjsPEpCg0pOL4l88GwlEB93h2db00IQXmq1B+
         qRZX8dw3dUjuTUxitUb4OVyp205pbAPYFFYbyzsBEvPKTYzumOmpKrxorXTQz8SL0qjk
         3zLA==
X-Forwarded-Encrypted: i=1; AJvYcCWWfuaw99JONX/pQls6Yvl3QAGgMb/tMzuEN4YfB8t9zDzcGDwRNZSAc/mhZYAwzCwka2HpX4crGR56w3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YworwqxECP/1w4ms6TCxMJtumAj6r6WD3AjQ+Q8GwYf4rqA0Ho/
	rdPBjUWqBEdiBWUPwuFoy4tcVWIKCa5YloenODGIZCtFHEIR70fO+LhK
X-Gm-Gg: ASbGncs1eMdNQ59mm5E5v44rN31N4PZzVVGp66gqe2rfgVRIdaO33vDKBIXhmPkW5H3
	IpXpALq7Oq3fsGO271jmDhCl5C7scVlEx6Z9kZ6qxbknEkkskxzawcqxft0FypS4NX+TbP11mBY
	oN8ahvIRbDECNinNeZXaRXUu5i0MFnkrmJiF+oMhiF+87znknHHCkC75hFcVch2VoqAh6uQg+E/
	3MeSAWFbas5sSDe2HJz5jI6JPV0LKkfkK/FMCo8evZaYPH6Rvz6/uZQQkbwdAr3MQa7N21fQUTi
	UECXP8Ud9h6kefNgkduzJKW+9vxtCgT0HWojut3lmNY5kWTQuLoVdggtAfZHjvTD4C2JuAjmTlU
	VYoAkfopvW9L9GeKkxmpypbiq90xgGOZ4EXxCEycPZnaDUwTduef72U4vWAH3k/++leeG7pEMdH
	vKT4XW5JmRCYR0
X-Google-Smtp-Source: AGHT+IFqbTc8TAbIO7Pt+JoBn6j3eF5AuK7khdfY2tHDIoCY3Yrdy8EvjCTM/KpLguB/J1O016ZDDQ==
X-Received: by 2002:a05:600c:4690:b0:46e:3dc2:ebac with SMTP id 5b1f17b1804b1-46fa9afbb62mr145998685e9.27.1760395551540;
        Mon, 13 Oct 2025 15:45:51 -0700 (PDT)
Received: from michalis-linux (adsl-75.176.58.251.tellas.gr. [176.58.251.75])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb49c4027sm204157245e9.17.2025.10.13.15.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 15:45:51 -0700 (PDT)
Date: Tue, 14 Oct 2025 01:45:49 +0300
From: Michail Tatas <michail.tatas@gmail.com>
To: dpenkler@gmail.com, gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	outreachy@lists.linux.dev
Subject: staging: gpib: convert comments from // to /* */
Message-ID: <aO2BHZzs3EsMTo3n@michalis-linux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch converts some comments from // -> /* */ to make everything consistent as suggested
in the TODO file in drivers/staging/gpib/TODO

This patch only updates part of the driver to keep a reasonable patch size. Further conversions
will be submitted in follow-up patches if this is accepted.

Signed-off-by: Michail Tatas <michail.tatas@gmail.com>
---
 .../gpib/agilent_82357a/agilent_82357a.c      | 70 +++++++++----------
 .../gpib/agilent_82357a/agilent_82357a.h      | 18 ++---
 2 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/drivers/staging/gpib/agilent_82357a/agilent_82357a.c b/drivers/staging/gpib/agilent_82357a/agilent_82357a.c
index 77c8e549b208..23d9dbbed807 100644
--- a/drivers/staging/gpib/agilent_82357a/agilent_82357a.c
+++ b/drivers/staging/gpib/agilent_82357a/agilent_82357a.c
@@ -420,7 +420,7 @@ static int agilent_82357a_abort(struct agilent_82357a_priv *a_priv, int flush)
 	return retval;
 }
 
-// interface functions
+/* interface functions */
 int agilent_82357a_command(struct gpib_board *board, u8 *buffer, size_t length,
 			   size_t *bytes_written);
 
@@ -449,8 +449,8 @@ static int agilent_82357a_read(struct gpib_board *board, u8 *buffer, size_t leng
 	if (!out_data)
 		return -ENOMEM;
 	out_data[i++] = DATA_PIPE_CMD_READ;
-	out_data[i++] = 0;	// primary address when ARF_NO_ADDR is not set
-	out_data[i++] = 0;	// secondary address when ARF_NO_ADDR is not set
+	out_data[i++] = 0;	/* primary address when ARF_NO_ADDR is not set */
+	out_data[i++] = 0;	/* secondary address when ARF_NO_ADDR is not set */
 	out_data[i] = ARF_NO_ADDRESS | ARF_END_ON_EOI;
 	if (a_priv->eos_mode & REOS)
 		out_data[i] |= ARF_END_ON_EOS_CHAR;
@@ -532,7 +532,7 @@ static int agilent_82357a_read(struct gpib_board *board, u8 *buffer, size_t leng
 	 */
 	agilent_82357a_take_control_internal(board, 0);
 
-	// FIXME check trailing flags for error
+	/* FIXME check trailing flags for error */
 	return retval;
 }
 
@@ -563,8 +563,8 @@ static ssize_t agilent_82357a_generic_write(struct gpib_board *board,
 	if (!out_data)
 		return -ENOMEM;
 	out_data[i++] = DATA_PIPE_CMD_WRITE;
-	out_data[i++] = 0; // primary address when AWF_NO_ADDRESS is not set
-	out_data[i++] = 0; // secondary address when AWF_NO_ADDRESS is not set
+	out_data[i++] = 0; /* primary address when AWF_NO_ADDRESS is not set */
+	out_data[i++] = 0; /* secondary address when AWF_NO_ADDRESS is not set */
 	out_data[i] = AWF_NO_ADDRESS | AWF_NO_FAST_TALKER_FIRST_BYTE;
 	if (send_commands)
 		out_data[i] |= AWF_ATN | AWF_NO_FAST_TALKER;
@@ -628,11 +628,11 @@ static ssize_t agilent_82357a_generic_write(struct gpib_board *board,
 		bsr = read_reg.value;
 		dev_dbg(&usb_dev->dev, "write aborted bsr 0x%x\n", bsr);
 
-		if (send_commands) {/* check for no listeners */
+		if (send_commands) { /* check for no listeners */
 			if ((bsr & BSR_ATN_BIT) && !(bsr & (BSR_NDAC_BIT | BSR_NRFD_BIT))) {
 				dev_dbg(&usb_dev->dev, "No listener on command\n");
 				clear_bit(TIMO_NUM, &board->status);
-				return -ENOTCONN; // no listener on bus
+				return -ENOTCONN; /* no listener on bus */
 			}
 		} else {
 			read_reg.address = ADSR;
@@ -726,7 +726,7 @@ static int agilent_82357a_take_control(struct gpib_board *board, int synchronous
 		return -ETIMEDOUT;
 
 	agilent_82357a_take_control_internal(board, synchronous);
-	// busy wait until ATN is asserted
+	/* busy wait until ATN is asserted */
 	for (i = 0; i < timeout; ++i) {
 		agilent_82357a_update_status(board, 0);
 		if (test_bit(ATN_NUM, &board->status))
@@ -795,7 +795,7 @@ static void agilent_82357a_interface_clear(struct gpib_board *board, int assert)
 	int retval;
 
 	if (!a_priv->bus_interface)
-		return; // -ENODEV;
+		return; /* -ENODEV; */
 
 	usb_dev = interface_to_usbdev(a_priv->bus_interface);
 	write.address = AUXCR;
@@ -817,7 +817,7 @@ static void agilent_82357a_remote_enable(struct gpib_board *board, int enable)
 	int retval;
 
 	if (!a_priv->bus_interface)
-		return; //-ENODEV;
+		return; /* -ENODEV; */
 
 	usb_dev = interface_to_usbdev(a_priv->bus_interface);
 	write.address = AUXCR;
@@ -828,7 +828,7 @@ static void agilent_82357a_remote_enable(struct gpib_board *board, int enable)
 	if (retval)
 		dev_err(&usb_dev->dev, "write_registers() returned error\n");
 	a_priv->ren_state = enable;
-	return;// 0;
+	return; /* 0; */
 }
 
 static int agilent_82357a_enable_eos(struct gpib_board *board, u8 eos_byte,
@@ -876,22 +876,22 @@ static unsigned int agilent_82357a_update_status(struct gpib_board *board,
 			dev_err(&usb_dev->dev, "read_registers() returned error\n");
 		return board->status;
 	}
-	// check for remote/local
+	/* check for remote/local */
 	if (address_status.value & HR_REM)
 		set_bit(REM_NUM, &board->status);
 	else
 		clear_bit(REM_NUM, &board->status);
-	// check for lockout
+	/* check for lockout */
 	if (address_status.value & HR_LLO)
 		set_bit(LOK_NUM, &board->status);
 	else
 		clear_bit(LOK_NUM, &board->status);
-	// check for ATN
+	/* check for ATN */
 	if (address_status.value & HR_ATN)
 		set_bit(ATN_NUM, &board->status);
 	else
 		clear_bit(ATN_NUM, &board->status);
-	// check for talker/listener addressed
+	/* check for talker/listener addressed */
 	if (address_status.value & HR_TA)
 		set_bit(TACS_NUM, &board->status);
 	else
@@ -926,7 +926,7 @@ static int agilent_82357a_primary_address(struct gpib_board *board, unsigned int
 	if (!a_priv->bus_interface)
 		return -ENODEV;
 	usb_dev = interface_to_usbdev(a_priv->bus_interface);
-	// put primary address in address0
+	/* put primary address in address0 */
 	write.address = ADR;
 	write.value = address & ADDRESS_MASK;
 	retval = agilent_82357a_write_registers(a_priv, &write, 1);
@@ -956,7 +956,7 @@ static int agilent_82357a_parallel_poll(struct gpib_board *board, u8 *result)
 	if (!a_priv->bus_interface)
 		return -ENODEV;
 	usb_dev = interface_to_usbdev(a_priv->bus_interface);
-	// execute parallel poll
+	/* execute parallel poll */
 	writes[0].address = AUXCR;
 	writes[0].value = AUX_CS | AUX_RPP;
 	writes[1].address = HW_CONTROL;
@@ -966,7 +966,7 @@ static int agilent_82357a_parallel_poll(struct gpib_board *board, u8 *result)
 		dev_err(&usb_dev->dev, "write_registers() returned error\n");
 		return retval;
 	}
-	udelay(2);	// silly, since usb write will take way longer
+	udelay(2);	/* silly, since usb write will take way longer */
 	read.address = CPTR;
 	retval = agilent_82357a_read_registers(a_priv, &read, 1, 1);
 	if (retval) {
@@ -974,7 +974,7 @@ static int agilent_82357a_parallel_poll(struct gpib_board *board, u8 *result)
 		return retval;
 	}
 	*result = read.value;
-	// clear parallel poll state
+	/* clear parallel poll state */
 	writes[0].address = HW_CONTROL;
 	writes[0].value = a_priv->hw_control_bits | NOT_PARALLEL_POLL;
 	writes[1].address = AUXCR;
@@ -989,32 +989,32 @@ static int agilent_82357a_parallel_poll(struct gpib_board *board, u8 *result)
 
 static void agilent_82357a_parallel_poll_configure(struct gpib_board *board, u8 config)
 {
-	// board can only be system controller
-	return;// 0;
+	/* board can only be system controller */
+	return; /* 0; */
 }
 
 static void agilent_82357a_parallel_poll_response(struct gpib_board *board, int ist)
 {
-	// board can only be system controller
-	return;// 0;
+	/* board can only be system controller */
+	return; /* 0; */
 }
 
 static void agilent_82357a_serial_poll_response(struct gpib_board *board, u8 status)
 {
-	// board can only be system controller
-	return;// 0;
+	/* board can only be system controller */
+	return; /* 0; */
 }
 
 static u8 agilent_82357a_serial_poll_status(struct gpib_board *board)
 {
-	// board can only be system controller
+	/* board can only be system controller */
 	return 0;
 }
 
 static void agilent_82357a_return_to_local(struct gpib_board *board)
 {
-	// board can only be system controller
-	return;// 0;
+	/* board can only be system controller */
+	return; /* 0; */
 }
 
 static int agilent_82357a_line_status(const struct gpib_board *board)
@@ -1269,7 +1269,7 @@ static int agilent_82357a_init(struct gpib_board *board)
 	writes[14].value = HR_BOIE | HR_BIIE;
 	writes[15].address = IMR1;
 	writes[15].value = HR_SRQIE;
-	// turn off reset state
+	/* turn off reset state */
 	writes[16].address = AUXCR;
 	writes[16].value = AUX_CHIP_RESET;
 	writes[17].address = LED_CONTROL;
@@ -1387,7 +1387,7 @@ static int agilent_82357a_go_idle(struct gpib_board *board)
 	struct agilent_82357a_register_pairlet writes[0x20];
 	int retval;
 
-	// turn on tms9914 reset state
+	/* turn on tms9914 reset state */
 	writes[0].address = AUXCR;
 	writes[0].value = AUX_CS | AUX_CHIP_RESET;
 	a_priv->hw_control_bits &= ~NOT_TI_RESET;
@@ -1461,7 +1461,7 @@ static struct gpib_interface agilent_82357a_gpib_interface = {
 	.skip_check_for_command_acceptors = 1
 };
 
-// Table with the USB-devices: just now only testing IDs
+/* Table with the USB-devices: just now only testing IDs */
 static struct usb_device_id agilent_82357a_driver_device_table[] = {
 	{USB_DEVICE(USB_VENDOR_ID_AGILENT, USB_DEVICE_ID_AGILENT_82357A)},
 	{USB_DEVICE(USB_VENDOR_ID_AGILENT, USB_DEVICE_ID_AGILENT_82357B)},
@@ -1626,15 +1626,15 @@ static int agilent_82357a_driver_resume(struct usb_interface *interface)
 			mutex_unlock(&agilent_82357a_hotplug_lock);
 			return retval;
 		}
-		// set/unset system controller
+		/* set/unset system controller */
 		retval = agilent_82357a_request_system_control(board, board->master);
-		// toggle ifc if master
+		/* toggle ifc if master */
 		if (board->master) {
 			agilent_82357a_interface_clear(board, 1);
 			usleep_range(200, 250);
 			agilent_82357a_interface_clear(board, 0);
 		}
-		// assert/unassert REN
+		/* assert/unassert REN */
 		agilent_82357a_remote_enable(board, a_priv->ren_state);
 
 		dev_dbg(&usb_dev->dev,
diff --git a/drivers/staging/gpib/agilent_82357a/agilent_82357a.h b/drivers/staging/gpib/agilent_82357a/agilent_82357a.h
index 33ac558e5552..0f76b56c2a7f 100644
--- a/drivers/staging/gpib/agilent_82357a/agilent_82357a.h
+++ b/drivers/staging/gpib/agilent_82357a/agilent_82357a.h
@@ -19,9 +19,9 @@ enum usb_vendor_ids {
 
 enum usb_device_ids {
 	USB_DEVICE_ID_AGILENT_82357A = 0x0107,
-	USB_DEVICE_ID_AGILENT_82357A_PREINIT = 0x0007,	// device id before firmware is loaded
-	USB_DEVICE_ID_AGILENT_82357B = 0x0718,		// device id before firmware is loaded
-	USB_DEVICE_ID_AGILENT_82357B_PREINIT = 0x0518,	// device id before firmware is loaded
+	USB_DEVICE_ID_AGILENT_82357A_PREINIT = 0x0007,	/* device id before firmware is loaded */
+	USB_DEVICE_ID_AGILENT_82357B = 0x0718,		    /* device id before firmware is loaded */
+	USB_DEVICE_ID_AGILENT_82357B_PREINIT = 0x0518,	/* device id before firmware is loaded */
 };
 
 enum endpoint_addresses {
@@ -119,7 +119,7 @@ struct agilent_82357a_urb_ctx {
 	unsigned timed_out : 1;
 };
 
-// struct which defines local data for each 82357 device
+/* struct which defines local data for each 82357 device */
 struct agilent_82357a_priv {
 	struct usb_interface *bus_interface;
 	unsigned short eos_char;
@@ -129,10 +129,10 @@ struct agilent_82357a_priv {
 	struct urb *bulk_urb;
 	struct urb *interrupt_urb;
 	u8 *interrupt_buffer;
-	struct mutex bulk_transfer_lock;	// bulk transfer lock
-	struct mutex bulk_alloc_lock;		// bulk transfer allocation lock
-	struct mutex interrupt_alloc_lock;	// interrupt allocation lock
-	struct mutex control_alloc_lock;	// control message allocation lock
+	struct mutex bulk_transfer_lock;	/* bulk transfer lock */
+	struct mutex bulk_alloc_lock;		/* bulk transfer allocation lock */
+	struct mutex interrupt_alloc_lock;	/* interrupt allocation lock */
+	struct mutex control_alloc_lock;	/* control message allocation lock */
 	struct timer_list bulk_timer;
 	struct agilent_82357a_urb_ctx context;
 	unsigned int bulk_out_endpoint;
@@ -171,7 +171,7 @@ enum led_control_bits {
 };
 
 enum reset_to_powerup_bits {
-	RESET_SPACEBALL = 0x1,	// wait 2 millisec after sending
+	RESET_SPACEBALL = 0x1,	/* wait 2 millisec after sending */
 };
 
 enum protocol_control_bits {
-- 
2.43.0


