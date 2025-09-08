Return-Path: <linux-kernel+bounces-806905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42151B49D5B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 01:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9C6F7B4599
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 23:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110802EE29F;
	Mon,  8 Sep 2025 23:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="KBlfvJFS"
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1BB2E2DD8;
	Mon,  8 Sep 2025 23:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757373088; cv=pass; b=kNySJLMA4uFmFk5/76OzczZchifsSEmVaPLcneEzDVTlk0qSce4eD04V4j4DXDc/yrsbYAMbM0IfWuRpszBbTIoYcJPsb0m2qQ4nGlzaJmUq38HfeiQ8ot9Rdtpj1lGtZsjs5FqK1OZlVOFnq7b0XoSc/Vw+ClRZFZlmdrhoMhw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757373088; c=relaxed/simple;
	bh=gX0VbYPSpZA8xPuFImS8Igbz+PayWaqxz0pNEZgodm0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=feSe7XMr0Q7VC8ZwBTRKPb78t7CBXlBd8A12sGF7Q48G5WeeBPxgxX6qK+7iquMzsPTjMcAt329yJdkmP5C/OtpoyZ0Z/RektT0aKgnTivWCI/YO4APPByBvtcBBOcKSrs/BRz2udyuh7A5EYzDbLbFCJoE/7XKyUMgfDyXjchc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=KBlfvJFS; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1757373062; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=YOGW/+1zoz8rqZCIQRTpbdPQkCxAkod4NKU5J1EdJqkbGWy+UpxKNgH6+7+pt99Fdgj7j5UZ0Sat++hc6JJSf4fg3mZwrFFVeCWrM3LSTL2fj1EmbVI23vwaHbg67is1roCq195fNL7DbJ+lVia8+DQiFe7190DRys1sfaCGIho=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1757373062; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=D2/ZpZyDKhnsd3ettsLOdPMB4G/IYtSZasbnpF0N5ps=; 
	b=SEa7a/ypLzWAwVSbA6iVkGVJ94zzGcwsd4n5QIaavCuyRWxikwgwWg6qf8+NbiY+tY3zrKKbOs5dNS8fZ0wNZvR7y//Tfqas4DFvnHhUlmACTNvY8ahbVUHkYy9PBHGozXax8CtJQr0EHqmctw7P86MQsw13VSzFRNUsrQd+6ek=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1757373062;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=From:From:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:To:To:Cc:Cc:Reply-To;
	bh=D2/ZpZyDKhnsd3ettsLOdPMB4G/IYtSZasbnpF0N5ps=;
	b=KBlfvJFSEjTZcuo3nRVa9kl6qbYF2VOy2pjKDvnL6lbJ8PdsssOnBZZK+sZd83BA
	LKqdlJ0cJHN4inU4pZxWYAQFBX5RA55QDCJoRZc7VlZZ4Y8es7ez0kcyrIKMRWOA/HL
	tZjWTDB9p+iIa9rvJhGwoiyk50DT1WBOFBW0uGlc=
Received: by mx.zohomail.com with SMTPS id 1757373061094813.0155423972999;
	Mon, 8 Sep 2025 16:11:01 -0700 (PDT)
From: Daniel Almeida <daniel.almeida@collabora.com>
Subject: [PATCH v2 0/2] rust: regulator: improve the ergonomics of Rust
 regulators
Date: Mon, 08 Sep 2025 20:10:26 -0300
Message-Id: <20250908-regulator-remove-dynamic-v2-0-e575ae2cde6a@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGJiv2gC/42NQQqDMBBFryKzbkoSSDFd9R7FRTKOOhBNSWyoi
 Hdv6gm6++/D+3+HTIkpw73ZIVHhzHGpoC8N4OSWkQT3lUFLbWSrrUg0voNbY6ppjoVEvy1uZhS
 DcjffokTlJVT9lWjgzzn97CpPnKu1nU9F/do/RosSUvTkjdXSUEv2gTEE52NyV4wzdMdxfAEU5
 1m1xAAAAA==
X-Change-ID: 20250829-regulator-remove-dynamic-f1a6b8c0c1b0
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.14.2
X-ZohoMailClient: External

This small series comes after some extensive discussion on a few minor
changes that can improve the current Rust regulator API.

Patch 1 removes Regulator<Dynamic>, as we have now established that
there is no usecase that can't use the safer Regulator<Enabled> and
Regulator<Disabled> APIs instead.

Patch 2 makes "devm_regulator_enable_get" and
"devm_regulator_enable_get_optional" available in Rust. This comes after
realizing that a lot of drivers simply care about whether regulators are
enabled for as long as the device is bound.

Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
---
Changes in v2:
- Picked up tags
- Rebased on regulator/for-next
- Renamed enable() and enable_optional() to devm_enable() and
  devm_enable_optional().
- Renamed patch 2/2 to pick up the above change
- Added more docs and links where applicable (thanks, Alex)

- Link to v1: https://lore.kernel.org/r/20250829-regulator-remove-dynamic-v1-0-deb59205e8e9@collabora.com

---
Daniel Almeida (2):
      rust: regulator: remove Regulator<Dynamic>
      rust: regulator: add devm_enable and devm_enable_optional

 rust/helpers/regulator.c |  10 ++++
 rust/kernel/regulator.rs | 146 +++++++++++++++++++----------------------------
 2 files changed, 68 insertions(+), 88 deletions(-)
---
base-commit: 59e8e7b7f2206d7097e43266722b625715720dfa
change-id: 20250829-regulator-remove-dynamic-f1a6b8c0c1b0

Best regards,
-- 
Daniel Almeida <daniel.almeida@collabora.com>


