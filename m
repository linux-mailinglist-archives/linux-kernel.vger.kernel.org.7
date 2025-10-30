Return-Path: <linux-kernel+bounces-878997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6E5C21EFD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 20:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B643D4E9F36
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Oct 2025 19:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F942EF673;
	Thu, 30 Oct 2025 19:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="cWmfeMjE"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6DF274B40
	for <linux-kernel@vger.kernel.org>; Thu, 30 Oct 2025 19:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761852516; cv=none; b=E8EQZlvRfsuXSTW4Cnb/XdFJ74fdrb3XnppVL6X3HHLOEYdfX1ikn7puixnOy5M10sK58cbjjfQmN4WoU65BQNXnymDvq+0qUisJZMY7kqsDmxsvQwdBJdUe+RBRWAcdXG54OyjLSIOCLax2xYop9QAfzmFYa2gr4jfFUISMVWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761852516; c=relaxed/simple;
	bh=EugKZBRZmqDm87UMEsBSl1ZfHa1HA2UKRQ/MlTEqK7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PqBwrnoeptekN5pdnszhqJDOd+St0ZYCH3ehQ+255RR8+F0zx02icvg3KE/66iyBuTWh77EXwmAAWOBchDrqQ5NatdvYJx9utwsbliRWxc0BJlLncjOpz3a8a+Ww1g5hzrEGrGLFSrCabYfPsvzo2X5tfesC4ZEo2wlktwWOOV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=cWmfeMjE; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id AB36F40E016E;
	Thu, 30 Oct 2025 19:28:32 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ZylZSXPEqsrQ; Thu, 30 Oct 2025 19:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1761852509; bh=HY+y5MNi+DmPei2C3nPxYxGfjUl6qF3z8jEU4oPVhk8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cWmfeMjECTbiIaSNuxbhJWfvS3xSXHjKxinbGE5TZSGaSoeefuQ2IRjHs+SvrfrSi
	 T2WbtP+TOs7PLi/VuLhyR2A3EBxo68CGb4sCR71tbLMqW5KrevhdqlsDiJiqKJt1eI
	 EkTL9xy+OGlYz3UBmU5R8QpCb9+1pcgUH8i5Cp6f0KcIUSwVGLjFUI568J6uBFrems
	 I8ce0sMGFUnZaAWj5mXIOEseFSzEqQI+MpAQ1S7kvR89kc1gBVw3n01rPcj+mcyiyS
	 muE+iKB9y5jQwGlkeyh2NnMe0d9q9yqX2k0qQ9ukFKL1CA9YgxrgJP4yqxZEWo/up8
	 8iuiORtBeFaRlUkb8RPeSDiTw403Vi/MFo1Kx9qXfgNbeMKKL6xJObvH4GptDE3XGi
	 7+SX20zjtK3MlHjIKWOD321PZjuyCviUIHJ9QbGl31D4J+AXjB3QaJKW53xUtHKFNM
	 egejqT2VeZbpgkdCyrgbbPznLeZ3dbdClpF5fvzO0979pclARhCYKxYFB7FrtfLa7r
	 1E3dmurUetvaRRQ8S4j+Hmkibg/LDbhia8pnS02MS2zD0SZYjzDwZ2sjVp2wNYaGdB
	 B3yc8Mc3pUUFWLep+EnZy+PpZc7JlYX2a0UwzR7m+lBTIbUL71AlZI3h8YP/W63zFb
	 Ou+GybpEtzNMtvGNu/ieBR9o=
Received: from zn.tnic (pd9530da1.dip0.t-ipconnect.de [217.83.13.161])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with UTF8SMTPSA id 3A55F40E021A;
	Thu, 30 Oct 2025 19:28:20 +0000 (UTC)
Date: Thu, 30 Oct 2025 20:28:19 +0100
From: Borislav Petkov <bp@alien8.de>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] x86/mm: Ensure clear_page() variants always have
 __kcfi_typeid_ symbols
Message-ID: <20251030192819.GFaQO8U29xvWcPT_s2@fat_crate.local>
References: <20251013-x86-fix-clear_page-cfi-full-lto-errors-v1-1-d69534c0be61@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251013-x86-fix-clear_page-cfi-full-lto-errors-v1-1-d69534c0be61@kernel.org>

Hey Nathan,

On Mon, Oct 13, 2025 at 02:27:36PM -0700, Nathan Chancellor wrote:
> When building with CONFIG_CFI=y and CONFIG_LTO_CLANG_FULL=y, there is a
> series of errors from the various versions of clear_page() not having
> __kcfi_typeid_ symbols.

might wanna wait with this one - those are going away except one:

https://lore.kernel.org/r/20251027202109.678022-5-ankur.a.arora@oracle.com

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

