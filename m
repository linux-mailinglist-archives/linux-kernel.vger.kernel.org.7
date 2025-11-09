Return-Path: <linux-kernel+bounces-892113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F75C445C6
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 20:18:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 54DD54E1E12
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 19:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA4B21D3F4;
	Sun,  9 Nov 2025 19:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOUox1EM"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F174C81
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 19:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762715899; cv=none; b=fCD1bLh9YW6LTIR+Xc0c/MtqUqy+jmUpwWJxAgluzKk0f8qB6vwvIvSoM1Oox5u/motm51KpjZcGMwa6lo0BP9ogO8R/uZGJCA0/d9ePW8PHJwAar0ODOPOZ1W7WGltyVV2LpF4bkqjQvb69zT8ItTCI5wtzZFxr9gLMz8yrdoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762715899; c=relaxed/simple;
	bh=4Tc5nMIJkCf+K1Yp/lS0TNl3kI2yP5RZlvH1VEVb//4=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rXkT/P0aCVw0x0X86wsSnUtk6pKOnPCFzvs7le462on5sYskEGQrPB1Wt2SzkuCMCoJ7BIRUhIKJ7+A2okyHWwb9TSKE7L7FTBMUapfDeeuCUed8KK8QRMxyp2GIaycoYtcvQJ4P4gzNuAMRbSizxhHcrPDXzsJLKk+nAVE3u8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bOUox1EM; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b626a4cd9d6so359649066b.3
        for <linux-kernel@vger.kernel.org>; Sun, 09 Nov 2025 11:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762715895; x=1763320695; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pt/WJLMW5CofgvBurApMG4dE+1UCGhjeZR+9TBOAEFA=;
        b=bOUox1EMgL6Y/1s/OW1tTX+n28pecYsTuXIdmflyy3d7XX97TV8kBOTywYBn8koFDe
         UYVHXNN0d5ZkR9Vnpm3VCuCXAm/Ljml0gXaL1cZeni7y9RehD1SM3/qNoUn19snfs6sa
         D834JOPOWtbOaYYruA7f8zkjdqymmb/6i6Ppj6DaV4ROCFFG8ILo4MBYmWVEHog6Puhd
         7I3EmndZbrwPwmWqxBrMt9dzr3jw7k8BgpeRgbsLD7Gue60V/i4vkGwcNZuhTd1rCMsU
         33oXa77jKS9GNaubL6vFUMnywboJWqPs7OfT9JARjEP3ai+qNYIHamIXYcVbsccx+9kx
         +2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762715895; x=1763320695;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pt/WJLMW5CofgvBurApMG4dE+1UCGhjeZR+9TBOAEFA=;
        b=Qihh4XbWoisfDxM9NTuS5ylKVnaATAgqKYjg7EDgaBMLOm+J4YJ8dWUfLtG4xYtMPM
         zBl6JFtMzIoRiqwzHcvBUineWZ02f20JYgCfx0m6JKJQ4mETqyVozNAcumoFv+y1ZmLq
         VCuOY5omC6WZhLmZyHl15IWFvcFw5RvyzGd4Tv6mK93YId0VZCqCRrWETe6rcvBqcXr4
         aG3zVcgHo8BN4why8iApdjCOfTYyuA/sh7wvzrGazd/TJLUHS3cDKDtubJXhVokXC4aG
         hJn5rV6OQV4bJhP7AE/g+YVqrarh5bqDWz9+pqS45rG8yVldEegmuK65yEJwzxxhLFxs
         wMJA==
X-Forwarded-Encrypted: i=1; AJvYcCVvMvx1D79o3vGN+dx3gfoG0NcBF7uHRdKSx6E8KC7ca4hhKiOUzHJEVbkcivNpTfacp9BPCG20STyWKT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDFwMdB0eRXcRPMpIAf67VkQDV0EcEh3V184M6hBpcoaXukmTr
	BAzj3oLc2mOBZOwYBdHzwZPbBDJmnPkxK9SU+SL0+XSY809L9ghFKj94
X-Gm-Gg: ASbGncvxwIAQi7Sm7V/rWs52Og0+4d33nRIcjmrLmb+vyX7OosHEQYdye6OwU0X/Ii8
	/Uy6X1q8HrH77xnatd/u/bTb6t1sTV3UNSNYP1GMo3PWkMW/UpBVfyIRyC+d9jBxR9QROc50qTU
	2lM9gJyUavsdLnOwWoc8/g/VtGPj24QyFYKykNsKbYhct8xKF+z3NUubzxnydQ1j3iPPcMiDvxM
	AFx6iwr5iQMNzzm7QLfcFZGjPFfbIafUFIcNVwH1PJd5HS33agSaU7C1Bm1C4Y+hLvoPjfubJqW
	BDSz0+5psfZDRP903zvEzCaWqThjFKf8U6NmXgFkUbaw3P0xgiWcmN352HRzFQLZE4qbzbsOMt/
	TmmGY/a6tuop55izB3rWH8oPlzTHcK1vhgj4CwLbeK3/oa6y1ABRLK7loUvYTIAfsd4Wc37zxc0
	FVFjNM4cLD6LKVn9RFaMNHGx79/X2YJXp8KGJ1
X-Google-Smtp-Source: AGHT+IHuRc5rVpG/mviy3lNjbujL/a/ATQzKZYImG61QSsXht/oKQln9ULAg8h7RmQMZ+J58jigtQw==
X-Received: by 2002:a17:906:6a19:b0:b72:9d56:ab52 with SMTP id a640c23a62f3a-b72e02d20c7mr560336266b.8.1762715895320;
        Sun, 09 Nov 2025 11:18:15 -0800 (PST)
Received: from michalis-linux (adsl-75.176.58.251.tellas.gr. [176.58.251.75])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bfa24d1fsm859351866b.73.2025.11.09.11.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 11:18:14 -0800 (PST)
Date: Sun, 9 Nov 2025 21:18:13 +0200
From: Michail Tatas <michail.tatas@gmail.com>
To: dpenkler@gmail.com, gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	outreachy@lists.linux.dev
Subject: [PATCH] staging: gpib: converted // to /**/ comments
Message-ID: <aRDo9UtYTwcoFCFm@michalis-linux>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch converts comments from // to /**/ to make them
consistent across the file as suggested by the TODO file in
drivers/staging/gpib/todo

Signed-off-by: Michail Tatas <michail.tatas@gmail.com>
---
 .../gpib/agilent_82357a/agilent_82357a.c      | 72 +++++++++----------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/drivers/staging/gpib/agilent_82357a/agilent_82357a.c b/drivers/staging/gpib/agilent_82357a/agilent_82357a.c
index 77c8e549b208..eafbd562f3ab 100644
--- a/drivers/staging/gpib/agilent_82357a/agilent_82357a.c
+++ b/drivers/staging/gpib/agilent_82357a/agilent_82357a.c
@@ -23,7 +23,7 @@ MODULE_DESCRIPTION("GPIB driver for Agilent 82357A/B usb adapters");
 
 #define MAX_NUM_82357A_INTERFACES 128
 static struct usb_interface *agilent_82357a_driver_interfaces[MAX_NUM_82357A_INTERFACES];
-static DEFINE_MUTEX(agilent_82357a_hotplug_lock); // protect board insertion and removal
+static DEFINE_MUTEX(agilent_82357a_hotplug_lock); /* protect board insertion and removal */
 
 static unsigned int agilent_82357a_update_status(struct gpib_board *board,
 						 unsigned int clear_mask);
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
@@ -632,7 +632,7 @@ static ssize_t agilent_82357a_generic_write(struct gpib_board *board,
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
+	return;/* 0; */
 }
 
 static void agilent_82357a_serial_poll_response(struct gpib_board *board, u8 status)
 {
-	// board can only be system controller
-	return;// 0;
+	/* board can only be system controller */
+	return;/* 0; */
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
+	return;/* 0; */
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
@@ -1448,7 +1448,7 @@ static struct gpib_interface agilent_82357a_gpib_interface = {
 	.parallel_poll = agilent_82357a_parallel_poll,
 	.parallel_poll_configure = agilent_82357a_parallel_poll_configure,
 	.parallel_poll_response = agilent_82357a_parallel_poll_response,
-	.local_parallel_poll_mode = NULL, // XXX
+	.local_parallel_poll_mode = NULL, /* XXX */
 	.line_status = agilent_82357a_line_status,
 	.update_status = agilent_82357a_update_status,
 	.primary_address = agilent_82357a_primary_address,
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
-- 
2.43.0


