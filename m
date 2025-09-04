Return-Path: <linux-kernel+bounces-800179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C767EB4344B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 09:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 542A87A6679
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Sep 2025 07:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99062DBF48;
	Thu,  4 Sep 2025 07:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DN6DEquL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="12Dz8n+B"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D156F2BD5A8
	for <linux-kernel@vger.kernel.org>; Thu,  4 Sep 2025 07:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756971228; cv=none; b=cqxAbXOThiA5A5ZTo6+B/2yciUCnAcNNCEC4mTC3f7lkn/QOE7ZEimuND+MpWMGNS1RHQfdSw0k1RbspD8Y4W65URidxY2f9kEvAp/0haSb8yKGxEJz/P1P4abYy/gmKNM01gZmxOZxIshYbLQgnR9fot/Ha0KvrFIf5rjp6WFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756971228; c=relaxed/simple;
	bh=ienDHB18/6JnMp8bUj3ZRO82kjn5yq80VpqVKvFeD9M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p5/zgAHor7f7wQ/KV6xhN/8b8xnPQpFU+IqM5TTeTIVg6z0MgT/9Nj9WuYVh2+4dkR9dYuWKZgdqPWDw02WtQFwT0yjwUs4+e9atbjt1Hh1WEJwIr3+fcxvJVbBD+cjvgY29GVWeZyix9rwZ4uoJ3G1AfBpsKStl9JyYpzmUWB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DN6DEquL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=12Dz8n+B; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756971224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ienDHB18/6JnMp8bUj3ZRO82kjn5yq80VpqVKvFeD9M=;
	b=DN6DEquLvrAKYb0VnToMoAQzgNqtKm9cLYzH3SUCr4yCp8bGCm3U4hzMaT0sUcoAtdV8vn
	XWAX8wPu9gC3GHSsJxgDcNOn3uRNaHSymKLVlAqJMAzz4wLpfZuTOynn6yI4WFTEWag/pJ
	dDY7OIeGBXrwKmjBDsh/M/87tYwlBwfgV4lQjeQm6/pWkrxfsojZVcGPEJ4re8gQA89uZF
	reMBHABJ/7XnG6wAjHZvWhzpOVsoZB3hd7xOXaVz3sTcujaiZmDxs9+EaK+hAR5tYJCfry
	qhiRA5q6nncCOd0/zA6OMslkQdEpGU/9Yo1ZH8sXxE5Mu8IZTJ7PrW5qJXiMcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756971224;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ienDHB18/6JnMp8bUj3ZRO82kjn5yq80VpqVKvFeD9M=;
	b=12Dz8n+BHEyhUGl9M5E90ZPvu/c8W1/9CqYgL3/+pW0Mcs/+y1GzTq66Nns6BS5+PrveUW
	Pyewo8x5R+jjdJCg==
To: Daniil Tatianin <d-tatianin@yandex-team.ru>, Petr Mladek <pmladek@suse.com>
Cc: Daniil Tatianin <d-tatianin@yandex-team.ru>,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Sergey
 Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v1] printk_ringbuffer: don't needlessly wrap data blocks
 around
In-Reply-To: <20250903001008.6720-1-d-tatianin@yandex-team.ru>
References: <20250903001008.6720-1-d-tatianin@yandex-team.ru>
Date: Thu, 04 Sep 2025 09:39:44 +0206
Message-ID: <84v7lyu0x3.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-09-03, Daniil Tatianin <d-tatianin@yandex-team.ru> wrote:
> Previously, data blocks that perfectly fit the data ring buffer would
> get wrapped around to the beginning for no reason since the calculated
> offset of the next data block would belong to the next wrap. Since this
> offset is not actually part of the data block, but rather the offset of
> where the next data block is going to start, there is no reason to
> include it when deciding whether the current block fits the buffer.

FYI, I am taking a look at this. We need to be really careful not to
introduce any subtle bugs.

As an example, data_check_size() makes sure there is always room for the
trailing "next ID". But with your patch, that check is
overconservative. For that particular case it really isn't an issue, it
just means you would not be able to have a record the fills the full
ringbuffer. But my point is that there may be parts of the code that
assume there is always a trailing "next ID" (since so far that has
always been true).

I just want to be careful in my review of it. So please be patient.

John

