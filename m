Return-Path: <linux-kernel+bounces-768270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5077EB25F09
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 10:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 899EE5C1A33
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Aug 2025 08:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4391FDE01;
	Thu, 14 Aug 2025 08:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QhAnXOea"
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24CC2E8E0E
	for <linux-kernel@vger.kernel.org>; Thu, 14 Aug 2025 08:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755160624; cv=none; b=M/feuf0T2GcmJhb/e2eHsy89QfI/qSSmbSHo9UGK6iBJ2w269c53HhWekj57xvxL6Eij2xk7GMzUqvelfbAJFzNaxrYGFVIUOLlzZd3991ysMzP2wHkwpz8wuqV47g9igno4H43Lyl47zNylFeVToed4vykW02Gq4EvJM8FWjtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755160624; c=relaxed/simple;
	bh=7b0aTpmiqZBCliWQsFcIzb1uU5MCGfOqIbqDgSViohE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UkJd0GASuiBjdDmrEHYappG/cMN1KFvAJ4cH9pZyndpU0kE2Ajy2NPq4vFo/GIBsgIo0JpAmKRakUGK1OoCOQHEG0GCsJmPERk1vJlYlPo543KuRSWA2rY8YArAkyyZue5edKGF5VWqCUb/hBzXnhHcJP/KP7A9/YLhNpc7CBl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QhAnXOea; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tM997p21EDSHDZRTdDdjWkBVRC6iMcoBPOjhGJob/ts=; b=QhAnXOeaU0UJcADi7GvHswcihg
	UXK4CjF2ju1ZS2S9JJLh2YCo7qAWS6xupdWQjUVtysGuIYzZTxqAA2g+p5RF3AAHAng2ClkTwwcSF
	hri1ya7xrI7bvcyM9H3c0rqBKA/f5UCXY5NRpTe/59EwzDfQwyHpkj565mGIHMEnRfXfanCwnd27w
	KGMTQ60dF6/rObDMfhX2RzZvPQeHs/RTpZa0HeT0fVufWhETSM95McogViwM8fo4/1/oICnVCZupu
	DT1dnnw+i9H/AfWAgVkWb/e46fSmKx09cRoKb8HdqHHrQaqhzN0ddzkhAqqFDgbmfhnAbhVg0E0sa
	EKn4Y/mw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1umTS7-0000000GOYG-3PZ0;
	Thu, 14 Aug 2025 08:36:52 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id D450B3002C5; Thu, 14 Aug 2025 10:36:51 +0200 (CEST)
Date: Thu, 14 Aug 2025 10:36:51 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [QUESTION] How to silence objtool warnings of vmlinux.o
Message-ID: <20250814083651.GR4067720@noisy.programming.kicks-ass.net>
References: <8737f2ed-3f4a-3cab-1dd1-55ad50f951e6@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8737f2ed-3f4a-3cab-1dd1-55ad50f951e6@loongson.cn>

On Thu, Aug 14, 2025 at 10:38:07AM +0800, Tiezhu Yang wrote:
> When compiling with LLVM and CONFIG_LTO_CLANG is set, there exist the
> following objtool warnings after silencing all of the other warnings:
> 
>   LD      vmlinux.o
> vmlinux.o: warning: objtool: .head.text+0x0: unreachable instruction
> vmlinux.o: warning: objtool: .head.text+0x18: unreachable instruction
> vmlinux.o: warning: objtool: .head.text+0x38: unreachable instruction
> vmlinux.o: warning: objtool: .head.text+0x3c: unreachable instruction
> vmlinux.o: warning: objtool: .head.text+0x40: unreachable instruction
> vmlinux.o: warning: objtool: .head.text+0x44: unreachable instruction
> vmlinux.o: warning: objtool: .head.text+0x54: unreachable instruction
> vmlinux.o: warning: objtool: .head.text+0x58: unreachable instruction
> vmlinux.o: warning: objtool: .head.text+0x6c: unreachable instruction
> vmlinux.o: warning: objtool: .head.text+0x84: unreachable instruction
> vmlinux.o: warning: objtool: .head.text+0x94: unreachable instruction
> vmlinux.o: warning: objtool: .head.text+0x9c: unreachable instruction
> vmlinux.o: warning: objtool: .head.text+0xc4: unreachable instruction
> vmlinux.o: warning: objtool: .head.text+0xf8: unreachable instruction
> vmlinux.o: warning: objtool: .head.text+0xfc: unreachable instruction
> vmlinux.o: warning: objtool: .head.text+0x104: unreachable instruction
> vmlinux.o: warning: objtool: .head.text+0x10c: unreachable instruction
> vmlinux.o: warning: objtool: .head.text+0x11c: unreachable instruction
> vmlinux.o: warning: objtool: .head.text+0x120: unreachable instruction
> vmlinux.o: warning: objtool: .head.text+0x124: unreachable instruction
> vmlinux.o: warning: objtool: .head.text+0x144: unreachable instruction
> vmlinux.o: warning: objtool: kernel_entry+0x0: unreachable instruction
> vmlinux.o: warning: objtool: smpboot_entry+0x0: unreachable instruction
> 
> All of the above instructions are in arch/loongarch/kernel/head.S,
> and there is "OBJECT_FILES_NON_STANDARD_head.o := y" in Makefile
> to skip objtool checking for head.o, but OBJECT_FILES_NON_STANDARD
> does not work for link time validation of vmlinux.o according to
> tools/objtool/Documentation/objtool.txt.

Correct. OBJECT_FILES_NON_STANDARD shouldn't really be used for anything
that ends up in vmlinux.o.

> How to silence this kind of objtool warnings?
> I appreciate any guidance here.

I think for x86 we just annotated it all. Specifically, those
unreachables appear to be due to non function code symbols. You need to
give them a proper UNWIND hint.


