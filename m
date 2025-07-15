Return-Path: <linux-kernel+bounces-731123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DEAB04F73
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 05:46:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B45E44E364C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jul 2025 03:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6AF2D1932;
	Tue, 15 Jul 2025 03:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ec6uJtSR"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644CA211A11
	for <linux-kernel@vger.kernel.org>; Tue, 15 Jul 2025 03:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752551118; cv=none; b=VqetXyEXHqmCrMY/ZfBIWveh+qmC93ZxMhtCx9tiHlyOAmW0RqvESAh+BD0V88fTA44QLxnAA4+blaGO1H7iI2qB/JC7lOXwSFXSfeKIRdmEIdcv9RE8Ucipr8m6nKNWAiINKLY67vHDRJ8sMSraviGoDk8Mnhd5LtN3s58ESQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752551118; c=relaxed/simple;
	bh=A2rbco88cm817wXE6TqKDXNOqrI27nA57zZ53yTzx+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WpgBhZyB7jCFJvcY6DJrDLlHYBjopqAwMCwMnhaQ4L5Yw04XhrT1Tqof3unWk6Vs3jJIL/56wWJxjOw+5JJdR2mINEAIaOVlqNLxWdM1NRzgwpsesPJK9bIbCItTCippMjp0gNUkFzFNKJD7at1u3wK3G8AO7G1zYW3QRK2fSp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ec6uJtSR; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-23dd9ae5aacso67005ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jul 2025 20:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752551113; x=1753155913; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L2lsPdVGCpiOT4xPfeYvJT1smkBD1psw0k7PE7Z1ULo=;
        b=Ec6uJtSR/oXUJg7w73dToN16o8kvzcZjRUF4BjeDrxDV0mDKcI0nLh5NG8Gvuv2GPF
         PJSXxWeljku0lAkl7iw31GTvZbJWDySS1DJTd/QHdIL+I10FnwergnxM776lsJX3waba
         ExPwNy7xOH2u9bGqDXPBNjLoadR9o/tOCuwOqJ0pMWZzilySEj7xq/jvfU0BCx2pIC41
         W+a+wAwtXfqy5KHD15NZQW+Aiq9Y4uuqQ5XHPs1rZ0P9LpiUi3uIswxYHBoyrtSg76oR
         9yNc/s3BD9xxqjDSAi/uzCLtzHjX1OnSO64Y+fM5XRsUlq4958Zl+kHMliCbk+30WcLv
         ph1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752551113; x=1753155913;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L2lsPdVGCpiOT4xPfeYvJT1smkBD1psw0k7PE7Z1ULo=;
        b=HW2tsIHd4AwxP7kf71y99GDlz5BjD+dX+j0OWrp7HC5b/ZfBGNEEnWySzc5M9uQkDT
         +rsRMFnYMaUAFpbDlplSXRnUA7t7lDK5tsjPmEBDcWFoFawPdkSLjn+63V6jCcZGglYn
         6BNtmLh3PM16ac4fbEx4udMyJB67nRDihIYI6p1TGHB4IVX6qj4t9ZnwpaSLJv9pDfnp
         mBo4rKue7Gi8VWiCmZQ50n7uFhox8XXlmT62BSrO186SduMZyWBtjpNoT+TY9K1U3GCp
         rI24vXEHCdtpwtvMnXpf/UX4ROYEHZ4+RtE9kF+QbUQ6XbgO4c0wNFKYmRpIsNEaypec
         JA4w==
X-Forwarded-Encrypted: i=1; AJvYcCVMjuHSxkCHij/7U5zgyEUbQlrYctQ2nZAh+TOlcix+/bSpAl0yFZ0sN0rN2qSy+x212+IKSm3/33BBsww=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh/36wYV6T4I5TV0nlReX5T+GEUux6jd+K3HvNV65Bm7bDdve3
	lTusI8TGp9Sg4cEIGSv5/k245KrveLAZ1V14gMAD+PAAQGaLLvkWrAvNobM1BcAWkA==
X-Gm-Gg: ASbGncuTzc+0CbTTsFftecCbn9FNEPjOgmgvT9PMEn23mkTSG6ElSyAqcq1AkZvptZi
	iLly2XQXN3QMOQ9lVP8cAwb6BKykoKjM7NJN5DIRGcq+X7JLlOZaf5Fkqgr1lgSPVdcCaPjBmpS
	6Irppmy9q9w/9PLTxaE422RAux/Vd+bLIL4e3rmnMAtVTg+Uip30nrsqC093XIi1GFb9j6kDYTe
	j8eX1Kbiru3o6dgYc041dp0mnAh2oqjni7cveDndsl/ptd8HwqkriL8WoORegW6+V3SvHssq/Cw
	GGh6E2qhXh4Mw/YnVaesW1Il+Q9Sat3g2YmqGtxYsak2Sru/XkrBOHCqh6KZy5HN27r6/qvon+q
	SrSL83UJl0lEGvSjUqPz+iUb3Rmz4z7+YoukkzraJ+1SdLx4sMaGi5PSrJgn3gFI=
X-Google-Smtp-Source: AGHT+IEAwepoOiB85bSDI2KEfSlH/kF0U+KsV9TyHPXJl1PpS4At+MpfMSJBWz7VWZvq0NYiiWtWKA==
X-Received: by 2002:a17:903:2ed0:b0:235:f10a:ad0 with SMTP id d9443c01a7336-23e1ab6413amr1677775ad.28.1752551113139;
        Mon, 14 Jul 2025 20:45:13 -0700 (PDT)
Received: from google.com (135.228.125.34.bc.googleusercontent.com. [34.125.228.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3017cc30sm14076647a91.32.2025.07.14.20.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jul 2025 20:45:12 -0700 (PDT)
Date: Tue, 15 Jul 2025 03:45:07 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Dmitry Antipov <dmantipov@yandex.ru>
Cc: Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	"Tiffany Y . Yang" <ynaffit@google.com>,
	linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 1/2] binder: use kstrdup() in
 binderfs_binder_device_create()
Message-ID: <aHXOw6DVD1AB5aIo@google.com>
References: <20250626073054.7706-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250626073054.7706-1-dmantipov@yandex.ru>

On Thu, Jun 26, 2025 at 10:30:53AM +0300, Dmitry Antipov wrote:
> In 'binderfs_binder_device_create()', use 'kstrdup()' to copy the
> newly created device's name, thus making the former a bit simpler.
> 
> Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
> ---
>  drivers/android/binderfs.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
> index 024275dbfdd8..4f827152d18e 100644
> --- a/drivers/android/binderfs.c
> +++ b/drivers/android/binderfs.c
> @@ -117,7 +117,6 @@ static int binderfs_binder_device_create(struct inode *ref_inode,
>  	struct dentry *dentry, *root;
>  	struct binder_device *device;
>  	char *name = NULL;
> -	size_t name_len;
>  	struct inode *inode = NULL;
>  	struct super_block *sb = ref_inode->i_sb;
>  	struct binderfs_info *info = sb->s_fs_info;
> @@ -161,9 +160,7 @@ static int binderfs_binder_device_create(struct inode *ref_inode,
>  	inode->i_gid = info->root_gid;
>  
>  	req->name[BINDERFS_MAX_NAME] = '\0'; /* NUL-terminate */
> -	name_len = strlen(req->name);
> -	/* Make sure to include terminating NUL byte */
> -	name = kmemdup(req->name, name_len + 1, GFP_KERNEL);
> +	name = kstrdup(req->name, GFP_KERNEL);
>  	if (!name)
>  		goto err;
>  
> -- 
> 2.50.0
> 

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks Dimitry,

Acked-by: Carlos Llamas <cmllamas@google.com>


