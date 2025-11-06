Return-Path: <linux-kernel+bounces-889200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F894C3CF17
	for <lists+linux-kernel@lfdr.de>; Thu, 06 Nov 2025 18:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A91824EA459
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Nov 2025 17:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E8A351FD3;
	Thu,  6 Nov 2025 17:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U0kPMkcB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3fVVhBrT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1B6354ACD
	for <linux-kernel@vger.kernel.org>; Thu,  6 Nov 2025 17:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762451181; cv=none; b=kRbW7cff6dv8EoPOwEtWkjJSBW0kv2miXFooVfQtptL3mrOgNHp0DPqvXG0zjroMZ98iqWb0m0PSB+8bG3kMvrvzO4dwtI9dHtfpJ7/JLfSw4f4s08t+51yCuJX12ROPbZCjkIaj6RYOlqOZsFHdiGwA6i3SsByCSgRabVcoOtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762451181; c=relaxed/simple;
	bh=EYQGe8DbxttD5RXFpbiW2LqwBiQnZAH3ywTkIv3BEmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXuj5p2Ump5QwurRnY6j3PifQCMX8TV2TX0mhNyJgwVG+7hPNsWOWfymAsgnAhHxUB4AbUnIccFGpuYNddO8jMpPaW35owRfXpmqxn3Ye7og3S6JEYixbl+BsQVAws4E9GasWsvmxBaftW4vfhmMyghqHZpwmK6oVKrGSESYjhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U0kPMkcB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3fVVhBrT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 6 Nov 2025 18:46:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762451177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EYQGe8DbxttD5RXFpbiW2LqwBiQnZAH3ywTkIv3BEmM=;
	b=U0kPMkcB1nEsK0jlNG0YV7Pyt/L5c+RKocTYhmlcQ6T+XGkH0SyAoq9DjgEkZs1sVsjARX
	RWS+wd6YNj2vkR8R/w8S2v5ED/0MI4uXvL4KJANOqZJjo76eX6kYuoG+/aB5WgDp0T7Q7s
	ZpBzPXZKRuhL/Brt2jShuYSjoBUNbVfHGT3/lqi+5OMmW99J1DF1etQpSbK6znPHJxouTf
	KA40MWg8uUp8/E9cRFBKElBUGVYE3dvVXS7fk+W2Bar3HyeuDkswKaIuZfcSUaYfFSyTVI
	ZsFroyvHWDZq0GES1+VJJaA+P7yMo9QryvvJ7P+sW4O3F6k4+t719bMDDcny6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762451177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EYQGe8DbxttD5RXFpbiW2LqwBiQnZAH3ywTkIv3BEmM=;
	b=3fVVhBrTDC2cK2OXukAjcgJ067PvA0bK05jzls2oz4H3X5S7wC2EVZL89LGnFQdSNoZ2Er
	LlElZpimnz/6IPDA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Tejun Heo <tj@kernel.org>
Cc: Calvin Owens <calvin@wbinvd.org>, linux-kernel@vger.kernel.org,
	Dan Schatzberg <dschatzberg@meta.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH cgroup/for-6.19] cgroup: Fix sleeping from invalid
 context warning on PREEMPT_RT
Message-ID: <20251106174614.2yy65_wM@linutronix.de>
References: <20251104181114.489391-1-calvin@wbinvd.org>
 <aQpUY7fEp6_ZqGel@slm.duckdns.org>
 <aQtqXfMfy8SWjS67@mozart.vkv.me>
 <aQufmyZ7X7NdfiCL@slm.duckdns.org>
 <20251106150717.cZuPZnF5@linutronix.de>
 <aQzczJZFiGPOocKb@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <aQzczJZFiGPOocKb@slm.duckdns.org>

On 2025-11-06 07:37:16 [-1000], Tejun Heo wrote:
> Hello,
Hi,

> On Thu, Nov 06, 2025 at 04:07:17PM +0100, Sebastian Andrzej Siewior wrote:
> > How important is it, that it happens right away? Written as-is, this
>=20
> Not important at all.
>=20
=E2=80=A6
> Will switch to IRQ_WORK_LAZY_INIT.

Quick question: Since it is not important at all, would it work to have
it in task's RCU callback, __put_task_struct()?

> Thanks for the review.
>=20

Sebastian

