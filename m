Return-Path: <linux-kernel+bounces-885910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4D7C343B0
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 08:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B719618884A1
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 07:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F37325C80D;
	Wed,  5 Nov 2025 07:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="FNLlsFmo"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494F8265CDD
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 07:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762327845; cv=none; b=SIqmB3ywGxCYUfaQfkmhbf2j+k605PTGwh+Se9xwQfIf8y/DLNdt/tUDQw7mKcOcx+AJAfB8TbQ4UcNsOv+szii0eOibi+NREns8Dg0AT4PisdJBaL/AfS3Hq5ttV2f64KG3ZCIrLCsI4Jgs0aqB//1wF5Xwul72C95z5gSzAHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762327845; c=relaxed/simple;
	bh=E1dOHEET+fuMIcpW2X+DT//mWVo0l6r5A9sIRy7IIxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f7Xr44d5Lp9H/LqP+RD01dfn43GQ5PPzALN/rMNtawksCQIRwLSRPJNawUUfgE1cI/i/Um9kstDapjcaEnMQoyXN0ZYytuo35OEW0Y8olj/fFyNfDJs3SPf3q/KAZ1vwDA6ERCsEKXDLUK1pa+l4ioFZDXyhlDe3h+6rF9PQA1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=FNLlsFmo; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b4736e043f9so253047166b.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Nov 2025 23:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762327841; x=1762932641; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ux6+i1bmVIFWhQiGDp7l9kTwV5Ptw+dOTwT3koSlg34=;
        b=FNLlsFmomleac0MTdyvsazTsZeqkPpYGC5NOEbOajvZ7ZKLfLg/5N1+b6vVEQWIzbq
         wGg1Kkc9s4bklbMYsKHUbGIxXnil5iElofoxsxTmIoQgCXABt44xbKRRXE6VRzIxysn9
         GBZN5ini0+W6srpl4zj2Yf9kqlmvdP2s1E5dCu7i1SQ+QeBMEpahKs24U+HUrBnD1sXn
         tye+jr3Sb0II/9o9bf3naF7h6az2TA6cmxfc/HaL0gPlYCeSKu2eYN9k7AUL35pZIf1z
         Ll8NTyzSMPz75aC54jJyrby+5QvTb3sHMxD3FfDKMJ4+18u0o0GttQXc2b4p7QFy7Mim
         O+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762327841; x=1762932641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ux6+i1bmVIFWhQiGDp7l9kTwV5Ptw+dOTwT3koSlg34=;
        b=tE6TAweXnZa3LWA4XaBhLcA5RTp9zdQ4FRF1KdVs7r190AVmbOMcNIMhR1pRMAz74w
         BUVi/8mgSIkr6EO8Om0X+29KIBVrvjiKtKskOIjbBw6SQA7rLlpN0PJ2EWr4AWOamQ6G
         AdVqSJp5iPXa3McMIE/r30SExCls3/GKUHpJ7JujVWnkWtHEBrfYATuJtIISZ7OmFT9l
         9lLV//MDYuzIggPFJu5h7E8qCvzYG8lbkf9f90JZT0KTbv+GWokBwTlypkv+LIkFMEPN
         my7wCyolewFdnxmYcEub/X61vc3OWm3VjoB0T6SE3/oIH2Mp9aXt9egh9lb9dYjmCmof
         bctw==
X-Forwarded-Encrypted: i=1; AJvYcCUUwDuWPdo7YfixZggUSJ7Jy0rjXAgqeG8kWO5iX+pi3DMpgklj11jB3uL8Lrm0anZsIB11ZbKOEZmnuNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgQ3sBLLxWKE+gv2DM3XE9Ze2HCTEhuO/LxZSMfRJQX0HAl+0S
	/XtK5f5nc7sIBynvKhgsABsF1OdznY4/5c6U2T1cl4EYNUGVc62xcdo0vKjqsJVOdpk=
X-Gm-Gg: ASbGnctvvO5m7pc35/qkOfmNZHdyfwwpjALvRXNFgxG7qIJNAtVU4DaxfTav13NhtiM
	w1qZkTerIF62fyLWnHsilxKAJdfAU9eHyOoMVJzqmSyrjbHC48dmc2J4a/yuHWSAwBw6Pi7otNS
	OyL6Ioe0OqFrAGWBz5fEe5YRiMIX/R2yvv1M78YP0rv8HvvDpLCS7bDkFGLTijLLD5QkluWCwop
	gnJsnyrJIS9JvNSQ9j/Z6p44tfYZiEhx11yrt3SZSp9UDa86+OX4/Iuy6JHxFfdcLD8Kzc3x/Fb
	rV+eJacPv3loGbUsSMA9JGko6HMb14e2Hbghun2oetsjLIrlj/xfI7VyuLnK+ThFkO4zLE2rxbB
	XA9wzw4dFzyX1UsZgN451UFDcEU76SAeTXai1exo0Ih9w560b1XwkkZ59ZRU3ol2mEBk4uOpO3W
	ekArBAKQRWPMmvpA==
X-Google-Smtp-Source: AGHT+IF4Z39tdBwbbzTMRpDJUt9P/ptkzqi1eF1iOdtCWCbeCbOmCHd88OE2YgBLVLBryIJTdoazkw==
X-Received: by 2002:a17:907:2d0e:b0:b6d:7742:c20c with SMTP id a640c23a62f3a-b72654e1f17mr170440066b.36.1762327841465;
        Tue, 04 Nov 2025 23:30:41 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b724034ade7sm414148866b.69.2025.11.04.23.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 23:30:41 -0800 (PST)
Date: Wed, 5 Nov 2025 08:30:38 +0100
From: Petr Mladek <pmladek@suse.com>
To: John Ogness <john.ogness@linutronix.de>
Cc: Sherry Sun <sherry.sun@nxp.com>, "esben@geanix.com" <esben@geanix.com>,
	"senozhatsky@chromium.org" <senozhatsky@chromium.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	Greg KH <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	"ryotkkr98@gmail.com" <ryotkkr98@gmail.com>,
	"kkartik@nvidia.com" <kkartik@nvidia.com>,
	"fj6611ie@aa.jp.fujitsu.com" <fj6611ie@aa.jp.fujitsu.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-serial <linux-serial@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [BUG] Suspend failure with nbcon + pm_debug_messages (Linux
 6.18-rc4)
Message-ID: <aQr9Hgx-AAP9i1Td@pathway.suse.cz>
References: <DB9PR04MB8429E7DDF2D93C2695DE401D92C4A@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <87tszamcaz.fsf@jogness.linutronix.de>
 <DB9PR04MB842977523C92FDE8AF4B714A92C4A@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <87qzuem7bo.fsf@jogness.linutronix.de>
 <DB9PR04MB8429F50811DDC648DD8A7B8792C4A@DB9PR04MB8429.eurprd04.prod.outlook.com>
 <87bjlhz8pw.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bjlhz8pw.fsf@jogness.linutronix.de>

On Wed 2025-11-05 00:25:55, John Ogness wrote:
> Hi Sherry,
> 
> On 2025-11-04, Sherry Sun <sherry.sun@nxp.com> wrote:
> >> Thanks for confirming the fix. I will make an official post on LKML
> >> with the patch today. Since the i.MX nbcon-driver is already
> >> mainline, I will CC stable. I will CC you as well.
> >
> > I'll keep an eye on any fixes you send later and verify them if
> > necessary. Hope this fix can be applied to the mainline and the stable
> > tree ASAP.
> 
> Even with this patch [1] I am able to reproduce the problem on one of my
> test boards. I am using the following extra boot arguments:
> 
> no_console_suspend loglevel=8 initcall_debug
> 
> And then:
> 
> # echo 1 > /sys/power/pm_debug_messages
> # echo mem > /sys/power/state
> 
> This generates a lot of output and leads to the same suspend
> failure. This may be due to the out-of-tree nbcon-8250 driver I am
> using, which introduces extra irq_work usage within the driver.

Great catch!

> Could you please try the above boot arguments with your i.MX board?
>
> I am wondering if blocking the queueing of irq_work during suspend
> should be generally implemented rather than just printk avoiding it. It
> also seems to only be a problem for ARM32 so perhaps it needs to be
> addressed at the architecture level.

IMHO, we could not _quietly_ block irq_work during the suspend a
generic way. We would need to warn about it so that the callers are
aware of it. Then the callers would need to explicitly block it
to avoid the warning.

I want to say that explicitly blocking the irq_work in printk() looks
like the right way to go. I think that it would be needed anyway.

Best Regards,
Petr

