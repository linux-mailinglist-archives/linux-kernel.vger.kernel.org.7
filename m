Return-Path: <linux-kernel+bounces-799947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0542BB43188
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBBB0580092
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 05:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7A522B8BD;
	Thu,  4 Sep 2025 05:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEPY5UgD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663ADC8CE;
	Thu,  4 Sep 2025 05:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756963087; cv=none; b=k6S1KcxdzIWPnG5NPB71tqKs9T3hZz5FCX3k+FNUYU5fOetkpFw+LC0YVzlWsBOrWAJ3ABNdM7Uoh9RTWExspDPigoSV26naJV4hkSGTBkl/EJ1Y9wDiqzAkeXHWHB0DKl6fk2BvbUfKLGTZKAovSy4Zj0RNtB0LusH8WmFVP/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756963087; c=relaxed/simple;
	bh=0aKem663rtBhcwUfKFeosww3r9HSWIadq/brKJlHnmg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o/Cd1ig22tf4i8v0DKnATIBsKCHM9/GycHD+oR/a+ipxx4H+HTeJebRU/i568IMdAe6moYURrQJg2cKLOt1HK8Lv68Jh//AczuYDYVrreE55y932HQFwWpptIC6UUXcD7JaASdiaaPeYdL7GNBDQagPgaNR9sJW9URejojNsEsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bEPY5UgD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87235C4CEF0;
	Thu,  4 Sep 2025 05:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756963086;
	bh=0aKem663rtBhcwUfKFeosww3r9HSWIadq/brKJlHnmg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bEPY5UgDP3Gs0Ato7IWtAJ7/UYexLY6S3hxOcoCvmYOeUBjZ1Y5JT7HPqJ/yqyK1U
	 lgSC26n6aWOkb0QFYmX4yglMpL3LJRilL81/ns/mAU3EYBUkh4FcBWpBKIvUN1+L20
	 ntPDmMDafiopkCIdahu0qxUrFLOtgo23KpUz5TRQFq0UCVgR4tDwg4RE8fRG/q9WkA
	 cJvQCn2hitl9b/QIQbQdDVuyq4KHfOeztm2V9hbJMPohldyp6uiv2wlgGlGuyTfX9c
	 teqxsLyTiJBvh7rBKAbLfu8V+ATW3qWI8rVww1JQ6I0Pk7QT1BRRl8nhSLoxtaNEzK
	 JQ9doD7MSuoYQ==
Date: Thu, 4 Sep 2025 07:18:01 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Linux Doc Mailing List
 <linux-doc@vger.kernel.org>, =?UTF-8?B?QmrDtnJu?= Roy Baron
 <bjorn3_gh@protonmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, Alice Ryhl
 <aliceryhl@google.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo
 <gary@garyguo.net>, Trevor Gross <tmgross@umich.edu>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 3/3] tools/docs: sphinx-* break documentation bulds
 on openSUSE
Message-ID: <20250904071700.2e680548@foz.lan>
In-Reply-To: <aLh9HVd8_S9LvSgv@casper.infradead.org>
References: <cover.1756916565.git.mchehab+huawei@kernel.org>
	<29135db8c8094006f256e1fa0b64663c735737e7.1756916565.git.mchehab+huawei@kernel.org>
	<aLh9HVd8_S9LvSgv@casper.infradead.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Wed, 3 Sep 2025 18:38:37 +0100
Matthew Wilcox <willy@infradead.org> escreveu:

> On Wed, Sep 03, 2025 at 06:24:16PM +0200, Mauro Carvalho Chehab wrote:
> > Before this patch, building htmldocs on opensuseLEAP works
> > fine:
> > 
> >     # make htmldocs
> >     Available Python versions:
> >       /usr/bin/python3.11
> > 
> >     Python 3.6.15 not supported. Changing to /usr/bin/python3.11
> >     Python 3.6.15 not supported. Changing to /usr/bin/python3.11  
> 
> [...]
> 
> > 1. after this change, sphinx-pre-install needs to be called
> >    by hand:
> > 
> >     $ /usr/bin/python3.11 tools/docs/sphinx-pre-install
> >     Detected OS: openSUSE Leap 15.6.
> >     Sphinx version: 7.2.6  
> 
> I thought the preferred option was to be able to specify:
> 
> PYTHON=/usr/bin/python3.11 make htmldocs
> 
> or even make htmldocs PYTHON=/usr/bin/python3.11
> 
> like being able to specify CC, LD or AWK.

This could be an option, but it is still half-broken - or at least
implementing it is not trivial - as spinx-pre-install is the
script which recommends what packages are needed on openSUSE Leap.
and on RHEL8 (and based) distros.

Internally, it needs to run sphinx-build --version to check if
Sphinx version is compatible with the build. So, adding support
for a PYTHON env is still half-broken after this series.

Thanks,
Mauro

