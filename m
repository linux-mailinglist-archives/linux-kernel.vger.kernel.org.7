Return-Path: <linux-kernel+bounces-677369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F16AD19C7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jun 2025 10:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87934167745
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jun 2025 08:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3435E1ACECE;
	Mon,  9 Jun 2025 08:30:37 +0000 (UTC)
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE20C881E;
	Mon,  9 Jun 2025 08:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=163.172.96.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749457836; cv=none; b=r0nIjH81MfUBwKMoI29wbNBJRtJqH+tuGV+Qzw2doDpEZ/4IRZB5OJqCETMezZNChWML1Mw5wXkeA32wrdiSNoke5LpXcNHQap7BzxHbbn7S4y1ZKTvuXrH0tJw5NyFbs/qQGvQKC8ODLmsMdRG0KVobdFylasLag93mFdYINPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749457836; c=relaxed/simple;
	bh=SVKrDjMhI312EibwMyLlbImdf4HRppB+YPaQtjHFeQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i7Le0grNrPp+jpz+RVZQu5pRiGOAwm5dChFaJ5zpwJjuqTD1VRd80zAsIdNE7iey5tiBaNcXdzweXjEsP67Vpb/nbgceVMSPyKOmuh1Z9E8gfc9sVIBzOi7SCjAe772J/q9c7OYmi8meIibGhG5Frjx7L8lFV8erIeGItTnbhqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu; spf=pass smtp.mailfrom=1wt.eu; arc=none smtp.client-ip=163.172.96.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=1wt.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=1wt.eu
Received: (from willy@localhost)
	by pcw.home.local (8.15.2/8.15.2/Submit) id 5598OF44026749;
	Mon, 9 Jun 2025 10:24:15 +0200
Date: Mon, 9 Jun 2025 10:24:15 +0200
From: Willy Tarreau <w@1wt.eu>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/nolibc: make stackprotector probing more robust
Message-ID: <20250609082415.GC26391@1wt.eu>
References: <20250609-nolibc-stackprotector-robust-v1-1-a1cfc92a568a@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250609-nolibc-stackprotector-robust-v1-1-a1cfc92a568a@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Thomas,

On Mon, Jun 09, 2025 at 09:39:16AM +0200, Thomas Wei�schuh wrote:
> nolibc only supports symbol-based stackprotectors, based on the global
> variable __stack_chk_guard. Support for this differs between
> architectures and toolchains. Some use the symbol mode by default, some
> require a flag to enable it and some don't support it at all.
> 
> Before the nolibc test Makefile required the availability of
> "-mstack-protector-guard=global" to enable stackprotectors.
> While this flag makes sure that the correct mode is available it doesn't
> work where the correct mode is the only supported one and therefore the
> flag is not implemented.
> 
> Switch to a more dynamic probing mechanism.
> This correctly enables stack protectors for mips, loongarch and m68k.
> 
> Signed-off-by: Thomas Wei�schuh <linux@weissschuh.net>

Acked-by: Willy Tarreau <w@1wt.eu>

Thanks,
Willy

