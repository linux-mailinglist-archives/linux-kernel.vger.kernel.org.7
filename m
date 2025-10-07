Return-Path: <linux-kernel+bounces-844446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4877FBC1EFC
	for <lists+linux-kernel@lfdr.de>; Tue, 07 Oct 2025 17:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CF5F14E6C8F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Oct 2025 15:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4272D29CE;
	Tue,  7 Oct 2025 15:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SJVivGH9"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBDD3595C
	for <linux-kernel@vger.kernel.org>; Tue,  7 Oct 2025 15:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759851210; cv=none; b=NBRsCnzt7GLEOstMdk4czGvg7RUBWOxmjxdh9YiVhDS3zox7Aa5+uIWnJTye93OMrIksOfrIn71f96Fpv8VeeLZswMSgTeMa6NJY3ex81C/+EBgaPKRwwaPWUt/87nA8yEeaIo5Iy88BjDNy2ijR5G/U3OKE7TCOiUVtucsO9sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759851210; c=relaxed/simple;
	bh=voS58tw35m/lG/LM2fn0NTC8nXB2+G7MEc2/Zy3M30Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uN3wzaRIDxvxOihMhWZ/ejSuG/DTYgUQW8Seb782A/YGkDLvP5kVdNXMwTyCFQps4EHoawbr2WwUF0OgA/XEHVDayKQn77JJgvxETPnFWSbh7Us+oZb0YYYAMoNBg+rT89MuAy/1PcOYdDpK/BF7+OFslr1fXfYCae78A5WRU6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SJVivGH9; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4dd7233b407so76354161cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Oct 2025 08:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759851208; x=1760456008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xuvsR45lwtNudjpmCrpSYAZww8RRbfVYdMazovR1q4o=;
        b=SJVivGH9KeaMXZkuDWjyuoZtUj26PNsH/+AYDqPFFCeSYOFFkDVRdnBjKIjMj3chqf
         8PDiwN0f4BASS3nYCpDZDOJ1fwQ3LUi0bhgItJ6WZfRkDFY4nRpSfcp3rO/PHCHxF+5L
         0Cmo7jwi4ZFRYfrj6UoPBCYPTjXzI7HicePEVHm+2ps8Jc+G0U7EU8raSL2hFrySGohl
         GhQ9eQgWWGEa6bf9QCF3Y53DK82rdqPqGvriwUlHmS/2DGr7B4NeVaHU4ng9DbGxygTO
         bSJOWocCruQ+hcU9KRLEvg6+0I2iiZ9KEwBaHEl78E8B7pp0V7Q/wP6yB4wc/ytPXXaT
         N++w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759851208; x=1760456008;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xuvsR45lwtNudjpmCrpSYAZww8RRbfVYdMazovR1q4o=;
        b=dkD7DSWTOznL3c3xrz1xrOAmVHRHSTR4haHr4NImVmujAcS1tfgZ8PPol1r1bfUk56
         EeNEe9TGcxXqNmxc/bfyn9YOoOUuO9xC54c4Pa0aDWGjnBfGIaw3PYoJ1Nbbm2Zauy1+
         aC8jDFt8cA0pHPubMnX5LCYcdixlTq3NU/AgzvyFoWcRbLpQli1IklQVgBOUsCs4yW6i
         KqUAtqfVkARAtR7BDTAfh0oz6+k28FC5SRoEO8jNJkhem3RwRB+yjJ+D0bJ1FXc4lgn1
         Psk/u4yqrZhldk1bNZO0v8YKOnzZyFBvmvlBEpYXCRgfGK4CUzD2iqGHY6HMZuvGv9N5
         Thgw==
X-Forwarded-Encrypted: i=1; AJvYcCX8lMd/yeC7ySeQ1GYTMvORPzm4xX6WSe/Xu/gU/v1tpflDLkbxhpHy1ir2QEON2pEg4hblQD1t/8c85eY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZRjChaod0vWI19JKkTCUvs7rFLi1i7i+mfkTJH+TiKxLh2Esc
	Z4jocnJgIdvX06ZlJH1CGsKILbgQ4MPIAjX1mRAuC1+/OxQ42fA41Hpf
X-Gm-Gg: ASbGncvsu8e1wxUzdHrxoLeW9kLRBqP+acmCttYGi0zC13sasrI3h1+iPiU3P2ow0Gr
	PHTjohLPbfFjy+QFuzLhQu+ZlqqkTw8R/HhpQxZV4NxZCXdpcU/0Y2/EinO71Q5iasqf1TcTG3E
	Eb9LKrPV1c+M3ko0DXsd2TTsd1gDhlIxVLHS5sx4XlSE9wtkWS5SCzA8xZ30WyLudGvB+cJI7M0
	wqpsX6emNAsivCT4IHLVpmzpaSmmZjKGUFJyp8H05/97YqhlmUyBeF7HwKDobmFK6wCagaPmIbU
	KDDwxC+jl7etRrQ3QzocTPQJ6clRCqIWDoKzEiIB0hxHFbo9K4/FTGj6AQOlyz8J2vQWL0O6Rpz
	q+Zwmx/xffX5eUaLk1XUerd+cN3t+kOodhJzWOjdWPpx09hQGdvqIReePPTxqtDWK
X-Google-Smtp-Source: AGHT+IGoEb/IGrmnpp4yezwDrWbOKdqI3indtAMm6uFh9R75EEpUxW2kD3vf9k0rDrfPXCPONiHGaw==
X-Received: by 2002:ac8:5a84:0:b0:4e0:33d8:c636 with SMTP id d75a77b69052e-4e576a80529mr211267621cf.26.1759851207508;
        Tue, 07 Oct 2025 08:33:27 -0700 (PDT)
Received: from etsgit14.ad.etsmtl.ca ([142.137.141.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8777a7e0779sm1561444085a.60.2025.10.07.08.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 08:33:27 -0700 (PDT)
From: Pascal Giard <evilynux@gmail.com>
X-Google-Original-From: Pascal Giard <pascal.giard@etsmtl.ca>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pascal Giard <pascal.giard@etsmtl.ca>
Subject: [PATCH v2 1/1] Bluetooth: btusb: Reclassify Qualcomm WCN6855 debug packets
Date: Tue,  7 Oct 2025 11:33:15 -0400
Message-ID: <20251007153315.72565-1-pascal.giard@etsmtl.ca>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some Qualcomm Bluetooth controllers, e.g., QCNFA765 with WCN6855
chip, send debug packets as ACL frames with header 0x2EDC.
The kernel misinterprets these as malformed ACL packets, causing
repeated errors:

  Bluetooth: hci0: ACL packet for unknown connection handle 3804

This can occur hundreds of times per minute, greatly cluttering logs.
On my computer, I am observing approximately 7 messages per second
when streaming audio to a speaker.

For Qualcomm controllers exchanging over UART, hci_qca.c already
filters out these debug packets. This patch is for controllers
not going through UART, but USB.

This patch uses the classify_pkt_type callback to reclassify the
packets with handle 0x2EDC as HCI_DIAG_PKT before they reach the
HCI layer. This change is only applied to Qualcomm devices marked
as BTUSB_QCA_WCN6855.

Tested on: Thinkpad T14 gen2 (AMD) with QCNFA765 (0489:E0D0)
Signed-off-by: Pascal Giard <pascal.giard@etsmtl.ca>
---
Changes in v2:
- Address reviewer feedback about 0x2EDC being a valid HCI handle
- Use classify_pkt_type callback instead of filtering in recv_acl
- Only apply to devices with BTUSB_QCA_WCN6855 quirk
---
 drivers/bluetooth/btusb.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5e9ebf0c5312..256179ace853 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1131,6 +1131,24 @@ static void btusb_qca_reset(struct hci_dev *hdev)
 	btusb_reset(hdev);
 }
 
+static u8 btusb_classify_qca_pkt_type(struct hci_dev *hdev, struct sk_buff *skb)
+{
+	/* Some Qualcomm controllers, e.g., QCNFA765 with WCN6855 chip, send debug
+	 * packets as ACL frames with connection handle 0x2EDC. These are not real
+	 * ACL packets and should be reclassified as HCI_DIAG_PKT to prevent
+	 * "ACL packet for unknown connection handle 3804" errors.
+	 */
+	if (skb->len >= 2) {
+		u16 handle = get_unaligned_le16(skb->data);
+
+		if (handle == 0x2EDC)
+			return HCI_DIAG_PKT;
+	}
+
+	/* Use default packet type for other packets */
+	return hci_skb_pkt_type(skb);
+}
+
 static inline void btusb_free_frags(struct btusb_data *data)
 {
 	unsigned long flags;
@@ -4201,6 +4219,7 @@ static int btusb_probe(struct usb_interface *intf,
 		data->recv_acl = btusb_recv_acl_qca;
 		hci_devcd_register(hdev, btusb_coredump_qca, btusb_dump_hdr_qca, NULL);
 		data->setup_on_usb = btusb_setup_qca;
+		hdev->classify_pkt_type = btusb_classify_qca_pkt_type;
 		hdev->shutdown = btusb_shutdown_qca;
 		hdev->set_bdaddr = btusb_set_bdaddr_wcn6855;
 		hdev->reset = btusb_qca_reset;
-- 
2.51.0


