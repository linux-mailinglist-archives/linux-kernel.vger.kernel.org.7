Return-Path: <linux-kernel+bounces-696780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FFBAE2B60
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jun 2025 21:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 690A31727E9
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jun 2025 19:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C4926A0F3;
	Sat, 21 Jun 2025 19:10:04 +0000 (UTC)
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3719F6BFC0
	for <linux-kernel@vger.kernel.org>; Sat, 21 Jun 2025 19:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750533003; cv=none; b=g/bjzHMdyLGyTXSDTxgm6/tCRSmCgqNBIQ1Davtz1UsxNs6ocd26GjUgV9NMFVUwZ8y5KEWIOvpkvkfiyn2Hlk8kcjwOc5VOdVQu8jQNDdjkMoR7mxwhzMiK1x4dkh2vP8AzRnfH1JQsy9Ias09XzKndAx54G4JXG8TLZHUvBmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750533003; c=relaxed/simple;
	bh=+qDA6oFXsHrv7Ib1PSRRkqy0Km6EE4uYDUnBmPU8ZnE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nDnhCt5PMy2kpFqiKDYENjMIzyRuTGSAM9QXEPGE51bBHz3SM9nzq/GHdUQKlOJQZpxHmCwfhG+GfRSskTeXfvCNZqzYI/wjL3GWPT+FxPX6otAeGzcsR//T/avi96TGhsUuoBCc8sppdJD9ARtL98RLszE7d47Eim3v3lxq36Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-232.elisa-laajakaista.fi [88.113.26.232])
	by fgw22.mail.saunalahti.fi (Halon) with ESMTP
	id 261e3ae0-4ed3-11f0-a5a7-005056bdf889;
	Sat, 21 Jun 2025 22:08:44 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 21 Jun 2025 22:08:43 +0300
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	gregkh@linuxfoundation.org, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 30/33] serial: 8250: invert
 serial8250_register_8250_port() CIR condition
Message-ID: <aFcDOx1bdB34I5hS@surfacebook.localdomain>
References: <20250611100319.186924-1-jirislaby@kernel.org>
 <20250611100319.186924-31-jirislaby@kernel.org>
 <aFJTQqVvmLBvrVRA@black.fi.intel.com>
 <dfb7552f-9163-4334-b137-1bf69fbdef5b@maciej.szmigiero.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfb7552f-9163-4334-b137-1bf69fbdef5b@maciej.szmigiero.name>

Fri, Jun 20, 2025 at 11:48:09PM +0200, Maciej S. Szmigiero kirjoitti:
> On 18.06.2025 07:48, Andy Shevchenko wrote:
> > On Wed, Jun 11, 2025 at 12:03:16PM +0200, Jiri Slaby (SUSE) wrote:

...

> > > +	if (uart->port.type == PORT_8250_CIR) {
> > > +		ret = -ENODEV;
> > > +		goto unlock;
> > > +	}
> > 
> > > +	if (up->port.flags & UPF_FIXED_TYPE)
> > > +		uart->port.type = up->port.type;
> > 
> > > +	if (uart->port.type != PORT_8250_CIR) {
> > 
> > I admit that there tons of mysterious ways of UART initialisation, but can you
> > elaborate how this is not a always-true conditional?
> 
> Careful here, someone had an idea in the past that this is indeed
> a dead code/branch and ended causing a regression [1].


> It would definitely make sense to add a comment describing the code
> flow there though as it proven to bewilder people.

Yes, this is my point between the lines. I left the code that may affect the
type change and the second check needs a comment explaining these cases, if any.
"If any" defines "always-true" or not conditional. W//o a comment this code
tends to be updated again and lead to a regression.

-- 
With Best Regards,
Andy Shevchenko



