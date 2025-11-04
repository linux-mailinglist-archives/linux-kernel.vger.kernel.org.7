Return-Path: <linux-kernel+bounces-884794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A20C312FC
	for <lists+linux-kernel@lfdr.de>; Tue, 04 Nov 2025 14:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DA1844F0CD6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Nov 2025 13:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDADD2F659C;
	Tue,  4 Nov 2025 13:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HEkNxRjM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AA83313543;
	Tue,  4 Nov 2025 13:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762261804; cv=none; b=tBa+o5PyDepNF5895CPmhp/YxGXid65gThvevwu82hG0quPq4oa1JBnmqVjLlF/JLEjFe22cj1xWn5YOjd8DmZCsnAQO3eR601fd9b9A7N7MtIht0+1i9nRX+CD1Ao+ytKokwzLV0H6w01YWLW46mvLOnvQe8ea9ICiHItuolx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762261804; c=relaxed/simple;
	bh=7NnkJEI0oOMuq1J+RwuRG1xxy/8alW7d08R0YIaczAQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GkyC5iUPDk7VieL5cEWUXerbnshJOA9fBYYhY8WhkihcHiNiqgk84GZqNV3DwTLUBJgyJhypYO9jJcoqcJhZ9E2m8Q0EixrQiBLAVIG3tbDm8TW/vw7xGIkIMtMeF4wjxZJrzTMMpSxidIn0jvl4Ardun2ZInvhpIjNCPWPKJyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HEkNxRjM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8438C4CEF7;
	Tue,  4 Nov 2025 13:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762261802;
	bh=7NnkJEI0oOMuq1J+RwuRG1xxy/8alW7d08R0YIaczAQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=HEkNxRjMxnqaI7GhSVYB1QFMwrTojd7orHe9LXy4lARahl5BLt6YTSdAmTtRwErgQ
	 UvuzRR6tvmiiOBahnVGrOEh26BUdEDQ73ZYy0Jw78/MPRU8O7ROIk+waK+sqspCXOC
	 KBNW/ikPazv3BM2FVJfE4EHqs7gFvGs3MjdvaHuV8hp+OCQG4eet76Q2UjgnAXXHr4
	 OPgA6Ncm91SCPLinK1Dzzf399AaMIvBZ8xfualciWhVc69l08bMwGeJVnic05CiBKj
	 hK0n+Cycu2xb5rcyfK/0f2tstt8xVDwCxL8P6PNWpr523HK1tZ8HQ9N8gu6ItRLwOK
	 8VFAJWCImGx2g==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Lyude Paul <lyude@redhat.com>, rust-for-linux@vger.kernel.org, Thomas
 Gleixner <tglx@linutronix.de>, Boqun Feng <boqun.feng@gmail.com>,
 linux-kernel@vger.kernel.org, Daniel Almeida
 <daniel.almeida@collabora.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Miguel
 Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo
 <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>, Benno
 Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor
 Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
Subject: Re: [PATCH v13 08/17] rust: helper: Add
 spin_{un,}lock_irq_{enable,disable}() helpers
In-Reply-To: <20251013155205.2004838-9-lyude@redhat.com>
References: <20251013155205.2004838-1-lyude@redhat.com>
 <20251013155205.2004838-9-lyude@redhat.com>
Date: Tue, 04 Nov 2025 13:56:46 +0100
Message-ID: <87346u7y7l.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lyude Paul <lyude@redhat.com> writes:

> From: Boqun Feng <boqun.feng@gmail.com>
>
> spin_lock_irq_disable() and spin_unlock_irq_enable() are inline
> functions, to use them in Rust, helpers are introduced. This is for
> interrupt disabling lock abstraction in Rust.
>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Lyude Paul <lyude@redhat.com>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>


Best regards,
Andreas Hindborg




