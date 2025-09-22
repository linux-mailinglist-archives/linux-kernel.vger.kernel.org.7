Return-Path: <linux-kernel+bounces-826567-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F8BB8ED32
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 04:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3D3C7AA101
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Sep 2025 02:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90BE24A054;
	Mon, 22 Sep 2025 02:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IrqOWpbR"
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2982836F
	for <linux-kernel@vger.kernel.org>; Mon, 22 Sep 2025 02:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758509485; cv=none; b=ZoU+rNGv2Jy2YJT+jloB+7esr7JDf2caCfjhUWhOqQvEqNSNPRzlIkqowfZsoTQkMuCf8QTfoyvoakCG6iQCPSDiDrw3gL6KocjH8Qymwj2aoYxSUBiIwEQaDTud8k1NivevRHIMdqzrM1lKbcvJmdLZ7GoMVyiOlG/v23ONfQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758509485; c=relaxed/simple;
	bh=FMeorxPuz9pIuJiA0k3nqjvZUMA4VDQjlDACW1IW7qY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fFxZKYXFNDRQxgwrM8E/lKjiKDgMXFya/gdJ8CdEFaL5zZigVaFq3I64OOD/OiwyDsRezxbeg1jk5Zcb2/oSqzjscVFmYfLVP35fquKljua2waxQvO4kk2rxtQUImo9d7imCFxNcjthkmBb8R9ywMbfEvi5A2IJlaV5U1UtJIR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IrqOWpbR; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2698384978dso32428105ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Sep 2025 19:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758509483; x=1759114283; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jH+DrKSNruoUAxCCZ6Vj2RaXFgJa9oKCTsnV5uqgSrE=;
        b=IrqOWpbR4GRksQmCMEq3oWDzpuwQGP7Q9b2ijTUvpODe1KLfJoChsG+Z6IgXrY8PJa
         Tjy5jLnYrUgTw2e0DELKTJd/D8QyX06Pq4ouxkOUJD57MH/XG0S/B3hzdsblTBeZzfb8
         TdXlNjHmZiQZi6vn5P1BbAVPvO2SIqmWtUcWIB6kKtK7W8Y8paAWyn6YRfRyzZkO/mJy
         63qccixsskHFMrERqAL2WMcucdGQEocsWzUxg9bkKr3GJd9FwymcPQ32MmJ2KJMTj9/u
         WhWq5Lpsx3dRaM50pYatnr8KNc3bXeDfcvIqvxS/RHXzcQVCnXJf/6/6ChAIVpFTxTDN
         ANVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758509483; x=1759114283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jH+DrKSNruoUAxCCZ6Vj2RaXFgJa9oKCTsnV5uqgSrE=;
        b=SxKyZ7sIL18ZDAt6hJXWHjzHEVYwJefGQd93I4izEEiSwp+1LXMp9NUGcEsjgtnBrj
         G/POBLqk4P2JyCtv8bsLfqwpPuoQjP+SWZvIGxzmXT6Te8WR4tu4rqjFtSiC6tja2Wvp
         OSxy27/yAPsCArQL3yjYh6wz0M1rf+5ZiDySuquKhi4xVMyl4scoNtAnIGMBHOhCz/rn
         o9KNKExRO/LXm93tEom9T8nzhC5FimECGFRv4MbTnQeDlJp0S/U5AmKGoj5/RSM1QBPb
         fD61pebGeCzqzAYcZyfKcjP5mBkThs9vLGKZufAjYc/0m4CW7KSfRXdZeSGfYq5XqTUK
         wiFQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/EN3XmGWroYaKePJK9sLH++6Zx+O+WItmPcbNSkKIzddmAS0JiPWFHQqb+9MRLRmLt4z5F12T9K7itPY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5QsRNpy0zdDr+8V/dBt76erGOmHRN6Es9k7iO3hH+c8tXJGtZ
	Zfl4z5VWHjq1RD7pZEpiXkodt+UQ5DKqjFTmL1u/WEf04LPFmfSyKG5o
X-Gm-Gg: ASbGncuO1KWKUkileQvWNVIp3CdVzxSsOvJ6aal6+DJsNqEFc56oqCuqNjOU+5qKCS2
	stEUDHp7mjgIZkrUkH8B63FErK65YjjuZjz4BMjzGgks/Tg+QtU+vkyCgvl5SSjpk+LOm0TMfZp
	OpK0pNZ/XtkfGUWtKPWTP5LcKXQjqK5NuY6OR/wW2+PPzJBoXtnOl8he1sYGfhRkqVRdfmvjaC8
	0NRTMllUiEehe2RiWCbHSjUfIEbkRlQcqWnYIdqrT5bBcJiT0uEmthaz0zvMcG8ZSjpcqdeuPS0
	bzpvbbuerU2iwZ+ElYFeql1pcL87b7U4kUuMd15SA92IAVUTpgGaLQCJ/nKIkLUFmdwXjIKjQtR
	B30k7pf12iK47WyE0CMFOrelFHdCgRT4yKHc=
X-Google-Smtp-Source: AGHT+IEwa3F5+Aw9ZdMexHvGOoSY1jJqiIO6Tj+RjacyuxTVxr4cEf2DJqUfKe3twh04nT5Dkwk0bg==
X-Received: by 2002:a17:903:3846:b0:267:c984:8d9f with SMTP id d9443c01a7336-269ba45919fmr171335405ad.24.1758509482553;
        Sun, 21 Sep 2025 19:51:22 -0700 (PDT)
Received: from localhost.localdomain ([117.86.193.224])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269800529cdsm116978635ad.22.2025.09.21.19.51.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Sep 2025 19:51:22 -0700 (PDT)
Date: Mon, 22 Sep 2025 10:51:10 +0800
From: Vernon Yang <vernon2gm@gmail.com>
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: hughd@google.com, akpm@linux-foundation.org, da.gomez@samsung.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Vernon Yang <yanglincheng@kylinos.cn>
Subject: Re: [PATCH] mm: shmem: fix too little space for tmpfs only fallback
 4KB
Message-ID: <kh5nq3ycj5neufhmiqetl5vtosictiflk73xyb2fdl2p4txmu3@4ndr7cw4b2j6>
References: <20250908123128.900254-1-vernon2gm@gmail.com>
 <c245dbb5-2e2b-4308-a296-f711b74002eb@linux.alibaba.com>
 <3349E5A6-BCDC-47B9-956B-CB0D0BC02D84@gmail.com>
 <fd0664f4-2ee7-420c-a63c-b4b1c923e1c2@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd0664f4-2ee7-420c-a63c-b4b1c923e1c2@linux.alibaba.com>

On Mon, Sep 22, 2025 at 09:46:53AM +0800, Baolin Wang wrote:
>
>
> On 2025/9/9 20:29, Vernon Yang wrote:
> >
> >
> > > On Sep 9, 2025, at 13:58, Baolin Wang <baolin.wang@linux.alibaba.com> wrote:
> > >
> > >
> > >
> > > On 2025/9/8 20:31, Vernon Yang wrote:
> > > > From: Vernon Yang <yanglincheng@kylinos.cn>
> > > > When the system memory is sufficient, allocating memory is always
> > > > successful, but when tmpfs size is low (e.g. 1MB), it falls back
> > > > directly from 2MB to 4KB, and other small granularity (8KB ~ 1024KB)
> > > > will not be tried.
> > > > Therefore add check whether the remaining space of tmpfs is sufficient
> > > > for allocation. If there is too little space left, try smaller large
> > > > folio.
> > >
> > > I don't think so.
> > >
> > > For a tmpfs mount with 'huge=within_size' and 'size=1M', if you try to write 1M data, it will allocate an order 8 large folio and will not fallback to order 0.
> > >
> > > For a tmpfs mount with 'huge=always' and 'size=1M', if you try to write 1M data, it will not completely fallback to order 0 either, instead, it will still allocate some order 1 to order 7 large folios.
> > >
> > > I'm not sure if this is your actual user scenario. If your files are small and you are concerned about not getting large folio allocations, I recommend using the 'huge=within_size' mount option.
> > >
> >
> > No, this is not my user scenario.
> >
> > Based on your previous patch [1], this scenario can be easily reproduced as
> > follows.
> >
> > $ mount -t tmpfs -o size=1024K,huge=always tmpfs /xxx/test
> > $ echo hello > /xxx/test/README
> > $ df -h
> > tmpfs            1.0M  4.0K 1020K   1% /xxx/test
> >
> > The code logic is as follows:
> >
> > shmem_get_folio_gfp()
> >      orders = shmem_allowable_huge_orders()
> >      shmem_alloc_and_add_folio(orders) return -ENOSPC;
> >          shmem_alloc_folio() alloc 2MB
> >          shmem_inode_acct_blocks()
> >              percpu_counter_limited_add() goto unacct;
> >          filemap_remove_folio()
> >      shmem_alloc_and_add_folio(order = 0)
> >
> >
> > As long as the tmpfs remaining space is too little and the system can allocate
> > memory 2MB, the above path will be triggered.
>
> In your scenario, wouldn't allocating 4K be more reasonable? Using a 1M
> large folio would waste memory. Moreover, if you want to use a large folio,
> I think you could increase the 'size' mount option. To me, this doesn't seem
> like a real-world usage scenario, instead it looks more like a contrived
> test case for a specific situation.

The previous example is just an easy demo to reproduce, and if someone
uses this example in the real world, of course the best method is to
increase the 'size'.

But the scenario I want to express here is that when the tmpfs space is
*consumed* to less than 2MB, only 4KB will be allocated, you can imagine
that when a tmpfs is constantly consumed, but someone is reclaiming or
freeing memory, causing often tmpfs space to remain in the range of
[0~2MB), then tmpfs will always only allocate 4KB.

> Sorry, this still doesn't convince me.

