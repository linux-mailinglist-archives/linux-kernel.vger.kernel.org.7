Return-Path: <linux-kernel+bounces-770708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55947B27E15
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 12:16:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FE9216FADE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 10:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB882FF16D;
	Fri, 15 Aug 2025 10:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwHTTOvU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1665A2FD7D6;
	Fri, 15 Aug 2025 10:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755252770; cv=none; b=PPoziPiJX0aARq0T3eAR695hQ/CcrtlwAnLURAyTkW/xiXvo3dCEQK/9QUDKJdFY20/rfw5gpbf7wyjXzezm716SFySJOBGJuTLOj56iZJI7hK7ccgC/VF1tMF7OdSd2EV2/fzND6qC5cLFWeJo8NeZTLZaacgRBBn0oXjio+mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755252770; c=relaxed/simple;
	bh=U6AVGw5ariZZSMxl2IiAStpx1ls9hsDC53C66pAWBxg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IK+S89WEW4cQ9ylVkIUXPbNPoOrokSnuGl1ptCDgDZJvuyLpHxj2gsDpMIjktHk4Vn08seTeoL6WYs1pPJPN3LRFA4BnhQqFCiwsYNNQhwpYXsuKlG2bXzTxfetDfNaKIxY5nXTQ5kYzfbHKF/f+/f0AqZkBCU+t2XNIcycRy94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwHTTOvU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20029C4CEEB;
	Fri, 15 Aug 2025 10:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755252769;
	bh=U6AVGw5ariZZSMxl2IiAStpx1ls9hsDC53C66pAWBxg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=bwHTTOvUrAXSDauxNWRB7voWcblsRNXkz++/LtGVEARiz6QQIVOYXXV1qPBCarPK3
	 t37nTEM/jMreYj/l8XjmjJceQ8bJoiIYVSKbE0KKqwrY9Wipolk8ByNyR6bdYwgVLA
	 ig22KP2hL/Rpdcq2VTW5kuPdUJMha49kWT1VJbJkzFALGpa7cRXyEhKqTjC9i6LCvQ
	 W1KeMQJ+YheRjly1OCqI0qvrkLZbBDFp56DzUyeJ81sCUj6906PCIZM4B9PSCGRL8n
	 dzAnB+nkuT1tntkWmk436hF+IklU40aivAkmTFwo/FxmInU4N/K3+QTl55ss/tSmWU
	 /v6YlTSWO90Kg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Oliver Mangold <oliver.mangold@pm.me>, Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Benno
 Lossin <lossin@kernel.org>, Asahi Lina <lina+kernel@asahilina.net>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Oliver
 Mangold <oliver.mangold@pm.me>
Subject: Re: [PATCH v11 0/4] New trait OwnableRefCounted for ARef<->Owned
 conversion.
In-Reply-To: <20250618-unique-ref-v11-0-49eadcdc0aa6@pm.me>
References: <OYpTDi4YYXiWvLG3nO_8_WKsgOl9KOpun9l3a34m0jza6nmEWDCLTldSwCfZ2PRRprjXqGmrgSL2JN8rPOQH8Q==@protonmail.internalid>
 <20250618-unique-ref-v11-0-49eadcdc0aa6@pm.me>
Date: Fri, 15 Aug 2025 12:12:40 +0200
Message-ID: <875xeoevvr.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Oliver,

"Oliver Mangold" <oliver.mangold@pm.me> writes:

> This allows to convert between ARef<T> and Owned<T> by
> implementing the new trait OwnedRefCounted.
>
> This way we will have a shared/unique reference counting scheme
> for types with built-in refcounts in analogy to Arc/UniqueArc.
>
> Signed-off-by: Oliver Mangold <oliver.mangold@pm.me>
> ---

In case it might save you some work, I rebased your series on v6.17-rc1:

https://github.com/metaspace/linux/commits/217c7ba3b95213abf9c1ce1a98ca496a48401f10


Best regards,
Andreas Hindborg




