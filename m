Return-Path: <linux-kernel+bounces-735469-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF192B08FBF
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 16:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B006BA42E2A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jul 2025 14:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE1E2F7CFF;
	Thu, 17 Jul 2025 14:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JGtShvcW"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE0F2F7D04
	for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 14:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752763386; cv=none; b=tcZV/ImuCs27WvMKgMfKI43mC3jm0qBL1Qw3569NMbth12xKOm27yIyC2+YB1GMcbEGLmf4qaEXDb2v9baH9gqnFF0+E4CewQaVG/L1NN3tejc1kDsWtneqNQhyUxaBT/NkU4YtGrjaY7IKyY5NJE8+d94OwMZEQi9XyZLJ17fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752763386; c=relaxed/simple;
	bh=TUvCGY8B4YTvR/P9Ogy3oBePGHFOB4QpVyXuiTt1/vM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iHYIOPRoxubqfh1mykkPuls5YJIgLWYc6rk5S3pujGxXiI8MPTDAECSt3emlj71MDP2tHxANWkLj3aVnJJST41FlKisozHj9MuDzOe2j9znZpqXFdRxGLc8eE5HtIe7Q/ZKg9xfoSeyC/Q/S+/Y86yv91wEQ91ulmuhDZmh27AU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JGtShvcW; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-73b5350980cso1510434a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jul 2025 07:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1752763384; x=1753368184; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N78W/BgXf1tgHbV1NKXMAh6lES1lL9j7RfFG1d9Frx8=;
        b=JGtShvcWLtdPiXcyX9BUB5PA/USt/WPS2bg1k3NRZkeWlkw9B96BOClNVL/bUhItv9
         4ct51ygsUhl3DZTGhkjX9UzjCsbzKdqoHpuqwyVGQv6Xq4UnzRxbBVhNNMmzUyp0rftg
         RIfNDDh4hmPf9J8+Og9PDVLwc1qVx6ez67zYkUZwZIP9xsdooGT7YYCjDzNf0MEPPoMu
         06/5gSkfjXf6QZzw2s1t/kpoSg8D9UTLkPpsO4UnXQeGGE3PLzuknKPdaiZIRr6/ZRaH
         ZL+GXyAqxJOeElBXSkiQVNPGunaI/4wf0t9ApzdkaiuOn60TK7TuPbmtCTvsyc2xAtp6
         dc3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752763384; x=1753368184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N78W/BgXf1tgHbV1NKXMAh6lES1lL9j7RfFG1d9Frx8=;
        b=q5kMCwHSR0wivJEAJaqfxIMMpLBDKa+qR49zmlQztgkviZmapqh0cvDlGSxR5fs2VK
         CRrmqwDVSELrEGUnbcM9296PWk122fob6tUG9iS31CuLOaSd96XJ2sk4ZVWxcArCehsp
         DTpog5YCGZkYAEn03Ml5cMFi4G/FkZ/cG6Hit4JhCToS3EOXLXHfqLfrjZzeR1dpT2ZC
         kLMeSnpDHp9Klvaq9Kas1MZOX8CVE0jcAK+feXo6fYt9O4KXwZ3BmJfX18xWUvlFPTFi
         lYbQylWNjZ24BVdhJNq0SOHsQquHlrAaV9sFc8KUHopx+7o7zGns4IOYWwX9tTJCD2gj
         aLKw==
X-Forwarded-Encrypted: i=1; AJvYcCUdn6zzckOHbmmQYD1t9y4iP5N0WcjpDz5YEWgR2DlAnT5Yw7/+fpL2wF6T1EhJ3t2+zrFeJrS2t5TSQPA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCEXcfQ4gMVQgV6TQcQHfr/pD0zu8qTKMvhplSBd6Eb+cRrxo8
	R7kTvC/pJs5RNP7a91+PeXbq9FMpNURFzP7sguZizD4BmN9YX8miXqfwJabkrrO+nJM=
X-Gm-Gg: ASbGncuhx2kH7jI09jGDO3G+7rD1T7wgNWlSXd7D6RUCb4q+Z4p0IPp0SXVrH4fipQl
	w1dBAmltwN3YPwj051P1Xfq7HtjL1j4gt71uhHVS7Y3Ar/lsa0sBWf4O3yQRW8oBII9TkvXIzhd
	jh6fZDBG5MdtcyTbT7vOsMNd077EM92lfdFEaRDuSGboqKvAb6hm47TizwBzV+ndTWi3jdYo2up
	k3hsboxhRdhaAqOk6UlbjoeL4AasMoqJkZwYh25CxnW2s86BdzUY9DF1m0s0QYoeys97dmsDAwb
	4YFzGLRGmTILeqJ8zThyF3NCXbWY40EKZScMGtCLCqHld4yx442UB92+l+ElTM8A0jRM8rKtE8O
	4ofeI3ZukNYGuxRA+zoUFTiwZcccb
X-Google-Smtp-Source: AGHT+IGQ+TSDCCeabKnTN9pyedrIO5RV7K7MPGMUZ9ECCW5ZPF3U2n6/pVX95Wy4kGkp6UMhuZSeXA==
X-Received: by 2002:a05:6830:270a:b0:73a:84e2:117f with SMTP id 46e09a7af769-73e734a9263mr2519166a34.9.1752763384241;
        Thu, 17 Jul 2025 07:43:04 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:2c38:70d4:43e:b901])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73e7bb81791sm282702a34.20.2025.07.17.07.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jul 2025 07:43:03 -0700 (PDT)
Date: Thu, 17 Jul 2025 17:43:01 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sergey Bashirov <sergeybashirov@gmail.com>
Cc: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
	Antonio Quartulli <antonio@mandelbit.com>,
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pNFS: Fix uninited ptr access in ext_tree_encode_commit
Message-ID: <2bb8edfa-e2f3-41dc-96ae-b75b5ba22060@suswa.mountain>
References: <20250717143522.59744-1-sergeybashirov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717143522.59744-1-sergeybashirov@gmail.com>

On Thu, Jul 17, 2025 at 05:34:04PM +0300, Sergey Bashirov wrote:
> Current implementation of the function assumes that the provided buffer
> can always accommodate at least one encoded extent. This patch adds
> handling of all theoretically possible values of be_prev, so that
> ext_tree_encode_commit makes no assumptions about the provided buffer
> size, and static checks pass without warnings.
> 
> Fixes: d84c4754f874 ("pNFS: Fix extent encoding in block/scsi layout")
> Addresses-Coverity-ID: 1647611 ("Memory - illegal accesses  (UNINIT)")
> Signed-off-by: Sergey Bashirov <sergeybashirov@gmail.com>
> ---

Generally, we wouldn't put a Fixes tag here because it's just silencing
a false positive.  But also putting a Fixes tag is fine.  Thanks!

Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>

regards,
dan carpenter


