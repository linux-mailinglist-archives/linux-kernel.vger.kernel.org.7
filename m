Return-Path: <linux-kernel+bounces-751097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F908B1653A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 19:15:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 546A018C243C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jul 2025 17:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42B5D2DFA31;
	Wed, 30 Jul 2025 17:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mK7n2jUa"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931A82DFA24;
	Wed, 30 Jul 2025 17:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753895708; cv=none; b=JVzpAJuTPsgJRb+WjhLnIdpnAk9L3fOdgtEcFxfqQmjrrSDDHZmPYALlFVB7Ms+/M8w7Qg27uVfQsMXdrWX2OOQUmbFJ07TfYWO6V/gVerJWeDkqm8OodBPaS9X2D2Y+FbGkbeXcb518ZGOZ+Cwyh0+w77r1PtYuEgFLmtSDVEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753895708; c=relaxed/simple;
	bh=vF1DNUNq3jV+3EkVfXZWIIzpTAJKBi2uQXnVAWMnJA4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=isoevQJ3OdJsvihRIynAQUgCRmVZIGOCrFYFMY1Iklo9ouUtTTDjA8eSAuVg9QEymH08Z8g2Wd0AIEOVUPJlya10ZefHtEBjQzgWeQABf5nnZUUOs0lbv3Pyd1+PN3jCva1DzEjW0LxVCaLImQAnTjKouNROIqMRaw5dgnIQQQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mK7n2jUa; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753895704;
	bh=vF1DNUNq3jV+3EkVfXZWIIzpTAJKBi2uQXnVAWMnJA4=;
	h=From:Subject:Date:To:Cc:From;
	b=mK7n2jUa21SxcYa9oPrzg28EIipLiBKAmrToqjevnG7+v0vcq2u/BECvqiM16OyjF
	 InOf1euaYH5hDjN0BnmspvAUIYv5/x+IkOvOOMfp69Qw8VeHWyL7vwazbPGwJnO/mW
	 1d2BhBRvAMTz5D+L4QKT1VrFT4kj/aiNYZ//0Jutb+kvwdyIjr+sIKazeNWZ9WGhWb
	 jQfvdO9qbzDD2GNC+qY2DKGx0pJaBTwpqlEKdtIRv74qy9GEY58U9XRzKr73lQIzey
	 jHtMw2NiTIjMapBk4CaU3bO3Fyx5dK8ajN99pIl+02/4Po7slDrLXEbcXBWMaWs5bL
	 OGGeQyNhlkBqA==
Received: from [192.168.0.7] (unknown [IPv6:2804:14d:72b4:82f6:67c:16ff:fe57:b5a3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dwlsalmeida)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0280017E129D;
	Wed, 30 Jul 2025 19:15:01 +0200 (CEST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Subject: [PATCH 0/3] Groundwork for Lock<T> when T is pinned
Date: Wed, 30 Jul 2025 14:14:43 -0300
Message-Id: <20250730-lock-t-when-t-is-pinned-v1-0-1b97d5f28aa2@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAANTimgC/x2MQQ5AMBAAvyJ7tklVpeEr4kAt3ZAlrSARf9c4T
 eYw80CkwBShyR4IdHLkTZIUeQbO9zIT8pgctNKVsqXCdXMLHnh5kgSOuLMIjahrbayplOndAKn
 eA018/+e2e98PW/F1V2kAAAA=
X-Change-ID: 20250730-lock-t-when-t-is-pinned-292474504acb
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, 
 Waiman Long <longman@redhat.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.14.2

It's currently impossible to have a pinned struct within the Lock<T> type.
This is problematic, because drivers might want to do this for various
reasons, specially as they grow in complexity.

A trivial example is:

struct Foo {
  #[pin]
  bar: Mutex<Bar>,
  #[pin]
  p: PhantomPinned,
}

struct Bar {
  #[pin]
  baz: Mutex<Baz>,
  #[pin]
  p: PhantomPinned,
}

Note that Bar is pinned, so having it in a Mutex makes it impossible to
instantiate a Foo that pins the Bar in bar. This is specially undesirable,
since Foo is already pinned, and thus, it could trivially enforce that its
bar field is pinned as well.

This can be trivially solved by using Pin<KBox<Bar>> instead of
structurally pinning, at the cost of an extra (completely unneeded)
allocation and ugly syntax.

This series lays out the groundwork to make the above possible without any
extra allocations.

- Patch 1 structurally pins the 'data' field in Lock<T>
- Patch 2 constrains the DerefMut implementation for safety reasons
- Patch 3 adds an accessor to retrieve a Pin<&mut T>

Note that this is just the beginning of the work needed to make a Pin<&mut
T> actually useful due to pin projections being currently unsupported.

In other words, it is currently impossible (even with the current patch) to
do this:

let mut data: MutexGuard<'_, Data> = mutex.lock();
let mut data: Pin<&mut Data> = data.as_mut();
let foo = &mut data.foo; // <- won't compile

The above is something that Benno is working on.

Thanks Boqun, Benno and the rest of the team for brainstorming the issue
and for and laying out a series of steps to implement a solution.

---
Daniel Almeida (3):
      rust: lock: pin the inner data
      rust: lock: guard: add T: Unpin bound to DerefMut
      rust: lock: add a Pin<&mut T> accessor

 rust/kernel/sync/lock.rs        | 35 +++++++++++++++++++++++++++++++----
 rust/kernel/sync/lock/global.rs |  5 ++++-
 2 files changed, 35 insertions(+), 5 deletions(-)
---
base-commit: dff64b072708ffef23c117fa1ee1ea59eb417807
change-id: 20250730-lock-t-when-t-is-pinned-292474504acb

Best regards,
-- 
Daniel Almeida <daniel.almeida@collabora.com>


