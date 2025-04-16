Return-Path: <linux-kernel+bounces-606539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16490A8B078
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 08:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BD5017C997
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Apr 2025 06:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A76229B13;
	Wed, 16 Apr 2025 06:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OaA54IXz"
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5011DB34E
	for <linux-kernel@vger.kernel.org>; Wed, 16 Apr 2025 06:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744785595; cv=none; b=E3yVL6Qe6MwTcqqdbPT4wCnslEiVhM5kFxdxniKTFtMMolo203xtfPDanH3WIWOrMGt6AjO4NURGMO9OebLFzr/LtIuSq2/2hcdROFpmY8w8XMEjjXtU7gRZGJsNW+fz9hX4sDpXgFaEe7xToLjij0gI5FKi1J+LnIXTa/ZhNBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744785595; c=relaxed/simple;
	bh=HI4pbslruePNiTAbh5gqsZgdMGgDRqUxwM+XevrO+Pg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FUsxuU0VZDCKbUz3xWXtcwKbwJELS/IzniccCQwWfiVJzGQsB6LVOmy6ioMu6b4iuDmBYKhIwEi8ozxHbz1o74gy9zAW791SXAK06sP8OWTlPAL+ZS5HfyGmNE0hf9GX5V+SPBUpD1IvGv3+4rabFAmjVUKLvJzVP9ACAdFoYzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OaA54IXz; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-301918a4e1bso5037128a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Apr 2025 23:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744785592; x=1745390392; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ylu6AhIoWiuJhO+ekGRtzlalkAr5ceAZvwt6SfVp77o=;
        b=OaA54IXzn1r9R9dsr2qMTb69KT1LX2fdcnv9gy7cFJOn0h/tagWI24oKzMyEbnRqlM
         sep7Jd9hy9zsBPdS2mqArwLgdBYLR1FvBgceSfSGCXu07vLs7zSOnjk9ypE6B2W1m0A9
         rTqvjN8ZwUNXPpe6xilDF03TNhIqu0xUGh6TefVYhY/Chki+mjBzbJsjWKdj/r8HFGSe
         lHcSTkGV7rAwFILJyvWB+E1tagdT8nQ06ad08nvIYO/L1KBHciQbX+a0L4nR7+e6eJUv
         VAl4U8CvllwzP6TBlmkjWeCdv/xDOjyYvSEuYP6uxyyeR+TTgSIfHb7SlQpZwn4zjiBS
         9/aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744785592; x=1745390392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ylu6AhIoWiuJhO+ekGRtzlalkAr5ceAZvwt6SfVp77o=;
        b=JlcTMRaaeqGSQodro/68VkkLufacovexfzddatW6nL6OLksxWTCLRrJAs/8ebyiynt
         tpAIROryRKKQbmj7w1ue7eR6tXg+Mg/N1UjABuvXotR/+jhRzp86yeKTNawD+wuFeH8Z
         xp5GAAfe/UDnuFvd7+nZk9FWD2pGQoXIpNQJ9segwmgCdQwVE+gjiwoJTWnrpJSM7muQ
         8b8IOh9XEFURBq6Wfe/1mu4m4UfRWukU/iqGmuossOZSiOOcJv8lNXajf52QCDMwGdhE
         ArO/Zzk5kx7HOatkMDBOAJVCkQrt8lsQ+vhf6vVFKCiqFOgxt6Yb1Y+We/zP40lXFYhn
         TTOA==
X-Forwarded-Encrypted: i=1; AJvYcCUYzfrA1MW61GL1yThKEQYfSdZ22LPwrsLcBvbP6dpBfMHt5Ldr2oA8NVBQlDSdNwnKBU3GjDiFWkvL9t4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh5AqQVfzyairmiXqhRr+q59SkrjqDNdEXsHYKRZV5k2EkIhq8
	AvHTZ5FC+73TKBXeZWfoQXJbTV+eJRNTFb6Kf1rHuZN1Q2/6BcnTJO6ssrPfa5Y=
X-Gm-Gg: ASbGncuxULvG/THcjD7UcrXMlBRTOPDqAH7zT3DOwXZcauBZNHqOhFu6WRw1HipLfeA
	NOmqBDwnHFLFB+6yj1XTCrVzPNuptfESin6Mh8ozEgk07I60yrThUkZZV4gLchnMWkgQAZCbayG
	f2YHSw1QJDuE6j45ISc+pZTi06DW6SuIwR5lZ6dqf0Bd5YEnGhWpkcXimY6Ud8J8LDhMd155+xK
	K5daoMXnAyeB3VNZf6LIf+/gJd5XUdBTDkcC7bVffxOFJY7+WMZdzwPA8j+tUjaNLdXcsU8pQvf
	kMo7TAGTilasMBnejixanoDwxM5+yvUGP7sPYIP9tw==
X-Google-Smtp-Source: AGHT+IFgWqv8VMoJN8BwxdKq91EbTInLCJldWjcRgfV4RZstK6Vh3XF5u8IeYaIAR54psCJCGXCoDA==
X-Received: by 2002:a17:90b:3c0c:b0:2fe:7fea:ca34 with SMTP id 98e67ed59e1d1-308641725d2mr817134a91.32.1744785591746;
        Tue, 15 Apr 2025 23:39:51 -0700 (PDT)
Received: from localhost ([122.172.83.32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-308612130c2sm757580a91.29.2025.04.15.23.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 23:39:51 -0700 (PDT)
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Danilo Krummrich <dakr@redhat.com>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Benno Lossin <benno.lossin@proton.me>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	Michael Turquette <mturquette@baylibre.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nishanth Menon <nm@ti.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Trevor Gross <tmgross@umich.edu>,
	Viresh Kumar <vireshk@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Yury Norov <yury.norov@gmail.com>
Cc: linux-pm@vger.kernel.org,
	Vincent Guittot <vincent.guittot@linaro.org>,
	rust-for-linux@vger.kernel.org,
	Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Joakim Bech <joakim.bech@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Burak Emir <bqe@google.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Russell King <linux@armlinux.org.uk>,
	linux-clk@vger.kernel.org,
	Anisse Astier <anisse@astier.eu>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V10 00/15] Rust abstractions for clk, cpumask, cpufreq, OPP
Date: Wed, 16 Apr 2025 12:09:17 +0530
Message-Id: <cover.1744783509.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This series introduces initial Rust abstractions for a few subsystems: clk,
cpumask, cpufreq and Operating Performance Points (OPP).

The abstractions cover most of the interfaces exposed by cpufreq and OPP
subsystems. It also includes minimal abstractions for the clk and cpumask
frameworks, which are required by the cpufreq / OPP abstractions.

Additionally, a sample `rcpufreq-dt` driver is included. This is a
duplicate of the existing `cpufreq-dt` driver, which is a
platform-agnostic, device-tree based cpufreq driver commonly used on ARM
platforms.

The implementation has been tested using QEMU, ensuring that frequency
transitions, various configurations, and driver binding/unbinding work as
expected. However, performance measurements have not been conducted yet.

For those interested in testing these patches, they can be found at:

git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git rust/cpufreq-dt

Based on 6.15-rc1.

V9->V10:
- Don't remove atomic cpumask bindings from rust/helpers/cpumask.c
- Rename from_raw/from_raw_mut to as_ref/as_mut_ref (cpumask).
- Improved comments for non-atomic methods (cpumask).
- s/new/new_zero/ and s/new_uninit/new/ (cpumask).
- Avoid using explicit casts `as *const` or `as *mut`.
- Renamed `cpumask_box` to `cpumask_var` and `cpus`.
- Add local types in Rust for cpufreq flags that use BIT().
- Add const initializer for cpufreq::Registration and simplify new().
- Improved few safety comments.

V8->V9:
- clk (changes since V4):
  - V4: https://lore.kernel.org/all/cover.1742276963.git.viresh.kumar@linaro.org/
  - Add more methods in Hertz (as_khz/mhz/ghz).
  - Reword a comment.

- cpumask (changes since V4):
  - V4: https://lore.kernel.org/all/cover.1743572195.git.viresh.kumar@linaro.org/
  - Add support for cpumask_{test_cpu|empty|full} and switch to using non-atomic
    helpers for set/clear.
  - s/CpumaskBox/CpumaskVar/
  - s/set_all/setall/
  - Improved examples, comments and commit logs.

- cpufreq/opp:
  - V8: https://lore.kernel.org/all/cover.1738832118.git.viresh.kumar@linaro.org/
  - Based on review comments received for clk/cpumask, a lot of changes were
    made to cpufreq/opp bindings in code, comments, examples, etc..
  - `attr` fields were dropped from cpufreq support, not required anymore
    because of latest changes in cpufreq core.
  - Use Hertz/MicroVolt/MicroWatt as units.
  - Lots of other cleanups.
  - Dropped Reviewed-by from Manos (there were too many changes).

V7->V8:
- Updated cpumask bindings to work with !CONFIG_CPUMASK_OFFSTACK case.
- Dropped few patches (property_present() and opp helpers), as they are already
  merged.
- from_cpu() is marked unsafe.
- Included a patch by Anisse Astier, to solve a long standing issue with this
  series.
- Dropped: "DO-NOT_MERGE: cpufreq: Rename cpufreq-dt platdev."
- Updated MAINTAINERS for new files.
- Other minor changes / cleanups.

V6->V7:
- from_cpu() is moved to cpu.rs and doesn't return ARef anymore, but just a
  reference.
- Dropped cpufreq_table_len() and related validation in cpufreq core.
- Solved the issue with BIT() macro differently, using an enum now.
- Few patches are broken into smaller / independent patches.
- Improved Commit logs and SAFETY comments at few places.
- Removed print message from cpufreq driver.
- Rebased over linux-next/master.
- Few other minor changes.

V5->V6:
- Rebase over latest rust/dev branch, which changed few interfaces that the
  patches were using.
- Included all other patches, which weren't included until now to focus only on
  core APIs.
- Other minor cleanups, additions.

V4->V5:
- Rename Registration::register() as new().
- Provide a new API: Registration::new_foreign_owned() and use it for
  rcpufreq_dt driver.
- Update MAINTAINERS file.

V3->V4:
- Fix bugs with freeing of OPP structure. Dropped the Drop routine and fixed
  reference counting.
- Registration object of the cpufreq core is modified a bit to remove the
  registered field, and few other cleanups.
- Use Devres for instead of platform data.
- Improve SAFETY comments.

V2->V3:
- Rebased on latest rust-device changes, which removed `Data` and so few changes
  were required to make it work.
- use srctree links (Alice Ryhl).
- Various changes the OPP creation APIs, new APIs: from_raw_opp() and
  from_raw_opp_owned() (Alice Ryhl).
- Inline as_raw() helpers (Alice Ryhl).
- Add new interface (`OPP::Token`) for dynamically created OPPs.
- Add Reviewed-by tag from Manos.
- Modified/simplified cpufreq registration structure / method a bit.

V1->V2:
- Create and use separate bindings for OF, clk, cpumask, etc (not included in
  this patchset but pushed to the above branch). This helped removing direct
  calls from the driver.
- Fix wrong usage of Pinning + Vec.
- Use Token for OPP Config.
- Use Opaque, transparent and Aref for few structures.
- Broken down into smaller patches to make it easy for reviewers.
- Based over staging/rust-device.

--
Viresh

Anisse Astier (1):
  rust: macros: enable use of hyphens in module names

Viresh Kumar (14):
  rust: cpumask: Add few more helpers
  rust: cpumask: Add initial abstractions
  MAINTAINERS: Add entry for Rust cpumask API
  rust: clk: Add helpers for Rust code
  rust: clk: Add initial abstractions
  rust: cpu: Add from_cpu()
  rust: opp: Add initial abstractions for OPP framework
  rust: opp: Add abstractions for the OPP table
  rust: opp: Add abstractions for the configuration options
  rust: cpufreq: Add initial abstractions for cpufreq framework
  rust: cpufreq: Extend abstractions for policy and driver ops
  rust: cpufreq: Extend abstractions for driver registration
  rust: opp: Extend OPP abstractions with cpufreq support
  cpufreq: Add Rust-based cpufreq-dt driver

 MAINTAINERS                     |   11 +
 drivers/cpufreq/Kconfig         |   12 +
 drivers/cpufreq/Makefile        |    1 +
 drivers/cpufreq/rcpufreq_dt.rs  |  233 ++++++
 rust/bindings/bindings_helper.h |    4 +
 rust/helpers/clk.c              |   66 ++
 rust/helpers/cpufreq.c          |   10 +
 rust/helpers/cpumask.c          |   25 +
 rust/helpers/helpers.c          |    2 +
 rust/kernel/clk.rs              |  318 ++++++++
 rust/kernel/cpu.rs              |   30 +
 rust/kernel/cpufreq.rs          | 1277 +++++++++++++++++++++++++++++++
 rust/kernel/cpumask.rs          |  330 ++++++++
 rust/kernel/lib.rs              |    8 +
 rust/kernel/opp.rs              | 1140 +++++++++++++++++++++++++++
 rust/macros/module.rs           |   20 +-
 16 files changed, 3479 insertions(+), 8 deletions(-)
 create mode 100644 drivers/cpufreq/rcpufreq_dt.rs
 create mode 100644 rust/helpers/clk.c
 create mode 100644 rust/helpers/cpufreq.c
 create mode 100644 rust/kernel/clk.rs
 create mode 100644 rust/kernel/cpu.rs
 create mode 100644 rust/kernel/cpufreq.rs
 create mode 100644 rust/kernel/cpumask.rs
 create mode 100644 rust/kernel/opp.rs

-- 
2.31.1.272.g89b43f80a514


