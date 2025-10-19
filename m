Return-Path: <linux-kernel+bounces-859493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41622BEDD4E
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 02:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA6F4189DC31
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Oct 2025 00:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F03B1514E4;
	Sun, 19 Oct 2025 00:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kg8hymdX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E851373
	for <linux-kernel@vger.kernel.org>; Sun, 19 Oct 2025 00:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760833316; cv=none; b=EBxFnI7lLA0ejY5T47/Sbd9KLoPKAMCGVbR+Q6g+HHSaOKBPTSJ12xXDxlumLreiNN2vLAD5KIFke1vVz1ReokB97pKUCzelmyz7ohUQAT4FNvx5vV82EY3Coxduo3Qlu/a/wSIuQgfTPSrtZoFWUdt4vgGZjH1oUg+uVA01q0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760833316; c=relaxed/simple;
	bh=/DQSoeqMlzJoPx5szU4pSCM9zENLUWybjjLypAojtB8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=uKVYy396shrJ8vd1Wyp6KT7zbfHM/NaLd0rOtT5meycz+7em6dGXZ1+ZqghJalE3F9pSS4XVMwWqQ+dvGQWECKdXckvUt2jNmFFz3dHT39EoGW4fXrP1UuatLvaNXCsxaihBQicDmz2uaG1NWM2bBGJCu8SS7YOlNh4ODag7rG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kg8hymdX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8990EC4CEF8;
	Sun, 19 Oct 2025 00:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760833315;
	bh=/DQSoeqMlzJoPx5szU4pSCM9zENLUWybjjLypAojtB8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=kg8hymdX+9c7oqXIk/+/K76L2dCjpX7wHjcu/QUTDyJsZpiC/QH05mDPUhOuBNA8a
	 kzvRfyrUif8eT28L2+JVVK+C7XV+PYR3AX0jjEtBQj7LQKZWxB6MeyGl8+QxIJZyIt
	 KePDz513qfXYyOag1Inb/Yr6poJ4Qn0bRRWn9djuLJMAJhDF/Sh/LPahMjU9nGfHI/
	 wd8i4NMnZwp1gZWlnR+81SgnwBSXYDsYeW0/+pP5JjBkSDmkUFsHfTdnHV8P18qQ/N
	 CljPn1RgqDTcTh29FqtQDCLy54g2SR6cWq27st0vWgX2Iqwx4oo1PxEhPVDgxR3MMW
	 d4z0ZYL7zvjOw==
Date: Sat, 18 Oct 2025 18:21:52 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Josephine Pfeiffer <hi@josie.lol>
cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
    alex@ghiti.fr, linux-riscv@lists.infradead.org, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] riscv: ptdump: use seq_puts() in pt_dump_seq_puts()
 macro
In-Reply-To: <20251018170451.3355496-1-hi@josie.lol>
Message-ID: <2eaeaa69-b2cf-3a3a-0239-2aefcaa836aa@kernel.org>
References: <20251018170451.3355496-1-hi@josie.lol>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sat, 18 Oct 2025, Josephine Pfeiffer wrote:

> The pt_dump_seq_puts() macro incorrectly uses seq_printf() instead of
> seq_puts(). This is both a performance issue and conceptually wrong,
> as the macro name suggests plain string output (puts) but the
> implementation uses formatted output (printf).
> 
> The macro is used in ptdump.c:301 to output a newline character. Using
> seq_printf() adds unnecessary overhead for format string parsing when
> outputting this constant string.

Hard to accept that it's a performance issue.  But I think you're right 
that generating a newline should be done with seq_puts().

> This bug was introduced in commit 59c4da8640cc ("riscv: Add support to
> dump the kernel page tables") in 2020, which copied the implementation
> pattern from other architectures that had the same bug.
> 
> Fixes: 59c4da8640cc ("riscv: Add support to dump the kernel page tables")
> Signed-off-by: Josephine Pfeiffer <hi@josie.lol>

A better fix would seem to be to just get rid of pt_dump_seq_puts().  It's 
only used once in arch/riscv.

Taking a broader view, both pt_dump_seq_puts() and pt_dump_seq_printf() 
look completely pointless.  Is there any argument for keeping them?


- Paul

