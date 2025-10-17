Return-Path: <linux-kernel+bounces-858236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 28F0FBE959F
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 16:55:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 69548505F6E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Oct 2025 14:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243B02F12AD;
	Fri, 17 Oct 2025 14:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wdw9mwo+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7825B33710B;
	Fri, 17 Oct 2025 14:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760712794; cv=none; b=QjUQOZK1Dz93uBt5Tx3IARna89qGsj+Gmz2CgwGskaPZh9bNMMXIIAK5F2VO0dgo7/wPDEbhv0yO70Ja/IcWEaaU8lgwl19/908KeQFiLrJbaS/pyK0KVLxI0ZfQThVVCkeJmasnMBFCIiXVuzkCa3GFaXOHZ375a0JK7ZXLmss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760712794; c=relaxed/simple;
	bh=KKMA6xL8eUMuPpKnoZOnT2r3qIED5LERfUjbuLajSKc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=eOCZGLUTnF1rSn+diKU6y/151TfzmUcnJs8EHVmRRdKlfD3cGMClWxf8vcPp7sjQWVOEW6tWz9SxRCpYUQXAMR8tYRSKI65fL9xLNEjeOoU2DnpkL1SLCqeKOkbVw0RC5KBwzU5AkrXNTN6Rmjq7IBIkcnK6XQS56we4wMWql80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wdw9mwo+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50FFFC4CEE7;
	Fri, 17 Oct 2025 14:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760712794;
	bh=KKMA6xL8eUMuPpKnoZOnT2r3qIED5LERfUjbuLajSKc=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=Wdw9mwo+AlSuQihG28tFNJoBNE8j6lByk9rz0V7IEgvfXck5RbDI9MRYTJiKr1cQn
	 EyAvAz9VfCWem9wKnmTn8JvgYhqTBwGm7snCAcUx9FFImQAEov0uLUUuh5k2UzE3ZW
	 nUIXTLHs8Ie0eTB0TQEH2siD25v/3sbGvl7yxKAs7xKFJsy1mxWmXulxj6Vv9QZ7Zs
	 meqLKF369/6xRZfsPru3juYEiXg1XvSsWs6oUvd9oLMqjNclVWg1wyJtfFrvCELfc5
	 DeNLs5WoRw3Tbpz0uun09fNcu3y648ACBZX9p9FJIxiwXdOiyhZghTtTgZoIPbMooQ
	 Kdhtor7O22HsQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 17 Oct 2025 16:53:09 +0200
Message-Id: <DDKOLD1897SY.84W93E6L8ITR@kernel.org>
Subject: Re: [PATCH 3/7] rust: debugfs: support for binary large objects
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <mmaurer@google.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251003222729.322059-1-dakr@kernel.org>
 <20251003222729.322059-4-dakr@kernel.org> <aPI9tNoh0I3KGDjl@google.com>
 <DDKO9M4P06HS.3UMGG3QR7BX67@kernel.org>
In-Reply-To: <DDKO9M4P06HS.3UMGG3QR7BX67@kernel.org>

On Fri Oct 17, 2025 at 4:37 PM CEST, Danilo Krummrich wrote:
> The reason I went with a trait is because that's consistent within the fi=
le.
>
> Otherwise, I don't mind one or the other. If we always want to use a stru=
ct, I'm
> fine with that. :)

Actually, there's another reason I forgot about since I sent the series. :)

We need it because we derive it from blanket implementations:

	impl<T: BinaryWriter + Sync> BinaryReadFile<T> for T
	impl<T: BinaryReader + Sync> BinaryWriteFile<T> for T
	impl<T: BinaryWriter + BinaryReader + Sync> BinaryReadWriteFile<T> for T

