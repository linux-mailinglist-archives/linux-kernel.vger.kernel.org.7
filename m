Return-Path: <linux-kernel+bounces-814159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B691B55014
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 15:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEA6F3A9294
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 13:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2C33081B8;
	Fri, 12 Sep 2025 13:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vix/6TvI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A038214EC62;
	Fri, 12 Sep 2025 13:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757685232; cv=none; b=C+TmI1CLKFmS9jxU2z5LdIuUDq+ICTYKX9i7DH7qTxkIvyRf2l8J+dbOuZKU+/rmyoGCd7jPHHXau2qpzYicqjEXiPc1EaQuQfWd6bdu+UpPHeDXTiWnBqpIKJbEKIaAGK0flPJDhKZk7K/vmM3cLKlA2VfZgmTEXNJlQY9PsY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757685232; c=relaxed/simple;
	bh=bX4u4S1oNeXFgqJ2WSCpw1xhDKv17/DgsmQZ5oaMwAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+2WcORaRvLe53amt7GrB3/2WqCwq+qk8PlYS7mPQWGPKNHJqYp3OkeFoHZuX/l0PMdqE1nPH6uZPztpkQpo/X5lcXrzJteOZ1Fjzwu63zOre9bz/tJeWxYdeSezVmIc9KDku37ezGO2TmpgubvEMFjo2pKWvzmAw6ZWCI+bzu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vix/6TvI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF16DC4CEF1;
	Fri, 12 Sep 2025 13:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757685232;
	bh=bX4u4S1oNeXFgqJ2WSCpw1xhDKv17/DgsmQZ5oaMwAM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vix/6TvIAbx+ap6egMi8iqKByEgrTVY1KZjR9ARUA1c1YMzYBsKI3rMK73lHeJUf2
	 pGlhlwUugyUOCRgO+ASzFLnr+cUqGXIeHJNFnagNtRJ7HSQCGgWqhR759+TNsWaerO
	 Y46yswyAcU+ozj0DpiNnmVYdSZuRM7HPksMuZ0kk=
Date: Fri, 12 Sep 2025 15:53:49 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Akiyoshi Kurita <weibu@redadmin.org>
Cc: Philipp Hortmann <philipp.g.hortmann@gmail.com>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] staging: rtl8723bs: rtw_efuse.h: fix double space
 in PwrState parameter
Message-ID: <2025091238-peddling-squint-c062@gregkh>
References: <20250909035804.129904-1-weibu@redadmin.org>
 <20250909053327.140763-1-weibu@redadmin.org>
 <20250909053327.140763-2-weibu@redadmin.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909053327.140763-2-weibu@redadmin.org>

On Tue, Sep 09, 2025 at 02:33:27PM +0900, Akiyoshi Kurita wrote:
> Fix coding style by removing a double space before the PwrState parameter.
> No functional changes.
> 
> Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
> ---
>  drivers/staging/rtl8723bs/include/rtw_efuse.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8723bs/include/rtw_efuse.h b/drivers/staging/rtl8723bs/include/rtw_efuse.h
> index ac7d6ef454c3..d791e35db769 100644
> --- a/drivers/staging/rtl8723bs/include/rtw_efuse.h
> +++ b/drivers/staging/rtl8723bs/include/rtw_efuse.h
> @@ -92,7 +92,7 @@ void EFUSE_GetEfuseDefinition(struct adapter *padapter, u8 efuseType, u8 type, v
>  u8 efuse_OneByteRead(struct adapter *padapter, u16 addr, u8 *data, bool	 bPseudoTest);
>  u8 efuse_OneByteWrite(struct adapter *padapter, u16 addr, u8 data, bool	 bPseudoTest);
>  
> -void Efuse_PowerSwitch(struct adapter *padapter, u8 bWrite, u8  PwrState);
> +void Efuse_PowerSwitch(struct adapter *padapter, u8 bWrite, u8 PwrState);
>  
>  u8 EFUSE_Read1Byte(struct adapter *padapter, u16 Address);
>  void EFUSE_ShadowMapUpdate(struct adapter *padapter, u8 efuseType, bool bPseudoTest);
> -- 
> 2.47.3
> 
> 

This patch did not apply, what tree and branch did you make it against?

thanks,

greg k-h

