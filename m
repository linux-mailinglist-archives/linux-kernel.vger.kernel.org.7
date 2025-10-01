Return-Path: <linux-kernel+bounces-839201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 74755BB10AC
	for <lists+linux-kernel@lfdr.de>; Wed, 01 Oct 2025 17:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04233188ED64
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Oct 2025 15:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F4526E71F;
	Wed,  1 Oct 2025 15:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e05CnD+v";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7FcZZN3z"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636C617C77
	for <linux-kernel@vger.kernel.org>; Wed,  1 Oct 2025 15:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759332115; cv=none; b=tau319hcEpS5+eYo9ExPKHBCr0nTYg7Cp67AGqhVitzsDU706uTMCl0Ze03PUDpVzDUs7scmD8xR4TrAIrll6NZMhAeNIpGIYc52HGHHI8TBujCz9HlxJcGBzF+0wsV8nMBHgadbGi7YkMeen0h55n/WwXVQnn2I3On/PKu6Lh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759332115; c=relaxed/simple;
	bh=7hlptcm/EwaISWLnJu9dMyS/XTW1fEyLyqYgBYC1slk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lE+0fj8hcXTIoAybDASuRiblxyTfG+TGJipEW/zgdLMfLqHz8t8VzgkS1cln83umxVmurfrNskuO4OMVnLxcV3gi22bkRSbBi4qRRTe6Dope/06LzjFBnzF24SgcoU9vFCHVRypqtIg/QrTV9nlE2CCQXV3mL3eAMJpsLmzjbP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e05CnD+v; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7FcZZN3z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1759332112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7hlptcm/EwaISWLnJu9dMyS/XTW1fEyLyqYgBYC1slk=;
	b=e05CnD+vkhPQDkJxIDWZuErtqO9n73Y5Hfn1EQBLtPL83GYpU9AT7+Hk2itplAUfpTosLE
	+SL6le0L1Jb4q+GM8ufuLMQChMLlos+baVLGkD2xMqcFlUsFeq+7Y3lK70bWmRMCTiyD15
	LYeEd3cxl6qkWeCsghotXAQmGrMYM0RB921i2+SyKJBK8EGQsD7/0soZMQneLhBpVlaooU
	uFtZ93dpLiSv7yVp2lsVtqvN0SUmLrufKpzbnq/hZHWPmUgovx60373JnnLD0HqFst7W3G
	gBNyF82Lg1uYmSxNykrSChE6FqeX1fUBfQn/n5JDqyvtutTlW9f8TYLuvFDRDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1759332112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7hlptcm/EwaISWLnJu9dMyS/XTW1fEyLyqYgBYC1slk=;
	b=7FcZZN3zpqMpzlf3b5TD/X033mENT6B3f6M0hqI2hqhNHp48t5/ezRoiUsQt/aCInLUwLy
	RIbXsCxktUMdv7Cw==
To: Marcos Paulo de Souza <mpdesouza@suse.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Petr Mladek <pmladek@suse.com>, Steven
 Rostedt <rostedt@goodmis.org>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Jason Wessel <jason.wessel@windriver.com>,
 Daniel Thompson <danielt@kernel.org>, Douglas Anderson
 <dianders@chromium.org>
Cc: linux-kernel@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
 Marcos Paulo de Souza <mpdesouza@suse.com>
Subject: Re: [PATCH v5 5/5] kdb: Adapt kdb_msg_write to work with NBCON
 consoles
In-Reply-To: <20250930-nbcon-kgdboc-v5-5-8125893cfb4f@suse.com>
References: <20250930-nbcon-kgdboc-v5-0-8125893cfb4f@suse.com>
 <20250930-nbcon-kgdboc-v5-5-8125893cfb4f@suse.com>
Date: Wed, 01 Oct 2025 17:27:51 +0206
Message-ID: <848qhuhckw.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-09-30, Marcos Paulo de Souza <mpdesouza@suse.com> wrote:
> Function kdb_msg_write was calling con->write for any found console,
> but it won't work on NBCON consoles. In this case we should acquire the
> ownership of the console using NBCON_PRIO_EMERGENCY, since printing
> kdb messages should only be interrupted by a panic.
>
> At this point, the console is required to use the atomic callback. The
> console is skipped if the write_atomic callback is not set or if the
> context could not be acquired. The validation of NBCON is done by the
> console_is_usable helper. The context is released right after
> write_atomic finishes.
>
> The oops_in_progress handling is only needed in the legacy consoles,
> so it was moved around the con->write callback.
>
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Marcos Paulo de Souza <mpdesouza@suse.com>

Reviewed-by: John Ogness <john.ogness@linutronix.de>

