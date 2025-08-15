Return-Path: <linux-kernel+bounces-770443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C78B27AC1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 10:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 131475E8834
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Aug 2025 08:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9E92459FA;
	Fri, 15 Aug 2025 08:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dsC81QYL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AFF241103;
	Fri, 15 Aug 2025 08:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755245893; cv=none; b=ORFjvbOAn1HP3tS6nk/vtTLq5pVpTNgT3Y1nevsHzQcvIYoizlzeAmvRbxRCFn2u0AgKjEHmKX//9pxdiLJyTdEYkpbc6WIc6NJ4+kXNAgF41O5Y+RGCnfUVPtidOeXjPnMEDJaHhrjM/Q1l97Q3Io4qhohX62GQa2+1wC7kK78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755245893; c=relaxed/simple;
	bh=zcUsgqtwck0vJoyHH7aREYeOs6qKr1S6WoXjnCNIOGE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ODgPI9XIUTtTQREkxMKfUaLlGj6X6aBgjUDwpoFqywlasd6DYs9/d6hnowAJ09wIic40o1IjttAvBSwHQLJELv31Qh7TQLnAz0ZNxs9utlNRinFBqtKrskCyk8MsX48Of0y4Es57lzlfIZN5U6hUHSucxH7j63Zy9/uN2R4ETIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dsC81QYL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86FF6C4CEF4;
	Fri, 15 Aug 2025 08:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755245893;
	bh=zcUsgqtwck0vJoyHH7aREYeOs6qKr1S6WoXjnCNIOGE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=dsC81QYL0ftqjtmTLFFRkAED0Y+GmWSPJ2nPhHV+7xxDW6VQnY+05rakk3HGwauOT
	 NM309QXfYjI0H/MT9PslfYMjmONfGVrNjLUe4RSngeiGZbi1Hcowt6+PDf/Vmwpd/X
	 l1JgyxsGsjJkkxqk/mMgEifjaHv1T0aD0SUDqoCjbbOcffVhqcpQdRhlZhyx+mif3v
	 VWUyrKSf8Rn+RDjnX/n3J6C2Asc4Fo/g6fzfPsgW7ye6yg5PI2nZWji7WxbBnlboVx
	 jeGjmQaHkuIedOE4klFSn/LmcUwK6X8T+CcW4L/ohW6hEecH+0cSug3mD/ugK1lDTG
	 bU4VcbGCoOuow==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, FUJITA
 Tomonori <fujita.tomonori@gmail.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, Boqun Feng
 <boqun.feng@gmail.com>, Frederic Weisbecker <frederic@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, John Stultz
 <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Miguel Ojeda
 <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo
 <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno
 Lossin <lossin@kernel.org>, Alice
 Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v7 6/7] rust: time: Add Instant::from_nanos()
In-Reply-To: <20250813224240.3799325-7-lyude@redhat.com>
References: <20250813224240.3799325-1-lyude@redhat.com>
 <qhskgOLluo5Q7Ug_Uox4HQdV-bMNVmbCn6OwxFpTKviNdDjlLONxr9WcYXT5-kHQMCSV-lNIdDOxPvA246_zwA==@protonmail.internalid>
 <20250813224240.3799325-7-lyude@redhat.com>
Date: Fri, 15 Aug 2025 10:11:19 +0200
Message-ID: <87tt29dmxk.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Lyude Paul" <lyude@redhat.com> writes:

> For implementing Rust bindings which can return a point in time.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



