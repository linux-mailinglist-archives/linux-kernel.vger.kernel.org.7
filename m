Return-Path: <linux-kernel+bounces-821767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F24B82322
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Sep 2025 00:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B8104888BE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 22:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCEE30F951;
	Wed, 17 Sep 2025 22:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="gJS0AlDu"
Received: from mail-10628.protonmail.ch (mail-10628.protonmail.ch [79.135.106.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96804273810;
	Wed, 17 Sep 2025 22:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758149644; cv=none; b=bsZFSdPt3uyWiqLMWflknFBeWt9FpDb/rlx7CgjKt9ZjshuA8pjorpp9H5KIVQHd/LIfRzLADmNzLsTnw99x2z0h/mBLAwGu34hdKzpFx+EFwx9Qyk7UvCHTvFbMOsHSIovF3jnztKnCn2yvqGh9BkTyrviG4cQLw6G7lBUQSmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758149644; c=relaxed/simple;
	bh=9+UVCe8WmKGioJeaplfY53Xsed6BsgXW5/+2Oh90GM4=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=aMgz/EQwAbV41LIXQDI70C0uUIJYhTc7tARX0zQeOeQ3WLSrHFQOvOTtXLreqNrAIvcPbKvTdAAsRBCEBzjDa6MN+vROhXqoE1xRUtivz1jthkRdvb0rQt4Nw3juMPv17duFpegj2Oi2EYkiDJPBRnVEvlv7EmgaO6l3I9PFmCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=gJS0AlDu; arc=none smtp.client-ip=79.135.106.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1758149634; x=1758408834;
	bh=Q5qspVNMpGUU2rhqy5PZwY/xTyF1BTlCFiE44W6OA/s=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=gJS0AlDu2FoIRjt0GneK57JwdDA9zWH5vOjD/w85QJI2uEjvqFeR3M8jjjTng9Rke
	 ivdBoEKbKJmTrSvyS9XWbcdPIdchRNRm8B/nQYMbFoU7bGZDotQaMzKrj2OhVP+5Sv
	 cRweDAsgqDN/7m5LtAGMJ5m1qNYuU4998mhHzEUf4qbHvrqI1YKd7Mj93HpKmOPCkY
	 WKGvv1JnWU1PGLYpR+LKWyJ3odOFduyAgQVVrlb3+tKI2ll7us66HyVdiDAPc6bzU1
	 jK3l6/QlVapqA+Rer0wlfIJyQn5K9eAOXO6QlziG3N0wExvoAGB9PBQLrhyDx8gg5X
	 kV2guZRNWWRZQ==
Date: Wed, 17 Sep 2025 22:53:50 +0000
To: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
From: Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc: a.hindborg@kernel.org, alex.gaynor@gmail.com, aliceryhl@google.com, benjamin.tissoires@redhat.com, benno.lossin@proton.me, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, dakr@kernel.org, db48x@db48x.net, gary@garyguo.net, jikos@kernel.org, ojeda@kernel.org, peter.hutterer@who-t.net, tmgross@umich.edu, Rahul Rameshbabu <sergeantsagara@protonmail.com>
Subject: [PATCH v4 0/2] Initial work for Rust abstraction for HID device driver development
Message-ID: <20250917225341.4572-1-sergeantsagara@protonmail.com>
Feedback-ID: 26003777:user:proton
X-Pm-Message-ID: d35ade03161af96fc0b4b9812fe140c177dc2f37
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I wanted to thank Benjamin for his response on the previous v3 RESEND.
Greatly appreciated. I have gone ahead with some minor logistically changes
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
 drivers/hid/hid-glorious.c            |   2 +
 drivers/hid/hid_glorious_rust.rs      |  60 ++++
 drivers/hid/rust/Kconfig              |  28 ++
 drivers/hid/rust/Makefile             |   6 +
 drivers/hid/rust/hid_glorious_rust.rs |  60 ++++
 rust/bindings/bindings_helper.h       |   3 +
 rust/kernel/hid.rs                    | 497 ++++++++++++++++++++++++++
 rust/kernel/lib.rs                    |   2 +
 10 files changed, 674 insertions(+)
 create mode 100644 drivers/hid/hid_glorious_rust.rs
 create mode 100644 drivers/hid/rust/Kconfig
 create mode 100644 drivers/hid/rust/Makefile
 create mode 100644 drivers/hid/rust/hid_glorious_rust.rs
 create mode 100644 rust/kernel/hid.rs


base-commit: 657403637f7d343352efb29b53d9f92dcf86aebb
--=20
2.51.0



