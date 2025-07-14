Return-Path: <linux-kernel+bounces-730070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D5EB03FF2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 15:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F11351AA0051
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 13:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283A324E4AD;
	Mon, 14 Jul 2025 13:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uE7IntSU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8680742065;
	Mon, 14 Jul 2025 13:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752499623; cv=none; b=LNJ65v2ZLe/dv7cX+3wLlH+AZ2Tk+RrJ1vGp+l9xwSBBN4gw3l/kSFWxxMtZvreCbujmVmt4lgC+QYgQTFb3GnMcK6kcM3OCuM5jJXUtI3fIGDJ7smj+o2N4xFPbbRGBBwcMzy79l5nD4i6jzuPUMBNlZjX7mUZsssDO7goAD/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752499623; c=relaxed/simple;
	bh=cYH/BLLVLcAR34XfR81w2+tpsrtS7RH74IvpAZtdRss=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oU8B3FS0C+8FXrfD3NIqxqIwJZC069yR6hmVNzcgl56VIptCd9QLreIM8zlFm376xzaSpqxUsWkzO7TjciFRkKyqcul2MkhSvxC4Ck2ScPs3I8jek1D0u2AEpJ7olsg5jx/ShPPPR2dH8GabLEDzT3iU9oU9XndI/rhuns7mcgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uE7IntSU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 326A8C4CEED;
	Mon, 14 Jul 2025 13:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752499623;
	bh=cYH/BLLVLcAR34XfR81w2+tpsrtS7RH74IvpAZtdRss=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uE7IntSUpDg0ITssN1Wakd+USvkgiqhnJ9qbsOW6e2pA2Y9b5RBvWFpG6a8hh6mQd
	 FuMfSZOt7WpK+5+zznmYh4sEjuOAdc6O206zMmESL7/eDT/CkF7z337MZiYDfjKd1M
	 0nFbJELM3fSEop/2ChIypwTRIw9v+aNWq/DlnJFMmfUfn8583scJ0SG7orEw2lyPLY
	 n7TlwhQiG4OT3Pwc8ZVAqpuf1hLbQoFLpXB4pKNggNEB+j1acyYlu8hUkbrvSI4eYy
	 LJDYzjRGw32B/kDKcS95MwOfqhEeEyEijYKCcZCP+ch2diPouHZdJTOrl5n7pSxft0
	 vcygEnkBPv2hQ==
Message-ID: <9f6d7e29-71d2-4f1b-b672-46acc8de8b6f@kernel.org>
Date: Mon, 14 Jul 2025 15:26:58 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] rust: device: implement Device::as_bound()
To: Greg KH <gregkh@linuxfoundation.org>
Cc: rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
 boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
 tmgross@umich.edu, daniel.almeida@collabora.com, m.wilczynski@samsung.com,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250713182737.64448-1-dakr@kernel.org>
 <20250713182737.64448-2-dakr@kernel.org>
 <2025071411-casually-cold-6aff@gregkh> <DBBONAMQ0C3X.825M3H3R2IUY@kernel.org>
 <2025071405-scorecard-cling-2cf5@gregkh>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <2025071405-scorecard-cling-2cf5@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/14/25 3:24 PM, Greg KH wrote:
> On Mon, Jul 14, 2025 at 11:49:44AM +0200, Danilo Krummrich wrote:
>> On Mon Jul 14, 2025 at 7:30 AM CEST, Greg KH wrote:
>>> On Sun, Jul 13, 2025 at 08:26:54PM +0200, Danilo Krummrich wrote:
>>>> Provide an unsafe functions for abstractions to convert a regular
>>>> &Device to a &Device<Bound>.
>>>>
>>>> This is useful for registrations that provide certain guarantees for the
>>>> scope of their callbacks, such as IRQs or certain class device
>>>> registrations (e.g. PWM, miscdevice).
>>>
>>> Do we have an example where this can be used today in the tree, or is
>>> this only for new stuff going forward that would use it?
>>
>> There's miscdevice in tree, but to be fair, miscdevice doesn't need it without
>> my patch series [1] adding driver support for the existing miscdevice
>> abstractions; the patch in [2] out of this series would use it within
>> args_from_registration().
>>
>> The PWM abstractions [3] need it in bound_parent_device(). The use-case is the
>> same as everywhere else, PWM chips never out-live driver unbind, hence they can
>> provide the corresponding bus device as &Device<Bound>.
>>
>> The same is true for IRQ registrations [4]. free_irq() is guaranteed to be
>> called before driver unbind, hence we can provide a &Device<Bound> in the IRQ
>> callbacks.
>>
>> Ultimately, we want to provide this "cookie" in any driver scope that can be
>> proven to be lifetime wise limited to device / driver unbind, so there'll be
>> much more users.
> 
> Ok, so we should probably merge it now for 6.17-rc1, no objection from
> me!

Yup, gonna pick it up soon (with the casts fixed up as noted in a previous
reply). :)

