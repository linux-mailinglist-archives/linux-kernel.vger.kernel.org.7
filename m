Return-Path: <linux-kernel+bounces-776298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E77FEB2CB82
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 19:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 205BB5C27EB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 17:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B80530DEAA;
	Tue, 19 Aug 2025 17:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBr2viVC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37182550CA;
	Tue, 19 Aug 2025 17:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755626029; cv=none; b=WW0PmUaRRmExu8WOo05Urxj+B9+0iKMA1m9ypoxiiTFM4HUPdROF1dCSlPfijUIp14xZtQBZciG+55QL8Sj0somM8nF4hjUj7O+85ATKt2Z8o82OFQbgkxi4iOuzR9z7r04uzRzqwbnUSsLWoKHSOSpYQPggv1dIhB9CVU5dmNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755626029; c=relaxed/simple;
	bh=+xxXPwLoU0wjEb+mW+JP5nJ7ehtG5WJJ5v83QIHPAO4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=V462D7OF+an8Bh2fphhrItrpaIz2MfpxyxQMFQvHdqPL6g391v51lEh4AO472VVDHMoFBahJFzVFROMf6zE3E0AeeqsdKiq0lCyg3CZ5lpAxAvZB51dabz8Ns9T9n+LBkpB38Q3E2IPqzPkNcWKWaIyLE9ImsiAZ9He9LRJsqK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBr2viVC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E635EC4CEF1;
	Tue, 19 Aug 2025 17:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755626028;
	bh=+xxXPwLoU0wjEb+mW+JP5nJ7ehtG5WJJ5v83QIHPAO4=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=bBr2viVC5Frwot+fUtbob4OA2U2Aso9ZG8T/EcSpgnZY7VzFOm3a3Op1M+G1KyN8S
	 Qv6BturvImnj+cFCyEY6ZGp26VHFlVXVehSK1o6b99R1SGjncIjrwZIffIS/IVWgwi
	 cHe9kWI6WMQHZE7DSpoJlRB3qUYV+Jc+xjucuRuL3fPPtcCbatAQAuTPCQ54FuBtWg
	 leAPoS9xbbob+n4lhn6RxRfFn8KSIWwd9ipS4TV8S1ATe6oi3GAKuUAgTlA/bPNNjy
	 ZNliXflbwJimCpVjXSw/FPAIiibCkdjhcDbbWiXhve2i7QJv6Cu1p4VN8jDny+LuaK
	 SHrE4VDN3VPMg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 Aug 2025 19:53:44 +0200
Message-Id: <DC6LHHC2RQAE.1D7LOPCF3IZNB@kernel.org>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Lorenzo Stoakes"
 <lorenzo.stoakes@oracle.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Andrew
 Ballance" <andrewjballance@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 <linux-kernel@vger.kernel.org>, <maple-tree@lists.infradead.org>,
 <rust-for-linux@vger.kernel.org>, <linux-mm@kvack.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 5/5] rust: maple_tree: add MAINTAINERS entry
References: <20250819-maple-tree-v2-0-229b48657bab@google.com>
 <20250819-maple-tree-v2-5-229b48657bab@google.com>
 <DC6DQKE6LVNQ.3BBD8WF8XGROO@kernel.org>
 <5ssx3vakl3enjeaygpxfqtb26ufehwfjvcwqfna4xbhc645xpj@lzuvaf3my3f6>
In-Reply-To: <5ssx3vakl3enjeaygpxfqtb26ufehwfjvcwqfna4xbhc645xpj@lzuvaf3my3f6>

On Tue Aug 19, 2025 at 3:36 PM CEST, Liam R. Howlett wrote:
> * Danilo Krummrich <dakr@kernel.org> [250819 07:49]:
>> On Tue Aug 19, 2025 at 12:34 PM CEST, Alice Ryhl wrote:
>> > Similar to and just below the existing MAPLE TREE entry.
>> >
>> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>> > ---
>> > Liam: I'm not sure what you prefer for the MAINTAINERS entry, so let m=
e
>> > know if you want anything changed. There are also a few other options,
>> > for example, I could just add the files under the existing MAPLE TREE
>> > entry? The get_maintainers script should still send any relevant patch=
es
>> > my way because they also match the RUST entry that has a wildcard on t=
he
>> > rust/ directory.
>>=20
>> From v1 [1]:
>>=20
>> 	>> We should have another section for the maple tree, since it's not ju=
st
>> 	>> used for mm.  Your stated plan is to use it for GPU allocations and =
the
>> 	>> code doesn't live in mm/, wdyt?
>> =09
>> 	> Sure, I can add a new section if you prefer that.
>>=20
>> Maple tree is already used outside of mm, e.g. for regmap stuff and I al=
so use
>> it in nouveau. Hence, I read this as moving maple tree to e.g. lib/ adju=
sting
>> the existing entry.
>>=20
>> I personally think that - of course unless the affected people prefer ot=
herwise
>> - it is usually best to keep a single maintainers entry for the C and th=
e Rust
>> code. Maybe Alice can simply be added to the existing maintainers entry?
>>=20
>> What do you think?
>
> I'm not sure what you mean by lib/ since the lib files are spread into
> other entries by the looks of it?

I think I misunderstood your comment from [1] above, and, despite knowing
better, mistakenly assumed otherwise -- just ignore this comment.

> I'm okay with the entry below or adjusting the existing one.

If you're both fine with either, I suggest to keep a single entry for both.

In general I think it's better if we try to avoid to differentiate between =
Rust
and C code of a single subsystem (or component) maintenance wise unless the=
re
are specific reasons.

Even though sometimes it's just a formality, I think it can help to bring p=
eople
together and learn from each other. There more good examples we can set up =
for
this, the better. :)

>> [1] https://lore.kernel.org/all/aJW3L3SEVUl_AVvN@google.com/

