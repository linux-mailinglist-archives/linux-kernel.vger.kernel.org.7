Return-Path: <linux-kernel+bounces-833882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D567BA347F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 12:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D498623E4C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Sep 2025 10:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6B8433AD;
	Fri, 26 Sep 2025 10:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="coLTQA68"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DE526AA94
	for <linux-kernel@vger.kernel.org>; Fri, 26 Sep 2025 10:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758881145; cv=none; b=psFe2omvWURuGxZPsDb8iBKMSzKD5uscbS4VyJsX3GH4j+rSFMOjZ3Kd7NV4LEfnQYnz+dP8KrB1J3xTwdPdPYJ6AudCtDAo0OVGRd98CMIbR6YLq0OBMQnPST1PyFX7V+GjGpemR3xWrqyy4oHGuWpva0HNGWV+CBkl11f88Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758881145; c=relaxed/simple;
	bh=OQbCnIhShPZKBxp/CTgnpLLrKP7PYQnn7jxSSy2VseM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hDYJHfhSPXu68g9TvrzAiigoX9ZANGGWz83W3lRcamId5RSv/XgMEkeJabKzGTyDAiomf0EusKYULqnha2IQgMhwVr2aCzQyZlRUwayeExgbTiJiXcVNhjhWrlrpn3kBWg81eNiHs19vnq2BYTVlzJGVDHxHoWBMedI5X8xkZ7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=coLTQA68; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E010040E016E;
	Fri, 26 Sep 2025 10:05:41 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id kxN8VKRpsW3e; Fri, 26 Sep 2025 10:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1758881138; bh=xHmi+K11WcMhrsbQa6Wjx0SpjFxjx8zIrajlY+Yn7/A=;
	h=Date:From:To:Cc:Subject:From;
	b=coLTQA687H5E5OaSczVv6rjE20lQvybxfaSICV6rFtiFB8MtQVUa+gZkRSrmYvc0m
	 IIFzDZ9MOEmrYlP3NvkZZZpQYNlrjF/RE1eKyvVobvuJqy7Y4umDK0MVMe9adHuko2
	 tOa6mbdezw1r1B+UokE2JZmod9Hv+ZYTlbHroje+xaOicgMcwnGGhW5uCBjXViDXGW
	 SYBjNTetJE5svlJXzbaJGkavMujXO68NyOAWN+1seTmnwpz3ce/YYL+QXOsDp/buN0
	 PQxIg5ciAeftFHQNbTHhVM2viZPR5ISIbY8CqfZFkDi/YWi9poRdg1mkzgpqubt76T
	 vxIJcwPITN/FZcVzCLT1CXjMO9Ppr38fWM3HYx5HlZVHIvuGWlc2tHjEkhgTqiOSV8
	 ourdFtRWEAbZi8eoxMYH0oDQRjFoX5yoGL3ckpTmMysE/p05SlUTkDk2k+1mJUtQO2
	 hwqMO24cXPHdJsmte7Ojxw5PYFYYaH2E3dsAMQrej9FxrX5JjUPoCShVeMN6rUTxKY
	 FDrslgVShZsz9/hkWL7cjKcBAXoLwObYeHGXItfRiS5gn6Z7dfFW6HackqS4/chany
	 lLsp1JtsN4sdlDIcUHZGh8ASv8DFsQTg2nyhFoxevl+gNrER0eOJWk5CWpaeRJ/MMX
	 tPb7zflMO8j7fd12+To+0J28=
Received: from zn.tnic (p5de8ed27.dip0.t-ipconnect.de [93.232.237.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 78DB040E016D;
	Fri, 26 Sep 2025 10:05:35 +0000 (UTC)
Date: Fri, 26 Sep 2025 12:05:34 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/asm for v6.18-rc1
Message-ID: <20250926100534.GAaNZlbuntdGwY0wN4@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull a x86/asm fix for v6.18-rc1.

Thx.

---

The following changes since commit 1b237f190eb3d36f52dffe07a40b5eb210280e00:

  Linux 6.17-rc3 (2025-08-24 12:04:12 -0400)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/x86_asm_for_v6.18_rc1

for you to fetch changes up to ac9c408ed19d535289ca59200dd6a44a6a2d6036:

  x86/vdso: Fix output operand size of RDPID (2025-08-26 19:33:19 +0200)

----------------------------------------------------------------
 - Fix RDPID's output operand size in inline asm and use the insn
   mnemonic because the minimum binutils version supports it

----------------------------------------------------------------
Uros Bizjak (1):
      x86/vdso: Fix output operand size of RDPID

 arch/x86/include/asm/segment.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

