Return-Path: <linux-kernel+bounces-833016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F82BA0FC1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 20:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09A58624973
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 18:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DBD313E39;
	Thu, 25 Sep 2025 18:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="snnSx2Jo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489681DBB13;
	Thu, 25 Sep 2025 18:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758824253; cv=none; b=RiJaFrEj1ni1KbDof0jx0MHvAHlydSpF4aRFdeNnM5rI+0IPRiE6sQbfMXs7Be/9vGglo8jIPVqoRC78KhMIsoqjONrrmxXWqjh8u0gGDgvpmnU0qsQC+IHxNB5DeZmZt+H0a00sbdKXjnZ6MfWf82OSerS9RqviUAXYIkcJdMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758824253; c=relaxed/simple;
	bh=vplUSjg+R+HU5CjzMqQFgUqhUMUeCAKMeinKHcOnjpc=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=CuU9zToTGcguGUpLZkWxbW2Y8sMIiHjUjTxlZzopkFiLmjJx/ZBWpBmkTM11ZLhwf63k1E92Ik/IxIBWMaKfewlThzvHhdWJ3xoJxVouPtpNNoX7qX3qO4B54Q9NloY4SRB/ZP0cKM3+kYtFmlkVTzenRTWKwAZdfMhpS+Tkk0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=snnSx2Jo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F635C4CEF0;
	Thu, 25 Sep 2025 18:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758824252;
	bh=vplUSjg+R+HU5CjzMqQFgUqhUMUeCAKMeinKHcOnjpc=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=snnSx2JoG2IMBMWuBuo4PaawWerSZyp3dENX1M7wJ/+jZc/ei+/XX8wlr+waqZlKb
	 R/87WQ7tlZqfNw0lxyMTm26eFFnyKPV/kf45PjT5+uugertGzUgkUXrauEHDIv584e
	 VFADaX0sCXb11+G+QAPM7z9L4Mm2QYKKcLtuQFCbpdPXP1wOX7+j5HpoSHkEinTi4+
	 2v42bc7xs1bfqJnmGjNZDym5CiEQliz0jnzSDbWxIndVjQqV/tO4AdG4zeWUZw8RWY
	 3sjCJiI2Sf96/nihtSkC4t+E+AIi+vuPyq6hswpW6UpbFppBZO+XEqHiWi65YLESnf
	 NLagdblxfDkOA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 25 Sep 2025 20:17:27 +0200
Message-Id: <DD235SX4QVBU.246L6UKUWBNB5@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] rust: slab: add basic slab module
Cc: "Elijah Wright" <git@elijahs.space>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Lorenzo Stoakes"
 <lorenzo.stoakes@oracle.com>, "Vlastimil Babka" <vbabka@suse.cz>, "Liam R.
 Howlett" <Liam.Howlett@oracle.com>, "Uladzislau Rezki" <urezki@gmail.com>,
 <linux-mm@kvack.org>
To: "Elijah" <me@elijahs.space>
References: <20250924193643.4001-1-git@elijahs.space>
 <DD1SGLU4180C.361W5XLH76XNC@kernel.org>
 <73d7d53f-439b-44a9-98ca-0b1c8fbc1661@elijahs.space>
 <DD22FI7F2ZHT.32SL8PXFZZHV3@kernel.org>
 <6e9c820f-070b-409e-ac25-af96b8b962c6@elijahs.space>
 <DD234804U7YK.3S2MBUJSFHF8J@kernel.org>
In-Reply-To: <DD234804U7YK.3S2MBUJSFHF8J@kernel.org>

On Thu Sep 25, 2025 at 8:15 PM CEST, Danilo Krummrich wrote:
> On Thu Sep 25, 2025 at 8:05 PM CEST, Elijah wrote:
>> On 9/25/2025 10:43 AM, Danilo Krummrich wrote:
>>
>>  > Anyways, I'd also like to hear some more opinions, especially=20
>> regarding (4), as
>>  > mentioned.
>>
>> ok I just looked it over. I think (4) isn't really viable, the cache=20
>> pointer storage overhead is probably too much (in addition to some=20
>> complex issues).
>
> Probably, given that kmemcache is meant to be used when we have a lot of =
(small)
> allocations.
>
> However, I'd like to hear from the MM folks, if there may be options in t=
he
> existing infrastructure, or if it's really a dead end.
>
> What are the other complex issues you are referring to?
>
>> I don't really like having a macro (so (3) basically)=20
>> and I think there are issues with non-static caches, I don't know=20
>> specifically though. obviously (1) doesn't work. (2) is exactly what I=
=20
>> was thinking specifically for rbtree. IMO the only useful options are=20
>> (2) and (3). I would say maybe implement (2) first and if you want=20
>> macro-generated ZST allocators they can wrap whatever that Box ends up=
=20
>> being.
>
> I'm not sold on duplicating the Box code just yet. What issues are you re=
ferring
> to?

Also, if we argue that (4) has a problem with scalability, then (2) has the
problem as well.

