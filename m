Return-Path: <linux-kernel+bounces-739868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD700B0CC44
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 23:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D7FD540EF5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jul 2025 21:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB61B23D287;
	Mon, 21 Jul 2025 21:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aU9WQ9Km"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009521DFE1;
	Mon, 21 Jul 2025 21:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753132418; cv=none; b=F0kE+//oIBUPJmIufE/rssQTmUpq1DFjbZ6QgmU0mamRi0obdt/XnrrHO/4Hi+XW3ZdKK4IyKpVv3kFZUT0SnaXP5eOBrh4fOL9s6rNN/fQAz2xxHRt6LEOVtqP5QxcEXixR3IVAkaJjs4ULD5PHEFIsSGRTeEGBGSHnqnXTtOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753132418; c=relaxed/simple;
	bh=mWPQrQ8PnPYgeaxRilzofv7vpYdirtRlcUykEhqi2VI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=WA7uLGWjD7qROkxOyG9j22FNLIalYx5sO2AINxAf+OqCYH+eo6YBoEPjMinyXblWmeUeJ1X3Uo3+xNhFWP6z1VfcWUiiyoKcSmIRLpiIdWILiuME4CdjA7xRuxJfuf6nvj8S4ySOwMi0L3QmmLAvc5wMdtKlPDG/zXJNegpKX6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aU9WQ9Km; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36214C4CEED;
	Mon, 21 Jul 2025 21:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1753132417;
	bh=mWPQrQ8PnPYgeaxRilzofv7vpYdirtRlcUykEhqi2VI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aU9WQ9KmS1jhzsDDLOkfoo3ShHj3krKQPQUzbdHXuiRuLQN+KuEM3pv9ES2ysKEjr
	 vQvWtKqXFfSRpthpLMOFSSXCyUirPUXaSpALbGDw3apYAciIG0gSKSWKFaATUb8mUh
	 q2kL8nA7YzldaRCiB/F0oMAjaAypBe8Y/DvgfBEI=
Date: Mon, 21 Jul 2025 14:13:36 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Linux Next Mailing List
 <linux-next@vger.kernel.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, George Abraham P
 <george.abraham.p@intel.com>, Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: linux-next: build failure after merge of all the trees
Message-Id: <20250721141336.1491a3b5b09529171d65db6f@linux-foundation.org>
In-Reply-To: <aH4nnsecLEqrCrpK@smile.fi.intel.com>
References: <20250721173754.42865913@canb.auug.org.au>
	<aH4nnsecLEqrCrpK@smile.fi.intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Jul 2025 14:42:22 +0300 Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> > Is there any good reason not to do this?
> > 
> > I guess this patch should have
> > 
> > Fixes: 39ced19b9e60 ("lib/vsprintf: split out sprintf() and friends")
> 
> This sounds correct to me and your patch should be sent as a fix to the stable
> kernels as well.
> 

Yep, thanks, I added the cc:stable, queued it up and shall send to
Linus this week.


