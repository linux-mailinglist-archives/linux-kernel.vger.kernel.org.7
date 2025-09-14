Return-Path: <linux-kernel+bounces-815479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C96B56708
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 08:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA53F189EF23
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Sep 2025 06:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35EA279324;
	Sun, 14 Sep 2025 06:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oRq349JN"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4C8272E6D;
	Sun, 14 Sep 2025 06:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757830211; cv=none; b=YvKpjQx2Z2dvfrDrdA32oABw1TtTewczBC1C3dAKroB6GDz3DNmQSk+uGY4KULaxHzTpBNEwSgAXs0/urBMxTa4DpjG547MCtPplcKKY3JuelvMg9BxPphIu2nklcrMzXO9t72MavvpESW9BACRMPK0nnPPKrTvpz0ZcdB7SzRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757830211; c=relaxed/simple;
	bh=en4EPSHAY+78dWvWrYG0CPGUeolpy9yjhYRTzJqB9+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jK2EI0+Nk1Or505xb6Opbidqqs4ZzC8q5K12wJXWP0zIsVbJDNT5OygIc9BZVdhisv3Bl+i2HEJHlUQNlwgYTjKCPqovfZWgdYxdJ7QVMbSwws39J8CBcWOBeYTbatCPgDIOb7MMyfW4/Egwkyhwd1tdWRrV2WtWfeQXaPkwP0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oRq349JN; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=58RoTa3TrNjhhtCEti8RBsnnl0PSeZGOGMgdc95agK0=; b=oRq349JN2OQhmvh5yJO7HLpQ5Q
	L9rDppFV0ydeH2JRDgv49VxLwXpfTguxkAlpvWHxvfHc/OR05oSfsF272uYAse/Oz9pka3c8BN6dv
	0JgBZGjR5BPvRknfzqEaRgST9qb1+yVvRsK+AL5fIktzFvMcpvr/KgvHzPdblEvflwtJX5YGC4HfP
	FbEDLrZl6Tghh5w+Hctc3WFsHdOi0Yz+uTTralJwGWpKcdLCASXiMoA448hZXCjnKMwJaHtsV1QWn
	O8IlUh0oNpWJd6QMdF+3arCD/Cd7mO4UuX1tPsWCjwW9zeCUx5WPvHO8bEuQSbtkp+K9iP+Hj2Ikl
	Tse0jRtw==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uxfw4-00000000BV4-2gIW;
	Sun, 14 Sep 2025 06:10:04 +0000
Message-ID: <5fcf5f4a-1bbf-458e-8aab-8c66d326fd17@infradead.org>
Date: Sat, 13 Sep 2025 23:10:04 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: process: Do not hardcode kernel major
 version number
To: Bagas Sanjaya <bagasdotme@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Documentation <linux-doc@vger.kernel.org>,
 Linux Kernel Workflows <workflows@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Dante Strock <dantestrock@hotmail.com>
References: <20250913015147.9544-1-bagasdotme@gmail.com>
 <61249b3d-3996-4d9f-814b-3794aa42c40b@infradead.org>
 <aaf3dffd-cc88-46e2-a65b-a1ff4fcc6eec@gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <aaf3dffd-cc88-46e2-a65b-a1ff4fcc6eec@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 9/13/25 8:18 PM, Bagas Sanjaya wrote:
> On 9/14/25 04:40, Randy Dunlap wrote:
>> On 9/12/25 6:51 PM, Bagas Sanjaya wrote:  
>>> -The kernel developers use a loosely time-based release process, with a new
>>> -major kernel release happening every two or three months.  The recent
>>> -release history looks like this:
>>> +Linux kernel uses a loosely time-based, rolling release development model.
>>
>>     The Linux kernel
>>
>>> +A new major kernel release (a.x) [1]_ happens every two or three monts, which
>>
>> I'm much more used to x.y                                           months,
>>
> 
> The reason I use a.x is because a is indeed supermajor (only incremented on occasional cases i.e. in Linux kernel when x gets large enough), and
> x is already used as second placeholder component.

Do we use the word "supermajor" anywhere?
$ grep ...
Nope.

How about we call it MAJOR (like the top-level Makefile does; well, it calls it
both VERSION and MAJOR[1]), so use
	m.x

I would say "or v.x" but that could be confusing when someone references a
v6.17-rc5 kernel.


[1]: from Makefile:VERSION = 6
PATCHLEVEL = 17
SUBLEVEL = 0
and
	echo \#define LINUX_VERSION_MAJOR $(VERSION);                    \
	echo \#define LINUX_VERSION_PATCHLEVEL $(PATCHLEVEL);            \
	echo \#define LINUX_VERSION_SUBLEVEL $(SUBLEVEL)

G'day.
-- 
~Randy


