Return-Path: <linux-kernel+bounces-850164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 89836BD21EC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 10:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EAB154ED1E2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Oct 2025 08:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10DF2F90D8;
	Mon, 13 Oct 2025 08:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XkuoK0C6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F071F0995;
	Mon, 13 Oct 2025 08:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760344774; cv=none; b=jg+Ek4jEFlz+IFDc3EIuSK0Xv5ceWYGOnWkn2u55lfUS6rylsGcbTGOG76SSNGm7IR3uA1qHJbaNGKoTt66oXDSzg1tpPnqS3375psHPqr3lqqClmeV99nBc00sVh2IuYtjizwKspjtaJsYMBrTEJ56UhqdDV5MTVFFxfep7INw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760344774; c=relaxed/simple;
	bh=uGsmLipNOJ8CQkC9V/7LJR4mpWEl2Gz5gcM6sSDEr00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vu9yFiO0OyrM+FE6+QYfo2xtpMTkLThuhj9K5CEU3I3Fhaw51BDDFfMdc8PeZzlfZEM34ve7HksWTEDrTLdfuncXqSF9c+9eh1cTiPR1ODYS7PrhuDs57XvPhuHhW2WO83fc7htn87rmGDsoHIVGwpCAcG6yuLGI+wlPaS2rAwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XkuoK0C6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97AEDC4CEE7;
	Mon, 13 Oct 2025 08:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760344774;
	bh=uGsmLipNOJ8CQkC9V/7LJR4mpWEl2Gz5gcM6sSDEr00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XkuoK0C6m1qf/0/9aPQDVitlFm2+93xbOnb+qhm1QMXabVJd3W8TrYvhFIa3YQ2bO
	 ih/RWhAvgcvRu91Y+Akny8JenMBhs2kpvgnBCcv0bM4ZNN73oPC9Rzrp2AND8dDzFZ
	 Nn55EDz+uEsCap5IBxEhgb6psTk3W8tbXe23Snw4=
Date: Mon, 13 Oct 2025 10:39:31 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
Cc: ~lkcamp/patches@lists.sr.ht, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: remove todo/note and duplicated
 EFUSE_CTRL macro
Message-ID: <2025101309-stalemate-hangout-e134@gregkh>
References: <20251010185456.26754-1-rodrigo.gobbi.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010185456.26754-1-rodrigo.gobbi.7@gmail.com>

On Fri, Oct 10, 2025 at 03:49:12PM -0300, Rodrigo Gobbi wrote:
> The usage of EFUSE_xxx and MSR macros are already in place, so the note
> and todo about that can be removed. Also, there was a duplication of the
> definition of EFUSE_CTRL macro in two places, keep the one at the .h file.
> 
> Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
> ---
> At drivers/staging/rtl8723bs/include/hal_com_reg.h file, there is the following note/TODO:
> 
> /*  TODO: use these definition when using REG_xxx naming rule. */
> /*  NOTE: DO NOT Remove these definition. Use later. */
> 
> #define EFUSE_CTRL				REG_EFUSE_CTRL		/*  E-Fuse Control. */
> #define EFUSE_TEST				REG_EFUSE_TEST		/*  E-Fuse Test. */
> #define MSR						(REG_CR + 2)		/*  Media Status register */
> 
> I guess the idea was to standardize those macros rather using the REG_xxx_yyy ones.
> In fact, when searching for a missusage of that, there is none, only a duplicated redefinition
> of EFUSE_CTRL at drivers/staging/rtl8723bs/core/rtw_efuse.c.
> 
> If my interpretation is correct about that comment, I`m think we can remove the
> note/TODO since it`s very old. Also, I`m removing the duplicated define, since
> the hal_com_reg.h is already included at rtw_efuse.c.
> 
> Tks and regards.
> ---
>  drivers/staging/rtl8723bs/core/rtw_efuse.c      | 3 ---
>  drivers/staging/rtl8723bs/include/hal_com_reg.h | 4 ----
>  2 files changed, 7 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_efuse.c b/drivers/staging/rtl8723bs/core/rtw_efuse.c
> index 208373113a62..6391932e214b 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_efuse.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_efuse.c
> @@ -26,9 +26,6 @@ u8 fakeBTEfuseContent[EFUSE_MAX_BT_BANK][EFUSE_MAX_HW_SIZE];
>  u8 fakeBTEfuseInitMap[EFUSE_BT_MAX_MAP_LEN] = {0};
>  u8 fakeBTEfuseModifiedMap[EFUSE_BT_MAX_MAP_LEN] = {0};
>  
> -#define REG_EFUSE_CTRL		0x0030
> -#define EFUSE_CTRL			REG_EFUSE_CTRL		/*  E-Fuse Control. */
> -
>  static bool
>  Efuse_Read1ByteFromFakeContent(u16 Offset, u8 *Value)
>  {
> diff --git a/drivers/staging/rtl8723bs/include/hal_com_reg.h b/drivers/staging/rtl8723bs/include/hal_com_reg.h
> index 9a02ae69d7a4..cf5c15dc2bfd 100644
> --- a/drivers/staging/rtl8723bs/include/hal_com_reg.h
> +++ b/drivers/staging/rtl8723bs/include/hal_com_reg.h
> @@ -189,10 +189,6 @@
>  /* 	Redifine 8192C register definition for compatibility */
>  /*  */
>  /*  */
> -
> -/*  TODO: use these definition when using REG_xxx naming rule. */
> -/*  NOTE: DO NOT Remove these definition. Use later. */
> -
>  #define EFUSE_CTRL				REG_EFUSE_CTRL		/*  E-Fuse Control. */
>  #define EFUSE_TEST				REG_EFUSE_TEST		/*  E-Fuse Test. */
>  #define MSR						(REG_CR + 2)		/*  Media Status register */
> -- 
> 2.48.1
> 

Does not apply to my tree at all :(

Can you rebase against the next linux-next release and resend?

thanks,

greg k-h

