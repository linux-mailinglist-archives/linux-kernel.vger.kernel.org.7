Return-Path: <linux-kernel+bounces-689887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAADADC7D9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 12:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 755273A3F57
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jun 2025 10:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F4E2900BD;
	Tue, 17 Jun 2025 10:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ypCw5P0B";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bLGGR7UC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F6F139D0A;
	Tue, 17 Jun 2025 10:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750155312; cv=none; b=uWdyb0f3V1RDt8kAFw9CTSVu+vPPuBV4HgUG7GG6mdRF9p9Sstt1wo8qV9FAHigMfxbdwyansjoALATi+GreRBmp9obte/r9vy74F+ijWFK12sTMcAygAzJzxAFJ5ZYoHyTlMAUyOY2cjGOwdMHNfe+/edgdgXjeDnUTgeBCFtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750155312; c=relaxed/simple;
	bh=o020+KD1pNUZfL2iwH/vfr7KMOXQU9Zgca+ajYb8GwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L6oACa9xLW1rZHn/d3e1OOcJgsLfYrlr4KfAX6CzElz4KDNXQdaKCWPtMzpEv5M9RTbUlf6JhvukLGdNHa4IlUMZ90CDKzPTxShxCJk4lxmoDqgrR/l/Q8vnYV2UB5UwVPeiAgdd9uEeQVkSUbB9/1YTP9mZ1GBQCN1p2COoNm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ypCw5P0B; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bLGGR7UC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 17 Jun 2025 12:15:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750155308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o020+KD1pNUZfL2iwH/vfr7KMOXQU9Zgca+ajYb8GwI=;
	b=ypCw5P0B6pY8H9XqSSk2lvrgfbKnP9dHS6QDw1QHVYUIugEEvTwbuqouq3q+ra0H+AnU7E
	hcxGHmUfXDgPmmWeSjFS9HuhrlfGW6NzbprU7V76y3hfUiRRFK3L7fqOf9aagPran3idWg
	+uuN7pPe62gCK8DAEGhTfn7S9KN3F7+ZX414J1Y1Vj0R0m2beGWdUf32eYPoOe1UxBsppJ
	nGuckIbJGWlEy01rDTqs8rVi3OrYpAWFz+U8cOwAF4iGZf892qYYrmIPjvuDaa/jsYENc1
	hHxilJGDl6LYYtwzEqiw+cOa+4KrsLU388loTdicYQcEQFrxHUQXQ994xuPLEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750155308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o020+KD1pNUZfL2iwH/vfr7KMOXQU9Zgca+ajYb8GwI=;
	b=bLGGR7UCKMMyzM7uSLL/+9pbVN8bK7kqSgLoJ9C1OpwO56U/3l1ofG0jxQKLQIgC960Wyx
	JY4k0hob+LJWpeDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Marc =?utf-8?Q?Str=C3=A4mke?= <marc.straemke@eltropuls.de>
Cc: linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: Latency spikes on V6.15.1 Preempt RT and maybe related to intel?
 IGB
Message-ID: <20250617101507.jU00mupE@linutronix.de>
References: <20250613145434.T2x2ML8_@linutronix.de>
 <E1uQ6I0-000000003aa-37uJ@smtprelay05.ispgateway.de>
 <20250613195838.0-gZ6bqS@linutronix.de>
 <97638b0b-cd96-40e2-9dc2-5e6f767b90a4@eltropuls.de>
 <20250617092814.vqKdu23w@linutronix.de>
 <bb74b5b6-bc23-4aa4-83df-449dc7c9006b@eltropuls.de>
 <20250617100013.1o5lsPLq@linutronix.de>
 <b7179ac8-c64b-44dd-b25a-62b34eb49c24@eltropuls.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <b7179ac8-c64b-44dd-b25a-62b34eb49c24@eltropuls.de>

On 2025-06-17 12:03:31 [+0200], Marc Str=C3=A4mke wrote:
> Hi Sebastian,
Hi,

> On 17.06.25 12:00, Sebastian Andrzej Siewior wrote:
> > Even if CPU1 would handle CPU0's timers then it would wake cyclictest on
> > CPU0 but that thread would have to wake until CPU0 is done with the PCI
> > bus. CPU1 knows nothing about it.
>=20
> Okay then the latency I see on the other CPU must be from a PCI access do=
ne
> by the second CPU which stall on the same shared bus.

Okay.
>=20
> Anyway: Thanks for your help Sebastian! I can probably live well with the=
se
> spikes in latency. I was more concerned that there is a deeper issue with=
 my
> config and the response time could be unbounded.

You don't have to live with it. You could add a read after the writes in
the loop (wrfl()). This should help.
Some Intel CPUs have a MSR bit to disable this kind of caching on the
PCI bus. Maybe the AMD CPU has this, too. Or there might be a switch in
the BIOS.

> Marc

Sebastian

