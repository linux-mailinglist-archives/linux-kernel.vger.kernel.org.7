Return-Path: <linux-kernel+bounces-730643-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49F80B04789
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 20:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6A8C4A36EB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jul 2025 18:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58CFB273D89;
	Mon, 14 Jul 2025 18:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="nRtBvyzf"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2EC25B66A;
	Mon, 14 Jul 2025 18:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752519145; cv=none; b=ngZGeWBdcWVIPytzM9KCbcmtY51W/nGkstuqXo+A74EOaYdd5hax8jmpf9HY6Umcn0M3/SOijGndRqtY3tuATYgqv1ypxgTng1jA+NySTwbbUkuICwsGeJKK54u5iZZSHzQO3IyQvSP9/lQWapMoLSoi5csQ+vQbn9lpTSdONl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752519145; c=relaxed/simple;
	bh=eTQVHiD2DBqTrTHdXQdwOxgTOu4JnTGjuuUnROq9D6Y=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=q1kmGp+YghetPkbPwS/lY49YUsBns4DhQFLnwljWxK22YvxAXLmpdHCR59z/WKGpC0+dvAGz648S8uvdwkyXtLc/RmvG6SDt/3Rv84PiPERFUGkayIlJ7ny9YT56H95lVhm+HqqL7hjb56azIw0KOCkg0L9RhuIq7aRdac6txlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=nRtBvyzf; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1752519141;
	bh=eTQVHiD2DBqTrTHdXQdwOxgTOu4JnTGjuuUnROq9D6Y=;
	h=From:Subject:Date:To:Cc:From;
	b=nRtBvyzfHNl4GBpM+SHe2jE9rz/WgWoBXT8FBodCy9V9gq2sOgl24nacX2o/31ibe
	 KmPEqe1VA3E1EsTWjhBrIodZELyY7NGEkYPznXmGBLM233s6fSfzIMZs0Tg2PHHyCM
	 Y0EbKsfxuFWlCJ4foFi6504GTBrNSz0LC3Kk9c2EKGjCTHE4bpvvzsqWANbO8g1Oax
	 YTkap++d+hXLRl9/ZjGOpqfQK7mLGP71OT2IRuTuLDXdNk7mwUZiizCBD8nZ2+hHaA
	 swNGjAQAPrC1w7Y38x6JRSbnZVxAkUJ+sgsW357n9fw1wLerwivig7cUG0zVyqR7V7
	 IOJn5O97C1rKw==
Received: from [192.168.0.2] (unknown [IPv6:2804:14d:72b4:82f6:67c:16ff:fe57:b5a3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dwlsalmeida)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6AE2B17E0DD7;
	Mon, 14 Jul 2025 20:52:19 +0200 (CEST)
From: Daniel Almeida <daniel.almeida@collabora.com>
Subject: [PATCH v8 0/2] Add a bare-minimum Regulator abstraction
Date: Mon, 14 Jul 2025 15:52:03 -0300
Message-Id: <20250714-topics-tyr-regulator2-v8-0-c7ab3955d524@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANNRdWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyLHQUlJIzE
 vPSU3UzU4B8JSMDI1MDc0MT3ZL8gszkYt2SyiLdotT00pzEkvwiI13jxNTkFFMTS6MkoxQloN6
 CotS0zAqwudGxtbUAb7cezWcAAAA=
X-Change-ID: 20250714-topics-tyr-regulator2-3aecd5492b2d
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.14.2

Changes in v8:
- Added Alex's r-b
- Added helpers/regulator.c, since the stubs are declared as inline if
  CONFIG_REGULATOR is not set (Intel bot)
- Removed unneeded "regulator.enable()" line from docs: it was not needed
  and, ironically, it misused the API by choosing Regulator<Dynamic>
  and then not keeping the enabled count count balenced (Alex)
- Clarified that the "Enabled" state decreases the enabled refcount when it
  drops (Alex)
- Renamed "Microvolt" as "Voltage" and introduced
  from_microvolts/as_microvolts (Alex)
- Fixed the spelling for MAINTAINERS in the second commit (Alex)
- Link to v7: https://lore.kernel.org/rust-for-linux/20250704-topics-tyr-regulator-v7-0-77bfca2e22dc@collabora.com/

Changes in v7:
- Add RegulatorState::DISABLE_ON_DROP (Alice)
- Remove #[cfg(CONFIG_REGULATOR)] in lib.rs (if this is N we will use
  the stubs)
- Add the bound on 'static directly on RegulatorState to avoid
  repetition
- Removed the `data` member on the example (Alice)
- Removed the `mut` token from try_into_enabled() and
  try_into_disabled() (Miguel & Intel bot)
- Link to v6: https://lore.kernel.org/r/20250627-topics-tyr-regulator-v6-0-1d015219b454@collabora.com

Changes in v6:
- Use ManuallyDrop<T> to avoid running the destructor in
  try_into_enabled() and try_into_disabled(). This is the same strategy
  that was being used successfully in the pre-typestate version of this
  patch
- Link to v5: https://lore.kernel.org/r/20250623-topics-tyr-regulator-v5-0-99069658cb54@collabora.com

Changes in v5:
- Remove TryIntoEnabled and TryIntoDisabled traits (they were only
  implemented for a single type anyways)
- Added regulator.rs to VOLTAGE AND CURRENT REGULATOR FRAMEWORK
- Applied the diff from Miguel Ojeda to format the docs
- Link to v4: https://lore.kernel.org/r/20250609-topics-tyr-regulator-v4-1-b4fdcf1385a7@collabora.com

Changes in v4:
- Rewrote the abstraction to use typestates as per the suggestions by
  Benno and Alex.
- Introduced the `Dynamic` state.
- Added more examples.
- Fixed some broken docs.
- Link to v3: https://lore.kernel.org/r/20250513-topics-tyr-regulator-v3-1-4cc2704dfec6@collabora.com

Changes in v3:
- Rebased on rust-next
- Added examples to showcase the API
- Fixed some rendering issues in the docs
- Exposed {get|set}_voltage for both Regulator and EnabledRegulator
- Derived Clone, Copy, PartialEq and Eq for Microvolt
- Link to v2: https://lore.kernel.org/r/20250326-topics-tyr-regulator-v2-1-c0ea6a861be6@collabora.com

Resend v2:
  - cc Regulator maintainers
Changes from v1:
  - Rebased on rust-next
  - Split the design into two types as suggested by Alice Ryhl.
  - Modify the docs to highlight how users can use kernel::types::Either
    or an enum to enable and disable the regulator at runtime.
  - Link to v1: https://lore.kernel.org/rust-for-linux/20250219162517.278362-1-daniel.almeida@collabora.com/

---
Daniel Almeida (2):
      rust: regulator: add a bare minimum regulator abstraction
      MAINTAINERS: add regulator.rs to the regulator API entry

 MAINTAINERS                     |   1 +
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/helpers.c          |   1 +
 rust/helpers/regulator.c        |  43 +++++
 rust/kernel/lib.rs              |   1 +
 rust/kernel/regulator.rs        | 418 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 465 insertions(+)
---
base-commit: e04c78d86a9699d136910cfc0bdcf01087e3267e
change-id: 20250714-topics-tyr-regulator2-3aecd5492b2d

Best regards,
-- 
Daniel Almeida <daniel.almeida@collabora.com>


