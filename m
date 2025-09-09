Return-Path: <linux-kernel+bounces-807153-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92658B4A0DA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 06:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 493264E0F19
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Sep 2025 04:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E602E3B19;
	Tue,  9 Sep 2025 04:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="shGAxe/o"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD43EEA6;
	Tue,  9 Sep 2025 04:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757393026; cv=none; b=fY+18cw9vpCxooIxSWhcGsbbePLVH6s+KA8OG5OvZO2/g9Q0C8YaVVJdp1ZXK0oMErktmE6kGc0Xxbgl0EvxzjOYnEBMBUD0BpD1C87WkBS1ECe9A+PwdMtQ6KPfYbuua30lyS1fugNLWhVoRvo57PcniTYBu7GKJ7a1QzLZ/gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757393026; c=relaxed/simple;
	bh=vK25CFkbQggNpHTev09//TCQa5dfJ8dUIU6Hdi5RXEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A1QxnhuSVplom9xZ/+5rle3fMPj08DQ46XUMkGPux2SE/SHsjcTSnfDR8lnmtH9pk9SP0QoTSHhiAu+VN0m+wtQNvakVwNjXPYVGFZClv1o9IN9EZ2id3Xl8JLlgEZnoBT1ahOvl08upz/A+Cxvj/INtGG/87ZGxKq+l3UeVUJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=shGAxe/o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B7B3C4CEF4;
	Tue,  9 Sep 2025 04:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757393025;
	bh=vK25CFkbQggNpHTev09//TCQa5dfJ8dUIU6Hdi5RXEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=shGAxe/ogayq9KvyhjpyByd0bpPsqa27IikvQmMgyD1rBoTO1RsXVwgAfGDrOx/Bc
	 SA4fnZxAEmeKhyBmFFVFBJSyCFJ3A6JXgWb+1MGlJPPd6ZkLcKO0k4p9Uli/C4VyKc
	 +mQGZS5G0u9/nEk0Qq6pAA/j0szXr0zpxyOz3owg=
Date: Tue, 9 Sep 2025 06:43:38 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Akiyoshi Kurita <weibu@redadmin.org>
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: rtw_efuse.h: simplify copyright
 banner
Message-ID: <2025090917-tribute-dividers-abd6@gregkh>
References: <20250909035804.129904-1-weibu@redadmin.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909035804.129904-1-weibu@redadmin.org>

On Tue, Sep 09, 2025 at 12:58:04PM +0900, Akiyoshi Kurita wrote:
> Replace the banner-style copyright comment with a single-line comment.
> No functional changes.
> 
> Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
> ---
>  drivers/staging/rtl8723bs/include/rtw_efuse.h | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/include/rtw_efuse.h b/drivers/staging/rtl8723bs/include/rtw_efuse.h
> index 669565fa1c69..d791e35db769 100644
> --- a/drivers/staging/rtl8723bs/include/rtw_efuse.h
> +++ b/drivers/staging/rtl8723bs/include/rtw_efuse.h
> @@ -1,9 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -/******************************************************************************
> - *
> - * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
> - *
> - ******************************************************************************/
> +/* Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved. */
> +
>  #ifndef __RTW_EFUSE_H__
>  #define __RTW_EFUSE_H__
>  
> @@ -95,7 +92,7 @@ void EFUSE_GetEfuseDefinition(struct adapter *padapter, u8 efuseType, u8 type, v
>  u8 efuse_OneByteRead(struct adapter *padapter, u16 addr, u8 *data, bool	 bPseudoTest);
>  u8 efuse_OneByteWrite(struct adapter *padapter, u16 addr, u8 data, bool	 bPseudoTest);
>  
> -void Efuse_PowerSwitch(struct adapter *padapter, u8 bWrite, u8  PwrState);
> +void Efuse_PowerSwitch(struct adapter *padapter, u8 bWrite, u8 PwrState);

This doesn't look like a copyright banner change :(


