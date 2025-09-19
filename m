Return-Path: <linux-kernel+bounces-824619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E229B89AF7
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 15:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FD81566D82
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Sep 2025 13:32:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AB3B30BF78;
	Fri, 19 Sep 2025 13:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qTmi3ROZ"
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5F422A4E8
	for <linux-kernel@vger.kernel.org>; Fri, 19 Sep 2025 13:32:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758288731; cv=none; b=MS93+W/xQOPcmIJC7GILID058dqEX48MKgQbEX0AmQyFl+NexRBt9eIGLHQtPxReEE1g/9XC0LKKaga35QGDiiplda3AdzFDHOylY43O0RhlkeNGFpKsPjW7kgwlZMuYciQg35QcVFs49CLUb/DLkEK2Ch6xnWIfNAi2qwgXQdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758288731; c=relaxed/simple;
	bh=522XQuHiQtRlADvCkhQlS7t0HivCCeZ8Q0Uxor6p3yY=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=nMnZEmcFVSX1nAyDCirecFiR87XVLr8aMTRFh1Hsvf3YxMBZ9N0W5EHo6s/lmJFGLMfWcWEFSTGc0/LnEEeO//WfGZ/vZm68l1BvLEGQMR/WjZv13YULRBL4AFLrq96NuNPQlIN2yIR9ontY+DhkpaeXC8hF0iq6zD8e7BpOZ0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qTmi3ROZ; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758288727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xobWA5WH5KabnpNcfVKu8vzslIjS1Bj9ADBWdzv8p14=;
	b=qTmi3ROZk5xkG2QUZ6CAwtO2SMZ+9OHsi9BVV/+ZjAfeK937Tm0Olfj+YFYYkBysyvDFN8
	qalWF7GMj0AVk3P+Dnk3xNpKHON/iNFyb4rSeV+t+2ZwNv4eFi7aZyrpyrxXl69mcuOOfP
	TAeXL4iEyzFi3pPPMxC/Ey2anYbn2IY=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH net-next] rust: net::phy inline if expressions to improve
 read_status
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <d1fe6fa4-da50-4899-8e2c-0721851c4e0d@lunn.ch>
Date: Fri, 19 Sep 2025 15:30:00 +0200
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Trevor Gross <tmgross@umich.edu>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Danilo Krummrich <dakr@kernel.org>,
 netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <A17B492B-0EAD-4CCE-9889-6D559401D3D3@linux.dev>
References: <20250919112007.940061-2-thorsten.blum@linux.dev>
 <d1fe6fa4-da50-4899-8e2c-0721851c4e0d@lunn.ch>
To: Andrew Lunn <andrew@lunn.ch>
X-Migadu-Flow: FLOW_OUT

On 19. Sep 2025, at 14:54, Andrew Lunn wrote:
> On Fri, Sep 19, 2025 at 01:20:08PM +0200, Thorsten Blum wrote:
>> Inline the if expressions for dev.set_speed() and dev.set_duplex() to
>> improve read_status(). This ensures dev.set_speed() is called only once
> 
> What is the issue of calling it twice, or 42 times??
> 
>> and allows us to remove the local variable 'duplex'.
> 
> And what is wrong with local variables?
> 
> And did you disassemble the code? What is the compiler actually doing?
> Does it actually have a stack variable, or is it just a register? Does
> the optimiser end up with just a single call to set_speed()?
> 
> This is slow path code. It gets called at most once per
> second. Performance does not matter. Which means readability has much
> higher preference. And i find the older version much easier to read.

There's obviously nothing wrong with local variables. This patch is not
about performance improvements, but writing consistent and idiomatic
Rust code.

Currently, dev.set_duplex() uses a local variable and is called once,
whereas dev.set_speed() doesn't use a local variable and is called
twice. This is just a cleanup patch using idiomatic (afaik) Rust code.

Thanks,
Thorsten


