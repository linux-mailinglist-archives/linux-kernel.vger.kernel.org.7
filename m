Return-Path: <linux-kernel+bounces-720223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B7FAFB8C2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 18:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE53B1AA6661
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 16:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842C5224244;
	Mon,  7 Jul 2025 16:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b="Z8eJT3FU"
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424AE1A8F84;
	Mon,  7 Jul 2025 16:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751906316; cv=pass; b=bnKXip8soQQ7cJJ1DSjEchadCUAG/uxeKeSd5MHqGaVV9Td4ny1jFiF5lpq6UqvupjX7Jy8D+4BwYPLPe0ht/46NfhfDh728bo10BGoECpL5IuXQKhOWJe6v7NcHcVyIF5Q0AVucNZcxEzsNxSkr1T+P/+sGTpKAQ+y8CnTkvzA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751906316; c=relaxed/simple;
	bh=4dwPwRB1WDIr8miWsunUu7u25OTcLebABPn6kDqCfSA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NGf2baK60LmEantWnYDIogC9QBKjkLqcP8tAcepcTtRz3w1U7WcBHezJTzmc7NVEMrDKscAPgoMg3Yft9LTG4YXbUIShlmECWqOZKKpDbyEtD0wDgrMyOfAiu4kJEE53QsL/1FWasXV5/lThyxL8Kd+cXVWBlfq4Q7JQYQ03B+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe; spf=pass smtp.mailfrom=rong.moe; dkim=pass (1024-bit key) header.d=rong.moe header.i=i@rong.moe header.b=Z8eJT3FU; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rong.moe
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rong.moe
ARC-Seal: i=1; a=rsa-sha256; t=1751906298; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=P25ekHM8AcRLKMMOcV4QnXhQ2N5aLHYbMid1+ZpzJmwcXZH/4pgNaY0kr3pmzdhe8LEQSW6Lv3aiOVQ191xSziz12fdyHytaFjIJlmUKBlj03w5w35bPAQ4oDrUkLyQqKo3GyQZkCRChf6V8Pvlx6v0cI9bA8d1oVy3mWDhNqn8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1751906298; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=J5UnDapHoJ+if1jcQAoIpvwMu4Z+VMda/2+k5dW8Vbs=; 
	b=dyw+FU9OxAQQkO2Ek6RLMfaRaVa2h4NAspRA/ccZpUcllU3JuChU8PmEqZeu41HSiPAj411F9qAm2Sf2Gx+hkJOmCwYo71KGERmbDKPEfFaL4y4ZP4KIlzjniBiHPS4ijxcIC61I9xa54VhSdD5YsYQHSQ2RWDO6W2nqe9HWfRk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=rong.moe;
	spf=pass  smtp.mailfrom=i@rong.moe;
	dmarc=pass header.from=<i@rong.moe>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1751906298;
	s=zmail; d=rong.moe; i=i@rong.moe;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=J5UnDapHoJ+if1jcQAoIpvwMu4Z+VMda/2+k5dW8Vbs=;
	b=Z8eJT3FUlGq3TUlKF+dAgnXO5HXqmYPWV4kgcoSbgKBa2i21i+RPhnsbpgsCuKIF
	4GugdoWAsQO32aq/ApYtWKeCsgsmxtzE5cTmHBNqTKgs3cZAUjDbZH9gNw2v8JQdtQH
	5FUIECSAjRMiq+J/H5wbuH3AyrcOLLVJyozKDunU=
Received: by mx.zohomail.com with SMTPS id 1751906295133418.11901836589163;
	Mon, 7 Jul 2025 09:38:15 -0700 (PDT)
From: Rong Zhang <i@rong.moe>
To: Ike Panhc <ikepanhc@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Rong Zhang <i@rong.moe>,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gergo Koteles <soyer@irl.hu>,
	=?UTF-8?q?Barnab=C3=A1s=20P=C5=91cze?= <pobrn@protonmail.com>
Subject: [PATCH 0/2] platform/x86: ideapad-laptop: Fix FnLock & kbd backlight not remembered among boots
Date: Tue,  8 Jul 2025 00:38:05 +0800
Message-ID: <20250707163808.155876-1-i@rong.moe>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

I had disabled ideapad-laptop for a long time until a critical bug was
fixed[1], and I soon noticed some behavior changes after reenabling
ideapad-laptop.

The behavior changes are about FnLock and keyboard backlight. The HW/FW
can remember their states among boots[2]. After enabling ideapad-laptop,
I noticed that their states were always reset to off after a reboot or a
power cycle.

Historically, FnLock was only exposed under the VPC2004 sysfs node, and
its state was remembered well. Things have changed since the
introduction of its LED class device. As a side effect of the LED class
device unregistering sequence, it is always turned off while shutting
down, making the HW/FW feature meaningless.

The story is similar but a bit different for keyboard backlight. Since
the first introduction of support for it, it has suffered from the same
issue.

Fix the issue by setting LED_RETAIN_AT_SHUTDOWN on their LED class
devices so that their states get remembered, which also aligns with the
behavior of manufacturer utilities on Windows.

[1]: commit 5808c3421695 ("platform/x86: ideapad-laptop: use
usleep_range() for EC polling")

[2]: For FnLock, most (if not all) models should support this; for
keyboard backlight, at least some recent models support this (I am not
sure about old models).

Rong Zhang (2):
  platform/x86: ideapad-laptop: Fix FnLock not remembered among boots
  platform/x86: ideapad-laptop: Fix kbd backlight not remembered among
    boots

 drivers/platform/x86/ideapad-laptop.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)


base-commit: d7b8f8e20813f0179d8ef519541a3527e7661d3a
-- 
2.50.0


