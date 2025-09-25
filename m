Return-Path: <linux-kernel+bounces-832942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C9BBA0CE9
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 19:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA9723BE9BB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Sep 2025 17:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0FC30CD9B;
	Thu, 25 Sep 2025 17:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=elijahs.space header.i=@elijahs.space header.b="VhtuGPKN";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="R4Pwbk/D"
Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25E830CB20
	for <linux-kernel@vger.kernel.org>; Thu, 25 Sep 2025 17:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758820843; cv=none; b=Q/0LQGBGdQs1/Vjn/jP4psWo7/uGntm2iApKJYkjcg/zbQzczz2ZpLo+CuKAVHmzR00jdAs1iLupnaLeeAP/ymk6P85tl6ybtqSIkMTg73F97vDSfnx0RmetReGGadMcI9zwzLoHEnNnbULznmIzhU2/5DjGNnj6xHybPrALANI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758820843; c=relaxed/simple;
	bh=97iUBxcczrc8d4ZjA8iMJpyUnogsQG3SuufPU6f2ca0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=akvROwJaia5q1IEnCUZT6q2xjPe+RmZWoHgNtQKJZavXS4aQr+wkbKBYum7v9WYAyyYeAYPzh6sZ7tyiRbVVuhKChAoTbXAoF2tUly/35YxrAkeK+lxdbOe2XliJ7Dhcuoczxzs2kHnVFzdBO1APvG1KAijoBaKrLWT4ZAQwHco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=elijahs.space; spf=pass smtp.mailfrom=elijahs.space; dkim=pass (2048-bit key) header.d=elijahs.space header.i=@elijahs.space header.b=VhtuGPKN; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=R4Pwbk/D; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=elijahs.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=elijahs.space
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=VhtuGPKN+ofn4I8WGP0GkYmDMBmyLJdRXM8GhaHAkMsxRw8oMqH7q7350yJDTUbHyK1e+7b9vfft8bnL+YKirFTJD+l7eRwyNgxTqoOVpNfibMYy1i7OPrsmO0FikERsv1QzGycVfjTVLnK+38a7oofcABek8kvO1nH8m8Cue00F1BbCHr8OOsXjC8hO59i9VBmo/twYVWB4asO6+8QzpM/p0o5GVma+9okSV/0NHuGsnWVYBAxmEaK5elRhsVFm/arVDUC6qmzOJdCwlZViB3slKY2HQ3xUP3HdY5hkaJTj98lwuqhuCeoSJP0CwE7ZdVoOD4nJnF6HM/Xn0s3lQA==; s=purelymail2; d=elijahs.space; v=1; bh=97iUBxcczrc8d4ZjA8iMJpyUnogsQG3SuufPU6f2ca0=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=R4Pwbk/D+8Y/tpVxz1UD8WEKrmqbA1h2GH4KbnVGeeySbeDisfO8qO3fvelzJbOJ1GQM0IUB1lAcZqtoNhdWY9lsXo9bfhPHW31qumeUiphzJ1GQJXxxnsYwCtvZez47QBUsWLwtmtdU6pv/YmH7ioxgQPykEMFls79gAAuvo7LawcnDhTg9Zc0shEJbwCxlJjp+XwVfKqG1dGgmZu+gk0InSlSG2DACOjX4b6rkaVYaulLmCDOeOOxYA29hIeriQ6YgQA4cHtQCIYBt+Ebu+iRF0dPhPID5tumsI3rtrwN55+NOkja+EFaDwCb93TOgXu6BGvB9LMoq7et39OzB4Q==; s=purelymail2; d=purelymail.com; v=1; bh=97iUBxcczrc8d4ZjA8iMJpyUnogsQG3SuufPU6f2ca0=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 26912:4866:null:purelymail
X-Pm-Original-To: linux-kernel@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1074361899;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Thu, 25 Sep 2025 17:20:15 +0000 (UTC)
Message-ID: <73d7d53f-439b-44a9-98ca-0b1c8fbc1661@elijahs.space>
Date: Thu, 25 Sep 2025 10:20:13 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rust: slab: add basic slab module
To: Danilo Krummrich <dakr@kernel.org>, Elijah Wright <git@elijahs.space>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Uladzislau Rezki <urezki@gmail.com>,
 linux-mm@kvack.org
References: <20250924193643.4001-1-git@elijahs.space>
 <DD1SGLU4180C.361W5XLH76XNC@kernel.org>
Content-Language: en-US
From: Elijah <me@elijahs.space>
In-Reply-To: <DD1SGLU4180C.361W5XLH76XNC@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I was thinking of maybe creating something like KBox for kmem_cache but 
I didn't want to touch allocator code yet, I figured I would just create 
the groundwork for that to exist. rbtree.rs uses KBox now but I'm not 
sure it should, at least if it's going to scale to many nodes

On 9/25/2025 2:54 AM, Danilo Krummrich wrote:
> What's the motivation?
> 
> I mean, we will need kmem_cache soon. But the users will all be drivers, e.g.
> the GPU drivers that people work on currently.
> 
> Drivers shouldn't use "raw" allocators (such as Kmalloc [1] or Vmalloc [2]), but
> the corresponding "managed" allocation primitives, such as KBox [3], VBox [4],
> KVec, etc.
> 
> Therefore, the code below shouldn't be used by drivers directly, hence the
> question for motivation.
> 
> In any case, kmem_cache is a special allocator (special as in it can have a
> non-static lifetime in contrast to other kernel allocators) and should be
> integrated with the existing infrastructure in rust/kernel/alloc/.
> 
> I think there are multiple options for that; (1) isn't really an option, but I
> think it's good to mention anyways:
> 
>    (1) Allow for non-zero sized implementations of the Allocator trait [3], such
>        that we can store a reference count to the KmemCache. This is necessary to
>        ensure that a Box<T, KmemCache> can't out-live the KmemCache itself.
> 
>        The reason why I said it's not really an option is because it discards the
>        option for dynamic dispatch of the generic Box type.
> 
>    (2) Same as (1), but with a custom Box type. This keeps dynamic dispatch for
>        the generic Box type (i.e. KBox, VBox, KVBox), but duplicates quite some
>        code and still doesn't allow for dynamic dispatch for the KmemCacheBox.
> 
>    (3) Implement a macro to generate a custom KmemCache Allocator trait
>        implementation for every KmemCache instance with a static lifetime.
> 
>        This makes KmemCache technically equivalent to the other allocators, such
>        as Kmalloc, etc. but obviously has the downside that the KmemCache might
>        live much longer than required.
> 
>        Technically, most KmemCache instances live for the whole module lifetime,
>        so it might be fine though.
> 
>        (This is what I think Alice proposed.)
> 
>    (4) Solve the problem on the C side and let kmem_cache_alloc() take care of
>        acquiring a reference count to the backing kmem_cache. The main question
>        here would be where to store the pointer for decreasing the reference
>        count on kmem_cache_free().
> 
>        Theoretically, it could be stored within the allocation itself, but it's a
>        bit of a yikes.
> 
>        However, it would resolve all the mentioned problems above.
> 
> I'd like to see (3) or (4), also depending on what the MM folks think.


