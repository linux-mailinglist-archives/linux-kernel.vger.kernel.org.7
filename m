Return-Path: <linux-kernel+bounces-618455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70352A9AEC0
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 15:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 984497AF81B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Apr 2025 13:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB43427CCD7;
	Thu, 24 Apr 2025 13:16:17 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F7D1E9B32
	for <linux-kernel@vger.kernel.org>; Thu, 24 Apr 2025 13:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745500577; cv=none; b=AFqfQJ6E/wbdqaTlQB0yiDAR4RKTMLbvqde6jITS5fzWNG4GSmYOSmM2gQ3gzqF5qjAcYPtb9tMxDNJDHMvJrBoE8442DpTDLmJMlJJKAgkQC7YGogOTxkr+1X8lIzhINnc+QLZvYFiMk6ELeNYHS8hM49oL/mrt4+DxeF5LyUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745500577; c=relaxed/simple;
	bh=sf/bhdFMSup+LU7n6TlPHSwZkkX6OA+LrdGX0WgIx9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHvWvK9Ow4CMWIVMstatzvsuj2iQ07M6oQyKS4YHABj/LLQYCwdm8Lwz/tM1WLBP+w93eHTsQLVdMYc0XTgEFoWM+p5IOgXEge0dV3NoHgPyt7keOz/ZgIaQRWkv5d01NOdLQ118hlnuyGKkpBErdGeH/3pw48MkwO0y20XYonM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1u7wQv-0000NW-Vb; Thu, 24 Apr 2025 15:16:05 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1u7wQv-001tDv-1k;
	Thu, 24 Apr 2025 15:16:05 +0200
Received: from sha by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <sha@pengutronix.de>)
	id 1u7wQv-001Myw-1M;
	Thu, 24 Apr 2025 15:16:05 +0200
Date: Thu, 24 Apr 2025 15:16:05 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Artur Rojek <artur@conclusive.pl>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-wireless@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jakub Klama <jakub@conclusive.pl>,
	Wojciech Kloska <wojciech@conclusive.pl>,
	Ulf Axelsson <ulf.axelsson@nordicsemi.no>
Subject: Re: [RFC PATCH 1/2] net: wireless: Add Nordic nRF70 series Wi-Fi
 driver
Message-ID: <aAo5leoKBdCUvImP@pengutronix.de>
References: <20250324211045.3508952-1-artur@conclusive.pl>
 <20250324211045.3508952-2-artur@conclusive.pl>
 <Z-v0Ftp-oIJ0zIPR@pengutronix.de>
 <CAGhaMFNENkcwvz1yxTLVZAXuWes5OKT6HqfWAHh+=SCLc=foeQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGhaMFNENkcwvz1yxTLVZAXuWes5OKT6HqfWAHh+=SCLc=foeQ@mail.gmail.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Fri, Apr 18, 2025 at 02:46:34PM +0200, Artur Rojek wrote:
> Hi Sascha,
> 
> thanks for the review, reply inline.
> 
 >
> > > +
> > > +     ret = gpiod_direction_output(priv->buck_en, 0);
> > > +     if (ret) {
> > > +             dev_err(dev, "Unable to set buck_en direction\n");
> > > +             return -EIO;
> > > +     }
> >
> > Should this "bucken" GPIO rather be a regulator?
> >
> > Is this really mandatory? It sounds like it could be hardwired to some
> > fixed voltage.
> 
> Take this with a grain of salt, as I am not a hardware designer.
> Nordic's Product Specification document [1] stipulates that BUCKEN line
> controls the PWR IP core. In order to start the IC, a power up sequence
> is required: first the various power supply lines, then BUCKEN, then
> IOVDD signal. Similar with a power down sequence.
> To me, this reads that BUCKEN cannot be simply wired to some fixed
> voltage and needs some sort of state control. Additionally, it is
> the (only?) way for the software to reset the IC and put it into a known
> state during probe, or after a hang.
> At least for the second case, the driver needs some sort of power
> control, whether it's directly the BUCKEN line, or some other circuit
> that in turn flicks the BUCKEN. I could rename it to 'vpwr-supply' if
> that makes things more transparent. I would risk saying that it makes
> it mandatory.
> 
> PS. The annoying part about the regulator API is that it reference
> counts its usage, and as such regulator_disable() cannot be called
> without a prior call to regulator_enable(). So to power-cycle the IC via
> the BUCKEN line, I will need to do the following sequence:
> regulator_enable() -> regulator_disable() -> regulator_enable()
> But I can live with that ;)

Ok, With this explanation I think it's best to use it as GPIO like you
did. It just sounded like the regulator API would fit here, hence the
question.

Sascha

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

