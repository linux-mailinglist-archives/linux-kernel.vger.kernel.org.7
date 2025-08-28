Return-Path: <linux-kernel+bounces-790578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D699B3AA79
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 21:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C61A1C84DD1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 19:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E629322C78;
	Thu, 28 Aug 2025 19:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUEvG38e"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0B1BA4A;
	Thu, 28 Aug 2025 19:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756407655; cv=none; b=AtJtN5rQ49NLvJi0ICfy0fCE+dOguZ6b1unmDJO6IponuyMmdbJXnYtKeGo112gCoZ/ux5zACZESLKxNEiN0VGUAo574WDa9cS17CkLsVnt4x3CZvMfP9HEbzOx/IDR7eDQpJxmoWR9ynWCo5M67VLrjbDlUM10FjVg+jDUSf24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756407655; c=relaxed/simple;
	bh=yzEqjwShKdy3e5mR1Q+9kCEEyTAmDJsObfl1FvhOcqQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kaiH5+DhNxgYmM7T2GpPIbm6oPHVK6kzmz+wX7DNERszmnaSBCqdO0+0SZVYdNZEaP1jc3wGxEaSpd5le3kpR7niorp3Ln1zOjjXE+zFVdA9vJ2UNhsP0p6ftFkhV9cjnn3VAMswEheXryRpqilx4LzVjI2+Qc1BoBib4M/gsAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XUEvG38e; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-248ff5cabe0so2696245ad.0;
        Thu, 28 Aug 2025 12:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756407653; x=1757012453; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uLB2ySJxURxeJ2Prp4OMsSE1Drdas7+Ru1DscCOUHP4=;
        b=XUEvG38eI0+y1uFQLVtcgefh+aeWM/o5nONNrlnQFycyRqc9UeVEzhjaeoHZ08RfTK
         OETglOa0EnbSzFEuTlQjhRypB1jltOubJL+6sNWRwUnmORQDZYeKBE25LMN/8IrafgID
         9CQPhyqY5eRZV2sYq4PSbXGZUBHOrxfmEkoZuLySwJQYh73MTyi0G4UF94IUxp0H4ydM
         sV2e9DCRfT9iQ3heY6sUSzawSj7MKubVPZf4EceKyqpFrEuaPxXKQG+UDDdL9KsnrMwf
         ayGaE5lUP5bnNvS3KyS/Y5T/dFJI6HDWQ4zIo+x5con9OyfvlJ5iCttQyuI8bEnOLKAf
         xlsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756407653; x=1757012453;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uLB2ySJxURxeJ2Prp4OMsSE1Drdas7+Ru1DscCOUHP4=;
        b=fyg82rU+QkwckTnAUJXukGUfwAXUfw/Kp3ecFRsVQCDSTaOeO4zrtdKioB4pN3Blps
         RnMSl0OM5LApBQffaKG0jjnt2t1ibTa/Qm1Rm5rfLU/P3GxOq0T0ji1t5RwVt0by+7vY
         RJqTi2/NO7EFK2ewpbmJUIdscHic8LB4pJQKLD3R3FQOKviRXwi/RDV0Z1Ld7m6SSiSH
         gphDlnAw5PEApj4EbfsHrv3YUoKeZSswhMDFIZxKsTZ1FK4Fg7htTtm/bgTkxeKmBhc3
         DvxCRWTTijf6gyMWHolLJlLfyZ63AnL2K2z4owfqrYeTcpUJbeRuqqkUyrHmbKRgHfRD
         +Zvw==
X-Forwarded-Encrypted: i=1; AJvYcCUmBTqmLZPZHagKujs68tew4AwdDTQ7CHElTdecKlk0B3dLDbYc+U8HT9hRGzO3WL0Cfyd5Xh08CwnVzQQ=@vger.kernel.org, AJvYcCX0vLi7nz6k6pqn235NOdhmPtTnZ30T3aGAzwyxuKYH7p8Eg/dbLsJkcRiEJtY/HNoFQ6vOSG654lRTlc8vPPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgpoHSr2V3IsdPEPeKci99K1CLv4EVQjfIIOxXVaT6nN3Ej8KP
	lQ6MMY4BMcB2FTHWwz/dmS37Yxol+37tPXbDb23fXClz0k6FT3HIo3MSEmQ5jQAg
X-Gm-Gg: ASbGnctKsBZD2yScN05vza6KV5JzUelz66QL1u9QrU8OeiswSvFd4/kKEuMSb7YCIt1
	AnIEWZVyZluq3j7RzqSjStVBSJGRH1swCibNKKbpQQ6u5ZFyQ/2T4tuL3jFCraainXQK6nTNFYf
	Mlh3yJBHtaRohQtlIm40nt0GlpogcotcJr75wdCI/kn8bAFHbffsy9X3yYwqlvfBacK/n/04p6D
	QXMLnqUl6QOS5Ngp6u4UkUYxiTk0IoBNT12t88QNlpKK1kq6WjavxYV1FKvrsAbh2Cs5glC73Wl
	SoQ+boQOUyj7GXW4LOk2l0FrjTl/x879s26mntvcD7/GVSFoVx94zHNcTSz3CJdGFqfnBQWXUXc
	e74sG7Mo4KnsG9b4h+t1MxXcKp655fnMVLaoUm0MxLvMWR7hV71TXa0tKW1Ps+ZYKxZQ=
X-Google-Smtp-Source: AGHT+IHW/KVZ59F/LWisNOWscaunifwOLuUYn75v+mJnJQp4Mv7Sd2maSFNmnAHJcLWsDxVxAIVdRQ==
X-Received: by 2002:a17:902:f78e:b0:248:d917:a57c with SMTP id d9443c01a7336-248d917aa6dmr44946385ad.40.1756407652864;
        Thu, 28 Aug 2025 12:00:52 -0700 (PDT)
Received: from mitchelllevy.localdomain ([174.127.224.194])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-327da8e5ad5sm405729a91.18.2025.08.28.12.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Aug 2025 12:00:52 -0700 (PDT)
From: Mitchell Levy <levymitchell0@gmail.com>
Subject: [PATCH v3 0/7] rust: Add Per-CPU Variable API
Date: Thu, 28 Aug 2025 12:00:07 -0700
Message-Id: <20250828-rust-percpu-v3-0-4dd92e1e7904@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADensGgC/22QQW7CMBBFr4K8rtHMOE5iVr1H1YVjT8BSIamdR
 CCUu+MEKtHS5R/pva/5V5E4Bk5it7mKyFNIoTvloN42wh3sac8y+JwFARVQo5JxTIPsObp+lGy
 p1UWjvVVKZKKP3Ibzavv4zPkQ0tDFyyqfcLmuHiQ0vzwTSpAEBrHimqjB9/3Rhq+t646LNjMaS
 ipeGeO0aaDyZI17YpbuiX76NBT4h6XMarbgwTMqq//pq5BemZrKlnRZacLmuW++Px/5e8wLDo8
 F5vkG/0Mdr18BAAA=
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Andrew Morton <akpm@linux-foundation.org>, 
 Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
 Christoph Lameter <cl@linux.com>, Danilo Krummrich <dakr@kernel.org>, 
 Benno Lossin <lossin@kernel.org>, Yury Norov <yury.norov@gmail.com>, 
 Viresh Kumar <viresh.kumar@linaro.org>
Cc: Tyler Hicks <code@tyhicks.com>, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, linux-mm@kvack.org, 
 Mitchell Levy <levymitchell0@gmail.com>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756407651; l=3695;
 i=levymitchell0@gmail.com; s=20240719; h=from:subject:message-id;
 bh=yzEqjwShKdy3e5mR1Q+9kCEEyTAmDJsObfl1FvhOcqQ=;
 b=szSZ6PnGo1rOv2lpQujKqFXCXBiX7rWi8n06tjC0VQVqwcm+sm8wUQv0Q3w2KlYaoSTSlxz2F
 5CveT0mdIMoAkxde7vCtqtupVWOEbUbtFz9UY0lasC+pM3SlbBXFrDH
X-Developer-Key: i=levymitchell0@gmail.com; a=ed25519;
 pk=n6kBmUnb+UNmjVkTnDwrLwTJAEKUfs2e8E+MFPZI93E=

This series adds an API for declaring an using per-CPU variables from
Rust, and it also adds support for Rust access to C per-CPU variables
(subject to some soundness requirements). It also adds a small sample
module, samples/rust/rust_percpu.rs, in the vein of lib/percpu_test.c.

---
Signed-off-by: Mitchell Levy <levymitchell0@gmail.com>

---
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
Mitchell Levy (7):
      rust: percpu: introduce a rust API for per-CPU variables
      rust: percpu: add a rust per-CPU variable sample
      rust: cpumask: Add a `Cpumask` iterator
      rust: cpumask: Add getters for globally defined cpumasks
      rust: percpu: Support non-zeroable types for DynamicPerCpu
      rust: percpu: Add pin-hole optimizations for numerics
      rust: percpu: cache per-CPU pointers in the dynamic case

 rust/helpers/cpumask.c          |   5 +
 rust/helpers/helpers.c          |   2 +
 rust/helpers/percpu.c           |  20 +++
 rust/helpers/preempt.c          |  14 ++
 rust/kernel/cpumask.rs          |  94 ++++++++++++-
 rust/kernel/lib.rs              |   3 +
 rust/kernel/percpu.rs           | 239 +++++++++++++++++++++++++++++++++
 rust/kernel/percpu/cpu_guard.rs |  35 +++++
 rust/kernel/percpu/dynamic.rs   | 127 ++++++++++++++++++
 rust/kernel/percpu/numeric.rs   | 128 ++++++++++++++++++
 rust/kernel/percpu/static_.rs   | 132 +++++++++++++++++++
 samples/rust/Kconfig            |   9 ++
 samples/rust/Makefile           |   1 +
 samples/rust/rust_percpu.rs     | 284 ++++++++++++++++++++++++++++++++++++++++
 14 files changed, 1092 insertions(+), 1 deletion(-)
---
base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
change-id: 20240813-rust-percpu-ea2f54b5da33

Best regards,
-- 
Mitchell Levy <levymitchell0@gmail.com>


