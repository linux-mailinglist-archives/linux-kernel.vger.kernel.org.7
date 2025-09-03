Return-Path: <linux-kernel+bounces-798798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEEE8B42313
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 16:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3388E3ACCE6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 14:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F3930EF6A;
	Wed,  3 Sep 2025 14:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="Bt5I6ns3"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1C02F4A0B
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 14:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756908369; cv=none; b=QTanHzWFI1Bl6E9vWIZY9D3TJukmWkGEMMHVlwesWHAS/QjAlfog0JKB65X9NjW1ZGvSg5FqPFNEh/ZKIKUtwwq1A3hw2hVk9XWUfbCw1l1l0DoO0hdnLtLHWdwfBZ+qVXEOU+Q2QrrK+oRPx6bG4sFw9Hd1x1XVmXlhPorm2do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756908369; c=relaxed/simple;
	bh=jJvjScnyctCjCrW9uH75zudbESAeHApJCJbWt0aaOPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6kkbHL25lRRaiZqHVZYaN5+1qjrscG7LOwfiCJV+yUGDtJzYF91FIL6hBka1LLqGAsBARnT3+aM2bYDadi1dJgR1ip8uH9+WlBkJxbkqJYaf40p6xohwjhSlnzj3rjL+oQHJ/fIdvBYcCIn0/96TnMaYVKhp3R4VHplUwkRXsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=Bt5I6ns3; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-248ff68356aso6775585ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Sep 2025 07:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1756908367; x=1757513167; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MjiZpHaOGAzMnI40BIIZ11hI7GlxfYSDqRw3KpQJVjo=;
        b=Bt5I6ns3QjS5/tn1xhY5FCnWhuvycOov8EjcbzyWr7Y8YbBGWa2QNmvX/pg/QDLSE2
         fh3KcR0+ygyqy7OaZ4GHumJHQkJ1OxLOvCgnIigQLLmhbb2RLgJAwlS2bbY86M2Sn3l5
         9dmP7CsFqWM2Qcp68NBPOteiEBj54ZeCQJHZUL+Wz8TmHEgTUknhZeqox1r6WJy/qc2L
         tY+fGpFEwH08lFfovSR+/lMShWzK82mLkKpmDf8eOPkCXrX4pUw+x23PFrgrOQmstrJ4
         7KWjRo7ZVkGVslzmU4pBvRVtlm1Ap+PX1+S4o9+vsJD0gVMj77grJfD/ZaP089U5BS3J
         BmHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756908367; x=1757513167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MjiZpHaOGAzMnI40BIIZ11hI7GlxfYSDqRw3KpQJVjo=;
        b=uTRaAlenLe7LqKEah++k/0VGZY3HUzsuU8ll47LXjA22jgXIfDFnWBjYRMXlzoT+Zz
         JWhwWbmPZnaCX3z0xXDeUM6h6pcPRauc4a9PYZnkP9XTCFUR2A+GviwgNA6FcoqODyrk
         iX1J4jXrsWJARvJAOVlCq9Nz8J1+FIexjOYX/DU/f3XE256eTZLVadqzKE4p/4Qw189Y
         g3h9i5v/WmSsnDAHf6lZlEOFqFJn/fqmhRs2LtRhw0eu2kKx24JH/3VbBGpqjOoeOzth
         gSceu2n8S7Hyoth5FWP/6LVc/CsTfQO0X8AOCYGUpA2TLTBvL7OsQ1kzH+y/N2OXjJX0
         ODnA==
X-Forwarded-Encrypted: i=1; AJvYcCV0ezednSuX84+DwnixlmSQmp9felQQRSm6bu1u/UIAxe2PAhXL2HIvFx/vG/zxgUzkKc2wcQVjbMTBXKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeOHmK4WnxqCkuHO7UCOYsBeFtS4uQFFRhbZ7ur69RLVaueBen
	LuXBBVyban9p/faO5Op2040uo4S/hqfr74Dwrs5aV/1iWYbsZLH9EvUdcHbVA9Iz56w=
X-Gm-Gg: ASbGncuhN+XxUGcgjFE2n+KdBBaeRppyzPTU6gTWCF/tFgkBizP3gU02nriy+U+M6ZI
	V1WfgeiVT1q/CP0/d2/BCFv7GaogayfUnFmaoBGATXMraQcL/lG9bfxwkgjM6pIuBO9247/78gz
	wytwyn6Fl+EODLdHRjax7OlXFSc0DKmAMgRnbD4scDMM48GO/+r7L8VIS5zlFHSriqYCv8LVuFe
	KWhyAZfrDL0lLH4FZHsVkdREGEZMgmXeOrWs5AqpAV5q6Eikjv6rTGsSVNe+SsN1d7HUUoh5H2Z
	KN6yCYOh4w2smUkrny7/7/TYRGDfnrijGulWt+fKAYq/fEsh/Eu6QBd78JyHvBhoN+t6O35qZX+
	O2iq0vfgZN/318ngPsGnyyUa1
X-Google-Smtp-Source: AGHT+IFlIeuwMod5aclkQ/QtX6cKW39pAdUeh1p1zXqs3QyuVJvhTttccp2Nuw4HcUpvwD0nuOddbQ==
X-Received: by 2002:a17:903:186:b0:246:2cb3:5768 with SMTP id d9443c01a7336-24944b4323fmr220781315ad.30.1756908366468;
        Wed, 03 Sep 2025 07:06:06 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24c9e39094dsm16821705ad.84.2025.09.03.07.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 07:06:05 -0700 (PDT)
Date: Wed, 3 Sep 2025 07:06:06 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	oe-kbuild-all@lists.linux.dev,
	Marcel Holtmann <marcel@holtmann.org>,
	Sean Wang <sean.wang@mediatek.com>,
	linux-mediatek@lists.infradead.org, naresh.kamboju@linaro.org
Subject: [PATCH v3] Bluetooth: Fix build after header cleanup
Message-ID: <aLhLTiIMRnjHfvOn@mozart.vkv.me>
References: <202508300413.OnIedvRh-lkp@intel.com>
 <b78a4255d17adbb74140aa23f89cb7653af96c75.1756513671.git.calvin@wbinvd.org>
 <84fd4012-966b-4983-b015-ffce06509b5e@molgen.mpg.de>
 <aLNRvzXE4O9dKZoN@mozart.vkv.me>
 <CABBYNZJBDgQHwmx82H2XJ-LCeOsxc77PPo6NA4zzT0dt7Uxddw@mail.gmail.com>
 <aLcQsE3x9o4BzXxp@mozart.vkv.me>
 <aLhK5wEHgxc3BIgb@mozart.vkv.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aLhK5wEHgxc3BIgb@mozart.vkv.me>

Some Kconfig dependencies are needed after my recent cleanup, since
the core code has its own option.

Since btmtksdio does not actually call h4_recv_buf(), move the
definitions it uses outside the BT_HCIUART_H4 gate in hci_uart.h to
avoid adding a dependency for btmtksdio.

The rest I touched (bpa10x, btmtkuart, and btnxpuart) do really call
h4_recv_buf(), so the dependency is required, add it for them.

Fixes: 0e272fc7e17d ("Bluetooth: remove duplicate h4_recv_buf() in header")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202508300413.OnIedvRh-lkp@intel.com/
Signed-off-by: Calvin Owens <calvin@wbinvd.org>
---
 drivers/bluetooth/Kconfig    | 6 ++++++
 drivers/bluetooth/hci_uart.h | 8 ++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/Kconfig b/drivers/bluetooth/Kconfig
index 4ab32abf0f48..7df69ccb6600 100644
--- a/drivers/bluetooth/Kconfig
+++ b/drivers/bluetooth/Kconfig
@@ -312,7 +312,9 @@ config BT_HCIBCM4377
 
 config BT_HCIBPA10X
 	tristate "HCI BPA10x USB driver"
+	depends on BT_HCIUART
 	depends on USB
+	select BT_HCIUART_H4
 	help
 	  Bluetooth HCI BPA10x USB driver.
 	  This driver provides support for the Digianswer BPA 100/105 Bluetooth
@@ -437,8 +439,10 @@ config BT_MTKSDIO
 
 config BT_MTKUART
 	tristate "MediaTek HCI UART driver"
+	depends on BT_HCIUART
 	depends on SERIAL_DEV_BUS
 	depends on USB || !BT_HCIBTUSB_MTK
+	select BT_HCIUART_H4
 	select BT_MTK
 	help
 	  MediaTek Bluetooth HCI UART driver.
@@ -483,7 +487,9 @@ config BT_VIRTIO
 
 config BT_NXPUART
 	tristate "NXP protocol support"
+	depends on BT_HCIUART
 	depends on SERIAL_DEV_BUS
+	select BT_HCIUART_H4
 	select CRC32
 	select CRC8
 	help
diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 5ea5dd80e297..cbbe79b241ce 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -121,10 +121,6 @@ void hci_uart_set_flow_control(struct hci_uart *hu, bool enable);
 void hci_uart_set_speeds(struct hci_uart *hu, unsigned int init_speed,
 			 unsigned int oper_speed);
 
-#ifdef CONFIG_BT_HCIUART_H4
-int h4_init(void);
-int h4_deinit(void);
-
 struct h4_recv_pkt {
 	u8  type;	/* Packet type */
 	u8  hlen;	/* Header length */
@@ -162,6 +158,10 @@ struct h4_recv_pkt {
 	.lsize = 2, \
 	.maxlen = HCI_MAX_FRAME_SIZE \
 
+#ifdef CONFIG_BT_HCIUART_H4
+int h4_init(void);
+int h4_deinit(void);
+
 struct sk_buff *h4_recv_buf(struct hci_dev *hdev, struct sk_buff *skb,
 			    const unsigned char *buffer, int count,
 			    const struct h4_recv_pkt *pkts, int pkts_count);
-- 
2.47.2


