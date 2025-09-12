Return-Path: <linux-kernel+bounces-813957-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0A2B54D84
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 14:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 196263B7530
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Sep 2025 12:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9423305970;
	Fri, 12 Sep 2025 12:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lF4XTIe4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1906305977;
	Fri, 12 Sep 2025 12:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757679553; cv=none; b=HmZvu8RjE5QpXpt5vFaHclgJzjY7M5XEunK2f7IEynzDeOEarRTdrn0IRvAsEpV2RNCfzOabV1Rf83H99Wl+c6hxtTuscPsc/9V7mU7Im5LbZcykF8T0vq2fz8EO+8ddZygfqCKypHUZY1dADdY5bSVlIBdqK/L7RyIt98KYCW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757679553; c=relaxed/simple;
	bh=K3GZbphVPlB7nuQAjzkpUgDrop8YRGxK0QNvD4dJlT0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nt+xdoYaYE9A3NtFANCGV1eplu5NBd7R2bEqsCOjthPGmozfNoQ3qpzhafEOxCUSioRIErwKhWSHm+dNY4LOezB1ct/NhQmCRXR4w6UCK0xLCfwRZ7zuW5VDRbtw+19Qw7+4XXYRrCL7B7gmkrSdOgpInVpvoq5EwYxAWjCAGIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lF4XTIe4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E538C4AF09;
	Fri, 12 Sep 2025 12:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757679551;
	bh=K3GZbphVPlB7nuQAjzkpUgDrop8YRGxK0QNvD4dJlT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lF4XTIe4iKegJ0rmylKbKMd9zZwZP/zIKRWEgifHWylvwDqe+/bcCp6PTd1DaMu5q
	 6koS1uU04Pfqc1gFpBtQ1GPb1ZHgThsuZIpqXpgoimJvZYvcLaUtdFOxt02jq0cT88
	 Y8emYNZHJ20LHSx1Jn0jxiYxcewbahCwSvU7ASgP9+3K7W1dvGX6L4DzE2Qj6J0NhS
	 O2skSi9AdHQ9YRh9qAw33nh1uq307WCkugZ0S4cq+aV4l8929L7hIrQc1SniSkMGdw
	 aAjEpGMyQ55RvxApMlltOGRAqHES8WVG7pb7fHPeXxwiTUJx0rB8UZXXpy7jzBtu3s
	 XXclgEXiMOcSw==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 65418F40066;
	Fri, 12 Sep 2025 08:19:09 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 12 Sep 2025 08:19:09 -0400
X-ME-Sender: <xms:vQ_EaK5xWBY1OdvF-9-d-sBUXNenG8gua_7hWi2WtgkltP5dOTL5eA>
    <xme:vQ_EaCKZNA4xmO0B_lwQCc1yauLGpBsIpon_obzCyKFQYA3O_2OY9uY14tjJYYWn7
    ie4qEIshJxtTOLW5xM>
X-ME-Received: <xmr:vQ_EaE_ApLlX2-1sPH9iRKVulzbqQF32iQCZ0c1yZl98l36j4NV0FjbCKRB6qg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvledtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdfstddttddvnecuhfhrohhmpefmihhrhihlucfu
    hhhuthhsvghmrghuuceokhgrsheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpeehieekueevudehvedtvdffkefhueefhfevtdduheehkedthfdtheejveelueffgeen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkihhrih
    hllhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeiudduiedvieehhedq
    vdekgeeggeejvdekqdhkrghspeepkhgvrhhnvghlrdhorhhgsehshhhuthgvmhhovhdrnh
    grmhgvpdhnsggprhgtphhtthhopeelkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepnhhprggthhgvsehrvgguhhgrthdrtghomhdprhgtphhtthhopehlihhnuhigqdhmmh
    eskhhvrggtkhdrohhrghdprhgtphhtthhopehlihhnuhigqdguohgtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqthhrrggtvgdqkhgvrhhnvghl
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhhiugesrhgvughhrg
    htrdgtohhmpdhrtghpthhtohepiihihiesnhhvihguihgrrdgtohhmpdhrtghpthhtohep
    sggrohhlihhnrdifrghngheslhhinhhugidrrghlihgsrggsrgdrtghomhdprhgtphhtth
    hopehlohhrvghniihordhsthhorghkvghssehorhgrtghlvgdrtghomh
X-ME-Proxy: <xmx:vQ_EaHMWpDNhgOLz8YhDyr22doRmBwip5EtzLxG1TIUWdkSQuP4Stg>
    <xmx:vQ_EaLKIIXmaXJp1Xlcvza7CLbKKPRKaMwKcIMBShlR_Y3f0-9Pblw>
    <xmx:vQ_EaDP_BB6dvMXH6WfQFZ17ShzOZbq3erteRXV-JJJxTy96d_WCTg>
    <xmx:vQ_EaNPlMmBIvYxJHR_H-aeQE4Rho1M3DBBavtR2-v2adrY6Rn23Fg>
    <xmx:vQ_EaOLaoIF3jav84kPurobIsVHJDJx511uKZR1tsMpEl8EJmqQpZt7o>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Sep 2025 08:19:08 -0400 (EDT)
Date: Fri, 12 Sep 2025 13:19:05 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Nico Pache <npache@redhat.com>
Cc: linux-mm@kvack.org, linux-doc@vger.kernel.org,
 	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 david@redhat.com, 	ziy@nvidia.com, baolin.wang@linux.alibaba.com,
 lorenzo.stoakes@oracle.com, 	Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, dev.jain@arm.com, corbet@lwn.net,
 	rostedt@goodmis.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, 	akpm@linux-foundation.org,
 baohua@kernel.org, willy@infradead.org, peterx@redhat.com,
 	wangkefeng.wang@huawei.com, usamaarif642@gmail.com,
 sunnanyong@huawei.com, 	vishal.moola@gmail.com,
 thomas.hellstrom@linux.intel.com, yang@os.amperecomputing.com,
 	aarcange@redhat.com, raquini@redhat.com, anshuman.khandual@arm.com,
 	catalin.marinas@arm.com, tiwai@suse.de, will@kernel.org,
 dave.hansen@linux.intel.com, 	jack@suse.cz, cl@gentwo.org,
 jglisse@google.com, surenb@google.com, 	zokeefe@google.com,
 hannes@cmpxchg.org, rientjes@google.com, mhocko@suse.com,
 	rdunlap@infradead.org, hughd@google.com, richard.weiyang@gmail.com,
 	lance.yang@linux.dev, vbabka@suse.cz, rppt@kernel.org, jannh@google.com,
 	pfalcato@suse.de
Subject: Re: [PATCH v11 00/15] khugepaged: mTHP support
Message-ID: <ppzgohmkll7dbf2aiwhw7f4spf6kxjtwwe3djkx26pwy4ekrnd@mgeantq5sn2z>
References: <20250912032810.197475-1-npache@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250912032810.197475-1-npache@redhat.com>

On Thu, Sep 11, 2025 at 09:27:55PM -0600, Nico Pache wrote:
> The following series provides khugepaged with the capability to collapse
> anonymous memory regions to mTHPs.
> 
> To achieve this we generalize the khugepaged functions to no longer depend
> on PMD_ORDER. Then during the PMD scan, we use a bitmap to track individual
> pages that are occupied (!none/zero). After the PMD scan is done, we do
> binary recursion on the bitmap to find the optimal mTHP sizes for the PMD
> range. The restriction on max_ptes_none is removed during the scan, to make
> sure we account for the whole PMD range. When no mTHP size is enabled, the
> legacy behavior of khugepaged is maintained. max_ptes_none will be scaled
> by the attempted collapse order to determine how full a mTHP must be to be
> eligible for the collapse to occur. If a mTHP collapse is attempted, but
> contains swapped out, or shared pages, we don't perform the collapse. It is
> now also possible to collapse to mTHPs without requiring the PMD THP size
> to be enabled.
> 
> When enabling (m)THP sizes, if max_ptes_none >= HPAGE_PMD_NR/2 (255 on
> 4K page size), it will be automatically capped to HPAGE_PMD_NR/2 - 1 for
> mTHP collapses to prevent collapse "creep" behavior. This prevents
> constantly promoting mTHPs to the next available size, which would occur
> because a collapse introduces more non-zero pages that would satisfy the
> promotion condition on subsequent scans.

Hm. Maybe instead of capping at HPAGE_PMD_NR/2 - 1 we can count
all-zeros 4k as none_or_zero? It mirrors the logic of shrinker.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

