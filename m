Return-Path: <linux-kernel+bounces-887094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E011DC37432
	for <lists+linux-kernel@lfdr.de>; Wed, 05 Nov 2025 19:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1343E1A20B9A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Nov 2025 18:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE55026F2BE;
	Wed,  5 Nov 2025 18:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CDITUnbF"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1B026E143
	for <linux-kernel@vger.kernel.org>; Wed,  5 Nov 2025 18:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762366614; cv=none; b=E6cKFelDOdvlTMIu6SdbigNQAoj1tvvrVUsOG8mxj4X8OWZL9/kXPBBsJKaSz3zSb3S2wnw2Z2aMLF0nvEe1bp8BAWDZU845FOpA7N5R3cW3DIXJmn1BM82xtjhbuKtaHlsT9g6lRpuZGjlE6Viq6FmQl0lQwVuT7gB4Lpz7PE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762366614; c=relaxed/simple;
	bh=CHsVV9xGLdeBVjQzQ+KO9Y00h83ZIy5yu3puOCqoV9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QMNp3Ifq6oOoh+Fv4hahurDPNo5kjQLjSg44dpge9hVheSzDi9hEbacTdnowjPc8dhDLvWY3lI/J0oPm8BCDDzyJY9dN+08iI9YiB8Lehkpdt1AZ1TPoGbx0k4ZdwoRcMiCLydbfAnLylsHN6BJ9eli0a+VLhgqPsB8rmY/o8uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=CDITUnbF; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-88033f09ffeso1521816d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Nov 2025 10:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1762366611; x=1762971411; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CHsVV9xGLdeBVjQzQ+KO9Y00h83ZIy5yu3puOCqoV9g=;
        b=CDITUnbF0zeKPEDxkTffAxzBC0jmHf5Y876UCRRtQ2rLcs8qb+Z88PVwnenEzbG9aw
         TMKKMq/cUOFjI2hTB2p69LTktVVOtIqKWN9gVdyAGB0YIcRo8qLYrHgvJ/lgpNMTOqYn
         5iGkwqREVHwe96A34n/Rc0FVPbB27ODK14DCh2OFhV9uFagGPKjsP9GYkvCjfza6Dr88
         6GMOm+6souMEhZX9dAd2h4LFh83WkPTW5+p0XwToVKFFytPbcqK/U523HxPJggggsXFT
         VGSfZzgVaOv85EidWvOuLQN8+8UnO2EVDpdPhjqOu8sJRpthaiOS7KXU+YZ62FxzOB5z
         H2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762366611; x=1762971411;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CHsVV9xGLdeBVjQzQ+KO9Y00h83ZIy5yu3puOCqoV9g=;
        b=fSRVqeBDpUn4o+XOKGqDrZ02UfPZ5JrnDlUvk76qc3AvDSc1TVboTcWXKmfB1jPtZQ
         eujOSs2Y8xRSf0coW560aPwHPBksgLYKmuwAiF7ryUV6/uL2DNTbGEw9BnR65RejqQqr
         CzA2DkyFgf1OctCsXBnJQzSeZ9J3TvEWfSs+hUeHG7UV13sHpuggD5jKtlHBpNHtleIm
         bXgtfK0u1YjG1fpx9OCMf6PUNRyeo+eQ6/ZeG40bXeKXplD/qkvc56MruOOnvqpn0bQg
         qZiB+d/pyO4VR9INmS6MoPZIPzyILbXW9jTO94+08GBKmrDE/Dlwalo5OkqNPOTss2Q2
         LhJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIbDqvyB/oIbDk9eqDSWagzvdEqxocHMeTrG94rBLvMQ/E3m/mdwTmofVl/hVYGW0BUvNlzzY5m5/WNp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYAlFFFtema6IMSIHh/N3lra38D19Xr/vXy3/Q0qEs+0lR9M65
	o9p510O+OxExxPVFuf0xakQyldLIdbrw0ZVauwdYnUTmYxl0gg/wJpzReoHdhX1rV7U=
X-Gm-Gg: ASbGncs5fuHXTmZAf1DXjj9zkvzorB1dco6BiMuBODSUPiuur1BYiN3lTCHN8+pkcyv
	bhu64+99mtFPgnObDQsYEiNKL2qNI2dGRRBcj2izM0n8pJd2w0+phrFuPq5mkdrzToKiqQ9/MSK
	MnUDGX/zptvR+Fu8F9O/jU7hchsNXu/dg1aCkTdMzq6fCR4breDb5ZkVFrs0KpPC9q5Lp18WitM
	mKFZg9FLoh9GJcExHyoN44pAo12gS1lvFebjgrIxxTKGYyhCKrrAv3OM+aO9SDgCjFzw02umVCq
	h4RqNvS26fzx530bskCbzrwhegJJKjosfCwJj/9jp6entuX3KSN9Ei2C4SShkZrCtvMhezfsiKG
	8tAZ5sO4IuvHaZZD9UESpMIq+eY6R9J0cqJWcwaUsgmhw2+SCT1NUZlLZH8ByQWz21Id/fILSJt
	PYE3JQSVMxlQnIEOQVFGIpfo0wYQQGhuRMDvvHYKlANZak1A==
X-Google-Smtp-Source: AGHT+IFaewYCh7lZ/e3jrLC+zJ6aPttGSWBIKbLkQBuHB0fmqLtXdWY7nE/Y+kB9ksn8kefKsppo3A==
X-Received: by 2002:ad4:5aa7:0:b0:880:5cc1:6923 with SMTP id 6a1803df08f44-880711d8255mr64437896d6.36.1762366610614;
        Wed, 05 Nov 2025 10:16:50 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-880828c457bsm1883826d6.5.2025.11.05.10.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 10:16:50 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vGi3s-00000007CLf-2PE0;
	Wed, 05 Nov 2025 14:16:48 -0400
Date: Wed, 5 Nov 2025 14:16:48 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Gregory Price <gourry@gourry.net>,
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
	SeongJae Park <sj@kernel.org>, Matthew Wilcox <willy@infradead.org>,
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
Message-ID: <20251105181648.GR1204670@ziepe.ca>
References: <cover.1762171281.git.lorenzo.stoakes@oracle.com>
 <2c75a316f1b91a502fad718de9b1bb151aafe717.1762171281.git.lorenzo.stoakes@oracle.com>
 <aQtiUPwhY5brDrna@gourry-fedora-PF4VCD3F>
 <20251105172115.GQ1204670@ziepe.ca>
 <03e363c3-638a-4017-99c2-b6668ca8d25a@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03e363c3-638a-4017-99c2-b6668ca8d25a@lucifer.local>

On Wed, Nov 05, 2025 at 05:32:29PM +0000, Lorenzo Stoakes wrote:

> Obviously heavily influenced by your great feedback, but I really did try to
> build it in a way that tried to simplify as much as possible.

My main remark, and it is not something you should necessarily do
anything about, but pte_none() can be given a consistent name too:

leafent_is_none_pte(pte)

Which is definted to be identical to:

leafent_is_none(leafent_from_pte(pte))

But presumably faster.

Jason

