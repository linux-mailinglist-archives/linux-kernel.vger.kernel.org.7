Return-Path: <linux-kernel+bounces-727254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 905B4B01731
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 11:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD818584EA2
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jul 2025 09:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E8021D3DD;
	Fri, 11 Jul 2025 09:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="oXk1KQ1L"
Received: from pf-012.whm.fr-par.scw.cloud (pf-012.whm.fr-par.scw.cloud [51.159.173.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10AD1B3925;
	Fri, 11 Jul 2025 09:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.173.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752224817; cv=none; b=lrCOg8Cullx25UBcaJpFsmx/jQy/ylbm/nLPq/zInyGohjqXL64BVvIzKTe3+gEtfp5/uWpmUNg2Wod+CdcKRZipaRwEvAUrgveU+xv1Xag+9TLqlWQtNGG2iOCzNaPS7XCJZ4JRUuTyZhJFt6X3uEvuuUQ+2aFbRViFipGFBVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752224817; c=relaxed/simple;
	bh=gIOnfD6Ucu6cXq75rqww/mHyT3XMSlgr9ui4hu/G25A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=poYORdeHFc2ikTZksqY0ndmDlAmRiBtT/vRTYFOke7aXlP8FbHmAl/JJp+miHu26p0YjaURLrDWbmAW+rPFt4yABhk4Dy6mAtYcSKe6Mu8MDfCQVuWUQkm+mqPaeu9iRQkcTteKzycLd1xhbZGxk8dCi3xwKucu+Yw+HTSZaf0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=oXk1KQ1L; arc=none smtp.client-ip=51.159.173.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=IL+rfgs1JWscThNTsA76nW7lNRb+bG4ZaKPaQgB79Fs=; b=oXk1KQ1LbLlHA7GOW/SjRQTV6B
	+4FyKjAsgyTOqLTVbhb74B0YspQEijQOss87LdN7Hh5+EErvV3SMZnCmVtLx0lTlHLeYCDgKLjy7S
	HEllncKGnuSbLBgKl9OTG7kexVc0kP6sERex7fdz9EVHFnAu8yGb3fNuXWFuAm3S3M6DrcbCcrtOa
	RsDlNEgI5ar1VpVvJLjeZPPFyNqr/UwJXNUGuZrxMBiSI/LhMWqBKkL+4wgsSbPdcy6k9MtSNRb8y
	IPxg3PyBB5e1hnz66cBAi8KhRoDypSjY4KsE5hNaRDXtX3ul/sd7KJtdqpTGiB0I5HfyCYllIVyJf
	2nrBt2oA==;
Received: from laubervilliers-658-1-215-187.w90-63.abo.wanadoo.fr ([90.63.246.187]:16749 helo=[10.224.9.2])
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <nicolas.bouchinet@oss.cyber.gouv.fr>)
	id 1ua9K6-0000000DVFH-3um2;
	Fri, 11 Jul 2025 10:41:36 +0200
From: nicolas.bouchinet@oss.cyber.gouv.fr
Date: Fri, 11 Jul 2025 10:41:23 +0200
Subject: [RFC PATCH v2 2/4] usb: core: Introduce usb authentication feature
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250711-usb_authentication-v2-2-2878690e6b6d@ssi.gouv.fr>
References: <20250711-usb_authentication-v2-0-2878690e6b6d@ssi.gouv.fr>
In-Reply-To: <20250711-usb_authentication-v2-0-2878690e6b6d@ssi.gouv.fr>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Luc Bonnafoux <luc.bonnafoux@ssi.gouv.fr>, 
 Alan Stern <stern@rowland.harvard.edu>, Kannappan R <r.kannappan@intel.com>, 
 Sabyrzhan Tasbolatov <snovitoll@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, 
 Stefan Eichenberger <stefan.eichenberger@toradex.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Pawel Laszczak <pawell@cadence.com>, 
 Ma Ke <make_ruc2021@163.com>, Jeff Johnson <jeff.johnson@oss.qualcomm.com>, 
 Luc Bonnafoux <luc.bonnafoux@oss.cyber.gouv.fr>, 
 Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>, 
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
X-Mailer: b4 0.14.2
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: nicolas.bouchinet@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: nicolas.bouchinet@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

From: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>

This includes the usb authentication protocol implementation bulk
exposed by the public usb_authenticate_device function.

The protocol exchange is driven by the host and can be decomposed into
three, mostly independent, phases:

- The Host can request a digest of each certificate own by the
  peripheral.
- If the Host does not recognize the peripheral from one of its digests,
  it can read one or more certificates from the device until a valid one
  is found.
- The Host can issue an authentication challenge to the peripheral.

The usb_authenticate_device function implements the usb authentication
protocol.

It implements the three phases of the protocol :

First, it needs to communicate with the usb device in order to fetch its
certificate digests (usb_authent_req_digest).
Then if the device is unknown, the host fetches the device certificate
chains (usb_authent_read_cert_part, usb_authent_read_certificate).
Once at least a digest has been recognized or a certificate chain has
been validated the host challenges the device in order to authenticate
it (usb_authent_challenge_dev).

It also needs to communicate with a policy engine using the following
functions :

usb_policy_engine_check_digest
usb_policy_engine_check_cert_chain
usb_policy_engine_generate_challenge
usb_policy_engine_check_challenge

Co-developed-by: Luc Bonnafoux <luc.bonnafoux@ssi.gouv.fr>
Signed-off-by: Luc Bonnafoux <luc.bonnafoux@ssi.gouv.fr>
Signed-off-by: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
---
 drivers/usb/core/authent.c | 586 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/usb/core/authent.h | 178 ++++++++++++++
 2 files changed, 764 insertions(+)

diff --git a/drivers/usb/core/authent.c b/drivers/usb/core/authent.c
new file mode 100644
index 0000000000000000000000000000000000000000..9a2d4ef27ad26d802f2ba65cb8fe72474eb93464
--- /dev/null
+++ b/drivers/usb/core/authent.c
@@ -0,0 +1,586 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * SPDX-FileCopyrightText: (C) 2025 ANSSI
+ *
+ * USB Authentication protocol implementation
+ *
+ * Author: Luc Bonnafoux <luc.bonnafoux@ssi.gouv.fr>
+ * Author: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
+ *
+ */
+
+#include <linux/types.h>
+#include <linux/usb.h>
+#include <linux/usb/ch9.h>
+#include <linux/usb/hcd.h>
+#include <linux/usb/quirks.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/device.h>
+#include <linux/delay.h>
+#include <asm/byteorder.h>
+#include "authent_netlink.h"
+#include "authent.h"
+
+/**
+ * usb_authent_req_digest() - Check if device is known via its digest
+ *
+ * @dev:	[in]		pointer to the usb device to query.
+ * @buffer:	[in, out]	buffer to hold request data.
+ * @digest:	[out]		device digest.
+ * @mask:	[out]		USB Authentication slot mask
+ *
+ * Context: task context, might sleep.
+ *
+ * This function sends a digest request to the usb device.
+ *
+ * Returns:
+ * * %0		- OK
+ * * %-ECOMM	- Failed to send or received a message to the device
+ * * %-EINVAL	- If buffer or mask is NULL
+ */
+
+static int usb_authent_req_digest(struct usb_device *dev, u8 *const buffer,
+				  u8 digest[USBAUTH_DIGESTS_SIZE], u8 *mask)
+{
+	int ret = 0;
+	struct usb_authent_digest_resp *digest_resp = NULL;
+
+	if (buffer == NULL || mask == NULL) {
+		dev_err(&dev->dev, "invalid arguments\n");
+		return -EINVAL;
+	}
+	ret = usb_control_msg(dev, usb_rcvctrlpipe(dev, 0), AUTH_IN, USB_DIR_IN,
+			      (USB_SECURITY_PROTOCOL_VERSION << 8) +
+				      USB_AUTHENT_DIGEST_REQ_TYPE,
+			      0, buffer, USBAUTH_DIGEST_RSP_SIZE, USB_CTRL_GET_TIMEOUT);
+	if (ret != USBAUTH_DIGEST_RSP_SIZE) {
+		dev_err(&dev->dev, "Failed to get digest: %d\n", ret);
+		ret = -ECOMM;
+		goto exit;
+	}
+
+	digest_resp = (struct usb_authent_digest_resp *)buffer;
+	*mask = digest_resp->slotMask;
+	memcpy(digest, digest_resp->digests, USBAUTH_DIGESTS_SIZE);
+
+	ret = 0;
+
+exit:
+
+	return ret;
+}
+
+/*
+ * This structure is sent as is on USB BUS and thus needs to be packed.
+ */
+struct usb_auth_cert_req {
+	u16 offset;
+	u16 length;
+} __packed;
+
+/**
+ * usb_auth_read_cert_part() -  Request a specific part of a certificate chain from the device
+ *
+ * @dev:	[in]		handle to the USB device
+ * @buffer:	[in,out]	buffer used for communication, caller allocated
+ * @slot:	[in]		slot in which to read the certificate
+ * @offset:	[in]		offset at which the certificate fragment must be read
+ * @length:	[in]		length of the certificate fragment to read
+ * @cert_part:	[out]		buffer to hold the fragment, caller allocated
+ *
+ * Context: task context, might sleep
+ *
+ * Returns:
+ * * %x00	- OK
+ * * %-ECOMM	- failed to send or receive a message to the device
+ * * %-EINVAL	- if buffer or cert_part is NULL
+ */
+static int usb_auth_read_cert_part(struct usb_device *dev, u8 *const buffer,
+				   const u8 slot, const u16 offset,
+				   const u16 length, u8 *cert_part)
+{
+	struct usb_auth_cert_req cert_req = {0};
+	int ret = -1;
+
+	if (buffer == NULL || cert_part == NULL) {
+		dev_err(&dev->dev, "invalid argument\n");
+		return -EINVAL;
+	}
+
+	cert_req.offset = cpu_to_le16(offset);
+	cert_req.length = cpu_to_le16(length);
+
+	memcpy(buffer, &cert_req, sizeof(struct usb_auth_cert_req));
+	ret = usb_control_msg(dev, usb_sndctrlpipe(dev, 0), AUTH_OUT,
+			      USB_DIR_OUT,
+			      (USB_SECURITY_PROTOCOL_VERSION << 8) +
+				      USB_AUTHENT_CERTIFICATE_REQ_TYPE,
+			      (slot << 8), buffer,
+			      sizeof(struct usb_auth_cert_req),
+			      USB_CTRL_GET_TIMEOUT);
+	if (ret < 0) {
+		dev_err(&dev->dev, "Failed to send certificate request: %d\n", ret);
+		ret = -ECOMM;
+		goto cleanup;
+	}
+
+	ret = usb_control_msg(dev, usb_rcvctrlpipe(dev, 0), AUTH_IN, USB_DIR_IN,
+			      (USB_SECURITY_PROTOCOL_VERSION << 8) +
+				      USB_AUTHENT_CERTIFICATE_RESP_TYPE,
+			      (slot << 8), buffer, length + 4,
+			      USB_CTRL_GET_TIMEOUT);
+	if (ret != (length + 4)) {
+		dev_err(&dev->dev, "Failed to get certificate from peripheral: %d\n", ret);
+		ret = -ECOMM;
+		goto cleanup;
+	}
+
+	/* TODO: parse received header */
+	memcpy(cert_part, buffer + 4, length);
+
+	ret = 0;
+
+cleanup:
+
+	return ret;
+}
+
+/**
+ * usb_authent_read_certificate() - Read a device certificate
+ *
+ * @dev:	[in]		pointer to the usb device to query
+ * @buffer:	[in, out]	buffer to hold request data, caller allocated
+ * @slot:	[in]		certificate chain to be read
+ * @cert_der:	[out]		buffer to hold received certificate chain
+ * @cert_len:	[out]		length of received certificate
+ *
+ * Context: task context, might sleep.
+ *
+ * Returns:
+ * * %0	- OK
+ * * %-EINVAL - NULL pointer or invalid slot value
+ * * %-ECOMM  - failed to send request to device
+ * * %-ENOMEM - failed to allocate memory for certificate
+ *
+ */
+static int usb_authent_read_certificate(struct usb_device *dev, u8 *const buffer,
+					u8 slot, u8 **cert_der, size_t *cert_len)
+{
+	u16 read_offset = 0;
+	u16 read_length = 0;
+	u8 chain_part[64] = {0};
+
+	if (slot >= 8 || buffer == NULL || cert_der == NULL || cert_len == NULL) {
+		dev_err(&dev->dev, "invalid arguments\n");
+		return -EINVAL;
+	}
+
+	if (usb_auth_read_cert_part(dev, buffer, slot, 0,
+				    USBAUTH_CHAIN_HEADER_SIZE,
+				    chain_part) != 0) {
+		dev_err(&dev->dev, "Failed to get first certificate part\n");
+		return -ECOMM;
+	}
+
+	*cert_len = le16_to_cpu(((u16 *)chain_part)[0]);
+
+	*cert_der = kzalloc(*cert_len, GFP_KERNEL);
+	if (!(*cert_der))
+		return -ENOMEM;
+
+	memcpy(*cert_der, chain_part, USBAUTH_CHAIN_HEADER_SIZE);
+	read_offset = USBAUTH_CHAIN_HEADER_SIZE;
+
+	while (read_offset < *cert_len) {
+		read_length = (*cert_len - read_offset) >= 64 ? 64 : (*cert_len - read_offset);
+
+		if (usb_auth_read_cert_part(dev, buffer, slot, read_offset,
+					    read_length, chain_part) != 0) {
+			dev_err(&dev->dev, "USB AUTH: Failed to get certificate part\n");
+			return -ECOMM;
+		}
+
+		memcpy(*cert_der + read_offset, chain_part, read_length);
+		read_offset += read_length;
+	}
+
+	return 0;
+}
+
+/**
+ * usb_authent_challenge_dev() - Challenge a device
+ *
+ * @dev:	[in]	pointer to the usb device to query
+ * @buffer:	[in]	pointer to the buffer allocated for USB query
+ * @slot:	[in]	certificate chain to be used
+ * @slot_mask:	[in]	slot mask of the device
+ * @nonce:	[in]	nonce to use for the challenge, 32 bytes long
+ * @chall:	[out]	buffer for chall response, 204 bytes long, caller allocated
+ *
+ * Context: task context, might sleep.
+ *
+ * Returns:
+ * * %0		- OK
+ * * %-EINVAL	- NULL input pointer or invalid slot value
+ * * %-ECOMM	- failed to send or receive message from the device
+ */
+static int usb_authent_challenge_dev(struct usb_device *dev, u8 *buffer,
+	const u8 slot, const u8 slot_mask, const u8 *const nonce,
+	u8 *const chall)
+{
+	int ret = -1;
+
+	if (buffer == NULL || slot >= 8 || nonce == NULL) {
+		dev_err(&dev->dev, "invalid arguments\n");
+		return -EINVAL;
+	}
+
+	memcpy(buffer, nonce, USBAUTH_NONCE_SIZE);
+	ret = usb_control_msg(dev, usb_sndctrlpipe(dev, 0), AUTH_OUT,
+			      USB_DIR_OUT,
+			      (USB_SECURITY_PROTOCOL_VERSION << 8) +
+				      USB_AUTHENT_CHALLENGE_REQ_TYPE,
+			      (slot << 8), buffer, USBAUTH_NONCE_SIZE, USB_CTRL_GET_TIMEOUT);
+	if (ret < 0) {
+		dev_err(&dev->dev, "Failed to send challenge request: %d\n", ret);
+		ret = -ECOMM;
+		goto cleanup;
+	}
+
+	((struct usb_chall_req_hd *) chall)->protocolVersion = USB_SECURITY_PROTOCOL_VERSION;
+	((struct usb_chall_req_hd *) chall)->messageType = USB_AUTHENT_CHALLENGE_REQ_TYPE;
+	((struct usb_chall_req_hd *) chall)->slotNumber = slot;
+	((struct usb_chall_req_hd *) chall)->reserved = 0x00;
+	memcpy(chall+4, nonce, USBAUTH_NONCE_SIZE);
+
+	ret = usb_control_msg(dev, usb_rcvctrlpipe(dev, 0), AUTH_IN, USB_DIR_IN,
+			      (USB_SECURITY_PROTOCOL_VERSION << 8) +
+				      USB_AUTHENT_CHALLENGE_RESP_TYPE,
+			      (slot << 8) + slot_mask, buffer, USBAUTH_CHALL_RSP_SIZE,
+			      USB_CTRL_GET_TIMEOUT);
+	if (ret != USBAUTH_CHALL_RSP_SIZE) {
+		dev_err(&dev->dev, "Failed to get challenge response: %d\n", ret);
+		ret = -ECOMM;
+		goto cleanup;
+	}
+
+	memcpy(chall + USBAUTH_CHAIN_HEADER_SIZE, buffer, USBAUTH_CHALL_RSP_SIZE);
+	ret = 0;
+
+cleanup:
+
+	return ret;
+}
+
+/**
+ * usb_auth_create_dev_ctx() - Create a device context according to USB Type-C Authentication Specification, chapter 5.5
+ *
+ * @dev:	[in]		handle to the USB device
+ * @ctx:	[in, out]	buffer to hold the device context, caller allocated
+ * @buf_size:	[in]		available size in the context buffer
+ * @ctx_size:	[out]		total size of the context if return equals 0
+ *
+ * The device context is composed of :
+ *	1. Device Descriptor
+ *	2. Complete BOS Descriptor (if present)
+ *	3. Complete Configuration 1 Descriptor
+ *	4. Complete Configuration 2 Descriptor (if present)
+ *	5. ...
+ *	6. Complete Configuration n Descriptor (if present)
+ *
+ * FIXME: Ensure the validity of the device context is complete:
+ *	- Will the config order consistent ?
+ *	- Do we need to also get the sub configuration strings ?
+ *
+ * Returns:
+ * * %0		- OK
+ * * %-EINVAL	- invalid dev, ctx or size
+ *
+ */
+static int usb_auth_create_dev_ctx(struct usb_device *dev, u8 *ctx,
+							const size_t buf_size, size_t *ctx_size)
+{
+	int cfgno = 0;
+	int desc_size = 0;
+
+	if (dev == NULL || ctx == NULL || ctx_size == NULL) {
+		dev_err(&dev->dev, "invalid inputs\n");
+		return -EINVAL;
+	}
+
+	*ctx_size = 0;
+
+	if (buf_size < (size_t)dev->descriptor.bLength) {
+		dev_err(&dev->dev, "buffer too small\n");
+		return -EINVAL;
+	}
+
+	memcpy(ctx, (void *) &dev->descriptor, (size_t) dev->descriptor.bLength);
+	*ctx_size += (size_t) dev->descriptor.bLength;
+
+	if (dev->bos == NULL || dev->bos->desc == NULL) {
+		dev_err(&dev->dev, "invalid BOS\n");
+		return -EINVAL;
+	}
+
+	desc_size = le16_to_cpu(dev->bos->desc->wTotalLength);
+	if (buf_size < (*ctx_size + desc_size)) {
+		dev_err(&dev->dev, "buffer too small\n");
+		return -EINVAL;
+	}
+
+	memcpy(ctx + (*ctx_size), (void *) dev->bos->desc, desc_size);
+	*ctx_size += desc_size;
+
+	if (dev->config == NULL) {
+		dev_err(&dev->dev, "invalid configuration\n");
+		return -EINVAL;
+	}
+
+	for (cfgno = 0; cfgno < dev->descriptor.bNumConfigurations; cfgno++) {
+		desc_size = le16_to_cpu(dev->config[cfgno].desc.wTotalLength);
+
+		if (buf_size < (*ctx_size + desc_size)) {
+			dev_err(&dev->dev, "buffer too small\n");
+			return -EINVAL;
+		}
+
+		memcpy(ctx + (*ctx_size), (void *) &dev->config[cfgno].desc, USB_DT_CONFIG_SIZE);
+		*ctx_size += USB_DT_CONFIG_SIZE;
+	}
+
+	return 0;
+}
+
+/**
+ * usb_auth_try_resume() - Check that the authentication can resume after a sleep
+ *
+ * @dev: [in] the usb device
+ * @hub: [in] the parent hub
+ *
+ * Returns:
+ * * %0		- OK
+ * * %-ENODEV	- hub has been disconnected
+ *
+ */
+static int usb_auth_try_resume(struct usb_device *dev, struct usb_device *hub)
+{
+	if (hub == NULL || dev == NULL ||
+		     dev->port_is_suspended == 1 ||
+		     dev->reset_in_progress == 1) {
+		return -ENODEV;
+	}
+
+	/*
+	 * TODO: test if the device has not been disconnected
+	 * TODO: test if the device has not been disconnected then replaced with another one
+	 */
+
+	return 0;
+}
+
+static bool usb_has_authentication_capability(const struct usb_device *const dev)
+{
+	return dev->bos && dev->bos->authent_cap;
+}
+
+/**
+ * usb_authenticate_device() - Challenge a device
+ *
+ * @dev: [in, out] pointer to device
+ *
+ * Authentication is done in the following steps:
+ *  1. Get device certificates digest to determine if it is already known
+ *       if yes, go to 3.
+ *  2. Get device certificates
+ *  3. Challenge device
+ *  4. Based on previous result, determine if device is allowed under local
+ *     security policy.
+ *
+ * Context: task context, might sleep.
+ * TODO: complete all possible error case.
+ * TODO: handle root hub device.
+ *
+ * Returns:
+ * * %0		- OK
+ * * %-ENOMEM	- failed to allocate memory for exchange
+ *
+ */
+int usb_authenticate_device(struct usb_device *dev)
+{
+	int ret = 0;
+	u8 is_valid = 0;
+	u8 is_known = 0;
+	u8 is_blocked = 0;
+	u8 chain_nb = 0;
+	u8 slot_mask = 0;
+	u8 slot = 0;
+	u8 digests[USBAUTH_DIGESTS_SIZE] = {0};
+	u8 nonce[USBAUTH_NONCE_SIZE] = {0};
+	u8 chall[USBAUTH_CHALL_SIZE] = {0};
+	u32 dev_id = 0;
+	size_t ctx_size = 0;
+	int i = 0;
+
+	u8 *cert_der = NULL;
+	u8 *buffer = NULL;
+	size_t cert_len = 0;
+
+	if (dev == NULL)
+		return -ENODEV;
+
+	dev->authenticated = 0;
+	if (!usb_has_authentication_capability(dev)) {
+		dev_notice(&dev->dev, "No authentication capability\n");
+		goto cleanup;
+	}
+
+	if (dev->parent == NULL)
+		return -ENODEV;
+
+	struct usb_device *hub = dev->parent;
+
+	buffer = kzalloc(512, GFP_KERNEL);
+	if (!buffer)
+		return -ENOMEM;
+
+	ret = usb_authent_req_digest(dev, buffer, digests, &slot_mask);
+	if (ret != 0) {
+		dev_err(&dev->dev, "failed to get digest: %d\n", ret);
+		goto cleanup;
+	}
+
+	usb_unlock_device(hub);
+	ret = usb_policy_engine_check_digest(dev->route, digests, slot_mask,
+					     &is_known, &is_blocked, &dev_id);
+	if (ret != 0) {
+		dev_err(&dev->dev, "failed to check digest: %d\n", ret);
+		usb_lock_device(hub);
+		goto cleanup;
+	}
+	dev_info(&dev->dev, "waking up\n");
+	usb_lock_device(hub);
+	ret = usb_auth_try_resume(dev, hub);
+	if (ret != 0) {
+		dev_err(&dev->dev, "failed to resume: %d\n", ret);
+		goto cleanup;
+	}
+
+	if (is_known)
+		goto device_known;
+
+	/*
+	 * If device is not already known try to obtain a valid certificate
+	 * Iterate over every device certificate slots, it gets them one by one
+	 * in order to avoid spamming the device.
+	 */
+	if (!is_known) {
+		for (i = 0; i < 8; i++) {
+			if (1 == ((slot_mask >> i) & 1)) {
+				ret = usb_authent_read_certificate(dev, buffer,
+								   chain_nb,
+								   &cert_der,
+								   &cert_len);
+				if (ret != 0) {
+					goto cleanup;
+				}
+
+				usb_unlock_device(hub);
+				ret = usb_policy_engine_check_cert_chain(
+					dev->route, digests + i * USBAUTH_DIGEST_SIZE, cert_der,
+					cert_len, &is_valid, &is_blocked,
+					&dev_id);
+				if (ret != 0) {
+					dev_err(&dev->dev,
+						"failed to validate certificate: %d\n",
+						ret);
+					usb_lock_device(hub);
+					goto cleanup;
+				}
+				usb_lock_device(hub);
+
+				ret = usb_auth_try_resume(dev, hub);
+				if (ret != 0) {
+					dev_err(&dev->dev, "failed to resume: %d\n", ret);
+					goto cleanup;
+				}
+
+				if (is_valid) {
+					slot = i;
+					goto device_known;
+				}
+			}
+		}
+		goto done;
+	} else {
+		for (i = 0; i < 8; i++) {
+			if (1 == ((is_known >> i) & 1)) {
+				slot = i;
+				break;
+			}
+		}
+	}
+
+device_known:
+	/*
+	 * Device is known, authenticate the device with a challenge request
+	 */
+	usb_unlock_device(hub);
+	ret = usb_policy_engine_generate_challenge(dev_id, nonce);
+	if (ret != 0) {
+		dev_err(&dev->dev, "failed to generate challenge: %d\n", ret);
+		usb_lock_device(hub);
+		goto cleanup;
+	}
+	usb_lock_device(hub);
+
+	ret = usb_auth_try_resume(dev, hub);
+	if (ret != 0) {
+		dev_err(&dev->dev, "failed to resume: %d\n", ret);
+		goto cleanup;
+	}
+
+	ret = usb_authent_challenge_dev(dev, buffer, slot, slot_mask, nonce,
+					chall);
+	if (ret != 0) {
+		dev_err(&dev->dev, "failed to challenge device: %d\n", ret);
+		goto cleanup;
+	}
+
+	ret = usb_auth_create_dev_ctx(dev, buffer, 512, &ctx_size);
+	if (ret != 0) {
+		dev_err(&dev->dev, "failed to create context: %d\n", ret);
+		goto cleanup;
+	}
+
+	usb_unlock_device(hub);
+	ret = usb_policy_engine_check_challenge(dev_id, chall, buffer, ctx_size,
+						&is_valid);
+	if (ret != 0) {
+		dev_err(&dev->dev, "failed to check challenge: %d\n", ret);
+		usb_lock_device(hub);
+		goto cleanup;
+	}
+	usb_lock_device(hub);
+
+	ret = usb_auth_try_resume(dev, hub);
+	if (ret != 0) {
+		dev_err(&dev->dev, "failed to resume: %d\n", ret);
+		goto cleanup;
+	}
+
+done:
+	ret = 0;
+	if (is_valid) {
+		dev->authenticated = 1;
+	} else {
+		dev->authenticated = 0;
+		dev_err(&dev->dev, "Device authentication failure\n");
+	}
+cleanup:
+	kfree(buffer);
+	kfree(cert_der);
+
+	return ret;
+}
diff --git a/drivers/usb/core/authent.h b/drivers/usb/core/authent.h
new file mode 100644
index 0000000000000000000000000000000000000000..2cf6d577131084a97f5c30fadaace1eac7e83c11
--- /dev/null
+++ b/drivers/usb/core/authent.h
@@ -0,0 +1,178 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * SPDX-FileCopyrightText: (C) 2025 ANSSI
+ *
+ * USB Authentication protocol definition
+ *
+ * Author: Luc Bonnafoux <luc.bonnafoux@ssi.gouv.fr>
+ * Author: Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>
+ *
+ */
+
+#ifndef __USB_CORE_AUTHENT_H_
+#define __USB_CORE_AUTHENT_H_
+
+#include <linux/types.h>
+#include <linux/usb.h>
+#include <linux/usb/ch11.h>
+#include <linux/usb/hcd.h>
+#include <uapi/linux/usb/usb_auth_netlink.h>
+
+/* From USB Type-C Authentication spec, Table 5-2 */
+#define USB_AUTHENT_CAP_TYPE 0x0e
+
+/* From USB Security Foundation spec, Table 5-2 */
+#define USB_SECURITY_PROTOCOL_VERSION 0x10
+
+#define AUTH_IN 0x18
+#define AUTH_OUT 0x19
+
+/* USB_DT_AUTHENTICATION_CAP */
+struct usb_authent_cap_descriptor {
+	__u8  bLength;
+	__u8  bDescriptorType;
+	__u8  bDevCapabilityType; /* Shall be set to USB_AUTHENT_CAP_TYPE */
+	/*
+	 * bit 0: set to 1 if firmware can be updated
+	 * bit 1: set to 1 to indicate the Device changes interface when updated
+	 * bits 2-7: reserved, set to 0
+	 */
+	__u8  bmAttributes;
+	__u8  bcdProtocolVersion; /* Shall be set to USB_SECURITY_PROTOCOL_VERSION */
+	__u8  bcdCapability; /* Set to 0x01 */
+
+} __packed;
+
+/* Certificate chain header, Table 3-1 */
+struct usb_cert_chain_hd {
+	__u16 length; /* Chain total length including header, little endian */
+	__u16 reserved; /* Shall be set to zero */
+	__u8 rootHash[32]; /* Hash of root certificate, big endian */
+} __packed;
+
+/* Challenge request header, Table 5-7 */
+struct usb_chall_req_hd {
+	__u8 protocolVersion;
+	__u8 messageType;
+	__u8 slotNumber;
+	__u8 reserved;
+};
+
+/* From USB Security Foundation spec, Table 5-3 and Table 5-9 */
+#define USB_AUTHENT_DIGEST_RESP_TYPE 0x01
+#define USB_AUTHENT_CERTIFICATE_RESP_TYPE 0x02
+#define USB_AUTHENT_CHALLENGE_RESP_TYPE 0x03
+#define USB_AUTHENT_ERROR_TYPE 0x7f
+#define USB_AUTHENT_DIGEST_REQ_TYPE 0x81
+#define USB_AUTHENT_CERTIFICATE_REQ_TYPE 0x82
+#define USB_AUTHENT_CHALLENGE_REQ_TYPE 0x83
+
+#define USBAUTH_DIGEST_RSP_SIZE 260
+#define USBAUTH_CHALL_RSP_SIZE 168
+#define USBAUTH_CHAIN_HEADER_SIZE 36
+
+/* USB Authentication GET_DIGEST Request Header */
+struct usb_authent_digest_req_hd {
+	__u8 protocolVersion; /* Shall be set to USB_SECURITY_PROTOCOL_VERSION */
+	__u8 messageType; /* Shall be set to USB_AUTHENT_DIGEST_REQ_TYPE */
+	__u8 param1; /* Reserved */
+	__u8 param2; /* Reserved */
+} __packed;
+
+/* USB Authentication GET_CERTIFICATE Request Header */
+struct usb_authent_certificate_req_hd {
+	__u8 protocolVersion; /* Shall be set to USB_SECURITY_PROTOCOL_VERSION */
+	__u8 messageType; /* Shall be set to USB_AUTHENT_CERTIFICATE_REQ_TYPE */
+	__u8 certChainSlotNumber; /* Must be between 0 and 7 inclusive */
+	__u8 param2; /* Reserved */
+} __packed;
+
+/* USB Authentication GET_CERTIFICATE Request */
+struct usb_authent_certificate_req {
+	__u8 protocolVersion; /* Shall be set to USB_SECURITY_PROTOCOL_VERSION */
+	__u8 messageType; /* Shall be set to USB_AUTHENT_CERTIFICATE_REQ_TYPE */
+	__u8 certChainSlotNumber; /* Must be between 0 and 7 inclusive */
+	__u8 param2; /* Reserved */
+	__u16 offset; /* Read index of Certificate Chain in bytes and little endian*/
+	__u16 length; /* Length of read request, little endian */
+} __packed;
+
+/* USB Authentication CHALLENGE Request Header */
+struct usb_authent_challenge_req_hd {
+	__u8 protocolVersion; /* Shall be set to USB_SECURITY_PROTOCOL_VERSION */
+	__u8 messageType; /* Shall be set to USB_AUTHENT_CHALLENGE_REQ_TYPE */
+	__u8 certChainSlotNumber; /* Must be between 0 and 7 inclusive */
+	__u8 param2; /* Reserved */
+} __packed;
+
+/* USB Authentication CHALLENGE Request Header */
+struct usb_authent_challenge_req {
+	__u8 protocolVersion; /* Shall be set to USB_SECURITY_PROTOCOL_VERSION */
+	__u8 messageType; /* Shall be set to USB_AUTHENT_CHALLENGE_REQ_TYPE */
+	__u8 certChainSlotNumber; /* Must be between 0 and 7 inclusive */
+	__u8 param2; /* Reserved */
+	__u32 nonce; /* Random Nonce chosen for the challenge */
+} __packed;
+
+/* USB Authentication DIGEST response Header */
+struct usb_authent_digest_resp {
+	__u8 protocolVersion; /* Shall be set to USB_SECURITY_PROTOCOL_VERSION */
+	__u8 messageType; /* Shall be set to USB_AUTHENT_DIGEST_RESP_TYPE */
+	__u8 capability; /* Shall be set to 0x01 */
+	__u8 slotMask; /* Bit set to 1 if slot is set, indicates number of digests */
+	__u8 digests[8][32]; /* List of digests */
+} __packed;
+
+/* USB Authentication CERTIFICATE response Header */
+struct usb_authent_certificate_resp_hd {
+	__u8 protocolVersion; /* Shall be set to USB_SECURITY_PROTOCOL_VERSION */
+	__u8 messageType; /* Shall be set to USB_AUTHENT_CERTIFICATE_RESP_TYPE */
+	__u8 slotNumber; /* Slot number of certificate chain returned */
+	__u8 param2; /* Reserved */
+} __packed;
+
+/* USB Authentication CHALLENGE response Header */
+struct usb_authent_challenge_resp_hd {
+	__u8 protocolVersion; /* Shall be set to USB_SECURITY_PROTOCOL_VERSION */
+	__u8 messageType; /* Shall be set to USB_AUTHENT_CHALLENGE_RESP_TYPE */
+	__u8 slotNumber; /* Slot number of certificate chain returned */
+	__u8 slotMask; /* Bit set to 1 if slot is set */
+} __packed;
+
+/* USB Authentication CHALLENGE response */
+struct usb_authent_challenge_resp {
+	__u8 protocolVersion; /* Shall be set to USB_SECURITY_PROTOCOL_VERSION */
+	__u8 messageType; /* Shall be set to USB_AUTHENT_CHALLENGE_RESP_TYPE */
+	__u8 slotNumber; /* Slot number of certificate chain returned */
+	__u8 slotMask; /* Bit set to 1 if slot is set */
+	__u8 minProtocolVersion;
+	__u8 maxProtocolVersion;
+	__u8 capabilities; /* Shall be set to 0x01 */
+	__u8 orgName; /* Organisation Name, USB-IF: 0 */
+	__u32 certChainHash; /* SHA256 digest of certificate chain, big endian */
+	__u32 salt; /* Chosen by responder */
+	__u32 contextHash; /* SHA256 digest of product information, big endian */
+	__u64 signature; /* ECDSA signature of request and response */
+} __packed;
+
+/* USB Authentication error codes, Foundation Table 5-18 */
+#define USB_AUTHENT_INVALID_REQUEST_ERROR 0x01
+#define USB_AUTHENT_UNSUPPORTED_PROTOCOL_ERROR 0x02
+#define USB_AUTHENT_BUSY_ERROR 0x03
+#define USB_AUTHENT_UNSPECIFIED_ERROR 0x04
+
+/* USB Authentication response header */
+struct usb_authent_error_resp_hd {
+	__u8 protocolVersion; /* Shall be set to USB_SECURITY_PROTOCOL_VERSION */
+	__u8 messageType; /* Shall be set to USB_AUTHENT_ERROR_TYPE */
+	__u8 errorCode;
+	__u8 errorData;
+} __packed;
+
+#ifdef CONFIG_USB_AUTHENTICATION
+int usb_authenticate_device(struct usb_device *dev);
+#else
+static inline int usb_authenticate_device(struct usb_device *dev) { return 0; }
+#endif
+
+#endif /* __USB_CORE_AUTHENT_H_ */

-- 
2.50.0


