Return-Path: <linux-kernel+bounces-743974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD52B10674
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 11:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D35CEAE643C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 09:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10082BE62D;
	Thu, 24 Jul 2025 09:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HPjFGbO7"
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374EA2BE629
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 09:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753349334; cv=none; b=HBLA91Oo2V5tAnQoblK6e3BeKTOA1EKtCS1u4yGLWm4l+PdkJDZAPMmSvuA/n6leSUhxp2wC7ww4tGB1FsrHyUQi/s1qn/N+Wj/280QkLtObr1wbBKJlOGaVfIxMkdcryfwe9ojpreRPGI2R+20avFhuoSXI6tngCGKcQFiI25Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753349334; c=relaxed/simple;
	bh=mvdxvHwnj2wsYWz4k1pqZ+LZ54XVClWdUrBL6s+YQf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=udxB61T0SbswAJ0qu4vYzCrmHD6fQQkNUsIgLVKc9GvEAt2enjB+5kf/w0lI7YJTEukh9jJdgD26xPzas06+PJmVuUumX28l9wQU7IskR+1LqoMr2GyVBIh/PyH6600fdaQlyDyLc/4QFdisj83MJ1OnTongyDeEmR5aHi6lwjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HPjFGbO7; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 24 Jul 2025 17:28:32 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753349329;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zov/CwKu2g/aK1+NzqVWBL06syMbiKGO7EetdWyS+Dw=;
	b=HPjFGbO7n3v0p1ZAIrJIxe4cFRd2tlR7bO8sCuk3GP7u7cw1oTchz8qrX9d0P43eILsU8u
	2fkHqvHVca+GP3y2WUICqjaT2vbDvzFcn4CtkAVOug+y5WT9WGFqpb+DVpQSkRNfgpFiND
	mxHt+lYBq4SGSHUQAo5Nq5KvCffUmH4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hui Zhu <hui.zhu@linux.dev>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Danilo Krummrich <dakr@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	bjorn3_gh@protonmail.com, Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hui Zhu <zhuhui@kylinos.cn>,
	Geliang Tang <geliang@kernel.org>
Subject: Re: [PATCH v3 2/2] rust: alloc: kvec: add doc example for `as_slice`
 method
Message-ID: <aIH8wCbTP87ZMIUz@teawaterdeMacBook-Pro.local>
References: <cover.1753339262.git.zhuhui@kylinos.cn>
 <376014022fa799f5480f6f993f1e25b2561507e4.1753339262.git.zhuhui@kylinos.cn>
 <CAH5fLgiYnZKtrHxtTHfw1n4VbRakNa1Nid9UHPWOwfNh-QHoUQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgiYnZKtrHxtTHfw1n4VbRakNa1Nid9UHPWOwfNh-QHoUQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

Hi Alice,

On Thu, Jul 24, 2025 at 10:21:46AM +0200, Alice Ryhl wrote:
> On Thu, Jul 24, 2025 at 9:54 AM Hui Zhu <hui.zhu@linux.dev> wrote:
> >
> > From: Hui Zhu <zhuhui@kylinos.cn>
> >
> > Add a practical usage example to the documentation of `KVec::as_slice()`
> > showing how to:
> > Create a new `KVec`
> > Push elements into it
> > Convert to a slice via `as_slice()`
> >
> > Co-developed-by: Geliang Tang <geliang@kernel.org>
> > Signed-off-by: Geliang Tang <geliang@kernel.org>
> > Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
> > ---
> >  rust/kernel/alloc/kvec.rs | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
> > index 3c72e0bdddb8..d384c34d1a5e 100644
> > --- a/rust/kernel/alloc/kvec.rs
> > +++ b/rust/kernel/alloc/kvec.rs
> > @@ -224,6 +224,15 @@ unsafe fn dec_len(&mut self, count: usize) -> &mut [T] {
> >      }
> >
> >      /// Returns a slice of the entire vector.
> > +    ///
> > +    /// # Examples
> > +    ///
> > +    /// ```
> > +    /// let mut v = KVec::new();
> > +    /// v.push(1, GFP_KERNEL);
> > +    /// v.push(2, GFP_KERNEL);
> 
> These function calls are fallible, but you are ignoring the errors.
> Please use the question mark operator.
> 
> Alice

Just sent v4 according to your comments.

Best,
Hui

