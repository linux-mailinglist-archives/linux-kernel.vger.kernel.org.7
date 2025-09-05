Return-Path: <linux-kernel+bounces-803563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E956B46264
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 20:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A249CB652ED
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Sep 2025 18:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88D8274B50;
	Fri,  5 Sep 2025 18:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDgCRkEJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0743017F4F6;
	Fri,  5 Sep 2025 18:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757097496; cv=none; b=MyTtLGwvsOfzCnCrHj3V/6OPPah47SkXjhWeRqKWQNjwEP5FwGep9rU21BH2bjx4nWMY4QExjIhihyY4nrzXQEwgi6SzmciSY4gwU21ls3EKEs/lmHiEXZQjRhDaiNAX4pfYQA9WtoNOB/eslOPDvfuBS/7up4Tq9idN3bdTunI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757097496; c=relaxed/simple;
	bh=yRMl6rKGMmDa8v1ekwAN3qQizqieb3T/4q2oJ3kuFM8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=dFgFbNa2PxicTaS9bi30fk2mg4ypgqRNe9RDPH7zTciREz5y00ff3dJKZhy65VBL1NNpTr6NGei8b8HyAomazqkxEF2/DZgRzm1W+NbbogdCLVhgFltuGesrus5F3NGofISiev5hzg7spW4YzUr2hqsoWpcry2OAvlrzYua8SAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDgCRkEJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D040BC4CEF1;
	Fri,  5 Sep 2025 18:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757097495;
	bh=yRMl6rKGMmDa8v1ekwAN3qQizqieb3T/4q2oJ3kuFM8=;
	h=Date:Cc:To:From:Subject:References:In-Reply-To:From;
	b=SDgCRkEJJiDM2hdbgIYxVJ6R2+7agEaMNR8FlKgT6J6FbpOF7kuHAhLYa2hVjiRyo
	 gIxiTd7FjEBI1hGyCzYwqNcZC58PPWPugAVrhbAFqeva0+NQZu8lreKISrUHRgd+l8
	 U+RDPHF3oVlyIdohb4Jf339+uf6WH95/VIe55RIYrvG1NMam1WD6JF+5k4Woo+BTcK
	 n17KIHzh+qehZaLGlA8ccY1nmRJFIpbzNynPXZzzsgsMTq+cWSg9lYw2t1fESwqu6H
	 eeLqH//dCPO1LOlM2FhNLaVUt4ea/26HJjbbK40wWBO/Sy1K+5DKTed6pozLQHQz6J
	 AzU6+M1/ZvTqQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 05 Sep 2025 20:38:11 +0200
Message-Id: <DCL32RUQ6Z56.1ERY7JBK6O1J6@kernel.org>
Cc: "Benno Lossin" <lossin@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Alex Gaynor" <alex.gaynor@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Fiona Behrens" <me@kloenk.dev>, "Alban
 Kurti" <kurti@invicto.ai>, "Alexandre Courbot" <acourbot@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] rust: pin-init: add references to previously
 initialized fields
References: <20250905140047.3325945-1-lossin@kernel.org>
 <aLscLsY0Sv1Qwgni@tardis-2.local>
In-Reply-To: <aLscLsY0Sv1Qwgni@tardis-2.local>

(Cc: Alex)

On Fri Sep 5, 2025 at 7:21 PM CEST, Boqun Feng wrote:
> On Fri, Sep 05, 2025 at 04:00:46PM +0200, Benno Lossin wrote:
>> After initializing a field in an initializer macro, create a variable
>> holding a reference that points at that field. The type is either
>> `Pin<&mut T>` or `&mut T` depending on the field's structural pinning
>> kind.
>>=20
>
> It's hard to review because of lack of examples. Could you or Danilo
> share some sample usages? Thanks!

Sure, here's an example. Eventually, it's going to be a bit more complicate=
d,
but basically that's it.

	#[pin_data(PinnedDrop)]
	pub(crate) struct Gpu {
	    spec: Spec,
	    bar: Arc<Devres<Bar0>>,
	    sysmem_flush: SysmemFlush,
	    gsp_falcon: Falcon<Gsp>,
	    sec2_falcon: Falcon<Sec2>,
	    #[pin]
	    gsp: Gsp,
	}

	impl Gpu {
	    pub(crate) fn new(
	        dev: &Device<Bound>,
	        bar: Arc<Devres<Bar0>>,
	    ) -> impl PinInit<Self, Error> + '_ {
	        try_pin_init(Self {
	            bar,
	            spec: Spec::new(bar.access(dev)?)?,
	            gsp_falcon: Falcon::<Gsp>::new(dev, spec.chipset)?,
	            sec2_falcon: Falcon::<Sec2>::new(dev, spec.chipset)?,
	            sysmem_flush: SysmemFlush::register(dev, bar.access(dev)?, spe=
c.chipset)?
	            gsp <- Gsp::new(gsp_falcon, sec2_falcon, sysmem_flush)?,
	        })
	    }
	}

Imagine how much unsafe pointer mess this needs without this patch. :)

