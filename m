Return-Path: <linux-kernel+bounces-871055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 42EC8C0C55B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 09:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7F8534F0EFA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Oct 2025 08:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1F72E8B72;
	Mon, 27 Oct 2025 08:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MWqrEI9R";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mBpwR5Tf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41382E613A
	for <linux-kernel@vger.kernel.org>; Mon, 27 Oct 2025 08:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761554230; cv=none; b=Ee+BWhS8onMjET+rs2j9wp8NKLc7bQICbI5JvEpt1v8SodULSz6Z6qKvdydIJo7+yWKUHCvX51+5p5w2j8v2LjQvgjUw0jblkTPVn4wMQ78zBwmkpw51m2Oc4DQyYqV5XNav2fIp/wyAPt63rcldmWYhI2+0gPNPLgivabmRYPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761554230; c=relaxed/simple;
	bh=23sooxuSf++o3+KFwXfnYu3rw2keOdZ8ITYkV4W9x2s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vs2wd1ZNmxBDH/X/vWPt9bU+yuJ+UD6R0FIdQquHhHXgSa07pYcrUU/NKJMi2sswjuOQ/AxI+AZfyQUIhZxmtxVZIl7zMA6ZE+WfYQhce6lFX6SFVCq60G6G4QHq2z9dBNn/Fl1zHe7gSNG2NspRkvI+2y04WvenQSruavp5kJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MWqrEI9R; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mBpwR5Tf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761554227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=23sooxuSf++o3+KFwXfnYu3rw2keOdZ8ITYkV4W9x2s=;
	b=MWqrEI9RoS/MGP8UetEf1sBvb25tNcS/CfqZKnR4w4bCYJ2nE6Kn+iP13vYuCLn4uSFBqJ
	nSxL73t/aS5QI+w22zTJh1JzxsmNeGHQHIg6sKAivaPk3D1XPOcEOhAVsDKBPDdTf0c+rq
	VzPhc5Y/HjrXa+kIyiqDcvkWK3K4eFOvK1CSYd6UqszPIRNCYDmhx5RPsATNnMIF6/0ClM
	2pYAcwOHBYRG0CR2t6oQHcynGQ94NpR0EJmYh369/1DkRJKpCHnHxAu2+rIl5nn7lCQlzu
	H8fF6VE5H3E8n5qJgeLRoZ8cIeZmXSZpn1FNnbdiies/D9yqqgtWpUrswuL/hQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761554227;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=23sooxuSf++o3+KFwXfnYu3rw2keOdZ8ITYkV4W9x2s=;
	b=mBpwR5Tf/OWIQu4kzk5gdFWDEmDW4ou6xZhltlhnJH8bV5wjeNjTvCCa5WXLN6DtNcMKpc
	qeovwMOkX92DwOCA==
To: Oleg Nesterov <oleg@redhat.com>, Petr Mladek <pmladek@suse.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] printk_legacy_map: use LD_WAIT_CONFIG instead of
 LD_WAIT_SLEEP
In-Reply-To: <20251026150726.GA23223@redhat.com>
References: <20251022154115.GA22400@redhat.com>
 <20251026150726.GA23223@redhat.com>
Date: Mon, 27 Oct 2025 09:43:06 +0106
Message-ID: <874irkspu5.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 2025-10-26, Oleg Nesterov <oleg@redhat.com> wrote:
> printk_legacy_map is used to hide lock nesting violations caused by
> legacy drivers and is using the wrong override type. LD_WAIT_SLEEP is
> for always sleeping lock types such as mutex_t. LD_WAIT_CONFIG is for
> lock type which are sleeping while spinning on PREEMPT_RT such as
> spinlock_t.
>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>

Reviewed-by: John Ogness <john.ogness@linutronix.de>

