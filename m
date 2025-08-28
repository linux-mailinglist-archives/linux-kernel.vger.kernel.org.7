Return-Path: <linux-kernel+bounces-790530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6587B3A9DC
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 20:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E66441B28400
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Aug 2025 18:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E3E2727FE;
	Thu, 28 Aug 2025 18:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mOFY1M+H";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qMkDZJe3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE322236F3
	for <linux-kernel@vger.kernel.org>; Thu, 28 Aug 2025 18:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756405242; cv=none; b=T06lZFH/1vBGma4FTbRqwtG5Awg8a2YSb7B41/I/Ty9YQEqn3LgyoVdQhi7OZj6lN7nyKISqW8sMLmn6voWY7+mU2zFu4T/ZwFUmpCkIRkYKaz4aY8OD0D29v++oJemooVLJHFHkxacRVLRzuh7Eu3SspfAQyxdK2DGKq42VVRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756405242; c=relaxed/simple;
	bh=XFTi5lpq+sSi55T3SeKKwHf9sQvKs+0TcUUfU2Bv1xA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdalPzUJi7qRBtgpZ4qlypr0Ak2kKd1cmhHWOPi4xHi/S1qwcu2+jWtLxYEEhHDkcu1CGzeG9OotStgD6CPdGEif+6w1rP2gAl4UbU6sSxSnO1uz3xyB4poZXquVP+9Ufx/Merh6v4Z+jB+faxun0cpZxPteVm997391KqnIfjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mOFY1M+H; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qMkDZJe3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 28 Aug 2025 20:20:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756405238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XFTi5lpq+sSi55T3SeKKwHf9sQvKs+0TcUUfU2Bv1xA=;
	b=mOFY1M+H4dFsHxHvOu0nun30XJgX3IExDFYgzRZ6d8Cws+csk+GhDm5m4noGHcEDDy7czR
	L3afZKdGoGrtzbw33hUciUiScUnh8qU6xEf2suquxgbW1tmaNfELVlVqSaX9g6zqLlzByo
	BFNrz7o+LKWAmMA5a9Eyhr04F5AQ9VPCxZX6bTyYYgH3LGHfGwX7dMSzjokk9/iYeJh/V1
	DujSnSAfZqcsM75YHyhnhNWr8sXyQRdgOAMfT+xYJF6qBDjrq0OuvBQRyKgwj4DcINEcgw
	lD6LOR3RYpJy/m1hkGYJuXjGOR2HMOxKNTrPDZcctQ4VCeoBFgypqlJH6WmrRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756405238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XFTi5lpq+sSi55T3SeKKwHf9sQvKs+0TcUUfU2Bv1xA=;
	b=qMkDZJe3zgoJEbY6WZ560qcwvuP775OEss5Y9w9vZeTvt8eokEg/nuHBMkHz2hmCAF/flm
	pfJhEGJirr131FCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>
Cc: Waiman Long <llong@redhat.com>, Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Borislav Petkov <bp@alien8.de>, kernel-dev@igalia.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/futex: Fix futex_numa_mpol's memory out of
 range subtest
Message-ID: <20250828182037.qkdKVaTN@linutronix.de>
References: <20250827154420.1292208-1-andrealmeid@igalia.com>
 <9d4c0d27-0ebd-4c6d-af38-d32ef420fde4@redhat.com>
 <61725722-f933-447c-a041-71b2d28e7f90@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <61725722-f933-447c-a041-71b2d28e7f90@igalia.com>

On 2025-08-28 15:06:26 [-0300], Andr=C3=A9 Almeida wrote:
> Thanks for the feedback! I will send a v2 addressing this by next week.

Any objections for getting Waiman's fix in for now and your rework for
next merge window?

Sebastian

