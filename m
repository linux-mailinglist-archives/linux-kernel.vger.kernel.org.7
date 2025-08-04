Return-Path: <linux-kernel+bounces-755326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B38F1B1A4F5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 16:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 586153B09A6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Aug 2025 14:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956EF26D4DE;
	Mon,  4 Aug 2025 14:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AtSK/4Xh"
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380521A4E70
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 14:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754317954; cv=none; b=PqofFMItG41YaDEEcYDWycNJdR2SEKcq3RBezDpv6WhPJTMMXx0IbuFfx3tV1bkd+sjxQkGHPDE27F/h5Vs7pBqKzZ3ty6Y578gXwTkue+2PzWIR/8gA1WkoHsccI1DCqvC5YYRtw7rwGujo1KbXBluMMEEYA75FX9bRVfrBJqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754317954; c=relaxed/simple;
	bh=SFofe2Xv/bnOocDqkJFJ3ql2ivs8XBYgiF2wMjcRYHY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 References; b=BS58N4g8jCViFiFHjPIhrG9NDG6rpKMRlHMic7itvh29ySCfS0nLqh2XZumzmIILMUk2lMNuEEuHpmzh8DW/JSOOjZo3BF71mGV+A+k7iXoy2lsmTK37ehGu7qgwk40b1NYIWCOZUsrkmqm+MBiJ3Ks6auwSjnnvv73YTBSCGFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=AtSK/4Xh; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20250804142358epoutp0480a99e276f17cbd0f261e31522ac806f~YlmpwDm_o1141111411epoutp04B
	for <linux-kernel@vger.kernel.org>; Mon,  4 Aug 2025 14:23:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20250804142358epoutp0480a99e276f17cbd0f261e31522ac806f~YlmpwDm_o1141111411epoutp04B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1754317438;
	bh=nhQejfYSbWcLFtDmYYyds2rK7Uwbx0J3FeE7atKF+30=;
	h=From:To:Cc:Subject:Date:References:From;
	b=AtSK/4Xho0fm5IlEBZPq4qUYYT5OTRKtMXwbDlqgF+IiVnURqs4oI0qiU26wNdKUZ
	 pKvfMrW5zQ+2+PBpuMUsPDhp4XXLxJeQU/E8v86A/ZIdjL79/IoCGILj6ykjFVlsAK
	 Z8o9CC6+TjYvEud3FxbrhY9+TcHYCj31o3HZ5cOA=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
	20250804142358epcas5p3b6795af3e36bf318fc68515be2298bd0~YlmpQmJVV2902729027epcas5p3e;
	Mon,  4 Aug 2025 14:23:58 +0000 (GMT)
Received: from epcas5p3.samsung.com (unknown [182.195.38.88]) by
	epsnrtp03.localdomain (Postfix) with ESMTP id 4bwf1n3l97z3hhT3; Mon,  4 Aug
	2025 14:23:57 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20250804142356epcas5p3aa0566fb78e44a37467ac088aa387f5e~YlmnnQJ-w2902729027epcas5p3b;
	Mon,  4 Aug 2025 14:23:56 +0000 (GMT)
Received: from INBRO002811.samsungds.net (unknown [107.122.5.126]) by
	epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250804142354epsmtip1ed8617054c2b8e57fb2a39a0416d1865~YlmlW23w-1586315863epsmtip1E;
	Mon,  4 Aug 2025 14:23:53 +0000 (GMT)
From: Selvarasu Ganesan <selvarasu.g@samsung.com>
To: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org,
	m.grzeschik@pengutronix.de, balbi@ti.com, bigeasy@linutronix.de,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jh0801.jung@samsung.com, dh10.jung@samsung.com, akash.m5@samsung.com,
	hongpooh.kim@samsung.com, eomji.oh@samsung.com, shijie.cai@samsung.com,
	alim.akhtar@samsung.com, muhammed.ali@samsung.com, thiagu.r@samsung.com,
	stable@vger.kernel.org, Selvarasu Ganesan <selvarasu.g@samsung.com>
Subject: [PATCH] usb: dwc3: Remove WARN_ON for device endpoint command
 timeouts
Date: Mon,  4 Aug 2025 19:52:55 +0530
Message-ID: <20250804142258.1577-1-selvarasu.g@samsung.com>
X-Mailer: git-send-email 2.46.0.windows.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250804142356epcas5p3aa0566fb78e44a37467ac088aa387f5e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250804142356epcas5p3aa0566fb78e44a37467ac088aa387f5e
References: <CGME20250804142356epcas5p3aa0566fb78e44a37467ac088aa387f5e@epcas5p3.samsung.com>

From: Akash M <akash.m5@samsung.com>

This commit addresses a rarely observed endpoint command timeout
which causes kernel panic due to warn when 'panic_on_warn' is enabled
and unnecessary call trace prints when 'panic_on_warn' is disabled.
It is seen during fast software-controlled connect/disconnect testcases.
The following is one such endpoint command timeout that we observed:

1. Connect
   =======
->dwc3_thread_interrupt
 ->dwc3_ep0_interrupt
  ->configfs_composite_setup
   ->composite_setup
    ->usb_ep_queue
     ->dwc3_gadget_ep0_queue
      ->__dwc3_gadget_ep0_queue
       ->__dwc3_ep0_do_control_data
        ->dwc3_send_gadget_ep_cmd

2. Disconnect
   ==========
->dwc3_thread_interrupt
 ->dwc3_gadget_disconnect_interrupt
  ->dwc3_ep0_reset_state
   ->dwc3_ep0_end_control_data
    ->dwc3_send_gadget_ep_cmd

In the issue scenario, in Exynos platforms, we observed that control
transfers for the previous connect have not yet been completed and end
transfer command sent as a part of the disconnect sequence and
processing of USB_ENDPOINT_HALT feature request from the host timeout.
This maybe an expected scenario since the controller is processing EP
commands sent as a part of the previous connect. It maybe better to
remove WARN_ON in all places where device endpoint commands are sent to
avoid unnecessary kernel panic due to warn.

Fixes: e192cc7b5239 ("usb: dwc3: gadget: move cmd_endtransfer to extra function")
Fixes: 72246da40f37 ("usb: Introduce DesignWare USB3 DRD Driver")
Fixes: c7fcdeb2627c ("usb: dwc3: ep0: simplify EP0 state machine")
Fixes: f0f2b2a2db85 ("usb: dwc3: ep0: push ep0state into xfernotready processing")
Fixes: 2e3db064855a ("usb: dwc3: ep0: drop XferNotReady(DATA) support")
Cc: stable@vger.kernel.org
Signed-off-by: Akash M <akash.m5@samsung.com>
Signed-off-by: Selvarasu Ganesan <selvarasu.g@samsung.com>

diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index 666ac432f52d..7b313836f62b 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -288,7 +288,9 @@ void dwc3_ep0_out_start(struct dwc3 *dwc)
 	dwc3_ep0_prepare_one_trb(dep, dwc->ep0_trb_addr, 8,
 			DWC3_TRBCTL_CONTROL_SETUP, false);
 	ret = dwc3_ep0_start_trans(dep);
-	WARN_ON(ret < 0);
+	if (ret < 0)
+		dev_warn(dwc->dev, "ep0 out start transfer failed: %d\n", ret);
+
 	for (i = 2; i < DWC3_ENDPOINTS_NUM; i++) {
 		struct dwc3_ep *dwc3_ep;
 
@@ -1061,7 +1063,9 @@ static void __dwc3_ep0_do_control_data(struct dwc3 *dwc,
 		ret = dwc3_ep0_start_trans(dep);
 	}
 
-	WARN_ON(ret < 0);
+	if (ret < 0)
+		dev_warn(dwc->dev, "ep0 data phase start transfer failed: %d\n",
+				ret);
 }
 
 static int dwc3_ep0_start_control_status(struct dwc3_ep *dep)
@@ -1078,7 +1082,12 @@ static int dwc3_ep0_start_control_status(struct dwc3_ep *dep)
 
 static void __dwc3_ep0_do_control_status(struct dwc3 *dwc, struct dwc3_ep *dep)
 {
-	WARN_ON(dwc3_ep0_start_control_status(dep));
+	int	ret;
+
+	ret = dwc3_ep0_start_control_status(dep);
+	if (ret)
+		dev_warn(dwc->dev,
+			"ep0 status phase start transfer failed: %d\n", ret);
 }
 
 static void dwc3_ep0_do_control_status(struct dwc3 *dwc,
@@ -1121,7 +1130,10 @@ void dwc3_ep0_end_control_data(struct dwc3 *dwc, struct dwc3_ep *dep)
 	cmd |= DWC3_DEPCMD_PARAM(dep->resource_index);
 	memset(&params, 0, sizeof(params));
 	ret = dwc3_send_gadget_ep_cmd(dep, cmd, &params);
-	WARN_ON_ONCE(ret);
+	if (ret)
+		dev_warn_ratelimited(dwc->dev,
+			"ep0 data phase end transfer failed: %d\n", ret);
+
 	dep->resource_index = 0;
 }
 
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 321361288935..50e4f667b2f2 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1774,7 +1774,11 @@ static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool int
 		dep->flags |= DWC3_EP_DELAY_STOP;
 		return 0;
 	}
-	WARN_ON_ONCE(ret);
+
+	if (ret)
+		dev_warn_ratelimited(dep->dwc->dev,
+				"end transfer failed: ret = %d\n", ret);
+
 	dep->resource_index = 0;
 
 	if (!interrupt)
@@ -4041,7 +4045,9 @@ static void dwc3_clear_stall_all_ep(struct dwc3 *dwc)
 		dep->flags &= ~DWC3_EP_STALL;
 
 		ret = dwc3_send_clear_stall_ep_cmd(dep);
-		WARN_ON_ONCE(ret);
+		if (ret)
+			dev_warn_ratelimited(dwc->dev,
+				"failed to clear STALL on %s\n", dep->name);
 	}
 }
 
-- 
2.17.1


