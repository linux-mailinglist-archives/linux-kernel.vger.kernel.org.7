Return-Path: <linux-kernel+bounces-753830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9390B188A7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 23:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 440F11C8588A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Aug 2025 21:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139F428C851;
	Fri,  1 Aug 2025 21:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="f3S86Z4f"
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93B514AD2B
	for <linux-kernel@vger.kernel.org>; Fri,  1 Aug 2025 21:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754083229; cv=none; b=GSBX/R3mop4mPuKX9k8rcupRNP1pQV3E+2BkeBSdYw1oHwP3wrU+NQQcmb8PCeCasSLAMTLc8BxiDe+D8gbRsClI20CfxBrA7xgX6jk/Iy5Qoa3HUwcHvnwndfLwc0TECGCpODef/9YhC3JMBSQZ30T8p5X71OY2iXzjGwlM52E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754083229; c=relaxed/simple;
	bh=dnJ75Uh0amC5NEsUTy48SGz/pn00Kw6TizLv4QjELiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TVhmRwDj7bfvGHrWqco0AkwgAyv9WDW/tZY3blTLRmrUw5yFJ1OWuBpWwKBEwKVU4r97NvpwU/4KAfxuQra+9jJH2rbxJhLwJsnEpFLpyN0wCXXLNkHcO/BmEVXnWNED/Bp7rpS4DHpGJrTqB8cwHZDYS6OvxE511JAboUR2pq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=f3S86Z4f; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nxROPiw0VEezk0RMyV/yz1uKaAQMPHHatCDhTnf+JZ8=; b=f3S86Z4fB7w9oiBWvB0g5Lj7YU
	Awf8h+t1PBn2QUQY6SzisX4jGoVAXpBascQLDf1BX4p9wJePbnoEOyKymhVf/C8/BvwXsbH0hksh/
	oHsPQwtlTsVrIoGla8IGWMdTU3WAHoKZjaWj1XY1eYEZhlKNJWPPyN9Et6qqDO22HEmhU94eRl3s5
	TC4Uf64BlHLvJF3trHEg4gazZeJCk64bI7yfavC1zI4V1njXsdlfXz69W++onM28trTdbgsSYVpeN
	bpJ9tquV6l6QHUowjawd89pQrB/zXAcQi9A6Nv5jG8jdxwEMswZu+u9yYZzZNLswyuZROdzxqnQve
	bFJ9Eb5A==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46282)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uhxAs-00070x-1M;
	Fri, 01 Aug 2025 22:20:22 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uhxAp-0002Oe-1m;
	Fri, 01 Aug 2025 22:20:19 +0100
Date: Fri, 1 Aug 2025 22:20:19 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Zhen Ni <zhen.ni@easystack.cn>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/adfs: bigdir: Restore EIO errno return when checkbyte
 mismatch
Message-ID: <aI0vk_rEGGApi6Vi@shell.armlinux.org.uk>
References: <20250801093806.1223287-1-zhen.ni@easystack.cn>
 <20250801192200.GR222315@ZenIV>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250801192200.GR222315@ZenIV>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Aug 01, 2025 at 08:22:00PM +0100, Al Viro wrote:
> As it is, commit message fails to explain anything other than "smatch
> has been involved in catching this one".  If you want to mention that,
> sure, but it's on the same level as "so-and-so told me this place
> looks fishy" - by all means, credit the contribution.  Reported-by/
> caught-by/actually quoting smatch warning somewhere in the message -
> up to you, but that shouldn't be the entirety of commit message ;-)

Agree with everything you've said.

FWIW, the patch is definitely correct, but the commit text should
also have:

Fixes: d79288b4f61b ("fs/adfs: bigdir: calculate and validate directory checkbyte")

as that introduced the bug.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

