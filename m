Return-Path: <linux-kernel+bounces-593933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B77A80936
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 14:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBA551BA5434
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Apr 2025 12:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CBC26773A;
	Tue,  8 Apr 2025 12:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3Pnco3M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC23B663;
	Tue,  8 Apr 2025 12:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744116042; cv=none; b=ppwZVOin+M9PwYL77/KD1ti01mbtdOSDrZVTYPn/J0Mc9gKcynA/Msi9PxrAzW8hepZrfQ4C0w3HfDKj/Mr/wGdefKnqciuaHs618SMCTt4X1pmTdZ+voeYPvdzdLtGb6Nmpl0vlgbvje/vx6gdVG0FSETDNwaeGn9+xQRB/OHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744116042; c=relaxed/simple;
	bh=AFsQveeqJu+5jnHeMu4ceq/aSVjGBPhAzXus6G8eXkc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XJpbQ4qlXGa53X+brQXoVVQ3PAqw7KDdjOut+uss2tujcEik6QEGvHOWrv3NgNadKf5aFTgksybpeRiUrrsKjG/0AyCovEG+/ZSG64sIoaOSHewTLPxIVRhR0OvwNju09LS1+rpSXZ1Y+mzFLt9e60JbXujzdPO1/pMQwwH5oH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3Pnco3M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C61C4CEE5;
	Tue,  8 Apr 2025 12:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744116042;
	bh=AFsQveeqJu+5jnHeMu4ceq/aSVjGBPhAzXus6G8eXkc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=D3Pnco3MterODOTkJUlIjXcA6IVXFpmhck3NuEf2IC6MEG3gLyrEXJqY91c12Vgza
	 kJSITMmIUMMMPUaPey8f+RIuBFc34ZfgHjrkcyMx2TA2WCXOjGa6rKeGoW/zm+EcgV
	 WfruGQ3G5Hkz0fvoMUe2V/uLRbot4kgphDICwctj581OsxOlqcaJ0yowY7hoNFMHv2
	 AC5a80BT59CwdiCUsU7XtXRNyahmVWZ+dqL/gFFMxeU6hGGyMUAcGV6oWFoSdu90Jr
	 bjfcx9XpRiu8fH2uyhAtAxkTouxiYeb7t8rSRbRD91luX1bK8mN9DW31j68yvV8+Ri
	 kn6i03D4ZHLjw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Abdiel Janulgue" <abdiel.janulgue@gmail.com>
Cc: <ojeda@kernel.org>,  "Danilo Krummrich" <dakr@kernel.org>,  "Daniel
 Almeida" <daniel.almeida@collabora.com>,  "Robin Murphy"
 <robin.murphy@arm.com>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun
 Feng" <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,
  =?utf-8?Q?Bj=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>,  "Benno Lossin"
 <benno.lossin@proton.me>,  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor
 Gross" <tmgross@umich.edu>,  <rust-for-linux@vger.kernel.org>,  "Marek
 Szyprowski" <m.szyprowski@samsung.com>,  <iommu@lists.linux.dev>,
  <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] rust: dma: convert the read/write macros to return
 Result
In-Reply-To: <20250326201230.3193329-3-abdiel.janulgue@gmail.com> (Abdiel
	Janulgue's message of "Wed, 26 Mar 2025 22:11:43 +0200")
References: <20250326201230.3193329-1-abdiel.janulgue@gmail.com>
	<FAHXf-DZiKKDg4co6oECBpNbo9t3eTpIaDJP0KvrI8bVc91uazjibC9BZgXQPMtqdsaWOlz5Qpp9Um-z2sFOPw==@protonmail.internalid>
	<20250326201230.3193329-3-abdiel.janulgue@gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 08 Apr 2025 14:29:30 +0200
Message-ID: <87r022hm51.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Abdiel Janulgue" <abdiel.janulgue@gmail.com> writes:

> As suggested by Andreas Hindborg, we could do better here by
> having the macros return `Result`, so that we don't have to wrap
> these calls in a closure for validation which is confusing.
>
> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>


Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



