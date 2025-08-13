Return-Path: <linux-kernel+bounces-766551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DCD1B247FE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 13:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C83D7B10BE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 11:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E612F6574;
	Wed, 13 Aug 2025 11:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=posteo.net header.i=@posteo.net header.b="LCd0IsQr"
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E191A9F9E
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 11:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755083202; cv=none; b=qwR62H4hDTxeBxD74nLwZnN4j1dyxl7Z9GYyWXKQvZyKSSpTPluHP85UbGY+vdFFJ8F0hCGvpRg42aItJmOjqSFovI/ft3K1lwsq1yOgpjjiSw28PEdwFSlyR3TseJ+a3WkvlY3cLdfEVfkAIb6IZqdN+DeoYLLeKhWBeCaGaAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755083202; c=relaxed/simple;
	bh=zL5jYILjg03q5A7OCrmFT1vnpldnvjNwH1orB+VxEeU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TVvkoVWKGZAQRxG7x1nEmfeY44hdKAtFgC0jwVJWyYS2KTlIVSJ0IhFY5auUcSgwpXiHnA4o7VDgdLym1EnPGIID1LnuJP9DR87OKO9vq6neZpyy26nRvMxDDkDsd40y5j5FbJc9SOtVn224JP0oaZjvPUErUuEPobmdYl8/T3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (3072-bit key) header.d=posteo.net header.i=@posteo.net header.b=LCd0IsQr; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 10E87240103
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 13:06:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net;
	s=1984.ea087b; t=1755083192;
	bh=NJ0EizDtRJJhlNZhJl1TR1dmIB5G5mhRteqDnrXTujM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:From;
	b=LCd0IsQrsfXrH+pDn/My9rdl+TZx5IA/HCLlNCNW/iBRIHkiAhe81ovfinrxq/rJ4
	 3XZk7+69XWZgHCNu/D3CFjjqxfeditCTr/Wb8XiP6tkfJpaCXS4zXyPUnMRFghl2WT
	 31uc+XEqkjmLE1czyIzwXF7SqsQsH3bSvTLLmDSGvrLNOpoOdcU3znpnnxIc6tGtfY
	 XsB6zEoUw6/6MLLrCEvLw/zD4HJRFdvgP30CjYrTzIgQOvhNiahfoOQlBQ+tzGN7V/
	 5AhJJGk0oMaJZLepMuqpfhOIeASMfvQJXUALTYjnj1VRVEEOHQeVmmsTvc95M+f7B2
	 DA1PtWaI1ClRnD5cTVPnnITXWO0JVIUq0S8SKUp3JtD64EWpR/Uzu5/ngv8/d8pL1q
	 hFP3nB9+5rtX9R+SNMe5rVnICLKUsdQyfSuRcoYkpc1wWkqmGFmKVRsxoY3KtmGfkX
	 Y13vd/o3HnSbvtw9i5HwE3daiHhF6C8niSYaO7mEumoYIDCr7tO
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4c25Cq0YLyz9rxB;
	Wed, 13 Aug 2025 13:06:30 +0200 (CEST)
Date: Wed, 13 Aug 2025 11:06:31 +0000
From: Wilken Gottwalt <wilken.gottwalt@posteo.net>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby
 <jirislaby@kernel.org>, Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH] tty: serial: 8250: exar: fix kernel warning in
 default_setup function
Message-ID: <20250813130629.03832804@posteo.net>
In-Reply-To: <aJJ49CSBqGZM_b1Y@smile.fi.intel.com>
References: <aIiDf31HzRBGuMN2@monster.localdomain>
	<2025072929-distant-hardener-0e75@gregkh>
	<20250730130348.082ad53d@posteo.net>
	<aJJ49CSBqGZM_b1Y@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Aug 2025 00:34:44 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Wed, Jul 30, 2025 at 11:03:50AM +0000, Wilken Gottwalt wrote:
> > On Tue, 29 Jul 2025 10:48:17 +0200
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > 
> > > > diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
> > > > index 04a0cbab02c2..5660bb897803 100644
> > > > --- a/drivers/tty/serial/8250/8250_exar.c
> > > > +++ b/drivers/tty/serial/8250/8250_exar.c
> > > > @@ -500,12 +500,13 @@ static int default_setup(struct exar8250 *priv, struct pci_dev
> > > > *pcidev, struct uart_8250_port *port)
> > > >  {
> > > >  	const struct exar8250_board *board = priv->board;
> > > > +	unsigned int bar = 0;
> > > >  	unsigned char status;
> > > > -	int err;
> > > >  
> > > > -	err = serial8250_pci_setup_port(pcidev, port, 0, offset, board->reg_shift);
> > > > -	if (err)
> > > > -		return err;
> > > > +	port->port.iotype = UPIO_MEM;
> > > > +	port->port.mapbase = pci_resource_start(pcidev, bar) + offset;
> > > > +	port->port.membase = priv->virt + offset;
> > > > +	port->port.regshift = board->reg_shift;
> > > 
> > > And so now serial8250_pci_setup_port() is never called?  Are you sure
> > > that's ok?
> > 
> > Hi Greg,
> > 
> > I will not provide a second version of this patch, because this is a bigger
> > problem involving 8250_exar, 8250_pci and 8250_pci1xxxx. With the changes from
> > kernel 6.10 to 6.11 the underlying pcim_* functions where changed. The
> > serial8250_pci_setup_port() does checks on pci_dev + BAR where resources were
> > already mapped via pcim_iomap(), pci_iomap() or even pci_ioremap_bar(). Not
> > sure if mixing this is a good idea after the kernel 6.11 changes.
> > 
> > serial8250_pci_setup_port() uses pcim_iomap() and pcim_iomap_table() for checking
> > these already mapped resources. But the pcim_iomap_table() is deprecated and
> > suggests to use pcim_iomap() function to aquire the pointer to the resources
> > while at the same time pcim_iomap() description states, don't use this function 
> > twice on the same BAR. I think the most sane approach would be to drop the
> > pcim_iomap() and pcim_iomap_table() checks from the serial8250_pci_setup_port()
> > function. But I can not fully test this, I only have access to some hardware
> > used by the 8250_exar driver. I also CC Andy and Parker, both worked on the
> > affected code.
> 
> I'm on vacations right now and I lost context of this a long ago, please Cc me
> to any new version of this change to have a fresh look.

Hi Andy,

there is not much to add here. It is basically a recursivly added issue and
affects the three mentioned drivers. In my opinion it is safe to remove the
pcim_iomap() and pcim_iomap_table() functions checks from the generic
serial8250_pci_setup_port() function. To me it looks like the "newly"
implemented pcim_iomap(), which should not be used twice on the same pci bar,
is the only issue here. But I can only speak for the 8250_exar driver. We
use the fix in productions systems and it solves the issue. But beyond that?
To me the change of the pcim_iomap() looks like a design flaw in general,
allowing io-mapping only one resource per pci bar looks odd to me, but I am
not knowleged enough about these subsystems.

greetings

