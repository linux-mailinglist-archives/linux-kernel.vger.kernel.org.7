Return-Path: <linux-kernel+bounces-871324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF01C0CEB6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 11:18:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 77C314EBEB6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 10:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0A92F363F;
	Mon, 27 Oct 2025 10:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="pkKQHn3n"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8D7134BD
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 10:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761560277; cv=none; b=kKLI5BM7GpOEGkye6PXTCydcRRQaTfBb3TbyzyRlIZ57FqM6Al5srEXEh5ZGcy2tXrGlj0b7cV7QyPHEcAGVAbV89gYtUM/H7vNIobBUaKAviGy5ZU0if5d/uTPKl8xRVhCEwYhUB/ocOW8md1Y7wY8LOuZI0Z0MMrLwugbbZA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761560277; c=relaxed/simple;
	bh=VlS7+HlKBSECYTt1bDBOxvEU+ZOLlEUucB1RHUNo4pI=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LJZXS0nG7U79HnRBd5ZBibEtUhPBrCPjgR+uSF09djBWo0ycL5nirHh4x7GtwfL1Puc/8CDr0Ekzg760wEI1f4jXulLKBhyIKUMefsAh+b1MikuYS0KftOcWDR6u/9LJmj3a+2HXessYBGJf9mOOY5oN4iDut11qzk52hE2W+t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=pkKQHn3n; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id B4FB041966
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 10:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1761560266;
	bh=9DhDySVvD7mdReEgfjhQfxSVU5DcbAQWOe9Vkh93eqY=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=pkKQHn3nqe04ZTRnWokHhu+DGeHofYpmTTQ+7uiaGOvTOvFFZW/uyGN3aYqtqy4NC
	 IhYFt/HShMGy+LH43TQ/J+rs6XzTn0z/Ld7TVz+wphNs01NabFT/HSK5azJpMJVNai
	 0PKuNJpWCj9PHydibPPT1lVIjWJdoqEuHLGatxAI9jMOvqQdagHd66QABeBXvZ3M7a
	 2OxYBSaDLHX/O8WzlsCfKtlKyQ8Y6o1hXITggJ6kbWVjpfWrIHOa3xg+GIOzNAUbgD
	 /8Mosg7qudpZiLEeii+Ms6WETZUPtVya4VwYWSLiwTsS7c1Jh5Wrq/R5vFP4ERS90C
	 InCp+53xv969t8n6z9mKDE/acnNhI160yjWnRxvgCtnvNVEJAHS4R8m3Y2eJPeqBZY
	 eZsX7UT2O4BeQk0dHJspZ1LAzGdLJyLXrrJy7bNxdpLuaIj4PKI4AzKrvnx3WJpPYn
	 JtYQBe36PJNuajL9wlda6l3IFGP9ZjXSTfF4NIjGdqL8FwoJWoJvh0Zw5j2wMM0rki
	 0JGzZd3g9V+gHcjv6TiuvKX5QpJO6d5cqjtJXeFbRI5SsxNk9eTugBDzrsq/kq31zb
	 iCFOTM9b6zTzDTPra2ZkFbV7unzpinT//cgR7eN+8X8Ll3hlX+/YjWQtLLlLon0nR4
	 CYtaxJzbaji+fYHeRjvwHyRQ=
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-5db24da6d69so10647107137.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 03:17:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761560264; x=1762165064;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9DhDySVvD7mdReEgfjhQfxSVU5DcbAQWOe9Vkh93eqY=;
        b=xPgHzzNvlc/ZQ6yB8x1JaAhuod2R05w+hmP7fxK+cf/S/3bQH/B69Zf0CPD5MXpiN/
         zSJRJ+wfYi9Tx7mHucE/AwR1QXzK0veiysAx6kP9/1Mtyw1tk93XKRQ5UCDEq2uDDENc
         TY01sy/0NOLhC+tICebo0EJY9bPEKM4uimEL0dDphVuOfkhdrwd9hAtlhK1CouswU+2F
         1ABxw/wkWSvE/910o/RK9tHIwLT4h7QrO+MRkMzs9m3V7BI6w7bYFPrVg33NIODM0kj8
         r+K1QyMFqsxw9J5SDgKtgpoX3d2dJKKP1NzqYclCnkuN94Cx86GqJop5joUcuajHDz/G
         FY9w==
X-Forwarded-Encrypted: i=1; AJvYcCWuzztbgb3ogbtxjDZijTdS98IIPpFG4nV3jNbTtaZv8aWCueiYdmGhv36gqn6qs7G4jUDSllJPlPI2ShA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq2BPrrAAhOgxnEUSdKtGKYf1BurYIj8RX/Was9O+1nlEighWZ
	Qr5eTireZ2DGx3Y8yWHzP+Cz/IHUsH13Ut0LxRYW0iSB4M7J+ZUIEfCKCtQV2f59bAPe1EkozeS
	/K+Yw45V0g72u5NyoZKI5npFN9HNTz5FA5fGLS8/WbN6DG0ME8/aD2QAU5W6R3Re9J/A7I0U92a
	kqhbs9m/ZYcym8lipehezA96x2LkwO8h+0XdlXV2vbGoTEROvHMiVfOk1H
X-Gm-Gg: ASbGncsMHwDBerYq6YhQCSNS98jaeCE0DfBOGR4ZaiPkC6NlCkPNjSbu3IYyDgdz4D+
	zIWnNA2Zv0W6v9bO0VR6aqxsXhWyx89sJc4zOed6ZqO3BV95iwkxcypqq7zaKLhq1BmoH4m+4v1
	G+Yt74IcIp7FPBjSjzlRGXCqJIs86rzPdP1deOxR0Qv6qcv59WM5Kn6A==
X-Received: by 2002:a05:6102:954:b0:5d5:f40d:28cc with SMTP id ada2fe7eead31-5d7dd6a1b92mr14555707137.34.1761560264189;
        Mon, 27 Oct 2025 03:17:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdPvzfUWy+KzTQx0NZKC+viVyDjrKZWPq/ag/aFPbstdqmRZATfbto1tMny89+DUKS+pVIxA5PrA3lQ+wZpqk=
X-Received: by 2002:a05:6102:954:b0:5d5:f40d:28cc with SMTP id
 ada2fe7eead31-5d7dd6a1b92mr14555692137.34.1761560263720; Mon, 27 Oct 2025
 03:17:43 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 27 Oct 2025 03:17:43 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 27 Oct 2025 03:17:43 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <aP86TltQ2uqeK6FY@pie>
References: <20251026224424.1891541-1-aurelien@aurel32.net>
 <20251026224424.1891541-2-aurelien@aurel32.net> <A73D83A7055D782E+aP7lAdAk66slv6l7@kernel.org>
 <aP8QHwsYDlbQxQJo@pie> <mvmh5vk67in.fsf@suse.de> <aP86TltQ2uqeK6FY@pie>
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
User-Agent: alot/0.0.0
Date: Mon, 27 Oct 2025 03:17:43 -0700
X-Gm-Features: AWmQ_bkt48PMnhkCO0H9qLGejhLpBvvYCPQTMfZ0eF7vE7Bd7Gc1hHCSa_6NREU
Message-ID: <CAJM55Z9w0pnFmVjJKJNMs1iqOxoL=YpkBu0L7NuUZ_0ipMtQAQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] driver: reset: spacemit-p1: add driver for poweroff/reboot
To: Andreas Schwab <schwab@suse.de>, Yao Zi <ziyao@disroot.org>
Cc: Troy Mitchell <troy.mitchell@linux.spacemit.com>, Aurelien Jarno <aurelien@aurel32.net>, 
	linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>, Yixun Lan <dlan@gentoo.org>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, linux-riscv@lists.infradead.org, spacemit@lists.linux.dev, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Yao Zi (2025-10-27 10:24:30)
> On Mon, Oct 27, 2025 at 10:03:44AM +0100, Andreas Schwab wrote:
> > On Okt 27 2025, Yao Zi wrote:
> > > On Mon, Oct 27, 2025 at 11:20:33AM +0800, Troy Mitchell wrote:
> > >> On Sun, Oct 26, 2025 at 11:41:14PM +0100, Aurelien Jarno wrote:
> > >> > diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> > >> > index 8248895ca9038..61c16f3d5abc7 100644
> > >> > --- a/drivers/power/reset/Kconfig
> > >> > +++ b/drivers/power/reset/Kconfig
> > >> > @@ -283,6 +283,15 @@ config POWER_RESET_KEYSTONE
> > >> >          help
> > >> >            Reboot support for the KEYSTONE SoCs.
> > >> >
> > >> > +config POWER_RESET_SPACEMIT_P1
> > >> > +        tristate "SpacemiT P1 poweroff and reset driver"
> > >> > +        depends on ARCH_SPACEMIT || COMPILE_TEST
> > >> > +        depends on MFD_SPACEMIT_P1
> > >> > +        default m
> > >> default m if ARCH_SPACEMIT? Or default ARCH_SPACEMIT?
> > >> I believe that reboot and shutdown are actually essential functionalities,
> > >> so it might make more sense: default ARCH_SPACEMIT?
> > >
> > > I don't think there's anything preventing it to be built as module by
> > > default: even though it's "essential", it's unnecessary during kernel
> > > and userspace startup, thus I see no reason to build it in the image.
> >
> > Wouldn't it be needed in a reboot-on-panic situation?
>
> Oops, yeah, I missed this stuff. Seems systemd automatic boot assessment
> could switch to another boot option if one fails to boot. And if it's
> caused by a (very early) kernel panic, then reboot support does play a
> part here.

But if systemd is running then you've at least got as far as the initramfs,
and have the module available. So I don't see the problem.

/Emil

