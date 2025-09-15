Return-Path: <linux-kernel+bounces-816751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C022B577F3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 13:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 720DF188D22D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 11:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F202FB991;
	Mon, 15 Sep 2025 11:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="d7TS+++l"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EBD2D8387
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 11:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757935244; cv=none; b=mxUZfw+G2TAA71vE4ilA9CGZ0BwOIzFLH9aM5dqeAItkFlNseZYv6OLGdGfK3W1DMbzS/AVA/G94OOluRa5loCvmFhe6YcIJldg0spbzHyA9bSNgWximpp8GKtsnIppY1yxI0e1vCIZOtitzjreijGrDqFwtGqFnIz2950ksqzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757935244; c=relaxed/simple;
	bh=apoe/R7LKXFn03294wBh4C0CpYiVrdSa7DIk9s+J6Hg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=poDuwrG2iis1vAoRncIeJ10v24ZKh7gOpvw8qmcr/SLUbrJym2xjaPH7ixtKJz0nOKsSdDToKVBiGOrsaNPeAQ7yeQQoH+gqeWPpus3x8XspQWQVPJeiqW5T9v6hAQUY55K5OeF+1t71T7MhD+U88jE4VL0X/jWLCHSx8N18OoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=d7TS+++l; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-45dd505a1dfso33225045e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 04:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757935240; x=1758540040; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Iu8rzYTcvyzbVtwugKF+K7RkWC5Qi8KesKpCxYtysTo=;
        b=d7TS+++lwpAag7SYp/A8DU1rgeH9auAL4LeDLTAWX+F6znBg42a/VdYvO0AJbBqEWU
         /XjwOpiT3Fw+Y/y9hUY9ZgGixWWGEofTFgN+xguu34QP7zpxqdis+RLB7/5WFBK63Dxn
         Nh2KE+ip4ZuT0WT8EhSStmYC81vRZW+tquiRIGFKgwBcuSIfbr763i1s9LxB2HCRzJQb
         GFixm/cpJ1d1ulk55PjutkUXzLqixQsv7NtvXIsw1yuoWFXTUJ4wjQxDZwzOIZUaZZow
         R4HYffdCvvbwX2aPifisYMnspvPUevR2jkScNFubhODnwet2ut5YhBKsrHaOx3nBzgXB
         SL1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757935240; x=1758540040;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Iu8rzYTcvyzbVtwugKF+K7RkWC5Qi8KesKpCxYtysTo=;
        b=JsJQynx/4bQYE1P1nXFxhpa5zlpLk7G1OvxMGeVJHIBmYVYKgoiyxn8E93t1lpRY2i
         05xLsWuJzhNBJ+s0wDTyaztwEsrVERDxwYxpHfPhR998/mfj4vCXTTy6T76g86OPjMiD
         8krFBZph4499pMVnRhhzp6HFkB/H4Q4t1ACLRFGoVpsOO1qHvD90yAGJfisy9QulHbOd
         niwrdxtGHMQsbNgfnA45NmfQJySTZvAWpIb3qTdyci9XZyRIHmenxuF37sgBQT6miFt1
         db8QCIzy0f6jLaT1Ws9rlNxIPp5410UB3T+WWrHMe7K6DD2Avl3iQThnEIQTM4jbHFps
         1uyg==
X-Gm-Message-State: AOJu0YwAXW7YOfr2F9TNl/+EYmfhAV5hkR5ulGlZi66d3uxqospuNRaL
	0k7E3EQLekzzp5An8GmEOK91kxI8syQHSueQJ/6H/eUUYLO0uo5erDhigSo7wqeDAUc=
X-Gm-Gg: ASbGncuQJAfk9Aing7gY2hIyuLBFJixHVBC4fCh7PoUZxiN8BvlsC9BxB8xNcoU2HPr
	bBUZz5WX5zAMEp94HD6MpF4e8buJuhX/mB7LDerd6wkCWu6oUTgPd1JLU8GqS6jQK7sRzAzmjtX
	kgvwNzhwH+dp2+AoqcT5X8T6c6w3a+YJjQJqtn047+1uDyPSNjEFKPGaqPtebDhBe5f7to/40/b
	ufyXTOOfT/L+U6cYrObBWVFIOo3TdD5vT3lwxIOrWyLD9USNXMeSdbKv7hNQvt1i0q8TfgcfWuW
	9Q/pFyzrfwQh6dV2eorf9V5Kr3pplszKSd2SSZ8Fs/0FY/6Nbjg/uYQQL7LDJbxhwIpkrkz8fg5
	GfqGZ2PM9lNCW+AdErIFsDznpbkdWDTcx2PoXmQ/Y9a0RgYDE
X-Google-Smtp-Source: AGHT+IEkf7SQBuubZjra15y4PEDu5E8Bmb4KjC+Ylm6QJOWkPtMJ2z8QCuatvFF4TrE/IKChqfV2HA==
X-Received: by 2002:a7b:c04b:0:b0:456:43c:dcdc with SMTP id 5b1f17b1804b1-45f212050femr79885125e9.33.1757935239965;
        Mon, 15 Sep 2025 04:20:39 -0700 (PDT)
Received: from [127.0.0.1] (210.37.160.45.gramnet.com.br. [45.160.37.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e01519f67sm91903345e9.1.2025.09.15.04.20.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 04:20:39 -0700 (PDT)
From: Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: [PATCH v4 0/5] Handle NBCON consoles on KDB
Date: Mon, 15 Sep 2025 08:20:29 -0300
Message-Id: <20250915-nbcon-kgdboc-v4-0-e2b6753bb566@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAH32x2gC/3XMSw6CMBSF4a2Qjq3pAyg4ch/GQbm9hcZITauNh
 rB3CxMMicNzku+fSMTgMJJTMZGAyUXnxzzKQ0Fg0GOP1Jm8iWCiYopLOnbgR3rrTeeBogULUlm
 DZU0yeQS07r3mLte8BxefPnzWeuLL+yeUOGW04ghgWlEq3ZzjK+IR/J0snSQ223C+syJbUKBEB
 wa1rXdWbrZlYmflYo1kuuGsthx+7DzPXyQjuVQfAQAA
X-Change-ID: 20250713-nbcon-kgdboc-efcfc37fde46
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Petr Mladek <pmladek@suse.com>, Steven Rostedt <rostedt@goodmis.org>, 
 John Ogness <john.ogness@linutronix.de>, 
 Sergey Senozhatsky <senozhatsky@chromium.org>, 
 Jason Wessel <jason.wessel@windriver.com>, 
 Daniel Thompson <danielt@kernel.org>, 
 Douglas Anderson <dianders@chromium.org>
Cc: linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net, 
 Marcos Paulo de Souza <mpdesouza@suse.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757935236; l=3332;
 i=mpdesouza@suse.com; s=20231031; h=from:subject:message-id;
 bh=apoe/R7LKXFn03294wBh4C0CpYiVrdSa7DIk9s+J6Hg=;
 b=VMeY28is3563W1JwDCjK4Zi5WbIy1IWrzcMOjVM3aTa/uK6bzFX7VLUwiXuc+VhcojV3rLP2J
 dg5tTTsN+I5BwbnkVwP7iw2MDOaSnl0WWhMnSKKN6yjIXNIUuq3kU9K
X-Developer-Key: i=mpdesouza@suse.com; a=ed25519;
 pk=/Ni/TsKkr69EOmdZXkp1Q/BlzDonbOBRsfPa18ySIwU=

In v4, only the first patch wasn't changed, all other received updates. A
new patch was added to export nbcon_write_context_set_buf helper. All
changes were made by following the suggestions from John Ogness and Petr
Mladek, thanks a lot for your reviews and suggestions!

As usual, how I tested the changes:

Testing
-------

I did the tests using qemu and reapplying commit f79b163c4231
('Revert "serial: 8250: Switch to nbcon console"') created originally by
John, just to exercise the common 8250 serial from qemu. The commit can
be checked on [1]. I had to solve some conflicts since the code has been
reworked after the commit was reverted.

Then I would create three different serial entries on qemu:
-serial mon:stdio -serial pty -serial pty

And for the kernel command line I added:
earlyprintk=serial,ttyS2 console=ttyS2 console=ttyS1 console=ttyS1 kgdboc=ttyS1,115200

Without the last patch on this patchset, when KDB is triggered, the mirroring
only worked on the earlyprintk console, since it's using the legacy console.

With the last patch applied, KDB mirroring works on legacy and nbcon
console. For debugging I added some messages to be printed by KDB, showing
also the console->name and console->index, and I was able to see both
->write and ->write_atomic being called, and it all working together.

[1]: https://github.com/marcosps/linux/commit/618bd49f8533db85d9c322f9ad1cb0da22aca9ee

Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>
---
Changes in v4:
- Added ifdefs to only check for KGDB if KGDB was enabled, suggested by John Ogness
- Updated comments about KDB on acquire_direct, suggested by Petr and John
- Added a new patch to export nbcon_write_context_set_buf, suggested by Petr and John
- Link to v3: https://lore.kernel.org/r/20250902-nbcon-kgdboc-v3-0-cd30a8106f1c@suse.com

Changes in v3:
- Only call nbcon_context_release if nbcon_context_exit_unsafe returns true (John Ogness)
- Dropped the prototype of console_is_usable from kernel/printk/internal. (Petr Mladek)
- Add comments to the new functions introduced (Petr Mladek)
- Flush KDB console on nbcon_kdb_release (Petr Mladek)
- Add an exception for KDB on nbcon_context_try_acquire_direct (John Ogness and Petr Mladek)
- Link to v2: https://lore.kernel.org/r/20250811-nbcon-kgdboc-v2-0-c7c72bcdeaf6@suse.com

Changes in v2:
- Set by mistake ..
- Link to v1: https://lore.kernel.org/r/20250713-nbcon-kgdboc-v1-0-51eccd9247a8@suse.com

---
Marcos Paulo de Souza (5):
      printk: nbcon: Export console_is_usable
      printk: nbcon: Introduce KDB helpers
      printk: nbcon: Allow KDB to acquire the NBCON context
      printk: nbcon: Export nbcon_write_context_set_buf
      kdb: Adapt kdb_msg_write to work with NBCON consoles

 include/linux/console.h   | 54 ++++++++++++++++++++++++++++++++++
 include/linux/kdb.h       |  6 ++++
 kernel/debug/kdb/kdb_io.c | 47 +++++++++++++++++++----------
 kernel/printk/internal.h  | 44 ---------------------------
 kernel/printk/nbcon.c     | 75 +++++++++++++++++++++++++++++++++++++++++++++--
 5 files changed, 165 insertions(+), 61 deletions(-)
---
base-commit: caa285912f4901a5acdb38624f1ae157e3cd9c4c
change-id: 20250713-nbcon-kgdboc-efcfc37fde46

Best regards,
-- 
Marcos Paulo de Souza <mpdesouza@suse.com>


