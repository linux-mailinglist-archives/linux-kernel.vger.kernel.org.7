Return-Path: <linux-kernel+bounces-799291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B92B4299F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 21:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D342C3B5E3C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 19:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39397350D76;
	Wed,  3 Sep 2025 19:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gS3mKbMF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE1F2D374A;
	Wed,  3 Sep 2025 19:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756927060; cv=none; b=JpZoG85biDGZl5knz7sYdwCU8MuYZG2F4AZuk9FDHQcgB7Yeep6kqIyqgwHZ8rqIsrbdyzEc0XBa7qr45N+XUstp2M1QQzb+/huBMe9/uM17Ujb6iyUXg3p/x5+2UL1ug52EFvtYHcDqXvEWA/klvT+pW10+zJ2xaZflEQcRx6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756927060; c=relaxed/simple;
	bh=g/Bz4I6EWjnXiglfW0xnAhMe1F3tQ/a9mgK7S6YMdN0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lQBU1gXKQ69GXjL+6z4K2DX7hpBRCmh6EVl6IxS2+d9tMpWFgD8u6xudBYDO5po7m11K9HY0f/HU5cVmHy/89ShoPFeDx7kzvnmUNLkCGZiCty/8/tf91k0ybk5cf6TQ6BwneGevVmh9T7nAMGlGXkDsb5Ec9UN+4RlloFw5H0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gS3mKbMF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8135C4CEE7;
	Wed,  3 Sep 2025 19:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756927060;
	bh=g/Bz4I6EWjnXiglfW0xnAhMe1F3tQ/a9mgK7S6YMdN0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gS3mKbMFFfM1sF+4vr4MZRsga3oIjgveJIbt4Gk2a7fjaU3DTtgliLwygscwY9+W9
	 W9xDtE04f3+XxhzgOypXVCvK0cm8Rivq5m1jiZYE7oqD+Mu1VBWP+cxqEEn6DkaS0U
	 16lTlkEeEkwmBA3VjM+EZiEnkNiEdUH7So1LAGfi8FeHreWDrBAKn2gnYuc+sPXG4F
	 kBjLOeeeMJdf28QohPM5MwTSQLDzy/HSHJ8EhCdEhsJU7/8cDMeZmmQ5DSjxgOEU5X
	 +VicOPrz1o0jh8PZn+0kIi3ys7l+GzcAfskb6LwKAJcHL2byyB6gUgqFxJAHUgxklT
	 6wzSwd437uE3g==
Date: Wed, 3 Sep 2025 21:17:35 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Linux Doc Mailing List
 <linux-doc@vger.kernel.org>, =?UTF-8?B?QmrDtnJu?= Roy Baron
 <bjorn3_gh@protonmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, Alice Ryhl
 <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo
 <gary@garyguo.net>, Trevor Gross <tmgross@umich.edu>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 3/3] tools/docs: sphinx-* break documentation bulds
 on openSUSE
Message-ID: <20250903211735.5a541530@foz.lan>
In-Reply-To: <76c552d4-878f-4ec4-a22c-c5b0f7903eba@infradead.org>
References: <cover.1756916565.git.mchehab+huawei@kernel.org>
	<29135db8c8094006f256e1fa0b64663c735737e7.1756916565.git.mchehab+huawei@kernel.org>
	<76c552d4-878f-4ec4-a22c-c5b0f7903eba@infradead.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Wed, 3 Sep 2025 10:41:12 -0700
Randy Dunlap <rdunlap@infradead.org> escreveu:

> On 9/3/25 9:24 AM, Mauro Carvalho Chehab wrote:
> > Before this patch, building htmldocs on opensuseLEAP works
> > fine:
> > 
> >     # make htmldocs
> >     Available Python versions:
> >       /usr/bin/python3.11
> > 
> >     Python 3.6.15 not supported. Changing to /usr/bin/python3.11
> >     Python 3.6.15 not supported. Changing to /usr/bin/python3.11
> >     Using alabaster theme
> >     Using Python kernel-doc
> > 
> >     ...
> > 
> > As the logic detects that Python 3.6 is too old and recommends
> > intalling python311-Sphinx. If installed, documentation builds
> > work like a charm.
> > 
> > Yet, some develpers complained that running python3.11 instead
> > of python3 should not happen. So, let's break the build to make
> > them happier:
> > 
> >     $ make htmldocs
> >     Python 3.6.15 not supported. Bailing out
> >     You could run, instead:
> >       /usr/bin/python3.11 /root/tools/docs/sphinx-build-wrapper htmldocs --sphinxdirs=. --conf=conf.py --theme= --css= --paper=  
> 
>                             /root
> ??

heh, you got me :-D

I ran it on an opensuse Leap container, created only to test builds.
I didn't care enough to create any user on such test containers, just
running everything there as root via lxc-attach, as, at the worse case
scenario, I can just re-run the script to re-create it.


Thanks,
Mauro

