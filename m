Return-Path: <linux-kernel+bounces-802367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27147B45194
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 10:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C48DE5A6792
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 08:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910CD27C17E;
	Fri,  5 Sep 2025 08:30:39 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607D7277C8D
	for <linux-kernel@vger.kernel.org>; Fri,  5 Sep 2025 08:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757061039; cv=none; b=HuPY+cjnugbVuKDSYtwWppam+lhMFra4W97RbXMY7KAm4CmcN40Ra9TcilXoPDcXIKPSN1Ymv5bJRyzyEErXslVEo5qUz3cvOdJpK/7ZB3hRmNH5co/dENTZOQJ41KTp6IklkcEaSgHnPPhK3XjBoi2tju/ySpEiEcxpssvJL2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757061039; c=relaxed/simple;
	bh=fSUZr85u55qz3E78iqTjDjChbiZpRIa278RUQ6PPAhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+7aZbj4q301hGvx11QRDTEPoHverXOtMVDRrHVztHfKSt06oE1ofG5MO582f4TiAF0jr0TzlrJjKhAwQdtFkz6MOVX1FO8jUeKIhOdizhGtAzdkii3PtLPPpiN/b4IEQHisUYXZpbGNLRK6Ttxej44NPmFbkwzWEvSQ8WRkbn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uuRq2-0006bu-EL; Fri, 05 Sep 2025 10:30:30 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uuRq2-003rTf-0p;
	Fri, 05 Sep 2025 10:30:30 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uuRq2-004Gq7-0T;
	Fri, 05 Sep 2025 10:30:30 +0200
Date: Fri, 5 Sep 2025 10:30:30 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Robin van der Gracht <robin@protonic.nl>, kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] can: j1939: call j1939_priv_put() immediately when
 j1939_local_ecu_get() failed
Message-ID: <aLqfpqn80TphoBG2@pengutronix.de>
References: <4f49a1bc-a528-42ad-86c0-187268ab6535@I-love.SAKURA.ne.jp>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <4f49a1bc-a528-42ad-86c0-187268ab6535@I-love.SAKURA.ne.jp>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Sun, Aug 24, 2025 at 07:30:09PM +0900, Tetsuo Handa wrote:
> Commit 25fe97cb7620 ("can: j1939: move j1939_priv_put() into sk_destruct
> callback") expects that a call to j1939_priv_put() can be unconditionally
> delayed until j1939_sk_sock_destruct() is called. But a refcount leak will
> happen when j1939_sk_bind() is called again after j1939_local_ecu_get()
>  from previous j1939_sk_bind() call returned an error. We need to call
> j1939_priv_put() before j1939_sk_bind() returns an error.
> 
> Fixes: 25fe97cb7620 ("can: j1939: move j1939_priv_put() into sk_destruct callback")
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

Tested-by: Oleksij Rempel <o.rempel@pengutronix.de>                                                                                                             
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

