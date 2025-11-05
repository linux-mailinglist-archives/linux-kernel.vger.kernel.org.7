Return-Path: <linux-kernel+bounces-886529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EF835C35D9C
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 14:32:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 016E54FAC74
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 13:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D8541DF273;
	Wed,  5 Nov 2025 13:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openatom-club.20200927.dkim.feishu.cn header.i=@openatom-club.20200927.dkim.feishu.cn header.b="JqT67dAC"
Received: from va-2-38.ptr.blmpb.com (va-2-38.ptr.blmpb.com [209.127.231.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DD7631327B
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 13:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762349376; cv=none; b=gtlM/pzStnAmTOjvYsXkry8R5o9AWF7y3yh/yz+aonphMYc6/YrQSIEDo4wuxQml4Sw0FrbLwXdNKj4kW30OO5XiBYDRE8LALC45vw61hgA7bgmjFY1s/6D5Od/Xr0fATWcQtaH6fHCCirwx6KwyPfLb7Z43yGN6gYWVSL1Xpzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762349376; c=relaxed/simple;
	bh=OiMZQ3jxA4zt4lcULg3hbwDPjkAVEqHfaOZsr+AATKg=;
	h=Cc:Message-Id:Content-Type:In-Reply-To:References:Subject:Date:
	 Mime-Version:To:From; b=hpJhFj7QMvH6ykcuf4WGW8vf6j1f5uh3V6no9NN/szMNUAPgMCAXsFtNnms2Ze/lbinsln7TWZl6SHE57pl7o1njyLaMBYhWqUKBYALAmLkGAWn4g/0nWL4awvAaKdw2kSHgUartpM6FyO9Y+tP+twlcABH4mL/g/N+PkAQRJhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openatom.club; spf=pass smtp.mailfrom=openatom.club; dkim=pass (2048-bit key) header.d=openatom-club.20200927.dkim.feishu.cn header.i=@openatom-club.20200927.dkim.feishu.cn header.b=JqT67dAC; arc=none smtp.client-ip=209.127.231.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openatom.club
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openatom.club
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=openatom-club.20200927.dkim.feishu.cn; t=1762349323;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=gq8PdA1jgim3bfb/guc9McLZThN4z7DOnpEn274tOao=;
 b=JqT67dACcZRF3plpzpELmnHkx1GH70oYZ9YaF5rC+guxKLKhOc/5I7PVnCPFHqrVsKPzuK
 pKx5YThEpteeTiogXltwzaPDD8RlHZWQSxvH8x9FS/pza68PfSlcFKzOj5t1UOmgI76e89
 bZnEo8DxQxkURazspQNT+52pjtvS7wY3pc9Dg7+qB7GJiy86SXkv9VIzq9VibN3DK0b6Oy
 ZIKrKDlQl3+T9kmcu2ZNXm4O+37KiKvL7mr06/s/xxJxcCX9D7L5nQYn90OsB/a+celFl2
 6cNxHlqRtX4gRUGhvhamcPIUhxv4AM7dK+rkP0zD1Euju71mXPIMhghRq/higw==
Received: from [198.18.0.1] ([114.249.49.233]) by smtp.feishu.cn with ESMTPS; Wed, 05 Nov 2025 21:28:40 +0800
Cc: <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, 
	"Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>, 
	=?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	"Benno Lossin" <lossin@kernel.org>, 
	"Andreas Hindborg" <a.hindborg@kernel.org>, 
	"Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>, 
	"Steven Rostedt (Google)" <rostedt@goodmis.org>, 
	"open list:RUST" <rust-for-linux@vger.kernel.org>, 
	"open list" <linux-kernel@vger.kernel.org>, 
	<hust-os-kernel-patches@googlegroups.com>
Message-Id: <b3f50745-5351-4e69-b3e2-ede99511e8dc@openatom.club>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+2690b5109+8fadb3+vger.kernel.org+chenmiao@openatom.club>
In-Reply-To: <aQoIliAbrn0Re7E3@google.com>
User-Agent: Mozilla Thunderbird
References: <df3a68334760b2b254219a69426982bf858dee39.1762221537.git.chenmiao@openatom.club> <aQoIliAbrn0Re7E3@google.com>
X-Original-From: Chen Miao <chenmiao@openatom.club>
Subject: Re: [PATCH] rust: kernel: Support more jump_label api
Date: Wed, 5 Nov 2025 21:28:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Chen Miao" <chenmiao@openatom.club>

On 11/4/2025 10:07 PM, Alice Ryhl wrote:
> On Tue, Nov 04, 2025 at 02:04:17AM +0000, chenmiao wrote:
>> The initial implementation of arch_static_branch was achieved by accessing
>> the offset from the original type. However, this approach extended the
>> path and introduced redundant calculations when dealing with types like
>> `static_key_true/false`, as shown below:
>>
>> ```
>> static_brach_unlikely(tp, tracepoint, key)
>>    => tracepoint->key->key
>>    => &tracepoint->key(static_key_false) == &tracepoint->key.key(static_key)
>>    => off: tracepoint->key - tracepoint
>> ```
>>
>> In practice, the implementation of `arch_static_branch` overlooked many
>> detailed descriptions. To improve clarity, additional comments have been
>> added to the original logic. The approach has been modified to directly
>> locate the corresponding `static_key` instead of using offsets, thereby
>> reducing  computational overhead.
>>
>> If finding the offset from the primitive type is necessary for this
>> implementation, I will abandon this change.
>>
>> Additionally, support for the `static_branch_enable/disable` APIs has been
>> introduced.
>>
>> Signed-off-by: chenmiao <chenmiao@openatom.club>
>> +    ($basety:ty, $branch:expr, $key:path, $keytyp:ty, $field:ident) => {{
>>           let _key: *const $keytyp = ::core::ptr::addr_of!($key);
>> -        let _key: *const $crate::bindings::static_key_false = ::core::ptr::addr_of!((*_key).$field);
>> +        let _key: *const $basety = ::core::ptr::addr_of!((*_key).$field);
>>           let _key: *const $crate::bindings::static_key = _key.cast();
>>   
>>           #[cfg(not(CONFIG_JUMP_LABEL))]
>> @@ -30,7 +71,88 @@ macro_rules! static_branch_unlikely {
>>           }
>>   
>>           #[cfg(CONFIG_JUMP_LABEL)]
>> -        $crate::jump_label::arch_static_branch! { $key, $keytyp, $field, false }
>> +        {
>> +            $crate::jump_label::arch_static_branch! { _key, $branch }
>> +        }
> So ... this is changing from $key to _key. That's replacing the global
> variable with a local variable holding a pointer to the global variable.
> However, the arch_static_branch! macro uses the `sym` operand which
> requires you to pass it the global directly.
>
> Did you try this code? I don't believe it will work.
>
> Alice

I'm very sorry for making a fatal mistake. My misunderstanding of sym led to 
this issue, so I shouldn't make any changes to that part. However, regarding 
the other modifications, I believe it is necessary to support the direct 
passing of structures similar to `static_key_false`, just as in C language.

Chen Miao

