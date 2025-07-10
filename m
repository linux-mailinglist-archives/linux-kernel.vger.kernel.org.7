Return-Path: <linux-kernel+bounces-725585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D056AB0010E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 14:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE5323AD6DA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jul 2025 12:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5FE25229C;
	Thu, 10 Jul 2025 11:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIwoMnsQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C20524DCF8;
	Thu, 10 Jul 2025 11:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752148771; cv=none; b=sZHK+xwOWN1scZ3H1z8rAzqt3IDf5/hVHRk9TM3vTEGIOU4k4ygcrmqVbnBou6I4S6pcvy7TyxZEb8+Nv73ggkiZNnX1B46pkflD9ugNG7LIJaJgv9ZHtj/MFXeaKPFyG7VIcf1fW0/6HQyi1G1ALyUPwCmdJNu62UaSwWiPbe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752148771; c=relaxed/simple;
	bh=rsy5WZacwZWU86OvNk0YvSH3NT8R8QHi3tjqaMIzFls=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nKVageZvO7oHbdhkX0NsqDmaOAJ1ATzs6A2E1uzMoro3ZfhWTHdhC6zXPYI8QqDOlVXI0zCYWCFGQfZcKpv2Yz5G6OYwboGoIPcLANJN3huT9BovqLZIyYgdM9VBDo1u4ikbS5KasnjQHB8QF48eGVHKEggN17mj8kkzAVYeNJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EIwoMnsQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75C0EC4CEE3;
	Thu, 10 Jul 2025 11:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752148771;
	bh=rsy5WZacwZWU86OvNk0YvSH3NT8R8QHi3tjqaMIzFls=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=EIwoMnsQEQyfkRpQ8S5T5vRXNvGXOEeK7l7tXySw6Ucaz3EdZYvY+AQpJDYGSPOTF
	 G7c7r4KwjA8ffR/6V+Zq5dG0C/I8a+fk1v+aK3nQoYB6QBjI5Ub+70vS/ToGlViDc1
	 ZQjv4m/8jrTrFderf5/6eC6E0uMwJCVHFSzlpfhngYJb20Fds3Bo3j/iWkOJElzeYl
	 2cpi/x4pufka+PFfeAUU7u4yRjWfxLgzWygU74Wjm7gHd9npapE9bDMTX9aYMKPA4x
	 QiDk41QnqsQmvOubTXlBoE3OealLT7RXiDrw4KBGqoMtCX9x2bN5dQFZ42BSK2unjd
	 +QDFlgHjlzHGA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "FUJITA Tomonori" <fujita.tomonori@gmail.com>
Cc: <miguel.ojeda.sandonis@gmail.com>,  <alex.gaynor@gmail.com>,
  <ojeda@kernel.org>,  <aliceryhl@google.com>,  <anna-maria@linutronix.de>,
  <bjorn3_gh@protonmail.com>,  <boqun.feng@gmail.com>,  <dakr@kernel.org>,
  <frederic@kernel.org>,  <gary@garyguo.net>,  <jstultz@google.com>,
  <linux-kernel@vger.kernel.org>,  <lossin@kernel.org>,
  <lyude@redhat.com>,  <rust-for-linux@vger.kernel.org>,
  <sboyd@kernel.org>,  <tglx@linutronix.de>,  <tmgross@umich.edu>
Subject: Re: [PATCH v3 0/5] rust: time: Convert hrtimer to use Instant and
 Delta
In-Reply-To: <87h5zstoaq.fsf@kernel.org> (Andreas Hindborg's message of "Fri,
	04 Jul 2025 09:20:29 +0200")
References: <94kOZwdYnRPRMO6SAHAvEFEygT4dU-njfBxTMC6BiPQ-u49pyL5hLgbLQBGOct1ruxVJPtYGJ0Dq0Ns2mh-sMQ==@protonmail.internalid>
	<20250625.082020.1714542193051382332.fujita.tomonori@gmail.com>
	<877c102pxs.fsf@kernel.org>
	<ZFASmKV5PIQgMyCMtprnQhN2MklF9_-3RwUFGLemFqvv23Cm3vyKh-spm0PhKWFjc8vixGNYrAlz93Dw_ruczw==@protonmail.internalid>
	<20250626.091248.526065656918619245.fujita.tomonori@gmail.com>
	<87h5zstoaq.fsf@kernel.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Thu, 10 Jul 2025 13:59:17 +0200
Message-ID: <871pqojlyi.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andreas Hindborg <a.hindborg@kernel.org> writes:

> "FUJITA Tomonori" <fujita.tomonori@gmail.com> writes:
>
>> On Wed, 25 Jun 2025 10:19:59 +0200
>> Andreas Hindborg <a.hindborg@kernel.org> wrote:
>>
>>> "FUJITA Tomonori" <fujita.tomonori@gmail.com> writes:
>>>
>>>> On Tue, 24 Jun 2025 21:03:24 +0200
>>>> Andreas Hindborg <a.hindborg@kernel.org> wrote:
>>>>
>>>>> Andreas Hindborg <a.hindborg@kernel.org> writes:
>>>>>
>>>>>> "FUJITA Tomonori" <fujita.tomonori@gmail.com> writes:
>>>>>>
>>>>>>> On Tue, 24 Jun 2025 15:11:31 +0200
>>>>>>> Andreas Hindborg <a.hindborg@kernel.org> wrote:
>>>>>>>
>>>>>>>>> and already introduces pain for
>>>>>>>>> others (and likely even more pain when we need to rename it back =
next
>>>>>>>>> cycle), it doesn't look like a good idea to keep it.
>>>>>>>>
>>>>>>>> Ok, I'll drop it.
>>>>>>>
>>>>>>> Do you want me to send the updated hrtimer conversion patchset
>>>>>>> (using as_* names)?
>>>>>>
>>>>>> No, I am just about finished fixing up the rest. You can check if it=
 is
>>>>>> OK when I push.
>>>>>
>>>>> I pushed it, please check.
>>>>
>>>> Thanks!
>>>>
>>>> The commit d9fc00dc7354 ("rust: time: Add HrTimerExpires trait") adds
>>>> to Instant structure:
>>>>
>>>> +    #[inline]
>>>> +    pub(crate) fn as_nanos(&self) -> i64 {
>>>> +        self.inner
>>>> +    }
>>>>
>>>> Would it be better to take self instead of &self?
>>>>
>>>> pub(crate) fn as_nanos(self) -> i64 {
>>>>
>>>> Because the as_nanos method on the Delta struct takes self, wouldn=E2=
=80=99t it
>>>> be better to keep it consistent? I think that my original patch adds
>>>> into_nanos() that takes self.
>>>>
>>>> This commit also adds HrTimerExpire strait, which as_nanos() method
>>>> takes &self:
>>>>
>>>> +/// Time representations that can be used as expiration values in [`H=
rTimer`].
>>>> +pub trait HrTimerExpires {
>>>> +    /// Converts the expiration time into a nanosecond representation.
>>>> +    ///
>>>> +    /// This value corresponds to a raw ktime_t value, suitable for p=
assing to kernel
>>>> +    /// timer functions. The interpretation (absolute vs relative) de=
pends on the
>>>> +    /// associated [HrTimerMode] in use.
>>>> +    fn as_nanos(&self) -> i64;
>>>> +}
>>>>
>>>> That's because as I reported, Clippy warns if as_* take self.
>>>>
>>>> As Alice pointed out, Clippy doesn't warn if a type implements
>>>> Copy. So we can add Copy to HrTimerExpires trait, then Clippy doesn't
>>>> warn about as_nanos method that takes self:
>>>>
>>>> +/// Time representations that can be used as expiration values in [`H=
rTimer`].
>>>> +pub trait HrTimerExpires: Copy {
>>>> +    /// Converts the expiration time into a nanosecond representation.
>>>> +    ///
>>>> +    /// This value corresponds to a raw ktime_t value, suitable for p=
assing to kernel
>>>> +    /// timer functions. The interpretation (absolute vs relative) de=
pends on the
>>>> +    /// associated [HrTimerMode] in use.
>>>> +    fn as_nanos(self) -> i64;
>>>> +}
>>>>
>>>> I'm fine with either (taking &self or Adding Copy).
>>>
>>> Let's wait for the whole naming discussion to resolve before we do
>>> anything. I am honestly a bit confused as to what is the most idiomatic
>>> resolution here.
>>>
>>> I think taking `&self` vs `self` makes not difference in codegen if we
>>> mark the function `#[inline(always)]`.
>>
>> I believe we've reached a consensus on the discussion about `&self` vs
>> `self`.
>
> But not on the function name, right?
>
>>
>> Miguel summarized nicely:
>>
>> https://lore.kernel.org/lkml/CANiq72nd6m3eOxF+6kscXuVu7uLim4KgpONupgTsMc=
AF9TNhYQ@mail.gmail.com/
>>
>>>> Yes, I would prefer taking by value. I think Alice mentioned earlier in
>>>> this thread that the compiler will be smart about this and just pass t=
he
>>>> value. But it still feels wrong to me.
>>>
>>> If inlined/private, yes; but not always.
>>>
>>> So for small ("free") functions like this, it should generally not
>>> matter, since they should be inlined whether by manual marking or by
>>> the compiler.
>>
>>> But, in general, it is not the same, and you can see cases where the
>>> compiler will still pass a pointer, and thus dereferences and writes
>>> to memory to take an address to pass it.
>>>
>>> Which means that, outside small things like `as_*`, one should still
>>> probably take by value. Which creates an inconsistency.
>>
>>
>> I think that another consensus from this discussion is that the table
>> in the API naming guidelines doesn't cover this particular case.
>> Therefore, it makes sense to keep the current function name and move
>> forward.
>>
>> Delta already provides `fn as_nanos(self)` (and drm uses in
>> linux-next, as you know) so I believe that Instant should use the same
>> interface.
>>
>>
>> That table needs improvement, but reaching consensus will likely take
>> time, it makes sense to address it independently.
>
> I am still uncertain what guidelines to follow inside the kernel. Last
> time I applied a patch in this situation, I had to remove it again. I
> would rather not have to do that.
>
> Perhaps the best way forward is if you send the patch with the naming
> and argument type you think is best, and then we continue the discussion
> on that patch?

This was discussed [1] and consensus was reached that `as_*` iwth pass
by value plus a `Copy` bound on the trait is the way to go for this
method.


Best regards,
Andreas Hindborg


[1] https://hackmd.io/ZXXSbxxQRpiWzX61sJFlcg?view#API-Naming-guidelines-for=
-conversion-functions


