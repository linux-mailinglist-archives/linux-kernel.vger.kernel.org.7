Return-Path: <linux-kernel+bounces-781612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C91BB31470
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 11:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3286F5E3480
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 09:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E972129DB6E;
	Fri, 22 Aug 2025 09:51:32 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C63E27990D
	for <linux-kernel@vger.kernel.org>; Fri, 22 Aug 2025 09:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755856292; cv=none; b=u0pbK3bEfqf+2dAuORx3U3NsFmSvuuKwWtGvn4DOimiSOMJ9IxmU+bLOZGkdvdOlnWA6rJWctsk0VBiRqixaM/D7rHiEAMQOBMC9pSZTTk94eE0F+EXleE6qqDdJOmz26XwvJAdy60Dr2HiPOgq6W0Rah0y/1+HRbI3hVENymlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755856292; c=relaxed/simple;
	bh=8v1zu7FbFT5zGaFyS+U86qwFLsQ4LJfn2ILDpx4uklQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ulsabZiH+m2Ckauh7Op+2HmA+5QYg4CyKeeyab7UAjQAAXD5VhQMCSeJlH5VU3IlLnSrw7vPSMe1/zXIZ9GKD6AlOFcBYgHxiDxmRZHHSLVUwNyopF5vjkqPBCFocxXzajw916U1vXCIxxELjjI7+NfBsmD0lAaLZiJBrfEbQBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1upOQd-0000nC-6n; Fri, 22 Aug 2025 11:51:23 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1upOQb-001YYS-1P;
	Fri, 22 Aug 2025 11:51:21 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1upOQb-00A5Ry-10;
	Fri, 22 Aug 2025 11:51:21 +0200
Date: Fri, 22 Aug 2025 11:51:21 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Robin van der Gracht <robin@protonic.nl>, kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: can/j1939: hung inside rtnl_dellink()
Message-ID: <aKg9mTaSxzBVpTVI@pengutronix.de>
References: <50055a40-6fd9-468f-8e59-26d1b5b3c23d@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <50055a40-6fd9-468f-8e59-26d1b5b3c23d@I-love.SAKURA.ne.jp>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hello Tetsuo,

On Sat, Aug 16, 2025 at 03:51:54PM +0900, Tetsuo Handa wrote:
> Hello.
> 
> I made a minimized C reproducer for
> 
>   unregister_netdevice: waiting for vcan0 to become free. Usage count = 2
> 
> problem at https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84 , and
> obtained some data using debug printk() patch. It seems that the cause is
> net/can/j1939/ does not handle NETDEV_UNREGISTER notification
> while net/can/j1939/ can directly call rtnl_dellink() via sendmsg().

Sorry for long delay and than you for your investigation!

> The minimized C reproducer is shown below.
....

> Therefore, I guess that either
> 
>   j1939_netdev_notify() is handling NETDEV_UNREGISTER notification
> 
> or
> 
>   rtnl_dellink() can be called via sendmsg() despite the j1939 socket
>   are in use
> 
> is wrong. How to fix this problem?

I assume the first variant is correct. Can you please test following change:
--- a/net/can/j1939/main.c
+++ b/net/can/j1939/main.c
@@ -370,6 +370,7 @@
 		goto notify_done;
 
 	switch (msg) {
+	case NETDEV_UNREGISTER:
 	case NETDEV_DOWN:
 		j1939_cancel_active_session(priv, NULL);
 		j1939_sk_netdev_event_netdown(priv);

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

