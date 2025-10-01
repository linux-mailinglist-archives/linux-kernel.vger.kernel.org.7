Return-Path: <linux-kernel+bounces-838545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF85BAF76B
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 09:43:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04F174A14D5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 07:43:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A58274650;
	Wed,  1 Oct 2025 07:43:22 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B081273D66
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 07:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759304602; cv=none; b=tLHD7FeAWD1daEaqthEZOUp84QzWdCKfduaFCVmcfIKLOjdBH63oQX8Ll1j3ItPsWr9bwBuoyScwNFsrHRdC837e92bD9/A1VwBgnde7x+CJs6xJQCrT3oWTb6nNhSA+RiBfwYXai4MkvBFheRXOs+rKyUSVaJJuDDtwiBZSxiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759304602; c=relaxed/simple;
	bh=gwQUi+de6VXVjLGqT/JXgA7Hht52xsPf+ID99icPCbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YCJJ9sfga2Hd+P4u1LY7DDYoKOLAhEYb7l0wdTo5G/0g3Kx0HGf3jnCQHVX5jjYmCryLe5wQgCbEpVjl87l62xRJ+s2brPr6UUA7t71wIBZOYndntR7EVC6TAH9H8/hU+vNkbsfg+eUeq1Ns9bVRfRSYneK6mxbQGmwDTtSbvT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1v3rUK-00074Z-FU; Wed, 01 Oct 2025 09:43:00 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1v3rUJ-001NRj-0M;
	Wed, 01 Oct 2025 09:42:59 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1v3rUJ-006RWI-01;
	Wed, 01 Oct 2025 09:42:59 +0200
Date: Wed, 1 Oct 2025 09:42:58 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Thangaraj.S@microchip.com,
	Rengarajan.S@microchip.com, UNGLinuxDriver@microchip.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+62ec8226f01cb4ca19d9@syzkaller.appspotmail.com
Subject: Re: [PATCH] net: usb: lan78xx: Fix lost EEPROM read timeout
 error(-ETIMEDOUT) in lan78xx_read_raw_eeprom
Message-ID: <aNzbgjlz_J_GwQSt@pengutronix.de>
References: <20250930084902.19062-1-bhanuseshukumar@gmail.com>
 <20250930173950.5d7636e2@kernel.org>
 <5f936182-6a69-4d9a-9cec-96ec93aab82a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5f936182-6a69-4d9a-9cec-96ec93aab82a@gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 01, 2025 at 10:07:21AM +0530, Bhanu Seshu Kumar Valluri wrote:
> On 01/10/25 06:09, Jakub Kicinski wrote:
> > On Tue, 30 Sep 2025 14:19:02 +0530 Bhanu Seshu Kumar Valluri wrote:
> >> +	if (dev->chipid == ID_REV_CHIP_ID_7800_) {
> >> +		int rc = lan78xx_write_reg(dev, HW_CFG, saved);
> >> +		/* If USB fails, there is nothing to do */
> >> +		if (rc < 0)
> >> +			return rc;
> >> +	}
> >> +	return ret;
> > 
> > I don't think you need to add and handle rc here separately?
> > rc can only be <= so save the answer to ret and "fall thru"?
> 
> The fall thru path might have been reached with ret holding EEPROM read timeout
> error status. So if ret is used instead of rc it might over write the ret with 0 when 
> lan78xx_write_reg returns success and timeout error status would be lost.

Ack, I see. It may happen if communication with EEPROM will fail. The same
would happen on write path too. Is it happened with real HW or it is
some USB emulation test? For me it is interesting why EEPROM is timed
out.

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

