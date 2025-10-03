Return-Path: <linux-kernel+bounces-841322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 64624BB708D
	for <lists+linux-kernel@lfdr.de>; Fri, 03 Oct 2025 15:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 653634E3B41
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Oct 2025 13:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992422B9B9;
	Fri,  3 Oct 2025 13:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkgF/PRP"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1122115E8B
	for <linux-kernel@vger.kernel.org>; Fri,  3 Oct 2025 13:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759498722; cv=none; b=LO1L7j+PGstiBryNgf4G5AJtghLDOrBbWHnb65NYQZgV3HmhgexjVMxUErm3EHBTEyT+q+zBVjFNoW1npuvP0VYDuAUIYUPhrE5vonwYYRrDE9P9KpiUQPzcL4r8RLU/m5LHOraBH1q8ygVOrE4xEOmGlkSZSnSR0XvTqbet/Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759498722; c=relaxed/simple;
	bh=HchU8f4EgzCIclHzMtEp4ytQk6iEU1OkJuge3NDZgkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qK+RHz3olVeADc/B4vPr74BePgUOdRkVL4UJBjk2pr9qbsI4FJCLdTc17aIOoeFdZ4Gtjvzl0t7nLjzJ1d787pqzjNjnJ5j2umGZRUPWhQ/v76+OxaenwytYQLsDrCQCeVdtFwf4mYRhka2Jh5pJu60NpZd8kbZdwsNzej4SqkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kkgF/PRP; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-46e34bd8eb2so25625665e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Oct 2025 06:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759498719; x=1760103519; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zjd42OOVf+WajS57RrAMPmwuVCYgfRwVOtOJ5YCKMLU=;
        b=kkgF/PRP3WSisCuM7qr1b+G/qaDJIg1Il7bNMY1zINAfSZN+gbRXJMcVir5ZJDXrog
         4t77zDxR0oH5L9z/5Iw5rOn3w4U5qziu3u9FHr1kt1mOtviEOIr8PRUUA6hc6oDRLqNu
         gp+xEDLycpzqD2ELyb1wGekV7PM3b/20mhL7m4wXFvEGUWXcMsJqLd0cEM/O0r6Hhin2
         HrCRwpm0GX9MlTYiFYFfj5z7BsVA7ofJZdlkXZ2F/JuEnuPT7OIhuPzx+ucYmxvoc576
         OlGrsYRPVaWjW2cit/sK8IYaaue3Zc2L5xzqXLe11LIM3JSpL0CXeAnXCYN3+0lKqAR2
         E6hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759498719; x=1760103519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zjd42OOVf+WajS57RrAMPmwuVCYgfRwVOtOJ5YCKMLU=;
        b=kPh2sbcNvWSS7rCGbXyjJ3MnqltrkNcT+J9qnWVZ3issC6v2JVrI+YLVUwAkEjc1VN
         km6VKxGAtKPi13syQrcsI41D4xmeVFd2LBFp3t0TencYDZjmLNyW3bWIzDHkXKK+52eW
         A7SgFOpauhcyHrgfCn0s3H+UGJT/5Kpi/H54kxaBGcCO80O31asRBb2D1NjCO+TGyNek
         f+DJkI9CF6/6AfN9rUVgAlOiXeed/Rm1uanyTU8URZV8P6snygtkkK/2/hTgxU8M6474
         /a3lZwoH9xliwWRRSaht0CKtUytyUGqNhgapvVlLRSGiMV9em7kSp2uGw3WxJgievqgw
         8IRg==
X-Forwarded-Encrypted: i=1; AJvYcCXuRPR8xWIkJeW4e90+3s7JG3MtUDi3elzCY+EdO6jRbeYgO+VN87/OKQIIM2J85CCag2iUeVRGrCcQh/U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOyJoqlC0eFe0DfGYM3eqJP6o/tw0Ukad3kl91zuteU5rPnTYY
	wnClErgp8l0LMufj1+zRZMHYPu9UR6Yj5m4biNFFBUvpwUHuZWCPJLVuzpMufw==
X-Gm-Gg: ASbGncvjJNr+3L4/oVXU5NuH5QBte9rzfgGF3/t2i29bFBU8LDJhtGNYuv51aDw25FC
	HI5lHoWAsXU+lWsGeKIcBhorYBq4/2dtNzNDHB7MFU9TmPtec4xyPi3LTc++pvSqY9O7SoDNEyS
	RaeyMa5qKckk15KHfoLb5ses0dq+DSxuxJVo7VDOYL1lNBV/d2azDhG8K21Gf+iKfsrDKvcBIIH
	bywg1YuE3rD9MTe1cIXsK/c6t9Gov9X2CKyaa8GVsNpwQ/5nGewWpfADUwJ1WfNGuzdO7Ojy45m
	7sOvZQz1Ng36pu1xwsjH07K74ao6acImdHvvapCNYaZORbSK+Fnq6R4FgTPHpnwb+pRQ9jrIghI
	BNpkSLkGLcwvDWCfmE7h+FjmMlB2m3+8C92dN795iXkDJ0uCeEILFtSLe1pa7u5vMDYdQ7FJJvX
	hVLo5NZby2OrxSZWdC
X-Google-Smtp-Source: AGHT+IE2d2+VTZ/oWXOczMKDIO72TpVL76DePnGYNZ6TZ9XC7xNSiQbSXq1QW7v89ZQFfAk81Twbfw==
X-Received: by 2002:a05:600c:1f8d:b0:46e:436c:2191 with SMTP id 5b1f17b1804b1-46e71145d77mr24764275e9.25.1759498719134;
        Fri, 03 Oct 2025 06:38:39 -0700 (PDT)
Received: from f (cst-prg-21-74.cust.vodafone.cz. [46.135.21.74])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e61a020a3sm130655105e9.10.2025.10.03.06.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 06:38:38 -0700 (PDT)
Date: Fri, 3 Oct 2025 15:38:28 +0200
From: Mateusz Guzik <mjguzik@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: kernel test robot <oliver.sang@intel.com>, 
	Dave Chinner <dchinner@redhat.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	linux-kernel@vger.kernel.org, Carlos Maiolino <cem@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-xfs@vger.kernel.org
Subject: Re: [linus:master] [xfs]  c91d38b57f:  stress-ng.chown.ops_per_sec
 70.2% improvement
Message-ID: <nfqwkcdbd5xawykrtb5nrhvmpfimtry6qyuig5p7qmlehc7itl@utic4l437gwn>
References: <202510020917.2ead7cfe-lkp@intel.com>
 <20251003075615.GA13238@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251003075615.GA13238@lst.de>

On Fri, Oct 03, 2025 at 09:56:15AM +0200, Christoph Hellwig wrote:
> On Thu, Oct 02, 2025 at 04:11:29PM +0800, kernel test robot wrote:
> > 
> > 
> > Hello,
> > 
> > kernel test robot noticed a 70.2% improvement of stress-ng.chown.ops_per_sec on:
> 
> I wonder what stress-ng shown is doing, because unless it is mixing fsync
> and ilock-heavy operations on the same node this would be highly
> unexpected.
> 

According to my strace there is no fsync, instead all of the worker
threads are issuing chown, lchown and fchown on the same inode.

As far as *benchmarking* goes this is useless.

Note stress-ng does not claim to be a benchmarking suite, but a stress
test suite which can also report ops/s for whatever it did.

This bit does not look particularly useful for stress testing either tbh.

