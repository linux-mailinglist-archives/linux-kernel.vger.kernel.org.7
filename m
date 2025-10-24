Return-Path: <linux-kernel+bounces-869424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB474C07D98
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 21:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E6644009DD
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Oct 2025 19:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38CB357A2A;
	Fri, 24 Oct 2025 19:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="YvjFzXO0"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907342DF6F4
	for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 19:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761333003; cv=none; b=P+gu6vV3HnjQXa7+/z5NJZK8BcNsXKOZ7Yl4Szq1ESLqd9sIW3YnRjILMhgocJ0Qjby4ntEXs+H8EQDIc9pXVH8yKKKdbxWJYvom4EqnY81i9kr2XrlneEBbN5cxu8UlHUnewdjjGEPcBDGv7mDN2TYZrfSH2xUR6EES6s0Pk00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761333003; c=relaxed/simple;
	bh=eOV8n3GyeI7NGmNQOPYmpec1MI+qOKDL2up+UvX3whg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bxfDyOln6aqV4mOFZXZj9Q1g1+GVh+k8xw0INitSfN1ery0cSPSV9tOSVAT1COniF4qNk+NEQqvXSHamzYu2Ling5ssPXPIys537DlurPT2k+BlJRGT8SBNS/z6sfV/PujL7IXgeyoHQJ2CH1afCY1XID7fWjVUdkHg+Fw0l0xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=YvjFzXO0; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-88ed6837e2eso356516085a.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Oct 2025 12:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1761333000; x=1761937800; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r4YhT6UkULx0zY0BI31WYEg/XWXtKp76n8KPsV3vFlM=;
        b=YvjFzXO0J6h2ss5Sjx0x/YOHwNaZ4Tm+e+WqDpFH9ACMNz46aWXSiaQsQwolqekzQO
         2buiBh7TWFig/XGHuU8xyyyCnwtmRTYFFY45EsAZmWULSomAfW1N2sgkiqXHUoHo6QTR
         7CZ5LqV7OgWZGlcGb5jecQPrBWfpBrrsKfEN6nhZgnr0/mzyWb95v2Aoqltu98hD3TZk
         IOG5fzcgJua53NNBnVpecM0fDkXU6wkdxKPJBexBF6Z3DCRjfkWDwMDZqWSMFu5PvSkZ
         K75yKN3CZw31D88pNNMrUcdvvRHb3zV1rkpRutMPmDiSN1YLdM+henQF42C8jPnce2uU
         k2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761333000; x=1761937800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r4YhT6UkULx0zY0BI31WYEg/XWXtKp76n8KPsV3vFlM=;
        b=df3zAgfiiwa0FWJJNwleQCA9VDdoc0wEohDgpUQWb6po6Q5uqLzhGQcfKe6yco2Q7T
         EokPEORh55Oh0QNx3XBbuEU/3dCBVWjeJVdwzTECuN0E/hkoBWnLpLmJZgpLDkEIeKUU
         bN4LKPPy171zjMFiULKwDMdp9mysn+5WjU/5HOCjZy+Akz40DujArvYet+aRzmIJ5uoi
         y5YwxV5O+QrVeJ5B1CDn93widcOD3IZo6G8jGDS2adzOaihZnRTEKrqUxUmtl/BqjCuB
         iP4QWZih/MMEYC+a3HtnkizmnIgcerkn7BymMpnHeV49IPgkL/1GdqbQht8yYuNh/2P/
         5UEA==
X-Forwarded-Encrypted: i=1; AJvYcCWC+i+2VuuNsAMfbniZUo50Adprupu+sNUlvK/Nj77nO/HPtfRHkED7bXJ0uqvx3F44ijXYk8MxZpcnHTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3NT2y7Lk/LkppeEAxwvMK9aiLgZuAb1Pvf8ZzGhp3zVzoSIoG
	YV7nMoOKIGhJaU0cVi1RB2lXPyWDX7znKa9rcjPys85IcVprfqiPoPRjYy3Cou4PR0k=
X-Gm-Gg: ASbGncuJRl8Ec12orpyBxD6PHrMG+/yfBpYSCnk8lD/HrIql39WoLkzcO8eYos9iBWV
	efJfM1/NEF4i2pCqTsRY4xc6DZNVlYREBCgWS8B6wMqP+KucQdSMBAcSrm9PmEL0KmWlGPdH0B/
	4Rhmdu++AmQxlq4mKoOQ97t771JdMHC63iWrcqSAw43IN941a25Jkq93Lkq7lnDrqUhklQ9zey3
	XSB+o8GvpiwQu/bTKytJynKxFw6wayh9lvZ/EeL4B20JGrf9zzr15qQLGp/vVw9+lvFiPCekFqx
	LbqBjGBe+Wfkbwf78BgX4w4OiNKKG1TCG5OgK2cFWjwT2JLLsk+qUFYvdXROfjItI/j2fjBbGYE
	iRRJbci1ov1v9boxc4c9F5d16QHfPno9lBT77XY7aO6HkvbxGiKKbh0NyI15ISRZ3OL/jcz/jus
	VRkof1v3mpfwENfLXEEOMK+kGEUGMPfOEjMORwcBUY4dJOaNutH5AkUp60c78=
X-Google-Smtp-Source: AGHT+IHrkcPaJLyTM5pJbJ/XVcfel+4u6gv+3P752b0IEbbyKeVVUPlOZ4xL4VMnAte1FxD358/CqA==
X-Received: by 2002:a05:620a:40c4:b0:85f:82c1:c8b1 with SMTP id af79cd13be357-8907011583dmr3539276185a.46.1761333000331;
        Fri, 24 Oct 2025 12:10:00 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-89c11e631e4sm442634485a.44.2025.10.24.12.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 12:09:59 -0700 (PDT)
Date: Fri, 24 Oct 2025 15:09:57 -0400
From: Gregory Price <gourry@gourry.net>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@redhat.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Kemeng Shi <shikemeng@huaweicloud.com>,
	Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>,
	Baoquan He <bhe@redhat.com>, Chris Li <chrisl@kernel.org>,
	Peter Xu <peterx@redhat.com>, Matthew Wilcox <willy@infradead.org>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
	Byungchul Park <byungchul@sk.com>,
	Ying Huang <ying.huang@linux.alibaba.com>,
	Alistair Popple <apopple@nvidia.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
	kvm@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [RFC PATCH 09/12] mm/huge_memory: refactor change_huge_pmd()
 non-present logic
Message-ID: <aPvPBS5H0E9OXEo1@gourry-fedora-PF4VCD3F>
References: <cover.1761288179.git.lorenzo.stoakes@oracle.com>
 <282c5f993e61ca57a764a84d0abb96e355dee852.1761288179.git.lorenzo.stoakes@oracle.com>
 <aPvIPqEfnxxQ7duJ@gourry-fedora-PF4VCD3F>
 <2563f7e1-347c-4e62-9c03-98805c6aa446@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2563f7e1-347c-4e62-9c03-98805c6aa446@lucifer.local>

On Fri, Oct 24, 2025 at 07:44:41PM +0100, Lorenzo Stoakes wrote:
> On Fri, Oct 24, 2025 at 02:41:02PM -0400, Gregory Price wrote:
> 
> You can see it's equivalent except we rely on compiler removing dead code when
> we use thp_migration_supported() obviously (which is fine)
> 

derp - disregard.  End of the day friday is probably not the time to
be doing core patch reviews :P.

Cheers,
~Gregory

