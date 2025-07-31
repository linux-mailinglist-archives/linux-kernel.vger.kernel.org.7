Return-Path: <linux-kernel+bounces-751698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93203B16C68
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 09:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0F1956829F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Jul 2025 07:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0949F28C02E;
	Thu, 31 Jul 2025 07:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wZoqS4GE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6LtiQIhE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF4772617
	for <linux-kernel@vger.kernel.org>; Thu, 31 Jul 2025 07:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753945747; cv=none; b=d7WZeE3mWdegKMEdBrhrfZ62JUka0hOFsGVjmaLODvBf77z4r9OprmT0Etv+4ykkmRnQOduUtIOBjWm8WSkAZy8BvOFKpiQpRFvMXZqjSyKDCiTmiXDPpBKL/Q8XQ9Zast8bPkzVzOzp07UHG4VI1AqCap4/GWJcmKfdm5AHkfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753945747; c=relaxed/simple;
	bh=3CegUHe+7UemHnE/ubES78XKIkLpzEVOgLyiU4X1cz8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T0JrWxj5g7Bb5/+ftk+kFC4hvjcZOFl919EMO0w7VL3wLK0WeYfc7sVROibKSZsFuJy42K2pYkd9r6jRTp8W3urPNNJRMj7a0dPcCj0eoHGmtVePa4Hzqpc3aFPOkRuN6HBdbDmvWKoUsDaJzOhzbDIzZCTwcV+qx3lk9wc7ELk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wZoqS4GE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6LtiQIhE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753945743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3CegUHe+7UemHnE/ubES78XKIkLpzEVOgLyiU4X1cz8=;
	b=wZoqS4GEHyVDb1tMiyrxto4guIe+n5ctbITrDwYvEPulshBOeYLzLtgWPs8lyHF6VV83Hr
	UbpEJPRx/IFLXz4ddxS8kg1xiJeWxmhaCkAk/tzCI5W3ms9Snuj1Y/+ZR9fKrrw3lLtVK5
	VNOe7RdCK/DeEpSa6WyZxKSH6ejx1Ohl0J8Z0R1q7NDDDJC3Q9a2UhU9XV1TFbd/gfOLFU
	4zrDIWLRMWxiplW5fNG10bCLPWyqDvxJI1TGKu5YiyuV4yFBbwUcIkS6ZcU/53LumXDcAv
	4Tos5VUX0L4yh9vBJJII3TiO/+fUlPVhGKu0T3WmruR54nDXF85ispN8sMxfnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753945743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3CegUHe+7UemHnE/ubES78XKIkLpzEVOgLyiU4X1cz8=;
	b=6LtiQIhEZk62J0enoPf4hccPTHwfiYezGQyYXenJYH0B0xHuTZKARcIq21PYsZOZv+nNHJ
	XoX/y9g76kQnSUBg==
To: Sergey Senozhatsky <senozhatsky@chromium.org>, Andrew Morton
 <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>
Cc: Feng Tang <feng.tang@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] panic: remove redundant panic-cpu backtrace
In-Reply-To: <20250731030314.3818040-1-senozhatsky@chromium.org>
References: <20250731030314.3818040-1-senozhatsky@chromium.org>
Date: Thu, 31 Jul 2025 09:15:02 +0206
Message-ID: <84seichm5t.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-07-31, Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
> SYS_INFO_ALL_CPU_BT sends NMI backtrace request to
> all CPUs, which dumps an extra backtrace on panic CPU.

Isn't this only true if CONFIG_DEBUG_BUGVERBOSE=y?

Also, the information is not the same. trigger_all_cpu_backtrace() will
also dump the registers. For CONFIG_DEBUG_BUGVERBOSE=y on the panic CPU,
only the stack is dumped.

John Ogness

