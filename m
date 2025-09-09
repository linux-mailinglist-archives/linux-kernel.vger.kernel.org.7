Return-Path: <linux-kernel+bounces-808712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1F0B503EE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 19:07:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8253F3B7C16
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 17:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B5731D39D;
	Tue,  9 Sep 2025 17:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="Pqi6Ndag"
Received: from forward103d.mail.yandex.net (forward103d.mail.yandex.net [178.154.239.214])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE74731D392;
	Tue,  9 Sep 2025 17:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.214
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757437278; cv=none; b=YwX9JqSNOo7bIe4Pcvwkb1F8v//cncaWUw+PMrloLs1QTmUwRUk2agzIPQsnJaKR/TCUrXDWD97up5KdDPk3okaE17rZEMavgeg6I5WhBHPNYFFygV41FlWQj58XdQUTCTHlE9Ax0TBc+noPCYPqHC+lmNIsyg9qFPLmzKxVQwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757437278; c=relaxed/simple;
	bh=xRE4pPdpIvRc4WWtOLOD4HpsN2wmwaazRWvWqiHgm9A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=u6r1anUt7ArzEmPegqqvzOlVUwl1kSRg0CdYp2oO+clHD2djey6gL7fpPcwNA2eBM3Wbtsav1cai+XWogWo10Dtjh5t7zy8S5uu23JZKMX9hALi+Fr8fiQqG+awJZLg1gHySgj+klf8l0TtCdDquWpSA6hxymN+/TwiDCkFf4jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=Pqi6Ndag; arc=none smtp.client-ip=178.154.239.214
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:149a:0:640:77a6:0])
	by forward103d.mail.yandex.net (Yandex) with ESMTPS id 32294C00C0;
	Tue, 09 Sep 2025 20:01:07 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id F0NUYT4M44Y0-070iJfnZ;
	Tue, 09 Sep 2025 20:01:06 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1757437266;
	bh=7aT+MqOg9UdVsmKjV35hDGDjaRxtRR1IzB81eX0PbRc=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=Pqi6Ndagr8XbLmmpLUe+Ig52n+gL+KfkVZHbm985RoHezQwM/LPK/GxZm1vEVnuML
	 CtVTWIertY/jsAzGPcCUJ15xLYGQAKK35wLp1fMrso1vxnYBaMsza1iqbi5TazO2i1
	 DL/UB0y3Shn8761YNdmCJEIV3+CWD186XzUrVhtQ=
Authentication-Results: mail-nwsmtp-smtp-production-main-77.iva.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: rust-for-linux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	daniel@sedlak.dev,
	dirk.behme@de.bosch.com,
	felipe_life@live.com,
	tamird@gmail.com,
	dakr@kernel.org,
	tmgross@umich.edu,
	aliceryhl@google.com,
	a.hindborg@kernel.org,
	lossin@kernel.org,
	bjorn3_gh@protonmail.com,
	gary@garyguo.net,
	boqun.feng@gmail.com,
	alex.gaynor@gmail.com,
	ojeda@kernel.org,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: [PATCH v2 0/1] rust: refactor to_result to return the original value
Date: Tue,  9 Sep 2025 20:00:12 +0300
Message-ID: <20250909170013.16025-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changelog in v2:
  - Removed `map(|_| ())` calls from v1 and replaced them with
  `to_result(...)?` and `Ok(())` (except miscdevice.rs, as it
  required `Ok::<(), Error>(())` which is less clean).

  - Rebased on latest regulator/for-next and fixed the build error.

Onur Özkan (1):
  rust: refactor to_result to return the original value

 rust/kernel/auxiliary.rs        |  3 ++-
 rust/kernel/block/mq/tag_set.rs |  3 ++-
 rust/kernel/cpufreq.rs          |  5 +++--
 rust/kernel/devres.rs           |  3 ++-
 rust/kernel/dma.rs              | 11 ++++++++---
 rust/kernel/error.rs            | 17 ++++++++++++-----
 rust/kernel/miscdevice.rs       |  2 +-
 rust/kernel/mm/virt.rs          |  3 ++-
 rust/kernel/pci.rs              |  6 ++++--
 rust/kernel/platform.rs         |  3 ++-
 rust/kernel/regulator.rs        | 14 ++++++++------
 11 files changed, 46 insertions(+), 24 deletions(-)

--
2.50.0


