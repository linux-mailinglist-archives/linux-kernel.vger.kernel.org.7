Return-Path: <linux-kernel+bounces-816304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F098B57208
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 09:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB70E3BF5EE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Sep 2025 07:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC39B2E9EA8;
	Mon, 15 Sep 2025 07:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LvNnyXh0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T54UbsVG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69262E88B3
	for <linux-kernel@vger.kernel.org>; Mon, 15 Sep 2025 07:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757922682; cv=none; b=JCb0QtAYrsJPBBqD9O8n8akNgTwQ8JXD3cpZRFjYAb/yerSZ/b2xBii1xgz9n2pcrqsY5nr6cFHGNqY3prp741KgSIuSqB4fAgymJkhFX9uDN3wB3tS6qiDropAiwxdY37jUZ2TGP1mjUbkNZi13hb0YD3BrgeLWRcDKZqLYPyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757922682; c=relaxed/simple;
	bh=/4m/TcD/L+nywzhzgZbHYHh/zumiDL+hLV8CZn7yQUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uf9lhgEuSV+WwJVz9UalygBBfjoiTP9a3OzNG1K5lXDTLa5ASDXey+7ePihpQC5hUw7ftNBhY8CsSR26SK07vSyQuM8bZ6g+EmbNvDOQguSaEkieYvBnsRLqT6GXtG9duLk/IbXsZxNvZtUoZ7pvIURCNXwCjhZNrikmN9p8/Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LvNnyXh0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T54UbsVG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Sep 2025 09:51:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757922679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/4m/TcD/L+nywzhzgZbHYHh/zumiDL+hLV8CZn7yQUA=;
	b=LvNnyXh055gKSdFXW8DmcKPAXCyqlXCFpDgcEhqI/P5RyLw050OEJ+YQFaCuuNkJW+K1nD
	KBftN74lZp1OPS6G0GaPIDBjDGksuIlPd78F1droOE2q73zXx3dLXT8D4FXiSqV1gTzqBP
	LTQI/kNFKZptFqezI2y5aFtNmpgiGosjfbOfm0/0XnFvxgZFtyc7pToT8fDNL0FZpDVm4y
	A+YfcipqvoZy1Ijfm46ZrKzsVvinNlWabQqvmOfqc7oJREuHmnaXMpQICTHBxj7ektvzco
	k+/btVbJJpBtlaP+3ePPXaGcp97X3WSGb3HjbRgYd8Tqq7kw14x0Gs5lLW1ISg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757922679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/4m/TcD/L+nywzhzgZbHYHh/zumiDL+hLV8CZn7yQUA=;
	b=T54UbsVGnfja1n7ath0NYQmyQClKwJSKcv2V6JWG2SqljVHN8B1ZAwDDIf01WpEH3JPpQx
	7QkcUVhhhDrfYlCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: =?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>
Cc: linux-kernel@vger.kernel.org, Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Waiman Long <longman@redhat.com>,
	kernel-dev@igalia.com
Subject: Re: [PATCH v2 1/2] selftest/futex: Make the error check more precise
 for futex_numa_mpol
Message-ID: <20250915075117.ts5Z9WGG@linutronix.de>
References: <20250904165556.56926-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250904165556.56926-1-andrealmeid@igalia.com>

On 2025-09-04 13:55:55 [-0300], Andr=C3=A9 Almeida wrote:
> Instead of just checking if the syscall failed as expected, check as
> well what is the error code returned, to check if it's match the
> expectation and it's failing in the correct error path inside the
> kernel.

Andr=C3=A9, these two are the only ones that are still pending?

Sebastian

