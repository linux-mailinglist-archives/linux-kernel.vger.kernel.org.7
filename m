Return-Path: <linux-kernel+bounces-887224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B16C379B1
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 21:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CA2C1A20E44
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 20:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9F032E6B1;
	Wed,  5 Nov 2025 20:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="ZSxGdxX9"
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 916632FB97F
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 20:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762372869; cv=none; b=CNBOH2vicXnGyK+cU/hjBTayeyyQSAmryhOy266XrRr36pgkaKDnn47K0NuxzOugQqT0oX2an9pK/32gE7C7B7W38Sx7huJC/UDlg1HduKV4z7W66En5PvqUgieQJjkODG4Xoz2OLss2wHCx/jyYeETYnSbIRVAtj0abSbpF/yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762372869; c=relaxed/simple;
	bh=GsjEeX/yoeLxBaD+dnbSv8Mk07ocMdYdXojXWIK+l4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FI+DF0mI4InOMH+JWclSi3nivYUdNtrqZ9y+9EU78hCxLN1w6wzEqvuEkvapubQ8/w4MoA9Z+4dERn2/OX3BYgr3K3eNc+53wG121SvuPRJwjFgX4js8ABQyByjHvfZBC6/Zd3sqg64w74vZ/JRWFdOqtJHaHADYDXF/xxANhLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=ZSxGdxX9; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-88057f5d041so3064956d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 12:01:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1762372865; x=1762977665; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ldDyq3tsFgYvyoHI8nWeYS5HdbVk0rd4V1r4ezrVHxs=;
        b=ZSxGdxX9xCk1HKNpVIcM3JeGL4ppDGq/ppX1tKu4zzry89rvCfCuRLNhxVQTwFsO/1
         xzBHvTqNEf1f//pxFOyyjiKoLv3JQ6jMFuZ1U0gtSFs0gUY5788vd0Bw+sW7CJcHcas5
         /cwugQ+wGeG5ifFdnhLsHYmm7TAMulD3ytgLT9U21uBeTuEwU3xQhOJyUj57qplDnfTR
         6OGd4k3TKUOwqaDx7S/HHNZKW9KXKtxkZML1HmUe3fcX1+KMtLTI5WtXaoSnN5l1vuRl
         ThKKki1xOPnWTPWwyCqM3j+KNciRfeFxGonXxktJUKdXwJHAPgOsc3ryftcHX8Y9jd+0
         lCyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762372865; x=1762977665;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ldDyq3tsFgYvyoHI8nWeYS5HdbVk0rd4V1r4ezrVHxs=;
        b=sUDTyaeCqQlnS4QEVbSHEYy7HxGWYpqDhHAqyDzOZcsAkK7PDp91GzI9vQ60fZZJ/1
         exCGX2xjun7NDS/lYx3Ski/h4qND7F2P9KffmsTLOfGDRcd2OI+cMnsu5cPIjPklqDOM
         PmzDCV8ULOQXBcxnF5tmD9eETTTfpy8RAT5CTEeVUAWWL8YGVtSIurxXcw1wiLXsXSTO
         wKQ/OCvChd089J3YFkmCS8HxDiI5L+LyZNrIx0dCFsyrCMResaOs1ICjwNY62Yp9i0YG
         XXQdV49c5ebkx4sHo1/fjIUNzpE9KGn9oh5eXYIAZXNpiN+Xng9j9uoxelknuTvTOtzm
         nxlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWs+7ldlQm2qTROKQA760OQE6LbOBwL02eVL/gbfZJlGMxBNXYYXUl7jxeQ09Du1a45OM2GN1HPDXJ9FFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkgXgyA0i45xs26klgimzgF8sJt3TWMJ2Bx57x08ijiymicaZa
	ycqvHBcDc6PC5P3WhuSrTGuXkP0tSgaMHFlI/Lnl5Ty75q0HvwnZChvp0Z2z/J2aeAA=
X-Gm-Gg: ASbGncuGwcymNgGOJTBUkmKBqWOM2sN7H+g9MsuO4a/RVBsE0rbGhrsaLgEWLxpInIx
	gLiyei/2jCkKuUey8pATeo0P+DiIOGUb5qZNTOzYDXzN+LElcF6dqs9XOYmj15X95To5qGEJJIq
	slGjzpPzK7xzujCqPCFAEveS44dz/rU/2D3FR5qxELWR9TKLiviiah0ZnyuxhCVJVZfrZsgPLeO
	bej+G523eSx+bxV5hEGX/J0Wcc/oZltOc2muz9T0Gok5FsAtjt2SAx1vCgSnFLNwmH+lLQtGA0h
	GCE9P31PC4kcod7sMhOh/6nAhEncq704AsF82niy77w+fwwHAilOFtad7O3wqlgFLzZ3wBgwzdu
	XsEbf7VPgPanXz8t5Jx445Tfz3hUHV1Zy4sAtl5d7j1HxG3nUA2Wgpmfy8+8gXO4GT/XXWZUig2
	xjvXn/eu1c3A+OjbBVXPlTVqWFunGsmHgqSWaqtY0yPaCtNI5epQRsjKYu1+8=
X-Google-Smtp-Source: AGHT+IFrPbLMeE9CYwB+D7eMKoLl9vB1NdinT/slFi02CGhPHxsO1o1rCTabfaRmYf3n9WMkLz+GWg==
X-Received: by 2002:a05:6214:20ad:b0:880:4896:5d81 with SMTP id 6a1803df08f44-88071135a41mr51873106d6.3.1762372864533;
        Wed, 05 Nov 2025 12:01:04 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-880828c4570sm4100556d6.10.2025.11.05.12.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 12:01:03 -0800 (PST)
Date: Wed, 5 Nov 2025 15:01:00 -0500
From: Gregory Price <gourry@gourry.net>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Arnd Bergmann <arnd@arndb.de>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
	SeongJae Park <sj@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
	Leon Romanovsky <leon@kernel.org>, Xu Xin <xu.xin16@zte.com.cn>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Jann Horn <jannh@google.com>, Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
	Hugh Dickins <hughd@google.com>, linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-arch@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH 02/16] mm: introduce leaf entry type and use to simplify
 leaf entry logic
Message-ID: <aQus_MNi2gFyY_pL@gourry-fedora-PF4VCD3F>
References: <cover.1762171281.git.lorenzo.stoakes@oracle.com>
 <2c75a316f1b91a502fad718de9b1bb151aafe717.1762171281.git.lorenzo.stoakes@oracle.com>
 <aQugI-F_Jig41FR9@casper.infradead.org>
 <aQukruJP6CyG7UNx@gourry-fedora-PF4VCD3F>
 <373a0e43-c9bf-4b5b-8d39-4f71684ef883@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <373a0e43-c9bf-4b5b-8d39-4f71684ef883@lucifer.local>

On Wed, Nov 05, 2025 at 07:52:36PM +0000, Lorenzo Stoakes wrote:
> On Wed, Nov 05, 2025 at 02:25:34PM -0500, Gregory Price wrote:
> > On Wed, Nov 05, 2025 at 07:06:11PM +0000, Matthew Wilcox wrote:
> I thought about doing this but it doesn't really work as the type is
> _abstracted_ from the architecture-specific value, _and_ we use what is
> currently the swp_type field to identify what this is.
> 
> So we would lose the architecture-specific information that any 'hardware leaf'
> entry would require and not be able to reliably identify it without losing bits.
> 
> Trying to preserve the value _and_ correctly identify it as a present entry
> would be difficult.
> 
> And I _really_ didn't want to go on a deep dive through all the architectures to
> see if we could encode it differently to allow for this.
> 
> Rather I think it's better to differentiate between s/w + h/w leaf entries.
>

Reasonable - names are hard, but just about anything will be better than swp_entry.

SWE / sw_entry seems perfectly reasonable.

~Gregory

