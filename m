Return-Path: <linux-kernel+bounces-767069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 216EAB24EC4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 18:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D8E65C1996
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Aug 2025 15:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3417527E076;
	Wed, 13 Aug 2025 15:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NirD4G37"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7401326E14C
	for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 15:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755100737; cv=none; b=h9u3SXJqM1YNozqyItnwbi/l50lYkmkAlnMDasjWKCOR8qY60xh7OwYH15qN0ygc+6XUnh7/E6yWH20fQEf+e0kps+lEbJYs6/HEmTHQdr7vN3BplNNz2Eq5VZR24ELRmLj6fUvSHlwPOx5FC95X08QjsYvEdy8eE9bgB59zAkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755100737; c=relaxed/simple;
	bh=JCJTW/Ucx88U/k5zzDsfVlKugMbj9mbeM3mUGqS/nCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m4ed/d61zsDd+cdSoKxRwwVOfPXoXY89l5zZY/sxIgD52gXgAJ7S4JipiAE8XdJ+/GWSoIzRdH15Q34CxbyHnY/YHTCS7ieyLgZJN/ILNuoTb0CgibtxKjQRZVdubxO04J6696gzVAEAU3cQWbQYyZASYv1TJ48KRGzBxAQAzzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NirD4G37; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-459eb4ae596so61598355e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Aug 2025 08:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755100733; x=1755705533; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cp6XeG0MyOuXPRX2EUNgzHzmYyd18LTitGQ6mKDCv5k=;
        b=NirD4G370wM0PVwO0+6k38cBSEWnpq4rq435W+rqUERDZ/xul1Lsm8AOr/TjSotCpK
         d70IdvxGMDhGcuquJtiIjWvIQTeF0I/hY1u3kQV6QVe5+xip9cimOWkZ/wi3213JXWDL
         4Fx+rs968PBViKBDgtCsN3+cEr9eTwHDP4zOmg2Y2wpgkha6Ny/+8Z7DGCwz//VZw/iP
         e7d9LaGppCP3QOmW+fsE7rfq97pHDz+pBr1QbLS1H4U7D0ymBzwPpY2s3KEKH8SoENJu
         eGviXitSx6wcnRDPSpnWSulz7yVXy/5PSKXWPLHwM0/frZXd6ld+11GXCfybwXcghy0D
         m5bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755100733; x=1755705533;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cp6XeG0MyOuXPRX2EUNgzHzmYyd18LTitGQ6mKDCv5k=;
        b=Wsyo0u/GFfkARE5R+Q/8jxbyyJQF2I5UTSKYaZMZdFxcoxwZK9S8RqEGDWCivWjI6i
         fGTHNPaGu0Hi6j9SzOTLKoJJTNOZmSp05pKp2hKa7EmLgeIdZFhkBApS9Cy4o6F+Or5l
         lZy5pD7LJXj4TY0E0TKG7o09M4UskA88u+tsLGECmwwjr2wNj8yLZgHQBtZU6dz719JD
         tEv+cKCvPxDKgpXg9tqggb3NhC71pcOw8s6T9xek/jTq6zijTeKcfn8MmNFv+gIQvtWP
         nVNQmyhCqlx/meSPgqsM5Nf3MBkOqz+SXaIqch9+SDAF9RiyaKwTH0z1hIN3AhLN+6z9
         vJJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXo17KJGQepK6RyomfjJD1/cSgQ4J1xZNXcrh3MXclN1dxWVyZo4Dvg2RMpKvSoBPLMZgY3tmRBnFR8/y0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFtasFBeH6KCIATtG3Dz+21xT0iWQjJiA7OaaTAKoEm9YJfYpN
	Q5NJI5E4ZjSHWIhUOvEUhvjw2zBARtTxyef6+a3iIHsoNI/pb/EAI/xX3rvslb4EvyA=
X-Gm-Gg: ASbGncsSgCD+HB59kMVDwhl7q1vk/VuLyM0lvqBKN9Myz8Rp9JFz1TJD9mrAOEwAQ/Y
	qeXTNNT8JvwDlCkswrh0JeTAbJcSpQ32LsKljSUX7E2cGo3i6dokwY0zkKZ3FQIdIfjX+F+/Sbq
	DQP6fMWVlHOfJjSAo+6z7e+QFnbCszajlYqS76VFXfltVfjyuBQcRGsgrjr8YGRQEx71CFVpYfR
	sVDThzjgFzLciE7KoWlHbhY9And0B6JT+/bti5neRujwMQw93fyXTx3wjkEGLzuoQzZAHmahPH1
	OniXq0D3m5hPhx524AS3R+8Ul145m4qbWxgrMvOy141w2XaSMrOYxbx82kGlFBuQ6EtPnS1bS2f
	yalGsdnGyEi91o04gt/kgMf277YZVHjmnKKc8sjAnUk8=
X-Google-Smtp-Source: AGHT+IFmDnHCSl5CKkyh/D1IvMDkhgbQzh6CQ86Hu6D5gyD/dtG5m2liXMYcw3pmw6tZ+PFrvCebxA==
X-Received: by 2002:a5d:5f95:0:b0:3b7:8dd7:55ad with SMTP id ffacd0b85a97d-3b917f14804mr2882432f8f.39.1755100733462;
        Wed, 13 Aug 2025 08:58:53 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b91b05b28fsm1789186f8f.21.2025.08.13.08.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 08:58:53 -0700 (PDT)
Date: Wed, 13 Aug 2025 18:58:49 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	qemu-devel@nongnu.org,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Anders Roxell <anders.roxell@linaro.org>,
	Ben Copeland <benjamin.copeland@linaro.org>,
	LTP List <ltp@lists.linux.it>, chrubis <chrubis@suse.cz>,
	Petr Vorel <pvorel@suse.cz>, Ian Rogers <irogers@google.com>,
	linux-perf-users@vger.kernel.org,
	Zhang Yi <yi.zhang@huaweicloud.com>,
	Joseph Qi <jiangqi903@gmail.com>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org,
	linux-ext4 <linux-ext4@vger.kernel.org>,
	Zhang Yi <yi.zhang@huawei.com>, Theodore Ts'o <tytso@mit.edu>,
	Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH 6.16 000/627] 6.16.1-rc1 review
Message-ID: <aJy2OVhg4RUYbHHR@stanley.mountain>
References: <20250812173419.303046420@linuxfoundation.org>
 <CA+G9fYtBnCSa2zkaCn-oZKYz8jz5FZj0HS7DjSfMeamq3AXqNg@mail.gmail.com>
 <2025081300-frown-sketch-f5bd@gregkh>
 <CA+G9fYuEb7Y__CVHxZ8VkWGqfA4imWzXsBhPdn05GhOandg0Yw@mail.gmail.com>
 <2025081311-purifier-reviver-aeb2@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025081311-purifier-reviver-aeb2@gregkh>

On Wed, Aug 13, 2025 at 04:53:37PM +0200, Greg Kroah-Hartman wrote:
> On Wed, Aug 13, 2025 at 08:01:51PM +0530, Naresh Kamboju wrote:
> > Hi Greg,
> > 
> > > > 2)
> > > >
> > > > The following list of LTP syscalls failure noticed on qemu-arm64 with
> > > > stable-rc 6.16.1-rc1 with CONFIG_ARM64_64K_PAGES=y build configuration.
> > > >
> > > > Most failures report ENOSPC (28) or mkswap errors, which may be related
> > > > to disk space handling in the 64K page configuration on qemu-arm64.
> > > >
> > > > The issue is reproducible on multiple runs.
> > > >
> > > > * qemu-arm64, ltp-syscalls - 64K page size test failures list,
> > > >
> > > >   - fallocate04
> > > >   - fallocate05
> > > >   - fdatasync03
> > > >   - fsync01
> > > >   - fsync04
> > > >   - ioctl_fiemap01
> > > >   - swapoff01
> > > >   - swapoff02
> > > >   - swapon01
> > > >   - swapon02
> > > >   - swapon03
> > > >   - sync01
> > > >   - sync_file_range02
> > > >   - syncfs01
> > > >
> > > > Reproducibility:
> > > >  - 64K config above listed test fails
> > > >  - 4K config above listed test pass.
> > > >
> > > > Regression Analysis:
> > > > - New regression? yes
> > >
> > > Regression from 6.16?  Or just from 6.15.y?
> > 
> > Based on available data, the issue is not present in v6.16 or v6.15.
> > 
> > Anders, bisected this regression and found,
> > 
> >   ext4: correct the reserved credits for extent conversion
> >     [ Upstream commit 95ad8ee45cdbc321c135a2db895d48b374ef0f87 ]
> > 
> > Report lore link,
> > 
> > https://lore.kernel.org/stable/CA+G9fYtBnCSa2zkaCn-oZKYz8jz5FZj0HS7DjSfMeamq3AXqNg@mail.gmail.com/
> 
> Great, and that's also affecting 6.17-rc1 so we are "bug compatible"?
> :)

Lol.

regards,
dan carpenter


