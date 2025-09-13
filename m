Return-Path: <linux-kernel+bounces-815285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32DC8B56227
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 18:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E63923BFFA3
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Sep 2025 16:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94BC2ECEB2;
	Sat, 13 Sep 2025 16:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="fHEkrPZC"
Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch [109.224.244.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C06A8460
	for <linux-kernel@vger.kernel.org>; Sat, 13 Sep 2025 16:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757779974; cv=none; b=ayM5BXGP4oMJArMGcvM26J4OIBYf6JxaNtcaCSTGShJ6l8WyUEYEOo5nk5Td1jKvsxUWVKd9STI8+vfkrUDKXLEg4MF9NTvfb4x2hIrn9MumVbYuAze2j+7iRD6krJ4+6f8ByPj7xMF7A6HqxJk+9KKfnwkLR4foagH6iafJGjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757779974; c=relaxed/simple;
	bh=I8jMpUr68XX+6gm0f6J6zT3Hf0r17Zmm25fJRdup2qY=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=uJKvGmRE/WHjiy46n+7foSolon3qbvzbytUGZ0Pe+88Z4KYrBQu6499T66EcVIlZdLPEA2iswxMXAAgUwWF9YRHMJaytAZElffccPB9qXWkBJchM/bIBpmjVjeJiKTrTv4SCR90MYxtRStNb78PhoSo+e3OVCSReUGC7L/GiSYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=fHEkrPZC; arc=none smtp.client-ip=109.224.244.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1757779968; x=1758039168;
	bh=HTRRFLQA4W58CnoPCKMcmuL1LZdQbPIxjemOCUYV6oY=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=fHEkrPZCr8rk5BZr37ke5tCIWoZSTud/Yx45rPa5lBhHgpD94ZemdyGxgSN8On7bI
	 wA2Fu8tSvr5E5ijIlcg8uQ8214eTmG6yyx2/AWEAjt5BLMQ1TFv3LGe3mNCu5HNk0n
	 48/0yjBveh/hGWSnGFgU2gC+NfgMtfvRBt5/qINb2CyUGuoQUMFzW3yQDju1QBa5FO
	 eJVRxhtiaVBV7zZtTTeCvpaS1jtu7n51tBrZkA9O6HGIydc4JN10xtV0X1Zs+9jP+l
	 HktgD3vHTVdEkK9FG5zbpdUzXrEJPnPnDlQlXgkbMVkqe5pza7JrpoUjnuJTsK2b4y
	 PZncIyAk2jd+g==
Date: Sat, 13 Sep 2025 16:12:43 +0000
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
From: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, a.hindborg@kernel.org, alex.gaynor@gmail.com, aliceryhl@google.com, benno.lossin@proton.me, Benjamin Tissoires <benjamin.tissoires@redhat.com>, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, dakr@kernel.org, db48x@db48x.net, gary@garyguo.net, ojeda@kernel.org, tmgross@umich.edu, peter.hutterer@who-t.net, Rahul Rameshbabu <sergeantsagara@protonmail.com>
Subject: [PATCH v3 RESEND RESEND 0/3] Initial work for Rust abstraction for HID device driver development
Message-ID: <20250913161222.3889-1-sergeantsagara@protonmail.com>
Feedback-ID: 26003777:user:proton
X-Pm-Message-ID: 9458c0e7b09b92054a04ca476221929edf7ac6b6
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello again,

I am doing another resend. Let me know if it makes sense to start sending o=
ut
work I have on top of these changes. I wanted to wait till these changes go=
t
merged first but maybe that is not the right strategy?

https://lore.kernel.org/rust-for-linux/20250721020211.196394-2-sergeantsaga=
ra@protonmail.com/

I incorporated Danilo's and Miguel's feedback from my v2. Additionally, I
noticed I had basic formatting issues when running scripts/checkpatch.pl.
I made sure to check the generated rustdocs and that the Rust examples
compile as part of the kunit infrastructure. I dropped the kref bindings
as they are no longer needed for this series.

Link: https://lore.kernel.org/rust-for-linux/20250808061223.3770-1-sergeant=
sagara@protonmail.com/
Link: https://lore.kernel.org/rust-for-linux/20250721020211.196394-2-sergea=
ntsagara@protonmail.com/
Link: https://lore.kernel.org/rust-for-linux/20250713211012.101476-4-sergea=
ntsagara@protonmail.com/
Link: https://lore.kernel.org/rust-for-linux/20250629045031.92358-2-sergean=
tsagara@protonmail.com/
Link: https://lore.kernel.org/rust-for-linux/20250313160220.6410-2-sergeant=
sagara@protonmail.com/
Link: https://binary-eater.github.io/tags/usb-monitor-control/

Rahul Rameshbabu (3):
  HID: core: Change hid_driver to use a const char* for name
  rust: core abstractions for HID drivers
  rust: hid: Glorious PC Gaming Race Model O and O- mice reference
    driver

 MAINTAINERS                      |  16 +
 drivers/hid/Kconfig              |  16 +
 drivers/hid/Makefile             |   1 +
 drivers/hid/hid-glorious.c       |   2 +
 drivers/hid/hid_glorious_rust.rs |  60 ++++
 include/linux/hid.h              |   2 +-
 rust/bindings/bindings_helper.h  |   3 +
 rust/kernel/hid.rs               | 503 +++++++++++++++++++++++++++++++
 rust/kernel/lib.rs               |   2 +
 9 files changed, 604 insertions(+), 1 deletion(-)
 create mode 100644 drivers/hid/hid_glorious_rust.rs
 create mode 100644 rust/kernel/hid.rs


base-commit: 1523590203786bf4e1d29b7d08a7100c783f20ba
--=20
2.47.2



