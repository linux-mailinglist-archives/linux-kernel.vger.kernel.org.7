Return-Path: <linux-kernel+bounces-721732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3F7AFCD35
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 16:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C98A3A4962
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 14:16:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30C02DEA82;
	Tue,  8 Jul 2025 14:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLsIDOX/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2D3204583;
	Tue,  8 Jul 2025 14:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751984213; cv=none; b=bS3nxZ9gQIc/F1T/zEOV/p81Wb9UBF6+Tr7X27EuIq//8SpF3xYrAIBYGoLMKoEPJkWPvkrox7XYZW2y1px8kcO9taDUmuMBQekQ+r8gwi5L7OqTNBJF4XNoBTo0UpypN5rCi1hDg+uJbcrTFmOTkyDuRdY9pwmGVrz8Xra+zkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751984213; c=relaxed/simple;
	bh=HVdq9Ob+LWkVTvYMozCbo8YOzRFhxR/8PVag/iaD52Y=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=fztLQT61Buf9tduoPSpwl310X1Nixq2Jxotay1WugIF16gH2FQA68MpEdpKd4dQCFH7ypMpbBOhqhDk46UQwez9gOclCVZdW7b7tNbifjWs8lkSXKFzYnZmrW0BTEgyYiIDBtnMCX2IJUzpwuCmyI87u8lH20rJqDTpJeErril4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLsIDOX/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1D93C4CEED;
	Tue,  8 Jul 2025 14:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751984212;
	bh=HVdq9Ob+LWkVTvYMozCbo8YOzRFhxR/8PVag/iaD52Y=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=KLsIDOX/gO9gG5yNmE+GW0qVHE/PNhaZHFFwlrCyDDCFkutAzCkrzOykvoHW3463T
	 0NO9tgXfSPuECNSQ2RX6wZEtw/YNP0eGdP3ZHy7hFFgjuAQ0JntIcs3Bays0bsEmRk
	 Q/OP9PCQXMyudlDjCZo3dPudakfShLV24LYYKScir4ftFY1XBoNEWlOeE/x8kH3Qkq
	 fTESNZ+SwKP8Hz/z4t1+tzI/r7Vr0PihIIPl+I1Gx7kRihMnwGFW9Axt1/7ZpKJXY+
	 QnXQuX44/xMRwhQlenMpyWOus49Arjo+bNLe80idPHPu8d+jT7HYVRHeGaInSgjGFt
	 eet+zAlI36iGQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Jul 2025 16:16:48 +0200
Message-Id: <DB6QKIHD2VGS.AHEOXL25SSXW@kernel.org>
Subject: Re: [PATCH v11 0/4] support large align and nid in Rust allocators
Cc: "Vitaly Wool" <vitaly.wool@konsulko.se>, <linux-mm@kvack.org>,
 <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>, "Uladzislau
 Rezki" <urezki@gmail.com>, "Alice Ryhl" <aliceryhl@google.com>, "Vlastimil
 Babka" <vbabka@suse.cz>, <rust-for-linux@vger.kernel.org>, "Liam Howlett"
 <liam.howlett@oracle.com>
To: "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250707164755.631374-1-vitaly.wool@konsulko.se>
 <824065ea-1f5c-4cd4-9917-4b7a91882af8@lucifer.local>
 <aG0HJte0Xw55z_y4@pollux>
 <54fc10ce-c3b6-4571-93e7-eebfc538d0c7@lucifer.local>
In-Reply-To: <54fc10ce-c3b6-4571-93e7-eebfc538d0c7@lucifer.local>

On Tue Jul 8, 2025 at 3:19 PM CEST, Lorenzo Stoakes wrote:
> On Tue, Jul 08, 2025 at 01:55:18PM +0200, Danilo Krummrich wrote:
>> On Tue, Jul 08, 2025 at 11:58:06AM +0100, Lorenzo Stoakes wrote:
>> > +cc Liam
>> >
>> > Hi guys,
>> >
>> > We have a section in MAINTAINERS for mm rust (MEMORY MANAGEMENT - RUST=
), so
>> > it's slightly concerning to find a series (at v11!) like this that cha=
nges
>> > mm-related stuff and it involves files not listed there and nobody bot=
hered
>> > to cc- the people listed there.
>>
>> What files are you referring to? Are you referring to:
>>
>> 	rust/kernel/alloc.rs
>> 	rust/kernel/alloc/*
>>
>> If so, they're indeed not under the "MEMORY MANAGEMENT - RUST" entry, wh=
ich
>> so far seems correct.
>
> Looking at these, they seem to be intended to be the primary means by whi=
ch
> slab/vmalloc allocations will be managed in rust kernel code correct?
>
> There's also stuff relating to NUMA etc.
>
> I really do wonder where the line between this and the mm stuff is. Becau=
se
> if the idea is 'well this is just a wrapper around slab/vmalloc' surely t=
he
> same can be said of what's in rust/kernel/mm.rs re: VMAs?
>
> So if this is the rust equivalent of include/linux/slab.h and mm/slub.c
> then that does seem to me to suggest this should be considered an mm/rust
> thing right?
>
> It'd be good to know exactly what is considered mm rust and should go
> through the mm tree and what isn't.

(Please also see the explanation in [1].)

There's a thin abstraction layer for allocators in Rust, represented by the
kernel's Allocator trait [2] (which has a few differences to the Allocator =
trait in
upstream Rust, which, for instance, can't deal with GFP flags).

This allocator trait is implemented by three backends, one for each of
krealloc(), vrealloc() and kvrealloc() [3].

Otherwise, the alloc module implements Rust's core allocation primitives Bo=
x and
Vec, which each of them have a type alias for allocator backends. For insta=
nce,
there is KBox, VBox and KVBox [4].

This was also mentioned in the mm rework in [5] and in the subsequent patch
series reworking the Rust allocator module [6].

Before [6], the Rust allocator module only covered the kmalloc allocator (i=
.e.
krealloc()) and was maintained under the "RUST" entry.

Since [6], this is maintained under the "RUST [ALLOC]" entry by me.

Given that, there is a clear and documented responsibility, which also Andr=
ew is
aware of.

To me the current setup looks reasonable, but feel free to take a look at t=
he
code and its relationship to mm and Rust core infrastructure and let me kno=
w
what you think -- I'm happy to discuss other proposals.

[1] https://lore.kernel.org/all/aG0HJte0Xw55z_y4@pollux/
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/rust/kernel/alloc.rs#n139
[3] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/rust/kernel/alloc/allocator.rs#n130
[4] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/rust/kernel/alloc/kbox.rs
[5] https://lore.kernel.org/all/20240722163111.4766-1-dakr@kernel.org/
[6] https://lore.kernel.org/all/20241004154149.93856-1-dakr@kernel.org/

