Return-Path: <linux-kernel+bounces-792871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2112B3C9E9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 11:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 747901C23D5A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Aug 2025 09:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC9C268C40;
	Sat, 30 Aug 2025 09:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TkGw0htN"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3EA1DE8AE;
	Sat, 30 Aug 2025 09:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756547317; cv=none; b=sQKO9rWx1IAdJ+jdZafGDNw5w1iPxqGYGGw8MS8S11ot3IWtdBptjyJXsTTleHvD08wR/xXtiCK12nIP29zftXGOuynGMyfFMpQtzqOLfoZZBItDSDC6dxWhYfl37vsI20rhdVWkEg0CTBWhjv+lYLjBnEpjjykAGB9lhZ6+Ars=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756547317; c=relaxed/simple;
	bh=WrBzWUBbNLVi1TVHVDGcJFK1o+XYYsxTimvrazHOL+0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G4kqkREVEAOECSJCytIQvj6A4ohd7vWU6AIwSGmIZ+A2Ntzy8+sIZfRG4q5hZuxkTu+gFNO9YbUZCeFE9yk5ENbt9vayG8m3w6MQsoyn+fh2Tk4bR8yiFUOQ3IjSBEhfo9VXpvFEPNSqFZkWWFY5WKtbgnOIr2hlvvIvDKhiumg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TkGw0htN; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-55f6bb0a364so1497020e87.1;
        Sat, 30 Aug 2025 02:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756547314; x=1757152114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dp4t+5XjcUN448FoaeZJP4HhV6YJjFsdimtWRYF00KI=;
        b=TkGw0htNQKtqnQTebydRJ0ZOC5ODXXPdeoSgXSHGzkuZuSBSaaty8Z/5Hj7bFebWZD
         sMHIDhSXz5WdaiDX/LvBv2/hyDcP9nhJHUdWry2FhkQLMlMNDrzlx7cQNsz13mIqntsK
         0tmbwkzkySKg7opaq3iIc7Nr8PCe4R7W+qpcjknT4/kv+DoOAlAT9IdpgJkFTK72YPmp
         x8wDxEVLPxSWsC/TQqpxI+2YsKYrL0gMbJgUXuhWf1X/UzW+pBhqURcA8/3vjhrMpGBO
         HBw/jnd/TALMcoFhpnoYDTfFWZAHnUNSv8FZsAuRlo5lPcYT64BnJ8qr+I6RImlts9D9
         Mpkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756547314; x=1757152114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dp4t+5XjcUN448FoaeZJP4HhV6YJjFsdimtWRYF00KI=;
        b=nq8Q3D6Dcy5VHRReDjJ0FsCDnQJvNerUfjWA4G5x5Dq3XVaF09DSvmhkVvr2ZeZDDm
         agbuZekVAuguSJTuUgxXtZqMdRXJJI2JfKpSB4yNf7sJemT4KcG0Um+cpHnTosC3xGSM
         YtEHyiK/JLXAQ1BrhC6PJnzyK+y8TmDUQ8/ewMlot++VU70ylw039l2ARiJITp9M5CzI
         8TzvsfBXwsT+cM2B4OI5LLW8C3/sA5wyq2KG+7XihS8tLGKd4XlbUpcpFf5mVdnR5ZPF
         pKdo/60ku+7INOHgCh+aoEYoQGftYN/Qs3oHLvA+tH3Jt0Ykj/p14XQUrn2rOWsCI1zW
         euKg==
X-Forwarded-Encrypted: i=1; AJvYcCVuOJxsVatB173fNBP9bVcJQaFyEDlYv2kghfKhPFPgL1i3WmYIHHy7p6eR4cp9aaybG7XmSEmctk4poYU=@vger.kernel.org, AJvYcCXavQ4K/hKWpnkIhopPZQASPVFkd5IJ9RneJi/p+BpUIAMWosC029qg7cGkL8xH2ycjhrjmJ/VP4Q7E@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2EELtuYo55ClWEWDmSuN9BC0CuMtxxqIjAQmJkKn7gyJNnKi3
	Ddjld+qC1/zf3ugGZPgnEYW0QUZJbt9YwREnJavoXvzCO+frcGo/4lBrLZlBFg==
X-Gm-Gg: ASbGnctoCQtdvfG94aXuR/3ADryj28VuHtv/Swl7VqyYVtwBtcj7Wx9tjA5OvrZ9u6R
	1GrrmnPQi5dtaLzx2rfoH0p/DTmXrnUdeMKY/GfT3sDmREXnQRjcTVORD9IK6jr302akUDJsfCv
	O8Mcnt4iXQ9MTzdKgOTYq0lzcGjuCMOYRKtpdXYV2lEd7/V9jeX63Bachp16I9KMaIRzPBqjPKw
	T8hczdvJy7BBcQAPzYASTIPYbbiMUhMALTh1reAa29Oj6K5MnjklR1t/AHVoW+9Z9ZUBElJYKdt
	ix+J/VcHbbIMsLE1NHsetwDqitn+oYYyJvV3kgtCJ48t6FFRkHYGXbxF8KXojQ69SiKGxwKtrxm
	XWMPFfKJkFZgMTjDrL0uq/IbOqQDS9eWcVs4XzBv4wMzsew==
X-Google-Smtp-Source: AGHT+IGdB28Kgve/k09nulGg5xE5ZB+QMPE3o6zmbFp9NBmgjzvdnMtt6dfwBVuvpO1a7qA3If8MlQ==
X-Received: by 2002:a05:6512:6812:b0:55f:4a34:e333 with SMTP id 2adb3069b0e04-55f708ecf28mr337051e87.33.1756547313289;
        Sat, 30 Aug 2025 02:48:33 -0700 (PDT)
Received: from foxbook (bhd106.neoplus.adsl.tpnet.pl. [83.28.93.106])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55f676dd6e2sm1299335e87.23.2025.08.30.02.48.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 30 Aug 2025 02:48:32 -0700 (PDT)
Date: Sat, 30 Aug 2025 11:48:28 +0200
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: David Wang <00107082@163.com>
Cc: WeitaoWang-oc@zhaoxin.com, mathias.nyman@linux.intel.com,
 gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
 surenb@google.com, kent.overstreet@linux.dev
Subject: Re: [REGRESSION 6.17-rc3] usb/xhci: possible memory leak after
 suspend/resume cycle.
Message-ID: <20250830114828.3dd8ed56.michal.pecio@gmail.com>
In-Reply-To: <20250829181354.4450-1-00107082@163.com>
References: <20250829181354.4450-1-00107082@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 30 Aug 2025 02:13:54 +0800, David Wang wrote:
> Hi,
>
> I have been watching kernel memory usage for drivers for a while, via /proc/allocinfo.
> After upgrade to 6.17-rc3, I notice memory usage behavior changes for usb drivers:
> 
> Before rc3, after several suspend/resume cycles, usb devices's memory usage is very stable:
> 
>        40960        5 drivers/usb/host/xhci-mem.c:980 [xhci_hcd] func:xhci_alloc_virt_device 9
>         1024        1 drivers/usb/host/xhci-mem.c:841 [xhci_hcd] func:xhci_alloc_tt_info 2
>          320       10 drivers/usb/host/xhci-mem.c:461 [xhci_hcd] func:xhci_alloc_container_ctx 31
>         1920       15 drivers/usb/host/xhci-mem.c:377 [xhci_hcd] func:xhci_ring_alloc 31
>          112       12 drivers/usb/host/xhci-mem.c:49 [xhci_hcd] func:xhci_segment_alloc 32
>         1792       28 drivers/usb/host/xhci-mem.c:38 [xhci_hcd] func:xhci_segment_alloc 59
> 
> But with rc3, the memory usage increase after each suspend/resume cycle: 
> 
> #1:
>        49152        6 drivers/usb/host/xhci-mem.c:980 [xhci_hcd] func:xhci_alloc_virt_device 9
>         1024        1 drivers/usb/host/xhci-mem.c:841 [xhci_hcd] func:xhci_alloc_tt_info 2
>          384       12 drivers/usb/host/xhci-mem.c:461 [xhci_hcd] func:xhci_alloc_container_ctx 32
>         2176       17 drivers/usb/host/xhci-mem.c:377 [xhci_hcd] func:xhci_ring_alloc 32
>          128       14 drivers/usb/host/xhci-mem.c:49 [xhci_hcd] func:xhci_segment_alloc 34
>         2048       32 drivers/usb/host/xhci-mem.c:38 [xhci_hcd] func:xhci_segment_alloc 61
> #2:
>        57344        7 drivers/usb/host/xhci-mem.c:980 [xhci_hcd] func:xhci_alloc_virt_device 13
>         1024        1 drivers/usb/host/xhci-mem.c:841 [xhci_hcd] func:xhci_alloc_tt_info 3
>          448       14 drivers/usb/host/xhci-mem.c:461 [xhci_hcd] func:xhci_alloc_container_ctx 46
>         2432       19 drivers/usb/host/xhci-mem.c:377 [xhci_hcd] func:xhci_ring_alloc 43
>          144       16 drivers/usb/host/xhci-mem.c:49 [xhci_hcd] func:xhci_segment_alloc 44
>         2304       36 drivers/usb/host/xhci-mem.c:38 [xhci_hcd] func:xhci_segment_alloc 82
> #3:
>        65536        8 drivers/usb/host/xhci-mem.c:980 [xhci_hcd] func:xhci_alloc_virt_device 17
>         1024        1 drivers/usb/host/xhci-mem.c:841 [xhci_hcd] func:xhci_alloc_tt_info 4
>          512       16 drivers/usb/host/xhci-mem.c:461 [xhci_hcd] func:xhci_alloc_container_ctx 60
>         2688       21 drivers/usb/host/xhci-mem.c:377 [xhci_hcd] func:xhci_ring_alloc 54
>          160       18 drivers/usb/host/xhci-mem.c:49 [xhci_hcd] func:xhci_segment_alloc 54
>         2560       40 drivers/usb/host/xhci-mem.c:38 [xhci_hcd] func:xhci_segment_alloc 103
> 
> The memory increasing pattern keeps going on for each suspend/resume afterwards, I am not
> sure whether those memory would be released sometime later.
> 
> And in kernel log, two lines of error always showed up after suspend/resume:
> 
> 	[  295.613598] xhci_hcd 0000:03:00.0: dma_pool_destroy xHCI ring segments busy
> 	[  295.613605] xhci_hcd 0000:03:00.0: dma_pool_destroy xHCI input/output contexts busy

Hi,

Good work, looks like suspend/resume is a little understested corner
of this driver.

Did you check whether the same leak occurs if you simply disconnect
a device or if it's truly unique to suspend?

> And bisect narrow down to commit 2eb03376151bb8585caa23ed2673583107bb5193(
> "usb: xhci: Fix slot_id resource race conflict"):

I see a trivial bug which everyone (myself included tbh) missed before.
Does this help?

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index f11e13f9cdb4..f294032c2ad7 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -932,7 +932,7 @@ void xhci_free_virt_device(struct xhci_hcd *xhci, struct xhci_virt_device *dev,
  */
 static void xhci_free_virt_devices_depth_first(struct xhci_hcd *xhci, int slot_id)
 {
-	struct xhci_virt_device *vdev;
+	struct xhci_virt_device *vdev, *tmp_vdev;
 	struct list_head *tt_list_head;
 	struct xhci_tt_bw_info *tt_info, *next;
 	int i;
@@ -952,8 +952,8 @@ static void xhci_free_virt_devices_depth_first(struct xhci_hcd *xhci, int slot_i
 		if (tt_info->slot_id == slot_id) {
 			/* are any devices using this tt_info? */
 			for (i = 1; i < HCS_MAX_SLOTS(xhci->hcs_params1); i++) {
-				vdev = xhci->devs[i];
-				if (vdev && (vdev->tt_info == tt_info))
+				tmp_vdev = xhci->devs[i];
+				if (tmp_vdev && (tmp_vdev->tt_info == tt_info))
 					xhci_free_virt_devices_depth_first(
 						xhci, i);
 			}



