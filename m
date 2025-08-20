Return-Path: <linux-kernel+bounces-777928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C3B0B2DF44
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 16:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBD971C859B9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Aug 2025 14:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7DE26FDBB;
	Wed, 20 Aug 2025 14:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Hr+n9n4T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391E825F79A
	for <linux-kernel@vger.kernel.org>; Wed, 20 Aug 2025 14:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755699828; cv=none; b=kKvRrhq0hpyz4f97qf5D7p4gPpt0mN3NE7BuXMuLm8EXFfrtljcft5JlYnwllSa0tD7Azg9LiVRx4QsKFVBf5gsEY4GiTYVvlo7tP5CE6zAxJqebxsYvZERFBhz9RY4/uMmXkycpHXdF9c2W6R9geIB1GEwEOAlNajJZtdKBmWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755699828; c=relaxed/simple;
	bh=ORq1Z094UCaI2GoeAocstCuXlQKM6HBhzRoNfhakUJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJ7FrLV0vksnde+X9nuAooaA1Zg7GvQqQBS0aTcEM3MAOydgy0mgCEXPuKhBmnzola8WRJeYb8jArzP6VzSrFcNAt7Ti3vweM90rmacmBIde11Noc6Hxrp7r3GpJKIMjTaX+JG0htH+xGB8OE/vTwUuxtYmz9Q/NoxBmSfCKtAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Hr+n9n4T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32BDDC4CEEB;
	Wed, 20 Aug 2025 14:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755699827;
	bh=ORq1Z094UCaI2GoeAocstCuXlQKM6HBhzRoNfhakUJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hr+n9n4T1vYdvd1wN1EoL1flM8OkwQstOBUD26tqXTZcYfKHDG0bCbyJVTDewBdHu
	 tAfkqzU5VmXtmDLRlziAFkcTe8qeJa/6jdlwVCmeQo9vssK71cvuFEYAYz8tIopWZS
	 rj7Xajb9hnadsxumxKdUOgbwArYw/Zxgi1GDqUjM=
Date: Wed, 20 Aug 2025 16:23:44 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: zhoumin <teczm@foxmail.com>
Cc: akpm@linux-foundation.org, dakr@kernel.org,
	linux-kernel@vger.kernel.org, rafael@kernel.org
Subject: Re: [RFC PATCH] kobject: fix uevent helper execution order issues
Message-ID: <2025082029-december-backroom-ef5a@gregkh>
References: <2025081956-untie-elude-7880@gregkh>
 <tencent_34F69492AC1630B90634E94C886712651306@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <tencent_34F69492AC1630B90634E94C886712651306@qq.com>

On Wed, Aug 20, 2025 at 10:04:26PM +0800, zhoumin wrote:
> Hi Greg
> 
> Thanks for your patience.
> 
> > Why are you not looking at the SEQNUM value?  That should be what orders
> > the events, right?  Otherwise how would any of this work?  :)
> 
> > Also, what usermode helper program are you using that requires a binary?
> > What is wrong with udev?
> 
> Due to historical reasons, our system does not use udev and relies entirely
> on custom shell scripts to handle kobject events.

Given that udev is older than any other "historical reason" that feels
very odd.  udev was created at the same exact time the uevent api was
added, it's over 20 years old now.

> The helper_lock and UMH_WAIT_EXEC in the kernel ensure that the uevent
> helper serializes the execution of our shell scripts. That is why I
> proposed the RFC patch to change UMH_NO_WAIT to UMH_WAIT_EXEC—for our use
> case, this change provides clear benefits without downsides, aslo it avoids
> blocking like UMH_WAIT_PROC while improving script execution order.

But it does not guarantee what you are saying the real problem is here,
out-of-order events.

> Regarding SEQNUM: using it would require parsing and tracking global
> sequence numbers manually. In contrast, using a file lock would allow me to
> focus only on serializing events for the same kobject, since events from
> different objects don’t require synchronization.

SEQNUM is there for this very reason, to ignore it is wrong, and broken.
This is how the uevent system was designed to work.  Please fix your
userspace implementation, do not attempt to paper over the race in the
kernel, because as you say, it's not going to really solve it, only
reduce it.

And you will find that events from different objects WILL require
synchronization in many places, to ignore that is just going to cause
you even more problems.

> If you believe this patch isn’t suitable for mainline, I’m open to
> implementing a SEQNUM-based approach for better event ordering instead.

Please do so.  Even better yet, use udev!  Or mdev.  or one of the other
very old uevent handlers out there, you have plenty to choose from.

thanks,

greg k-h

