Return-Path: <linux-kernel+bounces-814265-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 232C3B551CE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 16:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2079B1D66892
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1027A313533;
	Fri, 12 Sep 2025 14:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="m1AbP2Ti"
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B0B3128A6
	for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 14:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757687393; cv=none; b=Wjmnn6k/ixxXWrdwkKJnVPk+P0KLzLYmrm7fXPo8dgbDjtV0+1HdMhOlWwL6QXWQaJwbAWp+m87yj+L5edY7VW2eyQFZAFg6d7no31bouqbl5InXNh3FUFABDg03IGg21SnDRLZWkCwJgIoAK5W6BeHICaYFCd5qAfRfxIKlEno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757687393; c=relaxed/simple;
	bh=hV+fkBeoyEL70BR3AZPZk+/IitPWaFSZ0qChnKQvBhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oR8uofJi6zVDj3co96mmeETL0UNR5R8jbyDWgthZ4NgknwT/g5f2h1hnWnpgD2uWoeCgNVYO/tU+eh+s1PtSjaBdF7txPlBwd7JysdPBB1/RyTWbSbNzG79Ds3faarTiyKCrOOmklWcQvTCkXuZcD6z6SxNZKrie6p7PvGlFq3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=m1AbP2Ti; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-80e3612e1a7so327120485a.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Sep 2025 07:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1757687391; x=1758292191; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S3815g4jYHJhhlasvHknAmQ5Z8UgQ2k4aKoITX7J8o4=;
        b=m1AbP2TiBWtGuDVgJM36Uezne+LnA/gzOl8SdHNdXU34loo/EgugyBnirTRGsxRW3m
         k8nKZ+auOjobx9jh0dA63MFEDUbgqMvQP9/qmSArJJ0jfqxR6v8x4h3mECdnal7q0Wxj
         3K5na5eCWipWSvNNxvxLGqNGC7dLOXzEDghMojfkXqM0gRQNiXhEuNP8+t+xF0olzl7h
         Kwwddtadp+J11xnRaMrKXx3YwWXctlNqvvkLJ0k2BUmLq5zwVJiAkTS+dJ2BHVoCerYy
         4aFY2YYTmC4/VcbIxCxzVSu0wr0j4+WPVm2dR+eO0+AcrU6ok/J75dFtFx6FpgvUa3IK
         XVeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757687391; x=1758292191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S3815g4jYHJhhlasvHknAmQ5Z8UgQ2k4aKoITX7J8o4=;
        b=R/wy+fgT+Lcu3DQ4fjRd6D+oPjCUOjJPDuhpBfx1/zZJ41de/q06hgK9gkLB2BD/JC
         rAu0rnlcTsibPTJhxw3UbcoqidMScEk5dvfDdko+NM9y0W+1FoUfevAzQlcF8S5nJjUt
         4Y5yNpgRmlyYRWT5G1wvMQF1l8YFL7i9+izQT9VNNqvsKflrBRsMP8bux563qRm1V6ox
         6BrH1DMBULtShmjuRRNpCa8Kj7OST1PF8AgyvSfm3UhGSXSN0oDryfcOcPTto8gXnL9g
         0QtFRcbHSei5tH7VLic2oyG2zSkNQ3Z1ykjY5w6UfgJkGN3Y/N1RlaBDqIL1VMTud0//
         Z9hw==
X-Forwarded-Encrypted: i=1; AJvYcCW7tv6DBI/MKrQCAMgH3GwBgAEl0vPGUSexm95NIGwX/1efXSY0wgzQqs69SjnFpuYMayp8UmDI5dIFLoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpGjnqKhs/b8RNy4T/IRlaHs/0Xzmnvk5hOURYygITVxBODpKT
	a27muJfv11Jw9BnjGhnWb/Ax1aDMMP8bDitQ59Mf2KjqizhN8C4dV9wownjGz9Nrpg==
X-Gm-Gg: ASbGnctSATMqoUMKBKYCuk2xJCg4d77vDqMW4oMYSDldDBI1+OyuaIone40Xja5K5Du
	rlUjrI5CKAcZOY1aMTYAOvheeQv3nKvzI/wVhO7HdreiyoOJjLrwunIzRJILYgYUrbNMIjShwWZ
	4mkWZo+DOxt56/MG2kWERMdm7MjG5SpZRiI33Ru62MsruOpYy1CQxDR2ip74532mfSKcAf8xexS
	v5x90i/zV5POfs7H5sYVV+CQ/VE5/uk6Y1rLzbzI8/9rGHrkkNTtbPAMuLD0f3BCfvOdqFmaLxH
	1bFaZkuVZIk4xDqGo9ZPg5W+bBxIhlXdpEG7jLHcyZfYpLEkxWf2+pUH2mbB+Xk56Zd4h7eMdSs
	V+rcDIt+ZHxGh0nSxMjSWHwaerz/WVZOjfCI=
X-Google-Smtp-Source: AGHT+IFHGCNDq4E3kronwhkO+pICG0brIM0Kb9Hz7hqiD4Sy52fYKpi6o68Y7702rWJbbRJBfdlK+A==
X-Received: by 2002:a05:620a:190f:b0:823:a881:e447 with SMTP id af79cd13be357-824013d8d5bmr375511385a.77.1757687390335;
        Fri, 12 Sep 2025 07:29:50 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:d03:1700::6aa9])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-820c974d68dsm276204885a.16.2025.09.12.07.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 07:29:49 -0700 (PDT)
Date: Fri, 12 Sep 2025 10:29:47 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Hubert =?utf-8?Q?Wi=C5=9Bniewski?= <hubert.wisniewski.25632@gmail.com>,
	stable@vger.kernel.org, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Lukas Wunner <lukas@wunner.de>, Xu Yang <xu.yang_2@nxp.com>,
	linux-usb@vger.kernel.org
Subject: Re: [PATCH net v1 1/1] net: usb: asix: ax88772: drop phylink use in
 PM to avoid MDIO runtime PM wakeups
Message-ID: <a25b24ec-67bd-42b7-ac7b-9b8d729faba4@rowland.harvard.edu>
References: <20250908112619.2900723-1-o.rempel@pengutronix.de>
 <CGME20250911135853eucas1p283b1afd37287b715403cd2cdbfa03a94@eucas1p2.samsung.com>
 <b5ea8296-f981-445d-a09a-2f389d7f6fdd@samsung.com>
 <aMLfGPIpWKwZszrY@shell.armlinux.org.uk>
 <20250911075513.1d90f8b0@kernel.org>
 <aMM1K_bkk4clt5WD@shell.armlinux.org.uk>
 <22773d93-cbad-41c5-9e79-4d7f6b9e5ec0@rowland.harvard.edu>
 <aMPawXCxlFmz6MaC@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMPawXCxlFmz6MaC@shell.armlinux.org.uk>

On Fri, Sep 12, 2025 at 09:33:05AM +0100, Russell King (Oracle) wrote:
> On Thu, Sep 11, 2025 at 10:30:09PM -0400, Alan Stern wrote:
> > The USB subsystem uses only one pair of callbacks for suspend and resume 
> > because USB hardware has only one suspend state.  However, the callbacks 
> > do get an extra pm_message_t parameter which they can use to distinguish 
> > between system sleep transitions and runtime PM transitions.
> 
> Unfortunately, this isn't the case. While a struct usb_device_driver's
> suspend()/resume() methods get the pm_message_t, a struct usb_driver's
> suspend()/resume() methods do not:
> 
> static int usb_resume_interface(struct usb_device *udev,
>                 struct usb_interface *intf, pm_message_t msg, int reset_resume)
> {
>         struct usb_driver       *driver;
> ...
>         if (reset_resume) {
>                 if (driver->reset_resume) {
>                         status = driver->reset_resume(intf);
> ...
>         } else {
>                 status = driver->resume(intf);
> 
> vs
> 
> static int usb_resume_device(struct usb_device *udev, pm_message_t msg)
> {
>         struct usb_device_driver        *udriver;
> ...
>         if (status == 0 && udriver->resume)
>                 status = udriver->resume(udev, msg);
> 
> and in drivers/net/usb/asix_devices.c:
> 
> static struct usb_driver asix_driver = {
> ...
>         .suspend =      asix_suspend,
>         .resume =       asix_resume,
>         .reset_resume = asix_resume,
> 
> where asix_resume() only takes one argument:
> 
> static int asix_resume(struct usb_interface *intf)
> {

Your email made me go back and check the code more carefully, and it 
turns out that we were both half-right.  :-)

The pm_message_t argument is passed to the usb_driver's ->suspend 
callback in usb_suspend_interface(), but not to the ->resume callback in 
usb_resume_interface().  Yes, it's inconsistent.

I suppose the API could be changed, at the cost of updating a lot of 
drivers.  But it would be easier if this wasn't necessary, if there was 
some way to work around the problem.  Unfortunately, I don't know 
anything about how the network stack handles suspend and resume, or 
what sort of locking it requires, so I can't offer any suggestions.

Alan Stern

