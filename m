Return-Path: <linux-kernel+bounces-758020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8386DB1C9D0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 18:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CDFF1890227
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Aug 2025 16:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53FF824C06A;
	Wed,  6 Aug 2025 16:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IKxXrsJp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GW7FF7fd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DAAF1A8F84
	for <linux-kernel@vger.kernel.org>; Wed,  6 Aug 2025 16:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754497950; cv=none; b=J6b5gievGfG4cF9f6BVg5CtMx5CnF72gwxVGpj8cixYzvxta2TvhilibYg4EF0BDo2P4CfijrdVwuPIOLm7wuUz1Id7JDUuTL+iIQoNH3oVIHBPriq7dCXwBeQJGEMtgFaXfGfkv8BnTL9ZHcKlyL1ACUoMXRV3YAksfI6E85Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754497950; c=relaxed/simple;
	bh=MRc7Visqm6dEZ9J6GqL6PUuT3A7l1LVXjxUj6IqU46c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rcNGcCoOlPsbZB1kGdnJ/hLFfdjUdCzkCVkwvwU5/mN77LaN4vHHsHHWijTKIw8oBI8uVHCnEB2O0WiOJJzZuHWd5V5RmPFwjfNyt0eqmF8r7vPCLVYjugeK7HXMmW/uA5JiZa30dM3/IrnBx5SFS6R/UkbUhgSLPlYFwrZNoCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IKxXrsJp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GW7FF7fd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754497947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MRc7Visqm6dEZ9J6GqL6PUuT3A7l1LVXjxUj6IqU46c=;
	b=IKxXrsJpO3xZznxZswD8rsmCWCROwDO68rcGAyS1MOmW98JiK7epvFbDaqfEtfYfYD1g9r
	xuJMX0gcdK4kZIoKApoUgNNP1tcOq6ncvZrCovIn224mG2bcmmlGBVPF78TSjJcMPoYL2j
	cScY9sH3e9CTPui5BCyA3UP5iZdCLW0HZN0fBQGwhJVA308wfWUvqlvalenCRZ1DpZz6zD
	aP0gTWRgnkjS7C4CxM2kGdtUPz+r41yr55jISnOzNju63pnZ8P2vEkJEGUD1ErNtnq0yg9
	Ej3to/HRtxF36fgQpN/EwqlxQN8D3L5ulY0gN2UGaxfd2WbNjRoW9jAW4QZa2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754497947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MRc7Visqm6dEZ9J6GqL6PUuT3A7l1LVXjxUj6IqU46c=;
	b=GW7FF7fdcZk8fEfSU8a1Ag7ZPExNdp3ErjdiCJj4taJs1NAd6juzSoYg0eV5LeB2YE1r7C
	sgd/6O8imsHsdPBA==
To: Prakash Sangappa <prakash.sangappa@oracle.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "peterz@infradead.org" <peterz@infradead.org>, "rostedt@goodmis.org"
 <rostedt@goodmis.org>, "mathieu.desnoyers@efficios.com"
 <mathieu.desnoyers@efficios.com>, "bigeasy@linutronix.de"
 <bigeasy@linutronix.de>, "kprateek.nayak@amd.com"
 <kprateek.nayak@amd.com>, "vineethr@linux.ibm.com"
 <vineethr@linux.ibm.com>
Subject: Re: [PATCH V7 00/11] Scheduler time slice extension
In-Reply-To: <A5159BA4-857F-44F4-B14E-F1872C3D433B@oracle.com>
References: <20250724161625.2360309-1-prakash.sangappa@oracle.com>
 <A5159BA4-857F-44F4-B14E-F1872C3D433B@oracle.com>
Date: Wed, 06 Aug 2025 18:24:12 +0200
Message-ID: <87zfccctar.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Aug 06 2025 at 16:03, Prakash Sangappa wrote:

Please don't top post and trim your replies. We all have this mail in
our inboxes.

> Any comments?

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#merge-window

and people are on vacation ....

