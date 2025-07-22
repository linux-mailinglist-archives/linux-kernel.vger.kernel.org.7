Return-Path: <linux-kernel+bounces-740599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7364B0D644
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 11:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00DB4179B88
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jul 2025 09:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F532DECB1;
	Tue, 22 Jul 2025 09:48:22 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D137723C4F6
	for <linux-kernel@vger.kernel.org>; Tue, 22 Jul 2025 09:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753177702; cv=none; b=Jx9CSH6qbXp9mdLhKqmGEho9sBMNxFwVEsSSoNJh1gtCKmRbYhd240qTUHUqf8RfAVA/B2hVHHfHt8RZdbDyOZzr/yiu6Bu4TdP7u2jjztWkMueVxnAmFyCkK1m1q5bIuJOvehqkAYoCv9fV7+V/UQjkpewETrzijLJlfA0fzYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753177702; c=relaxed/simple;
	bh=dVcikr205Ak80qRUlwLt6JjiveksBUipnmRSJ08H5Go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JjA2WLZas9ro5I9pOm/tTh6qbMbztRK8wBcSNC+CHKYui5X6QQJP5h2TcjJCROBnwy3P2Mv5I9Nrsz1wXgiF8ok/Lxu/BS5jWBa/XUW2fg0ds4tZ1LJunrtABKapBG4MytftGxVUx+9oREP94UnUpjourlNMEshXTYXcgxuz/3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AF0A2152B;
	Tue, 22 Jul 2025 02:48:13 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 86D623F66E;
	Tue, 22 Jul 2025 02:48:17 -0700 (PDT)
Date: Tue, 22 Jul 2025 10:48:12 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Alexey Gladkov <legion@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	MengEn Sun <mengensun@tencent.com>,
	Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: Re: [PATCH RESEND v2 1/2] ucount: Fix atomic_long_inc_below()
 argument type
Message-ID: <aH9eXGb7QJ7fZl1t@J2N7QTR9R3>
References: <20250721174610.28361-1-ubizjak@gmail.com>
 <20250721154325.476b87e09aa5d778bcead478@linux-foundation.org>
 <CAFULd4bLXhnNzbitQ8mX8-L-3HhW1BAGN0hzCpbAu58cTcRS2w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFULd4bLXhnNzbitQ8mX8-L-3HhW1BAGN0hzCpbAu58cTcRS2w@mail.gmail.com>

On Tue, Jul 22, 2025 at 08:44:29AM +0200, Uros Bizjak wrote:
> On Tue, Jul 22, 2025 at 12:43 AM Andrew Morton
> <akpm@linux-foundation.org> wrote:
> >
> > On Mon, 21 Jul 2025 19:45:57 +0200 Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > > The type of u argument of atomic_long_inc_below() should be long
> > > to avoid unwanted truncation to int.
> > >
> > > Fixes: f9c82a4ea89c ("Increase size of ucounts to atomic_long_t")
> >
> > Please (always!) provide a description of the userspace-visible effects
> > of the bug.  That way I (and others) can decide whether the fix should
> > be backported.  And people will be able to determine whether this patch
> > may fix problems which they are observing.  Thanks.
> 
> The patch fixes the wrong argument type of an internal function to
> prevent unwanted argument truncation. It fixes an internal locking
> primitive; it should not have any direct effect on userspace.

AFAICT there's no problem in practice because atomic_long_inc_below() is
only used by inc_ucount(), and it looks like the value is constrained
between 0 and INT_MAX.

In inc_ucount() the limit value is taken from
user_namespace::ucount_max[], and AFAICT that's only written by sysctls,
to the table setup by setup_userns_sysctls(), where UCOUNT_ENTRY()
limits the value between 0 and INT_MAX.

This is certainly a cleanup, but there might be no functional issue in
practice as above.

Mark.

