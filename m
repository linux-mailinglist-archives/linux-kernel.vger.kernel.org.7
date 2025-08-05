Return-Path: <linux-kernel+bounces-756606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80244B1B69C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 16:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B9441782CD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Aug 2025 14:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72C27278157;
	Tue,  5 Aug 2025 14:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="kaDTtUVO"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33570275B07
	for <linux-kernel@vger.kernel.org>; Tue,  5 Aug 2025 14:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754404506; cv=none; b=OMzT6rqXrSZY6vLAbvfDXnYQUAbqRFZW1PpFRL8QUcLn02ThGWmheJLwmTMLvnMmRK8egC/rRAysC1yQSf1VK6R3tQqfkZMolADNGcgZjJRgA61Rgvogpc9GVDmB8ntxsYrTs67x9OwW2fRborwKeC+HsVEUm89DxEaosOHhdrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754404506; c=relaxed/simple;
	bh=Cwbx4fAo3v6Kvmo6qZurjhrji8V9gCulLFdPdTB/AJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+ZEb2a1rkF9U4uktFjuWdK3XcV+KLRUxn7fg/CGkk1V9mstCO+L04mCFWcT9vlvyfo6YskCjWnKGFqxeLN6sqKUmTiTc2fT4iDQBYyziQRGBb833rszw1ds6oG3zv9zRWrU9fA46lhtI405NGpy4Ilvy9HEMZi6twzYXeBVeZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=kaDTtUVO; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7e7f940a386so145688985a.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Aug 2025 07:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1754404504; x=1755009304; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RBToXdvc7vhVURp+VSgDGT8CNn/O/Lx3N4Cacd9QC+s=;
        b=kaDTtUVOdsgW+SanOdS8detQSiuBhifz7s5q7Q96YUopgFQgZywMedTVza5U8yIxll
         ALPmtOY3tFzvmI1rKiWdkzIU0jwxaMQyPL0SgyOmFQnoqytBjj97wVsRJif7mq+9pgQG
         69ELtb4hgNq3yV8JNjG2BXDuS3NpBrxQ3TvRMcuGxJw0so6H0H337S3NBwioKKtdF57d
         vtNr7t/ofrVvu7Xcvv7OKtPd1CLmu0WT8ikJDFFzNNfnT9E0Ovwm4fDiEnBFFO89CJe9
         K+b1dOs7x82+NXGrxUVQEWLQMNxzOeA3dYo6ch/C4J45haSbqcpb8YoeAdrJ2VCjewyT
         RTAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754404504; x=1755009304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RBToXdvc7vhVURp+VSgDGT8CNn/O/Lx3N4Cacd9QC+s=;
        b=EablImsIy8GETcTkE8xFm+97s/hlSI/2VZW7x42rtVjW1vxw6/Gy94nkGIptfULKI8
         tRK3EpvSvDVlpCq1x0P2KJYUgnW3cGv98x6GTKQywoS8YlZW4EXTiMMHzH5qKK8l7W/r
         yQAVCyxXW27+hiOZ57IVQiKPHcBD0F/kogRrrDvhQC2iehyekIo/dykPxcN8w9i6MYOe
         XU0dY2Q/YOWtp3RvQpqBsBIr6SmvtdzEC/n7HDjK6MWq5HYzEQ+n5RSX20lsByLXazD4
         v6m4zbyz1SdumFQTL+UDJIKX45qDHVmOxs76j8YC75sqjGUG53EfHFFqQ38XW1YXHWzb
         9Aqw==
X-Forwarded-Encrypted: i=1; AJvYcCV0YlN62tyIu8T4QqhmDmXy0Hj9StdHmlDKSlfXOnzdV9+bPb8ssDNuwk6MjajueW3gnaZivdTKnzAI8C0=@vger.kernel.org
X-Gm-Message-State: AOJu0YznCuHjeRhviH0y7juuemGPbW5ZGkoOIv4mVvNaw7+oJUxFZvWI
	nPFqlfMj8I8XRwIkv7Mw7f8K9XyyTTr8fCCHbc6KPjZ7nQIDXj8PiXzvFUxXJILg6ts=
X-Gm-Gg: ASbGncuRcONiJXK8KBpwf6EsECwtjfBw5DB+PGQgTbJqX8x4VaXczA/wfFr8TOLUVCn
	dbGVz/8mIYSYB98LRE1KUhEM1yqjVYEPRXdDhgZejYyx8k/08YE+mhunwn1tcLGU9/WWPx2ouhm
	GslgfhPGJoF525KfnKzR3BfiqeGT2Po+LvALgt+Jzu96qSbEwhxMeZZdcwCW8X2h2B1cO74zBMG
	Rfk6MYjh1HLKMPjULQW2bPESHepxLskvvUQr99fdc3jkcPrBftVnaB0LKSEoz8cHhw6b9L96aTR
	xMUwyNWlD21PhdMb3LckVGpIGwTUx/3fpdnMSZl0Tgssv1bfRz93ZBRCS5vpnzBhEA6XYSAzqgu
	/CHjEXe3qyeS9xDaGcg1/Z8YIfhMTlOUbUxXnyZxBcFFgaTPA5L+BPn5uxEu7YQ7F3i0vlvE0O1
	LckUk=
X-Google-Smtp-Source: AGHT+IF+3kfrwzrTgPnPbgiihuZwD781MauBUX6H7jY1e1xn+FzW3NhXvH6UtxUPt9nNb/NESu2wng==
X-Received: by 2002:a05:620a:a483:b0:7e6:7e39:be55 with SMTP id af79cd13be357-7e696269e7amr1410178785a.2.1754404503789;
        Tue, 05 Aug 2025 07:35:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f5bee91sm681707485a.32.2025.08.05.07.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Aug 2025 07:35:03 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1ujIko-00000001Y5w-2i8N;
	Tue, 05 Aug 2025 11:35:02 -0300
Date: Tue, 5 Aug 2025 11:35:02 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Bernard Metzler <bernard.metzler@linux.dev>,
	Leon Romanovsky <leon@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
	Jakub Kicinski <kuba@kernel.org>,
	David Howells <dhowells@redhat.com>, Tom Talpey <tom@talpey.com>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, torvalds@linux-foundation.org,
	stable@vger.kernel.org, kernel test robot <oliver.sang@intel.com>
Subject: Re: [PATCH v2] RDMA/siw: Fix the sendmsg byte count in
 siw_tcp_sendpages
Message-ID: <20250805143502.GQ26511@ziepe.ca>
References: <20250729120348.495568-1-pfalcato@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250729120348.495568-1-pfalcato@suse.de>

On Tue, Jul 29, 2025 at 01:03:48PM +0100, Pedro Falcato wrote:
> Ever since commit c2ff29e99a76 ("siw: Inline do_tcp_sendpages()"),
> we have been doing this:
> 
> static int siw_tcp_sendpages(struct socket *s, struct page **page, int offset,
>                              size_t size)
> [...]
>         /* Calculate the number of bytes we need to push, for this page
>          * specifically */
>         size_t bytes = min_t(size_t, PAGE_SIZE - offset, size);
>         /* If we can't splice it, then copy it in, as normal */
>         if (!sendpage_ok(page[i]))
>                 msg.msg_flags &= ~MSG_SPLICE_PAGES;
>         /* Set the bvec pointing to the page, with len $bytes */
>         bvec_set_page(&bvec, page[i], bytes, offset);
>         /* Set the iter to $size, aka the size of the whole sendpages (!!!) */
>         iov_iter_bvec(&msg.msg_iter, ITER_SOURCE, &bvec, 1, size);
> try_page_again:
>         lock_sock(sk);
>         /* Sendmsg with $size size (!!!) */
>         rv = tcp_sendmsg_locked(sk, &msg, size);
> 
> This means we've been sending oversized iov_iters and tcp_sendmsg calls
> for a while. This has a been a benign bug because sendpage_ok() always
> returned true. With the recent slab allocator changes being slowly
> introduced into next (that disallow sendpage on large kmalloc
> allocations), we have recently hit out-of-bounds crashes, due to slight
> differences in iov_iter behavior between the MSG_SPLICE_PAGES and
> "regular" copy paths:
> 
> (MSG_SPLICE_PAGES)
> skb_splice_from_iter
>   iov_iter_extract_pages
>     iov_iter_extract_bvec_pages
>       uses i->nr_segs to correctly stop in its tracks before OoB'ing everywhere
>   skb_splice_from_iter gets a "short" read
> 
> (!MSG_SPLICE_PAGES)
> skb_copy_to_page_nocache copy=iov_iter_count
>  [...]
>    copy_from_iter
>         /* this doesn't help */
>         if (unlikely(iter->count < len))
>                 len = iter->count;
>           iterate_bvec
>             ... and we run off the bvecs
> 
> Fix this by properly setting the iov_iter's byte count, plus sending the
> correct byte count to tcp_sendmsg_locked.
> 
> Cc: stable@vger.kernel.org
> Fixes: c2ff29e99a76 ("siw: Inline do_tcp_sendpages()")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202507220801.50a7210-lkp@intel.com
> Reviewed-by: David Howells <dhowells@redhat.com>
> Signed-off-by: Pedro Falcato <pfalcato@suse.de>

Applied thanks,

Jason

