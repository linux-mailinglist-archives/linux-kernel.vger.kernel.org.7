Return-Path: <linux-kernel+bounces-760018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 962DCB1E5AB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 11:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 697F318C011C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 09:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C10126AA8F;
	Fri,  8 Aug 2025 09:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9usCQuk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0676C2AE74;
	Fri,  8 Aug 2025 09:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754645813; cv=none; b=grj+LuEVpEkD+JTCmEpcrdbiGLEBO2qcUpAinwaLV8Y9BQqpG+S9REpGeuW11FdZ9q4X0iWkOEsHZhiZQTsPdKrJNEGeGK6QgjE4KgBFnUt4r4rpzo1j8LFTXrGDwTEPpAT+quBIOxzTzeduUajSU9Z60MN0E4b3NyFxeb5/mOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754645813; c=relaxed/simple;
	bh=nkYfMtqkmchCRW26gGfc/31rsd8iTVwqWA+8uKAAyTM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IxRGmUzfhWUFzRuuisXA6/XpmrXwJK32ZDgZzNYwaY3GhVD7KGt8UJ6WV7VmIcoY0t+mvTjklAlfd0WthQMwdvJVs5piw7zGdlTvs2Vrn00QSg2yKPr1ABdh7RHc/KRpXSxJUlEWu0EZ9mBmVNt0BGMvItNLGL1fTRu0PePkrYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9usCQuk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CBAAC4CEED;
	Fri,  8 Aug 2025 09:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754645812;
	bh=nkYfMtqkmchCRW26gGfc/31rsd8iTVwqWA+8uKAAyTM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=G9usCQuk9f4pzDFzBmPHDL8b/4qo+g2P9dvOOv5ayL/j1th0MtZgPPkP7NQQ0R3t9
	 3gupCmrttmw/c+Qm9vawhBoDC9dXVySkdplYdfCJW0CHcHHOiYcjpLgcu+bjpQpjH4
	 H445eagdhHYVoO9DYaAZQFl+qvYmi7rZsvuksHY09dfXs6RGMRV2lCbkVGz/xed1bL
	 FkbT9RpAflA7MU+QtGFui8+J+KUJJES9fjud/+RRCmFYLMRq9vqc+lDDPFEiAsLE1V
	 l2jlxwWKxW/CaZEbeRNZlYJs5npDRtfU6C33Q/Tc0izEcBAc40EuYEyM+DAe8wrCbB
	 y9RBUmU2JX6QA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Benno Lossin <lossin@kernel.org>, Benno Lossin <lossin@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>,
 Fiona Behrens <me@kloenk.dev>, Christian Schrefl
 <chrisi.schrefl@gmail.com>
Cc: Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/13] rust: pin-init: add `zeroed()` &
 `Zeroable::zeroed()` functions
In-Reply-To: <20250523145125.523275-4-lossin@kernel.org>
References: <20250523145125.523275-1-lossin@kernel.org>
 <YQB28aSuStBXa5rR42ragT81sJsdvHv1g7oHQlBw4amdaPtRIczi3CYqYY6E1tumr63Ell5XB371DiuTZ6sU_w==@protonmail.internalid>
 <20250523145125.523275-4-lossin@kernel.org>
Date: Fri, 08 Aug 2025 11:31:48 +0200
Message-ID: <87pld65fcr.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Benno Lossin" <lossin@kernel.org> writes:

> `zeroed()` returns a zeroed out value of a sized type implementing
> `Zeroable`.
>
> The function is added as a free standing function, in addition to an
> associated function on `Zeroable`, because then it can be marked `const`
> (functions in traits can't be const at the moment).

Do you want to add a note on this in the code, so we can const the trait
function and let go of the other one if it becomes possible in the
future?

Best regards,
Andreas Hindborg



