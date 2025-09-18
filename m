Return-Path: <linux-kernel+bounces-793132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA80B3CF13
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 21:32:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E2407C6AA5
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 19:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9849B2DEA71;
	Sat, 30 Aug 2025 19:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="h/6JcrGn"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E91255F52
	for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 19:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756582341; cv=none; b=VfZ1mLk9qbzCdJApj5YDq7InYeL/arDJJ4PbMWRUmlimkCmWA3FGozqhj34RdFC0eFtM/bOOWYUUiYhbexFC+LEjEmvp5vONbwGQH30W+UuguXbQhK0TWsYUTYnSY0sA02zPpXoS0UgZQL9oSIR9Bef3yZ1+sB4r6kRMSPJtS8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756582341; c=relaxed/simple;
	bh=A7kOwLXfXYTqy6VkkzPnhYvUhmrg8KJbNZ7bE1IEsE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E7aFKWwf9lKhJOP58ALP6Toq8TA+UFieCFmvs8NLG56oWDbw9tI4Kn1yBFFIFJNSDoFmpbPDkK5K3Zh3hX2NtU42/caa2CKR1pk4OxySudIVnQf29lZCJL47vPiue6oyqGFirlIYHUOnkKOdEbO8Gp6y/o6oQLDY75A9FogZhzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=h/6JcrGn; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2490369145fso15656025ad.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Aug 2025 12:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1756582339; x=1757187139; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XHChkfQMkbV7SjUtwakYhLoytq+CyhHZTNbhfb0dUvg=;
        b=h/6JcrGnse1Mp0iw65iCsiiT72hHFcS6W9+o/iHUpXmLtUQXcvikjKZaj1WtYXHHjr
         ftSQ1D6FkoXEN61T9QdLGlazmgdG0jR8VdXlk7P7NGnfDH2lyOgXWMxRVTi2EMqll6/j
         //ulEanWKPs0z7fE32y5yFWrmGL2rMyJ9ZBlKBZ9o8iq8wQwMghKwLFE0+6fal3wknu3
         ezdUvEoODTv2+4BYmdd3x2tt+5mzfR/fouNCHWRlBlqByEsUREtB+Qn/n7A386/ew8vG
         RpmRBZaH/Czgvc8k+ulZQkEnf8ZIAzgAfYQW4OAmBVAPvdiQ3+9RKClvIjrgLMin+9Ii
         D6Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756582339; x=1757187139;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XHChkfQMkbV7SjUtwakYhLoytq+CyhHZTNbhfb0dUvg=;
        b=qFPnTZzEOhjcUndN5e307flOB1aXXocVHMrseRY3GTH2Qv9ddhopKAoW+o38B3GbqO
         Eic67JC0zAJ9Uc83pG9kvqWsCV4PX20cXyKm97aZIyY6+Mq6qrsvbbEcu0vIiFhS6oF4
         US/W6H3our6U/m8uHS3hjnCCfW+AhiqZxqaa3ojZEBcxLIHJ8EoMk/cqkbW8pbTVRc6r
         Ew0+RkCDFnUuLLO9kUDakZqkvSullN8l4pBUWPPaxnuPeHwCuvAuD9Fn9RQ76qbaeyBU
         fHxE10yXFbifazd2KD3Pz+RyyzS0twe58HwwqhS3dNsBNXUR4Dwxj71abURKqX0Twt+0
         fxmQ==
X-Gm-Message-State: AOJu0YxT79xVWk/EgiuEeGRX+1ZXyTjUr/DYKsOYzEoJ9RmlD358UmAU
	KyakjB/Z0ymVaFyQlS0oBtHj1rJ65gDJ49yiruyQ/mGDjpD45+4nW40Pv0k0QaRFlQA=
X-Gm-Gg: ASbGncsN9ZDrQW2NoHaWhZ6ddkFp0e5ByPEqmvWhMd46OQnD1d1jzOr94SEFUmzzaew
	3QxpI2qOjRWT+Zgbhnplk15YZB0UGgYkpZA+QJICzSMOyvanhasRSPv64ai0iUtVPmBXRfhu995
	XP9WjmVhJRAO6J09JO+SHx6ghSp8vZnLMh6aiTGW4oYI61jigWq52uHfrmOphJCBH/MMiDmMkNr
	mn4kmns68KMC/2tubPrwZgllj799f9xNORkCUzxHE9BKfLTljBRpQFzLKXEllCv6puNlxnN6ymI
	XAZwEtDm5uIodCENE/TjqwC/NbSnIC0rbeg8ncvdR+BDAI0QQUcQW4qEFimnvKDxqiGy2vUZGrn
	gUmFHrZTnTDVVJnRlC31gDbWygRcIz3oOP+Q=
X-Google-Smtp-Source: AGHT+IH+3miFeIR6tQUL0wfehVSxT31HOSJPjvKC8CX71Xx5VWWJuBvRY0vS/CA50IGWE4dB1x1ywg==
X-Received: by 2002:a17:902:ebc9:b0:246:b15f:8d9d with SMTP id d9443c01a7336-24944a1ca58mr35922805ad.14.1756582338796;
        Sat, 30 Aug 2025 12:32:18 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.167.117])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24903702396sm59584335ad.14.2025.08.30.12.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Aug 2025 12:32:18 -0700 (PDT)
Date: Sat, 30 Aug 2025 12:32:15 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	oe-kbuild-all@lists.linux.dev,
	Marcel Holtmann <marcel@holtmann.org>,
	Sean Wang <sean.wang@mediatek.com>,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] Bluetooth: btmtksdio: Fix build after header cleanup
Message-ID: <aLNRvzXE4O9dKZoN@mozart.vkv.me>
References: <202508300413.OnIedvRh-lkp@intel.com>
 <b78a4255d17adbb74140aa23f89cb7653af96c75.1756513671.git.calvin@wbinvd.org>
 <84fd4012-966b-4983-b015-ffce06509b5e@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <84fd4012-966b-4983-b015-ffce06509b5e@molgen.mpg.de>

On Saturday 08/30 at 07:11 +0200, Paul Menzel wrote:
> Dear Calvin,
> 
> 
> Thank you for your patch, and addressing the regression right away.
> 
> Am 30.08.25 um 02:50 schrieb Calvin Owens:
> > Syzbot found a randconfig which fails after my recent patch:
> > 
> >      drivers/bluetooth/btmtksdio.c:442:33: error: array type has incomplete element type ‘struct h4_recv_pkt’
> >        442 | static const struct h4_recv_pkt mtk_recv_pkts[] = {
> >            |                                 ^~~~~~~~~~~~~
> >      drivers/bluetooth/btmtksdio.c:443:11: error: ‘H4_RECV_ACL’ undeclared here (not in a function)
> >        443 |         { H4_RECV_ACL,      .recv = btmtksdio_recv_acl },
> >            |           ^~~~~~~~~~~
> >      drivers/bluetooth/btmtksdio.c:444:11: error: ‘H4_RECV_SCO’ undeclared here (not in a function)
> >        444 |         { H4_RECV_SCO,      .recv = hci_recv_frame },
> >            |           ^~~~~~~~~~~
> >      drivers/bluetooth/btmtksdio.c:445:11: error: ‘H4_RECV_EVENT’ undeclared here (not in a function)
> >        445 |         { H4_RECV_EVENT,    .recv = btmtksdio_recv_event },
> > 
> > ...because we can have BT_MTKSDIO=y with BT_HCIUART_H4=n, and the
> > definitions used here are gated on BT_HCIUART_H4 in hci_uart.h.
> 
> The drivers below seem to be affected:
> 
>     drivers/bluetooth/bpa10x.c:     { H4_RECV_EVENT,   .recv =
> hci_recv_frame },
>     drivers/bluetooth/btmtksdio.c:  { H4_RECV_EVENT,    .recv =
> btmtksdio_recv_event },
>     drivers/bluetooth/btmtkuart.c:  { H4_RECV_EVENT,    .recv =
> btmtkuart_recv_event },
>     drivers/bluetooth/btnxpuart.c:  { H4_RECV_EVENT,        .recv =
> hci_recv_frame },
>
> > I think the simplest way to fix this is to remove the gate on the
> > definitions in hci_uart.h. Since the constants are macros, there's no
> > runtime cost to doing so, and nothing seems to rely on their absence in
> > the BT_HCIUART_H4=n case.
> 
> Looking at the implementation, it looks like they only work with the H4
> protocol? So maybe, that should be denoted in the Kconfig files?

Thanks for looking Paul.

Yes, my fix will cause a link error with other randconfigs, which my
'make randconfig drivers/bluetooth/' test loop missed after I made the
function prototype always defined, whoops.

We do need the dependencies here, as you note. The btmtksdio case syzbot
found is the odd one out because it only uses the constants, and doesn't
call h4_recv_buf().

Hopefully this gets it all:

-----8<-----
From: Calvin Owens <calvin@wbinvd.org>
Subject: [PATCH v2] Bluetooth: Fix build after header cleanup

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


