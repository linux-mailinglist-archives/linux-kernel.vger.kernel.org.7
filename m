Return-Path: <linux-kernel+bounces-738126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1C5B0B4C7
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 11:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAA64175191
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Jul 2025 09:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4F41F150B;
	Sun, 20 Jul 2025 09:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b="b4Pe8rWd"
Received: from forward205d.mail.yandex.net (forward205d.mail.yandex.net [178.154.239.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF48194C86;
	Sun, 20 Jul 2025 09:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753005356; cv=none; b=G7cC/nWImL8XEMbPZ5jJXT45qNedQwsXfTaTO5GDRUe9Y7CdqOyASd8EeT5P63pGbx820e5BK37fRdLJrTRo04KSkjSa+kSH4qC/0coBJKPV8VYd5I09WdKdrqpBjwKtBi7z+hBbSc+OCNyGhTiJJqtwCQiPrfhqeRbFgH+wYLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753005356; c=relaxed/simple;
	bh=nVRWul7JznatP3FBPnvenoM5+A47fUh4a/yaCR3QUdE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FNeL2aamukIumcFjpF1AN6fdg0dzLoCG8pmLaMyLqxOW6KuIm7sPnqQv56375w6d/LRmV/o/5D4hSDKcbkLIsiyizYGz3j+kow86jHmgk/6RGvIvTk1rs0Ud2EsrbxNnKWirHzuEGXEf+tbmnbfLuO/NMiSp7V2ZPktR6w39gwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev; spf=pass smtp.mailfrom=onurozkan.dev; dkim=pass (1024-bit key) header.d=onurozkan.dev header.i=@onurozkan.dev header.b=b4Pe8rWd; arc=none smtp.client-ip=178.154.239.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=onurozkan.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=onurozkan.dev
Received: from forward100d.mail.yandex.net (forward100d.mail.yandex.net [IPv6:2a02:6b8:c41:1300:1:45:d181:d100])
	by forward205d.mail.yandex.net (Yandex) with ESMTPS id 2399B92E2D;
	Sun, 20 Jul 2025 12:49:01 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-88.klg.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-88.klg.yp-c.yandex.net [IPv6:2a02:6b8:c42:e0cb:0:640:3e34:0])
	by forward100d.mail.yandex.net (Yandex) with ESMTPS id E04E7C009B;
	Sun, 20 Jul 2025 12:48:52 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-88.klg.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id emMPSZxMxuQ0-98qbNwqf;
	Sun, 20 Jul 2025 12:48:52 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=onurozkan.dev;
	s=mail; t=1753004932;
	bh=T1S/pggF2BkEMZN47JeqSf908HoFqZB6KhYrW1p3Fps=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=b4Pe8rWdYrG5scKTMZiI8Y2DOL5gBIbiMPbZhbVszmYgcUuucxbKUbI8Pp9s5CuXh
	 GOCcC0jE0ydERoQnxiHxgosuct6+0aCcZeXF8HAJIUJ6ZcT6lz+V8/Y00t7rtUcsNi
	 P+JB/GeOpxQgxlpEhmhuFf0xbycwDwvaOCrQZtTM=
Authentication-Results: mail-nwsmtp-smtp-production-main-88.klg.yp-c.yandex.net; dkim=pass header.i=@onurozkan.dev
From: =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
To: rust-for-linux@vger.kernel.org
Cc: dakr@kernel.org,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>
Subject: [PATCH v1 0/3] rust: make various `alloc` functions `const fn`
Date: Sun, 20 Jul 2025 12:48:35 +0300
Message-ID: <20250720094838.29530-1-work@onurozkan.dev>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series makes various functions in the
`alloc` crate const fn.

Each patch corresponds to a different module within
the same `alloc` crate.

Onur Özkan (3):
  rust: make `allocator::aligned_size` a `const fn`
  rust: make `ArrayLayout::new_unchecked` a `const fn`
  rust: make `kvec::Vec` functions `const fn`

 rust/kernel/alloc/allocator.rs |  2 +-
 rust/kernel/alloc/kvec.rs      | 10 +++++-----
 rust/kernel/alloc/layout.rs    |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

--
2.50.0


