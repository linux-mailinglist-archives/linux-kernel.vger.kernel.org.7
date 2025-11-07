Return-Path: <linux-kernel+bounces-890626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD82C407E0
	for <lists+linux-kernel@lfdr.de>; Fri, 07 Nov 2025 16:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F9E8566435
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Nov 2025 14:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66E52F362F;
	Fri,  7 Nov 2025 14:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qhgIRhBD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VDplipDK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9D631B113
	for <linux-kernel@vger.kernel.org>; Fri,  7 Nov 2025 14:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762527284; cv=none; b=bBpi/CHZUwB/tuqZ+SDCtHTgRluBgHgCfHRREVpaRCiFEKVnOf1iBhxuonyT51XkQT6G+TfvfPqDB+fyAZssrRtP3iaquDb0JWCU4PrrMgDQKRI5YhtZcCmt0o6eqMJV9eT819Mo5rIzOdmGcSU8YaoJhZMzFkLPYOgIo05jEYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762527284; c=relaxed/simple;
	bh=NSwvFczhxtRp8oy8f5BYI85c4vjokVNjjSK8yG2UK7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/o8+bcPQaaKih8l43r3IlmadS5FxCIZgo3Hd/lF7jmsVp4yknOZ0XvX01CdlP8CsBvBqo47e22jxAQhxVOxTtBKhcz35aUE95kAvd+352kx3zbS26k1IdM08mq46yF7ePwg//m6mCe4VlGKoUuAIvT9iMZ6zI8JDCzQE5CGETI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qhgIRhBD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VDplipDK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 7 Nov 2025 15:54:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762527279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LY0JiuU7RFFjzgWi7hy2UBf2xm89IuEPJwX9ivwTBVQ=;
	b=qhgIRhBDkENx/qA5+PwNx1UidCsrv8dSt7Sntkt3TrgPHUVXyCi6dSOLoQyqR4GaxDfiHm
	OPvsKIB74aZGMEZRPw0IK3UIAIta8R+IxS4OgMMT+XjcbpiaOd6ef+dFQqT9y+TIEulKnO
	2APxCSh36+epH/dYOgQn80LA/Y+wddANeLSDLFsPKpsXeVnJkNsAodFx26Mco9bokmwB1P
	FiScMSTxurFKTxcfzkipwo0vdlpuKL/sci6OgVyBQ0avBDOot2sbjHh1HU0zkQv3YqpgSN
	pi5LxPfw9LLEFJd5r7BUeQ98W4R+Lg+xoAq5WK/WD82v0ulCcB/f4nEpjh4rjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762527279;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LY0JiuU7RFFjzgWi7hy2UBf2xm89IuEPJwX9ivwTBVQ=;
	b=VDplipDKzoqVu93FRhnDF8jLjPWCp6mo+N+SuhilqwA3k1XjcAK0ejdbAsLXYf0rMWMioK
	ksZoaXhxSuxI0UCQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: kernel test robot <lkp@intel.com>
Cc: x86-ml <x86@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [tip:timers/vdso] BUILD SUCCESS WITH UNVERIFIED WARNING
 4c6736970fbf35aa65512ce7f82abd970f133c8e
Message-ID: <20251107155158-90fb8c9c-59bf-47b3-8756-7c406166db70@linutronix.de>
References: <202511030021.9v1mIgts-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202511030021.9v1mIgts-lkp@intel.com>

On Mon, Nov 03, 2025 at 12:58:28AM +0800, kernel test robot wrote:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/vdso
> branch HEAD: 4c6736970fbf35aa65512ce7f82abd970f133c8e  clocksource: Remove ARCH_CLOCKSOURCE_DATA
> 
> Unverified Warning (likely false positive, kindly check if interested):
> 
>     arch/sparc/include/uapi/../../../../lib/vdso/gettimeofday.c:325 __cvdso_clock_gettime_common() warn: bitwise AND condition is false here
>     arch/sparc/include/uapi/../../../../lib/vdso/gettimeofday.c:325 __cvdso_clock_gettime_common() warn: right shifting more than type allows 32 vs 40

While I can't reproduce this specific warning, this is most likely an issue in
the sparse configuration in the kernel. The CHECKFLAGS are not adapted for the
compat vDSO. Therefore sparse runs with a mixed 32-bit and 64-bit configuration. 
Other architectures are also affected.

There are a few different aproaches for cleaning this up, but I'm not sure yet
which to use.

(...)

