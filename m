Return-Path: <linux-kernel+bounces-792622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D59B3C6C9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 02:50:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C365A04BC5
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 00:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3431B1F0E56;
	Sat, 30 Aug 2025 00:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="UAvKffAU"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68A219E7F7
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 00:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756515048; cv=none; b=U6mtZdpacebCpLM4XN5b8mZiQ+5EfO1gxWnjDjLYnGeykQYkxYCL+xkt6tVai9JkEhcBHQsNenNf2WHMfsC8dM8lCPaKbe0mvn/iDsvXD3OdEYkTIbQFMXL3uABTMKPZDTeekUIZ10WXh3mMt+w1CRCEV2C3QP6S4WGKOllq6f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756515048; c=relaxed/simple;
	bh=nyBd3svYSA8ZWsKGuTLD0ccws/tYPuOWANWLsrbj49M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cALAHt4Zj/GRkvDTnph0pLnF2CGH2rmy6tWkGgkUEJJiDPXEF0UO47kKH9+/0oyqHf4xVoWYfAzo4G3s/EGR9c6A5gMHUyE6m8H2mZpisiP3vf5/UKBq+jItkjbNFU2dWsP9JV/d7069lhC5tscAtpc4GrS76iyNhtSwAY/VUGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=UAvKffAU; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b4e84a61055so11098a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Aug 2025 17:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1756515046; x=1757119846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P2SbNmp2jN3W5ifKkr2ZRQIsE+bXPrNXTTlRWUPsyEw=;
        b=UAvKffAUMg8b8oHs4FRXEAuqUKfnu/CfcPw9r7GWdLx41PAVJYXLc+h3JgR/CPYSBx
         vU9EEUpvr/8z+nGuTrwtKYAl2pXIRfD2iKT/uT2Kt2RiMrlQJlfsMQqDMW1FkcahQEYm
         aYQDp9zUX9Fx6Elf4IY/cACL49Wm4J9QW0YFuZIKixdqMZ96O3E8I1vEDZl43UDV/RJI
         flaA7fo/iQtEhlsYB6B8FSKeqZXHv+iimTyW7NB8k+nODUE6/3166TbFHd1Lujr89sq1
         FzJEgPUanHLNrKipa3qVhjUdG5P8vg8pqZbhg2HPHoHjOzNaMHHJJgbeHqXCQr4FMAe3
         BD2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756515046; x=1757119846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P2SbNmp2jN3W5ifKkr2ZRQIsE+bXPrNXTTlRWUPsyEw=;
        b=L5v8/Cgz01ngZLqqCDv7Io35L8zXlxX9/SIRyZpxoMmOu7eawtplwzGj7CGdlI/Tai
         6D/fI8YrTSSDywdM7McmE1XQckf+fnKxdt2v3hOGsho39jpKlQHsar7cSIEiEcJaqoqe
         4gLbS1YTPuXeFnGV0Lzy0Clu0MVllLl75ACbn16QxPi50WPJAtMyaLtmtwtOEzE+YyKm
         GWY+CYZbzPSvmN1n+SOkfcUaFUzP6NdrVaQLLBwRQE1RbVeAuM/BOqQvn8Q/c1UvSslK
         8ZqIVneMr59tgMamO36FiVTGUrKLrp/Xs26aJtHW43wq0BidG5HbYD1JnCqjRO1PGIM4
         uj8w==
X-Gm-Message-State: AOJu0YxwQFfP5vOihPvMqx/muauRgSvpNjdOB9oeFJ9/ZpfBucUvLzaQ
	jqM4yPV957k7dYs+m0wi6wfIRcKS445FsWWQ1YtIlUtXLG17W7VZ1Dv/rhzGOyo7bk6VpAKg0k3
	+R0bi
X-Gm-Gg: ASbGncuKdCyx8XYpOSLXBL4ZkA63IPvpfFXfLMtCmisI2PkOUnH8Oa0LOTZGZlqpEf5
	RqwJPXbMLaFPGxrJ2HSGMl+3tENCwTe1ZiyfCN+ipNsuHw7y6mzVdEDHVq/PP9Uf6bMxVUIByrd
	XWdCRWjYVFS9pDO0F6f/+jAYq6Sly7CvnPskd7f52nndrqqtOZMITIiibIGEHihHHgwb2xOS0d2
	yxfe3MvEV49U0Vr6WYnPGYUX6PNLMyOVSWvhVVmDl7+rYXH5bJYCXN3VKs+FnSwFG7dFVbXNEhj
	Bcs6Yo7zbSURp5j/r0ux6wcpvyNEpAQJOkfyXJ/k9+ZT1lXwsPZKn+SuiJX4zrCmJBWjMP1I6Ux
	9fl3l68IxV1fComfZ4X0nRWre
X-Google-Smtp-Source: AGHT+IEgjacSF3MiNjBgqMzAV1pQjZuDMZIwv0mu4RkXIH4CsWBoPGHGROsvLiA4PPniQpoHC2qUVQ==
X-Received: by 2002:a17:903:190:b0:246:e8cc:8cef with SMTP id d9443c01a7336-24944870a4emr8537915ad.3.1756515046144;
        Fri, 29 Aug 2025 17:50:46 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-249063961desm37008335ad.103.2025.08.29.17.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 17:50:45 -0700 (PDT)
From: Calvin Owens <calvin@wbinvd.org>
To: linux-kernel@vger.kernel.org
Cc: linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	oe-kbuild-all@lists.linux.dev,
	Marcel Holtmann <marcel@holtmann.org>,
	Sean Wang <sean.wang@mediatek.com>,
	linux-mediatek@lists.infradead.org
Subject: [PATCH] Bluetooth: btmtksdio: Fix build after header cleanup
Date: Fri, 29 Aug 2025 17:50:29 -0700
Message-ID: <b78a4255d17adbb74140aa23f89cb7653af96c75.1756513671.git.calvin@wbinvd.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <202508300413.OnIedvRh-lkp@intel.com>
References: <202508300413.OnIedvRh-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Syzbot found a randconfig which fails after my recent patch:

    drivers/bluetooth/btmtksdio.c:442:33: error: array type has incomplete element type ‘struct h4_recv_pkt’
      442 | static const struct h4_recv_pkt mtk_recv_pkts[] = {
          |                                 ^~~~~~~~~~~~~
    drivers/bluetooth/btmtksdio.c:443:11: error: ‘H4_RECV_ACL’ undeclared here (not in a function)
      443 |         { H4_RECV_ACL,      .recv = btmtksdio_recv_acl },
          |           ^~~~~~~~~~~
    drivers/bluetooth/btmtksdio.c:444:11: error: ‘H4_RECV_SCO’ undeclared here (not in a function)
      444 |         { H4_RECV_SCO,      .recv = hci_recv_frame },
          |           ^~~~~~~~~~~
    drivers/bluetooth/btmtksdio.c:445:11: error: ‘H4_RECV_EVENT’ undeclared here (not in a function)
      445 |         { H4_RECV_EVENT,    .recv = btmtksdio_recv_event },

...because we can have BT_MTKSDIO=y with BT_HCIUART_H4=n, and the
definitions used here are gated on BT_HCIUART_H4 in hci_uart.h.

I think the simplest way to fix this is to remove the gate on the
definitions in hci_uart.h. Since the constants are macros, there's no
runtime cost to doing so, and nothing seems to rely on their absence in
the BT_HCIUART_H4=n case.

I let randconfig builds run for awhile in drivers/bluetooth/ and didn't
hit anything else, so hopefully this was the only fallout.

Fixes: 74bcec450eea ("Bluetooth: remove duplicate h4_recv_buf() in header")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202508300413.OnIedvRh-lkp@intel.com/
Signed-off-by: Calvin Owens <calvin@wbinvd.org>
---
 drivers/bluetooth/hci_uart.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/bluetooth/hci_uart.h b/drivers/bluetooth/hci_uart.h
index 5ea5dd80e297..fd0624988aba 100644
--- a/drivers/bluetooth/hci_uart.h
+++ b/drivers/bluetooth/hci_uart.h
@@ -121,7 +121,6 @@ void hci_uart_set_flow_control(struct hci_uart *hu, bool enable);
 void hci_uart_set_speeds(struct hci_uart *hu, unsigned int init_speed,
 			 unsigned int oper_speed);
 
-#ifdef CONFIG_BT_HCIUART_H4
 int h4_init(void);
 int h4_deinit(void);
 
@@ -165,7 +164,6 @@ struct h4_recv_pkt {
 struct sk_buff *h4_recv_buf(struct hci_dev *hdev, struct sk_buff *skb,
 			    const unsigned char *buffer, int count,
 			    const struct h4_recv_pkt *pkts, int pkts_count);
-#endif
 
 #ifdef CONFIG_BT_HCIUART_BCSP
 int bcsp_init(void);
-- 
2.49.1


