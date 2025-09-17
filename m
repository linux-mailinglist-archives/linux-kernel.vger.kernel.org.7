Return-Path: <linux-kernel+bounces-820005-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B2AB7F8EC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 15:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEBA332516E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Sep 2025 05:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAF4263F36;
	Wed, 17 Sep 2025 05:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c00guJfH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0439D261B6E;
	Wed, 17 Sep 2025 05:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758088326; cv=none; b=jXDMlkeZtIwmPtNwtGQsmQa2A1KNXhzmLG4aBRb1YchPZiJrrrRo4QAYVVTSSrteVHYbKufKfI0RSJN5zhs/EIdCsphszT3PmflnqtTlB10L8HlziqrNDwmLW7pUZ7Moi0kiXAqHTj6vH3d2569wo25mj5wEH8sf6kiDYubEGZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758088326; c=relaxed/simple;
	bh=jouXAy/5BYCdlnpG5KBWN8vAz7fpfB9HCntWrw0afkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jgVmhvnaKSITh9TINqUFMGNlOCG61J5cpB1WNT1HmJCClbpi5DhSXdpSX4Q/ACfUWYYHgo3X8Rz/Dx6k7cg3oPI07y0MV+r8fzQLqzdWAO06MgEuLGIM/n5GUuhD7/l8JcUDR6JUgTFL/qIiGymG7J5fNbtgivuo+PxUSBTPTC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c00guJfH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5F5C4CEF0;
	Wed, 17 Sep 2025 05:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758088325;
	bh=jouXAy/5BYCdlnpG5KBWN8vAz7fpfB9HCntWrw0afkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c00guJfHT4MS0TVRdiXkoj72AYqSdQfRFXREW9yvc3zx9epc8faCD4ekJl7gHevsn
	 EL5AZnI6Uq2fgQs3Y2ERoQByu55gwkDPWBQZH1W+NML8uaGs4AaG+DLwz9/cg0JMOJ
	 vn9y+yq/iawSTAxkZuueYmzd+fwKBnt5m3yakZOk=
Date: Wed, 17 Sep 2025 07:52:01 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Akiyoshi Kurita <weibu@redadmin.org>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: xmit: fix grammar in comment
Message-ID: <2025091705-murky-sage-465f@gregkh>
References: <20250917053944.1447050-1-weibu@redadmin.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250917053944.1447050-1-weibu@redadmin.org>

On Wed, Sep 17, 2025 at 02:39:44PM +0900, Akiyoshi Kurita wrote:
> Fix 'number of page' -> 'number of pages' in a comment.
> 
> Signed-off-by: Akiyoshi Kurita <weibu@redadmin.org>
> ---
>  drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
> index 842e19b53421..7ba8981f4652 100644
> --- a/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
> +++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
> @@ -76,7 +76,7 @@ static s32 rtl8723_dequeue_writeport(struct adapter *padapter)
>  	/*  check if hardware tx fifo page is enough */
>  	if (!rtw_hal_sdio_query_tx_freepage(pri_padapter, PageIdx, pxmitbuf->pg_num)) {
>  		if (!bUpdatePageNum) {
> -			/*  Total number of page is NOT available, so update current FIFO status */
> +			/*  Total number of pages is NOT available, so update current FIFO status */

As "pages" is now plural, shouldn't "is" become "are"?

Also, you can drop the extra leading space in the comment.

thanks,

greg "english grammer is rough" k-h

