Return-Path: <linux-kernel+bounces-732102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F551B06220
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 16:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F9F5586915
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 14:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF571E5701;
	Tue, 15 Jul 2025 14:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="MyHJkUKW"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFCB1FBE87;
	Tue, 15 Jul 2025 14:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752591021; cv=none; b=JUaMRzIAfLCLmYQADwJJhtG8rlN9DF0k2duaeeIXurrvLhKoocDmU8fqi9BXOgCg0iq7r7oAgqMi/bhGA+lxhcmoYLKaEHL31DT5PP48+7PrEyZdYi4noS3lUumEJ6ep79UilCRy9IDZLY00pARVNZnQBYaYdtm/S8x+Ozvkz/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752591021; c=relaxed/simple;
	bh=+wgGVto9dsSs8/v9aJtijZl/1/TPhlSs51dcW7v4a+Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VAxjAuj4FtcYVP+bD/cBTSWVjbdD/R2YuOa9sEeK42mIc11qs+VWNd48a/FdOwWCJVYiH01kJ3wUOMgY08K8w7gWcVbkZ5jn1pZQ7R73WDmXfoSL8DOqpDb4TO6GyxJG0ipglRRqF6niLgEnK3poQ3EsjpgxQ3ZEEpAKnWbTLEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=MyHJkUKW; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7985A40AD8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1752591017; bh=uH2D2NvjUKhPxtxAe4lDHQ8oj3q8V1MzrlSAX96qGyk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=MyHJkUKWM/x2PV+jcuJ3rtwD1JdD3uGDqp6KITRpv1lKIQ87ESqFpnieHR1vfDghY
	 Q5pz/2T2dZPbT32+8emzfXCq4L06OY3whZBtzx7Lp+gRKQKFaMmCwKGX33BOa/f5dW
	 aEXpzHswDDq+yWA3Tt9567sUOIAmQVX79COMOEMQv0fYRdKNnVwkUX0GPIbVdFS+/G
	 I4HZMrD0KLy/PyKUT2wAvru5wRIV8LjYWB7CEwG2U+06gKTNsQlUEUCTPa/1y+PoSw
	 DVysczP+OHUpNojxZoygS5W8yPC/RO564coW0IYgnHzjvmdXeOnP0TXjDXOj3/rtF5
	 bw/jxIa1Nx/YQ==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 7985A40AD8;
	Tue, 15 Jul 2025 14:50:17 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Cc: Boqun Feng <boqun.feng@gmail.com>, Clark Williams
 <clrkwllms@kernel.org>, Frederic Weisbecker <frederic@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, John Ogness <john.ogness@linutronix.de>, Peter
 Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>,
 Thomas Gleixner <tglx@linutronix.de>, Valentin Schneider
 <vschneid@redhat.com>, Waiman Long <longman@redhat.com>, Will Deacon
 <will@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 3/3] Documentation: Add real-time
In-Reply-To: <20250715144127.697787-4-bigeasy@linutronix.de>
References: <20250715144127.697787-1-bigeasy@linutronix.de>
 <20250715144127.697787-4-bigeasy@linutronix.de>
Date: Tue, 15 Jul 2025 08:50:16 -0600
Message-ID: <87ecuhh5jr.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  Documentation/index.rst                 |   1 +
>  Documentation/real-time/differences.rst | 244 ++++++++++++++++++++++++
>  Documentation/real-time/index.rst       |  18 ++
>  Documentation/real-time/theory.rst      | 119 ++++++++++++
>  4 files changed, 382 insertions(+)
>  create mode 100644 Documentation/real-time/differences.rst
>  create mode 100644 Documentation/real-time/index.rst
>  create mode 100644 Documentation/real-time/theory.rst
>
> diff --git a/Documentation/index.rst b/Documentation/index.rst
> index c0cf79a87c3a3..78c93d992b62b 100644
> --- a/Documentation/index.rst
> +++ b/Documentation/index.rst
> @@ -42,6 +42,7 @@ kernel.
>     Driver APIs <driver-api/index>
>     Subsystems <subsystem-apis>
>     Locking <locking/index>
> +   Real-Time <real-time/index>
>  
>  Development tools and processes
>  ===============================
> diff --git a/Documentation/real-time/differences.rst b/Documentation/real-time/differences.rst
> new file mode 100644
> index 0000000000000..0b9a46a7badf4
> --- /dev/null
> +++ b/Documentation/real-time/differences.rst
> @@ -0,0 +1,244 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. _real_time_differences:

Here, too, you don't need this label, especially since you never
reference it.

I'll try to have a more substantive look shortly.

Thanks,

jon

