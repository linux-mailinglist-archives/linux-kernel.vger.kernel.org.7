Return-Path: <linux-kernel+bounces-887453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 661F8C3849B
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 00:02:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F297C18C1939
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 23:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755111DF25F;
	Wed,  5 Nov 2025 23:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+9JOsrm"
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CE21EA7FF
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 23:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762383748; cv=none; b=Bp3IzxQAgF9p6EXBQz4jzjb9IUuFjjowM9pJbab4K9Oq+05T5abnOMLYT+7coHEumiVS3h5U3bAITA+OAraD6/qPmADOXNi92F1FQB4wfHWVKv/yiw45SPjWXsXPbA65wogdEYT2CCq5YO9yOLKRDmaxrvui69XPE6cERGXw+H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762383748; c=relaxed/simple;
	bh=unKKUkPd5pRTqG3L9Z0F/ADhxBnwusdEiP6PTAc6qPM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NnuWuPil2jUy8M0rYC81+3Dd0HLI5qmSjVlr6IDeJDO5D4wwlGeNTTw040TT1g3AvkDnbTVTi7NXpslyxLoYZNwwjLJU2jRueTOTGgVgGOSCKPKPel8HgEr5DzbeZMgsMInbnhcr1M/OfBBX8icm/l1o5fmbKBMGqLHSzDAwj0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+9JOsrm; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3401314d845so524388a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 15:02:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762383746; x=1762988546; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m5P8jXB+dIsfoWVQD4/Et/l6O3PGrt87olQD+9nhTtY=;
        b=C+9JOsrm3uprfGAdTQPSzpv7Y9RRwWRSAwcp+VYnEwnkiic/NbtGRaI9g7NOXLIaY8
         aeElRLmvZ6YuFVZopO2Le1/CfzM60aWFjJ4RZVWx551CTr3VOtRAD+8z+Wg8rf1qNR7Q
         +xYMC1iqPtZrafAFaUOUdS71xuX/ZeUoA9nYMqwcDcVkibTdmaPGEnWcJyUw+degcFya
         sO1UQjU6gHtlkJZ2NzM7T41lzstJaLX3OW8HKQg1mw1k1FzE0746gboM4OcQLduhzvDL
         jRPyBL5e/UB/SeS7BuKwWFPAs2NOZ3CZid3/0bKii79B+HyrVCvNebs2j15K8rGzL7lV
         0h2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762383746; x=1762988546;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m5P8jXB+dIsfoWVQD4/Et/l6O3PGrt87olQD+9nhTtY=;
        b=DnlnooMCwO0Rxjl66MsyxRiB4yuUqy8UKsUjJ1Qmx4DisdRPqCBIXetd/CnJPzbWZ+
         qNC0UdqvMIn+RgGbnwfDsvEZH274T4eOtJN7q/lfffjcIUzjESH7OegA6yc3+1oQAZ3s
         pGgtFgIqHdkrR7rUSFB/LNa6SCb44F9M7qG7i1ZilZGXv3VvmOt9q2Uok19c7OI9PvID
         +0i/br7734VgMNqOCG8w1/l8w9Lj7sSU8xE4xru4UsjGvlYEawcLtt3/q7eRLXTeCXIT
         bwSnQ0sKaDx9sQKWuObfJeTFKc43hGAPPRdukDraBif34e0nBwEifjWMSyriIGiipUCn
         0taA==
X-Forwarded-Encrypted: i=1; AJvYcCWPomEQATZEtn/1TePUEeibiAOcwtie2IHtVnMv7KMnLQww55ZtHqf17LqWFvHZjJrEi8lk8xHQS9CUfdI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsrN3elsXyDE7/P7/RIqcC5kfWPU2730VGjDlo3qcWvqagsgF+
	FC1l3ilEauRlRKLgRss39ckprctCtWFt/E6mBXGdhR3Y2z5rwDpa1352
X-Gm-Gg: ASbGnctl3PRvFM5aR0tILMNF4lWJkTl7dxRT4TeR28Irec3ZCdRm5J/JimxjIGpxALy
	V+C5xO3Gr6kI8yP4SEIgGWZmvZzScc19cXvL7WnxwiIYSb9k5nsiNiPd8nZNhcytx28TPiURQdl
	esEU3AKAyM2T8cr5n9IqY5RRyGXx2f2ebgXc1s3ofCgvUfY9oIuntA6VPzDblw5t7GlYQwCiO7W
	wOEHjtpNz4DDNFUI5elONUKGXOyjshybiuuVYH56SvZWDXabYBSYzEMVobAoQkRO2ChX0p6sFd+
	3A5WC3xvre/RAp7YUAtz4PMo17cwbp5h56NJ6Yw1PAi9LriLGC2HrJnjzZ9gMgZq5titC6nwz57
	RSZQM2SE7i992j3wQ29nVrqEGsVLhLGZaGSaLKesJDkw5fLX2kgFtl7CYtqGxDLR677NNPy9Vsx
	tiwMNmz7CsXKZzg3umCU6owczsHnA9U2m7sF3Nq69J+ifS
X-Google-Smtp-Source: AGHT+IFcWQsxhsDJYw8BvHJ+cu4xy3Cbjz4NgQDldTTtvAA02XiwTojS7CTRnWKlbDVxorN9sS9LUA==
X-Received: by 2002:a17:902:d488:b0:26d:d860:3dae with SMTP id d9443c01a7336-2962ad83389mr72820715ad.3.1762383746250;
        Wed, 05 Nov 2025 15:02:26 -0800 (PST)
Received: from mitchelllevy.localdomain ([131.107.147.147])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2965096839asm6325645ad.13.2025.11.05.15.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 15:02:25 -0800 (PST)
From: Mitchell Levy <levymitchell0@gmail.com>
Subject: [PATCH v4 0/9] rust: Add Per-CPU Variable API
Date: Wed, 05 Nov 2025 15:01:12 -0800
Message-Id: <20251105-rust-percpu-v4-0-984b1470adcb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADjXC2kC/22Q3U7EIBBGX2XDtRhmgAJe+R7GCwrTXRJ3W6FtN
 Ju+u7Rq3B8vv0nOOcmcWaGcqLCn3ZllmlNJ/akO9bBj4eBPe+Ip1s1QoBIWJM9TGflAOQwTJ4+
 dVq2OXkpWiSFTlz4228tr3YdUxj5/bvIZ1uvmAQR35ZmBC47CARiyiC08748+vT2G/rhqK6NFg
 +qecUG7VpiI3oULZm3P+NvTQsENi5XV5EUUkUB6/U/PAN4zFpsOdWM0Qnvbk389i/aalZVVMTo
 kIOOEumSX78dlep/q98ef7y3LF3S2LbabAQAA
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Andrew Morton <akpm@linux-foundation.org>, 
 Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
 Christoph Lameter <cl@linux.com>, Danilo Krummrich <dakr@kernel.org>, 
 Benno Lossin <lossin@kernel.org>, Yury Norov <yury.norov@gmail.com>, 
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: Tyler Hicks <code@tyhicks.com>, Allen Pais <apais@linux.microsoft.com>, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-mm@kvack.org, Mitchell Levy <levymitchell0@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762383744; l=5076;
 i=levymitchell0@gmail.com; s=20240719; h=from:subject:message-id;
 bh=unKKUkPd5pRTqG3L9Z0F/ADhxBnwusdEiP6PTAc6qPM=;
 b=wJYwix5/zj4Vy0vQM6M/OltQSTZy+YEPGtMMsjgYxv3Uz1EwTP5wCYJJImuAi/rTC8Jt8quPT
 BKnBugpFEAqA+8tOxJtVekq+qC4/uZGDxtzL43n7if+USvw9ItaSj9r
X-Developer-Key: i=levymitchell0@gmail.com; a=ed25519;
 pk=n6kBmUnb+UNmjVkTnDwrLwTJAEKUfs2e8E+MFPZI93E=

This series adds an API for declaring and using per-CPU variables from
Rust, and it also adds support for Rust access to C per-CPU variables
(subject to some soundness requirements). It also adds a small sample
module, samples/rust/rust_percpu.rs, in the vein of lib/percpu_test.c.

---
Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>

---
Changes in v4:
- Split what was the first patch into three patches (Thanks Yury Norov)
- Add intra-doc links to rustdoc comments (Thanks Miguel Ojeda)
- `get_remote_ptr` is no longer unsafe (Thanks Miguel Ojeda)
- Renamed the CPU mask getters to be more clear (Thanks Yury Norov)
- Add an `ExternStaticPerCpuSymbol` type for static per-CPU variables
  shared with C in order to make the extra soundness requirements for
  these variables more explicit.
- Properly drop the contents of dynamically allocated per-CPUs when the
  `DynamicPerCpu` is dropped, and properly document that
  `PerCpuAllocation` does not handle dropping values in the allocation.
- Functions on the numeric token types are now `#[inline]`
- Safety requirements of `PerCpuPtr` functions now include the fact that
  the pointed-to allocation must be live and appropriately laid out in
  memory, and SAFETY comments of uses of these functions have been
  updated to reflect these requirements.
- Included the cpumask patches first, since it might make sense for
  these to be merged separately.
- Documentation improvements throughout.
- Link to v3: https://lore.kernel.org/r/20250828-rust-percpu-v3-0-4dd92e1e7904@gmail.com

Changes in v3:
- Add a `CheckedPerCpuToken` that enables usage of per-CPU variables via
  a `&T`, allowing for a wholly safe interface when `T` allows for
  interior mutability (Thanks Benno Lossin)
- Add support for non-zeroable types to be used in a `DynamicPerCpu`.
- Remove necessity for `unsafe` to get a `StaticPerCpu` from its
  declaration (Thanks Benno Lossin)
- Allow the declaration of static per-CPU variables of types that are
  `!Sync`.
- Implement `PerCpuPtr` in terms of `MaybeUninit<T>` rather than `T` so
  as to keep all invariants in the `DynamicPerCpu` and `StaticPerCpu`
  types --- this would also enable `PerCpuPtr` to be used in a per-CPU
  type that does lazy initialization.
- Link to v2: https://lore.kernel.org/r/20250712-rust-percpu-v2-0-826f2567521b@gmail.com

Changes in v2:
- Fix kernel test robot issues
- Fix documentation error
- Require `T: Zeroable` in the dynamic case
- Link to v1: https://lore.kernel.org/r/20250624-rust-percpu-v1-0-9c59b07d2a9c@gmail.com

Changes in v1:
- Use wrapping_add in `PerCpuPtr::get_ref` since overflow is expected.
- Separate the dynamic and static cases, with shared logic in a
  `PerCpuPtr` type.
- Implement pin-hole optimizations for numeric types
- Don't assume `GFP_KERNEL` when allocating the `Arc` in the dynamic
  case.
- Link to RFC v2: https://lore.kernel.org/r/20250414-rust-percpu-v2-0-5ea0d0de13a5@gmail.com

Changes in RFC v2:
- Renamed PerCpuVariable to StaticPerCpuSymbol to be more descriptive
- Support dynamically allocated per-CPU variables via the
  PerCpuAllocation type. Rework statically allocated variables to use
  this new type.
- Make use of a token/closure-based API via the PerCpu and PerCpuToken
  types, rather than an API based on PerCpuRef that automatically
  Deref(Mut)'s into a &(mut) T.
- Rebased
- Link to RFC: https://lore.kernel.org/r/20241219-rust-percpu-v1-0-209117e822b1@gmail.com

---
Mitchell Levy (9):
      rust: cpumask: Add a `Cpumask` iterator
      rust: cpumask: Add getters for globally defined cpumasks
      rust: percpu: Add C bindings for per-CPU variable API
      rust: percpu: introduce a rust API for static per-CPU variables
      rust: percpu: introduce a rust API for dynamic per-CPU variables
      rust: percpu: add a rust per-CPU variable sample
      rust: percpu: Support non-zeroable types for DynamicPerCpu
      rust: percpu: Add pin-hole optimizations for numerics
      rust: percpu: cache per-CPU pointers in the dynamic case

 rust/helpers/cpumask.c          |   5 +
 rust/helpers/helpers.c          |   2 +
 rust/helpers/percpu.c           |  20 +++
 rust/helpers/preempt.c          |  14 ++
 rust/kernel/cpumask.rs          |  94 ++++++++++++-
 rust/kernel/lib.rs              |   3 +
 rust/kernel/percpu.rs           | 273 +++++++++++++++++++++++++++++++++++++
 rust/kernel/percpu/cpu_guard.rs |  36 +++++
 rust/kernel/percpu/dynamic.rs   | 184 +++++++++++++++++++++++++
 rust/kernel/percpu/numeric.rs   | 138 +++++++++++++++++++
 rust/kernel/percpu/static_.rs   | 218 +++++++++++++++++++++++++++++
 samples/rust/Kconfig            |   9 ++
 samples/rust/Makefile           |   1 +
 samples/rust/rust_percpu.rs     | 294 ++++++++++++++++++++++++++++++++++++++++
 14 files changed, 1290 insertions(+), 1 deletion(-)
---
base-commit: f3f6b3664302e16ef1c6b91034a72df5564d6b8a
change-id: 20240813-rust-percpu-ea2f54b5da33

Best regards,
-- 
Mitchell Levy <levymitchell0@gmail.com>


