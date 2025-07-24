Return-Path: <linux-kernel+bounces-743753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16FF0B102DA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 10:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F1117B9615
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jul 2025 08:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FBD26F45D;
	Thu, 24 Jul 2025 08:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZjkI5Loe"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684FE223327
	for <linux-kernel@vger.kernel.org>; Thu, 24 Jul 2025 08:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753344401; cv=none; b=gvTmwpTStEX625BthjGy67AtdvSweaEgn9vp7xgq/skhzAVHbavbTyduStiItbBEvXtXrTF5gF1mZMfmor2itk0XnFiU48hJMur6DzkfqjK+HTVs6ywGRBF/Kiu2b4FR6a3EEZTk39bqJoc9rWjUBWKhrEHN7tShZLGuE8Dwsmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753344401; c=relaxed/simple;
	bh=PNwT/8zDWcuVBAHKnP5js2HoP+0ShQO7JHv+8inHsIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXimfwXKaf4LT15Xi1nxfAxrgLJyYookYRHCSKBC3+3KqzIMYCyshkDwpOy8PXH3OISCVPSt6dAxqG9BCLxT9k6IrxV+GyqBy80DGbg6MHutRnrc6IzFL0iN8bboCE4SWw2wxWN35ObEh34RoC8TxhdfLU7YimuBHIoJ+s572Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZjkI5Loe; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 24 Jul 2025 16:06:03 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753344396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lj4FB2FyquD4iJUJMuRwd+hUUVbBfQpKLuMnnFCzouo=;
	b=ZjkI5LoehTRNiNCMF1r9FRCRUnUaGEkWGIqeJSxMfgAt/Y+qbHXuywtfu3YNE7iSolBY+w
	pGuRNnSeAsyLccEezhWG0m/Lo7lMVR0DlDc9YF4gT9bDoaXQkoXcPp4asup4XM2lUSv6xX
	1uAbPPfe1FukcshTzIOYV3NE2RwtPnA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hui Zhu <hui.zhu@linux.dev>
To: Boqun Feng <boqun.feng@gmail.com>, Danilo Krummrich <dakr@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	bjorn3_gh@protonmail.com, Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Hui Zhu <zhuhui@kylinos.cn>, Geliang Tang <geliang@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Uladzislau Rezki <urezki@gmail.com>
Subject: Re: [PATCH v2] rust: add a sample alloc usage
Message-ID: <aIHpayMmbIqpyuig@teawaterdeMacBook-Pro.local>
References: <20250717095053.49239-1-hui.zhu@linux.dev>
 <DBEAFCFHFU35.1IZI3ZSJSIRAY@kernel.org>
 <aHkhVwD7WKm1dSsa@Mac.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHkhVwD7WKm1dSsa@Mac.home>
X-Migadu-Flow: FLOW_OUT

Hi Danilo and Boqun,

On Thu, Jul 17, 2025 at 09:14:15AM -0700, Boqun Feng wrote:
> On Thu, Jul 17, 2025 at 01:19:05PM +0200, Danilo Krummrich wrote:
> > (Cc: Lorenzo, Vlastimil, Liam, Uladzislau)
> > 
> > On Thu Jul 17, 2025 at 11:50 AM CEST, Hui Zhu wrote:
> > > diff --git a/samples/rust/Makefile b/samples/rust/Makefile
> > > index bd2faad63b4f..7c3e68d9ada5 100644
> > > --- a/samples/rust/Makefile
> > > +++ b/samples/rust/Makefile
> > > @@ -10,6 +10,7 @@ obj-$(CONFIG_SAMPLE_RUST_DRIVER_PLATFORM)	+= rust_driver_platform.o
> > >  obj-$(CONFIG_SAMPLE_RUST_DRIVER_FAUX)		+= rust_driver_faux.o
> > >  obj-$(CONFIG_SAMPLE_RUST_DRIVER_AUXILIARY)	+= rust_driver_auxiliary.o
> > >  obj-$(CONFIG_SAMPLE_RUST_CONFIGFS)		+= rust_configfs.o
> > > +obj-$(CONFIG_SAMPLE_RUST_ALLOC)		+= rust_alloc.o
> > 
> > I think adding an example for large alignment is fine, but let's do this in a
> > doc-test on VBox in rust/kernel/alloc/kbox.rs. I think adding a separate module
> 
> I would suggest using #[kunit_tests(..)], which is similar to how
> doc-test run, for it if we only use it for test purposes.
> 
> Regards,
> Boqun
> 
> > for this is overkill.
> > 
> > Note that doc-tests are executed on boot if CONFIG_RUST_KERNEL_DOCTESTS=y.
> > 
> [...]

I sent version v3 that move vbox code to allocator as unit tests and add
move kvec::as_slice to doc example.

Best,
Hui


