Return-Path: <linux-kernel+bounces-868352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C892FC0507D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 10:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 430633AF51A
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 08:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B34303C9B;
	Fri, 24 Oct 2025 08:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0CKa43V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC48E303A2C;
	Fri, 24 Oct 2025 08:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761294070; cv=none; b=lvRuMXMGP0H/SkMRkvCZ5AM2crymQRSpV0osItd41jixOTSoxqhvrHWZCJa/wcZKtKBMipHCsrXW1/z1nMJWR1eyUz/FMwZc1h2nyNDN5/yg1i+dHsIbgmlHEXelvKIOSMlV3vA5/LEi8kPyg3+YnGs+a9XCImXV+zNq/srroAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761294070; c=relaxed/simple;
	bh=5V4UJ1E29hqtjc4YTQEUGEJrzE/JhcdAzXVTQ0cpwA0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GK+fkPz0zJcXxzrET4DwxB3txsZfPKzPAMEPk9x1AjdNNmHjaLDMTrYQ3x7Tt9IbmTutTKfl2Nz0+by32q/pGyi+aN//gwirB/Sdd3CUf31ZA+0JW2bFIpR69FpaNHUEpaUazwA0RB41dWqHbRxOopOCZtzH5hGICFOGvWRZWs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M0CKa43V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE546C4CEF1;
	Fri, 24 Oct 2025 08:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761294068;
	bh=5V4UJ1E29hqtjc4YTQEUGEJrzE/JhcdAzXVTQ0cpwA0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=M0CKa43Vv/+uvi68N5AOqpdvX9z+4LVyny+w0Q0Uhx+d+wdmMBiSaD4AAt8z9m+Aq
	 bDsMs1loLQVOv7xobWXKEklbv0/vrjgFhIiqcRWnEUhx2frxw2e85titSevmLU3EbR
	 bjBQQsTUqRSziIrDN1pZDvUNGHWephco+LSm559oi4qDEkMCtPZe9DevWzEhxG2Dxb
	 sHtKXrEKWNypvMoD/x6BvhdN0xe5s5GclOf+aIIHeUwGPuT4ZfbmiJiMpy++90NBK+
	 O65DK1sJirYdWC+aS06N1aTql2DAtcBb+Ly7+Pa5pejrCzABhN74PaECGSkb4Xbj5Y
	 /Cw/kA1PhYSAw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>, FUJITA Tomonori
 <fujita.tomonori@gmail.com>
Cc: dakr@kernel.org, miguel.ojeda.sandonis@gmail.com,
 daniel.almeida@collabora.com, alex.gaynor@gmail.com, ojeda@kernel.org,
 anna-maria@linutronix.de, bjorn3_gh@protonmail.com, boqun.feng@gmail.com,
 frederic@kernel.org, gary@garyguo.net, jstultz@google.com,
 linux-kernel@vger.kernel.org, lossin@kernel.org, lyude@redhat.com,
 rust-for-linux@vger.kernel.org, sboyd@kernel.org, tglx@linutronix.de,
 tmgross@umich.edu, gregkh@linuxfoundation.org
Subject: Re: [PATCH v2 1/2] rust: add udelay() function
In-Reply-To: <aPjmKSrETqrchW_e@google.com>
References: <DDO3G26SIZTK.1KV7Q0PQXHWTA@kernel.org>
 <CANiq72nUiizxo3YFgxUZ1jiczRNbY2ATao2YUBiCEC7k5hbv6Q@mail.gmail.com>
 <DDO3OMBHS8TB.2LDODR1AFRCU3@kernel.org>
 <20251022.193230.585171330619599845.fujita.tomonori@gmail.com>
 <vTqqW7yepc41IJ7rUH2GAcWAJ1HHAUQ2_NeQ_os6L5MKNZ-acMHFwH9u3m0oRDumL2YQPnZ6Qu58-iLlAv0Tew==@protonmail.internalid>
 <aPjmKSrETqrchW_e@google.com>
Date: Fri, 24 Oct 2025 10:20:56 +0200
Message-ID: <877bwkhfrr.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alice Ryhl" <aliceryhl@google.com> writes:

> On Wed, Oct 22, 2025 at 07:32:30PM +0900, FUJITA Tomonori wrote:
>> On Tue, 21 Oct 2025 17:20:41 +0200
>> "Danilo Krummrich" <dakr@kernel.org> wrote:
>>
>> > On Tue Oct 21, 2025 at 5:13 PM CEST, Miguel Ojeda wrote:
>> >> i.e. if they aren't sure what the value is, then I would prefer they
>> >> clamp it explicitly on the callee side (or we provide an explicitly
>> >> clamped version if it is a common case, but it seems to me runtime
>> >> values are already the minority).
>> >
>> > Absolutely! Especially given the context udelay() is introduced
>> > (read_poll_timeout_atomic()), the compile time checked version is what we really
>> > want.
>> >
>> > Maybe we should even defer a runtime checked / clamped version until it is
>> > actually needed.
>>
>> Then perhaps something like this?
>>
>> #[inline(always)]
>> pub fn udelay(delta: Delta) {
>>     build_assert!(
>>         delta.as_nanos() >= 0 && delta.as_nanos() <= i64::from(bindings::MAX_UDELAY_MS) * 1_000_000
>>     );
>
> This is a bad idea. Using build_assert! assert for range checks works
> poorly, as we found for register index bounds checks.

What was the issue you encountered here?


Best regards,
Andreas Hindborg




