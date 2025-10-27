Return-Path: <linux-kernel+bounces-871513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7C0C0D89A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 13:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F6A93BDC8D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 12:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4672F12CD;
	Mon, 27 Oct 2025 12:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CaM2lqts"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A772EFDB2
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 12:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761567790; cv=none; b=RHF0Qlx5/ZEYwSuXIuwLyez2eUjHFezcEm8p7c39hffNwr5b4LU77lgdQfRH2R/tcauqnkVLHw//YaACn2LDvi6SVbtQKnRkGv6OMvknPJ4K55P0e5AXSEySQk8H9HIGSUEDH85faA0PtnQw4POlr4MVtckQsr4TJgAO2mcnz2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761567790; c=relaxed/simple;
	bh=kZd+uJXSOqkobA+ypEeT0daeXVSJcNxd3LoIqnwunV8=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=do6G+6jAzISrkrEmVJLEh7J+ArHO7O3R167xk7ev3E61+pvf/+TbgM1usbdq/pzYxuSclRwqaUNiFRX2TnehDmw5ISoKOUMZdrmMCXKTptYuKlFNC7wzK8u/YeQTbUSG0GfsFeIKEvjR6OdSbE9MsglDcOQyu8HksR+JfQLA9Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CaM2lqts; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761567785;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+YoMZdrakavnIv1PNZCagRBexFYBPMnzcN+XmTYqHPU=;
	b=CaM2lqtsU3efUNlCFYjJF+ydxw/V5kkAYzz3dnKgKtThJY+ZbwYWQrVLofxP2EuwusfSE5
	k9EHG4UVhaLy0FYXt4D1dTA7I1wNZfeiMR1hkxj2UYFjHFIAa727tJsTJ9KBn3hEaygcBa
	A0TDVQkdSKm0Y025Lm4x8xo/jY62qe8=
From: Thorsten Blum <thorsten.blum@linux.dev>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: x86/smpboot: Question regarding native_play_dead() __noreturn warning
Message-Id: <47A8B84B-2685-4DA2-B39B-E55812374426@linux.dev>
Date: Mon, 27 Oct 2025 13:23:02 +0100
Cc: linux-kernel@vger.kernel.org,
 x86@kernel.org
To: Waiman Long <longman@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>
X-Migadu-Flow: FLOW_OUT

Hi,

I just came across this comment in arch/x86/kernel/smpboot.c:

/*
* native_play_dead() is essentially a __noreturn function, but it can't
* be marked as such as the compiler may complain about it.
*/
void native_play_dead(void) {
	...
}

and when I mark native_play_dead() as __noreturn, neither gcc nor clang
complain about it.

The commit message 2743fe89d4d4 ("x86/idle: Disable IBRS when CPU is
offline to improve single-threaded performance") says:

"Add a comment to say that native_play_dead() is a __noreturn function,
but it can't be marked as such to avoid confusion about the missing
MSR restoration code."

Unfortunately, that doesn't really help me either. Can someone explain
what the issue was and if the comment is still valid? Otherwise, I'd
like to submit a patch adding __noreturn and removing the comment.

Thanks,
Thorsten


