Return-Path: <linux-kernel+bounces-835857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E81A7BA834D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 08:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 203473C304B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Sep 2025 06:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C20042BF3CC;
	Mon, 29 Sep 2025 06:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YBp8aoW+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119242BF000;
	Mon, 29 Sep 2025 06:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759129098; cv=none; b=Rwf+azpgPYLgXFJ8IaHuKFRZL0S6uTH0k43wiH0+eBYnO5HZq4lnYlVjnefix0icQC4j9fEINyOCYPsoZhp+Qeel7Oh+4D/dCpryOCxVIykvC4TCnBs4TMheteiFg9JHql3QklSZYFnqF4a9i94q4/wHauAJ8wMiwBHH25zbjRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759129098; c=relaxed/simple;
	bh=UhH2n8XuCOOM8KPxIWXZg6GnG8E37tiWR5u8VO5rNHI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tyDdubgWxeH/VWieIMMlhMOHBhaUP/nD8LjSD4MU2aX5QQ8BZGZxQFGbv60W1IBs4aq/iaOQccS3ym19Q0JAu5rN1449YqdsMBOg2ILrMWwV58/9XUhm1lx8FD1sKufnZd1BtVWQ1HlM8p+iqU8Ba7/rMS38R/XAwHTNNF9z+lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YBp8aoW+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1086BC4CEF4;
	Mon, 29 Sep 2025 06:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759129097;
	bh=UhH2n8XuCOOM8KPxIWXZg6GnG8E37tiWR5u8VO5rNHI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YBp8aoW+1mEfL/Jvl03q2y8wKmuUABNXW8mb+8Pem5rvwV+R7JkRwHcw34ErEWGCB
	 mB8r4YW6AeXThbAMNcO4+BcB+UGideh3XEtI9Rw86V1S6BnyQXxKa0EZp9FoA0GsdJ
	 GiSy65+1/NREEqUzzuDi1IQAhkTh6/3b8AZossTo=
Date: Mon, 29 Sep 2025 08:58:14 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 04/15] staging: rtl8723bs: align asterisk in block
 comment to fix formatting
Message-ID: <2025092953-depravity-oasis-93cb@gregkh>
References: <20250929065000.1010848-1-vivek.balachandhar@gmail.com>
 <20250929065000.1010848-5-vivek.balachandhar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250929065000.1010848-5-vivek.balachandhar@gmail.com>

On Mon, Sep 29, 2025 at 06:49:49AM +0000, Vivek BalachandharTN wrote:
> Align the leading asterisks in a multi-line block comment to maintain
> consistent formatting and improve readability,in accordance with kernel
> coding style guidelines. No functional changes.
> 
> Signed-off-by: Vivek BalachandharTN <vivek.balachandhar@gmail.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_mlme.c | 40 +++++++++++------------
>  1 file changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> index 3eeea832dcb6..cd41f713a52e 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
> @@ -869,8 +869,8 @@ static void find_network(struct adapter *adapter)
>  }
>  
>  /*
> -*rtw_free_assoc_resources: the caller has to lock pmlmepriv->lock
> -*/
> + *rtw_free_assoc_resources: the caller has to lock pmlmepriv->lock

Shouldn't you also have a space after the '*' and before the 'r'?

thanks,

greg k-h

