Return-Path: <linux-kernel+bounces-785397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C985B34A12
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 20:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCAE13ABFFD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Aug 2025 18:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D113090FD;
	Mon, 25 Aug 2025 18:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="Dgfgclea"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D220F2FD1D4;
	Mon, 25 Aug 2025 18:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756145938; cv=pass; b=S8i6wPGPXVE6NUpHUTwzag7OvVx0v875tL1sEKwcFMFpr8gAcNafCqoSRCj/pWZN2gJERUd6/Jd2cvUMqdCIT4gpaeB6fGiGP2SLfUf+oawt2bIpBbnuhILchTP7txqzTY9ntv+OoI5dXH0qf2s4+CoTfdJtZk/yCDwg08ULZcQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756145938; c=relaxed/simple;
	bh=3zG5PWohBglYztGgAsj5Yc0sdnwJfXcMbiKQjfVyYTg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=hRK+tnZEDhF6wzwoF9gB+FKRbGC3nJsjJF6gIOxRnpPnlGyoqDuV4zEMCft4ZT+IF6cA+CwphFcRoc+g8TO3ydtXF0OkoSgl5klDQ/FCgSRwXmZ4WJBXJZCV4+JPl4PnDxv3lUQ9J5v9uv8XKxR/JUsDl/PKPeVhaH7sfDO3gA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=Dgfgclea; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1756145920; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nok+UyPnernefB2Ng4tgXPbs8TpTs6Snp1Y54qTU3mI8r5R/OpuQ+kPncMVR8DeH4urVo702fFE1uTnzyTGFn7ylKhw7jXhGn2RLJ1v0XYL5jq37tXnWuiqjYZGAPzxqYjO6ifvyjmICX54EzDxiynYGpGTzk3t/t2C1VvvrQEY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1756145920; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=F3JKEDd8NLA8oG5s5VElI0Z3scwvrJyrGva6SN3G44U=; 
	b=EKnfZNRh15LTpvuyxp5lZOHchcucmKzOZVK0+9BKGOgM1K5CuiNpkw2XJMyzwGV0yP8MAOn8PiJuHBbxO6bpwstXlF1klTzcv7RZZrhUHucQLUJh4WS699rP6DcsDixd+AGnnM6C4BiUMor1Lh5JHXGgcA1JAruqd5qwyeTzRQ0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1756145920;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=F3JKEDd8NLA8oG5s5VElI0Z3scwvrJyrGva6SN3G44U=;
	b=Dgfgcleakx2a0CbpRJzAJn20d5VLDn7PMY5jD/xv++QkPU7WK7XKI4N7yV8lO+8L
	ll8YSHlYeSFkYqPh8q6B5EnavPCeYvEmqSZVppGog55i25eVtc2Sxgef3YSLASCflSq
	grIkCQjPeuW4tzC/P6ksSNzwnfSgZRUkv6x2MICs=
Received: by mx.zohomail.com with SMTPS id 1756145917509114.81336748548438;
	Mon, 25 Aug 2025 11:18:37 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Subject: [PATCH 0/2] rust: usb: add initial USB abstractions
Date: Mon, 25 Aug 2025 15:18:04 -0300
Message-Id: <20250825-b4-usb-v1-0-7aa024de7ae8@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANyorGgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDCyNT3SQT3dLiJN2UFIO0VBOTtBRziyQloOKCotS0zAqwQdGxtbUAdxS
 WFVgAAAA=
X-Change-ID: 20250825-b4-usb-dd0fe44fd78b
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 linux-usb@vger.kernel.org, Daniel Almeida <daniel.almeida@collabora.com>
X-Mailer: b4 0.14.2
X-ZohoMailClient: External

This adds initial support for USB Rust drivers, not only because I see a
widespread use of module_usb_driver() in media (which is a subsystem I
aim to support) but also because I want to learn about USB in general
and this is a nice opportunity to start doing so.

I tried to keep things as consistent with pci.rs and platform.rs as
possible and tested it by manually binding a device (i.e.: my Logitech
mouse) to the sample driver via:

/sys/bus/usb/drivers/rust_driver_usb/new_id

This initial patch is therefore comprised of the same patterns that are
known to work for pci and platform already.

Physically disconnecting the device also worked, i.e.: nothing bad
showed up in dmesg.

Note that I did not touch MAINTAINERS at all. The objective is to
kickstart the discussion of what to do there here in v1.

---
Daniel Almeida (2):
      rust: usb: add basic USB abstractions
      samples: rust: add a USB driver sample

 rust/bindings/bindings_helper.h |   1 +
 rust/helpers/helpers.c          |   1 +
 rust/helpers/usb.c              |   8 +
 rust/kernel/lib.rs              |   2 +
 rust/kernel/usb.rs              | 457 ++++++++++++++++++++++++++++++++++++++++
 samples/rust/Kconfig            |  11 +
 samples/rust/Makefile           |   1 +
 samples/rust/rust_driver_usb.rs |  47 +++++
 8 files changed, 528 insertions(+)
---
base-commit: 44d454fcffa8b08d6d66df132121c1d387fa85db
change-id: 20250825-b4-usb-dd0fe44fd78b

Best regards,
-- 
Daniel Almeida <daniel.almeida@collabora.com>


