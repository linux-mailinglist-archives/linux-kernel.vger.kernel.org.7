Return-Path: <linux-kernel+bounces-767528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F5CB255A1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 23:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51AD41BC6EF7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 21:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBEE2F0C66;
	Wed, 13 Aug 2025 21:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kixCU72p";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="miPQTsxy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4008417B50A
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 21:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755120780; cv=none; b=kd+pNoQwmv2VMKC5ZRQo+ME9QhXH6HTXNORhzzUT2eMmQ2e9IbKKuM1fgKlMpam0SOBWhQNQFXY6QH58M8sYYJtdk51L75BxxCBY4cEXx76ak/8vr6lZM6KIK/UcCAhfkW37MrhvXrZn0+j/TqGi5fZm2taD5269spMWbFFE/7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755120780; c=relaxed/simple;
	bh=u8Pyt5wWXrSvDLFQ73CXqthEMQ5R6UrJQVV6hA8lnGw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kq1eHorBX03fypNjndKVkCbCK9A+pj/+3B44AmyFf/Uke9DE5Zeq8XlR6ZS7xi3iOPEHd7+fNuLb0/Wsh1bv5ko/+31pK5fM4j5EtWyyLhz4+YtrW7DI5frJdMLRHfXXS3IDElgZTfpByDrse24/1pyMlwEDO4B16oC95yZprMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kixCU72p; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=miPQTsxy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755120776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F92pkFXjQnC4OZ1VICcLVkKgVuSoopvPjrfi+MtqLwk=;
	b=kixCU72poGCChbEXMWmlNqsBAYy4OM+H6ppQvCyT99GpG/RK2e9zpo0Qe5bD1kTwYPsj+p
	HwgPwGcc5EHl1yqx6kLe4tahL7l5yGIpSHqaqjbaMkUPM9ZXBTvXGh0/uaQr8/relfgsfw
	1j3BJvtIk2MoOz9f3S28aUDoxEumhsWxUboSmbSyh8NuJfTpRJboZ+XjPvvTIemiazq9wZ
	PfgIo5fVskt9mVKa3zwHL+4TCo7KNsFtvNQ/0nW5AKLyAXuRHYEDF843tqjHmqbZCM1bmh
	ZSRgBO9oX7yZNdLjSbimGI2SStCJaKe6YBnM2Y8P3YRD8TPBGHZEfrfZ2/oYsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755120776;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=F92pkFXjQnC4OZ1VICcLVkKgVuSoopvPjrfi+MtqLwk=;
	b=miPQTsxyE++O+DeKjpIBpTZgllKO3OLAhhTA9/CUyvkuv9B29R6y+xE8kc24zuxicBDocS
	2kWjkJKstFkRe9Dg==
To: Jens Axboe <axboe@kernel.dk>, LKML <linux-kernel@vger.kernel.org>
Cc: Michael Jeanson <mjeanson@efficios.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Peter Zijlstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng
 <boqun.feng@gmail.com>, Wei Liu <wei.liu@kernel.org>
Subject: Re: [patch 00/11] rseq: Optimize exit to user space
In-Reply-To: <12342355-b3fb-4e78-ad5b-dcfff1366ccf@kernel.dk>
References: <20250813155941.014821755@linutronix.de>
 <12342355-b3fb-4e78-ad5b-dcfff1366ccf@kernel.dk>
Date: Wed, 13 Aug 2025 23:32:54 +0200
Message-ID: <87bjoi7vqx.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Aug 13 2025 at 11:45, Jens Axboe wrote:
> On 8/13/25 10:29 AM, Thomas Gleixner wrote:
>> 
>> suffered badly from the stale eventmask bits and the cleaned up version
>> brought a whopping 25+% performance gain.
>
> Thanks for doing this work, it's been on my list to take a look at rseq
> as it's quite the pig currently and enabled by default (with what I
> assume is from a newer libc).

Yes, recent glibc uses it.

Could you give it a test ride to see whether this makes a difference in
your environment?

Thanks

        tglx


