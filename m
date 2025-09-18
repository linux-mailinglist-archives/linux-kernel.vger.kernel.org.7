Return-Path: <linux-kernel+bounces-822195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35338B83439
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 09:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF4C81C20520
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 07:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585092DFA26;
	Thu, 18 Sep 2025 07:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="XlBglBRF"
Received: from mail-10628.protonmail.ch (mail-10628.protonmail.ch [79.135.106.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0E623BCF0
	for <linux-kernel@vger.kernel.org>; Thu, 18 Sep 2025 07:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758179321; cv=none; b=UMo50IjMqmt6cAM+qaYnQ5fIDB+AZx6EOKmdCpvstl0mpV3LldS//cihPeeVEX09utrRf68mEO39z/H5PGsv9V7JRLSrvHW/fNOYibr2VgdgVaykQ8yPIAyJBrN4QUNLGnCM2nMxhQyEc9PomUQYsxnbAE/5GU1C7cBEBLlXlaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758179321; c=relaxed/simple;
	bh=2Fq72gcZ7a03LjbxYRbcM9QBgxuKhj6eC6DiaxDA8hY=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=hRKtF9zWWCwDIXdwz1IgAGTK4MjkI4RVpdjBolGAVSNS5pE7wvyQfaGdHG740ywHwFWt1iI8EPJA8FAZ9Tjuxtt2f7PGcZ+yCCxrzuEXC4hdmJjauJAGU7dBhgacCHkZy2Eix7XN5uu10yGSPu6PvfHzFS78J8gZrZKPcTYCjjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=XlBglBRF; arc=none smtp.client-ip=79.135.106.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1758179316; x=1758438516;
	bh=G18Lwbk4LeVocyoPjOlUgmWjaKT4pQvEdGV2DKNp9MU=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=XlBglBRFcRSDdCkK21Y14twJhmv1Ihq+KUewWSo3gVwNCda3SPrFnTqJGkg5sjfUx
	 K8d2kf7Kc/PTEjUT00qyAxNZkXIwIhaZv/jy880H+5aVCDasDPsd7LA9pVyupCHCJr
	 +64WyRmHm9UduI0SGEQnm4HthWRpXya/STku7iga8j2mvGyx4c67hSD1VuycKKF1U7
	 +1YPFSXN7v4UsPGG/iFPhTWrnpc558b5M7GxHJK8+9waaWzMYKxftulewzRPyoX6li
	 7KJNn2Yl4QupMSnC3MRopoZ4HvTEdthImMGdN7mhqKpHxaj9WhEOkgJVGHuZKDMhtd
	 sL7E4FVJOlR0g==
Date: Thu, 18 Sep 2025 07:08:30 +0000
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
From: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc: a.hindborg@kernel.org, alex.gaynor@gmail.com, aliceryhl@google.com, benjamin.tissoires@redhat.com, benno.lossin@proton.me, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, dakr@kernel.org, db48x@db48x.net, gary@garyguo.net, jikos@kernel.org, ojeda@kernel.org, peter.hutterer@who-t.net, tmgross@umich.edu, Rahul Rameshbabu <sergeantsagara@protonmail.com>
Subject: [PATCH v5 0/2] Initial work for Rust abstraction for HID device driver development
Message-ID: <20250918070824.70822-1-sergeantsagara@protonmail.com>
Feedback-ID: 26003777:user:proton
X-Pm-Message-ID: a62392e7296436a68d693ede3507a9fb03c13dbb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Haa.... My v4 had a build system bug, so I never properly test
GloriousRust. I did not implement the RawDeviceIdIndex trait in v4. My v5
should properly exercise the reference driver.

I wanted to thank Benjamin for his response on the previous v3 RESEND.
Greatly appreciated. I have gone ahead with some minor logistical changes
in the series, based on his response. I have dropped the C patch since he
also took that patch into the hid tree in v3.

Link: https://lore.kernel.org/rust-for-linux/wjfjzjc626n55zvhksiyldobwubr2i=
mbvfavqej333lvnka2wn@r4zfcjqtanvu/
Link: https://lore.kernel.org/rust-for-linux/175810473311.3076338.143091013=
39951114135.b4-ty@kernel.org/

Rahul Rameshbabu (2):
  rust: core abstractions for HID drivers
  rust: hid: Glorious PC Gaming Race Model O and O- mice reference
    driver

 MAINTAINERS                           |  14 +
 drivers/hid/Kconfig                   |   2 +
 drivers/hid/Makefile                  |   2 +
 drivers/hid/hid-glorious.c            |   2 +
 drivers/hid/hid_glorious_rust.rs      |  60 +++
 drivers/hid/rust/Kconfig              |  28 ++
 drivers/hid/rust/Makefile             |   6 +
 drivers/hid/rust/hid_glorious_rust.rs |  60 +++
 rust/bindings/bindings_helper.h       |   3 +
 rust/kernel/hid.rs                    | 513 ++++++++++++++++++++++++++
 rust/kernel/lib.rs                    |   2 +
 11 files changed, 692 insertions(+)
 create mode 100644 drivers/hid/hid_glorious_rust.rs
 create mode 100644 drivers/hid/rust/Kconfig
 create mode 100644 drivers/hid/rust/Makefile
 create mode 100644 drivers/hid/rust/hid_glorious_rust.rs
 create mode 100644 rust/kernel/hid.rs


base-commit: 657403637f7d343352efb29b53d9f92dcf86aebb
--=20
2.51.0



