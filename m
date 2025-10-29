Return-Path: <linux-kernel+bounces-877187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E16ABC1D63D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 22:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D6FD18835D1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 21:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13883313E1D;
	Wed, 29 Oct 2025 21:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tM9fC9EJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1Sb13Lvl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1555E13C914
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 21:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761772297; cv=none; b=i+/ChGEaC7R3/CM3QhdMTjhA2rSxm50jasJp+zEAkQ4RvPShPTLRi2ba+K4J7GCnT9MG9Gm55AEx4Hlv6T7/dXWPItRg76xnnpLa16ZCxUiOcN7ejCRP4F+RIBmnTTcKvHiT4OXFL13vj5cPMprqiqp8CR0HCC9B5i6tyL2bvxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761772297; c=relaxed/simple;
	bh=EKrwOYl2fWXfhR0BobjtUdYPCQBZ+Wop5jQkuQDs4AU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MNfXhBtHvnQSgZAbVPzmNA1mkas76/V/yv6cgs86zIdi45cHeKE3CE4oozpsNDxfmcUAwg+9lKeifTLc/cFSTf+2ePNCw5IAElIx3e8pfK8U8w97UitFsHisBuurfIf19zS9cjPyT1pDoMh+/KgmgvUljD5QuE8ZvVyAfhjaAik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tM9fC9EJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1Sb13Lvl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761772294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hAcmz8ynqx4JKBtSrkI316xT0kahfzQLfye1XcSJHjY=;
	b=tM9fC9EJy8OXFCel2LUMY8atYKJy8klYFR27R0/Gx5FpejWzcFOrvNZqXIOezWpCbY/DZP
	04jAtNMBgkvMLz+10jKCkMekf86KddB3AXzHd+uljqv9jHI7et7M0T+WhEfRFjQSYP9Vrl
	L9F8dYsoCggpwxVzDcgER3Cm1dGf9AloMBQqLSV1/zWMkjb9a7WKHOt4ic3d+21kGavSAf
	66zA+oR9NQNtIwgtW4DtoFgRmNrFrrwi5EsmSw5+bhnfIO0FMKm2G4h0DWXUHTaOnDEl7v
	s1IARmzcPv7mc3HskJq62X0ZXPqbcwJwxT2emZsQgxL6rPj9jXOI9XIrPHgGSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761772294;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hAcmz8ynqx4JKBtSrkI316xT0kahfzQLfye1XcSJHjY=;
	b=1Sb13LvlmHd9sKwGQe3MCwjG63C8AVPA5hODwXPTtMz+UYuxY3oWYcPA42t4FfKOgCKZ2z
	pz3iXh/Y9oZh6fAw==
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Gabriele Monaco
 <gmonaco@redhat.com>, Michael Jeanson <mjeanson@efficios.com>, Jens Axboe
 <axboe@kernel.dk>, "Paul E. McKenney" <paulmck@kernel.org>, "Gautham R.
 Shenoy" <gautham.shenoy@amd.com>, Florian Weimer <fweimer@redhat.com>, Tim
 Chen <tim.c.chen@intel.com>, Yury Norov <yury.norov@gmail.com>, Shrikanth
 Hegde <sshegde@linux.ibm.com>
Subject: Re: [patch V3 09/20] cpumask: Cache num_possible_cpus()
In-Reply-To: <938a1d18-c7b0-45d6-ac4b-4c1246e08044@efficios.com>
References: <20251029123717.886619142@linutronix.de>
 <20251029124515.846126176@linutronix.de>
 <938a1d18-c7b0-45d6-ac4b-4c1246e08044@efficios.com>
Date: Wed, 29 Oct 2025 22:11:33 +0100
Message-ID: <87sef1tnui.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Oct 29 2025 at 11:54, Mathieu Desnoyers wrote:
> On 2025-10-29 09:09, Thomas Gleixner wrote:
> [...]
>>   
>> +void set_cpu_possible(unsigned int cpu, bool possible)
>
> Unless I'm missing something, I suspect that "set_cpu_possible()" should
> be marked as __init.

Good point!

