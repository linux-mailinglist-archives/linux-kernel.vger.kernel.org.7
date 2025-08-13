Return-Path: <linux-kernel+bounces-766878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56801B24C3F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 16:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F886886B90
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 14:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15F42EAD00;
	Wed, 13 Aug 2025 14:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CbQsSzA9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058B22D94A4;
	Wed, 13 Aug 2025 14:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755096001; cv=none; b=Z7GC/XvsSbEHgq7OCEUdgyPw0/pMFPhJ6fyvJJwdIEeCODWhu1D76AutAHD8u6s4WcV6KpIUowQflsF5GWYq8V7vIW8qxPEtoDS6RHxTjSj+nOZxi5Tb7qQpPFaordJ0t8CLrj4ivlVhds4LKaWDGR3P9vS9PUyVUhoeu5+tbDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755096001; c=relaxed/simple;
	bh=nIMn1kPl8ANV2TH1sXmHbDMsu1fIrTebb3WmS9IqLtc=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=DYtLXP+SDI3s+CXoJgvG/ci79dR3UjXQmmnDEVip2z7KXow9hZfK2TvOZtCZ/ECXSe/OjT4fpOC6nVQV9feMNsJm6e+uPc8cmeKfAtAOmkC+GEbFhDTesNvW1EYVXQYCTOW7CSQzDYGlBl3I9nldNVTNRIp+8EoiMwfj8n/w/30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CbQsSzA9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF34C4CEED;
	Wed, 13 Aug 2025 14:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755096000;
	bh=nIMn1kPl8ANV2TH1sXmHbDMsu1fIrTebb3WmS9IqLtc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CbQsSzA9gk13zrXG8Mguj441Rgv+J7xz1DDqTcWxw0E6w+KZJXfXDgVjh7xIWKHG7
	 j6BxIhjitWER3MKemcagzVbBuYX7kD62K9XfRR75YjcWhO7sCsh3QP6vSeKHndKiah
	 3ifftJCIQRcfZh7MG5Pz2XXiYyNT3B393+5hqtBdbEl6D+4QZZrmSHXGS+NJCQgafm
	 6RFGTmGeyREC+Xd/SyUzpTnMqIHHhW1zp9Xqjm/0jLxXARVc2HLBq0PTjCchGodC78
	 vfNdgtQlWz8exx6940Evo8+kimAI/sJC/hh5kLk/MimIJcyV9nWgXfG5bLu1CrKOPp
	 xcCx6Bzx8Zu3A==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 13 Aug 2025 16:39:53 +0200
Message-Id: <DC1DLSRDL44Z.W74NH6OV15J6@kernel.org>
From: "Benno Lossin" <lossin@kernel.org>
To: "Tamir Duberstein" <tamird@gmail.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Luis Chamberlain" <mcgrof@kernel.org>, "Russ Weight"
 <russ.weight@linux.dev>, "Peter Zijlstra" <peterz@infradead.org>, "Ingo
 Molnar" <mingo@redhat.com>, "Will Deacon" <will@kernel.org>, "Waiman Long"
 <longman@redhat.com>, "Nathan Chancellor" <nathan@kernel.org>, "Nick
 Desaulniers" <nick.desaulniers+lkml@gmail.com>, "Bill Wendling"
 <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>, "Christian
 Brauner" <brauner@kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>
Subject: Re: [PATCH v14 3/3] rust: replace `CStr` with `core::ffi::CStr`
X-Mailer: aerc 0.20.1
References: <20250710-cstr-core-v14-0-ca7e0ca82c82@gmail.com>
 <20250710-cstr-core-v14-3-ca7e0ca82c82@gmail.com>
 <DC0A9UKTPH05.2O2V0B2KHMIW8@kernel.org>
 <CAJ-ks9n4V-PEDhkTv6SXj_Oh6LB4LdsNi8Nnv_6JbT7dhvnh2w@mail.gmail.com>
In-Reply-To: <CAJ-ks9n4V-PEDhkTv6SXj_Oh6LB4LdsNi8Nnv_6JbT7dhvnh2w@mail.gmail.com>

On Wed Aug 13, 2025 at 4:06 PM CEST, Tamir Duberstein wrote:
> On Tue, Aug 12, 2025 at 3:50=E2=80=AFAM Benno Lossin <lossin@kernel.org> =
wrote:
>> On Thu Jul 10, 2025 at 4:53 PM CEST, Tamir Duberstein wrote:
>> > +/// Extensions to [`CStr`].
>> > +pub trait CStrExt {
>>
>> Should we make this trait sealed?
>
> We can -- but is it harmful for someone to implement? I think probably no=
t.

I don't think anything aside from `CStr` should implement it, so I'd say
we make it sealed. There are also safe functions that return raw
pointers & an implementation could just return a bogus pointer...

---
Cheers,
Benno

