Return-Path: <linux-kernel+bounces-780751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B8DB308F3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Aug 2025 00:14:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0C25AE7578
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Aug 2025 22:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F762EA740;
	Thu, 21 Aug 2025 22:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="h3P4Sl4U"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B4E7262F;
	Thu, 21 Aug 2025 22:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755814456; cv=none; b=UCiwR6QCnkGtZoO45s/zybau7so2cR2eSZmsWF8KnYda3J4d7CbNvnAHqPwX0WKrW2t21CFa/EO4RKGwv2OeQU6xnn/sVfkh9VTChto4JPRziZqSyJADit0gMzquHRqF+4gWrqvyEaYoBAfU5+82ORPrUTFqgodUuzkhZKRT50s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755814456; c=relaxed/simple;
	bh=S+Trtko+0wRKZhE6JSWDniCh6IfrnPbrR3w4hXx+v6w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UwcWzKXIDXjwy8hL/ez2Usebt+t7ay+shSfKv97RngyOk9BXa4YIgWCoKzwRYEkaaAMNqin2nTQpcQs1S+Y9DWFcvYXmVeXCWl3HjTltklR+avd1SvNmKBTWnuTVtUQkEOoYgtmybyXqxljs4+cgtE870RqlpjOcah9L7AZEjsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=h3P4Sl4U; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 53AC540AE2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755814454; bh=Mi8nBCWTguqPRir2kyPNhtQ3kf1zAQLHtOjWErpNaMw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=h3P4Sl4UvlEg5OiJabnH7iF1K4tXUnOeHA1vrIX3dGBFsZqf1IZwfkpzOogYNUmKY
	 fnVVMk3aKcgP1ve9imHvnbsifWaOMFiDinlE8J1Vcc5my1JhcOM8goZgp/Yhx5IQZE
	 M9qW+Ym0d0yiBX1n0yp3u4CydG8sTg/ejzF4kXhS6TXsiHtz7EM95WfmItvyCVclnL
	 phSKGKXAEY8AGOxTzVX+qslBCPM+g4xWSJfJh54lPEuOXR0VUq/y5K8pe1v8UXf6iM
	 5qjFU396HS3t181C9ibg8ONt/JkzUJqWYKzwz2V61+F+R8mOz0xd4LJPrtShD23ngO
	 3JulSAeCmVKwg==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::824])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 53AC540AE2;
	Thu, 21 Aug 2025 22:14:14 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: paulmck@kernel.org
Cc: Nikil Paul S <snikilpaul@gmail.com>, linux-doc@vger.kernel.org,
 skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v4] docs: rcu: Replace multiple dead OLS links in RTFP.txt
In-Reply-To: <972cf9c8-f8a6-4a5a-90a4-696f9a4e0f6d@paulmck-laptop>
References: <20250819180545.3561-2-snikilpaul@gmail.com>
 <87h5y07e6y.fsf@trenco.lwn.net>
 <972cf9c8-f8a6-4a5a-90a4-696f9a4e0f6d@paulmck-laptop>
Date: Thu, 21 Aug 2025 16:14:13 -0600
Message-ID: <877bywqq4q.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Paul E. McKenney" <paulmck@kernel.org> writes:

> On Thu, Aug 21, 2025 at 11:54:45AM -0600, Jonathan Corbet wrote:
>> Nikil Paul S <snikilpaul@gmail.com> writes:
>> 
>> > This patch updates several dead OLS links in RTFP.txt, replacing them
>> > with working copies hosted on kernel.org.
>> >
>> > Originally posted as part of a 2-patch series, this is now being sent
>> > as a standalone v4 patch to avoid confusion.
>> >
>> > Changes since v3:
>> >  - No change in content, only resubmitted as a single patch instead of
>> >    "2/2" from the earlier series.
>> >
>> > Signed-off-by: Nikil Paul S <snikilpaul@gmail.com>
>> > ---
>> >  Documentation/RCU/RTFP.txt | 6 +++---
>> >  1 file changed, 3 insertions(+), 3 deletions(-)
>> 
>> So this looks good to me, but it should really be run past the RCU folks
>> (and Paul in particular) as well; adding him to the CC.
>
> I queued this and checked it and it looks good.  By default, I would
> send this during the upcoming merge window.  But if you would rather
> take it:
>
> Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
>
> Either way, let me know!

It's all yours.

Thanks,

jon

