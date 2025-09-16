Return-Path: <linux-kernel+bounces-818826-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CA3B596D3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 15:02:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32FB07AEBB9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Sep 2025 13:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040852D7DF7;
	Tue, 16 Sep 2025 13:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="qYNe58LI"
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D051581EE
	for <linux-kernel@vger.kernel.org>; Tue, 16 Sep 2025 13:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758027722; cv=none; b=rKxNikkAKrHaELPhHmAJDTuuIQFOHJ1QSlEJOjDgoXGFlMRUVZOCDpXJA5lR4KnyGAR7Zu1Nkpj41xxt1rEQf3HRQuo1ZESZqkc1BAR90qUbrLlxKLyhSL+bsYZM8Y5IwwlbHyvsXZ0UZkZw8mLelV3y9p/CYjCKtQznIPJIEts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758027722; c=relaxed/simple;
	bh=cWjHIZx4N3gxIdbHVSGE4LMNnD9sgtogPlptxrE1hlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ngYk72R0MB5Nk8co7yoOBHcPPNY39iMAl0C2Oz6VTbHDx4TPdNs0yEi4JZ2mGHUQ59xq6hU7BiUeGQf7TJ03Q9JTri6T4RWgX3Wrq5ZFxj5hrL0ECZkrOrm6yQ8iDWWaai1X1uWPIwHBAmmqppu4Ewlf82EJZTTQL7P6emtke2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=qYNe58LI; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 73F971A0D84;
	Tue, 16 Sep 2025 13:01:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 43A5E6061E;
	Tue, 16 Sep 2025 13:01:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5F99A102F16E7;
	Tue, 16 Sep 2025 15:01:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758027714; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=k9M61n3kgzP2GV1QhxaccbFiJSqMOAJaomD40tqnjhY=;
	b=qYNe58LIJbjugz0DRC9rB3+gaAO55rAlDyzyo/ScR5dC3Ce0Edm5vWdbLQckVZCwNgGUOO
	ABqJao4X4oksQm/R27ggwiEEKngnyu424VWl88MTDHH8FDqb7k+b4rE92M/QPed8J2Vcko
	lk5jW0Xh+KBESeIX6GfRzS8sibHlWrn3v44NMaAQigEUoXM3l1tjABqTFGATYSMuj6KgtR
	rZM1pixQWIpEnRAZLkXPs0dAV0GTOHTn5Skt62umrXOmnEFUi1Ym7aKwjkC9Dr+XIgweom
	EnY1LEmAZvuoySyzidhW1pEtoKkdbAR2B+H2JKd0u34EiQh7oNER0ehfF/HpvA==
Date: Tue, 16 Sep 2025 15:01:50 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Jorge Marques <gastmaier@gmail.com>
Cc: Jorge Marques <jorge.marques@analog.com>, Frank Li <Frank.Li@nxp.com>,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i3c: master: adi: fix header location
Message-ID: <20250916130150ed797d53@mail.local>
References: <20250916091252.39265-1-alexandre.belloni@bootlin.com>
 <jmfzuymhxvxnjwk73nmsfaaadnmy5uy4uanh4jegwgdvgfr22e@2iqtifbsgxmu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jmfzuymhxvxnjwk73nmsfaaadnmy5uy4uanh4jegwgdvgfr22e@2iqtifbsgxmu>
X-Last-TLS-Session-Version: TLSv1.3

On 16/09/2025 12:45:57+0200, Jorge Marques wrote:
> On Tue, Sep 16, 2025 at 11:12:51AM +0200, alexandre.belloni@bootlin.com wrote:
> > From: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > 
> > The adi-axi-common header has been moved to the upper directory.
> > 
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> 
> Acked-by: Jorge Marques <jorge.marques@analog.com>
> 
>   Commit: 2ad26b7bedcd4941e6dafa1851e2054b369b9d25
>   Link: https://lore.kernel.org/r/20250519-dev-axi-clkgen-limits-v6-3-bc4b3b61d1d4@analog.com
> 

Yeah, I'm a bit wary of adding the commit id here as there is no
guarantee the branch is not going to be rebased before the pull request
is sent to Linus.

> > ---
> >  drivers/i3c/master/adi-i3c-master.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/i3c/master/adi-i3c-master.c b/drivers/i3c/master/adi-i3c-master.c
> > index 162f9eed39aa..18597ba1f1c3 100644
> > --- a/drivers/i3c/master/adi-i3c-master.c
> > +++ b/drivers/i3c/master/adi-i3c-master.c
> > @@ -10,7 +10,7 @@
> >  #include <linux/clk.h>
> >  #include <linux/err.h>
> >  #include <linux/errno.h>
> > -#include <linux/fpga/adi-axi-common.h>
> > +#include <linux/adi-axi-common.h>
> >  #include <linux/i3c/master.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/io.h>
> > -- 
> > 2.51.0
> > 

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

