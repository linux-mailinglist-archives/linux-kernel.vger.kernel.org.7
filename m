Return-Path: <linux-kernel+bounces-861416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8FABF2AB2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 19:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9064A18A4EBE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Oct 2025 17:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6622BF01D;
	Mon, 20 Oct 2025 17:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TSvzKtQa"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511502874E9
	for <linux-kernel@vger.kernel.org>; Mon, 20 Oct 2025 17:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760980709; cv=none; b=Py7jm2YAP4xf5DJ8VOOn3ZIkgCTtstdqfYveFRGhL5VVo02ETO8jr2rJz9H6na3OpS9GiXJVSCATP+E3XAbEj9qJhgv6S3aJwbRWqNzaJtU4v82/DvJbfZsmBN4cM7Keu1S3wIPWepcdCvLcKDWsVI9Ajxcn2UDrwgVVv97VAIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760980709; c=relaxed/simple;
	bh=wsQkPHbm4wafoYfjAgBgysbBi3Sxpym3wJ/HixIbzzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XTnEr+pv6IQYWzexpNKfC4ztdFlMk12GKFx9KED2y4MnYHbzIOvjFJ2om0hsdponIv3hI3e20s0Yms8l1f9lVdGzP0VpVGOS/zoDJM2Ms7UukDJTsowdeONYfjz0QT+oQ7TaKdNJf1HqKvsLl432vhks+yOYjZDVPdbwsp0qeL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TSvzKtQa; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=9x6DNTf/yDEXM6/2wZfojGSgf54/pQuEMGJL2Ue3vsU=; b=TSvzKtQaOaW5f0AMu32EM6epyy
	eFzvIW+1CxG/oRnlCJlq+Nqq4hCDfAQU9i/FJ8IdcJj6V8oRZa7sbsBwQnkpX71XqDCqbUsWgPN+B
	nw7bIEL2I6Rr1R7WqoY9ymffh+MYH5FpCm3vQYJF22VwVmaV27gCmTABrJ16dxo4851JDbMB025dG
	qont0aide3/6jqsHeGF7wODPG7h4/t9HFHqqH4ukl3ifN0xNLA42NCSBe2JaMLJ+qapafR+RIiuzT
	FzZa+wZxKYo1/VdwCp7oN9QDtLkTZ/SO07wE8hF2PxKAfoUnjL5KD6vNe9QffZ/yV/Lk4abdcyHiN
	rxlusKGw==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vAtWc-0000000ESu4-0eXS;
	Mon, 20 Oct 2025 17:18:26 +0000
Message-ID: <c4848d9a-5007-414f-a95a-75f2a98bd24c@infradead.org>
Date: Mon, 20 Oct 2025 10:18:24 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] init/main.c: Wrap long kernel cmdline when printing to
 logs
To: Doug Anderson <dianders@chromium.org>
Cc: linux-kernel@vger.kernel.org, Andrew Chant <achant@google.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, Brian Gerst <brgerst@gmail.com>,
 Christian Brauner <brauner@kernel.org>, Francesco Valla
 <francesco@valla.it>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Guo Weikang <guoweikang.kernel@gmail.com>,
 Huacai Chen <chenhuacai@kernel.org>, Jan Hendrik Farr <kernel@jfarr.cc>,
 Jeff Xu <jeffxu@chromium.org>, Kees Cook <kees@kernel.org>,
 Masahiro Yamada <masahiroy@kernel.org>, =?UTF-8?Q?Michal_Koutn=C3=BD?=
 <mkoutny@suse.com>, Miguel Ojeda <ojeda@kernel.org>,
 "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Shakeel Butt <shakeel.butt@linux.dev>,
 Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 "Uladzislau Rezki (Sony)" <urezki@gmail.com>
References: <20251019100605.1.I095f1e2c6c27f9f4de0b4841f725f356c643a13f@changeid>
 <2d514d61-121d-44fc-aec7-637dd0920de8@infradead.org>
 <CAD=FV=VNyt1zG_8pS64wgV8VkZWiWJymnZ-XCfkrfaAhhFSKcA@mail.gmail.com>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CAD=FV=VNyt1zG_8pS64wgV8VkZWiWJymnZ-XCfkrfaAhhFSKcA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 10/20/25 8:33 AM, Doug Anderson wrote:
> Hi,
> 
> On Sun, Oct 19, 2025 at 3:23 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>> Hi,
>>
>> On 10/19/25 10:06 AM, Douglas Anderson wrote:
>>> The kernel cmdline length is allowed to be longer than what printk can
>>> handle. When this happens the cmdline that's printed to the kernel
>>> ring buffer at bootup is cutoff and some kernel cmdline options are
>>> "hidden" from the logs. This undercuts the usefulness of the log
>>> message.
>>>
>>> Add wrapping to the printout. Allow wrapping to be set lower by a
>>> Kconfig knob "CONFIG_CMDLINE_LOG_WRAP_IDEAL_LEN". By default, the
>>> wrapping is set to 1021 characters, which is measured to be the
>>> current maximum that pr_notice() can handle. Anyone whose cmdline
>>> isn't being cut off today should see no difference in log output.
>>>
>>> Wrapping is based on spaces, ignoring quotes. All lines are prefixed
>>> with "Kernel command line: " and lines that are not the last line have
>>> a " \" suffix added to them. The prefix and suffix count towards the
>>> line length for wrapping purposes. The ideal length will be exceeded
>>> if no appropriate place to wrap is found.
>>>
>>> Signed-off-by: Douglas Anderson <dianders@chromium.org>
>>> ---
>>>
>>>  init/Kconfig | 10 +++++++
>>>  init/main.c  | 83 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>>>  2 files changed, 92 insertions(+), 1 deletion(-)
>>
>> Is this (length) only a problem for the kernel boot command line?
>>
>> What does _printk() do with a very long string?
> 
> printk() will cut it off at ~1024 characters. The printing of the
> kernel command line is backed by pr_notice(), which is backed by
> printk(), which is where the limitation is. Yes, we could consider
> changing printk() to either remove the 1024 character limitation or
> have it do its own word wrapping, but I wouldn't expect people to be
> very receptive to that.
> 
> Thinking about increasing the maximum printk() size from 1024 to
> something bigger, I'd expect the response that people should, in the
> general case, not be printing such long strings to the kernel buffer.
> 
> Thinking about wrapping directly to printk(), I'd expect:
> * People wouldn't like the extra overhead added to every printk() call.
> * People wouldn't like the fact that there would be no obvious way to
> connect the continuation to the previous line (no way to know what the
> common prefix should be).
> * It wouldn't be obvious, in the general case, if wrapping should
> happen based on spaces.
> 
> 
> Printing the command line to the kernel log buffer is one of the very
> rare cases where:
> * There's a legitimate reason to print a (potentially) very long
> string to the kernel buffer.
> * We know that wrapping based on spaces is a reasonable thing to do.
> 
> If we want this to be something generic, we could certainly put this
> function into "lib/", sort of like how print_hex_dump() sits there.
> That function is actually a nice parallel to what we're doing here. It
> handles adding a prefix and handles intelligent wrapping that makes
> sense for the data presented.
> 
> My own preference would be to leave the code where it is and, once we
> have a second need for similar wrapping we can move the code into
> "lib/". That being said, if people think it belongs in "lib/" now I'd
> be happy to split this into two patches.

Yes, leaving it as you wrote it here is good for now IMO.

Regarding its max size (sort of ignoring the s390 MAX),
bootconfig max is 32 KB but usually not nearly that large
(Documentation/admin-guide/bootconfig.rst).

thanks.
-- 
~Randy


