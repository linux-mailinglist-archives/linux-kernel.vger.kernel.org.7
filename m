Return-Path: <linux-kernel+bounces-835004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F586BA6039
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 16:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0FB54C284E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Sep 2025 14:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988DC2E22AB;
	Sat, 27 Sep 2025 14:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pdu/Li2e"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DD32E22B4
	for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 14:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758981825; cv=none; b=lUZSXYupojwSi7l8f/h/uJjniXF21Fd+G5gkTZmsUB45THIvXdK9grvVMSLGszkw2X4+8bIEm0DLZqBiYGi0EZSJPy+sjhKHSrYazYuf8rWIz+IbUoo9dPSn0MZP5CT57dRGPftQ1YQ6bC3gjOu7HoI1ZxoHYjPOO00NB/EzSCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758981825; c=relaxed/simple;
	bh=iZIouQAWI0nC2znsT3y23S97+/Gt8E8XVf9A0+wMI68=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1K35VDNPQtSoe2jNdNdNRIb6xKIyw9T4yeUPUv7Fo+1q/+GzJl/rYJOpC7rgNwlvjXF+dFNFC+DfthpnUvkHsgDb0iOcEu6FBXS0yytbsVCS/BSfWurNdfjoY3gsfiR1hFsGnnNbTGVyDCu84/Ya6oZtz1rBL7sMJ+ekapd20c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pdu/Li2e; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-856328df6e1so309836785a.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Sep 2025 07:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758981823; x=1759586623; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1RowTgROwHl16yIt+/YH6L82gef48dxD9rHygNzwZv8=;
        b=Pdu/Li2ezlqIt8JEvn2C7/xnHjfuP5EauZ+eLkqElJ640trRwjvGJC1CCIzMjqxtzN
         HY0rVDTRJyJk54g9Jo4gJ4PxGkF9mcJPkl4xiZDcyO1etW7dKkFDqRSrtXLdQhxBo/QJ
         tobLP3y+/t6mW0Gzj3prUmkRNRRDa2OyahXtEcQajJ9NFHgDtb/vGluWBlJ+IZNuRsNS
         tc2fmZ3eYCixVIiSm9RC/0uW78S8NVvlKFveI5vfTmIzv8Z7RHzRbd3mjeVCKu+v7ye8
         619eyPg858tv0pX4f87gs040WA3ywmehsca8z+3/J1JbbHjn7Y4TJVXSmXsIxoqKHeMp
         YCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758981823; x=1759586623;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1RowTgROwHl16yIt+/YH6L82gef48dxD9rHygNzwZv8=;
        b=ZHUI5RdwVFSeZwn2TCst11OkfEAhUysbCrPMTRMxjfvjm3Ya1xLP2nYqYzegVFo7OL
         iXXXtY9H7WBLZEJ2D1374Xlif5uqONJxoyknFTobaQm7HbR+J6yMe/j6KIYlQew6GR4U
         v3udJueYLivy70Q285AelSYNCdHBdjNUF4b8VXoSxo8wsCSPPiPgaQmNfiGH43agUOP7
         sdA9c2byiyYwuOHTcAMhk5eqtSIE5uaB3crd7v6oEtmDVjTGFjUeciJ2O/1cTbmpd90L
         rM5q7dPew9gRtYAosS88vkAmeb3CR3ibYNcEMtlXkvVSOEokDMtrlHyh1/j1+xDMx7sY
         0nrQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbX7hOc0GETiwWMP2hg+ofJ5a7X6/Z3QF9mmnnAEvSItvmW0gr0v4LKNVHc9YGhYFFqJ4+QUxDE0vgUCM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy7NutSsCXV9MSAggPIVF88dcYlomTesKU/tlTiRmY7fkMu6aZ
	NUgZqb9qm103UieOA8MbJDsNiGs8VFt4NES1yx9/r7RStlWT24Su/faf
X-Gm-Gg: ASbGncvgh/Cq3+Sy44k8N+evqDpfJ5NLX8wMiOxGFxpOYX9Fxd7aThRpbmiF6OL+OAg
	rZdLmtfb3KCsiqGUiDdJJt6PylfEkIvPFrRUZqlVCE14xbTVO2UiFEJVKwrixGHvBzHuGGr9gQ+
	qb23glrtIUGQHOjGeq3Qu/4+LA5Pu86PFotCaz9cyZCrT7JSn2llLNNmi+pNBkDrpcsJQjQWp8W
	wPpkImeGNi20huXi+w5oMk+NK4fKFvbeN/LemmhQT6PoTVYsSqJ5MQeZD/yzRxA5triaoodsb2L
	1CU2oRQlhb9Vo3hS79A8Ha4Whc+lV+IWkoeEDt7TKLBxnlmlAcTPVzkR4YQLmrUvP+YlMQ2s+5V
	oJQiq34Z0FtI8JRUGoNBd2AhSoqDtJkxkfX2owpGYscfn8GUp+fVVqK6d+OesscwOBABfkrqpuB
	6b4IDqfDohf+SvlBvX9SMgw5k7ej/LlJ6k4QNXsDp8Luso
X-Google-Smtp-Source: AGHT+IEjsLJZDcVKW7VjD94SJTTQGuy7D2CuSP0XnP5QiF1Og6sVMZnEnghTHukI4UHYi90JuQhxLA==
X-Received: by 2002:a05:620a:2681:b0:862:79a9:eae9 with SMTP id af79cd13be357-86279a9ed9bmr629769085a.85.1758981821539;
        Sat, 27 Sep 2025 07:03:41 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-85c3218ed08sm441368585a.50.2025.09.27.07.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Sep 2025 07:03:41 -0700 (PDT)
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id 32CA4F40068;
	Sat, 27 Sep 2025 10:03:40 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Sat, 27 Sep 2025 10:03:40 -0400
X-ME-Sender: <xms:vO7XaOkakHRJvsqWLHFtsaCue-4lER0uhhpEdVDiyTQvM-clt7JAqA>
    <xme:vO7XaMowdZoBt1ZvjERssLFIFryVG6xQlckUYy7sujr3aDmGX-PYQHGF_hsK0c2Eo
    Uf2Ova8XFCQsgJX-tw5Pi7_C00N46SUWNM8sWlOBezUOL3bv9Px4g>
X-ME-Received: <xmr:vO7XaFnYgBEE1kaYfoB7fpYi3AmmkijMgLG346jOoVPulJcBdMp3lcmUy8uvHHgxYgCXjKLneOcKzE4rmXrE-KkgUEMVrpF5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejvdegfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekrodttddtjeenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeffleekfedutefhkefhheekhfelvdejgfegvdejjeffudelkedtffeiveejteet
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvgdpnhgspghrtghpthhtohepfeeipdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehmihhguhgvlhdrohhjvggurgdrshgrnhguohhnihhssehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepphhhrghsthgrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopeho
    jhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhr
    tghpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghpth
    htoheplhhoshhsihhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrrdhhihhnuggs
    ohhrgheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlihgtvghrhihhlhesghhooh
    hglhgvrdgtohhm
X-ME-Proxy: <xmx:vO7XaFbfSe5rN_-sdK1GxSVnOKVKQrMFGfq8HBxu5s7_wZIGPoqLrw>
    <xmx:vO7XaBHfE2uJGEmOZHTQaFl02_Nu9BhbWcr63y4RVIA07jBGfwUAgA>
    <xmx:vO7XaIOoeTYs7_ZW_lDvrSrb4vXqP73TEUrfIfWq1jCcuhcOx4YGkQ>
    <xmx:vO7XaHyutnwLGGZJM2FwjIsFy6LBiPy67EPfnCl-UBGlO2ywf0aDhQ>
    <xmx:vO7XaFn7RDDlFLjCS5q9t1KCy6953tiUDCyGEEqgOuXe_UslZGYeGqpK>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 27 Sep 2025 10:03:39 -0400 (EDT)
Date: Sat, 27 Sep 2025 07:03:38 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Philipp Stanner <phasta@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,	Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>,	Waiman Long <longman@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,	Justin Stitt <justinstitt@google.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Asahi Lina <lina+kernel@asahilina.net>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Krishna Ketan Rai <prafulrai522@gmail.com>,
	Lyude Paul <lyude@redhat.com>,	Mitchell Levy <levymitchell0@gmail.com>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev, dri-devel@lists.freedesktop.org
Subject: Re: [RFC PATCH] rust: sync: Add dma_fence abstractions
Message-ID: <aNfuulKIiLfjHRma@tardis.local>
References: <20250918123100.124738-2-phasta@kernel.org>
 <aNa7BDpKS2KA__4M@tardis.local>
 <CANiq72=6pGtKKr3XeZXLVrJTNMv7YbGzbezSUrZ7A43MJQLwJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72=6pGtKKr3XeZXLVrJTNMv7YbGzbezSUrZ7A43MJQLwJg@mail.gmail.com>

On Sat, Sep 27, 2025 at 02:14:22PM +0200, Miguel Ojeda wrote:
> On Fri, Sep 26, 2025 at 6:10 PM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > Thoughts? Miguel, Greg, Danilo and Lyude, any idea or suggestion?
> 
> Either way sounds OK.
> 
> More generally, one thing to consider nowadays is whether we will want
> something to eventually live in its own crate etc., but for this I
> don't think it applies and being in the `kernel` crate is fine.
> 

Being in the `kernel` crate is fine to me as well assuming dma-buf is
also in the `kernel` crate, but I think it's not fine to put it in
kernel::sync (see my reply to Philipp) as it is.

IMO, we have a few other issues of file hierarchy as well, so I'm trying
to avoid more.

For example:

- It may actually make more sense to revocable.rs in kernel::sync.
- device_id.rs and devres.rs may be better in kernel::device?
- maybe we should create a kernel::bus and put auxiliary.rs, faux.rs,
  pci.rs and platform.rs into it?
- cpumask.rs could be in kernel::cpu?

Regards,
Boqun

> By the way, should Gustavo and -media be Cc'd?
> 
> Thanks!
> 
> Cheers,
> Miguel

