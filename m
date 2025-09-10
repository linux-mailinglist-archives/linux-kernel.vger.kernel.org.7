Return-Path: <linux-kernel+bounces-809969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D50B51420
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 12:36:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BF0317AD4BD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Sep 2025 10:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0A62652AC;
	Wed, 10 Sep 2025 10:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3S0ICof"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6532550CA;
	Wed, 10 Sep 2025 10:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757500559; cv=none; b=ILLaIagGojydqdjJNv6ry3zJPkNxQKZWSnVxQzs3OJwOHaBVOAL5sJ+s4qwyNpWfT3WKi4TwzzTDZx1b5kZJF88ItjOAF06CWaNgVvYpuL1RLNb6XZUQqbUNcQ4Gs48T4aIXFH6NrJ86OVrg02iz8Rbd+IENSx1LRR/Nzj9/gXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757500559; c=relaxed/simple;
	bh=O99jgoyXrigkg/dbUEzGAlU+fprC6Vj5D5ti+/fLI7s=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=VCnGbqjg13O9OlQgZy2dMck+7udIl/ZpjPCGnZe/HMCU6A9fZnevUstSIhbI1hLDeVu48rOrPr/bdLIUEgTotLAC/WCY7g/Rjaaq1G1JVrQEhNJ5AqmONNNEgZQA94Uv1KSOviszfHDrywAWgOvH4inIJFpWAb746Hho8AoV9F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3S0ICof; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4010CC4CEF0;
	Wed, 10 Sep 2025 10:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757500559;
	bh=O99jgoyXrigkg/dbUEzGAlU+fprC6Vj5D5ti+/fLI7s=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=l3S0ICofL+SEGH8DdDhipX9f1OYJeBXKaypVbwLvc8Au+irpdC0LC5VJyMHSlIB9O
	 T5AUTNZGGHMwkaN6n3npL772E6kPufkHeAMEROsXomwfcNZnHEgIAOjqIoi+qUDO5a
	 TOmSQ+2WMXTltmEX+7LvIhxrsv/otFOIjAyIaJk7PhmHumykg0Oh5NLLlW48WbY6xJ
	 K8V0pdgYhtrPM8KVPaUkPprHYKmpI6Kn3vaopuw1IYCu8+nFXlB0QLMZGTOZB8JGAi
	 l9N2CKPn1AqtQDP1XKiSXiUe9KxYBik7YvNaofgHOHcyEJPh3avdVEI8GY1INXD8aQ
	 yAdO6DKyvdDgA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Sep 2025 12:35:54 +0200
Message-Id: <DCP1Y8N4SRRF.25V7F6PV5ODCQ@kernel.org>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Fiona Behrens" <me@kloenk.dev>, "Alban Kurti" <kurti@invicto.ai>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] rust: pin-init: add `#[bind]` attribute to access
 previously initialized fields
From: "Benno Lossin" <lossin@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
X-Mailer: aerc 0.20.1
References: <20250910100755.2361281-1-lossin@kernel.org>
 <aMFQL-Hq1KvBG5lh@google.com>
In-Reply-To: <aMFQL-Hq1KvBG5lh@google.com>

On Wed Sep 10, 2025 at 12:17 PM CEST, Alice Ryhl wrote:
> On Wed, Sep 10, 2025 at 12:07:53PM +0200, Benno Lossin wrote:
>> Assigning a field a value in an initializer macro can be marked with the
>> `#[bind]` attribute. Doing so creates a `let` binding with the same
>> name. This `let` binding has the type `Pin<&mut T>` if the field is
>> structurally pinned or `&mut T` otherwise (where `T` is the type of the
>> field).
>>=20
>> Signed-off-by: Benno Lossin <lossin@kernel.org>
>
> Is there a reason we can't apply this to all fields and avoid the
> attribute?

Adding the attribute was due to Boqun's concern on v1 [1]. I think it
might be surprising too, but I'm also happy with no attribute.

[1]: https://lore.kernel.org/all/aLshd0_C-1rh3FAg@tardis-2.local

> Do we have a place that might be able to use this?

I didn't find one, but Danilo plans to base some changes on top this
cycle that need this.

---
Cheers,
Benno

