Return-Path: <linux-kernel+bounces-759906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF15B1E45C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 10:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 866D318C117F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Aug 2025 08:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038852609CC;
	Fri,  8 Aug 2025 08:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HEAYWHUp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6382A4A11;
	Fri,  8 Aug 2025 08:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754641617; cv=none; b=SAH9eqflPQH84tD+AFDEohpg0mOAE19hw7wyuM3LFzWPkh5qSrj0jq2F/Z4mg17dHtmnS9w+sFhmjeywlGn/DEUj2uFuvOFanojorlnJHFn1y66MCHqqKvFcB/JT+aSZMW8vHjuwcfpQuk99fccvAUwaLLQ8CZzW5XOIFTw7Vpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754641617; c=relaxed/simple;
	bh=yijCaF4i3QtRJm0bLFsVv2wW9o1TENOE2lwvCRsnlnA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dmT/5B6wOgGCKEkGOh0fhzfvZlhFxPRuH/yzQ+WiqcpT3tuWfsGohqknPcJz48uDOeLAW23v6e1KcdoTFCLaTFD6gcJVHnsklffiyDf99WJGJ+x3lmrGjdgyNTTG+i0frTbpB8Wb4JvBuwcZC+hcZgZkXxbv/lYt2Mp0/yLzTTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HEAYWHUp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FBECC4CEF0;
	Fri,  8 Aug 2025 08:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754641617;
	bh=yijCaF4i3QtRJm0bLFsVv2wW9o1TENOE2lwvCRsnlnA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=HEAYWHUpqmdo9dv+7OeGckVaRnvoSaUCh6XYxKLPnTvS9mNrQZPjgYwYuk3S0UOwm
	 T2vUjy6NvLLIuskLKiRR4OnR5Ms9f3W78Elmf/hbTJ/V2h0iMD/0irk/6qILSWxx8W
	 1PP6rDUROoq7GELxCmCEYPDnwQMrcexCKsS8ZLIbeeBDpB4bCvek1CwVzFUxhJb2qM
	 /eY/AEVhECd0oPlaw09Fi2dVsyyA+ajEPwrnR2RTR+gPSFCE/2dU+WmK1EnwWBsQNv
	 g7IjyMnwBvZooLubWbiujZfSD01Ps4wzDde0lzQ/PEY4ayX37021cZdUXryXimxiEK
	 Ieymu+vbtWfQg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org, Thomas
 Gleixner <tglx@linutronix.de>, Boqun Feng <boqun.feng@gmail.com>,
 linux-kernel@vger.kernel.org, FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: Frederic Weisbecker <frederic@kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, John Stultz <jstultz@google.com>, Stephen
 Boyd <sboyd@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor
 <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6r?=
 =?utf-8?Q?n?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich
 <dakr@kernel.org>
Subject: Re: [PATCH v6 7/7] rust: hrtimer: Add HrTimer::expires()
In-Reply-To: <20250724185236.556482-8-lyude@redhat.com>
References: <20250724185236.556482-1-lyude@redhat.com>
 <kZ7hk3R7uz5chPaN0BJeXeMb4XcLmrfadB-EfQ1a0zd9lQwFvJxfI2OBUg2NHaJn8gPzlc56YAejZKFJk5JwMA==@protonmail.internalid>
 <20250724185236.556482-8-lyude@redhat.com>
Date: Fri, 08 Aug 2025 10:24:32 +0200
Message-ID: <8734a26x1b.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Lyude Paul" <lyude@redhat.com> writes:

> Add a simple callback for retrieving the current expiry time for an
> HrTimer. In rvkms, we use the HrTimer expiry value in order to calculate
> the approximate vblank timestamp during each emulated vblank interrupt.
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg




