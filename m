Return-Path: <linux-kernel+bounces-841757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A0DBB8286
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 22:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 546914E9BCD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 20:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A48C257AFB;
	Fri,  3 Oct 2025 20:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SyWx08qS"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3908B221264
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 20:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759525162; cv=none; b=H74kcKXySJ9Id09ktayPxBpZyEJ+e57L/C9F/jyTpEbKJ91yzBcQ8mztqfUtFZhUoobZnFae7b6Ccd7CBgy0l9AfBQ2cDDZfUiHj+lqFKY3FyhDA4C4RdxLGCwlyugmsI9CXDRbbAsTTdxrIgXUCd4W9alUVrAkf38zTPbLgsRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759525162; c=relaxed/simple;
	bh=3iS0NPyXkoJCsxxmYHv7FSsoUUYgEBq2uJwzGDpCMzM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AQe4QFm6Et5L6CdTCNGBFAo9L+94JyBADxTA43Fit0XnPybf82vPPbShw7doXcLik5F2GMyzxp8LCtFYzGdp1Vy9h6ZL9RE+Hp8/qX7P+hCYnagiN00pfmpl9Z46IqKpjW/hJB7zWJAcNCr5ZSeNALgrw31rOkTlEld+LAlQnis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SyWx08qS; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8572d7b2457so305263485a.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 13:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759525160; x=1760129960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KT4nMlGTNRa2oLGSJ7qmFMgvXCrjlBGOzo/18l5VvRs=;
        b=SyWx08qSUUlzAzNYA7Ei+s2WPLuRHioRrLddHhtG4HxDVApCO3s/DdRjlpSJ+JdiKO
         eWTZfnoRxdZq/oiqR4bNLZpS6g7PvNjqK93R4ZrSaE5gIbzy+t7FE8SWW6TSY98VErp6
         Bao06ISlPFZC8R1+BQsbBW5GI2HgQTgsefvuqWtXylxY9WiCTkDFl/TY13ahQ4IvHmQs
         Lp/7TjjsO36rv2JAxXUipJGcZeqJNs0Jz7V1jsVemjt0a5FT15zfMhf49na2SlrPC9r8
         TyGO0UDML86KsFe1N1V2+eL6IvxmOuOX8XfUNYoQM7WQiEHT6WwSgOu4keFmBJOeHm5m
         ogxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759525160; x=1760129960;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KT4nMlGTNRa2oLGSJ7qmFMgvXCrjlBGOzo/18l5VvRs=;
        b=MHJGqnSTmCoWoRiwXzHHM6q5ZdVHrohxx00Vr4WfCdw1yfoRI67B9LcZ/dDdQXs3r4
         nw3XbEvT5x5167ECgFgEg2RLP1CWP/JBgKGT7CY4XkOGhG8D5oFPq7IVjPewZU//iqk6
         Cbr1r4VS5sGv1CmQVJHv2KDNyDO5nLKw2xfTGNBX2oNRudV88hqVhX1hFyUUzajyWN7t
         jJyj+pNg8LTQACgFE8iv91XtfA/XRS4ySWEE0K/V4HbGQA7Ui5Efd3cEdT2vC+k7iFvV
         U/ZzkuL9/CuMfWUkl9ITykZXxmVY5fkLj6QgVyRPEt9R/198m9jPTuCMS4C2+x0d0YuS
         lYeA==
X-Forwarded-Encrypted: i=1; AJvYcCVS53KcIeH09RXEgMcKjZz+CJkLusLGNkEY2YiD/kmSVArOxRIMzPohHiTplj6PatAv0zK7oZjgDj4rUfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJukrg6umrYNwegMPjCl8qwThSXceytJeabWuyOTjZgRm8i1ka
	t6XrWtMvxDvnYfvu7My8vPwaMXdA4AORz+Yr1dvE5dG9y5CYX2VRPDRCCAj9G6fR
X-Gm-Gg: ASbGncus06mrNPhpEsMwkyoDLs3T5wCaW8zM3W7uJUeWS49OISEewSkW70FzWs0f40a
	DShuXIA4PQ/N/hk84Xw+WsFl7rMHya0l05W2fIKUXHwnkQftUMnrLdYUul+ajOol3du5KL8k1WD
	KFkgwmGtJAUovX3EDDtwZ7btGBuCpCPYw81EjOTxcCWIe87bVfy/1D60SOkgqie8glV6DR1icsM
	XMn5PsdP+9F6/rYRnqLYq6sKfHu2jhoWwErkf+gF0X6jbPG/I74fhbS5HF9czgCjDA5eIaosMYc
	e8X6PZPlRJIMbxbP44bfsC7c3OdZJ7SUEgsDrIXCDWQip7F+P4l+CBmsY9W9AIWSbuAitsAWJen
	O4ADV9nwwo6xKrxwFMUTfPf2omKIjP2JXuzWsq2293fZ5wCjgkAI=
X-Google-Smtp-Source: AGHT+IG52HETqCWP88p+h8ZNfHvJ7DJyecVGzPgXEf1tHWE6Q+vyJHKSUErRHgLmxu46A08JBLL+cw==
X-Received: by 2002:a05:620a:4002:b0:828:4c12:9a67 with SMTP id af79cd13be357-87a3376d80bmr657803985a.17.1759525160083;
        Fri, 03 Oct 2025 13:59:20 -0700 (PDT)
Received: from etsgit14.hitronhub.home ([2607:fa49:173b:2900::2ca])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8777a7e0295sm514898085a.59.2025.10.03.13.59.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 13:59:19 -0700 (PDT)
From: Pascal Giard <evilynux@gmail.com>
X-Google-Original-From: Pascal Giard <pascal.giard@etsmtl.ca>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pascal Giard <pascal.giard@etsmtl.ca>
Subject: [PATCH] Bluetooth: Add filter for Qualcomm debug packets
Date: Fri,  3 Oct 2025 16:58:37 -0400
Message-ID: <20251003205837.10748-1-pascal.giard@etsmtl.ca>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some Qualcomm Bluetooth controllers, e.g., QCNFA765 send debug packets
as ACL frames with header 0x2EDC. The kernel misinterprets these as
malformed ACL packets, causing repeated errors:

  Bluetooth: hci0: ACL packet for unknown connection handle 3804

This can occur hundreds of times per minute, greatly cluttering logs.
On my computer, I am observing approximately 7 messages per second
when streaming audio to a speaker.

For Qualcomm controllers exchanging over UART, hci_qca.c already
filters out these debug packets. This patch is for controllers
not going through UART, but USB.

This patch filters these packets in btusb_recv_acl() before they reach
the HCI layer, redirecting them to hci_recv_diag().

Tested on: Thinkpad T14 gen2 (AMD) with QCNFA765, kernel 6.16.9

Signed-off-by: Pascal Giard <pascal.giard@etsmtl.ca>
---
 drivers/bluetooth/btusb.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5e9ebf0c5312..900400646315 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -68,6 +68,9 @@ static struct usb_driver btusb_driver;
 #define BTUSB_ACTIONS_SEMI		BIT(27)
 #define BTUSB_BARROT			BIT(28)
 
+/* Qualcomm firmware debug packets header */
+#define QCA_DEBUG_HEADER	0x2EDC
+
 static const struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
 	{ USB_DEVICE_INFO(0xe0, 0x01, 0x01) },
@@ -1229,6 +1232,12 @@ static int btusb_recv_intr(struct btusb_data *data, void *buffer, int count)
 
 static int btusb_recv_acl(struct btusb_data *data, struct sk_buff *skb)
 {
+	/* Drop QCA firmware debug packets sent as ACL frames */
+	if (skb->len >= 2) {
+		if (get_unaligned_le16(skb->data) == QCA_DEBUG_HEADER)
+			return hci_recv_diag(data->hdev, skb);
+	}
+
 	/* Only queue ACL packet if intr_interval is set as it means
 	 * force_poll_sync has been enabled.
 	 */
-- 
2.51.0


