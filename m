Return-Path: <linux-kernel+bounces-720153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9B0AFB7AF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 17:43:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C27B1AA6448
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 15:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 312CC1FC0F3;
	Mon,  7 Jul 2025 15:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b="HC6Zl+yD"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EB51E3772
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 15:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751902921; cv=none; b=DxSZRSqkzJ8w295IJ1Xhoxr9LVDepzxw5Bu4G//n8vIhP8MNILxk2WyWXdwm3XR8Xu86kk1BDrjE4BxfODcdGoHYqVJXUysSUtS6udtaqqiVSXmx2GdZaDLC+HfD5ow+5VqbnCf37hX9Vc+7vUIWrI/H3L4sDMMwoYKNLP0QgEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751902921; c=relaxed/simple;
	bh=nZcqKdsiNZsgXi3CYyuSuyLeDkIyPeUFTwLlGsfH+YU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ffeL/UE4+Pk13vdETd5OJg/4Lcm98QHrD0wNgaWBtqVC61GVLuPJ8k3RJxoLJ9KewCT+jkZVgvEuEUgJagrz0ahEajg9cZNULN6yfxNB3hjLpvtlCabPZDAKT+DYyoAFqH6w5rua5+9OS1hFR2qEoGPFJ1FNzYBs9pEEDSemu/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de; spf=pass smtp.mailfrom=t-8ch.de; dkim=pass (1024-bit key) header.d=t-8ch.de header.i=@t-8ch.de header.b=HC6Zl+yD; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=t-8ch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-8ch.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
	t=1751902916; bh=nZcqKdsiNZsgXi3CYyuSuyLeDkIyPeUFTwLlGsfH+YU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HC6Zl+yDd0IraQCtoRPhJn/pNVxM+9OLUpLr6ZJ8eFa8mJg/zyO6DjHAuvKhSbMV7
	 GVXWHjtSmIwkHrDld+oxEG5N+W9VvInYzkQaj1QaK2hna1z0Pek027ULU2wSq/ML9X
	 vbWKAwTy4izRAvL6qi8Kw+/6ZQRdYrw2eXNoSrAU=
Date: Mon, 7 Jul 2025 17:41:56 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To: Willy Tarreau <w@1wt.eu>
Cc: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, 
	linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH v2 2/2] tools/nolibc: add a new "install_all_archs"
 target
Message-ID: <85c93c7c-239c-47aa-8a4e-d944c828314b@t-8ch.de>
References: <20250629170732.16817-1-w@1wt.eu>
 <20250629170732.16817-3-w@1wt.eu>
 <2363c2c9-a3ba-4b2b-849e-cd9e4d73297c@t-8ch.de>
 <20250706070124.GD29601@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250706070124.GD29601@1wt.eu>

On 2025-07-06 09:01:24+0200, Willy Tarreau wrote:

<snip>

> If it is made clear that there is no interest in packaging uapi headers
> for archs not supported by nolibc, then this means that nolibc can be
> the place where the archs to be packaged is decided, and the two can
> be more tightly coupled, but as of now, this lack of interest is not
> yet obvious to me.

Given that this functionality was removed from kbuild recently I assume
that it there is limited interest to get it back.
Also in v2 none of the kbuild maintainers or list are Cc-ed anymore.

IMO we can apply patch 1 first and on its own.


Thomas

