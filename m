Return-Path: <linux-kernel+bounces-884796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1403FC312BC
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 14:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D695542934D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 13:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227F131B102;
	Tue,  4 Nov 2025 13:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="utUHk/Bc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728F42222C8;
	Tue,  4 Nov 2025 13:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762261817; cv=none; b=gKuOsrQyQyuGZnDqKAGIYHBUBQi9pRKOwh3O2XCRCMz4WEAEdC8Bsz2TD4o0QqVaV5VcR2++3bnlk0dyLMPDuUA0bljUtAZN4ai8t4Ewwnv/gR4Qbkn17KnqauwaJE5if4lurYUVPnU+D6iSgn+sDHylg+AvDdig4VtyZlsAm/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762261817; c=relaxed/simple;
	bh=roQtB6xzVdyzUTA6Orljp+u8/FjEGveLzv5u1l9s0uw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Xl96lQSqxZA1loEfLYmVOGGg9aGNwH7WH8KLevNJwwufOhgmTtkQ+hdlV8DYV+AyYX7+AwqXnWyD94frThYyhny2wYaeu1o1dWcYWxkZPiSh3GWK3EnnqXnpF18r41lXCVoQ82SYm5GvDxX5ZU9GplVmR2V0leGzTwp0H2zAXAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=utUHk/Bc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA84C4CEF7;
	Tue,  4 Nov 2025 13:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762261816;
	bh=roQtB6xzVdyzUTA6Orljp+u8/FjEGveLzv5u1l9s0uw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=utUHk/BcrZaTqvpKzOaJkp/eh29wh/RJu9tPt9rehJVhLug47lD5ej88gekralErE
	 zC75aC0PJtDJMlBsy2d8uAW3Ti/Ovbaug1FVhNalS4oTsp98UgRJwi6AQT0OUMY5HP
	 swTIYKDawQqEtQ3SySkqcl63/StO3OIi+nK1Ei0XQkg0bGy8QHVEcD1tqWcE6Ei4Ah
	 A5BFif5A6CZVL322cyt0adoZ+vePm6b9RcCHA+pI2UfBOqgBHmcDhWZ6+6igvA/oDC
	 EU/ZThbPgyvYWkJyB2nLjiv0u5HjbXWFV7ffWRodN5MGyboI2ZSjj3kb5j8P8iJUNY
	 izO44q2Fozs8A==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org, Thomas
 Gleixner <tglx@linutronix.de>, Boqun Feng <boqun.feng@gmail.com>,
 linux-kernel@vger.kernel.org, Daniel Almeida
 <daniel.almeida@collabora.com>
Cc: Benno Lossin <lossin@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex
 Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Viresh Kumar
 <viresh.kumar@linaro.org>, FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Krishna Ketan Rai <prafulrai522@gmail.com>, Ingo Molnar
 <mingo@kernel.org>, Mitchell Levy <levymitchell0@gmail.com>, Tamir
 Duberstein <tamird@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>
Subject: Re: [PATCH v13 07/17] rust: Introduce interrupt module
In-Reply-To: <20251013155205.2004838-8-lyude@redhat.com>
References: <20251013155205.2004838-1-lyude@redhat.com>
 <20251013155205.2004838-8-lyude@redhat.com>
Date: Tue, 04 Nov 2025 13:55:57 +0100
Message-ID: <875xbq7y8y.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lyude Paul <lyude@redhat.com> writes:

> This introduces a module for dealing with interrupt-disabled contexts,
> including the ability to enable and disable interrupts along with the
> ability to annotate functions as expecting that IRQs are already
> disabled on the local CPU.
>
> [Boqun: This is based on Lyude's work on interrupt disable abstraction,
> I port to the new local_interrupt_disable() mechanism to make it work
> as a guard type. I cannot even take the credit of this design, since
> Lyude also brought up the same idea in zulip. Anyway, this is only for
> POC purpose, and of course all bugs are mine]
>
> Signed-off-by: Lyude Paul <lyude@redhat.com>
> Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Reviewed-by: Benno Lossin <lossin@kernel.org>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg



