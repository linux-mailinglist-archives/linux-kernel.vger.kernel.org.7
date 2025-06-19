Return-Path: <linux-kernel+bounces-693127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E77C8ADFB55
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 04:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C8E7179F32
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jun 2025 02:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D2B230272;
	Thu, 19 Jun 2025 02:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lUP+jB2d"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43DA22154E
	for <linux-kernel@vger.kernel.org>; Thu, 19 Jun 2025 02:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750301094; cv=none; b=KJhXi6/AuK2O54BJIl6eybjd4lOHUtmbE8wsr7yU80ztoe/J8XvLIMXAXqKGOJ4JYWTSwq7FPDBLVvlxB1QsCLQvFRT/VRWPCKWBv9DVM5KEW4tAEltGOcOgkg7mTqIhM3lvlu+oMA4azRGeBquLnPyu8LRtzyaRvRkE56AMJv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750301094; c=relaxed/simple;
	bh=qoyTG+y8tPin1lSTQeGsP+HTVOL7kT5xddmxzpFuYF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cONuwD6phM3mnXxYJcrdHl/PrXwEXp3EqQwxJOwBg6Q8jDaWeEH4ZLdbDeBCdD7o8TgVgfRp1Fver0OpT8VsmTb45FXCGgya0/PJawsyVi40Evh9h+aI069bdDMMxMKQDY+Wk+D6BHujsLraTr5KIcXmQ/w/qwVLencasbI+HGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lUP+jB2d; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-747c2cc3419so176341b3a.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jun 2025 19:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1750301092; x=1750905892; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NGiV4ZITlSkGta2ar3rISknYHCyA9ON09GdNG8pubLA=;
        b=lUP+jB2dib70oqGt16Y6GBeBfnzx1zSmE8b286umuV+VGipfXEGsJve7AZHadYBTLH
         kPqMZ6qXkDnO5ObjGixdg6pgSbSUoUIQjYMeFMYQlFXONkESGNBzF4x3ZTGzfAQuxXDb
         6YGuw7F5C/VJuA55bICrXOMuQCNf5zlqfej/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750301092; x=1750905892;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NGiV4ZITlSkGta2ar3rISknYHCyA9ON09GdNG8pubLA=;
        b=EcjSayKp+InPNPqOy94/eaa2P7+usXBc6dN2pweqfezv38a06MqEoDtCwtc0Nn7wOV
         KiWHzlOnN8BEsRY2CvIeo1YBKoG9KIVvpEpL44n0QX5psc3VU75gAVb6DmZkgx6qp14I
         kYOusX7CXacH2l03Egg6VHcUkdotmjWWi93ROlaboHwU0TQEqg0/Fa26s7IZclnNNZ+O
         taUQm+LnVMoez9dIKkG2IfGfwvBqpF/gA2gkEisIVCtHMQ/MBPoaaP4X06thHadI/fbP
         9p+TzhWk5vDkW4dpDYL3s00b4iL3BChHVIj/Geu7qdwpg1WW7PgceQ0sRea0QDADv60D
         PvyA==
X-Gm-Message-State: AOJu0YwQk85o5y2CUBapSTgnhXhKAj8CCAETB/fFn410kv9PZCCNa/Do
	3iZL1EFj7cjVxz0+YqWxCoDoOWZ4DEChhu3Oek1dLiFbgWEHZbWfsk4JPQm0gIPgYg==
X-Gm-Gg: ASbGncvIFBv8LBBlDLmkmTOd71xHklEgeY/uqeQ62c5Uh+RRPLVW7AwWe7KpplFfHv5
	LTfM9r3zAz55l0lEXjaFkSbfodH0wu3eaZ0tBvgAT3UkuiGMuyz5DodpDe2mEvO8MHDOY7jt2Kg
	vuymNHyURmr5KAAlY1oProj+deAj4V6gY6MbKJYn25Kr3zdF/juLrM6Qt4ifOjDJOps/sCp/Gf3
	tukM4b6nAavKCRc5KQyzWiB8Y/UEoUidyU18biewGk75E6w0Pi+uv+toxhjMYIMur70lVQpxrH4
	BCB4jUt7zPUrKS65zIeTNwZZXjv1ZFyviPUf1zbMPZ74PLn1ztVoozOnoyKzzcYwEA==
X-Google-Smtp-Source: AGHT+IG6keXC3NsOp2Ins+/oPh724/MxHSdE1WbIS33oc9s9zagcbgJChxdFiOB1royOBlBoftNKog==
X-Received: by 2002:a05:6a00:1d15:b0:748:e4f6:ff31 with SMTP id d2e1a72fcca58-748e4f7091emr9593788b3a.8.1750301091998;
        Wed, 18 Jun 2025 19:44:51 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:7cb6:ce70:9b77:ed3b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748ff646231sm44607b3a.146.2025.06.18.19.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 19:44:51 -0700 (PDT)
Date: Thu, 19 Jun 2025 11:44:40 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Jerrin Shaji George <jerrin.shaji-george@broadcom.com>, 
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>, 
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, Byungchul Park <byungchul@sk.com>, 
	Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Alistair Popple <apopple@nvidia.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Minchan Kim <minchan@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, 
	Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, 
	Oscar Salvador <osalvador@suse.de>, Rik van Riel <riel@surriel.com>, 
	Harry Yoo <harry.yoo@oracle.com>, Qi Zheng <zhengqi.arch@bytedance.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>
Subject: Re: [PATCH RFC 03/29] mm/zsmalloc: drop PageIsolated() related
 VM_BUG_ONs
Message-ID: <ved33aqy5rlayhagg3x6xcry3cyadw6eponaj6dfwkt7xmbep6@dpcvwrfgrjxx>
References: <20250618174014.1168640-1-david@redhat.com>
 <20250618174014.1168640-4-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250618174014.1168640-4-david@redhat.com>

On (25/06/18 19:39), David Hildenbrand wrote:
> Let's drop these checks; these are conditions the core migration code
> must make sure will hold either way, no need to double check.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

