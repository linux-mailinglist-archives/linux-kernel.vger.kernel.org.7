Return-Path: <linux-kernel+bounces-746978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A967B12DCE
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 07:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD433189B92F
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Jul 2025 05:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5968119D880;
	Sun, 27 Jul 2025 05:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWyjjdRq"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0D33987D;
	Sun, 27 Jul 2025 05:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753595849; cv=none; b=W05JZrWUxzxIPI2CfxUtTzEJaZaNpNCOLDz6MiUVBsnmdDJJnYjZ8mUFNt9fR9xPrS8F5myN36owzBqqUNeNg0L9U0s6fYXDg9CDVtnwzzaa1HvhnUtpLwpLt1GsUmhNTzrnee+HmBwRwn+8IQ/CxRWmd4AJP6hww+yJr5wX2+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753595849; c=relaxed/simple;
	bh=NIkS8EkTTHwRgmQ0qWtztUxiOo+wfB95ULozbE2RB6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/TkqpjS7ROA00eGmAWcR14SzlBq8MJ1SFQ67VTFtAFnyEBriPiy3yEOWyC5nrVMehlsodrMtYj1tx2yuXYeHLA4ZxlMF3ppVec8WZRkiaUsrcYOpyQM4fyJaJmiwjIY721OJ0PIohBSC0ceJJtBPAubT+jaVkEjP8D/C3UcbUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EWyjjdRq; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-236377f00a1so29921365ad.3;
        Sat, 26 Jul 2025 22:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753595848; x=1754200648; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ouaLqm1R9pYu2kjb2/unKvQ+wVyFyZBELlahYoTUXkA=;
        b=EWyjjdRquEzGY1o2Xo99Oz0PNw2FzzWgAjY+2RnjtzoCGO3f3yTDF4TSBcf9Je0Xou
         76QswEGCQvECyeqeLOOj2GHbvMu2BnDmSDiITCNDT81eDPsiyfg6owBD718KXVi0hJxp
         r1qcTihrt3yFLibzhGmRGywX98sGGnjvobbM8eTlLgSnjUKA91iZJjCQbl32AecQwCLi
         OYwOj8H/nQB/H6OEX+Jv4/90kLxtyeRSTuuZKxeJPXXezMbKIOM+Vgkhg90fMW+Ld7Ah
         VBlmqGoApSWkGVGH1vwXfrrxCc3cu8hGmisurPoyhgTXwtWUfWH0PZU5HEkDR2a3yxzT
         8gnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753595848; x=1754200648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ouaLqm1R9pYu2kjb2/unKvQ+wVyFyZBELlahYoTUXkA=;
        b=N7YPfUrf1TBAP2uasHwZqBQZPtR4lLmyw46YTqTnYcYQksOG2TUEZDJbn3w5SKY3Vo
         Ybp+cLFqxBRo+GxBcfIsbTcdE/4nDu4BxZwSSPV/BhAM36GzxvilYFXw6AN0fr6cJ14O
         ZzIAQ+p+pdfyhceFGuqYGl1aWtF/o4XOt+HaqW6WZxoMF+zg+XiZ4oRpEUb4DESN5Yfr
         VSyRNPDj/Va7fopwRg/q34ralzpHnmIvsKarx6fWunS7pGb5bBhMQJZZbJuKy7O0k+JG
         Yy/ek9r2u39RxJtMI6vuMR9zPTNJL//5rhZmCZkLIPIV49B1w23FPNkBoF8KNJVOXUkF
         typg==
X-Forwarded-Encrypted: i=1; AJvYcCV5toHaUsUpPgD4T3O7+QWx5W3Yt3iLUPygczzYGNX1axXhWqUMVsnnG5KjtrNWFHiONNG8xRTUCNT6MlZk@vger.kernel.org, AJvYcCX0OYTbCujZIkWgOhJhmVTC1CgRIjpDxHaC7iBX7bdU6EruPQxKqdNJYX3efPdHMkNpvMyMVcho+X2M@vger.kernel.org
X-Gm-Message-State: AOJu0Yw599o3uRdJpSKlkJBDHJpQ5u0juHdj4ke/u2STh66y01fEwY5c
	I/B2N9AvMdsr3O4tei9xn2NaTJryWC7taTaZMRrpyOtu+xxttsPvGEBfEFfZbjEf
X-Gm-Gg: ASbGncs6z8TfDKSeB9qlwmsP2dox/ujYMdVxdUac1nNl5l8kO9IHjPEced/FZoZ8dqe
	0hXwULbSI1GOU4yF2JuNMcFaqZsYVJxFKa1RfoBgdNVE1/b/ugXfKcldQ7F+6SGhTx8hAZ9gcIN
	BDeX8h7T2ivs83Et9V+XhHYL/MfXtY9o4W+GrPBJx3gXPhkO5SgQWiRFmAKil16wabZAVvubxnq
	i5loAdDl3WvAWZiWTWrqL4e7xYNJKknPRVemK7/ZB49if+MCv8KdaCq9VULm6u2YAWXWEUiWr5C
	T/BCL2uSI8E1S7L4c6kmHKI6yoRVPJLP6OsIAKRTAfCiCX0AXcgrvbWMAEIZ2BIUMkyt04kIK3B
	zGh0CUpYJxWD5nuKiLFGH3V6mUS8E8DEy2LkLz3xkN0FIV3wKfWvFcjbEW2sxn2COvXZnkb2Me3
	0=
X-Google-Smtp-Source: AGHT+IGq8V6jL0qsxc/xLYXjd9K12nmc3vEi5z4imGq1hQgK/s5MM/Z/wf4Ba/rfxpwQws59Tqe8tQ==
X-Received: by 2002:a17:902:ce8e:b0:23f:6fa4:1567 with SMTP id d9443c01a7336-23fb2fefd31mr99604175ad.8.1753595847477;
        Sat, 26 Jul 2025 22:57:27 -0700 (PDT)
Received: from localhost.localdomain (c-76-133-73-115.hsd1.ca.comcast.net. [76.133.73.115])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe30bce5sm28251825ad.27.2025.07.26.22.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Jul 2025 22:57:26 -0700 (PDT)
Date: Sat, 26 Jul 2025 22:57:24 -0700
From: Tao Ren <rentao.bupt@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Tao Ren <taoren@meta.com>
Subject: Re: [PATCH v3 10/13] ARM: dts: aspeed: Add Facebook Fuji-data64
 (AST2600) Board
Message-ID: <aIW/xEfJX/UD1kje@localhost.localdomain>
References: <20250723233013.142337-1-rentao.bupt@gmail.com>
 <20250723233013.142337-11-rentao.bupt@gmail.com>
 <d09667e5-992e-4ced-ae30-7a4116a72c62@lunn.ch>
 <aIGGdbIX9HaV4dB/@localhost.localdomain>
 <769d6817-ee97-4a23-b013-29bc875a00cb@lunn.ch>
 <aIMTvUyHGd/ikKY9@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aIMTvUyHGd/ikKY9@localhost.localdomain>

On Thu, Jul 24, 2025 at 10:18:57PM -0700, Tao Ren wrote:
> On Thu, Jul 24, 2025 at 02:53:39PM +0200, Andrew Lunn wrote:
> > On Wed, Jul 23, 2025 at 06:03:49PM -0700, Tao Ren wrote:
> > > On Thu, Jul 24, 2025 at 02:03:20AM +0200, Andrew Lunn wrote:
> > > > > +&mac3 {
> > > > > +	status = "okay";
> > > > > +	phy-mode = "rgmii";
> > > > 
> > > > Does the PCB have extra long clock lines to implement the 2ns delay?
> > > > 
> > > > 	Andrew
> > > 
> > > Hi Andrew,
> > > 
> > > Thank you for catching it. I didn't notice the settings because the file
> > > is copied from the exiting fuji.dts with minor changes.
> > > 
> > > The delay is currently introduced on MAC side (by manually setting SCU
> > > registers), but I guess I can update phy-mode to "rgmii-id" so the delay
> > > can be handled by the PHY?
> > 
> > That would be good, if it works. The problem with the current code is
> > that those SCU registers are not set as part of the MAC driver, so it
> > is hard to know what value they have.
> > 
> > 	Andrew
> 
> Hi Andrew,
> 
> I set phy-mode to rgmii-id (letting BCM54616S handle RX/TX delay) and
> cleared SCU350 (MAC3/4 RGMII delay) register, but somehow BMC is not
> reachable over ethernet.
> 
> Let me see if I missed other settings. I will drop the mac entry from v4
> if I cannot make it work by next Monday.

Hi Andrew,

I made it "work" by updating phy-mode to rgmii-txid, and it seems like
AST2600 MAC introduces RX delay even though RXCLK delay setting is 0 in
SCU350 register.

As I'm not 100% sure where the RX clock delay is introduced, I will drop
mac3 entry in v4.


Thanks,

Tao

