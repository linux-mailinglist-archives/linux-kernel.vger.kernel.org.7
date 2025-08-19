Return-Path: <linux-kernel+bounces-774869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F59B2B895
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 07:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 372A97A37B5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Aug 2025 05:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB9B30FF00;
	Tue, 19 Aug 2025 05:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="umvsuBi4"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C617B2AEFD
	for <linux-kernel@vger.kernel.org>; Tue, 19 Aug 2025 05:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755581113; cv=none; b=WQvZ6LdCV1AHX0+yt9uNCNyCB1FJMf7UYC08v3mCZRvOMAz0F/Xu4itNs4zN8KsIRpjZGyXFnIj9hd8ZILhQbUwmEFqrdR31y1L8XhJ0UL9/IYGgnpzseBnDzI0wiNg3SQDnj1IKDJyNn8AFPXC62Pq1+zF+4WDCUzgG3TH+SCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755581113; c=relaxed/simple;
	bh=8VWnIw8OMW4m2SkxianySdGuIW4HjoawAYYxrqElj8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AAHx1Px1m65ZyGKGu1nmf475ZPwQzHqWFP6coV8QVSV3swndBRGSqjD7emmYhw12DADqtLyO38EX8p+/oGt+79HDFXXY2ZttMrIVcjACqA4VT77A/le2r+eITsthEFWTG/ckRtTiDE/36fNdo3UjpwHU41FMzi/+opOQg7NdtuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=umvsuBi4; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-45a1b00f23eso26687655e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Aug 2025 22:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755581109; x=1756185909; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AV/OooNGHPqLagZxjCjPrmrhDMj3BpKXfdIAYN7P2zY=;
        b=umvsuBi4iUQI3vZZLTdMC4RFwHQAV0ObMJFhf6x20OPuDTgCP2n5Tq3uAbuNBpLKwi
         ckTaVoiNTPCkCZwelwYAFi2IFCoh6pjfpjrZYkoQnP6DUCzhXKTpvfnlNEU4GXrI8m5f
         SUzI4l/C5sPsFQWIF0wNmTQ9u0aNyqeLO24tqaIsxhfYo0m5+JuUxalGdwiNwy63xi8x
         Ah57wa3TetiLcPWz5oLksafcAjFoE+N2FDGFo4//jpjEcZLPB9eD7S5tXF0PZLXdvyAh
         kKcWrBGwUgn2CU0wF3TC5CyzsU5kCzcukvLg9IutK0nq+yEfjCvrlcGvhabWu5xZpGWa
         bbCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755581109; x=1756185909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AV/OooNGHPqLagZxjCjPrmrhDMj3BpKXfdIAYN7P2zY=;
        b=KHoOuvF1k54UVs+xbFdyFqS3y9wDNxIEZUDCW3PE+snnrmKBGL0Py/95WKLomAipFc
         rbzBq8M63gW5xDbqMWy77U7Alz0m6opLn0c/7REhLGsbhVltS4S7uIhffj9V1kPI9geA
         dSzwLYQqRc+Z7Ejp74Oght2eViES0+dCv9VzIbOiuEjcQhExPn1U7C8TTcVpXnCJiDTr
         7TgdtMhu+aJXXn4sX0b3r0CTXCebvMbulumIi7NdIAniqusjPvo51zH+JQbKY1P9Yidi
         CgnaE3mgQWnLmJf7RTUnejKOXrWNgNOJEWcqK3vy1j1teLUV5DXLtvO3LvdUWozF3u//
         htFw==
X-Forwarded-Encrypted: i=1; AJvYcCVtjVZxtLzLZJCKfoNA4GtdMlAwvMV7oQy1y6/httOWQ1tJ/Rfi+F2ACHCHJG0x5auCEizsUsVlbFiZud8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzE2l8GBJNFib9j/Wq51jYVb7RIkGQxZ1s4O9l9oQbNH1Je6GvH
	N71eiSqECk7pse9tlw25FKwN+lKsPtoEJ6SCREvRInY5zzJ8DS1xaBKLGGVBDA8+lcY=
X-Gm-Gg: ASbGncsHuLaoiQXwvTv4s4s5/cGMg4gkxwvR1/bdqbcyCGkUFQPPGI5roneSpbBSd4N
	YBCaTNj/TIo2pZlsuxSF7P77GyU4WkLoaMsfC/LmUNFDUI2i51I3fxM67Js5o6X3kdNRKMZRaLK
	HNi0H6o8EbuqxB29nHaQXWVESLHbHPz0QVFgWZThuFNnAVK46rizmVA/yo43qd+MIvaIlz6OvA4
	Jx2IRO/8RUQ1Uz54zR4ylU9b+wj7PC2KhsTN0nE73nEu5w1+1R4n1pnop99RfLf6IMLFhI/WKGR
	hOopdcdwb5cPbnKqGli+KeuWCgCduxGC7byUr/bW6AysV/f+115BAdFZHJhqUE1Hwqul2y17HGj
	DKTJV2dRDJYIK4SL3tR/GR4kl488=
X-Google-Smtp-Source: AGHT+IHIiam/qjt8oskXB9TmvpyuJV3YNW8Fc5vo+kIONJNHr/RadS5xUia24l7fuZR0OAkgVqai7w==
X-Received: by 2002:a05:600c:5249:b0:456:24aa:958e with SMTP id 5b1f17b1804b1-45b43d464e9mr9178205e9.0.1755581109065;
        Mon, 18 Aug 2025 22:25:09 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45a1c6cf151sm200043865e9.8.2025.08.18.22.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Aug 2025 22:25:08 -0700 (PDT)
Date: Tue, 19 Aug 2025 08:25:05 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Wang Zhaolong <wangzhaolong@huaweicloud.com>
Cc: sfrench@samba.org, pc@manguebit.org, linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
	chengzhihao1@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v4] smb: client: Fix mount deadlock by avoiding super
 block iteration in DFS reconnect
Message-ID: <aKQKsS1Vv8joDjo8@stanley.mountain>
References: <20250815031618.3758759-1-wangzhaolong@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815031618.3758759-1-wangzhaolong@huaweicloud.com>

On Fri, Aug 15, 2025 at 11:16:18AM +0800, Wang Zhaolong wrote:
> diff --git a/fs/smb/client/dfs.c b/fs/smb/client/dfs.c
> index f65a8a90ba27..37d83aade843 100644
> --- a/fs/smb/client/dfs.c
> +++ b/fs/smb/client/dfs.c
> @@ -429,11 +429,11 @@ int cifs_tree_connect(const unsigned int xid, struct cifs_tcon *tcon)
>  				       tcon, tcon->ses->local_nls);
>  		goto out;
>  	}
>  
>  	sb = cifs_get_dfs_tcon_super(tcon);
> -	if (!IS_ERR(sb))
> +	if (!IS_ERR_OR_NULL(sb))
>  		cifs_sb = CIFS_SB(sb);
>  

This is a bad or incomplete fix.  When functions return BOTH error
pointers and NULL it MEANS something.  The NULL return in this case
is a special kind of success.

For example, if you look up a file, then the an error means the
lookup failed because we're not allowed to have filenames '/' so that's
-EINVAL or maybe there was an allocation failure so that's -ENOMEM or
maybe you don't have access to the directory so it's -EPERM.  The NULL
would mean that the lookup succeeded fine, but the file was not found.

Another common use case is "get the LED functions so I can blink
them".  -EPROBE_DEFER means the LED subsystem isn't ready yet, but NULL
means the administrator has deliberately disabled it.  It's not an error
it's deliberate.

It needs to be documented what the NULL returns *means*.  The documentation
is missing here.

See my blog for more details.
https://staticthinking.wordpress.com/2022/08/01/mixing-error-pointers-and-null/

regards,
dan carpenter

