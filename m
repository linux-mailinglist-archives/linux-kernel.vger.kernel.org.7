Return-Path: <linux-kernel+bounces-892138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A28C446C0
	for <lists+linux-kernel@lfdr.de>; Sun, 09 Nov 2025 21:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E73DB188ADBF
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Nov 2025 20:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C9A23B60A;
	Sun,  9 Nov 2025 20:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="RgSKTigY"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380691D5146
	for <linux-kernel@vger.kernel.org>; Sun,  9 Nov 2025 20:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762720038; cv=none; b=NftIhBGJPKqn8xrQlt62DbBH3stXDVp8cX94XFuMUldr7XJEHmZsVBIux+OQ1qdIiqnWb97I1p+zoc2RhZuZXMpgVljawJ6jVPcKnKX2Klafxcvad1fJ7c7JRgZfr3MfeqPAkhV/3c4DE2mvYExtNNc8A4IWLC3bBLIbEAwkk9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762720038; c=relaxed/simple;
	bh=fKR3QBbaHqgZ3LcctrliMMiqU5fz+/oHsaft4+SoaA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IK6iLn0hmmNfnEA6uDJEsD1tckB+mf6CYjFcTH1Q4zxmKmo56Z4ooVZwbIC5ZwZdq6N3wLsS83b32NReVImcJs8CIO5n/QhVrjGv7j+ybnESpL/9CIBeCHnEwIIX9YUKnhvK/ABDP37mkv0Df8NpHjcx/+aHJSd99vzQug3ppRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=RgSKTigY; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1762720032;
	bh=fKR3QBbaHqgZ3LcctrliMMiqU5fz+/oHsaft4+SoaA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RgSKTigYOzKxxsqTPG7VPXFM67JiGn8gSxcQVTY3g6FgERi5ykMUSHwbQU4KB0ri3
	 h4DrJLdCCe3z/i6hDDNtZqZ/H3c5nHzfzXBYu8/ls+u7QlU/tE2ndKH9CCl/9s7HDZ
	 5iEao5HkAogDupjxUnTfIQ/qlFG42cvTsWspye5E=
Date: Sun, 9 Nov 2025 21:27:11 +0100
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>
Cc: linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] tools/nolibc: avoid using plain integer as NULL pointer
Message-ID: <f85ba2f8-d611-4d68-829d-b96c45201882@t-8ch.de>
References: <20251109-nolibc-sparse-v1-1-02256638a99c@weissschuh.net>
 <20251109195754.GB20023@1wt.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251109195754.GB20023@1wt.eu>

On 2025-11-09 20:57:54+0100, Willy Tarreau wrote:
> Hi Thomas,
> 
> On Sun, Nov 09, 2025 at 08:27:29PM +0100, Thomas Weißschuh wrote:
> > The integer zero should not be used as NULL pointer.
> > It is invalid and sparse will complain about it.
> > 
> > Use proper NULL pointers instead.
> 
> Huh ? I've been using that for decades and seeing it everywhere. That's
> quite bizarre, 0 is perfectly valid as a pointer. Ah, here it is, in
> C99:6.3.2.3:
> 
>   An integer constant expression with the value 0, or such an expression
>   cast to type void *, is called a null pointer constant.
> 
> The change is small, so if it hurts sparse, I'm fine with changing it,
> but at least the commit message should be adjusted to say that sparse
> doesn't like it and not that it's not valid.

Yeah, indeed '0' is special and valid, even in C23.
My recollection was wrong. Thanks for the hint!

> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/r/202509261452.g5peaXCc-lkp@intel.com/
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> 
> For the patch: Acked-by: Willy Tarreau <w@1wt.eu>

And thanks again.


Thomas

