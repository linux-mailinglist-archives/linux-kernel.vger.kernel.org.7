Return-Path: <linux-kernel+bounces-787095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EA6BB37160
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 19:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44CE31BC024C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Aug 2025 17:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0386330ACEA;
	Tue, 26 Aug 2025 17:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dVe48VXW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C94B1FECAB;
	Tue, 26 Aug 2025 17:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756229637; cv=none; b=D5teh+FVyVSseJT5HAJ31od0/CXhA90loXSMgfNdD3hjuaDxzbAyl8DYubbVigErp/5f06Jwf51M0Ghs1YOqAelxbELJF3ZSbKJG7KxUGhUa0nWGBzznlgkD2n49/2wHgS1P1CU0PAJ0M2OL3TdlbIILXdjjCHV+M1/H8qS6nNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756229637; c=relaxed/simple;
	bh=set+UrL846DMXk1AZBQ1WxbxGenls/IbLNhWKN1zPXw=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=Yx6nRUkniyvga5SNR87Tww39A9bCsF9VNhxyD7KCcUc5d0syYb5Qv/l1vzoV/MZmPZta3BrPVPyh/54GVCnJ4BETjN+rwyOrCHBTqVuWQj5sUb3IGVLqiA8GqXqI1SjCZx+R7NxvIelSfZGJHKjRi0XXzj1qk/xGBzDfV6Bu0wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dVe48VXW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CAEBC4CEF1;
	Tue, 26 Aug 2025 17:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756229636;
	bh=set+UrL846DMXk1AZBQ1WxbxGenls/IbLNhWKN1zPXw=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=dVe48VXWWQgERNS0xbyNcosZ3AtJcMiPJSWYDnEZ1ZKnt9bLIhNHQDrOyrTteE8PX
	 lIthowePyi8pJCLA/gV1S2By+SVsV5SEzMVrlzv+v05U1hLdQuz7ObCO/i12ld7/22
	 w1nObEevj2M7a71JtJdFJtnXTpT2xGZzzBil2cJy4YleDiD8evoAHO1CJUiXdNithR
	 aDESst+om4NAJrIJhwxk4Q/71IA7Qt8mkhCzC1S2unl92MKC1wiXpJUEjUpFYdqGdI
	 as+uNf8VQyd7CpW38mgSIjbutFtgA1v359mcjYzcT157H52n5p1UarN/eCWyh70Y4P
	 mEs14YpEFB9Qw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 26 Aug 2025 19:33:49 +0200
Message-Id: <DCCJG1V40J97.1FQA6ZV5JE6RK@kernel.org>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3 2/5] rust: dma: add type alias for
 bindings::dma_addr_t
Cc: <akpm@linux-foundation.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <abdiel.janulgue@gmail.com>,
 <acourbot@nvidia.com>, <jgg@ziepe.ca>, <lyude@redhat.com>,
 <robin.murphy@arm.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
References: <20250825132539.122412-1-dakr@kernel.org>
 <20250825132539.122412-3-dakr@kernel.org>
 <CE0E1F73-69CE-4629-979E-9AE5B6AB055E@collabora.com>
In-Reply-To: <CE0E1F73-69CE-4629-979E-9AE5B6AB055E@collabora.com>

On Tue Aug 26, 2025 at 7:15 PM CEST, Daniel Almeida wrote:
> Hmm, I wonder if this shouldn=E2=80=99t be its own type, instead of an al=
ias. This
> will be handy if we want to enforce that a given address is, in fact, a b=
us
> address.

I'm not sure I understand the idea. How can a new type compared to a type a=
lias
help to guarantee that a DMA address is also a bus address?

This depends on whether there is an IOMMU, etc.

> In any case, this can be a separate patch. This one is good.
>
>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>


