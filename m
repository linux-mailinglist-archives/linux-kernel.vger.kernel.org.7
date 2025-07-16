Return-Path: <linux-kernel+bounces-733144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB1EEB070C8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 10:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B43B17DAEB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jul 2025 08:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06B8D2EE998;
	Wed, 16 Jul 2025 08:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dbXVzg49"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC9D2641CC
	for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752655247; cv=none; b=KLKIcqoO63sGfmN1jCVHMhhns8wLtQfsZDtfHBeuWLKYZS0Znzc8ZwNIugi7EmED6RZtjFdW3xNXqIPmErU+gOuMlw886iZA6OZx0SsZI4ddy8438ELicTL7KW43xAzRFVU1VaxqLMM9dRMkCmn7E2aCc7Wxol9vgkRtcCZWO6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752655247; c=relaxed/simple;
	bh=qrMBhDY0wRYT8PuFs9DrrojFLigfaPzRLRSNGcKBjFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fjXbSXewLytA+xFVcXvSWbw6X8Hij0a0yJMvRgF6Hx6mp2gFlHXxux+wIOOMyQmh5YO6ZuraYIDi5zmkLgF0jktK541VkHlO8Rp2KYHfvlitpGkTpOc8h+fWMmesEJpCn6zOnjWJ/z+xUPoCgCUBhfSD1N17NXjY//P7EbbN2oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dbXVzg49; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3b49ffbb31bso3624147f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jul 2025 01:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752655244; x=1753260044; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BJWUrIQdaBC7NQriNJZiQ1JQak1bftewdlMIEM95H+4=;
        b=dbXVzg49eBEzGaya6EjZx4Hre9mk4xnYTxI07b4nCnTr3J6OJpNbizsW+yBnf/EpA8
         X+v0Z4azBJSsjij0ezjnbeq8PPDQ5oYDjx0mVz0X4GDtpFZ1tDi1y2aVPZexejJDR4dd
         Vddcy3CD2ZfXCT4t35uPpL6Y0QADd9Ytz8tZEw71W+xpwd8xontFd53Mo7MSeyA9+Lct
         IGURggFZpuSErG1rNlLe2FwP08C0pLpU01rrlGiIrUR0haBKWDqnQN9gAT0QvQELnJfy
         1IdJdYB6xf+ofsVKdIg9lDlL06sYMPp0tMDAgFjhdeZzmXZy2+8R07XHitmD7aw5eTmT
         Vyjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752655244; x=1753260044;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJWUrIQdaBC7NQriNJZiQ1JQak1bftewdlMIEM95H+4=;
        b=BCVCxQh66bU+bi1//UcKgFJyffDhhyaMUDVeVqatSQHdUXTmRQNie09qwz7a8C12K7
         +JlcmNhTMvKG2vZEuVxbHaOS8/3dobLr5HY1XwtLvlH09dU1hfKoK7h5/HCBMYqQZe0v
         584W9hz1pXo0cCOWu35soehzEZSSYdNcq97AfBjzvCa7nMOsEjwxdzngWSAE4lh3gW9A
         SpxEqOaPyQ5foBjtFCgxmDBF4U70YvI4a4IY4zyNRuxIHN1QYXAjZkH4LHnaoEh+qE2D
         68QTrkz1W3vH9rNaIRj2y3rkLJRWOnh9gP20WAFNLhUmUabgouK3826H5c1G4TfB4QfI
         Z1sw==
X-Forwarded-Encrypted: i=1; AJvYcCWCZuHYhMsO8s2NBhbBSo7gSOTywpIFzciajoEAPbcHSmU6XGZcWfrmK4V4cvKaXZlZojLNQK+gvcs+xI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdWsY89Dge8zek3ANBF8iSbJLgNL5PtILXZXy48KHf3uKmf/t6
	3ssKrZdI4Ts+jp0fZrT0ng6XH2QLOG5al+bHhOQcS95Wvbwu7kY3nwX4uRFD3mplsA==
X-Gm-Gg: ASbGncuhxCCjxq328RKyFlpvssZ0SS/glVporqjopC+3EmUcU8p1SQStESUpGT7Jx/v
	mOI3iZd2rKr7NQ5GKmJMY25CCmuolXZ3WttPWb4GqGNg3KUbuSCCmRrBVvbODfePCxrGKhBkgdk
	UJ5RKzybRlJV/HE4xNG6OlAoiV+qv8EbulEhIMADiZAxNrvKoB0gWTk8hS/K19EsHfEbFc3rzl5
	kwmHstbl1tpHCzK4GOvhzkNpUqbPg96Stfk0PINJTlI8AQuJozBpX+Ga2TZ1E7dPEwmDTyTWtbV
	ZiYchNLSQ83urDamTbGmrTWJqWUjDodlKb+Hd31FxkcR9D+dHA0gsCi7NEgOhyR+OUjFULZQ8tF
	ja2fU7o7QYFvE00wd7i1/GA==
X-Google-Smtp-Source: AGHT+IG2JVIKdbXCgSujNuX8MaJwzxKIn3RGftig+Rl8Or93NssoDRwCfiPvHo1nvu0ecatAz1qVHQ==
X-Received: by 2002:a5d:560a:0:b0:3a4:e844:745d with SMTP id ffacd0b85a97d-3b60dd8e738mr1521605f8f.56.1752655243702;
        Wed, 16 Jul 2025 01:40:43 -0700 (PDT)
Received: from MiWiFi-CR6608-srv ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23de434c9cbsm126694355ad.202.2025.07.16.01.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 01:40:43 -0700 (PDT)
Date: Wed, 16 Jul 2025 16:39:56 -0400
From: Wei Gao <wegao@suse.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Penglei Jiang <superman.xpt@gmail.com>,
	Mark Brown <broonie@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
	Brahmajit Das <brahmajit.xyz@gmail.com>,
	Andrei Vagin <avagin@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Ryan Roberts <ryan.roberts@arm.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs/proc: Use inode_get_dev() for device numbers in
 procmap_query
Message-ID: <aHgOHMWnTsYgsj7C@MiWiFi-CR6608-srv>
References: <20250716142732.3385310-1-wegao@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716142732.3385310-1-wegao@suse.com>

On Wed, Jul 16, 2025 at 10:27:32AM -0400, Wei Gao wrote:
> This ensures consistency and proper abstraction when accessing device
> information associated with an inode.
> 
> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  fs/proc/task_mmu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 751479eb128f..b113a274f814 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -518,8 +518,8 @@ static int do_procmap_query(struct proc_maps_private *priv, void __user *uarg)
>  		const struct inode *inode = file_user_inode(vma->vm_file);
>  
>  		karg.vma_offset = ((__u64)vma->vm_pgoff) << PAGE_SHIFT;
> -		karg.dev_major = MAJOR(inode->i_sb->s_dev);
> -		karg.dev_minor = MINOR(inode->i_sb->s_dev);
> +		karg.dev_major = MAJOR(inode_get_dev(inode));
> +		karg.dev_minor = MINOR(inode_get_dev(inode));
>  		karg.inode = inode->i_ino;
>  	} else {
>  		karg.vma_offset = 0;
> -- 
> 2.49.0
> 

Sorry for my mistake, this patch is not correct since upstream has no inode_get_dev function,
Only suse downstream code defines this function. Please SKIP this patch.

