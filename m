Return-Path: <linux-kernel+bounces-806274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A88B49479
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 17:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73DBE1BC0F32
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Sep 2025 15:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C6B31062D;
	Mon,  8 Sep 2025 15:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NuYrAMMW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A4B3101C5
	for <linux-kernel@vger.kernel.org>; Mon,  8 Sep 2025 15:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757346953; cv=none; b=UDZX45YS+ksu1LD0I4ukrhxGFN3nP5oSzQuQkOvtcQ+sMF4kdn/eMLqdcInfof/VOS4/t80410GIYeAib6uF2G/zDPSIFRPycKLjoW3LMgPFAxb6hsPCqr7rGe8l1Y5IXkMeSaRSU2VweeBnWL91dWY/yJQwc51GYaMnS+r2UYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757346953; c=relaxed/simple;
	bh=lLhbPcuccrh2iWdqlw6avv6jjc/4//fhsw+RixeJ94U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q5DSf7Ya369hjAxiH/UkjxGjZohg31A4zEtT1+o+eFSbWPi0XFkd7uThrLryNamlRqvfbQpY+bSbDNecrqMVMXvfyd+4lcpaW+CU1fcftcCcv/FgRJFyv7mJBUiOZxR968t+9crOKNt6ruo+tto3B39Z2jlNxvYA8Mju7YjMCu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NuYrAMMW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C017C4CEF7;
	Mon,  8 Sep 2025 15:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757346953;
	bh=lLhbPcuccrh2iWdqlw6avv6jjc/4//fhsw+RixeJ94U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NuYrAMMWtM7HuqBx808w83itr50EZcctk4Z/E20AFT532ebIk+lM3pt3v2BLIX97h
	 nGkjP55Np3GxsQFYZuo+tzXv9PPcTAg0AnK5pWBpSk9PY9JbJ7VMvF/fzTMq4UI8MX
	 cg7+x9gVmMIx9r26sDTGcZXsu19HbNLkaDharc81foxF0Hq3+2OFSgDIL/bMhHuYpU
	 a23RpTdGvgohZIueqDgVqZMcQbz0QHfo8QW7lUgnjpHZDL1EWcLyvzZpz6ai7ll1SX
	 /5/0u0/Q/lT8pQ0UW7fUbG3BYQSUB8/RUhnsNOvJqL5d3xHBzuTVitCHyB7kHuJ4/r
	 A/AtuSdVXWUVA==
From: Will Deacon <will@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Andy Lutomirski <luto@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: kernel-team@android.com,
	Will Deacon <will@kernel.org>,
	John Stultz <jstultz@google.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] arm64: uapi: Provide correct __BITS_PER_LONG for the compat vDSO
Date: Mon,  8 Sep 2025 16:55:32 +0100
Message-Id: <175734490190.158300.1463560749148120421.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250821-vdso-arm64-compat-bitsperlong-v1-0-700bcabe7732@linutronix.de>
References: <20250821-vdso-arm64-compat-bitsperlong-v1-0-700bcabe7732@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Thu, 21 Aug 2025 09:56:43 +0200, Thomas Weißschuh wrote:
> The generic vDSO library uses the UAPI headers. On arm64 __BITS_PER_LONG is
> always '64' even when used from the compat vDSO. In that case __GENMASK()
> does an illegal bitshift, invoking undefined behaviour.
> 
> The first patch should go into the 6.17 tree.
> 
> 
> [...]

Applied to arm64 (for-next/vdso), thanks!

[2/3] arm64: vdso32: Stop suppressing warnings
      https://git.kernel.org/arm64/c/80c4e1948908
[3/3] arm64: vdso32: Respect -Werror from kbuild
      https://git.kernel.org/arm64/c/281817dffe28

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev

