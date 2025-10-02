Return-Path: <linux-kernel+bounces-840323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B98D1BB41D0
	for <lists+linux-kernel@lfdr.de>; Thu, 02 Oct 2025 15:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F6E91758BC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Oct 2025 13:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81AE3115B5;
	Thu,  2 Oct 2025 13:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CqO5bBiE"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76D232D5928
	for <linux-kernel@vger.kernel.org>; Thu,  2 Oct 2025 13:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759413557; cv=none; b=qFYdRiYBk1I+yfcZFl3T/JxJ0OJK6+a4V8hUxIYv7Y4SVfsx4rtwUsKqbQGEV7UGedDFdPLCs47CdH75+8IwVSBquqQkO9cfrTTyp4VmacjwC0VSY6c1zYof+64ejyaKX1MPxvokSb+wv5r/hTcgCl5YzQkeTnMM0PAfhg8fUuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759413557; c=relaxed/simple;
	bh=k5xtrHej6iQBf40JjE8Ern58Z/LL3iBX9ALSoI8ap0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b5VJ206mwLpKprpxXjfmgmloEhz6mN9E4xNDDk0rTyVCm2AQc+ADymrtU84OZrxJERs7YmkKZjSMp/PQhQjT9E9MylyoP7ezyhz5OSfydURsDAsSYlrqOWHAHLmTlN9I72tXaj3clIlbeNdc59hw0k6HZkV+iERrFVdFZdMXZyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=CqO5bBiE; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-78af3fe5b17so1000665b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 02 Oct 2025 06:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759413555; x=1760018355; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AejVj1pzVa5tMHUAvlwjfMQqAVzkVnwGk/N4H8InPvw=;
        b=CqO5bBiEv5oq36jkXOLephgZU6sY80BxJFsTla0kq8f5B7w1zbC1VnKlxByLjWqpbJ
         hd4LhS2RAut0l8zgei+d1vc6FqtGRiNH1uV4/ZIglFSe6+nqCXZPAwukMq7PDuBIvNmG
         zC1wGiq30LnQJ+EfyHRulmsNVtk02CMQSyvyG0V5BI3+kE21quGOjmy46reKteHHJecL
         0MSWis+58gTzgI6R00GyZPg7QwX93b6kUwQ9buK+OP1BIZ4uE3fSE0V2OvlgWPzZ4qCG
         gvk4w1IssbUsAlPjY0js7wPlX+g2v/xyd7Ps0B3Brs3I/PLitxp2ftK76h5CBT0f1nNw
         ZdSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759413555; x=1760018355;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AejVj1pzVa5tMHUAvlwjfMQqAVzkVnwGk/N4H8InPvw=;
        b=V6GhC+PqFsZRbCV7wLl/ZqqYsL8xFWczqDitdocM9ZJyfwKSMgUf1G+ntxSJK0iNKU
         JsDnXgsYjNr8U109nsSHH/hDRRNVd0tG8QwycU4GKqMkdDcZvHRCVLlk31lKAy3L6GuA
         X6lE2U/kXMSJd2PrtSK19XmlT0oLySbXNGeOYyEIJ7zBEYBNAzTWY9sI8mX/tIrKQwgh
         reuKjM07mHH+vD79yrbUfr/AuCQmTMCnUzYNmkouP9l+AZvROmBMrIp48WbQ8DGu0gUN
         J/0cHiBEgkvPFAwtamTD157ZuqPBSyojS6G1oRBY8QQ55z6a9u0jobAq5ajLbboRmtIH
         RHsA==
X-Forwarded-Encrypted: i=1; AJvYcCULVyasaObfPbSBt7G/ZSW9heKy8D3JAovniPuay7NYowxfTW7szZC8DNA9uUKUQN5vkQqWkr7RtBYYs8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyE7UoMWJsifiGT+kIrDd0a1maonOqhFV5zlPI3l03GmxW3rqN
	CVTxXrspJTnmpsKkAojVhuX5ecKzggFArB39P8ks9/94zUpfyJmoyjfLQUgz4wyNENE=
X-Gm-Gg: ASbGncvYjkLujpucszIFyvMXKEQkAEGy1hQFQdR1P9ZMSDvs8vFJDrnOpja/blx6F4t
	RDqzHV8iRUlv++I1MtSOA+mtjhTiKlRfpKBmScoo5efKtg3ooo/XKz+EmahTEAOSezBSdPLvtnV
	3Db6Cp2Etw4KqvjIw+Au/muTvCdCULPbmyI4GggvKyXa3Mg3w5DvjPTXIuMzijFKmpBzE/FfMai
	xV+0sT4EmxMMvhUzzxWTllddulz3lw8gUw03cr5VntZAiJZpTSDFFh/d9qFWu5Hnelr/tIKcHlC
	GWILEeoI5WU73cSZczyNtIUmPrmv0fJCr7n2i69xzmyXhuxFz65Q7p3vhtFy0WljmQYbcwtymqr
	8z89c6s4zvs892ce8MwOo
X-Google-Smtp-Source: AGHT+IFjGtBLlrkcnGT3IwhvYU0siZeeKF1GDGUMbBleUNQJiex5zPfFC6dd5HdcsemvvP6EVFcU7w==
X-Received: by 2002:a05:6a00:17a6:b0:781:17ee:602 with SMTP id d2e1a72fcca58-78af422946amr8738022b3a.28.1759413554667;
        Thu, 02 Oct 2025 06:59:14 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b0208eb5asm2300221b3a.82.2025.10.02.06.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 06:59:14 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v4Jps-0000000DiKt-0OJJ;
	Thu, 02 Oct 2025 10:59:08 -0300
Date: Thu, 2 Oct 2025 10:59:08 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Shigeru Yoshida <syoshida@redhat.com>
Cc: glider@google.com, elver@google.com, dvyukov@google.com,
	akpm@linux-foundation.org, leon@kernel.org,
	m.szyprowski@samsung.com, kasan-dev@googlegroups.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kmsan: fix kmsan_handle_dma() to avoid false positives
Message-ID: <20251002135908.GE3195829@ziepe.ca>
References: <20251002051024.3096061-1-syoshida@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251002051024.3096061-1-syoshida@redhat.com>

On Thu, Oct 02, 2025 at 02:10:24PM +0900, Shigeru Yoshida wrote:
> KMSAN reports an uninitialized value issue in dma_map_phys()[1].  This
> is a false positive caused by the way the virtual address is handled
> in kmsan_handle_dma().  Fix it by translating the physical address to
> a virtual address using phys_to_virt().

This is the same sort of thinko as was found on the alpha patch, it is
tricky!

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

> @@ -339,13 +339,12 @@ static void kmsan_handle_dma_page(const void *addr, size_t size,
>  void kmsan_handle_dma(phys_addr_t phys, size_t size,
>  		      enum dma_data_direction dir)
>  {
> -	struct page *page = phys_to_page(phys);

This throws away the page_offset encoded in phys

>  	u64 page_offset, to_go;
>  	void *addr;
>  
>  	if (PhysHighMem(phys))
>  		return;
> -	addr = page_to_virt(page);

And this gives an addr that is now 0 page_offset, which is not right.

> +	addr = phys_to_virt(phys);

Make more sense anyhow when combined with PhysHighMem() and gives the
right page_offset.

Jason

