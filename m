Return-Path: <linux-kernel+bounces-612592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F44A9514D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Apr 2025 15:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BEC981893F33
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Apr 2025 13:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22BB265637;
	Mon, 21 Apr 2025 13:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="auL+r6RC"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73567264A9E
	for <linux-kernel@vger.kernel.org>; Mon, 21 Apr 2025 13:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745240456; cv=none; b=hGkK3GltUleOAqQr3eggk64S6ByaMzgvKitG40KuNjOTjSFSh0BxMKiWhaW96ivTjIqScHj5AR2uFyq1QZntVLrUJhgLyitxe4TMVoJtvDU2x+4nxLUN3To7qiJddbZqWbgwz7vd06TMiySL43BLnPr57cPygjEXELjbOtf7H4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745240456; c=relaxed/simple;
	bh=U6HdusizQQ44WP/OcKAx6zUmmKr7k0YwKNHZu1i2KaA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AhEJk7ejXDkaluWhEmsBWjcxa3GV4//woLjpmnZaXW3uuxWvbxZq7i9l2DFOw/oRHxzXM09WZSZj8mu0h1tG9h83pI7rVtUV2PbCV/kczT3H6GboOKNHI3Mf5viKmY2wM2C4liAg5WSva025mEIPiqKQiXpSqMkz/bitPFnEWpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=auL+r6RC; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9336740058
	for <linux-kernel@vger.kernel.org>; Mon, 21 Apr 2025 13:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1745240451;
	bh=xt2B9ADJDt0Wyq0DI03C72a3TKtZqtXqFgRaWL3xAMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=auL+r6RCuX0GsJufbzlp/TnJeRqU2wFQSmrbDWd0JUC94XRTStrp4LZa5qRAh9D5S
	 fpggaAcLk7Bgbv3Dp/GUWohR59NnBIXDHv4HiLjdxAsN69LlzBTQZ0epWsTRsBsgiQ
	 AMkPBjmWADNmIGIGaCwyLO9Ze1IXM2q17hYpRJ3aGM1EIBHunCSk7SDFGV9GXsgmI9
	 eWgEXRkbK7/QTH8BsZxnINkCBmQQZacwgaMUmgV/gABnRiZlVM4U5yuGRJE5lZhGVW
	 uoufctTb9KqTCm9s64FlBPiq6EAGh0DPxXn4Erj4to+Z4a74OMNilP6fsWUCim/OHW
	 FnVirKwu3YyAQ==
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-af59547f55bso2198285a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Apr 2025 06:00:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745240450; x=1745845250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xt2B9ADJDt0Wyq0DI03C72a3TKtZqtXqFgRaWL3xAMI=;
        b=B2LUdx/RIV8wo1FSXxc+tp5i0yHtgTPpd2Jxz7LKrpmSDmq9gBA9IszyxJ24jC4R4l
         bVp/Oc2aAjWAvLZnvRgTNYsPhsJdT7R1v+nCUzxOVYTwKD7JYjX2GALyQopKrOAXpNGN
         XYCfFMHqop/srFLEWImWsojsxuzVWr4Dfkq8W1sm41Vdh7XAqh8OTf7SNu+YmVCtblkQ
         x++PLSimyJKIE7BtXBugnLIKIOrk0PhyVhBtToPvQsLmtVBWNUWcV8q/8BL6LBFnD/ZF
         e9mFrO1bFrxUR01U3gNA4kxbCGqsNkWKamNETe9KO6U89iYsVJIp7zB4DRTFBm0h2cz0
         fe+A==
X-Forwarded-Encrypted: i=1; AJvYcCVPY9xQRQlmu6suFD4kt2t4MKFoidH4EaPEHD4My/RgptehJ+ZS0N1z15ToN4OGi5J7FYUsjPBNLuWBb0s=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsnx4Wmh3AP8NER/YvcJLv5aC+4RP4g1O7TqC5YWBlKmVyzB/M
	neiG4FNpTExv5Hze9PaxQQ1PRSi/90YExJxQHFlsVgvm5/N2L96svW6L/y9hnlmr+K1SkLyRalv
	e9eXYe/WJNvfnEcAQkihFqGHPeR7UqoorwLlPiXxw3sVIiPFZeuS3mQ2Dm0+e+uonbrq3nP7pmC
	FzMwkkxlBNsg==
X-Gm-Gg: ASbGncsYtgLLkYNtr2j5KhT5ei6STSzG3tu3SLC1/aB6woTLDBS6axxR7WCp++f3p0O
	XgBykHryCKFKT5KyrYZn19C5IZQ4ul3/2FJ/d2VfXNTqRPLnZei3NDEZVPBI/WEGRxZZnEmxm9i
	BwKU2IxGT4XCHb+2kZL6qDiD+NM9Xlii7Ms82p+B20SeQrCCc44igZuofRWLgOh2v6ozUma/Xxk
	SZ5k6IWvnxsD8bRs3PU0Z0T7Q+WN82U/K7pg/g4GAvgeR6wNiAs9UpsTyW0ZIJMIa1YEcdXO62O
	e+RU3sHr+expu4hoDe0UP0NBYV9+iTp1tmLzQ1VfJa3SaWgUYCxA/z9CxOBE4vXXtVE=
X-Received: by 2002:a17:902:f611:b0:220:d909:1734 with SMTP id d9443c01a7336-22c5359c1fdmr169217845ad.14.1745240449756;
        Mon, 21 Apr 2025 06:00:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGC3QVfR3rmUZ11eoJYGY0QEOqAKR0jKz3lbZlewuMME5I1asWEVrEnNWc0ZMiKJm9A0yP6IA==
X-Received: by 2002:a17:902:f611:b0:220:d909:1734 with SMTP id d9443c01a7336-22c5359c1fdmr169217335ad.14.1745240449310;
        Mon, 21 Apr 2025 06:00:49 -0700 (PDT)
Received: from rickywu0421-ThinkPad-X1-Carbon-Gen-11.cnshub.home ([182.233.178.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c50bda7b3sm64758665ad.52.2025.04.21.06.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 06:00:48 -0700 (PDT)
From: En-Wei Wu <en-wei.wu@canonical.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pmenzel@molgen.mpg.de
Cc: quic_tjiang@quicinc.com,
	chia-lin.kao@canonical.com,
	anthony.wong@canonical.com
Subject: [PATCH v4 2/2] Bluetooth: btusb: use skb_pull to avoid unsafe access in QCA dump handling
Date: Mon, 21 Apr 2025 21:00:38 +0800
Message-ID: <20250421130038.34998-3-en-wei.wu@canonical.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250421130038.34998-1-en-wei.wu@canonical.com>
References: <20250421130038.34998-1-en-wei.wu@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use skb_pull() and skb_pull_data() to safely parse QCA dump packets.

This avoids direct pointer math on skb->data, which could lead to
invalid access if the packet is shorter than expected.

Signed-off-by: En-Wei Wu <en-wei.wu@canonical.com>
---
 drivers/bluetooth/btusb.c | 98 ++++++++++++++++-----------------------
 1 file changed, 41 insertions(+), 57 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index f905780fcdea..031292ab766f 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3017,8 +3017,6 @@ static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
 {
 	int ret = 0;
 	u8 pkt_type;
-	u8 *sk_ptr;
-	unsigned int sk_len;
 	u16 seqno;
 	u32 dump_size;
 
@@ -3027,18 +3025,8 @@ static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
 	struct usb_device *udev = btdata->udev;
 
 	pkt_type = hci_skb_pkt_type(skb);
-	sk_ptr = skb->data;
-	sk_len = skb->len;
+	dump_hdr = (struct qca_dump_hdr *)skb->data;
 
-	if (pkt_type == HCI_ACLDATA_PKT) {
-		sk_ptr += HCI_ACL_HDR_SIZE;
-		sk_len -= HCI_ACL_HDR_SIZE;
-	}
-
-	sk_ptr += HCI_EVENT_HDR_SIZE;
-	sk_len -= HCI_EVENT_HDR_SIZE;
-
-	dump_hdr = (struct qca_dump_hdr *)sk_ptr;
 	seqno = le16_to_cpu(dump_hdr->seqno);
 	if (seqno == 0) {
 		set_bit(BTUSB_HW_SSR_ACTIVE, &btdata->flags);
@@ -3058,16 +3046,15 @@ static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
 
 		btdata->qca_dump.ram_dump_size = dump_size;
 		btdata->qca_dump.ram_dump_seqno = 0;
-		sk_ptr += offsetof(struct qca_dump_hdr, data0);
-		sk_len -= offsetof(struct qca_dump_hdr, data0);
+
+		skb_pull(skb, offsetof(struct qca_dump_hdr, data0));
 
 		usb_disable_autosuspend(udev);
 		bt_dev_info(hdev, "%s memdump size(%u)\n",
 			    (pkt_type == HCI_ACLDATA_PKT) ? "ACL" : "event",
 			    dump_size);
 	} else {
-		sk_ptr += offsetof(struct qca_dump_hdr, data);
-		sk_len -= offsetof(struct qca_dump_hdr, data);
+		skb_pull(skb, offsetof(struct qca_dump_hdr, data));
 	}
 
 	if (!btdata->qca_dump.ram_dump_size) {
@@ -3087,7 +3074,6 @@ static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
 		return ret;
 	}
 
-	skb_pull(skb, skb->len - sk_len);
 	hci_devcd_append(hdev, skb);
 	btdata->qca_dump.ram_dump_seqno++;
 	if (seqno == QCA_LAST_SEQUENCE_NUM) {
@@ -3115,67 +3101,65 @@ static int handle_dump_pkt_qca(struct hci_dev *hdev, struct sk_buff *skb)
 /* Return: true if the ACL packet is a dump packet, false otherwise. */
 static bool acl_pkt_is_dump_qca(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	u8 *sk_ptr;
-	unsigned int sk_len;
-
 	struct hci_event_hdr *event_hdr;
 	struct hci_acl_hdr *acl_hdr;
 	struct qca_dump_hdr *dump_hdr;
+	void *orig_data;
+	unsigned int orig_len;
 
-	sk_ptr = skb->data;
-	sk_len = skb->len;
+	orig_data = skb->data;
+	orig_len = skb->len;
 
-	acl_hdr = hci_acl_hdr(skb);
-	if (le16_to_cpu(acl_hdr->handle) != QCA_MEMDUMP_ACL_HANDLE)
-		return false;
-	sk_ptr += HCI_ACL_HDR_SIZE;
-	sk_len -= HCI_ACL_HDR_SIZE;
-	event_hdr = (struct hci_event_hdr *)sk_ptr;
+	acl_hdr = skb_pull_data(skb, sizeof(*acl_hdr));
+	if (!acl_hdr || (le16_to_cpu(acl_hdr->handle) != QCA_MEMDUMP_ACL_HANDLE))
+		goto restore_return;
 
-	if ((event_hdr->evt != HCI_VENDOR_PKT)
-		|| (event_hdr->plen != (sk_len - HCI_EVENT_HDR_SIZE)))
-		return false;
+	event_hdr = skb_pull_data(skb, sizeof(*event_hdr));
+	if (!event_hdr || (event_hdr->evt != HCI_VENDOR_PKT))
+		goto restore_return;
 
-	sk_ptr += HCI_EVENT_HDR_SIZE;
-	sk_len -= HCI_EVENT_HDR_SIZE;
-
-	dump_hdr = (struct qca_dump_hdr *)sk_ptr;
-	if ((sk_len < offsetof(struct qca_dump_hdr, data))
-		|| (dump_hdr->vse_class != QCA_MEMDUMP_VSE_CLASS)
-	    || (dump_hdr->msg_type != QCA_MEMDUMP_MSG_TYPE))
-		return false;
+	dump_hdr = (struct qca_dump_hdr *)skb->data;
+	if ((skb->len < sizeof(*dump_hdr)) ||
+	   (dump_hdr->vse_class != QCA_MEMDUMP_VSE_CLASS) ||
+	   (dump_hdr->msg_type != QCA_MEMDUMP_MSG_TYPE))
+		goto restore_return;
 
 	return true;
+
+restore_return:
+	skb->data = orig_data;
+	skb->len = orig_len;
+	return false;
 }
 
 /* Return: true if the event packet is a dump packet, false otherwise. */
 static bool evt_pkt_is_dump_qca(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	u8 *sk_ptr;
-	unsigned int sk_len;
-
 	struct hci_event_hdr *event_hdr;
 	struct qca_dump_hdr *dump_hdr;
+	void *orig_data;
+	unsigned int orig_len;
 
-	sk_ptr = skb->data;
-	sk_len = skb->len;
+	orig_data = skb->data;
+	orig_len = skb->len;
 
-	event_hdr = hci_event_hdr(skb);
+	event_hdr = skb_pull_data(skb, sizeof(*event_hdr));
+	if (!event_hdr || (event_hdr->evt != HCI_VENDOR_PKT))
+		goto restore_return;
 
-	if ((event_hdr->evt != HCI_VENDOR_PKT)
-		|| (event_hdr->plen != (sk_len - HCI_EVENT_HDR_SIZE)))
-		return false;
+	dump_hdr = (struct qca_dump_hdr *)skb->data;
+	if ((skb->len < sizeof(*dump_hdr)) ||
+	   (dump_hdr->vse_class != QCA_MEMDUMP_VSE_CLASS) ||
+	   (dump_hdr->msg_type != QCA_MEMDUMP_MSG_TYPE))
+		goto restore_return;
 
-	sk_ptr += HCI_EVENT_HDR_SIZE;
-	sk_len -= HCI_EVENT_HDR_SIZE;
+	return true;
 
-	dump_hdr = (struct qca_dump_hdr *)sk_ptr;
-	if ((sk_len < offsetof(struct qca_dump_hdr, data))
-		|| (dump_hdr->vse_class != QCA_MEMDUMP_VSE_CLASS)
-	    || (dump_hdr->msg_type != QCA_MEMDUMP_MSG_TYPE))
-		return false;
+restore_return:
+	skb->data = orig_data;
+	skb->len = orig_len;
+	return false;
 
-	return true;
 }
 
 static int btusb_recv_acl_qca(struct hci_dev *hdev, struct sk_buff *skb)
-- 
2.43.0


