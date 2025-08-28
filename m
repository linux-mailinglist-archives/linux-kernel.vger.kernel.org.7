Return-Path: <linux-kernel+bounces-790708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AA9BB3AC08
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 22:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D02A72009EF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 20:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01AC129D292;
	Thu, 28 Aug 2025 20:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="JyEQ7a43"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC21728B7DE;
	Thu, 28 Aug 2025 20:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756414394; cv=pass; b=GIlr6nSKJrzs+6FuB7X/gmYI+f3A5NexmhD9X+UQADmuNfkbxI8ZAcGpithRS+DRMB1hzXDjTEYCLYvHk5PMUCTIXK5muCb957lBChXHd2OaRXbBTxlWB7ZD/fG9wPrKgfdYCzxHzw3WTmH6m4oDLqgCbNRCdRAV78lDv9tcKQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756414394; c=relaxed/simple;
	bh=vDunwPYJgo4ywCXcXrQF7egra/P6DcOk4+niTP6ZbJA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ke5NiHUgCRVsrTJs/h1Gk1RwrAkld+ldoby1NxOOzaU0D0d2hFxY+pZxPx6DCNRXXGGA8d7EODo+U8jy8oG4gQYfCWbfEdpPtr+7aM4fvV7luCa0VRMyRKyTYUxHXKv0P+m51z437pLyBZUzsePEYagr35X+JNuGNhMVP8pABUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=JyEQ7a43; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1756414368; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=KnHGhlddVHc+Ul0o/4/sVcxB5ADdTKVy/09RbIUd/xtYjoM6WLzdl3nZ30Z3Oq/Q7LekSfkk+3c5tQLLy7HCBZsUoA6eCU5nXraz9ZlcM33Fay1hdB0dOIM2wu7upaciGqBKXVf+kebZVLm7yciKzJEgBQJBoW0oDej71RzSUqI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756414368; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=lTmcpQUvJeTYz+ofWSSP4Sk1n42n24d3ktOgHwMIRiU=; 
	b=m+uw8gjSMXxIvFrbP3NUQoKAeop+JHkc/z3y+B95FPwHpxFB4sDD4yuU0FP4wcni2ULlJyCfC2nFYtJNkCiBuiYoRmphK7+wLJnPw3WvR1eCNPyehpX7qqnnxbx7voY3WHxRYQx1dT8zDpn9Nhjh4OVbLNlxoVHulYOeBtZVQIs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756414368;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=lTmcpQUvJeTYz+ofWSSP4Sk1n42n24d3ktOgHwMIRiU=;
	b=JyEQ7a432mWg8+iRcIt+9NeY5TIVb8+I6u4ZNj8C/RXpLSMVcd9R893OKayv5Nos
	dyL3RdUYinmGVlR3vubCr5KCflmqa+yJQWINYaIyRvC1B0LLyBcWn75d3h7/xAzqCcx
	CPqrJx2fl59OxC3FPmDyAbxOcxuE0DsK4RErQxJo=
Received: by mx.zohomail.com with SMTPS id 1756414365050778.3062359015115;
	Thu, 28 Aug 2025 13:52:45 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Subject: [PATCH v2 0/3] Groundwork for Lock<T> when T is pinned
Date: Thu, 28 Aug 2025 17:52:16 -0300
Message-Id: <20250828-lock-t-when-t-is-pinned-v2-0-b067c4b93fd6@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIDBsGgC/x2M0QpAQBAAf0X7bOtaJ/Er8sBZbLR0J9Tl312ep
 nmYiRDYCwdosgieLwmyaxLKM3BLrzOjjMmBDJWmKgxuu1vxxHthTZCAh6jyiFSTrWxpbO8GSPX
 heZLnP7fd+37OtDfhaQAAAA==
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
X-ZohoMailClient: External

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

- Patch 1 constrains the DerefMut implementation for safety reasons
- Patch 2 structurally pins the 'data' field in Lock<T>
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

Changes in v2:

- Rebased on v6.17-rc3
- Collected tags
- Swap the order between patches 1 and 2
- Mention that it's easier to go through DerefMut if T:Unpin in patch 3
- Un-indent the example in patch 3, also make it prettier by adding
  links
- Link to v1: https://lore.kernel.org/rust-for-linux/20250730-lock-t-when-t-is-pinned-v1-0-1b97d5f28aa2@collabora.com/

---
Daniel Almeida (3):
      rust: lock: guard: add T: Unpin bound to DerefMut
      rust: lock: pin the inner data
      rust: lock: add a Pin<&mut T> accessor

 rust/kernel/sync/lock.rs        | 41 +++++++++++++++++++++++++++++++++++++----
 rust/kernel/sync/lock/global.rs |  5 ++++-
 2 files changed, 41 insertions(+), 5 deletions(-)
---
base-commit: 1b237f190eb3d36f52dffe07a40b5eb210280e00
change-id: 20250730-lock-t-when-t-is-pinned-292474504acb

Best regards,
-- 
Daniel Almeida <daniel.almeida@collabora.com>


