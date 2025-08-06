Return-Path: <linux-kernel+bounces-757272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECCDEB1C01F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 07:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53E733A2682
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 05:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B67B1FDA9E;
	Wed,  6 Aug 2025 05:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="aPo0UqtU"
Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C36171C9
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 05:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754459808; cv=none; b=FXrPE238clNJwxAGhRIhiwYnp2W0JYWBlHolk4WXk4s5Hf2I73AXtq2a2JeH6u8btDFmS04vluH7k+6nxODn9I2U345DAL8zgGC/23+bOjBuTbJ6AWm9L13wYszpbqauCemOTGFOnMHKS1w7OEBeJV5S0vlHGIAu4U1PT5LsG6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754459808; c=relaxed/simple;
	bh=Wq18DcZ4T3FgD3owtAsL5t1BZwFY/y8Ifdw12QC6K20=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sqpsrHIzeJSNWoqI9Rvb8D2skCMUjlBWvfxD0QtVdeoG+Mpk5e7VSycxGpS7XYBH2GBdDayLGLbDgipPJ8ECJrDzkZgHGQaZHu85AHfYGMUH/kDjfuz9/fnqgFYUnJBwi1YtE2m5AqEAZhtKPwXx9nXqkmvE7eZcCzvHt8X01gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=aPo0UqtU; arc=none smtp.client-ip=79.135.106.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1754459798; x=1754718998;
	bh=Wq18DcZ4T3FgD3owtAsL5t1BZwFY/y8Ifdw12QC6K20=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=aPo0UqtU+UAffpKO9J534/omsqrcfG/jKPMQUKuaohh758LZ8T6dkKWnJgRSZ9WxC
	 UJlWh8jBugtfz5CJbzb4ZrtfsoOZDx+I1nJ0LLlg4n9QHjjpfzDRFeRxYHHtdd0N+S
	 vLpqU9NJTtAATLVfaH/Hz1xaURExuVwDuCsL8XUxmR+zm4e6lncEHRDuM2UYQwuUqK
	 mjDsjciFCk3nzB+j8FqkngCn0DFzmfjewJJTrgVUZrKkusnYh6pfcdyvN6JwNuDl7h
	 dzPo2r2FCWInctOn//teZJmjn5OSpQkLxkF917syhutx0Cg3Ie8o5Hkc/Fb+hUOorB
	 8PTG8BtLt2S/Q==
Date: Wed, 06 Aug 2025 05:56:34 +0000
To: Danilo Krummrich <kernel@dakr.org>
From: Oliver Mangold <oliver.mangold@pm.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Benno Lossin <lossin@kernel.org>, Asahi Lina <lina+kernel@asahilina.net>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 0/4] New trait OwnableRefCounted for ARef<->Owned conversion.
Message-ID: <aJLujhnHgWhR-JyZ@mango>
In-Reply-To: <b7a7f917-9c22-4971-b9e0-6bc0d674b139@dakr.org>
References: <20250618-unique-ref-v11-0-49eadcdc0aa6@pm.me> <b7a7f917-9c22-4971-b9e0-6bc0d674b139@dakr.org>
Feedback-ID: 31808448:user:proton
X-Pm-Message-ID: 54a919aea5b1782a89dec3c103aaac52fb96b272
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 250805 1923, Danilo Krummrich wrote:
> On 6/18/25 2:27 PM, Oliver Mangold wrote:
> > This allows to convert between ARef<T> and Owned<T> by
> > implementing the new trait OwnedRefCounted.
>=20
> Thanks for working on this!
>=20
> Please make sure to use scripts/get_maintainer.pl in order to make sure t=
o send
> your series to all relevant maintainers and reviewers. I think you forgot=
 some
> of them.

Okay. Sorry, I will make sure for the next revision.


