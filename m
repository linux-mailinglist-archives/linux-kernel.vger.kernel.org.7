Return-Path: <linux-kernel+bounces-814158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7056EB55010
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C1783AA4F6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E733081A8;
	Fri, 12 Sep 2025 13:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qprch+ml"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFE214EC62;
	Fri, 12 Sep 2025 13:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757685191; cv=none; b=FIIksaJFjCT8hGz6WGsWptZ9VmmNBObIw3gtZA3sAFdy1BHgSwpTeRa8yl+rSKAreQ6Ig8lvYK6nLvLMBvy/608876ZQOvVd19qF7a/Jo99T3rrqPCNVS7Y1dxv0KDkGaS68pFS+dU/7PPgKkupqLPa7rVuAHeaMSz6o1sEv7nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757685191; c=relaxed/simple;
	bh=TiRdUHaf06OOZKkxXvJfagsayF15UZJ9tcT9HLaT5W4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQDZCf+3G5GpalhPwEYAmjTUs3XX0ETh2BS72lOPHvW1zImEkgRFgvQPswI8UaRuuB9dBLK1n1ev3hhUa5I/2vr9GL10pbVOOs3cOebBKNz7mMVyueHuNZVKGmZojS5Xp+7nCir8fBdwJd/9bd9OxPgYogN5vgZR9KCLHZQ/ZVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qprch+ml; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C2D1C4CEF1;
	Fri, 12 Sep 2025 13:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757685190;
	bh=TiRdUHaf06OOZKkxXvJfagsayF15UZJ9tcT9HLaT5W4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qprch+mlJq8aEPFQlMnvGeWpBtzkCzi3KtxfhDmQ4VGXrfmRs7ErqptMPNQhJX4ke
	 uxj1Lv9VB+oW8xxeN+zaejTuj6FKYtwo7qzBWT5v7ZAHCSsbryZOuVu+/57sVyAKVO
	 q2PumWpF6A945+9UVXOn1b3tAIzDaRIrbS5i3ENw=
Date: Fri, 12 Sep 2025 15:53:08 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Akiyoshi Kurita <weibu@redadmin.org>
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: rtl8723bs: fix function definition style in
 hal_com_phycfg.c
Message-ID: <2025091245-efficient-preaching-9e0e@gregkh>
References: <20250908172925.58312-1-weibu@redadmin.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908172925.58312-1-weibu@redadmin.org>

On Tue, Sep 09, 2025 at 02:29:25AM +0900, Akiyoshi Kurita wrote:
> Several function definitions in this file did not follow the kernel
> coding style, spreading arguments across multiple lines.
> 
> As requested by Dan Carpenter, fix all instances to place the function
> parameters and the closing parenthesis on the same line as the function
> name, improving readability and conforming to style guidelines.
> 
> Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
> ---
>  .../staging/rtl8723bs/hal/hal_com_phycfg.c    | 33 ++++---------------
>  1 file changed, 6 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
> index 75ed731bbb14..fa987a797b16 100644
> --- a/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
> +++ b/drivers/staging/rtl8723bs/hal/hal_com_phycfg.c
> @@ -61,8 +61,6 @@ phy_SetTxPowerByRateBase(struct adapter *Adapter, u8 RfPath,
>  
>  static void
>  phy_StoreTxPowerByRateBase(struct adapter *padapter)
> -{
> -	u8 path, base;
>  
>  	for (path = RF_PATH_A; path <= RF_PATH_B; ++path) {
>  		base = PHY_GetTxPowerByRate(padapter, path, MGN_11M);

This patch doesn't apply, nor does it even look like it can build?  Did
you test-build the result?

thanks,

greg k-h

