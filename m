Return-Path: <linux-kernel+bounces-868355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBB3C05071
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D133C4FC101
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 616003043CD;
	Fri, 24 Oct 2025 08:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TsYUin82"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B0D2FC88C;
	Fri, 24 Oct 2025 08:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761294195; cv=none; b=Ymiy+XTIvyoDWjm77BNapwErzGX5kmMAYgzilyb+75E2htJI1OGedZHMaCF9r4xsU4qca5ISxeeQrycig+4ceIVx1QyVgbX8/0yREifspsXZdSb/3wpQWaR8mtrsf7LdhZED3CBbVrNIUy6PZ7Z+tMb7bNbc4OlQbMGSvTyeTOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761294195; c=relaxed/simple;
	bh=f7IiCtdsMP9fzUEEFAOVEDHBt8eRbabg5W2VbyP0LKE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kSSxpLG1ggTU7hEB0pqzpfYgtq9fqj3Yib2oRlMct8Z6CZVd00M1NCFaei4sMRtBgPA9yE/7gQkt1Qmw0tJ93Y1akq7U747dEjRS3xUj+O7WcH6PuBttFWD5X0Vn20w+YQwuhHZSDaR5tNwihO3jhJNU5Nh3S9knTBxDafopEXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TsYUin82; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9380C4CEF1;
	Fri, 24 Oct 2025 08:23:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761294195;
	bh=f7IiCtdsMP9fzUEEFAOVEDHBt8eRbabg5W2VbyP0LKE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=TsYUin82qZvPIMvVAMj+2viHwFtr/OdOgFKW6F87cNwzjpQdTFVG9W0VrbVyo0/PW
	 pKLTOLX6H7Z18a+zJSMb9/YEeHHmZn2fRae8oZ5ruAqgkp/S/3yvJfCoceCQCqRsp6
	 wNihpd0vE4QqPT/nHH+WpQzThpPDjhVCENf0BizVmn1xg/C1yeNAfUTsudo5fcNsid
	 mm9fBPdiodoGBu3f0+MBathiIKzVjt5gU3qWwN8/Ozk5DN8J7CxzxWoqVaj7geOX/7
	 1N3yGR5WUmXgBu7Kv7gRbQCjTo1iOeD2AH7XPQARZUcFG+0iNS+ttcL517ilqbX3Le
	 CdauNLQJExzjA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>, aliceryhl@google.com,
 dakr@kernel.org, miguel.ojeda.sandonis@gmail.com
Cc: fujita.tomonori@gmail.com, daniel.almeida@collabora.com,
 alex.gaynor@gmail.com, ojeda@kernel.org, anna-maria@linutronix.de,
 bjorn3_gh@protonmail.com, boqun.feng@gmail.com, frederic@kernel.org,
 gary@garyguo.net, jstultz@google.com, linux-kernel@vger.kernel.org,
 lossin@kernel.org, lyude@redhat.com, rust-for-linux@vger.kernel.org,
 sboyd@kernel.org, tglx@linutronix.de, tmgross@umich.edu,
 gregkh@linuxfoundation.org
Subject: Re: [PATCH v2 1/2] rust: add udelay() function
In-Reply-To: <20251023.141909.400243634709519102.fujita.tomonori@gmail.com>
References: <DDO3OMBHS8TB.2LDODR1AFRCU3@kernel.org>
 <20251022.193230.585171330619599845.fujita.tomonori@gmail.com>
 <aPjmKSrETqrchW_e@google.com>
 <v19-iFZczROFeW5CLs5unJeqiFWIX0oFV1ekc7pY-uzN8DDyoe_SVQqX6ARPdY3WbNjys5ffGs-8Cpisdk3h2g==@protonmail.internalid>
 <20251023.141909.400243634709519102.fujita.tomonori@gmail.com>
Date: Fri, 24 Oct 2025 10:23:03 +0200
Message-ID: <874irohfo8.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

"FUJITA Tomonori" <fujita.tomonori@gmail.com> writes:

> On Wed, 22 Oct 2025 14:11:53 +0000
> Alice Ryhl <aliceryhl@google.com> wrote:
>
>> On Wed, Oct 22, 2025 at 07:32:30PM +0900, FUJITA Tomonori wrote:
>>> On Tue, 21 Oct 2025 17:20:41 +0200
>>> "Danilo Krummrich" <dakr@kernel.org> wrote:
>>>
>>> > On Tue Oct 21, 2025 at 5:13 PM CEST, Miguel Ojeda wrote:
>>> >> i.e. if they aren't sure what the value is, then I would prefer they
>>> >> clamp it explicitly on the callee side (or we provide an explicitly
>>> >> clamped version if it is a common case, but it seems to me runtime
>>> >> values are already the minority).
>>> >
>>> > Absolutely! Especially given the context udelay() is introduced
>>> > (read_poll_timeout_atomic()), the compile time checked version is wha=
t we really
>>> > want.
>>> >
>>> > Maybe we should even defer a runtime checked / clamped version until =
it is
>>> > actually needed.
>>>
>>> Then perhaps something like this?
>>>
>>> #[inline(always)]
>>> pub fn udelay(delta: Delta) {
>>>     build_assert!(
>>>         delta.as_nanos() >=3D 0 && delta.as_nanos() <=3D i64::from(bind=
ings::MAX_UDELAY_MS) * 1_000_000
>>>     );
>>
>> This is a bad idea. Using build_assert! assert for range checks works
>> poorly, as we found for register index bounds checks.
>
> Oh, I didn=E2=80=99t know about that. Do you have a pointer or some detai=
ls I
> could look at?
>
>
>> If you really want to check it at compile-time, you'll need a wrapper
>> type around Delta that can only be constructed with delays in the right
>> range.
>
> You meant that introducing a new type like UdelayDelta, right?
>
> read_poll_timeout() and read_poll_timeout_atomic() use different Delta
> types... I'm not sure it's a good idea.

I would assume we keep this type private and only construct it in
`udelay`. @Alice, could you give a pointer on this approach?


Best regards,
Andreas Hindborg




