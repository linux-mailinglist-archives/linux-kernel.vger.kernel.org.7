Return-Path: <linux-kernel+bounces-769496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1670FB26F70
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 21:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE9B03AE366
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 19:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2A721FF47;
	Thu, 14 Aug 2025 19:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/Zhs395"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF101B87C0
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 19:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755198102; cv=none; b=W21VGgkdo6kDpURCnbwG6kVcuQczlkfOEcr5x9O8qmQKILz0AlTSaXWZSEhhXti/YlpHIXJKN6fM4INpZv2K9RosRoCCQKcqZ7hSETi2KCP3TLVeSDz+YldCa6U404KRkRkZqyEWK0GSSDr5JbbQTSE9vZewjEnQ4tU8GiJVog8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755198102; c=relaxed/simple;
	bh=dYKRRxUvWc+B1HVvSc9kNNi41yNbc1hBu+8G8tf/lYE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=e1NtjSTSg6xi2diTGF5myZinxTp7UDjQ8hlVQDmlLOhtYotAk7FiL+iHxAnNJwcmxHlrf2iKTaD9tcF/hSjmzj98myEPpDSNzhgVCUf5kloBEaqqWvmENCj/Xo+zxpxuNa7bk5zrYAePhpog5X96r58/O46Fr8eczadAFDyNruo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/Zhs395; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-70a88de7d4fso10782646d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 12:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755198098; x=1755802898; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+XhEXTvkAxz7145zzl36aT4R5/bhWDXDqL3ioQhcrxA=;
        b=b/Zhs395ZNt/MPmiby5vd4y96QyXFJDIKWDzr1qDTXz+AxUS4PBC33iEUVy3qRbAbU
         Hs7LVrAOE/Vv68igydZOQ5e9PFGSgdq58rbfciN+pohlCEo/p7/jAeL+wNSxuYwgQ77q
         qUwX6FWZB1clD9+Cj2WWgwdr5KwcJx2sSm3uHLXeUOu47sHxYx2T5wGxw37u/CHR1dJY
         3wRfTNJgqBUAA2crYNW7BvKBt0Ksacqrh2V2djv5IalRvq2BF56+/SddOKxOgKT73Lnb
         aqTd1icfLqMgepAz/Dy+dTYyWQ1BVHvcpFUBvs6wcOlogz7YilCJZUF8SZwaSlIVm0Cd
         Gzfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755198098; x=1755802898;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+XhEXTvkAxz7145zzl36aT4R5/bhWDXDqL3ioQhcrxA=;
        b=d9UofM3f0Ao08u6ujTIgosfgK6nAxZkndrj2YpwP6jQ9Gj7bzfg3hpn1fG247Gjc4C
         ZgRLjpMppgHJHAftmknVAcdCvownYA/bLr980xp+7+3WOxsrmevF8feo7ITZfClJej1g
         47Nz0o1sSD5+bAv2RjBZDPlDsqY6dxaj+kE/jCHrTjt3DY7gCxq7jGVP8H1Rcmunehu0
         NIQlwqdNxq9zuQ8g4Njtu5q2Sfwc/ctgQ/Gf5EdUaqM3cBUvq8gQBnQshFFdcLgg1Zg9
         8eFIBDotPM7OGYvO9eZ9CuG1enSKa+JVt+aAnbmKENkxHhh+hnx1SUGvErCfoSyYAvDG
         HtNw==
X-Forwarded-Encrypted: i=1; AJvYcCVMQkN6UsMiFzpZc745QSumVt4/XUNfEoZns7fYZDuJ58WFAYgJ4nOhm1nwQjM6mb2s2s6ZK7WOhKOLNqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPNt/lTHH2rIPGZSicPPA83S2sRx9GBv5h0n+RDZ4oiDEquzzg
	Q5ntlLOV32Fy3jws4CiwIUS96mDS7r2LXf5pQ0RQ7sUiDuXibXTmwzlZ1HqpRTGz
X-Gm-Gg: ASbGncvdaw+s03jOR7xR+lDuIu+A/0mUccq2kc8rHJxCGYoth6bngEDfMbzQF7Z0/HL
	/yDYLA7YKum7Sm+tEK/vjG31cuEHXjyThXNLrznDgZm7XscsfpYgeWeV4wEWXYidJNJHROL0arB
	TrWmlSiHdDUmrUUK0o/9FmlxQND38iZtjV6w4J4w1uypxtsxi3A0u9NfhzKPaIImrccqU0cn3c/
	+4w/EcV54scNh91yRXN58EuMKEu/fdYMC3tgVKPyMFuvQWaQXjVICitwjiSic8RRjWv8NIeRTBV
	FvtdzB0kumefz/SyZbaN3Mtac53rL/rXZH0eIxm20mFQ7wWu2C2AKcKCIfP5MNwlnBf9DAmmJGa
	mKcd5dvCKF+zClB934qZxTbX0R66wDw==
X-Google-Smtp-Source: AGHT+IGyJSss7TDXxGgyuh6C3t1JQ2AhA4yKiiTt2NyB2l2dV0CpZTMPPN0CrDXGBMqelp/TB6m4tw==
X-Received: by 2002:ad4:5d65:0:b0:707:6364:792f with SMTP id 6a1803df08f44-70b9827bed6mr47883496d6.11.1755198097447;
        Thu, 14 Aug 2025 12:01:37 -0700 (PDT)
Received: from localhost ([104.160.227.17])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70af5bc7310sm16441466d6.71.2025.08.14.12.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 12:01:36 -0700 (PDT)
Date: Thu, 14 Aug 2025 15:01:36 -0400
From: Luke Yang <lukeyang.dev@gmail.com>
To: Dave Penkler <dpenkler@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: gpib: tidy-up comments
Message-ID: <aJ4ykOs_MmjnQdPa@luyang-thinkpadp1gen7.toromso.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Improve comment readability:

- "//comment" -> "// comment"
- Align comments vertically in columns
- Enforce consistency between "// comments" and "/* comments */"

Signed-off-by: Luke Yang <lukeyang.dev@gmail.com>
---
 .../gpib/agilent_82357a/agilent_82357a.c      | 18 ++--
 .../gpib/agilent_82357a/agilent_82357a.h      | 10 +--
 drivers/staging/gpib/cb7210/cb7210.h          |  4 +-
 drivers/staging/gpib/cec/cec_gpib.c           |  2 +-
 drivers/staging/gpib/common/gpib_os.c         |  2 +-
 drivers/staging/gpib/common/iblib.c           |  2 +-
 drivers/staging/gpib/eastwood/fluke_gpib.c    |  2 +-
 drivers/staging/gpib/fmh_gpib/fmh_gpib.c      |  2 +-
 drivers/staging/gpib/gpio/gpib_bitbang.c      | 14 +--
 drivers/staging/gpib/hp_82341/hp_82341.c      | 12 +--
 drivers/staging/gpib/hp_82341/hp_82341.h      | 40 ++++-----
 drivers/staging/gpib/include/amccs5933.h      |  4 +-
 drivers/staging/gpib/include/gpib_types.h     |  3 +-
 drivers/staging/gpib/include/nec7210.h        | 26 +++---
 .../staging/gpib/include/nec7210_registers.h  |  4 +-
 drivers/staging/gpib/include/plx9050.h        |  8 +-
 drivers/staging/gpib/include/tms9914.h        | 90 +++++++++----------
 .../staging/gpib/include/tnt4882_registers.h  | 22 ++---
 drivers/staging/gpib/ines/ines.h              | 12 +--
 drivers/staging/gpib/ines/ines_gpib.c         |  4 +-
 drivers/staging/gpib/nec7210/nec7210.c        |  6 +-
 drivers/staging/gpib/ni_usb/ni_usb_gpib.c     | 10 +--
 drivers/staging/gpib/ni_usb/ni_usb_gpib.h     | 10 +--
 drivers/staging/gpib/pc2/pc2_gpib.c           |  4 +-
 drivers/staging/gpib/tms9914/tms9914.c        | 10 +--
 drivers/staging/gpib/tnt4882/mite.h           | 10 +--
 drivers/staging/gpib/tnt4882/tnt4882_gpib.c   |  4 +-
 27 files changed, 168 insertions(+), 167 deletions(-)

diff --git a/drivers/staging/gpib/agilent_82357a/agilent_82357a.c b/drivers/staging/gpib/agilent_82357a/agilent_82357a.c
index b923dc606d1d..77c8e549b208 100644
--- a/drivers/staging/gpib/agilent_82357a/agilent_82357a.c
+++ b/drivers/staging/gpib/agilent_82357a/agilent_82357a.c
@@ -449,8 +449,8 @@ static int agilent_82357a_read(struct gpib_board *board, u8 *buffer, size_t leng
 	if (!out_data)
 		return -ENOMEM;
 	out_data[i++] = DATA_PIPE_CMD_READ;
-	out_data[i++] = 0;	//primary address when ARF_NO_ADDR is not set
-	out_data[i++] = 0;	//secondary address when ARF_NO_ADDR is not set
+	out_data[i++] = 0;	// primary address when ARF_NO_ADDR is not set
+	out_data[i++] = 0;	// secondary address when ARF_NO_ADDR is not set
 	out_data[i] = ARF_NO_ADDRESS | ARF_END_ON_EOI;
 	if (a_priv->eos_mode & REOS)
 		out_data[i] |= ARF_END_ON_EOS_CHAR;
@@ -532,7 +532,7 @@ static int agilent_82357a_read(struct gpib_board *board, u8 *buffer, size_t leng
 	 */
 	agilent_82357a_take_control_internal(board, 0);
 
-	//FIXME check trailing flags for error
+	// FIXME check trailing flags for error
 	return retval;
 }
 
@@ -966,7 +966,7 @@ static int agilent_82357a_parallel_poll(struct gpib_board *board, u8 *result)
 		dev_err(&usb_dev->dev, "write_registers() returned error\n");
 		return retval;
 	}
-	udelay(2);	//silly, since usb write will take way longer
+	udelay(2);	// silly, since usb write will take way longer
 	read.address = CPTR;
 	retval = agilent_82357a_read_registers(a_priv, &read, 1, 1);
 	if (retval) {
@@ -989,31 +989,31 @@ static int agilent_82357a_parallel_poll(struct gpib_board *board, u8 *result)
 
 static void agilent_82357a_parallel_poll_configure(struct gpib_board *board, u8 config)
 {
-	//board can only be system controller
+	// board can only be system controller
 	return;// 0;
 }
 
 static void agilent_82357a_parallel_poll_response(struct gpib_board *board, int ist)
 {
-	//board can only be system controller
+	// board can only be system controller
 	return;// 0;
 }
 
 static void agilent_82357a_serial_poll_response(struct gpib_board *board, u8 status)
 {
-	//board can only be system controller
+	// board can only be system controller
 	return;// 0;
 }
 
 static u8 agilent_82357a_serial_poll_status(struct gpib_board *board)
 {
-	//board can only be system controller
+	// board can only be system controller
 	return 0;
 }
 
 static void agilent_82357a_return_to_local(struct gpib_board *board)
 {
-	//board can only be system controller
+	// board can only be system controller
 	return;// 0;
 }
 
diff --git a/drivers/staging/gpib/agilent_82357a/agilent_82357a.h b/drivers/staging/gpib/agilent_82357a/agilent_82357a.h
index 23aa4799eb86..33ac558e5552 100644
--- a/drivers/staging/gpib/agilent_82357a/agilent_82357a.h
+++ b/drivers/staging/gpib/agilent_82357a/agilent_82357a.h
@@ -20,7 +20,7 @@ enum usb_vendor_ids {
 enum usb_device_ids {
 	USB_DEVICE_ID_AGILENT_82357A = 0x0107,
 	USB_DEVICE_ID_AGILENT_82357A_PREINIT = 0x0007,	// device id before firmware is loaded
-	USB_DEVICE_ID_AGILENT_82357B = 0x0718,	// device id before firmware is loaded
+	USB_DEVICE_ID_AGILENT_82357B = 0x0718,		// device id before firmware is loaded
 	USB_DEVICE_ID_AGILENT_82357B_PREINIT = 0x0518,	// device id before firmware is loaded
 };
 
@@ -129,10 +129,10 @@ struct agilent_82357a_priv {
 	struct urb *bulk_urb;
 	struct urb *interrupt_urb;
 	u8 *interrupt_buffer;
-	struct mutex bulk_transfer_lock; // bulk transfer lock
-	struct mutex bulk_alloc_lock;    // bulk transfer allocation lock
-	struct mutex interrupt_alloc_lock; // interrupt allocation lock
-	struct mutex control_alloc_lock;   // control message allocation lock
+	struct mutex bulk_transfer_lock;	// bulk transfer lock
+	struct mutex bulk_alloc_lock;		// bulk transfer allocation lock
+	struct mutex interrupt_alloc_lock;	// interrupt allocation lock
+	struct mutex control_alloc_lock;	// control message allocation lock
 	struct timer_list bulk_timer;
 	struct agilent_82357a_urb_ctx context;
 	unsigned int bulk_out_endpoint;
diff --git a/drivers/staging/gpib/cb7210/cb7210.h b/drivers/staging/gpib/cb7210/cb7210.h
index 13f127563ab3..ddc841ff87ae 100644
--- a/drivers/staging/gpib/cb7210/cb7210.h
+++ b/drivers/staging/gpib/cb7210/cb7210.h
@@ -56,10 +56,10 @@ enum cb7210_page_in {
 };
 
 enum hs_regs {
-	//write registers
+	// write registers
 	HS_MODE = 0x8,	/* HS_MODE register */
 	HS_INT_LEVEL = 0x9,	/* HS_INT_LEVEL register */
-	//read registers
+	// read registers
 	HS_STATUS = 0x8,	/* HS_STATUS register */
 };
 
diff --git a/drivers/staging/gpib/cec/cec_gpib.c b/drivers/staging/gpib/cec/cec_gpib.c
index 0c9d10ee7cd2..dbf9b95baabc 100644
--- a/drivers/staging/gpib/cec/cec_gpib.c
+++ b/drivers/staging/gpib/cec/cec_gpib.c
@@ -206,7 +206,7 @@ static struct gpib_interface cec_pci_interface = {
 	.parallel_poll_configure = cec_parallel_poll_configure,
 	.parallel_poll_response = cec_parallel_poll_response,
 	.local_parallel_poll_mode = NULL, // XXX
-	.line_status = NULL,	//XXX
+	.line_status = NULL,	// XXX
 	.update_status = cec_update_status,
 	.primary_address = cec_primary_address,
 	.secondary_address = cec_secondary_address,
diff --git a/drivers/staging/gpib/common/gpib_os.c b/drivers/staging/gpib/common/gpib_os.c
index 2a0465ce16c4..9dbbac8b8436 100644
--- a/drivers/staging/gpib/common/gpib_os.c
+++ b/drivers/staging/gpib/common/gpib_os.c
@@ -326,7 +326,7 @@ static int setup_serial_poll(struct gpib_board *board, unsigned int usec_timeout
 	cmd_string[i++] = MLA(board->pad);	/* controller's listen address */
 	if (board->sad >= 0)
 		cmd_string[i++] = MSA(board->sad);
-	cmd_string[i++] = SPE;	//serial poll enable
+	cmd_string[i++] = SPE;	// serial poll enable
 
 	ret = board->interface->command(board, cmd_string, i, &bytes_written);
 	if (ret < 0 || bytes_written < i) {
diff --git a/drivers/staging/gpib/common/iblib.c b/drivers/staging/gpib/common/iblib.c
index 549280d9a6e9..7cbb6a467177 100644
--- a/drivers/staging/gpib/common/iblib.c
+++ b/drivers/staging/gpib/common/iblib.c
@@ -608,7 +608,7 @@ static int wait_satisfied(struct wait_info *winfo, struct gpib_status_queue *sta
 		*status = temp_status;
 		return 1;
 	}
-//XXX does wait for END work?
+// XXX does wait for END work?
 	return 0;
 }
 
diff --git a/drivers/staging/gpib/eastwood/fluke_gpib.c b/drivers/staging/gpib/eastwood/fluke_gpib.c
index 491356433249..3ae848e3f738 100644
--- a/drivers/staging/gpib/eastwood/fluke_gpib.c
+++ b/drivers/staging/gpib/eastwood/fluke_gpib.c
@@ -507,7 +507,7 @@ static int fluke_accel_write(struct gpib_board *board, u8 *buffer, size_t length
 	}
 	if (retval < 0)
 		return retval;
-	//handle sending of last byte with eoi
+	// handle sending of last byte with eoi
 	if (send_eoi) {
 		size_t num_bytes;
 
diff --git a/drivers/staging/gpib/fmh_gpib/fmh_gpib.c b/drivers/staging/gpib/fmh_gpib/fmh_gpib.c
index 4138f3d2bae7..164dcfc3c9ef 100644
--- a/drivers/staging/gpib/fmh_gpib/fmh_gpib.c
+++ b/drivers/staging/gpib/fmh_gpib/fmh_gpib.c
@@ -523,7 +523,7 @@ static int fmh_gpib_accel_write(struct gpib_board *board, u8 *buffer,
 	}
 	if (retval < 0)
 		return retval;
-	//handle sending of last byte with eoi
+	// handle sending of last byte with eoi
 	if (send_eoi) {
 		size_t num_bytes;
 
diff --git a/drivers/staging/gpib/gpio/gpib_bitbang.c b/drivers/staging/gpib/gpio/gpib_bitbang.c
index 17884810fd69..22a55f3f794d 100644
--- a/drivers/staging/gpib/gpio/gpib_bitbang.c
+++ b/drivers/staging/gpib/gpio/gpib_bitbang.c
@@ -277,8 +277,8 @@ struct bb_priv {
 	int ndac_mode;	     /* nrfd interrupt mode 0/1 -> edge/levels */
 	int dav_tx;	     /* keep trace of DAV status while sending */
 	int dav_rx;	     /* keep trace of DAV status while receiving */
-	u8 eos;	     // eos character
-	short eos_flags;     // eos mode
+	u8 eos;              /* eos character */
+	short eos_flags;     /* eos mode */
 	short eos_check;     /* eos check required in current operation ... */
 	short eos_check_8;   /* ... with byte comparison */
 	short eos_mask_7;    /* ... with 7 bit masked character */
@@ -290,14 +290,14 @@ struct bb_priv {
 	u8 *rbuf;
 	u8 *wbuf;
 	int end_flag;
-	int r_busy;	   /* 0==idle	1==busy	 */
+	int r_busy;	      /* 0==idle   1==busy */
 	int w_busy;
 	int write_done;
-	int cmd;	   /* 1 = cmd write in	progress */
+	int cmd;	      /* 1 = cmd write in progress */
 	size_t w_cnt;
 	size_t length;
 	u8 *w_buf;
-	spinlock_t rw_lock; // protect mods to rw_lock
+	spinlock_t rw_lock;   /* protect mods to rw_lock */
 	int phase;
 	int ndac_idle;
 	int ndac_seq;
@@ -1462,8 +1462,8 @@ static inline void SET_DIR_READ(struct bb_priv *priv)
 		gpiod_set_value(TE, 0);	 /* set NDAC and NRFD to transmit and DAV to receive */
 	}
 
-	gpiod_direction_output(NRFD, 0);  // hold off the talker
-	gpiod_direction_output(NDAC, 0);  // data not accepted
+	gpiod_direction_output(NRFD, 0); /* hold off the talker */
+	gpiod_direction_output(NDAC, 0); /* data not accepted */
 
 	priv->direction = DIR_READ;
 }
diff --git a/drivers/staging/gpib/hp_82341/hp_82341.c b/drivers/staging/gpib/hp_82341/hp_82341.c
index e5c1997ce7d9..1a2ad0560e14 100644
--- a/drivers/staging/gpib/hp_82341/hp_82341.c
+++ b/drivers/staging/gpib/hp_82341/hp_82341.c
@@ -38,7 +38,7 @@ static int hp_82341_accel_read(struct gpib_board *board, u8 *buffer, size_t leng
 	unsigned short event_status;
 	int i;
 	int num_fifo_bytes;
-	//hardware doesn't support checking for end-of-string character when using fifo
+	// hardware doesn't support checking for end-of-string character when using fifo
 	if (tms_priv->eos_flags & REOS)
 		return tms9914_read(board, tms_priv, buffer, length, end, bytes_read);
 
@@ -49,7 +49,7 @@ static int hp_82341_accel_read(struct gpib_board *board, u8 *buffer, size_t leng
 	*bytes_read = 0;
 	if (length == 0)
 		return 0;
-	//disable fifo for the moment
+	// disable fifo for the moment
 	outb(DIRECTION_GPIB_TO_HOST_BIT, hp_priv->iobase[3] + BUFFER_CONTROL_REG);
 	/*
 	 * Handle corner case of board not in holdoff and one byte has slipped in already.
@@ -154,7 +154,7 @@ static int restart_write_fifo(struct gpib_board *board, struct hp_82341_priv *hp
 	while (1) {
 		int status;
 
-		//restart doesn't work if data holdoff is in effect
+		// restart doesn't work if data holdoff is in effect
 		status = tms9914_line_status(board, tms_priv);
 		if ((status & BUS_NRFD) == 0) {
 			outb(RESTART_STREAM_BIT, hp_priv->iobase[0] + STREAM_STATUS_REG);
@@ -764,7 +764,7 @@ static int hp_82341_attach(struct gpib_board *board, const struct gpib_board_con
 	     ENABLE_TI_INTERRUPT_EVENT_BIT, hp_priv->iobase[0] +  EVENT_ENABLE_REG);
 	outb(ENABLE_BUFFER_END_INTERRUPT_BIT | ENABLE_TERMINAL_COUNT_INTERRUPT_BIT |
 	     ENABLE_TI_INTERRUPT_BIT, hp_priv->iobase[0] + INTERRUPT_ENABLE_REG);
-	//write clear event register
+	// write clear event register
 	outb((TI_INTERRUPT_EVENT_BIT | POINTERS_EQUAL_EVENT_BIT |
 	      BUFFER_END_EVENT_BIT | TERMINAL_COUNT_EVENT_BIT),
 	     hp_priv->iobase[0] + EVENT_STATUS_REG);
@@ -867,7 +867,7 @@ static irqreturn_t hp_82341_interrupt(int irq, void *arg)
 	event_status = inb(hp_priv->iobase[0] + EVENT_STATUS_REG);
 	if (event_status & INTERRUPT_PENDING_EVENT_BIT)
 		retval = IRQ_HANDLED;
-	//write-clear status bits
+	// write-clear status bits
 	if (event_status & (TI_INTERRUPT_EVENT_BIT | POINTERS_EQUAL_EVENT_BIT |
 			    BUFFER_END_EVENT_BIT | TERMINAL_COUNT_EVENT_BIT)) {
 		outb(event_status & (TI_INTERRUPT_EVENT_BIT | POINTERS_EQUAL_EVENT_BIT |
@@ -901,7 +901,7 @@ static void set_transfer_counter(struct hp_82341_priv *hp_priv, int count)
 
 	outb(complement & 0xff, hp_priv->iobase[1] + TRANSFER_COUNT_LOW_REG);
 	outb((complement >> 8) & 0xff, hp_priv->iobase[1] + TRANSFER_COUNT_MID_REG);
-	//I don't think the hi count reg is even used, but oh well
+	// I don't think the hi count reg is even used, but oh well
 	outb((complement >> 16) & 0xf, hp_priv->iobase[1] + TRANSFER_COUNT_HIGH_REG);
 }
 
diff --git a/drivers/staging/gpib/hp_82341/hp_82341.h b/drivers/staging/gpib/hp_82341/hp_82341.h
index 370a3d4576eb..859ef2899acb 100644
--- a/drivers/staging/gpib/hp_82341/hp_82341.h
+++ b/drivers/staging/gpib/hp_82341/hp_82341.h
@@ -65,7 +65,7 @@ enum config_control_status_bits {
 	IRQ_SELECT_MASK = 0x7,
 	DMA_CONFIG_MASK = 0x18,
 	ENABLE_DMA_CONFIG_BIT = 0x20,
-	XILINX_READY_BIT = 0x40,	//read only
+	XILINX_READY_BIT = 0x40,	// read only
 	DONE_PGL_BIT = 0x80
 };
 
@@ -94,7 +94,7 @@ static inline unsigned int IRQ_SELECT_BITS(int irq)
 };
 
 enum mode_control_status_bits {
-	SLOT8_BIT = 0x1,	// read only
+	SLOT8_BIT = 0x1,		// read only
 	ACTIVE_CONTROLLER_BIT = 0x2,	// read only
 	ENABLE_DMA_BIT = 0x4,
 	SYSTEM_CONTROLLER_BIT = 0x8,
@@ -106,12 +106,12 @@ enum mode_control_status_bits {
 enum monitor_bits {
 	MONITOR_INTERRUPT_PENDING_BIT = 0x1,	// read only
 	MONITOR_CLEAR_HOLDOFF_BIT = 0x2,	// write only
-	MONITOR_PPOLL_BIT = 0x4,	// write clear
-	MONITOR_SRQ_BIT = 0x8,	// write clear
-	MONITOR_IFC_BIT = 0x10,	// write clear
-	MONITOR_REN_BIT = 0x20,	// write clear
-	MONITOR_END_BIT = 0x40,	// write clear
-	MONITOR_DAV_BIT = 0x80	// write clear
+	MONITOR_PPOLL_BIT = 0x4,		// write clear
+	MONITOR_SRQ_BIT = 0x8,			// write clear
+	MONITOR_IFC_BIT = 0x10,			// write clear
+	MONITOR_REN_BIT = 0x20,			// write clear
+	MONITOR_END_BIT = 0x40,			// write clear
+	MONITOR_DAV_BIT = 0x80			// write clear
 };
 
 enum interrupt_enable_bits {
@@ -123,36 +123,36 @@ enum interrupt_enable_bits {
 };
 
 enum event_status_bits {
-	TI_INTERRUPT_EVENT_BIT = 0x1,	//write clear
+	TI_INTERRUPT_EVENT_BIT = 0x1,		// write clear
 	INTERRUPT_PENDING_EVENT_BIT = 0x2,	// read only
-	POINTERS_EQUAL_EVENT_BIT = 0x4,	//write clear
-	BUFFER_END_EVENT_BIT = 0x10,	//write clear
+	POINTERS_EQUAL_EVENT_BIT = 0x4,		// write clear
+	BUFFER_END_EVENT_BIT = 0x10,		// write clear
 	TERMINAL_COUNT_EVENT_BIT = 0x20,	// write clear
 	DMA_TERMINAL_COUNT_EVENT_BIT = 0x80,	// write clear
 };
 
 enum event_enable_bits {
-	ENABLE_TI_INTERRUPT_EVENT_BIT = 0x1,	//write clear
-	ENABLE_POINTERS_EQUAL_EVENT_BIT = 0x4,	//write clear
-	ENABLE_BUFFER_END_EVENT_BIT = 0x10,	//write clear
-	ENABLE_TERMINAL_COUNT_EVENT_BIT = 0x20,	// write clear
+	ENABLE_TI_INTERRUPT_EVENT_BIT = 0x1,		// write clear
+	ENABLE_POINTERS_EQUAL_EVENT_BIT = 0x4,		// write clear
+	ENABLE_BUFFER_END_EVENT_BIT = 0x10,		// write clear
+	ENABLE_TERMINAL_COUNT_EVENT_BIT = 0x20,		// write clear
 	ENABLE_DMA_TERMINAL_COUNT_EVENT_BIT = 0x80,	// write clear
 };
 
 enum stream_status_bits {
-	HALTED_STATUS_BIT = 0x1,	//read
-	RESTART_STREAM_BIT = 0x1	//write
+	HALTED_STATUS_BIT = 0x1,	// read
+	RESTART_STREAM_BIT = 0x1	// write
 };
 
 enum buffer_control_bits {
 	DIRECTION_GPIB_TO_HOST_BIT = 0x20,	// transfer direction (set for gpib to host)
-	ENABLE_TI_BUFFER_BIT = 0x40,	//enable fifo
-	FAST_WR_EN_BIT = 0x80,	// 350 ns t1 delay?
+	ENABLE_TI_BUFFER_BIT = 0x40,		// enable fifo
+	FAST_WR_EN_BIT = 0x80,			// 350 ns t1 delay?
 };
 
 // registers accessible through isapnp chip on 82341d
 enum hp_82341d_pnp_registers {
-	PIO_DATA_REG = 0x20,	//read/write pio data lines
+	PIO_DATA_REG = 0x20,		// read/write pio data lines
 	PIO_DIRECTION_REG = 0x21,	// set pio data line directions (set for input)
 };
 
diff --git a/drivers/staging/gpib/include/amccs5933.h b/drivers/staging/gpib/include/amccs5933.h
index 4de0f6797458..d7f63c795096 100644
--- a/drivers/staging/gpib/include/amccs5933.h
+++ b/drivers/staging/gpib/include/amccs5933.h
@@ -24,7 +24,7 @@ extern inline int INCOMING_MAILBOX_REG(unsigned int mailbox)
 enum {
 	OUTBOX_EMPTY_INTR_BIT = 0x10,	// enable outbox empty interrupt
 	INBOX_FULL_INTR_BIT = 0x1000,	// enable inbox full interrupt
-	INBOX_INTR_CS_BIT = 0x20000, // read, or write clear inbox full interrupt
+	INBOX_INTR_CS_BIT = 0x20000,	// read, or write clear inbox full interrupt
 	INTR_ASSERTED_BIT = 0x800000,	// read only, interrupt asserted
 };
 
@@ -52,7 +52,7 @@ extern inline int OUTBOX_SELECT_BITS(unsigned int mailbox)
 	return (mailbox & 0x3) << 2;
 };
 
-//BMCSR bits
+// BMCSR bits
 enum {
 	MBOX_FLAGS_RESET_BIT = 0x08000000,	// resets mailbox empty/full flags
 };
diff --git a/drivers/staging/gpib/include/gpib_types.h b/drivers/staging/gpib/include/gpib_types.h
index db040c80d778..998abb379749 100644
--- a/drivers/staging/gpib/include/gpib_types.h
+++ b/drivers/staging/gpib/include/gpib_types.h
@@ -273,7 +273,8 @@ struct gpib_board {
 	struct mutex big_gpib_mutex;
 	/* pid of last process to lock the board mutex */
 	pid_t locking_pid;
-	spinlock_t locking_pid_spinlock; // lock for setting locking pid
+	/* lock for setting locking pid */
+	spinlock_t locking_pid_spinlock;
 	/* Spin lock for dealing with races with the interrupt handler */
 	spinlock_t spinlock;
 	/* Watchdog timer to enable timeouts */
diff --git a/drivers/staging/gpib/include/nec7210.h b/drivers/staging/gpib/include/nec7210.h
index 312217b4580e..9835aa5ef4ff 100644
--- a/drivers/staging/gpib/include/nec7210.h
+++ b/drivers/staging/gpib/include/nec7210.h
@@ -22,18 +22,18 @@ struct nec7210_priv {
 	u32 iobase;
 #endif
 	void __iomem *mmiobase;
-	unsigned int offset;	// offset between successive nec7210 io addresses
+	unsigned int offset;		// offset between successive nec7210 io addresses
 	unsigned int dma_channel;
 	u8 *dma_buffer;
 	unsigned int dma_buffer_length;	// length of dma buffer
 	dma_addr_t dma_buffer_addr;	// bus address of board->buffer for use with dma
 	// software copy of bits written to registers
 	u8 reg_bits[8];
-	u8 auxa_bits;	// bits written to auxiliary register A
-	u8 auxb_bits;	// bits written to auxiliary register B
+	u8 auxa_bits;			// bits written to auxiliary register A
+	u8 auxb_bits;			// bits written to auxiliary register B
 	// used to keep track of board's state, bit definitions given below
 	unsigned long state;
-	/* lock for chips that extend the nec7210 registers by paging in alternate regs */
+	// lock for chips that extend the nec7210 registers by paging in alternate regs
 	spinlock_t register_page_lock;
 	// wrappers for outb, inb, readb, or writeb
 	u8 (*read_byte)(struct nec7210_priv *priv, unsigned int register_number);
@@ -64,17 +64,17 @@ static inline void write_byte(struct nec7210_priv *priv, u8 byte, unsigned int r
 
 // struct nec7210_priv.state bit numbers
 enum {
-	PIO_IN_PROGRESS_BN,	// pio transfer in progress
+	PIO_IN_PROGRESS_BN,		// pio transfer in progress
 	DMA_READ_IN_PROGRESS_BN,	// dma read transfer in progress
 	DMA_WRITE_IN_PROGRESS_BN,	// dma write transfer in progress
-	READ_READY_BN,	// board has data byte available to read
-	WRITE_READY_BN,	// board is ready to send a data byte
-	COMMAND_READY_BN,	// board is ready to send a command byte
-	RECEIVED_END_BN,	// received END
-	BUS_ERROR_BN,	// output error has occurred
-	RFD_HOLDOFF_BN,	// rfd holdoff in effect
-	DEV_CLEAR_BN,	// device clear received
-	ADR_CHANGE_BN,	// address state change occurred
+	READ_READY_BN,			// board has data byte available to read
+	WRITE_READY_BN,			// board is ready to send a data byte
+	COMMAND_READY_BN,		// board is ready to send a command byte
+	RECEIVED_END_BN,		// received END
+	BUS_ERROR_BN,			// output error has occurred
+	RFD_HOLDOFF_BN,			// rfd holdoff in effect
+	DEV_CLEAR_BN,			// device clear received
+	ADR_CHANGE_BN,			// address state change occurred
 };
 
 // interface functions
diff --git a/drivers/staging/gpib/include/nec7210_registers.h b/drivers/staging/gpib/include/nec7210_registers.h
index 97c53ac8e805..067983d7a07f 100644
--- a/drivers/staging/gpib/include/nec7210_registers.h
+++ b/drivers/staging/gpib/include/nec7210_registers.h
@@ -11,7 +11,7 @@ enum nec7210_chipset {
 	NEC7210,	// The original
 	TNT4882,	// NI
 	NAT4882,	// NI
-	CB7210,	// measurement computing
+	CB7210,		// measurement computing
 	IOT7210,	// iotech
 	IGPIB7210,	// Ines
 	TNT5004,	// NI (minor differences to TNT4882)
@@ -48,7 +48,7 @@ enum nec7210_read_regs {
 	ADR1,	// address 2
 };
 
-//bit definitions common to nec-7210 compatible registers
+// bit definitions common to nec-7210 compatible registers
 
 // ISR1: interrupt status register 1
 enum isr1_bits {
diff --git a/drivers/staging/gpib/include/plx9050.h b/drivers/staging/gpib/include/plx9050.h
index 66c56335f5c0..c911b285a0ca 100644
--- a/drivers/staging/gpib/include/plx9050.h
+++ b/drivers/staging/gpib/include/plx9050.h
@@ -23,10 +23,10 @@ enum plx9050_intcsr_bits {
 	PLX9050_LINTR2_STATUS_BIT = 0x20,
 	PLX9050_PCI_INTR_EN_BIT = 0x40,
 	PLX9050_SOFT_INTR_BIT = 0x80,
-	PLX9050_LINTR1_SELECT_ENABLE_BIT = 0x100,	//9052 extension
-	PLX9050_LINTR2_SELECT_ENABLE_BIT = 0x200,	//9052 extension
-	PLX9050_LINTR1_EDGE_CLEAR_BIT = 0x400,	//9052 extension
-	PLX9050_LINTR2_EDGE_CLEAR_BIT = 0x800,	//9052 extension
+	PLX9050_LINTR1_SELECT_ENABLE_BIT = 0x100,	// 9052 extension
+	PLX9050_LINTR2_SELECT_ENABLE_BIT = 0x200,	// 9052 extension
+	PLX9050_LINTR1_EDGE_CLEAR_BIT = 0x400,		// 9052 extension
+	PLX9050_LINTR2_EDGE_CLEAR_BIT = 0x800,		// 9052 extension
 };
 
 enum plx9050_cntrl_bits {
diff --git a/drivers/staging/gpib/include/tms9914.h b/drivers/staging/gpib/include/tms9914.h
index 50a9d3b22619..e66b75e0fda8 100644
--- a/drivers/staging/gpib/include/tms9914.h
+++ b/drivers/staging/gpib/include/tms9914.h
@@ -30,10 +30,10 @@ struct tms9914_priv {
 	u8 imr0_bits, imr1_bits;
 	// bits written to address mode register
 	u8 admr_bits;
-	u8 auxa_bits;	// bits written to auxiliary register A
+	u8 auxa_bits;		// bits written to auxiliary register A
 	// used to keep track of board's state, bit definitions given below
 	unsigned long state;
-	u8 eos;	// eos character
+	u8 eos;			// eos character
 	short eos_flags;
 	u8 spoll_status;
 	enum tms9914_holdoff_mode holdoff_mode;
@@ -67,15 +67,15 @@ static inline void write_byte(struct tms9914_priv *priv, u8 byte, unsigned int r
 
 // struct tms9914_priv.state bit numbers
 enum {
-	PIO_IN_PROGRESS_BN,	// pio transfer in progress
+	PIO_IN_PROGRESS_BN,		// pio transfer in progress
 	DMA_READ_IN_PROGRESS_BN,	// dma read transfer in progress
 	DMA_WRITE_IN_PROGRESS_BN,	// dma write transfer in progress
-	READ_READY_BN,	// board has data byte available to read
-	WRITE_READY_BN,	// board is ready to send a data byte
-	COMMAND_READY_BN,	// board is ready to send a command byte
-	RECEIVED_END_BN,	// received END
-	BUS_ERROR_BN,	// bus error
-	DEV_CLEAR_BN,	// device clear received
+	READ_READY_BN,			// board has data byte available to read
+	WRITE_READY_BN,			// board is ready to send a data byte
+	COMMAND_READY_BN,		// board is ready to send a command byte
+	RECEIVED_END_BN,		// received END
+	BUS_ERROR_BN,			// bus error
+	DEV_CLEAR_BN,			// device clear received
 };
 
 // interface functions
@@ -150,23 +150,23 @@ enum {
 	IMR0 = 0,	/* interrupt mask 0          */
 	IMR1 = 1,	/* interrupt mask 1          */
 	AUXCR = 3,	/* auxiliary command         */
-	ADR = 4,	// address register
-	SPMR = 5,	// serial poll mode register
+	ADR = 4,	/* address register	     */
+	SPMR = 5,	/* serial poll mode register */
 	PPR = 6,	/* parallel poll             */
 	CDOR = 7,	/* data out register         */
 };
 
 // read registers
 enum {
-	ISR0 = 0,	/* interrupt status 0          */
-	ISR1 = 1,	/* interrupt status 1          */
-	ADSR = 2,	/* address status               */
-	BSR = 3,	/* bus status */
-	CPTR = 6,	/* command pass thru           */
-	DIR = 7,	/* data in register            */
+	ISR0 = 0,	/* interrupt status 0	     */
+	ISR1 = 1,	/* interrupt status 1	     */
+	ADSR = 2,	/* address status	     */
+	BSR = 3,	/* bus status		     */
+	CPTR = 6,	/* command pass thru	     */
+	DIR = 7,	/* data in register          */
 };
 
-//bit definitions common to tms9914 compatible registers
+// bit definitions common to tms9914 compatible registers
 
 /* ISR0   - Register bits */
 enum isr0_bits {
@@ -248,33 +248,33 @@ enum bus_status_bits {
 /*---------------------------------------------------------*/
 
 enum aux_cmd_bits {
-	AUX_CS = 0x80,	/* set bit instead of clearing it, used with commands marked 'd' below */
-	AUX_CHIP_RESET = 0x0,	/* d Chip reset                   */
-	AUX_INVAL = 0x1,	// release dac holdoff, invalid command byte
-	AUX_VAL = (AUX_INVAL | AUX_CS),	// release dac holdoff, valid command byte
-	AUX_RHDF = 0x2,	/* X Release RFD holdoff          */
-	AUX_HLDA = 0x3,	/* d holdoff on all data          */
-	AUX_HLDE = 0x4,	/* d holdoff on EOI only          */
-	AUX_NBAF = 0x5,	/* X Set new byte available false */
-	AUX_FGET = 0x6,	/* d force GET                    */
-	AUX_RTL = 0x7,	/* d return to local              */
-	AUX_SEOI = 0x8,	/* X send EOI with next byte      */
-	AUX_LON = 0x9,	/* d Listen only                  */
-	AUX_TON = 0xa,	/* d Talk only                    */
-	AUX_GTS = 0xb,	/* X goto standby                 */
-	AUX_TCA = 0xc,	/* X take control asynchronously  */
-	AUX_TCS = 0xd,	/* X take    "     synchronously  */
-	AUX_RPP = 0xe,	/* d Request parallel poll        */
-	AUX_SIC = 0xf,	/* d send interface clear         */
-	AUX_SRE = 0x10,	/* d send remote enable           */
-	AUX_RQC = 0x11,	/* X request control              */
-	AUX_RLC = 0x12,	/* X release control              */
-	AUX_DAI = 0x13,	/* d disable all interrupts       */
-	AUX_PTS = 0x14,	/* X pass through next secondary  */
-	AUX_STDL = 0x15,	/* d short T1 delay                 */
-	AUX_SHDW = 0x16,	/* d shadow handshake             */
-	AUX_VSTDL = 0x17,	/* d very short T1 delay (smj9914 extension) */
-	AUX_RSV2 = 0x18,	/* d request service bit 2 (smj9914 extension) */
+	AUX_CS = 0x80,			/* set bit instead of clearing it, used with commands marked 'd' below */
+	AUX_CHIP_RESET = 0x0,		/* d Chip reset                   */
+	AUX_INVAL = 0x1,		/* release dac holdoff, invalid command byte */
+	AUX_VAL = (AUX_INVAL | AUX_CS),	/* release dac holdoff, valid command byte   */
+	AUX_RHDF = 0x2,			/* X Release RFD holdoff          */
+	AUX_HLDA = 0x3,			/* d holdoff on all data          */
+	AUX_HLDE = 0x4,			/* d holdoff on EOI only          */
+	AUX_NBAF = 0x5,			/* X Set new byte available false */
+	AUX_FGET = 0x6,			/* d force GET                    */
+	AUX_RTL = 0x7,			/* d return to local              */
+	AUX_SEOI = 0x8,			/* X send EOI with next byte      */
+	AUX_LON = 0x9,			/* d Listen only                  */
+	AUX_TON = 0xa,			/* d Talk only                    */
+	AUX_GTS = 0xb,			/* X goto standby                 */
+	AUX_TCA = 0xc,			/* X take control asynchronously  */
+	AUX_TCS = 0xd,			/* X take    "     synchronously  */
+	AUX_RPP = 0xe,			/* d Request parallel poll        */
+	AUX_SIC = 0xf,			/* d send interface clear         */
+	AUX_SRE = 0x10,			/* d send remote enable           */
+	AUX_RQC = 0x11,			/* X request control              */
+	AUX_RLC = 0x12,			/* X release control              */
+	AUX_DAI = 0x13,			/* d disable all interrupts       */
+	AUX_PTS = 0x14,			/* X pass through next secondary  */
+	AUX_STDL = 0x15,		/* d short T1 delay		  */
+	AUX_SHDW = 0x16,		/* d shadow handshake             */
+	AUX_VSTDL = 0x17,		/* d very short T1 delay (smj9914 extension)   */
+	AUX_RSV2 = 0x18,		/* d request service bit 2 (smj9914 extension) */
 };
 
 #endif	//_TMS9914_H
diff --git a/drivers/staging/gpib/include/tnt4882_registers.h b/drivers/staging/gpib/include/tnt4882_registers.h
index 1b1441cd03d5..d54c4cc61168 100644
--- a/drivers/staging/gpib/include/tnt4882_registers.h
+++ b/drivers/staging/gpib/include/tnt4882_registers.h
@@ -32,11 +32,11 @@ enum {
 	CMDR = 0x1c,	// command register
 	TIMER = 0x1e,	// timer register
 
-	STS1 = 0x10,		/* T488 Status Register 1 */
-	STS2 = 0x1c,		/* T488 Status Register 2 */
+	STS1 = 0x10,	// T488 Status Register 1
+	STS2 = 0x1c,	// T488 Status Register 2
 	ISR0 = IMR0,
-	ISR3 = 0x1a,		/* T488 Interrupt Status Register 3 */
-	BCR = 0x1f,		/* bus control/status register */
+	ISR3 = 0x1a,	// T488 Interrupt Status Register 3
+	BCR = 0x1f,	// bus control/status register
 	BSR = BCR,
 };
 
@@ -107,11 +107,11 @@ enum imr0_bits {
 
 /* ISR0 -- Interrupt Status Register 0 */
 enum isr0_bits {
-	TNT_SYNC_BIT = 0x1, /* handshake sync */
-	TNT_TO_BIT = 0x2, /* timeout */
-	TNT_ATNI_BIT = 0x4, /* ATN interrupt */
+	TNT_SYNC_BIT = 0x1,	/* handshake sync */
+	TNT_TO_BIT = 0x2,	/* timeout */
+	TNT_ATNI_BIT = 0x4,	/* ATN interrupt */
 	TNT_IFCI_BIT = 0x8,	/* interface clear interrupt */
-	TNT_EOS_BIT = 0x10, /* end of string */
+	TNT_EOS_BIT = 0x10,	/* end of string */
 	TNT_NL_BIT = 0x20,	/* new line receive */
 	TNT_STBO_BIT = 0x40,	/* status byte out  */
 	TNT_NBA_BIT = 0x80,	/* new byte available */
@@ -129,7 +129,7 @@ enum isr3_bits {
 };
 
 enum keyreg_bits {
-	MSTD = 0x20,	// enable 350ns T1 delay
+	MSTD = 0x20,	/* enable 350ns T1 delay */
 };
 
 /* STS1 -- Status Register 1 (read only) */
@@ -157,7 +157,7 @@ enum tnt4882_aux_cmds {
 	AUX_9914 = 0x15,	// switch to 9914 mode
 	AUX_REQT = 0x18,
 	AUX_REQF = 0x19,
-	AUX_PAGEIN = 0x50,	/* page in alternate registers */
+	AUX_PAGEIN = 0x50,	// page in alternate registers
 	AUX_HLDI = 0x51,	// rfd holdoff immediately
 	AUX_CLEAR_END = 0x55,
 	AUX_7210 = 0x99,	// switch to 7210 mode
@@ -183,7 +183,7 @@ enum auxi_bits {
 
 enum sasr_bits {
 	ACRDY_BIT = 0x4,	/* acceptor ready state */
-	ADHS_BIT = 0x8,	/* acceptor data holdoff state */
+	ADHS_BIT = 0x8,		/* acceptor data holdoff state */
 	ANHS2_BIT = 0x10,	/* acceptor not ready holdoff immediately state */
 	ANHS1_BIT = 0x20,	/* acceptor not ready holdoff state */
 	AEHS_BIT = 0x40,	/* acceptor end holdoff state */
diff --git a/drivers/staging/gpib/ines/ines.h b/drivers/staging/gpib/ines/ines.h
index f0210ce2470d..6ad57e9a1216 100644
--- a/drivers/staging/gpib/ines/ines.h
+++ b/drivers/staging/gpib/ines/ines.h
@@ -97,9 +97,9 @@ enum extend_mode_bits {
 	TR3_TRIG_ENABLE_BIT = 0x1,	// enable generation of trigger pulse T/R3 pin
 	// clear message available status bit when chip writes byte with EOI true
 	MAV_ENABLE_BIT = 0x2,
-	EOS1_ENABLE_BIT = 0x4,	// enable eos register 1
-	EOS2_ENABLE_BIT = 0x8,	// enable eos register 2
-	EOIDIS_BIT = 0x10,	// disable EOI interrupt when doing rfd holdoff on end?
+	EOS1_ENABLE_BIT = 0x4,		// enable eos register 1
+	EOS2_ENABLE_BIT = 0x8,		// enable eos register 2
+	EOIDIS_BIT = 0x10,		// disable EOI interrupt when doing rfd holdoff on end?
 	XFER_COUNTER_ENABLE_BIT = 0x20,
 	XFER_COUNTER_OUTPUT_BIT = 0x40,	// use counter for output, clear for input
 	// when xfer counter hits 0, assert EOI on write or RFD holdoff on read
@@ -121,10 +121,10 @@ enum ines_admr_bits {
 };
 
 enum xdma_control_bits {
-	DMA_OUTPUT_BIT = 0x1,	// use dma for output, clear for input
+	DMA_OUTPUT_BIT = 0x1,		// use dma for output, clear for input
 	ENABLE_SYNC_DMA_BIT = 0x2,
-	DMA_ACCESS_EVERY_CYCLE = 0x4,// dma accesses fifo every cycle, clear for every other cycle
-	DMA_16BIT = 0x8,	// clear for 8 bit transfers
+	DMA_ACCESS_EVERY_CYCLE = 0x4,	// dma accesses fifo every cycle, clear for every other cycle
+	DMA_16BIT = 0x8,		// clear for 8 bit transfers
 };
 
 enum bus_control_monitor_bits {
diff --git a/drivers/staging/gpib/ines/ines_gpib.c b/drivers/staging/gpib/ines/ines_gpib.c
index c851fd014f48..a3cf846fd0f9 100644
--- a/drivers/staging/gpib/ines/ines_gpib.c
+++ b/drivers/staging/gpib/ines/ines_gpib.c
@@ -152,7 +152,7 @@ static int ines_accel_read(struct gpib_board *board, u8 *buffer,
 
 	write_byte(nec_priv, INES_RFD_HLD_IMMEDIATE, AUXMR);
 
-	//clear in fifo
+	// clear in fifo
 	nec7210_set_reg_bits(nec_priv, ADMR, IN_FIFO_ENABLE_BIT, 0);
 	nec7210_set_reg_bits(nec_priv, ADMR, IN_FIFO_ENABLE_BIT, IN_FIFO_ENABLE_BIT);
 
@@ -225,7 +225,7 @@ static int ines_accel_write(struct gpib_board *board, u8 *buffer, size_t length,
 	unsigned int num_bytes, i;
 
 	*bytes_written = 0;
-	//clear out fifo
+	// clear out fifo
 	nec7210_set_reg_bits(nec_priv, ADMR, OUT_FIFO_ENABLE_BIT, 0);
 	nec7210_set_reg_bits(nec_priv, ADMR, OUT_FIFO_ENABLE_BIT, OUT_FIFO_ENABLE_BIT);
 
diff --git a/drivers/staging/gpib/nec7210/nec7210.c b/drivers/staging/gpib/nec7210/nec7210.c
index 34a1cae4f486..bbf39367f5e4 100644
--- a/drivers/staging/gpib/nec7210/nec7210.c
+++ b/drivers/staging/gpib/nec7210/nec7210.c
@@ -779,10 +779,10 @@ int nec7210_write(struct gpib_board *board, struct nec7210_priv *priv,
 
 	*bytes_written = 0;
 
-	clear_bit(DEV_CLEAR_BN, &priv->state); //XXX
+	clear_bit(DEV_CLEAR_BN, &priv->state); // XXX
 
 	if (send_eoi)
-		length-- ; /* save the last byte for sending EOI */
+		length-- ; // save the last byte for sending EOI
 
 	if (length > 0)	{
 		// isa dma transfer
@@ -1005,7 +1005,7 @@ void nec7210_board_online(struct nec7210_priv *priv, const struct gpib_board *bo
 	nec7210_primary_address(board, priv, board->pad);
 	nec7210_secondary_address(board, priv, board->sad, board->sad >= 0);
 
-	// enable interrupts
+	/* enable interrupts */
 	priv->reg_bits[IMR1] = HR_ERRIE | HR_DECIE | HR_ENDIE |
 		HR_DETIE | HR_CPTIE | HR_DOIE | HR_DIIE;
 	priv->reg_bits[IMR2] = IMR2_ENABLE_INTR_MASK;
diff --git a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
index 73ea72f34c0a..4dec87d12687 100644
--- a/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
+++ b/drivers/staging/gpib/ni_usb/ni_usb_gpib.c
@@ -29,7 +29,7 @@ static void ni_usb_stop(struct ni_usb_priv *ni_priv);
 
 static DEFINE_MUTEX(ni_usb_hotplug_lock);
 
-//calculates a reasonable timeout in that can be passed to usb functions
+// calculates a reasonable timeout in that can be passed to usb functions
 static inline unsigned long ni_usb_timeout_msecs(unsigned int usec)
 {
 	if (usec == 0)
@@ -327,7 +327,7 @@ static void ni_usb_soft_update_status(struct gpib_board *board, unsigned int ni_
 	board->status &= ~clear_mask;
 	board->status &= ~ni_usb_ibsta_mask;
 	board->status |= ni_usb_ibsta & ni_usb_ibsta_mask;
-	//FIXME should generate events on DTAS and DCAS
+	// FIXME should generate events on DTAS and DCAS
 
 	spin_lock_irqsave(&board->spinlock, flags);
 /* remove set status bits from monitored set why ?***/
@@ -569,7 +569,7 @@ static int ni_usb_write_registers(struct ni_usb_priv *ni_priv,
 	mutex_unlock(&ni_priv->addressed_transfer_lock);
 
 	ni_usb_parse_reg_write_status_block(in_data, &status, &reg_writes_completed);
-	//FIXME parse extra 09 status bits and termination
+	// FIXME parse extra 09 status bits and termination
 	kfree(in_data);
 	if (status.id != NIUSB_REG_WRITE_ID) {
 		dev_err(&usb_dev->dev, "parse error, id=0x%x != NIUSB_REG_WRITE_ID\n", status.id);
@@ -1106,7 +1106,7 @@ static int ni_usb_request_system_control(struct gpib_board *board, int request_c
 	return 0;
 }
 
-//FIXME maybe the interface should have a "pulse interface clear" function that can return an error?
+// FIXME maybe the interface should have a "pulse interface clear" function that can return an error?
 static void ni_usb_interface_clear(struct gpib_board *board, int assert)
 {
 	int retval;
@@ -1363,7 +1363,7 @@ static int ni_usb_parallel_poll(struct gpib_board *board, u8 *result)
 		return -ENOMEM;
 
 	out_data[i++] = NIUSB_IBRPP_ID;
-	out_data[i++] = 0xf0;	//FIXME: this should be the parallel poll timeout code
+	out_data[i++] = 0xf0;	// FIXME: this should be the parallel poll timeout code
 	out_data[i++] = 0x0;
 	out_data[i++] = 0x0;
 	i += ni_usb_bulk_termination(&out_data[i]);
diff --git a/drivers/staging/gpib/ni_usb/ni_usb_gpib.h b/drivers/staging/gpib/ni_usb/ni_usb_gpib.h
index b011e131201c..688f5e08792f 100644
--- a/drivers/staging/gpib/ni_usb/ni_usb_gpib.h
+++ b/drivers/staging/gpib/ni_usb/ni_usb_gpib.h
@@ -72,10 +72,10 @@ struct ni_usb_priv {
 	struct urb *bulk_urb;
 	struct urb *interrupt_urb;
 	u8 interrupt_buffer[0x11];
-	struct mutex addressed_transfer_lock; // protect transfer lock
-	struct mutex bulk_transfer_lock;  // protect bulk message sends
-	struct mutex control_transfer_lock; // protect control messages
-	struct mutex interrupt_transfer_lock; //  protect interrupt messages
+	struct mutex addressed_transfer_lock;	// protect transfer lock
+	struct mutex bulk_transfer_lock;	// protect bulk message sends
+	struct mutex control_transfer_lock;	// protect control messages
+	struct mutex interrupt_transfer_lock;	//  protect interrupt messages
 	struct timer_list bulk_timer;
 	struct ni_usb_urb_ctx context;
 	int product_id;
@@ -145,7 +145,7 @@ enum ni_usb_error_codes {
 	 * CIC with no listener
 	 */
 	NIUSB_NO_LISTENER_ERROR = 8,
-	// get NIUSB_TIMEOUT_ERROR on board read/write timeout
+	/* get NIUSB_TIMEOUT_ERROR on board read/write timeout */
 	NIUSB_TIMEOUT_ERROR = 10,
 };
 
diff --git a/drivers/staging/gpib/pc2/pc2_gpib.c b/drivers/staging/gpib/pc2/pc2_gpib.c
index 2282492025b7..9f3943d1df66 100644
--- a/drivers/staging/gpib/pc2/pc2_gpib.c
+++ b/drivers/staging/gpib/pc2/pc2_gpib.c
@@ -36,7 +36,7 @@ static const int pc2_2a_iosize = 16;
 static const int pc2a_reg_offset = 0x400;
 static const int pc2_reg_offset = 1;
 
-//interrupt service routine
+// interrupt service routine
 static irqreturn_t pc2_interrupt(int irq, void *arg);
 static irqreturn_t pc2a_interrupt(int irq, void *arg);
 
@@ -593,7 +593,7 @@ static struct gpib_interface pc2a_cb7210_interface = {
 	.parallel_poll_configure =	pc2_parallel_poll_configure,
 	.parallel_poll_response =	pc2_parallel_poll_response,
 	.local_parallel_poll_mode = NULL, // XXX
-	.line_status =	NULL, //XXX
+	.line_status =	NULL, // XXX
 	.update_status =	pc2_update_status,
 	.primary_address =	pc2_primary_address,
 	.secondary_address =	pc2_secondary_address,
diff --git a/drivers/staging/gpib/tms9914/tms9914.c b/drivers/staging/gpib/tms9914/tms9914.c
index 04d57108efc7..0d11b80bb982 100644
--- a/drivers/staging/gpib/tms9914/tms9914.c
+++ b/drivers/staging/gpib/tms9914/tms9914.c
@@ -647,7 +647,7 @@ static void check_my_address_state(struct gpib_board *board,
 	} else if (cmd_byte == MTA(board->pad))	{
 		priv->primary_talk_addressed = 1;
 		if (board->sad < 0)
-			//make active talker
+			// make active talker
 			write_byte(priv, AUX_TON | AUX_CS, AUXCR);
 	} else if (board->sad >= 0 && priv->primary_talk_addressed &&
 		   cmd_byte == MSA(board->sad)) {
@@ -730,7 +730,7 @@ irqreturn_t tms9914_interrupt_have_status(struct gpib_board *board, struct tms99
 	if (status0 & HR_SPAS) {
 		priv->spoll_status &= ~request_service_bit;
 		write_byte(priv, priv->spoll_status, SPMR);
-		//FIXME: set SPOLL status bit
+		// FIXME: set SPOLL status bit
 	}
 	// record service request in status
 	if (status1 & HR_SRQ)
@@ -841,7 +841,7 @@ void tms9914_board_reset(struct tms9914_priv *priv)
 
 	/* parallel poll unconfigure */
 	write_byte(priv, 0, PPR);
-	// request for data holdoff
+	/* request for data holdoff */
 	tms9914_set_holdoff_mode(priv, TMS9914_HOLDOFF_ALL);
 }
 EXPORT_SYMBOL_GPL(tms9914_board_reset);
@@ -852,7 +852,7 @@ void tms9914_online(struct gpib_board *board, struct tms9914_priv *priv)
 	tms9914_primary_address(board, priv, board->pad);
 	tms9914_secondary_address(board, priv, board->sad, board->sad >= 0);
 
-	// enable tms9914 interrupts
+	/* enable tms9914 interrupts */
 	priv->imr0_bits |= HR_MACIE | HR_RLCIE | HR_ENDIE | HR_BOIE | HR_BIIE |
 		HR_SPASIE;
 	priv->imr1_bits |= HR_MAIE | HR_SRQIE | HR_UNCIE | HR_ERRIE | HR_IFCIE |
@@ -861,7 +861,7 @@ void tms9914_online(struct gpib_board *board, struct tms9914_priv *priv)
 	write_byte(priv, priv->imr1_bits, IMR1);
 	write_byte(priv, AUX_DAI, AUXCR);
 
-	// turn off reset state
+	/* turn off reset state */
 	write_byte(priv, AUX_CHIP_RESET, AUXCR);
 }
 EXPORT_SYMBOL_GPL(tms9914_online);
diff --git a/drivers/staging/gpib/tnt4882/mite.h b/drivers/staging/gpib/tnt4882/mite.h
index 522d6b56cb7d..a1fdba9672a0 100644
--- a/drivers/staging/gpib/tnt4882/mite.h
+++ b/drivers/staging/gpib/tnt4882/mite.h
@@ -219,15 +219,15 @@ void mite_list_devices(void);
 #define MITE_AMHOST_A24_BLOCK	        0x3b
 
 enum mite_registers {
-	MITE_IODWBSR = 0xc0, //IO Device Window Base Size Register
-	MITE_CSIGR = 0x460,	//chip signature
-	MITE_IODWBSR_1 = 0xc4, // IO Device Window Base Size Register 1 (used by 6602 boards)
+	MITE_IODWBSR = 0xc0,	// IO Device Window Base Size Register
+	MITE_CSIGR = 0x460,	// chip signature
+	MITE_IODWBSR_1 = 0xc4,	// IO Device Window Base Size Register 1 (used by 6602 boards)
 	MITE_IODWCR_1 = 0xf4
 };
 
 enum MITE_IODWBSR_bits {
-	WENAB = 0x80,	// window enable
-	WENAB_6602 = 0x8c // window enable for 6602 boards
+	WENAB = 0x80,		// window enable
+	WENAB_6602 = 0x8c	// window enable for 6602 boards
 };
 
 #endif
diff --git a/drivers/staging/gpib/tnt4882/tnt4882_gpib.c b/drivers/staging/gpib/tnt4882/tnt4882_gpib.c
index a17b69e34986..29c6884e01fd 100644
--- a/drivers/staging/gpib/tnt4882/tnt4882_gpib.c
+++ b/drivers/staging/gpib/tnt4882/tnt4882_gpib.c
@@ -570,7 +570,7 @@ static irqreturn_t tnt4882_internal_interrupt(struct gpib_board *board)
 
 	if (isr0_bits & TNT_IFCI_BIT)
 		push_gpib_event(board, EVENT_IFC);
-	//XXX don't need this wakeup, one below should do?
+	// XXX don't need this wakeup, one below should do?
 //		wake_up_interruptible(&board->wait);
 
 	if (isr3_bits & HR_NFF)
@@ -730,7 +730,7 @@ static int tnt4882_parallel_poll(struct gpib_board *board, u8 *result)
 	if (tnt_priv->nec7210_priv.type != NEC7210) {
 		tnt_priv->auxg_bits |= RPP2_BIT;
 		write_byte(&tnt_priv->nec7210_priv, tnt_priv->auxg_bits, AUXMR);
-		udelay(2);	//FIXME use parallel poll timeout
+		udelay(2);	// FIXME use parallel poll timeout
 		*result = read_byte(&tnt_priv->nec7210_priv, CPTR);
 		tnt_priv->auxg_bits &= ~RPP2_BIT;
 		write_byte(&tnt_priv->nec7210_priv, tnt_priv->auxg_bits, AUXMR);
-- 
2.50.0


