Return-Path: <linux-kernel+bounces-796920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F442B40956
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 17:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA59A3A4AC5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 15:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB2F324B1A;
	Tue,  2 Sep 2025 15:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="TqzUt202"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E382D2FC019
	for <linux-kernel@vger.kernel.org>; Tue,  2 Sep 2025 15:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756827830; cv=none; b=PjZyY0ydeB/8+70HzCYQpa0VudLH3YXKmRNKJCWX5bfIomlgKmqc16ysh711IPhrJY+dFc2e5+PAZqGK1Zf7hDeR0UWLWb2LyuZHWeqV9RnboG5fq5hjShXmYD+TXeXBTGYBLlH+CHK7F7F79quvHp8un+XAl7scx8RsIYj0Wck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756827830; c=relaxed/simple;
	bh=uBSaj1nJUmnyVjV9iB6505ljdKzXL6ViqWhA8JBUUkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LOGJZdRs3yTmRE1X+BsZh6osskp8DY94UwKQrVMaHSbRnUd/Jy8IWZPG9krvaeT9O1lwwW+oGeGk6ETO3Puu59V5O6TZmPl+cC8okjZ78FFITIMVpIiNNQgaZf/3zh4dQUv2raqFeAgGkp0UeTlBwAIf28L4hxlwR2lyGaiaSmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=TqzUt202; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-24a9cc916b3so25594315ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Sep 2025 08:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1756827828; x=1757432628; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gkt6jh8He1kXHojoNOHUR+RVSUvV3fJpjiiQf61S0dw=;
        b=TqzUt202I/3OgqvIesp8LshIGsRPIkBWcPaRzsaoaoDX/SEGCl38NpAqljofb1YAlB
         aOR+l1xAn/YGz0RLFjwjsG/l5yGkIHmXciuCGTAJ5E/ZSs6dZ1lMvvwkJJ21B04lXE79
         h56vVyyNuST0dBesqxtKRebrU31TQXVIF9wsACX3la4a4ZU3Sv2nmqhGWVRNJNRC9vjh
         T+pCZLRVX3/ME92cQoPxozzsuJLciIqy2KX3Xe7xSQe0L4PRv5ELtsZQUt5E259fo0oG
         Wsb0D3bAVrYXaZSOmAEdc2XwmL9sigePq9TopohNQFT9c0g9PrqeBcKLLnkdm1GBLTKm
         JvcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756827828; x=1757432628;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gkt6jh8He1kXHojoNOHUR+RVSUvV3fJpjiiQf61S0dw=;
        b=msYVTuH6LQyGLp5aGR3WMVPneKGv5eUqXDODsxRC/w/u4ToAJECawsOe0z5z5Pe0b4
         PxOmydGmtawqjpefkD/FiHrFcDM/2Y76A9mqYySy/obEZoIrCenVhxXgQz7KarFQa5AV
         3IG+wmT0BEmMWNhUJNqrvH24nSkk72sppM3QovmcxEc9ifn2u57iJ+IE5AxqgDPeIqda
         R3kkXCMTnKyAddSgymz3rIHaixc2hnhAC2MHVUR7BUByDhZ6thL2UXENmreQgVWphMuj
         XVf/k0yKhlZ6y+ufT4igpps/WjzBG9n2GxZ7Sm3SkBQ1dRSrPHO951cSJ9En8iQO1zhz
         O/Ag==
X-Forwarded-Encrypted: i=1; AJvYcCUyo9zUP6RJIy2zy6aX8D15gKs2Lcr4pOebrhXW71OrRSQqa8HIK6NwSeuFxRE2TAaNhDjLWglTO/AkNgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcsIDfDmvlWbJ8U0VTxUboqIWZKhDGfN4hX2wB8BhzzZmcXU+L
	yD8RFdDU0jstnqTywtKT/fRhZv333upHW90pZL+sZeujY+g5X5f4+LQ+yeHSyVcTnXM=
X-Gm-Gg: ASbGnctIrPFCaxJXMI8sWjRHleJzZCBpMemnc4bMfFtfGnMr70k1jLkm1mEyGASGZD3
	izItKetd6aUTnpEyiZlj82cCiUxujdv1MScwjVHCgXMu1vWzZqn+l99T5TuirHlBYPEXHOJ+VVy
	7IWj/eM/+kr2i4ve2a0Yl1Wcq6RrV7VecawB+KQ9zOYNOaC6/VKixBMHnZuCTuLgQl4UOyGIi+3
	ZNvdp4Iz3S/h83OYyLYLuCDAxqXGRmoThhu+56teXVir9Y/Y6GX4fu6GyIIkkNXlJnDBiFgbacG
	SOWzB7t0SKywN9ONWStxbQR+kp4gL/2uDxLCqcxwAk6UQkarpGOJpZDVerPtuniEQezhEsLt5Tz
	nKtLupiRraZNV3ApcRFVYn9ZmQY/NkHXQDWkZXPB424zqzA==
X-Google-Smtp-Source: AGHT+IGlZIJUkPm51/UzPGDsdAct3krCic7IzLREXEY9/oW76ewvmB7K7S3GcX3yQJ4WmturI/w3dQ==
X-Received: by 2002:a17:903:186:b0:248:6d1a:430f with SMTP id d9443c01a7336-24944a173famr145263995ad.25.1756827828044;
        Tue, 02 Sep 2025 08:43:48 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3278f881f21sm9364227a91.2.2025.09.02.08.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 08:43:47 -0700 (PDT)
Date: Tue, 2 Sep 2025 08:43:44 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, linux-kernel@vger.kernel.org,
	linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	oe-kbuild-all@lists.linux.dev,
	Marcel Holtmann <marcel@holtmann.org>,
	Sean Wang <sean.wang@mediatek.com>,
	linux-mediatek@lists.infradead.org, naresh.kamboju@linaro.org
Subject: [PATCH v2] Bluetooth: Fix build after header cleanup
Message-ID: <aLcQsE3x9o4BzXxp@mozart.vkv.me>
References: <202508300413.OnIedvRh-lkp@intel.com>
 <b78a4255d17adbb74140aa23f89cb7653af96c75.1756513671.git.calvin@wbinvd.org>
 <84fd4012-966b-4983-b015-ffce06509b5e@molgen.mpg.de>
 <aLNRvzXE4O9dKZoN@mozart.vkv.me>
 <CABBYNZJBDgQHwmx82H2XJ-LCeOsxc77PPo6NA4zzT0dt7Uxddw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABBYNZJBDgQHwmx82H2XJ-LCeOsxc77PPo6NA4zzT0dt7Uxddw@mail.gmail.com>

Some Kconfig dependencies are needed after my recent cleanup, since
the core code has its own option.

Since btmtksdio does not actually call h4_recv_buf(), move the
definitions it uses outside the BT_HCIUART_H4 gate in hci_uart.h to
avoid adding a dependency for btmtksdio.

The rest I touched (bpa10x, btmtkuart, and btnxpuart) do really call
h4_recv_buf(), so the dependency is required, add it for them.

Fixes: 74bcec450eea ("Bluetooth: remove duplicate h4_recv_buf() in header")
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


