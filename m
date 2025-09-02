Return-Path: <linux-kernel+bounces-795703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B113B3F6BC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 09:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B5AA3BE8CE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Sep 2025 07:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582412E62AD;
	Tue,  2 Sep 2025 07:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lu9c3c4h"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C42C3D987;
	Tue,  2 Sep 2025 07:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756798226; cv=none; b=hzvjZgDPzByQMU/mi2SNRlJuS4kmwKRaCHOm/6ThqGsQefcfGqCBsL+60tNOgVgLMqi7D2T/8eDwIvYejn2AlyxgzmnC/ubeVr5zvG9mcyJkniV4PP/E+Bq7VtdDN4CMCWIxUhlDfwcL2S+3iPzCOdpY6fs3FHoAunroUovvmw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756798226; c=relaxed/simple;
	bh=6lFl9dPjmRTYDx+CpfGuVDgR/X9YMe5minGWPTR0f7k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GPuEgdR2+5j1NerKDn3+iq5RWEnQ6goSNRGnRHqTjVGpqPBMj92eHGg+v5d7AUamJDO+P7MRWZ0uow1kYO2XhSplk5JWLafBacnbuGlC3SXtpqdmhpQBrceZE1zA6Tb9jKJxrR4SFozI2bG/nbmPi+Tdfw9g1nuKRe1oCZrHp+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lu9c3c4h; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-55f687fd3bdso4917655e87.1;
        Tue, 02 Sep 2025 00:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756798223; x=1757403023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x0jB3VEYTfpyq2xHIYY2lQr0Fn3bHWi6R5aEr8IPA5Y=;
        b=lu9c3c4hCS3ackTv79BcT5XGgXefkPNdW+/sWu7Go9V+qAfImb6ZymyvlefaFOBEln
         VxDInaqlsPsLVxOiOAyCsRcoUXdys7kK4l1WrarJM3C4mLpNZpEiO6CktJgUWOExZEmr
         nqxlRmSuAcTdvPo7BF3y018d5dAsZOLiTw5GWolR2NHRyQyQRDSvewm54e8gtiVxhdLH
         /ZaIQT6LPpRXS/Zdn5HaEKDlsDJcTlrBbj+XfIFH2oG7rYgBv3t+PlVDvIB8nTVSmL/J
         ubj/KX7tka0Tn8bWYU8YH8lPZ1uh3la0VX4MrvHmROzNX5uulz1WKBasVzlQNu+4mYbO
         IK3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756798223; x=1757403023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x0jB3VEYTfpyq2xHIYY2lQr0Fn3bHWi6R5aEr8IPA5Y=;
        b=SbriYC+WAbmIb091kuyH3rUr8morWK1kugtdewVh/AiLtQDIyM48sNSNpZP/1AAQ8k
         8shZb+h4PI/hMecb28NaTyZprRMCyLgm9LKNG3c4rMQSx+5j8k2UkPp6Rz7KGBeHVRV7
         2DpsFgF3lfLWv88p/hk8OpgbTZV9f9Wk0+tDdgYxwdW/ldf2Ryk4qEfLkPY3KlEm5elh
         oht3CbNKPzEzLREoipx1Bcg0RgopXR5AdSoD9A+FYOgDUvd41WR6TecNvp7FM+28BHlm
         GeCpdBSPcxLLcU2ikYg4ysne4TPJxU0S1PlNVMQq6GY1u/aNT8YmQic/y6mIgDlPd5hz
         vPkw==
X-Forwarded-Encrypted: i=1; AJvYcCWvpQ6JsCIA1yEmueoJIiqS242UaeEDfh5eHadKgzjQe3WtAwhyt9o6akUu0P9n5riKhh7Xz5WihswZ@vger.kernel.org, AJvYcCX3p2P6U8C+cDwpET3MJbcMYzLD92DoTLmFDsHcdKxRWFunKq2Uc/PdYLJDjcWmo3Y1xQOHUAA3/UNasnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqJS0+0Q5fjV+F6I6/bQ6aeFV+5U1G3NDcvbhm2MRLsLwp5ol0
	sGLfvLIOILn65KW3hVykk2r7lu0K2Fxfq0RWBV4aPMzYIgUCwrF8zNL1cutCJw==
X-Gm-Gg: ASbGncum2QV7bmgMB83/YZrrgmmndkFwpsBVO7xWHf8QmI++65UNHdhi7bUFIky5S9e
	GIW0e0FIQrhkPGuiQPrT9RDc8x/YVgyMEGvf7u65zIEK9WxzPJV6sFhlt9o3+uBSa7NPRBoKzOY
	04KX9T6XZfppuceLpfuVCFz/+Wz21PZe0Ki3/xLhhc10d0JRUnfx2+tV/c8nVFtNFW7ji4NtfdJ
	hGbc1+URjnXxYfIiXlDi1dmZZTXPKRuTWlEx6t8AulkslpmaqfDXHu7ff1ShE1HTJVPndK3pH47
	+cXrm4cf+IW9T031CygpX0471UEhHGgLJdFy6AWz6axLbYilMIazydGJ2AZ/oQ31fFp/ytUJbSS
	rE8gynpiX5pf1OZd5yTFraI4oJU36HQwAiwnhZR9qwFEdRg==
X-Google-Smtp-Source: AGHT+IEWt9xLa/lW4Z2IgsvRs7xgmPRe947bvzcKipdb44i4HmmTpqxjUyWqGAice/Yqb7gSCy1u+A==
X-Received: by 2002:a05:6512:151a:20b0:560:84b0:2def with SMTP id 2adb3069b0e04-56084b03203mr158032e87.56.1756798222936;
        Tue, 02 Sep 2025 00:30:22 -0700 (PDT)
Received: from foxbook (bey208.neoplus.adsl.tpnet.pl. [83.28.36.208])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-337f508fb9esm2774801fa.56.2025.09.02.00.30.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 02 Sep 2025 00:30:22 -0700 (PDT)
Date: Tue, 2 Sep 2025 09:30:17 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: David Wang <00107082@163.com>, WeitaoWang-oc@zhaoxin.com,
 gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 regressions@lists.linux.dev, linux-kernel@vger.kernel.org,
 surenb@google.com, kent.overstreet@linux.dev
Subject: [PATCH] usb: xhci: Fix xhci_free_virt_devices_depth_first()
Message-ID: <20250902093017.13d6c666.michal.pecio@gmail.com>
In-Reply-To: <f9476552-a6dc-4f1c-91da-b15c8f0d9844@linux.intel.com>
References: <20250829181354.4450-1-00107082@163.com>
	<20250830114828.3dd8ed56.michal.pecio@gmail.com>
	<5051e27a.2ba3.198fa7b5f31.Coremail.00107082@163.com>
	<f9476552-a6dc-4f1c-91da-b15c8f0d9844@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Reusing 'vdev' for iteration caused a recent commit to malfunction
uexpectedly, resulting in a reported memory leak and potential UAF
if devices are freed in bad order. Using a second variable solves
this problem, and maybe others later.

HCS_MAX_SLOTS(xhci->hcs_params1) is the highest possible slot_id,
so change the iteration range to include it. Currently this doesn't
seem to cause problems because the only caller begins with freeing
the topmost slot_id, but it breaks documented functionality.

Reported-by: David Wang <00107082@163.com>
Closes: https://lore.kernel.org/linux-usb/20250829181354.4450-1-00107082@163.com/
Fixes: 2eb03376151b ("usb: xhci: Fix slot_id resource race conflict")
Fixes: ee8665e28e8d ("xhci: free xhci virtual devices with leaf nodes first")
Cc: stable@vger.kernel.org
Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
---
 drivers/usb/host/xhci-mem.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index eed5926b200e..db7dc70c37e5 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -932,7 +932,7 @@ void xhci_free_virt_device(struct xhci_hcd *xhci, struct xhci_virt_device *dev,
  */
 static void xhci_free_virt_devices_depth_first(struct xhci_hcd *xhci, int slot_id)
 {
-	struct xhci_virt_device *vdev;
+	struct xhci_virt_device *vdev, *vdev_i;
 	struct list_head *tt_list_head;
 	struct xhci_tt_bw_info *tt_info, *next;
 	int i;
@@ -951,9 +951,9 @@ static void xhci_free_virt_devices_depth_first(struct xhci_hcd *xhci, int slot_i
 		/* is this a hub device that added a tt_info to the tts list */
 		if (tt_info->slot_id == slot_id) {
 			/* are any devices using this tt_info? */
-			for (i = 1; i < HCS_MAX_SLOTS(xhci->hcs_params1); i++) {
-				vdev = xhci->devs[i];
-				if (vdev && (vdev->tt_info == tt_info))
+			for (i = 1; i <= HCS_MAX_SLOTS(xhci->hcs_params1); i++) {
+				vdev_i = xhci->devs[i];
+				if (vdev_i && (vdev_i->tt_info == tt_info))
 					xhci_free_virt_devices_depth_first(
 						xhci, i);
 			}
-- 
2.48.1

