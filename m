Return-Path: <linux-kernel+bounces-753772-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D461FB187AB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 21:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64BFB1AA7E47
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 19:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFC928DB64;
	Fri,  1 Aug 2025 19:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="EcWUhQV0"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE224A04
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 19:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754076127; cv=none; b=nQbp2biA78PEHUhD+XLHaPQlROz3VUroZFe0ewJcfkGsnhCQ/khih5UzOP8U1mmt4IDeTeLn5jbOglCuzFkl5zMZSd2DSJq3Yoo7QQ/SGqCY+pVVvueJo8tYPQoMtZHPl8f/E+j/EY+F3ORBetpwpKrXZ8bApbaxDO7WjM+vfBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754076127; c=relaxed/simple;
	bh=O5a9UkRKTirFXTkSmfB1hs+d/FdrrTqBT9C2s6x3Ugg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jl0mQegkJEPfbVud7TM/vzX/cOop79SR/cUUbrYiJBcs5TnwlwJFqaSe+pGfWVMb1O4IcpuXZv7049C3WRt8XWgtmGK+TvNgKrTUjcPtRA+kRJQ0gg/ohZgWnWGbj6T/K9hwCRcosji/iU0EJxPDMOUPR4Cl2cfSlse0Jdan7JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=EcWUhQV0; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MvWr/Fc2XWteE3tHBA6zWjbAEB1SSJFVlU+7M1xiMBg=; b=EcWUhQV0Q/Vu9tiitDcholbaiQ
	nxyILvOtQBTwL0J8CgcKeVIHYnGC21Odca7gSX0GNMdQeYW/cWCEpLvvtMWxu4xzzDsx2WrdV614l
	dodTmqraezWmXqbLSodct7adXnQHhrBhbqWbcH781j35d7XHSOkqr1JED5GzFijjmCncmCgWo/EZq
	6403HoXyVDTHk855qjFzJJkG3cbPD5GCiFZ3UyEmQSdD576qaT4vcfCx4lbUfI2q68wTBq6p1Yi2R
	Gw0zCFcrKg+DJVK1YMZGUDjhK1SuYIQ9yzJ+QPM8DKP5VqjRc279j0ehgpIjoV1osEfZi/NfNacQ1
	MaIgKd+g==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uhvKK-00000001PQ5-2pBw;
	Fri, 01 Aug 2025 19:22:00 +0000
Date: Fri, 1 Aug 2025 20:22:00 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Zhen Ni <zhen.ni@easystack.cn>
Cc: rmk+kernel@armlinux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/adfs: bigdir: Restore EIO errno return when checkbyte
 mismatch
Message-ID: <20250801192200.GR222315@ZenIV>
References: <20250801093806.1223287-1-zhen.ni@easystack.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801093806.1223287-1-zhen.ni@easystack.cn>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Fri, Aug 01, 2025 at 05:38:06PM +0800, Zhen Ni wrote:
> Fix smatch warn:
> fs/adfs/dir_fplus.c:146 adfs_fplus_read() warn: missing error code 'ret'

Gyah...  You don't fix $TOOL warnings, you fix underlying bugs - or, in case
of $TOOL generating a false positive, making $TOOL to STFU.  At the very
least you need to tell which one it is.

In this case it was not a false positive, so you need an explanation of
what's wrong with the code in question ("it makes smatch to complain"
is *NOT* it).

What happens here is a failure exit where we do complain into dmesg,
but actually report success to the caller, since the eventual return
value (in 'ret') is 0 left behind by successful adfs_fplus_validate_tail()
in the previous test.

_IF_ that behaviour had been an intentional mitigation strategy,
it needs to be explicitly described as such; however, looking at the
history of that function it seems more likely that this is an analogue
of the bug in previous failure exit fixed in 587065dcac64 ("fs/adfs:
bigdir: Fix an error code in adfs_fplus_read()"), so it's probably
better to return an error, same as we do on the other failure exits.

As it is, commit message fails to explain anything other than "smatch
has been involved in catching this one".  If you want to mention that,
sure, but it's on the same level as "so-and-so told me this place
looks fishy" - by all means, credit the contribution.  Reported-by/
caught-by/actually quoting smatch warning somewhere in the message -
up to you, but that shouldn't be the entirety of commit message ;-)

