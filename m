Return-Path: <linux-kernel+bounces-720601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 659B3AFBE25
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jul 2025 00:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83F9A1AA648B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Jul 2025 22:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B54528BAB9;
	Mon,  7 Jul 2025 22:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="BJJcZby2"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C155828A40D
	for <linux-kernel@vger.kernel.org>; Mon,  7 Jul 2025 22:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751926259; cv=none; b=lSur6uJhoXJD5DSLF5ayx4y1WFU2kuPVlZpoPSFmmZFnL8eh/aegySH41RxeGPboRZkYuJCb5ne7xv+xYY6pEzLoq8a4yUCS49YX/weQV/RDgWgRla/TBnYw+ZdEAV/T4cRV4hpZaS8WYQ0k9c5F5xkBp2C2eb1ONkHzJofG50g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751926259; c=relaxed/simple;
	bh=35P+PzeQz8QYd9zwPa+wI6sQOKUmAYabpn3mflqfAHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kgKU50/ddaQNp8kbuDkikUWHu/uPQjxqgAaw35WZODxPR+M081K4G7bGn+fRGyn0sSyX/CRVt0RHTGVxEB+0ht66ZMUIlrqXtVDxdG7uJ7m5avJ5La1tYYeX71JITiYAUy/LIZlEispxQ3Hn36DR0DGmMD5laEpQsVnJ7FpNk8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=BJJcZby2; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3190fbe8536so3216945a91.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jul 2025 15:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1751926257; x=1752531057; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/X8f9phiGCMvRDjMay6uMYpdTiVZMhh4dLxOIZe5Jpc=;
        b=BJJcZby2TwXLQ7WsUJrczKMNAdHu1RkQeamQwejlrhViMNra6njqj3N9VOYH1Q1sew
         MGEDFiaVEH8yk41Q4cdMhJ5N045lCq6k5mlnP/iEm4SP/5HvDc3yzoaKKYOYb7oYyE/C
         GooTnMgb+XafEOszytCvgs55fwhgTjfSWiaetqD9/4crUZIoNXxSAJ3xvPRaAJWLZUVy
         rsNGxBIPij0f5S+O4D9Fd+Xcg9GCbe9RKYXfCyz4IhMrVUFaSMcWpxsxMUVctKYub4yJ
         Vc6GV8cXjDLSqMnW5sfE6Z2nOhWtyf+b7r1X21ArMFOD2qPJ0lLomA/SbN/XvZi7f3L1
         290Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751926257; x=1752531057;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/X8f9phiGCMvRDjMay6uMYpdTiVZMhh4dLxOIZe5Jpc=;
        b=cAp4IFdzS26On8/RBdDIzMZYDA5CS5ysSSSZUpYOO23KWhfIbcuNfrweBLf0SZ+Vjm
         e3eDTd80w6HhiM70J9F6CwWucuXv3fulkv+lj4LZqvYyI/KvsLrwxhMeKfLZymIjh4Nq
         cbO+gSdiqU0ldR6BWaJJ45dd2eOdojkLdcNQ4l767RXiLoICLkauZmUhwYMmnhGgw8o7
         4Jvnv68C5ZVIpgAn1iuzdbaZ+C/XpZgJyflLWDiOSqQnhcBw2h+L3DHJhnsUM15i0IvY
         tK2h480MZgwnZNitS4MVsdtdBC24Jt07knzfuLcdBBDiBQEOl/pzWO1ANjprHtS4sVoH
         SlXg==
X-Forwarded-Encrypted: i=1; AJvYcCVbimffPEbm+um3p9bUzkyoSaCW9gj9hjoN2Gd86hJIHsoCjpDHPjb7PcdNdn2TAgWsdqJJPS6RfOGI1kI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3yD46f3Om77KH6hCjiE5p7L9K2cSlUYtd/Pa6FUGaEP2l7yv/
	RpOW9kovKXFb1aziztYx9S7kA7Z+GVhinH5XSTtJeQJ0ZLyn6uCRY9zJCLw4wgpOM/w=
X-Gm-Gg: ASbGncunUZSSjMI/fnZGDjLdgjiN+wmI9P5NNs8WmGlk2Bo3PTfg211MPE/281yLpyd
	IkV/kNZTlG0JZNWI/x09Ve3RUzb9lYgFpXBlSVvDzlOpfKCEN5QTCOH3aLwCw073kh9uWi2H9RT
	yYyue3svycXwgNyK16fE7V2iEJXTDKIY+/gVQtO605pyeDCqr+31IUSEaDW04IG7FaPPsxUtwnk
	JB426e6/bukAhf3sG5AUHxbbhulSeXA5w0bicuyUhO+0vomn64dzTHDmghe0LoHhb+dePGZtVwc
	R7cqCeYlu/X4FbMYXZKUx79ceaM0z1ZoIfIykEdllcwboZcIQSifxtkuoaWQ3/K5UemRI1Eus4j
	6IEMnC7Pj9l9M9DCwLmge7LDyXXTAtaMp/+hlIBWGWnUzM42W
X-Google-Smtp-Source: AGHT+IGgSQP4rI9MHxYjtGDNpVWGbpbBXk4JtykC1/d3jUVH3U2eBXd33t5un+V4PjHGBa+v8wRNQA==
X-Received: by 2002:a17:90b:3e45:b0:311:e8cc:4255 with SMTP id 98e67ed59e1d1-31aaddc57a2mr18425361a91.31.1751926257003;
        Mon, 07 Jul 2025 15:10:57 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-184-88.pa.nsw.optusnet.com.au. [49.180.184.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c21e75e14sm312152a91.25.2025.07.07.15.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 15:10:56 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1uYu32-00000008Bdy-3NwV;
	Tue, 08 Jul 2025 08:10:52 +1000
Date: Tue, 8 Jul 2025 08:10:52 +1000
From: Dave Chinner <david@fromorbit.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Zi Yan <ziy@nvidia.com>, Barry Song <baohua@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org,
	syzbot <syzbot+359a67b608de1ef72f65@syzkaller.appspotmail.com>,
	akpm@linux-foundation.org, apopple@nvidia.com, byungchul@sk.com,
	david@redhat.com, gourry@gourry.net, joshua.hahnjy@gmail.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	matthew.brost@intel.com, rakie.kim@sk.com,
	syzkaller-bugs@googlegroups.com, ying.huang@linux.alibaba.com,
	Harry Yoo <harry.yoo@oracle.com>, Michal Hocko <mhocko@suse.com>,
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [syzbot] [mm?] WARNING in xfs_init_fs_context
Message-ID: <aGxF7NqHNK7Vtd1_@dread.disaster.area>
References: <6861c281.a70a0220.3b7e22.0ab8.GAE@google.com>
 <DDD5FAAF-F698-4FC8-B49C-FD1D3B283A8E@nvidia.com>
 <1921ec99-7abb-42f1-a56b-d1f0f5bc1377@I-love.SAKURA.ne.jp>
 <630b4379-751a-4bf1-a249-f2e051ec77d6@suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <630b4379-751a-4bf1-a249-f2e051ec77d6@suse.cz>

On Wed, Jul 02, 2025 at 09:30:30AM +0200, Vlastimil Babka wrote:
> On 7/2/25 3:41 AM, Tetsuo Handa wrote:
> > By the way, why is xfs_init_fs_context() using __GFP_NOFAIL ?
> > 
> > 	mp = kzalloc(sizeof(struct xfs_mount), GFP_KERNEL | __GFP_NOFAIL);
> > 	if (!mp)
> > 		return -ENOMEM;
> > 
> > This looks an allocation attempt which can fail safely.

It's irrelevant - it shouldn't fail regardless of __GFP_NOFAIL being
specified.

> Indeed. Dave Chinner's commit f078d4ea82760 ("xfs: convert kmem_alloc()
> to kmalloc()") dropped the xfs wrapper. This allocation didn't use
> KM_MAYFAIL so it got __GFP_NOFAIL. The commit mentions this high-order
> nofail issue for another allocation site that had to use xlog_kvmalloc().

I don't see how high-order allocation behaviour is relevant here.

Pahole says the struct xfs_mount is 4224 bytes in length. It is an
order-1 allocation and if we've fragmented memory so badly that slab
can't allocate an order-1 page then *lots* of other stuff is going
to be stalling. (e.g. slab pages for inodes are typically order-3,
same as the kmalloc-8kk slab).

Note that the size of the structure is largely because of the
embedded cpumask for inodegc:

	struct cpumask             m_inodegc_cpumask;    /*  3104  1024 */

This should probably be pulled out into a dynamically allocated
inodegc specific structure. Then the struct xfs_mount is only a
order-0 allocation and should never fail, regardless of
__GFP_NOFAIL being specified or not.

> I think either this allocation really can fail as the code (return
> -ENOMEM) suggests and thus can drop __GFP_NOFAIL, or it can use
> kvmalloc() - I think the wrapper for that can be removed now too after
> the discussion in [1] resulted in commit 46459154f997 ("mm: kvmalloc:
> make kmalloc fast path real fast path").

I know about that - I have patches that I'm testing that replace
xlog_kvmalloc() with kvmalloc calls.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

