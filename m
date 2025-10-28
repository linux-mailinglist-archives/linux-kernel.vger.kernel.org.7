Return-Path: <linux-kernel+bounces-873670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C614C14656
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 12:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA30B4265C3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Oct 2025 11:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC36307AFB;
	Tue, 28 Oct 2025 11:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b="n3eMlPvv"
Received: from smtp70.iad3b.emailsrvr.com (smtp70.iad3b.emailsrvr.com [146.20.161.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1010E305948
	for <linux-kernel@vger.kernel.org>; Tue, 28 Oct 2025 11:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=146.20.161.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761651411; cv=none; b=hRYfo2EU8rh7mGaocX4N3swSywCj1Mp3Yq4VounpZZmlSgbYdA1s7HQFbpOXaoLAcG99x3Nvrgsx41/0vrMYj6OBtHAB0PCWgHvcxON0wh4hpe8aaCwsSa4uLRh7x5CYc2+sty6/UZ3umEANzmTo6zeZe5fJ4PFV6T1auG0dTM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761651411; c=relaxed/simple;
	bh=4awWjJKUoUU4MtANdtPYrUHLvN7n+6YrLHLVGj1qDLM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JfVYb6My3SBn2uokYAmJt2yVjPKqPXBUXgqvSv7RMcu0fjjr9+I91uAAjZMS6xYfQ5TcujHOEwVEFonimQi/0IYL98UqGfyLd6f/SyzRaTG/gNRNi7FB123KgFtwhwXT7k+ytzS0QCdkZivEoLWAja6vWOQUyzWPECkm+HB3l1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk; spf=pass smtp.mailfrom=mev.co.uk; dkim=pass (1024-bit key) header.d=mev.co.uk header.i=@mev.co.uk header.b=n3eMlPvv; arc=none smtp.client-ip=146.20.161.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mev.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mev.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
	s=20221208-6x11dpa4; t=1761650926;
	bh=4awWjJKUoUU4MtANdtPYrUHLvN7n+6YrLHLVGj1qDLM=;
	h=From:To:Subject:Date:From;
	b=n3eMlPvv7O3f/b2PSfSklyqelTchJPXyX6fyViSnB64UM9GLGZjIFnIv+Ntb2jW//
	 wr+5KPWbFb7NYimaEyTNwMx7u4YC/GQ0sqjLJW5VfHab8hwH7GnW/A5/vW3cxDfmGg
	 LIk/bEsiOI0QyCGXc/cTPpFQ11QvSwioDZHEyYFE=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp1.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 91FF96033E;
	Tue, 28 Oct 2025 07:28:45 -0400 (EDT)
From: Ian Abbott <abbotti@mev.co.uk>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ian Abbott <abbotti@mev.co.uk>,
	H Hartley Sweeten <hsweeten@visionengravers.com>
Subject: [PATCH] comedi: 8255: Fail to attach if fail to request I/O port region
Date: Tue, 28 Oct 2025 11:28:33 +0000
Message-ID: <20251028112833.15033-1-abbotti@mev.co.uk>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Classification-ID: 78266644-0099-4a55-b3bb-d8a12d3b36ef-1-1

The COMEDI standalone 8255 driver can be used to configure a COMEDI
device consisting of one of more subdevices, each using an 8255 digital
I/O chip mapped to a range of port I/O addresses.  The base port I/O
address of each chip is specified in an array of integer option values
by the `COMEDI_DEVCONFIG` ioctl.

When support for multiple 8255 subdevices per device was added in the
out-of-tree comedi 0.7.27 back in 1999, if any port I/O region could not
be requested, then the corresponding subdevice was set to be an "unused"
subdevice, and the COMEDI device would still be set-up OK as long as
those were the only types of errors.  That has persisted until the
present day, but seems a bit odd in retrospect.  All the other COMEDI
drivers that use port I/O or memory regions will fail to set up the
device if any region cannot be requested.  It seems unlikely that the
sys admin would deliberately choose a port that cannot be requested just
to leave a gap in the device's usable subdevice numbers, and failing to
set-up the device will provide a more noticeable indication that
something hasn't been set-up correctly, so change the driver to fail to
set up the device if any of the port I/O regions cannot be requested.

Signed-off-by: Ian Abbott <abbotti@mev.co.uk>
---
 drivers/comedi/drivers/8255.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/comedi/drivers/8255.c b/drivers/comedi/drivers/8255.c
index f45f7bd1c61a..5f70938b4477 100644
--- a/drivers/comedi/drivers/8255.c
+++ b/drivers/comedi/drivers/8255.c
@@ -77,19 +77,17 @@ static int dev_8255_attach(struct comedi_device *dev,
 		 * base address of the chip.
 		 */
 		ret = __comedi_request_region(dev, iobase, I8255_SIZE);
+		if (ret)
+			return ret;
+		ret = subdev_8255_io_init(dev, s, iobase);
 		if (ret) {
+			/*
+			 * Release the I/O port region here, as the
+			 * "detach" handler cannot find it.
+			 */
+			release_region(iobase, I8255_SIZE);
 			s->type = COMEDI_SUBD_UNUSED;
-		} else {
-			ret = subdev_8255_io_init(dev, s, iobase);
-			if (ret) {
-				/*
-				 * Release the I/O port region here, as the
-				 * "detach" handler cannot find it.
-				 */
-				release_region(iobase, I8255_SIZE);
-				s->type = COMEDI_SUBD_UNUSED;
-				return ret;
-			}
+			return ret;
 		}
 	}
 
-- 
2.51.0


