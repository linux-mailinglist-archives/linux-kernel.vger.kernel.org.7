Return-Path: <linux-kernel+bounces-849405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A84BD00B7
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 11:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A51994E2294
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Oct 2025 09:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65433258CDC;
	Sun, 12 Oct 2025 09:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="HDCjqbGK"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF99D1E7C2E
	for <linux-kernel@vger.kernel.org>; Sun, 12 Oct 2025 09:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760261712; cv=none; b=u3zaaUyWrj+msnCu7nxnoQAlGBBh48igCLfQI9Xwr1NbnMDLSNgpSHI0DUkZ7S5UyJ8rVSXMmMHmrtvd9wAI74qzDhgRZCjiTQXaorUXlbSIJ1zW+QQKE7ikghbnhZWtVl26tpNdEoYTXFHERdOarNQ9LoNl68DGScj7YIN1Xdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760261712; c=relaxed/simple;
	bh=OQR8EZdHj56X349pdhdLpdiDu9DnsB3IDWB8lcuZZK0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TpO1v5w+BmopeGHgGKgNRS6pPur7W7gO2CDxTI+Jn5rdtrGBseublt2VMMPvGr7d6owSrmZZrlwhCByjY1si/9GM5ZqCxJG9Vo26dl7TytjmvzHSqVogiu3DS2T0tTLhwgnIiXKdw16KCOWukz4DfmfP5SWQ0eKFYmLMnqgroSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=HDCjqbGK; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8847240E01A5;
	Sun, 12 Oct 2025 09:34:59 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 9yC4qg79Z0RF; Sun, 12 Oct 2025 09:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1760261693; bh=B7wHYEuCfTA10hM6bYK17bvnt5K2wcfCGUFQda7ASzA=;
	h=Date:From:To:Cc:Subject:From;
	b=HDCjqbGKTPWcXTAtZ0N+YeYOgVQu3mQtd5ORnvWsjTLJBS/N/WcNyOFtILIPwpcT+
	 TY25yxR6ecm4FwkEnRQKYTnmmrUXEQV4cZwl3hJYwn0zV+OFfvmTlHn5dTQNxkz/U8
	 8iVU2qiY1RX3jBn7OkouUoLadux5/2qrLc85KNhUQNjoghyhi9ttrvN+89KUEsLsv6
	 8m30Hd5L7m5tNu1N+s1OetaZbiplg5HWjCutZrxkgYz4HVcq9crTSUm13W1Ob9R1Yv
	 8dIpmvp9ZJfDKysfIDiAe8Sg0aNEeGh4XqsuvVa7Eu9v3yL6aqIHExtlXp70OTTYg5
	 JbJtwRWz+YviGvD91z7V6uCHmaHlJqEaLgY0jpvKDjnN3l509BxtPSoaUeC/ubRAuU
	 CMStgUd1O7nwUx/lliUlHEgMoq4CwRn0Vtt85EcbDHOiWfSqDtkr3vyWA5j0245vgG
	 9KeNwWS5qmqC0NpQ39Ijo07sXOe7QsXjwO6FEbBoOChQNSv+wILrstEMOMH5JUgNrA
	 e/zFQbvxga1Po3YJmYWWadTxAM34XJswz9fHAjBX2npz2ZG+0aXsGNv48gsskS8vZE
	 6PrFlwUJw7pzS0P8rUOxBwEV1j23JUuSIx8H2vlOFoEAgsbyMzT0qydz9itCpwTOlF
	 wcXKfh930tG+ITv9c49VgFDk=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id E59F640E015B;
	Sun, 12 Oct 2025 09:34:49 +0000 (UTC)
Date: Sun, 12 Oct 2025 11:34:41 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] irq/urgent for v6.18-rc1
Message-ID: <20251012093441.GAaOt2McdE_lAqjRUy@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull the irq/urgent lineup for v6.18-rc1.

Thx.

---

The following changes since commit c746c3b5169831d7fb032a1051d8b45592ae8d78:

  Merge tag 'for-6.18-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux (2025-10-06 13:53:19 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/irq_urgent_for_v6.18_rc1

for you to fetch changes up to f75e07bf5226da640fa99a0594687c780d9bace4:

  irqchip/sifive-plic: Avoid interrupt ID 0 handling during suspend/resume (2025-10-07 10:23:22 +0200)

----------------------------------------------------------------
- Skip interrupt ID 0 in sifive-plic during suspend/resume because ID 0 is
  reserved and accessing reserved register space could result in undefined
  behavior

- Fix a function's retval check in aspeed-scu-ic

----------------------------------------------------------------
Dan Carpenter (1):
      irqchip/aspeed-scu-ic: Fix an IS_ERR() vs NULL check

Lucas Zampieri (1):
      irqchip/sifive-plic: Avoid interrupt ID 0 handling during suspend/resume

 drivers/irqchip/irq-aspeed-scu-ic.c | 4 ++--
 drivers/irqchip/irq-sifive-plic.c   | 6 ++++--
 2 files changed, 6 insertions(+), 4 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

