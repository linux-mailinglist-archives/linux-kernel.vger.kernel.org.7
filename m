Return-Path: <linux-kernel+bounces-765464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB62B23750
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 21:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D40D7A5FFA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Aug 2025 19:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE51F2FF141;
	Tue, 12 Aug 2025 19:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Qe2dtomF"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2392D47F4
	for <linux-kernel@vger.kernel.org>; Tue, 12 Aug 2025 19:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755025817; cv=none; b=U4R4u6QdMaI7Q+OggmIxzIJHNj8TztP6+mSKq1onq/BjCym44uzdHAJf6IO/3Qr6TfLNQQAsFTM6FwPiSsXYa17E3rfLDz+pmcAV9JiTzmEL9QOQ8U8sHyO0HnThDNdD7xIK3e6pR+RcflBmMoOZjZAmUxlesG8kXkeE/4CM4Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755025817; c=relaxed/simple;
	bh=LzhTtAMdZF9XlgfO1PmsR4oUciFiUByCPuKIkHwGHL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Drz4hHNaMu016JlqI8o3bks/1GrwoGDlZixC1tm+2JasbS5IgAaEl74F0eyDfCEZgcmd64hAb8bA+cOr2qEfKsaykn/Trdm59BDoVkF0k9oBkKrEBGom+iQ3oFRwf5yrEW1cRVuECFr64roIvYMsSaTtEfvtKCfddBpqyw3Zhlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Qe2dtomF; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id CA05140E0265;
	Tue, 12 Aug 2025 19:10:11 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id XKA3r43OHtdB; Tue, 12 Aug 2025 19:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1755025808; bh=4CCFzCPrQvwAglut7imptsq5eJFfq4xWdAWMZh0h11I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qe2dtomFtpZLVjEGxaLSOuhkB4fseA0XuRemvrQwNaJ0Cbt7XtW84xqAVaoPL5Fc7
	 YA4YXM0rc7L6MArNhNF3XV7EHH/o6K/8nZPUlG8sdT30aP2tEsqdgH3tjXZbnZVSdp
	 ACm1L1381hx4kWhvRopesFj649V8i2mSfli27Po2vhIp6Q14sdsK9avtT7TDImaiZZ
	 neTh7HVufmf67E1rCnsBnUa186Rac8A2gU5tf/6YMmtTf+rZKDtVMQRVCUyBqifGKN
	 KbV584nM05gupf2NR9+xzpzi4X/evxB8xb3qAinm3acMvmDuNXP5T4J2JUHvbdY3ub
	 jHRFohVcRZBR3ZCppwM7Fg2Xp3bkGEgTtGkZrCTyEF8vCaaZphx7nZkeGgipMa9UC6
	 NOzUrJ9mVPh6EkMsdrlWo6qVi4D+jC93Es24YS6mZdSbxNQcLCyjqeAnUNhHa25k2i
	 Sl5t2oqk3CEgV5iY5e0KKJzoDOJnf8oueUr1PtLMA9inGy/PEz6lqxjwOf+A1GBT6g
	 iBmq6pX9eqHUMTgwG+gNpClLdTEGQ05erutilcBk41H8bfaG7Lb2n+OXL8AB4K4InY
	 G0lvwya+lCKHez8S1tGWIzOzl4vp0CJG+lwzB+gLM6sCiSpqCViqyC22oJNEuvbfVR
	 o2wHE+XH+2+fKt6m4/0Gy35A=
Received: from zn.tnic (pd953092e.dip0.t-ipconnect.de [217.83.9.46])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2316040E023D;
	Tue, 12 Aug 2025 19:10:04 +0000 (UTC)
Date: Tue, 12 Aug 2025 21:09:57 +0200
From: Borislav Petkov <bp@alien8.de>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: Borislav Petkov <bp@kernel.org>, X86 ML <x86@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] x86/microcode: Add microcode loader debugging
 functionality
Message-ID: <20250812190957.GFaJuRhZG9XYXP2UUJ@fat_crate.local>
References: <20250809094206.28028-1-bp@kernel.org>
 <20250809094206.28028-3-bp@kernel.org>
 <82cdc358-3551-4c8b-a387-0e9da4668b44@intel.com>
 <20250812102645.GBaJsW5cJLYc90Fhhg@fat_crate.local>
 <17938a19-66a6-42e2-bab9-345cfa3cb818@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <17938a19-66a6-42e2-bab9-345cfa3cb818@intel.com>

On Tue, Aug 12, 2025 at 11:57:50AM -0700, Sohil Mehta wrote:
> To ensure people only use it for debugging purposes similar to
> X86_DEBUG_FPU or DEBUG_ENTRY.

No, because CONFIG_MICROCODE_DBG is a separate option and no one should enable
it. Not even DEBUG_KERNEL builds.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

