Return-Path: <linux-kernel+bounces-863216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3801BF745D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 17:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2B9D18A0BFF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Oct 2025 15:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20145342C95;
	Tue, 21 Oct 2025 15:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6URpcPC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E034AEE2;
	Tue, 21 Oct 2025 15:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761059376; cv=none; b=IAFnmEErE4pZCNtaHoUx/URK0OtM2/XBYajkr8lAwHLh3ZhOqyV8aulWWmxaj4br4j4n3tHc1jcbrInrWlmv5a67VKuoe9ziLoAW7RwXg/WmbZF7F3Q98AjeCE/7FGpHn4XZwD3QuwM8NMpTENaYk9HgELPNZBQtlDNARlfTOjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761059376; c=relaxed/simple;
	bh=p+dU+7bNsw1s+IcYrE/VXZrwS6vrHowCckKjMnIjOdo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=mQARQRVaVq15FQfmtnj5UrYekktC1jFExCb1xRDW3otnla3VC93o0KuQ438q95MsvA/+A/xx+sGhtKzjkzVPPokZalxAmc9DG/7vtKp8xcMNFyDJWDpakO3OYkqX1et3R+zODACGOWQba8oWS05Ew79vkh/5HuJYZX+Jsdt05Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6URpcPC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66D7DC4CEF1;
	Tue, 21 Oct 2025 15:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761059376;
	bh=p+dU+7bNsw1s+IcYrE/VXZrwS6vrHowCckKjMnIjOdo=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=X6URpcPCDG+HT82BE1TY+lwZEUfUcpEhz0Sh/PxjBu9PjaBJDjz0OyCIDKqNMq31n
	 Ig50isULKU/EK091l2yrm4IgySdE4KJpMerQbZP4r2Fw74XINR1wUofd8DL2tz4nQU
	 LaAaxb5Ab16iuiWNaoJ6to8vospX7OQrMl+aF17pZCMzzerkuceGfpRTiM4n6WD9W2
	 nFdRasRs6Gwo74kTAxenaMwGVviX4ctJsgNedQRm8qxRKNTAR9uBVoBPbUig5b95Yk
	 b2EVPZ6B+7P5f54l7IsTRevj/5bG37T/EcpLNfy76DejlmpKpHSngBImnBwFEIBw2P
	 7GWoxdWzHp67Q==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Oct 2025 17:09:30 +0200
Message-Id: <DDO3G26SIZTK.1KV7Q0PQXHWTA@kernel.org>
Subject: Re: [PATCH v2 1/2] rust: add udelay() function
Cc: "FUJITA Tomonori" <fujita.tomonori@gmail.com>, <aliceryhl@google.com>,
 <daniel.almeida@collabora.com>, <a.hindborg@kernel.org>,
 <alex.gaynor@gmail.com>, <ojeda@kernel.org>, <anna-maria@linutronix.de>,
 <bjorn3_gh@protonmail.com>, <boqun.feng@gmail.com>, <frederic@kernel.org>,
 <gary@garyguo.net>, <jstultz@google.com>, <linux-kernel@vger.kernel.org>,
 <lossin@kernel.org>, <lyude@redhat.com>, <rust-for-linux@vger.kernel.org>,
 <sboyd@kernel.org>, <tglx@linutronix.de>, <tmgross@umich.edu>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>
To: "Miguel Ojeda" <miguel.ojeda.sandonis@gmail.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251021071146.2357069-1-fujita.tomonori@gmail.com>
 <20251021071146.2357069-2-fujita.tomonori@gmail.com>
 <DDNZL452A8JR.K1AA7LHZEXW8@kernel.org>
 <CANiq72m+uAWyRf6y6vAKjCQnwsMqVVGQx3VrHW1yAp4a-5eWew@mail.gmail.com>
 <54328318-c235-413a-a069-5ea93f1dcb2b@kernel.org>
 <CANiq72=eOYk=WM5xfMkHj-REYjedYiYNakVvfto-AUL5E0O8qA@mail.gmail.com>
In-Reply-To: <CANiq72=eOYk=WM5xfMkHj-REYjedYiYNakVvfto-AUL5E0O8qA@mail.gmail.com>

On Tue Oct 21, 2025 at 4:58 PM CEST, Miguel Ojeda wrote:
> On Tue, Oct 21, 2025 at 4:46=E2=80=AFPM Danilo Krummrich <dakr@kernel.org=
> wrote:
>>
>> Given that we'd have a WARN() for any value passed that is > MAX_UDELAY_=
MS, and
>> given that WARN() is considered a vulnerability if hit (Greg, please cor=
rect me
>> if that's wrong), this would literally become a vulnerability generator.=
 :)
>
> Yes, but only if hit in a way that can be triggered by an attacker,
> e.g. user actions, not in general.

Sure, that's what I assumed.

> i.e. that is why I was saying that someone could end up calculating a
> delay value based on something e.g. user controlled, and then gets an
> edge case wrong, and hits the `WARN()`, which is the "bad case" and a
> CVE would be assigned.
>
> A `pr_warn_once!` plus `debug_assert!` (or similar) should be a fine
> way for having EB in functions, which is a useful concept without
> leaving it UB liek in C nor going with a full `Result`. I can document
> that combo.

I'm not even sure we want that necessarily. I'd probably go for just docume=
nting
that the value will be clamped to 0 <=3D value <=3D MAX_UDELAY_MS plus an i=
nternal
pr_debug!().

This way the function can also explicitly used in cases where the driver is=
n't
sure whether the value is in range and use it without duplicating the clamp
logic that the function already does internally anyways.

