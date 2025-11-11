Return-Path: <linux-kernel+bounces-895257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E83C4D5C8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 12:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A13C934310E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Nov 2025 11:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020E934AB15;
	Tue, 11 Nov 2025 11:17:12 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DBC34D92E
	for <linux-kernel@vger.kernel.org>; Tue, 11 Nov 2025 11:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762859831; cv=none; b=Q6zGjvaI2pu/hNOHPaQxCv7EuYzdJc7m9AwXbyho6XDTg89nUUjvCV05wglcgkGD1tHOVFqhzy2qQRzclHW7RHjLpd+xsC4SNjaNZgxRc6fwkVNEjHAwRrrBI9lcNCjubBaOOvZNtT62PZoB3AwVUTFY83QFn21TnWtpFBDXRq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762859831; c=relaxed/simple;
	bh=uXKNyH5ermYmOE7AaALivQQxfbhotXP7qcgta6fTn8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bsBCjhY1hArJ1f51uMTi2P5e39ozwuFvJXaesVWx/tjGSizLQETlxxeu5cFqT9w1sTnoMD04GgK3JMnafjNfyjtJViot2G0jg23UYAog8fVaEmB76Mhd3qgC/FWUU2+nqIHcDl8g7QCSQv+cfJMjIYv3z7uv9MglmMfXAGsdzmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mfe@pengutronix.de>)
	id 1vIm7c-0006Uh-Vj; Tue, 11 Nov 2025 12:01:12 +0100
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1vIm7b-008BcB-0G;
	Tue, 11 Nov 2025 12:01:11 +0100
Received: from mfe by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <mfe@pengutronix.de>)
	id 1vIm7a-00ET0X-32;
	Tue, 11 Nov 2025 12:01:10 +0100
Date: Tue, 11 Nov 2025 12:01:10 +0100
From: Marco Felsch <m.felsch@pengutronix.de>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Russ Weight <russ.weight@linux.dev>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kamel Bouhara <kamel.bouhara@bootlin.com>,
	Marco Felsch <kernel@pengutronix.de>,
	Henrik Rydberg <rydberg@bitmath.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v3 1/4] firmware_loader: expand firmware error codes with
 up-to-date error
Message-ID: <20251111110110.io65cbslrv75lbby@pengutronix.de>
References: <20250821-v6-10-topic-touchscreen-axiom-v3-0-940ccee6dba3@pengutronix.de>
 <20250821-v6-10-topic-touchscreen-axiom-v3-1-940ccee6dba3@pengutronix.de>
 <ifdhjgo6wchlsztqvgkaawpbnh3zahb76vmyzlomokfrqt6tjp@qjcdvcdqviag>
 <5tlhy2jl77etqxsna42ksdmvu3x3bsp5c44poshkt45agldfsj@bkzlvbfoshsl>
 <20251016145205.244gsevx5tdloiqy@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016145205.244gsevx5tdloiqy@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On 25-10-16, Marco Felsch wrote:
> Hi all,
> 
> On 25-09-20, Dmitry Torokhov wrote:
> > On Wed, Aug 27, 2025 at 03:29:33PM -0600, Russ Weight wrote:
> > > 
> > > On Thu, Aug 21, 2025 at 07:26:36PM +0200, Marco Felsch wrote:
> > > > Add FW_UPLOAD_ERR_DUPLICATE to allow drivers to inform the firmware_loader
> > > > framework that the update is not required. This can be the case if the
> > > > user provided firmware matches the current running firmware.
> > > > 
> > > > Sync lib/test_firmware.c accordingly.
> > > > 
> > > > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > > 
> > > Reviewed-by: Russ Weight <russ.weight@linux.dev>
> > 
> > Does this mean I should merge this through input tree?
> 
> may I ask how this is planned to go further?

Gentle ping.

Regards,
  Marco


> 
> Regards,
>   Marco
> 
> > 
> > Thanks.
> > 
> > -- 
> > Dmitry

-- 
#gernperDu 
#CallMeByMyFirstName

Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | https://www.pengutronix.de/ |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-9    |

