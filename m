Return-Path: <linux-kernel+bounces-882647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5218C2B03C
	for <lists+linux-kernel@lfdr.de>; Mon, 03 Nov 2025 11:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4001D1886094
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Nov 2025 10:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08DAB2FD7DF;
	Mon,  3 Nov 2025 10:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="gONmfi3D"
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92D23A1B5
	for <linux-kernel@vger.kernel.org>; Mon,  3 Nov 2025 10:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762165271; cv=none; b=AK24VJ4/p3Glk421q7C8BsODSvl797hfloDZ/i7ndDKZ5hf0erNLTFgo15GbneS1gS36vWNe1HQqKK2tx69BGtJqJ931lP0X4V1GKjJpkaFCv27aFGUGImtZ7S+WvA59nu6fri3zGOLgxJCTZTV53569IRXqNvRCkUjxSLKY+aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762165271; c=relaxed/simple;
	bh=k1EGgemh0YvKaAypzO46uDpmkC8C0SwmtOwNRcFu0Iw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=UQn6XmLo+JDOdfdOY5kej7t+dgbMm4bDdqZwOdi25II9cUOfMmsJYrm7sL0+yZpF1veTnfngpq61fVDtzQ7EwDZ7zet0+ZgdHF8v8IAlf/9ISDBhMPudJPkkpvCpJ3O8t2vX/qoeeK/VHTdX1M9Bxwl19VbSHaJJnw7eW1hUyH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=gONmfi3D; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762165266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UduoQ5cPAGugAapT/bwQuTkKlfFPoSHFciwdeqtq810=;
	b=gONmfi3DuBPgW4/lMY4f+hmhb5cugJMXClVH0tlqAX0xng5VylNyvMensbD+YCiwVOB0SY
	zJlKMyfZ6i+vdFKv2wBto0iCfRhIHwp8face7GcmAjrp4IVop6bSXPjzWPtff/JsPabWpL
	gmsQLT/NK2V06QD0TXMjZ63CHBnTEGM=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH RESEND] lib/vsprintf: Improve vsprintf + sprintf function
 comments
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
In-Reply-To: <aQh5GINiLL9xLlzg@smile.fi.intel.com>
Date: Mon, 3 Nov 2025 11:20:32 +0100
Cc: Petr Mladek <pmladek@suse.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Sergey Senozhatsky <senozhatsky@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <03A68F34-E2D1-4687-874E-8D976406BF72@linux.dev>
References: <20251103090913.2066-2-thorsten.blum@linux.dev>
 <aQh5GINiLL9xLlzg@smile.fi.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Migadu-Flow: FLOW_OUT

On 3. Nov 2025, at 10:42, Andy Shevchenko wrote:
> On Mon, Nov 03, 2025 at 10:09:13AM +0100, Thorsten Blum wrote:
>> Clarify that the return values of vsprintf() and sprintf() exclude the
>> trailing NUL character.
> 
> I dunno if we need this clarification, but I'm not against it either, FWIW,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> if it helps somebody.

Thanks. It would have helped me :)


