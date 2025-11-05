Return-Path: <linux-kernel+bounces-886563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 662D7C35F0A
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 14:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 45CF74FCF11
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 13:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EFD31D370;
	Wed,  5 Nov 2025 13:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openatom-club.20200927.dkim.feishu.cn header.i=@openatom-club.20200927.dkim.feishu.cn header.b="lg5PiINu"
Received: from sg-1-19.ptr.blmpb.com (sg-1-19.ptr.blmpb.com [118.26.132.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E85931D386
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 13:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762350940; cv=none; b=nNv9KmNBC8alqI3W55Hx580iV28XVgi4fSP2f8S0mnmyonQuYHAGc2qgWfEg3M3i7NZDqWHvRvEllmRKadJ9cSHXMp+OhX4PRnI+EdC60I4I7xycz2UHPSONEu33UztoaYbBFmvufwisoeAvDJJiLVVMafLJ7QJMME0o/Ugl2Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762350940; c=relaxed/simple;
	bh=Ne/x6WAUXKDBEfToF/9H1xkD2gW0oBLfEwKvnZaFfsI=;
	h=From:Date:In-Reply-To:Content-Type:Subject:Mime-Version:
	 Message-Id:References:To:Cc; b=dd+JKkEpAyZdWOdmzHoBtj1o5mdfF5iCfoAqj5aWqAqDTaOM0dy0f3ETpMreWt0eEbbh42DqDV6YERHZlj4JvdtZeBa5yH7P06QsRe5j5o63eXkWVxRTi0XB7aXcTGisy/Qjq01SK16XICLmp8q2ksxPnksnLwq5m+arGscuPio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openatom.club; spf=pass smtp.mailfrom=openatom.club; dkim=pass (2048-bit key) header.d=openatom-club.20200927.dkim.feishu.cn header.i=@openatom-club.20200927.dkim.feishu.cn header.b=lg5PiINu; arc=none smtp.client-ip=118.26.132.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=openatom.club
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openatom.club
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=openatom-club.20200927.dkim.feishu.cn; t=1762350931;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=c6Fob5GKK2EFqfF+QqeezHuK3XYr7a3QAGL+sni9S9w=;
 b=lg5PiINuFJXchz+Fc4dF/6Oxh/cm+cGm5WIOE8YS+cEe0OaCX63Kpb/uk7NdJxhsjXzRJA
 FgzRMzya9XAMfHYj1nxk+S8+Pf6J44zfBgcEmzi/5mAcyuhoF8vRCd4/Wu7+Fm+egm261p
 210kCs5dmxwvc2W5cQCEEr4Pv8Lw7KXchRBCbyBR93GYiX3QQfC7niG7Y/ZBsQjGWmUuq0
 jPvh1N70c8JKv8w1vZUdkL+HuNVg9zu+ajVUveKYAhAQDqP660DGgr1nqE3nWP10+2xBW6
 PPs+owxIY0BEexBzqtmNbi0vWa4LqHhNbwG9iRXf8Z43TVqnjo4yxZ03Gt33+g==
Content-Transfer-Encoding: quoted-printable
X-Lms-Return-Path: <lba+2690b5751+bbe982+vger.kernel.org+chenmiao@openatom.club>
From: "Chen Miao" <chenmiao@openatom.club>
Date: Wed, 5 Nov 2025 21:55:27 +0800
In-Reply-To: <aQtTRUMUaaUmTAWZ@google.com>
X-Original-From: Chen Miao <chenmiao@openatom.club>
Received: from [198.18.0.1] ([114.249.49.233]) by smtp.feishu.cn with ESMTPS; Wed, 05 Nov 2025 21:55:28 +0800
Content-Type: text/plain; charset=UTF-8
Subject: Re: [PATCH] rust: kernel: Support more jump_label api
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-Id: <90bfcb3e-dee1-4f78-a1b2-02ce99db4997@openatom.club>
References: <df3a68334760b2b254219a69426982bf858dee39.1762221537.git.chenmiao@openatom.club> <aQoIliAbrn0Re7E3@google.com> <b3f50745-5351-4e69-b3e2-ede99511e8dc@openatom.club> <aQtTRUMUaaUmTAWZ@google.com>
User-Agent: Mozilla Thunderbird
To: "Alice Ryhl" <aliceryhl@google.com>
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

On 11/5/2025 9:38 PM, Alice Ryhl wrote:
> On Wed, Nov 05, 2025 at 09:28:39PM +0800, Chen Miao wrote:
>> On 11/4/2025 10:07 PM, Alice Ryhl wrote:
>>> On Tue, Nov 04, 2025 at 02:04:17AM +0000, chenmiao wrote:
>>>> The initial implementation of arch_static_branch was achieved by acces=
sing
>>>> the offset from the original type. However, this approach extended the
>>>> path and introduced redundant calculations when dealing with types lik=
e
>>>> `static_key_true/false`, as shown below:
>>>>
>>>> ```
>>>> static_brach_unlikely(tp, tracepoint, key)
>>>>     =3D> tracepoint->key->key
>>>>     =3D> &tracepoint->key(static_key_false) =3D=3D &tracepoint->key.ke=
y(static_key)
>>>>     =3D> off: tracepoint->key - tracepoint
>>>> ```
>>>>
>>>> In practice, the implementation of `arch_static_branch` overlooked man=
y
>>>> detailed descriptions. To improve clarity, additional comments have be=
en
>>>> added to the original logic. The approach has been modified to directl=
y
>>>> locate the corresponding `static_key` instead of using offsets, thereb=
y
>>>> reducing  computational overhead.
>>>>
>>>> If finding the offset from the primitive type is necessary for this
>>>> implementation, I will abandon this change.
>>>>
>>>> Additionally, support for the `static_branch_enable/disable` APIs has =
been
>>>> introduced.
>>>>
>>>> Signed-off-by: chenmiao <chenmiao@openatom.club>
>>>> +    ($basety:ty, $branch:expr, $key:path, $keytyp:ty, $field:ident) =
=3D> {{
>>>>            let _key: *const $keytyp =3D ::core::ptr::addr_of!($key);
>>>> -        let _key: *const $crate::bindings::static_key_false =3D ::cor=
e::ptr::addr_of!((*_key).$field);
>>>> +        let _key: *const $basety =3D ::core::ptr::addr_of!((*_key).$f=
ield);
>>>>            let _key: *const $crate::bindings::static_key =3D _key.cast=
();
>>>>   =20
>>>>            #[cfg(not(CONFIG_JUMP_LABEL))]
>>>> @@ -30,7 +71,88 @@ macro_rules! static_branch_unlikely {
>>>>            }
>>>>   =20
>>>>            #[cfg(CONFIG_JUMP_LABEL)]
>>>> -        $crate::jump_label::arch_static_branch! { $key, $keytyp, $fie=
ld, false }
>>>> +        {
>>>> +            $crate::jump_label::arch_static_branch! { _key, $branch }
>>>> +        }
>>> So ... this is changing from $key to _key. That's replacing the global
>>> variable with a local variable holding a pointer to the global variable=
.
>>> However, the arch_static_branch! macro uses the `sym` operand which
>>> requires you to pass it the global directly.
>>>
>>> Did you try this code? I don't believe it will work.
>>>
>>> Alice
>> I'm very sorry for making a fatal mistake. My misunderstanding of sym le=
d to
>> this issue, so I shouldn't make any changes to that part. However, regar=
ding
>> the other modifications, I believe it is necessary to support the direct
>> passing of structures similar to `static_key_false`, just as in C langua=
ge.
> It sounds like you are adding a new use-case for this macro. Can you
> provide more information for this new feature? It is currently unclear
> to me exactly how this will be used.
>
> Alice

If there's a binding-required driver implementation in the future where a k=
ey=20
function uses if (static_branch_unlikely(&zoned_enabled))=E2=80=94 defined =
by=20
DEFINE_STATIC_KEY_FALSE(zoned_enabled);=E2=80=94 then in Rust we can direct=
ly=20
implement it using if static_branch_unlikely!(zoned_enabled), without havin=
g=20
to call it via if static_branch_unlikely!(zoned_enabled,=20
bindings::static_key_false, key).

static_branch_unlikely!(zoned_enabled) instead of=20
static_branch_unlikely!(zoned_enabled, bindings::static_key_false, key).

Chen Miao

