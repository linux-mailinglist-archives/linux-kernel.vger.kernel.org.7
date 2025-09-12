Return-Path: <linux-kernel+bounces-814149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF2EB54FEF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 559791D61023
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE471514DC;
	Fri, 12 Sep 2025 13:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YKrnQb/t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913D61F948;
	Fri, 12 Sep 2025 13:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757684761; cv=none; b=C8I1cs1U2ODTUQHpI76+ljW1L4hImbj/HT0ohZLMjmZXhMjHyAoOpPa3dzO9PsBrYkmRoQ1D9RAB1M/iY0aIV3B8Dn/h1NFk0iK8Y5R5Y01aVJiH/jLkz/HsmTI59D6CDpJ490E4bmnAoJQ0VeR8pch8mbqU1QsuyorkC4glnPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757684761; c=relaxed/simple;
	bh=TRofAVMgao80P4fDZgJzpoxhApTQTIa/IKsPxCYPhP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GulqXpyV8fYEh8Jpptwv5OZezfAc5WSAEchreJ7EgbsyGTekqM3jmh+zelFvT9fJDdeIHUYKOwheqCWLqntLll56AhcZz5bb7TuvrZnzuhpgEMYa5NkxRBIECZcVCinS+4AyYzDYpjBiBK+JY9XNgfryZzLZKLFxskkKYnRutr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YKrnQb/t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A104DC4CEF1;
	Fri, 12 Sep 2025 13:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757684761;
	bh=TRofAVMgao80P4fDZgJzpoxhApTQTIa/IKsPxCYPhP4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YKrnQb/tX21gt3MVuIl0AW+kxt50N0woqBWJVIqANVH4UKNnSza8WkT/TsmvpsPlg
	 mQz/P9RTxeThpJBSRDVtDsoPDrR3QdhCVgxR2upTiplkapuSG3AldPk3tw0tQni5Wx
	 muVU7ioPN047q0o3+4a3RC+o6h65DrKR2XAYG2GU=
Date: Fri, 12 Sep 2025 15:45:58 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Akiyoshi Kurita <weibu@redadmin.org>
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: fix coding style in hal_com_phycfg.c
Message-ID: <2025091233-showman-dill-3d17@gregkh>
References: <20250908144641.39518-1-weibu@redadmin.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908144641.39518-1-weibu@redadmin.org>

On Mon, Sep 08, 2025 at 11:46:41PM +0900, Akiyoshi Kurita wrote:
> The function definition for phy_StoreTxPowerByRateBase() did not
> follow the kernel coding style.
> 
> Move the closing parenthesis to the same line as the argument to fix
> the style issue reported by checkpatch.pl.
> 
> Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
> ---
>  drivers/staging/rtl8723bs/hal/hal_com_phycfg.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
> index d5649e7d8f99..f137ec747ab3 100644
> --- a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
> +++ b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
> @@ -60,9 +60,7 @@ phy_SetTxPowerByRateBase(struct adapter *Adapter, u8 RfPath,
>  }
>  
>  static void
> -phy_StoreTxPowerByRateBase(
> -struct adapter *padapter
> -	)
> +phy_StoreTxPowerByRateBase(struct adapter *padapter)

This really should end up being:

static void phy_StoreTxPowerByRateBase(struct adapter *padapter)

right?

thanks,

greg k-h

