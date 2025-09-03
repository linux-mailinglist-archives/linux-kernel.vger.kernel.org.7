Return-Path: <linux-kernel+bounces-798366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE0EB41CF4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 13:22:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1ABF63B2285
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Sep 2025 11:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EEAE2F291A;
	Wed,  3 Sep 2025 11:22:32 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1D82AEF1
	for <linux-kernel@vger.kernel.org>; Wed,  3 Sep 2025 11:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756898551; cv=none; b=CZNg4OIYK+jslriU4hefuNPZHEi+XLVmPY40tPhhdZVUA6aC/lgpNH8+pe/koA9nMakViG3+eHzg+svaJg1e1OAesRXf2qxK/6wgIZniiQbXKp1EmTo+3ol2PTyz2iJ7VxZ8hyyum4FzbgRyPwH82JR1aeJZKlwZb7gnUgqm6qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756898551; c=relaxed/simple;
	bh=zYZnDtv6rGgYpJQG24a8oSDSw2IwuYWcsnZALlerISY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FICgp7U4FuMwzPnlomDcrnCntqaKGKgLMv9CjRAPH7u3pCcPCxuGv2ZJckTcfHePo9gKUVQ82MubbTi1jfgH0dTpsoooId3CjNEj33TgQqB7idEW1RIlenhAW3w8lKOxRj2isD7VtHRXLAaLlZaUP+NkMA+8jlK0zUeaWQubhiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74004C4CEF0;
	Wed,  3 Sep 2025 11:22:29 +0000 (UTC)
From: Catalin Marinas <catalin.marinas@arm.com>
To: Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Andy Lutomirski <luto@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: John Stultz <jstultz@google.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 0/3] arm64: uapi: Provide correct __BITS_PER_LONG for the compat vDSO
Date: Wed,  3 Sep 2025 12:21:22 +0100
Message-ID: <175689848208.2711243.6145487727322080491.b4-ty@arm.com>
X-Mailer: git-send-email 2.47.2
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

Applied to arm64 (for-next/fixes), thanks! And sorry for the delay,
missed it due to holidays.

[1/3] arm64: uapi: Provide correct __BITS_PER_LONG for the compat vDSO
      https://git.kernel.org/arm64/c/9a6d3ff10f7f

I'll leave the other two patches to Will for the upcoming merging
window.

-- 
Catalin


