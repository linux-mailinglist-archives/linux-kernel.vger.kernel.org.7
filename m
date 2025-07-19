Return-Path: <linux-kernel+bounces-737820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EED28B0B0F0
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 18:41:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB3F317DF34
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jul 2025 16:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D60B288532;
	Sat, 19 Jul 2025 16:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="ijz1yxkx"
Received: from forward500d.mail.yandex.net (forward500d.mail.yandex.net [178.154.239.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5023FE4;
	Sat, 19 Jul 2025 16:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752943284; cv=none; b=FR/ng0yF+Q2fhjX6cM4tzK6U3MmfZscRkqN5/ZnSZpun7YbIInHDwIytq6Y4bCCqhkkQx+aiOtajlj/qe1sq+/VIvjTLJRCjrM0jAAGUv5Yck5gEqXT9mQjlHZ1L3PWj6+onkpfl2UaXXknOyMvVD0gOUHsLNg24HBOdThDCI9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752943284; c=relaxed/simple;
	bh=59ocjmmejqq8NswP8t3X5LfiE3ug0zI3+t/C3qJM1Lg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VMKLV67H4vPBTM1vLFcbzByQtU3mG1Qa29dkuwXOi9fAbROi0tecYNfRFsZSNgIRDAN4YoOTTtrWm63grZV5JpsIW2wEQ3XedQRzed+5zD2xeQ8qur3c8MJ2rcZq+xJ/vHFNW3LLI34GGrpmgrU1bIF5/SfakgjMRYBh0d4jZtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=ijz1yxkx; arc=none smtp.client-ip=178.154.239.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net [IPv6:2a02:6b8:c43:152c:0:640:d236:0])
	by forward500d.mail.yandex.net (Yandex) with ESMTPS id 57C1D82BD2;
	Sat, 19 Jul 2025 19:33:46 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id eXSWZaoLrCg0-kvnHepGJ;
	Sat, 19 Jul 2025 19:33:44 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1752942824;
	bh=6oQHYLnEFQgp6/Ee3TU8iu86sgdYuBvdkrlkyS0Beiw=;
	h=Cc:Message-ID:Subject:Date:References:To:From:In-Reply-To;
	b=ijz1yxkxdPHL9pX2v7Gws9E82P+aO8FLEWlS8UnfswCyaCEJQoOnfrxzIn2ilMZxa
	 JNPtmRj7afE55FeAoH9um+sTBjyQKctiEZ/jmCIiy0QFiPuFvkpP+94apJGTEBL3jn
	 0il/aoF+EPL5NBqOIrW2DdmhdF+kA34yFi6/Uig0=
Authentication-Results: mail-nwsmtp-smtp-production-main-80.klg.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
Date: Sat, 19 Jul 2025 19:33:39 +0300
From: Onur <work@onurozkan.dev>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, jens.korinth@tuta.io, Jens
 Korinth via B4 Relay <devnull+jens.korinth.tuta.io@kernel.org>, Miguel
 Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo
 <gary@garyguo.net>, =?UTF-8?B?QmrDtnJu?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Rust For Linux
 <rust-for-linux@vger.kernel.org>, FUJITA Tomonori
 <fujita.tomonori@gmail.com>, Dirk Behme <dirk.behme@gmail.com>, Linux
 Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/3] rust: Add pr_*_once macros134
Message-ID: <20250719193339.090eca3d@nimda.home>
In-Reply-To: <aHsSAaLDjp8TTXAw@Mac.home>
References: <20241126-pr_once_macros-v4-0-410b8ca9643e@tuta.io>
	<87zfish69f.fsf@kernel.org>
	<XyUDgEm-do6Hd7zeR0J2gte301dYC_LTbQqJ85HUnf0DKGZoH4V9G9dgvmEw4fEadnu8CAZ4j4XWqLdn2YzkAw==@protonmail.internalid>
	<OIpcOXB--F-9@tuta.io>
	<87o6z8h4im.fsf@kernel.org>
	<20250717190713.1f19043e@nimda.home>
	<aHsSAaLDjp8TTXAw@Mac.home>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-unknown-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Jul 2025 20:33:21 -0700
Boqun Feng <boqun.feng@gmail.com> wrote:

> > 
> > I have reviewed the patch series from start to finish. I am not
> > using or depending the patch actively but I can send v5 sometime
> > soon (I will have some space next week) if you would like.
> > 
> 
> Note that you need to use LKMM atomics [1], and you should really use
> a 32bit atomic at the beginning. Thanks!
> 
> There are a few explanations on why we want to avoid use Rust native
> atomics:
> 
> 	https://lwn.net/Articles/993785/
> 	https://lore.kernel.org/rust-for-linux/CAHk-=whkQk=zq5XiMcaU3xj4v69+jyoP-y6Sywhq-TvxSSvfEA@mail.gmail.com/
> 


These are excellent sources for digging into the details.
Thanks a lot! :)

Regards,
Onur

