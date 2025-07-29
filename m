Return-Path: <linux-kernel+bounces-749699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B6F7B151C1
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 18:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D18953BA28E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jul 2025 16:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B5C2951DD;
	Tue, 29 Jul 2025 16:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="QGjz74IH"
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8886F34CF5
	for <linux-kernel@vger.kernel.org>; Tue, 29 Jul 2025 16:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753808227; cv=none; b=trRFAS6N1z9U9CpHzb0P1WWifs9tC1Eie2/B+KJjgWX/f/VutIOLBALG8T4/zxZc6vFalBubsLQUOnI/V9JcVCPADn1NJc9PuoxYfrfRavFhqIQljo98t3GZITgZpa3R0l1xQES9EF6ahxZ/qRFr0/gNmetHfZ8j/aUQmX2gy5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753808227; c=relaxed/simple;
	bh=+977VOT3EG5SmDJiKtPAI7ApdMTCxDR9HZxrk+8N668=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l9dZKp88yihdiVPhzKd64F7GQWx8aarSlyN3AV5cua/huIDBcY6eoNGwQXEMhqCK/c9qg/7Z9G8RE24Mwk1EikUNWYCuvOB7KS4F0YA5zm8Dt8AQd0Y/zruBAKCnJN8WvBUt6cLEbcvNF6hAGoX70FB06ZJrdGTjNxYRBXMsWCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=QGjz74IH; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oV1+sebviRt7o4jrQaPUAaHLD06ST54XdVTIdCd1tyE=; b=QGjz74IHUAN/c7xPt56GMdCbG3
	zUN+bZJaZwdow0qziFLej630fRo0rP/xjSCvWN4o6eqrHDUQeIAmr1oskvJESXlahRLBEubN+ZKg4
	K7S+WaVNMprvJ37gZRNcxg13zji+RX6wKFRCpGCEgOvVxOe3gf+vua/QQ966PB+qziniJHkQ/RouX
	SkoXmVOJByilysOf0NgW2bwakY1bu8NQeFUAtsrv/+6mANq21iS7t3e0aiPH86bTmfr+YQRCSLoRM
	7WmVrkfTufrq1Ew9epX/oF3XvA4hOBHY9S9nT+bkIY+x2MooaZji29ySzf8RiGh3j8dhh2wnHrwBb
	JMZaJizQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugndL-00000004w5r-3JKT;
	Tue, 29 Jul 2025 16:56:59 +0000
Date: Tue, 29 Jul 2025 17:56:59 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Xichao Zhao <zhao.xichao@vivo.com>
Cc: gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
	maco@android.com, joelagnelf@nvidia.com, brauner@kernel.org,
	cmllamas@google.com, surenb@google.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binderfs: Use PTR_ERR_OR_ZERO() to simplify code
Message-ID: <20250729165659.GJ222315@ZenIV>
References: <20250729093704.596293-1-zhao.xichao@vivo.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729093704.596293-1-zhao.xichao@vivo.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Tue, Jul 29, 2025 at 05:37:04PM +0800, Xichao Zhao wrote:
> Use the standard error pointer macro to shorten the code and simplify.
> 
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>
> ---
>  drivers/android/binderfs.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
> index 0d9d95a7fb60..729e3ed94b89 100644
> --- a/drivers/android/binderfs.c
> +++ b/drivers/android/binderfs.c
> @@ -598,10 +598,8 @@ static int init_binder_features(struct super_block *sb)
>  	dentry = binderfs_create_file(dir, "freeze_notification",
>  				      &binder_features_fops,
>  				      &binder_features.freeze_notification);
> -	if (IS_ERR(dentry))
> -		return PTR_ERR(dentry);
>  
> -	return 0;
> +	return PTR_ERR_OR_ZERO(dentry);
>  }

NAK.  Take a look at the failure exits before this one; keeping them
consistent is a good thing.

