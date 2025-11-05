Return-Path: <linux-kernel+bounces-886611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BEC2C3611B
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 15:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1467418C827A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 14:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34B2325480;
	Wed,  5 Nov 2025 14:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openatom-club.20200927.dkim.feishu.cn header.i=@openatom-club.20200927.dkim.feishu.cn header.b="hVItn9BC"
Received: from sg-1-35.ptr.blmpb.com (sg-1-35.ptr.blmpb.com [118.26.132.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75DFB21D59C
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 14:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762353061; cv=none; b=CQJAc8YGH56IqrkgjDU1+uJpOpKfU0gJkQpI9NvIjMJa31RLRX59Z2RypDw9zWAo58DI4hCUqUlh3iJ5oBsSLjt9ZyQHVQAl8/dWUt1FGTw4x2vMTg5brHR3FdSlFUsmjq6gt+a7GI+8MQ4Z02+vL1nia7UQqROtYPY8rhd0818=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762353061; c=relaxed/simple;
	bh=+yn8kCg0DcocwldbWqFx7eecPWeUurwZTTG8G8mO0Eo=;
	h=Mime-Version:References:Content-Type:Subject:Message-Id:Cc:
	 In-Reply-To:To:From:Date; b=V51Mm6yNWX/tBRVHKYx0xHepVmd2s7nXbRHW0c3lp3M2D2m6iTtWcAXqLTLbTn300v/etwH1w2DqaVJJOoXgXwCxDL9iDB3rUVxvURR/QM0MLpjpWNH4LE70Kwzzf/QyaHDy5rZxN7PCxo3dRD3MdfF+BgNvnaxDW18uPhpvhc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openatom.club; spf=pass smtp.mailfrom=openatom.club; dkim=pass (2048-bit key) header.d=openatom-club.20200927.dkim.feishu.cn header.i=@openatom-club.20200927.dkim.feishu.cn header.b=hVItn9BC; arc=none smtp.client-ip=118.26.132.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openatom.club
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openatom.club
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=openatom-club.20200927.dkim.feishu.cn; t=1762352208;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=QPF4dN9RFRcdX3bhAtclDyHuCbEVFOt7Ivic9yuyuzg=;
 b=hVItn9BCqYjzguDumS3Z3E0yFh7ixfKp3B0OtcRLUSDYz1ptmi4yUK7P+MQY2r+IrtlbKo
 lJySlzHB6YBH+ZoyMj+hMoaNfyJWvJditUGQ9jm0cR0FyVLHanwwNYv5AqEHw8pIscnPVi
 3HyxfoMyvKc/SxhCIATB7v/Ak7cqk5re1x46H5kRrA62yXMKVACwq1puUQCrYiN4PQM/Oj
 LBWgOz5O9Lb7hCRTjMNGyqU/m3PRIpj29VYHXrgm8gk8KjamZqf5RvvGY22lcm5FH9pW2d
 pdc3OAUY+OMBSsRiwcW+9ZKT98w6DxP0HgMb6iR8mVHE7++Hsbl4HtaoIn/8jQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <df3a68334760b2b254219a69426982bf858dee39.1762221537.git.chenmiao@openatom.club> <aQoIliAbrn0Re7E3@google.com> <b3f50745-5351-4e69-b3e2-ede99511e8dc@openatom.club> <aQtTRUMUaaUmTAWZ@google.com> <90bfcb3e-dee1-4f78-a1b2-02ce99db4997@openatom.club> <aQtbeWpRD7ip8-2A@google.com>
X-Original-From: Chen Miao <chenmiao@openatom.club>
Content-Type: text/plain; charset=UTF-8
X-Lms-Return-Path: <lba+2690b5c4e+db2974+vger.kernel.org+chenmiao@openatom.club>
Subject: Re: [PATCH] rust: kernel: Support more jump_label api
Message-Id: <9c01f57e-35b0-494f-9e8e-c8d44e4a7596@openatom.club>
Received: from [198.18.0.1] ([114.249.49.233]) by smtp.feishu.cn with ESMTPS; Wed, 05 Nov 2025 22:16:45 +0800
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
Content-Transfer-Encoding: quoted-printable
User-Agent: Mozilla Thunderbird
In-Reply-To: <aQtbeWpRD7ip8-2A@google.com>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Chen Miao" <chenmiao@openatom.club>
Date: Wed, 5 Nov 2025 22:16:44 +0800

On 11/5/2025 10:13 PM, Alice Ryhl wrote:
> On Wed, Nov 05, 2025 at 09:55:27PM +0800, Chen Miao wrote:
>> On 11/5/2025 9:38 PM, Alice Ryhl wrote:
>>> On Wed, Nov 05, 2025 at 09:28:39PM +0800, Chen Miao wrote:
>>>> On 11/4/2025 10:07 PM, Alice Ryhl wrote:
>>>>> On Tue, Nov 04, 2025 at 02:04:17AM +0000, chenmiao wrote:
>>>>>> The initial implementation of arch_static_branch was achieved by acc=
essing
>>>>>> the offset from the original type. However, this approach extended t=
he
>>>>>> path and introduced redundant calculations when dealing with types l=
ike
>>>>>> `static_key_true/false`, as shown below:
>>>>>>
>>>>>> ```
>>>>>> static_brach_unlikely(tp, tracepoint, key)
>>>>>>      =3D> tracepoint->key->key
>>>>>>      =3D> &tracepoint->key(static_key_false) =3D=3D &tracepoint->key=
.key(static_key)
>>>>>>      =3D> off: tracepoint->key - tracepoint
>>>>>> ```
>>>>>>
>>>>>> In practice, the implementation of `arch_static_branch` overlooked m=
any
>>>>>> detailed descriptions. To improve clarity, additional comments have =
been
>>>>>> added to the original logic. The approach has been modified to direc=
tly
>>>>>> locate the corresponding `static_key` instead of using offsets, ther=
eby
>>>>>> reducing  computational overhead.
>>>>>>
>>>>>> If finding the offset from the primitive type is necessary for this
>>>>>> implementation, I will abandon this change.
>>>>>>
>>>>>> Additionally, support for the `static_branch_enable/disable` APIs ha=
s been
>>>>>> introduced.
>>>>>>
>>>>>> Signed-off-by: chenmiao <chenmiao@openatom.club>
>>>>>> +    ($basety:ty, $branch:expr, $key:path, $keytyp:ty, $field:ident)=
 =3D> {{
>>>>>>             let _key: *const $keytyp =3D ::core::ptr::addr_of!($key)=
;
>>>>>> -        let _key: *const $crate::bindings::static_key_false =3D ::c=
ore::ptr::addr_of!((*_key).$field);
>>>>>> +        let _key: *const $basety =3D ::core::ptr::addr_of!((*_key).=
$field);
>>>>>>             let _key: *const $crate::bindings::static_key =3D _key.c=
ast();
>>>>>>    =20
>>>>>>             #[cfg(not(CONFIG_JUMP_LABEL))]
>>>>>> @@ -30,7 +71,88 @@ macro_rules! static_branch_unlikely {
>>>>>>             }
>>>>>>    =20
>>>>>>             #[cfg(CONFIG_JUMP_LABEL)]
>>>>>> -        $crate::jump_label::arch_static_branch! { $key, $keytyp, $f=
ield, false }
>>>>>> +        {
>>>>>> +            $crate::jump_label::arch_static_branch! { _key, $branch=
 }
>>>>>> +        }
>>>>> So ... this is changing from $key to _key. That's replacing the globa=
l
>>>>> variable with a local variable holding a pointer to the global variab=
le.
>>>>> However, the arch_static_branch! macro uses the `sym` operand which
>>>>> requires you to pass it the global directly.
>>>>>
>>>>> Did you try this code? I don't believe it will work.
>>>>>
>>>>> Alice
>>>> I'm very sorry for making a fatal mistake. My misunderstanding of sym =
led to
>>>> this issue, so I shouldn't make any changes to that part. However, reg=
arding
>>>> the other modifications, I believe it is necessary to support the dire=
ct
>>>> passing of structures similar to `static_key_false`, just as in C lang=
uage.
>>> It sounds like you are adding a new use-case for this macro. Can you
>>> provide more information for this new feature? It is currently unclear
>>> to me exactly how this will be used.
>>>
>>> Alice
>> If there's a binding-required driver implementation in the future where =
a key
>> function uses if (static_branch_unlikely(&zoned_enabled))=E2=80=94 defin=
ed by
>> DEFINE_STATIC_KEY_FALSE(zoned_enabled);=E2=80=94 then in Rust we can dir=
ectly
>> implement it using if static_branch_unlikely!(zoned_enabled), without ha=
ving
>> to call it via if static_branch_unlikely!(zoned_enabled,
>> bindings::static_key_false, key).
>>
>> static_branch_unlikely!(zoned_enabled) instead of
>> static_branch_unlikely!(zoned_enabled, bindings::static_key_false, key).
> In general, you would never use "static_key_false" as the second
> argument to static_branch_unlikely!. The second argument is the name of
> the struct *containing* a field of type static_key_false.
>
> I guess your point is that there's no way to use the macro right now if
> the global is a bare static_key_false that is not wrapped in a struct?
>
> Alice
Yes, you're right. But in fact, currently there are no other uses of=20
static_branch_unlikely in Rust for Linux (except for tracepoint), so this i=
s=20
also a bit awkward.

