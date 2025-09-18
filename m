Return-Path: <linux-kernel+bounces-774399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A14D2B2B1B9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 21:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDB553B5FD7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Aug 2025 19:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D643451B3;
	Mon, 18 Aug 2025 19:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="A587SMQv"
Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8AC78F36
	for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 19:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755545528; cv=none; b=posy/D9t91JWvzvq1xAg8Q+dh0T2ejOZ5Yd7ckPm+l4c4GXRUpJkpOC53JYJsUccqlJihZC9nvgVjh4gnstT5tq/ZNdezScJzhFMREBz2PRCko53Sqc+7dk/O1oPa+82cRX3ro9+T89XBX7891SgymaGFRFMknDDLVMRLKg0ZQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755545528; c=relaxed/simple;
	bh=XNjz0I2eUY/Kr2G52Qo4E3MpWKIoWqP2+NCSQHIjBqI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=pxZrAy7STk3EQsyqwXxZqy0V1lVz5EqyO+aTHd3CaPSUD5brtFChx4Hr2k/8o5XpzB71YdgVcJfGve2tbAaaUwsl4JfscoDInndsVuvMsKIqRftWkOpmi20VAbd+NaKZ4wM//ju/dKZMgMVtGhdwMVp4iStkckuww4+MSDE5v4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=A587SMQv; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755545524;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3IWli4z+BgUSiJzQPJlT48mDOgPDj86VGLzv17N+ak4=;
	b=A587SMQv1d16oej8NYD1kxIDDoIfTcrYAKEql/P9cnEmDztkEDLX3Nx+z5FL+MXz5XxnP3
	ysQ2HROoynCqG8E6N4kmfXx1Bbi10WsmD6INkAOJes4RwZB4mtrTVmORtg1CoGzwYmgmq0
	2ZUeSuYqm3xfu8CDT/3hK2tqwE61QOI=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] kcsan: test: Replace deprecated strcpy() with strscpy()
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <hqvjfoaw5ooucqp3mwswrjxletq6vdzztwvlaxvxf5a6bivdzf@7fcytrsqhz4y>
Date: Mon, 18 Aug 2025 21:32:01 +0200
Cc: Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>,
 linux-hardening@vger.kernel.org,
 kasan-dev@googlegroups.com,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <6BC1BD59-839C-4A3B-AE91-8CE963C891AA@linux.dev>
References: <20250815213742.321911-3-thorsten.blum@linux.dev>
 <hqvjfoaw5ooucqp3mwswrjxletq6vdzztwvlaxvxf5a6bivdzf@7fcytrsqhz4y>
To: Justin Stitt <justinstitt@google.com>
X-Migadu-Flow: FLOW_OUT

On 18. Aug 2025, at 20:26, Justin Stitt wrote:
> Looks good.
> 
> Here's my checklist:
> 1) strcpy() and strscpy() have differing return values, but we aren't using
> it.
> 2) strscpy() can fail with -E2BIG if source is too big, but it isn't in
> this case.
> 3) two-arg version of strscpy() is OK to use here as the source has a known
> size at compile time.
> 
> Reviewed-by: Justin Stitt <justinstitt@google.com>

Thanks for your thorough review.

Thorsten


