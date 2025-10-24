Return-Path: <linux-kernel+bounces-868906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D944C06775
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 15:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BA0619A7AD5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 13:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E800C31BCB9;
	Fri, 24 Oct 2025 13:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="HDHGMijU"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA8F31352C
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 13:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761312119; cv=none; b=haQoLHGJgnmYkj88AqstDdLiGCQqocUCbHmjZ+Uz9YWQIgGPT5I9hHIkt2O3fpX/jXq7v++zzdvBXbIkIb9Qv2J1ZozRgl0x1GARWCJNZeVDzTlCuVNY4WzBQw4JBJXIXRvVAdCup6eSfLr054to4/lmxrwN+tZZYADilzcjKLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761312119; c=relaxed/simple;
	bh=RPCzSX1oysyX6317kBY4C69cJS7GZoh7NbUICcDmhcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mXIFF/FXEH4vPP8I7ElG4PaW9ZGhL6iQo86g+B28z/82ByGQKUdBc2IdUtHX2gLqhO1Dgh8lWDeYsHQkVVbsXdlG2Xk8iSPEOGa46VtrzA8P0Zjg1W7i2YNoj4dhnoKkU7NBwgdy8DCLCYGqc6lYItwMXo9ZsK1yMVlsP6W6i38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=HDHGMijU; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-890cc9b6bbbso267756185a.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 06:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1761312116; x=1761916916; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SAQ779KA4rgqpBPvYfGfpoeCfLnfK7s3JhseOdjjejg=;
        b=HDHGMijUvIGtwcUK2yjuSrnVPHSpn9VB4tFX549rxEmiaPwfKmalf+NVDeRzOG/jvc
         a0H1hU22mMlaGW8SKpk1568+1t/E8lvLk7JD2/rgGXUoR+ssSP5a5PwIj0tpI8PN+hCy
         Onh1vAsL6N0grY62c6QPzx0C3qvCAyVnAzIilK0gdrtDwewIGkKuD83LPt+8aw/YI5Qb
         AlfR1/fvONLKqQhjKYxC6B66Or7GqBXJ6bQ1ROoQ68PSdL2Hm5kqS97PBgzD/B/M+AfA
         AAiHCYzEBoqa5+wxZF2SyYlKOedsrVG8m0CXFezzxCAdu9ckOB6d82BgEvQGoQrMHBVm
         hAzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761312116; x=1761916916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SAQ779KA4rgqpBPvYfGfpoeCfLnfK7s3JhseOdjjejg=;
        b=roCja6HVwLAMeG7DRzY/l/foLyCFFJEapQWdtm1O05rxDJseyYb5JSyeJSZCB0X6u4
         2wylsIOYogXyV9Uyv23g9QXFkxR4xNmKsY7NEIwfaRbtrwjDa4+CgJLUX95ZBuDf1SB1
         uj3VD/6igqqCght+6D4SPmwLEaLldcLXND0zTsrWSA0fdEmL71Ll/CEMYnsVaSkldZb3
         dUT1TKbhZ9y+BaPCr5KNstXhse5J9TwyVhYso7i+W5cNRvEWejVBRXBxeHtadQo5C6jW
         RJI+oJjdz9yP4qw+9cocJqu5kHvX37G9RfAszhIB3vZznvWsLMqYYwhXK+nRIJJDA/sJ
         WYaA==
X-Forwarded-Encrypted: i=1; AJvYcCWc/PvQxUP/RNosgx5WEIN/+eCyfCoyvKiBijfJw/vYdg0zsnRTe7DbgWQGsTvjE17jg7LKzqWFlHPzXY0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwDnwkyJcmiBFD/S4yKHPW/dJWv7uJTL5KSY0T23RTNpLUM726
	B1oOt3IMzsLKgJqEczqDgO284944YbvSyltTZ3CWdtIwexBHyosA3J41Ya4KmPnXriI=
X-Gm-Gg: ASbGncuaGKm7APk+XLRhy4WELfws/nDIKdhUxRFw+CN1vCSjzJ/N8cZcGmB2+FW1SFL
	6brcEz0aqBBICT3lZOJjmAxUJnvYCgwX4xK/tRHvJy2JX1rt91iB6BqZjKRdp8in8YwU5qM6rw9
	6Je80U90TwCjZUL2lpL81NTSs7qJnmp4X8YlT/U+St5COapeOeUrNVaomtQxLk+jdhdz6m2eU0l
	rpzi1KMayCNHEj9ExsOle3tH59M3WOpoW8B7AgVgVVvtmelio9yjgMrV1lgyyWbgBbPwH8+f4j7
	dArd38aA3FhaWJhP4yOd+j9xcLXM6ryPFyZN1u4C/YdWCVdqNx/PLXmpJSkN1lxF6egwtfv0UEF
	Kp3wP/t5h6yP5mFkJxbm+kQkuBGQRLIkV1rqSbJG7duyyj/tVGsi6pDeh+73F2SDJIcZ90xZ8Wz
	5Oi2UWD/vrV2xlklNWvRvjiPzU0Vqmh2zwuffBro9/3O5TyQ==
X-Google-Smtp-Source: AGHT+IF631U7b/Uv4UfsWkET0fESocT6MB8PTnMKWhD//uyVN3fsa04WJmaAsspdgQynojvxMNqoYw==
X-Received: by 2002:a05:620a:46a8:b0:890:379d:9807 with SMTP id af79cd13be357-8906fd18325mr3332613385a.41.1761312116477;
        Fri, 24 Oct 2025 06:21:56 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89c120567b1sm384070085a.51.2025.10.24.06.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 06:21:55 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vCHjv-00000003hqy-1N7J;
	Fri, 24 Oct 2025 10:21:55 -0300
Date: Fri, 24 Oct 2025 10:21:55 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, corbet@lwn.net,
	graf@amazon.com, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
	masahiroy@kernel.org, ojeda@kernel.org, pratyush@kernel.org,
	rdunlap@infradead.org, rppt@kernel.org, tj@kernel.org,
	jasonmiu@google.com, dmatlack@google.com, skhawaja@google.com
Subject: Re: [PATCH 2/2] liveupdate: kho: allocate metadata directly from the
 buddy allocator
Message-ID: <20251024132155.GA760669@ziepe.ca>
References: <20251015053121.3978358-1-pasha.tatashin@soleen.com>
 <20251015053121.3978358-3-pasha.tatashin@soleen.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015053121.3978358-3-pasha.tatashin@soleen.com>

On Wed, Oct 15, 2025 at 01:31:21AM -0400, Pasha Tatashin wrote:
> -	elm = kzalloc(sz, GFP_KERNEL);
> +	order = get_order(sz);
> +	elm = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
>  	if (!elm)
>  		return ERR_PTR(-ENOMEM);

Please add a function to allocate preservable non-scratch pages then
:\ I don't think we should be sprinkling __get_free_pages() all over
the place.

You can then add a cleanup.h for the new function and so on.

It should allocate frozen pages, accept a size_t and return a void *.

If this issue is only related to kfence then the new function could
have an if IS_ENABLED(KFENCE) and use slab when it is safe.

Jason

