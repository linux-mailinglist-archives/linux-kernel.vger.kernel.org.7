Return-Path: <linux-kernel+bounces-776336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDDCB2CC1E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 20:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ADEA5687FF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 18:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244612FA0FF;
	Tue, 19 Aug 2025 18:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="TAo7dedv"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79C01CA84;
	Tue, 19 Aug 2025 18:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755628384; cv=pass; b=ABnNZ+YsTaK5dWubH7vXmgY/niak6MxPREWOD5ZNJZNdfzaKWjiZzQTNtBuATha/UkXr9q0XrHzXA+GtCF3Yekn4E+rfJwmjyYjhhji6cvgCib7UIL+oWGq0235Gup3DZOyo/7FDdMqV9d/USEi+t1o+1bT3XYm6JhDLiht8gMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755628384; c=relaxed/simple;
	bh=gyCnc6XMMEZwjfpHHn3fsXLulNzAZSiJEyyQg0iCnMg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ujqB+qNagvqMOsB6z5gQ96EmkfTNKf/ZN8vruMWnmbHmsQbcCxgbLurGvdy6PQXPQoVtS2rxpxGwXOkJd0NHb3m0tQC3VnFsO5+0Ju2mB7VWp+4x7u40uPJP0b5n37KOJF1AMY/patBIucy4XvWz2HvkxwT1Hnv8DXq+QnxA8XI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=TAo7dedv; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1755628362; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=aI3xGS1ywG/MLi87Bh0Z2bqBzAQ2TAly8SPdHGfJDXxItqPHGvvVIoKDMhjQSqfD4feEAgLWi7McrpRfVHit5U8E3PfR0TbjURP+rK08n3AjreDZGUN/rfjQYUcYDJM8g3/BU1u3sufW67kgozzW5mt0/4tZxiI90TM2OAcdEj4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1755628362; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=BEtAilB2KNZcvq6SvOa/0+TPx2JcL1FpO0Zea2H+S9M=; 
	b=kzO+9XoNkLi7gJfbJWsKFa9cBDLclS9X/q6CfT9qLryD1Qt7Gq6fmiU0itrf7xyLmR+IcczzLs7BOa1u8aNgWZeuBkLE9elWxm2a+7iicCfPBB1IrkjFLJq41VJVQLsbo7fK0KGaHeJxDK3Rai+jXldBbw7GJWMKmX5+QhDLsD8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1755628362;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=BEtAilB2KNZcvq6SvOa/0+TPx2JcL1FpO0Zea2H+S9M=;
	b=TAo7dedvqPN8b/rP80FSF+rePxIzJa7twCTNAAamuAoAvuU3uU+zjiu0Ce9mwf3Y
	fF5Igh8vO0nHk0zA2aIf+k+qrM9pQL05v9sGk2QQu71f/3Wx6cIp8NI+Y5sIvcsztke
	x7cXpxisVrBsW7h27fKGSv1cIM5DbkAIVL9dzrBQ=
Received: by mx.zohomail.com with SMTPS id 1755628360586610.4093312458549;
	Tue, 19 Aug 2025 11:32:40 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH v2 1/2] rust: Add cpu_relax() helper
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250817044724.3528968-2-fujita.tomonori@gmail.com>
Date: Tue, 19 Aug 2025 15:32:23 -0300
Cc: a.hindborg@kernel.org,
 alex.gaynor@gmail.com,
 ojeda@kernel.org,
 aliceryhl@google.com,
 anna-maria@linutronix.de,
 bjorn3_gh@protonmail.com,
 boqun.feng@gmail.com,
 dakr@kernel.org,
 frederic@kernel.org,
 gary@garyguo.net,
 jstultz@google.com,
 linux-kernel@vger.kernel.org,
 lossin@kernel.org,
 lyude@redhat.com,
 rust-for-linux@vger.kernel.org,
 sboyd@kernel.org,
 tglx@linutronix.de,
 tmgross@umich.edu,
 acourbot@nvidia.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <843AC662-BBC0-4879-A5F8-68C41C660A59@collabora.com>
References: <20250817044724.3528968-1-fujita.tomonori@gmail.com>
 <20250817044724.3528968-2-fujita.tomonori@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
X-Mailer: Apple Mail (2.3826.700.81)
X-ZohoMailClient: External



> On 17 Aug 2025, at 01:47, FUJITA Tomonori <fujita.tomonori@gmail.com> =
wrote:
>=20
> Add cpu_relax() helper in preparation for supporting
> read_poll_timeout().
>=20
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> ---
> rust/helpers/helpers.c   |  1 +
> rust/helpers/processor.c |  8 ++++++++
> rust/kernel/lib.rs       |  1 +
> rust/kernel/processor.rs | 14 ++++++++++++++
> 4 files changed, 24 insertions(+)
> create mode 100644 rust/helpers/processor.c
> create mode 100644 rust/kernel/processor.rs
>=20
> diff --git a/rust/helpers/helpers.c b/rust/helpers/helpers.c
> index 7cf7fe95e41d..04598665e7c8 100644
> --- a/rust/helpers/helpers.c
> +++ b/rust/helpers/helpers.c
> @@ -34,6 +34,7 @@
> #include "pid_namespace.c"
> #include "platform.c"
> #include "poll.c"
> +#include "processor.c"
> #include "property.c"
> #include "rbtree.c"
> #include "rcu.c"
> diff --git a/rust/helpers/processor.c b/rust/helpers/processor.c
> new file mode 100644
> index 000000000000..d41355e14d6e
> --- /dev/null
> +++ b/rust/helpers/processor.c
> @@ -0,0 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/processor.h>
> +
> +void rust_helper_cpu_relax(void)
> +{
> + cpu_relax();
> +}
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index ed53169e795c..c098c47c1817 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -110,6 +110,7 @@
> pub mod platform;
> pub mod prelude;
> pub mod print;
> +pub mod processor;
> pub mod rbtree;
> pub mod regulator;
> pub mod revocable;
> diff --git a/rust/kernel/processor.rs b/rust/kernel/processor.rs
> new file mode 100644
> index 000000000000..85b49b3614dd
> --- /dev/null
> +++ b/rust/kernel/processor.rs
> @@ -0,0 +1,14 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Processor related primitives.
> +//!
> +//! C header: =
[`include/linux/processor.h`](srctree/include/linux/processor.h)
> +
> +/// Lower CPU power consumption or yield to a hyperthreaded twin =
processor.
> +///
> +/// It also happens to serve as a compiler barrier.
> +#[inline]
> +pub fn cpu_relax() {
> +    // SAFETY: Always safe to call.
> +    unsafe { bindings::cpu_relax() }
> +}
> --=20
> 2.43.0
>=20
>=20

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>=

