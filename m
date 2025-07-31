Return-Path: <linux-kernel+bounces-752573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6102AB17753
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 22:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 98F401C27DFA
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 20:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013912620E4;
	Thu, 31 Jul 2025 20:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="ZFMaBrHd"
Received: from forward201b.mail.yandex.net (forward201b.mail.yandex.net [178.154.239.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665971D52B;
	Thu, 31 Jul 2025 20:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753994927; cv=none; b=racbATkQMxcfUxVEPrNuGkQ2IrrjtIJrmccQP4pUxZ7wJpTbqO9RrDh7Ey6irhhMhhOCppjbpUZZsnJchC6s/SgErMGqpptLsAfnIfrdJR7W2SsljIDEfac0xm1KE2pQV+fiJhdkrA6a/W7nVDO8qQBLrjiHLxLzqKxE1ls6IY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753994927; c=relaxed/simple;
	bh=zu89rWD18maT5mlPGkcNnKZRmtKYYkp3le2g40M7lHI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RKbZyH2BKa5bXxJab2cMuJ4rHBJ41ldZ8Wtm80By82L1EXNz0TjDLqx4patNzmd+mgaIXZrGmrEKq4kzJPwlpTcjAErM7h92SIllKD3TgEB/aBnImMCKnB1+epMt3LuUjH1tPVwMUrMSCw+av8mLiJbPreWHnkn9dt2ZIR6obT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=ZFMaBrHd; arc=none smtp.client-ip=178.154.239.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d100])
	by forward201b.mail.yandex.net (Yandex) with ESMTPS id 72D9DC2D32;
	Thu, 31 Jul 2025 23:41:37 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net [IPv6:2a02:6b8:c23:4419:0:640:5be6:0])
	by forward100b.mail.yandex.net (Yandex) with ESMTPS id 43FAD8061A;
	Thu, 31 Jul 2025 23:41:29 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id GfiURY3MWmI0-iWtruDbZ;
	Thu, 31 Jul 2025 23:41:28 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1753994488;
	bh=XYcp1T4gKc6+rSZ7apzntYtjpDeYNFP4mcB4aJYJo1M=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=ZFMaBrHdTSBk29zsIAPIvIvUFk2WJvnxohwNn0TeQbDaYq/JNRC5iBIfjI9rbQQ0z
	 rO9TSPtHyYY8ndW8IfDXjgP5MrO8NYTgUuDQSROqij9kO4qW/C1i/LY4nErmNfMUG1
	 0L/ZPjhV0e72kEsOdMJ2nlBJ5BHvnTtgr31pJMD4=
Authentication-Results: mail-nwsmtp-smtp-production-main-60.sas.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: rust-for-linux@vger.kernel.org
Cc: ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	dakr@kernel.org,
	me@kloenk.dev,
	felipe_life@live.com,
	abdiel.janulgue@gmail.com,
	dirk.behme@de.bosch.com,
	daniel@sedlak.dev,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: [PATCH v3 0/1] rust: update error.rs documentation
Date: Thu, 31 Jul 2025 23:41:14 +0300
Message-ID: <20250731204115.13669-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Changelog:
  v1: Removed header link to keep the doc more generic.
  v2: Reverted v1 and added missing header links.
  v3: Replaced `arch/mips/include/uapi/asm/errno.h` with
    `nclude/uapi/asm-generic/errno.h` header link.

Onur Özkan (1):
  rust: update error.rs documentation

 rust/kernel/error.rs | 2 ++
 1 file changed, 2 insertions(+)

--
2.50.0


