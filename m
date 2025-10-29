Return-Path: <linux-kernel+bounces-876309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6603BC1B8A4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 16:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 147853BC8E1
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Oct 2025 14:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9011F7575;
	Wed, 29 Oct 2025 14:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b="V1QDIcxV"
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623121B4257
	for <linux-kernel@vger.kernel.org>; Wed, 29 Oct 2025 14:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.134.164.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761746681; cv=none; b=IDE+rPGIj3WP4zKTbsSjRiUhtl8E1hFnJ0IOPdhvzzN6U43xsAyaLfgc7ePgvK0W/Zc4CmX8IYh9rdWUnQppZiJSvpZnZ5Vak9a2H6pbKqOeUj3dBJwDi63ndZVQQpJieqC92wDc87F2qtcm0swImBpVyi9Vs1vjPtStCrhLz98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761746681; c=relaxed/simple;
	bh=LjgZ+8Qvmq2LnO34BG6M1cGWj4cLJmHvHdPjTj2fjgg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ZjjeoZxmp5l+W4Q2nxviVaQYJxc4+fpxabGyB/C++2QWe4u0nd2blJc4bYraXrSgCE4BuTXz/h2pCoYLQZHSIwFuZ+OoB0bImCgzY4UabL0HGsmZFacLFKy7cxxBuQ9kQbDcIkvHgV9eO7flRDhyooHJ68v2X3hOGwMLQEI6t1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr; spf=pass smtp.mailfrom=inria.fr; dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.b=V1QDIcxV; arc=none smtp.client-ip=192.134.164.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inria.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inria.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=GW5JfX3QBMOHPTucfcg6McfzsaX2iUcJ+WJkFYkpThI=;
  b=V1QDIcxV1OpOgdIrAhAvJ3axda4B03iobbmS4Cxbaosfow98RWEcwPR+
   iKyyNiIW3oJqdI1Kulr1KZiinVJ8rrbeW+2YLZoDGxWTx0k5hyUKiKFB6
   +9I2hW4/AeoyXH6Aev2kVoK/lnzRHNq9Qr6dIXGvA1ezcZMtR328mkeQR
   k=;
X-CSE-ConnectionGUID: 59zTktmgQ8+Fk5Ugd4Ez+A==
X-CSE-MsgGUID: bu7tKIpsRhqROUrqIztnFQ==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.19,264,1754949600"; 
   d="scan'208";a="246692466"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 15:04:36 +0100
Date: Wed, 29 Oct 2025 15:04:36 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Gal Pressman <gal@nvidia.com>
cc: Johan Hovold <johan@kernel.org>, Nicolas Palix <nicolas.palix@imag.fr>, 
    Jakub Kicinski <kuba@kernel.org>, Alexei Lazar <alazar@nvidia.com>, 
    Simon Horman <horms@kernel.org>, cocci@inria.fr, 
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Revert "scripts/coccinelle: Find PTR_ERR() to %pe
 candidates"
In-Reply-To: <826f2fdb-bad8-44f4-8c8e-9353c3de73cd@nvidia.com>
Message-ID: <47ef2f61-85c1-92fa-12dc-e5918d90488@inria.fr>
References: <20251029132922.17329-1-johan@kernel.org> <826f2fdb-bad8-44f4-8c8e-9353c3de73cd@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Wed, 29 Oct 2025, Gal Pressman wrote:

> Hi Johan,
>
> On 29/10/2025 15:29, Johan Hovold wrote:
> > This reverts commit 57c49d2355729c12475554b4c51dbf830b02d08d.
> >
> > Using "%pe" to print errnos is in no way mandated and a driver authors
> > may chose not to use it, for example, for consistency reasons.
> >
> > Drop the recently added cocci script that has gotten the build bots to
> > send warning emails about perfectly valid code and which will likely
> > only result in churn and inconsistency.
> >
> > Link: https://lore.kernel.org/all/aQHi4nUfIlcN1ac6@hovoldconsulting.com/
> > Signed-off-by: Johan Hovold <johan@kernel.org>
>
> The test by no means mandates authors to use %pe, as the output says:
> WARNING: Consider using %pe to print PTR_ERR()
>
> "Consider" :).
>
> I would consider it best practice to use it, and a few drivers were
> converted thanks to this test.
>
> If the issue is with automatic build bots, then maybe this test should
> be excluded from them, rather than deleted?

This is easy to do.  Or I can discard them when they come to me for
approval.

julia

