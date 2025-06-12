Return-Path: <linux-kernel+bounces-683956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4A2AD7446
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 16:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9466C1886F70
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jun 2025 14:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD457248888;
	Thu, 12 Jun 2025 14:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="kkYWnBX2"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617FD248166
	for <linux-kernel@vger.kernel.org>; Thu, 12 Jun 2025 14:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749739051; cv=none; b=B6ovMGke72yIKlYrGhcuncdA/QTyQ2/xeffzlS7qLjBaQtWwyskAlICWR0uFK0TbtRDVdI40b4PMq35Ki5wZ0Xa7K4EFU6bgWZ7Nn9e7IppEMyGStyr+PgpZ2SrT8rp0g5EbXf2D7pqir0Duo1r7lFZQbR5ssH7noh5iowZZMrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749739051; c=relaxed/simple;
	bh=3ON5Gv3OWdxiRwybeyLaTwXdsFOiWoMBl3YdA40kGwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dqi4CAjcroS1p3YGbyzrDnT6eXhzbF29xsb8tkivrQfuykn16SJpbApCJkYXU+ApJnChJoTrZhkPP0vd5aQOPNAAIdoUyQlHzvoTODkTOfayssOxfFxfMiLMAzGRaDUabs6VHsZIDPW7DAmLA4jEq0JWua8aKhyiws2MBYiJ7+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=kkYWnBX2; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi [91.158.153.178])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 74FE87E4;
	Thu, 12 Jun 2025 16:37:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1749739032;
	bh=3ON5Gv3OWdxiRwybeyLaTwXdsFOiWoMBl3YdA40kGwA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kkYWnBX2ITn3E2WKghndy5Qd38beY9eWSEg0ks8FBlFROl/mRxCGJP+VtirWYarou
	 db9b54L1Uz3PEpCFxUMZocOLXno3eRuLFC4rDiGDQwHXxi56aqnF3BI275F7RXrtzm
	 WssiUe0GobKjq2WpxScToXHlyPIC0xYP8q4+mOuA=
Message-ID: <c93bf50b-0300-4bd9-8c59-bc2b876801f8@ideasonboard.com>
Date: Thu, 12 Jun 2025 17:37:17 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm: omapdrm: reduce clang stack usage
To: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>
Cc: Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 linux <linux@treblig.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Dave Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Nathan Chancellor <nathan@kernel.org>
References: <20250610092737.2641862-1-arnd@kernel.org>
 <f4e42ca9-d6f2-401b-9a53-d3b41915c6a0@ideasonboard.com>
 <4a81fc44-7c93-49d1-891b-dae11cd5e74a@app.fastmail.com>
Content-Language: en-US
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Autocrypt: addr=tomi.valkeinen@ideasonboard.com; keydata=
 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
In-Reply-To: <4a81fc44-7c93-49d1-891b-dae11cd5e74a@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 12/06/2025 15:40, Arnd Bergmann wrote:
> On Thu, Jun 12, 2025, at 09:58, Tomi Valkeinen wrote:
>> On 10/06/2025 12:27, Arnd Bergmann wrote:
>>>  
>>> -static void dispc_restore_context(struct dispc_device *dispc)
>>> +static noinline_for_stack void dispc_restore_context(struct dispc_device *dispc)
>>>  {
>>>  	int i, j;
>>>  
>>
>> While I don't think this causes any harm, but... What's going on here?
>> If I compile with gcc (x86 or arm), I see stack usage in few hundreds of
>> bytes. If I compile with LLVM=1, the stack usage jumps to over a thousand.
>>
>> Is clang just broken? I don't see anything special with
>> dispc_restore_context() or dispc_runtime_resume(), so is this same thing
>> happening all around the kernel, and we need to sprinkle noinlines
>> everywhere?
>>
>> Or do we get some extra debugging feature enabled only on clang with
>> allmodconfig, and that is eating the stack?
> 
> There is no general answer here, but a combination of multiple
> effects going on at the same time throughout the kernel, which lead
> to clang observing excessive stack usage in some files when gcc
> does not:
> 
> - both compilers have a number of corner cases where they run off
>   and do something crazy for unusual input (usually crypto code),
>   but since gcc has more users, most files that trigger only gcc
>   already have workarounds in place, while the ones that trigger
>   with clang are still missing them
> 
> - The inlining algorithm works the opposite way on clang vs gcc,
>   while gcc always starts inlining leaf functions into their callers
>   and does this recursively, clang starts with global functions
>   and inlines its direct callees first. If you have deeply nested
>   static functions that could all be inlined, both stop at some
>   point, but the resulting object code looks completely different,
>   and the stack usage is a symptom of this. I've added 'noinline'
>   for some of the cases like this where I know both result in
>   the same (harmless) stack usage through the call chain, but
>   only clang warns about it.
> 
> - clang has previously had bugs where it tracks the lifetime of
>   stack variables incorrectly, so multiple variables that
>   should share the same stack slot won't. Some of these are
>   fixed now, others are a result of the different inlining, and
>   some others are likely still bugs we should fix in clang
> 
> - CONFIG_KMSAN disables some optimizations that are required
>   for reducing stack usage, and at the moment this is only
>   implemented in clang but not gcc.
> 
> - CONFIG_KASAN has some similar issues as KMSAN but is not
>   quite as bad here.
> 
> - CONFIG_KASAN_STACK tends to use more stack with clang than gcc
>   because of implementation choices around how hard it should
>   try to detect array overflows. This could be changed by having
>   clang make similar decisions to gcc here, but for now we just
>   require using CONFIG_EXPERT=y to enable KASAN_STACK on clang.
> 
> I have managed to produce a testcase for this file that shows
> how clang produces huge stack usage when gcc does not,
> in this case it seems to be triggered by -fsanitize=kernel-address
> 
> https://godbolt.org/z/TT88zPYf6

Interesting! And clang does fine if I change the DISPC_OVL_BASE() to

static u16 DISPC_OVL_BASE(enum omap_plane_id plane)
{
    static const u16 bases[] = {0x0080, 0x00BC, 0x014C, 0x0300, 0x0500};
    return bases[plane];
}

In any case, I'll apply this with a small comment.

 Tomi


